program ExpandedAAS;

uses
  Forms,
  Main in 'Main.pas' {ACOForm},
  Ant in 'Ant.pas',
  PherMap in 'PherMap.pas',
  BatchForm in 'BatchForm.pas' {BForm},
  SetForm in 'SetForm.pas' {SForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TACOForm, ACOForm);
  Application.CreateForm(TBForm, BForm);
  Application.CreateForm(TSForm, SForm);
  Application.Run;
end.
