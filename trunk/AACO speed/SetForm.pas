unit SetForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, ComCtrls, StrUtils;

const
  ACOAS     = 0;
  ACOACS    = 1;
  ACOAMTS   = 2;
  ACOMM     = 3;

type
  TSForm = class(TForm)
    SettingsControl: TPageControl;
    ASTab: TTabSheet;
    ACSTab: TTabSheet;
    AMTSTab: TTabSheet;
    MinMaxTab: TTabSheet;
    CancelBtn: TBitBtn;
    AcceptBtn: TBitBtn;
    AlgRadGrp: TRadioGroup;
    ParGrpBox: TGroupBox;
    Label1: TLabel;
    ASAlphaEdit: TLabeledEdit;
    ASBetaEdit: TLabeledEdit;
    ASPherInitEdit: TLabeledEdit;
    ASPherDecayEdit: TLabeledEdit;
    ASPherAddEdit: TLabeledEdit;
    Label2: TLabel;
    ACSAlphaEdit: TLabeledEdit;
    ACSBetaEdit: TLabeledEdit;
    ACSPherInitEdit: TLabeledEdit;
    ACSPherDecayEdit: TLabeledEdit;
    ACSPherAddEdit: TLabeledEdit;
    AMTSAlphaEdit: TLabeledEdit;
    Label3: TLabel;
    AMTSBetaEdit: TLabeledEdit;
    AMTSPherInitEdit: TLabeledEdit;
    AMTSPherDecayEdit: TLabeledEdit;
    AMTSPherAddEdit: TLabeledEdit;
    ACSGreedyEdit: TLabeledEdit;
    AMTSAntLife: TLabeledEdit;
    SetPanel: TPanel;
    Label4: TLabel;
    SetNumAntsEdit: TEdit;
    Label5: TLabel;
    MMAlphaEdit: TLabeledEdit;
    MMBetaEdit: TLabeledEdit;
    MMPherDecayEdit: TLabeledEdit;
    MMPherInitEdit: TLabeledEdit;
    MMPherAddEdit: TLabeledEdit;
    SetMemo: TMemo;
    MMIterGlobalEdit: TLabeledEdit;
    procedure AlgRadGrpClick(Sender: TObject);
    procedure FormInit();
  private
    { Private declarations }
    settings: TStringList;
    size: integer;
    setOK : bool;
  public
    { Public declarations }

  end;

var
  SForm: TSForm;

implementation

{$R *.dfm}

procedure TSForm.FormInit();
var i: integer;
begin
  settingsControl.ActivePageIndex := 0;
  setMemo.Clear;
  if FileExists('settings.txt') then begin
    settings := TStringList.Create;
    settings.LoadFromFile('settings.txt');
    size := settings.Count -1;
    i:= 0;
    while ((CompareStr(settings.Strings[i], '\\AS') <> 0) and (i < size)) do
      inc(i);

    if (i <> size) then begin
      inc(i);
      while(AnsiContainsStr(settings.Strings[i], '\\') = false) do begin
        setMemo.Lines.Add(settings.Strings[i]);
        inc(i);
      end;
    end;
    setOK := true;
  end
  else begin
    setMemo.Lines.Add('Settings file not detected');
    setOK := false
  end;
end;

procedure TSForm.AlgRadGrpClick(Sender: TObject);
var i: integer;
begin
  i:= 0;
  case AlgRadGrp.ItemIndex of

    ACOAS:
    begin
      SettingsControl.ActivePageIndex := ACOAS;
      if(setOK = true) then begin
        setMemo.Clear;
        while ((CompareStr(settings.Strings[i], '\\AS') <> 0) and (i < size)) do
          inc(i);

        if (i <> size) then begin
          inc(i);
          while(AnsiContainsStr(settings.Strings[i], '\\') = false) do begin
            setMemo.Lines.Add(settings.Strings[i]);
            inc(i);
          end;
        end;
      end;
    end;

    ACOACS:
    begin
      SettingsControl.ActivePageIndex := ACOACS;
      if(setOK = true) then begin
        setMemo.Clear;
        while ((CompareStr(settings.Strings[i], '\\ACS') <> 0) and (i < size)) do
          inc(i);

        if (i <> size) then begin
          inc(i);
          while(AnsiContainsStr(settings.Strings[i], '\\') = false) do begin
            setMemo.Lines.Add(settings.Strings[i]);
            inc(i);
          end;
        end;
      end;
    end;

    ACOAMTS:
    begin
      SettingsControl.ActivePageIndex := ACOAMTS;
      if(setOK = true) then begin
        setMemo.Clear;
        while ((CompareStr(settings.Strings[i], '\\AMTS') <> 0) and (i < size)) do
          inc(i);

        if (i <> size) then begin
          inc(i);
          while(AnsiContainsStr(settings.Strings[i], '\\') = false) do begin
            setMemo.Lines.Add(settings.Strings[i]);
            inc(i);
          end;
        end;
      end;
    end;

    ACOMM:
    begin
      SettingsControl.ActivePageIndex := ACOMM;
      if(setOK = true) then begin
        setMemo.Clear;
        while ((CompareStr(settings.Strings[i], '\\MM') <> 0) and (i < size)) do
          inc(i);

        if (i <> size) then begin
          inc(i);
          while(AnsiContainsStr(settings.Strings[i], '\\') = false) do begin
            setMemo.Lines.Add(settings.Strings[i]);
            inc(i);
          end;
        end;
      end;
    end;
  end;
end;

end.
