unit BatchForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

const
  AFNONE = 0;
  AFAMTS = 6;
                 
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
    procedure AntenRadGrpClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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
end;

procedure TBForm.PherAddCheckClick(Sender: TObject);
begin
  PherAddS.Enabled := not PherAddCheck.Checked;
  PherAddE.Enabled := not PherAddCheck.Checked;
end;

procedure TBForm.PherDecayCheckClick(Sender: TObject);
begin
  PherDecayS.Enabled := not PherDecayCheck.Checked;
  PherDecayE.Enabled := not PherDecayCheck.Checked;
end;

procedure TBForm.AntFacCheckClick(Sender: TObject);
begin
  if(AntFacCheck.Checked = true) then begin
    AntFacS.Enabled := false;
    AntFacE.Enabled := false;
  end
  else if((AntenRadGrp.ItemIndex <> AFNONE) and (AntenRadGrp.ItemIndex <> AFAMTS)) then begin
    AntFacS.Enabled := true;
    AntFacE.Enabled := true;
  end;
end;

procedure TBForm.PherInitCheckClick(Sender: TObject);
begin
  PherInitS.Enabled := not PherInitCheck.Checked;
  PherInitE.Enabled := not PherInitCheck.Checked;
end;


procedure TBForm.AntenRadGrpClick(Sender: TObject);
begin
  if ((AntenRadGrp.ItemIndex = AFNONE) or (AntenRadgrp.ItemIndex = AFAMTS)) then begin
    AntFacB.Enabled := false;
    AntFacS.Enabled := false;
    AntFacE.Enabled := false;
  end
  else begin
    AntFacB.Enabled := true;
    if(AntFacCheck.Checked = false) then begin
      AntFacS.Enabled := true;
      AntFacE.Enabled := true;
    end;
  end;
end;

procedure TBForm.FormCreate(Sender: TObject);
begin
  AntFacS.Enabled := false;
  AntFacE.Enabled := false;
  AntFacB.Enabled := false;
end;

end.
