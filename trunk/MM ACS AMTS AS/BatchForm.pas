unit BatchForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, PherMap;

const
  AFNONE = 0;
  AFAMTS = 6;
                 
type
  TBForm = class(TForm)
    BatchControl: TPageControl;
    ASTab: TTabSheet;
    ASStartBox: TGroupBox;
    ASnaB: TLabeledEdit;
    ASpaB: TLabeledEdit;
    ASpdB: TLabeledEdit;
    ASafB: TLabeledEdit;
    ASpiB: TLabeledEdit;
    ASStepBox: TGroupBox;
    ASpaS: TLabeledEdit;
    ASpdS: TLabeledEdit;
    ASnaS: TLabeledEdit;
    ASafS: TLabeledEdit;
    ASpiS: TLabeledEdit;
    ASEndBox: TGroupBox;
    ASnaE: TLabeledEdit;
    ASpaE: TLabeledEdit;
    ASpdE: TLabeledEdit;
    ASafE: TLabeledEdit;
    ASpiE: TLabeledEdit;
    ACSTab: TTabSheet;
    ACSStartbox: TGroupBox;
    ACSnaB: TLabeledEdit;
    ACSpaB: TLabeledEdit;
    ACSpdB: TLabeledEdit;
    ACSafB: TLabeledEdit;
    ACSpiB: TLabeledEdit;
    ACSgpB: TLabeledEdit;
    ACSStepBox: TGroupBox;
    ACSpaS: TLabeledEdit;
    ACSpdS: TLabeledEdit;
    ACSnaS: TLabeledEdit;
    ACSafS: TLabeledEdit;
    ACSpiS: TLabeledEdit;
    ACSgpS: TLabeledEdit;
    ACSEndBox: TGroupBox;
    ACSnaE: TLabeledEdit;
    ACSpaE: TLabeledEdit;
    ACSpdE: TLabeledEdit;
    ACSafE: TLabeledEdit;
    ACSpiE: TLabeledEdit;
    ACSgpE: TLabeledEdit;
    AMTSTab: TTabSheet;
    AMTSStartBox: TGroupBox;
    AMTSnaB: TLabeledEdit;
    AMTSpaB: TLabeledEdit;
    AMTSpdB: TLabeledEdit;
    AMTSafB: TLabeledEdit;
    AMTSpiB: TLabeledEdit;
    AMTSmaB: TLabeledEdit;
    AMTSStepBox: TGroupBox;
    AMTSpaS: TLabeledEdit;
    AMTSpdS: TLabeledEdit;
    AMTSnaS: TLabeledEdit;
    AMTSafS: TLabeledEdit;
    AMTSpiS: TLabeledEdit;
    AMTSmaS: TLabeledEdit;
    AMTSEndBox: TGroupBox;
    AMTSnaE: TLabeledEdit;
    AMTSpaE: TLabeledEdit;
    AMTSpdE: TLabeledEdit;
    AMTSafE: TLabeledEdit;
    AMTSpiE: TLabeledEdit;
    AMTSmaE: TLabeledEdit;
    MMTab: TTabSheet;
    MMStartBox: TGroupBox;
    MMnaB: TLabeledEdit;
    MMpaB: TLabeledEdit;
    MMpdB: TLabeledEdit;
    MMafB: TLabeledEdit;
    MMpiB: TLabeledEdit;
    MMStepBox: TGroupBox;
    MMpaS: TLabeledEdit;
    MMpdS: TLabeledEdit;
    MMnaS: TLabeledEdit;
    MMpiS: TLabeledEdit;
    MMafS: TLabeledEdit;
    MMEndBox: TGroupBox;
    MMnaE: TLabeledEdit;
    MMpaE: TLabeledEdit;
    MMpdE: TLabeledEdit;
    MMpiE: TLabeledEdit;
    MMafE: TLabeledEdit;
    genEdit: TLabeledEdit;
    iterEdit: TLabeledEdit;
    OkBtn: TBitBtn;
    txtNameEdit: TLabeledEdit;
    AntenTypeRadGrp: TRadioGroup;
    cancelBtn: TBitBtn;
    ExcludeBox: TGroupBox;
    AntCheck: TCheckBox;
    PherAddCheck: TCheckBox;
    PherDecayCheck: TCheckBox;
    AntFacCheck: TCheckBox;
    PherInitCheck: TCheckBox;
    GreedCheck: TCheckBox;
    AgeCheck: TCheckBox;
    AlphaEdit: TLabeledEdit;
    BetaEdit: TLabeledEdit;
    AlgRadGrp: TRadioGroup;
    iterGlobalEdit: TLabeledEdit;
    AntenDirRadGrp: TRadioGroup;

    procedure BatchInit();
    procedure AntCheckClick(Sender: TObject);
    procedure PherAddCheckClick(Sender: TObject);
    procedure PherDecayCheckClick(Sender: TObject);
    procedure GreedCheckClick(Sender: TObject);
    procedure AgeCheckClick(Sender: TObject);

    procedure AntFacCheckClick(Sender: TObject);
    procedure PherInitCheckClick(Sender: TObject);
    procedure AntenTypeRadGrpClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure AlgRadGrpClick(Sender: TObject);

  private
    { Private declarations }
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
  else if(AntenTypeRadGrp.ItemIndex <> AFNONE) then begin
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

procedure TBForm.AntenTypeRadGrpClick(Sender: TObject);
begin
  if(AntenTypeRadGrp.ItemIndex = AFNONE) then begin
    ASafB.Enabled := false;
    ASafS.Enabled := false;
    ASafE.Enabled := false;

    ACSafB.Enabled := false;
    ACSafS.Enabled := false;
    ACSafE.Enabled := false;

    AMTSafB.Enabled := false;
    AMTSafS.Enabled := false;
    AMTSafE.Enabled := false;

    MMafB.Enabled := false;
    MMafS.Enabled := false;
    MMafE.Enabled := false;
  end
  else begin
    ASafB.Enabled := true;
    ACSafB.Enabled := true;
    AMTSafB.Enabled := true;
    MMafB.Enabled := true;

    if(AntFacCheck.Checked = false) then begin
      ASafS.Enabled := true;
      ASafE.Enabled := true;

      ACSafS.Enabled := true;
      ACSafE.Enabled := true;

      AMTSafS.Enabled := true;
      AMTSafE.Enabled := true;

      MMafS.Enabled := true;
      MMafE.Enabled := true;
    end;
  end;
end;


procedure TBForm.FormCreate(Sender: TObject);
begin
  ASafB.Enabled := false;
  ASafS.Enabled := false;
  ASafE.Enabled := false;

  ACSafB.Enabled := false;
  ACSafS.Enabled := false;
  ACSafE.Enabled := false;

  AMTSafB.Enabled := false;
  AMTSafS.Enabled := false;
  AMTSafE.Enabled := false;

  MMafB.Enabled := false;
  MMafS.Enabled := false;
  MMafE.Enabled := false;

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

end.
