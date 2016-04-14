unit BatchForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, PherMap, ESBPCSPanel,
  ESBPCSSpinEdit;

const
  AFNONE = 0;
  AFAMTS = 6;
                 
type
  TBForm = class(TForm)
    BatchControl: TPageControl;
    ASTab: TTabSheet;
    ASStartBox: TGroupBox;
    ASpaB: TLabeledEdit;
    ASpdB: TLabeledEdit;
    ASafB: TLabeledEdit;
    ASpiB: TLabeledEdit;
    ASStepBox: TGroupBox;
    ASpaS: TLabeledEdit;
    ASpdS: TLabeledEdit;
    ASafS: TLabeledEdit;
    ASpiS: TLabeledEdit;
    ASEndBox: TGroupBox;
    ASpaE: TLabeledEdit;
    ASpdE: TLabeledEdit;
    ASafE: TLabeledEdit;
    ASpiE: TLabeledEdit;
    ACSTab: TTabSheet;
    ACSStartbox: TGroupBox;
    ACSpaB: TLabeledEdit;
    ACSpdB: TLabeledEdit;
    ACSafB: TLabeledEdit;
    ACSpiB: TLabeledEdit;
    ACSgpB: TLabeledEdit;
    ACSStepBox: TGroupBox;
    ACSpaS: TLabeledEdit;
    ACSpdS: TLabeledEdit;
    ACSafS: TLabeledEdit;
    ACSpiS: TLabeledEdit;
    ACSgpS: TLabeledEdit;
    ACSEndBox: TGroupBox;
    ACSpaE: TLabeledEdit;
    ACSpdE: TLabeledEdit;
    ACSafE: TLabeledEdit;
    ACSpiE: TLabeledEdit;
    ACSgpE: TLabeledEdit;
    AMTSTab: TTabSheet;
    AMTSStartBox: TGroupBox;
    AMTSpaB: TLabeledEdit;
    AMTSpdB: TLabeledEdit;
    AMTSafB: TLabeledEdit;
    AMTSpiB: TLabeledEdit;
    AMTSmaB: TLabeledEdit;
    AMTSStepBox: TGroupBox;
    AMTSpaS: TLabeledEdit;
    AMTSpdS: TLabeledEdit;
    AMTSafS: TLabeledEdit;
    AMTSpiS: TLabeledEdit;
    AMTSmaS: TLabeledEdit;
    AMTSEndBox: TGroupBox;
    AMTSpaE: TLabeledEdit;
    AMTSpdE: TLabeledEdit;
    AMTSafE: TLabeledEdit;
    AMTSpiE: TLabeledEdit;
    AMTSmaE: TLabeledEdit;
    MMTab: TTabSheet;
    MMStartBox: TGroupBox;
    MMpaB: TLabeledEdit;
    MMpdB: TLabeledEdit;
    MMafB: TLabeledEdit;
    MMpiB: TLabeledEdit;
    MMStepBox: TGroupBox;
    MMpaS: TLabeledEdit;
    MMpdS: TLabeledEdit;
    MMpiS: TLabeledEdit;
    MMafS: TLabeledEdit;
    MMEndBox: TGroupBox;
    MMpaE: TLabeledEdit;
    MMpdE: TLabeledEdit;
    MMpiE: TLabeledEdit;
    MMafE: TLabeledEdit;
    OkBtn: TBitBtn;
    cancelBtn: TBitBtn;
    ExcludeBox: TGroupBox;
    AntCheck: TCheckBox;
    PherAddCheck: TCheckBox;
    PherDecayCheck: TCheckBox;
    AntFacCheck: TCheckBox;
    PherInitCheck: TCheckBox;
    GreedCheck: TCheckBox;
    AgeCheck: TCheckBox;
    AlgRadGrp: TRadioGroup;
    AntenDirRadGrp: TRadioGroup;
    AntenCheckGrp: TGroupBox;
    AF1: TCheckBox;
    AF5: TCheckBox;
    AF2: TCheckBox;
    AF4: TCheckBox;
    AF3: TCheckBox;
    AF6: TCheckBox;
    AF7: TCheckBox;
    GroupBox1: TGroupBox;
    randSeedEdit: TESBPosSpinEdit;
    ASnaB: TESBPosSpinEdit;
    Label3: TLabel;
    ASnaS: TESBPosSpinEdit;
    Label4: TLabel;
    ASnaE: TESBPosSpinEdit;
    Label5: TLabel;
    ACSnaB: TESBPosSpinEdit;
    Label6: TLabel;
    ACSnaS: TESBPosSpinEdit;
    Label7: TLabel;
    ACSnaE: TESBPosSpinEdit;
    Label8: TLabel;
    AMTSnaB: TESBPosSpinEdit;
    Label9: TLabel;
    AMTSnaS: TESBPosSpinEdit;
    Label10: TLabel;
    AMTSnaE: TESBPosSpinEdit;
    Label11: TLabel;
    MMnaB: TESBPosSpinEdit;
    Label12: TLabel;
    MMnaS: TESBPosSpinEdit;
    Label13: TLabel;
    MMnaE: TESBPosSpinEdit;
    Label14: TLabel;
    GroupBox2: TGroupBox;
    txtNameEdit: TLabeledEdit;
    AlphaEdit: TLabeledEdit;
    BetaEdit: TLabeledEdit;
    iterGlobalEdit: TLabeledEdit;
    genEdit: TESBPosSpinEdit;
    Label1: TLabel;
    iterEdit: TESBPosSpinEdit;
    Label2: TLabel;
    GroupBox4: TGroupBox;
    lSCheckBox: TCheckBox;
    lSEdit: TESBPosSpinEdit;
    lSRadGrp: TRadioGroup;

    procedure BatchInit();
    function GetAFList(): TBoolArray;
    procedure AntCheckClick(Sender: TObject);
    procedure PherAddCheckClick(Sender: TObject);
    procedure PherDecayCheckClick(Sender: TObject);
    procedure GreedCheckClick(Sender: TObject);
    procedure AgeCheckClick(Sender: TObject);

    procedure AntFacCheckClick(Sender: TObject);
    procedure PherInitCheckClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure AlgRadGrpClick(Sender: TObject);
    procedure AF1Click(Sender: TObject);
    procedure AF2Click(Sender: TObject);
    procedure AF3Click(Sender: TObject);
    procedure AF4Click(Sender: TObject);
    procedure AF5Click(Sender: TObject);
    procedure AF6Click(Sender: TObject);
    procedure AF7Click(Sender: TObject);
    procedure lSCheckBoxClick(Sender: TObject);


  private
    { Private declarations }
    AFList : TBoolArray;
  public
    { Public declarations }
  end;

