unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, TeeProcs, TeEngine, Chart, Contnrs, {for TObjectList}
  ExtDlgs, Math, Series, ComCtrls, Menus, ToolWin, ActnMan, ActnCtrls, ActnMenus,
  //user created units
   PherMap, BatchForm, Ant, SetForm, ESBPCSPanel, ESBPCSSpinEdit;

//typedef containing the path distance and the amount of times it has occurred
type
  TPathRec = record
    d: integer;
    c: integer;
end;

type
	TACOForm = class(TForm)
    oneTourBtn: TButton;
    nTourBtn: TButton;
    tspOpen: TOpenDialog;
    pChart: TChart;
    runBtn: TButton;
    saveMapDialog: TSavePictureDialog;
    resetBtn: TButton;
    distLbl: TLabel;
    cityLbl: TLabel;
    mapPnl: TPanel;
    mapImg: TImage;
    Series1: TFastLineSeries;
    Series2: TFastLineSeries;
    genLbl: TLabel;
    restartBtn: TButton;
    BPrgsBar: TProgressBar;
    ProgressLbl: TLabel;
    AntMeetLbl: TLabel;
    IterLbl: TLabel;
    IterNumLbl: TLabel;
    MainMenu1: TMainMenu;
    PMenu: TMenuItem;
    PMenuLoad: TMenuItem;
    PMenuSet: TMenuItem;
    PMenuQuit: TMenuItem;
    OMenu: TMenuItem;
    OMenuBat: TMenuItem;
    SetMemo: TMemo;
    OMenuAbout: TMenuItem;
    AntenGrp: TGroupBox;
    AntenTypeRadGrp: TRadioGroup;
    AntenDirRadGrp: TRadioGroup;
    AntFEdit: TESBFloatSpinEdit;
    Label1: TLabel;
    GroupBox1: TGroupBox;
    lSCheckBox: TCheckBox;
    lSEdit: TESBPosSpinEdit;
    lSRadGrp: TRadioGroup;
    
    //constructor/destructor
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    
    //initialising buttons -- in order of precedence
	  procedure loadBtnClick(Sender: TObject);
	  procedure initBtnClick(Sender: TObject);
    
    //normal graphical use buttons
	  procedure nTourBtnClick(Sender: TObject);
    procedure runBtnClick(Sender: TObject);
    procedure oneTourBtnClick(Sender: TObject);
    
    //soft reset button
    procedure resetBtnClick(Sender: TObject);
    procedure restartBtnClick(Sender: TObject);
    procedure AntenTypeRadGrpClick(Sender: TObject);

    procedure AntFEditExit(Sender: TObject);
    procedure PMenuLoadClick(Sender: TObject);
    procedure OMenuBatClick(Sender: TObject);
    procedure PMenuSetClick(Sender: TObject);
    procedure OMenuAboutClick(Sender: TObject);
    procedure AntenDirRadGrpClick(Sender: TObject);
    procedure PMenuQuitClick(Sender: TObject);
    procedure lSCheckBoxClick(Sender: TObject);
    procedure lSEditChange(Sender: TObject);
    

  private
    { Private declarations }

    bDist:  integer;
    bPath:  TPath;
    aL:     TObjectList;
    gen:    integer;
    aMeet:  integer;
    go :    boolean;
    antCountList: array of integer;
    antCityList: array of array of integer;

    function OneTour(mapUpdate: bool): bool;   //if a new path has been found
    function UpdatePheromone(mapUpdate: bool): bool;

    procedure ASBatch(filename: string; totalIter: integer);
    procedure ACSBatch(filename: string; totalIter: integer);
    procedure AMTSBatch(filename: string; totalIter: integer);
    procedure MMBatch(filename: string; totalIter: integer);

    function Antennation(): integer;
    procedure LocalSearch();
    procedure ToggleBtns();

    function GetLSType(theType : integer): string;
    function GetAntType(theType : integer): string;
    function GetAntDir(theDir: integer): string;

    procedure FillNormalMemo();
    procedure FillBatchMemo();

    //spare functions
//  function  PathToStr(path: TmyPath): string;
  public

    { Public declarations }

  end;

var
  ACOForm: TACOForm;

implementation

{$R *.dfm}

{ TForm1 }

{---------------------------------------------------------------------------------------------
----------------PHEROMONE PROCEDURES----------------------------------------------------------
---------------------------------------------------------------------------------------------}

function TACOForm.UpdatePheromone(mapUpdate: bool): bool;

var i, j: integer;
  iterGlobal: bool;
  dist, iDist: integer;
  path, iPath: TPath;
begin
  iterGlobal := false;   //asume using global best
  setLength(path,mCfg.nC);
  result := false;
  iDist := MAXINT;

  //checking if algorithm is MAX MIN
  if(mCfg.aLType = ACOMM) then begin
    //if so, we need to determine whether to use global or iterative best path when updating
    //boolean value is IterGlobal, true if iteration best, false if global best
    if(Random < mCfg.igB) then begin
      iterGlobal := true;
      setLength(iPath, mCfg.nC); //we need to store the best path this iteration
    end;
  end;

  //quick check to see if we have a new best path
  //Strictly only required for MM and ACS
  //used in mapping best path for all algorithms
  for i := 0 to (mCfg.nA -1) do begin
    dist := TAnt(aL.Items[i]).GetDistance();
    path := TAnt(aL.Items[i]).GetPath();

    if dist < bDist then begin     //updating global best path
      bDist := dist;
      result := true;
      for j := 0 to mCfg.nC -1 do
        bPath[j] := path[j];   //copy path elements to new best path
    end;

    if((iterGlobal = true) and (dist < iDist)) then begin //updating iterative best path
      iDist := dist;
      for j:= 0 to mCfg.nC -1 do
        iPath[j] := path[j];
    end;
  end;

  ReducePher(); //currently AS and ACS and AMTS and MM all reduce the pheromone the same way

  //update the rest of the paths

  case mCfg.aLType of
   //AS lays pheromone on all paths that ants have travelled on
    ACOAS: begin
      for i := 0 to (mCfg.nA -1) do begin
        dist := TAnt(aL.Items[i]).GetDistance();
        path := TAnt(aL.Items[i]).GetPath();
        LayPherPath(path, dist);
      end;
    end;
    //ACS updates the best path only in global update
    ACOACS: begin
      LayACSBestPath(bPath, bDist);
      for i:= 0 to (mCfg.nA -1) do begin
        dist := TAnt(aL.Items[i]).GetDistance();
        path := TAnt(aL.Items[i]).GetPath();
        LayPherPath(path, dist);
      end;
    end;
    //AMTS updates identically to AS
    ACOAMTS: begin
      for i := 0 to (mCfg.nA -1) do begin
        dist := TAnt(aL.Items[i]).GetDistance();
        path := TAnt(aL.Items[i]).GetPath();
        LayPherPath(path, dist);
      end;
    end;
    ACOMM: begin
      if (iterGlobal = true) then
        LayMMBestPath(iPath, iDist) //update iterative best
      else
        LayMMBestPath(bPath, bDist);  //update global best
    end;
  end;
end;

{---------------------------------------------------------------------------------------------
-----------------CONSTRUCTOR/DESTRUCTOR --------------------------------------------------
---------------------------------------------------------------------------------------------}

procedure TACOForm.FormCreate(Sender: TObject);
begin
  //Randomize;
  RandSeed := 100;
  aL := TObjectList.Create(True);
  mapImg := TImage.Create(ACOForm);
  mapImg.Parent := mapPnl;
  mapImg.Height := mapPnl.Height;
  mapImg.Width := mapPnl.Width;
  gen := 0;
  aMeet := 0;
  CityLbl.Caption := 'Number of cities:= '+IntToStr(mCfg.nC);
  DistLbl.Caption := 'Distance := null';
  GenLbl.Caption := 'Generations := ' +IntToStr(gen);
  AntMeetLbl.Caption := 'Ant Meetings :=' + IntToStr(aMeet);
  PMenuSet.Enabled := false;
  OMenuBat.Enabled := false;
  
  mCfg.aFType := AFNONE;
  setLength(mBat.aFType, CURRENT_AF_TYPES);
  mCfg.lSTimes := 0;
end;

procedure TACOForm.FormDestroy(Sender: TObject);
begin
  aL.Free;
	bPath := nil;
end;

{---------------------------------------------------------------------------------------------
-----------------BUTTON PROCEDURES----------------------------------------------------------
---------------------------------------------------------------------------------------------}

{---------------------------------------------------------------------------------------------
-----------------INITIAL PROCEDURES----------------------------------------------------------
---------------------------------------------------------------------------------------------}

procedure TACOForm.loadBtnClick(Sender: TObject);
var  strs: TStringList;
  i: integer;
