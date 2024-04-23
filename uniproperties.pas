unit uniProperties;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls, sqldb, sqlite3,
  ComCtrls, ActnList, Buttons, BCPanel, BCMDButtonFocus, FileUtil, StrUtils, IniFiles;

type

  { TfrmProperties }

  TfrmProperties = class(TForm)
    actExit: TAction;
    ActionList1: TActionList;
    btnAccounts: TBCMDButtonFocus;
    btnBudget: TBCMDButtonFocus;
    btnLinks: TBCMDButtonFocus;
    btnCategories: TBCMDButtonFocus;
    btnComments: TBCMDButtonFocus;
    btnCurrencies: TBCMDButtonFocus;
    btnData: TBCMDButtonFocus;
    btnExit: TBCMDButtonFocus;
    btnHolidays: TBCMDButtonFocus;
    btnPayees: TBCMDButtonFocus;
    btnPayments: TBCMDButtonFocus;
    btnPersons: TBCMDButtonFocus;
    btnRecycle: TBCMDButtonFocus;
    btnScheduler: TBCMDButtonFocus;
    btnTags: TBCMDButtonFocus;
    emoji: TImageList;
    imgPassword: TImage;
    imgEncryption: TImage;
    imgAccounts: TImage;
    imgBudget: TImage;
    imgLinks: TImage;
    imgCategories: TImage;
    imgComments: TImage;
    imgCurrencies: TImage;
    imgData: TImage;
    imgHeight: TImage;
    imgHolidays: TImage;
    imgPayees: TImage;
    imgPayments: TImage;
    imgPersons: TImage;
    imgRecycle: TImage;
    imgScheduler: TImage;
    imgTags: TImage;
    imgWidth: TImage;
    lblAccounts: TLabel;
    lblBudget: TLabel;
    lblLinks: TLabel;
    lblCategories: TLabel;
    lblComments: TLabel;
    lblCurrencies: TLabel;
    lblData: TLabel;
    lblFileName: TLabel;
    lblFileName_: TLabel;
    lblHeight: TLabel;
    lblHolidays: TLabel;
    lblLocation: TLabel;
    lblLocation_: TLabel;
    lblOS1: TLabel;
    lblOS2: TLabel;
    lblEncryptionProtection: TLabel;
    lblEncryptionProtection_: TLabel;
    lblPayees: TLabel;
    lblPayments: TLabel;
    lblPersons: TLabel;
    lblPasswordProtection: TLabel;
    lblPasswordProtection_: TLabel;
    lblRecycle: TLabel;
    lblSchedulers: TLabel;
    lblSize: TLabel;
    lblSize_: TLabel;
    lblSQLiteName1: TLabel;
    lblSQLiteName2: TLabel;
    lblSQLiteVersion1: TLabel;
    lblSQLiteVersion2: TLabel;
    lblTags: TLabel;
    lblWidth: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    pnlAccounts: TPanel;
    pnlBottom: TPanel;
    pnlBudget: TPanel;
    pnlLinks: TPanel;
    pnlCategories: TPanel;
    pnlComments: TPanel;
    pnlCurrencies: TPanel;
    pnlData: TPanel;
    pnlHeight: TPanel;
    pnlHolidays: TPanel;
    pnlOS: TPanel;
    pnlEncryptionProtection: TPanel;
    pnlPayees: TPanel;
    pnlPayments: TPanel;
    pnlPersons: TPanel;
    pnlRecords: TScrollBox;
    pnlRecycle: TPanel;
    pnlScheduler: TPanel;
    pnlSQLiteName: TPanel;
    pnlSQLiteVersion: TPanel;
    pnlTags: TPanel;
    pnlWidth: TPanel;
    tabProperties: TPageControl;
    pnlCaption1: TBCPanel;
    pnlDatabase: TPanel;
    pnlCaption: TBCPanel;
    pnlFileName: TPanel;
    pnlLocation: TPanel;
    pnlPasswordProtection: TPanel;
    pnlSize: TPanel;
    tabDatabase: TTabSheet;
    tabRecords: TTabSheet;
    procedure btnAccountsClick(Sender: TObject);
    procedure btnBudgetClick(Sender: TObject);
    procedure btnCategoriesClick(Sender: TObject);
    procedure btnCommentsClick(Sender: TObject);
    procedure btnCurrenciesClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure btnHolidaysClick(Sender: TObject);
    procedure btnLinksClick(Sender: TObject);
    procedure btnPayeesClick(Sender: TObject);
    procedure btnPaymentsClick(Sender: TObject);
    procedure btnPersonsClick(Sender: TObject);
    procedure btnRecycleClick(Sender: TObject);
    procedure btnSchedulerClick(Sender: TObject);
    procedure btnTagsClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  frmProperties: TfrmProperties;

