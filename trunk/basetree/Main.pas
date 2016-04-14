unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, TeeProcs, TeEngine, Chart,
  Contnrs, {for TObjectList} ExtDlgs, Math, Series,
  //user created units
   PherMap, BatchForm, Ant, ComCtrls, Menus, ToolWin, ActnMan, ActnCtrls,
  ActnMenus;

//typedef containing the path distance and the amount of times it has occurred
type
  TPathRec = record
    d: integer;
    c: integer; 
end;

type
	TACOForm = class(TForm)
    oneTourBtn: TButton;
    initBtn: TButton;
    loadBtn: TButton;
    nTourBtn: TButton;
    batchBtn: TButton;
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
    SettingsPnl: TPanel;
    BetaEdit: TLabeledEdit;
    AlphaEdit: TLabeledEdit;
    Label1: TLabel;
    AntTypeGrp: TRadioGroup;
    PherInitEdit: TLabeledEdit;
    PherDecayEdit: TLabeledEdit;
    PherAddEdit: TLabeledEdit;
    AntFEdit: TLabeledEdit;
    
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
    procedure batchBtnClick(Sender: TObject);
    procedure AntTypeGrpClick(Sender: TObject);

    procedure AlphaEditExit(Sender: TObject);
    procedure PherInitEditExit(Sender: TObject);
    procedure PherAddEditExit(Sender: TObject);
    procedure AntFEditExit(Sender: TObject);
    procedure BetaEditExit(Sender: TObject);
    procedure PherDecayEditExit(Sender: TObject);
    

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
    procedure DoBatch(filename: string; totalIter: integer);
    function Antennation(): integer;
    procedure ToggleBtns;

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
  dist: integer;
  path: TPath;
begin
  ReducePher();
  setLength(path,mCfg.nC);
  result := false;
  for i := 0 to (mCfg.nA -1) do begin
    path := TAnt(aL.Items[i]).GetPath();
    dist := TAnt(aL.Items[i]).GetDistance();
    LayPherPath(path, dist);
    if dist < bDist then begin
      bDist := dist;
      result := true;
      if(mapUpdate) then  //only copy if we need to, cut down on time
        for j := 0 to mCfg.nC -1 do
          bPath[j] := path[j];   //copy path elements to new best path
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

  mCfg.aFType := AFNONE;
  mCfg.a := 2;
  mCfg.b := -2;
  mCfg.pI := 0.1;
  mCfg.pD := 0.1;
  mCfg.pA := 0.5;
  mCfg.aF := 0.1;

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
    ResetPher();    //reset to zero

    ChooseScale(MapImg);

    initBtn.Enabled := true;
    ResetBtn.Enabled := true;
    BatchBtn.Enabled := true;
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
    startPher();
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
  BatchBtn.Enabled := not BatchBtn.Enabled;
  oneTourBtn.Enabled := not oneTourBtn.Enabled;
  InitBtn.Enabled := not InitBtn.Enabled;
  LoadBtn.Enabled := not LoadBtn.Enabled;
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
  ResetPher();

  DrawMap(mapImg, bDist, bPath);
  StartPher();
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
  //update the pheromone map
  result := UpdatePheromone(mapUpdate);

//cleaning up
  for i:= 0 to mCfg.nA-1 do begin
    //resets taboo list and tree
    TAnt(aL.Items[i]).ResetList();
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
  resetPher();
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
  initBtn.Enabled   := false;
  runBtn.Enabled      := false;
  resetBtn.Enabled    := false;
  batchBtn.Enabled    := false;
  cityLbl.Caption := 'Number of cities:= '+IntToStr(mCfg.nC);
  distLbl.Caption := 'Distance := null';
  genLbl.Caption := 'Generations := ' +IntToStr(gen);
end;

procedure TACOForm.batchBtnClick(Sender: TObject);
var   batch: TBForm;
  fileName : string;
  totalIter: integer;
  iterStr: string;
