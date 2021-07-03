program Demo;

uses
  Vcl.Forms,
  View.Principal in 'src\View.Principal.pas' {frmPrincipal},
  Model.Demo in 'src\Model.Demo.pas' {dtmdlDemo: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdtmdlDemo, dtmdlDemo);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
