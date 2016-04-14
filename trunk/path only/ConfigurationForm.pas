unit ConfigurationForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TcfgForm = class(TForm)
    OkBtn: TBitBtn;
    AntsLblEdit: TLabeledEdit;
    BetaLblEdit: TLabeledEdit;
    AlphaLblEdit: TLabeledEdit;
    PherInitLblEdit: TLabeledEdit;
    PherDecayLblEdit: TLabeledEdit;
    CancelBtn: TBitBtn;
    PherAddLblEdit: TLabeledEdit;
    AntFacEdit: TLabeledEdit;

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  cfgForm: TcfgForm;

implementation

{$R *.dfm}


end.
