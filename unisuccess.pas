unit uniSuccess;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, Buttons, ActnList, BCPanel, BCMDButtonFocus, IniFiles;

type

  { TfrmSuccess }

  TfrmSuccess = class(TForm)
    actExit: TAction;
    ActionList1: TActionList;
    btnCancel: TBCMDButtonFocus;
    btnGuide: TBCMDButtonFocus;
    btnImport: TBCMDButtonFocus;
    btnPassword: TBCMDButtonFocus;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    imgHeight: TImage;
    imgWidth: TImage;
    lblHeight: TLabel;
    lblImport: TLabel;
    lblChoice:TLabel;
    lblPassword: TLabel;
    lblGuide: TLabel;
    lblCancel: TLabel;
    lblWidth: TLabel;
    pnlPassword: TPanel;
    pnlGuide: TPanel;
    pnlImport: TPanel;
    pnlCancel: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    pnlBottom: TPanel;
    pnlHeight: TPanel;
    pnlSuccessCaption: TBCPanel;
    pnlSuccess:TPanel;
    pnlWidth: TPanel;
    procedure actExitExecute(Sender: TObject);
    procedure btnGuideClick(Sender:TObject);
    procedure btnImportClick(Sender: TObject);
    procedure btnPasswordClick(Sender:TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure pnlSuccessResize(Sender: TObject);

  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmSuccess: TfrmSuccess;

implementation

{$R *.lfm}

uses
  uniPassword, uniMain, uniGuide, uniSettings;

{ TfrmSuccess }



procedure TfrmSuccess.btnGuideClick(Sender:TObject);
begin
  frmSuccess.Visible := False;
  frmGuide.ShowModal;
  frmSuccess.Visible := True;
end;

procedure TfrmSuccess.actExitExecute(Sender: TObject);
begin
  if frmGuide.Visible = True Then
    Exit;
  frmSuccess.ModalResult := mrCancel;
end;

procedure TfrmSuccess.btnImportClick(Sender: TObject);
begin
  frmMain.mnuImportClick(frmMain.mnuImport);
end;

procedure TfrmSuccess.btnPasswordClick(Sender:TObject);
begin
  frmPassword.ShowModal;
end;

procedure TfrmSuccess.FormClose(Sender: TObject; var CloseAction: TCloseAction);
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
        if INI.ReadString('POSITION', frmSuccess.Name, '') <>
          IntToStr(frmSuccess.Left) + separ + // form left
        IntToStr(frmSuccess.Top) + separ + // form top
        IntToStr(frmSuccess.Width) + separ + // form width
        IntToStr(frmSuccess.Height) then
          INI.WriteString('POSITION', frmSuccess.Name,
            IntToStr(frmSuccess.Left) + separ + // form left
            IntToStr(frmSuccess.Top) + separ + // form top
            IntToStr(frmSuccess.Width) + separ + // form width
            IntToStr(frmSuccess.Height));
      finally
        INI.Free;
      end;
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmSuccess.FormCreate(Sender: TObject);
begin
  // size
  pnlSuccessCaption.Height := PanelHeight;
  btnPassword.Height := ButtonHeight;
  btnGuide.Height := ButtonHeight;
  btnCancel.Height := ButtonHeight;
  btnImport.Height := ButtonHeight;
  pnlBottom.Height := ButtonHeight;

  // get form icon
  frmMain.img16.GetIcon(29, (Sender as TForm).Icon);
end;

procedure TfrmSuccess.FormResize(Sender: TObject);
begin
  lblWidth.Caption := IntToStr(frmSuccess.Width);
  lblHeight.Caption := IntToStr(frmSuccess.Height);
end;

procedure TfrmSuccess.FormShow(Sender: TObject);
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
      frmSuccess.Position := poDesigned;
      S := INI.ReadString('POSITION', frmSuccess.Name, '-1•-1•0•0');

      // width
      TryStrToInt(Field(Separ, S, 3), I);
      if (I < 1) or (I > Screen.Width) then
        frmSuccess.Width := Round(500 * (ScreenRatio / 100))
      else
        frmSuccess.Width := I;

      /// height
      TryStrToInt(Field(Separ, S, 4), I);
      if (I < 1) or (I > Screen.Height) then
        frmSuccess.Height := Round(300 * (ScreenRatio / 100))
      else
        frmSuccess.Height := I;

      // left
      TryStrToInt(Field(Separ, S, 1), I);
      if (I < 0) or (I > Screen.Width) then
        frmSuccess.left := (Screen.Width - frmSuccess.Width) div 2
      else
        frmSuccess.Left := I;

      // top
      TryStrToInt(Field(Separ, S, 2), I);
      if (I < 0) or (I > Screen.Height) then
        frmSuccess.Top := ((Screen.Height - frmSuccess.Height) div 2) - 75
      else
        frmSuccess.Top := I;
    end;
  finally
    INI.Free;
  end;
  // ********************************************************************
  // FORM SIZE END
  // ********************************************************************
end;

procedure TfrmSuccess.pnlSuccessResize(Sender: TObject);
begin
  pnlPassword.Height := (pnlSuccess.Height - 10) div 4;
  pnlImport.Height := pnlPassword.Height;
  pnlGuide.Height := pnlPassword.Height;
  pnlCancel.Height := pnlPassword.Height;
end;

end.

