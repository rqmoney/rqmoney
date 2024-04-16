unit uniPassword;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Buttons, ActnList, BCPanel, BCMDButtonFocus, StrUtils, IniFiles;

type

  { TfrmPassword }

  TfrmPassword = class(TForm)
    actExit: TAction;
    ActionList1: TActionList;
    btn0: TBCMDButtonFocus;
    btn1: TBCMDButtonFocus;
    btn2: TBCMDButtonFocus;
    btn3: TBCMDButtonFocus;
    btn4: TBCMDButtonFocus;
    btn5: TBCMDButtonFocus;
    btn6: TBCMDButtonFocus;
    btn7: TBCMDButtonFocus;
    btn8: TBCMDButtonFocus;
    btn9: TBCMDButtonFocus;
    btnBack: TBCMDButtonFocus;
    btnExit: TBCMDButtonFocus;
    btnSave: TBCMDButtonFocus;
    ediConfirm: TEdit;
    ediNew: TEdit;
    ediOld: TEdit;
    imgHeight: TImage;
    imgWidth: TImage;
    lblConfirm: TStaticText;
    lblHeight: TLabel;
    lblNew: TStaticText;
    lblOld: TStaticText;
    lblWidth: TLabel;
    Panel1: TPanel;
    Panel13: TPanel;
    Panel2: TPanel;
    Panel5: TPanel;
    Panel9: TPanel;
    pnlBottom: TPanel;
    pnlButtons: TPanel;
    pnlClient: TScrollBox;
    pnlConfirm: TPanel;
    pnlHeight: TPanel;
    pnlNew: TPanel;
    pnlNumeric: TPanel;
    pnlOld: TPanel;
    pnlPasswordCaption: TBCPanel;
    pnlPasswordBack: TPanel;
    lblPassword: TLabel;
    pnlWidth: TPanel;
    procedure actExitExecute(Sender: TObject);
    procedure btn0Click(Sender: TObject);
    procedure btnBackClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure ediConfirmKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure ediNewKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ediOldChange(Sender: TObject);
    procedure ediOldEnter(Sender: TObject);
    procedure ediOldExit(Sender: TObject);
    procedure ediOldKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure pnlClientResize(Sender: TObject);
    procedure pnlNumericResize(Sender: TObject);

  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmPassword: TfrmPassword;

implementation

{$R *.lfm}

uses
  uniMain, uniProperties, uniGate, uniResources, uniSettings;

{ TfrmPassword }

procedure TfrmPassword.btnSaveClick(Sender: TObject);
begin
  try
    // check the length
    if (length(ediNew.Text) > 0) and (length(ediNew.Text) < 5) then
    begin
      ShowMessage(Error_08);
      ediNew.SetFocus;
      exit;
    end;

    // check the confirmation
    if ediNew.Text <> ediConfirm.Text then
    begin
      ShowMessage(Error_09);
      ediConfirm.SetFocus;
      exit;
    end;
    frmPassword.Close;

    frmMain.QRY.SQL.Text := 'UPDATE settings SET set_value = :PWD WHERE set_parameter = "password"';
    frmMain.QRY.Params.ParamByName('PWD').AsString := XorEncode('5!9x4', ediNew.Text);
    frmMain.QRY.Prepare;
    frmMain.QRY.ExecSQL;
    frmMain.Tran.Commit;

    // Set database protection in frmProprerties
    If Length(ediNew.Text) = 0 then
      frmProperties.lblProtection.Caption := Caption_109 // no protection
    Else frmProperties.lblProtection.Caption := Caption_108; // protected database

    // Inform user about protection
    If ediOld.Enabled = False then
      ShowMessage (Message_03)
    Else
      ShowMessage (Message_04);
    frmGate.ediGate.Hint := ediNew.Text;
    ediOld.Clear;
    ediNew.Clear;
    ediConfirm.Clear;
    frmPassword.ModalResult := mrOK;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmPassword.ediConfirmKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    If Key = 13 then begin
    Key := 0;
    btnSave.SetFocus;
  end;
end;

procedure TfrmPassword.ediNewKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    If Key = 13 then begin
    Key := 0;
    ediConfirm.SetFocus;
  end;
end;

procedure TfrmPassword.btn0Click(Sender: TObject);
var
  Str: string;

