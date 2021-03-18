unit Controller.Financiamento.Factory.Interfaces;

interface

uses
  Controller.Financiamento.Interfaces;

type
  iControllerFinanciamentoFactory = interface
    ['{CEABB225-77A7-4DCE-AECF-D8A13E2C8385}']
    function Financiamento: iControllerFinanciamento;
  end;

implementation

end.
