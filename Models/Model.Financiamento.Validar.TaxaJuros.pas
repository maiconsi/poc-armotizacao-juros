unit Model.Financiamento.Validar.TaxaJuros;

interface

uses
  Model.Financiamento.Interfaces;

type
  TModelFinanciamentoValidarTaxaJuros = class(TInterfacedObject, iModelFinanciamentoValidar)
  private
    FParent: iModelFinanciamentoConfig;
  public
    constructor Create(AParent: iModelFinanciamentoConfig);
    destructor Destroy; override;
    class function New(AParent: iModelFinanciamentoConfig): iModelFinanciamentoValidar;

    function IsValid: Boolean;
  end;

implementation

{ TModelFinanciamentoValidarTaxaJuros }

constructor TModelFinanciamentoValidarTaxaJuros.Create(AParent: iModelFinanciamentoConfig);
begin
  FParent :=  AParent;
end;

destructor TModelFinanciamentoValidarTaxaJuros.Destroy;
begin

  inherited;
end;

function TModelFinanciamentoValidarTaxaJuros.IsValid: Boolean;
begin
  Result  :=  (FParent.TaxaJuros > 0) and (FParent.TaxaJuros < 100);
end;

class function TModelFinanciamentoValidarTaxaJuros.New(AParent: iModelFinanciamentoConfig): iModelFinanciamentoValidar;
begin
  Result := Self.Create(AParent);
end;

end.

