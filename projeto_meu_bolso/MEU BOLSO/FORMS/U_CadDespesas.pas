unit U_CadDespesas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Buttons,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask,
  Vcl.DBCtrls, Vcl.WinXPanels, Vcl.WinXCtrls;

type
  TfrmDespesas = class(TForm)
    pnlCabecalho: TPanel;
    pnlRodape: TPanel;
    btnNovo: TSpeedButton;
    btnDeletar: TSpeedButton;
    btnEditar: TSpeedButton;
    btnSalvar: TSpeedButton;
    btnCancelar: TSpeedButton;
    Q_Despesas: TFDQuery;
    DS_Despesas: TDataSource;
    cardPrincipal: TPanel;
    Q_DespesasID_COMPRA: TFDAutoIncField;
    Q_DespesasDT_COMPRA: TDateField;
    Q_DespesasDT_VENC: TDateField;
    Q_DespesasPRODUTO: TStringField;
    Q_DespesasONDE: TStringField;
    Q_DespesasCARTAO: TStringField;
    Q_DespesasV_COMPRA: TFMTBCDField;
    Q_DespesasV_PARC: TFMTBCDField;
    Q_DespesasNUM_PARC: TCurrencyField;
    Q_DespesasCADASTRO: TDateField;
    CardPanel1: TCardPanel;
    CardDespesasPF: TCard;
    Label2: TLabel;
    txtDespesa: TDBEdit;
    Label3: TLabel;
    txtDtCadastro: TDBEdit;
    Label4: TLabel;
    txtDtCompra: TDBEdit;
    Label5: TLabel;
    txtOnde: TDBEdit;
    Label6: TLabel;
    txtDtVenc: TDBEdit;
    Label8: TLabel;
    txtCartao: TDBEdit;
    txtFormaPgto: TComboBox;
    Label9: TLabel;
    Q_DespesasPAGAMENTO_FUNC: TFMTBCDField;
    Q_DespesasINTERNET_PJ: TFMTBCDField;
    Q_DespesasIMPOSTOS: TFMTBCDField;
    Q_DespesasFERIAS_FUNC: TFMTBCDField;
    Q_DespesasDECIMO13_FUN: TFMTBCDField;
    Label10: TLabel;
    txtValorCompra: TDBEdit;
    Label11: TLabel;
    txtValorParcela: TDBEdit;
    Label12: TLabel;
    txtNumParc: TDBEdit;
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    procedure btnNovoClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnDeletarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
  private
    { Private declarations }
    procedure limparCampos;
    procedure desbloquerCampos;
    procedure bloquearCampos;
  public
    { Public declarations }
  end;

var
  frmDespesas: TfrmDespesas;

implementation

{$R *.dfm}

uses U_DM;

procedure TfrmDespesas.bloquearCampos;
begin
  txtDespesa.Enabled := False;
  txtDtCadastro.Enabled := False;
//  txtDtCadastro.Text := DateToStr(now);
//  txtDtCompra.Text := DateToStr(now);
  txtDtCompra.Enabled := False;
  txtDtVenc.Enabled := False;
  txtOnde.Enabled := False;
  txtCartao.Enabled := False;
  txtNumParc.Enabled := False;
  txtValorCompra.Enabled := False;
  txtValorParcela.Enabled := False;
end;

procedure TfrmDespesas.desbloquerCampos;
begin
  txtDespesa.Enabled := True;
  txtDtCadastro.Enabled := True;
  txtDtCadastro.Text := DateToStr(now);
  txtDtCompra.Enabled := True;
  txtDtCompra.Text := DateToStr(now);
  txtOnde.Enabled := True;
  txtCartao.Enabled := True;
  txtNumParc.Enabled := True;
  txtValorCompra.Enabled := True;
  txtValorParcela.Enabled := True;
end;

