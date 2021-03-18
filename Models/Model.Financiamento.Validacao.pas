unit Model.Financiamento.Validacao;

interface

uses
  Model.Financiamento.Interfaces;

type
  TModelFinanciamentoValidacao = class(TInterfacedObject, iModelFinanciamentoValidacao)
  private
    FParent: iModelFinanciamentoConfig;
  public
    constructor Create(AParent: iModelFinanciamentoConfig);
    destructor Destroy; override;
    class function New(AParent: iModelFinanciamentoConfig): iModelFinanciamentoValidacao;

    function Capital: iModelFinanciamentoValidar;
    function MesesPagamento: iModelFinanciamentoValidar;
    function TaxaJuros: iModelFinanciamentoValidar;
  end;

implementation

uses
  Model.Financiamento.Validar.Capital,
  Model.Financiamento.Validar.MesesPagamento,
  Model.Financiamento.Validar.TaxaJuros;

{ TModelFinanciamentoValidacao }

function TModelFinanciamentoValidacao.Capital: iModelFinanciamentoValidar;
begin
  Result  :=  TModelFinanciamentoValidarCapital.New(FParent);
end;

constructor TModelFinanciamentoValidacao.Create(AParent: iModelFinanciamentoConfig);
begin
  FParent :=  AParent;
end;

destructor TModelFinanciamentoValidacao.Destroy;
begin

  inherited;
end;

function TModelFinanciamentoValidacao.MesesPagamento: iModelFinanciamentoValidar;
begin
  Result  :=  TModelFinanciamentoValidarMesesPagamento.New(FParent);
end;

class function TModelFinanciamentoValidacao.New(AParent: iModelFinanciamentoConfig): iModelFinanciamentoValidacao;
begin
  Result := Self.Create(AParent);
end;

function TModelFinanciamentoValidacao.TaxaJuros: iModelFinanciamentoValidar;
begin
  Result  :=  TModelFinanciamentoValidarTaxaJuros.New(FParent);
end;

end.
