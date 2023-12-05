unit uniSettings;

{$mode objfpc}{$H+}
{$ModeSwitch AutoDeref}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  LazUTF8, StdCtrls, ComCtrls, Buttons, dateutils, LCLIntf, laz.VirtualTrees,
  FileCtrl, uniMultiple, ExCheckCtrls, BCTypes, BCMDButtonFocus, BCPanel,
  IniFiles, strutils, Math, LCLTranslator, Spin, LCLProc, ActnList,
  LCLType, CalendarLite, DateTimePicker;

type // bottom grid (Key)
  TKey = record
    action: string;
    shortcut: string;
    Caption: string;
  end;
  PKey = ^TKey;

type // bottom grid (Key)
  TLang = record
    code: string;
    Name: string;
    translator: string;
    email: string;
  end;
  PLang = ^TLang;

type

  { TfrmSettings }

  TfrmSettings = class(TForm)
    actChange: TAction;
    ActionList1: TActionList;
    btnBackupFolder: TBitBtn;
    btnCancel: TBCMDButtonFocus;
    btnDefault: TBCMDButtonFocus;
    btnCaptionColorBack: TBCMDButtonFocus;
    btnCaptionColorFont: TBCMDButtonFocus;
    btnChange: TBCMDButtonFocus;
    btnEditTemplate: TBCMDButtonFocus;
    btnIniFile: TBCMDButtonFocus;
    btnOddRowColorBack: TBCMDButtonFocus;
    btnSave: TBCMDButtonFocus;
    cbxFirstWeekDay: TComboBox;
    cbxReportFont: TComboBox;
    chkChartRotateLabels: TCheckBox;
    chkChartShowLegend: TCheckBox;
    chkChartWrapLabelsText: TCheckBox;
    chkChartZeroBalance: TCheckBox;
    chkCloseDbWarning: TCheckBoxEx;
    chkDisplayFontBold: TCheckBox;
    chkDisplaySubCatCapital: TCheckBox;
    chkEnableSelfTransfer: TCheckBox;
    chkPrintSummarySeparately: TCheckBoxEx;
    chkPaymentSeparately: TCheckBox;
    chkNewVersion: TCheckBox;
    datTransactionsAddDate: TDateTimePicker;
    datTransactionsEditDate: TDateTimePicker;
    datTransactionsDeleteDate: TDateTimePicker;
    filListReports: TFileListBox;
    gbxBackupCount: TGroupBox;
    gbxBackup: TGroupBox;
    gbxChartBottomAxisLabels: TGroupBox;
    gbxCharts: TGroupBox;
    gbxTransactionsEdit: TGroupBox;
    gbxTransactionsDelete: TGroupBox;
    gbxTransactionsRestrictions: TGroupBox;
    gbxTransactionsAdd: TGroupBox;
    imgFlags: TImageList;
    lblTransactionsAddDays: TLabel;
    lblChartRotateDegree: TLabel;
    lblTransactionsAddDate: TLabel;
    lblTransactionsEditDate: TLabel;
    lblTransactionsDeleteDate: TLabel;
    lblTransactionsEditDays: TLabel;
    lblTransactionsDeleteDays: TLabel;
    pnlTransactionsAddDays: TPanel;
    Panel3: TPanel;
    pnlCharts: TPage;
    lblListReports: TLabel;
    lblPayments1: TLabel;
    lblPayments2: TLabel;
    lblReportFont: TLabel;
    lblReportFontSample: TLabel;
    lblReportFontSample1: TLabel;
    pnlTransactionsAddDate: TPanel;
    pnlTransactionsEditDate: TPanel;
    pnlTransactionsDeleteDate: TPanel;
    pnlTransactionsEditDays: TPanel;
    pnlTransactionsDeleteDays: TPanel;
    rbtTransactionsAddDate: TRadioButton;
    rbtTransactionsAddDays: TRadioButton;
    rbtTransactionsDeleteDays: TRadioButton;
    rbtTransactionsEditDays: TRadioButton;
    rbtTransactionsDeleteDate: TRadioButton;
    rbtTransactionsEditNo: TRadioButton;
    rbtTransactionsAddNo: TRadioButton;
    rbtTransactionsDeleteNo: TRadioButton;
    rbtTransactionsEditDate: TRadioButton;
    spiChartRotateLabels: TSpinEdit;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel9: TPanel;
    pnlBackupCount: TPanel;
    gbxBackupFolder: TGroupBox;
    pnlButtons: TPanel;
    pnlListReports: TPanel;
    pnlPayments: TPanel;
    pnlReportFont: TPanel;
    spiGridFontSize: TSpinEdit;
    cbxGridFontName: TComboBox;
    spiTransactionsAddDays: TSpinEdit;
    spiPayments: TSpinEdit;
    chkOpenNewTransaction: TCheckBoxEx;
    chkBackupMessage: TCheckBox;
    chkBoldFont: TCheckBox;
    chkDoBackup: TCheckBox;
    chkGradientEffect: TCheckBox;
    chkHoliday: TCheckBox;
    chkLastFormsSize: TCheckBox;
    chkLastUsedFile: TCheckBox;
    chkLastUsedFilter: TCheckBox;
    chkSaturday: TCheckBox;
    chkShowDifference: TCheckBox;
    chkShadowedFont: TCheckBox;
    chkShowIndex: TCheckBox;
    chkSunday: TCheckBox;
    chkAutoColumnWidth: TCheckBox;
    ediDecimalSeparator: TEdit;
    ediLongDateFormat: TEdit;
    ediShortDateFormat: TEdit;
    ediThousandSeparator: TEdit;
    lblGridFont: TLabel;
    lblTransactionsColor: TLabel;
    pnlTransactionsClient: TPanel;
    pnlGridFont: TPanel;
    pnlTransactions: TPage;
    Panel10: TPanel;
    Panel12: TPanel;
    Panel13: TPanel;
    pnlShortCutsClient: TPanel;
    pnlCreditTransactionsColor: TPanel;
    pnlDebitTransactionsColor: TPanel;
    pnlTransactionsColor: TPanel;
    pnlTransferMTransactionsColor: TPanel;
    pnlTransferPTransactionsColor: TPanel;
    rbtCreditColorAll: TRadioButton;
    rbtCreditColorBlack: TRadioButton;
    rbtCreditColorMixed: TRadioButton;
    rbtDebitColorAll: TRadioButton;
    rbtDebitColorBlack: TRadioButton;
    rbtDebitColorMixed: TRadioButton;
    rbtTransfersMColorAll: TRadioButton;
    rbtTransfersMColorBlack: TRadioButton;
    rbtTransfersMColorMixed: TRadioButton;
    rbtTransfersPColorAll: TRadioButton;
    rbtTransfersPColorBlack: TRadioButton;
    rbtTransfersPColorMixed: TRadioButton;
    spiReportSize: TSpinEdit;
    spiTransactionsEditDays: TSpinEdit;
    spiTransactionsDeleteDays: TSpinEdit;
    tabCreditFontColor: TTabSheet;
    tabDebitFontColor: TTabSheet;
    tabFontColor: TPageControl;
    tabGlobal: TPageControl;
    pnlOnRunClient: TPanel;
    pnlOnRun: TPage;
    pnlClient: TPanel;
    pnlCloseDb: TPage;
    pnlFormats: TPanel;
    imgHeight: TImage;
    imgWidth: TImage;
    lblDateFormat: TLabel;
    lblDateLong1: TLabel;
    lblDateLong2: TLabel;
    lblDateShort1: TLabel;
    lblDateShort2: TLabel;
    lblDecimalSeparator: TLabel;
    lblExampleLongDate: TLabel;
    lblExampleSeparator: TLabel;
    lblExampleShortDate: TLabel;
    lblFirstWeekDay: TLabel;
    lblHeight: TLabel;
    lblNumberExample: TLabel;
    lblNumericFormat: TLabel;
    lblOddRowColor: TLabel;
    lblPanelsColor: TLabel;
    lblScheduler1: TLabel;
    lblScheduler2: TLabel;
    lblScheduler3: TLabel;
    lblScheduler4: TLabel;
    lblThousandSeparator: TLabel;
    lblWidth: TLabel;
    lbxLanguage1: TFileListBox;
    pnlButtonsKeys: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    pnlDateFormat: TPanel;
    pnlDecimalSeparator: TPanel;
    pnlExample: TPanel;
    pnlGlobal: TPage;
    Panels: TNotebook;
    pnlHeight: TPanel;
    pnlLanguage: TPanel;
    pnlBottom: TPanel;
    pnlNumericFormat: TPanel;
    pnlOddRowColor: TPanel;
    pnlOddRowColorSettings: TPanel;
    pnl_OnStart: TPanel;
    pnlOnStart: TPage;
    pnlPanelsColor: TPanel;
    pnlReports: TPage;
    pnlShortcuts: TPage;
    pnlThousandSeparator: TPanel;
    pnlTools: TPage;
    pnlVisual: TPage;
    pnlVisualButtons: TPanel;
    pnlWidth: TPanel;
    cd: TColorDialog;
    rbtAfter: TRadioButton;
    rbtBefore: TRadioButton;
    rbtSettingsAutomatic: TRadioButton;
    rbtSettingsUser: TRadioButton;
    sd: TSelectDirectoryDialog;
    splSettings: TSplitter;
    tabProgram: TTabSheet;
    tabScheduler: TTabSheet;
    tabBudgets: TTabSheet;
    tabLanguage: TTabSheet;
    tabFormat: TTabSheet;
    tabPayments: TTabSheet;
    tabTables: TTabSheet;
    tabTool: TPageControl;
    tabTransferMFontColor: TTabSheet;
    tabTransferPFontColor: TTabSheet;
    tabVisualSettings: TPageControl;
    traBackupCount: TTrackBar;
    treSettings: TTreeView;
    VSTKeys: TLazVirtualStringTree;
    VSTLang: TLazVirtualStringTree;
    procedure btnBackupFolderClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnCaptionColorBackClick(Sender: TObject);
    procedure btnChangeClick(Sender: TObject);
    procedure btnDefaultClick(Sender: TObject);
    procedure btnEditTemplateClick(Sender: TObject);
    procedure btnIniFileClick(Sender: TObject);
    procedure btnOddRowColorBackClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure cbxFirstWeekDayChange(Sender: TObject);
    procedure cbxGridFontNameChange(Sender: TObject);
    procedure chkChartRotateLabelsChange(Sender: TObject);
    procedure chkChartShowLegendChange(Sender: TObject);
    procedure chkChartZeroBalanceChange(Sender: TObject);
    procedure chkDisplayFontBoldChange(Sender: TObject);
    procedure chkDisplaySubCatCapitalChange(Sender: TObject);
    procedure datTransactionsAddDateChange(Sender: TObject);
    procedure datTransactionsDeleteDateChange(Sender: TObject);
    procedure datTransactionsEditDateChange(Sender: TObject);
    procedure gbxTransactionsRestrictionsResize(Sender: TObject);
    procedure lblTransactionsAddDateClick(Sender: TObject);
    procedure lblTransactionsDeleteDateClick(Sender: TObject);
    procedure lblTransactionsEditDateClick(Sender: TObject);
    procedure rbtTransactionsAddDaysChange(Sender: TObject);
    procedure rbtTransactionsAddDateChange(Sender: TObject);
    procedure rbtTransactionsDeleteDaysChange(Sender: TObject);
    procedure rbtTransactionsDeleteDateChange(Sender: TObject);
    procedure rbtTransactionsEditDaysChange(Sender: TObject);
    procedure rbtTransactionsEditDateChange(Sender: TObject);
    procedure spiChartRotateLabelsChange(Sender: TObject);
    procedure spiGridFontSizeChange(Sender: TObject);
    procedure cbxReportFontChange(Sender: TObject);
    procedure spiPaymentsChange(Sender: TObject);
    procedure spiReportSizeChange(Sender: TObject);
    procedure chkDoBackupChange(Sender: TObject);
    procedure chkGradientEffectClick(Sender: TObject);
    procedure chkShowDifferenceChange(Sender: TObject);
    procedure chkAutoColumnWidthChange(Sender: TObject);
    procedure ediShortDateFormatChange(Sender: TObject);
    procedure filListReportsChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure pnlButtonsResize(Sender: TObject);
    procedure rbtCreditColorBlackChange(Sender: TObject);
    procedure rbtDebitColorBlackChange(Sender: TObject);
    procedure rbtSettingsAutomaticChange(Sender: TObject);
    procedure rbtSettingsUserChange(Sender: TObject);
    procedure rbtTransfersMColorBlackChange(Sender: TObject);
    procedure rbtTransfersPColorBlackChange(Sender: TObject);
    procedure splSettingsCanResize(Sender: TObject; var NewSize: integer;
      var Accept: boolean);
    procedure traBackupCountChange(Sender: TObject);
    procedure treSettingsAdvancedCustomDrawItem(Sender: TCustomTreeView;
      Node: TTreeNode; State: TCustomDrawState; Stage: TCustomDrawStage;
      var PaintImages, DefaultDraw: boolean);
    procedure treSettingsChange(Sender: TObject; Node: TTreeNode);
    procedure VSTLangChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure VSTLangGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: boolean; var ImageIndex: integer);
    procedure VSTLangGetNodeDataSize(Sender: TBaseVirtualTree;
      var NodeDataSize: integer);
    procedure VSTKeysBeforeCellPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
    procedure VSTKeysChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure VSTKeysDblClick(Sender: TObject);
    procedure VSTKeysGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: boolean; var ImageIndex: integer);
    procedure VSTKeysGetNodeDataSize(Sender: TBaseVirtualTree;
      var NodeDataSize: integer);
    procedure VSTKeysGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure VSTKeysResize(Sender: TObject);
    procedure VSTLangGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure VSTLangResize(Sender: TObject);

  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmSettings: TfrmSettings;
  FirstRun: boolean;

procedure UpdateSettings;
procedure SetPanelProperty(Sender: TObject);
procedure SetBtnProperty(Sender: TBCMDButtonFocus);
procedure UpdateShortCuts(Action: string; S: TShortCut);

implementation

{$R *.lfm}

uses
  uniMain, uniAbout, uniAccounts, uniPersons, uniScheduler, uniEdit, uniDelete,
  uniCounter, uniCurrencies, uniProperties, uniSchedulers, uniShortCut,
  uniPayees, uniCategories, uniHolidays, uniTags, uniComments, uniValues, uniBudgets,
  uniGuide, uniPassword, uniSQLResults, uniHistory, uniWrite, uniManyCurrencies,
  uniSuccess, uniGate, uniSQL, uniRecycleBin, uniFilter, uniImport, uniDetail,
  uniCalendar, uniResources, uniwriting, uniEdits, uniPeriod, uniPlan, uniTemplates,
  uniBudget, uniLinks;

  { TfrmSettings }

procedure TfrmSettings.FormCreate(Sender: TObject);
var
  I: integer;
  INI: TINIFile;
  INIFile, TempStr, File1: string;
  SystemFS: boolean;
  Key: PKey;
  Lang: PLang;
