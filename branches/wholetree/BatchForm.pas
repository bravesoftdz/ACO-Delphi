unit BatchForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TBForm = class(TForm)
    startBox: TGroupBox;
    NumAntsB: TLabeledEdit;
    PherAddB: TLabeledEdit;
    PherDecayB: TLabeledEdit;
    stepBox: TGroupBox;
    pherAddS: TLabeledEdit;
    PherDecayS: TLabeledEdit;
    endBox: TGroupBox;
    NumAntsE: TLabeledEdit;
    PherAddE: TLabeledEdit;
    PherDecayE: TLabeledEdit;
    genEdit: TLabeledEdit;
    iterEdit: TLabeledEdit;
    OkBtn: TBitBtn;
    txtNameEdit: TLabeledEdit;
    AntenRadGrp: TRadioGroup;
    cancelBtn: TBitBtn;
    NumAntsS: TLabeledEdit;
    AntFacB: TLabeledEdit;
    AntFacS: TLabeledEdit;
    AntFacE: TLabeledEdit;
    ExcludeBox: TGroupBox;
    AntCheck: TCheckBox;
    PherAddCheck: TCheckBox;
    PherDecayCheck: TCheckBox;
    AntFacCheck: TCheckBox;
    PherInitB: TLabeledEdit;
    PherInitS: TLabeledEdit;
    PherInitE: TLabeledEdit;
    PherInitCheck: TCheckBox;
    AlphaEdit: TLabeledEdit;
    BetaEdit: TLabeledEdit;
    procedure AntCheckClick(Sender: TObject);
    procedure PherAddCheckClick(Sender: TObject);
    procedure PherDecayCheckClick(Sender: TObject);
    procedure AntFacCheckClick(Sender: TObject);
    procedure PherInitCheckClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  BForm: TBForm;

implementation

{$R *.dfm}

procedure TBForm.AntCheckClick(Sender: TObject);
begin
  NumAntsS.Enabled := not AntCheck.Checked;
  NumAntsE.Enabled := not AntCheck.Checked;
  NumAntsS.Visible := not AntCheck.Checked;
  NumAntsE.Visible := not AntCheck.Checked;
end;

procedure TBForm.PherAddCheckClick(Sender: TObject);
begin
  PherAddS.Enabled := not PherAddCheck.Checked;
  PherAddE.Enabled := not PherAddCheck.Checked;
  PherAddS.Visible := not PherAddCheck.Checked;
  PherAddE.Visible := not PherAddCheck.Checked;
end;

procedure TBForm.PherDecayCheckClick(Sender: TObject);
begin
  PherDecayS.Enabled := not PherDecayCheck.Checked;
  PherDecayE.Enabled := not PherDecayCheck.Checked;
  PherDecayS.Visible := not PherDecayCheck.Checked;
  PherDecayE.Visible := not PherDecayCheck.Checked;
end;

procedure TBForm.AntFacCheckClick(Sender: TObject);
begin
  AntFacS.Enabled := not AntFacCheck.Checked;
  AntFacE.Enabled := not AntFacCheck.Checked;
  AntFacS.Visible := not AntFacCheck.Checked;
  AntFacE.Visible := not AntFacCheck.Checked;
end;

procedure TBForm.PherInitCheckClick(Sender: TObject);
begin
  PherInitS.Enabled := not PherInitCheck.Checked;
  PherInitE.Enabled := not PherInitCheck.Checked;
  PherInitS.Visible := not PherInitCheck.Checked;
  PherInitE.Visible := not PherInitCheck.Checked;
end;

end.