begin
	//open the file
	if tspOpen.Execute then begin
		strs := TStringList.Create;
		strs.LoadFromFile(tspOpen.FileName);

    LoadCities(strs);
		//read from file the number of cities,

    //initialise bestpath array
    setLength(bPath, mCfg.nC);

    //initialise antCountList
    //these 2 lengths do not change, only the antCityList[] changes
    setLength(antCountList, mCfg.nC);
    for i:= 0 to mCfg.Nc -1 do
      antCountList[i] := 0;
    setLength(antCityList, mCfg.nC);

    bDist := MAXINT; //set to maximum size INTEGER can hold

    ChooseScale(MapImg);

    ResetBtn.Enabled := true;
    nTourBtn.Enabled := false;
    runBtn.Enabled  := false;
    oneTourBtn.Enabled := false;
    DrawMap(mapImg, bDist, bPath);
    CityLbl.Caption := 'Number of cities:= '+IntToStr(mCfg.nC);
	end;
end;

procedure TACOForm.initBtnClick(Sender: TObject);
var temp, i: integer;
  strAnt: string;
begin
  if(InputQuery('Ant Dialog Box', 'Number of Ants?', strAnt)) then
  if(TryStrToInt(strAnt, temp)) then if((temp < 255) and (temp > 0)) then begin
    //enable all the buttons, populate the ant list
    mCfg.nA := temp;
    aL.Clear;
    InitPher();
    for i:= 0 to (mCfg.nA - 1) do aL.Add(TAnt.Create(i));
    for i:= 0 to (mCfg.nC - 1) do setLength(antCityList[i], mCfg.nA);
    nTourBtn.Enabled    := true;
    oneTourBtn.Enabled  := true;
    runBtn.Enabled      := true;
  end
  else ShowMessage('Error: '+strAnt+' is not an allowable value');
end;


{---------------------------------------------------------------------------------------------
-----------------RUNNING PROCEDURES----------------------------------------------------------
---------------------------------------------------------------------------------------------}

procedure TACOForm.nTourBtnClick(Sender: TObject);
var strTour: string;
  nTour, i: integer;
begin
  strTour := '10';
  if(InputQuery('Ant Tours', 'How many ant tours do you want to do?', strTour)) then begin
    if(TryStrToInt(strTour, nTour)) then begin
      go := true;
      toggleBtns();
      for i:= 0 to nTour -1 do begin
        oneTour(true);
        DistLbl.Caption := 'Distance := ' + IntToStr(bDist);
        GenLbl.Caption := 'Generations := '+IntToStr(gen);
        AntMeetLbl.Caption := 'Ant Meetings := ' + IntToStr(aMeet);
        GraphPheromone(pChart);
        DrawMap(mapImg, bDist, bPath);
      end;
      toggleBtns();
    end else ShowMessage('Error:' +strTour+ ' is not a valid value');
  end;
end;

procedure TACOForm.toggleBtns();
begin
  RunBtn.Enabled := not RunBtn.Enabled;
  NTourBtn.Enabled := not NTourBtn.Enabled;
  oneTourBtn.Enabled := not oneTourBtn.Enabled;
  ResetBtn.Enabled := not ResetBtn.Enabled;
end;
  



procedure TACOForm.runBtnClick(Sender: TObject);

var nGen, i: integer;
    strTour: string;
begin
  strTour:= '10';
  if(InputQuery('Run Until N generations', 'How many generations since new best distance?', strTour)) then begin
    if(TryStrToInt(strTour, nGen)) then begin
      i := 0;
      go := true;
      toggleBtns();
      while (i < nGen) do begin
        genLbl.Caption := 'Generations := '+IntToStr(gen);
        AntMeetLbl.Caption := 'Ant Meetings :=' + IntToStr(aMeet);
        if(oneTour(true)) then i := 0 else inc(i);
        distLbl.Caption := 'Distance := ' + IntToStr(bDist);
        GraphPheromone(pChart);
        DrawMap(mapImg, bDist, bPath);
      end;
      toggleBtns();
    end else ShowMessage('Error:' +strTour+ ' is not a valid value');
  end;
end;


procedure TACOForm.resetBtnClick(Sender: TObject);
begin
  go := false;
  gen := 0;
  bDist := MAXINT;
  pChart.Series[0].Clear;
  pChart.Series[1].Clear;
  aMeet := 0;
  CityLbl.Caption := 'Number of cities:= '+IntToStr(mCfg.nC);
  DistLbl.Caption := 'Distance := null';
  GenLbl.Caption := 'Generations := ' +IntToStr(gen);
  AntMeetLbl.Caption := 'Ant Meetings := ' + IntToStr(aMeet);
  InitPher();
  DrawMap(mapImg, bDist, bPath);

end;

procedure TACOForm.oneTourBtnClick(Sender: TObject);
begin
  go := true;
  oneTour(true);
  DistLbl.Caption := 'Distance := ' +IntToStr(bDist);
  GenLbl.Caption := 'Generations := '+IntToStr(gen);
  AntMeetLbl.Caption := 'Ant Meetings :=' + IntToStr(aMeet);
  DrawMap(mapImg, bDist, bPath);
  GraphPheromone(pChart);
  FillNormalMemo();
end;

function TACOForm.OneTour(mapUpdate : bool): bool;
var i,j, antMove :integer;
begin
  inc(gen);
  result := false;
  aMeet := 0;

  for i := 0 to mCfg.nA -1 do    //set initial city
    TAnt(aL.Items[i]).SetStartCity(RandomRange(0,(mCfg.nC -1)));
  //move each ant until all cities have been visited
  for i := 1 to (mCfg.nC -1) do  begin
    for j := 0 to (mCfg.nA -1) do begin
      antMove:= TAnt(aL.Items[j]).move();
      //place the index of that ant to the appropriate location in the antCity List
      // location is [city number][the amount of ants at that city]
      antCityList[antMove][antCountList[antMove]] := j;
      //increment the counter corresponding to that city
      inc(antCountList[antMove]);
      Application.ProcessMessages;
      if(go = false) then exit;
    end;
    //after every ant has moved, share the paths of each ant with its fellows
    aMeet := Antennation()+ aMeet;
  end;
  for j:= 0 to (mCfg.nA -1) do
    TAnt(aL.Items[j]).MoveFinal();

  //lets do our local search technique
  
  LocalSearch();

  //update the pheromone map
  result := UpdatePheromone(mapUpdate);
end;



procedure TACOForm.LocalSearch;
var i,j: integer;
begin
  for i:= 0 to mCfg.nA -1 do begin //do each ant
    for j := 0 to mCfg.lSTimes-1 do begin  //do each time
      TAnt(aL.Items[i]).TwoOpt();
    end;
  end;
end;



{---------------------------------------------------------------------------------------------
-----------------WORK IN PROGRESS----------------------------------------------------------
---------------------------------------------------------------------------------------------}

procedure TACOForm.restartBtnClick(Sender: TObject);

var w, h: integer;
begin

  go := false;
  aL.Clear;
  gen := 0;
  bDist := MAXINT;
  bPath := nil;
  InitPher();
  BPrgsBar.Visible := false;
  ProgressLbl.Visible := false;

  w := MapImg.Width;
  h := MapImg.Height;
  BPrgsBar.Visible := false;
  mapImg.Canvas.Pen.Color := clWhite;  //draw the basic rectangle background
  mapImg.Canvas.Brush.Color := clWhite;
  mapImg.Canvas.Brush.Style := bsSolid;
  mapImg.Canvas.Rectangle(0,0,w,h);

  pChart.Series[0].Clear;
  pChart.Series[1].Clear;

  oneTourBtn.Enabled  := false;
  nTourBtn.Enabled    := false;

  runBtn.Enabled      := false;
  resetBtn.Enabled    := false;
  cityLbl.Caption := 'Number of cities:= '+IntToStr(mCfg.nC);
  distLbl.Caption := 'Distance := null';
  genLbl.Caption := 'Generations := ' +IntToStr(gen);
  PMenuSet.Enabled := false;
  OMenuBat.Enabled := false;
  
end;

function TACOForm.Antennation(): integer;
var city,i,j, ant1, ant2, antsMeet, total: integer;
  tree1, tree2: TTree;
begin
  setLength(tree1, mCfg.Nc);
  setLength(tree2, mCfg.Nc);
  for i := 0 to mCfg.nC -1 do begin
    setLength(tree1[i], mCfg.nC);
    setLength(tree2[i], mCfg.nC);
  end;

  total := 0;
  for city:= 0 to mCfg.nC -1 do begin //for the length of the cityCount array
    antsMeet := antCountList[city] -1;
    if (antsMeet > 0) then begin   //more than 1 ant on the city
      for i:= 0 to antsMeet -1 do begin
        //ant indexes are given by antCityList[city][j]
        ant1  := antCityList[city][i];
        tree1 := TAnt(aL.Items[ant1]).GetTree;
        for j:= i+1 to antsMeet do begin
          ant2 := antCityList[city][j];
          tree2 := TAnt(aL.Items[ant2]).GetTree;
          //time to swap trees
          TAnt(aL.Items[ant1]).AddTree(tree2);
          inc(total);
          TAnt(aL.Items[ant2]).AddTree(tree1);
          inc(total);
        end;
      end;
    end;
    for i:= 0 to antsMeet do
      TAnt(aL.Items[antCityList[city][i]]).Consolidate;
    antCountList[city] := 0; //reset to zero
  end;
  result := total;
