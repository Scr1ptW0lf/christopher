program proj_Crypt;

uses
  Vcl.Forms,
  p_Crypt in 'p_Crypt.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
