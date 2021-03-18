unit Controller.Financiamento;

interface

uses
  Controller.Financiamento.Interfaces,
  Model.Financiamento.Interfaces,
  Entity.Model.Simulacao;

type
  TControllerFinanciamento = class(TInterfacedObject, iControllerFinanciamento)
  private
    FModelFinanciamento: iModelFinanciamento;
  public
    constructor Create();
    destructor Destroy; override;
    class function New(): iControllerFinanciamento;

    function Capital(AValue: Currency): iControllerFinanciamento; overload;
    function Capital(AValue: String): iControllerFinanciamento; overload;
    function TaxaJuros(AValue: Currency): iControllerFinanciamento; overload;
    function TaxaJuros(AValue: String): iControllerFinanciamento; overload;
    function MesesPagamento(AValue: Integer): iControllerFinanciamento;
    function CapitalIsValid: Boolean;
    function TaxaJurosIsValid: Boolean;
    function MesesPagamentoIsValid: Boolean;
    function DadosSimulacao: TSimulacao;
    function RealizarSimulacao: iControllerFinanciamento;
  end;

implementation

uses
  Model.Financiamento.Factory, System.SysUtils;

{ TControllerFinanciamento }

function TControllerFinanciamento.Capital(
  AValue: Currency): iControllerFinanciamento;
begin
  Result  :=  Self;

  FModelFinanciamento.Capital(AValue);
end;

function TControllerFinanciamento.Capital(
  AValue: String): iControllerFinanciamento;
begin
  Result  :=  Self;

  FModelFinanciamento.Capital(StrToFloatDef(AValue, 0));
end;

function TControllerFinanciamento.CapitalIsValid: Boolean;
begin
  Result  :=  FModelFinanciamento.Validacao.Capital.IsValid;
end;

constructor TControllerFinanciamento.Create;
begin
  FModelFinanciamento :=  TModelFinanciamentoFactory.New.Financiamento;
end;

function TControllerFinanciamento.DadosSimulacao: TSimulacao;
begin
  Result  :=  FModelFinanciamento.DadosSimulacao;
end;

destructor TControllerFinanciamento.Destroy;
begin

  inherited;
end;

function TControllerFinanciamento.MesesPagamento(
  AValue: Integer): iControllerFinanciamento;
begin
  Result  :=  Self;

  FModelFinanciamento.MesesPagamento(AValue);
end;

function TControllerFinanciamento.MesesPagamentoIsValid: Boolean;
begin
  Result  :=  FModelFinanciamento.Validacao.MesesPagamento.IsValid;
end;

class function TControllerFinanciamento.New: iControllerFinanciamento;
begin
  Result := Self.Create();
end;

function TControllerFinanciamento.RealizarSimulacao: iControllerFinanciamento;
begin
  Result  :=  Self;

  FModelFinanciamento
    .RealizarSimulacao;
end;

function TControllerFinanciamento.TaxaJuros(
  AValue: String): iControllerFinanciamento;
begin
  Result  :=  Self;

  FModelFinanciamento.TaxaJuros(StrToFloatDef(AValue, 0));
end;

function TControllerFinanciamento.TaxaJurosIsValid: Boolean;
begin
  Result  :=  FModelFinanciamento.Validacao.TaxaJuros.IsValid;
end;

function TControllerFinanciamento.TaxaJuros(
  AValue: Currency): iControllerFinanciamento;
begin
  Result  :=  Self;

  FModelFinanciamento.TaxaJuros(AValue);
end;

end.