end;

procedure TACOForm.AntenTypeRadGrpClick(Sender: TObject);
begin
  mCfg.aFType := AntenTypeRadGrp.ItemIndex;
end;


procedure TACOForm.AntFEditExit(Sender: TObject);
var temp: double;
begin
  if(TryStrToFloat(AntFEdit.Text, temp)) then begin
    mCfg.aF := temp;
    AntFEdit.Text := FloatToStr(mCfg.aF);
  end
  else begin
    ShowMessage('Error: Must be a number');
    AntFEdit.Text := FloatToStr(mCfg.aF);
  end;
end;

procedure TACOForm.PMenuLoadClick(Sender: TObject);
var  strs: TStringList;
  i: integer;
begin
	//open the file
	if tspOpen.Execute then begin
		strs := TStringList.Create;
		strs.LoadFromFile(tspOpen.FileName);

    LoadCities(strs);
		//read from file the number of cities,

    //initialise bestpath array
    setLength(bPath, mCfg.nC);

    //initialise antCountList
    //these 2 lengths do not change, only the antCityList[] changes
    setLength(antCountList, mCfg.nC);
    for i:= 0 to mCfg.Nc -1 do
      antCountList[i] := 0;
    setLength(antCityList, mCfg.nC);

    mCfg.lSType := LSEXP;

    bDist := MAXINT; //set to maximum size INTEGER can hold

    ChooseScale(MapImg);

    ResetBtn.Enabled := true;
    nTourBtn.Enabled := false;
    runBtn.Enabled  := false;
    oneTourBtn.Enabled := false;
    DrawMap(mapImg, bDist, bPath);
    CityLbl.Caption := 'Number of cities:= '+IntToStr(mCfg.nC);
    PMenuSet.Enabled := true;
    OMenuBat.Enabled := true;

	end;

end;

procedure TACOForm.OMenuBatClick(Sender: TObject);
var   batch: TBForm;
  fileName : string;
  totalIter: integer;
  iterStr: string;
  i, allDir, aFCount : integer;
