unit Model.Financiamento.Factory.Interfaces;

interface

uses
  Model.Financiamento.Interfaces;

type
  iModelFinanciamentoFactory = interface
    ['{4E07CB4C-E049-45CC-A11E-7520C9F93203}']
    function Financiamento: iModelFinanciamento;
  end;

implementation

end.