begin
  try
    // form size
    (Sender as TForm).Width := Round(
      (Screen.Width / IfThen(ScreenIndex = 0, 1, (ScreenRatio / 100))) -
      (Round(920 / (ScreenRatio / 100)) - ScreenRatio));
    (Sender as TForm).Height :=
      Round(Screen.Height / IfThen(ScreenIndex = 0, 1, (ScreenRatio / 100))) -
      4 * (250 - ScreenRatio);

    // form position
    (Sender as TForm).Left := (Screen.Width - (Sender as TForm).Width) div 2;
    (Sender as TForm).Top := ((Screen.Height - frmSettings.Height) div 2) - 75;

    frmSettings.Tag := 1;

    {$IFDEF WINDOWS}
    // set components height
    VSTKeys.Header.Height := PanelHeight;
    VSTLang.Header.Height := PanelHeight;
    pnlButtons.Height := ButtonHeight;
    pnlButtonsKeys.Height := ButtonHeight;
    pnlBottom.Height := ButtonHeight;
    {$ENDIF}

    tabGlobal.TabIndex := 0;
    tabVisualSettings.TabIndex := 0;
    tabFontColor.TabIndex := 0;
    tabTool.TabIndex := 0;

    // list of all reports
    filListReports.Directory :=
      ExtractFileDir(Application.ExeName) + DirectorySeparator + 'Templates';

    // input day long names
    for I := 1 to 7 do
    begin
      cbxFirstWeekDay.Items.Add(DefaultFormatSettings.LongDayNames[I]);
      frmMain.Calendar.DayNames :=
        frmMain.Calendar.DayNames + sLineBreak + DefaultFormatSettings.ShortDayNames[I];
    end;
    cbxFirstWeekDay.ItemIndex := 1;
    Panels.PageIndex := 0;

    for I := 0 to 11 do
      frmMain.Calendar.MonthNames :=
        frmMain.Calendar.MonthNames + sLineBreak +
        DefaultFormatSettings.LongMonthNames[I + 1];

    // frmMain calendar
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;

  // =================================================================================
  // FONT NAMES AND SIZES
  // =================================================================================
  try
    // input system fonts to the reports
    cbxReportFont.Items := Screen.Fonts;
    // set default font to the reports
    cbxReportFont.ItemIndex :=
      cbxReportFont.Items.IndexOf(GetFontData(frmMain.Font.Handle).Name);
    if cbxReportFont.ItemIndex = -1 then
      cbxReportFont.ItemIndex := 0;

    // input font names to the grids
    cbxGridFontName.Items := cbxReportFont.Items;
    // set default font name
    cbxGridFontName.ItemIndex := cbxReportFont.ItemIndex;

  except
    on E: Exception do
      ShowErrorMessage(E);
  end;

  // =================================================================================
  // LANGUAGE
  // =================================================================================

  try
    // read languages from folder LANGUAGES
    lbxLanguage1.Directory := ExtractFileDir(Application.ExeName) +
      DirectorySeparator + 'Languages';

    if lbxLanguage1.Items.Count > 0 then
      for I := 0 to lbxLanguage1.Items.Count - 1 do
      begin
        VSTLang.RootNodeCount := VSTLang.RootNodeCount + 1;
        Lang := VSTLang.GetNodeData(VSTLang.GetLast());
        Lang.code := AnsiLowerCase(LeftStr(lbxLanguage1.Items[I], 2));
        if Lang.code = 'cs' then
          Lang.Name := 'česky'
        else if Lang.code = 'en' then
          Lang.Name := 'english'
        else if Lang.code = 'sk' then
          Lang.Name := 'slovensky'
        else if Lang.code = 'br' then
        begin
          Lang.Name := 'português';
          Lang.translator := 'Douglas Ramos';
          Lang.email := 'mrsdouglasmail@gmail.com';
        end
        else
          Lang.Name := '???';
      end;

  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
  SetNodeHeight(VSTLang);

  // =================================================================================
  // CREATE INI FILE
  // =================================================================================
  try
    INIFile := ChangeFileExt(ParamStr(0), '.ini');

    // INI file WRITE procedure (if file does not exists) =========================
    if FileExists(INIFile) = False then
    begin
      FirstRun := True;
      INI := TINIFile.Create(INIFile);
      try
        // writing values to the INI file.
        INI.WriteInteger('GLOBAL', 'Version', 2);
        INI.WriteString('GLOBAL', 'Language',
          AnsiLowerCase(LeftStr(GetLang, 2)) + '.po');

        SetDefaultLang(
          AnsiLowerCase(LeftStr(GetLang, 2)),
          ExtractFileDir(Application.ExeName) + DirectorySeparator + 'Languages',
          AnsiLowerCase(LeftStr(GetLang, 2)) + '.po',
          True);

        INI.WriteBool('SYSTEM_FORMAT', 'Automatic', rbtSettingsAutomatic.Checked);
        // ====== Char(226) make error displaying thousand separators
        if Ord(DefaultFormatSettings.ThousandSeparator) = 226 then
          DefaultFormatSettings.ThousandSeparator := ' ';
        // ======
        INI.WriteString('SYSTEM_FORMAT', 'ThousandSeparator',
          IfThen(rbtSettingsAutomatic.Checked = True, '', IntToStr(
          Ord(DefaultFormatSettings.ThousandSeparator))));
        INI.WriteString('SYSTEM_FORMAT', 'DecimalSeparator',
          IfThen(rbtSettingsAutomatic.Checked = True, '', IntToStr(
          Ord(DefaultFormatSettings.DecimalSeparator))));
        INI.WriteString('SYSTEM_FORMAT', 'FirstWeekDay',
          IfThen(rbtSettingsAutomatic.Checked = True, '', '0'));
        INI.WriteString('SYSTEM_FORMAT', 'DateShortFormat',
          IfThen(rbtSettingsAutomatic.Checked = True, '',
          DefaultFormatSettings.ShortDateFormat));
        INI.WriteString('SYSTEM_FORMAT', 'DateLongFormat',
          IfThen(rbtSettingsAutomatic.Checked = True, '', ReplaceStr(
          DefaultFormatSettings.LongDateFormat, '"', '')));

        // ---------------------------------------------------
        INI.WriteBool('VISUAL_SETTINGS', 'ShadowedFont', True);
        INI.WriteBool('VISUAL_SETTINGS', 'BoldFont', True);
        INI.WriteBool('VISUAL_SETTINGS', 'CaptionsGradient', True);
        INI.WriteInteger('VISUAL_SETTINGS', 'CaptionsColor', $00AAB220);
        // gold $0000D7FF, orange 497912
        INI.WriteInteger('VISUAL_SETTINGS', 'CaptionsColorFont', clWhite);
        INI.WriteInteger('VISUAL_SETTINGS', 'OddRowColor', 14803425);
        INI.WriteInteger('VISUAL_SETTINGS', 'ColorizeCredit', 1);
        INI.WriteInteger('VISUAL_SETTINGS', 'ColorizeDebit', 1);
        INI.WriteInteger('VISUAL_SETTINGS', 'ColorizeTransferPlus', 1);
        INI.WriteInteger('VISUAL_SETTINGS', 'ColorizeTransferMinus', 1);
        INI.WriteString('VISUAL_SETTINGS', 'FontName',
          GetFontData(frmMain.Font.Handle).Name);
        INI.WriteInteger('VISUAL_SETTINGS', 'FontSize', 10);
        INI.WriteBool('VISUAL_SETTINGS', 'SummaryPieChartVisible', frmMain.chkShowPieChart.Checked);

        // ---------------------------------------------------
        INI.WriteBool('ON_START', 'OpenLastFile', chkLastUsedFile.Checked);
        INI.WriteString('ON_START', 'LastFile', '');
        INI.WriteBool('ON_START', 'OpenLastFormsSize', chkLastFormsSize.Checked);
        INI.WriteBool('ON_START', 'OpenLastFilter', chkLastUsedFilter.Checked);
        INI.WriteBool('ON_START', 'TablesColumnsAutoWidth', chkAutoColumnWidth.Checked);
        INI.WriteBool('ON_START', 'CheckNewVersion', True);

        // ---------------------------------------------------
        INI.WriteString('REPORTS', 'FontName', GetFontData(frmMain.Font.Handle).Name);
        INI.WriteInteger('REPORTS', 'FontSize', 10);
        INI.WriteBool('REPORTS', 'ChartLegend', True);
        INI.WriteBool('REPORTS', 'ChartZeroBalance', False);
        INI.WriteInteger('REPORTS', 'ChartRotate', 25);
        INI.WriteBool('REPORTS', 'ChartWrap', True);

        // ---------------------------------------------------
        INI.WriteBool('TRANSACTIONS', 'OpenFormAuto', chkOpenNewTransaction.Checked);
        INI.WriteBool('TRANSACTIONS', 'PrintSummarySeparately',
          chkPrintSummarySeparately.Checked);
        INI.WriteBool('TRANSACTIONS', 'DisplayAmountFontBold', True);
        INI.WriteBool('TRANSACTIONS', 'DisplaySubcategoryCapitalLetters', True);
        INI.WriteBool('TRANSACTIONS', 'EnableSelfTransfer', False);

        // restrictions
        INI.WriteString('TRANSACTIONS', 'RestrictionsAdd', '');
        INI.WriteString('TRANSACTIONS', 'RestrictionsEdit', '');
        INI.WriteString('TRANSACTIONS', 'RestrictionsDelete', '');

        // ---------------------------------------------------
        INI.WriteBool('SCHEDULER', 'Saturday', chkSaturday.Checked);
        INI.WriteBool('SCHEDULER', 'Sunday', chkSunday.Checked);
        INI.WriteBool('SCHEDULER', 'Holiday', chkHoliday.Checked);
        INI.WriteBool('SCHEDULER', 'Before', rbtBefore.Checked);

        INI.WriteBool('PAYMENTS', 'WriteSeparately', False);
        INI.WriteInteger('PAYMENTS', 'ShowWeeksCount', 0);

        INI.WriteBool('BUDGETS', 'ShowDifference', chkShowDifference.Checked);
        INI.WriteBool('BUDGETS', 'ShowIndex', chkShowIndex.Checked);

        // ---------------------------------------------------
        INI.WriteBool('BACKUP', 'DoBackup', chkDoBackup.Checked);
        INI.WriteString('BACKUP', 'Folder', '');
        INI.WriteInteger('BACKUP', 'Count', traBackupCount.Position);
        INI.WriteBool('BACKUP', 'ShowMessage', chkBackupMessage.Checked);

        // ---------------------------------------------------
        INI.WriteBool('ON_CLOSE', 'ConfirmDialog', chkCloseDbWarning.Checked);

        // ---------------------------------------------------
        // record
        INI.WriteString('KEYS', 'record_add', 'INS');
        INI.WriteString('KEYS', 'record_add_multi', 'CTRL+INS');
        INI.WriteString('KEYS', 'record_edit', 'SPACE');
        INI.WriteString('KEYS', 'record_duplicate', 'SHIFT+INS');
        INI.WriteString('KEYS', 'record_delete', 'DEL');
        INI.WriteString('KEYS', 'record_copy_all', 'CTRL+C');
        INI.WriteString('KEYS', 'record_copy_selected', 'SHIFT+C');
        INI.WriteString('KEYS', 'record_select', 'CTRL+A');
        INI.WriteString('KEYS', 'record_print_all', 'CTRL+P');
        INI.WriteString('KEYS', 'record_print_selected', 'SHIFT+P');
        INI.WriteString('KEYS', 'record_history', 'CTRL+H');
        INI.WriteString('KEYS', 'record_save', 'SHIFT+ENTER');
        INI.WriteString('KEYS', 'record_swap', 'SCROLLLOCK');

        // menu database
        INI.WriteString('KEYS', 'db_new', 'CTRL+N');
        INI.WriteString('KEYS', 'db_open', 'CTRL+O');
        INI.WriteString('KEYS', 'db_close', 'CTRL+X');
        INI.WriteString('KEYS', 'db_import', 'CTRL+I');
        INI.WriteString('KEYS', 'db_export', 'CTRL+E');
        INI.WriteString('KEYS', 'db_password', 'CTRL+W');
        INI.WriteString('KEYS', 'db_guide', 'CTRL+G');
        INI.WriteString('KEYS', 'db_sql', 'CTRL+Q');
        INI.WriteString('KEYS', 'db_trash', 'CTRL+L');
        INI.WriteString('KEYS', 'db_properties', 'CTRL+J');

        // menu lists
        INI.WriteString('KEYS', 'list_links', 'F4');
        INI.WriteString('KEYS', 'list_holidays', 'F5');
        INI.WriteString('KEYS', 'list_tags', 'F6');
        INI.WriteString('KEYS', 'list_currencies', 'F7');
        INI.WriteString('KEYS', 'list_payees', 'F8');
        INI.WriteString('KEYS', 'list_comments', 'F9');
        INI.WriteString('KEYS', 'list_accounts', 'F10');
        INI.WriteString('KEYS', 'list_categories', 'F11');
        INI.WriteString('KEYS', 'list_persons', 'F12');

        // menu tools
        INI.WriteString('KEYS', 'tool_scheduler', 'CTRL+S');
        INI.WriteString('KEYS', 'tool_write', 'CTRL+Y');
        INI.WriteString('KEYS', 'tool_calendar', 'CTRL+D');
        INI.WriteString('KEYS', 'tool_budget', 'CTRL+B');
        INI.WriteString('KEYS', 'tool_report', 'CTRL+R');
        INI.WriteString('KEYS', 'tool_counter', 'CTRL+U');
        INI.WriteString('KEYS', 'tool_calc', 'CTRL+K');

        // menu program
        INI.WriteString('KEYS', 'settings', 'CTRL+T');
        INI.WriteString('KEYS', 'update', 'CTRL+Z');
        INI.WriteString('KEYS', 'about', 'CTRL+M');

        // filter
        INI.WriteString('KEYS', 'filter_clear', 'CTRL+SHIFT+F1');
        INI.WriteString('KEYS', 'filter_expand', 'CTRL+SHIFT+F2');
        INI.WriteString('KEYS', 'filter_collapse', 'CTRL+SHIFT+F3');

        // ---------------------------------------------------
        INI.UpdateFile;
        INI.Free;
      except
        on E: Exception do
        begin
          ShowErrorMessage(E);
          // After the ini file was used it must be freed to prevent memory leaks.
          INI.Free;
        end;
      end;
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;

  // =================================================================================
  // READ INI FILE
  // =================================================================================
  // Create the object, specifying the the ini file that contains the settings
  if FileExists(INIFile) = True then
  begin
    INI := TINIFile.Create(INIFile);

    try
      // update to version 2
      // =========================================================
      if INI.ReadInteger('GLOBAL', 'Version', 1) = 1 then
      begin

        // delete old previous key(s)
        INI.DeleteKey('ON_START', 'SummaryColumnsAutoWidth');
        INI.DeleteKey('ON_START', 'TransactionsColumnsAutoWidth');
        // write new key
        INI.WriteBool('ON_START', 'TablesColumnsAutoWidth', chkAutoColumnWidth.Checked);
        // update version
        INI.WriteInteger('GLOBAL', 'Version', 2);
      end;

      // =========================================================

      // reading values from the INI file.
      // set language
      TempStr := INI.ReadString('GLOBAL', 'Language',
        AnsiLowerCase(LeftStr(GetLang, 2)) + '.po');
      VSTLang.Hint := LeftStr(TempStr, 2);

      SetDefaultLang(
        VSTLang.Hint,
        ExtractFileDir(Application.ExeName) + DirectorySeparator + 'Languages',
        TempStr,
        True);

      // ---------------------------------------------------
      // SET GLOBAL SETTINGS
      // ---------------------------------------------------
      // FORMAT settings
      SystemFS := INI.ReadBool('SYSTEM_FORMAT', 'Automatic', True);

      FS_own := DefaultFormatSettings; // necessary
      if SystemFS = True then
      begin
        rbtSettingsAutomatic.Checked := True;
        rbtSettingsAutomaticChange(rbtSettingsAutomatic);
      end
      else
      begin
        rbtSettingsUser.Checked := True;
        ediThousandSeparator.Text :=
          Chr(StrToInt(INI.ReadString('SYSTEM_FORMAT', 'ThousandSeparator',
          DefaultFormatSettings.ThousandSeparator)));
        ediDecimalSeparator.Text :=
          Chr(StrToInt(INI.ReadString('SYSTEM_FORMAT', 'DecimalSeparator',
          DefaultFormatSettings.DecimalSeparator)));
        cbxFirstWeekDay.ItemIndex :=
          INI.ReadInteger('SYSTEM_FORMAT', 'FirstWeekDay', 0);
        ediShortDateFormat.Text :=
          INI.ReadString('SYSTEM_FORMAT', 'DateShortFormat',
          DefaultFormatSettings.ShortDateFormat);
        ediLongDateFormat.Text :=
          INI.ReadString('SYSTEM_FORMAT', 'DateLongFormat',
          DefaultFormatSettings.LongDateFormat);
        rbtSettingsUserChange(rbtSettingsUser);
      end;
      frmMain.Calendar.StartingDayOfWeek := TDayOfWeek(cbxFirstWeekDay.ItemIndex);

      // =======================================================================================
      // set PROGRAM settings

      chkShadowedFont.Checked := INI.ReadBool('VISUAL_SETTINGS', 'ShadowedFont', True);
      chkBoldFont.Checked := INI.ReadBool('VISUAL_SETTINGS', 'BoldFont', True);
      chkGradientEffect.Checked :=
        INI.ReadBool('VISUAL_SETTINGS', 'CaptionsGradient', True);
      btnCaptionColorBack.Tag :=
        INI.ReadInteger('VISUAL_SETTINGS', 'CaptionsColor', 14446080);
      btnCaptionColorFont.Tag :=
        INI.ReadInteger('VISUAL_SETTINGS', 'CaptionsColorFont', 14803425);

      // Rows color
      btnOddRowColorBack.Tag :=
        INI.ReadInteger('VISUAL_SETTINGS', 'OddRowColor', 14803425);
      pnlOddRowColor.Color := btnOddRowColorBack.Tag;

      // color of credit transactions
      pnlCreditTransactionsColor.Tag :=
        INI.ReadInteger('VISUAL_SETTINGS', 'ColorizeCredit', 1);
      case pnlCreditTransactionsColor.Tag of
        0: rbtCreditColorBlack.Checked := True;
        1: rbtCreditColorMixed.Checked := True
        else
          rbtCreditColorAll.Checked := True;
      end;

      // color of debit transactions
      pnlDebitTransactionsColor.Tag :=
        INI.ReadInteger('VISUAL_SETTINGS', 'ColorizeDebit', 1);
      case pnlDebitTransactionsColor.Tag of
        0: rbtDebitColorBlack.Checked := True;
        1: rbtDebitColorMixed.Checked := True
        else
          rbtDebitColorAll.Checked := True;
      end;

      // color of transfer plus transactions
      pnlTransferPTransactionsColor.Tag :=
        INI.ReadInteger('VISUAL_SETTINGS', 'ColorizeTransferPlus', 1);
      case pnlTransferPTransactionsColor.Tag of
        0: rbtTransfersPColorBlack.Checked := True;
        1: rbtTransfersPColorMixed.Checked := True
        else
          rbtTransfersPColorAll.Checked := True;
      end;

      // color of transer minus transactions
      pnlTransferMTransactionsColor.Tag :=
        INI.ReadInteger('VISUAL_SETTINGS', 'ColorizeTransferMinus', 1);
      case pnlTransferMTransactionsColor.Tag of
        0: rbtTransfersMColorBlack.Checked := True;
        1: rbtTransfersMColorMixed.Checked := True
        else
          rbtTransfersMColorAll.Checked := True;
      end;

      // grid font name
      cbxGridFontName.ItemIndex :=
        cbxGridFontName.Items.IndexOf(INI.ReadString('VISUAL_SETTINGS',
        'FontName', GetFontData(frmMain.Font.Handle).Name));
      if cbxGridFontName.ItemIndex = -1 then
        cbxGridFontName.ItemIndex := 5;
      cbxGridFontNameChange(cbxGridFontName);

      // grid font size
      spiGridFontSize.Value := INI.ReadInteger('VISUAL_SETTINGS', 'FontSize', 10);

      // summary pie chart visibility
      frmMain.chkShowPieChart.Checked := INI.ReadBool('VISUAL_SETTINGS', 'SummaryPieChartVisible', True);

      // ---------------------------------------------------
      cbxReportFont.ItemIndex :=
        cbxReportFont.Items.IndexOf(INI.ReadString('REPORTS', 'FontName',
        GetFontData(frmMain.Font.Handle).Name));
      cbxReportFontChange(cbxReportFont);

      spiReportSize.Value := INI.ReadInteger('REPORTS', 'FontSize', 10);
      spiReportSizeChange(spiReportSize);

      chkChartShowLegend.Checked := INI.ReadBool('REPORTS', 'ChartLegend', True);
      chkChartZeroBalance.Checked := INI.ReadBool('REPORTS', 'ChartZeroBalance', False);

      I := INI.ReadInteger('REPORTS', 'ChartRotate', 25);
      chkChartRotateLabels.Checked := I > 0;
      chkChartRotateLabelsChange(chkChartRotateLabels);
      spiChartRotateLabels.Value := I;

      chkChartWrapLabelsText.Checked := INI.ReadBool('REPORTS', 'ChartWrap', True);

      // ---------------------------------------------------
      chkOpenNewTransaction.Checked :=
        INI.ReadBool('TRANSACTIONS', 'OpenFormAuto', False);
      chkPrintSummarySeparately.Checked :=
        INI.ReadBool('TRANSACTIONS', 'PrintSummarySeparately', True);
      chkDisplayFontBold.Checked :=
        INI.ReadBool('TRANSACTIONS', 'DisplayAmountFontBold', True);
      chkDisplaySubCatCapital.Checked :=
        INI.ReadBool('TRANSACTIONS', 'DisplaySubcategoryCapitalLetters', True);
      chkEnableSelfTransfer.Checked :=
        INI.ReadBool('TRANSACTIONS', 'EnableSelfTransfer', False);

      TempStr := INI.ReadString('TRANSACTIONS', 'RestrictionsAdd', '');
      case Length(TempStr) of
        0: rbtTransactionsAddNo.Checked := True;
        10: begin
          rbtTransactionsAddDate.Checked := True;
          datTransactionsAddDate.Date := StrToDate(TempStr, 'YYYY-MM-DD', '-');
        end
        else
        begin
          rbtTransactionsAddDays.Checked := True;
          spiTransactionsAddDays.Value := StrToInt(TempStr);
        end;
      end;

      TempStr := INI.ReadString('TRANSACTIONS', 'RestrictionsEdit', '');
      case Length(TempStr) of
        0: rbtTransactionsEditNo.Checked := True;
        10: begin
          rbtTransactionsEditDate.Checked := True;
          datTransactionsEditDate.Date := StrToDate(TempStr, 'YYYY-MM-DD', '-');
        end
        else
        begin
          rbtTransactionsEditDays.Checked := True;
          spiTransactionsEditDays.Value := StrToInt(TempStr);
        end;
      end;

      TempStr := INI.ReadString('TRANSACTIONS', 'RestrictionsDelete', '');
      case Length(TempStr) of
        0: rbtTransactionsDeleteNo.Checked := True;
        10: begin
          rbtTransactionsDeleteDate.Checked := True;
          datTransactionsDeleteDate.Date := StrToDate(TempStr, 'YYYY-MM-DD', '-');
        end
        else
        begin
          rbtTransactionsDeleteDays.Checked := True;
          spiTransactionsDeleteDays.Value := StrToInt(TempStr);
        end;
      end;

      // ---------------------------------------------------
      chkSaturday.Checked := INI.ReadBool('SCHEDULER', 'Saturday', True);
      chkSunday.Checked := INI.ReadBool('SCHEDULER', 'Sunday', True);
      chkHoliday.Checked := INI.ReadBool('SCHEDULER', 'Holiday', True);
      rbtBefore.Checked := INI.ReadBool('SCHEDULER', 'Before', True);
      rbtAfter.Checked := not (INI.ReadBool('SCHEDULER', 'Before', False));

      chkPaymentSeparately.Checked := INI.ReadBool('PAYMENTS', 'WriteSeparately', False);
      spiPayments.Value := INI.ReadInteger('PAYMENTS', 'ShowWeeksCount', 0);

      chkShowDifference.Checked := INI.ReadBool('BUDGETS', 'ShowDifference', False);
      chkShowIndex.Checked := INI.ReadBool('BUDGETS', 'ShowIndex', False);

      // ---------------------------------------------------
      chkDoBackup.Checked := INI.ReadBool('BACKUP', 'DoBackup', chkDoBackup.Checked);
      btnBackupFolder.Caption :=
        INI.ReadString('BACKUP', 'Folder', btnBackupFolder.Caption);
      traBackupCount.Position :=
        INI.ReadInteger('BACKUP', 'Count', traBackupCount.Position);
      traBackupCountChange(traBackupCount);
      chkBackupMessage.Checked :=
        INI.ReadBool('BACKUP', 'ShowMessage', chkBackupMessage.Checked);

      // =======================================================================================
      // last used file
      if INI.ReadBool('ON_START', 'OpenLastFile', True) = True then
      begin
        chkLastUsedFile.Checked := True;
        File1 := INI.ReadString('ON_START', 'LastFile', '');
      end
      else
      begin
        File1 := '';
        chkLastUsedFile.Checked := False;
      end;

      // last used filter
      chkLastUsedFilter.Checked := INI.ReadBool('ON_START', 'OpenLastFilter', True);

      // last used main form size
      chkLastFormsSize.Checked := INI.ReadBool('ON_START', 'OpenLastFormsSize', True);

      // check new version
      chkNewVersion.Checked := INI.ReadBool('ON_START', 'CheckNewVersion', True);

      // ---------------------------------------------------
      chkCloseDbWarning.Checked := INI.ReadBool('ON_CLOSE', 'ConfirmDialog', True);

      // FORMS SIZE AND POSITION
      if chkLastFormsSize.Checked = True then
      begin
        // frmMain
        frmMain.Position := poDesigned;
        frmMain.Width := INI.ReadInteger('frmMain', 'Width', frmMain.Width);
        frmMain.Height := INI.ReadInteger('frmMain', 'Height', frmMain.Height);
        frmMain.Left := INI.ReadInteger('frmMain', 'Left',
          (Screen.Width - frmMain.Width) div 2);
        frmMain.Top := INI.ReadInteger('frmMain', 'Top',
          ((Screen.Height - frmMain.Height) div 2) - 75);
        frmMain.pnlFilter.Width :=
          INI.ReadInteger('frmMain', 'pnlFilter', frmMain.pnlFilter.Width);
        frmMain.pnlSummary.Height :=
          INI.ReadInteger('frmMain', 'pnlSummary', frmMain.pnlSummary.Height);
        frmMain.vstBalance.Height := INI.ReadInteger('frmMain', 'ChartBalance', 200);

        // frmDetail
        frmDetail.Position := poDesigned;
        frmDetail.Width := INI.ReadInteger('frmDetail', 'Width', frmDetail.Width);
        frmDetail.Height := INI.ReadInteger('frmDetail', 'Height', frmDetail.Height);
        frmDetail.Left := INI.ReadInteger('frmDetail', 'Left',
          (Screen.Width - frmDetail.Width) div 2);
        frmDetail.Top := INI.ReadInteger('frmDetail', 'Top',
          ((Screen.Height - frmDetail.Height) div 2) - 75);
        frmDetail.pnlRight.Width :=
          INI.ReadInteger('frmDetail', 'pnlRight', frmDetail.pnlRight.Width);
        frmDetail.pnlRight.Tag := frmDetail.pnlRight.Width;

        // frmMultiple
        frmMultiple.Position := poDesigned;
        frmMultiple.Width :=
          INI.ReadInteger('frmMultiple', 'Width', frmMultiple.Width);
        frmMultiple.Height :=
          INI.ReadInteger('frmMultiple', 'Height', frmMultiple.Height);
        frmMultiple.Left := INI.ReadInteger('frmMultiple', 'Left',
          (Screen.Width - frmMultiple.Width) div 2);
        frmMultiple.Top := INI.ReadInteger('frmMultiple', 'Top',
          ((Screen.Height - frmMultiple.Height) div 2) - 75);
        frmMultiple.pnlLeft.Width :=
          INI.ReadInteger('frmMultiple', 'pnlLeft', frmMultiple.pnlLeft.Width);
        frmMultiple.pnlDetail.Width :=
          INI.ReadInteger('frmMultiple', 'pnlRight', frmMultiple.pnlDetail.Width);

        // frmEdit
        frmEdit.Position := poDesigned;
        frmEdit.Width := INI.ReadInteger('frmEdit', 'Width', frmEdit.Width);
        frmEdit.Height := INI.ReadInteger('frmEdit', 'Height', frmEdit.Height);
        frmEdit.Left := INI.ReadInteger('frmEdit', 'Left',
          (Screen.Width - frmEdit.Width) div 2);
        frmEdit.Top := INI.ReadInteger('frmEdit', 'Top',
          ((Screen.Height - frmEdit.Height) div 2) - 75);
        frmEdit.gbxTag.Width :=
          INI.ReadInteger('frmEdit', 'pnlRight', frmEdit.gbxTag.Width);

        // frmEdits
        frmEdits.Position := poDesigned;
        frmEdits.Width := INI.ReadInteger('frmEdits', 'Width', frmEdits.Width);
        frmEdits.Height := INI.ReadInteger('frmEdits', 'Height', frmEdits.Height);
        frmEdits.Left := INI.ReadInteger('frmEdits', 'Left',
          (Screen.Width - frmEdits.Width) div 2);
        frmEdits.Top := INI.ReadInteger('frmEdits', 'Top',
          ((Screen.Height - frmEdits.Height) div 2) - 75);
        frmEdits.pnlTag.Width :=
          INI.ReadInteger('frmEdits', 'pnlRight', frmEdits.pnlTag.Width);

        // frmCalendar
        frmCalendar.Position := poDesigned;
        frmCalendar.Width :=
          INI.ReadInteger('frmCalendar', 'Width', frmCalendar.Width);
        frmCalendar.Height :=
          INI.ReadInteger('frmCalendar', 'Height', frmCalendar.Height);
        frmCalendar.Left := INI.ReadInteger('frmCalendar', 'Left',
          (Screen.Width - frmCalendar.Width) div 2);
        frmCalendar.Top := INI.ReadInteger('frmCalendar', 'Top',
          ((Screen.Height - frmCalendar.Height) div 2) - 75);
        frmCalendar.pnlLeft.Width :=
          INI.ReadInteger('frmCalendar', 'pnlLeft', frmCalendar.pnlLeft.Width);

        // frmCategories
        frmCategories.Position := poDesigned;
        frmCategories.Width :=
          INI.ReadInteger('frmCategories', 'Width', frmCategories.Width);
        frmCategories.Height :=
          INI.ReadInteger('frmCategories', 'Height', frmCategories.Height);
        frmCategories.Left :=
          INI.ReadInteger('frmCategories', 'Left', (Screen.Width -
          frmCategories.Width) div 2);
        frmCategories.Top :=
          INI.ReadInteger('frmCategories', 'Top',
          ((Screen.Height - frmCategories.Height) div 2) - 75);
        frmCategories.pnlDetail.Width :=
          INI.ReadInteger('frmCategories', 'pnlRight', frmCategories.pnlDetail.Width);

        // frmCurrencies
        frmCurrencies.Position := poDesigned;
        frmCurrencies.Width :=
          INI.ReadInteger('frmCurrencies', 'Width', frmCurrencies.Width);
        frmCurrencies.Height :=
          INI.ReadInteger('frmCurrencies', 'Height', frmCurrencies.Height);
        frmCurrencies.Left :=
          INI.ReadInteger('frmCurrencies', 'Left', (Screen.Width -
          frmCurrencies.Width) div 2);
        frmCurrencies.Top :=
          INI.ReadInteger('frmCurrencies', 'Top',
          ((Screen.Height - frmCurrencies.Height) div 2) - 75);
        frmCurrencies.pnlRight.Width :=
          INI.ReadInteger('frmCurrencies', 'pnlRight', frmCurrencies.pnlRight.Width);

        // frmValues
        frmValues.Position := poDesigned;
        frmValues.Width := INI.ReadInteger('frmValues', 'Width', frmValues.Width);
        frmValues.Height := INI.ReadInteger('frmValues', 'Height', frmValues.Height);
        frmValues.Left := INI.ReadInteger('frmValues', 'Left',
          (Screen.Width - frmValues.Width) div 2);
        frmValues.Top := INI.ReadInteger('frmValues', 'Top',
          ((Screen.Height - frmValues.Height) div 2) - 75);
        frmValues.pnlDetail.Width :=
          INI.ReadInteger('frmValues', 'pnlRight', frmValues.pnlDetail.Width);

        // frmAccounts
        frmAccounts.Position := poDesigned;
        frmAccounts.Width :=
          INI.ReadInteger('frmAccounts', 'Width', frmAccounts.Width);
        frmAccounts.Height :=
          INI.ReadInteger('frmAccounts', 'Height', frmAccounts.Height);
        frmAccounts.pnlDetail.Width :=
          INI.ReadInteger('frmAccounts', 'pnlRight', frmAccounts.pnlDetail.Width);
        frmAccounts.Left := INI.ReadInteger('frmAccounts', 'Left',
          (Screen.Width - frmAccounts.Width) div 2);
        frmAccounts.Top := INI.ReadInteger('frmAccounts', 'Top',
          ((Screen.Height - frmAccounts.Height) div 2) - 75);

        // frmPersons
        frmPersons.Position := poDesigned;
        frmPersons.Width := INI.ReadInteger('frmPersons', 'Width', frmPersons.Width);
        frmPersons.Height :=
          INI.ReadInteger('frmPersons', 'Height', frmPersons.Height);
        frmPersons.Left := INI.ReadInteger('frmPersons', 'Left',
          (Screen.Width - frmPersons.Width) div 2);
        frmPersons.Top := INI.ReadInteger('frmPersons', 'Top',
          ((Screen.Height - frmPersons.Height) div 2) - 75);
        frmPersons.pnlDetail.Width :=
          INI.ReadInteger('frmPersons', 'pnlRight', frmPersons.pnlDetail.Width);

        // frmPayees
        frmPayees.Position := poDesigned;
        frmPayees.Width := INI.ReadInteger('frmPayees', 'Width', frmPayees.Width);
        frmPayees.Height := INI.ReadInteger('frmPayees', 'Height', frmPayees.Height);
        frmPayees.Left := INI.ReadInteger('frmPayees', 'Left',
          (Screen.Width - frmPayees.Width) div 2);
        frmPayees.Top := INI.ReadInteger('frmPayees', 'Top',
          ((Screen.Height - frmPayees.Height) div 2) - 75);
        frmPayees.pnlDetail.Width :=
          INI.ReadInteger('frmPayees', 'pnlRight', frmPayees.pnlDetail.Width);

        // frmTags
        frmTags.Position := poDesigned;
        frmTags.Width := INI.ReadInteger('frmTags', 'Width', frmTags.Width);
        frmTags.Height := INI.ReadInteger('frmTags', 'Height', frmTags.Height);
        frmTags.Left := INI.ReadInteger('frmTags', 'Left',
          (Screen.Width - frmTags.Width) div 2);
        frmTags.Top := INI.ReadInteger('frmTags', 'Top',
          ((Screen.Height - frmTags.Height) div 2) - 75);
        frmTags.pnlDetail.Width :=
          INI.ReadInteger('frmTags', 'pnlRight', frmTags.pnlDetail.Width);

        // frmHolidays
        frmHolidays.Position := poDesigned;
        frmHolidays.Width :=
          INI.ReadInteger('frmHolidays', 'Width', frmHolidays.Width);
        frmHolidays.Height :=
          INI.ReadInteger('frmHolidays', 'Height', frmHolidays.Height);
        frmHolidays.Left := INI.ReadInteger('frmHolidays', 'Left',
          (Screen.Width - frmHolidays.Width) div 2);
        frmHolidays.Top := INI.ReadInteger('frmHolidays', 'Top',
          ((Screen.Height - frmHolidays.Height) div 2) - 75);
        frmHolidays.pnlDetail.Width :=
          INI.ReadInteger('frmHolidays', 'pnlRight', frmHolidays.pnlDetail.Width);

        // frmComments
        frmComments.Position := poDesigned;
        frmComments.Width :=
          INI.ReadInteger('frmComments', 'Width', frmComments.Width);
        frmComments.Height :=
          INI.ReadInteger('frmComments', 'Height', frmComments.Height);
        frmComments.pnlDetail.Width :=
          INI.ReadInteger('frmComments', 'pnlRight', frmComments.pnlDetail.Width);
        frmComments.Left := INI.ReadInteger('frmComments', 'Left',
          (Screen.Width - frmComments.Width) div 2);
        frmComments.Top := INI.ReadInteger('frmComments', 'Top',
          ((Screen.Height - frmComments.Height) div 2) - 75);

        // frmSQL
        frmSQL.Position := poDesigned;
        frmSQL.Left := INI.ReadInteger('frmSQL', 'Left', frmSQL.Left);
        frmSQL.Top := INI.ReadInteger('frmSQL', 'Top', frmSQL.Top);
        frmSQL.Width := INI.ReadInteger('frmSQL', 'Width', frmSQL.Width);
        frmSQL.Height := INI.ReadInteger('frmSQL', 'Height', frmSQL.Height);

        // frmSQLResult
        frmSQLResult.Position := poDesigned;
        frmSQLResult.Left :=
          INI.ReadInteger('frmSQLResult', 'Left', frmSQLResult.Left);
        frmSQLResult.Top := INI.ReadInteger('frmSQLResult', 'Top', frmSQLResult.Top);
        frmSQLResult.Width :=
          INI.ReadInteger('frmSQLResult', 'Width', frmSQLResult.Width);
        frmSQLResult.Height :=
          INI.ReadInteger('frmSQLResult', 'Height', frmSQLResult.Height);

        // frmRecycleBin
        frmRecycleBin.Position := poDesigned;
        frmRecycleBin.Left :=
          INI.ReadInteger('frmRecycleBin', 'Left', frmRecycleBin.Left);
        frmRecycleBin.Top :=
          INI.ReadInteger('frmRecycleBin', 'Top', frmRecycleBin.Top);
        frmRecycleBin.Width :=
          INI.ReadInteger('frmRecycleBin', 'Width', frmRecycleBin.Width);
        frmRecycleBin.Height :=
          INI.ReadInteger('frmRecycleBin', 'Height', frmRecycleBin.Height);

        // frmSchedulers
        frmSchedulers.Width :=
          INI.ReadInteger('frmSchedulers', 'Width', frmSchedulers.Width);
        frmSchedulers.Height :=
          INI.ReadInteger('frmSchedulers', 'Height', frmSchedulers.Height);
        frmSchedulers.pnlRight.Width :=
          INI.ReadInteger('frmSchedulers', 'pnlRight', frmSchedulers.pnlRight.Width);
        frmSchedulers.Position := poDesigned;
        frmSchedulers.Left := INI.ReadInteger('frmSchedulers', 'Left',
          (Screen.Width - frmSchedulers.Width) div 2);
        frmSchedulers.Top := INI.ReadInteger('frmSchedulers', 'Top',
          ((Screen.Height - frmSchedulers.Height) div 2) - 75);

        // frmScheduler
        frmScheduler.Position := poDesigned;
        frmScheduler.Width := INI.ReadInteger('frmScheduler', 'Width',
          frmScheduler.Width);
        frmScheduler.Height :=
          INI.ReadInteger('frmScheduler', 'Height', frmScheduler.Height);
        frmScheduler.Left := INI.ReadInteger('frmScheduler', 'Left',
          (Screen.Width - frmScheduler.Width) div 2);
        frmScheduler.Top := INI.ReadInteger('frmScheduler', 'Top',
          ((Screen.Height - frmScheduler.Height) div 2) - 75);
        frmScheduler.pnlRight.Width :=
          INI.ReadInteger('frmScheduler', 'pnlRight', frmScheduler.pnlRight.Width);

        // frmWrite
        frmWrite.Position := poDesigned;
        frmWrite.Width := INI.ReadInteger('frmWrite', 'Width', frmWrite.Width);
        frmWrite.Height := INI.ReadInteger('frmWrite', 'Height', frmWrite.Height);
        frmWrite.Left := INI.ReadInteger('frmWrite', 'Left',
          (Screen.Width - frmWrite.Width) div 2);
        frmWrite.Top := INI.ReadInteger('frmWrite', 'Top',
          ((Screen.Height - frmWrite.Height) div 2) - 75);

        // frmDelete
        frmDelete.Position := poDesigned;
        frmDelete.Left := INI.ReadInteger('frmDelete', 'Left', frmDelete.Left);
        frmDelete.Top := INI.ReadInteger('frmDelete', 'Top', frmDelete.Top);
        frmDelete.Width := INI.ReadInteger('frmDelete', 'Width', frmDelete.Width);
        frmDelete.Height := INI.ReadInteger('frmDelete', 'Height', frmDelete.Height);

        // frmHistory
        frmHistory.Position := poDesigned;
        frmHistory.Left := INI.ReadInteger('frmHistory', 'Left', frmHistory.Left);
        frmHistory.Top := INI.ReadInteger('frmHistory', 'Top', frmHistory.Top);
        frmHistory.Width := INI.ReadInteger('frmHistory', 'Width', frmHistory.Width);
        frmHistory.Height :=
          INI.ReadInteger('frmHistory', 'Height', frmHistory.Height);

        // frmCounter
        frmCounter.Position := poDesigned;
        frmCounter.Width := INI.ReadInteger('frmCounter', 'Width', frmCounter.Width);
        frmCounter.Height :=
          INI.ReadInteger('frmCounter', 'Height', frmCounter.Height);
        frmCounter.Left := INI.ReadInteger('frmCounter', 'Left',
          (Screen.Width - frmCounter.Width) div 2);
        frmCounter.Top := INI.ReadInteger('frmCounter', 'Top',
          ((Screen.Height - frmCounter.Height) div 2) - 75);

        {$IFDEF WINDOWS}
        // frmSettings
        frmSettings.Position := poDesigned;
        frmSettings.Width := INI.ReadInteger('frmSettings', 'Width', frmSettings.Width);
        frmSettings.Height := INI.ReadInteger('frmSettings', 'Height', frmSettings.Height);
        frmSettings.Left := INI.ReadInteger('frmSettings', 'Left', (Screen.Width - frmSettings.Width) div 2);
        frmSettings.Top := INI.ReadInteger('frmSettings', 'Top', ((Screen.Height - frmSettings.Height) div 2) - 75);
        frmSettings.treSettings.Width :=
          INI.ReadInteger('frmSettings', 'pnlLeft', frmSettings.treSettings.Width);
        {$ENDIF}

        // frmBudgets
        frmBudgets.Position := poDesigned;
        frmBudgets.tabLeft.Width :=
          INI.ReadInteger('frmBudgets', 'pnlLeft', frmBudgets.tabLeft.Width);
        frmBudgets.pnlPeriods.Width :=
          INI.ReadInteger('frmBudgets', 'pnlPeriods', frmBudgets.pnlPeriods.Width);
        frmBudgets.Left := INI.ReadInteger('frmBudgets', 'Left',
          (Screen.Width - frmBudgets.Width) div 2);
        frmBudgets.Top := INI.ReadInteger('frmBudgets', 'Top',
          ((Screen.Height - frmBudgets.Height) div 2) - 75);

        // frmBudget
        frmBudget.Position := poDesigned;
        frmBudget.Width := INI.ReadInteger('frmBudget', 'Width', frmBudget.Width);
        frmBudget.Height := INI.ReadInteger('frmBudget', 'Height', frmBudget.Height);
        frmBudget.Left := INI.ReadInteger('frmBudget', 'Left',
          (Screen.Width - frmBudget.Width) div 2);
        frmBudget.Top := INI.ReadInteger('frmBudget', 'Top',
          ((Screen.Height - frmBudget.Height) div 2) - 75);
        frmBudget.pnlLeft.Width :=
          INI.ReadInteger('frmBudget', 'pnlLeft', frmBudget.pnlLeft.Width);

        // frmPeriod
        frmPeriod.Position := poDesigned;
        frmPeriod.Width := INI.ReadInteger('frmPeriod', 'Width', frmPeriod.Width);
        frmPeriod.Height := INI.ReadInteger('frmPeriod', 'Height', frmPeriod.Height);
        frmPeriod.Left := INI.ReadInteger('frmPeriod', 'Left',
          (Screen.Width - frmPeriod.Width) div 2);
        frmPeriod.Top := INI.ReadInteger('frmPeriod', 'Top',
          ((Screen.Height - frmPeriod.Height) div 2) - 75);
        frmPeriod.pnlLeft.Width :=
          INI.ReadInteger('frmPeriod', 'pnlLeft', frmPeriod.pnlLeft.Width);

        // frmTemplates
        frmTemplates.Position := poDesigned;
        frmTemplates.Left :=
          INI.ReadInteger(frmTemplates.Name, 'Left', frmTemplates.Left);
        frmTemplates.Top := INI.ReadInteger(frmTemplates.Name, 'Top', frmTemplates.Top);
        frmTemplates.Width := INI.ReadInteger(frmTemplates.Name,
          'Width', frmTemplates.Width);
        frmTemplates.Height :=
          INI.ReadInteger(frmTemplates.Name, 'Height', frmTemplates.Height);
        frmTemplates.pnlLeft.Width :=
          INI.ReadInteger(frmTemplates.Name, 'pnlLeft', frmTemplates.pnlLeft.Width);

        // frmLinks
        frmLinks.Position := poDesigned;
        frmLinks.Width := INI.ReadInteger('frmLinks', 'Width', frmLinks.Width);
        frmLinks.Height := INI.ReadInteger('frmLinks', 'Height', frmLinks.Height);
        frmLinks.Left := INI.ReadInteger('frmLinks', 'Left',
          (Screen.Width - frmLinks.Width) div 2);
        frmLinks.Top := INI.ReadInteger('frmLinks', 'Top',
          ((Screen.Height - frmLinks.Height) div 2) - 75);
        frmLinks.pnlDetail.Width :=
          INI.ReadInteger('frmLinks', 'pnlRight', frmLinks.pnlDetail.Width);
      end;

      // set columns width on all tables (manually or automatic) - THIS IS AFTER FORMS RESIZING !!!
      chkAutoColumnWidth.Checked :=
        INI.ReadBool('ON_START', 'TablesColumnsAutoWidth', True);
      if chkAutoColumnWidth.Checked = True then
      begin
        frmAccounts.VSTResize(frmAccounts.VST);
        frmBudget.VSTResize(frmBudget.VST);
        frmBudgets.VSTPeriodsResize(frmBudgets.VSTPeriods);
        frmCalendar.VSTResize(frmCalendar.VST);
        frmCategories.VSTResize(frmCategories.VST);
        frmComments.VSTResize(frmComments.VST);
        frmCurrencies.VSTResize(frmCurrencies.VST);
        frmDelete.VST1Resize(frmDelete.VST1);
        frmDelete.VST2Resize(frmDelete.VST2);
        frmDelete.VST3Resize(frmDelete.VST3);
        frmHistory.VST1Resize(frmHistory.VST1);
        frmHistory.VST1Resize(frmHistory.VST2);
        frmHolidays.VSTResize(frmHolidays.VST);
        frmLinks.VSTResize(frmLinks.VST);
        frmMain.VSTResize(frmMain.VST);
        frmMain.VSTSummaryResize(frmMain.VSTSummary);
        frmMultiple.VSTResize(frmMultiple.VST);
        frmPayees.VSTResize(frmPayees.VST);
        frmPeriod.VSTResize(frmPeriod.VST);
        frmPersons.VSTResize(frmPersons.VST);
        frmRecycleBin.VSTResize(frmRecycleBin.VST);
        frmSchedulers.VST1Resize(frmSchedulers.VST1);
        frmSchedulers.VSTResize(frmSchedulers.VST);
        frmSettings.VSTKeysResize(frmSettings.VSTKeys);
        frmTags.VSTResize(frmTags.VST);
        frmValues.VSTResize(frmValues.VST);
        frmWrite.VSTResize(frmWrite.VST);

      end
      else
      begin
        // table Transactions
        for I := 1 to frmMain.VST.Header.Columns.Count - 1 do
          frmMain.VST.Header.Columns[I].Width :=
            INI.ReadInteger('frmMain', 'TransColumn_' +
            RightStr('0' + IntToStr(I), 2), 100);

        // table Summary
        for I := 1 to frmMain.VSTSummary.Header.Columns.Count - 1 do
          frmMain.VSTSummary.Header.Columns[I].Width :=
            INI.ReadInteger('frmMain', 'SumColumn_' +
            RightStr('0' + IntToStr(I), 2), 100);

        // table Report - Balance
        for I := 1 to frmMain.VSTBalance.Header.Columns.Count - 1 do
          frmMain.VSTBalance.Header.Columns[I].Width :=
            INI.ReadInteger('frmMain', 'BalanceCol_' +
            RightStr('0' + IntToStr(I), 2), 100);

        // table Report - Chrono
        for I := 1 to frmMain.VSTChrono.Header.Columns.Count - 1 do
          frmMain.VSTChrono.Header.Columns[I].Width :=
            INI.ReadInteger('frmMain', 'ChronoCol_' +
            RightStr('0' + IntToStr(I), 2), 100);

        // table frmWrite
        for I := 1 to frmWrite.VST.Header.Columns.Count - 1 do
          frmWrite.VST.Header.Columns[I].Width :=
            INI.ReadInteger('frmWrite', 'Col_' + RightStr('0' + IntToStr(I), 2), 100);

        // table frmSchedulers
        for I := 1 to frmSchedulers.VST.Header.Columns.Count - 1 do
          frmSchedulers.VST.Header.Columns[I].Width :=
            INI.ReadInteger('frmSchedulers', 'Col1_' +
            RightStr('0' + IntToStr(I), 2), 100);

        // table frmSchedulers
        for I := 1 to frmSchedulers.VST1.Header.Columns.Count - 1 do
          frmSchedulers.VST1.Header.Columns[I].Width :=
            INI.ReadInteger('frmSchedulers', 'Col2_' +
            RightStr('0' + IntToStr(I), 2), 100);

        // table frmAccounts
        for I := 1 to frmAccounts.VST.Header.Columns.Count - 1 do
          frmAccounts.VST.Header.Columns[I].Width :=
            INI.ReadInteger('frmAccounts', 'Col_' + RightStr('0' + IntToStr(I), 2), 100);

        // table frmCategories
        for I := 1 to frmCategories.VST.Header.Columns.Count - 1 do
          frmCategories.VST.Header.Columns[I].Width :=
            INI.ReadInteger('frmCategories', 'Col_' +
            RightStr('0' + IntToStr(I), 2), 100);

        // table frmPersons
        for I := 1 to frmPersons.VST.Header.Columns.Count - 1 do
          frmPersons.VST.Header.Columns[I].Width :=
            INI.ReadInteger('frmPersons', 'Col_' + RightStr('0' + IntToStr(I), 2), 100);

        // table frmPayees
        for I := 1 to frmPayees.VST.Header.Columns.Count - 1 do
          frmPayees.VST.Header.Columns[I].Width :=
            INI.ReadInteger('frmPayees', 'Col_' + RightStr('0' + IntToStr(I), 2), 100);

        // table frmCurrencies
        for I := 1 to frmCurrencies.VST.Header.Columns.Count - 1 do
          frmCurrencies.VST.Header.Columns[I].Width :=
            INI.ReadInteger('frmCurrencies', 'Col_' +
            RightStr('0' + IntToStr(I), 2), 100);

        // table frmComments
        for I := 1 to frmComments.VST.Header.Columns.Count - 1 do
          frmComments.VST.Header.Columns[I].Width :=
            INI.ReadInteger('frmComments', 'Col_' + RightStr('0' + IntToStr(I), 2), 100);

        // table frmTags
        for I := 1 to frmTags.VST.Header.Columns.Count - 1 do
          frmTags.VST.Header.Columns[I].Width :=
            INI.ReadInteger('frmTags', 'Col_' + RightStr('0' + IntToStr(I), 2), 100);

        // table frmValues
        for I := 1 to frmValues.VST.Header.Columns.Count - 1 do
          frmValues.VST.Header.Columns[I].Width :=
            INI.ReadInteger('frmValues', 'Col_' + RightStr('0' + IntToStr(I), 2), 100);

        // table frmHistory
        for I := 1 to frmHistory.VST1.Header.Columns.Count - 1 do
          frmHistory.VST1.Header.Columns[I].Width :=
            INI.ReadInteger('frmHistory', 'Col1_' + RightStr('0' + IntToStr(I), 2), 100);

        // table frmHistory
        for I := 1 to frmHistory.VST2.Header.Columns.Count - 1 do
          frmHistory.VST2.Header.Columns[I].Width :=
            INI.ReadInteger('frmHistory', 'Col2_' + RightStr('0' + IntToStr(I), 2), 100);

        // table frmDelete
        for I := 1 to frmDelete.VST1.Header.Columns.Count - 1 do
          frmDelete.VST1.Header.Columns[I].Width :=
            INI.ReadInteger('frmDelete', 'Col1_' + RightStr('0' + IntToStr(I), 2), 100);

        // table frmDelete
        for I := 1 to frmDelete.VST2.Header.Columns.Count - 1 do
          frmDelete.VST2.Header.Columns[I].Width :=
            INI.ReadInteger('frmDelete', 'Col2_' + RightStr('0' + IntToStr(I), 2), 100);

        // table frmDelete
        for I := 1 to frmDelete.VST3.Header.Columns.Count - 1 do
          frmDelete.VST3.Header.Columns[I].Width :=
            INI.ReadInteger('frmDelete', 'Col3_' + RightStr('0' + IntToStr(I), 2), 100);

        // table frmRecycleBin
        for I := 1 to frmRecycleBin.VST.Header.Columns.Count - 1 do
          frmRecycleBin.VST.Header.Columns[I].Width :=
            INI.ReadInteger('frmRecycleBin', 'Col_' +
            RightStr('0' + IntToStr(I), 2), 100);

        // table frmMultiple
        for I := 1 to frmMultiple.VST.Header.Columns.Count - 1 do
          frmMultiple.VST.Header.Columns[I].Width :=
            INI.ReadInteger('frmMultiple', 'Col_' + RightStr('0' + IntToStr(I), 2), 100);

        // table frmHolidays
        for I := 1 to frmHolidays.VST.Header.Columns.Count - 1 do
          frmHolidays.VST.Header.Columns[I].Width :=
            INI.ReadInteger('frmHolidays', 'Col_' + RightStr('0' + IntToStr(I), 2), 100);

        // table frmBudgets
        for I := 1 to frmBudgets.VSTBudgets.Header.Columns.Count - 1 do
          frmBudgets.VSTBudgets.Header.Columns[I].Width :=
            INI.ReadInteger('frmBudgets', 'ColB_' + RightStr('0' + IntToStr(I), 2), 100);

        // table frmBudgets
        for I := 1 to frmBudgets.VSTPeriods.Header.Columns.Count - 1 do
          frmBudgets.VSTPeriods.Header.Columns[I].Width :=
            INI.ReadInteger('frmBudgets', 'Col_' + RightStr('0' + IntToStr(I), 2), 100);

        // table frmBudget
        for I := 1 to frmBudget.VST.Header.Columns.Count - 1 do
          frmBudget.VST.Header.Columns[I].Width :=
            INI.ReadInteger('frmBudget', 'Col_' + RightStr('0' + IntToStr(I), 2), 100);

        // table frmPeriod
        for I := 1 to frmPeriod.VST.Header.Columns.Count - 1 do
          frmPeriod.VST.Header.Columns[I].Width :=
            INI.ReadInteger('frmPeriod', 'Col_' + RightStr('0' + IntToStr(I), 2), 100);

        // table frmSettings
        for I := 1 to frmSettings.VSTKeys.Header.Columns.Count - 1 do
          frmSettings.VSTKeys.Header.Columns[I].Width :=
            INI.ReadInteger('frmSettings', 'Col_' + RightStr('0' + IntToStr(I), 2), 100);

        // table frmLinks
        for I := 1 to frmLinks.VST.Header.Columns.Count - 1 do
          frmLinks.VST.Header.Columns[I].Width :=
            INI.ReadInteger('frmLinks', 'Col_' + RightStr('0' + IntToStr(I), 2), 100);

        // table frmCalendar
        for I := 1 to frmCalendar.VST.Header.Columns.Count - 1 do
          frmCalendar.VST.Header.Columns[I].Width :=
            INI.ReadInteger('frmCalendar', 'Col_' + RightStr('0' + IntToStr(I), 2), 100);
      end;

      // ---------------------------------------------------------------------------
      // SHORTCUTS
      // ---------------------------------------------------------------------------
      // actions
      VSTKeys.Clear;
      VSTKeys.RootNodeCount := 0;

      // -----------------------------------
      VSTKeys.RootNodeCount := VSTKeys.RootNodeCount + 1;
      Key := VSTKeys.GetNodeData(VSTKeys.GetLast());
      Key.action := 'record_add';
      Key.shortcut := INI.ReadString('KEYS', Key.action, 'INS');
      UpdateShortCuts(key.action, TextToShortCut(Key.shortcut));

      // -----------------------------------
      VSTKeys.RootNodeCount := VSTKeys.RootNodeCount + 1;
      Key := VSTKeys.GetNodeData(VSTKeys.GetLast());
      Key.action := 'record_add_multi';
      Key.shortcut := INI.ReadString('KEYS', Key.action, 'CTRL+INS');
      UpdateShortCuts(key.action, TextToShortCut(Key.shortcut));

      // -----------------------------------
      VSTKeys.RootNodeCount := VSTKeys.RootNodeCount + 1;
      Key := VSTKeys.GetNodeData(VSTKeys.GetLast());
      Key.action := 'record_edit';
      Key.shortcut := INI.ReadString('KEYS', Key.action, 'SPACE');
      UpdateShortCuts(key.action, TextToShortCut(Key.shortcut));

      // -----------------------------------
      VSTKeys.RootNodeCount := VSTKeys.RootNodeCount + 1;
      Key := VSTKeys.GetNodeData(VSTKeys.GetLast());
      Key.action := 'record_duplicate';
      Key.shortcut := INI.ReadString('KEYS', Key.action, 'SHIFT+INS');
      UpdateShortCuts(key.action, TextToShortCut(Key.shortcut));

      // -----------------------------------
      VSTKeys.RootNodeCount := VSTKeys.RootNodeCount + 1;
      Key := VSTKeys.GetNodeData(VSTKeys.GetLast());
      Key.action := 'record_delete';
      Key.shortcut := INI.ReadString('KEYS', Key.action, 'DEL');
      UpdateShortCuts(key.action, TextToShortCut(Key.shortcut));

      // -----------------------------------
      VSTKeys.RootNodeCount := VSTKeys.RootNodeCount + 1;
      Key := VSTKeys.GetNodeData(VSTKeys.GetLast());
      Key.action := 'record_copy_all';
      Key.shortcut := INI.ReadString('KEYS', Key.action, 'CTRL+C');
      UpdateShortCuts(key.action, TextToShortCut(Key.shortcut));

      // -----------------------------------
      VSTKeys.RootNodeCount := VSTKeys.RootNodeCount + 1;
      Key := VSTKeys.GetNodeData(VSTKeys.GetLast());
      Key.action := 'record_copy_selected';
      Key.shortcut := INI.ReadString('KEYS', Key.action, 'SHIFT+C');
      UpdateShortCuts(key.action, TextToShortCut(Key.shortcut));

      // -----------------------------------
      VSTKeys.RootNodeCount := VSTKeys.RootNodeCount + 1;
      Key := VSTKeys.GetNodeData(VSTKeys.GetLast());
      Key.action := 'record_select';
      Key.shortcut := INI.ReadString('KEYS', Key.action, 'CTRL+A');
      UpdateShortCuts(key.action, TextToShortCut(Key.shortcut));

      // -----------------------------------
      VSTKeys.RootNodeCount := VSTKeys.RootNodeCount + 1;
      Key := VSTKeys.GetNodeData(VSTKeys.GetLast());
      Key.action := 'record_print_all';
      Key.shortcut := INI.ReadString('KEYS', Key.action, 'CTRL+P');
      UpdateShortCuts(key.action, TextToShortCut(Key.shortcut));

      // -----------------------------------
      VSTKeys.RootNodeCount := VSTKeys.RootNodeCount + 1;
      Key := VSTKeys.GetNodeData(VSTKeys.GetLast());
      Key.action := 'record_print_selected';
      Key.shortcut := INI.ReadString('KEYS', Key.action, 'SHIFT+P');
      UpdateShortCuts(key.action, TextToShortCut(Key.shortcut));

      // -----------------------------------
      VSTKeys.RootNodeCount := VSTKeys.RootNodeCount + 1;
      Key := VSTKeys.GetNodeData(VSTKeys.GetLast());
      Key.action := 'record_history';
      Key.shortcut := INI.ReadString('KEYS', Key.action, 'CTRL+H');
      UpdateShortCuts(key.action, TextToShortCut(Key.shortcut));

      // actions
      // -----------------------------------
      VSTKeys.RootNodeCount := VSTKeys.RootNodeCount + 1;
      Key := VSTKeys.GetNodeData(VSTKeys.GetLast());
      Key.action := 'record_save';
      Key.shortcut := INI.ReadString('KEYS', Key.action, 'SHIFT+ENTER');
      UpdateShortCuts(key.action, TextToShortCut(Key.shortcut));

      // -----------------------------------
      VSTKeys.RootNodeCount := VSTKeys.RootNodeCount + 1;
      Key := VSTKeys.GetNodeData(VSTKeys.GetLast());
      Key.action := 'record_swap';
      Key.shortcut := INI.ReadString('KEYS', Key.action, 'SCROLLLOCK');
      UpdateShortCuts(key.action, TextToShortCut(Key.shortcut));

      // menu database
      // -----------------------------------
      VSTKeys.RootNodeCount := VSTKeys.RootNodeCount + 1;
      Key := VSTKeys.GetNodeData(VSTKeys.GetLast());
      Key.action := 'db_new';
      Key.shortcut := INI.ReadString('KEYS', Key.action, 'CTRL+N');
      UpdateShortCuts(key.action, TextToShortCut(Key.shortcut));

      // -----------------------------------
      VSTKeys.RootNodeCount := VSTKeys.RootNodeCount + 1;
      Key := VSTKeys.GetNodeData(VSTKeys.GetLast());
      Key.action := 'db_open';
      Key.shortcut := INI.ReadString('KEYS', Key.action, 'CTRL+O');
      UpdateShortCuts(key.action, TextToShortCut(Key.shortcut));

      // -----------------------------------
      VSTKeys.RootNodeCount := VSTKeys.RootNodeCount + 1;
      Key := VSTKeys.GetNodeData(VSTKeys.GetLast());
      Key.action := 'db_close';
      Key.shortcut := INI.ReadString('KEYS', Key.action, 'CTRL+X');
      UpdateShortCuts(key.action, TextToShortCut(Key.shortcut));

      // -----------------------------------
      VSTKeys.RootNodeCount := VSTKeys.RootNodeCount + 1;
      Key := VSTKeys.GetNodeData(VSTKeys.GetLast());
      Key.action := 'db_import';
      Key.shortcut := INI.ReadString('KEYS', Key.action, 'CTRL+I');
      UpdateShortCuts(key.action, TextToShortCut(Key.shortcut));

      // -----------------------------------
      VSTKeys.RootNodeCount := VSTKeys.RootNodeCount + 1;
      Key := VSTKeys.GetNodeData(VSTKeys.GetLast());
      Key.action := 'db_export';
      Key.shortcut := INI.ReadString('KEYS', Key.action, 'CTRL+E');
      UpdateShortCuts(key.action, TextToShortCut(Key.shortcut));

      // -----------------------------------
      VSTKeys.RootNodeCount := VSTKeys.RootNodeCount + 1;
      Key := VSTKeys.GetNodeData(VSTKeys.GetLast());
      Key.action := 'db_password';
      Key.shortcut := INI.ReadString('KEYS', Key.action, 'CTRL+W');
      UpdateShortCuts(key.action, TextToShortCut(Key.shortcut));

      // -----------------------------------
      VSTKeys.RootNodeCount := VSTKeys.RootNodeCount + 1;
      Key := VSTKeys.GetNodeData(VSTKeys.GetLast());
      Key.action := 'db_guide';
      Key.shortcut := INI.ReadString('KEYS', Key.action, 'CTRL+G');
      UpdateShortCuts(key.action, TextToShortCut(Key.shortcut));

      // -----------------------------------
      VSTKeys.RootNodeCount := VSTKeys.RootNodeCount + 1;
      Key := VSTKeys.GetNodeData(VSTKeys.GetLast());
      Key.action := 'db_sql';
      Key.shortcut := INI.ReadString('KEYS', Key.action, 'CTRL+Q');
      UpdateShortCuts(key.action, TextToShortCut(Key.shortcut));

      // -----------------------------------
      VSTKeys.RootNodeCount := VSTKeys.RootNodeCount + 1;
      Key := VSTKeys.GetNodeData(VSTKeys.GetLast());
      Key.action := 'db_trash';
      Key.shortcut := INI.ReadString('KEYS', Key.action, 'CTRL+L');
      UpdateShortCuts(key.action, TextToShortCut(Key.shortcut));

      // -----------------------------------
      VSTKeys.RootNodeCount := VSTKeys.RootNodeCount + 1;
      Key := VSTKeys.GetNodeData(VSTKeys.GetLast());
      Key.action := 'db_properties';
      Key.shortcut := INI.ReadString('KEYS', Key.action, 'CTRL+J');
      UpdateShortCuts(key.action, TextToShortCut(Key.shortcut));

      // menu lists
      // -----------------------------------
      VSTKeys.RootNodeCount := VSTKeys.RootNodeCount + 1;
      Key := VSTKeys.GetNodeData(VSTKeys.GetLast());
      Key.action := 'list_links';
      Key.shortcut := INI.ReadString('KEYS', Key.action, 'F4');
      UpdateShortCuts(key.action, TextToShortCut(Key.shortcut));

      // -----------------------------------
      VSTKeys.RootNodeCount := VSTKeys.RootNodeCount + 1;
      Key := VSTKeys.GetNodeData(VSTKeys.GetLast());
      Key.action := 'list_holidays';
      Key.shortcut := INI.ReadString('KEYS', Key.action, 'F5');
      UpdateShortCuts(key.action, TextToShortCut(Key.shortcut));

      // -----------------------------------
      VSTKeys.RootNodeCount := VSTKeys.RootNodeCount + 1;
      Key := VSTKeys.GetNodeData(VSTKeys.GetLast());
      Key.action := 'list_tags';
      Key.shortcut := INI.ReadString('KEYS', Key.action, 'F6');
      UpdateShortCuts(key.action, TextToShortCut(Key.shortcut));

      // -----------------------------------
      VSTKeys.RootNodeCount := VSTKeys.RootNodeCount + 1;
      Key := VSTKeys.GetNodeData(VSTKeys.GetLast());
      Key.action := 'list_currencies';
      Key.shortcut := INI.ReadString('KEYS', Key.action, 'F7');
      UpdateShortCuts(key.action, TextToShortCut(Key.shortcut));

      // -----------------------------------
      VSTKeys.RootNodeCount := VSTKeys.RootNodeCount + 1;
      Key := VSTKeys.GetNodeData(VSTKeys.GetLast());
      Key.action := 'list_payees';
      Key.shortcut := INI.ReadString('KEYS', Key.action, 'F8');
      UpdateShortCuts(key.action, TextToShortCut(Key.shortcut));

      // -----------------------------------
      VSTKeys.RootNodeCount := VSTKeys.RootNodeCount + 1;
      Key := VSTKeys.GetNodeData(VSTKeys.GetLast());
      Key.action := 'list_comments';
      Key.shortcut := INI.ReadString('KEYS', Key.action, 'F9');
      UpdateShortCuts(key.action, TextToShortCut(Key.shortcut));

      // -----------------------------------
      VSTKeys.RootNodeCount := VSTKeys.RootNodeCount + 1;
      Key := VSTKeys.GetNodeData(VSTKeys.GetLast());
      Key.action := 'list_accounts';
      Key.shortcut := INI.ReadString('KEYS', Key.action, 'F10');
      UpdateShortCuts(key.action, TextToShortCut(Key.shortcut));

      // -----------------------------------
      VSTKeys.RootNodeCount := VSTKeys.RootNodeCount + 1;
      Key := VSTKeys.GetNodeData(VSTKeys.GetLast());
      Key.action := 'list_categories';
      Key.shortcut := INI.ReadString('KEYS', Key.action, 'F11');
      UpdateShortCuts(key.action, TextToShortCut(Key.shortcut));

      // -----------------------------------
      VSTKeys.RootNodeCount := VSTKeys.RootNodeCount + 1;
      Key := VSTKeys.GetNodeData(VSTKeys.GetLast());
      Key.action := 'list_persons';
      Key.shortcut := INI.ReadString('KEYS', Key.action, 'F12');
      UpdateShortCuts(key.action, TextToShortCut(Key.shortcut));

      // menu tools
      // -----------------------------------
      VSTKeys.RootNodeCount := VSTKeys.RootNodeCount + 1;
      Key := VSTKeys.GetNodeData(VSTKeys.GetLast());
      Key.action := 'tool_scheduler';
      Key.shortcut := INI.ReadString('KEYS', Key.action, 'CTRL+S');
      UpdateShortCuts(key.action, TextToShortCut(Key.shortcut));

      // -----------------------------------
      VSTKeys.RootNodeCount := VSTKeys.RootNodeCount + 1;
      Key := VSTKeys.GetNodeData(VSTKeys.GetLast());
      Key.action := 'tool_write';
      Key.shortcut := INI.ReadString('KEYS', Key.action, 'CTRL+Y');
      UpdateShortCuts(key.action, TextToShortCut(Key.shortcut));

      // -----------------------------------
      VSTKeys.RootNodeCount := VSTKeys.RootNodeCount + 1;
      Key := VSTKeys.GetNodeData(VSTKeys.GetLast());
      Key.action := 'tool_calendar';
      Key.shortcut := INI.ReadString('KEYS', Key.action, 'CTRL+D');
      UpdateShortCuts(key.action, TextToShortCut(Key.shortcut));

      // -----------------------------------
      VSTKeys.RootNodeCount := VSTKeys.RootNodeCount + 1;
      Key := VSTKeys.GetNodeData(VSTKeys.GetLast());
      Key.action := 'tool_budget';
      Key.shortcut := INI.ReadString('KEYS', Key.action, 'CTRL+B');
      UpdateShortCuts(key.action, TextToShortCut(Key.shortcut));

      // -----------------------------------
      VSTKeys.RootNodeCount := VSTKeys.RootNodeCount + 1;
      Key := VSTKeys.GetNodeData(VSTKeys.GetLast());
      Key.action := 'tool_report';
      Key.shortcut := INI.ReadString('KEYS', Key.action, 'CTRL+R');
      UpdateShortCuts(key.action, TextToShortCut(Key.shortcut));

      // -----------------------------------
      VSTKeys.RootNodeCount := VSTKeys.RootNodeCount + 1;
      Key := VSTKeys.GetNodeData(VSTKeys.GetLast());
      Key.action := 'tool_counter';
      Key.shortcut := INI.ReadString('KEYS', Key.action, 'CTRL+U');
      UpdateShortCuts(key.action, TextToShortCut(Key.shortcut));

      // -----------------------------------
      VSTKeys.RootNodeCount := VSTKeys.RootNodeCount + 1;
      Key := VSTKeys.GetNodeData(VSTKeys.GetLast());
      Key.action := 'tool_calc';
      Key.shortcut := INI.ReadString('KEYS', Key.action, 'CTRL+K');
      UpdateShortCuts(key.action, TextToShortCut(Key.shortcut));

      // menu program
      // -----------------------------------
      VSTKeys.RootNodeCount := VSTKeys.RootNodeCount + 1;
      Key := VSTKeys.GetNodeData(VSTKeys.GetLast());
      Key.action := 'settings';
      Key.shortcut := INI.ReadString('KEYS', Key.action, 'CTRL+T');
      UpdateShortCuts(key.action, TextToShortCut(Key.shortcut));

      // -----------------------------------
      VSTKeys.RootNodeCount := VSTKeys.RootNodeCount + 1;
      Key := VSTKeys.GetNodeData(VSTKeys.GetLast());
      Key.action := 'update';
      Key.shortcut := INI.ReadString('KEYS', Key.action, 'CTRL+Z');
      // ---------------------------------------------------------------------------
      UpdateShortCuts(key.action, TextToShortCut(Key.shortcut));

      // -----------------------------------
      VSTKeys.RootNodeCount := VSTKeys.RootNodeCount + 1;
      Key := VSTKeys.GetNodeData(VSTKeys.GetLast());
      Key.action := 'about';
      Key.shortcut := INI.ReadString('KEYS', Key.action, 'CTRL+M');
      // ---------------------------------------------------------------------------
      UpdateShortCuts(key.action, TextToShortCut(Key.shortcut));

      // -----------------------------------
      VSTKeys.RootNodeCount := VSTKeys.RootNodeCount + 1;
      Key := VSTKeys.GetNodeData(VSTKeys.GetLast());
      Key.action := 'filter_clear';
      Key.shortcut := INI.ReadString('KEYS', Key.action, 'Shift+Ctrl+F1');
      // ---------------------------------------------------------------------------
      UpdateShortCuts(key.action, TextToShortCut(Key.shortcut));

      // -----------------------------------
      VSTKeys.RootNodeCount := VSTKeys.RootNodeCount + 1;
      Key := VSTKeys.GetNodeData(VSTKeys.GetLast());
      Key.action := 'filter_expand';
      Key.shortcut := INI.ReadString('KEYS', Key.action, 'Shift+Ctrl+F2');
      // ---------------------------------------------------------------------------
      UpdateShortCuts(key.action, TextToShortCut(Key.shortcut));

      // -----------------------------------
      VSTKeys.RootNodeCount := VSTKeys.RootNodeCount + 1;
      Key := VSTKeys.GetNodeData(VSTKeys.GetLast());
      Key.action := 'filter_collapse';
      Key.shortcut := INI.ReadString('KEYS', Key.action, 'Shift+Ctrl+F3');
      // ---------------------------------------------------------------------------
      UpdateShortCuts(key.action, TextToShortCut(Key.shortcut));

      INI.Free;
    except
      on E: Exception do
      begin
        ShowErrorMessage(E);
        INI.Free;
      end;
    end;
    frmSettings.Tag := 2;
  end;

  // INI file END procedure ======================================================

  try
    frmSettings.Tag := 0;
    ediShortDateFormatChange(ediShortDateFormat);
    tabVisualSettings.TabIndex := 0;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;

  try
    UpdateLanguage;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;

  try
    UpdateSettings;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;

  try
    case Application.ParamCount of
      0: // open last used file
      begin
        if (File1 <> '') and (FileExists(File1)) then
          OpenFileX(File1);
      end
      else // open EXE with attached file
        if (FileExists(Application.Params[1])) then
          OpenFileX(Application.Params[1]);
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;

  {$IFDEF WINDOWS}
  if chkNewVersion.Checked = True then
  try
    frmMain.mnuCheckUpdateClick(frmMain.mnuCheckUpdate);
  except
  end;
  {$ENDIF}