begin
  batch := TBForm.Create(nil);
  try
    //make the default value for the number of ants to be the city number
    if batch.ShowModal = mrOk then begin
      //bugger fields, just assume everything is correct
      mBat.a := StrToInt(batch.AlphaEdit.Text);
      mBat.b := StrToInt(batch.BetaEdit.Text);
      mBat.numGen := StrToInt(batch.genEdit.Text);
      mBat.iteration := StrToInt(batch.iterEdit.Text);
      mBat.aFType := batch.AntenRadGrp.ItemIndex;
      fileName := batch.txtNameEdit.Text;


      mBat.pAB := StrToFloat(batch.PherAddB.Text);
      mBat.pAS := StrToFloat(batch.PherAddS.Text);
      mBat.pAE := StrToFloat(batch.PherAddE.Text);
      //if checked, set end to start and step to 1, so only one run is done
      if(batch.PherAddCheck.Checked) then begin
        mBat.pAS := 1;
        mBat.pAE := mBat.pAB;
      end;

      mBat.pDB := StrToFloat(batch.pherDecayB.Text);
      mBat.pDS := StrToFloat(batch.pherDecayS.Text);
      mBat.pDE := StrToFloat(batch.pherDecayE.Text);
      if(batch.PherDecayCheck.Checked) then begin
        mBat.pDS := 1;
        mBat.pDE := mBat.pDB;
      end;

      mBat.nAB := StrToInt(batch.NumAntsB.Text);
      mBat.nAS := StrToInt(batch.NumAntsS.Text);
      mBat.nAE := StrToInt(batch.NumAntsE.Text);
      if(batch.AntCheck.Checked) then begin
        mBat.nAS := 1;
        mBat.nAE := mBat.nAB;
      end;

      mBat.aFB := StrToFloat(batch.AntFacB.Text);
      mBat.aFS := StrToFloat(batch.AntFacS.Text);
      mBat.aFE := StrToFloat(batch.AntFacE.Text);
      if(batch.AntFacCheck.Checked) or (mBat.aFType = AFNONE) or (mBat.aFType = AFAMTS) then begin
        mBat.aFS := 1;
        mBat.aFE := mBat.aFB;
      end;

      mBat.pIB := StrToFloat(batch.PherInitB.Text);
      mBat.pIS := StrToFloat(batch.PherInitS.Text);
      mBat.pIE := StrToFloat(batch.PherInitE.Text);
      if(batch.PherInitCheck.Checked) then begin
        mBat.pIS := 1;
        mBat.pIE := mBat.PIB;
      end;


      //please note: must multiply by 1.000001 to push it over the value required for truncation
      //only there because Delphi is not that great with numbers
      totalIter := mBat.iteration
      * Trunc((mBat.nAE+mBat.nAS*1.00001-mBat.nAB)/mBat.nAS)
      * Trunc((mBat.pAE+mBat.pAS*1.00001-mBat.pAB)/mBat.pAS)
      * Trunc((mBat.pIE+mBat.pIS*1.00001-mBat.pIB)/mBat.pIS)
      * Trunc((mBat.pDE+mBat.pDS*1.00001-mBat.pDB)/mBat.pDS)
      * Trunc((mBat.aFE+mBat.aFS*1.00001-mBat.aFB)/mBat.aFS);
      
      iterStr := 'This batch run will take at least '+FloatToStr(totalIter *mBat.numGen)+
          ' generations to complete: Continue?';
      if MessageDlg(iterStr, mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        DoBatch(fileName, totalIter);
    end;
  	finally
    	batch.Release;
	end;

end;

procedure TACOForm.DoBatch(fileName:string; totalIter: integer);
var antL, iterL, curGen, i, curProgress: integer;
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
  mCfg.a      := mBat.a;
  mCfg.b      := mBat.b;
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
  WriteLn(txt,'BatchFile test, number of cities :=' +intToStr(mCfg.nC));
  WriteLn(txt,'BatchFile test, format:');
  WriteLn(txt,'avgGen avgdist DP AP IP NA AF AFTYPE Path1D Path1C Path2D Path2C Path3D Path3C ANTMEET');
  // 6 loops- number of ants, add P, decay P, init P, AntF, Iterations
  // start of with the number of ants

  antL := mBat.nAB;
  while(antL <= mBat.nAE) do begin  //ANT LOOP
    aL.Clear; //delete all ant objects - may be a memory leak
    //time to set the length of the antCityList and populate the aL object list
    for i := 0 to antL -1 do
      aL.Add(TAnt.Create(i));
    for i := 0 to mCfg.nC -1 do
      setLength(antCityList[i], antL);

    pAL := mBat.pAB;
    while(pAL <= mBat.pAE) do begin   //ADD LOOP
      pDL := mBat.pDB;
      while(pDL <= mBat.pDE) do begin  //DECAY LOOP
        pIL := mBat.pIB;
        while(pIL <= mBat.pIE) do begin //INIT LOOP
          aFL := mBat.aFB;
          while (aFL <= mBat.aFE) do begin //FACTOR LOOP
 {-----------------------------------------------------------------------------
 -----------------------testing loop------------------------------------------
 -----------------------------------------------------------------------------}
            mCfg.nA := antL;
            mCfg.pA := pAL;
            mCfg.pD := pDL;
            mCfg.aF := aFL;
            mCfg.pI := pIL;
            mCfg.aFType := mBat.aFType;
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
              startPher();
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
            end;
            ///FINISHING AN ITERATION
            genCount := genCount/mBat.iteration;
            avgDist := avgDist/mBat.iteration;
            totalAMeetCount := totalAMeetCount/mBat.iteration;
            //updating progress bar
            curProgress := curProgress + mBat.iteration;
            BPrgsBar.Position := curProgress;
            //time to write out to the file
             WriteLn(txt,FloatToStr(genCount)+' '+FloatToStr(avgDist)+' '
                    +FloatToStr(pDL)+' '+FloatToStr(pAL)+' '+FloatToStr(pIL)+' '
                    +IntToStr(antL)+' '+FloatToStr(aFL)+' '+IntToStr(mCfg.aFType)+' '
                    +IntToStr(topPaths[0].d)+' '+IntToStr(topPaths[0].c)+' '
                    +IntToStr(topPaths[1].d)+' '+IntToStr(topPaths[1].c)+' '
                    +IntToStr(topPaths[2].d)+' '+IntToStr(topPaths[2].c)+' '
                    +FloatToStr(totalAMeetCount));
            aFL := aFL + mBat.aFS
          end;
          ProgressLbl.Caption := 'Batch Percentage Complete: '+FloatToStr(Round(100*curProgress/totalIter))+'%';
          ACOForm.Refresh;
          pIL := pIL + mBat.pIS;
        end;
        pDL := pDL + mBat.pDS;
      end;
      pAL := pAL + mBat.pAS;
    end;
    antL := antL + mBat.nAS;
  end; //ending ant loop
  toggleBtns();
  CloseFile(txt);
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

procedure TACOForm.AntTypeGrpClick(Sender: TObject);
begin
  mCfg.aFType := AntTypeGrp.ItemIndex;
end;

procedure TACOForm.AlphaEditExit(Sender: TObject);
var temp: integer;
begin
  if(TryStrToInt(AlphaEdit.Text, temp)) then begin
    mCfg.a := temp;
    AlphaEdit.Text := IntToStr(mCfg.a);
  end
  else begin
    ShowMessage('Error: Must be an integer');
    AlphaEdit.Text := IntToStr(mCfg.a);
  end;
end;

procedure TACOForm.BetaEditExit(Sender: TObject);
var temp: integer;
begin
  if(TryStrToInt(BetaEdit.Text, temp)) then begin
    mCfg.b := temp;
    AlphaEdit.Text := IntToStr(mCfg.b);
  end
  else begin
    ShowMessage('Error: Must be an integer');
    BetaEdit.Text := IntToStr(mCfg.b);
  end;
end;

procedure TACOForm.PherInitEditExit(Sender: TObject);
var temp: double;
begin
  if(TryStrToFloat(PherInitEdit.Text, temp)) then begin
    mCfg.pI := temp;
    PherInitEdit.Text := FloatToStr(mCfg.pI);
  end
  else begin
    ShowMessage('Error: Must be a number');
    PherInitEdit.Text := FloatToStr(mCfg.pI);
  end;
end;

procedure TACOForm.PherAddEditExit(Sender: TObject);
var temp: double;
begin
  if(TryStrToFloat(PherAddEdit.Text, temp)) then begin
    mCfg.pA := temp;
    PherAddEdit.Text := FloatToStr(mCfg.pA);
  end
  else begin
    ShowMessage('Error: Must be a number');
    PherAddEdit.Text := FloatToStr(mCfg.pA);
  end;
end;

procedure TACOForm.PherDecayEditExit(Sender: TObject);
var temp: double;
begin
  if(TryStrToFloat(PherDecayEdit.Text, temp)) then begin
    mCfg.pD := temp;
    PherDecayEdit.Text := FloatToStr(mCfg.pD);
  end
  else begin
    ShowMessage('Error: Must be a number');
    PherDecayEdit.Text := FloatToStr(mCfg.pD);
  end;

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

end.


