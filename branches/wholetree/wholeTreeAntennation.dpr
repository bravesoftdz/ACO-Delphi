program wholeTreeAntennation;

uses
  Forms,
  Main in 'Main.pas' {ACOForm},
  Ant in 'Ant.pas',
  PherMap in 'PherMap.pas',
  BatchForm in 'BatchForm.pas' {BForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TACOForm, ACOForm);
  Application.CreateForm(TBForm, BForm);
  Application.Run;
end.
