unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, TeeProcs, TeEngine, Chart,
  Contnrs, {for TObjectList} ExtDlgs, Math, Series,
  //user created units
  ConfigurationForm, PherMap, BatchForm, Ant, ComCtrls;

type
	TACOForm = class(TForm)
    oneTourBtn: TButton;
    configBtn: TButton;
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
    AntenRadGrp: TRadioGroup;
    BPrgsBar: TProgressBar;
    ProgressLbl: TLabel;
    
    //constructor/destructor
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    
    //initialising buttons -- in order of precedence
	  procedure loadBtnClick(Sender: TObject);
	  procedure configBtnClick(Sender: TObject);
    
    //normal graphical use buttons
	  procedure nTourBtnClick(Sender: TObject);
    procedure runBtnClick(Sender: TObject);
    procedure oneTourBtnClick(Sender: TObject);
    
    //soft reset button
    procedure resetBtnClick(Sender: TObject);
    procedure restartBtnClick(Sender: TObject);
    procedure batchBtnClick(Sender: TObject);
    procedure AntenRadGrpClick(Sender: TObject);
    

  private
    { Private declarations }

    bDist:  double;
    bPath:  TPath;
    aL:     TObjectList;
    gen:    integer;
    go :    boolean;
    antCountList: array of integer;
    antCityList: array of array of integer;

    function OneTour(mapUpdate: bool): bool;   //return if
    function UpdatePheromone(mapUpdate: bool): bool;
    procedure DoBatch(filename: string; totalIter: integer);
    procedure Antennation(cityCount: integer);

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
  dist: double;
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
  Randomize;
  aL := TObjectList.Create(True);
  mapImg := TImage.Create(ACOForm);
  mapImg.Parent := mapPnl;
  mapImg.Height := mapPnl.Height;
  mapImg.Width := mapPnl.Width;
  gen := 0;
  cityLbl.Caption := 'Number of cities:= '+IntToStr(mCfg.nC);
  distLbl.Caption := 'Distance := null';
  genLbl.Caption := 'Generations := ' +IntToStr(gen);
  go := false;
  mCfg.aFType := AFNONE;
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

		//read from file the number of cities,
		mCfg.nC := StrToInt(strs.Strings[0]);
    //initialise bestpath array
    setLength(bPath, mCfg.nC);


    //initialise antCountList
    //these 2 lengths do not change, only the antCityList[] changes
    setLength(antCountList, mCfg.nC);
    for i:= 0 to mCfg.Nc -1 do
      antCountList[i] := 0;
    setLength(antCityList, mCfg.nC);

    bDist := MAXINT; //set to maximum size INTEGER can hold
    InitPher();     //initialise the pheromone
    ResetPher();    //reset to zero
		LoadCities(strs);
    ChooseScale(MapImg);

    ConfigBtn.Enabled := true;
    ResetBtn.Enabled := true;
    BatchBtn.Enabled := true;
    nTourBtn.Enabled := false;
    runBtn.Enabled  := false;
    oneTourBtn.Enabled := false;
    DrawMap(mapImg, bDist, bPath);
    CityLbl.Caption := 'Number of cities:= '+IntToStr(mCfg.nC);
	end;
end;

procedure TACOForm.configBtnClick(Sender: TObject);
var   cfg: TCfgForm;
 	    def, i: integer;
