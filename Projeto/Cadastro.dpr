program Cadastro;

uses
  Vcl.Forms,
  frmCadClientes in '..\Forms\frmCadClientes.pas' {frmCadUser},
  DmCli in '..\Forms\DmCli.pas' {DmCadCli: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmCadUser, frmCadUser);
  Application.CreateForm(TDmCadCli, DmCadCli);
  Application.Run;
end.