begin
  case frmPassword.Tag of
    1:
    begin
      Str := ediOld.Text;
      Insert((Sender as TBCMDButtonFocus).Caption, Str, btnSave.Tag + 1);
      ediOld.Text := Str;
      ediOld.SetFocus;
      ediOld.SelStart := btnSave.Tag + 1;
    end;
    2:
    begin
      Str := ediNew.Text;
      Insert((Sender as TBCMDButtonFocus).Caption, Str, btnSave.Tag + 1);
      ediNew.Text := Str;
      ediNew.SetFocus;
      ediNew.SelStart := btnSave.Tag + 1;
    end;
    3:
    begin
      Str := ediConfirm.Text;
      Insert((Sender as TBCMDButtonFocus).Caption, Str, btnSave.Tag + 1);
      ediConfirm.Text := Str;
      ediConfirm.SetFocus;
      ediConfirm.SelStart := btnSave.Tag + 1;
    end;
  end;
  frmPassword.Caption := ediNew.Text + ' - ' + IntToStr(btnSave.Tag);
end;

procedure TfrmPassword.actExitExecute(Sender: TObject);
begin
  frmPassword.ModalResult := mrCancel;
end;

procedure TfrmPassword.btnBackClick(Sender: TObject);
var
  Str: string;

begin
  Str := '';
  if btnSave.Tag = 0 then
  begin
    case frmPassword.Tag of
      1:
      begin
        ediOld.SetFocus;
        ediOld.SelStart := 0;
        ediOld.SelLength := 0;
      end;
      2:
      begin
        ediNew.SetFocus;
        ediNew.SelStart := 0;
        ediNew.SelLength := 0;
      end;
      3:
      begin
        ediConfirm.SetFocus;
        ediConfirm.SelStart := 0;
        ediConfirm.SelLength := 0;
      end;

    end;
    Exit;
  end;

  case frmPassword.Tag of
    1:
    begin
      Str := ediOld.Text;
      Delete(Str, btnSave.Tag, 1);
      ediOld.Text := Str;
      ediOld.SetFocus;
      ediOld.SelStart := btnSave.Tag - 1;
    end;
    2:
    begin
      Str := ediNew.Text;
      Delete(Str, btnSave.Tag, 1);
      ediNew.Text := Str;
      ediNew.SetFocus;
      ediNew.SelStart := btnSave.Tag - 1;
    end;
    3:
    begin
      Str := ediConfirm.Text;
      Delete(Str, btnSave.Tag, 1);
      ediConfirm.Text := Str;
      ediConfirm.SetFocus;
      ediConfirm.SelStart := btnSave.Tag - 1;
    end;
  end;
  frmPassword.Caption := str + ' - ' + IntToStr(btnSave.Tag);
end;

procedure TfrmPassword.btnExitClick(Sender: TObject);
begin
  frmPassword.Close;
end;

procedure TfrmPassword.ediOldChange(Sender: TObject);
begin
  btnBack.Enabled := not (Length((Sender as TEdit).Text) = 0);
end;

procedure TfrmPassword.ediOldEnter(Sender: TObject);
begin
  (Sender as TEdit).Color := Color_focus;
end;

procedure TfrmPassword.ediOldExit(Sender: TObject);
begin
  frmPassword.Tag := (Sender as TEdit).Tag;
  btnSave.Tag := (Sender as TEdit).SelStart;
  (Sender as TEdit).Color := clDefault;
end;

procedure TfrmPassword.ediOldKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If Key = 13 then begin
    Key := 0;
    ediNew.SetFocus;
  end;
end;

procedure TfrmPassword.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
var
  INI: TINIFile;
  INIFile: string;

begin
  try
    // write position and window size
    if frmSettings.chkLastFormsSize.Checked = True then
    begin
      try
        INIFile := ChangeFileExt(ParamStr(0), '.ini');
        INI := TINIFile.Create(INIFile);
        if INI.ReadString('POSITION', frmPassword.Name, '') <>
          IntToStr(frmPassword.Left) + separ + // form left
        IntToStr(frmPassword.Top) + separ + // form top
        IntToStr(frmPassword.Width) + separ + // form width
        IntToStr(frmPassword.Height) then
          INI.WriteString('POSITION', frmPassword.Name,
            IntToStr(frmPassword.Left) + separ + // form left
            IntToStr(frmPassword.Top) + separ + // form top
            IntToStr(frmPassword.Width) + separ + // form width
            IntToStr(frmPassword.Height));
      finally
        INI.Free;
      end;
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;

