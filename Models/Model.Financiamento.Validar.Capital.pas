unit Model.Financiamento.Validar.Capital;

interface

uses
  Model.Financiamento.Interfaces;

type
  TModelFinanciamentoValidarCapital = class(TInterfacedObject, iModelFinanciamentoValidar)
  private
    FParent: iModelFinanciamentoConfig;
  public
    constructor Create(AParent: iModelFinanciamentoConfig);
    destructor Destroy; override;
    class function New(AParent: iModelFinanciamentoConfig): iModelFinanciamentoValidar;

    function IsValid: Boolean;
  end;

implementation

{ TModelFinanciamentoValidarCapital }

constructor TModelFinanciamentoValidarCapital.Create(AParent: iModelFinanciamentoConfig);
begin
  FParent :=  AParent;
end;

destructor TModelFinanciamentoValidarCapital.Destroy;
begin

  inherited;
end;

function TModelFinanciamentoValidarCapital.IsValid: Boolean;
begin
  Result  :=  (FParent.Capital > 0);
end;

class function TModelFinanciamentoValidarCapital.New(AParent: iModelFinanciamentoConfig): iModelFinanciamentoValidar;
begin
  Result := Self.Create(AParent);
end;

end.
