unit uniSettings;

{$mode objfpc}{$H+}
{$ModeSwitch AutoDeref}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  LazUTF8, StdCtrls, ComCtrls, Buttons, dateutils, LCLIntf, laz.VirtualTrees,
  FileCtrl, BCTypes, BCMDButtonFocus, BCPanel,
  IniFiles, strutils, Math, LCLTranslator, Spin, LCLProc, ActnList,
  LCLType, CheckLst, CalendarLite, DateTimePicker;

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
    btnTimeStamp: TSpeedButton;
    cbxFirstWeekDay: TComboBox;
    cbxReportFont: TComboBox;
    chkItemsFromFilter: TCheckBox;
    chkFilterComboboxStyle: TCheckBox;
    chkButtonsVisibility: TCheckListBox;
    chkBackupQuestion: TCheckBox;
    chkChartRotateLabels: TCheckBox;
    chkChartShowLegend: TCheckBox;
    chkChartWrapLabelsText: TCheckBox;
    chkChartZeroBalance: TCheckBox;
    chkCloseDbWarning: TCheckBox;
    chkDarkStyle: TCheckBox;
    chkRememberNewTransactionsForm: TCheckBox;
    chkEncryptDatabase: TCheckBox;
    chkDisplayFontBold: TCheckBox;
    chkDisplaySubCatCapital: TCheckBox;
    chkEnableSelfTransfer: TCheckBox;
    chkLastUsedFilterDate: TCheckBox;
    chkOpenNewTransaction: TCheckBox;
    chkPaymentSeparately: TCheckBox;
    chkNewVersion: TCheckBox;
    chkPrintSummarySeparately: TCheckBox;
    chkRedColorButtonDelete: TCheckBox;
    chkSelectAll: TCheckBox;
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
    gbxTransactionsAdd: TGroupBox;
    gbxNewTransaction: TGroupBox;
    imgFlags: TImageList;
    lblButtonsSize: TLabel;
    lblButtonsVisibility: TLabel;
    lblTransactionsAddDays: TLabel;
    lblChartRotateDegree: TLabel;
    lblTransactionsAddDate: TLabel;
    lblTransactionsEditDate: TLabel;
    lblTransactionsDeleteDate: TLabel;
    lblTransactionsEditDays: TLabel;
    lblTransactionsDeleteDays: TLabel;
    tabFilter: TTabSheet;
    tabTransactions: TPageControl;
    pnlButtonVisibilityTop: TPanel;
    pnlButtonsVisibility: TPanel;
    pnlButtonsSize: TPanel;
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
    rbtButtonsSize24: TRadioButton;
    rbtButtonsSize32: TRadioButton;
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
    tabButtons: TTabSheet;
    tabTransactionsGlobal: TTabSheet;
    tabTransactionsRestrictions: TTabSheet;
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
    procedure btnTimeStampClick(Sender: TObject);
    procedure cbxFirstWeekDayChange(Sender: TObject);
    procedure cbxGridFontNameChange(Sender: TObject);
    procedure chkButtonsVisibilityClickCheck(Sender: TObject);
    procedure chkChartRotateLabelsChange(Sender: TObject);
    procedure chkChartShowLegendChange(Sender: TObject);
    procedure chkChartZeroBalanceChange(Sender: TObject);
    procedure chkDarkStyleClick(Sender: TObject);
    procedure chkDisplayFontBoldChange(Sender: TObject);
    procedure chkDisplaySubCatCapitalChange(Sender: TObject);
    procedure chkEncryptDatabaseChange(Sender: TObject);
    procedure chkFilterComboboxStyleChange(Sender: TObject);
    procedure chkSelectAllChange(Sender: TObject);
    procedure datTransactionsAddDateChange(Sender: TObject);
    procedure datTransactionsDeleteDateChange(Sender: TObject);
    procedure datTransactionsEditDateChange(Sender: TObject);
    procedure gbxTransactionsRestrictionsResize(Sender: TObject);
    procedure lblTransactionsAddDateClick(Sender: TObject);
    procedure lblTransactionsDeleteDateClick(Sender: TObject);
    procedure lblTransactionsEditDateClick(Sender: TObject);
    procedure rbtButtonsSize24Change(Sender: TObject);
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
    procedure tabTransactionsRestrictionsResize(Sender: TObject);
    procedure traBackupCountChange(Sender: TObject);
    procedure treSettingsAdvancedCustomDrawItem(Sender: TCustomTreeView;
      Node: TTreeNode; State: TCustomDrawState; Stage: TCustomDrawStage;
      var PaintImages, DefaultDraw: boolean);
    procedure treSettingsChange(Sender: TObject; Node: TTreeNode);
    procedure VSTKeysPaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      TextType: TVSTTextType);
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
  uniCounter, uniCurrencies, uniProperties, uniSchedulers, uniShortCut, uniImage,
  uniPayees, uniCategories, uniHolidays, uniTags, uniComments, uniValues, uniBudgets,
  uniGuide, uniPassword, uniSQLResults, uniHistory, uniWrite, uniManyCurrencies,
  uniSuccess, uniGate, uniSQL, uniRecycleBin, uniFilter, uniImport, uniDetail,
  uniCalendar, uniResources, uniwriting, uniEdits, uniPeriod, uniPlan, uniTemplates,
  uniBudget, uniLinks, uniSplash, uniTimeStamp;

  { TfrmSettings }

procedure TfrmSettings.FormCreate(Sender: TObject);
var
  I: integer;
  INI: TINIFile;
  INIFile, Temp, File1: string;
  SystemFS: boolean;
  Key: PKey;
  Lang: PLang;