var
  BForm: TBForm;

implementation

{$R *.dfm}

procedure TBForm.AntFacCheckClick(Sender: TObject);
begin
  if(AntFacCheck.Checked = true) then begin
    ASafE.Enabled := false;
    ASafS.Enabled := false;

    ACSafE.Enabled := false;
    ACSafS.Enabled := false;

    AMTSafE.Enabled := false;
    AMTSafS.Enabled := false;

    MMafE.Enabled := false;
    MMafS.Enabled := false;
  end
  else begin
    ASafE.Enabled := true;
    ASafS.Enabled := true;

    ACSafE.Enabled := true;
    ACSafS.Enabled := true;

    AMTSafE.Enabled := true;
    AMTSafS.Enabled := true;

    MMafE.Enabled := true;
    MMafS.Enabled := true;
  end;
end;


procedure TBForm.FormCreate(Sender: TObject);
begin
  setLength(AFList, CURRENT_AF_TYPES);
end;

procedure TBForm.AlgRadGrpClick(Sender: TObject);
begin
  iterGlobalEdit.Visible := false;
  case AlgRadGrp.ItemIndex of
    ACOAS:
    begin
      batchControl.ActivePageIndex := ACOAS;
      ageCheck.Enabled    := false;
      greedCheck.Enabled  := false;
    end;

    ACOACS:
    begin
      batchControl.ActivePageIndex := ACOACS;
      ageCheck.Enabled    := false;
      greedCheck.Enabled  := true;
    end;

    ACOAMTS:
    begin
      batchControl.ActivePageIndex := ACOAMTS;
      ageCheck.Enabled    := true;
      greedCheck.Enabled  := false;
    end;

    ACOMM:
    begin
      batchControl.ActivePageIndex := ACOMM;
      ageCheck.Enabled    := false;
      greedCheck.Enabled  := false;
      iterGlobalEdit.Visible := true;
    end

  end;
end;

procedure TBForm.BatchInit;
begin
   batchControl.ActivePageIndex := 0;
   greedCheck.Enabled := false;
   ageCheck.Enabled := false;
   iterGlobalEdit.Visible := false;
end;

procedure TBForm.AgeCheckClick(Sender: TObject);
begin
  AMTSmaE.Enabled := not AgeCheck.Checked;
  AMTSmaS.Enabled := not AgeCheck.Checked;
end;

procedure TBForm.GreedCheckClick(Sender: TObject);
begin
  ACSgpE.Enabled := not GreedCheck.Checked;
  ACSgpS.Enabled := not GreedCheck.Checked;
end;

