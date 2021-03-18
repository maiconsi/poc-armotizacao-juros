unit Model.Financiamento.Simular;

interface

uses
  Model.Financiamento.Interfaces;

type
  TModelFinanciamentoSimular = class(TInterfacedObject, iModelFinanciamentoSimular)
  private
    FParent: iModelFinanciamentoConfig;
    procedure GeraParcelas;
  public
    constructor Create(AParent: iModelFinanciamentoConfig);
    destructor Destroy; override;
    class function New(AParent: iModelFinanciamentoConfig): iModelFinanciamentoSimular;

    function Execute: iModelFinanciamento;
  end;

implementation

uses
  Entity.Model.Simulacao, System.SysUtils;

{ TModelFinanciamentoSimular }

procedure TModelFinanciamentoSimular.GeraParcelas;
var
  LParcela: TSimulacaoParcela;
  I: Integer;

  LSaldoDevedor: Currency;
  LValorJuros: Currency;
begin
  LParcela  :=  TSimulacaoParcela.Create;
  LParcela.parcela      :=  0;
  LParcela.juros        :=  0;
  LParcela.amortizacao  :=  0;
  LParcela.pagamento    :=  0;
  LParcela.saldo_devedor:=  FParent.Capital;
  FParent.DadosSimulacao.parcelas.Add(LParcela);

  LSaldoDevedor :=  FParent.Capital;
  for I := 1 to FParent.MesesPagamento do
  begin
    LValorJuros   :=  (LSaldoDevedor * (FParent.TaxaJuros / 100));
    LSaldoDevedor :=  LSaldoDevedor + LValorJuros;

    LParcela  :=  TSimulacaoParcela.Create;
    LParcela.parcela      :=  I;
    LParcela.juros        :=  LValorJuros;
    if I = FParent.MesesPagamento then
    begin
      LParcela.amortizacao  :=  FParent.Capital;
      LParcela.pagamento    :=  LSaldoDevedor;
      LParcela.saldo_devedor:=  0;
    end
    else
    begin
      LParcela.amortizacao  :=  0;
      LParcela.pagamento    :=  0;
      LParcela.saldo_devedor:=  LSaldoDevedor;
    end;
    FParent.DadosSimulacao.parcelas.Add(LParcela);
  end;
end;

constructor TModelFinanciamentoSimular.Create(AParent: iModelFinanciamentoConfig);
begin
  FParent :=  AParent;
end;

destructor TModelFinanciamentoSimular.Destroy;
begin

  inherited;
end;

function TModelFinanciamentoSimular.Execute: iModelFinanciamento;
begin
  Result  :=  FParent.This;

  if Not FParent.This.Validacao.Capital.IsValid then
    raise Exception.Create('Valor do capital inválido!');

  if Not FParent.This.Validacao.TaxaJuros.IsValid then
    raise Exception.Create('Taxa de juros inválida!');

  if Not FParent.This.Validacao.MesesPagamento.IsValid then
    raise Exception.Create('Meses para pagamento inválido!');

  FParent.DadosSimulacao.Clear;
  FParent.DadosSimulacao.capital    :=  FParent.Capital;
  FParent.DadosSimulacao.periodo    :=  FParent.MesesPagamento;
  FParent.DadosSimulacao.taxa_juros :=  FParent.TaxaJuros;

  GeraParcelas;
end;

class function TModelFinanciamentoSimular.New(AParent: iModelFinanciamentoConfig): iModelFinanciamentoSimular;
begin
  Result := Self.Create(AParent);
end;

end.