begin
  try
    frmSettings.Tag := 1;

    // set components height
    VSTKeys.Header.Height := PanelHeight;
    VSTLang.Header.Height := PanelHeight;
    pnlButtons.Height := ButtonHeight;
    pnlButtonsKeys.Height := ButtonHeight;
    pnlBottom.Height := ButtonHeight + 2;

    tabGlobal.TabIndex := 0;
    tabVisualSettings.TabIndex := 0;
    tabFontColor.TabIndex := 0;
    tabTool.TabIndex := 0;
    tabTransactions.TabIndex := 0;

    // get form icon
    frmMain.img16.GetIcon(25, (Sender as TForm).Icon);

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

  if frmSplash.Visible = True then
  begin
    frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 2;
    frmSplash.Update;
    TimeLog[43, 0] := 'Set calendar';
    TimeLog[43, 1] := IntToStr(GetTickCount64 - TimeStart);
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

  // frmMain buttons size
  rbtButtonsSize24.Caption := '24 px';
  rbtButtonsSize32.Caption := '32 px';

  // frmMain buttons visibility (fill the list of buttons)
  for I := 0 to frmMain.tooMenu.ControlCount - 1 do
  begin
    chkButtonsVisibility.Items.Add('');
    chkButtonsVisibility.CheckAll(cbChecked, False, False);
  end;

  if frmSplash.Visible = True then
  begin
    frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 2;
    frmSplash.Update;
    TimeLog[44, 0] := 'Set font properties';
    TimeLog[44, 1] := IntToStr(GetTickCount64 - TimeStart);
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
        INI.WriteInteger('GLOBAL', 'Version', 3);
        INI.WriteString('GLOBAL', 'Language',
          AnsiLowerCase(LeftStr(GetLang, 2)) + '.po');

        SetDefaultLang(
          AnsiLowerCase(LeftStr(GetLang, 2)),
          ExtractFileDir(Application.ExeName) + DirectorySeparator + 'Languages',
          AnsiLowerCase(LeftStr(GetLang, 2)) + '.po',
          True);

        INI.WriteInteger('GLOBAL', 'DarkMode', 0);

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
        INI.WriteBool('VISUAL_SETTINGS', 'SummaryPieChartVisible', True);
        INI.WriteBool('VISUAL_SETTINGS', 'RedColoredButtonDelete', True);
        INI.WriteInteger('VISUAL_SETTINGS', 'ButtonsSize', 24);
        INI.WriteString('VISUAL_SETTINGS', 'ButtonsVisibility', StringOfChar('1', 28));
        INI.WriteBool('VISUAL_SETTINGS', 'FilterComboboxStyle', False);

        // ---------------------------------------------------
        INI.WriteBool('ON_START', 'OpenLastFile', chkLastUsedFile.Checked);
        INI.WriteString('ON_START', 'LastFile', '');
        INI.WriteBool('ON_START', 'OpenLastFormsSize', chkLastFormsSize.Checked);
        INI.WriteBool('ON_START', 'OpenLastFilter', chkLastUsedFilter.Checked);
        INI.WriteBool('ON_START', 'OpenLastFilterDate', chkLastUsedFilterDate.Checked);
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
        INI.WriteBool('TRANSACTIONS', 'RememberNewTransactionsForm', False);
        INI.WriteBool('TRANSACTIONS', 'ItemsFromFilter', False);

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
        INI.WriteBool('BACKUP', 'ConfirmDialog', chkBackupQuestion.Checked);

        // ---------------------------------------------------
        INI.WriteBool('ON_CLOSE', 'ConfirmDialog', chkCloseDbWarning.Checked);
        INI.WriteBool('ON_CLOSE', 'EncryptDatabase', chkEncryptDatabase.Checked);

        // ---------------------------------------------------
        // record
        INI.WriteString('KEYS', 'record_add_simple', 'INS');
        INI.WriteString('KEYS', 'record_add_multiple', 'CTRL+INS');
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

        // detail
        INI.WriteString('KEYS', 'new_transaction_simple', 'F1');
        INI.WriteString('KEYS', 'new_transaction_multiple', 'F2');

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
    INI.EraseSection('POSITION');

    try
      // update to version 2
      // =========================================================
      if INI.ReadInteger('GLOBAL', 'Version', 1) < 2 then
      begin

        // delete old previous key(s)
        INI.DeleteKey('ON_START', 'SummaryColumnsAutoWidth');
        INI.DeleteKey('ON_START', 'TransactionsColumnsAutoWidth');

        // write new key
        INI.WriteBool('ON_START', 'TablesColumnsAutoWidth', chkAutoColumnWidth.Checked);

        // update version
        INI.WriteInteger('GLOBAL', 'Version', 2);
      end;
    except
    end;

    try
      // update to version 3
      // =========================================================
      if INI.ReadInteger('GLOBAL', 'Version', 2) < 3 then
      begin
        // add new transactions key
        INI.WriteString('KEYS', 'new_transaction_simple', 'F1');
        INI.WriteString('KEYS', 'new_transaction_multiple', 'F2');

        // update version
        INI.WriteInteger('GLOBAL', 'Version', 3);
      end;
    except
    end;

    try
      // update to version 4
      // =========================================================
      if INI.ReadInteger('GLOBAL', 'Version', 3) < 4 then
      begin

        // optimize the columns width writing
        if INI.ReadBool('ON_START', 'TablesColumnsAutoWidth', True) = False then
        begin

          // table frmAccounts
          Temp := '';
          for I := 1 to frmAccounts.VST.Header.Columns.Count - 1 do
            Temp := Temp + IfThen(I = 1, '', separ) +
              INI.ReadString('frmAccounts', 'Col_' +
              RightStr('0' + IntToStr(I), 2), '100');
          INI.WriteString('COLUMNS_WIDTH', 'Accounts', Temp);
          INI.EraseSection('frmAccounts');

          // table Report - Balance
          Temp := '';
          for I := 1 to frmMain.VSTBalance.Header.Columns.Count - 1 do
            Temp := Temp + IfThen(I = 1, '', separ) +
              INI.ReadString('frmMain', 'BalanceCol_' +
              RightStr('0' + IntToStr(I), 2), '100');
          INI.WriteString('COLUMNS_WIDTH', 'Balance', Temp);

          // table frmBudget
          Temp := '';
          for I := 1 to frmBudget.VST.Header.Columns.Count - 1 do
            Temp := Temp + IfThen(I = 1, '', separ) +
              INI.ReadString('frmBudget', 'Col_' +
              RightStr('0' + IntToStr(I), 2), '100');
          INI.WriteString('COLUMNS_WIDTH', 'Budget', Temp);
          INI.EraseSection('frmBudget');

          // table frmBudgets - budgets
          Temp := '';
          for I := 1 to frmBudgets.VSTBudgets.Header.Columns.Count - 1 do
            Temp := Temp + IfThen(I = 1, '', separ) +
              INI.ReadString('frmBudgets', 'ColB_' +
              RightStr('0' + IntToStr(I), 2), '100');
          INI.WriteString('COLUMNS_WIDTH', 'Budgets_1', Temp);

          // table frmBudgets - periods
          Temp := '';
          for I := 1 to frmBudgets.VSTPeriods.Header.Columns.Count - 1 do
            Temp := Temp + IfThen(I = 1, '', separ) +
              INI.ReadString('frmBudgets', 'Col_' +
              RightStr('0' + IntToStr(I), 2), '100');
          INI.WriteString('COLUMNS_WIDTH', 'Budgets_2', Temp);
          INI.EraseSection('frmBudgets');

          // table frmCalendar
          Temp := '';
          for I := 1 to frmCalendar.VST.Header.Columns.Count - 1 do
            Temp := Temp + IfThen(I = 1, '', separ) +
              INI.ReadString('frmCalendar', 'Col_' +
              RightStr('0' + IntToStr(I), 2), '100');
          INI.WriteString('COLUMNS_WIDTH', 'Calendar', Temp);
          INI.EraseSection('frmCalendar');

          // table frmCategories
          Temp := '';
          for I := 1 to frmCategories.VST.Header.Columns.Count - 1 do
            Temp := Temp + IfThen(I = 1, '', separ) +
              INI.ReadString('frmCategories', 'Col_' +
              RightStr('0' + IntToStr(I), 2), '100');
          INI.WriteString('COLUMNS_WIDTH', 'Categories', Temp);
          INI.EraseSection('frmCategories');

          // table Report - Chrono
          Temp := '';
          for I := 1 to frmMain.VSTChrono.Header.Columns.Count - 1 do
            Temp := Temp + IfThen(I = 1, '', separ) +
              INI.ReadString('frmMain', 'ChronoCol_' +
              RightStr('0' + IntToStr(I), 2), '100');
          INI.WriteString('COLUMNS_WIDTH', 'Chronology', Temp);

          // table frmComments
          Temp := '';
          for I := 1 to frmComments.VST.Header.Columns.Count - 1 do
            Temp := Temp + IfThen(I = 1, '', separ) +
              INI.ReadString('frmComments', 'Col_' +
              RightStr('0' + IntToStr(I), 2), '100');
          INI.WriteString('COLUMNS_WIDTH', 'Comments', Temp);
          INI.EraseSection('frmComments');

          // table Report - Cross
          Temp := '';
          for I := 1 to frmMain.VSTCross.Header.Columns.Count - 1 do
            Temp := Temp + IfThen(I = 1, '', separ) +
              INI.ReadString('frmMain', 'CrossTableCol_' +
              RightStr('0' + IntToStr(I), 2), '100');
          INI.WriteString('COLUMNS_WIDTH', 'CrossTable', Temp);

          // table frmCurrencies
          Temp := '';
          for I := 1 to frmCurrencies.VST.Header.Columns.Count - 1 do
            Temp := Temp + IfThen(I = 1, '', separ) +
              INI.ReadString('frmCurrencies', 'Col_' +
              RightStr('0' + IntToStr(I), 2), '100');
          INI.WriteString('COLUMNS_WIDTH', 'Currencies', Temp);
          INI.EraseSection('frmCurrencies');

          // table frmDelete 1
          Temp := '';
          for I := 1 to frmDelete.VST1.Header.Columns.Count - 1 do
            Temp := Temp + IfThen(I = 1, '', separ) +
              INI.ReadString('frmDelete', 'Col1_' +
              RightStr('0' + IntToStr(I), 2), '100');
          INI.WriteString('COLUMNS_WIDTH', 'Delete_1', Temp);

          // table frmDelete 2
          Temp := '';
          for I := 1 to frmDelete.VST2.Header.Columns.Count - 1 do
            Temp := Temp + IfThen(I = 1, '', separ) +
              INI.ReadString('frmDelete', 'Col2_' +
              RightStr('0' + IntToStr(I), 2), '100');
          INI.WriteString('COLUMNS_WIDTH', 'Delete_2', Temp);

          // table frmDelete 3
          Temp := '';
          for I := 1 to frmDelete.VST3.Header.Columns.Count - 1 do
            Temp := Temp + IfThen(I = 1, '', separ) +
              INI.ReadString('frmDelete', 'Col3_' +
              RightStr('0' + IntToStr(I), 2), '100');
          INI.WriteString('COLUMNS_WIDTH', 'Delete_3', Temp);
          INI.EraseSection('frmDelete');

          // table frmDetail
          Temp := '';
          for I := 1 to frmDetail.VST.Header.Columns.Count - 1 do
            Temp := Temp + IfThen(I = 1, '', separ) +
              INI.ReadString('frmDetail', 'Col_' +
              RightStr('0' + IntToStr(I), 2), '100');
          INI.WriteString('COLUMNS_WIDTH', 'Detail', Temp);
          INI.EraseSection('frmDetail');

          // table frmHistory 1
          Temp := '';
          for I := 1 to frmHistory.VST1.Header.Columns.Count - 1 do
            Temp := Temp + IfThen(I = 1, '', separ) +
              INI.ReadString('frmHistory', 'Col1_' +
              RightStr('0' + IntToStr(I), 2), '100');
          INI.WriteString('COLUMNS_WIDTH', 'History_1', Temp);

          // table frmHistory 2
          Temp := '';
          for I := 1 to frmHistory.VST2.Header.Columns.Count - 1 do
            Temp := Temp + IfThen(I = 1, '', separ) +
              INI.ReadString('frmHistory', 'Col2_' +
              RightStr('0' + IntToStr(I), 2), '100');
          INI.WriteString('COLUMNS_WIDTH', 'History_2', Temp);
          INI.EraseSection('frmHistory');

          // table frmHolidays
          Temp := '';
          for I := 1 to frmHolidays.VST.Header.Columns.Count - 1 do
            Temp := Temp + IfThen(I = 1, '', separ) +
              INI.ReadString('frmHolidays', 'Col_' +
              RightStr('0' + IntToStr(I), 2), '100');
          INI.WriteString('COLUMNS_WIDTH', 'Holidays', Temp);
          INI.EraseSection('frmHolidays');

          // table frmLinks
          Temp := '';
          for I := 1 to frmLinks.VST.Header.Columns.Count - 1 do
            Temp := Temp + IfThen(I = 1, '', separ) +
              INI.ReadString('frmLinks', 'Col_' + RightStr('0' + IntToStr(I), 2), '100');
          INI.WriteString('COLUMNS_WIDTH', 'Links', Temp);
          INI.EraseSection('frmLinks');

          // table frmPayees
          Temp := '';
          for I := 1 to frmPayees.VST.Header.Columns.Count - 1 do
            Temp := Temp + IfThen(I = 1, '', separ) +
              INI.ReadString('frmPayees', 'Col_' +
              RightStr('0' + IntToStr(I), 2), '100');
          INI.WriteString('COLUMNS_WIDTH', 'Payees', Temp);
          INI.EraseSection('frmPayees');

          // table frmPeriod
          Temp := '';
          for I := 1 to frmPeriod.VST.Header.Columns.Count - 1 do
            Temp := Temp + IfThen(I = 1, '', separ) +
              INI.ReadString('frmPeriod', 'Col_' +
              RightStr('0' + IntToStr(I), 2), '100');
          INI.WriteString('COLUMNS_WIDTH', 'Period', Temp);
          INI.EraseSection('frmPeriod');

          // table frmPersons
          Temp := '';
          for I := 1 to frmPersons.VST.Header.Columns.Count - 1 do
            Temp := Temp + IfThen(I = 1, '', separ) +
              INI.ReadString('frmPersons', 'Col_' +
              RightStr('0' + IntToStr(I), 2), '100');
          INI.WriteString('COLUMNS_WIDTH', 'Persons', Temp);
          INI.EraseSection('frmPersons');

          // table frmRecycleBin
          Temp := '';
          for I := 1 to frmRecycleBin.VST.Header.Columns.Count - 1 do
            Temp := Temp + IfThen(I = 1, '', separ) +
              INI.ReadString('frmRecycleBin', 'Col_' +
              RightStr('0' + IntToStr(I), 2), '100');
          INI.WriteString('COLUMNS_WIDTH', 'RecycleBin', Temp);
          INI.EraseSection('frmRecycleBin');

          // table frmSchedulers  1
          Temp := '';
          for I := 1 to frmSchedulers.VST.Header.Columns.Count - 1 do
            Temp := Temp + IfThen(I = 1, '', separ) +
              INI.ReadString('frmSchedulers', 'Col1_' +
              RightStr('0' + IntToStr(I), 2), '100');
          INI.WriteString('COLUMNS_WIDTH', 'Schedulers_1', Temp);

          // table frmSchedulers  1
          Temp := '';
          for I := 1 to frmSchedulers.VST1.Header.Columns.Count - 1 do
            Temp := Temp + IfThen(I = 1, '', separ) +
              INI.ReadString('frmSchedulers', 'Col2_' +
              RightStr('0' + IntToStr(I), 2), '100');
          INI.WriteString('COLUMNS_WIDTH', 'Schedulers_2', Temp);
          INI.EraseSection('frmSchedulers');

          // table frmSettings
          Temp := '';
          for I := 1 to frmSettings.VSTKeys.Header.Columns.Count - 1 do
            Temp := Temp + IfThen(I = 1, '', separ) +
              INI.ReadString('frmSettings', 'Col_' +
              RightStr('0' + IntToStr(I), 2), '100');
          INI.WriteString('COLUMNS_WIDTH', 'Settings', Temp);
          INI.EraseSection('frmSettings');

          // table Summary
          Temp := '';
          for I := 1 to frmMain.VSTSummary.Header.Columns.Count - 1 do
            Temp := Temp + IfThen(I = 1, '', separ) +
              INI.ReadString('frmMain', 'SumColumn_' +
              RightStr('0' + IntToStr(I), 2), '100');
          INI.WriteString('COLUMNS_WIDTH', 'Summary', Temp);

          // table frmTags
          Temp := '';
          for I := 1 to frmTags.VST.Header.Columns.Count - 1 do
            Temp := Temp + IfThen(I = 1, '', separ) +
              INI.ReadString('frmTags', 'Col_' + RightStr('0' + IntToStr(I), 2), '100');
          INI.WriteString('COLUMNS_WIDTH', 'Tags', Temp);
          INI.EraseSection('frmTags');

          // table Transactions
          Temp := '';
          for I := 1 to frmMain.VST.Header.Columns.Count - 1 do
            Temp := Temp + IfThen(I = 1, '', separ) +
              INI.ReadString('frmMain', 'TransColumn_' +
              RightStr('0' + IntToStr(I), 2), '100');
          INI.WriteString('COLUMNS_WIDTH', 'Transactions', Temp);
          INI.EraseSection('frmMain');

          // table frmValues
          Temp := '';
          for I := 1 to frmValues.VST.Header.Columns.Count - 1 do
            Temp := Temp + IfThen(I = 1, '', separ) +
              INI.ReadString('frmValues', 'Col_' +
              RightStr('0' + IntToStr(I), 2), '100');
          INI.WriteString('COLUMNS_WIDTH', 'Values', Temp);
          INI.EraseSection('frmValues');

          // table frmWrite
          Temp := '';
          for I := 1 to frmWrite.VST.Header.Columns.Count - 1 do
            Temp := Temp + IfThen(I = 1, '', separ) +
              INI.ReadString('frmWrite', 'Col_' + RightStr('0' + IntToStr(I), 2), '100');
          INI.DeleteKey('frmWrite', 'Col_' + RightStr('0' + IntToStr(I), 2));
          INI.EraseSection('frmWrite');

        end;
        // update version
        INI.WriteInteger('GLOBAL', 'Version', 4);
      end;
    except
    end;

    try
      // =========================================================
      // reading values from the INI file.
      // set language
      Temp := INI.ReadString('GLOBAL', 'Language',
        AnsiLowerCase(LeftStr(GetLang, 2)) + '.po');
      VSTLang.Hint := LeftStr(Temp, 2);

      SetDefaultLang(
        VSTLang.Hint,
        ExtractFileDir(Application.ExeName) + DirectorySeparator + 'Languages',
        Temp,
        True);
    except
    end;

    chkDarkStyle.Checked := INI.ReadInteger('GLOBAL', 'DarkMode', 0) = 2;

    if frmSplash.Visible = True then
    begin
      frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 2;
      frmSplash.Update;
      TimeLog[45, 0] := 'Create INI file';
      TimeLog[45, 1] := IntToStr(GetTickCount64 - TimeStart);
    end;

    try
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
    except
    end;

    try
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
      frmSettings.chkRedColorButtonDelete.Checked :=
        INI.ReadBool('VISUAL_SETTINGS', 'RedColoredButtonDelete', True);

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
    except
    end;

    try
      // grid font name
      cbxGridFontName.ItemIndex :=
        cbxGridFontName.Items.IndexOf(INI.ReadString('VISUAL_SETTINGS',
        'FontName', GetFontData(frmMain.Font.Handle).Name));
      if cbxGridFontName.ItemIndex = -1 then
        cbxGridFontName.ItemIndex := 5;
      cbxGridFontNameChange(cbxGridFontName);

      // grid font size
      spiGridFontSize.Value := INI.ReadInteger('VISUAL_SETTINGS', 'FontSize', 10);
      spiGridFontSize.Tag := spiGridFontSize.Value;

      // summary pie chart visibility
      I := INI.ReadInteger('VISUAL_SETTINGS', 'SummaryPieChartVisible', 0);
      frmMain.chkShowPieChart.Tag := I;
      if I = 1 then
        frmMain.chkShowPieChart.Checked := True
      else
        frmMain.chkShowPieChart.Checked := False;
    except
    end;

    try
      // Button size (24 px or 32 px) in frmMain
      I := INI.ReadInteger('VISUAL_SETTINGS', 'ButtonsSize', 24);
      if I = 24 then
      begin
        rbtButtonsSize24.Checked := True;
        rbtButtonsSize24Change(rbtButtonsSize24);
      end
      else
      begin
        rbtButtonsSize32.Checked := True;
        rbtButtonsSize24Change(rbtButtonsSize32);
      end;

      // Button visibility (in frmMain)
      SystemFS := False;
      Temp := INI.ReadString('VISUAL_SETTINGS', 'ButtonsVisibility',
        StringOfChar('1', 28));
      for I := 0 to chkButtonsVisibility.Items.Count - 1 do
      begin
        chkButtonsVisibility.Checked[I] := StrToBool(MidStr(Temp, I + 1, 1));
        frmMain.tooMenu.Controls[I].Visible := chkButtonsVisibility.Checked[I];
        if chkButtonsVisibility.Checked[I] = True then
          SystemFS := True;
      end;
      frmMain.tooMenu.Visible := SystemFS;
      chkSelectAll.Checked := SystemFS;
    except
    end;

    try
      // Filter combobox style (Dropdown or DropdownList
      chkFilterComboboxStyle.Checked :=
        INI.ReadBool('VISUAL_SETTINGS', 'FilterComboboxStyle', False);
      chkFilterComboboxStyleChange(chkFilterComboboxStyle);
    except
    end;

    try
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
    except
    end;

    try
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
      chkRememberNewTransactionsForm.Checked :=
        INI.ReadBool('TRANSACTIONS', 'RememberNewTransactionsForm', False);
      chkItemsFromFilter.Checked :=
        INI.ReadBool('TRANSACTIONS', 'ItemsFromFilter', False);


      Temp := INI.ReadString('TRANSACTIONS', 'RestrictionsAdd', '');
      case Length(Temp) of
        0: rbtTransactionsAddNo.Checked := True;
        10: begin
          rbtTransactionsAddDate.Checked := True;
          datTransactionsAddDate.Date := StrToDate(Temp, 'YYYY-MM-DD', '-');
        end
        else
        begin
          rbtTransactionsAddDays.Checked := True;
          spiTransactionsAddDays.Value := StrToInt(Temp);
        end;
      end;

      Temp := INI.ReadString('TRANSACTIONS', 'RestrictionsEdit', '');
      case Length(Temp) of
        0: rbtTransactionsEditNo.Checked := True;
        10: begin
          rbtTransactionsEditDate.Checked := True;
          datTransactionsEditDate.Date := StrToDate(Temp, 'YYYY-MM-DD', '-');
        end
        else
        begin
          rbtTransactionsEditDays.Checked := True;
          spiTransactionsEditDays.Value := StrToInt(Temp);
        end;
      end;

      Temp := INI.ReadString('TRANSACTIONS', 'RestrictionsDelete', '');
      case Length(Temp) of
        0: rbtTransactionsDeleteNo.Checked := True;
        10: begin
          rbtTransactionsDeleteDate.Checked := True;
          datTransactionsDeleteDate.Date := StrToDate(Temp, 'YYYY-MM-DD', '-');
        end
        else
        begin
          rbtTransactionsDeleteDays.Checked := True;
          spiTransactionsDeleteDays.Value := StrToInt(Temp);
        end;
      end;
    except
    end;

    try
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

    except
    end;

    try
      // ---------------------------------------------------
      chkDoBackup.Checked := INI.ReadBool('BACKUP', 'DoBackup', chkDoBackup.Checked);
      btnBackupFolder.Caption :=
        INI.ReadString('BACKUP', 'Folder', btnBackupFolder.Caption);
      traBackupCount.Position :=
        INI.ReadInteger('BACKUP', 'Count', traBackupCount.Position);
      traBackupCountChange(traBackupCount);
      chkBackupMessage.Checked :=
        INI.ReadBool('BACKUP', 'ShowMessage', chkBackupMessage.Checked);
      chkBackupQuestion.Checked :=
        INI.ReadBool('BACKUP', 'ConfirmDialog', chkBackupQuestion.Checked);
    except
    end;

    try
      // =======================================================================================
      // last used file
      if INI.ReadBool('ON_START', 'OpenLastFile', True) = True then
      begin
        chkLastUsedFile.Checked := True;
        frmMain.pnlBottomClient.Tag := IfThen(chkLastUsedFile.Checked = True, 1, 0);
        File1 := INI.ReadString('ON_START', 'LastFile', '');
      end
      else
      begin
        File1 := '';
        chkLastUsedFile.Checked := False;
      end;
      if FileExists(File1) = True then
        frmMain.pnlBottomClient.Hint := File1
      else
        frmMain.pnlBottomClient.Hint := '';

    except
    end;

    try
      // last used filter
      chkLastUsedFilter.Checked := INI.ReadBool('ON_START', 'OpenLastFilter', True);

      // last used date filter
      chkLastUsedFilterDate.Checked :=
        INI.ReadBool('ON_START', 'OpenLastFilterDate', True);

      // last used main form size
      chkLastFormsSize.Checked := INI.ReadBool('ON_START', 'OpenLastFormsSize', True);

      // check new version
      chkNewVersion.Checked := INI.ReadBool('ON_START', 'CheckNewVersion', True);

      // ---------------------------------------------------
      chkCloseDbWarning.Checked := INI.ReadBool('ON_CLOSE', 'ConfirmDialog', True);
      chkEncryptDatabase.Checked := INI.ReadBool('ON_CLOSE', 'EncryptDatabase', True);
    except
    end;

    if frmSplash.Visible = True then
    begin
      frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 2;
      frmSplash.Update;
      TimeLog[46, 0] := 'Open INI file 1';
      TimeLog[46, 1] := IntToStr(GetTickCount64 - TimeStart);
    end;

    // FORMS SIZE AND POSITION
    if chkLastFormsSize.Checked = True then
    begin
      Temp := frmAccounts.Name + '_' + IntToStr(ExtendedScreenWidth);
      // frmAccounts
      frmAccounts.Position := poDesigned;
      frmAccounts.Width :=
        INI.ReadInteger(Temp, 'Width', frmAccounts.Width);
      frmAccounts.Height :=
        INI.ReadInteger(Temp, 'Height', frmAccounts.Height);
      frmAccounts.pnlDetail.Width :=
        INI.ReadInteger(Temp, 'pnlRight', frmAccounts.pnlDetail.Width);
      frmAccounts.Left := INI.ReadInteger(Temp, 'Left',
        (Screen.Width - frmAccounts.Width) div 2);
      frmAccounts.Top := INI.ReadInteger(Temp, 'Top',
        ((Screen.Height - frmAccounts.Height) div 2) - 75);

      frmAccounts.Hint := IntToStr(frmAccounts.Width) +
        IntToStr(frmAccounts.Height) + IntToStr(frmAccounts.Left) +
        IntToStr(frmAccounts.Top) + IntToStr(frmAccounts.pnlDetail.Width);


      // frmBudgets
      Temp := frmBudgets.Name + '_' + IntToStr(ExtendedScreenWidth);
      frmBudgets.Position := poDesigned;
      frmBudgets.Width := INI.ReadInteger(Temp, 'Width', frmBudgets.Width);
      frmBudgets.Height := INI.ReadInteger(Temp, 'Height', frmBudgets.Height);
      frmBudgets.tabLeft.Width :=
        INI.ReadInteger(Temp, 'pnlLeft', frmBudgets.tabLeft.Width);
      frmBudgets.pnlPeriods.Width :=
        INI.ReadInteger(Temp, 'pnlPeriods', frmBudgets.pnlPeriods.Width);
      frmBudgets.Left := INI.ReadInteger(Temp, 'Left',
        (Screen.Width - frmBudgets.Width) div 2);
      frmBudgets.Top := INI.ReadInteger(Temp, 'Top',
        ((Screen.Height - frmBudgets.Height) div 2) - 75);

      frmBudgets.Hint := IntToStr(frmBudgets.Width) + IntToStr(frmBudgets.Height) +
        IntToStr(frmBudgets.Left) + IntToStr(frmBudgets.Top) +
        IntToStr(frmBudgets.tabLeft.Width) + IntToStr(frmBudgets.pnlPeriods.Width);

      // frmBudget
      Temp := frmBudget.Name + '_' + IntToStr(ExtendedScreenWidth);
      frmBudget.Position := poDesigned;
      frmBudget.Width := INI.ReadInteger(Temp, 'Width', frmBudget.Width);
      frmBudget.Height := INI.ReadInteger(Temp, 'Height', frmBudget.Height);
      frmBudget.Left := INI.ReadInteger(Temp, 'Left',
        (Screen.Width - frmBudget.Width) div 2);
      frmBudget.Top := INI.ReadInteger(Temp, 'Top',
        ((Screen.Height - frmBudget.Height) div 2) - 75);
      frmBudget.pnlLeft.Width :=
        INI.ReadInteger(Temp, 'pnlLeft', frmBudget.pnlLeft.Width);

      frmBudget.Hint := IntToStr(frmBudget.Width) + IntToStr(frmBudget.Height) +
        IntToStr(frmBudget.Left) + IntToStr(frmBudget.Top) +
        IntToStr(frmBudget.pnlLeft.Width);

      // frmCalendar
      Temp := frmCalendar.Name + '_' + IntToStr(ExtendedScreenWidth);
      frmCalendar.Position := poDesigned;
      frmCalendar.Width :=
        INI.ReadInteger(Temp, 'Width', frmCalendar.Width);
      frmCalendar.Height := INI.ReadInteger(Temp, 'Height', frmCalendar.Height);
      frmCalendar.Left := INI.ReadInteger(Temp, 'Left',
        (Screen.Width - frmCalendar.Width) div 2);
      frmCalendar.Top := INI.ReadInteger(Temp, 'Top',
        ((Screen.Height - frmCalendar.Height) div 2) - 75);
      frmCalendar.pnlLeft.Width :=
        INI.ReadInteger(Temp, 'pnlLeft', frmCalendar.pnlLeft.Width);

      frmCalendar.Hint := IntToStr(frmCalendar.Width) +
        IntToStr(frmCalendar.Height) + IntToStr(frmCalendar.Left) +
        IntToStr(frmCalendar.Top) + IntToStr(frmCalendar.pnlLeft.Width);

      // frmCategories
      Temp := frmCategories.Name + '_' + IntToStr(ExtendedScreenWidth);
      frmCategories.Position := poDesigned;
      frmCategories.Width :=
        INI.ReadInteger(Temp, 'Width', frmCategories.Width);
      frmCategories.Height :=
        INI.ReadInteger(Temp, 'Height', frmCategories.Height);
      frmCategories.Left :=
        INI.ReadInteger(Temp, 'Left', (Screen.Width - frmCategories.Width) div 2);
      frmCategories.Top :=
        INI.ReadInteger(Temp, 'Top', ((Screen.Height - frmCategories.Height) div
        2) - 75);
      frmCategories.pnlDetail.Width :=
        INI.ReadInteger(Temp, 'pnlRight', frmCategories.pnlDetail.Width);

      frmCategories.Hint := IntToStr(frmCategories.Width) +
        IntToStr(frmCategories.Height) + IntToStr(frmCategories.Left) +
        IntToStr(frmCategories.Top) + IntToStr(frmCategories.pnlDetail.Width);

      // frmComments
      Temp := frmComments.Name + '_' + IntToStr(ExtendedScreenWidth);
      frmComments.Position := poDesigned;
      frmComments.Width :=
        INI.ReadInteger(Temp, 'Width', frmComments.Width);
      frmComments.Height :=
        INI.ReadInteger(Temp, 'Height', frmComments.Height);
      frmComments.pnlDetail.Width :=
        INI.ReadInteger(Temp, 'pnlRight', frmComments.pnlDetail.Width);
      frmComments.Left := INI.ReadInteger(Temp, 'Left',
        (Screen.Width - frmComments.Width) div 2);
      frmComments.Top := INI.ReadInteger(Temp, 'Top',
        ((Screen.Height - frmComments.Height) div 2) - 75);

      frmComments.Hint := IntToStr(frmComments.Width) +
        IntToStr(frmComments.Height) + IntToStr(frmComments.Left) +
        IntToStr(frmComments.Top) + IntToStr(frmComments.pnlDetail.Width);

      // frmCounter
      Temp := frmCounter.Name + '_' + IntToStr(ExtendedScreenWidth);
      frmCounter.Position := poDesigned;
      frmCounter.Width := INI.ReadInteger(Temp, 'Width', frmCounter.Width);
      frmCounter.Height :=
        INI.ReadInteger(Temp, 'Height', frmCounter.Height);
      frmCounter.Left := INI.ReadInteger(Temp, 'Left',
        (Screen.Width - frmCounter.Width) div 2);
      frmCounter.Top := INI.ReadInteger(Temp, 'Top',
        ((Screen.Height - frmCounter.Height) div 2) - 75);

      frmCounter.Hint := IntToStr(frmCounter.Width) + IntToStr(frmCounter.Height) +
        IntToStr(frmCounter.Left) + IntToStr(frmCounter.Top);

      // frmCurrencies
      Temp := frmCurrencies.Name + '_' + IntToStr(ExtendedScreenWidth);
      frmCurrencies.Position := poDesigned;
      frmCurrencies.Width :=
        INI.ReadInteger(Temp, 'Width', frmCurrencies.Width);
      frmCurrencies.Height :=
        INI.ReadInteger(Temp, 'Height', frmCurrencies.Height);
      frmCurrencies.Left :=
        INI.ReadInteger(Temp, 'Left', (Screen.Width - frmCurrencies.Width) div 2);
      frmCurrencies.Top :=
        INI.ReadInteger(Temp, 'Top', ((Screen.Height - frmCurrencies.Height) div
        2) - 75);
      frmCurrencies.pnlRight.Width :=
        INI.ReadInteger(Temp, 'pnlRight', frmCurrencies.pnlRight.Width);

      frmCurrencies.Hint := IntToStr(frmCurrencies.Width) +
        IntToStr(frmCurrencies.Height) + IntToStr(frmCurrencies.Left) +
        IntToStr(frmCurrencies.Top) + IntToStr(frmCurrencies.pnlRight.Width);

      // frmDelete
      Temp := frmDelete.Name + '_' + IntToStr(ExtendedScreenWidth);
      frmDelete.Position := poDesigned;
      frmDelete.Left := INI.ReadInteger(Temp, 'Left', frmDelete.Left);
      frmDelete.Top := INI.ReadInteger(Temp, 'Top', frmDelete.Top);
      frmDelete.Width := INI.ReadInteger(Temp, 'Width', frmDelete.Width);
      frmDelete.Height := INI.ReadInteger(Temp, 'Height', frmDelete.Height);

      frmDelete.pnlBottom.Hint :=
        IntToStr(frmDelete.Width) + IntToStr(frmDelete.Height) +
        IntToStr(frmDelete.Left) + IntToStr(frmDelete.Top);

      // frmDetail
      Temp := frmDetail.Name + '_' + IntToStr(ExtendedScreenWidth);
      frmDetail.Position := poDesigned;
      frmDetail.Width := INI.ReadInteger(Temp, 'Width', frmDetail.Width);
      frmDetail.Height := INI.ReadInteger(Temp, 'Height', frmDetail.Height);
      frmDetail.Left := INI.ReadInteger(Temp, 'Left',
        (Screen.Width - frmDetail.Width) div 2);
      frmDetail.Top := INI.ReadInteger(Temp, 'Top',
        ((Screen.Height - frmDetail.Height) div 2) - 75);
      frmDetail.pnlSimple.Tag :=
        INI.ReadInteger(Temp, 'Simple', frmDetail.pnlSimple.Tag);
      frmDetail.pnlMultiple.Tag :=
        INI.ReadInteger(Temp, 'Multi', frmDetail.pnlMultiple.Tag);
      frmDetail.pnlRight.Width :=
        INI.ReadInteger(Temp, 'pnlRight', frmDetail.pnlRight.Width);
      frmDetail.pnlLeft.Width :=
        INI.ReadInteger(Temp, 'pnlLeft', frmDetail.pnlLeft.Width);
      frmDetail.pnlDetail.Width :=
        INI.ReadInteger(Temp, 'pnlDetail', frmDetail.pnlDetail.Width);
      frmDetail.pnlRight.Tag := frmDetail.pnlRight.Width;

      frmDetail.Hint := IntToStr(frmDetail.Width) + IntToStr(frmDetail.Height) +
        IntToStr(frmDetail.Left) + IntToStr(frmDetail.Top) +
        IntToStr(frmDetail.pnlSimple.Tag) + IntToStr(frmDetail.pnlMultiple.Tag) +
        IntToStr(frmDetail.pnlRight.Width) + IntToStr(frmDetail.pnlLeft.Width) +
        IntToStr(frmDetail.pnlDetail.Width);

      // frmEdit
      Temp := frmEdit.Name + '_' + IntToStr(ExtendedScreenWidth);
      frmEdit.Position := poDesigned;
      frmEdit.Width := INI.ReadInteger(Temp, 'Width', frmEdit.Width);
      frmEdit.Height := INI.ReadInteger(Temp, 'Height', frmEdit.Height);
      frmEdit.Left := INI.ReadInteger(Temp, 'Left',
        (Screen.Width - frmEdit.Width) div 2);
      frmEdit.Top := INI.ReadInteger(Temp, 'Top',
        ((Screen.Height - frmEdit.Height) div 2) - 75);
      frmEdit.pnlRight.Width :=
        INI.ReadInteger(Temp, 'pnlRight', frmEdit.pnlRight.Width);

      frmEdit.Hint := IntToStr(frmEdit.Width) + IntToStr(frmEdit.Height) +
        IntToStr(frmEdit.Left) + IntToStr(frmEdit.Top) +
        IntToStr(frmEdit.pnlRight.Width);

      // frmEdits
      Temp := frmEdits.Name + '_' + IntToStr(ExtendedScreenWidth);
      frmEdits.Position := poDesigned;
      frmEdits.Width := INI.ReadInteger(Temp, 'Width', frmEdits.Width);
      frmEdits.Height := INI.ReadInteger(Temp, 'Height', frmEdits.Height);
      frmEdits.Left := INI.ReadInteger(Temp, 'Left',
        (Screen.Width - frmEdits.Width) div 2);
      frmEdits.Top := INI.ReadInteger(Temp, 'Top',
        ((Screen.Height - frmEdits.Height) div 2) - 75);
      frmEdits.pnlTag.Width :=
        INI.ReadInteger(Temp, 'pnlRight', frmEdits.pnlTag.Width);

      frmEdits.Hint := IntToStr(frmEdits.Width) + IntToStr(frmEdits.Height) +
        IntToStr(frmEdits.Left) + IntToStr(frmEdits.Top) +
        IntToStr(frmEdits.pnlTag.Width);

      // frmGate
      Temp := frmGate.Name + '_' + IntToStr(ExtendedScreenWidth);
      frmGate.Position := poDesigned;
      frmGate.Left := INI.ReadInteger(Temp, 'Left', frmGate.Left);
      frmGate.Top := INI.ReadInteger(Temp, 'Top', frmGate.Top);
      frmGate.Width := INI.ReadInteger(Temp, 'Width', frmGate.Width);
      frmGate.Height := INI.ReadInteger(Temp, 'Height', frmGate.Height);

      frmGate.Hint := IntToStr(frmGate.Width) + IntToStr(frmGate.Height) +
        IntToStr(frmGate.Left) + IntToStr(frmGate.Top);

      // frmGuide
      Temp := frmGuide.Name + '_' + IntToStr(ExtendedScreenWidth);
      frmGuide.Position := poDesigned;
      frmGuide.Left := INI.ReadInteger(Temp, 'Left', frmGuide.Left);
      frmGuide.Top := INI.ReadInteger(Temp, 'Top', frmGuide.Top);
      frmGuide.Width := INI.ReadInteger(Temp, 'Width', frmGuide.Width);
      frmGuide.Height := INI.ReadInteger(Temp, 'Height', frmGuide.Height);

      frmGuide.Hint := IntToStr(frmGuide.Width) + IntToStr(frmGuide.Height) +
        IntToStr(frmGuide.Left) + IntToStr(frmGuide.Top);

      // frmHistory
      Temp := frmHistory.Name + '_' + IntToStr(ExtendedScreenWidth);
      frmHistory.Position := poDesigned;
      frmHistory.Left := INI.ReadInteger(Temp, 'Left', frmHistory.Left);
      frmHistory.Top := INI.ReadInteger(Temp, 'Top', frmHistory.Top);
      frmHistory.Width := INI.ReadInteger(Temp, 'Width', frmHistory.Width);
      frmHistory.Height :=
        INI.ReadInteger(Temp, 'Height', frmHistory.Height);

      frmHistory.Hint := IntToStr(frmHistory.Width) + IntToStr(frmHistory.Height) +
        IntToStr(frmHistory.Left) + IntToStr(frmHistory.Top);

      // frmHolidays
      Temp := frmHolidays.Name + '_' + IntToStr(ExtendedScreenWidth);
      frmHolidays.Position := poDesigned;
      frmHolidays.Width :=
        INI.ReadInteger(Temp, 'Width', frmHolidays.Width);
      frmHolidays.Height :=
        INI.ReadInteger(Temp, 'Height', frmHolidays.Height);
      frmHolidays.Left := INI.ReadInteger(Temp, 'Left',
        (Screen.Width - frmHolidays.Width) div 2);
      frmHolidays.Top := INI.ReadInteger(Temp, 'Top',
        ((Screen.Height - frmHolidays.Height) div 2) - 75);
      frmHolidays.pnlDetail.Width :=
        INI.ReadInteger(Temp, 'pnlRight', frmHolidays.pnlDetail.Width);

      frmHolidays.Hint := IntToStr(frmHolidays.Width) +
        IntToStr(frmHolidays.Height) + IntToStr(frmHolidays.Left) +
        IntToStr(frmHolidays.Top) + IntToStr(frmHolidays.pnlDetail.Width);

      // frmImage
      Temp := frmImage.Name + '_' + IntToStr(ExtendedScreenWidth);
      frmImage.Position := poDesigned;
      frmImage.Left := INI.ReadInteger(Temp, 'Left', frmImage.Left);
      frmImage.Top := INI.ReadInteger(Temp, 'Top', frmImage.Top);
      frmImage.Width := INI.ReadInteger(Temp, 'Width', frmImage.Width);
      frmImage.Height := INI.ReadInteger(Temp, 'Height', frmImage.Height);

      frmImage.Hint := IntToStr(frmImage.Width) + IntToStr(frmImage.Height) +
        IntToStr(frmImage.Left) + IntToStr(frmImage.Top);

      // frmImport
      Temp := frmImport.Name + '_' + IntToStr(ExtendedScreenWidth);
      frmImport.Position := poDesigned;
      frmImport.Left := INI.ReadInteger(Temp, 'Left', frmImport.Left);
      frmImport.Top := INI.ReadInteger(Temp, 'Top', frmImport.Top);
      frmImport.Width := INI.ReadInteger(Temp, 'Width', frmImport.Width);
      frmImport.Height := INI.ReadInteger(Temp, 'Height', frmImport.Height);

      frmImport.Hint := IntToStr(frmImport.Width) + IntToStr(frmImport.Height) +
        IntToStr(frmImport.Left) + IntToStr(frmImport.Top);

      // frmLinks
      Temp := frmLinks.Name + '_' + IntToStr(ExtendedScreenWidth);
      frmLinks.Position := poDesigned;
      frmLinks.Width := INI.ReadInteger(Temp, 'Width', frmLinks.Width);
      frmLinks.Height := INI.ReadInteger(Temp, 'Height', frmLinks.Height);
      frmLinks.Left := INI.ReadInteger(Temp, 'Left',
        (Screen.Width - frmLinks.Width) div 2);
      frmLinks.Top := INI.ReadInteger(Temp, 'Top',
        ((Screen.Height - frmLinks.Height) div 2) - 75);
      frmLinks.pnlDetail.Width :=
        INI.ReadInteger(Temp, 'pnlRight', frmLinks.pnlDetail.Width);

      frmLinks.Hint := IntToStr(frmLinks.Width) + IntToStr(frmLinks.Height) +
        IntToStr(frmLinks.Left) + IntToStr(frmLinks.Top) +
        IntToStr(frmLinks.pnlDetail.Width);

      // frmMain
      Temp := frmMain.Name + '_' + IntToStr(ExtendedScreenWidth);
      frmMain.Position := poDesigned;
      frmMain.Width := INI.ReadInteger(Temp, 'Width', frmMain.Width);
      frmMain.Height := INI.ReadInteger(Temp, 'Height', frmMain.Height);
      frmMain.Left := INI.ReadInteger(Temp, 'Left',
        (Screen.Width - frmMain.Width) div 2);
      frmMain.Top := INI.ReadInteger(Temp, 'Top',
        ((Screen.Height - frmMain.Height) div 2) - 75);
      frmMain.pnlFilter.Width :=
        INI.ReadInteger(Temp, 'pnlFilter', frmMain.pnlFilter.Width);
      frmMain.pnlSummary.Height :=
        INI.ReadInteger(Temp, 'pnlSummary', frmMain.pnlSummary.Height);
      frmMain.vstBalance.Height := INI.ReadInteger(Temp, 'ChartBalance', 200);

      frmMain.Hint := IntToStr(frmMain.Width) + IntToStr(frmMain.Height) +
        IntToStr(frmMain.Left) + IntToStr(frmMain.Top) +
        IntToStr(frmMain.pnlFilter.Width) + IntToStr(frmMain.pnlSummary.Height) +
        IntToStr(frmMain.VSTBalance.Height);

      // frmPassword
      Temp := frmPassword.Name + '_' + IntToStr(ExtendedScreenWidth);
      frmPassword.Position := poDesigned;
      frmPassword.Left := INI.ReadInteger(Temp, 'Left', frmPassword.Left);
      frmPassword.Top := INI.ReadInteger(Temp, 'Top', frmPassword.Top);
      frmPassword.Width := INI.ReadInteger(Temp, 'Width', frmPassword.Width);
      frmPassword.Height := INI.ReadInteger(Temp, 'Height', frmPassword.Height);

      frmPassword.Hint := IntToStr(frmPassword.Width) +
        IntToStr(frmPassword.Height) + IntToStr(frmPassword.Left) +
        IntToStr(frmPassword.Top);

      // frmPayees
      Temp := frmPayees.Name + '_' + IntToStr(ExtendedScreenWidth);
      frmPayees.Position := poDesigned;
      frmPayees.Width := INI.ReadInteger(Temp, 'Width', frmPayees.Width);
      frmPayees.Height := INI.ReadInteger(Temp, 'Height', frmPayees.Height);
      frmPayees.Left := INI.ReadInteger(Temp, 'Left',
        (Screen.Width - frmPayees.Width) div 2);
      frmPayees.Top := INI.ReadInteger(Temp, 'Top',
        ((Screen.Height - frmPayees.Height) div 2) - 75);
      frmPayees.pnlDetail.Width :=
        INI.ReadInteger(Temp, 'pnlRight', frmPayees.pnlDetail.Width);

      frmPayees.Hint := IntToStr(frmPayees.Width) + IntToStr(frmPayees.Height) +
        IntToStr(frmPayees.Left) + IntToStr(frmPayees.Top) +
        IntToStr(frmPayees.pnlDetail.Width);

      // frmPeriod
      Temp := frmPeriod.Name + '_' + IntToStr(ExtendedScreenWidth);
      frmPeriod.Position := poDesigned;
      frmPeriod.Width := INI.ReadInteger(Temp, 'Width', frmPeriod.Width);
      frmPeriod.Height := INI.ReadInteger(Temp, 'Height', frmPeriod.Height);
      frmPeriod.Left := INI.ReadInteger(Temp, 'Left',
        (Screen.Width - frmPeriod.Width) div 2);
      frmPeriod.Top := INI.ReadInteger(Temp, 'Top',
        ((Screen.Height - frmPeriod.Height) div 2) - 75);
      frmPeriod.pnlLeft.Width :=
        INI.ReadInteger(Temp, 'pnlLeft', frmPeriod.pnlLeft.Width);

      frmPeriod.Hint := IntToStr(frmPeriod.Width) + IntToStr(frmPeriod.Height) +
        IntToStr(frmPeriod.Left) + IntToStr(frmPeriod.Top) +
        IntToStr(frmPeriod.pnlLeft.Width);

      // frmPersons
      Temp := frmPersons.Name + '_' + IntToStr(ExtendedScreenWidth);
      frmPersons.Position := poDesigned;
      frmPersons.Width := INI.ReadInteger(Temp, 'Width', frmPersons.Width);
      frmPersons.Height :=
        INI.ReadInteger(Temp, 'Height', frmPersons.Height);
      frmPersons.Left := INI.ReadInteger(Temp, 'Left',
        (Screen.Width - frmPersons.Width) div 2);
      frmPersons.Top := INI.ReadInteger(Temp, 'Top',
        ((Screen.Height - frmPersons.Height) div 2) - 75);
      frmPersons.pnlDetail.Width :=
        INI.ReadInteger(Temp, 'pnlRight', frmPersons.pnlDetail.Width);

      frmPersons.Hint := IntToStr(frmPersons.Width) + IntToStr(frmPersons.Height) +
        IntToStr(frmPersons.Left) + IntToStr(frmPersons.Top) +
        IntToStr(frmPersons.pnlDetail.Width);

      // frmPlan
      Temp := frmPlan.Name + '_' + IntToStr(ExtendedScreenWidth);
      frmPlan.Position := poDesigned;
      frmPlan.Left := INI.ReadInteger(Temp, 'Left', frmPlan.Left);
      frmPlan.Top := INI.ReadInteger(Temp, 'Top', frmPlan.Top);
      frmPlan.Width := INI.ReadInteger(Temp, 'Width', frmPlan.Width);
      frmPlan.Height := INI.ReadInteger(Temp, 'Height', frmPlan.Height);

      frmPlan.Hint := IntToStr(frmPlan.Width) + IntToStr(frmPlan.Height) +
        IntToStr(frmPlan.Left) + IntToStr(frmPlan.Top);

      // frmProperties
      Temp := frmProperties.Name + '_' + IntToStr(ExtendedScreenWidth);
      frmProperties.Position := poDesigned;
      frmProperties.Left := INI.ReadInteger(Temp, 'Left', frmProperties.Left);
      frmProperties.Top := INI.ReadInteger(Temp, 'Top', frmProperties.Top);
      frmProperties.Width := INI.ReadInteger(Temp, 'Width', frmProperties.Width);
      frmProperties.Height := INI.ReadInteger(Temp, 'Height', frmProperties.Height);

      frmProperties.Hint := IntToStr(frmProperties.Width) +
        IntToStr(frmProperties.Height) + IntToStr(frmProperties.Left) +
        IntToStr(frmProperties.Top);

      // frmRecycleBin
      Temp := frmRecycleBin.Name + '_' + IntToStr(ExtendedScreenWidth);
      frmRecycleBin.Position := poDesigned;
      frmRecycleBin.Left := INI.ReadInteger(Temp, 'Left', frmRecycleBin.Left);
      frmRecycleBin.Top := INI.ReadInteger(Temp, 'Top', frmRecycleBin.Top);
      frmRecycleBin.Width := INI.ReadInteger(Temp, 'Width', frmRecycleBin.Width);
      frmRecycleBin.Height := INI.ReadInteger(Temp, 'Height', frmRecycleBin.Height);

      frmRecycleBin.Hint := IntToStr(frmRecycleBin.Width) +
        IntToStr(frmRecycleBin.Height) + IntToStr(frmRecycleBin.Left) +
        IntToStr(frmRecycleBin.Top);

      // frmSQL
      Temp := frmSQL.Name + '_' + IntToStr(ExtendedScreenWidth);
      frmSQL.Position := poDesigned;
      frmSQL.Left := INI.ReadInteger(Temp, 'Left', frmSQL.Left);
      frmSQL.Top := INI.ReadInteger(Temp, 'Top', frmSQL.Top);
      frmSQL.Width := INI.ReadInteger(Temp, 'Width', frmSQL.Width);
      frmSQL.Height := INI.ReadInteger(Temp, 'Height', frmSQL.Height);

      frmSQL.Hint := IntToStr(frmSQL.Width) + IntToStr(frmSQL.Height) +
        IntToStr(frmSQL.Left) + IntToStr(frmSQL.Top);

      // frmSQLResult
      Temp := frmSQLResult.Name + '_' + IntToStr(ExtendedScreenWidth);
      frmSQLResult.Position := poDesigned;
      frmSQLResult.Left :=
        INI.ReadInteger(Temp, 'Left', frmSQLResult.Left);
      frmSQLResult.Top := INI.ReadInteger(Temp, 'Top', frmSQLResult.Top);
      frmSQLResult.Width :=
        INI.ReadInteger(Temp, 'Width', frmSQLResult.Width);
      frmSQLResult.Height :=
        INI.ReadInteger(Temp, 'Height', frmSQLResult.Height);

      frmSQLResult.Hint := IntToStr(frmSQLResult.Width) +
        IntToStr(frmSQLResult.Height) + IntToStr(frmSQLResult.Left) +
        IntToStr(frmSQLResult.Top);

      // frmShortCut
      Temp := frmShortCut.Name + '_' + IntToStr(ExtendedScreenWidth);
      frmShortCut.Position := poDesigned;
      frmShortCut.Left := INI.ReadInteger(Temp, 'Left', frmShortCut.Left);
      frmShortCut.Top := INI.ReadInteger(Temp, 'Top', frmShortCut.Top);
      frmShortCut.Width := INI.ReadInteger(Temp, 'Width', frmShortCut.Width);
      frmShortCut.Height := INI.ReadInteger(Temp, 'Height', frmShortCut.Height);

      frmShortCut.Hint := IntToStr(frmShortCut.Width) +
        IntToStr(frmShortCut.Height) + IntToStr(frmShortCut.Left) +
        IntToStr(frmShortCut.Top);

      // frmSchedulers
      Temp := frmSchedulers.Name + '_' + IntToStr(ExtendedScreenWidth);
      frmSchedulers.Width :=
        INI.ReadInteger(Temp, 'Width', frmSchedulers.Width);
      frmSchedulers.Height :=
        INI.ReadInteger(Temp, 'Height', frmSchedulers.Height);
      frmSchedulers.pnlRight.Width :=
        INI.ReadInteger(Temp, 'pnlRight', frmSchedulers.pnlRight.Width);
      frmSchedulers.Position := poDesigned;
      frmSchedulers.Left := INI.ReadInteger(Temp, 'Left',
        (Screen.Width - frmSchedulers.Width) div 2);
      frmSchedulers.Top := INI.ReadInteger(Temp, 'Top',
        ((Screen.Height - frmSchedulers.Height) div 2) - 75);

      frmSchedulers.Hint := IntToStr(frmSchedulers.Width) +
        IntToStr(frmSchedulers.Height) + IntToStr(frmSchedulers.Left) +
        IntToStr(frmSchedulers.Top) + IntToStr(frmSchedulers.pnlRight.Width);

      // frmScheduler
      Temp := frmScheduler.Name + '_' + IntToStr(ExtendedScreenWidth);
      frmScheduler.Position := poDesigned;
      frmScheduler.Width := INI.ReadInteger(Temp, 'Width', frmScheduler.Width);
      frmScheduler.Height :=
        INI.ReadInteger(Temp, 'Height', frmScheduler.Height);
      frmScheduler.Left := INI.ReadInteger(Temp, 'Left',
        (Screen.Width - frmScheduler.Width) div 2);
      frmScheduler.Top := INI.ReadInteger(Temp, 'Top',
        ((Screen.Height - frmScheduler.Height) div 2) - 75);
      frmScheduler.pnlRight.Width :=
        INI.ReadInteger(Temp, 'pnlRight', frmScheduler.pnlRight.Width);

      frmScheduler.Hint := IntToStr(frmScheduler.Width) +
        IntToStr(frmScheduler.Height) + IntToStr(frmScheduler.Left) +
        IntToStr(frmScheduler.Top) + IntToStr(frmScheduler.pnlRight.Width);

      // frmSuccess
      Temp := frmSuccess.Name + '_' + IntToStr(ExtendedScreenWidth);
      frmSuccess.Position := poDesigned;
      frmSuccess.Left := INI.ReadInteger(Temp, 'Left', frmSuccess.Left);
      frmSuccess.Top := INI.ReadInteger(Temp, 'Top', frmSuccess.Top);
      frmSuccess.Width := INI.ReadInteger(Temp, 'Width', frmSuccess.Width);
      frmSuccess.Height := INI.ReadInteger(Temp, 'Height', frmSuccess.Height);

      frmSuccess.Hint := IntToStr(frmSuccess.Width) + IntToStr(frmSuccess.Height) +
        IntToStr(frmSuccess.Left) + IntToStr(frmSuccess.Top);

      // frmSettings
      Temp := frmSettings.Name + '_' + IntToStr(ExtendedScreenWidth);
      frmSettings.Position := poDesigned;
      frmSettings.Width := INI.ReadInteger(Temp, 'Width', frmSettings.Width);
      frmSettings.Height := INI.ReadInteger(Temp, 'Height', frmSettings.Height);
      frmSettings.Left := INI.ReadInteger(Temp, 'Left',
        (Screen.Width - frmSettings.Width) div 2);
      frmSettings.Top := INI.ReadInteger(Temp, 'Top',
        ((Screen.Height - frmSettings.Height) div 2) - 75);
      frmSettings.treSettings.Width :=
        INI.ReadInteger(Temp, 'pnlLeft', frmSettings.treSettings.Width);

      frmSettings.Hint := IntToStr(frmSettings.Width) +
        IntToStr(frmSettings.Height) + IntToStr(frmSettings.Left) +
        IntToStr(frmSettings.Top) + IntToStr(frmSettings.treSettings.Width);

      // frmTags
      Temp := frmTags.Name + '_' + IntToStr(ExtendedScreenWidth);
      frmTags.Position := poDesigned;
      frmTags.Width := INI.ReadInteger(Temp, 'Width', frmTags.Width);
      frmTags.Height := INI.ReadInteger(Temp, 'Height', frmTags.Height);
      frmTags.Left := INI.ReadInteger(Temp, 'Left',
        (Screen.Width - frmTags.Width) div 2);
      frmTags.Top := INI.ReadInteger(Temp, 'Top',
        ((Screen.Height - frmTags.Height) div 2) - 75);
      frmTags.pnlDetail.Width :=
        INI.ReadInteger(Temp, 'pnlRight', frmTags.pnlDetail.Width);

      frmTags.Hint := IntToStr(frmTags.Width) + IntToStr(frmTags.Height) +
        IntToStr(frmTags.Left) + IntToStr(frmTags.Top) +
        IntToStr(frmTags.pnlDetail.Width);

      // frmTemplates (for import)
      Temp := frmTemplates.Name + '_' + IntToStr(ExtendedScreenWidth);
      frmTemplates.Position := poDesigned;
      frmTemplates.Left :=
        INI.ReadInteger(frmTemplates.Name, 'Left', frmTemplates.Left);
      frmTemplates.Top := INI.ReadInteger(frmTemplates.Name, 'Top', frmTemplates.Top);
      frmTemplates.Width := INI.ReadInteger(frmTemplates.Name, 'Width',
        frmTemplates.Width);
      frmTemplates.Height :=
        INI.ReadInteger(frmTemplates.Name, 'Height', frmTemplates.Height);
      frmTemplates.pnlLeft.Width :=
        INI.ReadInteger(frmTemplates.Name, 'pnlLeft', frmTemplates.pnlLeft.Width);

      frmTemplates.Hint := IntToStr(frmTemplates.Width) +
        IntToStr(frmTemplates.Height) + IntToStr(frmTemplates.Left) +
        IntToStr(frmTemplates.Top) + IntToStr(frmTemplates.pnlLeft.Width);

      // frmValues
      Temp := frmValues.Name + '_' + IntToStr(ExtendedScreenWidth);
      frmValues.Position := poDesigned;
      frmValues.Width := INI.ReadInteger(Temp, 'Width', frmValues.Width);
      frmValues.Height := INI.ReadInteger(Temp, 'Height', frmValues.Height);
      frmValues.Left := INI.ReadInteger(Temp, 'Left',
        (Screen.Width - frmValues.Width) div 2);
      frmValues.Top := INI.ReadInteger(Temp, 'Top',
        ((Screen.Height - frmValues.Height) div 2) - 75);
      frmValues.pnlDetail.Width :=
        INI.ReadInteger(Temp, 'pnlRight', frmValues.pnlDetail.Width);

      frmValues.Hint := IntToStr(frmValues.Width) + IntToStr(frmValues.Height) +
        IntToStr(frmValues.Left) + IntToStr(frmValues.Top) +
        IntToStr(frmValues.pnlDetail.Width);

      // frmWrite
      Temp := frmWrite.Name + '_' + IntToStr(ExtendedScreenWidth);
      frmWrite.Position := poDesigned;
      frmWrite.Width := INI.ReadInteger(Temp, 'Width', frmWrite.Width);
      frmWrite.Height := INI.ReadInteger(Temp, 'Height', frmWrite.Height);
      frmWrite.Left := INI.ReadInteger(Temp, 'Left',
        (Screen.Width - frmWrite.Width) div 2);
      frmWrite.Top := INI.ReadInteger(Temp, 'Top',
        ((Screen.Height - frmWrite.Height) div 2) - 75);

      frmWrite.Hint := IntToStr(frmWrite.Width) + IntToStr(frmWrite.Height) +
        IntToStr(frmWrite.Left) + IntToStr(frmWrite.Top);

      // frmWriting
      Temp := frmWriting.Name + '_' + IntToStr(ExtendedScreenWidth);
      frmWriting.Position := poDesigned;
      frmWriting.Width := INI.ReadInteger(Temp, 'Width', frmWriting.Width);
      frmWriting.Height := INI.ReadInteger(Temp, 'Height', frmWriting.Height);
      frmWriting.Left := INI.ReadInteger(Temp, 'Left',
        (Screen.Width - frmWriting.Width) div 2);
      frmWriting.Top := INI.ReadInteger(Temp, 'Top',
        ((Screen.Height - frmWriting.Height) div 2) - 75);

      frmWriting.Hint := IntToStr(frmWriting.Width) + IntToStr(frmWriting.Height) +
        IntToStr(frmWriting.Left) + IntToStr(frmWriting.Top);
    end;

    if frmSplash.Visible = True then
    begin
      frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 2;
      frmSplash.Update;
      TimeLog[47, 0] := 'Open INI file 2';
      TimeLog[47, 1] := IntToStr(GetTickCount64 - TimeStart);
    end;

    // set columns width on all tables (manually or automatic) - THIS IS AFTER FORMS RESIZING !!!
    chkAutoColumnWidth.Checked :=
      INI.ReadBool('ON_START', 'TablesColumnsAutoWidth', True);
    if chkAutoColumnWidth.Checked = True then
    begin
      try
        frmAccounts.VSTResize(frmAccounts.VST);
        frmBudget.VSTResize(frmBudget.VST);
        frmBudgets.VSTBudgetsResize(frmBudgets.VSTBudgets);
        frmBudgets.VSTPeriodsResize(frmBudgets.VSTPeriods);
        frmCalendar.VSTResize(frmCalendar.VST);
        frmCategories.VSTResize(frmCategories.VST);
        frmComments.VSTResize(frmComments.VST);
        frmCurrencies.VSTResize(frmCurrencies.VST);
        frmDelete.VST1Resize(frmDelete.VST1);
        frmDelete.VST2Resize(frmDelete.VST2);
        frmDelete.VST3Resize(frmDelete.VST3);
        frmDetail.VSTResize(frmDetail.VST);
        frmHistory.VST1Resize(frmHistory.VST1);
        frmHistory.VST1Resize(frmHistory.VST2);
        frmHolidays.VSTResize(frmHolidays.VST);
        frmLinks.VSTResize(frmLinks.VST);
        frmMain.VSTBalanceResize(frmMain.VSTBalance);
        frmMain.VSTChronoResize(frmMain.VSTChrono);
        frmMain.VSTCrossResize(frmMain.VSTCross);
        frmMain.VSTResize(frmMain.VST);
        frmMain.VSTSummaryResize(frmMain.VSTSummary);
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
      except
      end;

    end
    else
    begin
      try
        // frmAccount
        SetColumnsWidth(frmAccounts.VST,
          INI.ReadString('COLUMNS_WIDTH', 'Accounts', ''));
        frmAccounts.VST.Parent.Hint := ReadColumnsWidth(frmAccounts.VST);

        // frmBudget
        SetColumnsWidth(frmBudget.VST, INI.ReadString('COLUMNS_WIDTH', 'Budget', ''));
        frmBudget.VST.Parent.Hint := ReadColumnsWidth(frmBudget.VST);

        // frmBudgets 1
        SetColumnsWidth(frmBudgets.VSTBudgets,
          INI.ReadString('COLUMNS_WIDTH', 'Budgets_1', ''));
        frmBudgets.VSTBudgets.Parent.Hint := ReadColumnsWidth(frmBudgets.VSTBudgets);

        // frmBudgets 2
        SetColumnsWidth(frmBudgets.VSTPeriods,
          INI.ReadString('COLUMNS_WIDTH', 'Budgets_2', ''));
        frmBudgets.VSTPeriods.Parent.Hint := ReadColumnsWidth(frmBudgets.VSTPeriods);

        // frmCalendar
        SetColumnsWidth(frmCalendar.VST, INI.ReadString('COLUMNS_WIDTH',
          'Calendar', ''));
        frmCalendar.VST.Parent.Hint := ReadColumnsWidth(frmCalendar.VST);

        // frmCategories
        SetColumnsWidth(frmCategories.VST, INI.ReadString('COLUMNS_WIDTH',
          'Categories', ''));
        frmCategories.VST.Parent.Hint := ReadColumnsWidth(frmCategories.VST);

        // frmComments
        SetColumnsWidth(frmComments.VST, INI.ReadString('COLUMNS_WIDTH',
          'Comments', ''));
        frmComments.VST.Parent.Hint := ReadColumnsWidth(frmComments.VST);

        // frmCurrencies
        SetColumnsWidth(frmCurrencies.VST, INI.ReadString('COLUMNS_WIDTH',
          'Currencies', ''));
        frmCurrencies.VST.Parent.Hint := ReadColumnsWidth(frmCurrencies.VST);

        // frmDelete 1
        SetColumnsWidth(frmDelete.VST1, INI.ReadString('COLUMNS_WIDTH', 'Delete_1', ''));
        frmDelete.VST1.Parent.Hint := ReadColumnsWidth(frmDelete.VST1);

        // frmDelete 2
        SetColumnsWidth(frmDelete.VST2, INI.ReadString('COLUMNS_WIDTH', 'Delete_2', ''));
        frmDelete.VST2.Parent.Hint := ReadColumnsWidth(frmDelete.VST2);

        // frmDelete 3
        SetColumnsWidth(frmDelete.VST3, INI.ReadString('COLUMNS_WIDTH', 'Delete_3', ''));
        frmDelete.VST3.Parent.Hint := ReadColumnsWidth(frmDelete.VST3);

        // frmDetail
        SetColumnsWidth(frmDetail.VST, INI.ReadString('COLUMNS_WIDTH', 'Detail', ''));
        frmDetail.VST.Parent.Hint := ReadColumnsWidth(frmDetail.VST);

        // frmHistory 1
        SetColumnsWidth(frmHistory.VST1, INI.ReadString('COLUMNS_WIDTH',
          'History_1', ''));
        frmHistory.VST1.Parent.Hint := ReadColumnsWidth(frmHistory.VST1);

        // frmHistory 2
        SetColumnsWidth(frmHistory.VST2, INI.ReadString('COLUMNS_WIDTH',
          'History_2', ''));
        frmHistory.VST2.Parent.Hint := ReadColumnsWidth(frmHistory.VST2);

        // frmHolidays
        SetColumnsWidth(frmHolidays.VST, INI.ReadString('COLUMNS_WIDTH',
          'Holidays', ''));
        frmHolidays.VST.Parent.Hint := ReadColumnsWidth(frmHolidays.VST);

        // frmLinks
        SetColumnsWidth(frmLinks.VST, INI.ReadString('COLUMNS_WIDTH', 'Links', ''));
        frmLinks.VST.Parent.Hint := ReadColumnsWidth(frmLinks.VST);

        // frmMain Transactions
        SetColumnsWidth(frmMain.VST, INI.ReadString('COLUMNS_WIDTH',
          'Transactions', ''));
        frmMain.VST.Parent.Hint := ReadColumnsWidth(frmMain.VST);

        // frmMain Balance
        SetColumnsWidth(frmMain.VSTBalance, INI.ReadString('COLUMNS_WIDTH',
          'Balance', ''));
        frmMain.VSTBalance.Parent.Hint := ReadColumnsWidth(frmMain.VSTBalance);

        // frmMain Chronology
        SetColumnsWidth(frmMain.VSTChrono, INI.ReadString('COLUMNS_WIDTH',
          'Chronology', ''));
        frmMain.VSTChrono.Parent.Hint := ReadColumnsWidth(frmMain.VSTChrono);

        // frmMain Cross table
        SetColumnsWidth(frmMain.VSTCross, INI.ReadString('COLUMNS_WIDTH',
          'CrossTable', ''));
        frmMain.VSTCross.Parent.Hint := ReadColumnsWidth(frmMain.VSTCross);

        // frmMain Summary
        SetColumnsWidth(frmMain.VSTSummary, INI.ReadString('COLUMNS_WIDTH',
          'Summary', ''));
        frmMain.VSTSummary.Parent.Hint := ReadColumnsWidth(frmMain.VSTSummary);

        // frmPayees
        SetColumnsWidth(frmPayees.VST, INI.ReadString('COLUMNS_WIDTH', 'Payees', ''));
        frmPayees.VST.Parent.Hint := ReadColumnsWidth(frmPayees.VST);

        // frmPeriod
        SetColumnsWidth(frmPeriod.VST, INI.ReadString('COLUMNS_WIDTH', 'Period', ''));
        frmPeriod.VST.Parent.Hint := ReadColumnsWidth(frmPeriod.VST);

        // frmPersons
        SetColumnsWidth(frmPersons.VST, INI.ReadString('COLUMNS_WIDTH', 'Persons', ''));
        frmPersons.VST.Parent.Hint := ReadColumnsWidth(frmPersons.VST);

        // frmRecycleBin
        SetColumnsWidth(frmRecycleBin.VST, INI.ReadString('COLUMNS_WIDTH',
          'RecycleBin', ''));
        frmRecycleBin.VST.Parent.Hint := ReadColumnsWidth(frmRecycleBin.VST);

        // frmScheduler 1
        SetColumnsWidth(frmSchedulers.VST, INI.ReadString('COLUMNS_WIDTH',
          'Schedulers_1', ''));
        frmSchedulers.VST.Parent.Hint := ReadColumnsWidth(frmSchedulers.VST);

        // frmScheduler 1
        SetColumnsWidth(frmSchedulers.VST1, INI.ReadString('COLUMNS_WIDTH',
          'Schedulers_2', ''));
        frmSchedulers.VST1.Parent.Hint := ReadColumnsWidth(frmSchedulers.VST1);

        // frmSettings
        SetColumnsWidth(frmSettings.VSTKeys, INI.ReadString('COLUMNS_WIDTH',
          'Settings', ''));
        frmSettings.VSTKeys.Parent.Hint := ReadColumnsWidth(frmSettings.VSTKeys);

        // frmTags
        SetColumnsWidth(frmTags.VST, INI.ReadString('COLUMNS_WIDTH', 'Tags', ''));
        frmTags.VST.Parent.Hint := ReadColumnsWidth(frmTags.VST);

        // frmValues
        SetColumnsWidth(frmValues.VST, INI.ReadString('COLUMNS_WIDTH', 'Values', ''));
        frmValues.VST.Parent.Hint := ReadColumnsWidth(frmValues.VST);

        // frmWrite
        SetColumnsWidth(frmWrite.VST, INI.ReadString('COLUMNS_WIDTH', 'Write', ''));
        frmWrite.VST.Parent.Hint := ReadColumnsWidth(frmWrite.VST);

      except
      end;
    end;

    if frmSplash.Visible = True then
    begin
      frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 2;
      frmSplash.Update;
      TimeLog[48, 0] := 'Open INI file 3';
      TimeLog[48, 1] := IntToStr(GetTickCount64 - TimeStart);
    end;


    try
      // ---------------------------------------------------------------------------
      // SHORTCUTS
      // ---------------------------------------------------------------------------
      // actions
      VSTKeys.Clear;
      VSTKeys.RootNodeCount := 0;
      VSTKeys.BeginUpdate;

      // -----------------------------------
      VSTKeys.RootNodeCount := VSTKeys.RootNodeCount + 1;
      Key := VSTKeys.GetNodeData(VSTKeys.GetLast());
      Key.action := 'record_add_simple';
      Key.shortcut := INI.ReadString('KEYS', Key.action, 'INS');
      UpdateShortCuts(key.action, TextToShortCut(Key.shortcut));

      //// -----------------------------------
      VSTKeys.RootNodeCount := VSTKeys.RootNodeCount + 1;
      Key := VSTKeys.GetNodeData(VSTKeys.GetLast());
      Key.action := 'record_add_multiple';
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

      // -----------------------------------
      VSTKeys.RootNodeCount := VSTKeys.RootNodeCount + 1;
      Key := VSTKeys.GetNodeData(VSTKeys.GetLast());
      Key.action := 'new_transaction_simple';
      Key.shortcut := INI.ReadString('KEYS', Key.action, 'F1');
      // ---------------------------------------------------------------------------
      UpdateShortCuts(key.action, TextToShortCut(Key.shortcut));

      // -----------------------------------
      VSTKeys.RootNodeCount := VSTKeys.RootNodeCount + 1;
      Key := VSTKeys.GetNodeData(VSTKeys.GetLast());
      Key.action := 'new_transaction_multiple';
      Key.shortcut := INI.ReadString('KEYS', Key.action, 'F2');
      // ---------------------------------------------------------------------------
      UpdateShortCuts(key.action, TextToShortCut(Key.shortcut));

      INI.Free;
      VSTKeys.EndUpdate;
      SetNodeHeight(VSTKeys);
    except
      on E: Exception do
      begin
        VSTKeys.EndUpdate;
        ShowErrorMessage(E);
        INI.Free;
      end;
    end;
    frmSettings.Tag := 2;
  end;

  if frmSplash.Visible = True then
  begin
    frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 2;
    frmSplash.Update;
    TimeLog[49, 0] := 'Close INI file';
    TimeLog[49, 1] := IntToStr(GetTickCount64 - TimeStart);
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
    TimeLog[50, 0] := 'Update language';
    TimeLog[50, 1] := IntToStr(GetTickCount64 - TimeStart);
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
  try
    UpdateSettings;
    TimeLog[51, 0] := 'Update settings';
    TimeLog[51, 1] := IntToStr(GetTickCount64 - TimeStart);
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
  {$IFDEF LINUX}
  chkDarkStyle.Enabled := False;
  {$ENDIF}
