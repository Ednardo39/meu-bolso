program MEU_BOLSO;

uses
  Vcl.Forms,
  U_CadDespesas in 'U_CadDespesas.pas' {frmDespesas},
  U_DM in 'U_DM.pas' {DM: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmDespesas, frmDespesas);
  Application.CreateForm(TDM, DM);
  Application.Run;
end.
