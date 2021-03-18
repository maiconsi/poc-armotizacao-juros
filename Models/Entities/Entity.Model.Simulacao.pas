unit Entity.Model.Simulacao;

interface

uses
  System.Generics.Collections;

type
  TSimulacaoParcela = class;

  TSimulacao = class
  private
    Ftaxa_juros: Currency;
    Fperiodo: Integer;
    Fcapital: Currency;
    Fparcelas: TObjectList<TSimulacaoParcela>;
    function GetTotalAmortizacao: Currency;
    function GetTotalJuros: Currency;
    function GetTotalPagamento: Currency;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
  published
    property capital: Currency read Fcapital write Fcapital;
    property taxa_juros: Currency read Ftaxa_juros write Ftaxa_juros;
    property periodo: Integer read Fperiodo write Fperiodo;

    property total_juros: Currency read GetTotalJuros;
    property total_amortizacao: Currency read GetTotalAmortizacao;
    property total_pagamento: Currency read GetTotalPagamento;
    property parcelas: TObjectList<TSimulacaoParcela> read Fparcelas write Fparcelas;
  end;

  TSimulacaoParcela = class
  private
    Fjuros: Currency;
    Fpagamento: Currency;
    Fsaldo_devedor: Currency;
    Famortizacao: Currency;
    Fparcela: Integer;
  published
    property parcela: Integer read Fparcela write Fparcela;
    property juros: Currency read Fjuros write Fjuros;
    property amortizacao: Currency read Famortizacao write Famortizacao;
    property pagamento: Currency read Fpagamento write Fpagamento;
    property saldo_devedor: Currency read Fsaldo_devedor write Fsaldo_devedor;
  end;

implementation

{ TSimulacao }

procedure TSimulacao.Clear;
begin
  Fcapital  :=  0;
  Fperiodo  :=  0;
  Ftaxa_juros:= 0;

  Fparcelas.Clear;
end;

constructor TSimulacao.Create;
begin
  Fparcelas :=  TObjectList<TSimulacaoParcela>.Create;

  Clear;
end;

destructor TSimulacao.Destroy;
begin
  Fparcelas.Free;

  inherited;
end;

function TSimulacao.GetTotalAmortizacao: Currency;
var
  LParcela: TSimulacaoParcela;
begin
  Result  :=  0;

  for LParcela in Fparcelas do
    Result:=  Result + LParcela.amortizacao;
end;

function TSimulacao.GetTotalJuros: Currency;
var
  LParcela: TSimulacaoParcela;
begin
  Result  :=  0;

  for LParcela in Fparcelas do
    Result:=  Result + LParcela.juros;
end;

function TSimulacao.GetTotalPagamento: Currency;
var
  LParcela: TSimulacaoParcela;
begin
  Result  :=  0;

  for LParcela in Fparcelas do
    Result:=  Result + LParcela.pagamento;
end;

end.
