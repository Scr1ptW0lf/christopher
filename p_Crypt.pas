unit p_Crypt;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Menus,
  Vcl.ExtCtrls, Vcl.Imaging.jpeg, Vcl.Buttons, strUtils, FileCtrl;

type
  TForm1 = class(TForm)
    PageControl: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    lblChristopher: TLabel;
    tHeading: TTimer;
    lblIntro1: TLabel;
    lblIntro2: TLabel;
    imgBackground: TImage;
    lblCopyright: TLabel;
    lblEStep1: TLabel;
    redEDecrypted: TRichEdit;
    btnELoad: TButton;
    lblEFileLoaded: TLabel;
    shpELine: TShape;
    lblEStep2: TLabel;
    btnEEncText: TButton;
    btnEEncFile: TButton;
    redEEncrypted: TRichEdit;
    lblEPass: TLabel;
    edtEPass: TEdit;
    ckbxEViewPass: TCheckBox;
    lblESettings: TLabel;
    btnEReset: TBitBtn;
    btnEHelp: TBitBtn;
    btnEClose: TBitBtn;
    lblEAdvSett: TLabel;
    rgpEEncType: TRadioGroup;
    lblEAdv1: TLabel;
    lblEAdv2: TLabel;
    lblEAdv3: TLabel;
    ckbxEInsane: TCheckBox;
    lblEInsane1: TLabel;
    lblEInsane2: TLabel;
    lblEInsane3: TLabel;
    lblEInsane4: TLabel;
    lblEInsane5: TLabel;
    shpDLine: TShape;
    btnDLoad: TButton;
    lblDFileLoaded: TLabel;
    redDEncrypted: TRichEdit;
    lblDStep1: TLabel;
    redDDecrypted: TRichEdit;
    btnDDecFile: TButton;
    btnDDecText: TButton;
    lblDStep2: TLabel;
    ckbxDViewPass: TCheckBox;
    edtDPass: TEdit;
    lblDPass: TLabel;
    lblDSettings: TLabel;
    lblDAdv3: TLabel;
    lblDAdv2: TLabel;
    lblDAdv1: TLabel;
    lblDAdvSett: TLabel;
    rgpDEncType: TRadioGroup;
    btnDHelp: TBitBtn;
    btnDClose: TBitBtn;
    btnDReset: TBitBtn;
    ckbxDInsane: TCheckBox;
    lblDInsane3: TLabel;
    lblDInsane2: TLabel;
    lblDInsane1: TLabel;
    btnDLoadKey: TButton;
    lblDKeyLoaded: TLabel;
    TabSheet4: TTabSheet;
    lbxFAQ: TListBox;
    lblFAQ: TLabel;
    memHelp: TMemo;
    procedure Startup(Sender: TObject);
    procedure Copyright(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure Starting(Sender: TObject);
    procedure btnEResetClick(Sender: TObject);
    procedure ckbxDViewPassClick(Sender: TObject);
    procedure ckbxEViewPassClick(Sender: TObject);
    procedure btnEHelpClick(Sender: TObject);
    procedure btnELoadClick(Sender: TObject);
    procedure btnDHelpClick(Sender: TObject);
    procedure btnDLoadClick(Sender: TObject);
    procedure btnDLoadKeyClick(Sender: TObject);
    procedure ckbxDInsaneClick(Sender: TObject);
    procedure ckbxEInsaneClick(Sender: TObject);
    procedure btnEEncTextClick(Sender: TObject);
    procedure btnDDecTextClick(Sender: TObject);
    procedure rgpEEncTypeClick(Sender: TObject);
    procedure btnEEncFileClick(Sender: TObject);
    procedure btnDDecFileClick(Sender: TObject);
    procedure lbxFAQClick(Sender: TObject);
    procedure btnDResetClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  iStart: integer;
  sFileE, sFileD, sDKeyPath: string;
  sDKey: TStringList;

const
  ALPHABET = 'abcdefghijklmnopqrstuvwxyz';

implementation

{$R *.dfm}

procedure TForm1.Starting(Sender: TObject); //on form activate
begin
    iStart := 0;
    memHelp.Text := '';
end;

procedure TForm1.Startup(Sender: TObject); //title animation
begin
    if iStart = 1 then
    lblChristopher.Caption := 'C';
    if iStart = 2 then
    lblChristopher.Caption := 'CH';
    if iStart = 3 then
    lblChristopher.Caption := 'CHR';
    if iStart = 4 then
    lblChristopher.Caption := 'CHRI';
    if iStart = 5 then
    lblChristopher.Caption := 'CHRIS';
    if iStart = 6 then
    lblChristopher.Caption := 'CHRIST';
    if iStart = 7 then
    lblChristopher.Caption := 'CHRISTO';
    if iStart = 8 then
    lblChristopher.Caption := 'CHRISTOP';
    if iStart = 9 then
    lblChristopher.Caption := 'CHRISTOPH';
    if iStart = 10 then
    lblChristopher.Caption := 'CHRISTOPHE';
    if iStart = 11 then
    lblChristopher.Caption := 'CHRISTOPHER';
    if iStart = 12 then
    lblIntro1.Visible := true;
    if iStart = 14 then
    lblIntro2.Visible := true;
    if iStart = 15 then
    PageControl.Visible := true;
    if iStart = 16 then
    tHeading.Enabled := false;
    iStart := iStart + 1;
end;

procedure TForm1.btnEEncTextClick(Sender: TObject); //encrypt text button
var i, iMessLength, iChar, iPassKey: integer;
sMessage: TStringList;
sPass, sMessageEnc: string;
cLetter, cPass1, cPass2, cPass3, cCharEnc: char;
begin                               //checking for null password or text to be encrypted
    if ckbxEInsane.Checked = true then
      begin
        MessageDlg('You may only encrypt a file using insane mode.', mtWarning, [mbOK], 0);
        exit;
      end;
    if redEDecrypted.Text = '' then
      begin
        MessageDlg('No text detected to encrypt, please input some.', mtWarning, [mbOK], 0);
        exit;
      end;
    if edtEPass.Text = '' then
      begin
        MessageDlg('No password detected, please input one of at least 6 characters.', mtWarning, [mbOK], 0);
        exit;
      end;
    if length(edtEPass.Text) < 6 then
      begin
        MessageDlg('Your password is too short, please make it 6 characters or longer.', mtWarning, [mbOK], 0);
        exit;
      end;


//start of encryption process
    if rgpEEncType.ItemIndex = 0 then
      begin
      sMessage := TStringList.Create;
      sPass := edtEPass.Text;
      sMessage.Text := redEDecrypted.Text;
      iMessLength := length(sMessage.Text);
      cPass1 := sPass[4];
      cPass2 := sPass[1];
      cPass3 := sPass[6];

      iPassKey := trunc((ord(cPass1) + ord(cPass2) - ord(cPass3)));

      redEEncrypted.Text := '';
      for i := 1 to iMessLength do
        begin
            cLetter := sMessage.Text[i];
            if cLetter = #10 then
            begin
              redEEncrypted.Lines.Add(sMessageEnc);
              sMessageEnc := '';
            end
            else
            begin
              iChar := ord(cLetter) + iPassKey;
              cCharEnc := chr(iChar);
              sMessageEnc := sMessageEnc + cCharEnc;
            end;
        end;
      end;

end;

procedure TForm1.btnELoadClick(Sender: TObject); //browse and select file to encrypt
var iMessYN: integer;
begin
    if rgpEEncType.ItemIndex = 0 then
    begin

    if PromptForFileName(sFileE,
                       'Text files (*.txt)|*.txt',
                       '',
                       'Select the file to be encrypted',
                       'C:\',
                       False)
    then
      begin
        lblEFileLoaded.Caption := 'File Selected';
        redEDecrypted.Text := sFileE;
        redEEncrypted.Text := '';
        redEDecrypted.Enabled := false;
        btnEEncText.Enabled := false;
        btnEEncFile.Enabled := true;
        redEEncrypted.Enabled := false;
        MessageDlg('Selected file: '+sFileE, mtInformation, [mbOK], 0);
       end
    end;
end;

procedure TForm1.btnEEncFileClick(Sender: TObject); //encrypt file button
var i, iMessLength, iChar, iPassKey, iNum1, iNum2, iNum3, iNum4, iNum5, iNum6, iKeyTotal: integer;
sMessage, sMessageEncT: TStringList;
sPass, sMessageEnc, FileLoc: string;
cLetter, cPass1, cPass2, cPass3, cCharEnc, cKey1, cKey2, cKey3, cKey4, cKey5, cKey6: char;
iKey1, iKey2, iKey3, iKey4, iKey5, iKey6, iKey7, iKey8, iKey9, iKey10, iKey11, iKey12, iKey13: integer;
KeyKey: TStringList;
KeyLoc: string;
begin
    if edtEPass.Text = '' then
      begin
        MessageDlg('No password detected, please input one of at least 6 characters.', mtWarning, [mbOK], 0);
        exit;
      end;
    if length(edtEPass.Text) < 6 then
      begin
        MessageDlg('Your password is too short, please make it 6 characters or longer.', mtWarning, [mbOK], 0);
        exit;
      end;


//start of encryption process
    if ckbxEInsane.Checked = true then
      begin
          randomize;
          iKey1 := random(100000000000000)+100000000000000;
          iKey2 := random(100000000000000)+100000000000000;
          iKey3 := random(100000000000000)+100000000000000;
          iKey4 := random(100000000000000)+100000000000000;
          iKey5 := random(100000000000000)+100000000000000;
          iKey6 := random(100000000000000)+100000000000000;
          iKey7 := random(100000000000000)+100000000000000;
          iKey8 := random(100000000000000)+100000000000000;
          iKey9 := random(100000000000000)+100000000000000;
          iKey10 := random(100000000000000)+100000000000000;
          iKey11 := random(100000000000000)+100000000000000;
          iKey12 := random(100000000000000)+100000000000000;
          iKey13 := random(8999)+1000;
          KeyKey := TStringList.Create;
          KeyKey.Add(inttostr(iKey1));
          KeyKey.Add(inttostr(iKey2));
          KeyKey.Add(inttostr(iKey3));
          KeyKey.Add(inttostr(iKey4));
          KeyKey.Add(inttostr(iKey5));
          KeyKey.Add(inttostr(iKey6));
          KeyKey.Add(inttostr(iKey7));
          KeyKey.Add(inttostr(iKey8));
          KeyKey.Add(inttostr(iKey9));
          KeyKey.Add(inttostr(iKey10));
          KeyKey.Add(inttostr(iKey11));
          KeyKey.Add(inttostr(iKey12));
          KeyKey.Add(inttostr(iKey13));
          cKey1 := KeyKey.Text[14];
          cKey2 := KeyKey.Text[24];
          cKey3 := KeyKey.Text[40];
          cKey4 := KeyKey.Text[53];
          cKey5 := KeyKey.Text[69];
          cKey6 := KeyKey.Text[101];
          iNum1 := strtoint(cKey1);
          iNum2 := strtoint(cKey2);
          iNum3 := strtoint(cKey3);
          iNum4 := strtoint(cKey4);
          iNum5 := strtoint(cKey5);
          iNum6 := strtoint(cKey6);
          iKeyTotal := iNum1+iNum2+iNum3+iNum4+iNum5+iNum6;
         if PromptForFileName(KeyLoc,
                       'Text files (*.txt)|*.txt',
                       '',
                       'Select where to save key',
                       'C:\',
                       True)
         then
            begin
             KeyKey.SaveToFile(KeyLoc + '.txt');
             MessageDlg('Key saved to ' + KeyLoc + '.txt', mtInformation, [mbOK], 0);
             sMessage := TStringList.Create;
              sMessageEncT := TStringList.Create;
              sPass := edtEPass.Text;
              sMessage.LoadFromFile(sFileE);

             iMessLength := length(sMessage.Text);
             cPass1 := sPass[4];
             cPass2 := sPass[1];
             cPass3 := sPass[6];

              iPassKey := (ord(cPass1) + ord(cPass2) + ord(cPass3) + iKeyTotal);

             for i := 1 to iMessLength do
                begin
                   cLetter := sMessage.Text[i];
                   if cLetter = #10 then
                    begin
                      sMessageEncT.Add(sMessageEnc);
                      sMessageEnc := '';
                   end
                   else
                    begin
                     iChar := ord(cLetter) + iPassKey;
                     cCharEnc := chr(iChar);
                     sMessageEnc := sMessageEnc + cCharEnc;
                   end;
               end;
                if PromptForFileName(FileLoc,
                'Text files (*.txt)|*.txt',
                '',
                'Select where to save encrypted file',
                'C:\',
                True)
                   then
                      begin
                         sMessageEncT.SaveToFile(FileLoc + '.txt',TEncoding.UTF8);
                         redEEncrypted.Text := FileLoc + '.txt';
                         MessageDlg('File saved to ' + FileLoc + '.txt', mtInformation, [mbOK], 0)
                      end;
                      exit;
            end;

      end;

    if rgpEEncType.ItemIndex = 0 then
      begin
      sMessage := TStringList.Create;
      sMessageEncT := TStringList.Create;
      sPass := edtEPass.Text;
      sMessage.LoadFromFile(sFileE);

      iMessLength := length(sMessage.Text);
      cPass1 := sPass[4];
      cPass2 := sPass[1];
      cPass3 := sPass[6];

      iPassKey := trunc((ord(cPass1) + ord(cPass2) - ord(cPass3)));

      for i := 1 to iMessLength do
        begin
            cLetter := sMessage.Text[i];
            if cLetter = #10 then
            begin
              sMessageEncT.Add(sMessageEnc);
              sMessageEnc := '';
            end
            else
            begin
              iChar := ord(cLetter) + iPassKey;
              cCharEnc := chr(iChar);
              sMessageEnc := sMessageEnc + cCharEnc;
            end;
        end;
                if PromptForFileName(FileLoc,
                'Text files (*.txt)|*.txt',
                '',
                'Select where to save encrypted file',
                'C:\',
                True)
                   then
                      begin
                         sMessageEncT.SaveToFile(FileLoc + '.txt',TEncoding.UTF8);
                         redEEncrypted.Text := FileLoc + '.txt';
                         MessageDlg('File saved to ' + FileLoc + '.txt', mtInformation, [mbOK], 0)
                      end;
                      exit;
      end;

end;

procedure TForm1.btnDDecTextClick(Sender: TObject); //decrypt text button
var i, iMessLength, iChar, iPassKey: integer;
sMessage: TStringList;
sPass, sMessageEnc: string;
cLetter, cPass1, cPass2, cPass3, cCharEnc: char;

begin                               //checking for null password or text to be decrypted
    if ckbxDInsane.Checked = true then
      begin
        MessageDlg('You may only decrypt a file using insane mode.', mtWarning, [mbOK], 0);
        exit;
      end;
    if redDEncrypted.Text = '' then
      begin
        MessageDlg('No text detected to decrypt, please input some.', mtWarning, [mbOK], 0);
        exit;
      end;
    if edtDPass.Text = '' then
      begin
        MessageDlg('No password detected, please input one of at least 6 characters.', mtWarning, [mbOK], 0);
        exit;
      end;
    if length(edtDPass.Text) < 6 then
      begin
        MessageDlg('The password is too short, it must be 6 characters or longer.', mtWarning, [mbOK], 0);
        exit;
      end;


//start of decryption process
    if rgpDEncType.ItemIndex = 0 then //default
      begin
      sMessage := TStringList.Create;
      sPass := edtDPass.Text;
      sMessage.Text := redDEncrypted.Text;
      iMessLength := length(sMessage.Text);
      cPass1 := sPass[4];
      cPass2 := sPass[1];
      cPass3 := sPass[6]; //char 4 of pass used
      iPassKey := (ord(cPass1) + ord(cPass2) - ord(cPass3));
      redDDecrypted.Text := '';
      for i := 1 to iMessLength do
        begin
            cLetter := sMessage.Text[i];
            if cLetter = #10 then
            begin
              redDDecrypted.Lines.Add(sMessageEnc);
              sMessageEnc := '';
            end
            else
            begin
              iChar := ord(cLetter) - iPassKey;
              cCharEnc := chr(iChar);
              sMessageEnc := sMessageEnc + cCharEnc;
            end;
        end;
      end;

end;

procedure TForm1.btnDLoadClick(Sender: TObject); //browse and select file to decrypt
begin
    if PromptForFileName(sFileD,
                       'Text files (*.txt)|*.txt',
                       '',
                       'Select the file to be decrypted',
                       'C:\',
                       False)
  then
    begin
    lblDFileLoaded.Caption := 'File Selected';
    redDEncrypted.Text := sFileD;
    redDEncrypted.Enabled := false;
    btnDDecText.Enabled := false;
    btnDDecFile.Enabled := true;
    redDDecrypted.Enabled := false;
    MessageDlg('Selected file: '+sFileD, mtInformation, [mbOK], 0);
   end
end;

procedure TForm1.btnDLoadKeyClick(Sender: TObject); //select decryption key file
begin
    if PromptForFileName(sDKeyPath,
                       'Text files (*.txt)|*.txt',
                       '',
                       'Select your key file',
                       'C:\',
                       False)
  then
    begin
    sDKey := TStringList.Create;
    sDKey.LoadFromFile(sDKeyPath);
    if length(sDKey.Text) = 138 then
      begin
      MessageDlg('Selected key: '+sDKeyPath, mtInformation, [mbOK], 0);
      lblDKeyLoaded.Caption := 'Key selected';
      end
   end
end;

procedure TForm1.btnDDecFileClick(Sender: TObject); //decrypt file button
var i, iMessLength, iChar, iPassKey, iNum1, iNum2, iNum3, iNum4, iNum5, iNum6, iKeyTotal: integer;
sMessage, sMessageEncT: TStringList;
sPass, sMessageEnc, FileLoc: string;
cLetter, cPass1, cPass2, cPass3, cCharEnc, cKey1, cKey2, cKey3, cKey4, cKey5, cKey6: char;
iKey1, iKey2, iKey3, iKey4, iKey5, iKey6, iKey7, iKey8, iKey9, iKey10, iKey11, iKey12, iKey13: integer;
KeyKey: TStringList;
KeyLoc: string;
begin
    if edtDPass.Text = '' then
      begin
        MessageDlg('No password detected, please input one of at least 6 characters.', mtWarning, [mbOK], 0);
        exit;
      end;
    if length(edtDPass.Text) < 6 then
      begin
        MessageDlg('Your password is too short, it must be 6 characters or longer.', mtWarning, [mbOK], 0);
        exit;
      end;


//start of decryption process
    if ckbxDInsane.Checked = true then
    begin
          if sDKeyPath = '' then
          begin
              MessageDlg('No key file selected, please select one.', mtWarning, [mbOK], 0);
              exit;
          end;
          KeyKey := TStringList.Create;
          KeyKey.LoadFromFile(sDKeyPath);
          cKey1 := KeyKey.Text[14];
          cKey2 := KeyKey.Text[24];
          cKey3 := KeyKey.Text[40];
          cKey4 := KeyKey.Text[53];
          cKey5 := KeyKey.Text[69];
          cKey6 := KeyKey.Text[101];
          iNum1 := strtoint(cKey1);
          iNum2 := strtoint(cKey2);
          iNum3 := strtoint(cKey3);
          iNum4 := strtoint(cKey4);
          iNum5 := strtoint(cKey5);
          iNum6 := strtoint(cKey6);
          iKeyTotal := iNum1+iNum2+iNum3+iNum4+iNum5+iNum6;
          sMessage := TStringList.Create;
          sMessageEncT := TStringList.Create;
          sPass := edtDPass.Text;
          sMessage.LoadFromFile(sFileD);

          iMessLength := length(sMessage.Text);
          cPass1 := sPass[4];
          cPass2 := sPass[1];
          cPass3 := sPass[6];

              iPassKey := (ord(cPass1) + ord(cPass2) + ord(cPass3) + iKeyTotal);

              for i := 1 to iMessLength do
               begin
                   cLetter := sMessage.Text[i];
                   if cLetter = #10 then
                begin
                  sMessageEncT.Add(sMessageEnc);
                  sMessageEnc := '';
                end
                  else
                begin
                  iChar := ord(cLetter) - iPassKey;
                  cCharEnc := chr(iChar);
                  sMessageEnc := sMessageEnc + cCharEnc;
                end;
              end;


                if PromptForFileName(FileLoc,
                'Text files (*.txt)|*.txt',
                '',
                'Select where to save decrypted file',
                'C:\',
                True)
                   then
                      begin
                         sMessageEncT.SaveToFile(FileLoc + '.txt',TEncoding.UTF8);
                         redDDecrypted.Text := FileLoc + '.txt';
                         MessageDlg('File saved to ' + FileLoc + '.txt', mtInformation, [mbOK], 0)
                      end;
                      exit;

  end;

    if rgpEEncType.ItemIndex = 0 then
      begin
      sMessage := TStringList.Create;
      sMessageEncT := TStringList.Create;
      sPass := edtDPass.Text;
      sMessage.LoadFromFile(sFileD);

      iMessLength := length(sMessage.Text);
      cPass1 := sPass[4];
      cPass2 := sPass[1];
      cPass3 := sPass[6];

      iPassKey := trunc((ord(cPass1) + ord(cPass2) - ord(cPass3)));

      for i := 1 to iMessLength do
        begin
            cLetter := sMessage.Text[i];
            if cLetter = #10 then
            begin
              sMessageEncT.Add(sMessageEnc);
              sMessageEnc := '';
            end
            else
            begin
              iChar := ord(cLetter) - iPassKey;
              cCharEnc := chr(iChar);
              sMessageEnc := sMessageEnc + cCharEnc;
            end;
        end;
                if PromptForFileName(FileLoc,
                'Text files (*.txt)|*.txt',
                '',
                'Select where to save decrypted file',
                'C:\',
                True)
                   then
                      begin
                         sMessageEncT.SaveToFile(FileLoc + '.txt',TEncoding.UTF8);
                         redDDecrypted.Text := FileLoc + '.txt';
                         MessageDlg('File saved to ' + FileLoc + '.txt', mtInformation, [mbOK], 0)
                      end;
      end;

end;

procedure TForm1.ckbxEInsaneClick(Sender: TObject); //insane checkbox encrypter
begin
    if ckbxEInsane.Checked = true then
    begin
      rgpEEncType.ItemIndex := 0;
      rgpEEncType.Enabled := false;
    end
    else
    begin
      rgpEEncType.ItemIndex := 0;
      rgpEEncType.Enabled := true;
    end;
end;

procedure TForm1.ckbxDInsaneClick(Sender: TObject); //insane checkbox decrypter
begin
    if ckbxDInsane.Checked = true then
    begin
      btnDLoadKey.Enabled := true;
      rgpDEncType.ItemIndex := 0;
      rgpDEncType.Enabled := false;
    end
    else
    begin
      btnDLoadKey.Enabled := false;
      rgpDEncType.ItemIndex := 0;
      rgpDEncType.Enabled := true;
    end;
end;

procedure TForm1.rgpEEncTypeClick(Sender: TObject); //on encryption enc type click
begin
    if rgpEEncType.ItemIndex = 1 then
      MessageDlg('Please note that only lowercase letters and spaces may be used in this encryption type.', mtInformation, [mbOK], 0);
    if rgpEEncType.ItemIndex = 2 then
      MessageDlg('Please note that only lowercase letters and spaces may be used in this encryption type.', mtInformation, [mbOK], 0);
end;

procedure TForm1.btnEHelpClick(Sender: TObject); //help button encrypt page
begin
    MessageDlg('Either input text into the top block or click "Browse" to select a text file, type a memorable password into the "Password" block (or push the generate button), then click the corresponding button to encrypt the text. For more help visit the help page.', mtInformation, [mbOK], 0);
end;

procedure TForm1.btnDHelpClick(Sender: TObject); //help button decrypt page
begin
    MessageDlg('Paste the encrypted message into the top block or click "Browse" to select the encrypted file, type the password into the "Password" block, then click the corresponding button to decrypt the text. For more help visit the help page.', mtInformation, [mbOK], 0);
end;

procedure TForm1.btnEResetClick(Sender: TObject); //reset button encrypt page
begin
    redEDecrypted.Text := '';
    redEEncrypted.Text := '';
    edtEPass.Text := '';
    ckbxEViewPass.Checked := false;
    ckbxEInsane.Checked := false;
    rgpEEncType.ItemIndex := 0;
    redEDecrypted.Enabled := true;
    redEEncrypted.Enabled := true;
    btnEEncText.Enabled := true;
    btnEEncFile.Enabled := false;
    lblEFileLoaded.Caption := 'No file loaded';
end;

procedure TForm1.btnDResetClick(Sender: TObject); //reset button decrypt page
begin
    redDDecrypted.Text := '';
    redDEncrypted.Text := '';
    edtDPass.Text := '';
    ckbxDViewPass.Checked := false;
    ckbxDInsane.Checked := false;
    rgpDEncType.ItemIndex := 0;
    redDDecrypted.Enabled := true;
    redDEncrypted.Enabled := true;
    btnDDecText.Enabled := true;
    btnDDecFile.Enabled := false;
    lblDFileLoaded.Caption := 'No file loaded';
    lblDKeyLoaded.Caption := 'No Key Loaded';
end;

procedure TForm1.btnCloseClick(Sender: TObject); //close button
var buttonSelected : Integer;
begin
    buttonSelected := MessageDlg('Are you sure you want to exit?', mtConfirmation, [mbYes,mbNo], 0);
    if buttonSelected = mrYes then
      Application.Terminate();
end;

procedure TForm1.ckbxEViewPassClick(Sender: TObject); //view pass button encrypt page
begin
    if ckbxEViewPass.State = cbUnchecked then
      edtEPass.PasswordChar := '*';
    if ckbxEViewPass.State = cbChecked then
      edtEPass.PasswordChar := #0;
end;

procedure TForm1.ckbxDViewPassClick(Sender: TObject); //view pass button decrypt page
begin
    if ckbxDViewPass.State = cbUnchecked then
      edtDPass.PasswordChar := '*';
    if ckbxDViewPass.State = cbChecked then
      edtDPass.PasswordChar := #0;
end;

procedure TForm1.Copyright(Sender: TObject); //when you click copyright
begin
    MessageDlg('In other words, don''t steal the darn program please', mtInformation, [mbOK], 0);
end;

procedure TForm1.lbxFAQClick(Sender: TObject); //help page list click
begin
    if lbxFAQ.ItemIndex = 0 then
    begin
      memHelp.Text := '';
      memHelp.Lines.Add('Funny symbols in your text?');
      memHelp.Lines.Add('');
      memHelp.Lines.Add('The decryption process in "Default" mode is not perfect. Due to the nature of text encoding in Windows, there may be strange characters indicating break lines in your text.');
      memHelp.Lines.Add('');
      memHelp.Lines.Add('If this really bothers you, you can use either the "Scramble Alphabet" or "Caesers Shift" options, however these are not as secure and you may only use lowercase letters in these encryptions.');
      memHelp.Lines.Add('');
      memHelp.Lines.Add('If these characters are in place of letters or the font of your decrypted text is strange, then the program doesn''t like the password used to encrypt the text. Try and use passwords that contain letters, numbers and symbols.');
    end;

    if lbxFAQ.ItemIndex = 2 then
    begin
      memHelp.Text := '';
      memHelp.Lines.Add('Your decrypted file is patchy?');
      memHelp.Lines.Add('');
      memHelp.Lines.Add('Yet again, the nature of text encoding in Windows somewhat limits us. We''ve changed the encoding to the optimum settings, however issues may still arise.');
      memHelp.Lines.Add('');
      memHelp.Lines.Add('Try and use passwords that have letters, numbers and symbols in them. Alternatively use a different encryption type to encrypt your files. This may limit you to only lowercase letters, and for this we are sorry.');
    end;

    if lbxFAQ.ItemIndex = 4 then
    begin
      memHelp.Text := '';
      memHelp.Lines.Add('You''re bored?');
      memHelp.Lines.Add('');
      memHelp.Lines.Add('A game was going to be included in here called "Can you crack it?", but the developer ran out of time so you''ll just have to imagine playing it. Go watch Netflix instead.');
    end;

    if lbxFAQ.ItemIndex = 6 then
    begin
      memHelp.Text := '';
      memHelp.Lines.Add('Why did I put so much effort into a crummy school project?');
      memHelp.Lines.Add('');
      memHelp.Lines.Add('Umm... not entirely sure. I put my best into most things that I do, and I realize I''ve gone completely overkill with this, but come on. This was an awesome project to work on.');
      memHelp.Lines.Add('');
      memHelp.Lines.Add('Don''t be surprised if you see this thing working for the government as the new Enigma machine. Then again, you probably won''t...');
    end;

    if lbxFAQ.ItemIndex = 8 then
    begin
      memHelp.Text := '';
      memHelp.Lines.Add('Need more help?');
      memHelp.Lines.Add('');
      memHelp.Lines.Add('Don''t hesitate to contact me via email at 207938@online.kes.co.za . If you''re old school, find my P.O. Box and send me a letter that I can ignore.');
      memHelp.Lines.Add('');
      memHelp.Lines.Add('Thanks for using my program! <3');
    end;
end;

end.