end;

procedure TfrmPassword.FormCreate(Sender: TObject);
begin
  btn0.Caption := IntToStr(btn0.Tag);
  btn1.Caption := IntToStr(btn1.Tag);
  btn2.Caption := IntToStr(btn2.Tag);
  btn3.Caption := IntToStr(btn3.Tag);
  btn4.Caption := IntToStr(btn4.Tag);
  btn5.Caption := IntToStr(btn5.Tag);
  btn6.Caption := IntToStr(btn6.Tag);
  btn7.Caption := IntToStr(btn7.Tag);
  btn8.Caption := IntToStr(btn8.Tag);
  btn9.Caption := IntToStr(btn9.Tag);

  pnlPasswordCaption.Height := PanelHeight;
  pnlBottom.Height := ButtonHeight;

  // get form icon
  frmMain.img16.GetIcon(5, (Sender as TForm).Icon);
end;

procedure TfrmPassword.FormResize(Sender: TObject);
begin
  pnlPasswordCaption.Repaint;

  lblWidth.Caption := IntToStr((Sender as TForm).Width);
  lblHeight.Caption := IntToStr((Sender as TForm).Height);

  pnlPasswordCaption.Repaint;
  pnlNumeric.Repaint;
  btnExit.Repaint;
  btnSave.Repaint;
end;

procedure TfrmPassword.FormShow(Sender: TObject);
var
  S, Old: string;
  INI: TINIFile;
  I: integer;
begin
  // ********************************************************************
  // FORM SIZE START
  // ********************************************************************
  try
    S := ChangeFileExt(ParamStr(0), '.ini');
    // INI file READ procedure (if file exists) =========================
    if FileExists(S) = True then
    begin
      INI := TINIFile.Create(S);
      frmPassword.Position := poDesigned;
      S := INI.ReadString('POSITION', frmPassword.Name, '-1•-1•0•0');

      // width
      TryStrToInt(Field(Separ, S, 3), I);
      if (I < 1) or (I > Screen.Width) then
        frmPassword.Width := Round(450 * (ScreenRatio / 100))
      else
        frmPassword.Width := I;

      /// height
      TryStrToInt(Field(Separ, S, 4), I);
      if (I < 1) or (I > Screen.Height) then
        frmPassword.Height := Round(350 * (ScreenRatio / 100))
      else
        frmPassword.Height := I;

      // left
      TryStrToInt(Field(Separ, S, 1), I);
      if (I < 0) or (I > Screen.Width) then
        frmPassword.left := (Screen.Width - frmPassword.Width) div 2
      else
        frmPassword.Left := I;

      // top
      TryStrToInt(Field(Separ, S, 2), I);
      if (I < 0) or (I > Screen.Height) then
        frmPassword.Top := ((Screen.Height - frmPassword.Height) div 2) - 75
      else
        frmPassword.Top := I;
    end;
  finally
    INI.Free
  end;
  // ********************************************************************
  // FORM SIZE END
  // ********************************************************************

  ediOld.Clear;
  ediNew.Clear;
  ediConfirm.Clear;

  try
  // get old password
  with frmMain.QRY do
  begin
    SQL.Text := 'SELECT set_value FROM settings WHERE set_parameter = "password"';
    Open;
    Old := FieldByName('set_value').AsString;
    ediOld.Enabled := Length(Old) > 0;
    Close;
  end;

  if ediOld.Enabled = True then
    ediOld.SetFocus
  else
    ediNew.SetFocus;

  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmPassword.pnlClientResize(Sender: TObject);
begin
  pnlNumeric.Width := pnlClient.Width div 5 * 2;
end;

procedure TfrmPassword.pnlNumericResize(Sender: TObject);
begin
  btn0.Width := (Panel1.Width - 8) div 3;
  btn1.Width := btn0.Width;
  btn4.Width := btn0.Width;
  btn7.Width := btn0.Width;
  btn9.Width := btn0.Width;
  btn6.Width := btn0.Width;
  btn3.Width := btn0.Width;

  Panel1.Height := (pnlNumeric.Height - 15) div 4;
  Panel5.Height := Panel1.Height;
  Panel9.Height := Panel1.Height;
end;

end.
