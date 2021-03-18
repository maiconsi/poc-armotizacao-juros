unit View.Base;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TFormBase = class(TForm)
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormBase: TFormBase;

implementation

uses
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Samples.Spin;

{$R *.dfm}

procedure TFormBase.FormKeyPress(Sender: TObject; var Key: Char);
begin
  case Key of
    // Verifica se foi precionada a tecla Enter e manda o foco para o proximo componente
    #13: begin
      if (ActiveControl is TLabeledEdit) or
        (ActiveControl is TEdit) or
        (ActiveControl is TSpinEdit) then
      begin
        Perform(Wm_NextDlgCtl, 0, 0);
        Key:= #0;
      end;
    end;
  end;
end;

end.
