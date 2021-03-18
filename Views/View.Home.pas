unit View.Home;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.OleCtrls, SHDocVw, View.Base;

type
  TFormHome = class(TFormBase)
    WebBrowser1: TWebBrowser;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure LoadHTML;
  public
    { Public declarations }
  end;

var
  FormHome: TFormHome;

implementation

Uses
  System.IOUtils, Winapi.ActiveX;

{$R *.dfm}

procedure TFormHome.FormShow(Sender: TObject);
begin
  LoadHTML;
end;

procedure TFormHome.LoadHTML;
var
  LPath: String;
  LNameFileHTML: String;
begin
  LPath :=  TPath.Combine(ExtractFilePath(Application.ExeName), 'www');
  LNameFileHTML :=  TPath.Combine(LPath, 'index.html');
  if FileExists(LNameFileHTML) then
    WebBrowser1.Navigate(Format('file://%s', [LNameFileHTML]));
end;

end.
