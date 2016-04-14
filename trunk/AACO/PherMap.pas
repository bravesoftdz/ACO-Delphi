unit PherMap;

interface

uses
  ExtCtrls {image}, Classes {StringList}, Chart {duh}, Graphics {Colours}, Math {arcCos},
  SysUtils {strtoN conversions};


const
//////////// MAXMIN SETTINGS //////////////////////
  MMPBEST   = 0.05;


///////// ANTENNATION TYPES ////////////
  AFNONE    = 0;
  AFBOOL    = 1;
  AFLIN     = 2;
  AFSQR     = 3;
  AFSQRT    = 4;
  AFTANH    = 5;
  AFAMTS    = 6;
  AF1ONX    = 7;

  CURRENT_AF_TYPES = 8;

///////// ANTENNATION DIRECTIONS //////////
  BI        = 0;
  UNI       = 1;
  BOTH      = 2;

/////////// LOCAL SEARCH TYPES ////////////
  LSEXP     = 0;
  LSLIN     = 1;

////////////// ACO TYPES ////////////////
  ACOAS     = 0;
  ACOACS    = 1;
  ACOAMTS   = 2;
  ACOMM     = 3;

///////// DRAWING SETTINGS /////////////
  OFFSET    = 10;
  MAXTHICK  = 20; //for now
  RRR       = 6378.388;
  RS        = 3;




type
	TCoord = record
		x: double;
		y: double;
end;

type
  TSegment = record
    p: double;
    d: integer;
  end;

type
  TPath = array of integer;

type
  TTree = array of array of integer;

type
  TBoolArray = array of boolean;
type
  TConfig = record
    nC, nA: integer;
    b, a: integer;
    pI, pD, pA: double; //Pheromone settings
    gP: double;         //ACS  - Greedy probability
    igB: double;        //MM, iteration vs global best percentage
    pMX, pMN: double;   //MM - Pheromone max and min
    mA: integer;        //AMTS - Maximum ant age
    aLType: integer;    //Algorithm type - AS, ACS, AMTS, MM

    aFType: integer;    //Antennation type - NONE, BOOL, LIN, SQR, SQRT, TANH, AMTS
    aFDir : integer;    //Antennation Direction type - unidirectional or bi-directional (normal)
    aF : double;        //Antennation factor
    lSTimes: integer;   //Local search times
    lSType: integer;     //Local search technique
  end;

type
  TBatch = record
    nAB, nAS, nAE: integer;     //number of ants
    pAB, pAS, pAE : double;     //pheromone laid
    pDB, pDS, pDE : double;     //pheromone decayed
    pIB, pIS, pIE : double;     //initial pheromone level

    gPB, gPS, gPE : double;     //greedy probability ACS
    igB: double;                //percentage iteration best vs global best
    mAB, mAS, mAE : integer;    //maximum age of ants AMTS

    aFB, aFS, aFE : double;     //antennation factor
    a, b : integer;             //biasing of heuristics (distance vs pheromone)
    numGen, iteration: integer; //generations til stop, iterations per setting
    aFType: TBoolArray;   //antennation Type -- can do multiple types
    aFDir  : integer;            //antennation direction
    aLType: integer;            //algorithm type
  end;



  procedure ReducePher();
  procedure InitPher();
  procedure LayPherPath(path: TPath; dist: integer);
  procedure LayACSBestPath(path: TPath; dist: integer);
  procedure LayACSEdge(cC, nC: integer);
  procedure LayMMBestPath(path: TPath; dist: integer);

  procedure LoadCities(coordFile: TStringlist);
  function ParseCoord(str: string): TCoord;
  function WorldDistance(x1y1,x2y2:TCoord): integer;

  procedure ChooseScale(dest:TImage);
  procedure DrawMap(dest:TImage; bDist: double; bPath:TPath);
  procedure GraphPheromone(dest: TChart);

  //these 2 functions return a path segment from the cut-down triangular array
  //first function uses indexes, second function uses path and indexes
  function GetSeg(i,j:integer): TSegment; overload;
  function GetSeg(i,j: integer; path : TPath): TSegment; overload;

  // sets the pheromone levels of an arc ensuring no out-of-bounds arrays
  //first function sets the pheromone using a given path and then the indices of 2 cities in that path
  //second function uses the absolute city numbers
  procedure SetSegP(i,j: integer; path: TPath; p: double); overload;
  procedure SetSegP(i,j: integer; p: double); overload;

  function GetPathDistance(thePath: TPath): integer;
  function GetLinOffset(): integer;
  function GetExpOffset(): integer;

//public variables, visible to other classes
var
  mCfg: TConfig;
  mBat: TBatch;

