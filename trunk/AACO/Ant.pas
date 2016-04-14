unit Ant;

interface

  //any units that we use
uses Forms, Classes, SysUtils, Math, PherMap;

  type
    TAnt = class
    // internal definitions only accessible in this unit
    private
      tL:    TPath;
      meet: integer;
      tD:   integer;  //total distance travelled thus far
      cC:   integer;  //currentCity
      cCnt: integer;  //city counter
      ID: integer;    //ID of the ant

      age : integer;  //Age of ant AMTS

      //Trees holding arcs travelled by ants
      AMTSTree: TTree;   //arcs travelled by ant in previous tours AMTS

      AntenMTree: TTree;    //arcs travelled by other ants, stored  ANTENNATION
      AntenOTree: TTree;    //used to consolidate only, temporary storage ANTENNATION

      function    isNotTabooList(city : integer): boolean;
      function    AntennationFactor(nextCity: integer): double;
      function    AMTSFactor(nextCity: integer): double;

      procedure   ResetList();        //resets taboo list
      procedure   ResetAntenTree();   //resets antennation tree
      procedure   ResetAMTSTree();    //resets AMTS tree
    // Fields and methods only accessible by this class and descendants
    protected
    // Externally accessible fields and methods
    public
        constructor Create(identity: integer);
        function    GetPath: TPath;
        function    GetTree: TTree;
        function    GetDistance: integer;
        function    Move(): integer;  //returns what city it moved to, -1 if finished , antMeet is the number of meetings between ants thus far
        function    MoveFinal(): integer;

        procedure   SetStartCity(startCity: integer);
        procedure   AddTree(antTree: TTree);
        procedure   Consolidate();
        procedure   TwoOpt(); //perform 2 opt local search
    end;

implementation

{ TAnt }

constructor TAnt.Create(identity: integer);
var i: integer;
begin
  ID := identity;
  age := 0;

  meet := 0;
  tL := nil;
  AntenMTree := nil;
  AntenOTree := nil;
  AMTSTree := nil;

  setLength(tL, mCfg.nC);
  setLength(AntenMTree, mCfg.nC);
  setLength(AntenOTree, mCfg.nC);
  if (mCfg.aLType = ACOAMTS) then
    setLength(AMTSTree, mCfg.nC);
    
  for i:=0 to mCfg.nC -1 do begin
    setLength(AntenMTree[i], mCfg.nC);
    setLength(AntenOTree[i], mCfg.nC);

    if(mCfg.aLType = ACOAMTS) then
      setLength(AMTSTree[i], mCfg.nC);
  end;
end;

function TAnt.GetDistance: integer;
begin
  result:= tD;
end;

function TAnt.GetPath: TPath;
begin
  result:= tL;
end;

function TAnt.GetTree: TTree;
begin
  result := AntenMTree;
end;

function TAnt.isNotTabooList(city: integer) : boolean;
var i: integer;
begin
  i:= 0;
  while ((tL[i] <> city) and (i < cCnt)) do begin
    inc(i);
  end;

  if (i = cCnt) then begin
    result := true; //haven't found string, ie not taboo
  end
  else begin
    result := false; //found the string, taboo
  end;
end;

procedure TAnt.ResetAntenTree();
var i, j: integer;
begin
  for i:= 0 to mCfg.nC -1 do for j:= 0 to mCfg.nC -1 do begin
     AntenMTree[i][j] := 0;
  end;
  meet := 0;
end;

procedure TAnt.ResetAMTSTree();
var i,j :integer;
begin
  for i:= 0 to mCfg.nC -1 do for j := 0 to mCfg.nC -1 do
    AMTSTree[i][j] := 0;
end;

procedure TAnt.ResetList();
var i : integer;
begin
  for i:= 0 to mCfg.nC -1 do
    tL[i] := -1;
end;

procedure TAnt.SetStartCity(startCity: integer);
begin

  ResetList();
  ResetAntenTree();
  if(mCfg.aLType = ACOAMTS) then begin
    if(age > mCfg.mA) then begin
      age := 0;
      resetAMTSTree();
    end;
  end;

  tD := 0;
  cC := startCity;
  cCnt := 0;
  tL[cCnt] := cC;
end;

function TAnt.MoveFinal(): integer;
begin
  tD := tD + getSeg(cC, tL[0]).d;
  result := tL[0];
  inc(age);
end;

function TAnt.Move(): integer;
var probList: array of double;
  prob, sumProb, nmlProb, antFactor, mostAttract: double;
  i, nextCity, acsCity: integer;
