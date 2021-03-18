program Datapar;

uses
  Vcl.Forms,
  View.Principal in 'Views\View.Principal.pas' {FormPrincipal},
  View.Home in 'Views\View.Home.pas' {FormHome},
  View.SimularFinanciamento in 'Views\View.SimularFinanciamento.pas' {FormSimularFinanciamento},
  Controller.Financiamento.Interfaces in 'Controllers\Controller.Financiamento.Interfaces.pas',
  Controller.Financiamento in 'Controllers\Controller.Financiamento.pas',
  Model.Financiamento.Interfaces in 'Models\Model.Financiamento.Interfaces.pas',
  Model.Financiamento in 'Models\Model.Financiamento.pas',
  Model.Financiamento.Factory.Interfaces in 'Models\Model.Financiamento.Factory.Interfaces.pas',
  Model.Financiamento.Factory in 'Models\Model.Financiamento.Factory.pas',
  Controller.Financiamento.Factory.Interfaces in 'Controllers\Controller.Financiamento.Factory.Interfaces.pas',
  Controller.Financiamento.Factory in 'Controllers\Controller.Financiamento.Factory.pas',
  Entity.Model.Simulacao in 'Models\Entities\Entity.Model.Simulacao.pas',
  Model.Financiamento.Simular in 'Models\Model.Financiamento.Simular.pas',
  View.Base in 'Views\View.Base.pas' {FormBase},
  Model.Financiamento.Validar.Capital in 'Models\Model.Financiamento.Validar.Capital.pas',
  Model.Financiamento.Validar.TaxaJuros in 'Models\Model.Financiamento.Validar.TaxaJuros.pas',
  Model.Financiamento.Validar.MesesPagamento in 'Models\Model.Financiamento.Validar.MesesPagamento.pas',
  Model.Financiamento.Validacao in 'Models\Model.Financiamento.Validacao.pas';

{$R *.res}

begin
  {$IFDEF Debug}
  ReportMemoryLeaksOnShutdown := True;
  {$ENDIF}
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.Run;
end.