begin
  batch := TBForm.Create(nil);
  batch.BatchInit;
  try
    //make the default value for the number of ants to be the city number
    if batch.ShowModal = mrOk then begin
      //bugger fields, just assume everything is correct

      RandSeed := batch.randSeedEdit.value;


      mBat.a := StrToInt(batch.AlphaEdit.Text);
      mBat.b := StrToInt(batch.BetaEdit.Text);
      mBat.numGen := StrToInt(batch.genEdit.Text);
      mBat.iteration := StrToInt(batch.iterEdit.Text);
      mBat.aFDir := batch.AntenDirRadGrp.ItemIndex;
      fileName := batch.txtNameEdit.Text;
      mBat.aLType := batch.AlgRadGrp.ItemIndex;
      mBat.aFType := batch.GetAFList();


      aFCount := 0;
      for i := 0 to CURRENT_AF_TYPES-1 do begin
        if(mBat.aFType[i] = true) then
          inc(aFCount);
      end;

      if mBat.aFDir = BOTH then
        allDir := 2
      else
        allDir := 1;
      //have to deal with all the algorithms
      case mBat.aLType of
        ACOAS: begin

          mBat.pAB := StrToFloat(batch.ASpaB.Text);
          mBat.pAS := StrToFloat(batch.ASpaS.Text);
          mBat.pAE := StrToFloat(batch.ASpaE.Text);

          mBat.pDB := StrToFloat(batch.ASpdB.Text);
          mBat.pDS := StrToFloat(batch.ASpdS.Text);
          mBat.pDE := StrToFloat(batch.ASpdE.Text);

          mBat.nAB := StrToInt(batch.ASnaB.Text);
          mBat.nAS := StrToInt(batch.ASnaS.Text);
          mBat.nAE := StrToInt(batch.ASnaE.Text);

          mBat.aFB := StrToFloat(batch.ASafB.Text);
          mBat.aFS := StrToFloat(batch.ASafS.Text);
          mBat.aFE := StrToFloat(batch.ASafE.Text);

          mBat.pIB := StrToFloat(batch.ASpiB.Text);
          mBat.pIS := StrToFloat(batch.ASpiS.Text);
          mBat.pIE := StrToFloat(batch.ASpiE.Text);

        end;
        ACOACS: begin

          mBat.pAB := StrToFloat(batch.ACSpaB.Text);
          mBat.pAS := StrToFloat(batch.ACSpaS.Text);
          mBat.pAE := StrToFloat(batch.ACSpaE.Text);

          mBat.pDB := StrToFloat(batch.ACSpdB.Text);
          mBat.pDS := StrToFloat(batch.ACSpdS.Text);
          mBat.pDE := StrToFloat(batch.ACSpdE.Text);

          mBat.nAB := StrToInt(batch.ACSnaB.Text);
          mBat.nAS := StrToInt(batch.ACSnaS.Text);
          mBat.nAE := StrToInt(batch.ACSnaE.Text);

          mBat.aFB := StrToFloat(batch.ACSafB.Text);
          mBat.aFS := StrToFloat(batch.ACSafS.Text);
          mBat.aFE := StrToFloat(batch.ACSafE.Text);

          mBat.pIB := StrToFloat(batch.ACSpiB.Text);
          mBat.pIS := StrToFloat(batch.ACSpiS.Text);
          mBat.pIE := StrToFloat(batch.ACSpiE.Text);

          mBat.gPB := StrToFloat(batch.ACSgpB.Text);
          mBat.gPS := StrToFloat(batch.ACSgpS.Text);
          mBat.gPE := StrToFloat(batch.ACSgpE.Text);

        end;
        ACOAMTS: begin
          mBat.pAB := StrToFloat(batch.AMTSpaB.Text);
          mBat.pAS := StrToFloat(batch.AMtSpaS.Text);
          mBat.pAE := StrToFloat(batch.AMtSpaE.Text);

          mBat.pDB := StrToFloat(batch.AMTSpdB.Text);
          mBat.pDS := StrToFloat(batch.AMTSpdS.Text);
          mBat.pDE := StrToFloat(batch.AMTSpdE.Text);

          mBat.nAB := StrToInt(batch.AMTSnaB.Text);
          mBat.nAS := StrToInt(batch.AMTSnaS.Text);
          mBat.nAE := StrToInt(batch.AMTSnaE.Text);

          mBat.aFB := StrToFloat(batch.AMTSafB.Text);
          mBat.aFS := StrToFloat(batch.AMTSafS.Text);
          mBat.aFE := StrToFloat(batch.AMTSafE.Text);

          mBat.pIB := StrToFloat(batch.AMTSpiB.Text);
          mBat.pIS := StrToFloat(batch.AMTSpiS.Text);
          mBat.pIE := StrToFloat(batch.AMTSpiE.Text);

          mBat.mAB := StrToInt(batch.AMTSmaB.Text);
          mBat.mAS := StrToInt(batch.AMTSmaS.Text);
          mBat.mAE := StrToInt(batch.AMTSmaE.Text);
        end;
        ACOMM: begin
          mBat.pAB := StrToFloat(batch.MMpaB.Text);
          mBat.pAS := StrToFloat(batch.MMpaS.Text);
          mBat.pAE := StrToFloat(batch.AMtSpaE.Text);

          mBat.pDB := StrToFloat(batch.MMpdB.Text);
          mBat.pDS := StrToFloat(batch.MMpdS.Text);
          mBat.pDE := StrToFloat(batch.MMpdE.Text);

          mBat.nAB := StrToInt(batch.MMnaB.Text);
          mBat.nAS := StrToInt(batch.MMnaS.Text);
          mBat.nAE := StrToInt(batch.MMnaE.Text);

          mBat.aFB := StrToFloat(batch.MMafB.Text);
          mBat.aFS := StrToFloat(batch.MMafS.Text);
          mBat.aFE := StrToFloat(batch.MMafE.Text);

          mBat.pIB := StrToFloat(batch.MMpiB.Text);
          mBat.pIS := StrToFloat(batch.MMpiS.Text);
          mBat.pIE := StrToFloat(batch.MMpiE.Text);

          mBat.igB := StrToFloat(batch.iterGlobalEdit.Text);
        end;
      end;

      //if checked, set end to start and step to 1, so only one run is done
      if(batch.PherAddCheck.Checked) then
        mBat.pAE := mBat.pAB;
      if(batch.PherDecayCheck.Checked) then
        mBat.pDE := mBat.pDB;
      if(batch.AntCheck.Checked) then
        mBat.nAE := mBat.nAB;
      if(batch.AntFacCheck.Checked) then
        mBat.aFE := mBat.aFB;
      if(batch.PherInitCheck.Checked) then
        mBat.pIE := mBat.pIB;
      if(batch.GreedCheck.Checked) then
        mBat.gPE := mBat.gPB;
      if(batch.AgeCheck.Checked) then
        mBat.mAE := mBat.mAB;


      //please note: must multiply by 1.000001 to push it over the value required for truncation
      //only there because Delphi is not that great with numbers
      totalIter := mBat.iteration * aFCount * allDir
      * Trunc((mBat.nAE+mBat.nAS*1.00001-mBat.nAB)/mBat.nAS)
      * Trunc((mBat.pAE+mBat.pAS*1.00001-mBat.pAB)/mBat.pAS)
      * Trunc((mBat.pIE+mBat.pIS*1.00001-mBat.pIB)/mBat.pIS)
      * Trunc((mBat.pDE+mBat.pDS*1.00001-mBat.pDB)/mBat.pDS)
      * Trunc((mBat.aFE+mBat.aFS*1.00001-mBat.aFB)/mBat.aFS);
      case mBat.aLType of
        ACOACS: totalIter := totalIter*Trunc((mBat.gPE+mBat.gPS*1.00001-mBat.gPB)/mBat.gPS);
        ACOAMTS: totalIter := totalIter*Trunc((mBat.mAE+mBat.mAS*1.00001-mBat.mAB)/mBat.mAS);
      end;

      iterStr := 'This batch run will take at least '+FloatToStr(totalIter)+
          ' iterations to complete: Continue?';
      if MessageDlg(iterStr, mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
        AntenTypeRadGrp.Enabled := false;
        AntenDirRadGrp.Enabled := false;
        AntFEdit.Enabled := false;
        //load basic settings
        mCfg.aLType := mBat.aLType;
        mCfg.a      := mBat.a;
        mCfg.b      := mBat.b;
        mCfg.aFDir  := mBat.aFDir;

        if batch.lSCheckBox.Checked = true then
          mCfg.lSTimes := batch.lSEdit.Value
        else
          mCfg.lSTimes := 0;

        case mBat.aLType of
          ACOAS:    ASBatch(fileName, totalIter);
          ACOACS:   ACSBatch(fileName, totalIter);
          ACOAMTS:  AMTSBatch(fileName, totalIter);
          ACOMM:    MMBatch(fileName, totalIter);
        end;
      end;
    end;
  	finally
    	batch.Release;
	end;
end;




procedure TACOForm.PMenuSetClick(Sender: TObject);
var settings: TSForm;
  i: integer;
begin
  settings := TSForm.Create(nil);
  settings.FormInit();
  settings.SetNumAntsEdit.Text := IntToStr(mCfg.nC);
  try
    //make the default value for the number of ants to be the city number
    if(settings.ShowModal = mrOk) then begin 
      mCfg.nA := StrToInt(settings.SetNumAntsEdit.Text);
      mCfg.aLType := settings.AlgRadGrp.ItemIndex;

      case mCfg.aLType of
        ACOAS:
        begin
          mCfg.a  := StrToInt(settings.ASAlphaEdit.Text);
          mCfg.b  := StrToInt(settings.ASBetaEdit.Text);
          mCfg.pI := StrToFloat(settings.ASPherInitEdit.Text);
          mCfg.pD := StrToFloat(settings.ASPherDecayEdit.Text);
          mCfg.pA := StrToFloat(settings.ASPherAddEdit.Text);
        end;

        ACOACS:
        begin
          mCfg.a  := StrToInt(settings.ACSAlphaEdit.Text);
          mCfg.b  := StrToInt(settings.ACSBetaEdit.Text);
          mCfg.pI := StrToFloat(settings.ACSPherInitEdit.Text);
          mCfg.pD := StrToFloat(settings.ACSPherDecayEdit.Text);
          mCfg.pA := StrToFloat(settings.ACSPherAddEdit.Text);
          mCfg.gP := StrToFloat(settings.ACSGreedyEdit.Text);
        end;

        ACOAMTS:
        begin
          mCfg.a  := StrToInt(settings.AMTSAlphaEdit.Text);
          mCfg.b  := StrToInt(settings.AMTSBetaEdit.Text);
          mCfg.pI := StrToFloat(settings.AMTSPherInitEdit.Text);
          mCfg.pD := StrToFloat(settings.AMTSPherDecayEdit.Text);
          mCfg.pA := StrToFloat(settings.AMTSPherAddEdit.Text);
          mCfg.mA := StrToInt(settings.AMTSAntLife.Text);
        end;

        ACOMM:
        begin
          mCfg.a  := StrToInt(settings.MMAlphaEdit.Text);
          mCfg.b  := StrToInt(settings.MMBetaEdit.Text);
          mCfg.pI := StrToFloat(settings.MMPherInitEdit.Text);
          mCfg.pD := StrToFloat(settings.MMPherDecayEdit.Text);
          mCfg.pA := StrToFloat(settings.MMPherAddEdit.Text);
          mCfg.igB := StrToFloat(settings.MMIterGlobalEdit.Text);
        end;
      end;

      FillNormalMemo();
      runBtn.Enabled := true;
      nTourBtn.Enabled := true;
      oneTourBtn.Enabled  := true;

      aL.Clear();
      InitPher();
      for i:= 0 to (mCfg.nA - 1) do aL.Add(TAnt.Create(i));
      for i:= 0 to (mCfg.nC - 1) do setLength(antCityList[i], mCfg.nA);

    end;
  finally
   	settings.Release();
	end;
end;



procedure TACOForm.FillNormalMemo();
begin
  SetMemo.Clear();
  case mCfg.aLType of
    ACOAS: begin
      setMemo.Lines.Add('ACO type: Ant Systems');
      setMemo.Lines.Add('');
      setMemo.Lines.Add('Alpha: ' + IntToStr(mCfg.a));
      setMemo.Lines.Add('Beta:  ' + IntToStr(mCfg.b));
      setMemo.Lines.Add('');
      setMemo.Lines.Add('Pheromone Added:   ' + FloatToStr(mCfg.pA));
      setMemo.Lines.Add('Pheromone Decay:   ' + FloatToStr(mCfg.pD));
      setMemo.Lines.Add('Pheromone Initial: ' + FloatToStr(mCfg.pI));

    end;
    ACOACS: begin
      setMemo.Lines.Add('ACO type: Ant Colony Systems');
      setMemo.Lines.Add('');
      setMemo.Lines.Add('Alpha: ' + IntToStr(mCfg.a));
      setMemo.Lines.Add('Beta:  ' + IntToStr(mCfg.b));
      setMemo.Lines.Add('');
      setMemo.Lines.Add('Pheromone Added:   ' + FloatToStr(mCfg.pA));
      setMemo.Lines.Add('Pheromone Decay:   ' + FloatToStr(mCfg.pD));
      setMemo.Lines.Add('Pheromone Initial: ' + FloatToStr(mCfg.pI));
      setMemo.Lines.Add('');
      setMemo.Lines.Add('Greedy Threshold: ' + FloatToStr(mCfg.gP));
    end;

    ACOAMTS: begin
      setMemo.Lines.Add('ACO type: Ant Multi Tour Systems');
      setMemo.Lines.Add('');
      setMemo.Lines.Add('Alpha: ' + IntToStr(mCfg.a));
      setMemo.Lines.Add('Beta:  ' + IntToStr(mCfg.b));
      setMemo.Lines.Add('');
      setMemo.Lines.Add('Pheromone Added:   ' + FloatToStr(mCfg.pA));
      setMemo.Lines.Add('Pheromone Decay:   ' + FloatToStr(mCfg.pD));
      setMemo.Lines.Add('Pheromone Initial: ' + FloatToStr(mCfg.pI));
      setMemo.Lines.Add('');
      setMemo.Lines.Add('Maximum age: ' + IntToStr(mCfg.mA));
    end;

    ACOMM: begin
      setMemo.Lines.Add('ACO type: Ant Multi Tour Systems');
      setMemo.Lines.Add('');
      setMemo.Lines.Add('Alpha: ' + IntToStr(mCfg.a));
      setMemo.Lines.Add('Beta:  ' + IntToStr(mCfg.b));
      setMemo.Lines.Add('');
      setMemo.Lines.Add('Pheromone Added:   ' + FloatToStr(mCfg.pA));
      setMemo.Lines.Add('Pheromone Decay:   ' + FloatToStr(mCfg.pD));
      setMemo.Lines.Add('Pheromone Initial: ' + FloatToStr(mCfg.pI));
      setMemo.Lines.Add('Pheromone Maximum: ' + FloatToStr(mCfg.pMX));
      setMemo.Lines.Add('Pheromone Minimum: ' + FloatToStr(mCfg.pMN));
    end;
  end;
end;

procedure TACOForm.FillBatchMemo();
begin
  SetMemo.Clear();
  case mCfg.aLType of
    ACOAS: begin
      setMemo.Lines.Add('ACO type: Ant Systems');
      setMemo.Lines.Add('');
      setMemo.Lines.Add('Alpha: ' + IntToStr(mCfg.a));
      setMemo.Lines.Add('Beta:  ' + IntToStr(mCfg.b));
      setMemo.Lines.Add('');
      setMemo.Lines.Add('PA: '+FloatToStr(mBat.pAB)+'<->'+FloatToStr(mBat.pAE)+', by '+FloatToStr(mBat.pAS));
      setMemo.Lines.Add('PD: '+FloatToStr(mBat.pDB)+'<->'+FloatToStr(mBat.pDE)+', by '+FloatToStr(mBat.pDS));
      setMemo.Lines.Add('PI: '+FloatToStr(mBat.pIB)+'<->'+FloatToStr(mBat.pIE)+', by '+FloatToStr(mBat.pIS));
      setMemo.Lines.Add('AF: '+FloatToStr(mBat.aFB)+'<->'+FloatToStr(mBat.aFE)+', by '+FloatToStr(mBat.aFS));

    end;
    ACOACS: begin
      setMemo.Lines.Add('ACO type: Ant Colony Systems');
      setMemo.Lines.Add('');
      setMemo.Lines.Add('Alpha: ' + IntToStr(mCfg.a));
      setMemo.Lines.Add('Beta:  ' + IntToStr(mCfg.b));
      setMemo.Lines.Add('');
      setMemo.Lines.Add('PA: '+FloatToStr(mBat.pAB)+'<->'+FloatToStr(mBat.pAE)+', by '+FloatToStr(mBat.pAS));
      setMemo.Lines.Add('PD: '+FloatToStr(mBat.pDB)+'<->'+FloatToStr(mBat.pDE)+', by '+FloatToStr(mBat.pDS));
      setMemo.Lines.Add('PI: '+FloatToStr(mBat.pIB)+'<->'+FloatToStr(mBat.pIE)+', by '+FloatToStr(mBat.pIS));
      setMemo.Lines.Add('AF: '+FloatToStr(mBat.aFB)+'<->'+FloatToStr(mBat.aFE)+', by '+FloatToStr(mBat.aFS));
      setMemo.Lines.Add('');
      setMemo.Lines.Add('GP: '+FloatToStr(mBat.gpB)+'<->'+FloatToStr(mBat.gpE)+', by '+FloatToStr(mBat.gpS));
    end;

    ACOAMTS: begin
      setMemo.Lines.Add('ACO type: Ant Multi Tour Systems');
      setMemo.Lines.Add('');
      setMemo.Lines.Add('Alpha: ' + IntToStr(mCfg.a));
      setMemo.Lines.Add('Beta:  ' + IntToStr(mCfg.b));
      setMemo.Lines.Add('');
      setMemo.Lines.Add('PA: '+FloatToStr(mBat.pAB)+'<->'+FloatToStr(mBat.pAE)+', by '+FloatToStr(mBat.pAS));
      setMemo.Lines.Add('PD: '+FloatToStr(mBat.pDB)+'<->'+FloatToStr(mBat.pDE)+', by '+FloatToStr(mBat.pDS));
      setMemo.Lines.Add('PI: '+FloatToStr(mBat.pIB)+'<->'+FloatToStr(mBat.pIE)+', by '+FloatToStr(mBat.pIS));
      setMemo.Lines.Add('AF: '+FloatToStr(mBat.aFB)+'<->'+FloatToStr(mBat.aFE)+', by '+FloatToStr(mBat.aFS));
      setMemo.Lines.Add('');
      setMemo.Lines.Add('MA: '+IntToStr(mBat.mAB)+'<->'+IntToStr(mBat.mAE)+', by '+IntToStr(mBat.mAS));
    end;

    ACOMM: begin
      setMemo.Lines.Add('ACO type: MAXMIN Ant Systems');
      setMemo.Lines.Add('');
      setMemo.Lines.Add('Alpha: ' + IntToStr(mCfg.a));
      setMemo.Lines.Add('Beta:  ' + IntToStr(mCfg.b));
      setMemo.Lines.Add('');
      setMemo.Lines.Add('PA: '+FloatToStr(mBat.pAB)+'<->'+FloatToStr(mBat.pAE)+', by '+FloatToStr(mBat.pAS));
      setMemo.Lines.Add('PD: '+FloatToStr(mBat.pDB)+'<->'+FloatToStr(mBat.pDE)+', by '+FloatToStr(mBat.pDS));
      setMemo.Lines.Add('PI: '+FloatToStr(mBat.pIB)+'<->'+FloatToStr(mBat.pIE)+', by '+FloatToStr(mBat.pIS));
      setMemo.Lines.Add('AF: '+FloatToStr(mBat.aFB)+'<->'+FloatToStr(mBat.aFE)+', by '+FloatToStr(mBat.aFS));
      setMemo.Lines.Add('');
    end;
  end;
  setMemo.Lines.Add('');
  setMemo.Lines.Add('Antennation Type : '+GetAntType(mCfg.aFType));
  setMemo.Lines.Add('');

  if mCfg.aFDir = UNI then
    setMemo.Lines.Add('Antennation Direction: Unidirectional')
  else if mCfg.aFDir = BI then
    setMemo.Lines.Add('Antennation Direction: Bidirectional');

end;

procedure TACOForm.ACSBatch(filename: string; totalIter: integer);
var antL, iterL, curGen, i,j, curProgress: integer;
    pAL,pDL,aFL, pIL, gPL: double;
    totalAMeetCount, runAMeetCount, genCount, avgDist: double;
    txt: TextFile;
    topPaths : array of TPathRec;
    tp1, tp2 : TPathRec;
begin
  if FileExists(fileName) then
    if (MessageDlg('File ' + FileName + ' exists. Overwrite?', mtConfirmation,
        [mbOk, mbCancel], 0) = mrCancel) then
        Exit;
  go := true;
  toggleBtns();

  FillBatchMemo();

  curProgress := 0;
  setLength(topPaths,3);

  BPrgsBar.Min        := 0;
  BPrgsBar.Max        := totalIter;
  BPrgsBar.Position   := curProgress;
  BPrgsBar.Visible    := true;
  ProgressLbl.Visible := true;
  ProgressLbl.Caption := 'Batch Percentage Complete: '+FloatToStr(100.0*curProgress/totalIter)+'%';
  ACOForm.Refresh;
  AssignFile(txt, fileName);
  Rewrite(txt);
  WriteLn(txt,'BatchFile test, number of cities :=' +IntToStr(mCfg.nC));
  WriteLn(txt,'ACS Algorithm - LSType '+GetLSType(mCfg.lSType) + ' Times = '+IntToStr(mCfg.lSTimes));
  WriteLn(txt,'Format:');
  WriteLn(txt,'avgGen avgdist DP AP IP NA AF GP Path1D Path1C Path2D Path2C Path3D Path3C ANTMEET');
  // 8 loops- AFTYPE, DIRTYPE,  number of ants, add P, decay P, init P, AntF, Iterations

  //Start off with AFTYPE
  for j := 0 to CURRENT_AF_TYPES - 1 do begin
  if(mBat.aFType[j] = true) then begin
    mCfg.aFType := j;
    WriteLn(txt,'AntType = '+GetAntType(mCfg.aFType));

    //now do AFDIR
    if mBat.aFDir = BOTH then
      mCfg.aFDir := BI
    else
      mCfg.aFDir := mBat.aFDir;

    while(mCfg.aFDir <> BOTH) do begin
      WriteLn(txt,'AntDir = '+GetAntDir(mCfg.aFDir));
     // now the number of ants
      antL := mBat.nAB;
      RandSeed := 100; //reset random seed

      while(antL <= mBat.nAE) do begin  //ANT LOOP
        aL.Clear; //delete all ant objects - may be a memory leak
        //time to set the length of the antCityList and populate the aL object list
        for i := 0 to antL -1 do
          aL.Add(TAnt.Create(i));
        for i := 0 to mCfg.nC -1 do
          setLength(antCityList[i], antL);

        gPL := mBat.gPB;
        while(gPL <= mBat.gPE) do begin //GREED PROB LOOP
          pAL := mBat.pAB;
          while(pAL <= mBat.pAE) do begin   //PHER ADD LOOP
            pDL := mBat.pDB;
            while(pDL <= mBat.pDE) do begin  //PHER DECAY LOOP
              pIL := mBat.pIB;
              while(pIL <= mBat.pIE) do begin //PHER INIT LOOP
                aFL := mBat.aFB;
                while (aFL <= mBat.aFE) do begin //ANTENNATION LOOP
 {-----------------------------------------------------------------------------
 -----------------------testing loop------------------------------------------
 -----------------------------------------------------------------------------}
mCfg.nA := antL;
mCfg.pA := pAL;
mCfg.pD := pDL;
mCfg.aF := aFL;
mCfg.pI := pIL;
mCfg.gP := gPL;

iterL:= 0; genCount:= 0; avgDist:= 0; totalAMeetCount:= 0;
for i:= Low(TopPaths) to High(topPaths) do begin
  topPaths[i].d := MAXINT;
  topPaths[i].c := 0;
end;

while(iterL < mBat.iteration) do begin
  curGen := 0;
  runAMeetCount := 0;
  gen := 0;
///STARTING AN ITERATION
  InitPher();
  while(curGen <= mBat.numGen) do begin
  //if the tour does return a better path, reset curGen to zero else inc
    if(oneTour(false)) then curGen:= 0 else inc(curGen);
    runAMeetCount := runAMeetCount + aMeet;
  end;
  totalAMeetCount := totalAMeetCount + runAMeetcount/gen; //average meetings per generation
  genCount := genCount + gen - curGen;
  avgDist := avgDist + bDist;

  tp1.d := bDist;
  tp1.c := 1;

//need to check if path obtained is in 1st 2nd or 3rd path, can extend for as many as you want
//holy lord this will be complicated :(
//to hell with it, use the bubble method
  for i := 0 to High(topPaths) do begin
    if(tp1.d < topPaths[i].d) then begin
      tp2 := topPaths[i];          //have to
      topPaths[i] := tp1;
      tp1 := tp2
    end
    else if tp1.d = topPaths[i].d then begin
      tp1.d := MAXINT;
      inc(topPaths[i].c);
    end;
  end;
  bDist := MAXINT; //reset the best distance to the maximum integer possible
  inc(iterL);
  IterNumLbl.Caption := IntToStr(curProgress + iterL)+'/'+IntToStr(totalIter);
  ACOForm.Refresh;
end;

///FINISHING AN ITERATION
genCount := genCount/mBat.iteration;
avgDist := avgDist/mBat.iteration;
totalAMeetCount := totalAMeetCount/mBat.iteration;

//updating progress bar
curProgress := curProgress + mBat.iteration;
BPrgsBar.Position := curProgress;
ProgressLbl.Caption := 'Batch Percentage Complete: '+FloatToStr(Round(100*curProgress/totalIter))+'%';
ACOForm.Refresh;

//time to write out to the file
WriteLn(txt,FloatToStr(genCount)+' '+FloatToStr(avgDist)+' '
      +FloatToStr(pDL)+' '+FloatToStr(pAL)+' '+FloatToStr(pIL)+' '
      +IntToStr(antL)+' '+FloatToStr(aFL)+' '+FloatToStr(gPL)+' '
      +IntToStr(topPaths[0].d)+' '+IntToStr(topPaths[0].c)+' '
      +IntToStr(topPaths[1].d)+' '+IntToStr(topPaths[1].c)+' '
      +IntToStr(topPaths[2].d)+' '+IntToStr(topPaths[2].c)+' '
      +FloatToStr(totalAMeetCount));

aFL := aFL + mBat.aFS
{-------------------------------------------------------------------------------
-----------------------Finished batch section ----------------------------------
-------------------------------------------------------------------------------}
                end;  //ENDING ANTENNATION LOOP
                pIL := pIL + mBat.pIS;
              end;  //ENDING PHER INITIAL LOOP
              pDL := pDL + mBat.pDS;
            end;  //ENDING PHER DECAY LOOP
            pAL := pAL + mBat.pAS;
          end;  //ENDING PHER ADD LOOP
          gPL := gPL + mBat.gPS;
        end;  //ENDING GREED PROB LOOP
        antL := antL + mBat.nAS;
      end; //ENDING ANT LOOP
      WriteLn(txt,'');
      if mBat.aFDir <> BOTH then
        mCfg.aFDir := BOTH
      else
        inc(mCfg.aFDir);
    end;//ENDING AF DIRECTION LOOP
    WriteLn(txt, '');

  end;//ENDING AF CHECKED LOOP
  end; //ENDING AF TYPE LOOP
  toggleBtns();
  CloseFile(txt);

end;

procedure TACOForm.AMTSBatch(filename: string; totalIter: integer);

var antL, mAL, iterL, curGen, i,j, curProgress: integer;
    pAL,pDL,aFL, pIL: double;
    totalAMeetCount, runAMeetCount, genCount, avgDist: double;
    txt: TextFile;
    topPaths : array of TPathRec;
    tp1, tp2 : TPathRec;
begin
  if FileExists(fileName) then
    if (MessageDlg('File ' + FileName + ' exists. Overwrite?', mtConfirmation,
        [mbOk, mbCancel], 0) = mrCancel) then
        Exit;
  go := true;
  toggleBtns();

  FillBatchMemo();

  curProgress := 0;
  setLength(topPaths,3);

  BPrgsBar.Min        := 0;
  BPrgsBar.Max        := totalIter;
  BPrgsBar.Position   := curProgress;
  BPrgsBar.Visible    := true;
  ProgressLbl.Visible := true;
  ProgressLbl.Caption := 'Batch Percentage Complete: '+FloatToStr(100.0*curProgress/totalIter)+'%';
  ACOForm.Refresh;
  AssignFile(txt, fileName);
  Rewrite(txt);
  WriteLn(txt,'BatchFile test, number of cities :=' +IntToStr(mCfg.nC));
  WriteLn(txt,'AMTS Algorithm - LSType '+GetLSType(mCfg.lSType) + ' Times = '+IntToStr(mCfg.lSTimes));
  WriteLn(txt,'Format:');
  WriteLn(txt,'avgGen avgdist DP AP IP NA AF MA Path1D Path1C Path2D Path2C Path3D Path3C ANTMEET');
  // 9 loops- AFTYPE, AFDIR ,number of ants, max age, add P, decay P, init P, AntF, Iterations


  //Start off with AFTYPE
  for j := 0 to CURRENT_AF_TYPES - 1 do begin
  if(mBat.aFType[j] = true) then begin
    mCfg.aFType := j;
    WriteLn(txt,'AntType = '+GetAntType(mCfg.aFType));

    //now do AFDIR
    if mBat.aFDir = BOTH then
      mCfg.aFDir := BI
    else
      mCfg.aFDir := mBat.aFDir;

    while(mCfg.aFDir <> BOTH) do begin
      WriteLn(txt,'AntDir = '+GetAntDir(mCfg.aFDir));

    // start of with the number of ants
      antL := mBat.nAB;
      while(antL <= mBat.nAE) do begin  //ANT LOOP
        aL.Clear; //delete all ant objects - may be a memory leak
        //time to set the length of the antCityList and populate the aL object list
        for i := 0 to antL -1 do
          aL.Add(TAnt.Create(i));
        for i := 0 to mCfg.nC -1 do
          setLength(antCityList[i], antL);

        mAL := mBat.mAB;
        while(mAL <= mBat.mAE) do begin //MAX AGE LOOP
          pAL := mBat.pAB;
          while(pAL <= mBat.pAE) do begin   //PHER ADD LOOP
            pDL := mBat.pDB;
            while(pDL <= mBat.pDE) do begin  //PHER DECAY LOOP
              pIL := mBat.pIB;
              while(pIL <= mBat.pIE) do begin //PHER INIT LOOP
                aFL := mBat.aFB;
                while (aFL <= mBat.aFE) do begin //ANTENNATION LOOP
 {-----------------------------------------------------------------------------
 -----------------------testing loop------------------------------------------
 -----------------------------------------------------------------------------}
  mCfg.nA := antL;
  mCfg.pA := pAL;
  mCfg.pD := pDL;
  mCfg.aF := aFL;
  mCfg.pI := pIL;
  mCfg.mA := mAL;

  iterL:= 0; genCount:= 0; avgDist:= 0; totalAMeetCount:= 0;
  for i:= Low(TopPaths) to High(topPaths) do begin
    topPaths[i].d := MAXINT;
    topPaths[i].c := 0;
  end;

  while(iterL < mBat.iteration) do begin
    curGen := 0;
    runAMeetCount := 0;
    gen := 0;
  ///STARTING AN ITERATION
    InitPher();
    while(curGen <= mBat.numGen) do begin
    //if the tour does return a better path, reset curGen to zero else inc
      if(oneTour(false)) then curGen:= 0 else inc(curGen);
      runAMeetCount := runAMeetCount + aMeet;
    end;
    totalAMeetCount := totalAMeetCount + runAMeetcount/gen; //average meetings per generation
    genCount := genCount + gen - curGen;
    avgDist := avgDist + bDist;

    tp1.d := bDist;
    tp1.c := 1;

  //need to check if path obtained is in 1st 2nd or 3rd path, can extend for as many as you want
  //holy lord this will be complicated :(
  //to hell with it, use the bubble method
    for i := 0 to High(topPaths) do begin
      if(tp1.d < topPaths[i].d) then begin
        tp2 := topPaths[i];          //have to
        topPaths[i] := tp1;
        tp1 := tp2
      end
      else if tp1.d = topPaths[i].d then begin
        tp1.d := MAXINT;
        inc(topPaths[i].c);
      end;
    end;
    bDist := MAXINT; //reset the best distance to the maximum integer possible
    inc(iterL);
    IterNumLbl.Caption := IntToStr(curProgress + iterL)+'/'+IntToStr(totalIter);
    ACOForm.Refresh;
  end;

  ///FINISHING AN ITERATION
  genCount := genCount/mBat.iteration;
  avgDist := avgDist/mBat.iteration;
  totalAMeetCount := totalAMeetCount/mBat.iteration;

  //updating progress bar
  curProgress := curProgress + mBat.iteration;
  BPrgsBar.Position := curProgress;
  ProgressLbl.Caption := 'Batch Percentage Complete: '+FloatToStr(Round(100*curProgress/totalIter))+'%';
  ACOForm.Refresh;

  //time to write out to the file
  WriteLn(txt,FloatToStr(genCount)+' '+FloatToStr(avgDist)+' '
        +FloatToStr(pDL)+' '+FloatToStr(pAL)+' '+FloatToStr(pIL)+' '
        +IntToStr(antL)+' '+FloatToStr(aFL)+' '+IntToStr(mAL)+' '
        +IntToStr(topPaths[0].d)+' '+IntToStr(topPaths[0].c)+' '
        +IntToStr(topPaths[1].d)+' '+IntToStr(topPaths[1].c)+' '
        +IntToStr(topPaths[2].d)+' '+IntToStr(topPaths[2].c)+' '
        +FloatToStr(totalAMeetCount));
{-----------------------------------------------------------------------------
 -----------------------end testing loop----------------------------------------
 -----------------------------------------------------------------------------}
                  aFL := aFL + mBat.aFS
                end;  //ENDING ANTENNATION LOOP
                pIL := pIL + mBat.pIS;
              end;  //ENDING PHER INITIAL LOOP
              pDL := pDL + mBat.pDS;
            end;  //ENDING PHER DECAY LOOP
            pAL := pAL + mBat.pAS;
          end;  //ENDING PHER ADD LOOP
          mAL := mAL + mBat.mAS;
        end;  //ENDING MAX AGE LOOP
        antL := antL + mBat.nAS;
      end; //ENDING ANT LOOP
      WriteLn(txt,'');
      if mBat.aFDir <> BOTH then
        mCfg.aFDir := BOTH
      else
        inc(mCfg.aFDir);
    end;//ENDING AF DIRECTION LOOP
    WriteLn(txt, '');

  end;//ENDING AF CHECKED LOOP
  end; //ENDING AF TYPE LOOP
  toggleBtns();
  CloseFile(txt);
end;

procedure TACOForm.ASBatch(filename: string; totalIter: integer);

var antL, iterL, curGen, i,j, curProgress: integer;
    pAL,pDL,aFL, pIL: double;
    totalAMeetCount, runAMeetCount, genCount, avgDist: double;
    txt: TextFile;
    topPaths : array of TPathRec;
    tp1, tp2 : TPathRec;
begin
  if FileExists(fileName) then
    if (MessageDlg('File ' + FileName + ' exists. Overwrite?', mtConfirmation,
        [mbOk, mbCancel], 0) = mrCancel) then
        Exit;
  go := true;
  toggleBtns();

  FillBatchMemo();

  curProgress := 0;
  setLength(topPaths,3);

  BPrgsBar.Min        := 0;
  BPrgsBar.Max        := totalIter;
  BPrgsBar.Position   := curProgress;
  BPrgsBar.Visible    := true;
  ProgressLbl.Visible := true;
  ProgressLbl.Caption := 'Batch Percentage Complete: '+FloatToStr(100.0*curProgress/totalIter)+'%';
  ACOForm.Refresh;
  AssignFile(txt, fileName);
  Rewrite(txt);
  WriteLn(txt,'BatchFile test, number of cities :=' +IntToStr(mCfg.nC));
  WriteLn(txt,'AS Algorithm - LSType '+GetLSType(mCfg.lSType) + ' Times = '+IntToStr(mCfg.lSTimes));
  WriteLn(txt,'Format:');
  WriteLn(txt,'avgGen avgdist DP AP IP NA AF Path1D Path1C Path2D Path2C Path3D Path3C ANTMEET');
  // 8 loops- AFTYPE, AFDIR, number of ants, add P, decay P, init P, AntF, Iterations
  // start of with the number of ants
  //Start off with AFTYPE

  for j := 0 to CURRENT_AF_TYPES - 1 do begin
  if(mBat.aFType[j] = true) then begin
    mCfg.aFType := j;
    WriteLn(txt,'AntType = '+GetAntType(mCfg.aFType));

    //now do AFDIR
    if mBat.aFDir = BOTH then
      mCfg.aFDir := BI
    else
      mCfg.aFDir := mBat.aFDir;

    while(mCfg.aFDir <> BOTH) do begin
      WriteLn(txt,'AntDir = '+GetAntDir(mCfg.aFDir));

      antL := mBat.nAB;
      while(antL <= mBat.nAE) do begin  //ANT LOOP
        aL.Clear; //delete all ant objects - may be a memory leak
        //time to set the length of the antCityList and populate the aL object list
        for i := 0 to antL -1 do
          aL.Add(TAnt.Create(i));
        for i := 0 to mCfg.nC -1 do
          setLength(antCityList[i], antL);

        pAL := mBat.pAB;
        while(pAL <= mBat.pAE) do begin   //PHER ADD LOOP
          pDL := mBat.pDB;
          while(pDL <= mBat.pDE) do begin  //PHER DECAY LOOP
            pIL := mBat.pIB;
            while(pIL <= mBat.pIE) do begin //PHER INIT LOOP
              aFL := mBat.aFB;
              while (aFL <= mBat.aFE) do begin //ANTENNATION LOOP
 {-----------------------------------------------------------------------------
 -----------------------testing loop------------------------------------------
 -----------------------------------------------------------------------------}
  mCfg.nA := antL;
  mCfg.pA := pAL;
  mCfg.pD := pDL;
  mCfg.aF := aFL;
  mCfg.pI := pIL;

  iterL:= 0; genCount:= 0; avgDist:= 0; totalAMeetCount:= 0;
  for i:= Low(TopPaths) to High(topPaths) do begin
    topPaths[i].d := MAXINT;
    topPaths[i].c := 0;
  end;

  while(iterL < mBat.iteration) do begin
    curGen := 0;
    runAMeetCount := 0;
    gen := 0;
    ///STARTING AN ITERATION
    InitPher();
    while(curGen <= mBat.numGen) do begin
      //if the tour does return a better path, reset curGen to zero else inc
      if(oneTour(false)) then curGen:= 0 else inc(curGen);
      runAMeetCount := runAMeetCount + aMeet;
    end;
    totalAMeetCount := totalAMeetCount + runAMeetcount/gen; //average meetings per generation
    genCount := genCount + gen - curGen;
    avgDist := avgDist + bDist;

    tp1.d := bDist;
    tp1.c := 1;

    //need to check if path obtained is in 1st 2nd or 3rd path, can extend for as many as you want
    //holy lord this will be complicated :(
    //to hell with it, use the bubble method
    for i := 0 to High(topPaths) do begin
      if(tp1.d < topPaths[i].d) then begin
        tp2 := topPaths[i];          //have to
        topPaths[i] := tp1;
        tp1 := tp2
      end
      else if tp1.d = topPaths[i].d then begin
        tp1.d := MAXINT;
        inc(topPaths[i].c);
      end;
    end;
    bDist := MAXINT; //reset the best distance to the maximum integer possible
   inc(iterL);
   IterNumLbl.Caption := IntToStr(curProgress + iterL)+'/'+IntToStr(totalIter);
   ACOForm.Refresh;
  end;

  ///FINISHING AN ITERATION
  genCount := genCount/mBat.iteration;
  avgDist := avgDist/mBat.iteration;
  totalAMeetCount := totalAMeetCount/mBat.iteration;

  //updating progress bar
  curProgress := curProgress + mBat.iteration;
  BPrgsBar.Position := curProgress;
  ProgressLbl.Caption := 'Batch Percentage Complete: '+FloatToStr(Round(100*curProgress/totalIter))+'%';
  ACOForm.Refresh;

  //time to write out to the file
  WriteLn(txt,FloatToStr(genCount)+' '+FloatToStr(avgDist)+' '
          +FloatToStr(pDL)+' '+FloatToStr(pAL)+' '+FloatToStr(pIL)+' '
          +IntToStr(antL)+' '+FloatToStr(aFL)+' '
          +IntToStr(topPaths[0].d)+' '+IntToStr(topPaths[0].c)+' '
          +IntToStr(topPaths[1].d)+' '+IntToStr(topPaths[1].c)+' '
          +IntToStr(topPaths[2].d)+' '+IntToStr(topPaths[2].c)+' '
          +FloatToStr(totalAMeetCount));

  aFL := aFL + mBat.aFS
 {-----------------------------------------------------------------------------
 -----------------------end testing loop----------------------------------------
 -----------------------------------------------------------------------------}
              end;  //ENDING ANTENNATION LOOP
              pIL := pIL + mBat.pIS;
            end;  //ENDING PHER INITIAL LOOP
            pDL := pDL + mBat.pDS;
          end;  //ENDING PHER DECAY LOOP
          pAL := pAL + mBat.pAS;
        end;  //ENDING PHER ADD LOOP
        antL := antL + mBat.nAS;
      end; //ending ant loop
        WriteLn(txt,'');
      if mBat.aFDir <> BOTH then
        mCfg.aFDir := BOTH
      else
        inc(mCfg.aFDir);
    end;//ENDING AF DIRECTION LOOP
    WriteLn(txt, '');

  end;//ENDING AF CHECKED LOOP
  end; //ENDING AF TYPE LOOP
  toggleBtns();
  CloseFile(txt);

end;

procedure TACOForm.MMBatch(filename: string; totalIter: integer);
var antL, iterL, curGen, i,j, curProgress: integer;
    pAL,pDL,aFL, pIL: double;
    totalAMeetCount, runAMeetCount, genCount, avgDist: double;
    txt: TextFile;
    topPaths : array of TPathRec;
    tp1, tp2 : TPathRec;
begin
  if FileExists(fileName) then
    if (MessageDlg('File ' + FileName + ' exists. Overwrite?', mtConfirmation,
        [mbOk, mbCancel], 0) = mrCancel) then
        Exit;
  go := true;
  toggleBtns();

  mCfg.igB    := mBat.igB;
  FillBatchMemo();
  curProgress := 0;
  setLength(topPaths,3);

  BPrgsBar.Min        := 0;
  BPrgsBar.Max        := totalIter;
  BPrgsBar.Position   := curProgress;
  BPrgsBar.Visible    := true;
  ProgressLbl.Visible := true;
  ProgressLbl.Caption := 'Batch Percentage Complete: '+FloatToStr(100.0*curProgress/totalIter)+'%';
  ACOForm.Refresh;
  AssignFile(txt, fileName);
  Rewrite(txt);
  WriteLn(txt,'BatchFile test, number of cities :=' +IntToStr(mCfg.nC));
  WriteLn(txt,'ACS Algorithm - LSType '+GetLSType(mCfg.lSType) + ' Times = '+IntToStr(mCfg.lSTimes));
  WriteLn(txt,'Format:');
  WriteLn(txt,'avgGen avgdist DP AP IP NA AF Path1D Path1C Path2D Path2C Path3D Path3C ANTMEET');
  // 8 loops- AFTYPE, AFDIR, number of ants, add P, decay P, init P, AntF, Iterations
  // start of with the number of ants

  for j := 0 to CURRENT_AF_TYPES - 1 do begin
  if(mBat.aFType[j] = true) then begin
    mCfg.aFType := j;
    WriteLn(txt,'AntType = '+GetAntType(mCfg.aFType));

    //now do AFDIR
    if mBat.aFDir = BOTH then
      mCfg.aFDir := BI
    else
      mCfg.aFDir := mBat.aFDir;

    while(mCfg.aFDir <> BOTH) do begin
      WriteLn(txt,'AntDir = '+GetAntDir(mCfg.aFDir));

      antL := mBat.nAB;
      while(antL <= mBat.nAE) do begin  //ANT LOOP
        aL.Clear; //delete all ant objects - may be a memory leak
        //time to set the length of the antCityList and populate the aL object list
        for i := 0 to antL -1 do
          aL.Add(TAnt.Create(i));
        for i := 0 to mCfg.nC -1 do
          setLength(antCityList[i], antL);
        pAL := mBat.pAB;
        while(pAL <= mBat.pAE) do begin   //PHER ADD LOOP
          pDL := mBat.pDB;
          while(pDL <= mBat.pDE) do begin  //PHER DECAY LOOP
            pIL := mBat.pIB;
            while(pIL <= mBat.pIE) do begin //PHER INIT LOOP
              aFL := mBat.aFB;
              while (aFL <= mBat.aFE) do begin //ANTENNATION LOOP
 {-----------------------------------------------------------------------------
 -----------------------testing loop------------------------------------------
 -----------------------------------------------------------------------------}
  mCfg.nA   := antL;
  mCfg.pA   := pAL;
  mCfg.pD   := pDL;
  mCfg.aF   := aFL;
  mCfg.pI   := pIL;

  iterL:= 0; genCount:= 0; avgDist:= 0; totalAMeetCount:= 0;
  for i:= Low(TopPaths) to High(topPaths) do begin
    topPaths[i].d := MAXINT;
    topPaths[i].c := 0;
  end;

  while(iterL < mBat.iteration) do begin
    curGen := 0;
    runAMeetCount := 0;
    gen := 0;
  ///STARTING AN ITERATION
    InitPher();
    while(curGen <= mBat.numGen) do begin
  //if the tour does return a better path, reset curGen to zero else inc
      if(oneTour(false)) then curGen:= 0 else inc(curGen);
      runAMeetCount := runAMeetCount + aMeet;
    end;
    totalAMeetCount := totalAMeetCount + runAMeetcount/gen; //average meetings per generation
    genCount := genCount + gen - curGen;
    avgDist := avgDist + bDist;

    tp1.d := bDist;
    tp1.c := 1;

  //need to check if path obtained is in 1st 2nd or 3rd path, can extend for as many as you want
  //holy lord this will be complicated :(
  //to hell with it, use the bubble method
    for i := 0 to High(topPaths) do begin
      if(tp1.d < topPaths[i].d) then begin
        tp2 := topPaths[i];          //have to
        topPaths[i] := tp1;
        tp1 := tp2
      end
      else if tp1.d = topPaths[i].d then begin
        tp1.d := MAXINT;
        inc(topPaths[i].c);
      end;
    end;
    bDist := MAXINT; //reset the best distance to the maximum integer possible
    inc(iterL);
    IterNumLbl.Caption := IntToStr(curProgress + iterL)+'/'+IntToStr(totalIter);
    ACOForm.Refresh;
  end;

  ///FINISHING AN ITERATION
  genCount := genCount/mBat.iteration;
  avgDist := avgDist/mBat.iteration;
  totalAMeetCount := totalAMeetCount/mBat.iteration;

  //updating progress bar
  curProgress := curProgress + mBat.iteration;
  BPrgsBar.Position := curProgress;
  ProgressLbl.Caption := 'Batch Percentage Complete: '+FloatToStr(Round(100*curProgress/totalIter))+'%';
  ACOForm.Refresh;

  //time to write out to the file
  WriteLn(txt,FloatToStr(genCount)+' '+FloatToStr(avgDist)+' '
      +FloatToStr(pDL)+' '+FloatToStr(pAL)+' '+FloatToStr(pIL)+' '
      +IntToStr(antL)+' '+FloatToStr(aFL)+' '
      +IntToStr(topPaths[0].d)+' '+IntToStr(topPaths[0].c)+' '
      +IntToStr(topPaths[1].d)+' '+IntToStr(topPaths[1].c)+' '
      +IntToStr(topPaths[2].d)+' '+IntToStr(topPaths[2].c)+' '
      +FloatToStr(totalAMeetCount));

  aFL := aFL + mBat.aFS
{-----------------------------------------------------------------------------
 -----------------------end testing loop----------------------------------------
 -----------------------------------------------------------------------------}

              end;  //ENDING ANTENNATION LOOP
              pIL := pIL + mBat.pIS;
            end;  //ENDING PHER INITIAL LOOP
            pDL := pDL + mBat.pDS;
          end;  //ENDING PHER DECAY LOOP
          pAL := pAL + mBat.pAS;
        end;  //ENDING PHER MIN LOOP
        antL := antL + mBat.nAS;
      end; //ENDING ANT LOOP
      WriteLn(txt,'');
    if mBat.aFDir <> BOTH then
      mCfg.aFDir := BOTH
    else
      inc(mCfg.aFDir);
  end;//ENDING AF DIRECTION LOOP
  WriteLn(txt, '');

  end;//ENDING AF CHECKED LOOP
  end; //ENDING AF TYPE LOOP
  toggleBtns();
  CloseFile(txt);
end;



function TACOForm.GetAntType(theType : integer): string;
begin
  case theType of
    AFNONE:   result := 'None';
    AFBOOL:   result := 'Boolean';
    AFLIN:    result := 'Linear';
    AFSQR:    result := 'Square';
    AFSQRT:   result := 'Sqrt';
    AFTANH:   result := 'Tanh';
    AFAMTS:   result := '1 on Sqrt X';
    AF1ONX:   result := '1 on X';

  end;
end;

function TACOForm.GetLSType(theType : integer): string;
begin
  case theType of
    LSEXP:  result := 'Exponential';
    LSLIN:  result := 'Linear Distribution';
  end;
end;

procedure TACOForm.OMenuAboutClick(Sender: TObject);
begin
  MessageDlg('Edition 3.1 Local Search', mtInformation	,[mbOk],0);
end;

procedure TACOForm.AntenDirRadGrpClick(Sender: TObject);
begin
  mCfg.aFDir := AntenDirRadGrp.ItemIndex;
end;

function TACOForm.GetAntDir(theDir: integer): string;
begin
  case theDir of
    UNI : result := 'Unidirectional';
    BI :  result := 'Bidirectional';
  end;
end;

procedure TACOForm.PMenuQuitClick(Sender: TObject);
begin
  aL.Clear;
  Close;
  ACOForm.Close;
  Application.MainForm.Close;
  Application.Terminate;
end;

procedure TACOForm.lSCheckBoxClick(Sender: TObject);
begin
  lSEdit.Enabled := lSCheckBox.Checked;
  lSRadGrp.Enabled := lSCheckBox.Checked;
  if (lSCheckBox.Checked) then
    mCfg.lSTimes := lSEdit.Value
  else
    mCfg.lSTimes := 0;
end;



procedure TACOForm.lSEditChange(Sender: TObject);
begin
  mCfg.lSTimes := lSEdit.Value;
end;

end.