implementation

{$R *.lfm}

uses
  uniMain, uniRecycleBin, uniAccounts, uniCurrencies, uniCategories, uniComments,
  uniPersons, uniPayees, uniHolidays, uniTags, uniSchedulers, uniWrite, uniBudgets,
  uniLinks, uniResources, uniSettings;

{ TfrmProperties }

procedure TfrmProperties.FormCreate(Sender: TObject);
begin
  tabProperties.TabIndex := 0;

  // set components height
  pnlCaption.Height := PanelHeight;
  pnlCaption1.Height := PanelHeight;
  pnlBottom.Height := ButtonHeight;

  // get form icon
  frmMain.img16.GetIcon(9, (Sender as TForm).Icon);
end;

procedure TfrmProperties.FormResize(Sender: TObject);
begin
  lblWidth.Caption := IntToStr((Sender as TForm).Width);
  lblHeight.Caption := IntToStr((Sender as TForm).Height);
  pnlCaption.Repaint;
  pnlCaption1.Repaint;
end;

procedure TfrmProperties.btnExitClick(Sender: TObject);
begin
  frmProperties.Close;
end;

procedure TfrmProperties.btnHolidaysClick(Sender: TObject);
begin
  frmHolidays.ShowModal;
end;

procedure TfrmProperties.btnLinksClick(Sender: TObject);
begin
  frmLinks.ShowModal;
end;

procedure TfrmProperties.btnPayeesClick(Sender: TObject);
begin
  frmPayees.ShowModal;
end;

procedure TfrmProperties.btnPaymentsClick(Sender: TObject);
begin
  frmWrite.ShowModal;
end;

procedure TfrmProperties.btnPersonsClick(Sender: TObject);
begin
  frmPersons.ShowModal;
end;

procedure TfrmProperties.btnAccountsClick(Sender: TObject);
begin
  frmAccounts.ShowModal;
end;

procedure TfrmProperties.btnBudgetClick(Sender: TObject);
begin
  frmBudgets.ShowModal;
end;

procedure TfrmProperties.btnCategoriesClick(Sender: TObject);
begin
  frmCategories.ShowModal;
end;

procedure TfrmProperties.btnCommentsClick(Sender: TObject);
begin
  frmComments.ShowModal;
end;

procedure TfrmProperties.btnCurrenciesClick(Sender: TObject);
begin
  frmCurrencies.ShowModal;
end;

procedure TfrmProperties.btnRecycleClick(Sender: TObject);
begin
  frmRecycleBin.ShowModal;
  frmProperties.FormShow(frmProperties);
end;

procedure TfrmProperties.btnSchedulerClick(Sender: TObject);
begin
  frmSchedulers.ShowModal;
end;

procedure TfrmProperties.btnTagsClick(Sender: TObject);
begin
  frmTags.ShowModal;
end;