procedure TfrmDespesas.btnCancelarClick(Sender: TObject);
begin
  Q_Despesas.Cancel;
  btnDeletar.Enabled := False;
  btnEditar.Enabled := False;
  btnSalvar.Enabled := False;

  bloquearCampos;

  Messagedlg('A��o cancelada pelo usu�rio!', mtInformation, [mbOk], 0);
end;

procedure TfrmDespesas.btnDeletarClick(Sender: TObject);
begin
  if Messagedlg('Deseja deletar este registro?', mtConfirmation, [mbOk, mbNo],
    0) = mrOk then
  begin
    Q_Despesas.Delete;
    Messagedlg('Registro deletado com sucesso.', mtInformation, [mbOk], 0);
  end
  else
    abort;
end;

procedure TfrmDespesas.btnEditarClick(Sender: TObject);
begin
  if Messagedlg('Deseja editar este registro?', mtConfirmation, [mbOk, mbNo], 0)
    = mrOk then
  begin
    Q_Despesas.edit;
    btnSalvar.Enabled := True;
    btnEditar.Enabled := False;
    desbloquerCampos;
  end
  else
    abort;
end;

procedure TfrmDespesas.btnNovoClick(Sender: TObject);
begin
  Q_Despesas.Open;
  Q_Despesas.Append;

  // if CardDespesasPF.Active then
  // begin
  btnDeletar.Enabled := False;
  btnEditar.Enabled := False;
  btnSalvar.Enabled := True;

  desbloquerCampos;
  txtDtCadastro.Text := DateToStr(now);
  txtDtCompra.Text := DateToStr(now);
  txtDespesa.SetFocus;
  // end

  // Else if CardDespesasPJ.Active then
  // begin
  // btnDeletar.Visible := False;
  // btnEditar.Visible := False;
  // btnSalvar.Visible := True;
  // txtDtCadastroPJ.Text := DateToStr(now);
  // txtDtCompraPJ.Text := DateToStr(now);
  // txtProdutoPJ.SetFocus;
  // end

end;

procedure TfrmDespesas.btnSalvarClick(Sender: TObject);
begin
  // salvar o registro
  try
    // if txtDespesa.Text = '' then
    // begin
    // Messagedlg('Campo descri��o estar em branco!', mtInformation, [mbOk], 0);
    // txtDespesa.SetFocus;
    // Exit;
    // end;

    // LStatus := 'F';
    //
    // if txtStatus.State = tssOff then
    // LStatus := 'J';
    // Q_PadraoSTATUS.AsString := LStatus;

    // DMUSUARIO.cdsUsuariosSTATUS.AsString := Lstatus;

    // if CardDespesasPF.Active then
    // begin
    Q_Despesas.Post;
    Messagedlg('Registro salvo com sucesso!', mtInformation, [mbOk], 0);
    limparCampos;
    btnSalvar.Enabled := False;
    // end;
    // if CardDespesasPJ.Active then
    // begin
    // Q_Despesas.Post;
    // Messagedlg('Registro salvo com sucesso!', mtInformation, [mbOk], 0);
    // end;
  except
    ShowMessage('Erro nas grava��o dos dados,verifique!');
  end;
end;

procedure TfrmDespesas.DBGrid1DblClick(Sender: TObject);
begin
  btnEditar.Enabled := True;
end;

procedure TfrmDespesas.FormKeyPress(Sender: TObject; var Key: Char);
begin
  // Faz a tecla enter assumir a fun��o da tecla TAB
  if Key = #13 then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TfrmDespesas.FormShow(Sender: TObject);
begin
  bloquearCampos;
  Q_Despesas.Open;

end;

procedure TfrmDespesas.limparCampos;
begin
  // txtCodCompra.Text := '';
  txtDespesa.Text := '';
  txtDtCadastro.Text := DateToStr(now);
  txtDtCompra.Text := DateToStr(now);
  txtOnde.Text := '';
  txtCartao.Text := '0';
  txtNumParc.Text := '0';
  txtValorCompra.Text := '0';
  txtValorParcela.Text := '0';

end;

end.
