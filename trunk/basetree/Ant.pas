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
      mTree: TTree;    //tree holding travelled paths mTree is own tree, oTree is otherTrees
      oTree: TTree;
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
        procedure   Consolidate();
    end;

implementation

{ TAnt }

constructor TAnt.Create(identity: integer);
var i: integer;
begin
  ID := identity;
  meet := 0;
  setLength(tL, mCfg.nC);
  setLength(mTree, mCfg.nC);
  setLength(oTree, mCfg.nC);
  for i:=0 to mCfg.nC -1 do begin
    setLength(mTree[i], mCfg.nC);
    setLength(oTree[i], mCfg.nC);
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
  for i:= 0 to mCfg.nC -1 do for j:= 0 to mCfg.nC -1 do begin
     mTree[i][j] := 0;
  end;
  meet := 0;
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

      //this 'if' statement is a catch-all statement, ensures that the
      //antennation factor never goes above 1 and prevents overflows
      if(antFactor > 1) then
        antFactor := 0;
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

  //add record to internal tree of path taken
  inc(mTree[cC][nextCity]);
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
      inc(oTree[i][j]);
  end;
end;

function TAnt.AntennationFactor(nextCity: integer): double;

begin
  if meet = 0 then
    result := 0
  else begin
    case mCfg.aFType of
      AFNONE: result := 0;
      AFBOOL: if(mTree[cC][nextCity] > 0) then result := mCfg.aF else result := 0;
      AFLIN:  result := mCfg.aF *       (mTree[cC][nextCity]/meet);
      AFSQRT: result := mCfg.aF *   Sqrt(mTree[cC][nextCity]/meet);
      AFSQR:  result := mCfg.aF *  Power(mTree[cC][nextCity]/meet, 2.0);
      AFTANH: result := mCfg.aF *   Tanh(mTree[cC][nextCity]/Sqrt(meet));
      AFAMTS: result := 1 - 1/(1+Sqrt(mTree[cC][nextCity]));
      else  result := 0;
    end;
  end;
end;

procedure TAnt.Consolidate;
var i,j: integer;
begin
  for i:= 0 to mCfg.nC-1 do for j := 0 to mCfg.nC -1 do begin
    mtree[i][j] := oTree[i][j] + mTree[i][j];
    oTree[i][j] := 0;
  end;
end;

end.