end;

procedure TfrmSettings.btnSaveClick(Sender: TObject);
var
  INI: TINIFile;
  INIFile, S: string;
  B: byte;
  Key: PKey;
  P: PVirtualNode;
begin
  // check if backup folder exists
  if (chkDoBackup.Checked = True) then
    if DirectoryExists(btnBackupFolder.Caption) = False then
    begin
      ShowMessage(AnsiReplaceStr(Caption_224, '%', sLineBreak));
      frmSettings.treSettings.Items[11].Selected := True;
      Exit;
    end;

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
    INI.WriteInteger('GLOBAL', 'DarkMode', IfThen(chkDarkStyle.Checked = True, 2, 0));

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
    INI.WriteBool('ON_START', 'OpenLastFilterDate', chkLastUsedFilterDate.Checked);
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
    INI.WriteBool('VISUAL_SETTINGS', 'RedColoredButtonDelete',
      chkRedColorButtonDelete.Checked);
    INI.WriteInteger('VISUAL_SETTINGS', 'ButtonsSize',
      IfThen(rbtButtonsSize24.Checked = True, 24, 32));

    S := '';
    for B := 0 to chkButtonsVisibility.Items.Count - 1 do
      S := S + IfThen(chkButtonsVisibility.Checked[B] = True, '1', '0');
    INI.WriteString('VISUAL_SETTINGS', 'ButtonsVisibility', S);
    INI.WriteBool('VISUAL_SETTINGS', 'FilterComboboxStyle',
      chkFilterComboboxStyle.Checked);


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
    INI.WriteBool('TRANSACTIONS', 'RememberNewTransactionsForm',
      chkRememberNewTransactionsForm.Checked);
    INI.WriteBool('TRANSACTIONS', 'ItemsFromFilter', chkItemsFromFilter.Checked);

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
    INI.WriteBool('BACKUP', 'ConfirmDialog', chkBackupQuestion.Checked);

    // ---------------------------------------------------
    INI.WriteBool('ON_CLOSE', 'ConfirmDialog', chkCloseDbWarning.Checked);
    INI.WriteBool('ON_CLOSE', 'EncryptDatabase', chkEncryptDatabase.Checked);
    frmProperties.lblEncryptionProtection.Tag :=
      Abs(StrToInt(BoolToStr(chkEncryptDatabase.Checked)));


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