begin
  SetLength(probList, mCfg.nC);
  sumProb := 0.0;

  //set default values for ACS algorithm mode
  mostAttract := 0.0;
  acsCity := -1;

  inc(cCnt);
  for i := 0 to (mCfg.nC - 1) do begin  //completely fill probability list
    if(isNotTabooList(i)) then begin
      antFactor := antennationFactor(i);

      //this 'if' statement is a catch-all statement, ensures that the
      //antennation factor never goes above 1 and prevents overflows
      if(antFactor > 1) then
        antFactor := 0;
      prob := power(GetSeg(cC,i).p, mCfg.a) *
         power(GetSeg(cC,i).d, -mCfg.b) * (1 - antFactor);

      if(mCfg.aLType = ACOAMTS) then
        prob := prob / AMTSFactor(i);

      //ACS ALGORITHM, storing most attractive city thus far
      if((mCfg.aLType = ACOACS) and (prob > mostAttract)) then begin
        mostAttract := prob;
        acsCity := i;
      end;


      sumProb := sumProb + prob;
      probList[i] := prob;
    end
    else begin //taboo, make probability zero, no chance of going there
      probList[i] := 0.0;
    end;
  end; //finish creating roulette wheel

  //NEED TO CHECK IF IN ACS MODE AND ALSO RAND IS BELOW GREED THRESHOLD
  //IF SO, CHOOSE MOST ATTRACTIVE CITY IN ROULETTE WHEEL
  if((mCfg.aLType = ACOACS) and (Random < mCfg.gP)) then begin
    nextCity := acsCity;
  end
  else begin  //DO NORMAL AS ALGORITHM
    nmlProb := 0.0;
    nextCity := -1;
    prob := Random * sumProb; //get a random number between 0 and the total sum of probabilities
    repeat begin
      inc(nextCity);
      nmlProb := nmlProb + probList[nextCity];
    end;
    until (nmlprob > prob);
  end;

  //if using AMTS, increment the segment corresponding to the travelled arc
  if(mCfg.aLType = ACOAMTS) then
    inc(AMTSTree[cC][nextCity]);

  //add record to Antennation internal tree of path taken
  inc(AntenMTree[cC][nextCity]);

  //if we are dealing with UniDirectional Antennation, arc ij AND ji are incremented
  if mCfg.aFDir = UNI then
    inc(AntenMTree[nextCity][cC]);

  //If we are dealing with ACS, have to update the arcs locally i.e. after every movement
  if mCfg.aLType = ACOACS then
    LayACSEdge(cC, nextCity);

  tD := tD + GetSeg(cC, nextCity).d;
  tL[cCnt] := nextCity;
  cC := nextCity;
  result := cC;
end;

procedure TAnt.AddTree(antTree: TTree);
var i,j: integer;
begin
  inc(meet);
  for i:= 0 to mCfg.nC -1 do for j:= 0 to mCfg.nC -1 do begin
  //number of checks beforehand
  //check if i <> j, not same city
  //check if any ants in antTree
    if ((i <> j) and (antTree[i][j] > 0)) then
      inc(AntenOTree[i][j]);
  end;
end;

function TAnt.AntennationFactor(nextCity: integer): double;
begin
  if meet = 0 then
    result := 0
  else begin
    case mCfg.aFType of
      AFNONE: result := 0;
      AFBOOL: if(AntenMTree[cC][nextCity] > 0) then result := mCfg.aF else result := 0;
      AFLIN:  result := mCfg.aF *       (AntenMTree[cC][nextCity]/meet);
      AFSQRT: result := mCfg.aF *   Sqrt(AntenMTree[cC][nextCity]/meet);
      AFSQR:  result := mCfg.aF *  Power(AntenMTree[cC][nextCity]/meet, 2.0);
      AFTANH: result := mCfg.aF *   Tanh(AntenMTree[cC][nextCity]/Sqrt(meet));
      AFAMTS: result := (mCfg.aF * Sqrt(AntenMTree[cC][nextCity]))/(1+mCfg.aF * Sqrt(AntenMTree[cC][nextCity]));
      AF1ONX: result := (mCfg.aF * AntenMTree[cC][nextCity]) /(1+mCfg.aF * AntenMTree[cC][nextCity]);
      else  result := 0;
    end;
  end;
end;

procedure TAnt.Consolidate;
var i,j: integer;
begin
  for i:= 0 to mCfg.nC-1 do for j := 0 to mCfg.nC -1 do begin
    AntenMTree[i][j] := AntenOTree[i][j] + AntenMTree[i][j];
    AntenOTree[i][j] := 0;
  end;
end;


function TAnt.AMTSFactor(nextCity: integer): double;
begin
  result:= 1 + Sqrt(AMTSTree[cC][nextCity]);
end;


//performs 2-Opt with Linear weighting.
//pA is chosen, all other path positions are ranked by closeness
//The 2 nearest positions have weighting ceil((nC-1)/2),  all other cities are
//weighted according to their rank i.e., proximity

procedure TAnt.TwoOpt();
var k, pA, pB : integer;
  offset, temp, newDist: integer;
begin
  pA := Random(mCfg.nC);

  case mCfg.lSType of
    LSLIN   : offset := GetLinOffset();
    LSEXP   : offset := GetExpOffset();
    else  offset := 0; //ERROR ERROR
  end;

  if random > 0.5 then
    pB := (pA + offset) mod mCfg.nC
  else  //even offset, we subtract
    pB := (pA - offset+ mCfg.nC) mod mCfg.nC;


  //swap the values (we'll swap back if we have to)
  temp := tL[pA];
  tL[pA] := tL[pB];
  tL[pB] := temp;

  newDist := GetPathDistance(tL);
  if newDist < tD then
    tD := newDist //don't need to do anything else
  else begin
  //need to swap back
    temp := tL[pA];
    tL[pA] := tL[pB];
    tL[pB] := temp;
  end;


end;

end.

