unit Controller.Financiamento.Factory;

interface

uses
  Controller.Financiamento.Factory.Interfaces,
  Controller.Financiamento.Interfaces;

type
  TControllerFinanciamentoFactory = class(TInterfacedObject, iControllerFinanciamentoFactory)
  private
  public
    constructor Create();
    destructor Destroy; override;
    class function New(): iControllerFinanciamentoFactory;

    function Financiamento: iControllerFinanciamento;
  end;

implementation

uses
  Controller.Financiamento;

{ TControllerFinanciamentoFactory }

constructor TControllerFinanciamentoFactory.Create;
begin

end;

destructor TControllerFinanciamentoFactory.Destroy;
begin

  inherited;
end;

function TControllerFinanciamentoFactory.Financiamento: iControllerFinanciamento;
begin
  Result  :=  TControllerFinanciamento.New;
end;

class function TControllerFinanciamentoFactory.New: iControllerFinanciamentoFactory;
begin
  Result := Self.Create();
end;

end.