procedure TfrmSettings.btnTimeStampClick(Sender: TObject);
begin
  frmTimeStamp.ShowModal;
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
    frmDetail.VST.Font.Name := cbxGridFontName.Items[cbxGridFontName.ItemIndex];
    frmHistory.VST1.Font.Name := cbxGridFontName.Items[cbxGridFontName.ItemIndex];
    frmHistory.VST2.Font.Name := cbxGridFontName.Items[cbxGridFontName.ItemIndex];
    frmHolidays.VST.Font.Name := cbxGridFontName.Items[cbxGridFontName.ItemIndex];
    frmLinks.VST.Font.Name := cbxGridFontName.Items[cbxGridFontName.ItemIndex];
    frmMain.VST.Font.Name := cbxGridFontName.Items[cbxGridFontName.ItemIndex];
    frmMain.VSTBalance.Font.Name := cbxGridFontName.Items[cbxGridFontName.ItemIndex];
    frmMain.VSTChrono.Font.Name := cbxGridFontName.Items[cbxGridFontName.ItemIndex];
    frmMain.VSTCross.Font.Name := cbxGridFontName.Items[cbxGridFontName.ItemIndex];
    frmMain.VSTSummaries.Font.Name := cbxGridFontName.Items[cbxGridFontName.ItemIndex];
    frmMain.VSTSummary.Font.Name := cbxGridFontName.Items[cbxGridFontName.ItemIndex];
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
    frmTimeStamp.VST.Font.Name := cbxGridFontName.Items[cbxGridFontName.ItemIndex];
    frmValues.VST.Font.Name := cbxGridFontName.Items[cbxGridFontName.ItemIndex];
    frmWrite.VST.Font.Name := cbxGridFontName.Items[cbxGridFontName.ItemIndex];
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmSettings.chkButtonsVisibilityClickCheck(Sender: TObject);
var
  I: byte;
  ShowToolBar: boolean;
