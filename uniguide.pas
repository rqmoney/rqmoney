unit uniGuide;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Buttons, BCPanel, BCMDButtonFocus, IniFiles;

type

  { TfrmGuide }

  TfrmGuide = class(TForm)
    btnAccount: TBitBtn;
    btnBack: TBCMDButtonFocus;
    btnCategory: TBitBtn;
    btnNext: TBCMDButtonFocus;
    btnPayee: TBitBtn;
    btnPerson: TBitBtn;
    btnTransaction: TBitBtn;
    imgHeight: TImage;
    imgWidth: TImage;
    lblHeight: TLabel;
    lblTip: TLabel;
    lblWidth: TLabel;
    notGuide: TNotebook;
    pagAccount: TPage;
    pagCategory: TPage;
    pagFinish: TPage;
    pagPayee: TPage;
    pagPerson: TPage;
    pagTransaction: TPage;
    pagWelcome: TPage;
    pnlAccount: TPanel;
    pnlButtons: TPanel;
    pnlCategory: TPanel;
    pnlGuideCaption: TBCPanel;
    pnlHeight: TPanel;
    pnlList: TScrollBox;
    pnlPayee: TPanel;
    pnlPerson: TPanel;
    pnlBottom: TPanel;
    pnlTip: TPanel;
    pnlTransaction: TPanel;
    pnlWidth: TPanel;
    txtAccount: TLabel;
    txtCategory: TLabel;
    txtFinish: TLabel;
    txtPayee: TLabel;
    txtPerson: TLabel;
    txtTransaction: TLabel;
    txtWelcome: TLabel;
    procedure btnAccountClick(Sender: TObject);
    procedure btnBackClick(Sender: TObject);
    procedure btnCategoryClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure btnPayeeClick(Sender: TObject);
    procedure btnPersonClick(Sender: TObject);
    procedure btnTransactionClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmGuide: TfrmGuide;

implementation

{$R *.lfm}

uses
  uniPersons, uniAccounts, uniCategories, uniPayees, uniMain, uniSettings;

  { TfrmGuide }

procedure TfrmGuide.FormResize(Sender: TObject);
begin
  try
    lblWidth.Caption := IntToStr((Sender as TForm).Width);
    lblHeight.Caption := IntToStr((Sender as TForm).Height);

    pnlGuideCaption.Repaint;
  except
    on E: Exception do
      ShowMessage(E.Message + sLineBreak + E.ClassName + sLineBreak + E.UnitName);
  end;
end;

procedure TfrmGuide.FormShow(Sender: TObject);
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
      frmGuide.Position := poDesigned;
      S := INI.ReadString('POSITION', frmGuide.Name, '-1•-1•0•0');

      // width
      TryStrToInt(Field(Separ, S, 3), I);
      if (I < 1) or (I > Screen.Width) then
        frmGuide.Width := Round(700 * (ScreenRatio / 100))
      else
        frmGuide.Width := I;

      /// height
      TryStrToInt(Field(Separ, S, 4), I);
      if (I < 1) or (I > Screen.Height) then
        frmGuide.Height := Round(400 * (ScreenRatio / 100))
      else
        frmGuide.Height := I;

      // left
      TryStrToInt(Field(Separ, S, 1), I);
      if (I < 0) or (I > Screen.Width) then
        frmGuide.left := (Screen.Width - frmGuide.Width) div 2
      else
        frmGuide.Left := I;

      // top
      TryStrToInt(Field(Separ, S, 2), I);
      if (I < 0) or (I > Screen.Height) then
        frmGuide.Top := ((Screen.Height - frmGuide.Height) div 2) - 75
      else
        frmGuide.Top := I;
    end;
  finally
    INI.Free
  end;
  // ********************************************************************
  // FORM SIZE END
  // ********************************************************************

  if pnlButtons.Tag = 0 then
  begin
    frmGuide.Tag := 0;
    lblTip.Caption := IntToStr(frmGuide.Tag + 1) + ' / 7';
    notGuide.PageIndex := 0;
    notGuide.Tag := 0;
    btnBack.Visible := False;
    btnNext.Visible := True;
  end
  else
    pnlButtons.Tag := 0;
end;

procedure TfrmGuide.FormKeyPress(Sender: TObject; var Key: char);
begin
  if Ord(Key) = 27 then
    frmGuide.Close;
end;

procedure TfrmGuide.btnNextClick(Sender: TObject);
begin
  frmGuide.Tag := frmGuide.Tag + 1;
  notGuide.PageIndex := frmGuide.Tag;
  btnBack.Visible := frmGuide.Tag > 0;
  btnNext.Visible := frmGuide.Tag < notGuide.PageCount - 1;
  lblTip.Caption := IntToStr(frmGuide.Tag + 1) + ' / 7';
end;

procedure TfrmGuide.btnPayeeClick(Sender: TObject);
begin
  frmPayees.ShowModal;
end;

procedure TfrmGuide.btnPersonClick(Sender: TObject);
begin
  frmPersons.ShowModal;
end;

procedure TfrmGuide.btnTransactionClick(Sender: TObject);
begin
  frmMain.btnAddClick(frmMain.btnAdd);
end;

procedure TfrmGuide.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var
  INI: TINIFile;
  INIFile: string;
begin
  // write position and window size
  if frmSettings.chkLastFormsSize.Checked = True then
  begin
    try
      INIFile := ChangeFileExt(ParamStr(0), '.ini');
      INI := TINIFile.Create(INIFile);
      if INI.ReadString('POSITION', frmGuide.Name, '') <>
        IntToStr(frmGuide.Left) + separ + // form left
      IntToStr(frmGuide.Top) + separ + // form top
      IntToStr(frmGuide.Width) + separ + // form width
      IntToStr(frmGuide.Height) then
        INI.WriteString('POSITION', frmGuide.Name,
          IntToStr(frmGuide.Left) + separ + // form left
          IntToStr(frmGuide.Top) + separ + // form top
          IntToStr(frmGuide.Width) + separ + // form width
          IntToStr(frmGuide.Height));
    finally
      INI.Free;
    end;
  end;
end;

procedure TfrmGuide.FormCreate(Sender: TObject);
begin
  lblTip.Caption := '1 / 7';

  // set components height
  pnlGuideCaption.Height := PanelHeight;
  pnlButtons.Height := ButtonHeight;
  pnlBottom.Height := ButtonHeight;

  // get form icon
  frmMain.img16.GetIcon(6, (Sender as TForm).Icon);
end;

procedure TfrmGuide.btnBackClick(Sender: TObject);
begin
  frmGuide.Tag := frmGuide.Tag - 1;
  notGuide.PageIndex := frmGuide.Tag;
  btnBack.Visible := frmGuide.Tag > 0;
  btnNext.Visible := frmGuide.Tag < notGuide.PageCount - 1;
  lblTip.Caption := IntToStr(frmGuide.Tag + 1) + ' / 7';
end;

procedure TfrmGuide.btnCategoryClick(Sender: TObject);
begin
  frmCategories.ShowModal;
end;

procedure TfrmGuide.btnAccountClick(Sender: TObject);
begin
  frmAccounts.ShowModal;
end;

end.