begin
  cfg := TCfgForm.Create(nil);
  try
    //make the default value for the number of ants to be the city number
    cfg.AntsLblEdit.Text := intToStr(mCfg.nC);
    if cfg.ShowModal = mrOk then begin
      //check if there are any blank fields
      	if(cfg.AntsLblEdit.text = '') or (cfg.BetaLblEdit.text = '')
        	or (cfg.AlphaLblEdit.text = '') or (cfg.PherInitLblEdit.text = '')
        	or (cfg.PherDecayLblEdit.text = '') then
          	ShowMessage('Error: unable to have empty fields')
      	else begin
      	def := 0;
      	mCfg.pI := StrToFloatDef(cfg.PherInitLblEdit.Text,def);
      	mCfg.pD := StrToFloatDef(cfg.PherDecayLblEdit.Text, def);
      	mCfg.pA := StrToFloatDef(cfg.PherAddLblEdit.Text, def);
        mCfg.aF := StrToFloatDef(cfg.AntFacEdit.Text, def);
        //checking if unable to convert values to floats/ints
      	if( TryStrToInt(cfg.AntsLblEdit.Text, mCfg.nA) and
          	TryStrToInt(cfg.BetaLblEdit.Text, mCfg.b) and
          	TryStrToInt(cfg.AlphaLblEdit.Text, mCfg.a) and
          	(mCfg.pI <> def) and (mCfg.pD <> def) and
          	(mCfg.pA <> def) and (mCfg.aF <> def)) then begin

                //enable all the buttons, populate the ant list
                aL.Clear;
                StartPher();
                for i:= 0 to (mCfg.nA - 1) do aL.Add(TAnt.Create());
                for i:= 0 to (mCfg.nC - 1) do setLength(antCityList[i], mCfg.nA);

                nTourBtn.Enabled    := true;
                oneTourBtn.Enabled  := true;
                runBtn.Enabled      := true;
        end
      	else
         	ShowMessage('Error: impossible values entered');
      	end;
    end;
  	finally
    	cfg.Release;
	end;
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
      for i:= 0 to nTour -1 do begin
        oneTour(true);
        distLbl.Caption := 'Distance := ' + FloatToStr(bDist);
        genLbl.Caption := 'Generations := '+IntToStr(gen);
        GraphPheromone(pChart);
        DrawMap(mapImg, bDist, bPath);
      end;
    end else ShowMessage('Error:' +strTour+ ' is not a valid value');
  end;
end;


procedure TACOForm.runBtnClick(Sender: TObject);

var nGen, i: integer;
    strTour: string;
begin
  strTour:= '10';
  if(InputQuery('Run Until N generations', 'How many generations since new best distance?', strTour)) then begin
    if(TryStrToInt(strTour, nGen)) then begin
      i := 0;
      while (i < nGen) do begin
        genLbl.Caption := 'Generations := '+IntToStr(gen);
        if(oneTour(true)) then i := 0 else inc(i);
        distLbl.Caption := 'Distance := ' + FloatToStr(bDist);
        GraphPheromone(pChart);
        DrawMap(mapImg, bDist, bPath);
      end;
    end else ShowMessage('Error:' +strTour+ ' is not a valid value');
  end;
end;


procedure TACOForm.resetBtnClick(Sender: TObject);
begin
  gen := 0;
  bDist := MAXINT;
  pChart.Series[0].Clear;
  pChart.Series[1].Clear;
  
  cityLbl.Caption := 'Number of cities:= '+IntToStr(mCfg.nC);
  distLbl.Caption := 'Distance := null';
  genLbl.Caption := 'Generations := ' +IntToStr(gen);
  ResetPher();

  DrawMap(mapImg, bDist, bPath);
  StartPher();
end;

procedure TACOForm.oneTourBtnClick(Sender: TObject);
begin
  oneTour(true);
  distLbl.Caption := 'Distance := ' +FloatToStr(bDist);
  genLbl.Caption := 'Generations := '+IntToStr(gen);
  DrawMap(mapImg, bDist, bPath);
  GraphPheromone(pChart);
end;

function TACOForm.OneTour(mapUpdate : bool): bool;
var i,j, antMove:integer;
begin

  inc(gen);
  for i := 0 to mCfg.nA -1 do    //set initial city
    TAnt(aL.Items[i]).SetStartCity(RandomRange(0,(mCfg.nC -1)));
  //move each ant until all cities have been visited
  for i := 0 to (mCfg.nC -1) do  begin
    for j := 0 to (mCfg.nA -1) do begin
      antMove:= TAnt(aL.Items[j]).move();
      //place the index of that ant to the appropriate location in the antCity List
      // location is [city number][the amount of ants at that city]
      antCityList[antMove][antCountList[antMove]] := j;
      //increment the counter corresponding to that city
      inc(antCountList[antMove]);
    end;
    //after every ant has moved, share the paths of each ant with its fellows
    Antennation(i);
  end;
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
  configBtn.Enabled   := false;
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
      if(batch.AntFacCheck.Checked) then begin
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

      mBat.numGen := StrToInt(batch.genEdit.Text);
      mBat.iteration := StrToInt(batch.iterEdit.Text);
      mBat.aFType := batch.AntenRadGrp.ItemIndex;
      fileName := batch.txtNameEdit.Text;

      //please note: must multiply by 1.000001 to push it over the value required for truncation
      //only there because Delphi is not that great with numbers
      totalIter := mBat.iteration
      * Trunc((mBat.nAE+mBat.nAS*1.00001-mBat.nAB)/mBat.nAS)
      * Trunc((mBat.pAE+mBat.pAS*1.00001-mBat.pAB)/mBat.pAS)
      * Trunc((mBat.pIE+mBat.pIS*1.00001-mBat.pIB)/mBat.pIS)
      * Trunc((mBat.pDE+mBat.pDS*1.00001-mBat.pDB)/mBat.pDS)
      * Trunc((mBat.aFE+mBat.aFS*1.00001-mBat.aFB)/mBat.aFS);
      iterStr := 'This batch run will take at least '+FloatToStr(totalIter)+
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
    genCount, avgDist, bestDist: double;
    txt: TextFile;