begin
  frmMain.tooMenu.BeginUpdateBounds;
  frmMain.tooMenu.Controls[chkButtonsVisibility.ItemIndex].Visible :=
    chkButtonsVisibility.Checked[chkButtonsVisibility.ItemIndex];

  ShowToolBar := False;
  for I := frmMain.tooMenu.ControlCount - 1 downto 0 do
  begin
    frmMain.tooMenu.Controls[I].Left := 0;
    if chkButtonsVisibility.Checked[I] = True then
      ShowToolBar := True;
  end;
  frmMain.tooMenu.Visible := ShowToolBar;
  frmMain.tooMenu.EndUpdateBounds;
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

procedure TfrmSettings.chkDarkStyleClick(Sender: TObject);
begin

  if (frmSettings.Visible = True) and (chkDarkStyle.Tag < 2) then
    ShowMessage(Message_08);
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

procedure TfrmSettings.chkEncryptDatabaseChange(Sender: TObject);
var
  Temp: string;
begin
  if (frmMain.Conn.Connected = True) and
    (frmSettings.chkEncryptDatabase.Checked = True) then
  begin
    // check if database is protected by password
    frmMain.QRY.SQL.Text :=
      'SELECT set_value FROM settings WHERE set_parameter = "password"';
    frmMain.QRY.Open;
    Temp := frmMain.QRY.Fields[0].AsString;
    frmMain.QRY.Close;
    if Length(Temp) = 0 then
      if MessageDlg(Application.Title, AnsiReplaceStr(Question_28, '%', sLineBreak),
        mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        frmPassword.ShowModal;
  end;
end;

procedure TfrmSettings.chkFilterComboboxStyleChange(Sender: TObject);
begin
  if chkFilterComboboxStyle.Checked = True then
  begin
    frmMain.cbxPerson.Style := csDropDown;
    frmMain.cbxPayee.Style := csDropDown;
    frmMain.cbxAccount.Style := csDropDown;
    frmMain.cbxCategory.Style := csDropDown;
    frmMain.cbxSubcategory.Style := csDropDown;
    //    frmMain.cbxCurrency.Style := csDropDown;
  end
  else
  begin
    frmMain.cbxPerson.Style := csDropDownList;
    frmMain.cbxPayee.Style := csDropDownList;
    frmMain.cbxAccount.Style := csDropDownList;
    frmMain.cbxCategory.Style := csDropDownList;
    frmMain.cbxSubcategory.Style := csDropDownList;
    //    frmMain.cbxCurrency.Style := csDropDownList;
  end;
end;

procedure TfrmSettings.chkSelectAllChange(Sender: TObject);
var
  I: byte;
begin
  if chkSelectAll.Checked = True then
  begin
    chkButtonsVisibility.CheckAll(cbChecked, False, False);
    frmMain.tooMenu.Visible := True;
  end
  else
  begin
    chkButtonsVisibility.CheckAll(cbUnchecked, False, False);
    frmMain.tooMenu.Visible := False;
  end;
  for I := 0 to chkButtonsVisibility.Items.Count - 1 do
    frmMain.tooMenu.Controls[I].Visible := chkButtonsVisibility.Checked[I];
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
  gbxTransactionsAdd.Width := (tabTransactionsRestrictions.Width - 12) div 3;
  gbxTransactionsEdit.Width := gbxTransactionsAdd.Width;
end;

procedure TfrmSettings.lblTransactionsAddDateClick(Sender: TObject);
begin
  try
    if (Panels.PageIndex = 3) and (tabTransactions.TabIndex = 1) then
      datTransactionsAddDate.SetFocus;
  except
  end;
end;

procedure TfrmSettings.lblTransactionsDeleteDateClick(Sender: TObject);
begin
  try
    if (Panels.PageIndex = 3) and (tabTransactions.TabIndex = 1) then
      datTransactionsDeleteDate.SetFocus;
  except
  end;
end;

procedure TfrmSettings.lblTransactionsEditDateClick(Sender: TObject);
begin
  try
    if (Panels.PageIndex = 3) and (tabTransactions.TabIndex = 1) then
      datTransactionsEditDate.SetFocus;
  except
  end;
end;

procedure TfrmSettings.rbtButtonsSize24Change(Sender: TObject);
var
  I: byte;
  Img: TImageList;
begin
  if (Panels.PageIndex = 2) and (tabVisualSettings.TabIndex <> 2) then
    Exit;

  if TRadioButton(Sender).Checked = False then
    Exit;

  frmMain.tooMenu.Height := Round(TRadioButton(Sender).Tag * 1.5 * (ScreenRatio / 100));


  if TRadioButton(Sender).Tag = 24 then
    Img := frmMain.img24
  else
    Img := frmMain.img32;

  for I := 0 to frmMain.tooMenu.ControlCount - 1 do
    TSpeedButton(frmMain.tooMenu.Controls[I]).Images := Img;
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
    SetNodeHeight(frmDetail.VST);
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
  I: integer;
  N: PVirtualNode;
  Lang: PLang;
begin
  Screen.Cursor := crHourGlass;

  try
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

    if (Panels.PageIndex = 0) and (tabGlobal.TabIndex = 0) then
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
    chkRedColorButtonDelete.Tag := IfThen(chkRedColorButtonDelete.Checked = True, 1, 0);
    pnlButtonsSize.Tag := IfThen(rbtButtonsSize24.Checked = True, 24, 32);
    chkDarkStyle.Tag := IfThen(chkDarkStyle.Checked = True, 1, 0);

    chkButtonsVisibility.Hint := '';
    for I := 0 to chkButtonsVisibility.Items.Count - 1 do
      chkButtonsVisibility.Hint :=
        chkButtonsVisibility.Hint + IfThen(chkButtonsVisibility.Checked[I] =
        True, '1', '0');
    chkFilterComboboxStyle.Tag := IfThen(chkFilterComboboxStyle.Checked = True, 1, 0);

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
    chkRememberNewTransactionsForm.Tag :=
      IfThen(chkRememberNewTransactionsForm.Checked = True, 1, 0);
    datTransactionsAddDateChange(datTransactionsAddDate);
    datTransactionsEditDateChange(datTransactionsEditDate);
    datTransactionsDeleteDateChange(datTransactionsDeleteDate);
    chkItemsFromFilter.Tag := IfThen(chkItemsFromFilter.Checked = True, 1, 0);

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
    chkLastUsedFilterDate.Tag := IfThen(chkLastUsedFilterDate.Checked = True, 1, 0);

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

    frmMain.VSTEnergy.Hint := '';
    for I := 1 to frmMain.VSTEnergy.Header.Columns.Count - 1 do
      frmMain.VSTEnergy.Hint :=
        frmMain.VSTEnergy.Hint + IntToStr(frmMain.VSTEnergy.Header.Columns[I].Width) +
        IfThen(I < frmMain.VSTEnergy.Header.Columns.Count - 1, separ, '');

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
    chkBackupQuestion.Tag := IfThen(chkBackupQuestion.Checked = True, 1, 0);

    // on close
    chkCloseDbWarning.Tag := IfThen(chkCloseDbWarning.Checked = True, 1, 0);
    chkEncryptDatabase.Tag := IfThen(chkEncryptDatabase.Checked = True, 1, 0);

    SetNodeHeight(VSTLang);
    Screen.Cursor := crDefault;
    //    ShowMessage(IntToStr(treSettings.Width));
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
  chkBackupQuestion.Visible := chkDoBackup.Checked;

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
    frmMain.VSTEnergyResize(frmMain.VSTEnergy);
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

    // Report - Energy columns width
    for I := 1 to frmMain.VSTEnergy.Header.Columns.Count - 1 do
      frmMain.VSTEnergy.Header.Columns[I].Width :=
        StrToInt(Field(separ, frmMain.VSTEnergy.Hint, I));
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

    // repaint list in forms
    frmMain.VST.Repaint;

    if frmSchedulers.Visible = True then
    begin
      frmSchedulers.VST.Repaint;
      frmSchedulers.VST1.Repaint;
    end;
    if frmDetail.Visible = True then
      frmDetail.VST.Repaint;
    if frmWrite.Visible = True then
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
    frmMain.VSTSummaries.Repaint;
    frmMain.VSTBalance.Repaint;
    frmMain.VSTChrono.Repaint;
    frmMain.VSTCross.Repaint;
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

        // new transaction
        45: Key.shortcut := 'F1';
        46: Key.shortcut := 'F2';
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
  S: string;
  ShowToolBar: boolean;
begin
  // get back all temporarely settings
  try
    // ----------------------------------------------------------------------------
    // global settings
    // ----------------------------------------------------------------------------


    if VSTLang.SelectedCount > 0 then
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

    // chkDarkStyle
    if BoolToStr(chkDarkStyle.Checked) <> IntToStr(chkDarkStyle.Tag) then
    begin
      chkDarkStyle.Tag := 2;
      chkDarkStyle.Checked := StrToBool(IntToStr(chkDarkStyle.Tag));
    end;

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

    // chkRedColorButtonDelete
    if BoolToStr(chkRedColorButtonDelete.Checked) <>
      IntToStr(chkRedColorButtonDelete.Tag) then
      chkRedColorButtonDelete.Checked :=
        StrToBool(IntToStr(chkRedColorButtonDelete.Tag));

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

    // frmMain buttons size
    if (pnlButtonsSize.Tag = 24) and (rbtButtonsSize24.Checked = False) then
      rbtButtonsSize24.Checked := True
    else if (pnlButtonsSize.Tag = 32) and (rbtButtonsSize32.Checked = False) then
      rbtButtonsSize32.Checked := True;

    // frmMain buttons visibility
    S := '';
    for I := 0 to chkButtonsVisibility.Items.Count - 1 do
      S := S + IfThen(chkButtonsVisibility.Checked[I] = True, '1', '0');
    if S <> chkButtonsVisibility.Hint then
    begin
      ShowToolBar := False;
      for I := 0 to chkButtonsVisibility.Items.Count - 1 do
      begin
        chkButtonsVisibility.Checked[I] :=
          StrToBool(MidStr(chkButtonsVisibility.Hint, I + 1, 1));
        frmMain.tooMenu.Controls[I].Visible := chkButtonsVisibility.Checked[I];
        if chkButtonsVisibility.Checked[I] = True then
          ShowToolBar := True;
      end;
      frmMain.tooMenu.Visible := ShowToolBar;
      chkSelectAll.Checked := ShowToolBar;
    end;

    // chkFilterComboboxStyle
    if BoolToStr(chkFilterComboboxStyle.Checked) <>
      IntToStr(chkFilterComboboxStyle.Tag) then
      chkFilterComboboxStyle.Checked := StrToBool(IntToStr(chkFilterComboboxStyle.Tag));

    // ----------------------------------------------------------------------------
    // on start settings
    // ----------------------------------------------------------------------------

    // chkLastUsedFile
    if BoolToStr(chkLastUsedFile.Checked) <> IntToStr(chkLastUsedFile.Tag) then
      chkLastUsedFile.Checked := StrToBool(IntToStr(chkLastUsedFile.Tag));

    // chkLastFormsSize
    if BoolToStr(chkLastFormsSize.Checked) <> IntToStr(chkLastFormsSize.Tag) then
      chkLastFormsSize.Checked := StrToBool(IntToStr(chkLastFormsSize.Tag));

    // chkLastUsedFilter
    if BoolToStr(chkLastUsedFilter.Checked) <> IntToStr(chkLastUsedFilter.Tag) then
      chkLastUsedFilter.Checked := StrToBool(IntToStr(chkLastUsedFilter.Tag));

    // chkLastUsedFilterDate
    if BoolToStr(chkLastUsedFilterDate.Checked) <>
      IntToStr(chkLastUsedFilterDate.Tag) then
      chkLastUsedFilterDate.Checked := StrToBool(IntToStr(chkLastUsedFilterDate.Tag));

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

    // report / energy columns width
    for I := 1 to frmMain.VSTEnergy.Header.Columns.Count - 1 do
      frmMain.VSTEnergy.Header.Columns[I].Width :=
        StrToInt(Field(separ, frmMain.VSTEnergy.Hint, I));

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

    // chkRememberNewTransactionsForm
    if BoolToStr(chkRememberNewTransactionsForm.Checked) <>
      IntToStr(chkRememberNewTransactionsForm.Tag) then
      chkRememberNewTransactionsForm.Checked :=
        StrToBool(IntToStr(chkRememberNewTransactionsForm.Tag));

    // chkitemsFromFilter
    if BoolToStr(chkItemsFromFilter.Checked) <>
      IntToStr(chkItemsFromFilter.Tag) then
      chkItemsFromFilter.Checked := StrToBool(IntToStr(chkItemsFromFilter.Tag));

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

    if BoolToStr(chkBackupQuestion.Checked) <> IntToStr(chkBackupQuestion.Tag) then
      chkBackupQuestion.Checked := StrToBool(IntToStr(chkBackupQuestion.Tag));

    // on close
    if BoolToStr(chkCloseDbWarning.Checked) <> IntToStr(chkCloseDbWarning.Tag) then
      chkCloseDbWarning.Checked := StrToBool(IntToStr(chkCloseDbWarning.Tag));
    if BoolToStr(chkEncryptDatabase.Checked) <> IntToStr(chkEncryptDatabase.Tag) then
      chkEncryptDatabase.Checked := StrToBool(IntToStr(chkEncryptDatabase.Tag));

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
      ediThousandSeparator.SelectAll;

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

procedure TfrmSettings.tabTransactionsRestrictionsResize(Sender: TObject);
begin
  gbxTransactionsAdd.Width := (tabTransactionsRestrictions.Width - 12) div 3;
  gbxTransactionsEdit.Width := (tabTransactionsRestrictions.Width - 12) div 3;
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
            if (tabGlobal.TabIndex = 0) and (frmSettings.Visible = True) then
              VSTLang.SetFocus;
          end;
          2: Panels.PageIndex := 1; // on run
          3: Panels.PageIndex := 2; // visual
          4: Panels.PageIndex := 3; // transactions
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

procedure TfrmSettings.VSTKeysPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
begin
  TargetCanvas.Font.Color := IfThen(Dark = False, clDefault, clSilver);
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
  TargetCanvas.Brush.Color := // color
    IfThen(Node.Index mod 2 = 0, // odd row
    IfThen(Dark = False, clWhite, rgbToColor(22, 22, 22)),
    IfThen(Dark = False, frmSettings.pnlOddRowColor.Color,
    Brighten(frmSettings.pnlOddRowColor.Color, 44)));
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
  try
    VSTLang.Header.Columns[0].Width := round(ScreenRatio / 100 * 32);
    X := (VSTLang.Width - VSTLang.Header.Columns[0].Width) div 100;
    VSTLang.Header.Columns[1].Width := 12 * X; // code
    VSTLang.Header.Columns[2].Width := 25 * X; // language
    VSTLang.Header.Columns[3].Width := 30 * X; // author
    VSTLang.Header.Columns[4].Width :=
      VSTLang.Width - VSTLang.Header.Columns[0].Width - ScrollBarWidth - (67 * X);
    // comment
  except
  end;
end;

procedure UpdateSettings;
begin
  try
    screen.Cursor := crHourGlass;
    FullColor := frmSettings.btnCaptionColorBack.Tag;
    BrightenColor := Brighten(FullColor, 234);

    // Forms color
    {$IFDEF WINDOWS}
    If (Dark = False) then
    begin
      frmDetail.Color := $00DEDEDE; // gray
      frmEdit.Color := frmDetail.Color;
      frmEdits.Color := frmDetail.Color;
      frmScheduler.Color := frmDetail.Color;
      frmMain.pnlFilter.Color := frmDetail.Color;
      frmSQL.Color := frmDetail.Color;
      frmPlan.Color := frmDetail.Color;
    end;
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
    frmMain.chaPie.BackColor :=
      IfThen(Dark = False, BrightenColor, rgbToColor(44, 44, 44));
    //frmMain.chaBalance.BackColor := RGBToColor(222,222,222);

    // ===============================================================================
    // frmEdit
    // ===============================================================================
    SetBtnProperty(frmEdit.btnSave);
    SetBtnProperty(frmEdit.btnCancel);
    SetBtnProperty(frmEdit.btnAttachmentAdd);
    SetBtnProperty(frmEdit.btnAttachmentEdit);
    SetBtnProperty(frmEdit.btnAttachmentDelete);
    SetBtnProperty(frmEdit.btnAttachmentOpen);

    // ===============================================================================
    // frmEdits
    // ===============================================================================
    SetPanelProperty(frmEdits.pnlEditCaption);
    SetBtnProperty(frmEdits.btnReset);
    SetBtnProperty(frmEdits.btnSave);
    SetBtnProperty(frmEdits.btnCancel);

    // ===============================================================================
    // frmDetail buttons
    // ===============================================================================
    // panels
    SetPanelProperty(frmDetail.pnlBasicCaption);
    SetPanelProperty(frmDetail.pnlListCaption);
    SetPanelProperty(frmDetail.pnlDetailCaption);

    // buttons
    SetBtnProperty(frmDetail.btnCancel);
    SetBtnProperty(frmDetail.btnSave);
    SetBtnProperty(frmDetail.btnSettings);
    SetBtnProperty(frmDetail.btnDelete);
    SetBtnProperty(frmDetail.btnCancelX);
    SetBtnProperty(frmDetail.btnSaveX);
    SetBtnProperty(frmDetail.btnCancel);
    SetBtnProperty(frmDetail.btnAdd);
    SetBtnProperty(frmDetail.btnEdit);
    SetBtnProperty(frmDetail.btnSelect);
    SetBtnProperty(frmDetail.btnDuplicate);
    SetBtnProperty(frmDetail.btnAttachmentAdd);
    SetBtnProperty(frmDetail.btnAttachmentEdit);
    SetBtnProperty(frmDetail.btnAttachmentDelete);
    SetBtnProperty(frmDetail.btnAttachmentOpen);

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

    {frmCurrencies.btnValues.StyleNormal.Color := FullColor;
    frmCurrencies.btnValues.StyleNormal.TextColor := frmSettings.btnCaptionColorFont.Tag;
    frmCurrencies.btnValues.StyleHover.Color := frmSettings.btnCaptionColorFont.Tag;
    frmCurrencies.btnValues.StyleHover.TextColor := FullColor;}

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
    SetBtnProperty(frmSQL.btnDiagram);

    // ===============================================================================
    // frmSQL buttons
    // ===============================================================================
    // panels

    // buttons
    SetBtnProperty(frmImage.btnExit);
    SetBtnProperty(frmImage.btnCopy);

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
    // frmTimeStamp buttons
    // ===============================================================================
    // buttons
    SetBtnProperty(frmTimeStamp.btnExit);

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
    SetBtnProperty(frmSchedulers.btnPopPrint);

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
    Sender.StyleHover.TextColor := frmSettings.btnCaptionColorFont.Tag;
    Sender.Font.Bold := frmSettings.chkBoldFont.Checked;

    // background color
    Sender.StyleDisabled.Color :=
      ifThen(Dark = False, clWhite, clDkGray);

    if (frmSettings.chkRedColorButtonDelete.Checked = True) and
      ((Sender.Tag = 12345)) then
    begin
      Sender.StyleNormal.Color :=
        ifThen(Dark = False, clRed, clMaroon);
      Sender.StyleHover.Color := ifThen(Dark = False, clMaroon, clRed);
    end
    else
    begin
      Sender.StyleNormal.Color :=
        ifThen(Dark = False, Brighten(FullColor, 60), Brighten(FullColor, 50));
      Sender.StyleHover.Color := FullColor;
    end;

    // font color
    Sender.StyleNormal.TextColor := clWhite;

    Sender.StyleDisabled.Color :=
      ifThen(Dark = False, clWhite, clDkGray);
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
      frmMain.actAddSimple.ShortCut := S;
      frmMain.popAdd.ShortCut := S;
      frmMain.btnAdd.Hint := Hint_01 + ':' + sLineBreak + Caption_319 +
        ' [' + ShortCutToText(frmMain.popAdd.ShortCut) + ']' + sLineBreak +
        Caption_320 + ' [' + frmMain.pnlButtons.Hint + ']';
      frmHolidays.actAdd.ShortCut := S;
      frmHolidays.popAdd.ShortCut := S;
      frmHolidays.btnAdd.Hint := Hint_01 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmComments.actAdd.ShortCut := S;
      frmComments.popAdd.ShortCut := S;
      frmComments.btnAdd.Hint := frmHolidays.btnAdd.Hint;
      frmTags.actAdd.ShortCut := S;
      frmTags.popAdd.ShortCut := S;
      frmTags.btnAdd.Hint := frmHolidays.btnAdd.Hint;
      frmCurrencies.actAdd.ShortCut := S;
      frmCurrencies.popAdd.ShortCut := S;
      frmCurrencies.btnAdd.Hint := frmHolidays.btnAdd.Hint;
      frmPayees.actAdd.ShortCut := S;
      frmPayees.popAdd.ShortCut := S;
      frmPayees.btnAdd.Hint := frmHolidays.btnAdd.Hint;
      frmAccounts.actAdd.ShortCut := S;
      frmAccounts.popAdd.ShortCut := S;
      frmAccounts.btnAdd.Hint := frmHolidays.btnAdd.Hint;
      frmCategories.actAdd.ShortCut := S;
      frmCategories.popAdd.ShortCut := S;
      frmCategories.btnAdd.Hint := frmHolidays.btnAdd.Hint;
      frmPersons.actAdd.ShortCut := S;
      frmPersons.popAdd.ShortCut := S;
      frmPersons.btnAdd.Hint := frmHolidays.btnAdd.Hint;
      frmSchedulers.actAdd.ShortCut := S;
      frmSchedulers.popAdd.ShortCut := S;
      frmSchedulers.popAdd1.ShortCut := S;
      frmSchedulers.btnAdd.Hint := frmHolidays.btnAdd.Hint;
      frmSchedulers.btnAdd1.Hint := frmHolidays.btnAdd.Hint;
      frmBudgets.actBudgetAdd.ShortCut := S;
      frmBudgets.popBudgetAdd.ShortCut := S;
      frmBudgets.btnBudgetAdd.Hint := frmHolidays.btnAdd.Hint;
      frmDetail.actAdd.ShortCut := S;
      frmDetail.popAdd.ShortCut := S;
      frmDetail.btnAdd.Hint := frmHolidays.btnAdd.Hint;
      frmTemplates.actAdd.ShortCut := S;
      frmTemplates.btnAdd.Hint := frmHolidays.btnAdd.Hint;
      frmLinks.actAdd.ShortCut := S;
      frmLinks.popAdd.ShortCut := S;
      frmLinks.btnAdd.Hint := frmHolidays.btnAdd.Hint;
    end
    // ------------------------------------------------------------------------
    else if Action = 'record_add_multiple' then
    begin
      frmMain.actAddMultiple.ShortCut := S;
      frmMain.popAddMulti.ShortCut := S;
      frmMain.pnlButtons.Hint := ShortCutToText(S);
      frmMain.btnAdd.Hint := Hint_01 + ':' + sLineBreak + Caption_319 +
        ' [' + ShortCutToText(frmMain.popAdd.ShortCut) + ']' + sLineBreak +
        Caption_320 + ' [' + frmMain.pnlButtons.Hint + ']';
    end
    // ------------------------------------------------------------------------
    else if Action = 'record_edit' then
    begin
      frmMain.actEdit.ShortCut := S;
      frmMain.popEdit.ShortCut := S;
      frmMain.btnEdit.Hint := Hint_02 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmHolidays.actEdit.ShortCut := S;
      frmHolidays.popEdit.ShortCut := S;
      frmHolidays.btnEdit.Hint := frmMain.btnEdit.Hint;
      frmComments.actEdit.ShortCut := S;
      frmComments.popEdit.ShortCut := S;
      frmComments.btnEdit.Hint := frmMain.btnEdit.Hint;
      frmTags.actEdit.ShortCut := S;
      frmTags.popEdit.ShortCut := S;
      frmTags.btnEdit.Hint := frmMain.btnEdit.Hint;
      frmCurrencies.actEdit.ShortCut := S;
      frmCurrencies.popEdit.ShortCut := S;
      frmCurrencies.btnEdit.Hint := frmMain.btnEdit.Hint;
      frmPayees.actEdit.ShortCut := S;
      frmPayees.popEdit.ShortCut := S;
      frmPayees.btnEdit.Hint := frmMain.btnEdit.Hint;
      frmAccounts.actEdit.ShortCut := S;
      frmAccounts.popEdit.ShortCut := S;
      frmAccounts.btnEdit.Hint := frmMain.btnEdit.Hint;
      frmCategories.actEdit.ShortCut := S;
      frmCategories.popEdit.ShortCut := S;
      frmCategories.btnEdit.Hint := frmMain.btnEdit.Hint;
      frmPersons.actEdit.ShortCut := S;
      frmPersons.popEdit.ShortCut := S;
      frmPersons.btnEdit.Hint := frmMain.btnEdit.Hint;
      frmSchedulers.actEdit.ShortCut := S;
      frmSchedulers.popEdit1.ShortCut := S;
      frmSchedulers.btnEdit1.Hint := frmMain.btnEdit.Hint;
      frmBudgets.actBudgetEdit.ShortCut := S;
      frmBudgets.popBudgetEdit.ShortCut := S;
      frmBudgets.btnBudgetEdit.Hint := frmMain.btnEdit.Hint;
      frmWrite.actEdit.ShortCut := S;
      frmWrite.popEdit.ShortCut := S;
      frmWrite.btnEdit.Hint := frmMain.btnEdit.Hint;
      frmSettings.btnChange.Hint := frmMain.btnEdit.Hint;
      frmSettings.actChange.ShortCut := S;
      frmRecycleBin.actEdit.ShortCut := S;
      frmRecycleBin.btnEdit.Hint := frmMain.btnEdit.Hint;
      frmDetail.actEdit.ShortCut := S;
      frmDetail.popEdit.ShortCut := S;
      frmDetail.btnEdit.Hint := frmMain.btnEdit.Hint;
      frmCalendar.actEdit.ShortCut := S;
      frmCalendar.btnEdit.Hint := frmMain.btnEdit.Hint;
      frmTemplates.actEdit.ShortCut := S;
      frmTemplates.btnEdit.Hint := frmMain.btnEdit.Hint;
      frmLinks.actEdit.ShortCut := S;
      frmLinks.popEdit.ShortCut := S;
      frmLinks.btnEdit.Hint := frmMain.btnEdit.Hint;

    end
    // ------------------------------------------------------------------------
    else if Action = 'record_duplicate' then
    begin
      frmMain.actDuplicate.ShortCut := S;
      frmMain.popDuplicate.ShortCut := S;
      frmMain.btnDuplicate.Hint := Hint_18 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmDetail.actDuplicate.ShortCut := S;
      frmDetail.popDuplicate.ShortCut := S;
      frmDetail.btnDuplicate.Hint := frmMain.btnDuplicate.Hint;
      frmBudgets.actBudgetDuplicate.ShortCut := S;
      frmBudgets.popBudgetDuplicate.ShortCut := S;
      frmBudgets.btnBudgetDuplicate.Hint := frmMain.btnDuplicate.Hint;
    end
    // ------------------------------------------------------------------------
    else if Action = 'record_delete' then
    begin
      frmMain.actDelete.ShortCut := S;
      frmMain.popDelete.ShortCut := S;
      frmMain.btnDelete.Hint := Hint_03 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmHolidays.actDelete.ShortCut := S;
      frmHolidays.popDelete.ShortCut := S;
      frmHolidays.btnDelete.Hint := frmMain.btnDelete.Hint;
      frmComments.actDelete.ShortCut := S;
      frmComments.popDelete.ShortCut := S;
      frmComments.btnDelete.Hint := frmMain.btnDelete.Hint;
      frmTags.actDelete.ShortCut := S;
      frmTags.popDelete.ShortCut := S;
      frmTags.btnDelete.Hint := frmMain.btnDelete.Hint;
      frmCurrencies.actDelete.ShortCut := S;
      frmCurrencies.popDelete.ShortCut := S;
      frmCurrencies.btnDelete.Hint := frmMain.btnDelete.Hint;
      frmPayees.actDelete.ShortCut := S;
      frmPayees.popDelete.ShortCut := S;
      frmPayees.btnDelete.Hint := frmMain.btnDelete.Hint;
      frmAccounts.actDelete.ShortCut := S;
      frmAccounts.popDelete.ShortCut := S;
      frmAccounts.btnDelete.Hint := frmMain.btnDelete.Hint;
      frmCategories.actDelete.ShortCut := S;
      frmCategories.popDelete.ShortCut := S;
      frmCategories.btnDelete.Hint := frmMain.btnDelete.Hint;
      frmPersons.actDelete.ShortCut := S;
      frmPersons.popDelete.ShortCut := S;
      frmPersons.btnDelete.Hint := frmMain.btnDelete.Hint;
      frmSchedulers.actDelete.ShortCut := S;
      frmSchedulers.popDelete.ShortCut := S;
      frmSchedulers.btnDelete.Hint := frmMain.btnDelete.Hint;
      frmBudgets.actBudgetDelete.ShortCut := S;
      frmBudgets.popBudgetDelete.ShortCut := S;
      frmBudgets.btnBudgetDelete.Hint := frmMain.btnDelete.Hint;
      frmWrite.actDelete.ShortCut := S;
      frmWrite.popDelete.ShortCut := S;
      frmWrite.btnDelete.Hint := frmMain.btnDelete.Hint;
      frmRecycleBin.actDelete.ShortCut := S;
      frmRecycleBin.btnDelete.Hint := frmMain.btnDelete.Hint;
      frmDetail.actDelete.ShortCut := S;
      frmDetail.popDelete.ShortCut := S;
      frmDetail.btnDelete.Hint := frmMain.btnDelete.Hint;
      frmCalendar.actDelete.ShortCut := S;
      frmCalendar.btnDelete.Hint := frmMain.btnDelete.Hint;
      frmTemplates.actDelete.ShortCut := S;
      frmTemplates.btnDelete.Hint := frmMain.btnDelete.Hint;
      frmLinks.actDelete.ShortCut := S;
      frmLinks.popDelete.ShortCut := S;
      frmLinks.btnDelete.Hint := frmMain.btnDelete.Hint;
    end
    // ------------------------------------------------------------------------
    else if Action = 'record_copy_all' then
    begin
      frmMain.actCopy.ShortCut := S;
      frmMain.popCopy.ShortCut := S;
      frmMain.btnCopy.Hint := Hint_09 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmMain.btnReportCopy.Hint := frmMain.btnCopy.Hint;
      frmHolidays.actCopy.ShortCut := S;
      frmHolidays.popCopy.ShortCut := S;
      frmHolidays.btnCopy.Hint := frmMain.btnCopy.Hint;
      frmComments.actCopy.ShortCut := S;
      frmComments.popCopy.ShortCut := S;
      frmComments.btnCopy.Hint := frmMain.btnCopy.Hint;
      frmTags.actCopy.ShortCut := S;
      frmTags.popCopy.ShortCut := S;
      frmTags.btnCopy.Hint := frmMain.btnCopy.Hint;
      frmCurrencies.actCopy.ShortCut := S;
      frmCurrencies.popCopy.ShortCut := S;
      frmCurrencies.btnCopy.Hint := frmMain.btnCopy.Hint;
      frmPayees.actCopy.ShortCut := S;
      frmPayees.popCopy.ShortCut := S;
      frmPayees.btnCopy.Hint := frmMain.btnCopy.Hint;
      frmAccounts.actCopy.ShortCut := S;
      frmAccounts.popCopy.ShortCut := S;
      frmAccounts.btnCopy.Hint := frmMain.btnCopy.Hint;
      frmCategories.actCopy.ShortCut := S;
      frmCategories.popCopy.ShortCut := S;
      frmCategories.btnCopy.Hint := frmMain.btnCopy.Hint;
      frmPersons.actCopy.ShortCut := S;
      frmPersons.popCopy.ShortCut := S;
      frmPersons.btnCopy.Hint := frmMain.btnCopy.Hint;
      frmSQLResult.actCopy.ShortCut := S;
      frmSQLResult.btnCopy.Hint := frmMain.btnCopy.Hint;
      frmCounter.actCopy.ShortCut := S;
      frmCounter.btnCopy.Hint := frmMain.btnCopy.Hint;
      frmLinks.actCopy.ShortCut := S;
      frmLinks.popCopy.ShortCut := S;
      frmLinks.btnCopy.Hint := frmMain.btnCopy.Hint;
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
      frmHolidays.btnSelect.Hint := frmMain.btnSelect.Hint;
      frmComments.actSelect.ShortCut := S;
      frmComments.popSelect.ShortCut := S;
      frmComments.btnSelect.Hint := frmMain.btnSelect.Hint;
      frmTags.actSelect.ShortCut := S;
      frmTags.popSelect.ShortCut := S;
      frmTags.btnSelect.Hint := frmMain.btnSelect.Hint;
      frmCurrencies.actSelect.ShortCut := S;
      frmCurrencies.popSelect.ShortCut := S;
      frmCurrencies.btnSelect.Hint := frmMain.btnSelect.Hint;
      frmPayees.actSelect.ShortCut := S;
      frmPayees.popSelect.ShortCut := S;
      frmPayees.btnSelect.Hint := frmMain.btnSelect.Hint;
      frmAccounts.actSelect.ShortCut := S;
      frmAccounts.popSelect.ShortCut := S;
      frmAccounts.btnSelect.Hint := frmMain.btnSelect.Hint;
      frmCategories.actSelect.ShortCut := S;
      frmCategories.popSelect.ShortCut := S;
      frmCategories.btnSelect.Hint := frmMain.btnSelect.Hint;
      frmPersons.actSelect.ShortCut := S;
      frmPersons.popSelect.ShortCut := S;
      frmPersons.btnSelect.Hint := frmMain.btnSelect.Hint;
      frmRecycleBin.actSelect.ShortCut := S;
      frmRecycleBin.btnSelect.Hint :=
        frmMain.btnSelect.Hint;
      frmSQLResult.actSelect.ShortCut := S;
      frmSQLResult.btnSelect.Hint := frmMain.btnSelect.Hint;
      frmLinks.actSelect.ShortCut := S;
      frmLinks.popSelect.ShortCut := S;
      frmLinks.btnSelect.Hint := frmMain.btnSelect.Hint;
    end
    // ------------------------------------------------------------------------
    else if Action = 'record_print_all' then
    begin
      frmMain.actPrint.ShortCut := S;
      frmMain.popPrint.ShortCut := S;
      frmMain.btnPrint.Hint := Hint_13 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmMain.btnReportPrint.Hint := frmMain.btnPrint.Hint;
      frmHolidays.actPrint.ShortCut := S;
      frmHolidays.popPrint.ShortCut := S;
      frmHolidays.btnPrint.Hint := frmMain.btnPrint.Hint;
      frmComments.actPrint.ShortCut := S;
      frmComments.popPrint.ShortCut := S;
      frmComments.btnPrint.Hint := frmMain.btnPrint.Hint;
      frmTags.actPrint.ShortCut := S;
      frmTags.popPrint.ShortCut := S;
      frmTags.btnPrint.Hint := frmMain.btnPrint.Hint;
      frmCurrencies.actPrint.ShortCut := S;
      frmCurrencies.popPrint.ShortCut := S;
      frmCurrencies.btnPrint.Hint := frmMain.btnPrint.Hint;
      frmPayees.actPrint.ShortCut := S;
      frmPayees.popPrint.ShortCut := S;
      frmPayees.btnPrint.Hint := frmMain.btnPrint.Hint;
      frmAccounts.actPrint.ShortCut := S;
      frmAccounts.popPrint.ShortCut := S;
      frmAccounts.btnPrint.Hint := frmMain.btnPrint.Hint;
      frmCategories.actPrint.ShortCut := S;
      frmCategories.popPrint.ShortCut := S;
      frmCategories.btnPrint.Hint := frmMain.btnPrint.Hint;
      frmPersons.actPrint.ShortCut := S;
      frmPersons.popPrint.ShortCut := S;
      frmPersons.btnPrint.Hint := frmMain.btnPrint.Hint;
      frmLinks.actPrint.ShortCut := S;
      frmLinks.popPrint.ShortCut := S;
      frmLinks.btnPrint.Hint := frmMain.btnPrint.Hint;
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
      frmAccounts.actSave.ShortCut := S;
      frmAccounts.btnSave.Hint := frmDetail.btnSave.Hint;
      frmCurrencies.actSave.ShortCut := S;
      frmCurrencies.btnSave.Hint := frmDetail.btnSave.Hint;
      frmCategories.actSave.ShortCut := S;
      frmCategories.btnSave.Hint := frmDetail.btnSave.Hint;
      frmPersons.actSave.ShortCut := S;
      frmPersons.btnSave.Hint := frmDetail.btnSave.Hint;
      frmPayees.actSave.ShortCut := S;
      frmPayees.btnSave.Hint := frmDetail.btnSave.Hint;
      frmValues.actSave.ShortCut := S;
      frmValues.btnSave.Hint := frmDetail.btnSave.Hint;
      frmHolidays.actSave.ShortCut := S;
      frmHolidays.btnSave.Hint := frmDetail.btnSave.Hint;
      frmTags.actSave.ShortCut := S;
      frmTags.btnSave.Hint := frmDetail.btnSave.Hint;
      frmComments.actSave.ShortCut := S;
      frmComments.btnSave.Hint := frmDetail.btnSave.Hint;
      frmEdit.actSave.ShortCut := S;
      frmEdit.btnSave.Hint := frmDetail.btnSave.Hint;
      frmEdits.actSave.ShortCut := S;
      frmEdits.btnSave.Hint := frmDetail.btnSave.Hint;
      frmWrite.popSave.ShortCut := S;
      frmWrite.actSave.ShortCut := S;
      frmWrite.btnSave.Hint := frmDetail.btnSave.Hint;
      frmScheduler.actSave.ShortCut := S;
      frmScheduler.btnSave.Hint := frmDetail.btnSave.Hint;
      frmTemplates.actSave.ShortCut := S;
      frmTemplates.btnSave.Hint := frmDetail.btnSave.Hint;
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
    else if Action = 'new_transaction_simple' then
    begin
      frmDetail.actSimple.ShortCut := S;
      frmDetail.tabKind.Tabs[0].Text :=
        ' ' + Caption_319 + ' [' + ShortCutToText(frmDetail.actSimple.ShortCut) +
        ']' + ' ';
    end

    // ------------------------------------------------------------------------
    else if Action = 'new_transaction_multiple' then
    begin
      frmDetail.actMultiple.ShortCut := S;
      frmDetail.tabKind.Tabs[1].Text :=
        ' ' + Caption_320 + ' [' + ShortCutToText(frmDetail.actMultiple.ShortCut) +
        ']' + ' ';
    end

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
      // frmMain
      frmMain.mnuTags.ShortCut := S;
      frmMain.btnTags.Hint := Hint_41 + sLineBreak + '[' + ShortCutToText(S) + ']';
      // frmDetial
      frmDetail.actTags.ShortCut := S;
      frmDetail.btnTag.Hint := frmMain.btnTags.Hint;
      frmDetail.btnTagsX.Hint := frmMain.btnTags.Hint;
      // frmEdit
      frmEdit.actTags.ShortCut := S;
      frmEdit.btnTag.Hint := frmMain.btnTags.Hint;
      // frmEdits
      frmEdits.actTags.ShortCut := S;
      frmEdits.btnTag.Hint := frmMain.btnTags.Hint;
      // frmScheduler
      frmScheduler.actTags.ShortCut := S;
      frmScheduler.btnTag.Hint := frmMain.btnTags.Hint;
    end
    // ------------------------------------------------------------------------
    else if Action = 'list_currencies' then
    begin
      //frmMain
      frmMain.mnuCurrencies.ShortCut := S;
      frmMain.btnCurrencies.Hint := Hint_42 + sLineBreak + '[' + ShortCutToText(S) + ']';
      // frmAccounts
      frmAccounts.actCurrencies.ShortCut := S;
      frmAccounts.btnCurrency.Hint := frmMain.btnCurrencies.Hint;
      // frmCounter
      frmCounter.actCurrencies.ShortCut := S;
      frmCounter.btnCurrencies.Hint := frmMain.btnCurrencies.Hint;
      // frmCalendar
      frmCalendar.actCurrencies.ShortCut := S;
      frmCalendar.btnCurrencies.Hint := frmMain.btnCurrencies.Hint;
    end
    // ------------------------------------------------------------------------
    else if Action = 'list_payees' then
    begin
      // frmMain
      frmMain.mnuPayees.ShortCut := S;
      frmMain.btnPayees.Hint := Hint_43 + sLineBreak + '[' + ShortCutToText(S) + ']';
      // frmDetail
      frmDetail.actPayee.ShortCut := S;
      frmDetail.btnPayee.Hint := frmMain.btnPayees.Hint;
      frmDetail.btnPayeeX.Hint := frmMain.btnPayees.Hint;
      // frmEdit
      frmEdit.actPayees.ShortCut := S;
      frmEdit.btnPayee.Hint := frmMain.btnPayees.Hint;
      // frmEdits
      frmEdits.actPayees.ShortCut := S;
      frmEdits.btnPayee.Hint := frmMain.btnPayees.Hint;
      // frmScheduler
      frmScheduler.actPayees.ShortCut := S;
      frmScheduler.btnPayee.Hint := frmMain.btnPayees.Hint;
    end
    // ------------------------------------------------------------------------
    else if Action = 'list_comments' then
    begin
      // frmMain
      frmMain.mnuComments.ShortCut := S;
      frmMain.btnComments.Hint := Hint_44 + sLineBreak + '[' + ShortCutToText(S) + ']';
      // frmDetail
      frmDetail.actComments.ShortCut := S;
      frmDetail.btnComment.Hint := frmMain.btnComments.Hint;
      frmDetail.btnCommentX.Hint := frmMain.btnComments.Hint;
      // frmEdit
      frmEdit.actComments.ShortCut := S;
      frmEdit.btnComment.Hint := frmMain.btnComments.Hint;
      // frmEdits
      frmEdits.actComments.ShortCut := S;
      frmEdits.btnComment.Hint := frmMain.btnComments.Hint;
      // frmScheduler
      frmScheduler.actComments.ShortCut := S;
      frmScheduler.btnComment.Hint := frmMain.btnComments.Hint;
    end
    // ------------------------------------------------------------------------
    else if Action = 'list_accounts' then
    begin
      // frmMain
      frmMain.mnuAccounts.ShortCut := S;
      frmMain.btnAccounts.Hint := Hint_45 + sLineBreak + '[' + ShortCutToText(S) + ']';
      // frmDetail
      frmDetail.actAccounts.ShortCut := S;
      frmDetail.btnAccountFrom.Hint := frmMain.btnAccounts.Hint;
      frmDetail.btnAccountTo.Hint := frmMain.btnAccounts.Hint;
      frmDetail.btnAccountX.Hint := frmMain.btnAccounts.Hint;
      // frmEdit
      frmEdit.actAccounts.ShortCut := S;
      frmEdit.btnAccount.Hint := frmMain.btnAccounts.Hint;
      // frmEdits
      frmEdits.actAccounts.ShortCut := S;
      frmEdits.btnAccount.Hint := frmMain.btnAccounts.Hint;
      // frmScheduler
      frmScheduler.actAccounts.ShortCut := S;
      frmScheduler.btnAccountFrom.Hint := frmMain.btnAccounts.Hint;
      frmScheduler.btnAccountTo.Hint := frmMain.btnAccounts.Hint;
      // frmCalendar
      frmCalendar.actAccounts.ShortCut := S;
      frmCalendar.btnAccounts.Hint := frmMain.btnAccounts.Hint;
    end
    // ------------------------------------------------------------------------
    else if Action = 'list_categories' then
    begin
      // frmMain
      frmMain.mnuCategories.ShortCut := S;
      frmMain.btnCategories.Hint := Hint_46 + sLineBreak + '[' + ShortCutToText(S) + ']';
      // frmDetial
      frmDetail.actCategories.ShortCut := S;
      frmDetail.btnCategory.Hint := frmMain.btnCategories.Hint;
      frmDetail.btnCategoryX.Hint := frmMain.btnCategories.Hint;
      // frmEdit
      frmEdit.actCategories.ShortCut := S;
      frmEdit.btnCategory.Hint := frmMain.btnCategories.Hint;
      // frmEdits
      frmEdits.actCategories.ShortCut := S;
      frmEdits.btnCategory.Hint := frmMain.btnCategories.Hint;
      // frmScheduler
      frmScheduler.actCategories.ShortCut := S;
      frmScheduler.btnCategory.Hint := frmMain.btnCategories.Hint;
    end
    // ------------------------------------------------------------------------
    else if Action = 'list_persons' then
    begin
      // frmMain
      frmMain.mnuPersons.ShortCut := S;
      frmMain.btnPersons.Hint := Hint_47 + sLineBreak + '[' + ShortCutToText(S) + ']';
      // frmDetail
      frmDetail.actPersons.ShortCut := S;
      frmDetail.btnPerson.Hint := frmMain.btnPersons.Hint;
      frmDetail.btnPersonX.Hint := frmMain.btnPersons.Hint;
      // frmEdit
      frmEdit.actPersons.ShortCut := S;
      frmEdit.btnPerson.Hint := frmMain.btnPersons.Hint;
      // frmEdits
      frmEdits.actPersons.ShortCut := S;
      frmEdits.btnPerson.Hint := frmMain.btnPersons.Hint;
      // frmScheduler
      frmScheduler.actPersons.ShortCut := S;
      frmScheduler.btnPerson.Hint := frmMain.btnPersons.Hint;
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
      frmWrite.btnCalendar.Hint := frmMain.btnCalendar.Hint;
      frmSchedulers.actCalendar.ShortCut := S;
      frmSchedulers.btnCalendar.Hint := frmMain.btnCalendar.Hint;
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
      // frmMain
      frmMain.mnuCalc.ShortCut := S;
      frmMain.btnCalc.Hint := Hint_56 + sLineBreak + '[' + ShortCutToText(S) + ']';
      // frmDetail
      frmDetail.actCalc.ShortCut := S;
      frmDetail.btnAmountFrom.Hint := frmMain.btnCalc.Hint;
      frmDetail.btnAmountTo.Hint := frmMain.btnCalc.Hint;
      frmDetail.btnAmountX.Hint := frmMain.btnCalc.Hint;
      // frmEdit
      frmEdit.actCalc.ShortCut := S;
      frmEdit.btnAmount.Hint := frmMain.btnCalc.Hint;
      // frmEdits
      frmEdits.actCalc.ShortCut := S;
      frmEdits.btnAmount.Hint := frmMain.btnCalc.Hint;
      // frmScheduler
      frmScheduler.actCalc.ShortCut := S;
      frmScheduler.btnAmountFrom.Hint := frmMain.btnCalc.Hint;
      frmScheduler.btnAmountTo.Hint := frmMain.btnCalc.Hint;
    end
    // ------------------------------------------------------------------------
    else if Action = 'settings' then
    begin
      frmMain.mnuSettings.ShortCut := S;
      frmMain.btnSettings.Hint := Hint_57 + sLineBreak + '[' + ShortCutToText(S) + ']';
      frmWrite.actSettings.ShortCut := S;
      frmWrite.btnSettings.Hint := frmMain.btnSettings.Hint;
      frmScheduler.btnSettings.Hint := frmMain.btnSettings.Hint;
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
