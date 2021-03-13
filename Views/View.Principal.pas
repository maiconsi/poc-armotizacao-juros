unit View.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  System.ImageList, Vcl.ImgList,Vcl.CategoryButtons, Vcl.WinXCtrls,
  Vcl.StdCtrls, Vcl.Imaging.pngimage, Vcl.ExtCtrls, System.Actions,
  Vcl.ActnList, Vcl.ActnMan, Vcl.StdStyleActnCtrls, Vcl.ComCtrls;

type
  TFormPrincipal = class(TForm)
    pnlBarraFerramentas: TPanel;
    imgMenu: TImage;
    lblTitulo: TLabel;
    spvMenus: TSplitView;
    catMenuItems: TCategoryButtons;
    Image32: TImageList;
    ActionManager: TActionManager;
    AcHome: TAction;
    AcSimularFinanciamento: TAction;
    pgcListaPaginas: TPageControl;
    procedure imgMenuClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FNomeFormAtivo: String;

    function PodeAbrirFormulario(AClasseForm: TFormClass; var APagina: TTabSheet): Boolean;
    function TotalFormsAbertos(AClasseForm: TFormClass): Integer;
    procedure AjustarCaptionAbas(AClasseForm: TFormClass);
  public
    { Public declarations }
    procedure NovaPagina(AClasseForm: TFormClass);
    procedure SepararAba(APagina: TTabSheet);
    function FecharPagina(APagina: TTabSheet; AFreePagina : Boolean): Boolean; overload;
    function FecharPagina(APagina: TTabSheet; ATodasExcetoEssa: Boolean; AFreePagina : Boolean): Boolean; overload;
    function FecharTodasPaginas: Boolean;

    property NomeFormAtivo: String read FNomeFormAtivo write FNomeFormAtivo;
  end;

var
  FormPrincipal: TFormPrincipal;

implementation

{$R *.dfm}

//Destruo o form e fecho a ABA
function TFormPrincipal.FecharPagina(APagina: TTabSheet;
  AFreePagina: Boolean): Boolean;
var
  LForm: TForm;
  LNovaPaginaAtiva: TTabSheet;
begin
  LNovaPaginaAtiva := nil;
  Try
    LForm := (APagina.Components[0] as TForm);

    Result := LForm.CloseQuery;
  Except
    //--Evitar erros de ListOfBond -1
    Result  :=  False;
  End;

  if Result then
  begin
    if APagina.PageIndex > 0 then
      LNovaPaginaAtiva := pgcListaPaginas.Pages[APagina.PageIndex - 1]
    else
    begin
      if pgcListaPaginas.PageCount > 1 then
        LNovaPaginaAtiva :=  pgcListaPaginas.Pages[0];
    end;

    //--Elimino o LForm da memoria "garanto que não vai ficar nada em memoria"
    LForm.Close;
    LForm.Release;
    LForm :=  Nil;

    //--Para resolver o problema quando o usuario clica no botão X da aba
//    if AFreePagina then
//      APagina.Free;

    //--Seto a nova APagina a tiva
    pgcListaPaginas.ActivePage  := LNovaPaginaAtiva;

    //--Ajusto o Caption do FormPrincipal caso não existe nenuma aba ativa
    if LNovaPaginaAtiva = nil then
    begin
      Caption := 'Integr@Pec';
      Application.Title := Caption
    end;
  end;
end;

//Ajusta o caption da aba com novo indice
procedure TFormPrincipal.AjustarCaptionAbas(AClasseForm: TFormClass);
var
  I: Integer;
  LIndice: Integer;
  LTotalForms: Integer;
  LNovoCaption: string;
begin
  LTotalForms := TotalFormsAbertos(AClasseForm);

  if LTotalForms > 1 then
  begin
    LIndice := 1;
    for I := 0 to pgcListaPaginas.PageCount - 1 do
    begin
      with pgcListaPaginas do
      begin
        if Pages[I].Components[0].ClassType = AClasseForm then
        begin
          LNovoCaption := (Pages[I].Components[0] as TForm).Caption + ' (' + IntToStr(LIndice) + ')';
          (Pages[I] as TTabSheet).Caption := LNovoCaption;
          Inc(LIndice);
        end;
      end;
    end;
  end;
end;

function TFormPrincipal.FecharPagina(APagina: TTabSheet; ATodasExcetoEssa,
  AFreePagina: Boolean): Boolean;
var
  I: Integer;
