unit Model.Financiamento.Interfaces;

interface

uses
  Entity.Model.Simulacao;

type
  iModelFinanciamentoValidar = interface;
  iModelFinanciamentoValidacao = interface;

  iModelFinanciamento = interface
    ['{64A8E77F-46C5-491C-A7FB-448B2E023C17}']
    function Capital(AValue: Currency): iModelFinanciamento;
    function MesesPagamento(AValue: Integer): iModelFinanciamento;
    function TaxaJuros(AValue: Currency): iModelFinanciamento;
    function Validacao: iModelFinanciamentoValidacao;
    function DadosSimulacao: TSimulacao;

    function RealizarSimulacao: iModelFinanciamento;
  end;

  iModelFinanciamentoConfig = interface
    ['{8C3908C9-6C18-4D55-B424-318B5487955D}']
    function Capital: Currency;
    function MesesPagamento: Integer;
    function TaxaJuros: Currency;
    function DadosSimulacao: TSimulacao;
    function This: iModelFinanciamento;
  end;

  iModelFinanciamentoSimular = interface
    ['{43EF9792-B853-4A3E-AB2F-9271401B9A7B}']
    function Execute: iModelFinanciamento;
  end;

  iModelFinanciamentoValidar = interface
    ['{1E01B872-7D22-49E1-8D58-D26ECFB3F7BB}']
    function IsValid: Boolean;
  end;

  iModelFinanciamentoValidacao = interface
    ['{EDC590F2-FD38-48D1-879B-5958E55240F2}']
    function Capital: iModelFinanciamentoValidar;
    function MesesPagamento: iModelFinanciamentoValidar;
    function TaxaJuros: iModelFinanciamentoValidar;
  end;

implementation

end.