implementation
//private variables, not visible to other classes
var
  s:    array of array of Tsegment;
  cL:   array of TCoord;
  xmin, xmax, ymin, ymax: double; //used for drawing purposes
  scale: double;
  yoff, xoff: integer;


procedure ReducePher();
var i,j: integer;
begin
  for i := mCfg.nC -1 downto 0 do for j:= i - 1 downto 0 do begin
    s[i][j].p := s[i][j].p * (1- mCfg.pD);
    if((mCfg.aLType = ACOMM) and (s[i][j].p < mCfg.pMN)) then
      s[i][j].p := mCfg.pMN;
  end;
end;

procedure LayACSEdge(cC, nC: integer);
var addP : double;
begin
  addP := ((1 - mCfg.pA) * GetSeg(cC, nC).p) + (mCfg.pA * mCfg.pI);
  SetSegP(cC, nC, addP);
end;




procedure LayPherPath(path:TPath; dist:integer);
var i : integer;
    add : double;
begin

  case mCfg.aLType of
    ACOAS: begin
      for i := 0 to mCfg.nC-2 do begin //from path[n] to [n+1], lay pheromone
        add := mCfg.pA / dist + GetSeg(i,i+1,path).p;
        SetSegP(i,i+1,path,add); //(pu*dist of seg)
      end;
        //loop back to start - set s[path.0][path.end] pheromone
      add := mCfg.pA / dist + GetSeg(0, mCfg.nC -1,path).p;
      SetSegP(0,mCfg.nC-1,path, add);
    end;         //END AS CASE

    ACOAMTS: begin
      for i := 0 to mCfg.nC-2 do begin //from path[n] to [n+1], lay pheromone
        add := mCfg.pA / dist + GetSeg(i,i+1,path).p;
        SetSegP(i,i+1,path,add); //(pu*dist of seg)
      end;
        //loop back to start - set s[path.0][path.end] pheromone
      add := mCfg.pA / dist + GetSeg(0, mCfg.nC -1,path).p;
      SetSegP(0,mCfg.nC-1,path, add);
    end;         //END AMTS CASE -- functionally identical to AS case

  end;    //END CASE
end;

procedure LayACSBestPath(path: TPath; dist: integer);
var i : integer;
    add : double;
begin
  for i := 0 to mCfg.nC-2 do begin //from path[n] to [n+1], lay pheromone
    add := mCfg.pA / dist + GetSeg(i,i+1,path).p;
    SetSegP(i,i+1,path,add); //(pu*dist of seg + (1-pd*pher)
  end;
    //loop back to start - set s[path.0][path.end] pheromone
  add := mCfg.pA / dist + GetSeg(0, mCfg.nC - 1,path).p;
  SetSegP(0,mCfg.nC-1,path, add); //(pu*dist of seg + (1-pd*pher)
end;


procedure LayMMBestPath(path: TPath; dist: integer);
var i : integer;
    add : double;
    tmpPMax : double;
begin
  tmpPMax := (1/(mCfg.pD))*(1/dist);
  if tmpPMax > mCfg.pMX then   //reassign
    mCfg.pMX := tmpPMax;

  mCfg.pMN := (mCfg.pMX*(1-Power(MMPBEST, 1/mCfg.nC)))/((mCfg.nC/2-1)*Power(MMPBEST, 1/mCfg.nC));

  for i := 0 to mCfg.nC-2 do begin //from path[n] to [n+1], lay pheromone
    add := (mCfg.pA / dist) + GetSeg(i,i+1,path).p;
    if(add > mCfg.pMX) then
      add := mCfg.pMX;

    SetSegP(i,i+1,path,add); //(pu*dist of seg + (1-pd*pher)
  end;
    //loop back to start - set s[path.0][path.end] pheromone
  add := mCfg.pA / dist + GetSeg(0,mCfg.nC -1,path).p;
  if(add > mCfg.pMX) then
    add := mCfg.pMX;

  SetSegP(0,mCfg.nC-1,path, add); //(pu*dist of seg + (1-pd*pher)

end;

procedure LoadCities(coordFile: TStringlist);
var i,j: integer;
    tempStr, wrd, coordWrd: string;
	  x1y1, x2y2: TCoord;
    coordType : boolean;
begin

  tempStr := coordFile.Strings[0]; //parse first line