end;

procedure TfrmSettings.btnSaveClick(Sender: TObject);
var
  INI: TINIFile;
  INIFile: string;
  Key: PKey;
  P: PVirtualNode;
begin
  case MessageDlg(Application.Title, Question_04, mtConfirmation,
      [mbYes, mbNo, mbCancel], 0) of
    mrNo:
    begin
      frmSettings.ModalResult := mrCancel;
      Exit;
    end;
    mrCancel: Exit
    else
  end;
  // INI file WRITE procedure (if file does not exists) =========================
  // Create the object, specifying the the ini file that contains the settings
  INIFile := ChangeFileExt(ParamStr(0), '.ini');
  INI := TINIFile.Create(INIFile);
  try
    // writing values to the INI file.
    INI.WriteString('GLOBAL', 'Language',
      VSTLang.Text[VSTLang.GetFirstSelected(), 1] + '.po');
    VSTLang.Hint := VSTLang.Text[VSTLang.GetFirstSelected(), 1];

    // DATE FORMAT settings
    INI.WriteBool('SYSTEM_FORMAT', 'Automatic', rbtSettingsAutomatic.Checked);
    INI.WriteString('SYSTEM_FORMAT', 'ThousandSeparator',
      IfThen(rbtSettingsAutomatic.Checked = True, '',
      IntToStr(Ord(FS_own.ThousandSeparator))));
    INI.WriteString('SYSTEM_FORMAT', 'DecimalSeparator',
      IfThen(rbtSettingsAutomatic.Checked = True, '',
      IntToStr(Ord(FS_own.DecimalSeparator))));
    INI.WriteString('SYSTEM_FORMAT', 'FirstWeekDay',
      IfThen(rbtSettingsAutomatic.Checked = True, '', '1'));
    INI.WriteString('SYSTEM_FORMAT', 'DateShortFormat',
      IfThen(rbtSettingsAutomatic.Checked = True, '', FS_own.ShortDateFormat));
    INI.WriteString('SYSTEM_FORMAT', 'DateLongFormat',
      IfThen(rbtSettingsAutomatic.Checked = True, '',
      ReplaceStr(FS_own.LongDateFormat, '"', '')));

    // write ON START settings
    INI.WriteBool('ON_START', 'OpenLastFile', chkLastUsedFile.Checked);
    INI.WriteBool('ON_START', 'OpenLastFormsSize', chkLastFormsSize.Checked);
    INI.WriteBool('ON_START', 'OpenLastFilter', chkLastUsedFilter.Checked);
    INI.WriteBool('ON_START', 'TablesColumnsAutoWidth', chkAutoColumnWidth.Checked);

    if chkAutoColumnWidth.Checked = True then
    begin
      frmMain.VSTResize(frmMain.VST);
      frmMain.VSTSummaryResize(frmMain.VSTSummary);
    end;

    INI.WriteBool('ON_START', 'CheckNewVersion', chkNewVersion.Checked);

    // write PROGRAM settings
    INI.WriteBool('VISUAL_SETTINGS', 'ShadowedFont', chkShadowedFont.Checked);
    INI.WriteBool('VISUAL_SETTINGS', 'BoldFont', chkBoldFont.Checked);
    INI.WriteBool('VISUAL_SETTINGS', 'CaptionsGradient', chkGradientEffect.Checked);
    INI.WriteInteger('VISUAL_SETTINGS', 'CaptionsColor', btnCaptionColorBack.Tag);
    INI.WriteInteger('VISUAL_SETTINGS', 'CaptionsColorFont',
      btnCaptionColorFont.Tag);
    INI.WriteInteger('VISUAL_SETTINGS', 'OddRowColor', btnOddRowColorBack.Tag);
    INI.WriteInteger('VISUAL_SETTINGS', 'ColorizeCredit',
      pnlCreditTransactionsColor.Tag);
    INI.WriteInteger('VISUAL_SETTINGS', 'ColorizeDebit', pnlDebitTransactionsColor.Tag);
    INI.WriteInteger('VISUAL_SETTINGS', 'ColorizeTransferPlus',
      pnlTransferPTransactionsColor.Tag);
    INI.WriteInteger('VISUAL_SETTINGS', 'ColorizeTransferMinus',
      pnlTransferMTransactionsColor.Tag);
    INI.WriteString('VISUAL_SETTINGS', 'FontName',
      cbxGridFontName.Items[cbxGridFontName.ItemIndex]);
    INI.WriteInteger('VISUAL_SETTINGS', 'FontSize', spiGridFontSize.Value);

    // Reports
    // ---------------------------------------------------
    if cbxReportFont.ItemIndex > -1 then
      INI.WriteString('REPORTS', 'FontName',
        cbxReportFont.Items[cbxReportFont.ItemIndex])
    else
      INI.WriteString('REPORTS', 'FontName', GetFontData(frmMain.Font.Handle).Name);
    INI.WriteInteger('REPORTS', 'FontSize', spiReportSize.Value);
    INI.WriteBool('REPORTS', 'ChartLegend', chkChartShowLegend.Checked);
    INI.WriteBool('REPORTS', 'ChartZeroBalance', chkChartZeroBalance.Checked);
    INI.WriteInteger('REPORTS', 'ChartRotate', spiChartRotateLabels.Value);
    INI.WriteBool('REPORTS', 'ChartWrap', chkChartWrapLabelsText.Checked);

    // ---------------------------------------------------
    INI.WriteBool('TRANSACTIONS', 'OpenFormAuto', chkOpenNewTransaction.Checked);
    INI.WriteBool('TRANSACTIONS', 'PrintSummarySeparately',
      chkPrintSummarySeparately.Checked);
    INI.WriteBool('TRANSACTIONS', 'DisplayAmountFontBold', chkDisplayFontBold.Checked);
    INI.WriteBool('TRANSACTIONS', 'DisplaySubcategoryCapitalLetters',
      chkDisplaySubCatCapital.Checked);
    INI.WriteBool('TRANSACTIONS', 'EnableSelfTransfer', chkEnableSelfTransfer.Checked);

    // restrictions
    INI.WriteString('TRANSACTIONS', 'RestrictionsAdd',
      IfThen(rbtTransactionsAddNo.Checked = True, '',
      IfThen(rbtTransactionsAddDate.Checked = True,
      FormatDateTime('YYYY-MM-DD', datTransactionsAddDate.Date),
      IntToStr(spiTransactionsAddDays.Value))));
    INI.WriteString('TRANSACTIONS', 'RestrictionsEdit',
      IfThen(rbtTransactionsEditNo.Checked = True, '',
      IfThen(rbtTransactionsEditDate.Checked = True,
      FormatDateTime('YYYY-MM-DD', datTransactionsEditDate.Date),
      IntToStr(spiTransactionsEditDays.Value))));

    INI.WriteString('TRANSACTIONS', 'RestrictionsDelete',
      IfThen(rbtTransactionsDeleteNo.Checked = True, '',
      IfThen(rbtTransactionsDeleteDate.Checked = True,
      FormatDateTime('YYYY-MM-DD', datTransactionsDeleteDate.Date),
      IntToStr(spiTransactionsDeleteDays.Value))));

    // ---------------------------------------------------
    INI.WriteBool('SCHEDULER', 'Saturday', chkSaturday.Checked);
    INI.WriteBool('SCHEDULER', 'Sunday', chkSunday.Checked);
    INI.WriteBool('SCHEDULER', 'Holiday', chkHoliday.Checked);
    INI.WriteBool('SCHEDULER', 'Before', rbtBefore.Checked);

    INI.WriteBool('PAYMENTS', 'WriteSeparately', chkPaymentSeparately.Checked);
    INI.WriteInteger('PAYMENTS', 'ShowWeeksCount', spiPayments.Value);

    INI.WriteBool('BUDGETS', 'ShowDifference', chkShowDifference.Checked);
    INI.WriteBool('BUDGETS', 'ShowIndex', chkShowIndex.Checked);

    // ---------------------------------------------------
    INI.WriteBool('BACKUP', 'DoBackup', chkDoBackup.Checked);
    INI.WriteString('BACKUP', 'Folder', btnBackupFolder.Caption);
    INI.WriteInteger('BACKUP', 'Count', traBackupCount.Position);
    INI.WriteBool('BACKUP', 'ShowMessage', chkBackupMessage.Checked);

    // ---------------------------------------------------
    INI.WriteBool('ON_CLOSE', 'ConfirmDialog', chkCloseDbWarning.Checked);

    // write key shortcuts
    P := frmSettings.VSTKeys.GetFirst();
    while Assigned(P) do
    begin
      Key := frmSettings.VSTKeys.GetNodeData(P);
      INI.WriteString('KEYS', key.action, key.shortcut);
      UpdateShortCuts(key.action, TextToShortCut(Key.shortcut));
      P := frmSettings.VSTKeys.GetNext(P);
    end;

    // update file
    INI.UpdateFile;
    // After the ini file was used it must be freed to prevent memory leaks.
    INI.Free;

    btnSave.Tag := 1;
    frmSettings.ModalResult := mrOk;
    UpdateSettings;
  except
    On E: Exception do
    begin
      ShowErrorMessage(E);
      frmSettings.ModalResult := mrCancel;
    end;
  end;
  // INI file END procedure ======================================================

