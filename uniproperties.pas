unit uniProperties;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls, sqldb, sqlite3,
  ComCtrls, ActnList, Buttons, BCPanel, BCMDButtonFocus, FileUtil, StrUtils;

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
    lblPayees: TLabel;
    lblPayments: TLabel;
    lblPersons: TLabel;
    lblProtection: TLabel;
    lblProtection_: TLabel;
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
    pnlButtons: TPanel;
    pnlCaption1: TBCPanel;
    pnlDatabase: TPanel;
    pnlCaption: TBCPanel;
    pnlFileName: TPanel;
    pnlLocation: TPanel;
    pnlProtection: TPanel;
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
  uniMain, uniRecycleBin, uniAccounts, uniCurrencies, uniCategories, uniComments, uniPersons,
  uniPayees, uniHolidays, uniTags, uniSchedulers, uniWrite, uniBudgets, uniLinks;

{ TfrmProperties }

procedure TfrmProperties.FormCreate(Sender: TObject);
begin
  tabProperties.TabIndex := 0;

  {$IFDEF WINDOWS}
  // set components height
  pnlCaption.Height := PanelHeight;
  pnlCaption1.Height := PanelHeight;
  pnlButtons.Height := ButtonHeight;
  pnlBottom.Height := ButtonHeight;
  {$ENDIF}
end;

procedure TfrmProperties.FormResize(Sender: TObject);
begin
  lblWidth.Caption := IntToStr((Sender as TForm).Width);
  lblHeight.Caption := IntToStr((Sender as TForm).Height);

  btnExit.BorderSpacing.Left := (pnlButtons.Width - btnExit.Width) div 2;
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

procedure TfrmProperties.FormShow(Sender: TObject);
var
  I: Integer;
  D: Double;

begin
  // get file name
  lblFileName.Caption := ExtractFileName(frmMain.Conn.DatabaseName);

  // get file location
  lblLocation.Caption := ExtractFilePath(frmMain.Conn.DatabaseName);

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

