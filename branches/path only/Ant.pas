unit Ant;

interface

  //any units that we use
uses Forms, Classes, SysUtils, Math, PherMap;



  type
    TAnt = class
    // internal definitions only accessible in this unit
    private
      tL: TPath;
      totalDistance: double;
      cC: integer;  //currentCity
      cCnt: integer; //city counter
      tree: array of array of integer;


      function isNotTabooList(city : integer): boolean;
      function    AntennationFactor(nextCity: integer): double;
    // Fields and methods only accessible by this class and descendants
    protected
    // Externally accessible fields and methods
    public
        constructor Create();
        function    GetPath: TPath;
        function    GetDistance: double;
        function    Move(): integer;  //returns what city it moved to, -1 if finished
        procedure   ResetList(); //resets the taboo list and tree
        procedure   SetStartCity(startCity: integer);
        procedure   AddTree(path: TPath; cityCount: integer);

    end;

implementation

{ TAnt }

constructor TAnt.Create();
var i: integer;
begin
  setLength(tL, mCfg.nC);
  setLength(tree, mCfg.nC);
  for i:=0 to mCfg.nC -1 do
    setLength(tree[i], mCfg.nC);
end;

function TAnt.GetDistance: double;
begin
  result:= totalDistance;

end;

function TAnt.GetPath: TPath;
begin
  result:= tL;
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
  for i:= Low(tree) to High(tree) do for j:= Low(tree[i]) to High(tree[i]) do
    tree[i][j] := 0;
end;

procedure TAnt.SetStartCity(startCity: integer);
begin
  totalDistance := 0;
  cC := startCity;
  cCnt := 0;
  tL[cCnt] := cC;
end;


function TAnt.Move: integer;
var probList: array of double;
  prob, sumProb, nmlProb, antFactor: double;
  i, nextCity : integer;

begin
  SetLength(probList, mCfg.nC);
  sumProb := 0.0;

  if (cCnt = (mCfg.nC -1)) then begin  //back at start
    totalDistance := totalDistance + GetSeg(cC, tL[0]).d;
    result := tL[0];     //only need to add the distance from current city to initial city
  end
  else begin
    inc(cCnt);
    for i := 0 to (mCfg.nC - 1) do begin  //completely fill probability list
      if(isNotTabooList(i)) then begin
        antFactor := antennationFactor(i);
        prob := power(GetSeg(cC,i).p, mCfg.a) *
              power(GetSeg(cC,i).d, mCfg.b) * (1- antFactor) ;
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

    totalDistance := totalDistance + GetSeg(cC, nextCity).d;
    tL[cCnt] := nextCity;
    cC := nextCity;
    result := cC;
  end;
end;



procedure TAnt.AddTree(path: TPath; cityCount: integer);
var i: integer;
begin
  for i:= 0 to cityCount-1 do
    inc(tree[path[i]][path[i+1]]);
end;

function TAnt.AntennationFactor(nextCity: integer): double;
begin
  case mCfg.aFType of
    AFNONE: result := 0;
    AFBOOL: result := mCfg.aF;
    AFLIN:  result := mCfg.aF *       (tree[cC][nextCity]/mCfg.nA);
    AFSQRT: result := mCfg.aF *   Sqrt(tree[cC][nextCity]/mCfg.nA);
    AFSQR:  result := mCfg.aF *  Power(tree[cC][nextCity]/mCfg.nA, 2.0);
    AFTANH: result := mCfg.aF *   Tanh(tree[cC][nextCity]/Sqrt(mCfg.nA));
    else  result := 0;
  end;
end;

end.