end;

procedure TfrmSettings.cbxFirstWeekDayChange(Sender: TObject);
begin
  frmMain.Calendar.StartingDayOfWeek := TDayOfWeek(cbxFirstWeekDay.ItemIndex);
end;

procedure TfrmSettings.cbxGridFontNameChange(Sender: TObject);
begin
  try
    frmAccounts.VST.Font.Name := cbxGridFontName.Items[cbxGridFontName.ItemIndex];
    frmBudget.VST.Font.Name := cbxGridFontName.Items[cbxGridFontName.ItemIndex];
    frmBudgets.VSTBudCat.Font.Name := cbxGridFontName.Items[cbxGridFontName.ItemIndex];
    frmBudgets.VSTBudgets.Font.Name := cbxGridFontName.Items[cbxGridFontName.ItemIndex];
    frmBudgets.VSTPeriods.Font.Name := cbxGridFontName.Items[cbxGridFontName.ItemIndex];
    frmCalendar.VST.Font.Name := cbxGridFontName.Items[cbxGridFontName.ItemIndex];
    frmCalendar.VSTFloat.Font.Name := cbxGridFontName.Items[cbxGridFontName.ItemIndex];
    frmCategories.VST.Font.Name := cbxGridFontName.Items[cbxGridFontName.ItemIndex];
    frmComments.VST.Font.Name := cbxGridFontName.Items[cbxGridFontName.ItemIndex];
    frmCurrencies.VST.Font.Name := cbxGridFontName.Items[cbxGridFontName.ItemIndex];
    frmDelete.VST1.Font.Name := cbxGridFontName.Items[cbxGridFontName.ItemIndex];
    frmDelete.VST2.Font.Name := cbxGridFontName.Items[cbxGridFontName.ItemIndex];
    frmDelete.VST3.Font.Name := cbxGridFontName.Items[cbxGridFontName.ItemIndex];
    frmHistory.VST1.Font.Name := cbxGridFontName.Items[cbxGridFontName.ItemIndex];
    frmHistory.VST2.Font.Name := cbxGridFontName.Items[cbxGridFontName.ItemIndex];
    frmHolidays.VST.Font.Name := cbxGridFontName.Items[cbxGridFontName.ItemIndex];
    frmLinks.VST.Font.Name := cbxGridFontName.Items[cbxGridFontName.ItemIndex];
    frmMain.VST.Font.Name := cbxGridFontName.Items[cbxGridFontName.ItemIndex];
    frmMain.VSTSummaries.Font.Name := cbxGridFontName.Items[cbxGridFontName.ItemIndex];
    frmMain.VSTSummary.Font.Name := cbxGridFontName.Items[cbxGridFontName.ItemIndex];
    frmMultiple.VST.Font.Name := cbxGridFontName.Items[cbxGridFontName.ItemIndex];
    frmPayees.VST.Font.Name := cbxGridFontName.Items[cbxGridFontName.ItemIndex];
    frmPeriod.VST.Font.Name := cbxGridFontName.Items[cbxGridFontName.ItemIndex];
    frmPersons.VST.Font.Name := cbxGridFontName.Items[cbxGridFontName.ItemIndex];
    frmRecycleBin.VST.Font.Name := cbxGridFontName.Items[cbxGridFontName.ItemIndex];
    frmSchedulers.VST.Font.Name := cbxGridFontName.Items[cbxGridFontName.ItemIndex];
    frmSchedulers.VST1.Font.Name := cbxGridFontName.Items[cbxGridFontName.ItemIndex];
    frmSettings.VSTKeys.Font.Name := cbxGridFontName.Items[cbxGridFontName.ItemIndex];
    frmSettings.VSTLang.Font.Name := cbxGridFontName.Items[cbxGridFontName.ItemIndex];
    frmSQLResult.VST.Font.Name := cbxGridFontName.Items[cbxGridFontName.ItemIndex];
    frmTags.VST.Font.Name := cbxGridFontName.Items[cbxGridFontName.ItemIndex];
    frmTemplates.VST.Font.Name := cbxGridFontName.Items[cbxGridFontName.ItemIndex];
    frmValues.VST.Font.Name := cbxGridFontName.Items[cbxGridFontName.ItemIndex];
    frmWrite.VST.Font.Name := cbxGridFontName.Items[cbxGridFontName.ItemIndex];

  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmSettings.chkChartRotateLabelsChange(Sender: TObject);
