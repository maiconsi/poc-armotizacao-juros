unit Model.Financiamento.Factory;

interface

uses
  Model.Financiamento.Factory.Interfaces,
  Model.Financiamento.Interfaces;

type
  TModelFinanciamentoFactory = class(TInterfacedObject, iModelFinanciamentoFactory)
  private
  public
    constructor Create();
    destructor Destroy; override;
    class function New(): iModelFinanciamentoFactory;

    function Financiamento: iModelFinanciamento;
  end;

implementation

uses
  Model.Financiamento;

{ TModelFinanciamentoFactory }

constructor TModelFinanciamentoFactory.Create;
begin

end;

destructor TModelFinanciamentoFactory.Destroy;
begin

  inherited;
end;

function TModelFinanciamentoFactory.Financiamento: iModelFinanciamento;
begin
  Result  :=  TModelFinanciamento.New;
end;

class function TModelFinanciamentoFactory.New: iModelFinanciamentoFactory;
begin
  Result := Self.Create();
end;

end.