//FIRST NEED TO SORT WHAT TYPE OF COORDINATE SYSTEM IT IS
	//get the first city from the string by scanning until ' '
	wrd := Copy(tempStr, 1, Pos(' ', tempStr) - 1);     {Get the word from the string, scan til space}
	mCfg.nC := StrToInt(wrd);
	//redefine string by cutting from ' ' to end of the string and compare to Cartesian
  //determines what coordinate system we are using
	coordWrd := Copy(tempStr, Pos(' ',tempStr)+1,Length(tempStr)-Length(wrd)+1);
  coordType := CompareText(coordWrd, 'cartesian') = 0;

  //INITIALISE PHEROMONE MAP DIMENSIONS
  //initialise and clear arrays
  s := nil;
  cL := nil;

  //initialise coords array


  setLength(cL, mCfg.nC);

  //initialise s array in both dimensions - using topdown triangle approach
  setLength(s, mCfg.nC);
  for i := mCfg.nC -1 downto 0 do
    setLength(s[i],i);


  //load coordinates into an array in order
	for i:= 0 to (mCfg.nC-1) do
		cL[i] :=  ParseCoord(coordFile.strings[i+1]); //load xy coords of this city

  for i:= mCfg.nC -1 downto 0 do for j:= i-1 downto 0 do begin
    x1y1 := cL[i];
    x2y2 := cL[j];
    if(coordType) then
      s[i][j].d := Floor(Sqrt(power(x1y1.x - x2y2.x,2) + power(x1y1.y-x2y2.y,2))+0.5)
    else
      s[i][j].d := WorldDistance(x1y1,x2y2);
  end;

end;


function WorldDistance(x1y1,x2y2: TCoord): integer;
var  q1, q2, q3, long1, long2, lat1, lat2: double;
begin
    lat1  := PI*(trunc(x1y1.x)+(5.0*(x1y1.x-trunc(x1y1.x)))/3)/180;
    long1 := PI*(trunc(x1y1.y)+(5.0*(x1y1.y-trunc(x1y1.y)))/3)/180;
    lat2  := PI*(trunc(x2y2.x)+(5.0*(x2y2.x-trunc(x2y2.x))/3))/180;
    long2 := PI*(trunc(x2y2.y)+(5.0*(x2y2.y-trunc(x2y2.y))/3))/180;
    q1 := cos(long1 - long2);
    q2 := cos(lat1 - lat2);
    q3 := cos(lat1 + lat2);
		result := trunc(RRR*ArcCos(0.5*((1.0+q1)*q2-(1.0-q1)*q3))+1.0);
 end;

function ParseCoord(str: string): TCoord;
var wrd, tempStr: string;
	  theCoords: TCoord;
begin
	tempStr := str;
	//get the first city from the string by scanning until ' '
	wrd := Copy(tempStr, 1, Pos(' ', tempStr) - 1);     {Get the word from the string, scan til space}
	theCoords.x := StrtoFloat(wrd);
	//redefine string by cutting from ' ' to end of the string
	wrd := Copy(tempStr, Pos(' ', tempStr) + 1, Length(tempStr) - Length(wrd) + 1);
	theCoords.y := StrToFloat(wrd);
	result := theCoords;
end;

function GetSeg(i,j:integer): TSegment;
begin
  if(i > j) then
    result := s[i][j]
  else
    result := s[j][i];
    
end;

function GetSeg(i,j: integer; path : TPath): TSegment;
begin
  if(path[i] > path[j]) then
    result := s[path[i]][path[j]]
  else
    result := s[path[j]][path[i]];
end;

procedure SetSegP(i,j: integer; path : TPath; p: double);
begin
  if(path[i] > path[j]) then
    s[path[i]][path[j]].p := p
  else
    s[path[j]][path[i]].p := p;
end;

procedure SetSegP(i,j: integer; p: double);
begin
  if(i > j) then
    s[i][j].p := p
  else
    s[j][i].p := p;
end;

function GetPathDistance(thePath: TPath): integer;
var i : integer;
begin
  result := 0;
  for i:= 0 to mCfg.nC -2 do
    result := result + GetSeg(i,i+1,thePath).d;

  result := result + GetSeg(mCfg.nC-1,0,thePath).d;
end;


function GetLinOffset(): integer;
var  weight, pA, theRange: integer;
begin
  weight := (mCfg.nC*(mCfg.nC+1)) div 2;
  theRange := mCfg.nC div 2;
  pA := Random(weight+1);
  result := 0;
  while pA>theRange do begin
    pA := pA - theRange;
    inc(result);
    dec(theRange);
  end;
end;


function GetExpOffset(): integer;
begin
  result := 0 ;
  repeat
    inc(result)
  until (random < 0.25) or (result = mCfg.nC div 2);
end;


procedure ChooseScale(dest:TImage);
var w, h, i, j: integer;
    wSize: double;
    sP: TCoord;
