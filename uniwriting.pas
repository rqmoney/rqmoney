unit uniwriting;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls, BCMDButtonFocus,
  ActnList, IniFiles;

type

  { TfrmWriting }

  TfrmWriting = class(TForm)
    actExit: TAction;
    actWrite: TActionList;
    actSave: TAction;
    btnCancel: TBCMDButtonFocus;
    btnWrite: TBCMDButtonFocus;
    imgHeight: TImage;
    imgWidth: TImage;
    lblHeight: TLabel;
    lblWidth: TLabel;
    lblWrite: TLabel;
    pnlBottom: TPanel;
    pnlHeight: TPanel;
    pnlWidth: TPanel;
    pnlWrite: TPanel;
    pnlButtons: TPanel;
    rbtWriteAtOnce: TRadioButton;
    rbtWriteGradually: TRadioButton;
    procedure btnCancelClick(Sender: TObject);
    procedure btnWriteClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  frmWriting: TfrmWriting;

implementation

{$R *.lfm}

uses
  uniMain, uniSettings;

{ TfrmWriting }

procedure TfrmWriting.btnWriteClick(Sender: TObject);
begin
  frmWriting.ModalResult := mrOK;
end;

procedure TfrmWriting.FormClose(Sender: TObject; var CloseAction: TCloseAction);
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
        if INI.ReadString('POSITION', frmWriting.Name, '') <>
          IntToStr(frmWriting.Left) + separ + // form left
        IntToStr(frmWriting.Top) + separ + // form top
        IntToStr(frmWriting.Width) + separ + // form width
        IntToStr(frmWriting.Height) then
          INI.WriteString('POSITION', frmWriting.Name,
            IntToStr(frmWriting.Left) + separ + // form left
            IntToStr(frmWriting.Top) + separ + // form top
            IntToStr(frmWriting.Width) + separ + // form width
            IntToStr(frmWriting.Height));
      finally
        INI.Free;
      end;
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmWriting.FormCreate(Sender: TObject);
begin
  // set component size
  pnlButtons.Height := ButtonHeight;
  pnlBottom.Height := ButtonHeight;

  // get form icon
  frmMain.img16.GetIcon(19, (Sender as TForm).Icon);
end;

procedure TfrmWriting.FormKeyPress(Sender: TObject; var Key: char);
begin
  If Key = Chr(27) then
    btnCancelClick(btnCancel);
  If (Key = Chr(13)) and (btnWrite.Focused = False) then begin
    Key := Chr(0);
    btnWrite.SetFocus;
  end;
end;

procedure TfrmWriting.FormResize(Sender: TObject);
begin
  lblWidth.Caption := IntToStr((Sender as TForm).Width);
  lblHeight.Caption := IntToStr((Sender as TForm).Height);
end;

procedure TfrmWriting.FormShow(Sender: TObject);
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
      frmWriting.Position := poDesigned;
      S := INI.ReadString('POSITION', frmWriting.Name, '-1•-1•0•0');

      // width
      TryStrToInt(Field(Separ, S, 3), I);
      if (I < 1) or (I > Screen.Width) then
        frmWriting.Width := Round(350 * (ScreenRatio / 100))
      else
        frmWriting.Width := I;

      /// height
      TryStrToInt(Field(Separ, S, 4), I);
      if (I < 1) or (I > Screen.Height) then
        frmWriting.Height := Round(220 * (ScreenRatio / 100))
      else
        frmWriting.Height := I;

      // left
      TryStrToInt(Field(Separ, S, 1), I);
      if (I < 0) or (I > Screen.Width) then
        frmWriting.left := (Screen.Width - frmWriting.Width) div 2
      else
        frmWriting.Left := I;

      // top
      TryStrToInt(Field(Separ, S, 2), I);
      if (I < 0) or (I > Screen.Height) then
        frmWriting.Top := ((Screen.Height - frmWriting.Height) div 2) - 75
      else
        frmWriting.Top := I;
    end;
  finally
    INI.Free
  end;
  // ********************************************************************
  // FORM SIZE END
  // ********************************************************************

  rbtWriteAtOnce.SetFocus;
end;

procedure TfrmWriting.btnCancelClick(Sender: TObject);
begin
  frmWriting.ModalResult := mrCancel;
end;

end.