procedure TBForm.PherInitCheckClick(Sender: TObject);
begin
  ASpiE.Enabled := not PherInitCheck.Checked;
  ASpiS.Enabled := not PherInitCheck.Checked;

  ACSpiE.Enabled := not PherInitCheck.Checked;
  ACSpiS.Enabled := not PherInitCheck.Checked;

  AMTSpiE.Enabled := not PherInitCheck.Checked;
  AMTSpiS.Enabled := not PherInitCheck.Checked;

  MMpiE.Enabled := not PherInitCheck.Checked;
  MMpiS.Enabled := not PherInitCheck.Checked;
end;

procedure TBForm.AntCheckClick(Sender: TObject);
begin
  ASnaE.Enabled := not AntCheck.Checked;
  ASnaS.Enabled := not AntCheck.Checked;

  ACSnaE.Enabled := not AntCheck.Checked;
  ACSnaS.Enabled := not AntCheck.Checked;

  AMTSnaE.Enabled := not AntCheck.Checked;
  AMTSnaS.Enabled := not AntCheck.Checked;

  MMnaE.Enabled := not AntCheck.Checked;
  MMnaS.Enabled := not AntCheck.Checked;
end;

procedure TBForm.PherAddCheckClick(Sender: TObject);
begin
  ASpaE.Enabled := not PherAddCheck.Checked;
  ASpaS.Enabled := not PherAddCheck.Checked;

  ACSpaE.Enabled := not PherAddCheck.Checked;
  ACSpaS.Enabled := not PherAddCheck.Checked;

  AMTSpaE.Enabled := not PherAddCheck.Checked;
  AMTSpaS.Enabled := not PherAddCheck.Checked;

  MMpaE.Enabled := not PherAddCheck.Checked;
  MMpaS.Enabled := not PherAddCheck.Checked;
end;

procedure TBForm.PherDecayCheckClick(Sender: TObject);
begin
  ASpdE.Enabled := not PherDecayCheck.Checked;
  ASpdS.Enabled := not PherDecayCheck.Checked;

  ACSpdE.Enabled := not PherDecayCheck.Checked;
  ACSpdS.Enabled := not PherDecayCheck.Checked;

  AMTSpdE.Enabled := not PherDecayCheck.Checked;
  AMTSpdS.Enabled := not PherDecayCheck.Checked;

  MMpdE.Enabled := not PherDecayCheck.Checked;
  MMpdS.Enabled := not PherDecayCheck.Checked;
end;

function TBForm.GetAFList(): TBoolArray;
begin
  result := AFList;
end;



procedure TBForm.AF1Click(Sender: TObject);
var temp: string;
  index: integer;
begin
  temp := (Sender as TCheckBox).Name;
  index := length(temp);
  AFList[StrToInt(temp[index])] := (Sender as TCheckBox).Checked;
end;



procedure TBForm.AF2Click(Sender: TObject);
var temp: string;
  index : integer;
begin
  temp := (Sender as TCheckBox).Name;
  index := length(temp);
  AFList[StrToInt(temp[index])] := (Sender as TCheckBox).Checked;
end;

procedure TBForm.AF3Click(Sender: TObject);
var temp: string;
  index : integer;
begin
  temp := (Sender as TCheckBox).Name;
  index := length(temp);
  AFList[StrToInt(temp[index])] := (Sender as TCheckBox).Checked;
end;

procedure TBForm.AF4Click(Sender: TObject);
var temp: string;
  index : integer;
begin
  temp := (Sender as TCheckBox).Name;
  index := length(temp);
  AFList[StrToInt(temp[index])] := (Sender as TCheckBox).Checked;
end;

procedure TBForm.AF5Click(Sender: TObject);
var temp: string;
  index : integer;
begin
  temp := (Sender as TCheckBox).Name;
  index := length(temp);
  AFList[StrToInt(temp[index])] := (Sender as TCheckBox).Checked;
end;

procedure TBForm.AF6Click(Sender: TObject);
var temp: string;
  index : integer;
begin
  temp := (Sender as TCheckBox).Name;
  index := length(temp);
  AFList[StrToInt(temp[index])] := (Sender as TCheckBox).Checked;
end;

procedure TBForm.AF7Click(Sender: TObject);
var temp: string;
  index : integer;
begin
  temp := (Sender as TCheckBox).Name;
  index := length(temp);
  AFList[StrToInt(temp[index])] := (Sender as TCheckBox).Checked;
end;


procedure TBForm.lSCheckBoxClick(Sender: TObject);
begin
  lSEdit.Enabled := lSCheckBox.Checked;
  lSRadGrp.Enabled := lSCheckBox.Checked;
end;


end.
