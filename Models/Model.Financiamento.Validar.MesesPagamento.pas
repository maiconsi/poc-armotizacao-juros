unit Model.Financiamento.Validar.MesesPagamento;

interface

uses
  Model.Financiamento.Interfaces;

type
  TModelFinanciamentoValidarMesesPagamento = class(TInterfacedObject, iModelFinanciamentoValidar)
  private
    FParent: iModelFinanciamentoConfig;
  public
    constructor Create(AParent: iModelFinanciamentoConfig);
    destructor Destroy; override;
    class function New(AParent: iModelFinanciamentoConfig): iModelFinanciamentoValidar;

    function IsValid: Boolean;
  end;

implementation

{ TModelFinanciamentoValidarMesesPagamento }

constructor TModelFinanciamentoValidarMesesPagamento.Create(AParent: iModelFinanciamentoConfig);
begin
  FParent :=  AParent;
end;

destructor TModelFinanciamentoValidarMesesPagamento.Destroy;
begin

  inherited;
end;

function TModelFinanciamentoValidarMesesPagamento.IsValid: Boolean;
begin
  Result  :=  (FParent.MesesPagamento > 0);
end;

class function TModelFinanciamentoValidarMesesPagamento.New(AParent: iModelFinanciamentoConfig): iModelFinanciamentoValidar;
begin
  Result := Self.Create(AParent);
end;

end.

