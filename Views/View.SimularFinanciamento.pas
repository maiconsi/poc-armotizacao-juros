unit View.SimularFinanciamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Controller.Financiamento.Interfaces, Vcl.Samples.Spin, Vcl.StdCtrls,
  Vcl.ExtCtrls, System.Actions, Vcl.ActnList, Vcl.Grids, View.Base, Vcl.Mask;

type
  TFormSimularFinanciamento = class(TFormBase)
    PanCabecalho: TPanel;
    EdtValorCapital: TLabeledEdit;
    EdtTaxaJuros: TLabeledEdit;
    Label3: TLabel;
    EdtMesesPagar: TSpinEdit;
    Panel1: TPanel;
    Label1: TLabel;
    BtnSimular: TButton;
    ActionList1: TActionList;
    AcSimularFinanciamento: TAction;
    PanResultado: TPanel;
    stgSimulacao: TStringGrid;
    procedure AcSimularFinanciamentoExecute(Sender: TObject);
    procedure EdtValorCapitalExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EdtTaxaJurosExit(Sender: TObject);
    procedure EdtMesesPagarChange(Sender: TObject);
    procedure stgSimulacaoDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
    procedure EdtValorCapitalKeyPress(Sender: TObject; var Key: Char);
    procedure EdtTaxaJurosKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FController: iControllerFinanciamento;
    procedure PreencherGrid;
    procedure AjustarGrid;
  public
    { Public declarations }
  end;

var
  FormSimularFinanciamento: TFormSimularFinanciamento;

implementation

uses
  Controller.Financiamento.Factory, Entity.Model.Simulacao;

{$R *.dfm}

{ TFormSimularFinanciamento }

procedure TFormSimularFinanciamento.AcSimularFinanciamentoExecute(
  Sender: TObject);
begin
  FController
    .Capital(EdtValorCapital.Text)
    .TaxaJuros(EdtTaxaJuros.Text)
    .MesesPagamento(EdtMesesPagar.Value);

  if Not FController.CapitalIsValid then
  begin
    MessageDlg(Format('Valor do capital(%s) inválido!', [EdtValorCapital.Text]), mtWarning, [mbOK], 0, mbOK);
    EdtValorCapital.SetFocus;
    Exit;
  end;

  if Not FController.TaxaJurosIsValid then
  begin
    MessageDlg(Format('Taxa de juros(%s) inválida!', [EdtTaxaJuros.Text]), mtWarning, [mbOK], 0, mbOK);
    EdtTaxaJuros.SetFocus;
    Exit;
  end;

  if Not FController.MesesPagamentoIsValid then
  begin
    MessageDlg(Format('Meses para pagamento(%s) inválido!', [EdtMesesPagar.Text]), mtWarning, [mbOK], 0, mbOK);
    EdtMesesPagar.SetFocus;
    Exit;
  end;

  FController.RealizarSimulacao;

  PreencherGrid;
end;

procedure TFormSimularFinanciamento.AjustarGrid;
begin
  stgSimulacao.ColCount :=  5;
  stgSimulacao.RowCount :=  2;

  //Titulos das colunas
  stgSimulacao.Cells[0,0] :=  'n';
  stgSimulacao.Cells[1,0] :=  'Juros';
  stgSimulacao.Cells[2,0] :=  'Amortização Saldo devedor';
  stgSimulacao.Cells[3,0] :=  'Pagamento';
  stgSimulacao.Cells[4,0] :=  'Saldo devedor';
end;

procedure TFormSimularFinanciamento.EdtMesesPagarChange(Sender: TObject);
begin
  FController.MesesPagamento(EdtMesesPagar.Value);
end;

procedure TFormSimularFinanciamento.EdtTaxaJurosExit(Sender: TObject);
begin
  if EdtTaxaJuros.Text <> '' then
    EdtTaxaJuros.Text  :=  FloatToStrF(StrToFloatDef(EdtTaxaJuros.Text, 0), ffFixed, 15, 2);
end;

procedure TFormSimularFinanciamento.EdtTaxaJurosKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if not (Key in ['0'..'9', #8, ',']) then
    key := #0;
end;

procedure TFormSimularFinanciamento.EdtValorCapitalExit(Sender: TObject);
begin
  if EdtValorCapital.Text <> '' then
    EdtValorCapital.Text  :=  FloatToStrF(StrToFloatDef(EdtValorCapital.Text, 0), ffFixed, 15, 2);
end;

procedure TFormSimularFinanciamento.EdtValorCapitalKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if not (Key in ['0'..'9', #8, ',']) then
    key := #0;
end;

procedure TFormSimularFinanciamento.FormCreate(Sender: TObject);
begin
  FController :=  TControllerFinanciamentoFactory.New.Financiamento;

  AjustarGrid;
end;

procedure TFormSimularFinanciamento.FormShow(Sender: TObject);
begin
  inherited;
  EdtValorCapital.SetFocus;
end;

procedure TFormSimularFinanciamento.PreencherGrid;
var
  LParcela: TSimulacaoParcela;
  LLinha: Integer;
begin
  LLinha  :=  0;

  stgSimulacao.RowCount :=  EdtMesesPagar.Value + 3;

  for LParcela in FController.DadosSimulacao.parcelas do
  begin
    LLinha  :=  LParcela.parcela + 1;

    stgSimulacao.Cells[0, LLinha] :=  LParcela.parcela.ToString;
    stgSimulacao.Cells[1, LLinha] :=  FormatFloat('###,##0.00', LParcela.juros);
    stgSimulacao.Cells[2, LLinha] :=  FormatFloat('###,##0.00', LParcela.amortizacao);
    stgSimulacao.Cells[3, LLinha] :=  FormatFloat('###,##0.00', LParcela.pagamento);
    stgSimulacao.Cells[4, LLinha] :=  FormatFloat('###,##0.00', LParcela.saldo_devedor);
  end;

  //Totalizador
  LLinha  :=  LLinha + 1;
  stgSimulacao.Cells[0, LLinha] :=  'Totais';
  stgSimulacao.Cells[1, LLinha] :=  FormatFloat('###,##0.00', FController.DadosSimulacao.total_juros);
  stgSimulacao.Cells[2, LLinha] :=  FormatFloat('###,##0.00', FController.DadosSimulacao.capital);
  stgSimulacao.Cells[3, LLinha] :=  FormatFloat('###,##0.00', FController.DadosSimulacao.total_pagamento);
  stgSimulacao.Cells[4, LLinha] :=  '';
end;

procedure TFormSimularFinanciamento.stgSimulacaoDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  LCellText :String;
begin
  if (gdFixed in State) then
  begin
    stgSimulacao.Canvas.Brush.Color := clWhite;
    stgSimulacao.Canvas.Font.Style  := [fsBold];
  end
  else
  begin
    if ARow = stgSimulacao.Row then
      stgSimulacao.Canvas.Brush.Color := clSkyBlue
    else
      stgSimulacao.Canvas.Brush.Color := clWhite;

    if (ARow = Pred(stgSimulacao.RowCount)) then
      stgSimulacao.Canvas.Font.Style  := [fsBold]
    else
      stgSimulacao.Canvas.Font.Style  := [];
  end;

  stgSimulacao.Canvas.FillRect(Rect);

  LCellText := stgSimulacao.Cells[ACol, ARow];
  Rect.Top  :=  Rect.Top + 4;
  DrawText(stgSimulacao.Canvas.Handle, PChar(LCellText), -1, Rect, DT_CENTER);
end;

end.