begin
  spiChartRotateLabels.Enabled := chkChartRotateLabels.Checked;
  if chkChartRotateLabels.Checked = False then
    spiChartRotateLabels.Value := 0
  else
    spiChartRotateLabels.Value := 25;
end;

procedure TfrmSettings.chkChartShowLegendChange(Sender: TObject);
begin
  frmMain.chaBalance.Legend.Visible := chkChartShowLegend.Checked;
end;

procedure TfrmSettings.chkChartZeroBalanceChange(Sender: TObject);
begin
  frmMain.tabBalanceHeaderChange(frmMain.tabBalanceHeader);
end;

procedure TfrmSettings.chkDisplayFontBoldChange(Sender: TObject);
begin
  frmMain.VST.Repaint;
end;

procedure TfrmSettings.chkDisplaySubCatCapitalChange(Sender: TObject);
begin
  UpdateCategories;
  frmMain.VST.Repaint;
  if frmMain.pnlReport.Visible = True then
    frmMain.VST.Repaint;
  if frmWrite.Visible = True then
    frmWrite.VST.Repaint;
  if frmSchedulers.Visible = True then
    frmSchedulers.VST.Repaint;
  if frmBudgets.Visible = True then
    frmBudgets.VSTBudCat.Repaint;
end;

procedure TfrmSettings.datTransactionsAddDateChange(Sender: TObject);
begin
  lblTransactionsAddDate.Caption :=
    AnsiLowerCase(FS_own.LongDayNames[DayOfTheWeek(datTransactionsAddDate.Date + 1)]);
end;

procedure TfrmSettings.datTransactionsDeleteDateChange(Sender: TObject);
begin
  lblTransactionsDeleteDate.Caption :=
    AnsiLowerCase(FS_own.LongDayNames[DayOfTheWeek(datTransactionsDeleteDate.Date + 1)]);
end;

procedure TfrmSettings.datTransactionsEditDateChange(Sender: TObject);
begin
  lblTransactionsEditDate.Caption :=
    AnsiLowerCase(FS_own.LongDayNames[DayOfTheWeek(datTransactionsEditDate.Date + 1)]);
end;

procedure TfrmSettings.gbxTransactionsRestrictionsResize(Sender: TObject);
begin
  gbxTransactionsAdd.Width := (gbxTransactionsRestrictions.Width - 12) div 3;
  gbxTransactionsEdit.Width := gbxTransactionsAdd.Width;
end;

procedure TfrmSettings.lblTransactionsAddDateClick(Sender: TObject);
begin
  datTransactionsAddDate.SetFocus;
end;

procedure TfrmSettings.lblTransactionsDeleteDateClick(Sender: TObject);
begin
  datTransactionsDeleteDate.SetFocus;
end;

procedure TfrmSettings.lblTransactionsEditDateClick(Sender: TObject);
begin
  datTransactionsEditDate.SetFocus;
end;

procedure TfrmSettings.rbtTransactionsAddDaysChange(Sender: TObject);
begin
  pnlTransactionsAddDays.Enabled := rbtTransactionsAddDays.Checked = True;
end;

procedure TfrmSettings.rbtTransactionsAddDateChange(Sender: TObject);
begin
  datTransactionsAddDate.Enabled := rbtTransactionsAddDate.Checked = True;
  lblTransactionsAddDate.Enabled := rbtTransactionsAddDate.Checked = True;
end;

procedure TfrmSettings.rbtTransactionsDeleteDaysChange(Sender: TObject);
begin
  pnlTransactionsDeleteDays.Enabled := rbtTransactionsDeleteDays.Checked = True;
end;

procedure TfrmSettings.rbtTransactionsDeleteDateChange(Sender: TObject);
begin
  datTransactionsDeleteDate.Enabled := rbtTransactionsDeleteDate.Checked = True;
  lblTransactionsDeleteDate.Enabled := rbtTransactionsDeleteDate.Checked = True;
end;

procedure TfrmSettings.rbtTransactionsEditDaysChange(Sender: TObject);
begin
  pnlTransactionsEditDays.Enabled := rbtTransactionsEditDays.Checked = True;
end;

procedure TfrmSettings.rbtTransactionsEditDateChange(Sender: TObject);
begin
  datTransactionsEditDate.Enabled := rbtTransactionsEditDate.Checked = True;
  lblTransactionsEditDate.Enabled := rbtTransactionsEditDate.Checked = True;
end;

procedure TfrmSettings.spiChartRotateLabelsChange(Sender: TObject);
begin
  frmMain.chaBalance.BottomAxis.Marks.LabelFont.Orientation :=
    10 * spiChartRotateLabels.Value;
  frmMain.chaChrono.BottomAxis.Marks.LabelFont.Orientation :=
    10 * spiChartRotateLabels.Value;
end;

procedure TfrmSettings.spiGridFontSizeChange(Sender: TObject);
begin
  try
    SetNodeHeight(frmMain.VST);
    SetNodeHeight(frmMain.VSTSummary);
    SetNodeHeight(frmMain.VSTSummaries);
    frmMain.VSTSummaryResize(frmMain.VSTSummary);
    SetNodeHeight(frmSettings.VSTKeys);
    SetNodeHeight(frmSettings.VSTLang);
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmSettings.FormKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if Key = 27 then
    frmSettings.Close;
end;

procedure TfrmSettings.FormResize(Sender: TObject);
begin
  try
    imgWidth.ImageIndex := 0;
    lblWidth.Caption := IntToStr((Sender as TForm).Width);
    imgHeight.ImageIndex := 1;
    lblHeight.Caption := IntToStr((Sender as TForm).Height);

    btnCancel.Repaint;
    btnIniFile.Repaint;
    btnSave.Repaint;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;

end;

procedure TfrmSettings.FormShow(Sender: TObject);
var
  I: byte;
  N: PVirtualNode;
  Lang: PLang;
  INI: TIniFile;
begin
  try
    {$IFDEF LINUX}
    if FileExists(ChangeFileExt(ParamStr(0), '.ini')) = True then
    begin
      INI := TINIFile.Create(ChangeFileExt(ParamStr(0), '.ini'));

      // frmSettings
      frmSettings.Position := poDesigned;
      frmSettings.Width := INI.ReadInteger('frmSettings', 'Width', frmSettings.Width);
      frmSettings.Height := INI.ReadInteger('frmSettings', 'Height', frmSettings.Height);
      frmSettings.Left := INI.ReadInteger('frmSettings', 'Left', (Screen.Width - frmSettings.Width) div 2);
      frmSettings.Top := INI.ReadInteger('frmSettings', 'Top', ((Screen.Height - frmSettings.Height) div 2) - 75);
      frmSettings.treSettings.Width :=
        INI.ReadInteger('frmSettings', 'pnlLeft', frmSettings.treSettings.Width);
      INI.Free;
    end;
    {$ENDIF}

    // global settings
    N := VSTLang.GetFirst();
    while Assigned(N) do
    begin
      Lang := VSTLang.GetNodeData(N);
      if Lang.code = VSTLang.Hint then
        VSTLang.Selected[N] := True;
      if VSTLang.NodeHeight[N] < 24 then
        VSTLang.NodeHeight[N] := 24;
      N := VSTLang.GetNext(N);
    end;

    if (pnlGlobal.Visible = True) and (tabGlobal.TabIndex = 0) then
      VSTLang.SetFocus;

    pnlFormats.Tag := IfThen(rbtSettingsAutomatic.Checked = True, 0, 1);
    ediThousandSeparator.Hint := ediThousandSeparator.Text;
    ediDecimalSeparator.Hint := ediDecimalSeparator.Text;
    cbxFirstWeekDay.Tag := cbxFirstWeekDay.ItemIndex;
    ediShortDateFormat.Hint := ediShortDateFormat.Text;
    ediLongDateFormat.Hint := ediLongDateFormat.Text;

    // visual settings
    chkShadowedFont.Tag := IfThen(chkShadowedFont.Checked = True, 1, 0);
    chkBoldFont.Tag := IfThen(chkBoldFont.Checked = True, 1, 0);
    chkGradientEffect.Tag := IfThen(chkGradientEffect.Checked = True, 1, 0);
    chkAutoColumnWidth.Tag := IfThen(chkAutoColumnWidth.Checked = True, 1, 0);
    lblPanelsColor.Tag := btnCaptionColorBack.Tag;
    pnlVisualButtons.Tag := btnCaptionColorFont.Tag;
    pnlOddRowColor.Tag := btnOddRowColorBack.Tag;
    spiGridFontSize.Tag := spiGridFontSize.Value;
    cbxGridFontName.Tag := cbxGridFontName.ItemIndex;

    // reports
    cbxReportFont.Tag := cbxReportFont.ItemIndex;
    spiReportSize.Tag := spiReportSize.Value;

    tabCreditFontColor.Tag := pnlCreditTransactionsColor.Tag;
    tabDebitFontColor.Tag := pnlDebitTransactionsColor.Tag;
    tabTransferPFontColor.Tag := pnlTransferPTransactionsColor.Tag;
    tabTransferMFontColor.Tag := pnlTransferMTransactionsColor.Tag;

    // charts
    chkChartShowLegend.Tag := IfThen(chkChartShowLegend.Checked = True, 1, 0);
    chkChartZeroBalance.Tag := IfThen(chkChartZeroBalance.Checked = True, 1, 0);
    chkChartRotateLabels.Tag := IfThen(chkChartRotateLabels.Checked = True, 1, 0);
    spiChartRotateLabels.Tag := spiChartRotateLabels.Value;
    chkChartWrapLabelsText.Tag := IfThen(chkChartWrapLabelsText.Checked = True, 1, 0);

    // transactions
    chkOpenNewTransaction.Tag := IfThen(chkOpenNewTransaction.Checked = True, 1, 0);
    chkPrintSummarySeparately.Tag :=
      IfThen(chkPrintSummarySeparately.Checked = True, 1, 0);
    chkDisplayFontBold.Tag := IfThen(chkDisplayFontBold.Checked = True, 1, 0);
    chkDisplaySubCatCapital.Tag := IfThen(chkDisplaySubCatCapital.Checked = True, 1, 0);
    chkEnableSelfTransfer.Tag := IfThen(chkEnableSelfTransfer.Checked = True, 1, 0);
    datTransactionsAddDateChange(datTransactionsAddDate);
    datTransactionsEditDateChange(datTransactionsEditDate);
    datTransactionsDeleteDateChange(datTransactionsDeleteDate);

    // restrictions
    gbxTransactionsAdd.Tag := IfThen(rbtTransactionsAddNo.Checked =
      True, 0, IfThen(rbtTransactionsAddDate.Checked = True, 1, 2));
    datTransactionsAddDate.Hint :=
      FormatDateTime('YYYY-MM-DD', datTransactionsAddDate.Date);
    spiTransactionsAddDays.Tag := spiTransactionsAddDays.Value;

    gbxTransactionsEdit.Tag :=
      IfThen(rbtTransactionsEditNo.Checked = True, 0,
      IfThen(rbtTransactionsEditDate.Checked = True, 1, 2));
    datTransactionsEditDate.Hint :=
      FormatDateTime('YYYY-MM-DD', datTransactionsEditDate.Date);
    spiTransactionsEditDays.Tag := spiTransactionsEditDays.Value;

    gbxTransactionsDelete.Tag :=
      IfThen(rbtTransactionsDeleteNo.Checked = True, 0,
      IfThen(rbtTransactionsDeleteDate.Checked = True, 1, 2));
    datTransactionsDeleteDate.Hint :=
      FormatDateTime('YYYY-MM-DD', datTransactionsDeleteDate.Date);
    spiTransactionsDeleteDays.Tag := spiTransactionsDeleteDays.Value;

    frmSettings.btnSave.Tag := 0;

    // on start
    chkLastUsedFile.Tag := IfThen(chkLastUsedFile.Checked = True, 1, 0);
    chkLastFormsSize.Tag := IfThen(chkLastUsedFile.Checked = True, 1, 0);
    chkLastUsedFilter.Tag := IfThen(chkLastUsedFilter.Checked = True, 1, 0);

    frmMain.VST.Hint := '';
    for I := 1 to frmMain.VST.Header.Columns.Count - 1 do
      frmMain.VST.Hint :=
        frmMain.VST.Hint + IntToStr(frmMain.VST.Header.Columns[I].Width) +
        IfThen(I < frmMain.VST.Header.Columns.Count - 1, separ, '');

    frmMain.VSTSummary.Hint := '';
    for I := 1 to frmMain.VSTSummary.Header.Columns.Count - 1 do
      frmMain.VSTSummary.Hint :=
        frmMain.VSTSummary.Hint + IntToStr(frmMain.VSTSummary.Header.Columns[I].Width) +
        IfThen(I < frmMain.VSTSummary.Header.Columns.Count - 1, separ, '');

    frmMain.VSTBalance.Hint := '';
    for I := 1 to frmMain.VSTBalance.Header.Columns.Count - 1 do
      frmMain.VSTBalance.Hint :=
        frmMain.VSTBalance.Hint + IntToStr(frmMain.VSTBalance.Header.Columns[I].Width) +
        IfThen(I < frmMain.VSTBalance.Header.Columns.Count - 1, separ, '');

    chkNewVersion.Tag := IfThen(chkNewVersion.Checked = True, 1, 0);

    // scheduler
    chkSaturday.Tag := IfThen(chkSaturday.Checked = True, 1, 0);
    chkSunday.Tag := IfThen(chkSunday.Checked = True, 1, 0);
    chkHoliday.Tag := IfThen(chkHoliday.Checked = True, 1, 0);
    rbtBefore.Tag := IfThen(rbtBefore.Checked = True, 1, 0);

    // payments
    chkPaymentSeparately.Tag := IfThen(chkPaymentSeparately.Checked = True, 1, 0);
    spiPayments.Tag := spiPayments.Value;

    // budgets
    chkShowDifference.Tag := IfThen(chkShowDifference.Checked = True, 1, 0);
    chkShowIndex.Tag := IfThen(chkShowIndex.Checked = True, 1, 0);


    // backup
    chkDoBackup.Tag := IfThen(chkDoBackup.Checked = True, 1, 0);
    btnBackupFolder.Hint := btnBackupFolder.Caption;
    traBackupCount.Tag := traBackupCount.Position;
    chkBackupMessage.Tag := IfThen(chkBackupMessage.Checked = True, 1, 0);

    // on close
    chkCloseDbWarning.Tag := IfThen(chkCloseDbWarning.Checked = True, 1, 0);
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmSettings.pnlButtonsResize(Sender: TObject);
begin
  btnCancel.Width := (pnlButtons.Width - 8) div 4;
  btnSave.Width := (pnlButtons.Width - 8) div 4;
end;

procedure TfrmSettings.rbtCreditColorBlackChange(Sender: TObject);
begin
  if rbtCreditColorBlack.Checked = True then
    pnlCreditTransactionsColor.Tag := 0
  else if rbtCreditColorMixed.Checked = True then
    pnlCreditTransactionsColor.Tag := 1
  else
    pnlCreditTransactionsColor.Tag := 2;

  frmMain.VST.Repaint;
  frmMain.VSTSummary.Repaint;
end;

procedure TfrmSettings.ediShortDateFormatChange(Sender: TObject);
begin
  if frmSettings.Tag = 1 then
    Exit;
  try
    // update thousandseparators in Settings
    if Length(ediThousandSeparator.Text) = 1 then
      FS_own.ThousandSeparator := ediThousandSeparator.Text[1]
    else
      FS_own.ThousandSeparator := DefaultFormatSettings.ThousandSeparator;

    // update Decimalseparators in Settings
    if Length(ediDecimalSeparator.Text) = 1 then
      FS_own.DecimalSeparator := ediDecimalSeparator.Text[1]
    else
      FS_own.DecimalSeparator := DefaultFormatSettings.DecimalSeparator;

    // update short date format
    if Length(ediShortDateFormat.Text) > 0 then
      FS_own.ShortDateFormat := ediShortDateFormat.Text
    else
      FS_own.ShortDateFormat := DefaultFormatSettings.ShortDateFormat;

    // update long date format
    if Length(ediLongDateFormat.Text) > 0 then
      FS_own.LongDateFormat := ediLongDateFormat.Text
    else
      FS_own.LongDateFormat := DefaultFormatSettings.LongDateFormat;

    // update numbers and dates example
    lblNumberExample.Caption := Format('%n', [12345678.90], FS_own);
    lblDateShort2.Caption := FormatDateTime(FS_own.ShortDateFormat, Now, FS_own);
    lblDateLong2.Caption := FormatDateTime(FS_own.LongDateFormat, Now, FS_own);

  finally
    frmMain.VST.Repaint;
    frmMain.VSTSummary.Repaint;
  end;
end;

procedure TfrmSettings.filListReportsChange(Sender: TObject);
var
  FileName: string;
begin
  Filename := filListReports.Directory + DirectorySeparator +
    filListReports.Items[filListReports.ItemIndex];
  if FileExists(Filename) = False then
  begin
    btnEditTemplate.Hint := '';
    Exit;
  end;
  btnEditTemplate.Hint := FileName;
  btnEditTemplate.Enabled := filListReports.ItemIndex > -1;
end;

procedure TfrmSettings.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  if btnSave.Tag = 0 then
    btnCancelClick(btnCancel);
end;

procedure TfrmSettings.cbxReportFontChange(Sender: TObject);
begin
  try
    if cbxReportFont.ItemIndex = -1 then
      Exit;
    lblReportFontSample.Font.Name := cbxReportFont.Items[cbxReportFont.ItemIndex];
    lblReportFontSample.Repaint;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmSettings.spiPaymentsChange(Sender: TObject);
begin
  try
    if frmWrite.Visible = True then
      UpdatePayments;
  except
  end;
end;

procedure TfrmSettings.spiReportSizeChange(Sender: TObject);
begin
  try
    lblReportFontSample.Font.Size := spiReportSize.Value;
    lblReportFontSample.Repaint;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmSettings.chkDoBackupChange(Sender: TObject);
begin
  btnBackupFolder.Enabled := chkDoBackup.Checked;
  gbxBackupCount.Visible := chkDoBackup.Checked;
  gbxBackupFolder.Visible := chkDoBackup.Checked;
  chkBackupMessage.Visible := chkDoBackup.Checked;

  if btnBackupFolder.Enabled = False then
  begin
    btnBackupFolder.Caption := '';
  end;
  pnlBackupCount.Enabled := chkDoBackup.Checked;
  chkBackupMessage.Enabled := chkDoBackup.Checked;
end;

procedure TfrmSettings.chkGradientEffectClick(Sender: TObject);
begin
  UpdateSettings;
end;

procedure TfrmSettings.chkShowDifferenceChange(Sender: TObject);
begin
  if (frmBudgets.Visible = True) and (frmBudgets.VSTBudgets.SelectedCount = 1) then
    UpdateBudCategories;
end;

procedure TfrmSettings.chkAutoColumnWidthChange(Sender: TObject);
var
  I: byte;
begin
  if frmSettings.Visible = False then Exit;

  if chkAutoColumnWidth.Checked = True then
  begin
    frmMain.VSTResize(frmMain.VST);
    frmMain.VSTSummaryResize(frmMain.VSTSummary);
    frmMain.VSTBalanceResize(frmMain.VSTBalance);
  end
  else
  begin
    // Transactions columns width
    for I := 1 to frmMain.VST.Header.Columns.Count - 1 do
      frmMain.VST.Header.Columns[I].Width :=
        StrToInt(Field(separ, frmMain.VST.Hint, I));

    // Summary columns width
    for I := 1 to frmMain.VSTSummary.Header.Columns.Count - 1 do
      frmMain.VSTSummary.Header.Columns[I].Width :=
        StrToInt(Field(separ, frmMain.VSTSummary.Hint, I));

    // Report - Balance columns width
    for I := 1 to frmMain.VSTBalance.Header.Columns.Count - 1 do
      frmMain.VSTBalance.Header.Columns[I].Width :=
        StrToInt(Field(separ, frmMain.VSTBalance.Hint, I));
  end;
end;

procedure TfrmSettings.btnIniFileClick(Sender: TObject);
begin
  try
    OpenDocument(ChangeFileExt(ParamStr(0), '.ini'));
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmSettings.btnOddRowColorBackClick(Sender: TObject);
begin
  try
    if frmSettings.Tag = 1 then
      exit;

    cd.Color := pnlOddRowColor.Color;
    if cd.Execute = False then
      Exit;
    btnOddRowColorBack.Tag := cd.Color;
    pnlOddRowColor.Color := cd.Color;
    frmMain.VST.Repaint;
    frmSchedulers.VST.Repaint;
    frmSchedulers.VST1.Repaint;
    frmWrite.VST.Repaint

  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmSettings.btnCaptionColorBackClick(Sender: TObject);
begin
  try
    if frmSettings.Tag = 0 then
    begin
      if (Sender as TBCMDButtonFocus).Align = alRight then
        cd.Color := btnCaptionColorFont.Tag
      else
        cd.Color := btnCaptionColorBack.Tag;

      if cd.Execute = False then
        Exit;

      if (Sender as TBCMDButtonFocus).Align = alRight then
        btnCaptionColorFont.Tag := cd.Color
      else
        btnCaptionColorBack.Tag := cd.Color;
    end;

    UpdateSettings;
    frmMain.VST.Repaint;
    frmMain.VSTSummary.Repaint;
    frmSchedulers.VST.Repaint;
    frmSchedulers.VST1.Repaint;
    frmWrite.VST.Repaint;

  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmSettings.btnChangeClick(Sender: TObject);
var
  Key: PKey;
begin
  frmShortCut.lblAction.Caption := VSTKeys.Text[VSTKeys.GetFirstSelected(), 1];
  frmShortCut.lblShortCutOld.Caption := VSTKeys.Text[VSTKeys.GetFirstSelected(), 2];
  frmShortCut.lblShortCut.Caption := '';

  if frmShortCut.ShowModal <> mrOk then Exit;

  Key := VSTKeys.GetNodeData(VSTKeys.GetFirstSelected());
  Key.shortcut := frmShortCut.lblShortcut.Caption;
  VSTKeys.Repaint;
end;

procedure TfrmSettings.btnDefaultClick(Sender: TObject);
var
  P: PVirtualNode;
  Key: PKey;
begin
  if MessageDlg(Application.Title, Question_24, mtConfirmation, [mbYes, mbNo], 0) <>
    mrYes then
    Exit;

  try
    P := VSTKeys.GetFirst();
    while Assigned(P) do
    begin
      Key := VSTKeys.GetNodeData(P);
      case P.Index of
        0: Key.shortcut := 'INS';
        1: Key.shortcut := 'CTRL+INS';
        2: Key.shortcut := 'SPACE';
        3: Key.shortcut := 'SHIFT+INS';
        4: Key.shortcut := 'DEL';
        5: Key.shortcut := 'CTRL+C';
        6: Key.shortcut := 'SHIFT+C';
        7: Key.shortcut := 'CTRL+A';
        8: Key.shortcut := 'CTRL+P';
        9: Key.shortcut := 'SHIFT+P';
        10: Key.shortcut := 'CTRL+H';

        // actions
        11: Key.shortcut := 'SHIFT+ENTER';
        12: Key.shortcut := 'SCROLLLOCK';

        // menu database
        13: Key.shortcut := 'CTRL+N'; // new
        14: Key.shortcut := 'CTRL+O'; // open
        15: Key.shortcut := 'CTRL+X'; // close
        16: Key.shortcut := 'CTRL+I'; // import
        17: Key.shortcut := 'CTRL+E'; // export
        18: Key.shortcut := 'CTRL+W'; // password
        19: Key.shortcut := 'CTRL+G'; // guide
        20: Key.shortcut := 'CTRL+Q'; // sql
        21: Key.shortcut := 'CTRL+L'; // recycle bin (trash)
        22: Key.shortcut := 'CTRL+J'; // properties

        // menu lists
        23: Key.shortcut := 'F4';
        24: Key.shortcut := 'F5';
        25: Key.shortcut := 'F6';
        26: Key.shortcut := 'F7';
        27: Key.shortcut := 'F8';
        28: Key.shortcut := 'F9';
        29: Key.shortcut := 'F10';
        30: Key.shortcut := 'F11';
        31: Key.shortcut := 'F12';

        // menu tools
        32: Key.shortcut := 'CTRL+S';
        33: Key.shortcut := 'CTRL+Y';
        34: Key.shortcut := 'CTRL+D';
        35: Key.shortcut := 'CTRL+B';
        36: Key.shortcut := 'CTRL+R';
        37: Key.shortcut := 'CTRL+U';
        38: Key.shortcut := 'CTRL+K';

        // menu program
        39: Key.shortcut := 'CTRL+T';
        40: Key.shortcut := 'CTRL+Z';
        41: Key.shortcut := 'CTRL+M';

        // filter
        42: Key.shortcut := 'CTRL+SHIFT+F1';
        43: Key.shortcut := 'CTRL+SHIFT+F2';
        44: Key.shortcut := 'CTRL+SHIFT+F3';

      end;
      P := VSTKeys.GetNext(P);
    end;
    VSTKeys.Repaint;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;