procedure TfrmProperties.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
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
        if INI.ReadString('POSITION', frmProperties.Name, '') <>
          IntToStr(frmProperties.Left) + separ + // form left
        IntToStr(frmProperties.Top) + separ + // form top
        IntToStr(frmProperties.Width) + separ + // form width
        IntToStr(frmProperties.Height) then
          INI.WriteString('POSITION', frmProperties.Name,
            IntToStr(frmProperties.Left) + separ + // form left
            IntToStr(frmProperties.Top) + separ + // form top
            IntToStr(frmProperties.Width) + separ + // form width
            IntToStr(frmProperties.Height));
      finally
        INI.Free;
      end;
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmProperties.FormShow(Sender: TObject);
var
  D: Double;
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
      frmProperties.Position := poDesigned;
      S := INI.ReadString('POSITION', frmProperties.Name, '-1•-1•0•0');

      // width
      TryStrToInt(Field(Separ, S, 3), I);
      if (I < 1) or (I > Screen.Width) then
        frmProperties.Width := Screen.Width - 300 - (200 - ScreenRatio)
      else
        frmProperties.Width := I;

      /// height
      TryStrToInt(Field(Separ, S, 4), I);
      if (I < 1) or (I > Screen.Height) then
        frmProperties.Height := Screen.Height - 400 - (200 - ScreenRatio)
      else
        frmProperties.Height := I;

      // left
      TryStrToInt(Field(Separ, S, 1), I);
      if (I < 0) or (I > Screen.Width) then
        frmProperties.left := (Screen.Width - frmProperties.Width) div 2
      else
        frmProperties.Left := I;

      // top
      TryStrToInt(Field(Separ, S, 2), I);
      if (I < 0) or (I > Screen.Height) then
        frmProperties.Top := ((Screen.Height - frmProperties.Height) div 2) - 75
      else
        frmProperties.Top := I;
    end;
  finally
    INI.Free
  end;
  // ********************************************************************
  // FORM SIZE END
  // ********************************************************************

  // get file name
  lblFileName.Caption := ExtractFileName(frmMain.Conn.DatabaseName);

  // get file location
  lblLocation.Caption := ExtractFilePath(frmMain.Conn.DatabaseName);

  // get password protection
  lblPasswordProtection.Caption := IfThen(lblPasswordProtection.Tag = 0,
    Caption_109, Caption_108);
  emoji.GetBitmap(lblPasswordProtection.Tag, imgPassword.Picture.Bitmap);

  // get encryption protection
  lblEncryptionProtection.Caption := IfThen(lblEncryptionProtection.Tag = 0,
    Caption_109, Caption_108);
  emoji.GetBitmap(2 + lblEncryptionProtection.Tag, imgEncryption.Picture.Bitmap);

  // get file I
  try
    I := FileUtil.FileSize(frmMain.Conn.DatabaseName);
    lblSize.Caption := AnsiReplaceStr(Format('%n', [I + 0.0], FS_own), FS_own.DecimalSeparator + '00','') + ' b';
  Except
    lblSize.Caption := '???';
  end;

  // MAIN DATA ----------------------------
  frmMain.QRY.SQL.Text := 'SELECT COUNT(*) FROM data';
  frmMain.QRY.Open;
  D := frmMain.QRY.Fields[0].AsFloat;
  frmMain.QRY.Close;
  btnData.Caption := AnsiReplaceStr(Format('%n', [D], FS_own), FS_own.DecimalSeparator + '00','');

  // RECYCLE BIN  ----------------------------
  frmMain.QRY.SQL.Text := 'SELECT COUNT(*) FROM recycles';
  frmMain.QRY.Open;
  D := frmMain.QRY.Fields[0].AsFloat;
  frmMain.QRY.Close;
  btnRecycle.Caption := AnsiReplaceStr(Format('%n', [D], FS_own), FS_own.DecimalSeparator + '00','');

  // ACCOUNTS  ----------------------------
  frmMain.QRY.SQL.Text := 'SELECT COUNT(*) FROM accounts';
  frmMain.QRY.Open;
  D := frmMain.QRY.Fields[0].AsFloat;
  frmMain.QRY.Close;
  btnAccounts.Caption := AnsiReplaceStr(Format('%n', [D], FS_own), FS_own.DecimalSeparator + '00','');

  // CURRENCIES  ----------------------------
  frmMain.QRY.SQL.Text := 'SELECT COUNT(*) FROM currencies';
  frmMain.QRY.Open;
  D := frmMain.QRY.Fields[0].AsFloat;
  frmMain.QRY.Close;
  btnCurrencies.Caption := AnsiReplaceStr(Format('%n', [D], FS_own), FS_own.DecimalSeparator + '00','');

  // CATEGORES  ----------------------------
  frmMain.QRY.SQL.Text := 'SELECT COUNT(*) FROM categories';
  frmMain.QRY.Open;
  D := frmMain.QRY.Fields[0].AsFloat;
  frmMain.QRY.Close;
  btnCategories.Caption := AnsiReplaceStr(Format('%n', [D], FS_own), FS_own.DecimalSeparator + '00','');

  // COMMENTS  ----------------------------
  frmMain.QRY.SQL.Text := 'SELECT COUNT(*) FROM comments';
  frmMain.QRY.Open;
  D := frmMain.QRY.Fields[0].AsFloat;
  frmMain.QRY.Close;
  btnComments.Caption := AnsiReplaceStr(Format('%n', [D], FS_own), FS_own.DecimalSeparator + '00','');

  // PERSONS  ----------------------------
  frmMain.QRY.SQL.Text := 'SELECT COUNT(*) FROM persons';
  frmMain.QRY.Open;
  D := frmMain.QRY.Fields[0].AsFloat;
  frmMain.QRY.Close;
  btnPersons.Caption := AnsiReplaceStr(Format('%n', [D], FS_own), FS_own.DecimalSeparator + '00','');

  // PAYEES  ----------------------------
  frmMain.QRY.SQL.Text := 'SELECT COUNT(*) FROM payees';
  frmMain.QRY.Open;
  D := frmMain.QRY.Fields[0].AsFloat;
  frmMain.QRY.Close;
  btnPayees.Caption := AnsiReplaceStr(Format('%n', [D], FS_own), FS_own.DecimalSeparator + '00','');

  // HOLIDAYS  ----------------------------
  frmMain.QRY.SQL.Text := 'SELECT COUNT(*) FROM holidays';
  frmMain.QRY.Open;
  D := frmMain.QRY.Fields[0].AsFloat;
  frmMain.QRY.Close;
  btnHolidays.Caption := AnsiReplaceStr(Format('%n', [D], FS_own), FS_own.DecimalSeparator + '00','');

  // TAGS  ----------------------------
  frmMain.QRY.SQL.Text := 'SELECT COUNT(*) FROM tags';
  frmMain.QRY.Open;
  D := frmMain.QRY.Fields[0].AsFloat;
  frmMain.QRY.Close;
  btnTags.Caption := AnsiReplaceStr(Format('%n', [D], FS_own), FS_own.DecimalSeparator + '00','');

  // SCHEDULER  ----------------------------
  frmMain.QRY.SQL.Text := 'SELECT COUNT(*) FROM scheduler';
  frmMain.QRY.Open;
  D := frmMain.QRY.Fields[0].AsFloat;
  frmMain.QRY.Close;
  btnScheduler.Caption := AnsiReplaceStr(Format('%n', [D], FS_own), FS_own.DecimalSeparator + '00','');

  // PAYMENTS  ----------------------------
  frmMain.QRY.SQL.Text := 'SELECT COUNT(*) FROM payments';
  frmMain.QRY.Open;
  D := frmMain.QRY.Fields[0].AsFloat;
  frmMain.QRY.Close;
  btnPayments.Caption := AnsiReplaceStr(Format('%n', [D], FS_own), FS_own.DecimalSeparator + '00','');

  // BUDGET  ----------------------------
  frmMain.QRY.SQL.Text := 'SELECT COUNT(*) FROM budgets';
  frmMain.QRY.Open;
  D := frmMain.QRY.Fields[0].AsFloat;
  frmMain.QRY.Close;
  btnBudget.Caption := AnsiReplaceStr(Format('%n', [D], FS_own), FS_own.DecimalSeparator + '00','');

  // LINKS  ----------------------------
  frmMain.QRY.SQL.Text := 'SELECT COUNT(*) FROM links';
  frmMain.QRY.Open;
  D := frmMain.QRY.Fields[0].AsFloat;
  frmMain.QRY.Close;
  btnLinks.Caption := AnsiReplaceStr(Format('%n', [D], FS_own), FS_own.DecimalSeparator + '00','');


  // get current OS   ----------------------------
    {$IFDEF WIN32}
    lblOS2.Caption := 'Windows 32-bit';
    {$ENDIF}
    {$IFDEF WIN64}
    lblOS2.Caption := 'Windows 64-bit';
    {$ENDIF}
    {$IFDEF LINUX}
    lblOS2.Caption := 'Linux';
    {$ENDIF}

  lblSQLiteVersion2.Caption := sqlite3_version();
  lblSQLiteName2.Caption := frmMain.Conn.GetConnectionInfo(citClientName);

end;

end.

