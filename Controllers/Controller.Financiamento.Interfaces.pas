unit Controller.Financiamento.Interfaces;

interface

uses
  Entity.Model.Simulacao;

type
  iControllerFinanciamento = interface
    ['{7B3196CB-42A2-4AA1-8DC6-DA363A2C2E75}']
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

end.