end;

procedure TfrmSettings.btnEditTemplateClick(Sender: TObject);
var
  FileName: string;
begin
  FileName := filListReports.Directory + DirectorySeparator +
    filListReports.Items[filListReports.ItemIndex];
  if FileExists(Filename) = False then
    Exit;

  frmMain.Report.LoadFromFile(FileName);
  frmMain.Report.DesignReport;
end;

procedure TfrmSettings.btnCancelClick(Sender: TObject);
var
  I: byte;
  N: PVirtualNode;
  Lang: PLang;
begin
  // get back all temporarely settings
  try
    // ----------------------------------------------------------------------------
    // global settings
    // ----------------------------------------------------------------------------

    if (VSTLang.Hint <> VSTLang.Text[VSTLang.GetFirstSelected(), 1]) then
    begin
      SetDefaultLang(
        LeftStr(VSTLang.Hint, 2),
        ExtractFileDir(Application.ExeName) + DirectorySeparator + 'Languages',
        VSTLang.Hint + '.po',
        True);

      N := VSTLang.GetFirst();
      while Assigned(N) do
      begin
        Lang := VSTLang.GetNodeData(N);
        if Lang.code = VSTLang.Hint then
        begin
          VSTLang.Selected[N] := True;
          Break;
        end;
        N := VSTLang.GetNext(N);
      end;
    end;

    if BoolToStr(rbtSettingsUser.Checked) <> IntToStr(rbtSettingsUser.Tag) then
      rbtSettingsUser.Checked := StrToBool(IntToStr(rbtSettingsUser.Tag));

    if ediThousandSeparator.Hint <> ediThousandSeparator.Text then
      ediThousandSeparator.Text := ediThousandSeparator.Hint;

    if ediDecimalSeparator.Hint <> ediDecimalSeparator.Text then
      ediDecimalSeparator.Text := ediDecimalSeparator.Hint;

    if cbxFirstWeekDay.Tag <> cbxFirstWeekDay.ItemIndex then
      cbxFirstWeekDay.ItemIndex := cbxFirstWeekDay.Tag;

    if ediShortDateFormat.Hint <> ediShortDateFormat.Text then
      ediShortDateFormat.Text := ediShortDateFormat.Hint;

    if ediLongDateFormat.Hint <> ediLongDateFormat.Text then
      ediLongDateFormat.Text := ediLongDateFormat.Hint;

    // ----------------------------------------------------------------------------
    // visual settings
    // ----------------------------------------------------------------------------

    // chkShadowedFont
    if BoolToStr(chkShadowedFont.Checked) <> IntToStr(chkShadowedFont.Tag) then
      chkShadowedFont.Checked := StrToBool(IntToStr(chkShadowedFont.Tag));

    // chkBoldFont
    if BoolToStr(chkBoldFont.Checked) <> IntToStr(chkBoldFont.Tag) then
      chkBoldFont.Checked := StrToBool(IntToStr(chkBoldFont.Tag));

    // chkGradientEffect
    if BoolToStr(chkGradientEffect.Checked) <> IntToStr(chkGradientEffect.Tag) then
      chkGradientEffect.Checked := StrToBool(IntToStr(chkGradientEffect.Tag));

    if lblPanelsColor.Tag <> btnCaptionColorBack.Tag then
    begin
      btnCaptionColorBack.Tag := lblPanelsColor.Tag;
    end;

    if pnlVisualButtons.Tag <> btnCaptionColorFont.Tag then
      btnCaptionColorFont.Tag := pnlVisualButtons.Tag;

    if pnlOddRowColor.Tag <> btnOddRowColorBack.Tag then
    begin
      btnOddRowColorBack.Tag := pnlOddRowColor.Tag;
      pnlOddRowColor.Color := btnOddRowColorBack.Tag;
    end;

    //// credit color
    if pnlCreditTransactionsColor.Tag <> tabCreditFontColor.Tag then
      pnlCreditTransactionsColor.Tag := tabCreditFontColor.Tag;
    case pnlCreditTransactionsColor.Tag of
      0: rbtCreditColorBlack.Checked := True;
      1: rbtCreditColorMixed.Checked := True
      else
        rbtCreditColorAll.Checked := True;
    end;

    // debit color
    if pnlDebitTransactionsColor.Tag <> tabDebitFontColor.Tag then
      pnlDebitTransactionsColor.Tag := tabDebitFontColor.Tag;
    case pnlDebitTransactionsColor.Tag of
      0: rbtDebitColorBlack.Checked := True;
      1: rbtDebitColorMixed.Checked := True
      else
        rbtDebitColorAll.Checked := True;
    end;

    // transfer plus color
    if pnlTransferPTransactionsColor.Tag <> tabTransferPFontColor.Tag then
      pnlTransferPTransactionsColor.Tag := tabTransferPFontColor.Tag;
    case pnlTransferPTransactionsColor.Tag of
      0: rbtTransfersPColorBlack.Checked := True;
      1: rbtTransfersPColorMixed.Checked := True
      else
        rbtTransfersPColorAll.Checked := True;
    end;

    // transfer minus color
    if pnlTransferMTransactionsColor.Tag <> tabTransferMFontColor.Tag then
      pnlTransferMTransactionsColor.Tag := tabTransferMFontColor.Tag;
    case pnlTransferMTransactionsColor.Tag of
      0: rbtTransfersMColorBlack.Checked := True;
      1: rbtTransfersMColorMixed.Checked := True
      else
        rbtTransfersMColorAll.Checked := True;
    end;

    // cbxGridFontName;
    if cbxGridFontName.ItemIndex <> cbxGridFontName.Tag then
      cbxGridFontName.ItemIndex := cbxGridFontName.Tag;
    cbxGridFontNameChange(cbxGridFontName);

    // spiGridFontSize;
    if spiGridFontSize.Value <> spiGridFontSize.Tag then
    begin
      spiGridFontSize.Value := spiGridFontSize.Tag;
      spiGridFontSizeChange(spiGridFontSize);
    end;

    // ----------------------------------------------------------------------------
    // on start settings
    // ----------------------------------------------------------------------------

    // chkLastUsedFile
    if BoolToStr(chkLastUsedFile.Checked) <> IntToStr(chkLastUsedFile.Tag) then
      chkLastUsedFile.Checked := StrToBool(IntToStr(chkLastUsedFile.Tag));

    // chkLastFormsSize
    if BoolToStr(chkLastFormsSize.Checked) <> IntToStr(chkLastFormsSize.Tag) then
      chkLastFormsSize.Checked := StrToBool(IntToStr(chkLastFormsSize.Tag));

    // rbtOnStartFilterOff
    if BoolToStr(chkLastUsedFilter.Checked) <> IntToStr(chkLastUsedFilter.Tag) then
      chkLastUsedFilter.Checked := StrToBool(IntToStr(chkLastUsedFilter.Tag));

    // chkAutoColumnWidth
    if BoolToStr(chkAutoColumnWidth.Checked) <> IntToStr(chkAutoColumnWidth.Tag) then
      chkAutoColumnWidth.Checked :=
        StrToBool(IntToStr(chkAutoColumnWidth.Tag));

    // tables columns width
    for I := 1 to frmMain.VST.Header.Columns.Count - 1 do
      frmMain.VST.Header.Columns[I].Width :=
        StrToInt(Field(separ, frmMain.VST.Hint, I));

    // summary columns width
    for I := 1 to frmMain.VSTSummary.Header.Columns.Count - 1 do
      frmMain.VSTSummary.Header.Columns[I].Width :=
        StrToInt(Field(separ, frmMain.VSTSummary.Hint, I));

    // report / balance columns width
    for I := 1 to frmMain.VSTBalance.Header.Columns.Count - 1 do
      frmMain.VSTBalance.Header.Columns[I].Width :=
        StrToInt(Field(separ, frmMain.VSTBalance.Hint, I));

    // chkNewVersion
    if BoolToStr(chkNewVersion.Checked) <> IntToStr(chkNewVersion.Tag) then
      chkNewVersion.Checked := StrToBool(IntToStr(chkNewVersion.Tag));

    // ----------------------------------------------------------------------------
    // transactions settings
    // ----------------------------------------------------------------------------

    // chkopenNewTransaction
    if BoolToStr(chkopenNewTransaction.Checked) <>
      IntToStr(chkopenNewTransaction.Tag) then
      chkopenNewTransaction.Checked := StrToBool(IntToStr(chkopenNewTransaction.Tag));

    // chkDisplayFontBold
    if BoolToStr(chkDisplayFontBold.Checked) <> IntToStr(chkDisplayFontBold.Tag) then
      chkDisplayFontBold.Checked := StrToBool(IntToStr(chkDisplayFontBold.Tag));

    // chkDisplaySubCatCapital
    if BoolToStr(chkDisplaySubCatCapital.Checked) <>
      IntToStr(chkDisplaySubCatCapital.Tag) then
      chkDisplaySubCatCapital.Checked :=
        StrToBool(IntToStr(chkDisplaySubCatCapital.Tag));

    // chkPrintSummarySeparately
    if BoolToStr(chkPrintSummarySeparately.Checked) <>
      IntToStr(chkPrintSummarySeparately.Tag) then
      chkPrintSummarySeparately.Checked :=
        StrToBool(IntToStr(chkPrintSummarySeparately.Tag));

    // chkEnableSelfTransfer
    if BoolToStr(chkEnableSelfTransfer.Checked) <>
      IntToStr(chkEnableSelfTransfer.Tag) then
      chkEnableSelfTransfer.Checked := StrToBool(IntToStr(chkEnableSelfTransfer.Tag));

    // restrictions
    case gbxTransactionsAdd.Tag of
      0: rbtTransactionsAddNo.Checked := True;
      1: rbtTransactionsAddDate.Checked := True
      else
        rbtTransactionsAddDays.Checked := True;
    end;
    datTransactionsAddDate.Date :=
      StrToDate(datTransactionsAddDate.Hint, 'YYYY-MM-DD', '-');
    spiTransactionsAddDays.Value := spiTransactionsAddDays.Tag;

    case gbxTransactionsEdit.Tag of
      0: rbtTransactionsEditNo.Checked := True;
      1: rbtTransactionsEditDate.Checked := True
      else
        rbtTransactionsEditDays.Checked := True;
    end;
    datTransactionsEditDate.Date :=
      StrToDate(datTransactionsEditDate.Hint, 'YYYY-MM-DD', '-');
    spiTransactionsEditDays.Value := spiTransactionsEditDays.Tag;

    case gbxTransactionsDelete.Tag of
      0: rbtTransactionsDeleteNo.Checked := True;
      1: rbtTransactionsDeleteDate.Checked := True
      else
        rbtTransactionsDeleteDays.Checked := True;
    end;
    datTransactionsDeleteDate.Date :=
      StrToDate(datTransactionsDeleteDate.Hint, 'YYYY-MM-DD', '-');
    spiTransactionsDeleteDays.Value := spiTransactionsDeleteDays.Tag;

    // ----------------------------------------------------------------------------
    // reports
    // ----------------------------------------------------------------------------
    if cbxReportFont.Tag <> cbxReportFont.ItemIndex then
      cbxReportFont.ItemIndex := cbxReportFont.Tag;
    cbxReportFontChange(cbxReportFont);

    if spiReportSize.Tag <> spiReportSize.Value then
      spiReportSize.Value := spiReportSize.Tag;
    spiReportSizeChange(spiReportSize);

    // charts
    if BoolToStr(chkChartShowLegend.Checked) <> IntToStr(chkChartShowLegend.Tag) then
      chkChartShowLegend.Checked := StrToBool(IntToStr(chkChartShowLegend.Tag));

    if BoolToStr(chkChartZeroBalance.Checked) <> IntToStr(chkChartZeroBalance.Tag) then
      chkChartZeroBalance.Checked := StrToBool(IntToStr(chkChartZeroBalance.Tag));

    if BoolToStr(chkChartRotateLabels.Checked) <> IntToStr(chkChartRotateLabels.Tag) then
      chkChartRotateLabels.Checked := StrToBool(IntToStr(chkChartRotateLabels.Tag));

    if spiChartRotateLabels.Tag <> spiChartRotateLabels.Value then
      spiChartRotateLabels.Value := spiChartRotateLabels.Tag;
    spiChartRotateLabelsChange(spiChartRotateLabels);

    if BoolToStr(chkChartWrapLabelsText.Checked) <>
      IntToStr(chkChartWrapLabelsText.Tag) then
      chkChartWrapLabelsText.Checked := StrToBool(IntToStr(chkChartWrapLabelsText.Tag));

    // scheduler
    if BoolToStr(chkSaturday.Checked) <> IntToStr(chkSaturday.Tag) then
      chkSaturday.Checked := StrToBool(IntToStr(chkSaturday.Tag));

    if BoolToStr(chkSunday.Checked) <> IntToStr(chkSunday.Tag) then
      chkSunday.Checked := StrToBool(IntToStr(chkSunday.Tag));

    if BoolToStr(chkHoliday.Checked) <> IntToStr(chkHoliday.Tag) then
      chkHoliday.Checked := StrToBool(IntToStr(chkHoliday.Tag));

    if BoolToStr(rbtBefore.Checked) <> IntToStr(rbtBefore.Tag) then
    begin
      rbtBefore.Checked := StrToBool(IntToStr(rbtBefore.Tag));
      rbtAfter.Checked := not (StrToBool(IntToStr(rbtBefore.Tag)));
    end;

    // payments
    if BoolToStr(chkPaymentSeparately.Checked) <> IntToStr(chkPaymentSeparately.Tag) then
      chkPaymentSeparately.Checked := StrToBool(IntToStr(chkPaymentSeparately.Tag));

    if spiPayments.Tag <> spiPayments.Value then
      spiPayments.Value := spiPayments.Tag;

    // budgets
    if BoolToStr(chkShowDifference.Checked) <> IntToStr(chkShowDifference.Tag) then
      chkShowDifference.Checked := StrToBool(IntToStr(chkShowDifference.Tag));

    if BoolToStr(chkShowIndex.Checked) <> IntToStr(chkShowIndex.Tag) then
      chkShowIndex.Checked := StrToBool(IntToStr(chkShowIndex.Tag));

    // backup
    if BoolToStr(chkDoBackup.Checked) <> IntToStr(chkDoBackup.Tag) then
      chkDoBackup.Checked := StrToBool(IntToStr(chkDoBackup.Tag));

    if btnBackupFolder.Hint <> btnBackupFolder.Caption then
      btnBackupFolder.Caption := btnBackupFolder.Hint;
    btnBackupFolder.Hint := '';

    if traBackupCount.Tag <> traBackupCount.Position then
      traBackupCount.Position := traBackupCount.Tag;

    if BoolToStr(chkBackupMessage.Checked) <> IntToStr(chkBackupMessage.Tag) then
      chkBackupMessage.Checked := StrToBool(IntToStr(chkBackupMessage.Tag));

    // on close
    if BoolToStr(chkCloseDbWarning.Checked) <> IntToStr(chkCloseDbWarning.Tag) then
      chkCloseDbWarning.Checked := StrToBool(IntToStr(chkCloseDbWarning.Tag));

    UpdateSettings;
    btnSave.Tag := 1;
    frmSettings.ModalResult := mrCancel;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmSettings.btnBackupFolderClick(Sender: TObject);
begin
  if sd.Execute = False then
    Exit;
  btnBackupFolder.Caption := sd.FileName;
end;

procedure TfrmSettings.rbtDebitColorBlackChange(Sender: TObject);
begin
  if rbtDebitColorBlack.Checked = True then
    pnlDebitTransactionsColor.Tag := 0
  else if rbtdebitColorMixed.Checked = True then
    pnlDebitTransactionsColor.Tag := 1
  else
    pnlDebitTransactionsColor.Tag := 2;

  frmMain.VST.Repaint;
  frmMain.VSTSummary.Repaint;
end;

procedure TfrmSettings.rbtSettingsAutomaticChange(Sender: TObject);
begin
  if rbtSettingsAutomatic.Checked = False then
    Exit;

  try
    pnlNumericFormat.Enabled := False;
    pnlDateFormat.Enabled := False;
    ediThousandSeparator.SelLength := 0;
    FS_own := DefaultFormatSettings;

    // update thousand separator
    if Ord(FS_own.ThousandSeparator) = 226 then
      FS_own.ThousandSeparator := ' ';
    ediThousandSeparator.Text := FS_own.ThousandSeparator;

    // update decimal separator
    ediDecimalSeparator.Text := FS_own.DecimalSeparator;

    // update first week day
    cbxFirstWeekDay.ItemIndex :=
      IfThen((LeftStr(GetLang, 2) = 'cs') or (LeftStr(GetLang, 2) = 'sk'), 1, 0);

    // update short date format
    ediShortDateFormat.Text := FS_own.ShortDateFormat;

    // update long date format
    ediLongDateFormat.Text := FS_own.LongDateFormat;

    // update numbers and dates example
    lblNumberExample.Caption := Format('%n', [12345678.90], FS_own);
    lblDateShort2.Caption := FormatDateTime(FS_own.ShortDateFormat, Now, FS_own);
    lblDateLong2.Caption := FormatDateTime(FS_own.LongDateFormat, Now, FS_own);
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmSettings.rbtSettingsUserChange(Sender: TObject);
begin
  if rbtSettingsUser.Checked = False then
    Exit;

  try
    pnlNumericFormat.Enabled := True;
    pnlDateFormat.Enabled := True;

    if (frmSettings.Visible = True) and (Panels.PageIndex = 0) then
    begin
      //ediThousandSeparator.SetFocus;
      ediThousandSeparator.SelectAll;
    end;
    ediShortDateFormatChange(ediShortDateFormat);
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmSettings.rbtTransfersMColorBlackChange(Sender: TObject);
begin
  try
    if rbtTransfersMColorBlack.Checked = True then
      pnlTransferMTransactionsColor.Tag := 0
    else if rbtTransfersMColorMixed.Checked = True then
      pnlTransferMTransactionsColor.Tag := 1
    else
      pnlTransferMTransactionsColor.Tag := 2;

    frmMain.VST.Repaint;
    frmMain.VSTSummary.Repaint;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmSettings.rbtTransfersPColorBlackChange(Sender: TObject);
begin
  try
    if rbtTransfersPColorBlack.Checked = True then
      pnlTransferPTransactionsColor.Tag := 0
    else if rbtTransfersPColorMixed.Checked = True then
      pnlTransferPTransactionsColor.Tag := 1
    else
      pnlTransferPTransactionsColor.Tag := 2;

    frmMain.VST.Repaint;
    frmMain.VSTSummary.Repaint;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmSettings.splSettingsCanResize(Sender: TObject;
  var NewSize: integer; var Accept: boolean);
begin
  try
    imgWidth.ImageIndex := 3;
    lblWidth.Caption := IntToStr(treSettings.Width);

    imgHeight.ImageIndex := 2;
    lblHeight.Caption := IntToStr(frmSettings.Width - treSettings.Width);
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmSettings.traBackupCountChange(Sender: TObject);
begin
  pnlBackupCount.Caption := IntToStr(traBackupCount.Position);
end;

procedure TfrmSettings.treSettingsAdvancedCustomDrawItem(Sender: TCustomTreeView;
  Node: TTreeNode; State: TCustomDrawState; Stage: TCustomDrawStage;
  var PaintImages, DefaultDraw: boolean);
var
  LFont: TFont;
begin
  LFont := Sender.Canvas.Font;
  LFont.Bold := Node.Level = 0;
end;

procedure TfrmSettings.treSettingsChange(Sender: TObject; Node: TTreeNode);
begin
  try
    case Node.AbsoluteIndex of
      0, 9: Panels.Visible := False // program
      else
      begin
        Panels.Visible := True;
        case Node.AbsoluteIndex of
          1: begin
            Panels.PageIndex := 0; // global
            if tabGlobal.TabIndex = 0 then
              VSTLang.SetFocus;
          end;
          2: Panels.PageIndex := 1; // on run
          3: Panels.PageIndex := 2; // visual
          4: begin
            Panels.PageIndex := 3; // transactions
            chkOpenNewTransaction.AutoSize := True;
            chkOpenNewTransaction.WordWrap := False;
            chkOpenNewTransaction.WordWrap := True;
            pnlTransactionsClient.Repaint;
          end;
          5: Panels.PageIndex := 4; // reports
          6: Panels.PageIndex := 5; // Charts
          7: Panels.PageIndex := 6; // tools
          8: Panels.PageIndex := 7; // shortcuts

          10: Panels.PageIndex := 8; // on open
          11: Panels.PageIndex := 9; // on close
        end;
      end;
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmSettings.VSTLangChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  S, D: string;
begin
  if VSTLang.SelectedCount <> 1 then
    Exit;

  D := ExtractFileDir(Application.ExeName) + DirectorySeparator + 'Languages';
  S := VSTLang.Text[VSTLang.GetFirstSelected(), 1];

  //  If FileExists(D + DirectorySeparator + S) then begin
  SetDefaultLang(LeftStr(S, 2), D, S, True);
  UpdateLanguage;
end;

procedure TfrmSettings.VSTLangGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: boolean; var ImageIndex: integer);
var
  Lang: PLang;
begin
  if Column > 0 then
    Exit;
  Lang := VSTLang.GetNodeData(Node);
  if Lang.code = 'en' then
    ImageIndex := 0
  else if Lang.code = 'sk' then
    ImageIndex := 1
  else if Lang.code = 'cs' then
    ImageIndex := 2
  else if Lang.code = 'br' then
    ImageIndex := 3
  else
    ImageIndex := -1;
end;

procedure TfrmSettings.VSTLangGetNodeDataSize(Sender: TBaseVirtualTree;
  var NodeDataSize: integer);
begin
  NodeDataSize := SizeOf(TLang);
end;

procedure TfrmSettings.VSTKeysBeforeCellPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
begin
  TargetCanvas.Brush.Color := IfThen(Node.Index mod 2 = 0, clWhite,
    frmSettings.pnlOddRowColor.Color);
  TargetCanvas.FillRect(CellRect);
end;

procedure TfrmSettings.VSTKeysChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
begin
  btnChange.Enabled := VSTKeys.SelectedCount = 1;
end;

procedure TfrmSettings.VSTKeysDblClick(Sender: TObject);
begin
  if VSTKeys.SelectedCount = 1 then
    btnChangeClick(btnChange);
end;

procedure TfrmSettings.VSTKeysGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: boolean; var ImageIndex: integer);
begin
  if Column = 0 then
    ImageIndex := 5;
end;

procedure TfrmSettings.VSTKeysGetNodeDataSize(Sender: TBaseVirtualTree;
  var NodeDataSize: integer);
begin
  NodeDataSize := SizeOf(TKey);
end;

procedure TfrmSettings.VSTKeysGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  Key: PKey;
begin
  if Column = 0 then
    Exit;

  Key := VSTKeys.GetNodeData(Node);
  case Column of
    1: CellText := Key.Caption;
    2: CellText := Key.shortcut;
  end;
end;

procedure TfrmSettings.VSTKeysResize(Sender: TObject);
var
  X: integer;
begin
  (Sender as TLazVirtualStringTree).Header.Columns[0].Width :=
    Round(ScreenRatio / 100 * 25);
  if frmSettings.chkAutoColumnWidth.Checked = False then Exit;

  X := (VSTKeys.Width - VSTKeys.Header.Columns[0].Width) div 100;

  VSTKeys.Header.Columns[1].Width :=
    VSTKeys.Width - ScrollBarWidth - VSTKeys.Header.Columns[0].Width - (40 * X);
  VSTKeys.Header.Columns[2].Width := 40 * X;
end;

procedure TfrmSettings.VSTLangGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  Lang: PLang;
begin
  Lang := VSTLang.GetNodeData(Node);
  case Column of
    1: CellText := Lang.code;
    2: CellText := Lang.Name;
    3: CellText := Lang.translator;
    4: CellText := Lang.email;
  end;
end;

procedure TfrmSettings.VSTLangResize(Sender: TObject);
var
  X: integer;
begin
  VSTLang.Header.Columns[0].Width := round(ScreenRatio / 100 * 32);
  X := (VSTLang.Width - VSTLang.Header.Columns[0].Width) div 100;
  VSTLang.Header.Columns[1].Width := 12 * X; // code
  VSTLang.Header.Columns[2].Width := 25 * X; // language
  VSTLang.Header.Columns[3].Width := 30 * X; // author
  VSTLang.Header.Columns[4].Width :=
    VSTLang.Width - VSTLang.Header.Columns[0].Width - ScrollBarWidth - (67 * X);
  // comment
end;