begin
  Result := True;
  for I := pgcListaPaginas.PageCount - 1 downto 0 do
  begin
    if pgcListaPaginas.Pages[I] <> APagina then
    begin
      Result := FecharPagina(pgcListaPaginas.Pages[I], AFreePagina);
      if not Result then
        Exit;
    end;
  end;
end;

function TFormPrincipal.FecharTodasPaginas: Boolean;
var
  I: Integer;
begin
  Result := True;
  for I := pgcListaPaginas.PageCount - 1 downto 0 do
  begin
    Result := FecharPagina(pgcListaPaginas.Pages[I], True);
    if not Result then
      Exit;
  end;
end;

procedure TFormPrincipal.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  FecharTodasPaginas;
end;

procedure TFormPrincipal.imgMenuClick(Sender: TObject);
begin
  if spvMenus.Opened then
    spvMenus.Close
  else
    spvMenus.Open;
end;

//Instancia um novo form e adiciona em uma nova ABA
procedure TFormPrincipal.NovaPagina(AClasseForm: TFormClass);
var
  LPagina: TTabSheet;
  LForm: TForm;
begin
  //Verifica se pode abrir o LForm
  if not PodeAbrirFormulario(AClasseForm, LPagina) then
  begin
    pgcListaPaginas.ActivePage := LPagina;
    Exit;
  end;

  //Instancia uma página padrão
  LPagina := TTabSheet.Create(pgcListaPaginas);

  //Seta a PageList da nova página para aquela que já está no LForm principal
  LPagina.PageControl := pgcListaPaginas;

  //Cria um LForm passando a página para o seu construtor, que recebe um TComponent
  LForm := AClasseForm.Create(LPagina);

  //Propriedades do LForm
  LForm.Align       := alClient;
  LForm.BorderStyle := bsNone;
  LForm.Parent      := LPagina;

  //Propriedades da Aba
  LPagina.Caption   := LForm.Caption;
  LPagina.PopupMenu := Self.PopupMenu;

  //Ajusta o título (caption) das abas
  AjustarCaptionAbas(AClasseForm);

  //ativa a página
  pgcListaPaginas.ActivePage := LPagina;

  FNomeFormAtivo :=  LForm.Name;

  //--Ajusto o Caption do FormPrincipal
  Caption := LPagina.Caption;
  Application.Title := Caption;

  //exibe o formulário
  LForm.Show;
end;

function TFormPrincipal.PodeAbrirFormulario(AClasseForm: TFormClass;
  var APagina: TTabSheet): Boolean;
var
  I: Integer;
begin
  Result := True;
  //varre a pgcListaPaginas para saber se já existe um Form aberto
  for I := 0 to pgcListaPaginas.PageCount - 1 do
    //se achou um form
    if pgcListaPaginas.Pages[I].Components[0].ClassType = AClasseForm then
    begin
      APagina := pgcListaPaginas.Pages[I];
      //permite abrir o form novamente caso a Tag tenha o valor zero
      Result := (APagina.Components[0] as TForm).Tag = 0;
      Break;
    end;
end;

procedure TFormPrincipal.SepararAba(APagina: TTabSheet);
Var
  LPaginaEsquerda: TTabSheet;
begin
  LPaginaEsquerda := nil;

  with APagina.Components[0] as TForm do
  begin
    Align       := alNone;
    BorderStyle := bsSizeable;
//    Left := (((pgcListaPaginas.Width )- Width) div 2)+pgcListaPaginas.Left;
//    Top := (((pgcListaPaginas.ClientHeight)-Height) div 2 )+(pgcListaPaginas.Top)-18;
    Parent      := nil;
  end;

  //Tratamento para esconter a aba do pagecontrol
  if APagina.PageIndex > 0 then
    LPaginaEsquerda := pgcListaPaginas.Pages[APagina.PageIndex - 1];

  APagina.TabVisible :=  False;

  pgcListaPaginas.ActivePage := LPaginaEsquerda;
end;

//Verifica o total de abas abertas para o formulario passado como parâmetro
function TFormPrincipal.TotalFormsAbertos(AClasseForm: TFormClass): Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to pgcListaPaginas.PageCount - 1 do
  begin
    if pgcListaPaginas.Pages[I].Components[0].ClassType = AClasseForm then
      Inc(Result);
  end;
end;

procedure TFormPrincipal.FormCreate(Sender: TObject);
begin
  FNomeFormAtivo := '';
end;

end.
