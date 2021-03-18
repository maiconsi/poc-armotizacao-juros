unit Model.Financiamento;

interface

uses
  Model.Financiamento.Interfaces, Entity.Model.Simulacao;

type
  TModelFinanciamento = class(TInterfacedObject, iModelFinanciamento, iModelFinanciamentoConfig)
  private
    FCapital: Currency;
    FMesesPagamento: Integer;
    FTaxaJuros: Currency;
    FDadosSimulacao: TSimulacao;
  public
    constructor Create();
    destructor Destroy; override;
    class function New(): iModelFinanciamento;

    //iModelFinanciamento
    function Capital(AValue: Currency): iModelFinanciamento; overload;
    function MesesPagamento(AValue: Integer): iModelFinanciamento; overload;
    function TaxaJuros(AValue: Currency): iModelFinanciamento; overload;
    function Validacao: iModelFinanciamentoValidacao;
    function DadosSimulacao: TSimulacao;
    function RealizarSimulacao: iModelFinanciamento;

    //iModelFinanciamentoConfig
    function Capital: Currency; overload;
    function MesesPagamento: Integer; overload;
    function TaxaJuros: Currency; overload;
    function This: iModelFinanciamento;
  end;

implementation

uses
  Model.Financiamento.Simular, System.SysUtils, Model.Financiamento.Validacao;

{ TModelFinanciamento }

function TModelFinanciamento.Capital(AValue: Currency): iModelFinanciamento;
begin
  Result  :=  Self;

  FCapital  :=  AValue;
end;

function TModelFinanciamento.Capital: Currency;
begin
  Result  :=  FCapital;
end;

constructor TModelFinanciamento.Create;
begin
  FDadosSimulacao :=  TSimulacao.Create;
end;

function TModelFinanciamento.DadosSimulacao: TSimulacao;
begin
  Result  :=  FDadosSimulacao;
end;

destructor TModelFinanciamento.Destroy;
begin
  FDadosSimulacao.Free;

  inherited;
end;

function TModelFinanciamento.MesesPagamento: Integer;
begin
  Result  :=  FMesesPagamento;
end;

function TModelFinanciamento.MesesPagamento(
  AValue: Integer): iModelFinanciamento;
begin
  Result  :=  Self;

  FMesesPagamento  :=  AValue;
end;

class function TModelFinanciamento.New: iModelFinanciamento;
begin
  Result := Self.Create();
end;

function TModelFinanciamento.RealizarSimulacao: iModelFinanciamento;
begin
  Result  :=  Self;

  TModelFinanciamentoSimular.New(Self)
    .Execute;
end;

function TModelFinanciamento.TaxaJuros: Currency;
begin
  Result  :=  FTaxaJuros;
end;

function TModelFinanciamento.This: iModelFinanciamento;
begin
  Result  :=  Self;
end;

function TModelFinanciamento.Validacao: iModelFinanciamentoValidacao;
begin
  Result  :=  TModelFinanciamentoValidacao.New(Self);
end;

function TModelFinanciamento.TaxaJuros(AValue: Currency): iModelFinanciamento;
begin
  Result  :=  Self;

  FTaxaJuros  :=  AValue;
end;

end.