begin
  if FileExists(fileName) then
    if (MessageDlg('File ' + FileName + ' exists. Overwrite?', mtConfirmation,
        [mbOk, mbCancel], 0) = mrCancel) then
        Exit;

  mCfg.a      := mBat.a;
  mCfg.b      := mBat.b;
  curProgress := 0;

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
  WriteLn(txt,'avgGen avgdist bDist DP AP IP NA AF AFTYPE');
  // 6 loops- number of ants, add P, decay P, init P, AntF, Iterations
  // start of with the number of ants

  antL := mBat.nAB;
  while(antL <= mBat.nAE) do begin  //ANT LOOP
    aL.Clear; //delete all ant objects - may be a memory leak
    //time to set the length of the antCityList and populate the aL object list
    for i := 0 to antL -1 do
      aL.Add(TAnt.Create);
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
            iterL := 0; genCount:= 0; avgDist:= 0; bestDist := MAXINT;
            while(iterL < mBat.iteration) do begin
              curGen := 0;
              gen := 0;
              ///STARTING AN ITERATION
              startPher();
              while(curGen <= mBat.numGen) do
                //if the tour does return a better path, reset curGen to zero else inc
                if(oneTour(false)) then curGen:= 0 else inc(curGen);
              genCount := genCount + gen - curGen;
              avgDist := avgDist + bDist;
              if(bDist < bestDist) then bestDist := bDist;
              bDist := MAXINT; //reset the best distance to the maximum integer possible
              inc(iterL);
            end;
            ///FINISHING AN ITERATION
            genCount := genCount/mBat.iteration;
            avgDist := avgDist/mBat.iteration;
            //updating progress bar
            curProgress := curProgress + mBat.iteration;
            BPrgsBar.Position := curProgress;
            //time to write out to the file
             WriteLn(txt,FloatToStr(genCount)+' '+FloatToStr(avgDist)+' '+FloatToStr(bestDist)+' '
                    +FloatToStr(pDL)+' '+FloatToStr(pAL)+' '+FloatToStr(pIL)+' '
                    +IntToStr(antL)+' '+FloatToStr(aFL)+' '+IntToStr(mCfg.aFType));
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
  CloseFile(txt);
end;

procedure TACOForm.Antennation(cityCount: integer);
var i,j,k, ant1, ant2: integer;
  path1, path2: TPath;
begin
  setLength(path1, mCfg.Nc);
  setLength(path2, mCfg.Nc);
  for i:= 0 to mCfg.nC -1 do begin //for the length of the cityCount array
    if (antCountList[i] > 1) then begin   //more than 1 ant on the city
      for j:= 0 to antCountList[i] -1 do begin
        //ant indexes are given by antCityList[city][j]
        ant1  := antCityList[i][j];
        path1 := TAnt(aL.Items[ant1]).GetPath;
        for k:= j+1 to antCountList[i] -1 do begin
          ant2 := antCityList[i][j];
          path2 := TAnt(aL.Items[ant2]).GetPath;
          //time to swap trees, city count is the number of cities travelled thus far
          TAnt(aL.Items[ant1]).AddTree(path2, cityCount);
          TAnt(aL.Items[ant2]).AddTree(path1, cityCount);
        end;
      end;
    end;
    antCountList[i] := 0; //reset to zero
  end;
end;

procedure TACOForm.AntenRadGrpClick(Sender: TObject);
begin
  mCfg.aFType := AntenRadGrp.ItemIndex;
end;

end.