procedure UpdateSettings;
begin
  try
    screen.Cursor := crHourGlass;
    FullColor := frmSettings.btnCaptionColorBack.Tag;
    BrightenColor := Brighten(FullColor, 234);

    // ======================================================================================
    // date format in all forms
    // ======================================================================================
    //frmDetail.datDateFrom.Format := frmSettings.ediLongDateFormat.Text;
    //frmDetail.datDateTo.DateFormat := frmSettings.ediLongDateFormat.Text;
    //frmMain.datFrom.DateFormat := frmSettings.ediLongDateFormat.Text;
    //frmMain.datTo.DateFormat := frmSettings.ediLongDateFormat.Text;
    //frmAccounts.datDate.DateFormat := frmSettings.ediLongDateFormat.Text;
    //frmScheduler.datDateFrom.DateFormat := frmSettings.ediLongDateFormat.Text;
    //frmScheduler.datDateTo.DateFormat := frmSettings.ediLongDateFormat.Text;
    //frmEdit.datDate.DateFormat := frmSettings.ediLongDateFormat.Text;
    //frmMultiple.datDate.DateFormat := frmSettings.ediLongDateFormat.Text;

    // Forms color
    {$IFDEF WINDOWS}
    frmMultiple.Color := $00DEDEDE; // gray
    frmDetail.Color := frmMultiple.Color;
    frmEdit.Color := frmMultiple.Color;
    frmEdits.Color := frmMultiple.Color;
    frmScheduler.Color := frmMultiple.Color;
    frmMain.pnlFilter.Color := frmMultiple.Color;
    frmSQL.Color := frmMultiple.Color;
    frmPlan.Color := frmMultiple.Color;
    {$ENDIF}

    // ===============================================================================
    // frmSettings
    // ===============================================================================

    // panels
    //  SetPanelProperty(frmSettings.pnlVisualCaption);
    //  SetPanelProperty(frmSettings.pnlGlobalCaption);
    //  SetPanelProperty(frmSettings.pnlReportsCaption);
    //  SetPanelProperty(frmSettings.pnlOnStartCaption);
    //  SetPanelProperty(frmSettings.pnlShortsCutCaption);
    //  SetPanelProperty(frmSettings.pnlToolsCaption);
    //  SetPanelProperty(frmSettings.pnlCloseDbCaption);

    // buttons
    SetBtnProperty(frmSettings.btnIniFile);
    SetBtnProperty(frmSettings.btnSave);
    SetBtnProperty(frmSettings.btnCancel);
    SetBtnProperty(frmSettings.btnCaptionColorBack);
    SetBtnProperty(frmSettings.btnCaptionColorFont);
    SetBtnProperty(frmSettings.btnOddRowColorBack);
    SetBtnProperty(frmSettings.btnChange);
    SetBtnProperty(frmSettings.btnDefault);
    SetBtnProperty(frmSettings.btnEditTemplate);

    // ===============================================================================
    // frmMain
    // ===============================================================================

    // panels
    SetPanelProperty(frmMain.pnlFilterCaption);
    SetPanelProperty(frmMain.pnlListCaption);
    SetPanelProperty(frmMain.pnlSummaryCaption);
    SetPanelProperty(frmMain.pnlReportCaption);

    // buttons
    SetBtnProperty(frmMain.btnAdd);
    SetBtnProperty(frmMain.btnAddMulti);
    SetBtnProperty(frmMain.btnDuplicate);
    SetBtnProperty(frmMain.btnEdit);
    SetBtnProperty(frmMain.btnCopy);
    SetBtnProperty(frmMain.btnDelete);
    SetBtnProperty(frmMain.btnPrint);
    SetBtnProperty(frmMain.btnSelect);
    SetBtnProperty(frmMain.btnHistory);
    SetBtnProperty(frmMain.btnReportExit);
    SetBtnProperty(frmMain.btnReportCopy);
    SetBtnProperty(frmMain.btnReportPrint);
    SetBtnProperty(frmMain.btnReportSettings);

    // chart
    frmMain.chaPie.BackColor := BrightenColor;
    //frmMain.chaBalance.BackColor := RGBToColor(222,222,222);

    // ===============================================================================
    // frmDetail
    // ===============================================================================
    // buttons
    SetBtnProperty(frmDetail.btnCancel);
    SetBtnProperty(frmDetail.btnSave);
    SetBtnProperty(frmDetail.btnSettings);

    // ===============================================================================
    // frmEdit
    // ===============================================================================
    SetBtnProperty(frmEdit.btnSave);
    SetBtnProperty(frmEdit.btnCancel);

    // ===============================================================================
    // frmEdits
    // ===============================================================================
    SetPanelProperty(frmEdits.pnlEditCaption);
    SetBtnProperty(frmEdits.btnReset);
    SetBtnProperty(frmEdits.btnSave);
    SetBtnProperty(frmEdits.btnCancel);

    // ===============================================================================
    // frmMultiple buttons
    // ===============================================================================
    // panels
    SetPanelProperty(frmMultiple.pnlBasicCaption);
    SetPanelProperty(frmMultiple.pnlListCaption);
    SetPanelProperty(frmMultiple.pnlDetailCaption);

    // buttons
    SetBtnProperty(frmMultiple.btnSave);
    SetBtnProperty(frmMultiple.btnCancel);
    SetBtnProperty(frmMultiple.btnAdd);
    SetBtnProperty(frmMultiple.btnEdit);
    SetBtnProperty(frmMultiple.btnDelete);
    SetBtnProperty(frmMultiple.btnSelect);
    SetBtnProperty(frmMultiple.btnDuplicate);
    SetBtnProperty(frmMultiple.btnExit);
    SetBtnProperty(frmMultiple.btnWrite);

    // ===============================================================================
    // frmCounter buttons
    // ===============================================================================
    // panels
    SetPanelProperty(frmCounter.pnlCurrencyCaption);

    // buttons
    SetBtnProperty(frmCounter.btnReset);
    SetBtnProperty(frmCounter.btnPrint);
    SetBtnProperty(frmCounter.btnCopy);
    SetBtnProperty(frmCounter.btnExit);

    // ===============================================================================
    // frmAccounts buttons
    // ===============================================================================
    // panels
    SetPanelProperty(frmAccounts.pnlListCaption);
    SetPanelProperty(frmAccounts.pnlDetailCaption);

    // buttons
    SetBtnProperty(frmAccounts.btnAdd);
    SetBtnProperty(frmAccounts.btnEdit);
    SetBtnProperty(frmAccounts.btnDelete);
    SetBtnProperty(frmAccounts.btnCopy);
    SetBtnProperty(frmAccounts.btnPrint);
    SetBtnProperty(frmAccounts.btnSave);
    SetBtnProperty(frmAccounts.btnCancel);
    SetBtnProperty(frmAccounts.btnExit);
    SetBtnProperty(frmAccounts.btnSelect);

    // ===============================================================================
    // frmCurrencies buttons
    // ===============================================================================
    // panels
    SetPanelProperty(frmCurrencies.pnlListCaption);
    SetPanelProperty(frmCurrencies.pnlDetailCaption);

    // buttons
    SetBtnProperty(frmCurrencies.btnAdd);
    SetBtnProperty(frmCurrencies.btnEdit);
    SetBtnProperty(frmCurrencies.btnDelete);
    SetBtnProperty(frmCurrencies.btnCopy);
    SetBtnProperty(frmCurrencies.btnPrint);
    SetBtnProperty(frmCurrencies.btnSave);
    SetBtnProperty(frmCurrencies.btnCancel);
    SetBtnProperty(frmCurrencies.btnExit);
    SetBtnProperty(frmCurrencies.btnSelect);
    SetBtnProperty(frmCurrencies.btnValues);

    frmCurrencies.btnValues.StyleNormal.Color := FullColor;
    frmCurrencies.btnValues.StyleNormal.TextColor := frmSettings.btnCaptionColorFont.Tag;
    frmCurrencies.btnValues.StyleHover.Color := frmSettings.btnCaptionColorFont.Tag;
    frmCurrencies.btnValues.StyleHover.TextColor := FullColor;

    // ===============================================================================
    // frmValues buttons
    // ===============================================================================
    // panels
    SetPanelProperty(frmValues.pnlDetailCaption);
    SetPanelProperty(frmValues.pnlListCaption);

    // buttons
    SetBtnProperty(frmValues.btnAdd);
    SetBtnProperty(frmValues.btnEdit);
    SetBtnProperty(frmValues.btnDelete);
    SetBtnProperty(frmValues.btnSelect);
    SetBtnProperty(frmValues.btnCopy);
    SetBtnProperty(frmValues.btnSave);
    SetBtnProperty(frmValues.btnCancel);
    SetBtnProperty(frmValues.btnExit);

    // ===============================================================================
    // frmComments buttons
    // ===============================================================================
    // panels
    SetPanelProperty(frmComments.pnlListCaption);
    SetPanelProperty(frmComments.pnlDetailCaption);

    // buttons
    SetBtnProperty(frmComments.btnAdd);
    SetBtnProperty(frmComments.btnEdit);
    SetBtnProperty(frmComments.btnDelete);
    SetBtnProperty(frmComments.btnCopy);
    SetBtnProperty(frmComments.btnPrint);
    SetBtnProperty(frmComments.btnSave);
    SetBtnProperty(frmComments.btnCancel);
    SetBtnProperty(frmComments.btnExit);
    SetBtnProperty(frmComments.btnSelect);

    // ===============================================================================
    // frmHolidays buttons
    // ===============================================================================
    // panels
    SetPanelProperty(frmHolidays.pnlListCaption);
    SetPanelProperty(frmHolidays.pnlDetailCaption);

    // buttons
    SetBtnProperty(frmHolidays.btnAdd);
    SetBtnProperty(frmHolidays.btnEdit);
    SetBtnProperty(frmHolidays.btnDelete);
    SetBtnProperty(frmHolidays.btnCopy);
    SetBtnProperty(frmHolidays.btnPrint);
    SetBtnProperty(frmHolidays.btnSave);
    SetBtnProperty(frmHolidays.btnCancel);
    SetBtnProperty(frmHolidays.btnExit);
    SetBtnProperty(frmHolidays.btnSelect);

    // ===============================================================================
    // frmPersons buttons
    // ===============================================================================
    // panels
    SetPanelProperty(frmPersons.pnlListCaption);
    SetPanelProperty(frmPersons.pnlDetailCaption);

    // buttons
    SetBtnProperty(frmPersons.btnAdd);
    SetBtnProperty(frmPersons.btnEdit);
    SetBtnProperty(frmPersons.btnDelete);
    SetBtnProperty(frmPersons.btnCopy);
    SetBtnProperty(frmPersons.btnPrint);
    SetBtnProperty(frmPersons.btnSave);
    SetBtnProperty(frmPersons.btnCancel);
    SetBtnProperty(frmPersons.btnExit);
    SetBtnProperty(frmPersons.btnSelect);

    // ===============================================================================
    // frmPayees buttons
    // ===============================================================================
    // panels
    SetPanelProperty(frmPayees.pnlListCaption);
    SetPanelProperty(frmPayees.pnlDetailCaption);

    // buttons
    SetBtnProperty(frmPayees.btnAdd);
    SetBtnProperty(frmPayees.btnEdit);
    SetBtnProperty(frmPayees.btnDelete);
    SetBtnProperty(frmPayees.btnCopy);
    SetBtnProperty(frmPayees.btnPrint);
    SetBtnProperty(frmPayees.btnSave);
    SetBtnProperty(frmPayees.btnCancel);
    SetBtnProperty(frmPayees.btnExit);
    SetBtnProperty(frmPayees.btnSelect);

    // ===============================================================================
    // frmCategories buttons
    // ===============================================================================
    // panels
    SetPanelProperty(frmCategories.pnlListCaption);
    SetPanelProperty(frmCategories.pnlDetailCaption);

    // buttons
    SetBtnProperty(frmCategories.btnAdd);
    SetBtnProperty(frmCategories.btnEdit);
    SetBtnProperty(frmCategories.btnDelete);
    SetBtnProperty(frmCategories.btnCopy);
    SetBtnProperty(frmCategories.btnPrint);
    SetBtnProperty(frmCategories.btnSave);
    SetBtnProperty(frmCategories.btnCancel);
    SetBtnProperty(frmCategories.btnExit);
    SetBtnProperty(frmCategories.btnSelect);

    // ===============================================================================
    // frmTags buttons
    // ===============================================================================
    // panels
    SetPanelProperty(frmTags.pnlListCaption);
    SetPanelProperty(frmTags.pnlDetailCaption);

    // buttons
    SetBtnProperty(frmTags.btnAdd);
    SetBtnProperty(frmTags.btnEdit);
    SetBtnProperty(frmTags.btnDelete);
    SetBtnProperty(frmTags.btnCopy);
    SetBtnProperty(frmTags.btnPrint);
    SetBtnProperty(frmTags.btnSave);
    SetBtnProperty(frmTags.btnCancel);
    SetBtnProperty(frmTags.btnExit);
    SetBtnProperty(frmTags.btnSelect);

    // ===============================================================================
    // frmGuide buttons
    // ===============================================================================
    // panels
    SetPanelProperty(frmGuide.pnlGuideCaption);

    // buttons
    SetBtnProperty(frmGuide.btnBack);
    SetBtnProperty(frmGuide.btnNext);

    // ===============================================================================
    // frmPassword buttons
    // ===============================================================================
    // panels
    SetPanelProperty(frmPassword.pnlPasswordCaption);

    // buttons
    SetBtnProperty(frmPassword.btnSave);
    SetBtnProperty(frmPassword.btnExit);
    SetBtnProperty(frmPassword.btn0);
    SetBtnProperty(frmPassword.btn1);
    SetBtnProperty(frmPassword.btn2);
    SetBtnProperty(frmPassword.btn3);
    SetBtnProperty(frmPassword.btn4);
    SetBtnProperty(frmPassword.btn5);
    SetBtnProperty(frmPassword.btn6);
    SetBtnProperty(frmPassword.btn7);
    SetBtnProperty(frmPassword.btn8);
    SetBtnProperty(frmPassword.btn9);
    SetBtnProperty(frmPassword.btnBack);


    // ===============================================================================
    // frmSuccess buttons
    // ===============================================================================
    // panels
    SetPanelProperty(frmSuccess.pnlSuccessCaption);

    // buttons
    SetBtnProperty(frmSuccess.btnPassword);
    SetBtnProperty(frmSuccess.btnGuide);
    SetBtnProperty(frmSuccess.btnImport);
    SetBtnProperty(frmSuccess.btnCancel);

    // ===============================================================================
    // frmGate buttons
    // ===============================================================================
    // panels
    SetPanelProperty(frmGate.pnlCaption);

    // buttons
    SetBtnProperty(frmGate.btnOK);
    SetBtnProperty(frmGate.btn0);
    SetBtnProperty(frmGate.btn1);
    SetBtnProperty(frmGate.btn2);
    SetBtnProperty(frmGate.btn3);
    SetBtnProperty(frmGate.btn4);
    SetBtnProperty(frmGate.btn5);
    SetBtnProperty(frmGate.btn6);
    SetBtnProperty(frmGate.btn7);
    SetBtnProperty(frmGate.btn8);
    SetBtnProperty(frmGate.btn9);
    SetBtnProperty(frmGate.btnBack);

    // ===============================================================================
    // frmSQL buttons
    // ===============================================================================
    // panels
    SetPanelProperty(frmSQL.pnlCaption);

    // buttons
    SetBtnProperty(frmSQL.btnExit);
    SetBtnProperty(frmSQL.btnExecute);

    // ===============================================================================
    // frmSQLResult buttons
    // ===============================================================================
    // panels
    SetPanelProperty(frmSQLResult.pnlCaption);

    // buttons
    SetBtnProperty(frmSQLResult.btnCopy);
    SetBtnProperty(frmSQLResult.btnSelect);
    SetBtnProperty(frmSQLResult.btnExit);

    // ===============================================================================
    // frmProperties buttons
    // ===============================================================================
    // panels
    SetPanelProperty(frmProperties.pnlCaption);
    SetPanelProperty(frmProperties.pnlCaption1);

    // buttons
    SetBtnProperty(frmProperties.btnExit);
    SetBtnProperty(frmProperties.btnAccounts);
    SetBtnProperty(frmProperties.btnCategories);
    SetBtnProperty(frmProperties.btnComments);
    SetBtnProperty(frmProperties.btnCurrencies);
    SetBtnProperty(frmProperties.btnData);
    SetBtnProperty(frmProperties.btnHolidays);
    SetBtnProperty(frmProperties.btnPayees);
    SetBtnProperty(frmProperties.btnPersons);
    SetBtnProperty(frmProperties.btnPayments);
    SetBtnProperty(frmProperties.btnRecycle);
    SetBtnProperty(frmProperties.btnScheduler);
    SetBtnProperty(frmProperties.btnTags);
    SetBtnProperty(frmProperties.btnBudget);
    SetBtnProperty(frmProperties.btnLinks);

    // ===============================================================================
    // frmRecycleBin buttons
    // ===============================================================================
    // panels
    SetPanelProperty(frmRecycleBin.pnlListCaption);
    // buttons
    SetBtnProperty(frmRecycleBin.btnExit);
    SetBtnProperty(frmRecycleBin.btnEdit);
    SetBtnProperty(frmRecycleBin.btnDelete);
    SetBtnProperty(frmRecycleBin.btnRestore);
    SetBtnProperty(frmRecycleBin.btnSelect);

    // ===============================================================================
    // frmAbout buttons
    // ===============================================================================
    // buttons
    SetBtnProperty(frmAbout.btnExit);

    // ===============================================================================
    // frmFilter buttons
    // ===============================================================================
    // panels
    SetPanelProperty(frmFilter.pnlFilterCaption);
    // buttons
    SetBtnProperty(frmFilter.btnApplyFilter);

    // ===============================================================================
    // frmImport buttons
    // ===============================================================================
    // panels
    SetPanelProperty(frmImport.pnlImportCaption);

    // buttons
    SetBtnProperty(frmImport.btnImport);
    SetBtnProperty(frmImport.btnExit);

    // ===============================================================================
    // frmDelete buttons
    // ===============================================================================
    // panels
    //SetPanelProperty(frmDelete.pnlListCaption);

    // buttons
    SetBtnProperty(frmDelete.btnCancel);
    SetBtnProperty(frmDelete.btnDelete);

    // ===============================================================================
    // frmHistory buttons
    // ===============================================================================
    // panels
    SetPanelProperty(frmHistory.pnlOriginalCaption);
    SetPanelProperty(frmHistory.pnlHistoryCaption);
    // buttons
    SetBtnProperty(frmHistory.btnCancel);

    // ===============================================================================
    // frmScheduler buttons
    // ===============================================================================
    // panels
    SetPanelProperty(frmScheduler.pnlDetailCaption);

    // buttons
    SetBtnProperty(frmScheduler.btnSave);
    SetBtnProperty(frmScheduler.btnCancel);
    SetBtnProperty(frmScheduler.btnSettings);

    // ===============================================================================
    // frmSchedulers buttons
    // ===============================================================================

    // panels
    SetPanelProperty(frmSchedulers.pnlListCaption);
    SetPanelProperty(frmSchedulers.pnlPaymentsCaption);

    // buttons
    SetBtnProperty(frmSchedulers.btnAdd);
    SetBtnProperty(frmSchedulers.btnDelete);
    SetBtnProperty(frmSchedulers.btnCalendar);
    SetBtnProperty(frmSchedulers.btnExit);

    SetBtnProperty(frmSchedulers.btnAdd1);
    SetBtnProperty(frmSchedulers.btnEdit1);
    SetBtnProperty(frmSchedulers.btnDelete1);

    // ===============================================================================
    // frmWrite
    // ===============================================================================
    // panels
    SetPanelProperty(frmWrite.pnlListCaption);

    // buttons
    SetBtnProperty(frmWrite.btnEdit);
    SetBtnProperty(frmWrite.btnDelete);
    SetBtnProperty(frmWrite.btnCalendar);
    SetBtnProperty(frmWrite.btnSettings);
    SetBtnProperty(frmWrite.btnExit);
    SetBtnProperty(frmWrite.btnSave);

    // ===============================================================================
    // frmWriting
    // ===============================================================================
    // panels

    // buttons
    SetBtnProperty(frmWriting.btnCancel);
    SetBtnProperty(frmWriting.btnWrite);

    // ===============================================================================
    // frmShortCut
    // ===============================================================================
    // buttons
    //  SetBtnProperty(frmShortCut.btnCancel);
    //  SetBtnProperty(frmShortCut.btnSave);

    // ===============================================================================
    // frmManyCurrencies
    // ===============================================================================
    // panels
    SetPanelProperty(frmManyCurrencies.pnlManyCurrenciesCaption);
    // buttons
    SetBtnProperty(frmManyCurrencies.btnCancel);
    SetBtnProperty(frmManyCurrencies.btnSave);

    // ===============================================================================
    // frmCalendar
    // ===============================================================================

    // panels
    SetPanelProperty(frmCalendar.pnlCalendarCaption);
    SetPanelProperty(frmCalendar.pnlFilterCaption);
    SetPanelProperty(frmCalendar.pnlSummaryCaption);

    // buttons
    SetBtnProperty(frmCalendar.btnEdit);
    SetBtnProperty(frmCalendar.btnDelete);
    SetBtnProperty(frmCalendar.btnExit);

    // ===============================================================================
    // frmBudgets
    // ===============================================================================

    // panels
    SetPanelProperty(frmBudgets.pnlCategoriesCaption);
    SetPanelProperty(frmBudgets.pnlBudgetCaption);

    // Budget buttons
    SetBtnProperty(frmBudgets.btnBudgetAdd);
    SetBtnProperty(frmBudgets.btnBudgetEdit);
    SetBtnProperty(frmBudgets.btnBudgetDelete);
    SetBtnProperty(frmBudgets.btnBudgetDuplicate);

    SetBtnProperty(frmBudgets.btnSettings);
    SetBtnProperty(frmBudgets.btnExit);
    SetBtnProperty(frmBudgets.btnCopy);

    // Period buttons
    SetBtnProperty(frmBudgets.btnPeriodAdd);
    SetBtnProperty(frmBudgets.btnPeriodEdit);
    SetBtnProperty(frmBudgets.btnPeriodDelete);
    SetBtnProperty(frmBudgets.btnPeriodDuplicate);

    // ===============================================================================
    // frmBudget
    // ===============================================================================

    // panels
    SetPanelProperty(frmBudget.pnlTypeCaption);
    SetPanelProperty(frmBudget.pnlNameCaption);
    SetPanelProperty(frmBudget.pnlCategoriesCaption);

    // buttons
    SetBtnProperty(frmBudget.btnCancel);
    SetBtnProperty(frmBudget.btnSave);
    SetBtnProperty(frmBudget.btnCategories);

    // ===============================================================================
    // frmPeriod
    // ===============================================================================

    // panels
    SetPanelProperty(frmPeriod.pnlPeriodCaption);
    SetPanelProperty(frmPeriod.pnlBudgetCaption);

    // buttons
    SetBtnProperty(frmPeriod.btnCancel);
    SetBtnProperty(frmPeriod.btnSave);
    SetBtnProperty(frmPeriod.btnEdit);

    // ===============================================================================
    // frmPlan
    // ===============================================================================

    // panels
    SetPanelProperty(frmPlan.pnlPlanCaption1);
    //SetPanelProperty(frmPlan.pnlPlanCaption2);

    // buttons
    SetBtnProperty(frmPlan.btnCancel);
    SetBtnProperty(frmPlan.btnSave);

    // ===============================================================================
    // frmTemplates
    // ===============================================================================
    // panels
    SetPanelProperty(frmTemplates.pnlTopCaption);
    SetPanelProperty(frmTemplates.pnlBottomCaption);
    SetPanelProperty(frmTemplates.pnlSettingsCaption);

    // buttons
    SetBtnProperty(frmTemplates.btnCancel);
    SetBtnProperty(frmTemplates.btnSave);
    SetBtnProperty(frmTemplates.btnImport);
    SetBtnProperty(frmTemplates.btnExit);
    SetBtnProperty(frmTemplates.btnAdd);
    SetBtnProperty(frmTemplates.btnEdit);
    SetBtnProperty(frmTemplates.btnDelete);

    // ===============================================================================
    // frmLinks buttons
    // ===============================================================================
    // panels
    SetPanelProperty(frmLinks.pnlListCaption);
    SetPanelProperty(frmLinks.pnlDetailCaption);

    // buttons
    SetBtnProperty(frmLinks.btnAdd);
    SetBtnProperty(frmLinks.btnEdit);
    SetBtnProperty(frmLinks.btnDelete);
    SetBtnProperty(frmLinks.btnCopy);
    SetBtnProperty(frmLinks.btnPrint);
    SetBtnProperty(frmLinks.btnSave);
    SetBtnProperty(frmLinks.btnCancel);
    SetBtnProperty(frmLinks.btnExit);
    SetBtnProperty(frmLinks.btnSelect);

    screen.Cursor := crDefault;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure SetPanelProperty(Sender: TObject);
begin
  try
    if (frmSettings.chkGradientEffect.Checked = True) then
    begin
      (Sender as TBCPanel).Background.Style := bbsGradient;
      (Sender as TBCPanel).Background.Gradient1.StartColor := FullColor;
    end
    else
    begin
      (Sender as TBCPanel).Background.Style := bbsColor;
      (Sender as TBCPanel).Background.Color := FullColor;
    end;

    (Sender as TBCPanel).FontEx.Color := frmSettings.btnCaptionColorFont.Tag;
    (Sender as TBCPanel).FontEx.Shadow := frmSettings.chkShadowedFont.Checked;

    if frmSettings.chkBoldFont.Checked = True then
      (Sender as TBCPanel).FontEx.Style := [fsBold]
    else
      (Sender as TBCPanel).FontEx.Style := [];
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure SetBtnProperty(Sender: TBCMDButtonFocus);
begin
  try
    Sender.StyleHover.Color := FullColor;
    Sender.StyleHover.TextColor := frmSettings.btnCaptionColorFont.Tag;
    Sender.Font.Bold := frmSettings.chkBoldFont.Checked;

    Sender.StyleNormal.Color := Brighten(FullColor, 200);
    Sender.StyleNormal.TextColor := clBlack;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure UpdateShortCuts(Action: string; S: TShortCut);
