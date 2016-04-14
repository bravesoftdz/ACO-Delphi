unit PherMap;

interface

uses
ExtCtrls {image}, Classes {StringList}, Chart {duh}, Graphics {Colours}, Math {arcCos},
SysUtils {strtoN conversions};


const
  AFNONE    = 0;
  AFBOOL    = 1;
  AFLIN     = 2;
  AFSQR     = 3;
  AFSQRT    = 4;
  AFTANH    = 5;
  AFAMTS    = 6;

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
  TConfig = record
    nC, nA: integer;
    b, a: integer;
    pI, pD, pA: double;
    aF : double;
    aFType: integer;
  end;

type
  TBatch = record
    nAB, nAS, nAE: integer;
    pAB, pAS, pAE : double;
    pDB, pDS, pDE : double;
    pIB, pIS, pIE : double;
    aFB, aFS, aFE : double;
    a, b : integer;
    numGen, iteration: integer;
    aFType: integer;
  end;

type
  TPath = array of integer;

type
  TAntSet = record
    mem: set of byte;
    nAnts : integer;
  end;

type
  TTree = array of array of TAntSet;



  procedure InitPher();
  procedure ReducePher();
  procedure StartPher();
  procedure LayPherPath(path:TPath; dist:double);

  procedure ResetPher();
  procedure LoadCities(coordFile: TStringlist);
  function ParseCoord(str: string): TCoord;
  function WorldDistance(x1y1,x2y2:TCoord): integer;

  procedure ChooseScale(dest:TImage);
  procedure DrawMap(dest:TImage; bDist: double; bPath:TPath);
  procedure GraphPheromone(dest: TChart);

  function GetSeg(i,j:integer): TSegment;

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

procedure InitPher();
  { TODO : fix initialise routine }
var i: integer;
begin
  //initialise coords array
  setLength(cL, mCfg.nC);
  //initialise s array in both dimensions
  setLength(s, mCfg.nC);
  for i := 0 to (mCfg.nC -1) do
    setLength(s[i],mCfg.nC);
end;

//reset pheromone path

procedure ResetPher();
var i,j: integer;
begin
  //reset
	for i := 0 to high(s) do for j:= 0 to high(s[i]) do
    s[i][j].p := 0;
end;

procedure LoadCities(coordFile: TStringlist);

var i,j: integer;
  tempStr, wrd, coordType: string;
  coordSys: integer;
	x1y1, x2y2: TCoord;
begin

  tempStr := coordFile.Strings[0]; //parse first line
//FIRST NEED TO SORT WHAT TYPE OF COORDINATE SYSTEM IT IS
	//get the first city from the string by scanning until ' '
	wrd := Copy(tempStr, 1, Pos(' ', tempStr) - 1);     {Get the word from the string, scan til space}
	mCfg.nC := StrToInt(wrd);
	//redefine string by cutting from ' ' to end of the string
	coordType := Copy(tempStr, Pos(' ', tempStr) + 1, Length(tempStr) - Length(wrd) + 1);
  InitPher();     //initialise the pheromone
  coordSys := CompareStr(coordType, 'Cartesian');

	for i:= 0 to (mCfg.nC-1) do begin
		x1y1 :=  ParseCoord(coordFile.strings[i+1]); //load xy coords of this city
    cL[i] := x1y1; //storing coords into array
    for j := 0 to (mCfg.nC - 1) do begin
			if( i = j) then s[i][j].d := 0 //zero d between city to city
			else begin
				x2y2 := ParseCoord(coordFile.strings[j+1]); //load xy coords of connecting city
        if(coordSys <> 0) then
          s[i][j].d := WorldDistance(x1y1,x2y2)
        else
          s[i][j].d := Floor(Sqrt(power(x1y1.x - x2y2.x,2) + power(x1y1.y-x2y2.y,2))+0.5);
      end;
    end;
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

var
	wrd, tempStr: string;
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
  result := s[i][j];
end;

procedure ReducePher();
var j, i: integer;
begin
  for i := 0 to high(s) do for j:= 0 to high(s[i]) do
  //need to check if we are dealing with same index ie same city
    if(i <> j) then s[i][j].p := s[i][j].p * (1- mCfg.pD);
end;

procedure LayPherPath(path:TPath; dist:double);
var i : integer;
  newPher : double;
begin
  for i := Low(path) to (High(Path)-1) do begin //from path[n] to [n+1], lay pheromone
    newPher := mCfg.pA / dist + s[path[i]][path[i+1]].p; //(pu*dist of seg)
    s[path[i]][path[i+1]].p := newPher;

    //do the same operation except this time on the other directon, n+1 to n
    newPher := mCfg.pA / dist + s[path[i+1]][path[i]].p; //(pu*dist of seg)
    s[path[i+1]][path[i]].p := newPher;
  end;
  //loop back to start - set s[path.0][path.end] pheromone
  newPher := mCfg.pA / dist;
  s[path[mCfg.nC-1]][path[0]].p := newPher + s[path[mCfg.nC-1]][path[0]].p;
  // set s[path.end][path.0] pheromone
  newPher := mCfg.pA / dist;
  s[path[0]][path[mCfg.nC-1]].p := newPher + s[path[0]][path[mCfg.nC-1]].p;
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

  pmin := s[0][1].p; pmax := s[0][1].p; p:= pmax;
  for i:= 0 to mCfg.nC-1 do for j:= 0 to mCfg.nC -1 do begin
    if (i<>j) then p := s[i][j].p;
    if p > pmax then
      pmax := p;
    if p < pmin then
      pmin := p;
  end;

  if(pmax <> pmin) and (pmax <> 0) then begin //either it hasn't been initialised
    //draw pheromone trails
    dest.Canvas.Pen.Color := clGreen;
    for i:= 0 to mCfg.nC -1 do for j:= 0 to mCfg.nC -1 do begin
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
  if(bDist <> MAXINT) then begin
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
  for i:= 0 to mCfg.nC-1 do for j:= 0 to mCfg.nC -1 do begin
    if i<>j then begin
      p := s[i][j].p;
      if p > pmax then pmax := p;
      ptot := p + ptot;
    end;
  end;

  pav:= ptot/(mCfg.nC * mCfg.nC - mCfg.nC); //get the average pheromone

  dest.Series[0].Add(pav);
  dest.Series[1].Add(pmax);

end;


procedure StartPher();
var i,j: integer;
begin
  for i:=0 to mCfg.nC -1 do for j :=0 to mCfg.nC -1 do
    s[i][j].p := mCfg.pI;
end;

end.

