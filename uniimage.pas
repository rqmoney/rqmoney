unit uniImage;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  ActnList, BCMDButtonFocus, Clipbrd, LCLIntf, IniFiles;

type

  { TfrmImage }

  TfrmImage = class(TForm)
    actExit: TAction;
    actCopy: TAction;
    ActionList1: TActionList;
    btnCopy: TBCMDButtonFocus;
    btnExit: TBCMDButtonFocus;
    imgDiagram: TImage;
    imgHeight: TImage;
    imgWidth: TImage;
    lblApricotDB: TLabel;
    lblHeight: TLabel;
    lblWidth: TLabel;
    pnlBottom: TPanel;
    pnlButtons: TPanel;
    pnlHeight: TPanel;
    pnlWidth: TPanel;
    procedure btnCopyClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lblApricotDBClick(Sender: TObject);
    procedure lblApricotDBMouseEnter(Sender: TObject);
    procedure lblApricotDBMouseLeave(Sender: TObject);
  private

  public

  end;

var
  frmImage: TfrmImage;

implementation

{$R *.lfm}

uses
  uniMain, uniResources, uniSettings;

{ TfrmImage }

procedure TfrmImage.FormResize(Sender: TObject);
begin
  lblWidth.Caption := IntToStr((Sender as TForm).Width);
  lblHeight.Caption := IntToStr((Sender as TForm).Height);
end;

procedure TfrmImage.FormShow(Sender: TObject);
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
      frmImage.Position := poDesigned;
      S := INI.ReadString('POSITION', frmImage.Name, '-1•-1•0•0');

      // width
      TryStrToInt(Field(Separ, S, 3), I);
      if (I < 1) or (I > Screen.Width) then
        frmImage.Width := Screen.Width - 100 - (200 - ScreenRatio)
      else
        frmImage.Width := I;

      /// height
      TryStrToInt(Field(Separ, S, 4), I);
      if (I < 1) or (I > Screen.Height) then
        frmImage.Height := Screen.Height - 150 - (200 - ScreenRatio)
      else
        frmImage.Height := I;

      // left
      TryStrToInt(Field(Separ, S, 1), I);
      if (I < 0) or (I > Screen.Width) then
        frmImage.left := (Screen.Width - frmImage.Width) div 2
      else
        frmImage.Left := I;

      // top
      TryStrToInt(Field(Separ, S, 2), I);
      if (I < 0) or (I > Screen.Height) then
        frmImage.Top := ((Screen.Height - frmImage.Height) div 2) - 75
      else
        frmImage.Top := I;
    end;
  finally
    INI.Free
  end;
  // ********************************************************************
  // FORM SIZE END
  // ********************************************************************
end;

procedure TfrmImage.lblApricotDBClick(Sender: TObject);
begin
  OpenURL((Sender as TLabel).Hint);
end;

procedure TfrmImage.lblApricotDBMouseEnter(Sender: TObject);
begin
    (Sender as TLabel).Font.Underline := True;
    (Sender as TLabel).Font.Bold := True;
    (Sender as TLabel).Font.Color := clBlue;
    (Sender as TLabel).Cursor := crHandPoint;
end;

procedure TfrmImage.lblApricotDBMouseLeave(Sender: TObject);
begin
  (Sender as TLabel).Font.Underline := False;
  (Sender as TLabel).Font.Bold := False;
  (Sender as TLabel).Font.Color := clDefault;
  (Sender as TLabel).Cursor := crDefault;
end;

procedure TfrmImage.btnExitClick(Sender: TObject);
begin
  frmImage.ModalResult := mrCancel;
end;

procedure TfrmImage.FormClose(Sender: TObject; var CloseAction: TCloseAction);
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
        if INI.ReadString('POSITION', frmImage.Name, '') <>
          IntToStr(frmImage.Left) + separ + // form left
        IntToStr(frmImage.Top) + separ + // form top
        IntToStr(frmImage.Width) + separ + // form width
        IntToStr(frmImage.Height) then
          INI.WriteString('POSITION', frmImage.Name,
            IntToStr(frmImage.Left) + separ + // form left
            IntToStr(frmImage.Top) + separ + // form top
            IntToStr(frmImage.Width) + separ + // form width
            IntToStr(frmImage.Height));
      finally
        INI.Free;
      end;
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmImage.FormCreate(Sender: TObject);
begin
  // set component height
  pnlBottom.Height := ButtonHeight;

    // get form icon
  frmMain.img16.GetIcon(7, (Sender as TForm).Icon);

  lblApricotDB.Hint := 'https://www.apricotdb.co.za/joomla/';
end;

procedure TfrmImage.btnCopyClick(Sender: TObject);
begin
  Clipboard.Assign(imgDiagram.Picture.Bitmap);
  ShowMessage(Format(Message_07, [sLineBreak, IntToStr(imgDiagram.Picture.Bitmap.Width),
    IntToStr(imgDiagram.Picture.Bitmap.Height)]));
end;

end.