begin
  try
    // ------------------------------------------------------------------------
    if Action = 'record_add' then
    begin
      frmMain.actAdd.ShortCut := S;
      frmMain.popAdd.ShortCut := S;
      frmMain.btnAdd.Hint := Hint_01 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmHolidays.actAdd.ShortCut := S;
      frmHolidays.popAdd.ShortCut := S;
      frmHolidays.btnAdd.Hint := Hint_01 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmComments.actAdd.ShortCut := S;
      frmComments.popAdd.ShortCut := S;
      frmComments.btnAdd.Hint := Hint_01 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmTags.actAdd.ShortCut := S;
      frmTags.popAdd.ShortCut := S;
      frmTags.btnAdd.Hint := Hint_01 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmCurrencies.actAdd.ShortCut := S;
      frmCurrencies.popAdd.ShortCut := S;
      frmCurrencies.btnAdd.Hint := Hint_01 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmPayees.actAdd.ShortCut := S;
      frmPayees.popAdd.ShortCut := S;
      frmPayees.btnAdd.Hint := Hint_01 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmAccounts.actAdd.ShortCut := S;
      frmAccounts.popAdd.ShortCut := S;
      frmAccounts.btnAdd.Hint := Hint_01 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmCategories.actAdd.ShortCut := S;
      frmCategories.popAdd.ShortCut := S;
      frmCategories.btnAdd.Hint := Hint_01 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmPersons.actAdd.ShortCut := S;
      frmPersons.popAdd.ShortCut := S;
      frmPersons.btnAdd.Hint := Hint_01 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmSchedulers.actAdd.ShortCut := S;
      frmSchedulers.popAdd.ShortCut := S;
      frmSchedulers.popAdd1.ShortCut := S;
      frmSchedulers.btnAdd.Hint := Hint_01 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmSchedulers.btnAdd1.Hint := Hint_01 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmBudgets.actBudgetAdd.ShortCut := S;
      frmBudgets.popBudgetAdd.ShortCut := S;
      frmBudgets.btnBudgetAdd.Hint :=
        Hint_01 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmMultiple.actAdd.ShortCut := S;
      frmMultiple.popAdd.ShortCut := S;
      frmMultiple.btnAdd.Hint := Hint_01 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmTemplates.actAdd.ShortCut := S;
      frmTemplates.btnAdd.Hint := Hint_01 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmLinks.actAdd.ShortCut := S;
      frmLinks.popAdd.ShortCut := S;
      frmLinks.btnAdd.Hint := Hint_01 + sLineBreak + '[' + ShortCutToText(S) + ']';
    end
    // ------------------------------------------------------------------------
    else if Action = 'record_add_multi' then
    begin
      frmMain.actAddMulti.ShortCut := S;
      frmMain.btnAddMulti.Hint := Hint_19 + sLineBreak + '[' + ShortCutToText(S) + ']';
      ;
    end
    // ------------------------------------------------------------------------
    else if Action = 'record_edit' then
    begin
      frmMain.actEdit.ShortCut := S;
      frmMain.popEdit.ShortCut := S;
      frmMain.btnEdit.Hint := Hint_02 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmHolidays.actEdit.ShortCut := S;
      frmHolidays.popEdit.ShortCut := S;
      frmHolidays.btnEdit.Hint := Hint_02 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmComments.actEdit.ShortCut := S;
      frmComments.popEdit.ShortCut := S;
      frmComments.btnEdit.Hint := Hint_02 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmTags.actEdit.ShortCut := S;
      frmTags.popEdit.ShortCut := S;
      frmTags.btnEdit.Hint := Hint_02 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmCurrencies.actEdit.ShortCut := S;
      frmCurrencies.popEdit.ShortCut := S;
      frmCurrencies.btnEdit.Hint := Hint_02 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmPayees.actEdit.ShortCut := S;
      frmPayees.popEdit.ShortCut := S;
      frmPayees.btnEdit.Hint := Hint_02 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmAccounts.actEdit.ShortCut := S;
      frmAccounts.popEdit.ShortCut := S;
      frmAccounts.btnEdit.Hint := Hint_02 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmCategories.actEdit.ShortCut := S;
      frmCategories.popEdit.ShortCut := S;
      frmCategories.btnEdit.Hint := Hint_02 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmPersons.actEdit.ShortCut := S;
      frmPersons.popEdit.ShortCut := S;
      frmPersons.btnEdit.Hint := Hint_02 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmSchedulers.actEdit.ShortCut := S;
      frmSchedulers.popEdit1.ShortCut := S;
      frmSchedulers.btnEdit1.Hint :=
        Hint_02 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmBudgets.actBudgetEdit.ShortCut := S;
      frmBudgets.popBudgetEdit.ShortCut := S;
      frmBudgets.btnBudgetEdit.Hint :=
        Hint_02 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmWrite.actEdit.ShortCut := S;
      frmWrite.popEdit.ShortCut := S;
      frmWrite.btnEdit.Hint := Hint_02 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmSettings.btnChange.Hint := Hint_02 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmSettings.actChange.ShortCut := S;
      frmRecycleBin.actEdit.ShortCut := S;
      frmRecycleBin.btnEdit.Hint := Hint_02 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmMultiple.actEdit.ShortCut := S;
      frmMultiple.popEdit.ShortCut := S;
      frmMultiple.btnEdit.Hint := Hint_02 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmCalendar.actEdit.ShortCut := S;
      frmCalendar.btnEdit.Hint := Hint_02 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmTemplates.actEdit.ShortCut := S;
      frmTemplates.btnEdit.Hint := Hint_02 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmLinks.actEdit.ShortCut := S;
      frmLinks.popEdit.ShortCut := S;
      frmLinks.btnEdit.Hint := Hint_02 + sLineBreak + '[' + ShortCutToText(S) + ']';

    end
    // ------------------------------------------------------------------------
    else if Action = 'record_duplicate' then
    begin
      frmMain.actDuplicate.ShortCut := S;
      frmMain.popDuplicate.ShortCut := S;
      frmMain.btnDuplicate.Hint := Hint_18 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmMultiple.actDuplicate.ShortCut := S;
      frmMultiple.popDuplicate.ShortCut := S;
      frmMultiple.btnDuplicate.Hint :=
        Hint_18 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmBudgets.actBudgetDuplicate.ShortCut := S;
      frmBudgets.popBudgetDuplicate.ShortCut := S;
      frmBudgets.btnBudgetDuplicate.Hint :=
        Hint_18 + sLineBreak + '[' + ShortCutToText(S) + ']';
    end
    // ------------------------------------------------------------------------
    else if Action = 'record_delete' then
    begin
      frmMain.actDelete.ShortCut := S;
      frmMain.popDelete.ShortCut := S;
      frmMain.btnDelete.Hint := Hint_03 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmHolidays.actDelete.ShortCut := S;
      frmHolidays.popDelete.ShortCut := S;
      frmHolidays.btnDelete.Hint := Hint_03 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmComments.actDelete.ShortCut := S;
      frmComments.popDelete.ShortCut := S;
      frmComments.btnDelete.Hint := Hint_03 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmTags.actDelete.ShortCut := S;
      frmTags.popDelete.ShortCut := S;
      frmTags.btnDelete.Hint := Hint_03 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmCurrencies.actDelete.ShortCut := S;
      frmCurrencies.popDelete.ShortCut := S;
      frmCurrencies.btnDelete.Hint :=
        Hint_03 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmPayees.actDelete.ShortCut := S;
      frmPayees.popDelete.ShortCut := S;
      frmPayees.btnDelete.Hint := Hint_03 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmAccounts.actDelete.ShortCut := S;
      frmAccounts.popDelete.ShortCut := S;
      frmAccounts.btnDelete.Hint := Hint_03 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmCategories.actDelete.ShortCut := S;
      frmCategories.popDelete.ShortCut := S;
      frmCategories.btnDelete.Hint :=
        Hint_03 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmPersons.actDelete.ShortCut := S;
      frmPersons.popDelete.ShortCut := S;
      frmPersons.btnDelete.Hint := Hint_03 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmSchedulers.actDelete.ShortCut := S;
      frmSchedulers.popDelete.ShortCut := S;
      frmSchedulers.btnDelete.Hint :=
        Hint_03 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmBudgets.actBudgetDelete.ShortCut := S;
      frmBudgets.popBudgetDelete.ShortCut := S;
      frmBudgets.btnBudgetDelete.Hint :=
        Hint_03 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmWrite.actDelete.ShortCut := S;
      frmWrite.popDelete.ShortCut := S;
      frmWrite.btnDelete.Hint := Hint_03 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmRecycleBin.actDelete.ShortCut := S;
      frmRecycleBin.btnDelete.Hint :=
        Hint_03 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmMultiple.actDelete.ShortCut := S;
      frmMultiple.popDelete.ShortCut := S;
      frmMultiple.btnDelete.Hint := Hint_03 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmCalendar.actDelete.ShortCut := S;
      frmCalendar.btnDelete.Hint := Hint_03 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmTemplates.actDelete.ShortCut := S;
      frmTemplates.btnDelete.Hint :=
        Hint_03 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmLinks.actDelete.ShortCut := S;
      frmLinks.popDelete.ShortCut := S;
      frmLinks.btnDelete.Hint := Hint_03 + sLineBreak + '[' + ShortCutToText(S) + ']';
    end
    // ------------------------------------------------------------------------
    else if Action = 'record_copy_all' then
    begin
      frmMain.actCopy.ShortCut := S;
      frmMain.popCopy.ShortCut := S;
      frmMain.btnCopy.Hint := Hint_09 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmMain.btnReportCopy.Hint := Hint_09 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmHolidays.actCopy.ShortCut := S;
      frmHolidays.popCopy.ShortCut := S;
      frmHolidays.btnCopy.Hint := Hint_09 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmComments.actCopy.ShortCut := S;
      frmComments.popCopy.ShortCut := S;
      frmComments.btnCopy.Hint := Hint_09 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmTags.actCopy.ShortCut := S;
      frmTags.popCopy.ShortCut := S;
      frmTags.btnCopy.Hint := Hint_09 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmCurrencies.actCopy.ShortCut := S;
      frmCurrencies.popCopy.ShortCut := S;
      frmCurrencies.btnCopy.Hint := Hint_09 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmPayees.actCopy.ShortCut := S;
      frmPayees.popCopy.ShortCut := S;
      frmPayees.btnCopy.Hint := Hint_09 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmAccounts.actCopy.ShortCut := S;
      frmAccounts.popCopy.ShortCut := S;
      frmAccounts.btnCopy.Hint := Hint_09 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmCategories.actCopy.ShortCut := S;
      frmCategories.popCopy.ShortCut := S;
      frmCategories.btnCopy.Hint := Hint_09 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmPersons.actCopy.ShortCut := S;
      frmPersons.popCopy.ShortCut := S;
      frmPersons.btnCopy.Hint := Hint_09 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmSQLResult.actCopy.ShortCut := S;
      frmSQLResult.btnCopy.Hint := Hint_09 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmCounter.actCopy.ShortCut := S;
      frmCounter.btnCopy.Hint := Hint_09 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmLinks.actCopy.ShortCut := S;
      frmLinks.popCopy.ShortCut := S;
      frmLinks.btnCopy.Hint := Hint_09 + sLineBreak + '[' + ShortCutToText(S) + ']';
    end
    // ------------------------------------------------------------------------
    else if Action = 'record_copy_selected' then
    begin

    end
    // ------------------------------------------------------------------------
    else if Action = 'record_select' then
    begin
      frmMain.actSelect.ShortCut := S;
      frmMain.popSelect.ShortCut := S;
      frmMain.btnSelect.Hint := Hint_22 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmHolidays.actSelect.ShortCut := S;
      frmHolidays.popSelect.ShortCut := S;
      frmHolidays.btnSelect.Hint := Hint_22 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmComments.actSelect.ShortCut := S;
      frmComments.popSelect.ShortCut := S;
      frmComments.btnSelect.Hint := Hint_22 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmTags.actSelect.ShortCut := S;
      frmTags.popSelect.ShortCut := S;
      frmTags.btnSelect.Hint := Hint_22 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmCurrencies.actSelect.ShortCut := S;
      frmCurrencies.popSelect.ShortCut := S;
      frmCurrencies.btnSelect.Hint :=
        Hint_22 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmPayees.actSelect.ShortCut := S;
      frmPayees.popSelect.ShortCut := S;
      frmPayees.btnSelect.Hint := Hint_22 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmAccounts.actSelect.ShortCut := S;
      frmAccounts.popSelect.ShortCut := S;
      frmAccounts.btnSelect.Hint := Hint_22 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmCategories.actSelect.ShortCut := S;
      frmCategories.popSelect.ShortCut := S;
      frmCategories.btnSelect.Hint :=
        Hint_22 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmPersons.actSelect.ShortCut := S;
      frmPersons.popSelect.ShortCut := S;
      frmPersons.btnSelect.Hint := Hint_22 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmRecycleBin.actSelect.ShortCut := S;
      frmRecycleBin.btnSelect.Hint :=
        Hint_22 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmSQLResult.actSelect.ShortCut := S;
      frmSQLResult.btnSelect.Hint :=
        Hint_22 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmLinks.actSelect.ShortCut := S;
      frmLinks.popSelect.ShortCut := S;
      frmLinks.btnSelect.Hint := Hint_22 + sLineBreak + '[' + ShortCutToText(S) + ']';
    end
    // ------------------------------------------------------------------------
    else if Action = 'record_print_all' then
    begin
      frmMain.actPrint.ShortCut := S;
      frmMain.popPrint.ShortCut := S;
      frmMain.btnPrint.Hint := Hint_13 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmMain.btnReportPrint.Hint :=
        Hint_13 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmHolidays.actPrint.ShortCut := S;
      frmHolidays.popPrint.ShortCut := S;
      frmHolidays.btnPrint.Hint := Hint_13 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmComments.actPrint.ShortCut := S;
      frmComments.popPrint.ShortCut := S;
      frmComments.btnPrint.Hint := Hint_13 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmTags.actPrint.ShortCut := S;
      frmTags.popPrint.ShortCut := S;
      frmTags.btnPrint.Hint := Hint_13 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmCurrencies.actPrint.ShortCut := S;
      frmCurrencies.popPrint.ShortCut := S;
      frmCurrencies.btnPrint.Hint :=
        Hint_13 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmPayees.actPrint.ShortCut := S;
      frmPayees.popPrint.ShortCut := S;
      frmPayees.btnPrint.Hint := Hint_13 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmAccounts.actPrint.ShortCut := S;
      frmAccounts.popPrint.ShortCut := S;
      frmAccounts.btnPrint.Hint := Hint_13 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmCategories.actPrint.ShortCut := S;
      frmCategories.popPrint.ShortCut := S;
      frmCategories.btnPrint.Hint :=
        Hint_13 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmPersons.actPrint.ShortCut := S;
      frmPersons.popPrint.ShortCut := S;
      frmPersons.btnPrint.Hint := Hint_13 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmLinks.actPrint.ShortCut := S;
      frmLinks.popPrint.ShortCut := S;
      frmLinks.btnPrint.Hint := Hint_13 + sLineBreak + '[' + ShortCutToText(S) + ']';
    end
    // ------------------------------------------------------------------------
    else if Action = 'record_print_selected' then
    begin

    end
    // ------------------------------------------------------------------------
    else if Action = 'record_history' then
    begin
      frmMain.actHistory.ShortCut := S;
      frmMain.popHistory.ShortCut := S;
      frmMain.btnHistory.Hint := Hint_03 + sLineBreak + '[' + ShortCutToText(S) + ']';

    end
    // ------------------------------------------------------------------------
    else if Action = 'record_save' then
    begin
      frmDetail.actSave.ShortCut := S;
      frmDetail.btnSave.Hint := Hint_04 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmMultiple.actSave.ShortCut := S;
      frmMultiple.btnSave.Hint := Hint_04 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmMultiple.btnWrite.Hint := Hint_04 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmAccounts.actSave.ShortCut := S;
      frmAccounts.btnSave.Hint := Hint_04 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmCurrencies.actSave.ShortCut := S;
      frmCurrencies.btnSave.Hint := Hint_04 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmCategories.actSave.ShortCut := S;
      frmCategories.btnSave.Hint := Hint_04 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmPersons.actSave.ShortCut := S;
      frmPersons.btnSave.Hint := Hint_04 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmPayees.actSave.ShortCut := S;
      frmPayees.btnSave.Hint := Hint_04 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmValues.actSave.ShortCut := S;
      frmValues.btnSave.Hint := Hint_04 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmHolidays.actSave.ShortCut := S;
      frmHolidays.btnSave.Hint := Hint_04 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmTags.actSave.ShortCut := S;
      frmTags.btnSave.Hint := Hint_04 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmComments.actSave.ShortCut := S;
      frmComments.btnSave.Hint := Hint_04 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmEdit.actSave.ShortCut := S;
      frmEdit.btnSave.Hint := Hint_04 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmEdits.actSave.ShortCut := S;
      frmEdits.btnSave.Hint := Hint_04 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmWrite.popSave.ShortCut := S;
      frmWrite.actSave.ShortCut := S;
      frmWrite.btnSave.Hint := Hint_04 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmScheduler.actSave.ShortCut := S;
      frmScheduler.btnSave.Hint := Hint_04 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmTemplates.actSave.ShortCut := S;
      frmTemplates.btnSave.Hint := Hint_04 + sLineBreak + '[' + ShortCutToText(S) + ']';
    end
    // ------------------------------------------------------------------------
    else if Action = 'record_swap' then
    begin

    end
    // ------------------------------------------------------------------------
    else if Action = 'db_new' then
    begin
      frmMain.mnuNew.ShortCut := S;
      frmMain.btnNew.Hint := Hint_30 + sLineBreak + '[' + ShortCutToText(S) + ']';
    end
    // ------------------------------------------------------------------------
    else if Action = 'db_open' then
    begin
      frmMain.mnuOpen.ShortCut := S;
      frmMain.btnOpen.Hint := Hint_31 + sLineBreak + '[' + ShortCutToText(S) + ']';
    end
    // ------------------------------------------------------------------------
    else if Action = 'db_close' then
    begin
      frmMain.mnuClose.ShortCut := S;
      frmMain.btnClose.Hint := Hint_32 + sLineBreak + '[' + ShortCutToText(S) + ']';
    end
    // ------------------------------------------------------------------------
    else if Action = 'db_import' then
    begin
      frmMain.mnuImport.ShortCut := S;
      frmMain.btnImport.Hint := Hint_33 + sLineBreak + '[' + ShortCutToText(S) + ']';
    end
    // ------------------------------------------------------------------------
    else if Action = 'db_export' then
    begin
      frmMain.mnuExport.ShortCut := S;
      frmMain.btnExport.Hint := Hint_34 + sLineBreak + '[' + ShortCutToText(S) + ']';
    end
    // ------------------------------------------------------------------------
    else if Action = 'db_password' then
    begin
      frmMain.mnuPassword.ShortCut := S;
      frmMain.btnPassword.Hint := Hint_35 + sLineBreak + '[' + ShortCutToText(S) + ']';
    end
    // ------------------------------------------------------------------------
    else if Action = 'db_sql' then
    begin
      frmMain.mnuSQL.ShortCut := S;
      frmMain.btnSQL.Hint := Hint_36 + sLineBreak + '[' + ShortCutToText(S) + ']';
    end
    // ------------------------------------------------------------------------
    else if Action = 'db_guide' then
    begin
      frmMain.mnuGuide.ShortCut := S;
      frmMain.btnGuide.Hint := Hint_37 + sLineBreak + '[' + ShortCutToText(S) + ']';
    end
    // ------------------------------------------------------------------------
    else if Action = 'db_trash' then
    begin
      frmMain.mnuRecycle.ShortCut := S;
      frmMain.btnRecycle.Hint := Hint_39 + sLineBreak + '[' + ShortCutToText(S) + ']';
    end
    // ------------------------------------------------------------------------
    else if Action = 'db_properties' then
    begin
      frmMain.mnuProperties.ShortCut := S;
      frmMain.btnProperties.Hint := Hint_38 + sLineBreak + '[' + ShortCutToText(S) + ']';
    end
    // ------------------------------------------------------------------------

    // ------------------------------------------------------------------------
    else if Action = 'list_links' then
    begin
      frmMain.mnuSubLink.ShortCut := S;
    end
    // ------------------------------------------------------------------------
    else if Action = 'list_holidays' then
    begin
      frmMain.mnuHolidays.ShortCut := S;
      frmMain.btnHolidays.Hint := Hint_40 + sLineBreak + '[' + ShortCutToText(S) + ']';
    end
    // ------------------------------------------------------------------------
    else if Action = 'list_tags' then
    begin
      frmMain.mnuTags.ShortCut := S;
      frmMain.btnTags.Hint := Hint_41 + sLineBreak + '[' + ShortCutToText(S) + ']';
    end
    // ------------------------------------------------------------------------
    else if Action = 'list_currencies' then
    begin
      frmMain.mnuCurrencies.ShortCut := S;
      frmMain.btnCurrencies.Hint := Hint_42 + sLineBreak + '[' + ShortCutToText(S) + ']';
    end
    // ------------------------------------------------------------------------
    else if Action = 'list_payees' then
    begin
      frmMain.mnuPayees.ShortCut := S;
      frmMain.btnPayees.Hint := Hint_43 + sLineBreak + '[' + ShortCutToText(S) + ']';
    end
    // ------------------------------------------------------------------------
    else if Action = 'list_comments' then
    begin
      frmMain.mnuComments.ShortCut := S;
      frmMain.btnComments.Hint := Hint_44 + sLineBreak + '[' + ShortCutToText(S) + ']';
    end
    // ------------------------------------------------------------------------
    else if Action = 'list_accounts' then
    begin
      frmMain.mnuAccounts.ShortCut := S;
      frmMain.btnAccounts.Hint := Hint_45 + sLineBreak + '[' + ShortCutToText(S) + ']';
    end
    // ------------------------------------------------------------------------
    else if Action = 'list_categories' then
    begin
      frmMain.mnuCategories.ShortCut := S;
      frmMain.btnCategories.Hint := Hint_46 + sLineBreak + '[' + ShortCutToText(S) + ']';
    end
    // ------------------------------------------------------------------------
    else if Action = 'list_persons' then
    begin
      frmMain.mnuPersons.ShortCut := S;
      frmMain.btnPersons.Hint := Hint_47 + sLineBreak + '[' + ShortCutToText(S) + ']';
    end
    // ------------------------------------------------------------------------
    else if Action = 'tool_scheduler' then
    begin
      frmMain.mnuSchedulers.ShortCut := S;
      frmMain.btnSchedulers.Hint := Hint_50 + sLineBreak + '[' + ShortCutToText(S) + ']';
    end
    // ------------------------------------------------------------------------
    else if Action = 'tool_write' then
    begin
      frmMain.mnuWrite.ShortCut := S;
      frmMain.btnWrite.Hint := Hint_51 + sLineBreak + '[' + ShortCutToText(S) + ']';
    end
    // ------------------------------------------------------------------------
    else if Action = 'tool_calendar' then
    begin
      frmMain.mnuCalendar.ShortCut := S;
      frmMain.btnCalendar.Hint := Hint_52 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmWrite.actCalendar.ShortCut := S;
      frmWrite.btnCalendar.Hint := Hint_52 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmSchedulers.actCalendar.ShortCut := S;
      frmSchedulers.btnCalendar.Hint :=
        Hint_52 + sLineBreak + '[' + ShortCutToText(S) + ']';
    end
    // ------------------------------------------------------------------------
    else if Action = 'tool_budget' then
    begin
      frmMain.mnuBudget.ShortCut := S;
      frmMain.btnBudgets.Hint := Hint_53 + sLineBreak + '[' + ShortCutToText(S) + ']';
    end
    // ------------------------------------------------------------------------
    else if Action = 'tool_report' then
    begin
      frmMain.mnuReports.ShortCut := S;
      frmMain.btnReports.Hint := Hint_54 + sLineBreak + '[' + ShortCutToText(S) + ']';
    end
    // ------------------------------------------------------------------------
    else if Action = 'tool_counter' then
    begin
      frmMain.mnuCashCounter.ShortCut := S;
      frmMain.btnCashCounter.Hint :=
        Hint_55 + sLineBreak + '[' + ShortCutToText(S) + ']';
    end
    // ------------------------------------------------------------------------
    else if Action = 'tool_calc' then
    begin
      frmMain.mnuCalc.ShortCut := S;
      frmMain.btnCalc.Hint := Hint_56 + sLineBreak + '[' + ShortCutToText(S) + ']';
    end
    // ------------------------------------------------------------------------
    else if Action = 'settings' then
    begin
      frmMain.mnuSettings.ShortCut := S;
      frmMain.btnSettings.Hint := Hint_57 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmWrite.actSettings.ShortCut := S;
      frmWrite.btnSettings.Hint := Hint_57 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmScheduler.btnSettings.Hint :=
        Hint_57 + sLineBreak + '[' + ShortCutToText(S) + ']';
    end
    // ------------------------------------------------------------------------
    else if Action = 'about' then
    begin
      frmMain.mnuAbout.ShortCut := S;
      frmMain.btnAbout.Hint := Hint_58 + sLineBreak + '[' + ShortCutToText(S) + ']';
    end
    // ------------------------------------------------------------------------
    else if Action = 'filter_clear' then
    begin
      frmMain.popFilterClear.ShortCut := S;
      frmMain.actFilterClear.ShortCut := S;
    end
    // ------------------------------------------------------------------------
    else if Action = 'filter_expand' then
    begin
      frmMain.popFilterExpand.ShortCut := S;
      frmMain.actFilterExpand.ShortCut := S;
    end
    // ------------------------------------------------------------------------
    else if Action = 'filter_collapse' then
    begin
      frmMain.popFilterCollapse.ShortCut := S;
      frmMain.actFilterCollapse.ShortCut := S;
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

end.
