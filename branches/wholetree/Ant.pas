unit Ant;

interface

  //any units that we use
uses Forms, Classes, SysUtils, Math, PherMap;

  type
    TAnt = class
    // internal definitions only accessible in this unit
    private
      tL:    TPath;
      tD:   integer;  //total distance travelled thus far
      cC:   integer;  //currentCity
      cCnt: integer;  //city counter
      ID: integer;    //ID of the ant
      mtree: TTree;    //tree holding travelled paths mTree is own tree, oTree is otherTrees
      function isNotTabooList(city : integer): boolean;
      function    AntennationFactor(nextCity: integer): double;
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
        procedure   ResetList(); //resets the taboo list and tree
        procedure   SetStartCity(startCity: integer);
        procedure   AddTree(antTree: TTree);
    end;

implementation

{ TAnt }

constructor TAnt.Create(identity: integer);
var i,j: integer;
begin
  ID := identity;
  setLength(tL, mCfg.nC);
  setLength(mTree, mCfg.nC);
  for i:=0 to mCfg.nC -1 do begin
    setLength(mTree[i], mCfg.nC);
    for j:= 0 to mCfg.nC -1 do begin
      mTree[i][j].nAnts := 0;
      mTree[i][j].mem := [];
    end;
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
  result := mTree;
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

procedure TAnt.ResetList();
var i, j: integer;
begin
  for i:= Low(tL) to High(tL) do
    tL[i] := -1;
  for i:= Low(mTree) to High(mTree) do for j:= Low(mTree[i]) to High(mTree[i]) do begin
    mTree[i][j].mem := [];
    mTree[i][j].nAnts := 0;
  end;
end;

procedure TAnt.SetStartCity(startCity: integer);
begin
  tD := 0;
  cC := startCity;
  cCnt := 0;
  tL[cCnt] := cC;
end;

function TAnt.MoveFinal(): integer;
begin
  tD := tD + getSeg(cC, tL[0]).d;
  result := tL[0];
end;

function TAnt.Move(): integer;
var probList: array of double;
  prob, sumProb, nmlProb, antFactor: double;
  i, nextCity : integer;
begin
  SetLength(probList, mCfg.nC);
  sumProb := 0.0;
  inc(cCnt);
  for i := 0 to (mCfg.nC - 1) do begin  //completely fill probability list
    if(isNotTabooList(i)) then begin
      antFactor := antennationFactor(i);
      if(mCfg.aFType = AFAMTS) then
        prob := power(GetSeg(cC,i).p, mCfg.a) *
            power(GetSeg(cC,i).d, mCfg.b) / antFactor
      else
        prob := power(GetSeg(cC,i).p, mCfg.a) *
            power(GetSeg(cC,i).d, mCfg.b) * (1 - antFactor);
      sumProb := sumProb + prob;
      probList[i] := prob;
    end
    else begin //taboo, make probability zero, no chance of going there
      probList[i] := 0.0;
    end;
  end;
  nmlProb := 0.0;
  nextCity := -1;
  prob := Random * sumProb; //get a random number between 0 and the total sum of probabilities
  repeat begin
    inc(nextCity);
    nmlProb := nmlProb + probList[nextCity];
  end;
  until (nmlprob > prob);
  if(cCnt > 1) then
    tD := tD;
  Include(mTree[cC][nextCity].mem, ID);
  inc(mTree[cC][nextCity].nAnts);
  tD := tD + GetSeg(cC, nextCity).d;
  tL[cCnt] := nextCity;
  cC := nextCity;
  result := cC;
end;

procedure TAnt.AddTree(antTree: TTree);
var i,j,k,num: integer;
begin
  for i:= 0 to mCfg.nC -1 do for j:= 0 to mCfg.nC -1 do begin
  //number of checks beforehand
  //check if i <> j, not same city
  //check if any ants in antTree
  //check if antTree is NOT a subset of mTree,
    if ((i <> j) and (antTree[i][j].nAnts > 0))
    and (not (antTree[i][j].mem <= mTree[i][j].mem))then begin
      //check if intersection between sets is null, then just add the numbers
      if ((antTree[i][j].mem * mTree[i][j].mem) = []) then begin
        mTree[i][j].nAnts := mTree[i][j].nAnts + antTree[i][j].nAnts;
        mTree[i][j].mem := mTree[i][j].mem + antTree[i][j].mem;
      end
      else begin
        mTree[i][j].mem := mTree[i][j].mem + antTree[i][j].mem;
        num := 0;
        for k:= 0 to mCfg.nA - 1 do if k in mTree[i][j].mem then inc(num);
        mTree[i][j].nAnts := num;
      end;
    end;
  end;
end;

function TAnt.AntennationFactor(nextCity: integer): double;

begin
  case mCfg.aFType of
    AFNONE: result := 0;
    AFBOOL: if(mTree[cC][nextCity].nAnts > 0) then result := mCfg.aF else result := 0;
    AFLIN:  result := mCfg.aF *       (mTree[cC][nextCity].nAnts/(mCfg.nA));
    AFSQRT: result := mCfg.aF *   Sqrt(mTree[cC][nextCity].nAnts/(mCfg.nA));
    AFSQR:  result := mCfg.aF *  Power(mTree[cC][nextCity].nAnts/(mCfg.nA), 2.0);
    AFTANH: result := mCfg.aF *   Tanh(mTree[cC][nextCity].nAnts/Sqrt(mCfg.nA));
    AFAMTS: result := 1 + Sqrt(mTree[cC][nextCity].nAnts);
    else  result := 0;
  end;
end;

end.

