unit uniShortCut;

{$mode ObjFPC}{$H+}
{$ModeSwitch AutoDeref}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  ActnList, StrUtils, LCLType, LCLProc, laz.VirtualTrees, Buttons,
  IniFiles;

type

  { TfrmShortCut }

  TfrmShortCut = class(TForm)
    actCancel: TAction;
    ActionList1: TActionList;
    btnSave: TBitBtn;
    imgHeight: TImage;
    imgWidth: TImage;
    lblHeight: TLabel;
    lblShortcut: TStaticText;
    lblAction1: TLabel;
    lblAction: TLabel;
    lblShortcutOld1: TLabel;
    lblShortCutOld: TLabel;
    lblShortCutNew: TLabel;
    lblTip: TLabel;
    lblWidth: TLabel;
    pnlBottom: TPanel;
    pnlHeight: TPanel;
    pnlOld: TPanel;
    pnlNew: TPanel;
    pnlShortCut: TPanel;
    pnlAction: TPanel;
    pnlWidth: TPanel;
    procedure btnCancelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnSaveKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure btnSaveKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  frmShortCut: TfrmShortCut;

implementation

{$R *.lfm}

uses
  uniMain, uniResources, uniSettings;

{ TfrmShortCut }

procedure TfrmShortCut.btnCancelClick(Sender: TObject);
begin
  frmShortCut.ModalResult := mrCancel;
end;

procedure TfrmShortCut.btnSaveClick(Sender: TObject);
var
  Key: PKey;
  P: PVirtualNode;

begin
  If lblShortcut.Caption = '' then
    Exit;

  // check the duplicity
  P := frmSettings.VSTKeys.GetFirst();
  While Assigned(P) do begin
    Key := frmSettings.VSTKeys.GetNodeData(P);
    If Key.shortcut = lblShortcut.Caption then
      begin
        ShowMessage (Error_03 + sLineBreak + sLineBreak + Key.caption);
        Exit;
      end;

    P := frmSettings.VSTKeys.GetNext(P);
  end;
  frmShortCut.ModalResult := mrOk;
end;

procedure TfrmShortCut.btnSaveKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  //  frmShortCut.Caption := IntToStr(key);
  if key in [9, 20, 37..40, 92..93, 230, 144] then
  begin
    Key := 0;
    lblShortcut.Caption := '';
    Exit;
  end;

  If (key = 27) and (lblShortcut.Caption = 'ESC') then begin
    if MessageDlg(Application.Title, Question_19, mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      begin
      frmShortCut.ModalResult := mrCancel;
      Exit;
    end;
  end;

  lblShortcut.Tag := 0;

  if (ssCTRL in Shift) then
    lblShortcut.Hint := 'CTRL+'
  else if (ssShift in Shift) then
    lblShortcut.Hint := 'SHIFT+'
  else if (ssAlt in Shift) then
    lblShortcut.Hint := 'ALT+'
  else
    lblShortcut.Hint := '';

  lblShortcut.Caption := AnsiUpperCase(lblShortcut.Hint + ShortCutToText(Key));
  Key := 0;
end;

procedure TfrmShortCut.btnSaveKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  //  frmShortCut.Caption := IntToStr(key);
  if RightStr(lblShortcut.Caption, 1) = '+' then
    lblShortcut.Caption := '';
end;

procedure TfrmShortCut.FormClose(Sender: TObject; var CloseAction: TCloseAction
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
        if INI.ReadString('POSITION', frmShortCut.Name, '') <>
          IntToStr(frmShortCut.Left) + separ + // form left
        IntToStr(frmShortCut.Top) + separ + // form top
        IntToStr(frmShortCut.Width) + separ + // form width
        IntToStr(frmShortCut.Height) then
          INI.WriteString('POSITION', frmShortCut.Name,
            IntToStr(frmShortCut.Left) + separ + // form left
            IntToStr(frmShortCut.Top) + separ + // form top
            IntToStr(frmShortCut.Width) + separ + // form width
            IntToStr(frmShortCut.Height));
      finally
        INI.Free;
      end;
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmShortCut.FormCreate(Sender: TObject);
begin
  // set height
  pnlBottom.Height := ButtonHeight;

  // get form icon
  frmMain.img16.GetIcon(32, (Sender as TForm).Icon);
end;

procedure TfrmShortCut.FormResize(Sender: TObject);
begin
  try
    lblWidth.Caption := IntToStr(frmShortCut.Width);
    lblHeight.Caption := IntToStr(frmShortCut.Height);
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmShortCut.FormShow(Sender: TObject);
var
  INI: TINIFile;
  S: string;
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
      frmShortCut.Position := poDesigned;
      S := INI.ReadString('POSITION', frmShortCut.Name, '-1•-1•0•0');

      // width
      TryStrToInt(Field(Separ, S, 3), I);
      if (I < 1) or (I > Screen.Width) then
        frmShortCut.Width := Round(400 * (ScreenRatio / 100))
      else
        frmShortCut.Width := I;

      /// height
      TryStrToInt(Field(Separ, S, 4), I);
      if (I < 1) or (I > Screen.Height) then
        frmShortCut.Height := Round(250 * (ScreenRatio / 100))
      else
        frmShortCut.Height := I;

      // left
      TryStrToInt(Field(Separ, S, 1), I);
      if (I < 0) or (I > Screen.Width) then
        frmShortCut.left := (Screen.Width - frmShortCut.Width) div 2
      else
        frmShortCut.Left := I;

      // top
      TryStrToInt(Field(Separ, S, 2), I);
      if (I < 0) or (I > Screen.Height) then
        frmShortCut.Top := ((Screen.Height - frmShortCut.Height) div 2) - 75
      else
        frmShortCut.Top := I;
    end;
  finally
    INI.Free
  end;
  // ********************************************************************
  // FORM SIZE END
  // ********************************************************************
end;

end.