begin
  w := dest.Width;
  h := dest.Height;
  if w>h then wSize := w else wSize := h;

  sP := cL[0];
  xmin := sP.x; xmax := sP.x; ymin := sP.y; ymax := sP.y;

  //loop to figure out x/ymin and x/ymax for the cities
  for i:= 1 to mCfg.nC -1 do for j:= 0 to mCfg.nC -1 do begin
    sP := cL[i];
    if sP.x < xmin then xmin := sP.x else if sP.x > xmax then xmax := sP.x;
    if sP.y < ymin then ymin := sP.y else if sP.y > ymax then ymax := sP.y;
  end;

  //figuring out the scale to use
  if (ymax-ymin) > (xmax-xmin) then begin
    scale := (wSize-2*OFFSET)/(ymax-ymin);
    yoff := OFFSET;
    xoff := OFFSET + round(scale*((ymax-ymin)-(xmax-xmin))/2);
  end
  else begin
    scale := (wSize-2*OFFSET)/(xmax-xmin);
    xoff := OFFSET;
    yoff := OFFSET + round(scale*((xmax-xmin)-(ymax-ymin))/2);
  end;
end;

procedure DrawMap(dest:TImage; bDist: double; bPath:TPath);
var i, j, x, y, w, h, thick: integer;
    pmax, pmin, p: double;
    sP: TCoord;

begin
  w := dest.Width;
  h := dest.Height;
  //draw the basic rectangle background
  dest.Canvas.Pen.Color := clWhite;
  dest.Canvas.Brush.Color := clWhite;
  dest.Canvas.Brush.Style := bsSolid;
  dest.Canvas.Rectangle(0,0,w,h);

  pmin := 1e99; pmax := 0;
  for i:= mCfg.nC -1 downto 0 do for j:= i - 1 downto 0 do begin
    p := s[i][j].p;
    if p > pmax then
      pmax := p;
    if p < pmin then
      pmin := p;
  end;

  if(pmax <> pmin) and (pmax <> 0) then begin //there is at least a slight pheromone difference
    //draw pheromone trails
    dest.Canvas.Pen.Color := clGreen;
    for i:= mCfg.nC -1 downto 0 do for j:= i - 1 downto 0 do begin
      thick := round(MAXTHICK * (s[i][j].p - pmin)/(pmax-pmin));
      if(thick >0) and (i <> j) then begin  //draw if thickness is greater than zero
        dest.Canvas.Pen.Width := thick;
        sP := cL[i];
        x := round((sP.x - xmin) * scale) + xoff;
        y := dest.Height - round((sP.y - ymin) * scale) - yoff;
        dest.Canvas.MoveTo(x,y);
        sP := cL[j];
        x := round((sP.x - xmin) * scale) + xoff;
        y := dest.Height - round((sP.y - ymin) * scale) - yoff;
        dest.Canvas.LineTo(x,y);
      end;
    end;
  end;
  if(bDist < MAXINT) then begin
    //draw best path
    dest.Canvas.Pen.Color := clRed;
    dest.Canvas.Pen.Width := 1; //thickness 1
    sP := cL[bPath[mCfg.nC-1]];
    x := round((sP.x - xmin) * scale) + xoff;
    y := dest.Height - round((sP.y - ymin) * scale) - yoff;
    dest.Canvas.MoveTo(x,y);
    for i:= 0 to mCfg.nC-1 do begin
      sP := cL[bPath[i]];
      x := round((sP.x - xmin) * scale) + xoff;
      y := dest.Height - round((sP.y - ymin) * scale) - yoff;
      dest.Canvas.LineTo(x,y);
    end;
  end;

  //draw cities
  dest.Canvas.Brush.Color := clBlue;
  for i:= 0 to mCfg.nC-1 do begin
    sP := cL[i];
    x := round((sP.x - xmin) * scale) + xoff;
    y := dest.Height - round((sP.y - ymin) * scale) - yoff;
    dest.Canvas.FillRect(rect(x-RS,y+RS,x+RS,y-RS));
  end;

  dest.Repaint;

end;

procedure GraphPheromone(dest:TChart);
var ptot, pav, pmax, p : double;
    i,j : integer;
begin
  //obtaining the average, lowest and highest pheromone levels
  ptot := 0; pmax := 0;
  for i:= mCfg.nC -1 downto 0 do for j:= i - 1 downto 0 do begin
    p := s[i][j].p;
    if p > pmax then pmax := p;
    ptot := p + ptot;
  end;

  pav:= ptot/(mCfg.nC * mCfg.nC - mCfg.nC); //get the average pheromone

  dest.Series[0].Add(pav);
  dest.Series[1].Add(pmax);

end;


procedure InitPher();
var i,j: integer;
begin
  for i:= mCfg.nC - 1 downto 0 do for j := i - 1 downto 0 do
    s[i][j].p := mCfg.pI;

  if mCfg.aLType = ACOMM then begin
    mCfg.pMX := mCfg.pI;
    mCfg.pMN := 0;
  end;

end;

end.

