// Program: RQ MONEY
// Version: 3.9.2
// Starting date: March 3, 2016
// Author: Slavomir Svetlik
// Contact: rqmoney@gmail.com

unit uniMain;

{$mode objfpc}{$H+}
{$ModeSwitch AutoDeref}

interface

uses
  Classes, SysUtils, sqldb, DB, sqlite3conn, FileUtil, Forms, Controls, process,
  IniFiles, Clipbrd, Math, Graphics, Dialogs, Menus, ExtCtrls, StdCtrls,
  FileCtrl, Buttons, LazFileUtils, LazUTF8, ComCtrls, LR_Class, LR_Desgn,
  LR_DSet, Spin, StrUtils, LCLIntf, DateUtils, LCLType, ExtDlgs,
  CheckLst, GraphUtil, ActnList, BCPanel, BCMDButtonFocus, ECTabCtrl,
  BlowFish, laz.VirtualTrees, TAGraph, LCLTranslator, LCLProc,
  CalendarLite, SQLite3Dyn, gettext, TASeries, TASources, TAStyles,
  {$IFDEF WINDOWS}
  urlmon, windows,
  {$ENDIF}
  TAChartAxisUtils, TACustomSeries, DateTimePicker;

const
  separ = '•';
  separ_1 = ' | ';
  Color_focus = clSilver;
  Color_panel_focus = $00BDDDFF;

type // bottom grid (Summary)
  TSummary = record
    Account: string;
    AccountAmount: double;
    Comment: string;
    StartSum: double;
    Credit: double;
    Debit: double;
    TransferP: double;  // transfer plus
    TransferM: double; // transfer minus
  end;
  PSummary = ^TSummary;

type // Reports(Balance)
  TBalance = record
    Name1: string;
    Name2: string;
    Credit: double;
    Debit: double;
    TransferP: double;  // transfer plus
    TransferM: double; // transfer minus
  end;
  PBalance = ^TBalance;

type // main grid (transactions)
  TTransactions = record
    Date: string;
    Comment: string;
    Amount: double;
    currency: string;
    Account: string;
    Category: string;
    SubCategory: string;
    Person: string;
    Payee: string;
    ID: integer;
    Kind: integer;
    Order: integer;
  end;
  PTransactions = ^TTransactions;

type

  { TfrmMain }

  TfrmMain = class(TForm)
    actDelete: TAction;
    actEdit: TAction;
    actAddSimple: TAction;
    actCopy: TAction;
    actHistory: TAction;
    actFilterClear: TAction;
    actFilterExpand: TAction;
    actFilterCollapse: TAction;
    actDuplicate: TAction;
    actChronoStart: TAction;
    actChronoCredits: TAction;
    actChronoDebits: TAction;
    actChronoPlus: TAction;
    actChronoMinus: TAction;
    actChronoBalance: TAction;
    actChronoTotal: TAction;
    actChronoShowPoints: TAction;
    actChronoShowMarks: TAction;
    actAddMultiple: TAction;
    actSelect: TAction;
    actPrint: TAction;
    ActionList1: TActionList;
    btnAdd: TBCMDButtonFocus;
    btnSubcategory: TSpeedButton;
    btnReportPrint: TBCMDButtonFocus;
    btnReportExit: TBCMDButtonFocus;
    btnCopy: TBCMDButtonFocus;
    btnDelete: TBCMDButtonFocus;
    btnDuplicate: TBCMDButtonFocus;
    btnEdit: TBCMDButtonFocus;
    btnImport: TSpeedButton;
    btnExport: TSpeedButton;
    btnFilter: TBitBtn;
    btnMonthMinus: TBitBtn;
    btnMonthPlus: TBitBtn;
    btnHistory: TBCMDButtonFocus;
    btnPrint: TBCMDButtonFocus;
    btnReportCopy: TBCMDButtonFocus;
    btnSelect: TBCMDButtonFocus;
    btnReportSettings: TBCMDButtonFocus;
    btnYearMinus: TBitBtn;
    btnYearPlus: TBitBtn;
    btnAccount: TSpeedButton;
    btnCategory: TSpeedButton;
    btnCurrency: TSpeedButton;
    btnPayee: TSpeedButton;
    btnPerson: TSpeedButton;
    btnTag: TSpeedButton;
    btnType: TSpeedButton;
    Calendar: TCalendarLite;
    cbxSubcategory: TComboBox;
    cbxMonth: TComboBox;
    cbxYear: TComboBox;
    cbxAccount: TComboBox;
    cbxCategory: TComboBox;
    cbxComment: TComboBox;
    cbxCurrency: TComboBox;
    cbxMax: TComboBox;
    cbxMin: TComboBox;
    cbxPayee: TComboBox;
    cbxPerson: TComboBox;
    cbxTag: TComboBox;
    cbxType: TComboBox;
    chaChrono: TChart;
    chkShowPieChart: TCheckBox;
    popEditToolBar: TMenuItem;
    popAddMulitple: TMenuItem;
    popToolBar: TPopupMenu;
    tabBalanceShow: TECTabCtrl;
    Panel3: TPanel;
    Panel4: TPanel;
    tabBalanceHeader: TECTabCtrl;
    tabChronoHeader: TECTabCtrl;
    tabCrossTop: TECTabCtrl;
    tabCrossLeft: TECTabCtrl;
    img32: TImageList;
    popChartChronoShowMarks: TMenuItem;
    popChartChronoShowPoints: TMenuItem;
    popChartChrono6: TMenuItem;
    popChartChrono7: TMenuItem;
    popChartChrono1: TMenuItem;
    popChartChrono2: TMenuItem;
    popChartChrono3: TMenuItem;
    popChartChrono4: TMenuItem;
    popChartChrono5: TMenuItem;
    popChartChronoShowSeries: TMenuItem;
    popChartChrono: TPopupMenu;
    popCopyChartChrono: TMenuItem;
    Separator4: TMenuItem;
    souChrono: TListChartSource;
    serChronoStart: TLineSeries;
    serChronoCredits: TLineSeries;
    serChronoDebits: TLineSeries;
    serChronoTPlus: TLineSeries;
    serChronoTMinus: TLineSeries;
    serChronoBalance: TLineSeries;
    serChronoTotal: TLineSeries;
    datDateFrom: TDateTimePicker;
    datDateTo: TDateTimePicker;
    lblDateFrom: TLabel;
    lblDateTo: TLabel;
    mnuCheckUpdate: TMenuItem;
    pnlDateFrom: TPanel;
    pnlDateTo: TPanel;
    popSummaryPrint: TMenuItem;
    popSummaryCopy: TMenuItem;
    popCopyChartBalance: TMenuItem;
    popChartBalance: TPopupMenu;
    popSummary: TPopupMenu;
    splChrono: TSplitter;
    styBalanceCredit: TChartStyles;
    souBalanceCredits: TListChartSource;
    serBalanceDebits: TBarSeries;
    chaPie: TChart;
    chaBalance: TChart;
    serBalanceCredits: TBarSeries;
    DSTSummary: TfrUserDataset;
    DST: TfrUserDataset;
    DSTBalance: TfrUserDataset;
    ediComment: TEdit;
    imgButtons: TImageList;
    lblCurrencySummary: TLabel;
    mnuLinks: TMenuItem;
    mnuSubLink: TMenuItem;
    souBalanceDebits: TListChartSource;
    styBalanceDebit: TChartStyles;
    tabReports: TPageControl;
    Panel1: TPanel;
    pnlReportButtons: TPanel;
    pnlReportCaption: TBCPanel;
    pnlReport: TPanel;
    Separator2: TMenuItem;
    Separator3: TMenuItem;
    serPie: TPieSeries;
    spiMin: TFloatSpinEdit;
    spiMax: TFloatSpinEdit;
    img24: TImageList;
    imgAmount: TImage;
    imgDay: TImage;
    imgTime: TImage;
    imgMonthYear: TImage;
    imgPeriod: TImage;
    imgTag: TImage;
    imgPerson: TImage;
    imgPayee: TImage;
    imgComment: TImage;
    imgArrows: TImageList;
    imgCategory: TImage;
    imgCurrency: TImage;
    imgAccount: TImage;
    imgHeight: TImage;
    imgItems: TImage;
    imgItem: TImage;
    imgType: TImage;
    imgDate: TImage;
    imgWidth: TImage;
    lblTime: TLabel;
    mnuExport: TMenuItem;
    mnuImport: TMenuItem;
    pnlMonthYearClient: TPanel;
    pnlBottomClient: TPanel;
    pnlAccountCaption: TPanel;
    pnlAmountCaption: TPanel;
    pnlCategoryCaption: TPanel;
    pnlCommentCaption: TPanel;
    pnlCurrencyCaption: TPanel;
    gbxMonth: TGroupBox;
    gbxYear: TGroupBox;
    gbxDateFrom: TGroupBox;
    gbxDateTo: TGroupBox;
    pnlTime: TPanel;
    popFilterCollapse: TMenuItem;
    popFilterClear: TMenuItem;
    popFilterExpand: TMenuItem;
    pnlDateCaption: TPanel;
    pnlDayCaption: TPanel;
    pnlMonthYearCaption: TPanel;
    pnlPeriodCaption: TPanel;
    lblItem: TLabel;
    pnlPayeeCaption: TPanel;
    pnlPersonCaption: TPanel;
    pnlTagCaption: TPanel;
    pnlTypeCaption: TPanel;
    pnlCurrency1: TPanel;
    Panel2: TPanel;
    pnlDay: TPanel;
    pnlMonthYear: TPanel;
    pnlPeriod: TPanel;
    pnlType1: TPanel;
    pnlItem: TPanel;
    pnlListCaption: TBCPanel;
    pnlFilterCaption: TBCPanel;
    pnlSummaryCaption: TBCPanel;
    popFilter: TPopupMenu;
    Separator1: TMenuItem;
    tabBalance: TTabSheet;
    tabChrono: TTabSheet;
    tabCross: TTabSheet;
    tabCurrency: TTabControl;
    tmrFirstRun: TTimer;
    VSTBalance: TLazVirtualStringTree;
    VSTChrono: TLazVirtualStringTree;
    VSTCross: TLazVirtualStringTree;
    VSTSummary: TLazVirtualStringTree;
    pnlButtons: TPanel;
    lblHeight: TLabel;
    lblItems: TLabel;
    lblWidth: TLabel;
    pnlBottom: TPanel;
    pnlHeight: TPanel;
    pnlItems: TPanel;
    pnlWidth: TPanel;
    popHistory: TMenuItem;
    pnlSummary: TPanel;
    pnlFilter: TPanel;
    pnlAccount: TPanel;
    pnlAmount: TPanel;
    pnlCategory: TPanel;
    pnlComment: TPanel;
    pnlCurrency: TPanel;
    pnlDate: TPanel;
    btnNew: TSpeedButton;
    btnOpen: TSpeedButton;
    btnClose: TSpeedButton;
    btnPayees: TSpeedButton;
    btnComments: TSpeedButton;
    btnAccounts: TSpeedButton;
    btnCategories: TSpeedButton;
    btnPersons: TSpeedButton;
    btnBudgets: TSpeedButton;
    btnSchedulers: TSpeedButton;
    btnReports: TSpeedButton;
    btnCalc: TSpeedButton;
    btnCashCounter: TSpeedButton;
    btnPassword: TSpeedButton;
    btnSettings: TSpeedButton;
    btnAbout: TSpeedButton;
    btnExit: TSpeedButton;
    btnWrite: TSpeedButton;
    btnCalendar: TSpeedButton;
    btnSQL: TSpeedButton;
    btnGuide: TSpeedButton;
    btnProperties: TSpeedButton;
    btnRecycle: TSpeedButton;
    btnHolidays: TSpeedButton;
    btnTags: TSpeedButton;
    btnCurrencies: TSpeedButton;
    calculator: TCalculatorDialog;
    img16: TImageList;
    Conn: TSQLite3Connection;
    frDesigner1: TfrDesigner;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    pnlList: TPanel;
    popAddSimple: TMenuItem;
    pnlMax: TPanel;
    pnlMin: TPanel;
    pnlPayee: TPanel;
    pnlPerson: TPanel;
    pnlTag: TPanel;
    pnlType: TPanel;
    splSummary: TSplitter;
    mnuCalendar: TMenuItem;
    mnuWrite: TMenuItem;
    mnuBudget: TMenuItem;
    mnuRecycle: TMenuItem;
    mnuProperties: TMenuItem;
    pnlClient: TPanel;
    mnuReports: TMenuItem;
    splFilter: TSplitter;
    mnuCashCounter: TMenuItem;
    popSelect: TMenuItem;
    mnuSQL: TMenuItem;
    popDuplicate: TMenuItem;
    Report: TfrReport;
    ImgTypes: TImageList;
    mnuCalc: TMenuItem;
    imgSize: TImageList;
    MenuItem1: TMenuItem;
    mnuPassword: TMenuItem;
    mnuPause1a: TMenuItem;
    mnuGuide: TMenuItem;
    mnuSchedulers: TMenuItem;
    mnuTools: TMenuItem;
    mnuCategories: TMenuItem;
    mnuHolidays: TMenuItem;
    mnuTags: TMenuItem;
    mnuPayees: TMenuItem;
    mnuComments: TMenuItem;
    mnuAbout: TMenuItem;
    mnuSettings: TMenuItem;
    mnuCurrencies: TMenuItem;
    mnuAccounts: TMenuItem;
    mnuClose: TMenuItem;
    popCopy: TMenuItem;
    popDelete: TMenuItem;
    popEdit: TMenuItem;
    popList: TPopupMenu;
    popPrint: TMenuItem;
    mnuOpen: TMenuItem;
    mnuNew: TMenuItem;
    mnuDatabase: TMenuItem;
    mnuExit: TMenuItem;
    mnuProgram: TMenuItem;
    mnuPersons: TMenuItem;
    mnuLists: TMenuItem;
    mnuMain: TMainMenu;
    od: TOpenDialog;
    QRY: TSQLQuery;
    sd: TSaveDialog;
    tabTransactions: TTabSheet;
    tmr: TTimer;
    tooMenu: TPanel;
    Tran: TSQLTransaction;
    scrFilter: TScrollBox;
    VST: TLazVirtualStringTree;
    VSTSummaries: TLazVirtualStringTree;

    procedure btnFilterClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnCalcClick(Sender: TObject);
    procedure btnCurrencyMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure btnDuplicateClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure btnPrintMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure btnReportExitClick(Sender: TObject);
    procedure btnReportPrintClick(Sender: TObject);
    procedure btnReportPrintMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure btnReportSettingsClick(Sender: TObject);
    procedure CalendarDateChange(Sender: TObject);
    procedure cbxAccountDropDown(Sender: TObject);
    procedure cbxSubcategoryChange(Sender: TObject);
    procedure chaBalanceClick(Sender: TObject);
    procedure datDateFromKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure datDateToKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure DSTBalanceCheckEOF(Sender: TObject; var EOF: boolean);
    procedure DSTBalanceFirst(Sender: TObject);
    procedure DSTBalanceNext(Sender: TObject);
    procedure DSTSummaryCheckEOF(Sender: TObject; var EOF: boolean);
    procedure DSTSummaryFirst(Sender: TObject);
    procedure DSTSummaryNext(Sender: TObject);
    procedure DSTCheckEOF(Sender: TObject; var EOF: boolean);
    procedure DSTFirst(Sender: TObject);
    procedure DSTNext(Sender: TObject);
    procedure ediCommentEnter(Sender: TObject);
    procedure ediCommentExit(Sender: TObject);
    procedure lblDateFromClick(Sender: TObject);
    procedure lblDateToClick(Sender: TObject);
    procedure mnuCheckUpdateClick(Sender: TObject);
    procedure mnuSubLinkClick(Sender: TObject);
    procedure pnlFilterResize(Sender: TObject);
    procedure popChartChrono1Click(Sender: TObject);
    procedure popChartChronoShowMarksClick(Sender: TObject);
    procedure popChartChronoShowPointsClick(Sender: TObject);
    procedure popCopyChartBalanceClick(Sender: TObject);
    procedure popEditToolBarClick(Sender: TObject);
    procedure popSummaryCopyClick(Sender: TObject);
    procedure popSummaryPrintClick(Sender: TObject);
    procedure ReportBeginBand(Band: TfrBand);
    procedure serBalanceCreditsGetMark(out AFormattedMark: string; AIndex: integer);
    procedure serBalanceDebitsGetMark(out AFormattedMark: string; AIndex: integer);
    procedure serChronoBalanceGetMark(out AFormattedMark: string; AIndex: integer);
    procedure serChronoCreditsGetMark(out AFormattedMark: string; AIndex: integer);
    procedure serChronoDebitsGetMark(out AFormattedMark: string; AIndex: integer);
    procedure serChronoStartGetMark(out AFormattedMark: string; AIndex: integer);
    procedure serChronoTMinusGetMark(out AFormattedMark: string; AIndex: integer);
    procedure serChronoTotalGetMark(out AFormattedMark: string; AIndex: integer);
    procedure serChronoTPlusGetMark(out AFormattedMark: string; AIndex: integer);
    procedure spiMaxEnter(Sender: TObject);
    procedure spiMaxExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure mnuBudgetClick(Sender: TObject);
    procedure mnuCalendarClick(Sender: TObject);
    procedure mnuExportClick(Sender: TObject);
    procedure btnHistoryClick(Sender: TObject);
    procedure mnuWriteClick(Sender: TObject);
    procedure popFilterClearClick(Sender: TObject);
    procedure btnMonthMinusClick(Sender: TObject);
    procedure btnMonthPlusClick(Sender: TObject);
    procedure btnSelectClick(Sender: TObject);
    procedure btnYearMinusClick(Sender: TObject);
    procedure btnYearPlusClick(Sender: TObject);
    procedure cbxAccountChange(Sender: TObject);
    procedure cbxCategoryChange(Sender: TObject);
    procedure cbxCurrencyChange(Sender: TObject);
    procedure cbxMonthChange(Sender: TObject);
    procedure cbxPayeeChange(Sender: TObject);
    procedure cbxPersonChange(Sender: TObject);
    procedure cbxTagChange(Sender: TObject);
    procedure cbxTypeChange(Sender: TObject);
    procedure datDateFromChange(Sender: TObject);
    procedure datDateFromKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure ediCommentChange(Sender: TObject);
    procedure spiMinChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure pnlAccountCaptionClick(Sender: TObject);
    procedure pnlAmountCaptionClick(Sender: TObject);
    procedure pnlCategoryCaptionClick(Sender: TObject);
    procedure pnlCommentCaptionClick(Sender: TObject);
    procedure pnlCurrencyCaptionClick(Sender: TObject);
    procedure pnlPeriodCaptionClick(Sender: TObject);
    procedure pnlMonthYearCaptionClick(Sender: TObject);
    procedure pnlDateCaptionClick(Sender: TObject);
    procedure pnlDayCaptionClick(Sender: TObject);
    procedure pnlPayeeCaptionClick(Sender: TObject);
    procedure pnlPersonCaptionClick(Sender: TObject);
    procedure pnlTagCaptionClick(Sender: TObject);
    procedure pnlTypeCaptionClick(Sender: TObject);
    procedure mnuCalcClick(Sender: TObject);
    procedure mnuCashCounterClick(Sender: TObject);
    procedure mnuPropertiesClick(Sender: TObject);
    procedure mnuRecycleClick(Sender: TObject);
    procedure mnuReportsClick(Sender: TObject);
    procedure mnuSQLClick(Sender: TObject);
    procedure pnlButtonsResize(Sender: TObject);
    procedure popFilterExpandClick(Sender: TObject);
    procedure ReportGetValue(const ParName: string; var ParValue: variant);
    procedure mnuAboutClick(Sender: TObject);
    procedure mnuAccountsClick(Sender: TObject);
    procedure mnuCategoriesClick(Sender: TObject);
    procedure mnuCloseClick(Sender: TObject);
    procedure mnuCommentsClick(Sender: TObject);
    procedure mnuCurrenciesClick(Sender: TObject);
    procedure btnCopyClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure mnuExitClick(Sender: TObject);
    procedure mnuGuideClick(Sender: TObject);
    procedure mnuHolidaysClick(Sender: TObject);
    procedure mnuNewClick(Sender: TObject);
    procedure mnuTagsClick(Sender: TObject);
    procedure mnuOpenClick(Sender: TObject);
    procedure mnuPasswordClick(Sender: TObject);
    procedure mnuPayeesClick(Sender: TObject);
    procedure mnuPersonsClick(Sender: TObject);
    procedure mnuSchedulersClick(Sender: TObject);
    procedure mnuSettingsClick(Sender: TObject);
    procedure mnuImportClick(Sender: TObject);
    procedure splBalanceCanResize(Sender: TObject; var NewSize: integer;
      var Accept: boolean);
    procedure splSummaryCanResize(Sender: TObject; var NewSize: integer;
      var Accept: boolean);
    procedure splFilterCanResize(Sender: TObject; var NewSize: integer;
      var Accept: boolean);
    procedure tabBalanceHeaderChange(Sender: TObject);
    procedure tabBalanceShowChange(Sender: TObject);
    procedure tabChronoHeaderChange(Sender: TObject);
    procedure tabCrossLeftChange(Sender: TObject);
    procedure tabCrossTopChange(Sender: TObject);
    procedure tabReportsChange(Sender: TObject);
    procedure tabCurrencyChange(Sender: TObject);
    procedure tmrFirstRunTimer(Sender: TObject);
    procedure tmrTimer(Sender: TObject);
    procedure VSTBalanceChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure VSTBalanceCompareNodes(Sender: TBaseVirtualTree;
      Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: integer);
    procedure VSTBalanceGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: boolean; var ImageIndex: integer);
    procedure VSTBalanceGetNodeDataSize(Sender: TBaseVirtualTree;
      var NodeDataSize: integer);
    procedure VSTBalanceGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure VSTBalanceHeaderClick(Sender: TVTHeader; HitInfo: TVTHeaderHitInfo);
    procedure VSTBalancePaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      TextType: TVSTTextType);
    procedure VSTBalanceResize(Sender: TObject);
    procedure VSTBeforeCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas;
      Node: PVirtualNode; Column: TColumnIndex; CellPaintMode: TVTCellPaintMode;
      CellRect: TRect; var ContentRect: TRect);
    procedure VSTChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure VSTChronoGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: boolean; var ImageIndex: integer);
    procedure VSTChronoGetNodeDataSize(Sender: TBaseVirtualTree;
      var NodeDataSize: integer);
    procedure VSTChronoGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure VSTChronoHeaderClick(Sender: TVTHeader; HitInfo: TVTHeaderHitInfo);
    procedure VSTChronoResize(Sender: TObject);
    procedure VSTCompareNodes(Sender: TBaseVirtualTree; Node1, Node2: PVirtualNode;
      Column: TColumnIndex; var Result: integer);
    procedure VSTCrossBeforeCellPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
    procedure VSTCrossGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: boolean; var ImageIndex: integer);
    procedure VSTCrossGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure VSTCrossPaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      TextType: TVSTTextType);
    procedure VSTCrossResize(Sender: TObject);
    procedure VSTDblClick(Sender: TObject);
    procedure VSTEndOperation(Sender: TBaseVirtualTree; OperationKind: TVTOperationKind);
    procedure VSTFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure VSTGetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Kind: TVTImageKind; Column: TColumnIndex; var Ghosted: boolean;
      var ImageIndex: integer);
    procedure VSTGetNodeDataSize(Sender: TBaseVirtualTree; var NodeDataSize: integer);
    procedure VSTGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure VSTMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: integer; MousePos: TPoint; var Handled: boolean);
    procedure VSTPaintText(Sender: TBaseVirtualTree; const TargetCanvas: TCanvas;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType);
    procedure VSTResize(Sender: TObject);
    procedure VSTStartOperation(Sender: TBaseVirtualTree;
      OperationKind: TVTOperationKind);
    procedure VSTSummariesBeforeCellPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
    procedure VSTSummariesGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: boolean; var ImageIndex: integer);
    procedure VSTSummariesGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure VSTSummariesPaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      TextType: TVSTTextType);
    procedure VSTSummariesResize(Sender: TObject);
    procedure VSTSummaryBeforeCellPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
    procedure VSTSummaryChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure VSTSummaryCompareNodes(Sender: TBaseVirtualTree;
      Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: integer);
    procedure VSTSummaryFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure VSTSummaryGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: boolean; var ImageIndex: integer);
    procedure VSTSummaryGetNodeDataSize(Sender: TBaseVirtualTree;
      var NodeDataSize: integer);
    procedure VSTSummaryGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure VSTSummaryHotChange(Sender: TBaseVirtualTree;
      OldNode, NewNode: PVirtualNode);
    procedure VSTSummaryMouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
    procedure VSTSummaryPaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      TextType: TVSTTextType);
    procedure VSTSummaryResize(Sender: TObject);
    procedure ExternalLinkClick(Sender: TObject);
  private

  public

  end;

procedure ShowErrorMessage(E: Exception);
procedure Vacuum;
procedure FindEditedRecord(Sender: TLazVirtualStringTree; Column, Number: integer);
procedure CopyVST(Sender: TLazVirtualStringTree);
procedure OpenFileX(FileName: string);
procedure UpdateTransactions;
procedure UpdateSummary;
procedure CheckAllNodes(VST: TLazVirtualStringTree);
procedure FindNewRecord(Sender: TLazVirtualStringTree; Column: integer);
procedure SetNodeHeight(Sender: TLazVirtualStringTree);
procedure ComboBoxExit(Sender: TComboBox);
procedure FillSubcategory(Category: string; Component: TComboBox);
procedure FillCategory(Component: TComboBox; Kind: byte);
procedure ComboDDWidth(ComboBox: TComboBox);

function Field(char, Str: string; Count: integer): string;
function Brighten(AColor: TColor; Light: byte): TColor;
function CheckForbiddenChar(Sender: TObject): boolean;
function GetLang: string;
function GetMainCurrency: string;
function GetCategoryID(S: string): integer;
function Eval(Text: string): string;

var
  frmMain: TfrmMain;
  f_type, f_date, f_amount, f_currency, f_account, f_category, f_person,
  f_payee, f_comment, f_tag, f_subcategory: string;
  UpdatedAll, AllowUpdateTransactions: boolean;
  FullColor, BrightenColor: TColor;
  Balance: double;
  FS_own: TFormatSettings;
  B: array of TSpeedButton;
  ReportNode: PVirtualNode;
  ReportNodesCount, ButtonHeight, PanelHeight, ScreenRatio: integer;
  Start: int64;
  ScrollBarWidth, ScreenIndex: byte;
  cb: TClipboard;

implementation

{$R *.lfm}

uses
  unicomments, uniAccounts, uniCurrencies, uniSettings, uniSuccess, uniEdits,
  uniPersons, uniDetail, uniEdit, uniWrite, uniProperties, uniCalendar, uniValues,
  uniAbout, uniPayees, uniTags, uniHolidays, uniCategories, uniSchedulers,
  uniGuide, uniPassword, uniGate, uniFilter, uniSQL, uniCounter,
  uniRecycleBin, uniImport, uniHistory, uniResources,
  uniDelete, uniBudgets, uniBudget, uniPeriod, uniLinks;

  { TfrmMain }

function Eval(Text: string): string;
var
  slEval, slMath: TStringList;
  S1, S2, S3: double;
  B, C: byte;
  D, E: integer;
  ch: widechar;
  Temp: string;
  Convert: boolean;
begin
  Result := Format('%n', [0.0]);
  Text := ReplaceStr(Text, FS_own.ThousandSeparator, '');
  Text := ReplaceStr(Text, '.', FS_own.DecimalSeparator);
  Text := ReplaceStr(Text, ',', FS_own.DecimalSeparator);

  Convert := TryStrToFloat(Text, S2);

  if Convert = False then
  begin
    try
      slEval := TStringList.Create;
      slMath := TStringList.Create;
      slEval.Delimiter := '+';
      slEval.DelimitedText := ReplaceStr(Text, '-', '+-');
      S2 := 0;

      if slEval.Count > 0 then
        for B := 0 to slEval.Count - 1 do
        begin

          // Check for incorect characters
          for C := 1 to Length(slEval.Strings[B]) do
          begin
            ch := Copy(slEval.Strings[B], C, 1)[1];
            if not CharInSet(ch, ['0' .. '9', FS_own.DecimalSeparator,
              '+', '-', '*', '/']) then
            begin
              Temp := ReplaceStr(Error_24, '%1', Chr(39) + ch + Chr(39));
              ShowMessage(Temp);
              Result := Text;
              slEval.Free;
              slMath.Free;
              Exit;
            end;
          end;

          D := Pos('*', slEval.Strings[B]);
          E := Pos('/', slEval.Strings[B]);
          if (D > 0) or (E > 0) then
          begin
            slMath.Delimiter := '*';
            Temp := ReplaceStr(slEval.Strings[B], '*', '*x');
            Temp := ReplaceStr(Temp, '/', '*y');
            slMath.DelimitedText := Temp;

            for C := 0 to slMath.Count - 1 do
            try
              if LeftStr(slMath.Strings[C], 1) = 'x' then
              begin
                TryStrToFloat(ReplaceStr(slMath.Strings[C], 'x', ''), S3);
                S1 := S1 * S3;
              end
              else if LeftStr(slMath.Strings[C], 1) = 'y' then
              begin
                TryStrToFloat(ReplaceStr(slMath.Strings[C], 'y', ''), S3);
                if S3 <> 0.0 then
                  S1 := S1 / S3
                else
                  S1 := 0.0;
              end
              else
                TryStrToFloat(slMath.Strings[C], S1);
            except
              S1 := 0;
            end;
          end
          else // Convert string to decimal number
          try
            TryStrToFloat(slEval.Strings[B], S1);
          except
            S1 := 0;
          end;

          // Sum up results
          S2 := S1 + S2;
        end;

    finally
      slEval.Free;
      slMath.Free;
    end;
  end;

  // Convert decimal number to string
  Result := FloatToStr(S2);
end;

function GetMainCurrency: string;
var
  N: PVirtualNode;
  currency: PCurrency;
begin
  try
    N := frmCurrencies.VST.GetFirst();
    while Assigned(N) do
    begin
      currency := frmCurrencies.VST.GetNodeData(N);
      if (currency.Default = True) then
      begin
        Result := currency.Code;
        Break;
      end;
      N := frmCurrencies.VST.GetNext(N);
    end;
  except
  end;
end;

function GetCategoryID(S: string): integer;
var
  cat_name, cat_parent, id: string;
  Q: TSQLQuery;
begin
  Result := 0;
  if Length(S) = 0 then
    Exit;

  // setup components
  Q := TSQLQuery.Create(nil);
  Q.Transaction := frmMain.Tran;
  Q.DataBase := frmMain.Tran.DataBase;

  try
    if Pos(separ_1, S) > 0 then
    begin
      cat_parent := AnsiUpperCase(Field(separ_1, S, 1));
      cat_name := AnsiLowerCase(Field(separ_1, S, 2));
      id := '<>0';
    end
    else
    begin
      cat_parent := AnsiUpperCase(S);
      cat_name := AnsiUpperCase(S);
      id := '=0';
    end;

    Q.SQL.Text := 'SELECT cat_id FROM categories ' +
      'WHERE cat_name = :CAT_NAME and cat_parent_name = :CAT_PARENT and cat_parent_id ' +
      id + ';';
    Q.Params.ParamByName('CAT_NAME').AsString := cat_name;
    Q.Params.ParamByName('CAT_PARENT').AsString := cat_parent;
    Q.Prepare;
    Q.Open;
    Result := Q.Fields[0].AsInteger;
  finally
    Q.Close;
    Q.Free;
  end;
end;

procedure TfrmMain.ExternalLinkClick(Sender: TObject);
var
  S: string;
begin
  try
    S := (Sender as TMenuItem).Hint;
    if LeftStr((Sender as TMenuItem).Hint, 4) = 'www.' then
      S := 'http://' + S;
    OpenURL(S);
  finally
  end;
end;

procedure ComboBoxExit(Sender: TCombobox);
begin
  try
    (Sender as TComboBox).Font.Style := [];
    (Sender as TCombobox).SelLength := 0;
  except
  end;
end;

procedure SetNodeHeight(Sender: TLazVirtualStringTree);
var
  Node: PVirtualNode;
begin
  if Sender.TotalCount = 0 then Exit;
  Sender.BeginUpdate;
  try
    Sender.Font.Size := frmSettings.spiGridFontSize.Value;
    for Node in Sender.Nodes() do
      Sender.NodeHeight[Node] :=
        Round(Sender.Font.Size * 1.7 * ScreenRatio / 100) + 1;
  finally
    Sender.EndUpdate;
  end;
end;

function GetLang: string;
var
  T: string; // unused FallBackLang
  i: integer;
begin
  try
    Result := '';
    { We use the same method that is used in LCLTranslator unit }

    for i := 1 to Paramcount - 1 do
      if (ParamStrUTF8(i) = '--LANG') or (ParamStrUTF8(i) = '-l') or
        (ParamStrUTF8(i) = '--lang') then
        Result := ParamStrUTF8(i + 1);

    //Win32 user may decide to override locale with LANG variable.
    if Result = '' then
      Result := GetEnvironmentVariableUTF8('LANG');

    if Result = '' then
      GetLanguageIDs(Result, {%H-}T);

  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

function CheckForbiddenChar(Sender: TObject): boolean;
var
  I: integer;
begin
  Result := False;
  try
    if Sender.ClassType = TEdit then
    begin
      I := UTF8Pos('•', (Sender as TEdit).Text);
      if I > 0 then
      begin
        ShowMessage(AnsiReplaceStr(Error_06, '%', UTF8Copy(
          (Sender as TEdit).Text, I, 1)));
        (Sender as TEdit).SetFocus;
        (Sender as TEdit).SelStart := I - 1;
        (Sender as TEdit).SelLength := 1;
        Result := True;
      end;
    end
    else if Sender.ClassType = TMemo then
    begin
      I := UTF8Pos('•', (Sender as TMemo).Text);
      if I > 0 then
      begin
        ShowMessage(AnsiReplaceStr(Error_06, '%', UTF8Copy(
          (Sender as TMemo).Text, I, 1)));
        (Sender as TMemo).SetFocus;
        (Sender as TMemo).SelStart := I - 1;
        (Sender as TMemo).SelLength := 1;
        Result := True;
      end;
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

function Brighten(AColor: TColor; Light: byte): TColor;
var
  H, S, L: word;
begin
  try
    H := 0;
    L := 0;
    S := 0;
    ColorRGBToHLS(AColor, H, L, S);
    Result := ColorHLSToRGB(H, Light, S); // 225
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure FillCategory(Component: TComboBox; Kind: byte);
var
  Q: TSQLQuery;
begin
  if frmMain.Conn.Connected = False then
    Exit;

  // setup components
  Q := TSQLQuery.Create(nil);
  Q.Transaction := frmMain.Tran;
  Q.DataBase := frmMain.Tran.DataBase;

  // *************************
  // UPDATE LIST OF CATEGORIES
  // *************************
  Component.Clear;
  try
    // GET SUBCATEGORIES ===========================================================================
    Q.SQL.Text := // query
      'SELECT ' + // select
      'cat_name ' + // category name
      'FROM categories ' + // from
      'WHERE cat_parent_ID = 0 ' + // where
      'AND cat_status < 2 ' + // status
      'AND ((cat_type IS NULL) OR (cat_type = 0) OR (cat_type = :KIND));';
    // type (0 = all, 1 = credit, 2 = debit, 3 = transfer)

    Q.Params.ParamByName('KIND').AsInteger :=
      IfThen(Kind = 0, 1, IfThen(Kind = 1, 2, 3));
    Q.Prepare;
    Q.Open;

    while not Q.EOF do
    begin
      Component.Items.Add(Q.Fields[0].AsString);
      Q.Next;
    end;
  finally
    Q.Close;
    Q.Free;
  end;
  if Component.Items.Count > 0 then
    Component.ItemIndex := 0;
end;

procedure FillSubcategory(Category: string; Component: TComboBox);
var
  Qy: TSQLQuery;
  slSort: TStringList;
begin
  if Length(Category) = 0 then
    Exit;

  // setup components
  slSort := TStringList.Create;
  Qy := TSQLQuery.Create(nil);
  Qy.Transaction := frmMain.Tran;
  Qy.DataBase := frmMain.Tran.DataBase;

  // ****************************
  // UPDATE LIST OF SUBCATEGORIES
  // ****************************

  Component.Clear;

  // GET SUBCATEGORIES ===========================================================================
  Qy.SQL.Text := // query
    'SELECT cat_name FROM categories ' + // select
    'WHERE cat_parent_name = :CATEGORY AND cat_parent_id > 0 and cat_status < 2;';
  Qy.Params.ParamByName('CATEGORY').AsString := Category;
  Qy.Prepare;
  Qy.Open;

  try
    while not Qy.EOF do
    begin
      slSort.Add(IfThen(frmSettings.chkDisplaySubCatCapital.Checked =
        True, AnsiUpperCase(Qy.Fields[0].AsString), Qy.Fields[0].AsString));
      Qy.Next;
    end;
    slSort.Sort;
  finally
    Qy.Close;
    Qy.Free;
  end;
  slSort.Insert(0, '*');

  Component.Items := slSort;
  Component.ItemIndex := 0;
  slSort.Free;
end;

procedure CheckAllNodes(VST: TLazVirtualStringTree);
var
  Node: PVirtualNode;
begin
  VST.BeginUpdate;
  try
    Node := VST.GetFirst;
    while Assigned(Node) do
    begin
      if VST.Tag = 1 then
        VST.CheckState[Node] := csCheckedNormal
      else
        VST.CheckState[Node] := csUncheckedNormal;
      Node := VST.GetNext(Node);
    end;
  finally
    VST.EndUpdate;
  end;
end;

procedure CopyVST(Sender: TLazVirtualStringTree);
var
  Cols, Col: byte; // Columns count
  slCopy: TStringList; // the content of the table (TListView as vsReport)
  R: string; // 1 row of the table
  Node: PVirtualNode;
begin
  try
    Cols := (Sender as TLazVirtualStringTree).Header.Columns.Count - 1;
    slCopy := TStringList.Create;
    R := '';

    // create header
    for Col := 1 to Cols do
      R := R + (Sender as TLazVirtualStringTree).Header.Columns[Col].Text +
        IfThen(Col < Cols, chr(9), '');
    slCopy.Add(R);

    // create body
    for Node in (Sender as TLazVirtualStringTree).Nodes(False) do
    begin
      R := '';
      for Col := 1 to Cols do
        R := R + (Sender as TLazVirtualStringTree).Text[Node, Col] +
          IfThen(Col < Cols, chr(9), '');
      slCopy.Add(R);
    end;

    // send to the clipboard
    cb.AsText := slCopy.Text;
    slCopy.Free;
    ShowMessage(Format(Message_01,
      [IntToStr((Sender as TLazVirtualStringTree).TotalCount)]));
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure ShowErrorMessage(E: Exception);
begin
  try
    if UTF8Pos('unique', AnsiLowerCase(E.Message)) > 0 then
    begin
      ShowMessage(Error_03);
      Exit;
    end
    else
      ShowMessage(
        'Error message: ' + sLineBreak + E.Message + sLineBreak +
        sLineBreak + 'Error class: ' + sLineBreak + E.ClassName +
        sLineBreak + sLineBreak + 'Unit name: ' + sLineBreak + E.UnitName);
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

function Field(char, Str: string; Count: integer): string;
var
  sltempx: TStringList;
begin
  try
    Result := '';
    if Length(Str) = 0 then
      Exit;
    sltempx := TStringList.Create;
    sltempx.Text := AnsiReplaceStr(Str, char, chr(13));
    if Count <= sltempx.Count then
      Result := sltempx.Strings[Count - 1];
  except
    Result := '';
  end;
  sltempx.Free;
end;

procedure ComboDDWidth(ComboBox: TComboBox);
{$IFDEF WINDOWS}
var
  DDWidth: word;
  I: cardinal;
{$ENDIF}
begin
  {$IFDEF WINDOWS}
  try
    DDWidth := 0;
    if ComboBox.Items.Count = 0 then Exit;

    for I := 0 to ComboBox.Items.Count - 1 do
      if Combobox.Canvas.TextWidth(ComboBox.Items[I]) > DDWidth then
        DDWidth := Combobox.Canvas.TextWidth(ComboBox.Items[I]);


    if DDWidth - 30 > ComboBox.Width then
      SendMessage(ComboBox.Handle, CB_SETDROPPEDWIDTH, DDWidth + ScrollBarWidth + 30, 0);
  except
  end;
  {$ENDIF}
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
  I: byte;
  {$IFDEF WINDOWS}
  LibraryName: string;
  {$ENDIF}
begin
  Application.Title := 'RQ MONEY';

  // check the SQLite library in Linux
  {$IFDEF LINUX}
  try
    ScreenIndex := 1;
    Conn.GetConnectionInfo(citClientName);
  except
    begin
      ShowMessage(AnsiReplaceStr(Error_22, '%', sLineBreak));
      Application.Terminate;
    end;
  end;
  {$ENDIF}

  // check the SQL library in Windows
  {$IFDEF WINDOWS}
  ScreenIndex := 0;
  LibraryName := ExtractFileDir(Application.ExeName) + DirectorySeparator + 'sqlite3.dll';
  if FileExistsUTF8(LibraryName) = False then
  begin
    {$IFDEF WIN32}
    RenameFile(ExtractFileDir(Application.ExeName) + DirectorySeparator +
      'sqlite3.dll.32', LibraryName);
    {$ENDIF}
    {$IFDEF WIN64}
    RenameFile(ExtractFileDir(Application.ExeName) + DirectorySeparator +
      'sqlite3.dll.64', LibraryName);
    {$ENDIF}
    if FileExistsUTF8(LibraryName) = False then
    begin
      ShowMessage(ReplaceStr(Error_00, '%', sLineBreak) + sLineBreak +
        ExtractFileDir(Application.ExeName) + DirectorySeparator + 'sqlite3.dll');
      Application.Terminate;
    end;
  end;
  {$ENDIF}

  try
    frmMain.Caption := Application.Title;

    ScreenRatio := Round(Screen.PixelsPerInch / 96 * 100);
    // WINDOWS: 100 or 125 or 150 or 175
    // LINUX: 100 or 200

    // scrollbar width
    ScrollBarWidth := GetSystemMetrics(SM_CXVSCROLL) + 4;

    // don't allow updates during loading program or opening file
    AllowUpdateTransactions := False;

    od.InitialDir := ExtractFileDir(Application.ExeName);

    // set the date format
    Calendar.Date := Now;
    datDateFrom.Date := Now - 7;
    datDateTo.Date := Now;

    // set months in filter
    for I := 1 to 12 do
      cbxMonth.Items.Add(DefaultFormatSettings.LongMonthNames[I]);
    cbxMonth.Items.Insert(0, '*');
    cbxMonth.ItemIndex := 0;
    btnMonthMinus.Enabled := cbxMonth.ItemIndex > 0;
    btnMonthPlus.Enabled := cbxMonth.ItemIndex < cbxMonth.Items.Count - 1;

    // amount
    cbxMin.Items.Add('');
    cbxMin.Items.Add('>=');
    cbxMin.Items.Add('>');
    cbxMin.Items.Add('=');
    cbxMax.Items.Add('');
    cbxMax.Items.Add('<=');
    cbxMax.Items.Add('<');

    // filters
    f_type := 'd_type LIKE "%" ';
    pnlType.Hint := '';
    f_date := '';
    pnlDate.Hint := '';

    imgArrows.GetBitmap(0, imgDate.Picture.Bitmap);
    imgArrows.GetBitmap(0, imgCurrency.Picture.Bitmap);
    imgArrows.GetBitmap(0, imgAccount.Picture.Bitmap);
    imgArrows.GetBitmap(0, imgComment.Picture.Bitmap);
    imgArrows.GetBitmap(0, imgCategory.Picture.Bitmap);
    imgArrows.GetBitmap(0, imgAmount.Picture.Bitmap);
    imgArrows.GetBitmap(0, imgPerson.Picture.Bitmap);
    imgArrows.GetBitmap(0, imgPayee.Picture.Bitmap);
    imgArrows.GetBitmap(0, imgTag.Picture.Bitmap);
    imgArrows.GetBitmap(2, imgDay.Picture.Bitmap);
    imgArrows.GetBitmap(2, imgMonthYear.Picture.Bitmap);
    imgArrows.GetBitmap(2, imgPeriod.Picture.Bitmap);

    // clear filter (include Update transactions)
    frmMain.popFilterClear.Tag := 1;
    frmMain.popFilterClearClick(frmMain.popFilterClear);

    // set components height
    //ProgramFontSize := Abs(GetFontData(frmMain.Font.Handle).Height) + 4;
    PanelHeight := Round(18 * ScreenRatio / 100);
    ButtonHeight := Round(22 * ScreenRatio / 100 + 4);

    VST.Header.Height := PanelHeight;
    VSTSummary.Header.Height := PanelHeight;
    VSTSummaries.Header.Height := PanelHeight;
    VSTBalance.Header.Height := PanelHeight;
    VSTChrono.Header.Height := PanelHeight;
    VSTCross.Header.Height := PanelHeight;

    pnlFilterCaption.Height := PanelHeight;
    pnlListCaption.Height := PanelHeight;
    pnlSummaryCaption.Height := PanelHeight;
    pnlReportCaption.Height := PanelHeight;

    pnlButtons.Height := ButtonHeight;
    pnlBottom.Height := ButtonHeight;
    frmMain.pnlReportButtons.Height := ButtonHeight;

    pnlAccountCaption.Height := PanelHeight;
    pnlTypeCaption.Height := PanelHeight;
    pnlDateCaption.Height := PanelHeight;
    pnlCurrencyCaption.Height := PanelHeight;
    pnlAmountCaption.Height := PanelHeight;
    pnlTagCaption.Height := PanelHeight;
    pnlCommentCaption.Height := PanelHeight;
    pnlPersonCaption.Height := PanelHeight;
    pnlPayeeCaption.Height := PanelHeight;
    pnlCategoryCaption.Height := PanelHeight;
    pnlDayCaption.Height := PanelHeight;
    pnlMonthYearCaption.Height := PanelHeight;
    pnlPeriodCaption.Height := PanelHeight;
    tabBalanceHeader.Height := PanelHeight + 2;
    tabChronoHeader.Height := PanelHeight + 2;
    tabCurrency.Height := PanelHeight + 2;
    serBalanceCredits.Transparency := 75;
    tabCrossLeft.Height := PanelHeight + 2;
    tabCrossTop.Height := PanelHeight + 2;

    // set tabs reports
    tabReports.TabIndex := 0;
    tabBalanceHeader.TabIndex := 0;
    tabChronoHeader.TabIndex := 0;
    tabCrossTop.TabIndex := 0;
    tabCrossLeft.TabIndex := 0;
    tabBalanceShow.TabIndex := 0;

    tabCrossLeft.Tabs[0].Text := ' * ';
    cb := TClipboard.Create;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmMain.btnEditClick(Sender: TObject);
var
  ID: integer;
  P: PVirtualNode;
  Transaction: PTransactions;
begin
  if (Conn.Connected = False) or (pnlReport.Visible = True) then
    Exit;

  try
    case VST.SelectedCount of
      0: Exit;
      1: begin
        // check date restrictions
        if frmSettings.rbtTransactionsEditDate.Checked = True then
        begin
          P := VST.GetFirstSelected();
          Transaction := VST.GetNodeData(P);
          if Transaction.Date < FormatDateTime('YYYY-MM-DD',
            frmSettings.datTransactionsEditDate.Date) then
          begin
            ShowMessage(Error_30 + ' ' + DateToStr(
              frmSettings.datTransactionsEditDate.Date) + sLineBreak + Error_28);
            Exit;
          end;
        end;

        // check days restrictions
        if frmSettings.rbtTransactionsAddDays.Checked = True then
        begin
          P := VST.GetFirstSelected();
          Transaction := VST.GetNodeData(P);
          if Transaction.Date < FormatDateTime('YYYY-MM-DD',
            Round(Now - frmSettings.spiTransactionsEditDays.Value)) then
          begin
            ShowMessage(Error_30 + ' ' + DateToStr(
              Round(Now - frmSettings.spiTransactionsEditDays.Value)) +
              sLineBreak + Error_28);
            Exit;
          end;
        end;
        frmEdit.Tag := 1;
        ID := StrToInt(VST.Text[VST.GetFirstSelected(), 10]);

        if frmEdit.ShowModal <> mrOk then
          Exit;
      end;
      else
      begin
        // check date restrictions
        if frmSettings.rbtTransactionsEditDate.Checked = True then
        begin
          P := VST.GetFirstSelected();
          while Assigned(P) do
          begin
            Transaction := VST.GetNodeData(P);
            if Transaction.Date < FormatDateTime('YYYY-MM-DD',
              frmSettings.datTransactionsEditDate.Date) then
            begin
              ShowMessage(Error_30 + ' ' + DateToStr(
                frmSettings.datTransactionsEditDate.Date) + sLineBreak + Error_28);
              Exit;
            end;
            P := VST.GetNextSelected(P);
          end;
        end;

        // check days restrictions
        if frmSettings.rbtTransactionsEditDays.Checked = True then
        begin
          P := VST.GetFirstSelected();
          while Assigned(P) do
          begin
            Transaction := VST.GetNodeData(P);
            if Transaction.Date < FormatDateTime('YYYY-MM-DD',
              Round(Now - frmSettings.spiTransactionsEditDays.Value)) then
            begin
              ShowMessage(Error_30 + ' ' + DateToStr(
                Round(Now - frmSettings.spiTransactionsEditDays.Value)) +
                sLineBreak + Error_28);
              Exit;
            end;
            P := VST.GetNextSelected(P);
          end;
        end;


        frmEdits.Tag := 1;
        ID := 0;
        frmEdits.btnResetClick(frmEdits.btnReset);
        if frmEdits.ShowModal <> mrOk then
          Exit;
      end;
    end;

    UpdateTransactions;

    if ID > 0 then
      FindEditedRecord(VST, 10, ID);
    VST.SetFocus;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

{procedure TfrmMain.popPrintAccountBookClick(Sender: TObject);
var
  S: string;

begin
  if cbxAccount.ItemIndex < 1 then
  begin
    ShowMessage(Errors.Items[16]);
    Exit;
  end;

  btnPrint.Tag := 104;
  btnPrint.Caption := popPrintAccountBook.Caption;
  try
    If FileExists(ExtractFileDir(Application.ExeName) + DirectorySeparator +
      'Templates' + DirectorySeparator + 'account_book.lrf') = False then begin
      ShowMessage (frmMain.Errors.Items[14] + sLineBreak +
        ExtractFileDir(Application.ExeName) + DirectorySeparator + 'Templates' + DirectorySeparator + 'account_book.lrf');
      Exit;
    end;

    frmMain.Dataset.Tag := 104;

    S := AnsiReplaceStr(lblSumStart.Caption, FS_own.ThousandSeparator, '');
    TryStrToFloat(S, Balance);

    frmMain.Report.LoadFromFile(ExtractFileDir(Application.ExeName) + DirectorySeparator +
      'Templates' + DirectorySeparator + 'account_book.lrf');

    // header
    frmMain.Report.FindObject('AccountBookHeader').Memo.Text := AnsiUpperCase(popPrintAccountBook.Caption);
    frmMain.Report.FindObject('Account').Memo.Text := AnsiUpperCase(cbxAccount.Items[cbxAccount.ItemIndex]);
    Report.Title := AnsiUpperCase(Application.Title + ' - ' + popPrintAccountBook.Caption);
    frmMain.Report.FindObject('lblStart').Memo.Text := AnsiUpperCase(Caption_37]);
    frmMain.Report.FindObject('lblStartAmount').Memo.Text := frmMain.lblSumStart.Caption + ' ' +
      cbxSummaryCurrency.Items[cbxSummaryCurrency.ItemIndex];
    frmMain.Report.FindObject('BalanceHeader').Memo.Text := AnsiUpperCase(Caption_36]);
    frmMain.Report.FindObject('CurrentBalance').Memo.Text := frmMain.lblSumEnd.Caption + ' ' +
          cbxSummaryCurrency.Items[cbxSummaryCurrency.ItemIndex];
    frmMain.Report.FindObject('FilterX').Memo.Text := pnlFilterCaption.Caption + ': ' + pnlListCaption.Caption;

    // captions
    frmMain.Report.FindObject('lblDate').Memo.Text := AnsiUpperCase(pnlDateCaption.Caption);
    frmMain.Report.FindObject('lblAmount').Memo.Text := AnsiUpperCase(pnlAmountCaption.Caption);
    frmMain.Report.FindObject('lblComment').Memo.Text := AnsiUpperCase(pnlCommentCaption.Caption);
    frmMain.Report.FindObject('lblCategory').Memo.Text := AnsiUpperCase(pnlCategoryCaption.Caption);
    frmMain.Report.FindObject('lblPerson').Memo.Text := AnsiUpperCase(pnlPersonCaption.Caption);
    frmMain.Report.FindObject('lblPayee').Memo.Text := AnsiUpperCase(pnlPayeeCaption.Caption);
    frmMain.Report.FindObject('lblBalance').Memo.Text := AnsiUpperCase(Caption_35]);

    // footer
    frmMain.Report.FindObject('lblFooter').Memo.Text :=
      AnsiUpperCase(Application.Title + ' - ' + popPrintAccountBook.Caption);


    frmMain.Report.ShowReport;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end; }

procedure TfrmMain.mnuPersonsClick(Sender: TObject);
begin
  frmPersons.ShowModal;
end;

procedure TfrmMain.mnuSchedulersClick(Sender: TObject);
begin
  frmSchedulers.ShowModal;
end;

procedure TfrmMain.mnuSettingsClick(Sender: TObject);
begin
  frmSettings.ShowModal;
end;

procedure TfrmMain.mnuImportClick(Sender: TObject);
begin
  if (Conn.Connected = False) or (frmImport.ShowModal <> mrOk) then
    Exit;
  try
    AllowUpdateTransactions := True;
    UpdateTransactions;
    UpdateScheduler;
    UpdatePayments;
    UpdateLinks;

    if frmWrite.VST.CheckedCount > 0 then
      frmWrite.ShowModal
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmMain.splBalanceCanResize(Sender: TObject; var NewSize: integer;
  var Accept: boolean);
begin
  try
    imgWidth.ImageIndex := 10;
    lblWidth.Caption := IntToStr(chaBalance.Height);

    imgHeight.ImageIndex := 11;
    lblHeight.Caption := IntToStr(pnlReport.Height - chaBalance.Height);
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmMain.splSummaryCanResize(Sender: TObject; var NewSize: integer;
  var Accept: boolean);
begin
  try
    imgWidth.ImageIndex := 10;
    lblWidth.Caption := IntToStr(pnlSummary.Height);

    imgHeight.ImageIndex := 11;
    lblHeight.Caption := IntToStr(frmMain.Height - pnlSummary.Height);

  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmMain.splFilterCanResize(Sender: TObject; var NewSize: integer;
  var Accept: boolean);
begin
  try
    imgWidth.ImageIndex := 3;
    lblWidth.Caption := IntToStr(pnlFilter.Width);

    imgHeight.ImageIndex := 2;
    lblHeight.Caption := IntToStr(frmMain.Width - pnlFilter.Width);

    pnlListCaption.Repaint;
    pnlSummaryCaption.Repaint;
    scrFilter.Visible := pnlFilter.Width > 2;
    pnlFilterCaption.Visible := pnlFilter.Width > 2;
    pnlFilterCaption.Repaint;
    pnlReportCaption.Repaint;
    Calendar.Repaint;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmMain.tabBalanceHeaderChange(Sender: TObject);
var
  Balance: PBalance;
  P: PVirtualNode;
  C, D, TP, TM: double;
  _select, _group: string;
  I, J: integer;
begin
  if (pnlReport.Visible = False) then
    Exit;

  C := 0.0;
  D := 0.0;
  TP := 0.0;
  TM := 0.0;

  //clear previous summary data
  VSTBalance.Clear;
  VSTBalance.RootNodeCount := 0;

  try
    case tabBalanceHeader.TabIndex of
      0: begin // currencies
        VSTBalance.Header.Columns[1].Text := AnsiReplaceStr(Menu_23, '&', '');
        _select :=
          'acc_currency, (SELECT cur_name FROM currencies WHERE cur_code = acc_currency) as name, acc_currency, ';
        _group := 'acc_currency, name ';
      end;

      1: begin // account
        VSTBalance.Header.Columns[1].Text := AnsiReplaceStr(Menu_26, '&', '');
        _select := 'acc_currency, acc_name, acc_id, ';
        _group := 'acc_currency, acc_name, acc_id ';

      end;

      2: begin // categories
        VSTBalance.Header.Columns[1].Text := AnsiReplaceStr(Menu_27, '&', '');
        _select :=
          'cat_parent_name, CASE WHEN cat_parent_id = 0 THEN "" ELSE cat_name END as cat_name, cat_parent_id, ';
        _group := 'cat_parent_id, cat_parent_name, cat_name ';
      end;

      3: begin // persons
        VSTBalance.Header.Columns[1].Text := AnsiReplaceStr(Menu_28, '&', '');
        _select := 'per_name, "", "", ';
        _group := 'per_name ';
      end;

      4: begin // payees
        VSTBalance.Header.Columns[1].Text := AnsiReplaceStr(Menu_24, '&', '');
        _select := 'pee_name, "", "",';
        _group := 'pee_name ';
      end;
    end;
  except
  end;

  // ==================================================================
  if (frmMain.Conn.Connected = False) then
  begin
    btnReportCopy.Enabled := False;
    btnReportPrint.Enabled := False;
    Exit;
  end;

  try
    Screen.Cursor := crHourGlass;
    Application.ProcessMessages;

    frmMain.QRY.SQL.Text :=
      AnsiReplaceStr('SELECT ' + _select + sLineBreak + //_select
      'TOTAL (CASE WHEN d_type = 0 THEN d_sum ELSE 0.00 END) as c, ' +
      sLineBreak + // credits
      'TOTAL (CASE WHEN d_type = 1 THEN d_sum ELSE 0.00 END) as d, ' +
      sLineBreak + // debits
      'TOTAL (CASE WHEN d_type = 2 THEN d_sum ELSE 0.00 END) as p, ' +
      sLineBreak + // transfers +
      'TOTAL (CASE WHEN d_type = 3 THEN d_sum ELSE 0.00 END) as m ' +
      sLineBreak + // transfers -
      'FROM data ' + sLineBreak +// FROM tables
      'LEFT JOIN accounts ON (acc_id = d_account) ' + sLineBreak +// accounts
      'LEFT JOIN categories ON (cat_id = d_category) ' + sLineBreak +// categories
      'LEFT JOIN persons ON (per_id = d_person) ' + sLineBreak +// persons
      'LEFT JOIN payees ON (pee_id = d_payee) ' + sLineBreak +// payees
      'WHERE ' +  // where clausule
      f_type + sLineBreak + // type filter
      f_date + sLineBreak + // date filter
      f_currency + sLineBreak + // currency filter
      f_account + sLineBreak + // account filter
      f_amount + sLineBreak +  // amount filter
      f_comment + sLineBreak + // comment filter
      f_category + sLineBreak + // category filter
      f_subcategory + sLineBreak + // subcategory filter
      f_person + sLineBreak + // person filter
      f_payee + sLineBreak + // payee filter
      f_tag +  // tag filter
      'GROUP BY ' + _group + // group
      IfThen(frmSettings.chkChartZeroBalance.Checked = True, '',
      sLineBreak + 'HAVING c <> 0 OR d <> 0 or p <> 0 OR m <> 0;'),
      '_status = 0', '_status < 2');
    // show passive records also

    frmMain.QRY.Open;
    VSTBalance.BeginUpdate;

    // --------------------------------------------------------------------------------------
    while not (frmMain.QRY.EOF) do
    begin
      VSTBalance.RootNodeCount := VSTBalance.RootNodeCount + 1;
      P := VSTBalance.GetLast();
      Balance := VSTBalance.GetNodeData(P);
      Balance.Name1 := frmMain.QRY.Fields[0].AsString;
      Balance.Name2 := frmMain.QRY.Fields[1].AsString;
      Balance.Credit := frmMain.QRY.Fields[3].AsFloat; // credit
      C := C + Balance.Credit;
      Balance.Debit := frmMain.QRY.Fields[4].AsFloat; // debit
      D := D + Balance.Debit;
      Balance.TransferP := frmMain.QRY.Fields[5].AsFloat; // transfer +
      TP := TP + Balance.TransferP;
      Balance.TransferM := frmMain.QRY.Fields[6].AsFloat; // transfer -
      TM := TM + Balance.TransferM;
      frmMain.QRY.Next;
    end;
    frmMain.QRY.Close;
    chaBalance.Hint := IfThen(VSTBalance.RootNodeCount > 0,
      IntToStr(VSTBalance.RootNodeCount) + ' ' + Chart_08 + sLineBreak +
      '[' + Chart_02 + ']', '');

    // add Balance row
    VSTBalance.InsertNode(VSTBalance.GetFirst(), amInsertBefore);
    P := VSTBalance.GetFirst();
    Balance := VSTBalance.GetNodeData(P);
    Balance.Name1 := AnsiUpperCase(Caption_16);
    Balance.Credit := C;
    Balance.Debit := D;
    Balance.TransferP := TP;
    Balance.TransferM := TM;

    // sort summary table
    VSTBalance.Header.SortDirection := sdAscending;
    VSTBalance.Header.SortColumn := 1;
    VSTBalance.SortTree(1, sdAscending);
    SetNodeHeight(VSTBalance);

  finally
    VSTBalance.EndUpdate;
    lblItems.Caption := IntToStr(VSTBalance.TotalCount);
    btnReportCopy.Enabled := VSTBalance.RootNodeCount > 0;
    btnReportPrint.Enabled := VSTBalance.RootNodeCount > 0;
  end;

  // ===========================================================
  // CHART
  // ===========================================================

  try
    souBalanceCredits.Clear;
    souBalanceDebits.Clear;

    I := 0;
    J := 0;
    P := VSTBalance.GetFirst();

    while Assigned(P) do
    begin
      Balance := VSTBalance.GetNodeData(P);
      if (I > 0) and ((frmSettings.chkChartZeroBalance.Checked = True) or
        ((frmSettings.chkChartZeroBalance.Checked = False) and
        (Balance.Credit <> 0) or (Balance.Debit <> 0) or
        (Balance.TransferP <> 0) or (Balance.TransferM <> 0))) then
      begin
        _select := IfThen(Balance.Name2 = '', Balance.Name1, Balance.Name1 +
          IfThen(frmSettings.chkChartWrapLabelsText.Checked = False,
          separ_1, sLineBreak) + Balance.Name2);

        // credits
        souBalanceCredits.XCount := J + 1;
        souBalanceCredits.YCount := 2;
        souBalanceCredits.AddXYList(J, [Balance.Credit, Balance.TransferP], _select);

        // debits
        souBalanceDebits.XCount := J + 1;
        souBalanceDebits.YCount := 2;
        souBalanceDebits.AddXYList(J, [-Balance.Debit, -Balance.TransferM], _select);

        Inc(J);
        chaBalance.BottomAxis.Marks.Source := souBalanceCredits;
      end;
      Inc(I);
      P := VSTBalance.GetNext(P);
    end;
  except
  end;
  Screen.Cursor := crDefault;
end;

procedure TfrmMain.tabBalanceShowChange(Sender: TObject);
begin
  if pnlReport.Visible = False then
    Exit;

  VSTBalance.Visible := tabBalanceShow.TabIndex = 0;
  chaBalance.Visible := tabBalanceShow.TabIndex = 1;
end;

procedure TfrmMain.tabChronoHeaderChange(Sender: TObject);
var
  DateFrom, DateTo, Interval: string;
  //  LimitedDate: boolean;
  Summary: PSummary;
  P: PVirtualNode;
  AA, SS, C, D, TP, TM: double;
  I: integer;
begin
  if frmMain.Visible = False then
    Exit;

  SS := 0;
  C := 0;
  D := 0;
  TP := 0;
  TM := 0;

  //clear previous chrono data
  frmMain.VSTChrono.Clear;
  frmMain.VSTChrono.RootNodeCount := 0;
  if (Conn.Connected = False) then
    Exit;

  Screen.Cursor := crHourGlass;
  Application.ProcessMessages;

  try
    DateFrom := '1900-01-01';
    DateTo := '2222-12-31';

    // =============================================================================================
    // Date
    if frmMain.pnlDayCaption.Tag = 1 then
    begin
      DateFrom := FormatDateTime('yyyy-mm-dd', frmMain.Calendar.Date);
      DateTo := DateFrom;
      //    LimitedDate := True;
    end

    // Month - Year
    else if frmMain.pnlMonthYearCaption.Tag = 1 then
    begin
      if frmMain.cbxYear.ItemIndex = 0 then
      begin
        //      LimitedDate := False;
        DateFrom := '1900-01-01';
        DateTo := '2222-12-31';
      end
      else
      begin
        //      LimitedDate := True;
        if frmMain.cbxMonth.ItemIndex = 0 then
        begin
          DateFrom := frmMain.cbxYear.Text + '-01-01';
          DateTo := frmMain.cbxYear.Text + '-12-31';
        end
        else
        begin
          DateFrom := frmMain.cbxYear.Text + '-' +
            RightStr('0' + IntToStr(frmMain.cbxMonth.ItemIndex), 2) + '-01';
          DateTo := frmMain.cbxYear.Text + '-' +
            RightStr('0' + IntToStr(frmMain.cbxMonth.ItemIndex), 2) +
            '-' + IntToStr(DaysInAMonth(StrToInt(frmMain.cbxYear.Text),
            frmMain.cbxMonth.ItemIndex));
        end;
      end;
    end

    // Period
    else if frmMain.pnlPeriodCaption.Tag = 1 then
    begin
      //    LimitedDate := True;
      DateFrom := FormatDateTime('yyyy-mm-dd', frmMain.datDateFrom.Date);
      DateTo := FormatDateTime('yyyy-mm-dd', frmMain.datDateTo.Date);
    end;

  except
    begin
      DateFrom := '1900-01-01';
      DateTo := '2222-12-31';
    end;
  end;

  case tabChronoHeader.TabIndex of
    0: interval := '%Y-%w", d_date'; // days of week 0-6 with Sunday==0
    1: interval := '%Y-%d", d_date'; // days of month: 00-31
    2: interval := '%Y-%j", d_date'; // days of year: 001-366
    3: interval := '%Y-%W", d_date'; // week of year: 00-53
    4: Interval := '%Y-%m", d_date'; // month: 01-12
    5: Interval :=
        '%Y-", d_date) || replace(round((strftime("%m", d_date) + 2) / 3), ".0", ""';
    6: Interval := '%Y", d_date'; // year: 0000-9999
  end;

  // get starting sum
  try
    frmMain.QRY.SQL.Text :=
      'SELECT TOTAL(acc_amount),' + sLineBreak + '(SELECT TOTAL(d_sum) FROM data ' +
      sLineBreak + 'LEFT JOIN accounts ON (acc_id = d_account) ' +
      sLineBreak + // accounts
      'WHERE d_date < "' + dateFrom + '" ' + f_account + f_currency +
      ') ' + sLineBreak + 'FROM accounts ' + sLineBreak + 'WHERE acc_date <= "' +
      DateTo + '" ' + f_account + f_currency + ';';
    // starting sum
    frmMain.QRY.Open;
    while not (frmMain.QRY.EOF) do
    begin
      SS := frmMain.QRY.Fields[0].AsFloat + frmMain.QRY.Fields[1].AsFloat;
      AA := SS;
      frmMain.QRY.Next;
    end;
    frmMain.QRY.Close;
  except
  end;

  // get data
  frmMain.QRY.SQL.Text := AnsiReplaceStr('SELECT STRFTIME("' + Interval +
    ') as interval, ' + sLineBreak + //_select
    'TOTAL (CASE WHEN d_type = 0 THEN d_sum ELSE 0.00 END) as c, ' +
    sLineBreak + // credits
    'TOTAL (CASE WHEN d_type = 1 THEN d_sum ELSE 0.00 END) as d, ' +
    sLineBreak + // debits
    'TOTAL (CASE WHEN d_type = 2 THEN d_sum ELSE 0.00 END) as p, ' +
    sLineBreak + // transfers +
    'TOTAL (CASE WHEN d_type = 3 THEN d_sum ELSE 0.00 END) as m ' +
    sLineBreak + // transfers -
    'FROM data ' + sLineBreak + // FROM tables
    'LEFT JOIN accounts ON (acc_id = d_account) ' + sLineBreak + // accounts
    'LEFT JOIN categories ON (cat_id = d_category) ' + sLineBreak + // categories
    'LEFT JOIN persons ON (per_id = d_person) ' + sLineBreak + // persons
    'LEFT JOIN payees ON (pee_id = d_payee) ' + sLineBreak + // payees
    'WHERE ' +  // where clausule
    f_type + sLineBreak + // type filter
    f_date + sLineBreak + // date filter
    f_currency + sLineBreak + // currency filter
    f_account + sLineBreak + // account filter
    f_amount + sLineBreak +  // amount filter
    f_comment + sLineBreak + // comment filter
    f_category + sLineBreak + // category filter
    f_subcategory + sLineBreak + // subcategory filter
    f_person + sLineBreak + // person filter
    f_payee + sLineBreak + // payee filter
    f_tag +  // tag filter
    'GROUP BY interval', '_status = 0', '_status < 2'); // group

  frmMain.QRY.Open;
  VSTChrono.BeginUpdate;

  // --------------------------------------------------------------------------------------
  try
    while not (frmMain.QRY.EOF) do
    begin
      frmMain.VSTChrono.RootNodeCount := frmMain.VSTChrono.RootNodeCount + 1;
      P := frmMain.VSTChrono.GetLast();
      Summary := frmMain.VSTChrono.GetNodeData(P);
      TryStrToInt(RightStr(frmMain.QRY.Fields[0].AsString, 1), I);

      if tabChronoHeader.TabIndex = 0 then
        Summary.Account := frmMain.QRY.Fields[0].AsString + ' (' +
          AnsiLowerCase(DefaultFormatSettings.ShortDayNames[I + 1]) + ')'
      else
        Summary.Account := frmMain.QRY.Fields[0].AsString;

      Summary.StartSum := SS;

      Summary.Credit := frmMain.QRY.Fields[1].AsFloat; // credit
      C := C + Summary.Credit;
      Summary.Debit := frmMain.QRY.Fields[2].AsFloat; // debit
      D := D + Summary.Debit;
      Summary.TransferP := frmMain.QRY.Fields[3].AsFloat; // transfer +
      TP := TP + Summary.TransferP;
      Summary.TransferM := frmMain.QRY.Fields[4].AsFloat; // transfer -
      TM := TM + Summary.TransferM;

      SS := Summary.StartSum + frmMain.QRY.Fields[1].AsFloat +
        frmMain.QRY.Fields[2].AsFloat + frmMain.QRY.Fields[3].AsFloat +
        frmMain.QRY.Fields[4].AsFloat;
      frmMain.QRY.Next;
    end;
    frmMain.QRY.Close;

    // add summary row
    frmMain.VSTChrono.InsertNode(frmMain.VSTChrono.GetFirst(), amInsertBefore);
    P := frmMain.VSTChrono.GetFirst();
    Summary := frmMain.VSTChrono.GetNodeData(P);
    Summary.Account := AnsiUpperCase(Caption_16);
    Summary.StartSum := AA;
    Summary.Credit := C;
    Summary.Debit := D;
    Summary.TransferP := TP;
    Summary.TransferM := TM;

    serChronoStart.ShowPoints := popChartChronoShowPoints.Checked;
    serChronoCredits.ShowPoints := popChartChronoShowPoints.Checked;
    serChronoDebits.ShowPoints := popChartChronoShowPoints.Checked;
    serChronoTPlus.ShowPoints := popChartChronoShowPoints.Checked;
    serChronoTMinus.ShowPoints := popChartChronoShowPoints.Checked;
    serChronoBalance.ShowPoints := popChartChronoShowPoints.Checked;
    serChronoTotal.ShowPoints := popChartChronoShowPoints.Checked;

    serChronoStart.marks.Visible := popChartChronoShowMarks.Checked;
    serChronoCredits.marks.Visible := popChartChronoShowMarks.Checked;
    serChronoDebits.marks.Visible := popChartChronoShowMarks.Checked;
    serChronoTPlus.marks.Visible := popChartChronoShowMarks.Checked;
    serChronoTMinus.marks.Visible := popChartChronoShowMarks.Checked;
    serChronoBalance.marks.Visible := popChartChronoShowMarks.Checked;
    serChronoTotal.marks.Visible := popChartChronoShowMarks.Checked;
  finally
    SetNodeHeight(VSTChrono);
    VSTChrono.EndUpdate;
  end;
  lblItems.Caption := IntToStr(VSTChrono.TotalCount);
  Screen.Cursor := crDefault;

  // =======================================================
  // DRAW CHART
  // =======================================================
  serChronoStart.Clear;
  serChronoCredits.Clear;
  serChronoDebits.Clear;
  serChronoTPlus.Clear;
  serChronoTMinus.Clear;
  serChronoBalance.Clear;
  serChronoTotal.Clear;
  souChrono.Clear;

  if (VSTChrono.RootNodeCount < 1) then
    Exit;

  try
    P := VSTChrono.GetFirst();
    P := VSTChrono.GetNext(P);
    while Assigned(P) do
    begin
      Summary := VSTChrono.GetNodeData(P);
      if frmMain.popChartChrono1.Checked = True then
        serChronoStart.AddXY(P.Index, Summary.StartSum);
      serChronoStart.Legend.Visible := frmMain.popChartChrono1.Checked;

      if frmMain.popChartChrono2.Checked = True then
        serChronoCredits.AddXY(P.Index, Summary.Credit);
      serChronoCredits.Legend.Visible := frmMain.popChartChrono2.Checked;

      if frmMain.popChartChrono3.Checked = True then
        serChronoDebits.AddXY(P.Index, -Summary.Debit);
      serChronoDebits.Legend.Visible := frmMain.popChartChrono3.Checked;

      if frmMain.popChartChrono4.Checked = True then
        serChronoTPlus.AddXY(P.Index, Summary.TransferP);
      serChronoTPlus.Legend.Visible := frmMain.popChartChrono4.Checked;

      if frmMain.popChartChrono5.Checked = True then
        serChronoTMinus.AddXY(P.Index, -Summary.TransferM);
      serChronoTMinus.Legend.Visible := frmMain.popChartChrono5.Checked;

      if frmMain.popChartChrono6.Checked = True then
        serChronoBalance.AddXY(P.Index, Summary.Credit + Summary.Debit +
          Summary.TransferP + Summary.TransferM);
      serChronoBalance.Legend.Visible := frmMain.popChartChrono6.Checked;

      if frmMain.popChartChrono7.Checked = True then
        serChronoTotal.AddXY(P.Index, Summary.StartSum + Summary.Credit +
          Summary.Debit + Summary.TransferP + Summary.TransferM);
      serChronoTotal.Legend.Visible := frmMain.popChartChrono7.Checked;

      souChrono.Add(P.Index, 0.0, Summary.Account, 0);
      P := VSTChrono.GetNext(P);
    end;
  except
  end;
end;

procedure TfrmMain.tabCrossLeftChange(Sender: TObject);
var
  Balance, Balance1: PBalance;
  P, R: PVirtualNode;
  C, D, TP, TM: double;
  _select, _group, _where: string;
  Q: TSQLQuery;
begin
  if (frmMain.Visible = False) or (pnlReport.Visible = False) then
    Exit;

  try
    VSTCross.Clear;
    VSTCross.RootNodeCount := 0;
    VSTCross.Header.Columns[1].Text :=
      tabCrossTop.Tabs[tabCrossTop.TabIndex].Text + ' / ' +
      tabCrossLeft.Tabs[tabCrossLeft.TabIndex].Text;
  except
  end;

  if (Conn.Connected = False) then
  begin
    btnReportCopy.Enabled := False;
    btnReportPrint.Enabled := False;
    Exit;
  end;

  try
    Screen.Cursor := crHourGlass;
    Application.ProcessMessages;

    Q := TSQLQuery.Create(nil);
    Q.Transaction := Tran;
    Q.Database := Conn;

    C := 0.0;
    D := 0.0;
    TP := 0.0;
    TM := 0.0;

    //clear previous summary data
    VSTCross.Clear;
    VSTCross.RootNodeCount := 0;

    case tabCrossTop.TabIndex of
      0: begin // currencies
        _select :=
          'acc_currency, (SELECT cur_name FROM currencies WHERE cur_code = acc_currency) as name, acc_id, ';
        _group := 'acc_currency, name ';
      end;

      1: begin // account
        _select := 'acc_currency, acc_name, acc_id, ';
        _group := 'acc_currency, acc_name, acc_id ';
      end;

      2: begin // categories
        _select :=
          'cat_parent_name, "", cat_parent_id, ';
        _group := 'cat_parent_name ';
      end;

      3: begin // persons
        _select := 'per_name, "", per_id, ';
        _group := 'per_name ';
      end;

      4: begin // payees
        _select := 'pee_name, "", pee_id,';
        _group := 'pee_name ';
      end;
    end;

    frmMain.QRY.SQL.Text :=
      AnsiReplaceStr('SELECT ' + _select + sLineBreak + //_select
      'TOTAL (CASE WHEN d_type = 0 THEN d_sum ELSE 0.00 END) as c, ' +
      sLineBreak + // credits
      'TOTAL (CASE WHEN d_type = 1 THEN d_sum ELSE 0.00 END) as d, ' +
      sLineBreak + // debits
      'TOTAL (CASE WHEN d_type = 2 THEN d_sum ELSE 0.00 END) as p, ' +
      sLineBreak + // transfers +
      'TOTAL (CASE WHEN d_type = 3 THEN d_sum ELSE 0.00 END) as m ' +
      sLineBreak + // transfers -
      'FROM data ' + sLineBreak +// FROM tables
      'LEFT JOIN accounts ON (acc_id = d_account) ' + sLineBreak +// accounts
      'LEFT JOIN categories ON (cat_id = d_category) ' + sLineBreak +// categories
      'LEFT JOIN persons ON (per_id = d_person) ' + sLineBreak +// persons
      'LEFT JOIN payees ON (pee_id = d_payee) ' + sLineBreak +// payees
      'WHERE ' +  // where clausule
      f_type + sLineBreak + // type filter
      f_date + sLineBreak + // date filter
      f_currency + sLineBreak + // currency filter
      f_account + sLineBreak + // account filter
      f_amount + sLineBreak +  // amount filter
      f_comment + sLineBreak + // comment filter
      f_category + sLineBreak + // category filter
      f_subcategory + sLineBreak + // subcategory filter
      f_person + sLineBreak + // person filter
      f_payee + sLineBreak + // payee filter
      f_tag +  // tag filter
      'GROUP BY ' + _group + // group
      IfThen(frmSettings.chkChartZeroBalance.Checked = True, '',
      sLineBreak + 'HAVING c <> 0 OR d <> 0 or p <> 0 OR m <> 0;'),
      '_status = 0', '_status < 2');
    // show passive records also

    frmMain.QRY.Open;
    VSTCross.BeginUpdate;

    // --------------------------------------------------------------------------------------
    while not (frmMain.QRY.EOF) do
    begin
      VSTCross.RootNodeCount := VSTCross.RootNodeCount + 1;
      P := VSTCross.GetLast();
      Balance := VSTCross.GetNodeData(P);
      Balance.Name1 := frmMain.QRY.Fields[0].AsString;
      Balance.Name2 := frmMain.QRY.Fields[1].AsString;
      Balance.Credit := frmMain.QRY.Fields[3].AsFloat; // credit
      C := C + Balance.Credit;
      Balance.Debit := frmMain.QRY.Fields[4].AsFloat; // debit
      D := D + Balance.Debit;
      Balance.TransferP := frmMain.QRY.Fields[5].AsFloat; // transfer +
      TP := TP + Balance.TransferP;
      Balance.TransferM := frmMain.QRY.Fields[6].AsFloat; // transfer -
      TM := TM + Balance.TransferM;

      // ===========================================================================
      // insert subitems
      case tabCrossTop.TabIndex of
        0: _where := 'acc_currency '; // currencies
        1: _where := 'acc_currency '; // account
        2: _where := 'cat_parent_name '; // categories
        3: _where := 'per_name'; // persons
        4: _where := 'pee_name'; // payees
      end;

      if tabCrossLeft.TabIndex > 0 then
      begin
        case tabCrossLeft.TabIndex of
          1: begin // currencies
            _select :=
              'acc_currency, (SELECT cur_name FROM currencies WHERE cur_code = acc_currency) as name, ';
            _group := 'acc_currency, name ';
          end;

          2: begin // account
            _select := 'acc_currency, acc_name, ';
            _group := 'acc_currency, acc_name ';

          end;

          3: begin // categories
            _select := 'cat_parent_name, cat_parent_id, ';
            _group := 'cat_parent_name ';
          end;

          4: begin // subcategories
            _select := 'cat_parent_name, cat_name, ';
            _group := 'cat_parent_name, cat_name ';
          end;

          5: begin // persons
            _select := 'per_name, per_id, ';
            _group := 'per_name ';
          end;

          6: begin // payees
            _select := 'pee_name, pee_id, ';
            _group := 'pee_name ';
          end;
        end;

        Q.SQL.Text :=
          AnsiReplaceStr('SELECT ' + _select + sLineBreak + //_select
          'TOTAL (CASE WHEN d_type = 0 THEN d_sum ELSE 0.00 END) as c, ' +
          sLineBreak + // credits
          'TOTAL (CASE WHEN d_type = 1 THEN d_sum ELSE 0.00 END) as d, ' +
          sLineBreak + // debits
          'TOTAL (CASE WHEN d_type = 2 THEN d_sum ELSE 0.00 END) as p, ' +
          sLineBreak + // transfers +
          'TOTAL (CASE WHEN d_type = 3 THEN d_sum ELSE 0.00 END) as m ' + sLineBreak +
          // transfers -
          'FROM data ' + sLineBreak +// FROM tables
          'LEFT JOIN accounts ON (acc_id = d_account) ' + sLineBreak +// accounts
          'LEFT JOIN categories ON (cat_id = d_category) ' + sLineBreak +// categories
          'LEFT JOIN persons ON (per_id = d_person) ' + sLineBreak +// persons
          'LEFT JOIN payees ON (pee_id = d_payee) ' + sLineBreak +// payees
          'WHERE ' +  // where clausule
          f_type + sLineBreak + // type filter
          f_date + sLineBreak + // date filter
          f_currency + sLineBreak + // currency filter
          f_account + sLineBreak + // account filter
          f_amount + sLineBreak +  // amount filter
          f_comment + sLineBreak + // comment filter
          f_category + sLineBreak + // category filter
          f_subcategory + sLineBreak + // subcategory filter
          f_person + sLineBreak + // person filter
          f_payee + sLineBreak + // payee filter
          f_tag +  // tag filter
          ' AND ' + _where + ' = :WHERE ' + sLineBreak + // where1 condition
          'GROUP BY ' + _group + sLineBreak + // group
          'HAVING c <> 0 OR d <> 0 or p <> 0 OR m <> 0;', '_status = 0', '_status < 2');
        // show passive records also

        Q.Params.ParamByName('WHERE').AsString := frmMain.QRY.Fields[0].AsString;
        Q.Prepare;
        Q.Open;
        //ShowMessage(Q.SQL.Text + sLineBreak + IntToStr(Q.RecordCount));

        // --------------------------------------------------------------------------------------
        while not (Q.EOF) do
        begin
          {ShowMessage(
            frmMain.QRY.Fields[0].AsString + separ_1 + frmMain.QRY.Fields[1].AsString + sLineBreak +
            Q.Fields[0].AsString);}

          // child node (subcategory)
          VSTCross.ChildCount[P] := VSTCross.ChildCount[P] + 1;
          R := VSTCross.GetLastChild(P);
          Balance1 := VSTCross.GetNodeData(R);
          Balance1.Name1 := Q.Fields[0].AsString;
          Balance1.Name2 := Q.Fields[1].AsString;
          Balance1.Credit := Q.Fields[2].AsFloat; // credit
          Balance1.Debit := Q.Fields[3].AsFloat; // debit
          Balance1.TransferP := Q.Fields[4].AsFloat; // transfer +
          Balance1.TransferM := Q.Fields[5].AsFloat; // transfer -
          Q.Next;
        end;
        Q.Close;
      end;

      frmMain.QRY.Next;
    end;
    frmMain.QRY.Close;

    // add Balance summary row
    VSTCross.InsertNode(VSTCross.GetFirst(), amInsertBefore);
    P := VSTCross.GetFirst();
    Balance := VSTCross.GetNodeData(P);
    Balance.Name1 := AnsiUpperCase(Caption_16);
    Balance.Credit := C;
    Balance.Debit := D;
    Balance.TransferP := TP;
    Balance.TransferM := TM;

    // sort summary table
    VSTCross.Header.SortDirection := sdAscending;
    VSTCross.Header.SortColumn := 1;
    if VSTCross.TotalCount > 0 then
    begin
      VSTCross.SortTree(1, sdAscending);
      VSTCross.FullExpand();
    end;
    lblItems.Caption := IntToStr(VSTCross.TotalCount);

  finally
    Q.Free;
    Screen.Cursor := crDefault;
    SetNodeHeight(VSTCross);
    VSTCross.EndUpdate;
    Screen.Cursor := crDefault;
    btnReportCopy.Enabled := VSTCross.RootNodeCount > 0;
    btnReportPrint.Enabled := VSTCross.RootNodeCount > 0;
  end;
end;

procedure TfrmMain.tabCrossTopChange(Sender: TObject);
begin
  if (frmMain.Visible <> True) or (pnlReport.Visible = False) then
    Exit;

  try
    tabCrossLeft.Tabs[1].Options := tabCrossLeft.Tabs[1].Options + [etoVisible];
    // currency
    tabCrossLeft.Tabs[2].Options := tabCrossLeft.Tabs[2].Options + [etoVisible];
    // account
    tabCrossLeft.Tabs[3].Options := tabCrossLeft.Tabs[3].Options + [etoVisible];
    // category
    tabCrossLeft.Tabs[4].Options := tabCrossLeft.Tabs[4].Options + [etoVisible];
    // subcategory
    tabCrossLeft.Tabs[5].Options := tabCrossLeft.Tabs[5].Options + [etoVisible];
    // person
    tabCrossLeft.Tabs[6].Options := tabCrossLeft.Tabs[6].Options + [etoVisible]; // payee

    case tabCrossTop.TabIndex of
      0: tabCrossLeft.Tabs[1].Options := tabCrossLeft.Tabs[1].Options - [etoVisible];
      // currency
      1: tabCrossLeft.Tabs[2].Options := tabCrossLeft.Tabs[2].Options - [etoVisible];
      // account
      2: tabCrossLeft.Tabs[3].Options := tabCrossLeft.Tabs[3].Options - [etoVisible];
      // category
      3: tabCrossLeft.Tabs[5].Options := tabCrossLeft.Tabs[5].Options - [etoVisible];
      // person
      4: tabCrossLeft.Tabs[6].Options := tabCrossLeft.Tabs[6].Options - [etoVisible];
      // payee
    end;
  finally
    tabCrossLeft.TabIndex := 0;
    tabCrossLeftChange(tabCrossLeft);
  end;
end;

procedure TfrmMain.tabReportsChange(Sender: TObject);
begin
  try
    case tabReports.TabIndex of
      0: tabBalanceHeaderChange(tabBalanceHeader);
      1: tabChronoHeaderChange(tabChronoHeader);
      2: tabCrossTopChange(tabCrossTop);
    end;
  finally
    VSTSummaries.Visible := False;
  end;
end;

procedure TfrmMain.tabCurrencyChange(Sender: TObject);
begin
  UpdateSummary;
end;

procedure TfrmMain.tmrFirstRunTimer(Sender: TObject);
begin
  try
    if FirstRun = True then
    begin
      FirstRun := False;
      frmSettings.treSettings.Items[1].Selected := True;
      frmSettings.tabGlobal.TabIndex := 0;
      frmSettings.Left := (Screen.Width - frmSettings.Width) div 2;
      frmSettings.Top := ((Screen.Height - frmSettings.Height) div 2) - 75;
      frmSettings.ShowModal;
      tmrFirstRun.Enabled := False;
    end;
  except
  end;
end;

procedure TfrmMain.tmrTimer(Sender: TObject);
begin
  try
    tmr.Enabled := False;

    if (frmMain.Visible = True) and (Conn.Connected = True) then
    begin
      UpdatePayments;
      if frmWrite.VST.CheckedCount > 0 then
        frmWrite.ShowModal
      else
      if pnlReport.Visible = False then
        VST.SetFocus;
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmMain.VSTBalanceChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  Balance, Summaries: PBalance;
  B, S: PVirtualNode;
  C, D, P, M: double; // Credits, Debits, transfersPlus, transfersMinus
begin
  VSTSummaries.RootNodeCount := 0;
  VSTSummaries.Clear;

  VSTSummaries.Visible := (VSTBalance.SelectedCount > 1) and
    (VSTBalance.Selected[VSTBalance.GetFirst()] = False);

  if (VSTBalance.SelectedCount < 2) or
    (VSTBalance.Selected[VSTBalance.GetFirst()] = True) then
    Exit;

  try
    C := 0;
    D := 0;
    P := 0;
    M := 0;

    VSTSummaries.RootNodeCount := 2;
    S := VSTSummaries.GetFirst();
    Summaries := VSTSummaries.GetNodeData(S);

    B := VSTBalance.GetFirstSelected();
    while Assigned(B) do
    begin
      Balance := VSTBalance.GetNodeData(B);
      C := C + Balance.Credit;
      D := D + Balance.Debit;
      P := P + Balance.TransferP;
      M := M + Balance.TransferM;
      B := VSTBalance.GetNextSelected(B);
    end;

    Summaries.Credit := C;
    Summaries.Debit := D;
    Summaries.TransferP := P;
    Summaries.TransferM := M;

    S := VSTSummaries.GetNext(S);
    Summaries := VSTSummaries.GetNodeData(S);
    if VSTBalance.SelectedCount <> 0 then
    begin
      Summaries.Credit := RoundTo(C / VSTBalance.SelectedCount, -2);
      Summaries.Debit := RoundTo(D / VSTBalance.SelectedCount, -2);
      Summaries.TransferP := RoundTo(P / VSTBalance.SelectedCount, -2);
      Summaries.TransferM := RoundTo(M / VSTBalance.SelectedCount, -2);
    end;
    SetNodeHeight(VSTSummaries);

    // VSTSummaries size and position
    VSTSummaries.Left := 15 + VSTBalance.Header.Columns[1].Width;
    VSTSummaries.Width := VSTBalance.Width - VSTBalance.Header.Columns[1].Width - 20;
    VSTSummaries.Height := VSTBalance.Header.Height +
      (2 * VSTBalance.NodeHeight[VSTSummaries.GetFirst()]) + 5;
  except
  end;
end;

procedure TfrmMain.VSTBalanceCompareNodes(Sender: TBaseVirtualTree;
  Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: integer);
var
  Data1, Data2: PBalance;
begin
  if ((Sender as TLazVirtualStringTree).AbsoluteIndex(Node1) = 0) or
    ((Sender as TLazVirtualStringTree).AbsoluteIndex(Node2) = 0) then Exit;
  try
    Data1 := Sender.GetNodeData(Node1);
    Data2 := Sender.GetNodeData(Node2);
    case Column of
      1: Result := UTF8CompareText(AnsiLowerCase(Data1.Name1 + Data1.Name2),
          AnsiLowerCase(Data2.Name1 + Data2.Name2));
      2: Result := CompareValue(Data1.Credit, Data2.Credit);
      3: Result := CompareValue(Data1.Debit, Data2.Debit);
      4: Result := CompareValue(Data1.TransferP, Data2.TransferP);
      5: Result := CompareValue(Data1.TransferM, Data2.TransferM);
      6: Result := CompareValue(Data1.Credit + Data1.Debit + Data1.TransferP +
          Data1.TransferM, Data2.Credit + Data2.Debit + Data2.TransferP +
          Data2.TransferM);
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmMain.VSTBalanceGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: boolean; var ImageIndex: integer);
begin
  if Column > 0 then
    Exit;

  case tabBalanceHeader.TabIndex of
    0: ImageIndex := 12;
    1: ImageIndex := 15;
    2: ImageIndex := 16;
    3: ImageIndex := 17;
    4: ImageIndex := 13;
    5: ImageIndex := 11;
  end;
end;

procedure TfrmMain.VSTBalanceGetNodeDataSize(Sender: TBaseVirtualTree;
  var NodeDataSize: integer);
begin
  NodeDataSize := SizeOf(TBalance);
end;

procedure TfrmMain.VSTBalanceGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  Balance: PBalance;
begin
  try
    Balance := Sender.GetNodeData(Node);
    case Column of
      1: CellText := Balance.Name1 + IfThen(Balance.Name2 = '', '',
          separ_1 + IfThen((tabBalanceHeader.TabIndex = 2) and
          (frmSettings.chkDisplaySubCatCapital.Checked = True),
          AnsiUpperCase(Balance.Name2), Balance.Name2));
      // account name
      2: CellText := Format('%n', [Balance.Credit], FS_own);  // credits
      3: CellText := Format('%n', [Balance.Debit], FS_own);    // debits
      4: CellText := Format('%n', [Balance.TransferP], FS_own); // transfer +
      5: CellText := Format('%n', [Balance.TransferM], FS_own); // transfer -
      6: CellText := Format('%n', [Balance.Credit + Balance.Debit +
          Balance.TransferP + Balance.TransferM], FS_own);        // current ballance
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmMain.VSTBalanceHeaderClick(Sender: TVTHeader; HitInfo: TVTHeaderHitInfo);
var
  P: PVirtualNode;
  Balance: PBalance;
  _filter: string;
  I, J: integer;
begin
  // ===========================================================
  // CHART
  // ===========================================================
  try
    souBalanceCredits.Clear;
    souBalanceDebits.Clear;

    if (conn.Connected = False) or (VSTBalance.RootNodeCount = 0) then
      Exit;

    I := 0;
    J := 0;
    P := VSTBalance.GetFirst();

    while Assigned(P) do
    begin
      Balance := VSTBalance.GetNodeData(P);
      if (I > 0) and ((Balance.Credit <> 0) or (Balance.Debit <> 0) or
        (Balance.TransferP <> 0) or (Balance.TransferM <> 0)) then
      begin
        _filter := IfThen(Balance.Name2 = '', Balance.Name1, Balance.Name1 +
          sLineBreak + Balance.Name2);

        // credits
        souBalanceCredits.XCount := J + 1;
        souBalanceCredits.YCount := 2;
        souBalanceCredits.AddXYList(J, [Balance.Credit, Balance.TransferP], _filter);

        // debits
        souBalanceDebits.XCount := J + 1;
        souBalanceDebits.YCount := 2;
        souBalanceDebits.AddXYList(J, [-Balance.Debit, -Balance.TransferM], _filter);

        Inc(J);
        chaBalance.BottomAxis.Marks.Source := souBalanceCredits;
      end;
      Inc(I);
      P := VSTBalance.GetNext(P);
    end;
  finally
  end;
end;

procedure TfrmMain.VSTBalancePaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
var
  E: double;
begin
  try
    TryStrToFloat(ReplaceStr((Sender as TLazVirtualStringTree).Text[Node, Column],
      FS_own.ThousandSeparator, ''), E);

    TargetCanvas.Font.Bold := (vsSelected in node.States) or
      ((Sender as TLazVirtualStringTree).AbsoluteIndex(Node) = 0);

    if (vsSelected in node.States) or
      ((Sender as TLazVirtualStringTree).AbsoluteIndex(Node) = 0) or
      (((Sender as TLazVirtualStringTree).GetNodeLevel(Node) = 0) and
      (Sender.Name = 'VSTCross')) then
    begin
      if (E < 0) then
        TargetCanvas.Font.Color := clYellow
      else
        TargetCanvas.Font.Color := clWhite;
      Exit;
    end;

    if (Column > 1) then
    begin
      if (E < 0) then
        TargetCanvas.Font.Color := clRed
      else
        TargetCanvas.Font.Color := clDefault;
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmMain.VSTBalanceResize(Sender: TObject);
var
  X: integer;
begin
  try
    if (frmSettings.chkAutoColumnWidth.Checked = False) or
      (pnlReport.Visible = False) then
      Exit;

    (Sender as TLazVirtualStringTree).Header.Columns[0].Width :=
      round(ScreenRatio * 25 / 100);
    X := (VSTBalance.Width - VSTBalance.Header.Columns[0].Width) div 21;
    VSTBalance.Header.Columns[1].Width :=
      VSTBalance.Width - VSTBalance.Header.Columns[0].Width - ScrollBarWidth - (15 * X);
    // account
    VSTBalance.Header.Columns[2].Width := 3 * X; // credits
    VSTBalance.Header.Columns[3].Width := 3 * X; // debits
    VSTBalance.Header.Columns[4].Width := 3 * X; // transfers +
    VSTBalance.Header.Columns[5].Width := 3 * X; // transfers -
    VSTBalance.Header.Columns[6].Width := 3 * X; // current ballance

    // VSTSummaries size and position
    VSTSummaries.Left := 15 + VSTBalance.Header.Columns[1].Width;
    VSTSummaries.Width := VSTBalance.Width - VSTBalance.Header.Columns[1].Width - 20;
    VSTSummaries.Height := VSTBalance.Header.Height +
      (2 * VSTBalance.NodeHeight[VSTSummaries.GetFirst()]) + 5;
  finally;
  end;
end;

procedure TfrmMain.VSTBeforeCellPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
var
  Transaction: PTransactions;
begin
  try
    Transaction := Sender.GetNodeData(Node);
    if pnlListCaption.Tag = Transaction.ID then
      TargetCanvas.Brush.Color := clYellow
    else
    begin
      if Transaction.Date > FormatDateTime('YYYY-MM-DD', Now()) then
        TargetCanvas.Brush.Color := FullColor
      else
        TargetCanvas.Brush.Color :=
          IfThen(Node.Index mod 2 = 0, clWhite, frmSettings.pnlOddRowColor.Color);
    end;
    if (Column = 3) and ((Transaction.Kind in [0, 2]) and
      (Transaction.Amount < 0) or (Transaction.Kind in [1, 3]) and
      (Transaction.Amount > 0)) then TargetCanvas.Brush.Color := clBlack;

    TargetCanvas.FillRect(CellRect);
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
  VST.RepaintNode(Node);
end;

procedure TfrmMain.VSTChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  Amount, Sum: double;
  N: PVirtualNode;
  Transaction: PTransactions;
  S: string;
begin

  try
    // set buttons menu
    btnEdit.Enabled := VST.SelectedCount > 0;
    btnDelete.Enabled := VST.SelectedCount > 0;
    btnDuplicate.Enabled := VST.SelectedCount = 1;

    // set popup menu
    btnHistory.Enabled := VST.SelectedCount = 1; // btnHistory
    popHistory.Enabled := VST.SelectedCount = 1; // popList

    popDelete.Enabled := VST.SelectedCount > 0;
    popEdit.Enabled := VST.SelectedCount > 0;
    popDuplicate.Enabled := VST.SelectedCount = 1;

    pnlListCaption.Tag := 0;
    Transaction := VST.GetNodeData(VST.GetFirstSelected(False));

    case VST.SelectedCount of
      0: begin
        // pnlItem
        imgItem.ImageIndex := -1;
        lblItem.Caption := '';
        // pnlWidth
        if imgWidth.ImageIndex <> 0 then
          imgWidth.ImageIndex := 0;
        lblWidth.Caption := IntToStr(frmMain.Width);

        // pnlHeight
        if imgHeight.ImageIndex <> 1 then
          imgHeight.ImageIndex := 1;
        lblHeight.Caption := IntToStr(frmMain.Height);
      end;
      1: begin
        // pnlItem
        imgItem.ImageIndex := 5;
        lblItem.Caption := IntToStr(VST.GetFirstSelected(False).Index + 1) + '.';

        // pnlWidth
        if imgWidth.ImageIndex <> 9 then
          imgWidth.ImageIndex := 9;
        lblWidth.Caption := Format('%n', [Transaction.Amount], FS_own);

        // pnlHeight
        if imgHeight.ImageIndex <> 8 then
          imgHeight.ImageIndex := 8;
        lblHeight.Caption := Format('%n', [Transaction.Amount], FS_own);

        // find opposite transfer
        if Transaction.Kind > 1 then
        begin
          frmMain.QRY.SQL.Text :=
            'SELECT * FROM transfers ' + // select
            'WHERE tra_data1 = :ID1 OR tra_data2 = :ID1;';

          frmMain.QRY.Params.ParamByName('ID1').AsInteger := Transaction.ID;
          frmMain.QRY.Prepare;
          frmMain.QRY.Open;
          frmMain.QRY.Last;
          if frmMain.QRY.RecordCount = 1 then
          begin
            frmMain.QRY.First;
            while not (frmMain.QRY.EOF) do
            begin
              if frmMain.QRY.Fields[0].AsInteger = Transaction.ID then
                pnlListCaption.Tag := frmMain.QRY.Fields[1].AsInteger
              else
                pnlListCaption.Tag := frmMain.QRY.Fields[0].AsInteger;
              frmMain.QRY.Next;
            end;
          end;
          frmMain.QRY.Close;
        end;
      end
      else
      begin
        Sum := 0.00;
        screen.Cursor := crHourGlass;
        // get sum of selected
        N := VST.GetFirstSelected(False);
        while Assigned(N) do
        begin
          S := VST.Text[N, 3];
          S := AnsiReplaceStr(S, FS_own.ThousandSeparator, '');
          TryStrToFloat(S, Amount);
          Sum := Sum + Amount;
          N := VST.GetNextSelected(N);
        end;
        // pnlWidth
        if imgWidth.ImageIndex <> 9 then
          imgWidth.ImageIndex := 9;
        lblWidth.Caption := Format('%n', [Sum], FS_own);

        // pnlHeight
        if imgHeight.ImageIndex <> 8 then
          imgHeight.ImageIndex := 8;
        if VST.SelectedCount <> 0 then
          lblHeight.Caption := Format('%n', [Sum / VST.SelectedCount], FS_own);

        // pnlItem
        imgItem.ImageIndex := IfThen(VST.SelectedCount = VST.RootNodeCount, 7, 6);
        lblItem.Caption := '# ' + IntToStr(VST.SelectedCount);
        screen.Cursor := crDefault;
      end;
    end;
    imgWidth.Repaint;
    imgHeight.Repaint;
  except
    on E: Exception do
    begin
      screen.Cursor := crDefault;
      ShowErrorMessage(E);
    end;
  end;
end;

procedure TfrmMain.VSTChronoGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: boolean; var ImageIndex: integer);
begin
  if Column = 0 then
    ImageIndex := 20;
end;

procedure TfrmMain.VSTChronoGetNodeDataSize(Sender: TBaseVirtualTree;
  var NodeDataSize: integer);
begin
  NodeDataSize := SizeOf(TSummary);
end;

procedure TfrmMain.VSTChronoGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  Summary: PSummary;
begin
  try
    Summary := Sender.GetNodeData(Node);
    case Column of
      1: CellText := Summary.Account;       // account name
      2: CellText := Format('%n', [Summary.StartSum], FS_own); // starting balance
      3: CellText := Format('%n', [Summary.Credit], FS_own);  // credits
      4: CellText := Format('%n', [Summary.Debit], FS_own);    // debits
      5: CellText := Format('%n', [Summary.TransferP], FS_own); // transfer +
      6: CellText := Format('%n', [Summary.TransferM], FS_own); // transfer -
      7: CellText := Format('%n', [Summary.Credit + Summary.Debit +
          Summary.TransferP + Summary.TransferM], FS_own);
      // current ballance
      8: CellText := Format('%n', [Summary.StartSum + Summary.Credit +
          Summary.Debit + Summary.TransferP + Summary.TransferM], FS_own);
      // final ballance
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmMain.VSTChronoHeaderClick(Sender: TVTHeader; HitInfo: TVTHeaderHitInfo);
var
  P: PVirtualNode;
  Summary: PSummary;
begin
  serChronoStart.Clear;
  serChronoCredits.Clear;
  serChronoDebits.Clear;
  serChronoTPlus.Clear;
  serChronoTMinus.Clear;
  serChronoBalance.Clear;
  serChronoTotal.Clear;
  souChrono.Clear;

  if (VSTChrono.RootNodeCount < 1) then
    Exit;

  try
    P := VSTChrono.GetFirst();
    P := VSTChrono.GetNext(P);
    while Assigned(P) do
    begin
      Summary := VSTChrono.GetNodeData(P);
      if frmMain.popChartChrono1.Checked = True then
        serChronoStart.AddXY(P.Index, Summary.StartSum);
      serChronoStart.Legend.Visible := frmMain.popChartChrono1.Checked;

      if frmMain.popChartChrono2.Checked = True then
        serChronoCredits.AddXY(P.Index, Summary.Credit);
      serChronoCredits.Legend.Visible := frmMain.popChartChrono2.Checked;

      if frmMain.popChartChrono3.Checked = True then
        serChronoDebits.AddXY(P.Index, -Summary.Debit);
      serChronoDebits.Legend.Visible := frmMain.popChartChrono3.Checked;

      if frmMain.popChartChrono4.Checked = True then
        serChronoTPlus.AddXY(P.Index, Summary.TransferP);
      serChronoTPlus.Legend.Visible := frmMain.popChartChrono4.Checked;

      if frmMain.popChartChrono5.Checked = True then
        serChronoTMinus.AddXY(P.Index, -Summary.TransferM);
      serChronoTMinus.Legend.Visible := frmMain.popChartChrono5.Checked;

      if frmMain.popChartChrono6.Checked = True then
        serChronoBalance.AddXY(P.Index, Summary.Credit + Summary.Debit +
          Summary.TransferP + Summary.TransferM);
      serChronoBalance.Legend.Visible := frmMain.popChartChrono6.Checked;

      if frmMain.popChartChrono7.Checked = True then
        serChronoTotal.AddXY(P.Index, Summary.StartSum + Summary.Credit +
          Summary.Debit + Summary.TransferP + Summary.TransferM);
      serChronoTotal.Legend.Visible := frmMain.popChartChrono7.Checked;

      souChrono.Add(P.Index, 0.0, Summary.Account, 0);
      P := VSTChrono.GetNext(P);
    end;
  except
  end;
end;

procedure TfrmMain.VSTChronoResize(Sender: TObject);
var
  X: integer;
begin
  try
    // set transactions columns width
    if frmSettings.chkAutoColumnWidth.Checked = False then Exit;

    (Sender as TLazVirtualStringTree).Header.Columns[0].Width :=
      round(ScreenRatio * 25 / 100);
    X := (VSTChrono.Width - VSTChrono.Header.Columns[0].Width) div 8;
    VSTChrono.Header.Columns[1].Width :=
      VSTChrono.Width - VSTChrono.Header.Columns[0].Width - ScrollBarWidth - (7 * X);
    // account
    VSTChrono.Header.Columns[2].Width := X; // starting balance
    VSTChrono.Header.Columns[3].Width := X; // credits
    VSTChrono.Header.Columns[4].Width := X; // debits
    VSTChrono.Header.Columns[5].Width := X; // transfers +
    VSTChrono.Header.Columns[6].Width := X; // transfers -
    VSTChrono.Header.Columns[7].Width := X; // current ballance
    VSTChrono.Header.Columns[8].Width := X; // final ballance
  except
  end;
end;

procedure TfrmMain.VSTCompareNodes(Sender: TBaseVirtualTree;
  Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: integer);
var
  Data1, Data2: PTransactions;
begin
  try
    Data1 := Sender.GetNodeData(Node1);
    Data2 := Sender.GetNodeData(Node2);
    case Column of
      1:
        Result := CompareStr( // compare
          Data1.Date + IntToStr(Data1.ID), // 1
          Data2.Date + IntToStr(Data2.ID)); // 2
      2: Result := UTF8CompareText(AnsiLowerCase(Data1.Comment),
          AnsiLowerCase(Data2.Comment));
      3: Result := CompareValue(Data1.Amount, Data2.Amount);
      4: Result := UTF8CompareText(Data1.currency, Data2.currency);
      5: Result := UTF8CompareText(Data1.Account, Data2.Account);
      6: Result := UTF8CompareText(Data1.Category, Data2.Category);
      7: Result := UTF8CompareText(Data1.SubCategory, Data2.SubCategory);
      8: Result := UTF8CompareText(Data1.Person, Data2.Person);
      9: Result := UTF8CompareText(Data1.Payee, Data2.Payee);
      10: Result := CompareValue(Data1.ID, Data2.ID);
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmMain.VSTCrossBeforeCellPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
begin
  try
    if (vsSelected) in node.States then
    begin
      TargetCanvas.Brush.Color := clBlack;
      TargetCanvas.FillRect(CellRect);
      exit;
    end;

    if VSTCross.GetNodeLevel(Node) = 0 then
      TargetCanvas.Brush.Color := FullColor
    else
      TargetCanvas.Brush.Color :=
        IfThen(Node.Index mod 2 = 0, Brighten(frmSettings.btnCaptionColorBack.Tag, 225),
        Brighten(frmSettings.btnCaptionColorBack.Tag, 240));
    TargetCanvas.FillRect(CellRect);
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmMain.VSTCrossGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: boolean; var ImageIndex: integer);
begin
  if (Column > 0) then
    Exit;

  if (VSTCross.GetNodeLevel(Node) = 0) then
    case tabCrossTop.TabIndex of
      0: ImageIndex := 12;
      1: ImageIndex := 15;
      2: ImageIndex := 16;
      3: ImageIndex := 17;
      4: ImageIndex := 13;
    end
  else
    case tabCrossLeft.TabIndex of
      1: ImageIndex := 12;
      2: ImageIndex := 15;
      3: ImageIndex := 16;
      4: ImageIndex := 16;
      5: ImageIndex := 17;
      6: ImageIndex := 13;
    end;
end;

procedure TfrmMain.VSTCrossGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  Balance: PBalance;
begin
  try
    Balance := Sender.GetNodeData(Node);
    case Column of
      1: if (tabCrossLeft.TabIndex in [3, 5, 6]) and
          (VSTCross.GetNodeLevel(Node) = 1) then
          CellText := Balance.Name1
        else if (tabCrossTop.TabIndex = 2) and (tabCrossLeft.TabIndex = 4) then
          CellText := IfThen(VSTCross.GetNodeLevel(Node) = 0,
            Balance.Name1, Balance.Name2)
        else if (tabCrossLeft.TabIndex = 4) and (VSTCross.GetNodeLevel(Node) = 1) then
          CellText := Balance.Name1 + separ_1 +
            IfThen(frmSettings.chkDisplaySubCatCapital.Checked = True,
            AnsiUpperCase(Balance.Name2), Balance.Name2)
        else
          CellText := Balance.Name1 + IfThen(Balance.Name2 = '', '',
            separ_1 + Balance.Name2);
      // account name
      2: CellText := Format('%n', [Balance.Credit], FS_own);  // credits
      3: CellText := Format('%n', [Balance.Debit], FS_own);    // debits
      4: CellText := Format('%n', [Balance.TransferP], FS_own); // transfer +
      5: CellText := Format('%n', [Balance.TransferM], FS_own); // transfer -
      6: CellText := Format('%n', [Balance.Credit + Balance.Debit +
          Balance.TransferP + Balance.TransferM], FS_own);        // current ballance
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmMain.VSTCrossPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
var
  E: double;
begin
  try
    TryStrToFloat(ReplaceStr((Sender as TLazVirtualStringTree).Text[Node, Column],
      FS_own.ThousandSeparator, ''), E);

    if (vsSelected in node.States) or (VSTCross.AbsoluteIndex(Node) = 0) then
    begin
      if (E < 0) then
        TargetCanvas.Font.Color := clYellow
      else
        TargetCanvas.Font.Color := clWhite;
      Exit;
    end;

    TargetCanvas.Font.Bold := (vsSelected in node.States) or
      (VSTSummary.GetNodeLevel(Node) = 0);

    if (Column > 1) and (Node.Index > 0) then
    begin

      if (E < 0) then
        TargetCanvas.Font.Color := clRed
      else
        TargetCanvas.Font.Color := clDefault;
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmMain.VSTCrossResize(Sender: TObject);
var
  X: integer;
begin
  try
    if (frmSettings.chkAutoColumnWidth.Checked = False) or
      (pnlReport.Visible = False) then
      Exit;

    VSTCross.Header.Columns[0].Width := Round(ScreenRatio * 60 / 100);
    X := (VSTCross.Width - VSTCross.Header.Columns[0].Width) div 21;
    VSTCross.Header.Columns[1].Width :=
      VSTCross.Width - VSTCross.Header.Columns[0].Width - ScrollBarWidth - (15 * X);
    // account
    VSTCross.Header.Columns[2].Width := 3 * X; // credits
    VSTCross.Header.Columns[3].Width := 3 * X; // debits
    VSTCross.Header.Columns[4].Width := 3 * X; // transfers +
    VSTCross.Header.Columns[5].Width := 3 * X; // transfers -
    VSTCross.Header.Columns[6].Width := 3 * X; // current ballance
  except
  end;
end;

procedure TfrmMain.VSTDblClick(Sender: TObject);
begin
  try
    if VST.SelectedCount = 0 then
      btnAddClick(btnAdd)
    else if VST.SelectedCount = 1 then
      btnEditClick(btnEdit);
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmMain.VSTEndOperation(Sender: TBaseVirtualTree;
  OperationKind: TVTOperationKind);
begin
  lblTime.Caption := IntToStr(GetTickCount64 - Start) + ' ms';
end;

procedure TfrmMain.VSTFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  Transactions: PTransactions;
begin
  try
    Transactions := Sender.GetNodeData(Node);
    Transactions.Date := '';
    Transactions.Account := '';
    Transactions.Amount := 0;
    Transactions.Category := '';
    Transactions.SubCategory := '';
    Transactions.Comment := '';
    Transactions.currency := '';
    Transactions.ID := 0;
    Transactions.Kind := 0;
    Transactions.Order := 0;
    Transactions.Payee := '';
    Transactions.Person := '';
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmMain.VSTGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: boolean; var ImageIndex: integer);
var
  Transactions: PTransactions;
begin
  try
    if Column = 0 then
    begin
      Transactions := Sender.GetNodeData(Node);
      ImageIndex := Transactions.Kind;
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmMain.VSTGetNodeDataSize(Sender: TBaseVirtualTree;
  var NodeDataSize: integer);
begin
  NodeDataSize := SizeOf(TTransactions);
end;

procedure TfrmMain.VSTGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
var
  Transactions: PTransactions;
  B: byte;
begin
  try
    Transactions := Sender.GetNodeData(Node);
    case Column of
      1: begin
        B := DayOfTheWeek(StrToDate(Transactions.Date, 'YYYY-MM-DD', '-')) + 1;
        if B = 8 then
          B := 1;
        CellText := FS_own.ShortDayNames[B] + ' ' +
          DateToStr(StrToDate(Transactions.Date, 'YYYY-MM-DD', '-'), FS_own);
      end;
      2: CellText := Transactions.Comment;
      3: CellText := Format('%n', [Transactions.Amount], FS_own);
      4: CellText := Transactions.currency;
      5: CellText := Transactions.Account;
      6: CellText := AnsiUpperCase(Transactions.Category);
      7: CellText := IfThen(frmSettings.chkDisplaySubCatCapital.Checked =
          True, AnsiUpperCase(Transactions.SubCategory), Transactions.SubCategory);
      8: CellText := Transactions.Person;
      9: CellText := Transactions.Payee;
      10: CellText := IntToStr(Transactions.ID);
      11: CellText := IntToStr(Transactions.Kind);
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmMain.VSTMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: integer; MousePos: TPoint; var Handled: boolean);
begin
  try
    if (ssCtrl in Shift) and (frmSettings.spiGridFontSize.Value > 4) then
    begin
      if WheelDelta > 0 then
        frmSettings.spiGridFontSize.Value := frmSettings.spiGridFontSize.Value + 1
      else
        frmSettings.spiGridFontSize.Value := frmSettings.spiGridFontSize.Value - 1;
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmMain.VSTPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
var
  Transaction: PTransactions;
begin
  TargetCanvas.Font.Bold := (Column = 3) and
    (frmSettings.chkDisplayFontBold.Checked = True);
  Transaction := Sender.GetNodeData(Node);
  try
    if vsSelected in node.States then
      exit;

    Transaction := Sender.GetNodeData(Node);
    if Transaction.Date > FormatDateTime('YYYY-MM-DD', Now()) then
    begin
      if pnlListCaption.Tag = Transaction.ID then
        TargetCanvas.Font.Color := FullColor
      else
        TargetCanvas.Font.Color := frmSettings.btnCaptionColorFont.Tag;
    end
    else
      case Transaction.Kind of

        // credit color
        0: case frmSettings.pnlCreditTransactionsColor.Tag of
            0: TargetCanvas.Font.Color := clDefault;
            1: begin
              if Column = 3 then
                TargetCanvas.Font.Color := clBlue
              else
                TargetCanvas.Font.Color := clDefault;
            end
            else
              TargetCanvas.Font.Color := clBlue;
          end;

        // debit color
        1: case frmSettings.pnlDebitTransactionsColor.Tag of
            0: TargetCanvas.Font.Color := clDefault;
            1: begin
              if Column = 3 then
                TargetCanvas.Font.Color := clRed
              else
                TargetCanvas.Font.Color := clDefault;
            end
            else
              TargetCanvas.Font.Color := clRed;
          end;

        // transfer plus color
        2: case frmSettings.pnlTransferPTransactionsColor.Tag of
            0: TargetCanvas.Font.Color := clDefault;
            1: begin
              if Column = 3 then
                TargetCanvas.Font.Color := clGreen
              else
                TargetCanvas.Font.Color := clDefault;
            end
            else
              TargetCanvas.Font.Color := clGreen;
          end;

          // transfer minus color
        else
          case frmSettings.pnlTransferMTransactionsColor.Tag of
            0: TargetCanvas.Font.Color := clDefault;
            1: begin
              if Column = 3 then
                TargetCanvas.Font.Color := rgbToColor(240, 160, 0)
              else
                TargetCanvas.Font.Color := clDefault;
            end
            else
              TargetCanvas.Font.Color := rgbToColor(240, 160, 0);
          end;
      end;
    if (Column = 3) and ((Transaction.Kind in [0, 2]) and
      (Transaction.Amount < 0) or (Transaction.Kind in [1, 3]) and
      (Transaction.Amount > 0)) then TargetCanvas.Font.Color := clWhite;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmMain.VSTResize(Sender: TObject);
var
  X: integer;
begin
  try
    // set Chart size and location
    chaPie.Width := VST.Width div 2;
    chaPie.Height := IfThen(chaPie.Width > VST.Height, VST.Height, chaPie.Width);
    chaPie.Left := VST.Left + (VST.Width div 2);
    chaPie.top := VST.Top;

    // set depth (on Windows is a bug)
    {$IFDEF LINUX}
    serPie.Depth := chaPie.Height div 20;
    {$ENDIF}

    // set transactions columns width
    (Sender as TLazVirtualStringTree).Header.Columns[0].Width :=
      round(ScreenRatio * 25 / 100);
    if frmSettings.chkAutoColumnWidth.Checked = False then Exit;

    X := (VST.Width - VST.Header.Columns[0].Width) div 100;
    VST.Header.Columns[1].Width := 10 * X; // date 100
    VST.Header.Columns[2].Width :=
      VST.Width - VST.Header.Columns[0].Width - ScrollBarWidth - (85 * X); // comment
    VST.Header.Columns[3].Width := 10 * X; // amount
    VST.Header.Columns[4].Width := 5 * X; // currency
    VST.Header.Columns[5].Width := 13 * X; // account
    VST.Header.Columns[6].Width := 13 * X; // category
    VST.Header.Columns[7].Width := 13 * X; // subcategory
    VST.Header.Columns[8].Width := 8 * X; // person
    VST.Header.Columns[9].Width := 8 * X; // payee
    VST.Header.Columns[10].Width := 5 * X; // ID

  except
  end;
end;

procedure TfrmMain.VSTStartOperation(Sender: TBaseVirtualTree;
  OperationKind: TVTOperationKind);
begin
  Start := GetTickCount64;
end;

procedure TfrmMain.VSTSummariesBeforeCellPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
begin
  TargetCanvas.Brush.Color := IfThen(Column = 0, clWhite, clBlack);
  TargetCanvas.FillRect(CellRect);
end;

procedure TfrmMain.VSTSummariesGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: boolean; var ImageIndex: integer);
begin
  if column > 0 then
    Exit;

  ImageIndex := IfThen(Node.Index = 0, 9, 8);
end;

procedure TfrmMain.VSTSummariesGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  Summaries: PSummary;
  Balances: PBalance;
begin
  try
    if pnlReport.Visible = False then
    begin
      Summaries := Sender.GetNodeData(Node);
      case Column of
        1: CellText := Format('%n', [Summaries.StartSum], FS_own);  // startsum
        2: CellText := Format('%n', [Summaries.Credit], FS_own);  // credits
        3: CellText := Format('%n', [Summaries.Debit], FS_own);    // debits
        4: CellText := Format('%n', [Summaries.TransferP], FS_own); // transfer +
        5: CellText := Format('%n', [Summaries.TransferM], FS_own); // transfer -
        6: CellText := Format('%n', [Summaries.Credit + Summaries.Debit +
            Summaries.TransferP + Summaries.TransferM], FS_own); // current ballance
        7: CellText := Format('%n', [Summaries.StartSum + Summaries.Credit +
            Summaries.Debit + Summaries.TransferP + Summaries.TransferM], FS_own);
        // total ballance
      end;
    end
    else
    begin
      Balances := Sender.GetNodeData(Node);
      case Column of
        2: CellText := Format('%n', [Balances.Credit], FS_own);  // credits
        3: CellText := Format('%n', [Balances.Debit], FS_own);    // debits
        4: CellText := Format('%n', [Balances.TransferP], FS_own); // transfer +
        5: CellText := Format('%n', [Balances.TransferM], FS_own); // transfer -
        6: CellText := Format('%n', [Balances.Credit + Balances.Debit +
            Balances.TransferP + Balances.TransferM], FS_own); // current ballance
      end;
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmMain.VSTSummariesPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
var
  E: double;
begin
  if Column = 0 then
    Exit;

  try
    TryStrToFloat(ReplaceStr(VSTSummaries.Text[Node, Column],
      FS_own.ThousandSeparator, ''), E);
    if (E < 0) then
      TargetCanvas.Font.Color := $0058B7FF //clYellow
    else
      TargetCanvas.Font.Color := clWhite;
  finally
  end;
end;

procedure TfrmMain.VSTSummariesResize(Sender: TObject);
var
  X: integer;
begin
  try
    (Sender as TLazVirtualStringTree).Header.Columns[0].Width :=
      round(ScreenRatio * 25 / 100);
    X := (VSTSummaries.Width - VSTSummaries.Header.Columns[0].Width) div
      IfThen(pnlReport.Visible = True, 5, 7);
    VSTSummaries.Header.Columns[1].Width := IfThen(pnlReport.Visible = True, 0, X);
    // startsum
    VSTSummaries.Header.Columns[2].Width := X; // credits
    VSTSummaries.Header.Columns[3].Width := X; // debits
    VSTSummaries.Header.Columns[4].Width := X; // transfers +
    VSTSummaries.Header.Columns[5].Width := X; // transfers -
    VSTSummaries.Header.Columns[6].Width := X; // balance
    VSTSummaries.Header.Columns[7].Width := IfThen(pnlReport.Visible = True, 0, X);
    // total
  except
  end;
end;

procedure TfrmMain.VSTSummaryBeforeCellPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
begin
  try
    if (vsSelected) in node.States then
    begin
      TargetCanvas.Brush.Color := clBlack;
      TargetCanvas.FillRect(CellRect);
      exit;
    end;

    if Node.Index = 0 then
      TargetCanvas.Brush.Color := FullColor
    else
      TargetCanvas.Brush.Color :=
        IfThen(Node.Index mod 2 = 0, Brighten(frmSettings.btnCaptionColorBack.Tag, 225),
        Brighten(frmSettings.btnCaptionColorBack.Tag, 240));
    TargetCanvas.FillRect(CellRect);
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmMain.VSTSummaryChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  Summary, Summaries: PSummary;
  N1, N2: PVirtualNode;
  G, C, D, P, M: double; // startinG, Credits, Debits, transfersPlus, transfersMinus
begin
  VSTSummaries.RootNodeCount := 0;
  VSTSummaries.Clear;

  VSTSummaries.Visible := (VSTSummary.SelectedCount > 1) and
    (VSTSummary.Selected[VSTSummary.GetFirst()] = False);

  if (VSTSummary.SelectedCount < 2) or
    (VSTSummary.Selected[VSTSummary.GetFirst()] = True) then
    Exit;

  try
    VSTSummaries.RootNodeCount := 2;

    // FIRST LINE (SUMMARY)
    N2 := VSTSummaries.GetFirst();
    Summaries := VSTSummaries.GetNodeData(N2);

    G := 0;
    C := 0;
    D := 0;
    P := 0;
    M := 0;

    N1 := VSTSummary.GetFirstSelected();
    while Assigned(N1) do
    begin
      Summary := VSTSummary.GetNodeData(N1);
      G := G + Summary.StartSum + Summary.AccountAmount;
      C := C + Summary.Credit;
      D := D + Summary.Debit;
      P := P + Summary.TransferP;
      M := M + Summary.TransferM;
      N1 := VSTSummary.GetNextSelected(N1);
    end;

    Summaries.StartSum := G;
    Summaries.Credit := C;
    Summaries.Debit := D;
    Summaries.TransferP := P;
    Summaries.TransferM := M;

    // SECOND LINE (AVERAGE)
    Summaries := VSTSummaries.GetNodeData(VSTSummaries.GetNext(N2));
    if VSTSummary.SelectedCount <> 0 then
    begin
      Summaries.StartSum := RoundTo(G / VSTSummary.SelectedCount, -2);
      Summaries.Credit := RoundTo(C / VSTSummary.SelectedCount, -2);
      Summaries.Debit := RoundTo(D / VSTSummary.SelectedCount, -2);
      Summaries.TransferP := RoundTo(P / VSTSummary.SelectedCount, -2);
      Summaries.TransferM := RoundTo(M / VSTSummary.SelectedCount, -2);
    end;
    SetNodeHeight(VSTSummaries);

    // VSTSummaries size and position
    VSTSummaries.Left := VSTSummary.Left + VSTSummary.Header.Columns[1].Width;
    VSTSummaries.Width := VSTSummary.Width - VSTSummary.Header.Columns[0].Width -
      VSTSummary.Header.Columns[1].Width + 10;
    VSTSummaries.Height := VSTSummary.Header.Height +
      (2 * VSTSummary.NodeHeight[VSTSummaries.GetFirst()]) + 5;
  except
  end;
end;

procedure TfrmMain.VSTSummaryCompareNodes(Sender: TBaseVirtualTree;
  Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: integer);
var
  Data1, Data2: PSummary;
begin
  if (Node1.Index = 0) or (Node2.Index = 0) then Exit;

  Data1 := Sender.GetNodeData(Node1);
  Data2 := Sender.GetNodeData(Node2);
  try
    case Column of
      1: Result := UTF8CompareText(AnsiLowerCase(Data1.Account),
          AnsiLowerCase(Data2.Account));
      2: Result := CompareValue(Data1.AccountAmount + Data1.StartSum,
          Data2.AccountAmount + Data2.StartSum);
      3: Result := CompareValue(Data1.Credit, Data2.Credit);
      4: Result := CompareValue(Data1.Debit, Data2.Debit);
      5: Result := CompareValue(Data1.TransferP, Data2.TransferP);
      6: Result := CompareValue(Data1.TransferM, Data2.TransferM);
      7: Result := CompareValue(Data1.Credit + Data1.Debit + Data1.TransferP +
          Data1.TransferM, Data2.Credit + Data2.Debit + Data2.TransferP +
          Data2.TransferM);
      8: Result := CompareValue(Data1.AccountAmount + Data1.StartSum +
          Data1.Credit + Data1.Debit + Data1.TransferP + Data1.TransferM,
          Data2.AccountAmount + Data2.StartSum + Data2.Credit +
          Data2.Debit + Data2.TransferP + Data2.TransferM);
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmMain.VSTSummaryFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  Summary: PSummary;
begin
  try
    Summary := Sender.GetNodeData(Node);
    Summary.Account := '';
    Summary.Comment := '';
    Summary.AccountAmount := 0;
    Summary.Credit := 0;
    Summary.Debit := 0;
    Summary.StartSum := 0;
    Summary.TransferM := 0;
    Summary.TransferP := 0;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmMain.VSTSummaryGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: boolean; var ImageIndex: integer);
begin
  if Column = 0 then
    ImageIndex := 15;
end;

procedure TfrmMain.VSTSummaryGetNodeDataSize(Sender: TBaseVirtualTree;
  var NodeDataSize: integer);
begin
  try
    if pnlReport.Visible = False then
      NodeDataSize := SizeOf(TSummary)
    else
      NodeDataSize := SizeOf(TBalance);
  except
  end;
end;

procedure TfrmMain.VSTSummaryGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  Summary: PSummary;
begin
  try
    Summary := Sender.GetNodeData(Node);
    case Column of
      1: CellText := Summary.Account;       // account name
      2: CellText := Format('%n', [Summary.AccountAmount + Summary.StartSum], FS_own);
      // starting balance
      3: CellText := Format('%n', [Summary.Credit], FS_own);  // credits
      4: CellText := Format('%n', [Summary.Debit], FS_own);    // debits
      5: CellText := Format('%n', [Summary.TransferP], FS_own); // transfer +
      6: CellText := Format('%n', [Summary.TransferM], FS_own); // transfer -
      7: CellText := Format('%n', [Summary.Credit + Summary.Debit +
          Summary.TransferP + Summary.TransferM], FS_own);
      // current ballance
      8: CellText := Format('%n', [Summary.AccountAmount + Summary.StartSum +
          Summary.Credit + Summary.Debit + Summary.TransferP +
          Summary.TransferM], FS_own);
      // final ballance
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmMain.VSTSummaryHotChange(Sender: TBaseVirtualTree;
  OldNode, NewNode: PVirtualNode);
const
  MyColors: array[0..4] of TColor =
    ($00DFB8A9, // blue
    $0094A8FF, // red
    $00A5E5B7, // green
    $0090F4FF, // yellow
    $00DDDDDD); // gray
var
  Summary: PSummary;
begin
  // there is a bug in chart component, when shows 50% to 50% parts (in Window OS only!)
  // application crashes (on exit), when these data are visualised

  if (VSTSummary.RootNodeCount = 0) or (Conn.Connected = False) or
    (chkShowPieChart.Checked = False) then
    exit;

  if (NewNode = nil) then
  begin
    if chaPie.Visible = True then
      chaPie.Visible := False;
    VSTSummary.HelpContext := 0;
    Exit;
  end;

  try
    VSTSummary.HelpContext := 1;
    case VSTSummary.Tag of
      0: chaPie.Visible := False;
      1: begin
        try
          // set chart
          chaPie.Title.Text.Text :=
            VSTSummary.Text[NewNode, 1] + ' (' +
            tabCurrency.Tabs[tabCurrency.TabIndex] + ')';

          Summary := Sender.GetNodeData(NewNode);

          // =================================================================================================================
          // PIE CHART
          // =================================================================================================================
          // clear series
          serPie.Clear;

          // credits
          if Round(Summary.Credit) <> 0.0 then
            serPie.AddPie(Round(ABS(Summary.Credit)),
              VSTSummary.Header.Columns[3].CaptionText, MyColors[0]);  // blue

          if Round(Summary.TransferP) <> 0.0 then
            serPie.AddPie(round(ABS(Summary.TransferP)),
              VSTSummary.Header.Columns[5].CaptionText, MyColors[2]); // green

          // ballance
          if Round(Summary.Credit + Summary.Debit + Summary.TransferP +
            Summary.TransferM) <> 0.0 then
            serPie.AddPie(Round(ABS(Summary.Credit + Summary.Debit +
              Summary.TransferP + Summary.TransferM)),
              VSTSummary.Header.Columns[7].CaptionText, MyColors[4]); // gray

          // debits
          if Round(Summary.TransferM) <> 0.0 then
            serPie.AddPie(Round(ABS(Summary.TransferM)),
              VSTSummary.Header.Columns[6].CaptionText, MyColors[3]); // yellow

          if Round(Summary.Debit) <> 0.0 then
            serPie.AddPie(Round(ABS(Summary.Debit)),
              VSTSummary.Header.Columns[4].CaptionText, MyColors[1]);  // red

          // show chart
          if (Summary.Credit = 0.0) and (Summary.Debit = 0.0) and
            (Summary.TransferP = 0.0) and (Summary.TransferM = 0.0) then
            chaPie.Visible := False
          else
          begin
            if chaPie.Visible = False then
              chaPie.Visible := True;
          end;
        except
        end;
      end;
    end;
  except
  end;
end;

procedure TfrmMain.VSTSummaryMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: integer);
const
  MyColors: array[0..14] of TColor =
    ($0084E3FA, $008980F9, $0087CCFE, $00B893C1, $00F9D188, $00A5E5B7,
    $00DDDDDD, $00B0F1EC, $0090F4FF, $0094A8FF, $00C5B6F9, $00DFB8A9,
    $009ED2BE, $00FFD9B7, $007EAA92);
var
  P: PVirtualNode;
  Summary: PSummary;
  I: integer;
begin
  if (Conn.Connected = False) or (chkShowPieChart.Checked = False) then
    Exit;

  try
    if (X <= VSTSummary.Header.Columns[0].Width +
      VSTSummary.Header.Columns[1].Width) then
      VSTSummary.Tag := 1
    else if (X > VSTSummary.Header.Columns[0].Width +
      VSTSummary.Header.Columns[1].Width) and
      (X <= VSTSummary.Header.Columns[0].Width + VSTSummary.Header.Columns[1].Width +
      VSTSummary.Header.Columns[2].Width) then
      VSTSummary.Tag := 2
    else if (X > VSTSummary.Header.Columns[0].Width +
      VSTSummary.Header.Columns[1].Width + VSTSummary.Header.Columns[2].Width) and
      (X <= VSTSummary.Header.Columns[0].Width + VSTSummary.Header.Columns[1].Width +
      VSTSummary.Header.Columns[2].Width + VSTSummary.Header.Columns[3].Width) then
      VSTSummary.Tag := 3
    else if (X > VSTSummary.Header.Columns[0].Width +
      VSTSummary.Header.Columns[1].Width + VSTSummary.Header.Columns[2].Width +
      VSTSummary.Header.Columns[3].Width) and
      (X <= VSTSummary.Header.Columns[0].Width + VSTSummary.Header.Columns[1].Width +
      VSTSummary.Header.Columns[2].Width + VSTSummary.Header.Columns[3].Width +
      VSTSummary.Header.Columns[4].Width) then
      VSTSummary.Tag := 4
    else if (X > VSTSummary.Header.Columns[0].Width +
      VSTSummary.Header.Columns[1].Width + VSTSummary.Header.Columns[2].Width +
      VSTSummary.Header.Columns[3].Width + VSTSummary.Header.Columns[4].Width) and
      (X <= VSTSummary.Header.Columns[0].Width + VSTSummary.Header.Columns[1].Width +
      VSTSummary.Header.Columns[2].Width + VSTSummary.Header.Columns[3].Width +
      VSTSummary.Header.Columns[4].Width + VSTSummary.Header.Columns[5].Width) then
      VSTSummary.Tag := 5
    else if (X > VSTSummary.Header.Columns[0].Width +
      VSTSummary.Header.Columns[1].Width + VSTSummary.Header.Columns[2].Width +
      VSTSummary.Header.Columns[3].Width + VSTSummary.Header.Columns[4].Width +
      VSTSummary.Header.Columns[5].Width) and
      (X <= VSTSummary.Header.Columns[0].Width + VSTSummary.Header.Columns[1].Width +
      VSTSummary.Header.Columns[2].Width + VSTSummary.Header.Columns[3].Width +
      VSTSummary.Header.Columns[4].Width + VSTSummary.Header.Columns[5].Width +
      VSTSummary.Header.Columns[6].Width) then
      VSTSummary.Tag := 6
    else if (X > VSTSummary.Header.Columns[0].Width +
      VSTSummary.Header.Columns[1].Width + VSTSummary.Header.Columns[2].Width +
      VSTSummary.Header.Columns[3].Width + VSTSummary.Header.Columns[4].Width +
      VSTSummary.Header.Columns[5].Width + VSTSummary.Header.Columns[6].Width) and
      (X <= VSTSummary.Header.Columns[0].Width + VSTSummary.Header.Columns[1].Width +
      VSTSummary.Header.Columns[2].Width + VSTSummary.Header.Columns[3].Width +
      VSTSummary.Header.Columns[4].Width + VSTSummary.Header.Columns[5].Width +
      VSTSummary.Header.Columns[6].Width + VSTSummary.Header.Columns[7].Width) then
      VSTSummary.Tag := 7
    else if (X > VSTSummary.Header.Columns[0].Width +
      VSTSummary.Header.Columns[1].Width + VSTSummary.Header.Columns[2].Width +
      VSTSummary.Header.Columns[3].Width + VSTSummary.Header.Columns[4].Width +
      VSTSummary.Header.Columns[5].Width + VSTSummary.Header.Columns[6].Width +
      VSTSummary.Header.Columns[7].Width) and
      (X <= VSTSummary.Header.Columns[0].Width + VSTSummary.Header.Columns[1].Width +
      VSTSummary.Header.Columns[2].Width + VSTSummary.Header.Columns[3].Width +
      VSTSummary.Header.Columns[4].Width + VSTSummary.Header.Columns[5].Width +
      VSTSummary.Header.Columns[6].Width + VSTSummary.Header.Columns[7].Width +
      VSTSummary.Header.Columns[8].Width) then
      VSTSummary.Tag := 8
    else
      VSTSummary.Tag := 0;
  except
  end;

  if VSTSummary.HelpContext = 0 then chaPie.Visible := False;

  if (VSTSummary.Tag > 1) and (VSTSummary.HelpContext = 1) then
  begin
    try
      I := 0;
      serPie.Clear;
      chaPie.Visible := True;
      chaPie.Title.Text.Text :=
        VSTSummary.Header.Columns[VSTSummary.Tag].CaptionText + ' (' +
        tabCurrency.Tabs[tabCurrency.TabIndex] + ')';
      P := VSTSummary.GetFirst();
      P := VSTSummary.GetNext(P);

      while Assigned(P) do
      begin
        Summary := VSTSummary.GetNodeData(P);
        if VSTSummary.Tag = 2 then
        begin
          if Round(Summary.AccountAmount + Summary.StartSum) <> 0 then
          begin
            serPie.AddPie(Round(ABS(Summary.AccountAmount + Summary.StartSum)),
              Summary.Account, MyColors[I]);
            Inc(I);
          end;
        end
        else if VSTSummary.Tag = 3 then
        begin
          if Round(Summary.Credit) <> 0 then
          begin
            serPie.AddPie(Round(ABS(Summary.Credit)), Summary.Account, MyColors[I]);
            Inc(I);
          end;
        end
        else if VSTSummary.Tag = 4 then
        begin
          if Round(Summary.Debit) <> 0 then
          begin
            serPie.AddPie(Round(ABS(Summary.Debit)), Summary.Account, MyColors[I]);
            Inc(I);
          end;
        end
        else if VSTSummary.Tag = 5 then
        begin
          if Round(Summary.TransferP) <> 0 then
          begin
            serPie.AddPie(Round(ABS(Summary.TransferP)), Summary.Account, MyColors[I]);
            Inc(I);
          end;
        end
        else if VSTSummary.Tag = 6 then
        begin
          if Round(Summary.TransferM) <> 0 then
          begin
            serPie.AddPie(Round(ABS(Summary.TransferM)), Summary.Account, MyColors[I]);
            Inc(I);
          end;
        end
        else if VSTSummary.Tag = 7 then
        begin
          if Round(Summary.Credit + Summary.Debit + summary.TransferP +
            Summary.TransferM) <> 0 then
          begin
            serPie.AddPie(Round(ABS(Summary.Credit + Summary.Debit +
              summary.TransferP + Summary.TransferM)),
              Summary.Account, MyColors[I]);
            Inc(I);
          end;
        end
        else if VSTSummary.Tag = 8 then
        begin
          if Round(Summary.AccountAmount + Summary.StartSum +
            Summary.Credit + Summary.Debit + Summary.TransferP +
            Summary.TransferM) <> 0 then
          begin
            serPie.AddPie(Round(ABS(Summary.AccountAmount + Summary.StartSum +
              Summary.Credit + Summary.Debit + summary.TransferP + Summary.TransferM)),
              Summary.Account, MyColors[I]);
            Inc(I);
          end;
        end;

        if I = 15 then
          I := 0;
        P := VSTSummary.GetNext(P);
      end;
    except
      on E: Exception do
        ShowErrorMessage(E);
    end;
  end;
end;

procedure TfrmMain.VSTSummaryPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
var
  E: double;
begin
  try
    TryStrToFloat(ReplaceStr((Sender as TLazVirtualStringTree).Text[Node, Column],
      FS_own.ThousandSeparator, ''), E);

    TargetCanvas.Font.Bold := (vsSelected in node.States) or (Node.Index = 0);

    if (vsSelected in node.States) or (Node.Index = 0) then
    begin
      if (E < 0) then
        TargetCanvas.Font.Color := clYellow
      else
        TargetCanvas.Font.Color := clWhite;
      exit;
    end;

    if (Column > 1) and (Node.Index > 0) then
    begin
      if (E < 0) then
        TargetCanvas.Font.Color := clRed
      else
        TargetCanvas.Font.Color := clDefault;
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmMain.VSTSummaryResize(Sender: TObject);
var
  X: integer;
begin
  try
    if (frmSettings.chkAutoColumnWidth.Checked = False) or
      (pnlReport.Visible = True) then
      Exit;

    (Sender as TLazVirtualStringTree).Header.Columns[0].Width :=
      round(ScreenRatio * 25 / 100);
    X := (VSTSummary.Width - VSTSummary.Header.Columns[0].Width) div 27;
    VSTSummary.Header.Columns[1].Width :=
      VSTSummary.Width - VSTSummary.Header.Columns[0].Width - ScrollBarWidth - (21 * X);
    // account
    VSTSummary.Header.Columns[2].Width := 3 * X; // starting balance
    VSTSummary.Header.Columns[3].Width := 3 * X; // credits
    VSTSummary.Header.Columns[4].Width := 3 * X; // debits
    VSTSummary.Header.Columns[5].Width := 3 * X; // transfers +
    VSTSummary.Header.Columns[6].Width := 3 * X; // transfers -
    VSTSummary.Header.Columns[7].Width := 3 * X; // current ballance
    VSTSummary.Header.Columns[8].Width := 3 * X; // final ballance

    // VSTSummaries size and position
    VSTSummaries.Left := VSTSummary.Left + VSTSummary.Header.Columns[1].Width +
      VSTSummary.Header.Columns[2].Width;
    VSTSummaries.Width := VSTSummary.Width - VSTSummary.Header.Columns[0].Width -
      VSTSummary.Header.Columns[1].Width - VSTSummary.Header.Columns[2].Width -
      VSTSummary.Header.Columns[8].Width + 10;
    VSTSummaries.Height := VSTSummary.Header.Height +
      (2 * VSTSummary.NodeHeight[VSTSummaries.GetFirst()]) + 5;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmMain.mnuExitClick(Sender: TObject);
begin
  frmMain.Close;
end;

procedure TfrmMain.mnuGuideClick(Sender: TObject);
begin
  frmGuide.ShowModal;
end;

procedure TfrmMain.mnuHolidaysClick(Sender: TObject);
begin
  frmHolidays.ShowModal;
end;

procedure TfrmMain.mnuNewClick(Sender: TObject);
var
  S: string;
begin
  try
    sd.InitialDir := ExtractFileDir(Application.ExeName);
    if sd.Execute = False then
      Exit;

    // check connection of the database
    if conn.Connected = True then
      mnuCloseClick(mnuClose);
    if conn.Connected = True then
      Exit;

    screen.Cursor := crHourGlass;

    if FileExistsUTF8(sd.FileName) = True then
      if DeleteFileUTF8(sd.FileName) = False then
      begin
        ShowMessage(Error_01 + sLineBreak + sd.Filename);
        Exit;
      end;

    Conn.DatabaseName := sd.FileName;
    Conn.Connected := True;
    Conn.Open;

    Tran.StartTransaction;

    // SET AUTOMATIC VACUUM
    QRY.SQL.Text := 'PRAGMA foreign_keys = ON;';
    QRY.ExecSQL;

    //    CREATE MAIN TABLE [D]ATA
    QRY.SQL.Text :=
      'CREATE TABLE data (' + // create table DATA
      'd_date TEXT, ' + // date (YYYY-MM-DD format)
      'd_type INTEGER, ' + // type
      'd_sum REAL, ' + // sum (amount)
      'd_comment TEXT, ' + // comment
      'd_comment_lower TEXT, ' + //comment lower case
      'd_person INTEGER, ' + // person
      'd_category INTEGER, ' + // category
      'd_account INTEGER, ' + // account
      'd_payee INTEGER, ' + // payee
      'd_order INTEGER, ' + // sorting order (within one day)
      'd_id INTEGER PRIMARY KEY NOT NULL, ' + // ID
      'd_time TEXT);';
    QRY.ExecSQL;

    QRY.SQL.Text :=
      'CREATE TRIGGER after_insert_data ' + // create
      'AFTER INSERT ON data ' +  // trigger
      'FOR EACH ROW ' + // for
      'BEGIN UPDATE OR IGNORE data SET d_time = DateTime("Now", "localtime") ' +
      // update data
      'WHERE d_id = new.d_id; END;';
    QRY.ExecSQL;

    // CREATE TRIGGER BEFORE UPDATE DATA
    QRY.SQL.Text :=
      'CREATE TRIGGER before_update_data ' +   // create
      'BEFORE UPDATE ON data FOR EACH ROW ' + // after update
      'WHEN ((old.d_date <> new.d_date) OR (old.d_comment <> new.d_comment) OR ' +
      '(old.d_type <> new.d_type) OR ' +  //type
      '(old.d_sum <> new.d_sum) OR (old.d_person <> new.d_person) OR ' +
      '(old.d_account <> new.d_account) OR (old.d_category <> new.d_category) OR ' +
      '(old.d_payee <> new.d_payee)) ' + // payee
      'BEGIN ' +  // begin insert
      'INSERT OR IGNORE INTO history ' + // insert
      '(his_d_id, his_changed, his_date, his_type, his_sum, his_comment, ' +
      'his_person, his_category, his_account, his_payee) ' +
      'VALUES (old.d_id, old.d_time, ' + // values
      'old.d_date, old.d_type, old.d_sum, old.d_comment, old.d_person, ' +
      'old.d_category, old.d_account, old.d_payee); END;';
    QRY.ExecSQL;

    // CREATE TRIGGER AFTER UPDATE DATA
    QRY.SQL.Text :=
      'CREATE TRIGGER after_update_data ' + // create
      'AFTER UPDATE ON data ' +  // trigger
      'FOR EACH ROW ' + // for
      'BEGIN UPDATE OR IGNORE data SET d_time = DateTime("Now", "localtime") ' +
      // update data
      'WHERE d_id = new.d_id; END;';
    QRY.ExecSQL;

    // CREATE TRIGGER BEFORE DELETE DATA
    QRY.SQL.Text := 'CREATE TRIGGER before_delete_data ' + // 1
      'BEFORE DELETE ON data FOR EACH ROW BEGIN ' +  // 2
      'INSERT OR IGNORE INTO recycles (rec_date, rec_type, rec_sum, rec_comment, rec_person, '
      + 'rec_category, rec_account, rec_payee, rec_old_id) VALUES ' +
      '(old.d_date, old.d_type, old.d_sum, old.d_comment, old.d_person, ' +
      'old.d_category, old.d_account, old.d_payee, old.d_id); END;';
    QRY.ExecSQL;

    // CREATE TRIGGER AFTER DELETE DATA
    QRY.SQL.Text := 'CREATE TRIGGER after_delete_data ' + // 1
      'AFTER DELETE ON data FOR EACH ROW BEGIN ' +     // 2
      'UPDATE OR IGNORE data_tags SET dt_att = 1 WHERE dt_data = old.d_id;' +
      // set attribute to delete
      'DELETE FROM data_tags WHERE dt_data = old.d_id;' +  // tags
      'DELETE FROM history WHERE his_d_id = old.d_id;' +   // history
      'DELETE FROM attachments WHERE att_d_id = old.d_id;' +  // attachments
      'DELETE FROM transfers WHERE (tra_data1 = old.d_id) OR (tra_data2 = old.d_id); END;';
    QRY.ExecSQL;

    // **************************************************************************
    // INSERT TABLE [ATT]ACHMENTS

    QRY.SQL.Text :=
      'CREATE TABLE attachments (' + // create table
      'att_path TEXT, ' + // full path to the folder with the attachment
      'att_d_id INTEGER, ' + // ID of transaction (from table DATA)
      'att_id INTEGER PRIMARY KEY NOT NULL, ' + // ID of attachment
      'UNIQUE (att_path, att_d_id));';
    QRY.ExecSQL;

    // **************************************************************************
    // INSERT TABLE [TRA]NSFERS
    QRY.SQL.Text := 'CREATE TABLE transfers (' + // create table TRANSFERS
      'tra_data1 INTEGER, ' + // ID data credit
      'tra_data2 INTEGER, ' +  // ID data debit
      'tra_id INTEGER PRIMARY KEY);';
    QRY.ExecSQL;

    // **************************************************************************
    //    CREATE MAIN TABLE [REC]YCLE
    QRY.SQL.Text :=
      'CREATE TABLE recycles (' + // create table RECYCLES
      'rec_date TEXT, ' + // date (YYYY-MM-DD format)
      'rec_type INTEGER, ' + // type
      'rec_sum REAL, ' + // sum (amount)
      'rec_comment TEXT, ' + // comment
      'rec_person INTEGER, ' + // person
      'rec_category INTEGER, ' + // category
      'rec_account INTEGER, ' + // account
      'rec_payee INTEGER, ' + // payee
      'rec_id INTEGER PRIMARY KEY NOT NULL, ' + // ID
      'rec_old_id INTEGER, ' + // ID of deleted transaction (due tags)
      'rec_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP);';
    QRY.ExecSQL;

    // CREATE TRIGGER AFTER DELETE RECYCLES
    QRY.SQL.Text := 'CREATE TRIGGER after_delete_recycles ' +
      'AFTER DELETE ON recycles FOR EACH ROW BEGIN ' +     // 2
      'DELETE FROM recycle_tags WHERE rt_recycle = old.rec_id; END;';
    QRY.ExecSQL;

    // **************************************************************************
    // INSERT NEW TABLE [HIS]TORY
    QRY.SQL.Text := 'CREATE TABLE history (' + // create table HISTORY
      'his_d_id INTEGER, ' + // ID
      'his_changed TEXT, ' + // date of creation / modification transaction
      'his_date TEXT, ' + // date (YYYY-MM-DD format)
      'his_type INTEGER, ' + // type
      'his_sum REAL, ' + // sum (amount)
      'his_comment TEXT, ' + // comment
      'his_person INTEGER, ' + // person
      'his_category INTEGER, ' + // category
      'his_account INTEGER, ' + // account
      'his_payee INTEGER, ' + // payee
      'his_id INTEGER PRIMARY KEY);';
    QRY.ExecSQL;

    /// **************************************************************************
    // create table PERSONS
    QRY.SQL.Text :=
      'CREATE TABLE persons (' + // create table
      'per_name TEXT, ' + // name
      'per_name_lower TEXT UNIQUE, ' + // lower case name
      'per_comment TEXT, ' + // comment
      'per_status INTEGER, ' + // status
      'per_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP, ' + // time stamp
      'per_id INTEGER PRIMARY KEY NOT NULL);';
    QRY.ExecSQL;

    // CREATE TRIGGER AFTER DELETE PERSON
    QRY.SQL.Text := 'CREATE TRIGGER after_delete_person ' + // create
      'AFTER DELETE ON persons FOR EACH ROW BEGIN ' + // after
      'DELETE FROM data WHERE d_person = old.per_id;' +  // data
      'DELETE FROM payments WHERE pay_person = old.per_id;' + // payments
      'DELETE FROM scheduler WHERE sch_person = old.per_id; END;';
    QRY.ExecSQL;

    // **************************************************************************
    // create table [BUD]GET
    QRY.SQL.Text :=
      'CREATE TABLE budgets (' + // create table
      'bud_name TEXT UNIQUE, ' + // name
      'bud_type INTEGER, ' + // type
      'bud_id INTEGER PRIMARY KEY NOT NULL);';  // ID
    QRY.ExecSQL;

    // create table [BUD]GET + [CAT]EGORIES
    QRY.SQL.Text :=
      'CREATE TABLE budget_categories (' + // create table
      'budcat_category INTEGER, ' + // category
      'budcat_bud_id INTEGER, ' + // budget id
      'budcat_id INTEGER PRIMARY KEY NOT NULL);'; // ID
    QRY.ExecSQL;

    // create table [BUD]GET + [PER]IODS
    QRY.SQL.Text :=
      'CREATE TABLE budget_periods (' + // create table
      'budper_date1 TEXT, ' + // from date
      'budper_date2 TEXT, ' + // to date
      'budper_sum REAL, ' + // budgated amount
      'budper_bud_id INTEGER, ' + // budget ID
      'budper_cat_id INTEGER, ' + // category ID
      'budper_id INTEGER PRIMARY KEY NOT NULL, ' + // ID
      'UNIQUE (budper_date1, budper_date2, budper_bud_id, budper_cat_id));';
    QRY.ExecSQL;

    // CREATE TRIGGER AFTER DELETE BUDGET
    QRY.SQL.Text := 'CREATE TRIGGER before_delete_budgets ' +
      'BEFORE DELETE ON budgets FOR EACH ROW BEGIN ' +     // 2
      'DELETE FROM budget_categories WHERE budcat_bud_id = old.bud_id;' +
      'DELETE FROM budget_periods WHERE budper_bud_id = old.bud_id; END;';
    QRY.ExecSQL;

    // CREATE TRIGGER AFTER DELETE BUDGET_CATEGORIE
    QRY.SQL.Text := 'CREATE TRIGGER before_delete_budget_categories ' +
      'BEFORE DELETE ON budget_categories FOR EACH ROW BEGIN ' +     // 2
      'DELETE FROM budget_periods ' + // delete
      'WHERE budper_cat_id = old.budcat_category ' + // where
      'AND budper_bud_id = old.budcat_bud_id; END;';
    QRY.ExecSQL;

    // **************************************************************************
    // CREATE CODE-BOOKS OF [CAT]EGORIES
    QRY.SQL.Text :=
      'CREATE TABLE categories (' + // create table
      'cat_name TEXT, ' + // name
      'cat_parent_id INTEGER, ' + // parent ID
      'cat_parent_name TEXT, ' + // parent name
      'cat_status INTEGER, ' + // status
      'cat_comment TEXT, ' + // comment
      'cat_type INTEGER, ' + // type (0=all, 1=credit, 2=debit, 3=transfer)
      'cat_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP, ' + // time stamp
      'cat_id INTEGER PRIMARY KEY, ' + // ID
      'UNIQUE (cat_name, cat_parent_name, cat_parent_id));';
    QRY.ExecSQL;

    // CREATE TRIGGER BEFORE UPDATE CATEGORIES
    QRY.SQL.Text :=
      'CREATE TRIGGER before_update_categories ' + // create trigger
      'AFTER UPDATE OF cat_name ON categories FOR EACH ROW ' + // after
      'BEGIN ' + // begin
      'UPDATE OR IGNORE categories SET cat_parent_name = new.cat_name ' + // update
      'WHERE cat_parent_id <> "0" AND cat_parent_id = new.cat_id; ' + // condition
      'END;';
    QRY.ExecSQL;

    // CREATE TRIGGER AFTER UPDATE CATEGORIES
    QRY.SQL.Text :=
      'CREATE TRIGGER after_update_categories ' + // create trigger
      'AFTER UPDATE OF cat_status ON categories FOR EACH ROW ' + // after
      'BEGIN ' + // begin
      'UPDATE OR IGNORE categories SET cat_status = new.cat_status ' + // update
      'WHERE cat_parent_id <> "0" AND cat_parent_id = new.cat_id; ' + // condition
      'END;';
    QRY.ExecSQL;

    // CREATE TRIGGER AFTER DELETE CATEGORIES
    QRY.SQL.Text := 'CREATE TRIGGER after_delete_categories ' + // create trigger
      'AFTER DELETE ON categories FOR EACH ROW BEGIN ' + // after
      'DELETE FROM data WHERE d_category = old.cat_id OR ' +
      'd_category IN (SELECT cat_id FROM categories WHERE cat_parent_id = old.cat_id);' +
      'DELETE FROM payments WHERE pay_category = old.cat_id OR ' +
      'pay_category IN (SELECT cat_id FROM categories WHERE cat_parent_id = old.cat_id);'
      +
      'DELETE FROM scheduler WHERE sch_category = old.cat_id OR ' +
      'sch_category IN (SELECT cat_id FROM categories WHERE cat_parent_id = old.cat_id);'
      +
      'DELETE FROM budget_categories WHERE budcat_category = old.cat_id OR ' +
      'budcat_category IN (SELECT cat_id FROM categories WHERE cat_parent_id = old.cat_id);'
      + 'DELETE FROM categories WHERE cat_parent_id = old.cat_id; END;';
    QRY.ExecSQL;

    // CREATE TRIGGER AFTER UPDATE TYPE
    QRY.SQL.Text := 'CREATE TRIGGER after_update_type ' +
      'AFTER UPDATE OF cat_type ON categories FOR EACH ROW BEGIN ' +     // after
      'UPDATE OR IGNORE categories SET cat_type = new.cat_type ' + // update
      'WHERE cat_parent_id = new.cat_id; END;'; // where
    QRY.ExecSQL;

    // **************************************************************************
    // create table [ACC]OUNTS
    QRY.SQL.Text :=
      'CREATE TABLE accounts (' + // create table
      'acc_name TEXT, ' + // name
      'acc_name_lower TEXT, ' + // name lower case
      'acc_currency TEXT, ' + // currency
      'acc_date TEXT, ' + // starting date (YYYY-MM-DD format)
      'acc_amount REAL, ' + // starting balance
      'acc_status INTEGER, ' + // status
      'acc_comment TEXT, ' + // comment
      'acc_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP, ' + // datetime
      'acc_id INTEGER PRIMARY KEY NOT NULL, ' + // id
      'UNIQUE (acc_name_lower, acc_currency));';
    QRY.ExecSQL;

    // CREATE TRIGGER AFTER DELETE ACCOUNTS
    QRY.SQL.Text := 'CREATE TRIGGER after_delete_accounts ' + // create trigger
      'AFTER DELETE ON accounts FOR EACH ROW BEGIN ' + // after delete
      'DELETE FROM data WHERE d_account = old.acc_id;' +
      'DELETE FROM payments WHERE pay_account = old.acc_id;' +
      'DELETE FROM scheduler WHERE (sch_account1 = old.acc_id) or (sch_account2 = old.acc_id);END;';

    QRY.ExecSQL;

    // **************************************************************************
    // create table PAYEES
    QRY.SQL.Text :=
      'CREATE TABLE payees (' + // table
      'pee_name TEXT, ' +  // name
      'pee_name_lower TEXT UNIQUE, ' + // name lower case
      'pee_comment TEXT, ' + // comment
      'pee_status INTEGER, ' + // status
      'pee_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP, ' +
      'pee_id INTEGER PRIMARY KEY NOT NULL);';
    QRY.ExecSQL;

    // CREATE TRIGGER AFTER DELETE PAYEES
    QRY.SQL.Text := 'CREATE TRIGGER after_delete_payees ' +
      'AFTER DELETE ON payees FOR EACH ROW BEGIN ' +
      'DELETE FROM data WHERE d_payee = old.pee_id;' +
      'DELETE FROM payments WHERE pay_payee = old.pee_id ;' +
      'DELETE FROM scheduler WHERE sch_payee = old.pee_id; END;';
    QRY.ExecSQL;


    // **************************************************************************
    // create table VALUES
    QRY.SQL.Text :=
      'CREATE TABLE nominal (' + // create
      'nom_value REAL, ' + // nominal value
      'nom_coin INTEGER, ' + // type (banknote = 0 = False, coin = 1 = True)
      'nom_currency_id INTEGER, ' + // currency ID
      'nom_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP, ' + // time stamp
      'nom_id INTEGER PRIMARY KEY NOT NULL, ' + // ID
      'UNIQUE (nom_value, nom_currency_id));';
    QRY.ExecSQL;

    // **************************************************************************
    // create table CURRENCIES
    QRY.SQL.Text :=
      'CREATE TABLE currencies (' + // create
      'cur_code TEXT UNIQUE, ' + // code
      'cur_name TEXT, ' + // name
      'cur_default INTEGER, ' + // default (boolean)
      'cur_rate REAL, ' + // exchange rate (if not default)
      'cur_status INTEGER, ' + // status
      'cur_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP, ' + // time stamp
      'cur_id INTEGER PRIMARY KEY NOT NULL);';
    QRY.ExecSQL;

    // create trigger AFTER INSERT CURRENCIES
    QRY.SQL.Text :=
      'CREATE TRIGGER after_insert_currencies ' + // create trigger
      'AFTER INSERT ON currencies FOR EACH ROW BEGIN ' + // after condition
      'INSERT OR IGNORE INTO nominal (nom_value, nom_coin, nom_currency_id) VALUES ' +
      '(5000.00, 0, new.cur_id), ' + // 5000
      '(2000.00, 0, new.cur_id), ' + // 2000
      '(1000.00, 0, new.cur_id), ' + // 1000
      '( 500.00, 0, new.cur_id), ' + // 500
      '( 200.00, 0, new.cur_id), ' + // 200
      '( 100.00, 0, new.cur_id), ' + // 100
      '(  50.00, 0, new.cur_id), ' + // 50
      '(  20.00, 0, new.cur_id), ' + // 20
      '(  10.00, 0, new.cur_id), ' + // 10
      '(   5.00, 0, new.cur_id), ' + // 5
      '(   2.00, 1, new.cur_id), ' + // 2
      '(   1.00, 1, new.cur_id), ' + // 1
      '(   0.50, 1, new.cur_id), ' + // 0.50
      '(   0.20, 1, new.cur_id), ' + // 0.20
      '(   0.10, 1, new.cur_id), ' + // 0.10
      '(   0.05, 1, new.cur_id), ' + // 0.05
      '(   0.02, 1, new.cur_id), ' + // 0.02
      '(   0.01, 1, new.cur_id);' + // 0.01
      'END;';
    QRY.ExecSQL;

    // CREATE TRIGGER AFTER UPDATE CURRENCIES
    QRY.SQL.Text :=
      'CREATE TRIGGER after_update_currencies ' + // create trigger
      'AFTER UPDATE OF cur_code ON currencies FOR EACH ROW ' + // after
      'BEGIN ' + // begin
      'UPDATE OR IGNORE accounts SET acc_currency = new.cur_code ' + // update
      'WHERE acc_currency = old.cur_code; ' + // condition
      'END;';
    QRY.ExecSQL;

    // create trigger AFTER DELETE CURRENCIES
    QRY.SQL.Text :=
      'CREATE TRIGGER after_delete_currencies ' +
      'AFTER DELETE ON currencies FOR EACH ROW BEGIN ' +
      'DELETE FROM nominal WHERE nom_currency_id = old.cur_id; END;';
    QRY.ExecSQL;

    // **************************************************************************
    // insert a few mostly used currencies
    if AnsiLowerCase(LeftStr(GetLang, 2)) = 'cs' then
      S := '("CZK", "Česká koruna", 1, 1, 0);' // CZK
    else if AnsiLowerCase(LeftStr(GetLang, 2)) = 'br' then
      S := '("BRL", "Real Brasileiro", 1, 1, 0);' // BRL
    else if AnsiLowerCase(LeftStr(GetLang, 2)) = 'us' then
      S := '("USD", "U.S. dollar", 1, 1, 0);' // USD
    else if AnsiLowerCase(LeftStr(GetLang, 2)) = 'hu' then
      S := '("HUF", "Magyar forint", 1, 1, 0);' // HUF
    else if AnsiLowerCase(LeftStr(GetLang, 2)) = 'pl' then
      S := '("PLN", "Złoty", 1, 1, 0);' // PLN
    else
      S := '("EUR", "Euro", 1, 1, 0);';

    QRY.SQL.Text :=
      'INSERT OR IGNORE INTO currencies (cur_code, cur_name, cur_default, cur_rate, cur_status) VALUES '
      + S;
    QRY.ExecSQL;

    // **************************************************************************
    // create table COMMENTS
    QRY.SQL.Text :=
      'CREATE TABLE comments (' + // table
      'com_text TEXT UNIQUE, ' + // comment
      'com_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP, ' + // time stamp
      'com_id INTEGER PRIMARY KEY NOT NULL);';
    QRY.ExecSQL;

    // **************************************************************************
    // CREATE CODE-BOOKS OF [SCH]EDULER
    QRY.SQL.Text := 'CREATE TABLE scheduler (' + // create table
      'sch_date_from TEXT, ' + // date from  (YYYY-MM-DD format)
      'sch_date_to TEXT, ' + // date to  (YYYY-MM-DD format)
      'sch_period INTEGER, ' + // periodicity
      'sch_type INTEGER, ' + // type
      'sch_sum1 REAL, ' + // sum
      'sch_sum2 REAL, ' + // sum
      'sch_comment TEXT, ' + // comment
      'sch_account1 INTEGER, ' + // account
      'sch_account2 INTEGER, ' + // account
      'sch_category INTEGER, ' + // category
      'sch_person INTEGER, ' + // person
      'sch_payee INTEGER, ' + // payee
      'sch_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP, ' + // timestamp
      'sch_id INTEGER PRIMARY KEY);';
    QRY.ExecSQL;

    // CREATE TRIGGER TO SCHEDULE - FIXED PAYMENTS (AFTER DELETING)
    QRY.SQL.Text := 'CREATE TRIGGER after_delete_scheduler ' + // create
      'AFTER DELETE ON scheduler FOR EACH ROW BEGIN ' + // after
      'DELETE FROM schedulers_tags WHERE st_scheduler = old.sch_id;' +
      'DELETE FROM payments WHERE pay_sch_id = old.sch_id; END;'; // where
    QRY.ExecSQL;

    // **************************************************************************
    // CREATE CODE-BOOKS OF [PAY]MENTS
    QRY.SQL.Text := 'CREATE TABLE payments (' + // create table
      'pay_date_plan TEXT, ' + // date of scheduled payment (YYYY-MM-DD format)
      'pay_date_paid TEXT, ' + // date of real payment (YYYY-MM-DD format)
      'pay_type INTEGER, ' + // type
      'pay_sum REAL, ' + // sum
      'pay_comment TEXT, ' + // type
      'pay_account INTEGER, ' + // account
      'pay_category INTEGER, ' + // category
      'pay_person INTEGER, ' + // person
      'pay_payee INTEGER, ' + // payee
      'pay_sch_id INTEGER, ' + // ID of the scheduler
      'pay_id INTEGER PRIMARY KEY);';
    QRY.ExecSQL;

    // CREATE TRIGGER AFTER INSERT PAYMENTS
    QRY.SQL.Text := 'CREATE TRIGGER after_insert_payments ' + // create
      'AFTER INSERT ON payments ' + // after insert
      'BEGIN ' + // after
      'UPDATE OR IGNORE scheduler SET sch_date_to = (' + // update
      'SELECT pay_date_plan FROM payments ' + // SELECT
      'WHERE scheduler.sch_id = payments.pay_sch_id ' +
      'ORDER BY pay_date_plan DESC LIMIT 1) ' +
      // higher date
      'WHERE scheduler.sch_id = new.pay_sch_id; END;'; // where
    QRY.ExecSQL;

    // CREATE TRIGGER AFTER UPDATE PAYMENTS
    QRY.SQL.Text := 'CREATE TRIGGER after_update_payments ' + // create
      'AFTER UPDATE ON payments ' + // after insert
      'BEGIN ' + // after
      'UPDATE OR IGNORE scheduler SET sch_date_to = (' + // update
      'SELECT pay_date_plan FROM payments ' + // SELECT
      'WHERE scheduler.sch_id = payments.pay_sch_id ' +
      'ORDER BY pay_date_plan DESC LIMIT 1) ' +
      // higher date
      'WHERE scheduler.sch_id = new.pay_sch_id; END;'; // where
    QRY.ExecSQL;

    // CREATE TRIGGER BEFORE DELETE PAYMENTS
    QRY.SQL.Text := 'CREATE TRIGGER before_delete_payments ' +
      'BEFORE DELETE ON payments FOR EACH ROW BEGIN ' +     // 2
      'DELETE FROM payments_tags WHERE pt_payment = old.pay_id; END;';
    QRY.ExecSQL;

    // CREATE TRIGGER AFTER DELETE PAYMENTS
    QRY.SQL.Text := 'CREATE TRIGGER after_delete_payments ' + // create
      'AFTER DELETE ON payments ' + // after insert
      'WHEN (SELECT COUNT(*) FROM payments ' +
      'WHERE payments.pay_sch_id = old.pay_sch_id) > 0 ' + // WHEN
      'BEGIN ' + // after
      'UPDATE OR IGNORE scheduler SET sch_date_to = (' + // update
      'SELECT pay_date_plan FROM payments ' + // SELECT
      'WHERE scheduler.sch_id = old.pay_sch_id ORDER BY pay_date_plan DESC LIMIT 1) ' +
      // higher date
      'WHERE scheduler.sch_id = old.pay_sch_id; END;'; // where
    QRY.ExecSQL;

    // **************************************************************************  Ů
    // create table TAGS
    QRY.SQL.Text :=
      'CREATE TABLE tags (' + // table
      'tag_name TEXT UNIQUE, ' + // name
      'tag_comment TEXT, ' +  // comment
      'tag_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP, ' + // time
      'tag_id INTEGER PRIMARY KEY NOT NULL);';
    QRY.ExecSQL;

    // CREATE TRIGGER AFTER DELETE TAGS
    QRY.SQL.Text := 'CREATE TRIGGER after_delete_tags ' + // 1
      'AFTER DELETE ON tags FOR EACH ROW BEGIN ' +     // 2
      'DELETE FROM data_tags WHERE dt_tag = old.tag_id;' +
      'DELETE FROM payments_tags WHERE pt_tag = old.tag_id;' +
      'DELETE FROM recycle_tags WHERE rt_tag = old.tag_id;' +
      'DELETE FROM schedulers_tags WHERE st_tag = old.tag_id; END;';
    QRY.ExecSQL;

    // **************************************************************************
    // create table DATA-TAGS
    QRY.SQL.Text :=
      'CREATE TABLE data_tags (' + // table
      'dt_data INTEGER, ' + // ID record of data
      'dt_tag INTEGER, ' +  // ID record of tags
      'dt_att INTEGER, ' +  // attribute for deleting
      'dt_id INTEGER PRIMARY KEY NOT NULL, ' + // ID
      'UNIQUE(dt_data, dt_tag));';
    QRY.ExecSQL;

    // CREATE TRIGGER AFTER DELETE DATA_TAGS
    QRY.SQL.Text := 'CREATE TRIGGER after_delete_data_tags ' + // create
      'AFTER DELETE ON data_tags ' + // after
      'WHEN old.dt_att = 1 BEGIN ' + // attribute for data_tags prepared for deleting
      'INSERT OR IGNORE INTO recycle_tags (rt_recycle, rt_tag) VALUES (' +
      '(SELECT rec_id FROM recycles WHERE rec_old_id = old.dt_data), ' +
      'old.dt_tag); END;';
    QRY.ExecSQL;

    // **************************************************************************
    // create table SCHEDULERS-TAGS
    QRY.SQL.Text :=
      'CREATE TABLE schedulers_tags (' + // table
      'st_scheduler INTEGER, ' + // ID record of scheduler
      'st_tag INTEGER, ' +  // ID record of tags
      'st_id INTEGER PRIMARY KEY NOT NULL, ' + // ID
      'UNIQUE(st_scheduler, st_tag));';
    QRY.ExecSQL;

    // **************************************************************************
    // create table PAYMENTS-TAGS
    QRY.SQL.Text :=
      'CREATE TABLE payments_tags (' + // table
      'pt_payment INTEGER, ' + // ID record of payment
      'pt_tag INTEGER, ' +  // ID record of tags
      'pt_id INTEGER PRIMARY KEY NOT NULL, ' + // ID
      'UNIQUE(pt_payment, pt_tag));';
    QRY.ExecSQL;

    // **************************************************************************
    // create table RECYCLE-TAGS
    QRY.SQL.Text :=
      'CREATE TABLE recycle_tags (' + // table
      'rt_recycle INTEGER, ' + // ID record of recycle
      'rt_tag INTEGER, ' +  // ID record of tags
      'rt_id INTEGER PRIMARY KEY NOT NULL, ' + // ID
      'UNIQUE(rt_recycle, rt_tag));';
    QRY.ExecSQL;

    // -------------------------------------------------------------------
    // create table HOLIDAYS
    QRY.SQL.Text :=
      'CREATE TABLE holidays (' + // create table
      'hol_day INTEGER, ' + // day
      'hol_month INTEGER, ' + // month
      'hol_name TEXT, ' + // holiday name
      'hol_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP, ' + // time stamp
      'hol_id INTEGER PRIMARY KEY NOT NULL, ' + // ID
      'UNIQUE (hol_day, hol_month));';
    QRY.ExecSQL;

    // **************************************************************************
    // create table SETTINGS
    QRY.SQL.Text :=
      'CREATE TABLE settings (' + // create table
      'set_parameter TEXT UNIQUE, ' + // parameter
      'set_value TEXT);'; // value
    QRY.ExecSQL;

    // insert settings
    QRY.SQL.Text :=
      'INSERT OR IGNORE INTO settings (set_parameter, set_value) VALUES ' + // INSERT
      '("program", "RQ3"), ' + // program
      '("version", "3"), ' + // version
      '("password", NULL), ' + // password
      '("sort_column", "1"), ' + // sorting column
      '("sort_order", "0"), ' + // sorting order
      '("summary_sort_column", "1"), ' + // sorting column for summary
      '("summary_sort_order", "0"), ' + // sorting order for summary
      '("filter_type", "0•0"), ' + // filter type
      '("filter_date_type", "0000"), ' + // filter date type
      '("filter_date_1", NULL), ' + // date 1
      '("filter_date_2", NULL), ' + // date 2
      '("filter_currency", "0•0"), ' + // currency
      '("filter_account", "0•0"), ' + /// account
      '("filter_amount_type", "000"), ' + // amount type 1
      '("filter_amount_value_1", NULL), ' + // amount value 1
      '("filter_amount_value_2", NULL), ' + // amount value 2
      '("filter_comment_type", "00"), ' + // comment type
      '("filter_comment_text", NULL), ' + // comment text
      '("filter_category", "0•0"), ' + // category
      '("filter_person", "0•0"), ' + // person
      '("filter_payee", "0•0"), ' + // payee
      '("filter_tag", "0•0"),' + // tag
      '("last_transaction_type", NULL),' + // new transactions type
      '("last_transaction_date_from", NULL),' + // new transactions date frin
      '("last_transaction_date_to", NULL),' + // new transactions date to
      '("last_transaction_account_from", NULL),' + // new transactions account from
      '("last_transaction_account_to", NULL),' + // new transactions account to
      '("last_transaction_amount_from", NULL),' + // new transactions amount from
      '("last_transaction_amount_to", NULL),' + // new transactions amount to
      '("last_transaction_comment", NULL),' + // new transactions comment
      '("last_transaction_category", NULL),' + // new transactions category
      '("last_transaction_subcategory", NULL),' + // new transactions subcategory
      '("last_transaction_person", NULL),' + // new transactions person
      '("last_transaction_payee", NULL),' + // new transactions payee
      '("last_transaction_used", NULL);'; // boolean, if last image was used

    QRY.ExecSQL;

    // **************************************************************************
    // create table TEMPLATES (for import)
    QRY.SQL.Text :=
      'CREATE TABLE templates (' + // create table
      'tem_name TEXT UNIQUE, ' + // template name
      'tem_first INTEGER, ' + // don't import from beginning (lines)
      'tem_last INTEGER, ' + // don't import from end (lines)
      'tem_separator TEXT, ' + // fields separator
      'tem_quotes INTEGER, ' + // cut quotes
      'tem_date INTEGER, ' + // date column
      'tem_format TEXT, ' + // date format
      'tem_amount INTEGER, ' + // amount column
      'tem_decimal TEXT, ' + // decimal separator for amount
      'tem_thousand TEXT, ' + // thousand separator for amount
      'tem_type INTEGER, ' + // type column
      'tem_credit TEXT, ' + // character for credit type (0 if via signs)
      'tem_debit TEXT, ' + // character for debit type
      'tem_account TEXT, ' + // account name
      'tem_comment INTEGER, ' + // comment column
      'tem_comment_text TEXT, ' + // predefined comment
      'tem_category TEXT, ' + // category name
      'tem_person TEXT, ' + // person name
      'tem_payee TEXT, ' + // payee name
      'tem_columns INTEGER, ' + // columns count
      'tem_id INTEGER PRIMARY KEY NOT NULL);'; // id
    QRY.ExecSQL;

    // **************************************************************************
    // create table LINKS (internet addresses)
    QRY.SQL.Text :=
      'CREATE TABLE links (' +  // create table
      'lin_name TEXT, ' + //  name
      'lin_link TEXT UNIQUE, ' + // link
      'lin_shortcut TEXT, ' + // shortcut
      'lin_comment TEXT, ' + // comment
      'lin_id INTEGER PRIMARY KEY);'; // id
    QRY.ExecSQL;

    // **************************************************************************
    // create table NOTES (internal comments)
    QRY.SQL.Text :=
      'CREATE TABLE notes (' + // create table
      'not_name TEXT UNIQUE, ' + // name
      'not_text TEXT, ' + // text
      'not_id INTEGER PRIMARY KEY);';
    QRY.ExecSQL;

    // **************************************************************************
    Tran.Commit;

    //    QRY.Close;
    try
      Conn.Close(True);
    except
    end;

    frmGate.ediGate.Hint := '';

    // ==========================================================================
    // OPEN NEW CREATED FILE
    // ==========================================================================
    OpenFileX(sd.FileName);

    screen.Cursor := crDefault;

    // Message about successful creating + offering the guide for beginners
    frmSuccess.ShowModal;

  except
    on E: Exception do
    begin
      screen.Cursor := crDefault;
      ShowErrorMessage(E);
      Conn.Close;
    end;
  end;
end;

procedure TfrmMain.mnuTagsClick(Sender: TObject);
begin
  frmTags.ShowModal;
end;

procedure TfrmMain.mnuOpenClick(Sender: TObject);
begin
  try
    if od.Execute = False then
      Exit;

    // kontrola otvorenej databázy
    if conn.Connected = True then
      mnuCloseClick(mnuClose);
    if conn.Connected = True then
      Exit;

    OpenFileX(od.FileName);
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmMain.mnuPasswordClick(Sender: TObject);
begin
  frmPassword.ShowModal;
end;

procedure TfrmMain.mnuPayeesClick(Sender: TObject);
begin
  frmPayees.ShowModal;
end;

procedure TfrmMain.mnuCloseClick(Sender: TObject);
label
  ReadPasswordAgain;
var
  INI: TINIFile;
  INIFile, Temp: string;
  s1, s2: TStringStream;
  En: TBlowfishEncryptStream;
  F: TFileListBox;
  D1: TDateTime;
  DoBackup: boolean;
begin
  try
    if Conn.Connected = True then
    begin
      if frmSettings.chkCloseDbWarning.Checked = True then
        if MessageDlg(Application.Title, Question_00 + sLineBreak +
          conn.DatabaseName, mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
          Exit;

      // =====================================================================
      // SAVE SETTINGS TO INI FILE
      // =====================================================================
      INIFile := ChangeFileExt(ParamStr(0), '.ini');
      INI := TINIFile.Create(INIFile);

      // save last used file
      if frmSettings.chkLastUsedFile.Checked = True then
        INI.WriteString('ON_START', 'LastFile', frmMain.Conn.DatabaseName)
      else
        INI.WriteString('ON_START', 'LastFile', '');

      INI.UpdateFile;
      INI.Free;
      INIFile := frmMain.conn.DatabaseName;

      // =====================================================================
      // SAVE ALL DATABASE SETTINGS
      // =====================================================================

      frmMain.Tran.EndTransaction;
      try
        frmMain.Tran.StartTransaction;

        // save sorted column
        frmMain.QRY.SQL.Text :=
          'UPDATE or IGNORE settings SET set_value = :COLUMN WHERE set_parameter = "sort_column";';
        frmMain.QRY.Params.ParamByName('COLUMN').AsString :=
          IntToStr(VST.Header.SortColumn);
        frmMain.QRY.Prepare;
        frmMain.QRY.ExecSQL;

        // save sorting order
        frmMain.QRY.SQL.Text :=
          'UPDATE OR IGNORE settings SET set_value = :ORDER WHERE set_parameter = "sort_order";';
        frmMain.QRY.Params.ParamByName('ORDER').AsString :=
          BoolToStr(VST.Header.SortDirection = sdAscending);
        frmMain.QRY.Prepare;
        frmMain.QRY.ExecSQL;

        // save sorted column for summary
        frmMain.QRY.SQL.Text :=
          'UPDATE or IGNORE settings SET set_value = :COLUMN WHERE set_parameter = "summary_sort_column";';
        frmMain.QRY.Params.ParamByName('COLUMN').AsString :=
          IntToStr(VSTSummary.Header.SortColumn);
        frmMain.QRY.Prepare;
        frmMain.QRY.ExecSQL;

        // save sorting order for summary
        frmMain.QRY.SQL.Text :=
          'UPDATE OR IGNORE settings SET set_value = :ORDER WHERE set_parameter = "summary_sort_order";';
        frmMain.QRY.Params.ParamByName('ORDER').AsString :=
          BoolToStr(VSTSummary.Header.SortDirection = sdAscending);
        frmMain.QRY.Prepare;
        frmMain.QRY.ExecSQL;

        // =====================================================================
        // SAVE ALL FILTER SETTINGS
        // =====================================================================

        // Type
        frmMain.QRY.SQL.Text :=
          'UPDATE OR IGNORE settings SET set_value = :VALUE WHERE set_parameter = "filter_type";';
        frmMain.QRY.Params.ParamByName('VALUE').AsString :=
          IntToStr(pnlTypeCaption.Tag) + separ + IntToStr(cbxType.ItemIndex) +
          IfThen(cbxType.ItemIndex = -1, separ + cbxType.Hint, '');
        frmMain.QRY.Prepare;
        frmMain.QRY.ExecSQL;

        // Date type
        frmMain.QRY.SQL.Text :=
          'UPDATE OR IGNORE settings SET set_value = :VALUE WHERE set_parameter = "filter_date_type";';
        frmMain.QRY.Params.ParamByName('VALUE').AsString :=
          IntToStr(pnlDateCaption.Tag) + IntToStr(pnlDayCaption.Tag) +
          IntToStr(pnlMonthYearCaption.Tag) + IntToStr(pnlPeriodCaption.Tag);
        frmMain.QRY.Prepare;
        frmMain.QRY.ExecSQL;

        // Date value 1
        Temp := '';
        frmMain.QRY.SQL.Text :=
          'UPDATE OR IGNORE settings SET set_value = :VALUE WHERE set_parameter = "filter_date_1";';
        if pnlDayCaption.Tag = 1 then
          Temp := FormatDateTime('YYYY-MM-DD', Calendar.Date)
        else if pnlMonthYearCaption.Tag = 1 then
          Temp := IntToStr(cbxMonth.ItemIndex)
        else if pnlPeriodCaption.Tag = 1 then
          Temp := FormatDateTime('YYYY-MM-DD', datDateFrom.Date);
        if Temp = '' then
          frmMain.QRY.Params.ParamByName('VALUE').Value := NULL
        else
          frmMain.QRY.Params.ParamByName('VALUE').AsString := Temp;
        frmMain.QRY.Prepare;
        frmMain.QRY.ExecSQL;

        // Date value 2
        Temp := '';
        frmMain.QRY.SQL.Text :=
          'UPDATE OR IGNORE settings SET set_value = :VALUE WHERE set_parameter = "filter_date_2";';
        if pnlMonthYearCaption.Tag = 1 then
          Temp := IntToStr(cbxYear.ItemIndex)
        else if pnlPeriodCaption.Tag = 1 then
          Temp := FormatDateTime('YYYY-MM-DD', datDateTo.Date);
        if Temp = '' then
          frmMain.QRY.Params.ParamByName('VALUE').Value := NULL
        else
          frmMain.QRY.Params.ParamByName('VALUE').AsString := Temp;
        frmMain.QRY.Prepare;
        frmMain.QRY.ExecSQL;

        // Currency
        frmMain.QRY.SQL.Text :=
          'UPDATE OR IGNORE settings SET set_value = :VALUE WHERE set_parameter = "filter_currency";';
        frmMain.QRY.Params.ParamByName('VALUE').AsString :=
          IntToStr(pnlCurrencyCaption.Tag) + separ + IntToStr(cbxCurrency.ItemIndex) +
          IfThen(cbxCurrency.ItemIndex = -1, separ + separ + cbxCurrency.Hint, '');
        frmMain.QRY.Prepare;
        frmMain.QRY.ExecSQL;

        // Account
        frmMain.QRY.SQL.Text :=
          'UPDATE OR IGNORE settings SET set_value = :VALUE WHERE set_parameter = "filter_account";';
        frmMain.QRY.Params.ParamByName('VALUE').AsString :=
          IntToStr(pnlAccountCaption.Tag) + separ + IntToStr(cbxAccount.ItemIndex) +
          IfThen(cbxAccount.ItemIndex = -1, separ + separ + separ + cbxAccount.Hint, '');
        frmMain.QRY.Prepare;
        frmMain.QRY.ExecSQL;

        // Amount type
        frmMain.QRY.SQL.Text :=
          'UPDATE OR IGNORE settings SET set_value = :VALUE WHERE set_parameter = "filter_amount_type";';
        frmMain.QRY.Params.ParamByName('VALUE').AsString :=
          IntToStr(pnlAmountCaption.Tag) + IntToStr(cbxMin.ItemIndex) +
          IntToStr(cbxMax.ItemIndex);
        frmMain.QRY.Prepare;
        frmMain.QRY.ExecSQL;

        // Amount minimum amount
        frmMain.QRY.SQL.Text :=
          'UPDATE OR IGNORE settings SET set_value = :VALUE WHERE set_parameter = "filter_amount_value_1";';
        if cbxMin.ItemIndex = 0 then
          frmMain.QRY.Params.ParamByName('VALUE').Value := NULL
        else
          frmMain.QRY.Params.ParamByName('VALUE').AsString :=
            ReplaceStr(FloatToStr(spiMin.Value), FS_own.DecimalSeparator, '.');
        frmMain.QRY.Prepare;
        frmMain.QRY.ExecSQL;

        // Amount maximum amount
        frmMain.QRY.SQL.Text :=
          'UPDATE OR IGNORE settings SET set_value = :VALUE WHERE set_parameter = "filter_amount_value_2";';
        if cbxMax.ItemIndex = 0 then
          frmMain.QRY.Params.ParamByName('VALUE').Value := NULL
        else
          frmMain.QRY.Params.ParamByName('VALUE').AsString :=
            ReplaceStr(FloatToStr(spiMax.Value), FS_own.DecimalSeparator, '.');
        frmMain.QRY.Prepare;
        frmMain.QRY.ExecSQL;

        // Comment type
        frmMain.QRY.SQL.Text :=
          'UPDATE OR IGNORE settings SET set_value = :VALUE WHERE set_parameter = "filter_comment_type";';
        frmMain.QRY.Params.ParamByName('VALUE').AsString :=
          IntToStr(pnlCommentCaption.Tag) + IntToStr(cbxComment.ItemIndex);
        frmMain.QRY.Prepare;
        frmMain.QRY.ExecSQL;

        // Comment text
        frmMain.QRY.SQL.Text :=
          'UPDATE OR IGNORE settings SET set_value = :VALUE WHERE set_parameter = "filter_comment_text";';
        if Length(ediComment.Text) = 0 then
          frmMain.QRY.Params.ParamByName('VALUE').Value := NULL
        else
          frmMain.QRY.Params.ParamByName('VALUE').AsString := ediComment.Text;
        frmMain.QRY.Prepare;
        frmMain.QRY.ExecSQL;

        // Category
        frmMain.QRY.SQL.Text :=
          'UPDATE OR IGNORE settings SET set_value = :VALUE WHERE set_parameter = "filter_category";';
        frmMain.QRY.Params.ParamByName('VALUE').AsString :=
          IntToStr(frmMain.pnlCategoryCaption.Tag) + separ +
          IntToStr(frmMain.cbxCategory.ItemIndex) +
          IfThen(frmMain.cbxCategory.ItemIndex = -1, separ + separ +
          separ + frmMain.cbxCategory.Hint, separ +
          IfThen(frmMain.cbxSubcategory.ItemIndex = -1, '-1' + separ +
          separ + separ + frmMain.cbxSubcategory.Hint,
          IntToStr(frmMain.cbxSubcategory.ItemIndex)));
        frmMain.QRY.Prepare;
        frmMain.QRY.ExecSQL;

        // Person
        frmMain.QRY.SQL.Text :=
          'UPDATE OR IGNORE settings SET set_value = :VALUE WHERE set_parameter = "filter_person";';
        frmMain.QRY.Params.ParamByName('VALUE').AsString :=
          IntToStr(pnlPersonCaption.Tag) + separ + IntToStr(cbxPerson.ItemIndex) +
          IfThen(cbxPerson.ItemIndex = -1, separ + separ + cbxPerson.Hint, '');
        frmMain.QRY.Prepare;
        frmMain.QRY.ExecSQL;

        // Payee
        frmMain.QRY.SQL.Text :=
          'UPDATE OR IGNORE settings SET set_value = :VALUE WHERE set_parameter = "filter_payee";';
        frmMain.QRY.Params.ParamByName('VALUE').AsString :=
          IntToStr(pnlPayeeCaption.Tag) + separ + IntToStr(cbxPayee.ItemIndex) +
          IfThen(cbxPayee.ItemIndex = -1, separ + separ + cbxPayee.Hint, '');
        frmMain.QRY.Prepare;
        frmMain.QRY.ExecSQL;

        // Tags
        frmMain.QRY.SQL.Text :=
          'UPDATE OR IGNORE settings SET set_value = :VALUE WHERE set_parameter = "filter_tag";';
        frmMain.QRY.Params.ParamByName('VALUE').AsString :=
          IntToStr(pnlTagCaption.Tag) + separ + IntToStr(cbxTag.ItemIndex) +
          IfThen(cbxTag.ItemIndex = -1, separ + separ + cbxTag.Hint, '');
        frmMain.QRY.Prepare;
        frmMain.QRY.ExecSQL;

        // *********************************************************************
        // SAVE LAST TRANSACTION IMAGE (used items)
        // *********************************************************************
        // new transactions type
        frmMain.QRY.SQL.Text :=
          'UPDATE OR IGNORE settings SET set_value = :VALUE WHERE set_parameter = "last_transaction_type";';
        frmMain.QRY.Params.ParamByName('VALUE').AsInteger := frmDetail.cbxType.ItemIndex;
        frmMain.QRY.Prepare;
        frmMain.QRY.ExecSQL;

        // new transactions date from
        frmMain.QRY.SQL.Text :=
          'UPDATE OR IGNORE settings SET set_value = :VALUE WHERE set_parameter = "last_transaction_date_from";';
        frmMain.QRY.Params.ParamByName('VALUE').AsString :=
          FormatDateTime('YYYY-MM-DD', frmDetail.datDateFrom.Date);
        frmMain.QRY.Prepare;
        frmMain.QRY.ExecSQL;

        // new transactions date to
        frmMain.QRY.SQL.Text :=
          'UPDATE OR IGNORE settings SET set_value = :VALUE WHERE set_parameter = "last_transaction_date_to";';
        frmMain.QRY.Params.ParamByName('VALUE').AsString :=
          FormatDateTime('YYYY-MM-DD', frmDetail.datDateTo.Date);
        frmMain.QRY.Prepare;
        frmMain.QRY.ExecSQL;

        // new transactions account from
        frmMain.QRY.SQL.Text :=
          'UPDATE OR IGNORE settings SET set_value = :VALUE WHERE set_parameter = "last_transaction_account_from";';
        frmMain.QRY.Params.ParamByName('VALUE').AsInteger :=
          frmDetail.cbxAccountFrom.ItemIndex;
        frmMain.QRY.Prepare;
        frmMain.QRY.ExecSQL;

        // new transactions account to
        frmMain.QRY.SQL.Text :=
          'UPDATE OR IGNORE settings SET set_value = :VALUE WHERE set_parameter = "last_transaction_account_to";';
        frmMain.QRY.Params.ParamByName('VALUE').AsInteger :=
          frmDetail.cbxAccountTo.ItemIndex;
        frmMain.QRY.Prepare;
        frmMain.QRY.ExecSQL;

        // new transactions amount from
        frmMain.QRY.SQL.Text :=
          'UPDATE OR IGNORE settings SET set_value = :VALUE WHERE set_parameter = "last_transaction_amount_from";';
        frmMain.QRY.Params.ParamByName('VALUE').AsString :=
          AnsiReplaceStr(AnsiReplaceStr(frmDetail.spiAmountFrom.Text,
          FS_own.ThousandSeparator, ''), FS_own.DecimalSeparator, '.');
        frmMain.QRY.Prepare;
        frmMain.QRY.ExecSQL;

        // new transactions amount to
        frmMain.QRY.SQL.Text :=
          'UPDATE OR IGNORE settings SET set_value = :VALUE WHERE set_parameter = "last_transaction_amount_to";';
        frmMain.QRY.Params.ParamByName('VALUE').AsString :=
          AnsiReplaceStr(AnsiReplaceStr(frmDetail.spiAmountTo.Text,
          FS_own.ThousandSeparator, ''), FS_own.DecimalSeparator, '.');
        frmMain.QRY.Prepare;
        frmMain.QRY.ExecSQL;

        // new transactions comment
        frmMain.QRY.SQL.Text :=
          'UPDATE OR IGNORE settings SET set_value = :VALUE WHERE set_parameter = "last_transaction_comment";';
        frmMain.QRY.Params.ParamByName('VALUE').AsString := frmDetail.cbxComment.Text;
        frmMain.QRY.Prepare;
        frmMain.QRY.ExecSQL;

        // new transactions category
        frmMain.QRY.SQL.Text :=
          'UPDATE OR IGNORE settings SET set_value = :VALUE WHERE set_parameter = "last_transaction_category";';
        frmMain.QRY.Params.ParamByName('VALUE').AsInteger :=
          frmDetail.cbxCategory.ItemIndex;
        frmMain.QRY.Prepare;
        frmMain.QRY.ExecSQL;

        // new transactions subcategory
        frmMain.QRY.SQL.Text :=
          'UPDATE OR IGNORE settings SET set_value = :VALUE WHERE set_parameter = "last_transaction_subcategory";';
        frmMain.QRY.Params.ParamByName('VALUE').AsInteger :=
          frmDetail.cbxSubcategory.ItemIndex;
        frmMain.QRY.Prepare;
        frmMain.QRY.ExecSQL;

        // new transactions person
        frmMain.QRY.SQL.Text :=
          'UPDATE OR IGNORE settings SET set_value = :VALUE WHERE set_parameter = "last_transaction_person";';
        frmMain.QRY.Params.ParamByName('VALUE').AsInteger :=
          frmDetail.cbxPerson.ItemIndex;
        frmMain.QRY.Prepare;
        frmMain.QRY.ExecSQL;

        // new transactions payee
        frmMain.QRY.SQL.Text :=
          'UPDATE OR IGNORE settings SET set_value = :VALUE WHERE set_parameter = "last_transaction_payee";';
        frmMain.QRY.Params.ParamByName('VALUE').AsInteger :=
          frmDetail.cbxPayee.ItemIndex;
        frmMain.QRY.Prepare;
        frmMain.QRY.ExecSQL;

        // new transactions using
        frmMain.QRY.SQL.Text :=
          'UPDATE OR IGNORE settings SET set_value = 0 WHERE set_parameter = "last_transaction_used";';
        frmMain.QRY.ExecSQL;

      finally
        frmMain.Tran.Commit;
      end;

      if pnlReport.Visible = True then
        btnReportExitClick(btnReportExit);

      tabBalanceHeader.TabIndex := 0;
      tabBalanceHeaderChange(tabBalanceHeader);
      tabChronoHeader.TabIndex := 0;
      tabChronoHeaderChange(tabChronoHeader);
      tabCrossTop.TabIndex := 0;
      tabCrossLeft.TabIndex := 0;
      tabCrossLeftChange(tabCrossLeft);
      tabReports.TabIndex := 0;
      tabReportsChange(tabReports);

      // ================================================================
      // get encrypted password, then decrypt it
      // ================================================================
      try
        if (frmSettings.chkEncryptDatabase.Checked = True) then
        begin
          ReadPasswordAgain:
            frmMain.QRY.SQL.Text :=
              'SELECT set_value FROM settings WHERE set_parameter = "password";';
          frmMain.QRY.Open;
          Temp := frmMain.QRY.Fields[0].AsString;
          frmMain.QRY.Close;
          if Length(Temp) = 0 then
            if MessageDlg(Application.Title, AnsiReplaceStr(Question_28,
              '%', sLineBreak), mtConfirmation, [mbYes, mbNo], 0) = mrYes then
            begin
              frmPassword.ShowModal;
              goto ReadPasswordAgain;
            end;
        end;
      finally
        // close connected database
        frmMain.Conn.Close;
      end;

      // =====================================================================
      // ENCRYPTING THE DATABASE !!! =========================================
      // =====================================================================

      if (frmSettings.chkEncryptDatabase.Checked = True) and (Temp = '') then
        ShowMessage(Caption_326)
      else if (frmSettings.chkEncryptDatabase.Checked = True) and (Temp <> '') then
      begin
        Temp := XorDecode('5!9x4', Temp);
        s1 := TStringStream.Create('');
        s1.LoadFromFile(INIFile);
        s2 := TStringStream.Create('');  //make sure destination stream is blank
        En := TBlowfishEncryptStream.Create(ReverseString(Temp) + Temp, s2);
        En.copyfrom(s1, s1.size);
        s2.SaveToFile(INIFile);
        En.Free;
        s2.Free;
        s1.Free;
      end;

      // =====================================================================
      // BACKUP THE DATABASE !!! =============================================
      // =====================================================================
      if (frmSettings.chkDoBackup.Checked = True) then
      begin
        // if directory does not exist
        if DirectoryExistsUTF8(frmSettings.btnBackupFolder.Caption) = False then
          if MessageDlg(Message_00, AnsiReplaceStr(Caption_224, '%', sLineBreak),
            mtConfirmation, mbYesNo, 0) = mrYes then
          begin
            frmSettings.treSettings.Items[11].Selected := True;
            frmSettings.ShowModal;
          end;

        // if directory exists
        if DirectoryExistsUTF8(frmSettings.btnBackupFolder.Caption) = True then
        begin
          // get file age of first backup file (if exists)
          FileAge(INIFile, D1, True);
          Temp := frmSettings.btnBackupFolder.Caption + DirectorySeparator +
            ExtractFileNameOnly(INIFile) + FormatDateTime('_YYMMDD-hhnnss', D1) + '.RQ3';

          if FileExistsUTF8(Temp) = False then
          begin
            DoBackup := True;
            if (frmSettings.chkBackupQuestion.Checked = True) then
              if MessageDlg(Message_00, Question_27 + sLineBreak +
                frmSettings.btnBackupFolder.Caption, mtConfirmation,
                mbYesNo, 0) = mrNo then
                DoBackup := False;

            if DoBackup = True then
            begin
              // read existing database files
              F := TFileListBox.Create(nil);
              F.Directory := frmSettings.btnBackupFolder.Caption;
              F.Mask := ExtractFileNameOnly(INIFile) + '_??????-??????.RQ3';

              // delete the oldest file (if count is heigher than setted
              while F.Items.Count >= frmSettings.traBackupCount.Position do
              begin
                F.Sorted := True;
                DeleteFileUTF8(frmSettings.btnBackupFolder.Caption +
                  DirectorySeparator + F.Items[0]);
                F.UpdateFileList;
              end;

              // create backup (FileName.RQM + datetime stamp)
              FileUtil.CopyFile(INIFile, Temp);
              F.Free;
              if (frmSettings.chkBackupMessage.Checked = True) and
                (FileExistsUTF8(Temp) = True) then
                ShowMessage(Caption_227 + sLineBreak + AnsiUpperCase(
                  frmSettings.btnBackupFolder.Caption));
            end;
          end;
        end;
      end;
    end;

    Temp := ChangeFileExt(INIFILE, '.~tmp');
    if FileExistsUTF8(Temp) then
      DeleteFileUTF8(Temp);

    // =====================================================================
    // OTHER PROGRAM SETTINGS ==============================================
    // =====================================================================

    lblItems.Caption := '';

    // frmMain clear
    frmMain.VST.RootNodeCount := 0;
    UpdateSummary;
    tabCurrency.Tabs.Clear;

    // close panel Filter
    popFilterClear.Tag := 1;
    popFilterClearClick(popFilterClear); // include update transactions

    popFilterClear.Enabled := False;
    popFilterExpand.Enabled := False;
    popFilterCollapse.Enabled := False;
    actFilterClear.Enabled := False;
    actFilterExpand.Enabled := False;
    actFilterCollapse.Enabled := False;

    frmMain.pnlFilter.Enabled := False;
    frmMain.Caption := Application.Title;
    frmMain.chkShowPieChart.Enabled := False;

    // update main menu
    mnuClose.Enabled := False;
    mnuExport.Enabled := False;
    mnuImport.Enabled := False;

    mnuGuide.Enabled := False;
    mnuPassword.Enabled := False;
    mnuSQL.Enabled := False;
    mnuProperties.Enabled := False;
    mnuRecycle.Enabled := False;

    // update toolbar
    btnClose.Enabled := False;
    btnImport.Enabled := False;
    btnExport.Enabled := False;

    btnPassword.Enabled := False;
    btnGuide.Enabled := False;
    btnSQL.Enabled := False;
    btnProperties.Enabled := False;
    btnRecycle.Enabled := False;
    btnHistory.Enabled := False;

    // update transactions popup menu
    popAddSimple.Enabled := False;
    popAddMulitple.Enabled := False;
    popEdit.Enabled := False;
    popDuplicate.Enabled := False;
    popDelete.Enabled := False;
    popPrint.Enabled := False;
    popCopy.Enabled := False;
    popSelect.Enabled := False;
    popHistory.Enabled := False;

    // update transactions buttons
    pnlButtons.Enabled := False;

    btnAdd.Enabled := False;
    btnEdit.Enabled := False;
    btnDuplicate.Enabled := False;
    btnDelete.Enabled := False;
    btnPrint.Enabled := False;
    btnCopy.Enabled := False;
    btnSelect.Enabled := False;
    btnHistory.Enabled := False;

    pnlBottomClient.Visible := False;

    FormResize(frmMain);

    frmMain.VSTSummary.Enabled := False;

    // frmCurrencies
    UpdateCurrencies;

    // frmAccounts
    UpdateAccounts;

    // frmCategories
    UpdateCategories;

    // frmPersons
    UpdatePersons;

    // frmPayee
    UpdatePayees;

    // frmHolidays
    UpdateHolidays;

    // frmComments
    UpdateComments;

    // frmTags
    UpdateTags;

    // frmCashCounter
    frmCounter.cbxCurrency.ItemIndex := -1;
    frmCounter.cbxCurrencyChange(frmCounter.cbxCurrency);

    // frmSchedulers
    UpdateScheduler;

    // frmWrite
    UpdatePayments;

    // frmBudgets
    UpdateBudgets;

    // frmLinks
    UpdateLinks;

    // chart
    // chaBalance.ClearSeries;
    souBalanceCredits.Clear;
    souBalanceDebits.Clear;

  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmMain.mnuCommentsClick(Sender: TObject);
begin
  frmComments.ShowModal;
end;

procedure TfrmMain.mnuCurrenciesClick(Sender: TObject);
begin
  frmCurrencies.ShowModal;
end;

procedure TfrmMain.btnCopyClick(Sender: TObject);
begin
  if (Conn.Connected = False) then
    Exit;

  if (pnlReport.Visible = False) then
    if (VST.RootNodeCount > 0) then
    begin
      CopyVST(VST);
      VST.SetFocus;
    end;

  if (pnlReport.Visible = True) then
    case tabReports.TabIndex of
      0: if (VSTBalance.RootNodeCount > 0) then
        begin
          CopyVST(VSTBalance);
          if tabBalanceShow.TabIndex = 0 then
            VSTBalance.SetFocus;
        end;
      1: if (VSTChrono.RootNodeCount > 0) then
        begin
          CopyVST(VSTChrono);
          VSTChrono.SetFocus;
        end;
      2: if (VSTCross.RootNodeCount > 0) then
        begin
          CopyVST(VSTCross);
          VSTCross.SetFocus;
        end;
    end;
end;

procedure TfrmMain.btnDeleteClick(Sender: TObject);
var
  N: PVirtualNode;
  Transactions: PTransactions;
  IDs: string;
begin
  if (Conn.Connected = False) or (vST.RootNodeCount = 0) or
    (VST.SelectedCount = 0) or (pnlReport.Visible = True) then
    exit;

  // check date restrictions
  if frmSettings.rbtTransactionsDeleteDate.Checked = True then
  begin
    N := VST.GetFirstSelected(False);
    try
      while Assigned(N) do
      begin
        VST.GetNodeData(N);
        Transactions := VST.GetNodeData(N);
        if Transactions.Date < FormatDateTime('YYYY-MM-DD',
          frmSettings.datTransactionsDeleteDate.Date) then
        begin
          ShowMessage(Error_31 + ' ' + DateToStr(
            frmSettings.datTransactionsDeleteDate.Date) + sLineBreak + Error_28);
          Exit;
        end;
        N := VST.GetNextSelected(N);
      end;
    except
    end;
  end;

  // check days restrictions
  if frmSettings.rbtTransactionsDeleteDays.Checked = True then
  begin
    N := VST.GetFirstSelected(False);
    try
      while Assigned(N) do
      begin
        VST.GetNodeData(N);
        Transactions := VST.GetNodeData(N);
        if Transactions.Date < FormatDateTime('YYYY-MM-DD',
          Round(Now - frmSettings.spiTransactionsDeleteDays.Value)) then
        begin
          ShowMessage(Error_31 + ' ' + DateToStr(
            Round(Now - frmSettings.spiTransactionsDeleteDays.Value)) +
            sLineBreak + Error_28);
          Exit;
        end;
        N := VST.GetNextSelected(N);
      end;
    except
    end;
  end;

  //===============================================================================================
  //delete one item only
  if VST.SelectedCount = 1 then
  begin
    if MessageDlg(Message_00, Question_01 + sLineBreak + sLineBreak +
      VST.Header.Columns[1].Text + ': ' + VST.Text[VST.FocusedNode, 1] +
      sLineBreak + // date
      VST.Header.Columns[2].Text + ': ' + VST.Text[VST.FocusedNode, 2] +
      sLineBreak + VST.Header.Columns[3].Text + ': ' + VST.Text[VST.FocusedNode, 3] +
      '  ' + VST.Text[VST.FocusedNode, 4], mtConfirmation, mbYesNo, 0) <> 6 then
      Exit;


    //  // ===============================================================================================
    // delete multiple items
  end
  else
  begin
    if MessageDlg(Message_00, ReplaceStr(Question_02, '%', IntToStr(VST.SelectedCount)),
      mtConfirmation, mbYesNo, 0) <> 6 then
      Exit;
  end;

  // get IDs of all selected nodes
  IDs := '';
  N := VST.GetFirstSelected(False);
  try
    while Assigned(N) do
    begin
      VST.GetNodeData(N);
      IDs := IDs + VST.Text[N, 10] + ',';
      N := VST.GetNextSelected(N);
    end;
  finally
    IDs := LeftStr(IDs, Length(IDs) - 1);
  end;

  frmMain.QRY.SQL.Text := 'DELETE FROM data WHERE d_id IN (' + IDs + ');';
  frmMain.QRY.ExecSQL;
  frmMain.Tran.Commit;

  Vacuum;
  UpdateTransactions;
  VST.SetFocus;
end;

procedure TfrmMain.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var
  INI: TINIFile;
  INIFile: string;
  I: integer;
begin
  if pnlReport.Visible = True then
  begin
    btnReportExitClick(btnReportExit);
    CloseAction := Forms.caNone;
    Exit;
  end;

  try
    if conn.Connected = True then
      mnuCloseClick(mnuClose);

    if (conn.Connected = True) and (frmMain.Tag = 1) then
      Conn.Destroy
    else if (conn.Connected = True) and (frmMain.Tag = 0) then
    begin
      CloseAction := caNone;
      Exit;
    end;

    try
      frmMain.Visible := False;
      INIFile := ChangeFileExt(ParamStr(0), '.ini');
      INI := TINIFile.Create(INIFile);

      // save summary pie chart visibility
      INI.WriteBool('VISUAL_SETTINGS', 'SummaryPieChartVisible',
        frmMain.chkShowPieChart.Checked);

      if frmSettings.chkLastFormsSize.Checked = True then
      begin
        // frmMain
        if INI.ReadString('POSITION', frmMain.Name, '') <> IntToStr(frmMain.Left) +
        separ + // form left
        IntToStr(frmMain.Top) + separ + // form top
        IntToStr(frmMain.Width) + separ + // form width
        IntToStr(frmMain.Height) + separ + // form height
        IntToStr(pnlFilter.Width) + separ + // filter width
        IntToStr(pnlSummary.Height) then
          INI.WriteString('POSITION', frmMain.Name,
            IntToStr(frmMain.Left) + separ + // form left
            IntToStr(frmMain.Top) + separ + // form top
            IntToStr(frmMain.Width) + separ + // form width
            IntToStr(frmMain.Height) + separ + // form height
            IntToStr(pnlFilter.Width) + separ + // filter width
            IntToStr(pnlSummary.Height)); // summary height
      end
      else
        INI.EraseSection('POSITION');

      // font size
      I := INI.ReadInteger('VISUAL_SETTINGS', 'FontSize', 10);
      if frmMain.VST.Font.Size <> I then
        INI.WriteInteger('VISUAL_SETTINGS', 'FontSize',
          frmSettings.spiGridFontSize.Value);

      if frmSettings.chkAutoColumnWidth.Checked = True then
      begin
        // table Transactions
        for I := 1 to frmMain.VST.Header.Columns.Count - 1 do
          INI.DeleteKey('frmMain', 'TransColumn_' + RightStr('0' + IntToStr(I), 2));

        // table Summary
        for I := 1 to frmMain.VSTSummary.Header.Columns.Count - 1 do
          INI.DeleteKey('frmMain', 'SumColumn_' + RightStr('0' + IntToStr(I), 2));

        // table Balance
        for I := 1 to frmMain.VSTBalance.Header.Columns.Count - 1 do
          INI.DeleteKey('frmMain', 'BalanceCol_' + RightStr('0' + IntToStr(I), 2));

        // table Chrono
        for I := 1 to frmMain.VSTChrono.Header.Columns.Count - 1 do
          INI.DeleteKey('frmMain', 'ChronoCol_' + RightStr('0' + IntToStr(I), 2));

        // table Write
        for I := 1 to frmWrite.VST.Header.Columns.Count - 1 do
          INI.DeleteKey('frmWrite', 'Col_' + RightStr('0' + IntToStr(I), 2));

        // table Schedulers 1
        for I := 1 to frmSchedulers.VST.Header.Columns.Count - 1 do
          INI.DeleteKey('frmSchedulers', 'Col1_' + RightStr('0' + IntToStr(I), 2));

        // table Schedulers 2
        for I := 1 to frmSchedulers.VST1.Header.Columns.Count - 1 do
          INI.DeleteKey('frmSchedulers', 'Col2_' + RightStr('0' + IntToStr(I), 2));

        // table Accounts
        for I := 1 to frmAccounts.VST.Header.Columns.Count - 1 do
          INI.DeleteKey('frmAccounts', 'Col_' + RightStr('0' + IntToStr(I), 2));

        // table frmCategories
        for I := 1 to frmCategories.VST.Header.Columns.Count - 1 do
          INI.DeleteKey('frmCategories', 'Col_' + RightStr('0' + IntToStr(I), 2));

        // table frmPersons
        for I := 1 to frmPersons.VST.Header.Columns.Count - 1 do
          INI.DeleteKey('frmPersons', 'Col_' + RightStr('0' + IntToStr(I), 2));

        // table frmPayees
        for I := 1 to frmPayees.VST.Header.Columns.Count - 1 do
          INI.DeleteKey('frmPayees', 'Col_' + RightStr('0' + IntToStr(I), 2));

        // table frmCurrencies
        for I := 1 to frmCurrencies.VST.Header.Columns.Count - 1 do
          INI.DeleteKey('frmCurrencies', 'Col_' + RightStr('0' + IntToStr(I), 2));

        // table frmComments
        for I := 1 to frmComments.VST.Header.Columns.Count - 1 do
          INI.DeleteKey('frmComments', 'Col_' + RightStr('0' + IntToStr(I), 2));

        // table frmTags
        for I := 1 to frmTags.VST.Header.Columns.Count - 1 do
          INI.DeleteKey('frmTags', 'Col_' + RightStr('0' + IntToStr(I), 2));

        // table frmValues
        for I := 1 to frmValues.VST.Header.Columns.Count - 1 do
          INI.DeleteKey('frmValues', 'Col_' + RightStr('0' + IntToStr(I), 2));

        // table frmHistory
        for I := 1 to frmHistory.VST1.Header.Columns.Count - 1 do
          INI.DeleteKey('frmHistory', 'Col1_' + RightStr('0' + IntToStr(I), 2));

        // table frmHistory
        for I := 1 to frmHistory.VST2.Header.Columns.Count - 1 do
          INI.DeleteKey('frmHistory', 'Col2_' + RightStr('0' + IntToStr(I), 2));

        // table frmDelete
        for I := 1 to frmDelete.VST1.Header.Columns.Count - 1 do
          INI.DeleteKey('frmDelete', 'Col1_' + RightStr('0' + IntToStr(I), 2));

        // table frmDelete
        for I := 1 to frmDelete.VST2.Header.Columns.Count - 1 do
          INI.DeleteKey('frmDelete', 'Col2_' + RightStr('0' + IntToStr(I), 2));

        // table frmDelete
        for I := 1 to frmDelete.VST3.Header.Columns.Count - 1 do
          INI.DeleteKey('frmDelete', 'Col3_' + RightStr('0' + IntToStr(I), 2));

        // table frmRecycleBin
        for I := 1 to frmRecycleBin.VST.Header.Columns.Count - 1 do
          INI.DeleteKey('frmRecycleBin', 'Col_' + RightStr('0' + IntToStr(I), 2));

        // table frmDetail
        for I := 1 to frmDetail.VST.Header.Columns.Count - 1 do
          INI.DeleteKey('frmDetail', 'Col_' + RightStr('0' + IntToStr(I), 2));

        // table frmHolidays
        for I := 1 to frmHolidays.VST.Header.Columns.Count - 1 do
          INI.DeleteKey('frmHolidays', 'Col_' + RightStr('0' + IntToStr(I), 2));

        // table frmBudgets
        for I := 1 to frmBudgets.VSTPeriods.Header.Columns.Count - 1 do
          INI.DeleteKey('frmBudgets', 'Col_' + RightStr('0' + IntToStr(I), 2));

        // table frmBudgets
        for I := 1 to frmBudgets.VSTBudgets.Header.Columns.Count - 1 do
          INI.DeleteKey('frmBudgets', 'ColB_' + RightStr('0' + IntToStr(I), 2));

        // table frmBudget
        for I := 1 to frmBudget.VST.Header.Columns.Count - 1 do
          INI.DeleteKey('frmBudget', 'Col_' + RightStr('0' + IntToStr(I), 2));

        // table frmPeriod
        for I := 1 to frmPeriod.VST.Header.Columns.Count - 1 do
          INI.DeleteKey('frmPeriod', 'Col_' + RightStr('0' + IntToStr(I), 2));

        // table frmSettings
        for I := 1 to frmSettings.VSTKeys.Header.Columns.Count - 1 do
          INI.DeleteKey('frmSettings', 'Col_' + RightStr('0' + IntToStr(I), 2));

        // table frmLinks
        for I := 1 to frmLinks.VST.Header.Columns.Count - 1 do
          INI.DeleteKey('frmLinks', 'Col_' + RightStr('0' + IntToStr(I), 2));

        // table frmCalendar
        for I := 1 to frmCalendar.VST.Header.Columns.Count - 1 do
          INI.DeleteKey('frmCalendar', 'Col_' + RightStr('0' + IntToStr(I), 2));
      end
      else
      begin
        // table Transactions
        for I := 1 to frmMain.VST.Header.Columns.Count - 1 do
          INI.WriteInteger('frmMain', 'TransColumn_' + RightStr('0' + IntToStr(I), 2),
            frmMain.VST.Header.Columns[I].Width);

        // table Summary
        for I := 1 to frmMain.VSTSummary.Header.Columns.Count - 1 do
          INI.WriteInteger('frmMain', 'SumColumn_' + RightStr('0' + IntToStr(I), 2),
            frmMain.VSTSummary.Header.Columns[I].Width);

        // table Report - Balance
        for I := 1 to frmMain.VSTBalance.Header.Columns.Count - 1 do
          INI.WriteInteger('frmMain', 'BalanceCol_' + RightStr('0' + IntToStr(I), 2),
            frmMain.VSTBalance.Header.Columns[I].Width);

        // table Report - Chronologie
        for I := 1 to frmMain.VSTChrono.Header.Columns.Count - 1 do
          INI.WriteInteger('frmMain', 'ChronoCol_' + RightStr('0' + IntToStr(I), 2),
            frmMain.VSTChrono.Header.Columns[I].Width);

        // table Report - Cross tables
        for I := 1 to frmMain.VSTCross.Header.Columns.Count - 1 do
          INI.WriteInteger('frmMain', 'CrossTableCol_' + RightStr('0' + IntToStr(I), 2),
            frmMain.VSTCross.Header.Columns[I].Width);

        // table Write
        for I := 1 to frmWrite.VST.Header.Columns.Count - 1 do
          INI.WriteInteger('frmWrite', 'Col_' + RightStr('0' + IntToStr(I), 2),
            frmWrite.VST.Header.Columns[I].Width);

        // table Schedulers 1
        for I := 1 to frmSchedulers.VST.Header.Columns.Count - 1 do
          INI.WriteInteger('frmSchedulers', 'Col1_' + RightStr('0' + IntToStr(I), 2),
            frmSchedulers.VST.Header.Columns[I].Width);

        // table Schedulers 2
        for I := 1 to frmSchedulers.VST1.Header.Columns.Count - 1 do
          INI.WriteInteger('frmSchedulers', 'Col2_' + RightStr('0' + IntToStr(I), 2),
            frmSchedulers.VST1.Header.Columns[I].Width);

        // table Accounts
        for I := 1 to frmAccounts.VST.Header.Columns.Count - 1 do
          INI.WriteInteger('frmAccounts', 'Col_' + RightStr('0' + IntToStr(I), 2),
            frmAccounts.VST.Header.Columns[I].Width);

        // table frmCategories
        for I := 1 to frmCategories.VST.Header.Columns.Count - 1 do
          INI.WriteInteger('frmCategories', 'Col_' + RightStr('0' + IntToStr(I), 2),
            frmCategories.VST.Header.Columns[I].Width);

        // table frmPersons
        for I := 1 to frmPersons.VST.Header.Columns.Count - 1 do
          INI.WriteInteger('frmPersons', 'Col_' + RightStr('0' + IntToStr(I), 2),
            frmPersons.VST.Header.Columns[I].Width);

        // table frmPayees
        for I := 1 to frmPayees.VST.Header.Columns.Count - 1 do
          INI.WriteInteger('frmPayees', 'Col_' + RightStr('0' + IntToStr(I), 2),
            frmPayees.VST.Header.Columns[I].Width);

        // table frmCurrencies
        for I := 1 to frmCurrencies.VST.Header.Columns.Count - 1 do
          INI.WriteInteger('frmCurrencies', 'Col_' + RightStr('0' + IntToStr(I), 2),
            frmCurrencies.VST.Header.Columns[I].Width);

        // table frmComments
        for I := 1 to frmComments.VST.Header.Columns.Count - 1 do
          INI.WriteInteger('frmComments', 'Col_' + RightStr('0' + IntToStr(I), 2),
            frmComments.VST.Header.Columns[I].Width);

        // table frmTags
        for I := 1 to frmTags.VST.Header.Columns.Count - 1 do
          INI.WriteInteger('frmTags', 'Col_' + RightStr('0' + IntToStr(I), 2),
            frmTags.VST.Header.Columns[I].Width);

        // table frmValues
        for I := 1 to frmValues.VST.Header.Columns.Count - 1 do
          INI.WriteInteger('frmValues', 'Col_' + RightStr('0' + IntToStr(I), 2),
            frmValues.VST.Header.Columns[I].Width);

        // table frmHistory
        for I := 1 to frmHistory.VST1.Header.Columns.Count - 1 do
          INI.WriteInteger('frmHistory', 'Col1_' + RightStr('0' + IntToStr(I), 2),
            frmHistory.VST1.Header.Columns[I].Width);

        // table frmHistory
        for I := 1 to frmHistory.VST2.Header.Columns.Count - 1 do
          INI.WriteInteger('frmHistory', 'Col2_' + RightStr('0' + IntToStr(I), 2),
            frmHistory.VST2.Header.Columns[I].Width);

        // table frmDelete
        for I := 1 to frmDelete.VST1.Header.Columns.Count - 1 do
          INI.WriteInteger('frmDelete', 'Col1_' + RightStr('0' + IntToStr(I), 2),
            frmDelete.VST1.Header.Columns[I].Width);

        // table frmDelete
        for I := 1 to frmDelete.VST2.Header.Columns.Count - 1 do
          INI.WriteInteger('frmDelete', 'Col2_' + RightStr('0' + IntToStr(I), 2),
            frmDelete.VST2.Header.Columns[I].Width);

        // table frmDelete
        for I := 1 to frmDelete.VST3.Header.Columns.Count - 1 do
          INI.WriteInteger('frmDelete', 'Col3_' + RightStr('0' + IntToStr(I), 2),
            frmDelete.VST3.Header.Columns[I].Width);

        // table frmRecycleBin
        for I := 1 to frmRecycleBin.VST.Header.Columns.Count - 1 do
          INI.WriteInteger('frmRecycleBin', 'Col_' + RightStr('0' + IntToStr(I), 2),
            frmRecycleBin.VST.Header.Columns[I].Width);

        // table frmDetail
        for I := 1 to frmDetail.VST.Header.Columns.Count - 1 do
          INI.WriteInteger('frmDetail', 'Col_' + RightStr('0' + IntToStr(I), 2),
            frmDetail.VST.Header.Columns[I].Width);

        // table frmHolidays
        for I := 1 to frmHolidays.VST.Header.Columns.Count - 1 do
          INI.WriteInteger('frmHolidays', 'Col_' + RightStr('0' + IntToStr(I), 2),
            frmHolidays.VST.Header.Columns[I].Width);

        // table frmBudgets
        for I := 1 to frmBudgets.VSTPeriods.Header.Columns.Count - 1 do
          INI.WriteInteger('frmBudgets', 'Col_' + RightStr('0' + IntToStr(I), 2),
            frmBudgets.VSTPeriods.Header.Columns[I].Width);

        // table frmBudgets
        for I := 1 to frmBudgets.VSTBudgets.Header.Columns.Count - 1 do
          INI.WriteInteger('frmBudgets', 'ColB_' + RightStr('0' + IntToStr(I), 2),
            frmBudgets.VSTBudgets.Header.Columns[I].Width);

        // table frmBudget
        for I := 1 to frmBudget.VST.Header.Columns.Count - 1 do
          INI.WriteInteger('frmBudget', 'Col_' + RightStr('0' + IntToStr(I), 2),
            frmBudget.VST.Header.Columns[I].Width);

        // table frmPeriod
        for I := 1 to frmPeriod.VST.Header.Columns.Count - 1 do
          INI.WriteInteger('frmPeriod', 'Col_' + RightStr('0' + IntToStr(I), 2),
            frmPeriod.VST.Header.Columns[I].Width);

        // table frmSettings
        for I := 1 to frmSettings.VSTKeys.Header.Columns.Count - 1 do
          INI.WriteInteger('frmSettings', 'Col_' + RightStr('0' + IntToStr(I), 2),
            frmSettings.VSTKeys.Header.Columns[I].Width);

        // table frmLinks
        for I := 1 to frmLinks.VST.Header.Columns.Count - 1 do
          INI.WriteInteger('frmLinks', 'Col_' + RightStr('0' + IntToStr(I), 2),
            frmLinks.VST.Header.Columns[I].Width);

        // table frmCalendar
        for I := 1 to frmCalendar.VST.Header.Columns.Count - 1 do
          INI.WriteInteger('frmCalendar', 'Col_' + RightStr('0' + IntToStr(I), 2),
            frmCalendar.VST.Header.Columns[I].Width);
      end;

      INI.UpdateFile;
    finally
      INI.Free;
    end;
  except
  end;

  try
    cb.Free; // close clipboard
    Application.Terminate;
  finally
  end;
end;

procedure TfrmMain.cbxPersonChange(Sender: TObject);
begin
  if Conn.Connected = False then
    Exit;

  try
    case cbxPerson.ItemIndex of
      -1:
      begin
        pnlPersonCaption.Font.Color := clYellow;
        pnlPersonCaption.Font.Style := [fsBold];
      end;
      0:
      begin
        f_person := 'AND per_status = 0 ';
        pnlPerson.Hint := '';
        pnlPerson.Color := clDefault;
        pnlPersonCaption.Font.Style := [];
        pnlPersonCaption.Font.Color := clWhite;
        cbxPerson.Hint := '';
      end
      else
      begin
        f_person := 'AND per_name = "' + AnsiReplaceStr(
          cbxPerson.Items[cbxPerson.ItemIndex], '"', '""') + '" ';
        pnlPerson.Hint := separ_1 + cbxPerson.Items[cbxPerson.ItemIndex];
        pnlPersonCaption.Font.Color := clYellow;
        pnlPersonCaption.Font.Style := [fsBold];
        cbxPerson.Hint := cbxPerson.Items[cbxPerson.ItemIndex];
      end;
    end;
  finally
    UpdateTransactions;
  end;
end;

procedure TfrmMain.cbxTagChange(Sender: TObject);
begin
  if Conn.Connected = False then
    Exit;

  try
    case cbxTag.ItemIndex of
      -1:
      begin
        pnlTagCaption.Font.Color := clYellow;
        pnlTagCaption.Font.Style := [fsBold];
      end;
      0:
      begin
        f_tag := '';
        pnlTag.Hint := '';
        pnlTag.Color := clDefault;
        pnlTagCaption.Font.Style := [];
        pnlTagCaption.Font.Color := clWhite;
        cbxTag.Hint := '';
      end
      else
      begin
        f_tag := 'AND d_id IN (SELECT dt_data FROM data_tags WHERE dt_tag IN ' +
          '(SELECT tag_id FROM tags WHERE tag_name = "' + AnsiReplaceStr(
          cbxTag.Items[cbxTag.ItemIndex], '"', '""') + '")) ';
        pnlTag.Hint := separ_1 + cbxTag.Items[cbxTag.ItemIndex];
        pnlTagCaption.Font.Color := clYellow;
        pnlTagCaption.Font.Style := [fsBold];
        cbxTag.Hint := cbxTag.Items[cbxTag.ItemIndex];
      end;
    end;
  finally
    UpdateTransactions;
  end;
end;

procedure TfrmMain.cbxTypeChange(Sender: TObject);
begin
  if Conn.Connected = False then
    Exit;

  try
    case cbxType.ItemIndex of
      -1:
      begin
        pnlTypeCaption.Font.Style := [fsBold];
        pnlTypeCaption.Font.Color := clYellow;
      end;
      0:
      begin
        f_type := 'd_type LIKE "%" ';
        pnlType.Hint := '';
        pnlTypeCaption.Font.Style := [];
        pnlTypeCaption.Font.Color := clWhite;
        cbxType.Hint := IntToStr(cbxType.ItemIndex);
      end
      else
      begin
        f_type := 'd_type = ' + IntToStr(cbxType.ItemIndex - 1) + ' ';
        pnlType.Hint := separ_1 + AnsiUpperCase(cbxType.Text);
        pnlTypeCaption.Font.Style := [fsBold];
        pnlTypeCaption.Font.Color := clYellow;
        cbxType.Hint := IntToStr(cbxType.ItemIndex);
      end;
    end;
  finally
    UpdateTransactions;
  end;
end;

procedure TfrmMain.datDateFromChange(Sender: TObject);
begin
  try
    //frmMain.Caption := InttoStr(pnlFilter.Width);
    if pnlFilter.Width > 200 then
    begin
      lblDateFrom.Caption := FS_own.LongDayNames[DayOfTheWeek(datDateFrom.Date + 1)];
      lblDateTo.Caption := FS_own.LongDayNames[DayOfTheWeek(datDateTo.Date + 1)];
    end
    else
    begin
      lblDateFrom.Caption := FS_own.ShortDayNames[DayOfTheWeek(datDateFrom.Date + 1)];
      lblDateTo.Caption := FS_own.ShortDayNames[DayOfTheWeek(datDateTo.Date + 1)];
    end;
  except
    lblDateFrom.Caption := '';
    lblDateTo.Caption := '';
  end;

  try
    if Conn.Connected = False then
      Exit;

    if pnlPeriodCaption.Tag = 0 then
    begin
      f_date := '';
      pnlDate.Hint := '';
    end
    else
    begin
      f_date := 'AND d_date BETWEEN "' + FormatDateTime('YYYY-MM-DD', datDateFrom.Date) +
        '" AND "' + FormatDateTime('YYYY-MM-DD', datDateTo.Date) + '" ';
      pnlDate.Hint := separ_1 + FormatDateTime(FS_own.ShortDateFormat,
        datDateFrom.Date) + ' .. ' + FormatDateTime(FS_own.ShortDateFormat,
        datDateTo.Date);
    end;

    UpdateTransactions;

  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmMain.datDateFromKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 0;
    if frmMain.Visible = True then
      datDateTo.SetFocus;
  end;
end;

procedure TfrmMain.ediCommentChange(Sender: TObject);
begin
  if Conn.Connected = False then
    Exit;

  try
    if Length(ediComment.Text) = 0 then
    begin
      f_comment := '';
      pnlComment.Hint := '';
      // pnlComment.Color := clDefault;
      pnlCommentCaption.Font.Style := [];
      pnlCommentCaption.Font.Color := clWhite;
    end
    else
    begin
      case cbxComment.ItemIndex of
        0:
        begin // whenever in the text
          f_comment := 'AND d_comment_lower LIKE "%' + AnsiLowerCase(
            AnsiReplaceStr(ediComment.Text, '"', '""')) + '%" ';
          pnlComment.Hint := ' | *' + ediComment.Text + '* ';
        end;
        1:
        begin  // starting with text
          f_comment := 'AND d_comment_lower LIKE "' + AnsiLowerCase(
            AnsiReplaceStr(ediComment.Text, '"', '""')) + '%" ';
          pnlComment.Hint := separ_1 + ediComment.Text + '* ';
        end
        else
        begin // ending with text
          f_comment := 'AND d_comment_lower LIKE "%' + AnsiLowerCase(
            AnsiReplaceStr(ediComment.Text, '"', '""')) + '" ';
          pnlComment.Hint := ' | *' + ediComment.Text + ' ';
        end;
      end;
      pnlCommentCaption.Font.Color := clYellow;
      pnlCommentCaption.Font.Style := [fsBold];
    end;
  finally
    UpdateTransactions;
  end;
end;

procedure TfrmMain.spiMinChange(Sender: TObject);
var
  A: double;
  S: string;
begin

  if (Conn.Connected = False) or (spiMin.Text = '-') or (spiMax.Text = '-') then Exit;

  // no values
  if (cbxMin.ItemIndex = 0) and (cbxMax.ItemIndex = 0) then
  begin
    spiMin.Value := 0;
    spiMax.Value := 0;
    spiMin.Enabled := False;
    spiMax.Enabled := False;
    f_amount := '';
    pnlAmount.Hint := '';
    pnlAmount.Color := clDefault;
    pnlAmountCaption.Font.Style := [];
    pnlAmountCaption.Font.Color := clWhite;
  end
  else
  begin
    spiMin.Enabled := cbxMin.ItemIndex > 0;
    spiMax.Enabled := cbxMax.ItemIndex > 0;

    pnlAmountCaption.Font.Color := clYellow;
    pnlAmountCaption.Font.Style := [fsBold];

    // Amount from
    if (spiMin.Enabled = True) and (Length(spiMin.Text) > 0) then
    try
      S := AnsiReplaceStr(spiMin.Text, FS_own.ThousandSeparator, '');
      S := AnsiReplaceStr(S, '.', FS_own.DecimalSeparator);
      S := AnsiReplaceStr(S, ',', FS_own.DecimalSeparator);
      TryStrToFloat(S, A);
      f_amount := 'AND d_sum ' + cbxMin.Items[cbxMin.ItemIndex] +
        AnsiReplaceStr(FloatToStr(A), FS_own.DecimalSeparator, '.') + ' ';
      pnlAmount.Hint := separ_1 + cbxMin.Items[cbxMin.ItemIndex] + ' ' + spiMin.Text;
    except
      Exit;
    end;

    if (spiMax.Enabled = True) and (Length(spiMax.Text) > 0) then
    try
      S := AnsiReplaceStr(spiMax.Text, FS_own.ThousandSeparator, '');
      S := AnsiReplaceStr(S, '.', FS_own.DecimalSeparator);
      S := AnsiReplaceStr(S, ',', FS_own.DecimalSeparator);
      TryStrToFloat(S, A);

      f_amount := IfThen(spiMin.Enabled = True, f_amount, '') +
        'AND d_sum ' + cbxMax.Items[cbxMax.ItemIndex] +
        AnsiReplaceStr(FloatToStr(A), FS_own.DecimalSeparator, '.') + ' ';
      pnlAmount.Hint := pnlAmount.Hint + separ_1 + cbxMax.Items[cbxMax.ItemIndex] +
        ' ' + spiMax.Text;
    except
      Exit;
    end;
  end;
  UpdateTransactions;
end;

procedure TfrmMain.btnCalcClick(Sender: TObject);
begin
  mnuCalcClick(mnuCalc);
end;

procedure TfrmMain.btnAddClick(Sender: TObject);
var
  Amount: double;
  N: PVirtualNode;
  Transactions: PTransactions;
  UsedLastImage: boolean;
  // if was used the last image of new transactions image (used items)
begin
  try
    if (Conn.Connected = False) or (pnlReport.Visible = True) then
      exit;

    if Sender.ClassName = 'TAction' then
      frmDetail.tabKind.TabIndex := (Sender as TAction).Tag
    else if Sender.ClassName = 'TMenuItem' then
      frmDetail.tabKind.TabIndex := (Sender as TMenuItem).Tag
    else
      frmDetail.tabKind.TabIndex := 0;

    frmDetail.tabKindChange(frmDetail.tabKind);
    frmDetail.btnSave.Enabled := frmDetail.tabKind.TabIndex = 0;

    if frmMain.VST.Tag = 0 then
      frmDetail.tabKind.Tabs[1].Options :=
        frmDetail.tabKind.Tabs[1].Options + [etoVisible]
    else
      frmDetail.tabKind.Tabs[1].Options :=
        frmDetail.tabKind.Tabs[1].Options - [etoVisible];

    // ===========================================================================
    // NEW TRANSACTION  (without duplication)
    // ===========================================================================
    if frmDetail.tabKind.TabIndex = 0 then
    begin
      if VST.Tag = 0 then
      begin
        // enabled buttons
        frmDetail.btnSave.Tag := 0;

        try
          if frmSettings.chkRememberNewTransactionsForm.Checked = True then
          begin
            frmMain.QRY.SQL.Text :=
              'SELECT set_value FROM settings WHERE set_parameter = "last_transaction_used"';
            frmMain.QRY.Open;
            UsedLastImage := frmMain.QRY.Fields[0].AsString <> '0';
            frmMain.QRY.Close;

            if UsedLastImage = False then
            begin
              // set type
              frmMain.QRY.SQL.Text :=
                'SELECT set_value FROM settings WHERE set_parameter = "last_transaction_type"';
              frmMain.QRY.Open;
              frmDetail.cbxType.ItemIndex := StrToInt(frmMain.QRY.Fields[0].AsString);
              frmDetail.cbxTypeChange(frmDetail.cbxType);
              frmMain.QRY.Close;

              // set date from
              frmMain.QRY.SQL.Text :=
                'SELECT set_value FROM settings WHERE set_parameter = "last_transaction_date_from"';
              frmMain.QRY.Open;
              if Length(frmMain.QRY.Fields[0].AsString) = 10 then
                frmDetail.datDateFrom.Date :=
                  StrToDate(frmMain.QRY.Fields[0].AsString, 'YYYY-MM-DD', '-')
              else
                frmDetail.datDateFrom.Date := Now();
              frmMain.QRY.Close;

              // set date to
              frmMain.QRY.SQL.Text :=
                'SELECT set_value FROM settings WHERE set_parameter = "last_transaction_date_to"';
              frmMain.QRY.Open;
              if Length(frmMain.QRY.Fields[0].AsString) = 10 then
                frmDetail.datDateTo.Date :=
                  StrToDate(frmMain.QRY.Fields[0].AsString, 'YYYY-MM-DD', '-')
              else
                frmDetail.datDateTo.Date := Now();
              frmMain.QRY.Close;

              // set account from
              frmMain.QRY.SQL.Text :=
                'SELECT set_value FROM settings WHERE set_parameter = "last_transaction_account_from"';
              frmMain.QRY.Open;
              frmDetail.cbxAccountFrom.ItemIndex :=
                StrToInt(frmMain.QRY.Fields[0].AsString);
              frmMain.QRY.Close;

              // set account to
              frmMain.QRY.SQL.Text :=
                'SELECT set_value FROM settings WHERE set_parameter = "last_transaction_account_to"';
              frmMain.QRY.Open;
              frmDetail.cbxAccountTo.ItemIndex :=
                StrToInt(frmMain.QRY.Fields[0].AsString);
              frmMain.QRY.Close;

              // set amount from
              frmMain.QRY.SQL.Text :=
                'SELECT set_value FROM settings WHERE set_parameter = "last_transaction_amount_from"';
              frmMain.QRY.Open;
              frmDetail.spiAmountFrom.Text :=
                ReplaceStr(frmMain.QRY.Fields[0].AsString, '.', FS_own.DecimalSeparator);
              frmMain.QRY.Close;

              // set amount to
              frmMain.QRY.SQL.Text :=
                'SELECT set_value FROM settings WHERE set_parameter = "last_transaction_amount_to"';
              frmMain.QRY.Open;
              frmDetail.spiAmountTo.Text :=
                ReplaceStr(frmMain.QRY.Fields[0].AsString, '.', FS_own.DecimalSeparator);
              frmMain.QRY.Close;

              // set comment
              frmMain.QRY.SQL.Text :=
                'SELECT set_value FROM settings WHERE set_parameter = "last_transaction_comment"';
              frmMain.QRY.Open;
              frmDetail.cbxComment.Text := frmMain.QRY.Fields[0].AsString;
              frmMain.QRY.Close;

              // set category
              frmMain.QRY.SQL.Text :=
                'SELECT set_value FROM settings WHERE set_parameter = "last_transaction_category"';
              frmMain.QRY.Open;
              frmDetail.cbxCategory.ItemIndex :=
                StrToInt(frmMain.QRY.Fields[0].AsString);
              frmDetail.cbxCategoryChange(frmDetail.cbxCategory);
              frmMain.QRY.Close;

              // set subcategory
              frmMain.QRY.SQL.Text :=
                'SELECT set_value FROM settings WHERE set_parameter = "last_transaction_subcategory"';
              frmMain.QRY.Open;
              frmDetail.cbxSubcategory.ItemIndex :=
                StrToInt(frmMain.QRY.Fields[0].AsString);
              frmMain.QRY.Close;

              // set person
              frmMain.QRY.SQL.Text :=
                'SELECT set_value FROM settings WHERE set_parameter = "last_transaction_person"';
              frmMain.QRY.Open;
              frmDetail.cbxPerson.ItemIndex := StrToInt(frmMain.QRY.Fields[0].AsString);
              frmMain.QRY.Close;

              // set payee
              frmMain.QRY.SQL.Text :=
                'SELECT set_value FROM settings WHERE set_parameter = "last_transaction_payee"';
              frmMain.QRY.Open;
              frmDetail.cbxPayee.ItemIndex := StrToInt(frmMain.QRY.Fields[0].AsString);
              frmMain.QRY.Close;

              // set last used transaction to true
              frmMain.QRY.SQL.Text :=
                'UPDATE settings SET set_value = 1 WHERE set_parameter = "last_transaction_used";';
              frmMain.QRY.ExecSQL;
              frmMain.Tran.Commit;
            end;
          end;
        except
          frmMain.QRY.Close;
        end;

        try
          // panel Detail
          frmDetail.cbxType.Enabled := True;
          // type
          if (frmDetail.cbxType.ItemIndex = -1) then
          begin
            frmDetail.cbxType.ItemIndex := 1;
            frmDetail.cbxTypeChange(frmDetail.cbxType);
          end;
          // amount
          if frmDetail.spiAmountFrom.Text = '' then
            frmDetail.spiAmountFrom.Text := Format('%n', [0.0]);
          if frmDetail.spiAmountTo.Text = '' then
            frmDetail.spiAmountTo.Text := Format('%n', [0.0]);
          // comment
          //frmDetail.cbxComment.Text := '';
          // person
          if (frmDetail.cbxPerson.ItemIndex = -1) and
            (frmDetail.cbxPerson.Items.Count > 0) then
            frmDetail.cbxPerson.ItemIndex := 0;
          // account from
          if (frmDetail.cbxAccountFrom.ItemIndex = -1) and
            (frmDetail.cbxAccountFrom.Items.Count > 0) then
            frmDetail.cbxAccountFrom.ItemIndex :=
              IfThen(cbxAccount.ItemIndex > 0, cbxAccount.ItemIndex - 1, 0);
          // account to
          if (frmDetail.cbxAccountFrom.ItemIndex = -1) and
            (frmDetail.cbxAccountFrom.Items.Count > 0) then
            frmDetail.cbxAccountTo.ItemIndex := 0;
          // payee
          if (frmDetail.cbxPayee.ItemIndex = -1) and
            (frmDetail.cbxPayee.Items.Count > 0) then
            frmDetail.cbxPayee.ItemIndex := 0;
          // category
          if (frmDetail.cbxCategory.ItemIndex = -1) and
            (frmDetail.cbxCategory.Items.Count > 0) then
            frmDetail.cbxCategory.ItemIndex := 0;
          frmDetail.cbxCategoryChange(frmDetail.cbxCategory);
          // tag
          frmDetail.lbxTag.CheckAll(cbUnchecked, False, False);
        except
        end;

        if frmDetail.ShowModal = mrOk then
          if (frmSettings.chkOpenNewTransaction.Checked = True) and
            (frmDetail.tabKind.TabIndex = 0) then
            frmMain.btnAddClick(frmMain.btnAdd);
      end

      // ===========================================================================
      // DUPLICATE TRANSACTION
      // ===========================================================================
      else
      if VST.Tag = 1 then
      begin
        N := VST.GetFirstSelected();
        Transactions := VST.GetNodeData(N);

        try
          // enabled buttons
          frmDetail.btnSave.Tag := 1 - btnDuplicate.Tag;
          btnDuplicate.Tag := 0;

          // disabled menu
          frmDetail.cbxType.Enabled := Transactions.Kind < 2;
          frmDetail.cbxType.Tag := Transactions.Kind;
        except
          on E: Exception do
            ShowErrorMessage(E);
        end;

        frmDetail.cbxType.ItemIndex :=
          IfThen(Transactions.Kind < 2, Transactions.Kind, 2);

        frmDetail.gbxTo.Visible := False;
        frmDetail.gbxAccountFrom.Caption :=
          IfThen(Transactions.Kind in [0, 2], Caption_78, Caption_77);

        frmDetail.cbxAccountFrom.ItemIndex :=
          frmDetail.cbxAccountFrom.Items.IndexOf(Transactions.Account +
          separ_1 + Transactions.currency);

        // get values from table DATA
        frmMain.QRY.SQL.Text :=
          'SELECT ' + // SELECT statement
          'd_date, ' + // date
          'Round(d_sum, 2) as d_sum, ' + // sum
          'cat_parent_name, cat_name, cat_parent_id, ' + // category ID
          'd_type ' + // type
          'FROM data ' + sLineBreak + // FROM table DATA
          'LEFT JOIN ' + sLineBreak +// JOIN
          'categories ON (cat_id = d_category) ' + sLineBreak +// categories
          'WHERE d_id = :ID;';
        frmMain.QRY.Params.ParamByName('ID').AsInteger := Transactions.ID;
        frmMain.QRY.Prepare;
        frmMain.QRY.Open;

        // date 2
        frmDetail.datDateFrom.Date :=
          StrToDate(frmMain.QRY.FieldByName('d_date').AsString, 'YYYY-MM-DD', '-');
        frmDetail.datDateTo.Date := frmDetail.datDateFrom.Date;

        // amount 3
        TryStrToFloat(frmMain.QRY.FieldByName('d_sum').AsString, Amount);
        if Transactions.Kind in [1, 3] then
          Amount := -Amount;

        frmDetail.spiAmountFrom.Text := FloatToStr(Amount);

        // comment 5
        frmDetail.cbxComment.Text := Transactions.Comment;

        // category
        try
          if not (frmMain.QRY.FieldByName('cat_parent_ID').IsNull) then
          begin
            FillCategory(frmDetail.cbxCategory,
              IfThen(Transactions.Kind < 2, Transactions.Kind, 2));
            if frmMain.QRY.FieldByName('cat_parent_ID').AsInteger = 0 then
            begin
              frmDetail.cbxCategory.ItemIndex :=
                frmDetail.cbxCategory.Items.IndexOf(
                frmMain.QRY.FieldByName('cat_name').AsString);
              frmDetail.cbxCategoryChange(frmDetail.cbxCategory);
              frmDetail.cbxSubcategory.ItemIndex := 0;
            end
            else
            begin
              frmDetail.cbxCategory.ItemIndex :=
                frmDetail.cbxCategory.Items.IndexOf(
                frmMain.QRY.FieldByName('cat_parent_name').AsString);
              frmDetail.cbxCategoryChange(frmDetail.cbxCategory);
              frmDetail.cbxSubcategory.ItemIndex :=
                frmDetail.cbxSubcategory.Items.IndexOf(
                frmMain.QRY.FieldByName('cat_name').AsString);
            end;
          end;
        except
        end;

        // person
        frmDetail.cbxPerson.ItemIndex :=
          frmDetail.cbxPerson.Items.IndexOf(Transactions.Person);

        // payee
        frmDetail.cbxPayee.ItemIndex :=
          frmDetail.cbxPayee.Items.IndexOf(Transactions.Payee);

        frmMain.QRY.Close;

        // update tags
        frmDetail.lbxTag.CheckAll(cbUnchecked, False, False);
        frmMain.QRY.SQL.Text :=
          'SELECT tag_name FROM tags WHERE tag_id IN (' +
          'SELECT dt_tag FROM data_tags WHERE dt_data = ' +
          IntToStr(Transactions.ID) + ');';
        frmMain.QRY.Open;
        while not (frmMain.QRY.EOF) do
        begin
          frmDetail.lbxTag.Checked[frmDetail.lbxTag.Items.IndexOf(
            frmMain.QRY.Fields[0].AsString)] := True;
          frmMain.QRY.Next;
        end;
        frmMain.QRY.Close;
        frmDetail.ShowModal;
      end;
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;

  // =============================================================================================
  // frmDETAIL SHOW
  // =============================================================================================
  VST.SetFocus;
end;

procedure TfrmMain.btnFilterClick(Sender: TObject);
begin
  popFilter.PopUp;
end;

procedure TfrmMain.btnCurrencyMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
var
  cbx: TCombobox;
  I, J: integer;
  Temp, Str1, Str2: string;
  slTemp: TStringList;
begin
  case (Sender as TSpeedButton).Tag of
    1: // types
    begin
      frmFilter.pnlFilterCaption.Caption := AnsiUpperCase(Trim(pnlTypeCaption.Caption));
      frmMain.img16.GetIcon(28, frmFilter.Icon);
      cbx := cbxType;
    end;
    2: // Currencies
    begin
      frmFilter.pnlFilterCaption.Caption :=
        AnsiUpperCase(Trim(pnlCurrencyCaption.Caption));
      frmMain.img16.GetIcon(12, frmFilter.Icon);
      cbx := cbxCurrency;
    end;
    3: // Accounts
    begin
      frmFilter.pnlFilterCaption.Caption :=
        AnsiUpperCase(Trim(pnlAccountCaption.Caption));
      frmMain.img16.GetIcon(15, frmFilter.Icon);
      cbx := cbxAccount;
    end;
    4: // category
    begin
      frmFilter.pnlFilterCaption.Caption :=
        AnsiUpperCase(Trim(pnlCategoryCaption.Caption));
      frmMain.img16.GetIcon(16, frmFilter.Icon);
      cbx := cbxCategory;
    end;
    5: // subcategory
    begin
      frmFilter.pnlFilterCaption.Caption := AnsiUpperCase(Menu_29);
      frmMain.img16.GetIcon(16, frmFilter.Icon);
      cbx := cbxSubcategory;
    end;
    6: // person
    begin
      frmFilter.pnlFilterCaption.Caption :=
        AnsiUpperCase(Trim(pnlPersonCaption.Caption));
      frmMain.img16.GetIcon(17, frmFilter.Icon);
      cbx := cbxPerson;
    end;
    7: // payee
    begin
      frmFilter.pnlFilterCaption.Caption := AnsiUpperCase(Trim(pnlPayeeCaption.Caption));
      frmMain.img16.GetIcon(13, frmFilter.Icon);
      cbx := cbxPayee;
    end;
    8: // Tags
    begin
      frmFilter.pnlFilterCaption.Caption := AnsiUpperCase(Trim(pnlTagCaption.Caption));
      frmMain.img16.GetIcon(11, frmFilter.Icon);
      cbx := cbxTag;
    end
    else
  end;

  if (cbx.Items.Count < 2) or ((cbx.Items.Count = 2) and (cbx.Items[0] = '*')) then
    Exit;

  frmFilter.chkFilter.Clear;

  frmFilter.chkFilter.Items := cbx.Items;
  if frmFilter.chkFilter.Items[0] = '*' then
    frmFilter.chkFilter.Items.Delete(0);

  frmFilter.Constraints.MinHeight := 0;
  frmFilter.Height := 120 + (frmFilter.chkFilter.Items.Count * ButtonHeight);
  if frmFilter.Height > screen.Height - 100 then
    frmFilter.Height := Screen.Height - 100;
  frmFilter.Left := Mouse.CursorPos.x;
  frmFilter.Top := Mouse.CursorPos.y;
  if frmFilter.Top + frmFilter.Height > Screen.Height - 50 then
    frmFilter.Top := 0;
  frmFilter.Constraints.MinHeight := frmFilter.Height;
  frmFilter.chkFilterClickCheck(frmFilter.chkFilter);

  // -------------------------------------------------------
  // check checked fields (TYPE)
  if (cbx = cbxType) then
    if (cbx as TComboBox).Hint <> '' then
    begin
      I := UTF8Pos(',', (cbx as TComboBox).Hint);
      J := 1;
      while I > 0 do
      begin
        frmFilter.chkFilter.Checked[StrToInt(Field(',', (cbx as TComboBox).Hint, J))] :=
          True;
        Inc(J);
        I := UTF8Pos(',', (cbx as TComboBox).Hint, I + 1);
      end;
      frmFilter.chkFilter.Checked[StrToInt(Field(',', (cbx as TComboBox).Hint, J))] :=
        True;
    end;

  // -------------------------------------------------------
  // check checked fields (CURRENCY)
  if (cbx = cbxCurrency) then
    if (cbx as TComboBox).Hint <> '' then
    begin
      slTemp := TStringList.Create;
      slTemp.Text := ReplaceStr((cbx as TComboBox).Hint, separ, sLineBreak);
      for I := 0 to slTemp.Count - 1 do
      begin
        Temp := slTemp.Strings[I];

        for J := 0 to frmFilter.chkFilter.Items.Count - 1 do
          if AnsiLowerCase(Field(separ_1, frmFilter.chkFilter.Items[J], 1)) =
            AnsiLowerCase(Temp) then
            frmFilter.chkFilter.Checked[J] := True;
      end;
      slTemp.Free;
    end;

  // -------------------------------------------------------
  // check checked fields (ACCOUNT)
  if (cbx = cbxAccount) then
  begin
    if (cbx as TComboBox).Hint <> '' then
    begin
      slTemp := TStringList.Create;
      slTemp.Text := ReplaceStr((cbx as TComboBox).Hint, separ + separ, sLineBreak);
      for I := 0 to slTemp.Count - 1 do
      begin
        Temp := Field(separ, slTemp.Strings[I], 1) + separ_1 +
          Field(separ, slTemp.Strings[I], 2);
        for J := 0 to frmFilter.chkFilter.Items.Count - 1 do
          if AnsiLowerCase(frmFilter.chkFilter.Items[J]) = AnsiLowerCase(Temp) then
          begin
            frmFilter.chkFilter.Checked[J] := True;
            Break;
          end;
      end;
      slTemp.Free;
    end;
  end;

  // -------------------------------------------------------
  // check checked fields (CATEGORY)
  if (cbx = cbxCategory) then
  begin
    if (cbx as TComboBox).Hint <> '' then
    begin
      slTemp := TStringList.Create;
      slTemp.Text := ReplaceStr((cbx as TComboBox).Hint, separ + separ, sLineBreak);

      for I := 0 to slTemp.Count - 1 do
      begin
        if UTF8Pos(separ, slTemp.Strings[I]) = 0 then
          Temp := slTemp.Strings[I]
        else
          Temp := Field(separ, slTemp.Strings[I], 1) + separ_1 +
            Field(separ, slTemp.Strings[I], 2);

        for J := 0 to frmFilter.chkFilter.Items.Count - 1 do
        begin
          if AnsiLowerCase(frmFilter.chkFilter.Items[J]) = AnsiLowerCase(Temp) then
          begin
            frmFilter.chkFilter.Checked[J] := True;
            Break;
          end;
        end;
      end;
      slTemp.Free;
    end;
  end;

  // -------------------------------------------------------
  // check checked fields (SUBCATEGORY)
  if (cbx = cbxSubcategory) then
  begin
    if (cbx as TComboBox).Hint <> '' then
    begin
      slTemp := TStringList.Create;
      slTemp.Text := ReplaceStr((cbx as TComboBox).Hint, separ + separ, sLineBreak);

      for I := 0 to slTemp.Count - 1 do
      begin
        if UTF8Pos(separ, slTemp.Strings[I]) = 0 then
          Temp := slTemp.Strings[I]
        else
          Temp := Field(separ, slTemp.Strings[I], 1) + separ_1 +
            Field(separ, slTemp.Strings[I], 2);

        for J := 0 to frmFilter.chkFilter.Items.Count - 1 do
        begin
          if AnsiLowerCase(frmFilter.chkFilter.Items[J]) = AnsiLowerCase(Temp) then
          begin
            frmFilter.chkFilter.Checked[J] := True;
            Break;
          end;
        end;
      end;
      slTemp.Free;
    end;
  end;

  // -------------------------------------------------------
  // check checked fields (PERSON)
  if (cbx = cbxPerson) then
    if (cbx as TComboBox).Hint <> '' then
    begin
      slTemp := TStringList.Create;
      slTemp.Text := ReplaceStr((cbx as TComboBox).Hint, separ, sLineBreak);
      for I := 0 to slTemp.Count - 1 do
      begin
        Temp := slTemp.Strings[I];
        for J := 0 to frmFilter.chkFilter.Items.Count - 1 do
          if AnsiLowerCase(frmFilter.chkFilter.Items[J]) = AnsiLowerCase(Temp) then
          begin
            frmFilter.chkFilter.Checked[J] := True;
            Break;
          end;
      end;
      slTemp.Free;
    end;

  // -------------------------------------------------------
  // check checked fields (Payee)
  if (cbx = cbxPayee) then
    if (cbx as TComboBox).Hint <> '' then
    begin
      slTemp := TStringList.Create;
      slTemp.Text := ReplaceStr((cbx as TComboBox).Hint, separ, sLineBreak);
      for I := 0 to slTemp.Count - 1 do
      begin
        Temp := slTemp.Strings[I];
        for J := 0 to frmFilter.chkFilter.Items.Count - 1 do
          if AnsiLowerCase(frmFilter.chkFilter.Items[J]) = AnsiLowerCase(Temp) then
          begin
            frmFilter.chkFilter.Checked[J] := True;
            Break;
          end;
      end;
      slTemp.Free;
    end;

  // -------------------------------------------------------
  // check checked fields (Tag)
  if (cbx = cbxTag) then
    if (cbx as TComboBox).Hint <> '' then
    begin
      slTemp := TStringList.Create;
      slTemp.Text := ReplaceStr((cbx as TComboBox).Hint, chr(9), sLineBreak);
      for I := 0 to slTemp.Count - 1 do
      begin
        Temp := slTemp.Strings[I];
        for J := 0 to frmFilter.chkFilter.Items.Count - 1 do
          if AnsiLowerCase(frmFilter.chkFilter.Items[J]) = AnsiLowerCase(Temp) then
          begin
            frmFilter.chkFilter.Checked[J] := True;
            Break;
          end;
      end;
      slTemp.Free;
    end;

  frmFilter.chkFilterClickCheck(frmFilter.chkFilter);

  // =======================================================================================================
  if (frmFilter.chkFilter.Items.Count = 0) or (frmFilter.ShowModal <> mrOk) then
    Exit;
  // =======================================================================================================

  // READ ALL CHECKED ITEMS ===========================================
  // Start TYPE =======================================================
  if cbx = cbxType then
  begin
    if frmFilter.chkFilter.Tag = 1 then
    begin
      cbxType.ItemIndex := frmFilter.chkFilter.ItemIndex + 1;
    end
    else if frmFilter.chkFilter.Tag = frmFilter.chkFilter.Items.Count then
    begin
      cbxType.ItemIndex := 0;
    end
    else
    begin
      pnlType.Hint := '';
      pnlTypeCaption.Font.Color := clYellow;
      pnlTypeCaption.Font.Style := [fsBold];
      (cbx as TComboBox).Hint := '';

      for I := 0 to frmFilter.chkFilter.Items.Count - 1 do
        if frmFilter.chkFilter.Checked[I] = True then
        begin
          pnlType.Hint := pnlType.Hint + separ_1 +
            AnsiUpperCase(frmFilter.chkFilter.Items[I]);
          (cbx as TComboBox).Hint := (cbx as TComboBox).Hint + IntToStr(I) + ',';
        end;
      (cbx as TComboBox).Hint :=
        LeftStr((cbx as TComboBox).Hint, Length((cbx as TComboBox).Hint) - 1);
      f_type := 'd_type IN (' + (cbx as TComboBox).Hint + ') ';

      cbxType.ItemIndex := -1;
    end;
    cbxTypeChange(cbxType);
  end
  // end TYPE =======================================================

  // Start CURRENCY =======================================================
  else if cbx = cbxCurrency then
  begin
    if frmFilter.chkFilter.Tag = 1 then
    begin
      for I := 0 to frmFilter.chkFilter.Count - 1 do
      begin
        if frmFilter.chkFilter.Checked[I] = True then
          cbxCurrency.ItemIndex := I + 1;
      end;
    end
    else if frmFilter.chkFilter.Tag = frmFilter.chkFilter.Items.Count then
      cbxCurrency.ItemIndex := 0
    else
    begin
      cbxCurrency.ItemIndex := -1;
      pnlCurrency.Hint := '';
      pnlCurrencyCaption.Font.Color := clYellow;
      pnlCurrencyCaption.Font.Style := [fsBold];
      (cbx as TComboBox).Hint := '';

      for I := 0 to frmFilter.chkFilter.Items.Count - 1 do
        if frmFilter.chkFilter.Checked[I] = True then
        begin
          Temp := Field(separ_1, frmFilter.chkFilter.Items[I], 1);
          pnlCurrency.Hint := pnlCurrency.Hint + separ_1 + Temp;
          (cbx as TComboBox).Hint := (cbx as TComboBox).Hint + Temp + separ;
        end;
      (cbx as TComboBox).Hint :=
        UTF8Copy((cbx as TComboBox).Hint, 1, UTF8Length((cbx as TComboBox).Hint) - 1);

      Temp := AnsiReplaceStr(cbxCurrency.Hint, '"', '""');
      f_currency := 'AND acc_currency IN ("' + AnsiReplaceStr(Temp,
        separ, '","') + '") ';
    end;
    cbxCurrencyChange(cbxCurrency);
  end
  // end CURRENCY =======================================================

  // Start ACCOUNT =======================================================
  else if cbx = cbxAccount then
  begin
    if frmFilter.chkFilter.Tag = 1 then
    begin
      for I := 0 to frmFilter.chkFilter.Count - 1 do
      begin
        if frmFilter.chkFilter.Checked[I] = True then
          cbxAccount.ItemIndex := I + 1;
      end;
    end
    else if frmFilter.chkFilter.Tag = frmFilter.chkFilter.Items.Count then
    begin
      cbxAccount.ItemIndex := 0;
    end
    else
    begin
      cbxAccount.ItemIndex := -1;
      pnlAccount.Hint := '';
      pnlAccountCaption.Font.Color := clYellow;
      pnlAccountCaption.Font.Style := [fsBold];
      (cbx as TComboBox).Hint := '';
      f_account := 'AND (';
      for I := 0 to frmFilter.chkFilter.Items.Count - 1 do
        if frmFilter.chkFilter.Checked[I] = True then
        begin
          Str1 := Field(separ_1, frmFilter.chkFilter.Items[I], 1); // account
          Str2 := Field(separ_1, frmFilter.chkFilter.Items[I], 2); // currency
          (cbx as TComboBox).Hint :=
            (cbx as TComboBox).Hint + Str1 + separ + Str2 + separ + separ;
          f_account := f_account + '(acc_name = "' + AnsiReplaceStr(Str1, '"', '""') +
            '" AND acc_currency = "' + AnsiReplaceStr(Str2, '"', '""') + '") OR ';
          pnlAccount.Hint := pnlAccount.Hint + separ_1 + Str1 + ' (' + Str2 + ')';
        end;
      f_account := UTF8Copy(f_account, 1, UTF8Length(f_account) - 4) + ') ';
      (cbx as TComboBox).Hint :=
        UTF8Copy((cbx as TComboBox).Hint, 1, UTF8Length((cbx as TComboBox).Hint) - 2);
    end;
    cbxAccountChange(cbxAccount);
  end
  // end ACCOUNT =======================================================

  // Start CATEGORY =======================================================
  else if cbx = cbxCategory then
  begin
    if frmFilter.chkFilter.Tag = 1 then
    begin
      for I := 0 to frmFilter.chkFilter.Count - 1 do
      begin
        if frmFilter.chkFilter.Checked[I] = True then
          cbxCategory.ItemIndex := I + 1;
      end;
    end
    else if frmFilter.chkFilter.Tag = frmFilter.chkFilter.Items.Count then
    begin
      cbxCategory.ItemIndex := 0;
    end
    else
    begin
      pnlCategory.Hint := '';
      pnlCategoryCaption.Font.Color := clYellow;
      pnlCategoryCaption.Font.Style := [fsBold];
      (cbx as TComboBox).Hint := '';

      f_category := 'AND (';

      for I := 0 to frmFilter.chkFilter.Items.Count - 1 do
        if frmFilter.chkFilter.Checked[I] = True then
        begin
          Str1 := Field(separ_1, frmFilter.chkFilter.Items[I], 1);
          Str2 := Field(separ_1, frmFilter.chkFilter.Items[I], 2);
          (cbx as TComboBox).Hint :=
            (cbx as TComboBox).Hint + AnsiReplaceStr(frmFilter.chkFilter.Items[I],
            separ_1, separ) + separ + separ;

          if UTF8Pos(separ_1, frmFilter.chkFilter.Items[I]) = 0 then
            f_category := f_category + '(cat_parent_name = "' +
              AnsiUpperCase(AnsiReplaceStr(frmFilter.chkFilter.Items[I],
              '"', '""')) + '") OR '
          else
            f_category := f_category + '(cat_parent_id <> 0 AND cat_name = "' +
              AnsiReplaceStr(Str2, '"', '""') + '" AND cat_parent_name = "' +
              AnsiUpperCase(AnsiReplaceStr(Str1, '"', '""')) + '") OR ';

          pnlCategory.Hint := pnlCategory.Hint + separ_1 + AnsiUpperCase(Str1) +
            ' (' + IfThen(Str2 = '', '*', AnsiLowerCase(Str2)) + ') ';
        end;

      f_category := UTF8Copy(f_category, 1, UTF8Length(f_category) - 4) + ') ';
      (cbx as TComboBox).Hint :=
        UTF8Copy((cbx as TComboBox).Hint, 1, UTF8Length((cbx as TComboBox).Hint) - 2);

      cbxCategory.ItemIndex := -1;
    end;
    cbxCategoryChange(cbxCategory);
  end
  // end CATEGORY =======================================================

  // Start SUBCATEGORY =======================================================
  else if cbx = cbxSubcategory then
  begin
    if frmFilter.chkFilter.Tag = 1 then
    begin
      for I := 0 to frmFilter.chkFilter.Count - 1 do
      begin
        if frmFilter.chkFilter.Checked[I] = True then
          cbxSubcategory.ItemIndex := I + 1;
      end;
    end
    else if frmFilter.chkFilter.Tag = frmFilter.chkFilter.Items.Count then
    begin
      cbxSubcategory.ItemIndex := 0;
    end
    else
    begin
      Str1 := cbxCategory.Items[cbxCategory.ItemIndex];
      pnlCategory.Hint := Str1 + ' (';
      pnlCategoryCaption.Font.Color := clYellow;
      pnlCategoryCaption.Font.Style := [fsBold];
      (cbx as TComboBox).Hint := '';

      f_subcategory := '';

      for I := 0 to frmFilter.chkFilter.Items.Count - 1 do
        if frmFilter.chkFilter.Checked[I] = True then
        begin
          Str2 := frmFilter.chkFilter.Items[I];
          (cbx as TComboBox).Hint :=
            (cbx as TComboBox).Hint + AnsiReplaceStr(frmFilter.chkFilter.Items[I],
            separ_1, separ) + separ + separ;
          f_subcategory := f_subcategory + '"' + AnsiReplaceStr(Str2, '"', '""') + '",';

          pnlCategory.Hint := pnlCategory.Hint +
            IfThen(pnlCategory.Hint = Str1 + ' (', '', separ_1) + AnsiLowerCase(Str2);
        end;
      f_subcategory := UTF8Copy(f_subcategory, 1, UTF8Length(f_subcategory) - 1);
      f_subcategory := 'AND (cat_parent_id > 0 ' + sLineBreak +
        'AND cat_parent_name = "' + AnsiUpperCase(AnsiReplaceStr(Str1, '"', '""')) +
        '" ' + sLineBreak + 'AND cat_name IN (' + AnsiLowerCase(f_subcategory) + ')) ';

      pnlCategory.Hint := separ_1 + IfThen(frmSettings.chkDisplaySubCatCapital.Checked =
        True, AnsiUpperCase(pnlCategory.Hint), AnsiLowerCase(pnlCategory.Hint)) + ')';
      (cbx as TComboBox).Hint :=
        UTF8Copy((cbx as TComboBox).Hint, 1, UTF8Length((cbx as TComboBox).Hint) - 2);
      cbxSubcategory.ItemIndex := -1;
    end;
    cbxSubcategoryChange(cbxSubcategory);
  end
  // end subcategory =======================================================

  // Start PERSON =======================================================
  else if cbx = cbxPerson then
  begin
    if frmFilter.chkFilter.Tag = 1 then
    begin
      for I := 0 to frmFilter.chkFilter.Count - 1 do
      begin
        if frmFilter.chkFilter.Checked[I] = True then
          cbxPerson.ItemIndex := I + 1;
      end;
    end
    else if frmFilter.chkFilter.Tag = frmFilter.chkFilter.Items.Count then
    begin
      cbxPerson.ItemIndex := 0;
    end
    else
    begin
      pnlPerson.Hint := '';
      pnlPersonCaption.Font.Color := clYellow;
      pnlPersonCaption.Font.Style := [fsBold];
      (cbx as TComboBox).Hint := '';
      Temp := '';
      for I := 0 to frmFilter.chkFilter.Items.Count - 1 do
        if frmFilter.chkFilter.Checked[I] = True then
        begin
          pnlPerson.Hint := pnlPerson.Hint + separ_1 + AnsiUpperCase(
            frmFilter.chkFilter.Items[I]);
          (cbx as TComboBox).Hint :=
            (cbx as TComboBox).Hint + frmFilter.chkFilter.Items[I] + separ;
          temp := Temp + '"' + AnsiReplaceStr(frmFilter.chkFilter.Items[I],
            '"', '""') + '",';
        end;
      Temp := UTF8Copy(Temp, 1, UTF8Length(Temp) - 1);

      f_person := 'AND per_name IN (' + Temp + ') ';
      (cbx as TComboBox).Hint :=
        UTF8Copy((cbx as TComboBox).Hint, 1, UTF8Length((cbx as TComboBox).Hint) - 1);
      (cbx as TComboBox).ItemIndex := -1;
    end;
    cbxPersonChange((cbx as TComboBox));
  end
  // End PERSON ==========================================================

  // Start Payee =======================================================
  else if cbx = cbxPayee then
  begin
    if frmFilter.chkFilter.Tag = 1 then
    begin
      for I := 0 to frmFilter.chkFilter.Count - 1 do
      begin
        if frmFilter.chkFilter.Checked[I] = True then
          cbxPayee.ItemIndex := I + 1;
      end;
    end
    else if frmFilter.chkFilter.Tag = frmFilter.chkFilter.Items.Count then
    begin
      cbxPayee.ItemIndex := 0;
    end
    else
    begin
      pnlPayee.Hint := '';
      pnlPayeeCaption.Font.Color := clYellow;
      pnlPayeeCaption.Font.Style := [fsBold];
      (cbx as TComboBox).Hint := '';
      Temp := '';
      for I := 0 to frmFilter.chkFilter.Items.Count - 1 do
        if frmFilter.chkFilter.Checked[I] = True then
        begin
          pnlPayee.Hint := pnlPayee.Hint + separ_1 +
            AnsiUpperCase(frmFilter.chkFilter.Items[I]);
          (cbx as TComboBox).Hint :=
            (cbx as TComboBox).Hint + frmFilter.chkFilter.Items[I] + separ;
          temp := Temp + '"' + AnsiReplaceStr(frmFilter.chkFilter.Items[I],
            '"', '""') + '",';
        end;
      Temp := UTF8Copy(Temp, 1, UTF8Length(Temp) - 1);

      f_payee := 'AND pee_name IN (' + Temp + ') ';
      (cbx as TComboBox).Hint :=
        UTF8Copy((cbx as TComboBox).Hint, 1, UTF8Length((cbx as TComboBox).Hint) - 1);
      (cbx as TComboBox).ItemIndex := -1;
    end;
    cbxPayeeChange((cbx as TComboBox));
  end
  // End Payee ==========================================================

  // Start Tag =======================================================
  else if cbx = cbxTag then
  begin
    if frmFilter.chkFilter.Tag = 1 then
    begin
      for I := 0 to frmFilter.chkFilter.Count - 1 do
      begin
        if frmFilter.chkFilter.Checked[I] = True then
          cbxTag.ItemIndex := I + 1;
      end;
    end
    else if frmFilter.chkFilter.Tag = frmFilter.chkFilter.Items.Count then
    begin
      cbxTag.ItemIndex := 0;
    end
    else
    begin
      pnlTag.Hint := '';
      pnlTagCaption.Font.Color := clYellow;
      pnlTagCaption.Font.Style := [fsBold];
      (cbx as TComboBox).Hint := '';
      Temp := '';
      for I := 0 to frmFilter.chkFilter.Items.Count - 1 do
        if frmFilter.chkFilter.Checked[I] = True then
        begin
          pnlTag.Hint := pnlTag.Hint + separ_1 +
            AnsiUpperCase(frmFilter.chkFilter.Items[I]);
          (cbx as TComboBox).Hint :=
            (cbx as TComboBox).Hint + frmFilter.chkFilter.Items[I] + separ;
          temp := Temp + '"' + AnsiReplaceStr(frmFilter.chkFilter.Items[I],
            '"', '""') + '",';
        end;
      Temp := UTF8Copy(Temp, 1, UTF8Length(Temp) - 1);

      f_tag := 'AND d_id IN (SELECT dt_data FROM data_tags WHERE dt_tag IN ' +
        '(SELECT tag_id FROM tags WHERE tag_name IN (' + temp + '))) ';
      (cbx as TComboBox).Hint :=
        UTF8Copy((cbx as TComboBox).Hint, 1, UTF8Length((cbx as TComboBox).Hint) - 1);
      cbxTag.ItemIndex := -1;
    end;
    cbxTagChange(cbxTag);
  end;
  // End Tag ==========================================================

end;

procedure TfrmMain.btnDuplicateClick(Sender: TObject);
begin
  if (VST.SelectedCount <> 1) or (Conn.Connected = False) or
    (pnlReport.Visible = True) then
    Exit;
  VST.Tag := 1;
  btnAddClick(btnAdd);
  VST.Tag := 0;
  VST.SetFocus;
end;

procedure TfrmMain.btnPrintClick(Sender: TObject);
var
  FileName: string;
begin
  if (VST.RootNodeCount = 0) or (Conn.Connected = False) then
    Exit;

  if pnlReport.Visible = True then
  begin
    btnReportPrintClick(btnReportPrint);
    Exit;
  end;

  if btnPrint.Enabled = False then Exit;

  FileName := ExtractFileDir(Application.ExeName) + DirectorySeparator +
    'Templates' + DirectorySeparator + 'transactions.lrf';

  if FileExists(FileName) = False then
  begin
    ShowMessage(Error_14 + sLineBreak + FileName);
    Exit;
  end;

  // left mouse button = show report
  try
    if (Conn.Connected = False) then
      Exit;

    frmMain.Report.LoadFromFile(FileName);

    // header
    frmMain.Report.FindObject('HeaderCaption').Memo.Text :=
      AnsiUpperCase(Caption_25);
    frmMain.Report.FindObject('FilterX').Memo.Text :=
      pnlFilterCaption.Caption + ': ' + AnsiUpperCase(frmMain.pnlType.Hint +
      frmMain.pnlCurrency.Hint + frmMain.pnlAccount.Hint + frmMain.pnlDate.Hint +
      frmMain.pnlAmount.Hint + frmMain.pnlComment.Hint + frmMain.pnlCategory.Hint +
      frmMain.pnlPerson.Hint + frmMain.pnlPayee.Hint + frmMain.pnlTag.Hint);

    // transactions captions
    frmMain.Report.FindObject('lblDate').Memo.Text :=
      AnsiUpperCase(pnlDateCaption.Caption);
    frmMain.Report.FindObject('lblAmount').Memo.Text :=
      AnsiUpperCase(pnlAmountCaption.Caption);
    frmMain.Report.FindObject('lblComment').Memo.Text :=
      AnsiUpperCase(pnlCommentCaption.Caption);
    frmMain.Report.FindObject('lblAccount').Memo.Text :=
      AnsiUpperCase(pnlAccountCaption.Caption);
    frmMain.Report.FindObject('lblCategory').Memo.Text :=
      AnsiUpperCase(pnlCategoryCaption.Caption);
    frmMain.Report.FindObject('lblPerson').Memo.Text :=
      AnsiUpperCase(pnlPersonCaption.Caption);
    frmMain.Report.FindObject('lblPayee').Memo.Text :=
      AnsiUpperCase(pnlPayeeCaption.Caption);
    frmMain.Report.FindObject('lblID').Memo.Text :=
      AnsiUpperCase(Caption_53);

    frmMain.Report.FindObject('Account').Memo.Text :=
      frmMain.VSTSummary.Header.Columns[1].CaptionText;
    frmMain.Report.FindObject('StartSum').Memo.Text :=
      frmMain.VSTSummary.Header.Columns[2].CaptionText;
    frmMain.Report.FindObject('Credits').Memo.Text :=
      frmMain.VSTSummary.Header.Columns[3].CaptionText;
    frmMain.Report.FindObject('Debits').Memo.Text :=
      frmMain.VSTSummary.Header.Columns[4].CaptionText;
    frmMain.Report.FindObject('Pluses').Memo.Text :=
      frmMain.VSTSummary.Header.Columns[5].CaptionText;
    frmMain.Report.FindObject('Minuses').Memo.Text :=
      frmMain.VSTSummary.Header.Columns[6].CaptionText;
    frmMain.Report.FindObject('Balance').Memo.Text :=
      frmMain.VSTSummary.Header.Columns[7].CaptionText;
    frmMain.Report.FindObject('Total').Memo.Text :=
      frmMain.VSTSummary.Header.Columns[8].CaptionText;
    frmMain.Report.FindObject('Currency').Memo.Text :=
      tabCurrency.Tabs[tabCurrency.TabIndex] + ' - ' + AnsiUpperCase(Caption_15);

    // footer
    frmMain.Report.FindObject('lblFooter').Memo.Text :=
      AnsiUpperCase(Application.Title + ' - ' + AnsiUpperCase(Caption_25));

    frmMain.DSTSummary.Tag := 0;
    frmMain.Report.Tag := 1;
    frmMain.Report.ShowReport;
    VST.SetFocus;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmMain.btnPrintMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
var
  FileName: string;
begin
  FileName := ExtractFileDir(Application.ExeName) + DirectorySeparator +
    'Templates' + DirectorySeparator + 'transactions.lrf';

  if FileExists(FileName) = False then
  begin
    ShowMessage(Error_14 + sLineBreak + FileName);
    Exit;
  end;

  // right mouse button = show design report
  if Button = mbRight then
  begin
    frmMain.Report.LoadFromFile(FileName);
    frmMain.Report.DesignReport;
  end
  else if Button = mbLeft then
    btnPrintClick(btnPrint);
end;

procedure TfrmMain.btnReportExitClick(Sender: TObject);
begin
  frmMain.BeginFormUpdate;
  pnlReport.Visible := False;
  pnlClient.Visible := True;
  btnReports.Flat := True;
  mnuReports.Checked := False;
  VSTSummaries.Visible := False;
  VSTSummaries.Top := 1;
  VSTSummaries.Parent := pnlSummary;
  frmMain.EndFormUpdate;
  VST.SetFocus;
end;

procedure TfrmMain.btnReportPrintClick(Sender: TObject);
var
  FileName: string;
begin
  if (btnPrint.Enabled = False) or (Conn.Connected = False) then
    Exit;

  case tabReports.TabIndex of
    0, 2: FileName := ExtractFileDir(Application.ExeName) + DirectorySeparator +
        'Templates' + DirectorySeparator + 'report_balance.lrf';
    1: FileName := ExtractFileDir(Application.ExeName) + DirectorySeparator +
        'Templates' + DirectorySeparator + 'report_chrono.lrf';
  end;

  if FileExists(FileName) = False then
  begin
    ShowMessage(Error_14 + sLineBreak + FileName);
    Exit;
  end;

  try
    Report.LoadFromFile(FileName);

    if tabReports.TabIndex <> 1 then
    begin
      // header
      frmMain.Report.FindObject('HeaderCaption').Memo.Text :=
        AnsiUpperCase(IfThen(tabReports.TabIndex = 0, Caption_287, Caption_318) +
        ' - ' + IfThen(tabReports.TabIndex = 0,
        tabBalanceHeader.Tabs[tabBalanceHeader.TabIndex].Text,
        tabCrossTop.Tabs[tabCrossTop.TabIndex].Text + ' / ' +
        tabCrossLeft.Tabs[tabCrossLeft.TabIndex].Text));
      // transactions captions
      frmMain.Report.FindObject('Name').Memo.Text :=
        AnsiUpperCase(frmMain.VSTSummary.Header.Columns[1].CaptionText);
      frmMain.Report.FindObject('Credits').Memo.Text :=
        AnsiUpperCase(frmMain.VSTSummary.Header.Columns[3].CaptionText);
      frmMain.Report.FindObject('Debits').Memo.Text :=
        AnsiUpperCase(frmMain.VSTSummary.Header.Columns[4].CaptionText);
      frmMain.Report.FindObject('Pluses').Memo.Text :=
        AnsiUpperCase(frmMain.VSTSummary.Header.Columns[5].CaptionText);
      frmMain.Report.FindObject('Minuses').Memo.Text :=
        AnsiUpperCase(frmMain.VSTSummary.Header.Columns[6].CaptionText);
      frmMain.Report.FindObject('Balance').Memo.Text :=
        AnsiUpperCase(frmMain.VSTSummary.Header.Columns[7].CaptionText);

      // footer
      frmMain.Report.FindObject('Footer').Memo.Text :=
        AnsiUpperCase(Application.Title + ' - ' + AnsiReplaceStr(Menu_45, '&', ''));

      Report.Tag := 2;
      Report.ShowReport;
      case tabReports.TabIndex of
        0: if tabBalanceShow.TabIndex = 0 then
            VSTBalance.SetFocus;
        2: VSTCross.SetFocus;
      end;
    end;

    if tabReports.TabIndex = 1 then
    begin
      // header
      frmMain.Report.FindObject('HeaderCaption').Memo.Text :=
        AnsiUpperCase(AnsiReplaceStr(Menu_45, '&', '') + ' - ' +
        Caption_287 + ' - ' + tabChronoHeader.Tabs[tabChronoHeader.TabIndex].Text);

      frmMain.Report.FindObject('Account').Memo.Text :=
        frmMain.VSTChrono.Header.Columns[1].CaptionText;
      frmMain.Report.FindObject('StartSum').Memo.Text :=
        frmMain.VSTChrono.Header.Columns[2].CaptionText;
      frmMain.Report.FindObject('Credits').Memo.Text :=
        frmMain.VSTChrono.Header.Columns[3].CaptionText;
      frmMain.Report.FindObject('Debits').Memo.Text :=
        frmMain.VSTChrono.Header.Columns[4].CaptionText;
      frmMain.Report.FindObject('Pluses').Memo.Text :=
        frmMain.VSTChrono.Header.Columns[5].CaptionText;
      frmMain.Report.FindObject('Minuses').Memo.Text :=
        frmMain.VSTChrono.Header.Columns[6].CaptionText;
      frmMain.Report.FindObject('Balance').Memo.Text :=
        frmMain.VSTChrono.Header.Columns[7].CaptionText;
      frmMain.Report.FindObject('Total').Memo.Text :=
        frmMain.VSTChrono.Header.Columns[8].CaptionText;
      // footer
      frmMain.Report.FindObject('lblFooter').Memo.Text :=
        AnsiUpperCase(Application.Title + ' - ' + AnsiReplaceStr(Menu_45, '&', ''));

      Report.Tag := 1;
      Report.ShowReport;
      VSTChrono.SetFocus;
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmMain.btnReportPrintMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: integer);
var
  FileName: string;
begin
  if Button = mbLeft then
  begin
    btnPrintClick(btnPrint);
    Exit;
  end;

  try
    case tabReports.TabIndex of
      0, 2: FileName := ExtractFileDir(Application.ExeName) +
          DirectorySeparator + 'Templates' + DirectorySeparator + 'report_balance.lrf';
      1: FileName := ExtractFileDir(Application.ExeName) + DirectorySeparator +
          'Templates' + DirectorySeparator + 'report_chrono.lrf';
    end;

    if FileExists(FileName) = False then
    begin
      ShowMessage(Error_14 + sLineBreak + FileName);
      Exit;
    end;

    // right mouse button = show design report
    if Button = mbRight then
    begin
      Report.LoadFromFile(FileName);
      Report.DesignReport;
    end;
  except
  end;
end;

procedure TfrmMain.btnReportSettingsClick(Sender: TObject);
var
  vNode: TTreeNode;
begin
  try
    for vNode in frmSettings.treSettings.Items do
      if vNode.AbsoluteIndex = 6 then
        vNode.Selected := True;
    frmSettings.ShowModal;
  except
  end;
end;

procedure TfrmMain.CalendarDateChange(Sender: TObject);
begin
  try
    if Conn.Connected = False then
      Exit;

    if pnlDayCaption.Tag = 0 then
    begin
      f_date := '';
      pnlDate.Hint := '';
    end
    else
    begin
      f_date := 'AND d_date = "' + FormatDateTime('YYYY-MM-DD', Calendar.Date) + '"';
      pnlDate.Hint := separ_1 + FormatDateTime(FS_own.ShortDateFormat, Calendar.Date);
    end;

    UpdateTransactions;

  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmMain.cbxAccountDropDown(Sender: TObject);
begin
  {$IFDEF WINDOWS}
    ComboDDWidth(TComboBox(Sender));
  {$ENDIF}
end;

procedure TfrmMain.cbxSubcategoryChange(Sender: TObject);
begin
  if Conn.Connected = False then
    Exit;

  case cbxSubcategory.ItemIndex of
    -1: begin
      f_category := '';
    end;
    0: begin
      cbxCategoryChange(cbxCategory);
    end
    else
    begin
      f_category := '';
      f_subcategory := 'AND (cat_parent_id > 0 ' + sLineBreak +
        'AND cat_parent_name = "' + AnsiUpperCase(
        AnsiReplaceStr(cbxCategory.Items[cbxCategory.ItemIndex], '"', '""')) +
        '" ' + sLineBreak + 'AND cat_name = "' + AnsiLowerCase(
        cbxSubcategory.Items[cbxSubcategory.ItemIndex]) + '") ';
      pnlCategory.Hint := separ_1 + AnsiUpperCase(
        cbxCategory.Items[cbxCategory.ItemIndex]) + ' (' +
        cbxSubcategory.Items[cbxSubcategory.ItemIndex] + ')';
    end;
  end;
  UpdateTransactions;
end;

procedure TfrmMain.chaBalanceClick(Sender: TObject);
begin
  chaBalance.Tag := 1 - chaBalance.Tag;
  serBalanceCredits.Marks.YIndex := chaBalance.Tag;
  serBalanceDebits.Marks.YIndex := chaBalance.Tag;
  //  chaBalance.Repaint;
end;

procedure TfrmMain.datDateFromKeyDown(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  if key = 27 then
  begin
    Key := 0;
    mnuExitClick(mnuExit);
  end;
end;

procedure TfrmMain.datDateToKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 0;
    if (frmMain.Visible = True) and (pnlReport.Visible = False) then
      VST.SetFocus;
  end;
end;

procedure TfrmMain.DSTBalanceCheckEOF(Sender: TObject; var EOF: boolean);
begin
  case tabReports.TabIndex of
    0: EOF := ReportNodesCount = VSTBalance.TotalCount;
    2: EOF := ReportNodesCount = VSTCross.TotalCount;
  end;
end;

procedure TfrmMain.DSTBalanceFirst(Sender: TObject);
begin
  ReportNodesCount := 0;
  case tabReports.TabIndex of
    0: ReportNode := VSTBalance.GetFirst();
    2: ReportNode := VSTCross.GetFirst();
  end;
end;

procedure TfrmMain.DSTBalanceNext(Sender: TObject);
begin
  Inc(ReportNodesCount);
  case tabReports.TabIndex of
    0: ReportNode := VSTBalance.GetNext(ReportNode);
    2: ReportNode := VSTCross.GetNext(ReportNode);
  end;
end;

procedure TfrmMain.DSTSummaryCheckEOF(Sender: TObject; var EOF: boolean);
begin
  if pnlReport.Visible = False then
    EOF := ReportNodesCount = VSTSummary.RootNodeCount
  else
    EOF := ReportNodesCount = VSTChrono.RootNodeCount;
end;

procedure TfrmMain.DSTSummaryFirst(Sender: TObject);
begin
  ReportNodesCount := 0;
  if pnlReport.Visible = False then
    ReportNode := VSTSummary.GetFirst()
  else
    ReportNode := VSTChrono.GetFirst();
end;

procedure TfrmMain.DSTSummaryNext(Sender: TObject);
begin
  Inc(ReportNodesCount);
  if pnlReport.Visible = False then
    ReportNode := VSTSummary.GetNext(ReportNode)
  else
    ReportNode := VSTChrono.GetNext(ReportNode);
end;

procedure TfrmMain.DSTCheckEOF(Sender: TObject; var EOF: boolean);
begin
  case Report.Tag of
    1: EOF := ReportNodesCount = frmMain.VST.RootNodeCount;
    10: EOF := ReportNodesCount = frmPersons.VST.RootNodeCount;
    11: EOF := ReportNodesCount = frmCategories.VST.TotalCount;
    12: EOF := ReportNodesCount = frmAccounts.VST.TotalCount;
    13: EOF := ReportNodesCount = frmComments.VST.TotalCount;
    14: EOF := ReportNodesCount = frmPayees.VST.TotalCount;
    15: EOF := ReportNodesCount = frmCurrencies.VST.TotalCount;
    16: EOF := ReportNodesCount = frmTags.VST.TotalCount;
    17: EOF := ReportNodesCount = frmHolidays.VST.TotalCount;
    18: EOF := ReportNodesCount = frmLinks.VST.TotalCount;
    20: EOF := ReportNodesCount = frmCounter.BackGround.Tag - 1;
  end;
end;

procedure TfrmMain.DSTFirst(Sender: TObject);
begin
  ReportNodesCount := 0;
  case Report.Tag of
    1: ReportNode := frmMain.VST.GetFirst();
    10: ReportNode := frmPersons.VST.GetFirst();
    11: ReportNode := frmCategories.VST.GetFirst();
    12: ReportNode := frmAccounts.VST.GetFirst();
    13: ReportNode := frmComments.VST.GetFirst();
    14: ReportNode := frmPayees.VST.GetFirst();
    15: ReportNode := frmCurrencies.VST.GetFirst();
    16: ReportNode := frmTags.VST.GetFirst();
    17: ReportNode := frmHolidays.VST.GetFirst();
    18: ReportNode := frmLinks.VST.GetFirst();
  end;
end;

procedure TfrmMain.DSTNext(Sender: TObject);
begin
  Inc(ReportNodesCount);
  case Report.Tag of
    1: ReportNode := frmMain.VST.GetNext(ReportNode);
    10: ReportNode := frmPersons.VST.GetNext(ReportNode);
    11: ReportNode := frmCategories.VST.GetNext(ReportNode);
    12: ReportNode := frmAccounts.VST.GetNext(ReportNode);
    13: ReportNode := frmComments.VST.GetNext(ReportNode);
    14: ReportNode := frmPayees.VST.GetNext(ReportNode);
    15: ReportNode := frmCurrencies.VST.GetNext(ReportNode);
    16: ReportNode := frmTags.VST.GetNext(ReportNode);
    17: ReportNode := frmHolidays.VST.GetNext(ReportNode);
    18: ReportNode := frmLinks.VST.GetNext(ReportNode);
  end;
end;

procedure TfrmMain.ediCommentEnter(Sender: TObject);
begin
  actDelete.Enabled := False;
  actEdit.Enabled := False;
end;

procedure TfrmMain.ediCommentExit(Sender: TObject);
begin
  actDelete.Enabled := True;
  actEdit.Enabled := True;
end;

procedure TfrmMain.lblDateFromClick(Sender: TObject);
begin
  datDateFrom.SetFocus;
end;

procedure TfrmMain.lblDateToClick(Sender: TObject);
begin
  datDateTo.SetFocus;
end;

procedure TfrmMain.mnuCheckUpdateClick(Sender: TObject);
{$IFDEF WINDOWS}
var
  slVersion: TStringList;
  Temp, VDate, VVersion: string;
{$ENDIF}
begin
  {$IFDEF LINUX}
  If (frmMain.Visible = True) then
    begin
     MessageDlg(Application.Title + ' - ' + AnsiUpperCase(mnuCheckUpdate.Caption),
       Message_10 + ' (LINUX).', mtInformation, [mbOK], 0);
     Exit;
    end;
  {$ENDIF}

  {$IFDEF WINDOWS}
  try
    screen.Cursor := crHourGlass;
    Temp := ExtractFileDir(Application.ExeName) + DirectorySeparator + 'version.txt';
    URLDownloadToFile(nil, PChar('https://rqmoney.eu/version.txt'),
      PChar(Temp), 0, nil);

    if FileExists(Temp) = True then
    begin
      slVersion := TStringList.Create;
      slVersion.LoadFromFile(ExtractFileDir(Application.ExeName) +
        DirectorySeparator + 'version.txt');
      if slVersion.Count >= 2 then
      begin
        VVersion := slVersion.Strings[0];
        VDate := slVersion.Strings[1];
      end;
      slVersion.Free;
      DeleteFileUTF8(Temp);

      if VDate > frmAbout.lblReleased.Hint then
      begin
        Temp := AnsiReplaceStr(Question_25, '%1', VVersion);
        Temp := AnsiReplaceStr(Temp, '%2', sLineBreak);
        Temp := AnsiReplaceStr(Temp, '%3',
          DateToStr(StrToDate(VDate, 'YYYY-MM-DD', '-')));
        if MessageDlg(Application.Title, Temp, mtConfirmation,
          [mbYes, mbNo], 0) = mrYes then
          OpenURL(frmAbout.lblWebsite.Hint);
      end
      else if VDate = frmAbout.lblReleased.Hint then
        if (frmMain.Visible = True) then
          ShowMessage(Message_09 + sLineBreak + VVersion);
    end;
  finally
    screen.Cursor := crDefault;
  end;
  {$ENDIF}
end;

procedure TfrmMain.mnuSubLinkClick(Sender: TObject);
begin
  frmLinks.ShowModal;
end;

procedure TfrmMain.pnlFilterResize(Sender: TObject);
begin
  if pnlFilter.Width > 180 then
  begin
    datDateFrom.MonthDisplay := mdLong;
    datDateTo.MonthDisplay := mdLong;
    lblDateFrom.Caption :=
      DefaultFormatSettings.LongDayNames[DayOfTheWeek(datDateFrom.Date + 1)];
    lblDateTo.Caption := DefaultFormatSettings.LongDayNames[DayOfTheWeek(
      datDateTo.Date + 1)];
  end
  else
  begin
    datDateFrom.MonthDisplay := mdShort;
    datDateTo.MonthDisplay := mdShort;
    lblDateFrom.Caption :=
      DefaultFormatSettings.ShortDayNames[DayOfTheWeek(datDateFrom.Date + 1)];
    lblDateTo.Caption := DefaultFormatSettings.ShortDayNames[DayOfTheWeek(
      datDateTo.Date + 1)];
  end;
end;

procedure TfrmMain.popChartChrono1Click(Sender: TObject);
begin
  if (pnlReport.Visible = False) or (tabReports.TabIndex <> 1) then
    Exit;

  if Sender.ClassType = TAction then
    case (Sender as TAction).Tag of
      0: popChartChrono1.Checked := not (popChartChrono1.Checked);
      1: popChartChrono2.Checked := not (popChartChrono2.Checked);
      2: popChartChrono3.Checked := not (popChartChrono3.Checked);
      3: popChartChrono4.Checked := not (popChartChrono4.Checked);
      4: popChartChrono5.Checked := not (popChartChrono5.Checked);
      5: popChartChrono6.Checked := not (popChartChrono6.Checked);
      6: popChartChrono7.Checked := not (popChartChrono7.Checked);
    end
  else
  begin
    (Sender as TMenuItem).Checked := not ((Sender as TMenuItem).Checked);
  end;
  tabChronoHeaderChange(tabChronoHeader);
end;

procedure TfrmMain.popChartChronoShowMarksClick(Sender: TObject);
begin
  popChartChronoShowMarks.Checked := not (popChartChronoShowMarks.Checked);
  tabChronoHeaderChange(tabChronoHeader);
end;

procedure TfrmMain.popChartChronoShowPointsClick(Sender: TObject);
begin
  popChartChronoShowPoints.Checked := not (popChartChronoShowPoints.Checked);
  tabChronoHeaderChange(tabChronoHeader);
end;

procedure TfrmMain.popCopyChartBalanceClick(Sender: TObject);
begin
  case tabReports.TabIndex of
    0: chaBalance.CopyToClipboardBitmap;
    1: chaChrono.CopyToClipboardBitmap;
  end;

  ShowMessage(Chart_09);
end;

procedure TfrmMain.popEditToolBarClick(Sender: TObject);
var
  vNode: TTreeNode;
begin
  for vNode in frmSettings.treSettings.Items do
    if vNode.AbsoluteIndex = 3 then
    begin
      vNode.Selected := True;
      frmSettings.tabVisualSettings.TabIndex := 2;
    end;

  frmSettings.ShowModal;
end;

procedure TfrmMain.popSummaryCopyClick(Sender: TObject);
begin
  CopyVST(VSTSummary);
end;

procedure TfrmMain.popSummaryPrintClick(Sender: TObject);
var
  FileName: string;
begin
  if (VSTSummary.RootNodeCount = 0) or (Conn.Connected = False) or
    (popSummaryPrint.Enabled = False) then
    Exit;

  FileName := ExtractFileDir(Application.ExeName) + DirectorySeparator +
    'Templates' + DirectorySeparator + 'summary.lrf';

  if FileExists(FileName) = False then
  begin
    ShowMessage(Error_14 + sLineBreak + FileName);
    Exit;
  end;

  // left mouse button = show report
  try
    if (Conn.Connected = False) then
      Exit;

    frmMain.Report.LoadFromFile(FileName);

    // header
    frmMain.Report.FindObject('HeaderCaption').Memo.Text :=
      AnsiUpperCase(Caption_15) + ' (' + AnsiUpperCase(
      tabCurrency.Tabs[tabCurrency.TabIndex] + ')');
    frmMain.Report.FindObject('FilterX').Memo.Text :=
      pnlFilterCaption.Caption + ': ' + AnsiUpperCase(frmMain.pnlType.Hint +
      frmMain.pnlCurrency.Hint + frmMain.pnlAccount.Hint + frmMain.pnlDate.Hint +
      frmMain.pnlAmount.Hint + frmMain.pnlComment.Hint + frmMain.pnlCategory.Hint +
      frmMain.pnlPerson.Hint + frmMain.pnlPayee.Hint + frmMain.pnlTag.Hint);

    frmMain.Report.FindObject('Account').Memo.Text :=
      frmMain.VSTSummary.Header.Columns[1].CaptionText;
    frmMain.Report.FindObject('StartSum').Memo.Text :=
      frmMain.VSTSummary.Header.Columns[2].CaptionText;
    frmMain.Report.FindObject('Credits').Memo.Text :=
      frmMain.VSTSummary.Header.Columns[3].CaptionText;
    frmMain.Report.FindObject('Debits').Memo.Text :=
      frmMain.VSTSummary.Header.Columns[4].CaptionText;
    frmMain.Report.FindObject('Pluses').Memo.Text :=
      frmMain.VSTSummary.Header.Columns[5].CaptionText;
    frmMain.Report.FindObject('Minuses').Memo.Text :=
      frmMain.VSTSummary.Header.Columns[6].CaptionText;
    frmMain.Report.FindObject('Balance').Memo.Text :=
      frmMain.VSTSummary.Header.Columns[7].CaptionText;
    frmMain.Report.FindObject('Total').Memo.Text :=
      frmMain.VSTSummary.Header.Columns[8].CaptionText;

    // footer
    frmMain.Report.FindObject('lblFooter').Memo.Text :=
      AnsiUpperCase(Application.Title + ' - ' + AnsiUpperCase(Caption_25));

    frmMain.DSTSummary.Tag := 0;
    frmMain.Report.Tag := 1;
    frmMain.Report.ShowReport;
    VST.SetFocus;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmMain.ReportBeginBand(Band: TfrBand);
begin
  if (Band.Typ = btPageHeader) then
    Band.Visible := frmMain.DSTSummary.Tag = 0; //(CurrentPage = TotalPages) ;

  try
    if (Band.Typ = btMasterFooter) then
    begin
      Band.ForceNewPage := frmSettings.chkPrintSummarySeparately.Checked;
      frmMain.DSTSummary.Tag := 1;
    end;
  finally
  end;
end;


procedure TfrmMain.serBalanceCreditsGetMark(out AFormattedMark: string; AIndex: integer);
var
  D: double;
begin
  D := serBalanceCredits.YValues[AIndex, serBalanceCredits.Marks.YIndex];
  if D = 0 then
    AFormattedMark := ''
  else
    AFormattedMark := Format('%n', [D], FS_own);
end;

procedure TfrmMain.serBalanceDebitsGetMark(out AFormattedMark: string; AIndex: integer);
var
  D: double;
begin
  D := serBalanceDebits.YValues[AIndex, serBalanceDebits.Marks.YIndex];
  if D = 0 then
    AFormattedMark := ''
  else
    AFormattedMark := Format('%n', [D], FS_own);
end;

procedure TfrmMain.serChronoBalanceGetMark(out AFormattedMark: string; AIndex: integer);
var
  D: double;
begin
  D := serChronoBalance.YValues[AIndex, serChronoBalance.Marks.YIndex];
  if D = 0 then
    AFormattedMark := ''
  else
    AFormattedMark := Format('%n', [D], FS_own);
end;

procedure TfrmMain.serChronoCreditsGetMark(out AFormattedMark: string; AIndex: integer);
var
  D: double;
begin
  D := serChronoCredits.YValues[AIndex, serChronoCredits.Marks.YIndex];
  if D = 0 then
    AFormattedMark := ''
  else
    AFormattedMark := Format('%n', [D], FS_own);
end;

procedure TfrmMain.serChronoDebitsGetMark(out AFormattedMark: string; AIndex: integer);
var
  D: double;
begin
  D := serChronoDebits.YValues[AIndex, serChronoDebits.Marks.YIndex];
  if D = 0 then
    AFormattedMark := ''
  else
    AFormattedMark := Format('%n', [D], FS_own);
end;

procedure TfrmMain.serChronoStartGetMark(out AFormattedMark: string; AIndex: integer);
var
  D: double;
begin
  D := serChronoStart.YValues[AIndex, serChronoStart.Marks.YIndex];
  if D = 0 then
    AFormattedMark := ''
  else
    AFormattedMark := Format('%n', [D], FS_own);
end;

procedure TfrmMain.serChronoTMinusGetMark(out AFormattedMark: string; AIndex: integer);
var
  D: double;
begin
  D := serChronoTMinus.YValues[AIndex, serChronoTMinus.Marks.YIndex];
  if D = 0 then
    AFormattedMark := ''
  else
    AFormattedMark := Format('%n', [D], FS_own);
end;

procedure TfrmMain.serChronoTotalGetMark(out AFormattedMark: string; AIndex: integer);
var
  D: double;
begin
  D := serChronoTotal.YValues[AIndex, serChronoTotal.Marks.YIndex];
  if D = 0 then
    AFormattedMark := ''
  else
    AFormattedMark := Format('%n', [D], FS_own);
end;

procedure TfrmMain.serChronoTPlusGetMark(out AFormattedMark: string; AIndex: integer);
var
  D: double;
begin
  D := serChronoTPlus.YValues[AIndex, serChronoTPlus.Marks.YIndex];
  if D = 0 then
    AFormattedMark := ''
  else
    AFormattedMark := Format('%n', [D], FS_own);
end;

procedure TfrmMain.spiMaxEnter(Sender: TObject);
begin
  actDelete.Enabled := False;
end;

procedure TfrmMain.spiMaxExit(Sender: TObject);
begin
  actDelete.Enabled := True;
end;

procedure TfrmMain.FormShow(Sender: TObject);
var
  INI: TIniFile;
  INIFile, TempStr: string;
  I: integer;
begin
  // ********************************************************************
  // FORM SIZE START
  // ********************************************************************
  try
    INIFile := ChangeFileExt(ParamStr(0), '.ini');
    // INI file READ procedure (if file exists) =========================
    if FileExists(INIFile) = True then
    begin
      INI := TINIFile.Create(INIFile);
      frmMain.Position := poDesigned;
      TempStr := INI.ReadString('POSITION', frmMain.Name, '-1•-1•0•0•200•200');

      // width
      TryStrToInt(Field(Separ, TempStr, 3), I);
      if (I < 1) or (I > Screen.Width) then
        frmMain.Width := Screen.Width - 100 - (200 - ScreenRatio)
      else
        frmMain.Width := I;

      /// height
      TryStrToInt(Field(Separ, TempStr, 4), I);
      if (I < 1) or (I > Screen.Height) then
        frmMain.Height := Screen.Height - 150 - (200 - ScreenRatio)
      else
        frmMain.Height := I;

      // left
      TryStrToInt(Field(Separ, TempStr, 1), I);
      if (I < 0) or (I > Screen.Width) then
        frmMain.left := (Screen.Width - frmMain.Width) div 2
      else
        frmMain.Left := I;

      // top
      TryStrToInt(Field(Separ, TempStr, 2), I);
      if (I < 0) or (I > Screen.Height) then
        frmMain.Top := ((Screen.Height - frmMain.Height) div 2) - 75
      else
        frmMain.Top := I;

      // filter panel
      TryStrToInt(Field(Separ, TempStr, 5), I);
      if (I < 1) or (I > 500) then
        frmMain.pnlFilter.Width := 250
      else
        frmMain.pnlFilter.Width := I;

      // summary panel
      TryStrToInt(Field(Separ, TempStr, 6), I);
      if (I < 1) or (I > 600) then
        frmMain.pnlSummary.Height := 250
      else
        frmMain.pnlSummary.Height := I;
    end;
  finally
    INI.Free
  end;
  // ********************************************************************
  // FORM SIZE END
  // ********************************************************************

  SetNodeHeight(frmMain.VST);
  SetNodeHeight(frmMain.VSTSummary);
  VST.SetFocus;
  VST.ClearSelection;

  if FirstRun = True then
    tmrFirstRun.Enabled := True;
end;

procedure TfrmMain.mnuBudgetClick(Sender: TObject);
begin
  frmBudgets.ShowModal;
end;

procedure TfrmMain.mnuCalendarClick(Sender: TObject);
begin
  frmCalendar.ShowModal;
end;

procedure TfrmMain.mnuExportClick(Sender: TObject);
begin
  if (Conn.Connected = False) then
    Exit;
  ShowMessage(AnsiReplaceStr(Error_17, '%', sLineBreak));

end;

procedure TfrmMain.popFilterClearClick(Sender: TObject);
begin
  if popFilterClear.Tag = 0 then
  begin
    if MessageDlg(Application.Title, Question_03, mtConfirmation, [mbYes, mbNo], 0) <>
      mrYes then
      Exit;
  end
  else
    frmMain.popFilterClear.Tag := 0;

  frmMain.BeginFormUpdate;
  //  pnlFilter.Visible := False;
  AllowUpdateTransactions := False;

  // clear type
  cbxType.ItemIndex := 0;
  f_type := 'd_type LIKE "%" ';
  pnlType.Hint := '';
  pnlType.Color := clDefault;
  pnlTypeCaption.Font.Style := [];
  pnlTypeCaption.Font.Color := clWhite;
  if Conn.Connected = False then
  begin
    pnlTypeCaption.Tag := 1;
    pnlTypeCaptionClick(pnlTypeCaption);
  end;

  // clear date
  cbxMonth.ItemIndex := 0;
  cbxYear.ItemIndex := 0;
  pnlMonthYearCaption.Tag := 1;
  pnlMonthYearCaptionClick(pnlMonthYearCaption);

  if Conn.Connected = False then
  begin
    pnlDateCaption.Tag := 1;
    pnlDateCaptionClick(pnlDateCaption);
  end;

  // clear currency
  f_currency := 'AND cur_status = 0 ';
  pnlCurrency.Hint := '';
  pnlCurrency.Color := clDefault;
  pnlCurrencyCaption.Font.Style := [];
  pnlCurrencyCaption.Font.Color := clWhite;

  if Conn.Connected = False then
  begin
    cbxCurrency.Clear;
    cbxCurrency.Items.Add('*');
    pnlCurrencyCaption.Tag := 1;
    pnlCurrencyCaptionClick(pnlCurrencyCaption);
  end;
  cbxCurrency.ItemIndex := 0;
  cbxCurrencyChange(cbxCurrency);

  // clear account
  f_account := 'AND acc_status = 0 ';
  pnlAccount.Hint := '';
  pnlAccount.Color := clDefault;
  pnlAccountCaption.Font.Style := [];
  pnlAccountCaption.Font.Color := clWhite;
  if Conn.Connected = False then
  begin
    pnlAccountCaption.Tag := 1;
    pnlAccountCaptionClick(pnlAccountCaption);
  end;
  cbxAccount.ItemIndex := 0;
  cbxAccountChange(cbxAccount);

  // clear amount
  f_amount := '';
  pnlAmount.Hint := '';
  pnlAmount.Color := clDefault;
  pnlAmountCaption.Font.Style := [];
  pnlAmountCaption.Font.Color := clWhite;
  cbxMin.ItemIndex := 0;
  spiMin.Clear;
  cbxMax.ItemIndex := 0;
  spiMax.Clear;
  if Conn.Connected = False then
  begin
    pnlAmountCaption.Tag := 1;
    pnlAmountCaptionClick(pnlAmountCaption);
  end;

  // clear comment
  f_comment := '';
  pnlComment.Hint := '';
  pnlComment.Color := clDefault;
  pnlCommentCaption.Font.Style := [];
  pnlCommentCaption.Font.Color := clWhite;
  cbxComment.ItemIndex := 0;
  ediComment.Clear;
  if Conn.Connected = False then
  begin
    pnlCommentCaption.Tag := 1;
    pnlCommentCaptionClick(pnlCommentCaption);
  end;

  // clear category
  f_Category := '';
  pnlCategory.Hint := '';
  pnlCategory.Color := clDefault;
  pnlCategoryCaption.Font.Style := [];
  pnlCategoryCaption.Font.Color := clWhite;
  if Conn.Connected = False then
  begin
    pnlCategoryCaption.Tag := 1;
    pnlCategoryCaptionClick(pnlCategoryCaption);
    cbxCategory.Clear;
    cbxCategory.Items.Add('*');
  end;
  cbxCategory.ItemIndex := 0;
  cbxCategoryChange(cbxCategory);

  // clear person
  f_Person := 'AND per_status = 0 ';
  pnlPerson.Hint := '';
  pnlPerson.Color := clDefault;
  pnlPersonCaption.Font.Style := [];
  pnlPersonCaption.Font.Color := clWhite;
  if Conn.Connected = False then
  begin
    pnlPersonCaption.Tag := 1;
    pnlPersonCaptionClick(pnlPersonCaption);
    cbxPerson.Clear;
    cbxPerson.Items.Add('*');
  end;
  cbxPerson.ItemIndex := 0;
  cbxPersonChange(cbxPerson);

  // clear payee
  f_payee := '';
  pnlPayee.Hint := '';
  pnlPayee.Color := clDefault;
  pnlPayeeCaption.Font.Color := clWhite;
  pnlPayeeCaption.Font.Style := [];
  if Conn.Connected = False then
  begin
    pnlPayeeCaption.Tag := 1;
    pnlPayeeCaptionClick(pnlPayeeCaption);
    cbxPayee.Clear;
    cbxPayee.Items.Add('*');
  end;
  cbxPayee.ItemIndex := 0;
  cbxPayeeChange(cbxPayee);

  // clear tag
  f_tag := '';
  pnlTag.Hint := '';
  pnlTag.Color := clDefault;
  pnlTagCaption.Font.Style := [];
  pnlTagCaption.Font.Color := clWhite;
  if Conn.Connected = False then
  begin
    pnlTagCaption.Tag := 1;
    pnlTagCaptionClick(pnlTagCaption);
    cbxTag.Clear;
    cbxTag.Items.Add('*');
  end;
  cbxTag.ItemIndex := 0;
  cbxTagChange(cbxTag);

  // clear caption
  frmMain.pnlListCaption.Caption := AnsiUpperCase(Caption_25);
  frmMain.EndFormUpdate;
  //  pnlFilter.Visible := True;

  // update transactions
  if Conn.Connected = True then
  begin
    AllowUpdateTransactions := True;
    UpdateTransactions;
  end;
end;

procedure TfrmMain.btnMonthMinusClick(Sender: TObject);
begin
  cbxMonth.ItemIndex := cbxMonth.ItemIndex - 1;
  cbxMonthChange(cbxMonth);
end;

procedure TfrmMain.btnMonthPlusClick(Sender: TObject);
begin
  cbxMonth.ItemIndex := cbxMonth.ItemIndex + 1;
  cbxMonthChange(cbxMonth);
end;

procedure TfrmMain.btnSelectClick(Sender: TObject);
begin
  if (Conn.Connected = False) then
    Exit;

  if (VST.RootNodeCount > 0) and (pnlReport.Visible = False) then
  begin
    VST.SelectAll(False);
    VST.SetFocus;
  end
  else if (VSTBalance.RootNodeCount > 0) and (pnlReport.Visible = True) then
  begin
    VSTBalance.SelectAll(False);
    VSTBalance.SetFocus;
  end;
end;

procedure TfrmMain.btnYearMinusClick(Sender: TObject);
begin
  cbxYear.ItemIndex := cbxYear.ItemIndex + 1;
  cbxMonthChange(cbxMonth);
end;

procedure TfrmMain.btnYearPlusClick(Sender: TObject);
begin
  cbxYear.ItemIndex := cbxYear.ItemIndex - 1;
  cbxMonthChange(cbxMonth);
end;

procedure TfrmMain.cbxAccountChange(Sender: TObject);
var
  Account, currency: string;
begin
  if conn.Connected = False then
    exit;

  case cbxAccount.ItemIndex of
    -1:
    begin
      pnlAccountCaption.Font.Color := clYellow;
      pnlAccountCaption.Font.Style := [fsBold];
    end;
    0:
    begin
      f_account := 'AND acc_status = 0 ';
      pnlAccount.Hint := '';
      pnlAccount.Color := clDefault;
      pnlAccountCaption.Font.Style := [];
      pnlAccountCaption.Font.Color := clWhite;
      cbxAccount.Hint := '';
    end
    else
    begin
      Account := Field(separ_1, cbxAccount.Items[cbxAccount.ItemIndex], 1);
      currency := Field(separ_1, cbxAccount.Items[cbxAccount.ItemIndex], 2);
      f_account := 'AND acc_name = "' + AnsiReplaceStr(Account, '"', '""') +
        '" AND acc_currency = "' + AnsiReplaceStr(currency, '"', '""') + '" ';
      pnlAccount.Hint := separ_1 + Account + ' (' + currency + ')';
      pnlAccountCaption.Font.Color := clYellow;
      pnlAccountCaption.Font.Style := [fsBold];
      cbxAccount.Hint := Account + separ + currency;
    end;
  end;

  // =============================================================================================
  // update transactions
  UpdateTransactions;
end;

procedure TfrmMain.cbxCategoryChange(Sender: TObject);
var
  S: string;
begin
  if Conn.Connected = False then
    Exit;

  f_subcategory := '';

  case cbxCategory.ItemIndex of
    -1:
    begin
      pnlCategoryCaption.Font.Color := clYellow;
      pnlCategoryCaption.Font.Style := [fsBold];
      cbxSubcategory.Clear;
      cbxSubcategory.Items.Add('*');
      cbxSubcategory.ItemIndex := 0;
      cbxSubcategory.Enabled := False;
    end;
    0:
    begin
      f_category := ' AND cat_status = 0 ';
      pnlCategory.Hint := '';
      pnlCategory.Color := clDefault;
      pnlCategoryCaption.Font.Style := [];
      pnlCategoryCaption.Font.Color := clWhite;
      cbxCategory.Hint := '';
      cbxSubcategory.Clear;
      cbxSubcategory.Items.Add('*');
      cbxSubcategory.ItemIndex := 0;
      cbxSubcategory.Enabled := False;
    end
    else
    begin
      S := cbxCategory.Items[cbxCategory.ItemIndex];
      f_category := 'AND (cat_parent_name = "' + AnsiReplaceStr(S, '"', '""') + '") ';
      pnlCategory.Hint := separ_1 + S + ' (*)';
      cbxCategory.Hint := S;
      pnlCategoryCaption.Font.Color := clYellow;
      pnlCategoryCaption.Font.Style := [fsBold];
      FillSubcategory(S, cbxSubcategory);
      cbxSubcategory.Enabled := True;
    end;
  end;

  UpdateTransactions;
end;

procedure TfrmMain.cbxCurrencyChange(Sender: TObject);
var
  I: word;
  slAcc: TStringList;
begin
  if (conn.Connected = False) then
    exit;

  // ==============================================================================================
  try
    tabCurrency.Tabs.Clear;

    case cbxCurrency.ItemIndex of
      -1:
      begin
        pnlCurrencyCaption.Font.Color := clYellow;
        pnlCurrencyCaption.Font.Style := [fsBold];
        tabCurrency.Tabs.Text := AnsiReplaceStr(cbxCurrency.Hint, separ, sLineBreak);
      end;
      0: // selected all currencies
      begin
        f_currency :=
          'AND acc_currency IN (SELECT cur_code FROM currencies WHERE cur_status = 0) ';
        pnlCurrency.Hint := '';
        pnlCurrency.Color := clDefault;
        pnlCurrencyCaption.Font.Style := [];
        pnlCurrencyCaption.Font.Color := clWhite;
        if cbxCurrency.Items.Count > 1 then
          for I := 1 to cbxCurrency.Items.Count - 1 do
            tabCurrency.Tabs.Add(Field(separ_1, cbxCurrency.Items[I], 1));

      end
      else // selected one currency
      begin
        cbxCurrency.Hint := Field(separ_1, cbxCurrency.Items[cbxCurrency.ItemIndex], 1);
        f_currency := 'AND acc_currency = "' +
          AnsiReplaceStr(cbxCurrency.Hint, '"', '""') + '" ';
        pnlCurrencyCaption.Font.Color := clYellow;
        pnlCurrencyCaption.Font.Style := [fsBold];
        pnlCurrency.Hint := separ_1 + Field(separ_1,
          cbxCurrency.Items[cbxCurrency.ItemIndex], 1);
        tabCurrency.Tabs.Add(Field(separ_1,
          cbxCurrency.Items[cbxCurrency.ItemIndex], 1));
      end;
    end;
  finally
    frmMain.QRY.Close;
  end;

  // =============================================================
  // update list of accounts in the filter
  try
    cbxAccount.Clear;
    slAcc := TStringList.Create;
    frmMain.QRY.SQL.Text :=
      'SELECT acc_name, acc_currency ' + sLineBreak + // select
      'FROM currencies ' + sLineBreak + // from
      'LEFT JOIN accounts ON (acc_currency = cur_code) ' + sLineBreak + // left join
      'WHERE acc_status = 0 ' + sLineBreak + // where
      'AND cur_status = 0 ';


    case cbxCurrency.ItemIndex of
      -1: frmMain.QRY.SQL.Text := frmMain.QRY.SQL.Text + 'AND acc_currency IN ("' +
          AnsiReplaceStr(AnsiReplaceStr(cbxCurrency.Hint, '"', '""'),
          separ, '","') + '") ';
      0: cbxCurrency.Hint := '';
      else
      begin
        frmMain.QRY.SQL.Text :=
          frmMain.QRY.SQL.Text + 'AND acc_currency = "' + AnsiReplaceStr(
          Field(separ_1, cbxCurrency.Items[cbxCurrency.ItemIndex], 1), '"', '""') + '" ';
        cbxCurrency.Hint := Field(separ_1, cbxCurrency.Items[cbxCurrency.ItemIndex], 1);
      end;
    end;
    frmMain.QRY.Open;

    // =============================================================
    while not (frmMain.QRY.EOF) do
    begin
      slAcc.Add(
        frmMain.QRY.Fields[0].AsString + separ_1 + // acc_name
        frmMain.QRY.Fields[1].AsString); // acc_currency
      frmMain.QRY.Next;
    end;
    frmMain.QRY.Close;
    slAcc.Sort;
    cbxAccount.Items := slAcc;
    slAcc.Free;

    cbxAccount.Items.Insert(0, '*');
    cbxAccount.ItemIndex := 0;
    f_account := 'AND acc_status = 0 ';
    pnlAccount.Hint := '';
    cbxAccount.Hint := '';
    pnlAccount.Color := clDefault;
    pnlAccountCaption.Font.Style := [];
    pnlAccountCaption.Font.Color := clWhite;

    // find main currency
    tabCurrency.Visible := tabCurrency.Tabs.Count > 0;
    if tabCurrency.Tabs.Count > 0 then
      tabCurrency.Tabs.IndexOf(GetMainCurrency);
  finally;
    frmMain.QRY.Close;
  end;

  // =============================================================================================
  // update transactions;
  UpdateTransactions;
end;

procedure TfrmMain.cbxMonthChange(Sender: TObject);
begin
  if Conn.Connected = False then
  begin
    f_date := '';
    pnlDate.Hint := '';
    Exit;
  end;

  btnYearPlus.Enabled := cbxYear.ItemIndex > 0;
  btnMonthMinus.Enabled := cbxMonth.ItemIndex > 0;
  btnYearMinus.Enabled := cbxYear.ItemIndex < cbxYear.Items.Count - 1;
  btnMonthPlus.Enabled := cbxMonth.ItemIndex < cbxMonth.Items.Count - 1;

  if cbxYear.ItemIndex = 0 then
  begin
    if cbxMonth.ItemIndex = 0 then
    begin
      f_date := '';
      pnlDate.Hint := '';
      pnlDate.Color := clDefault;
      pnlDateCaption.Font.Color := clWhite;
      pnlDateCaption.Font.Style := [];
    end
    else
    begin
      pnlDateCaption.Font.Style := [fsBold];
      pnlDateCaption.Font.Color := clYellow;
      f_date := 'AND StrfTime("%m", d_date) = "' +
        RightStr('0' + IntToStr(cbxMonth.ItemIndex), 2) + '" ';
      pnlDate.Hint := separ_1 + cbxMonth.Items[cbxMonth.ItemIndex] + ' *';
    end;
  end
  else
  if cbxMonth.ItemIndex = 0 then
  begin
    pnlDateCaption.Font.Style := [fsBold];
    pnlDateCaption.Font.Color := clYellow;
    f_date := 'AND StrfTime("%Y", d_date) = "' + cbxYear.Items[cbxYear.ItemIndex] + '" ';
    pnlDate.Hint := ' | * ' + cbxYear.Items[cbxYear.ItemIndex];
  end
  else
  begin
    pnlDateCaption.Font.Style := [fsBold];
    pnlDateCaption.Font.Color := clYellow;
    f_date := 'AND d_date LIKE "' + cbxYear.Items[cbxYear.ItemIndex] +
      '-' + RightStr('0' + IntToStr(cbxMonth.ItemIndex), 2) + '-%" ';
    pnlDate.Hint := separ_1 + cbxMonth.Items[cbxMonth.ItemIndex] +
      ' ' + cbxYear.Items[cbxYear.ItemIndex];
  end;

  UpdateTransactions;
end;

procedure TfrmMain.cbxPayeeChange(Sender: TObject);
begin
  if Conn.Connected = False then
    Exit;

  case cbxPayee.ItemIndex of
    -1:
    begin
      pnlPayeeCaption.Font.Color := clYellow;
      pnlPayeeCaption.Font.Style := [fsBold];
    end;
    0:
    begin
      f_Payee := 'AND pee_status = 0 ';
      pnlPayee.Hint := '';
      pnlPayee.Color := clDefault;
      pnlPayeeCaption.Font.Style := [];
      pnlPayeeCaption.Font.Color := clWhite;
      cbxPayee.Hint := '';
    end
    else
    begin
      f_Payee := 'AND pee_name = "' + AnsiReplaceStr(
        cbxPayee.Items[cbxPayee.ItemIndex], '"', '""') + '" ';
      pnlPayee.Hint := separ_1 + cbxPayee.Items[cbxPayee.ItemIndex];
      pnlPayeeCaption.Font.Color := clYellow;
      pnlPayeeCaption.Font.Style := [fsBold];
      cbxPayee.Hint := cbxPayee.Items[cbxPayee.ItemIndex];
    end;
  end;

  UpdateTransactions;
end;

procedure TfrmMain.FormResize(Sender: TObject);
begin
  imgWidth.ImageIndex := 0;
  lblWidth.Caption := IntToStr((Sender as TForm).Width);

  imgHeight.ImageIndex := 1;
  lblHeight.Caption := IntToStr((Sender as TForm).Height);

  splFilter.Repaint;
  splSummary.Repaint;

  pnlListCaption.Repaint;
  pnlSummaryCaption.Repaint;
  pnlFilterCaption.Repaint;
  pnlReportCaption.Repaint;
end;

procedure TfrmMain.pnlAccountCaptionClick(Sender: TObject);
begin
  pnlAccountCaption.Tag := 1 - pnlAccountCaption.Tag;
  cbxAccount.Visible := pnlAccountCaption.Tag = 1;
  btnAccount.Visible := pnlAccountCaption.Tag = 1;
  imgArrows.GetBitmap(pnlAccountCaption.Tag, imgAccount.Picture.Bitmap);
end;

procedure TfrmMain.pnlAmountCaptionClick(Sender: TObject);
begin
  pnlAmountCaption.Tag := 1 - pnlAmountCaption.Tag;
  pnlMax.Visible := pnlAmountCaption.Tag = 1;
  pnlMin.Visible := pnlAmountCaption.Tag = 1;
  pnlMin.Top := 0;
  pnlAmountCaption.Top := 0;
  imgArrows.GetBitmap(pnlAmountCaption.Tag, imgAmount.Picture.Bitmap);
end;

procedure TfrmMain.pnlCategoryCaptionClick(Sender: TObject);
begin
  pnlCategoryCaption.Tag := 1 - pnlCategoryCaption.Tag;
  cbxCategory.Visible := pnlCategoryCaption.Tag = 1;
  btnCategory.Visible := pnlCategoryCaption.Tag = 1;
  cbxSubcategory.Visible := pnlCategoryCaption.Tag = 1;
  btnSubcategory.Visible := pnlCategoryCaption.Tag = 1;

  imgArrows.GetBitmap(pnlCategoryCaption.Tag, imgCategory.Picture.Bitmap);
end;

procedure TfrmMain.pnlCommentCaptionClick(Sender: TObject);
begin
  pnlCommentCaption.Tag := 1 - pnlCommentCaption.Tag;
  cbxComment.Visible := pnlCommentCaption.Tag = 1;
  ediComment.Visible := pnlCommentCaption.Tag = 1;
  cbxComment.Top := 0;
  pnlCommentCaption.Top := 0;
  imgArrows.GetBitmap(pnlCommentCaption.Tag, imgComment.Picture.Bitmap);
end;

procedure TfrmMain.pnlCurrencyCaptionClick(Sender: TObject);
begin
  pnlCurrencyCaption.Tag := 1 - pnlCurrencyCaption.Tag;
  cbxCurrency.Visible := pnlCurrencyCaption.Tag = 1;
  btnCurrency.Visible := pnlCurrencyCaption.Tag = 1;
  imgArrows.GetBitmap(pnlCurrencyCaption.Tag, imgCurrency.Picture.Bitmap);
end;

procedure TfrmMain.pnlPeriodCaptionClick(Sender: TObject);
begin
  if (pnlDayCaption.Tag = 1) then
  begin
    pnlDayCaption.Tag := 0;
    Calendar.Visible := False;
    imgArrows.GetBitmap(pnlDayCaption.Tag + 2, imgDay.Picture.Bitmap);
  end;

  if (pnlMonthYearCaption.Tag = 1) then
  begin
    pnlMonthYearCaption.Tag := 0;
    pnlMonthYearClient.Visible := False;
    imgArrows.GetBitmap(pnlMonthYearCaption.Tag + 2, imgMonthYear.Picture.Bitmap);
  end;

  pnlPeriodCaption.Tag := 1 - pnlPeriodCaption.Tag;

  gbxDateFrom.Visible := pnlPeriodCaption.Tag = 1;
  gbxDateTo.Visible := pnlPeriodCaption.Tag = 1;

  gbxDateTo.top := 0;
  gbxDateFrom.Top := 0;
  pnlPeriodCaption.Top := 0;

  imgArrows.GetBitmap(pnlPeriodCaption.Tag + 2, imgPeriod.Picture.Bitmap);

  if (pnlPeriodCaption.Tag = 1) then
  begin
    pnlDateCaption.Font.Bold := True;
    pnlDateCaption.Font.Color := clYellow;
  end
  else
  begin
    pnlDateCaption.Font.Bold := False;
    pnlDateCaption.Font.Color := clWhite;
  end;

  datDateFromChange(datDateFrom);
end;

procedure TfrmMain.pnlMonthYearCaptionClick(Sender: TObject);
begin
  if (pnlDayCaption.Tag = 1) then
  begin
    pnlDayCaption.Tag := 0;
    Calendar.Visible := False;
    imgArrows.GetBitmap(pnlDayCaption.Tag + 2, imgDay.Picture.Bitmap);
  end;

  if (pnlPeriodCaption.Tag = 1) then
  begin
    pnlPeriodCaption.Tag := 0;
    gbxDateFrom.Visible := False;
    gbxDateTo.Visible := False;
    imgArrows.GetBitmap(pnlPeriodCaption.Tag + 2, imgPeriod.Picture.Bitmap);
  end;

  pnlMonthYearCaption.Tag := 1 - pnlMonthYearCaption.Tag;

  pnlMonthYearClient.Visible := pnlMonthYearCaption.Tag = 1;
  //If pnlMonthYearClient.Visible = true then
  //  pnlMonthYearCaption.Top := 0;

  imgArrows.GetBitmap(pnlMonthYearCaption.Tag + 2, imgMonthYear.Picture.Bitmap);

  if (cbxMonth.ItemIndex > 0) or (cbxYear.ItemIndex > 0) then
  begin
    pnlDateCaption.Font.Bold := True;
    pnlDateCaption.Font.Color := clYellow;
  end
  else
  begin
    pnlDateCaption.Font.Bold := False;
    pnlDateCaption.Font.Color := clWhite;
  end;

  cbxMonthChange(cbxMonth);
end;

procedure TfrmMain.pnlDateCaptionClick(Sender: TObject);
begin
  pnlDateCaption.Tag := 1 - pnlDateCaption.Tag;

  //  if (pnlDayCaption.Tag = 1) or (cbxMonth.ItemIndex > 0) or
  //    (cbxYear.ItemIndex > 0) or (pnlPeriodCaption.Tag = 1) then
  if f_date <> '' then
  begin
    pnlDateCaption.Font.Bold := True;
    pnlDateCaption.Font.Color := clYellow;
  end
  else
  begin
    pnlDateCaption.Font.Bold := False;
    pnlDateCaption.Font.Color := clWhite;
  end;

  // Day
  pnlDayCaption.Visible := pnlDateCaption.Tag = 1;
  pnlDay.Visible := pnlDateCaption.Tag = 1;
  Calendar.Visible := pnlDayCaption.Tag = 1;
  pnlDayCaption.Top := 0;

  // MonthYear
  pnlMonthYearCaption.Visible := pnlDateCaption.Tag = 1;
  pnlMonthYearClient.Visible := pnlMonthYearCaption.Tag = 1;
  pnlMonthYear.Visible := pnlDateCaption.Tag = 1;
  gbxMonth.Top := 0;
  pnlMonthYearCaption.top := 0;

  // Period
  pnlPeriodCaption.Visible := pnlDateCaption.Tag = 1;
  pnlPeriod.Visible := pnlDateCaption.Tag = 1;

  // Arrow
  imgArrows.GetBitmap(pnlDateCaption.Tag, imgDate.Picture.Bitmap);

  pnlMonthYear.Top := 0;
  pnlDay.Top := 0;
  pnlDateCaption.Top := 0;
end;

procedure TfrmMain.pnlDayCaptionClick(Sender: TObject);
begin
  if (pnlMonthYearCaption.Tag = 1) then
  begin
    pnlMonthYearCaption.Tag := 0;
    pnlMonthYearClient.Visible := False;
    imgArrows.GetBitmap(pnlMonthYearCaption.Tag + 2, imgMonthYear.Picture.Bitmap);
  end;

  if (pnlPeriodCaption.Tag = 1) then
  begin
    pnlPeriodCaption.Tag := 0;
    gbxDateFrom.Visible := False;
    gbxDateTo.Visible := False;
    imgArrows.GetBitmap(pnlPeriodCaption.Tag + 2, imgPeriod.Picture.Bitmap);
  end;

  pnlDayCaption.Tag := 1 - pnlDayCaption.Tag;
  Calendar.Visible := pnlDayCaption.Tag = 1;

  if (Calendar.Visible = True) and (pnlFilter.Enabled = True) and
    (frmMain.Visible = True) then
    Calendar.SetFocus;
  pnlDateCaption.Top := 0;

  imgArrows.GetBitmap(pnlDayCaption.Tag + 2, imgDay.Picture.Bitmap);

  if (pnlDayCaption.Tag = 1) then
  begin
    pnlDateCaption.Font.Bold := True;
    pnlDateCaption.Font.Color := clYellow;
  end
  else
  begin
    pnlDateCaption.Font.Bold := False;
    pnlDateCaption.Font.Color := clWhite;
  end;
  CalendarDateChange(Calendar);
end;

procedure TfrmMain.pnlPayeeCaptionClick(Sender: TObject);
begin
  pnlPayeeCaption.Tag := 1 - pnlPayeeCaption.Tag;
  cbxPayee.Visible := pnlPayeeCaption.Tag = 1;
  btnPayee.Visible := pnlPayeeCaption.Tag = 1;
  imgArrows.GetBitmap(pnlPayeeCaption.Tag, imgPayee.Picture.Bitmap);
end;

procedure TfrmMain.pnlPersonCaptionClick(Sender: TObject);
begin
  pnlPersonCaption.Tag := 1 - pnlPersonCaption.Tag;
  cbxPerson.Visible := pnlPersonCaption.Tag = 1;
  btnPerson.Visible := pnlPersonCaption.Tag = 1;
  imgArrows.GetBitmap(pnlPersonCaption.Tag, imgPerson.Picture.Bitmap);
end;

procedure TfrmMain.pnlTagCaptionClick(Sender: TObject);
begin
  pnlTagCaption.Tag := 1 - pnlTagCaption.Tag;
  cbxTag.Visible := pnlTagCaption.Tag = 1;
  btnTag.Visible := pnlTagCaption.Tag = 1;
  imgArrows.GetBitmap(pnlTagCaption.Tag, imgTag.Picture.Bitmap);
end;

procedure TfrmMain.pnlTypeCaptionClick(Sender: TObject);
begin
  pnlTypeCaption.Tag := 1 - pnlTypeCaption.Tag;
  cbxType.Visible := pnlTypeCaption.Tag = 1;
  btnType.Visible := pnlTypeCaption.Tag = 1;
  imgType.ImageIndex := pnlTypeCaption.Tag;
end;

procedure TfrmMain.mnuCalcClick(Sender: TObject);
var
  AProcess: TProcess;
begin
  AProcess := TProcess.Create(nil);

  {$IFDEF WINDOWS}
  aProcess.Executable := 'calc.exe';
  aProcess.Options := aProcess.Options - [poWaitOnExit];
  AProcess.Execute;
  {$ENDIF}

  {$IFDEF LINUX}
  AProcess.Executable := FindDefaultExecutablePath('gnome-calculator');
  if Length(AProcess.Executable) = 0 then
    AProcess.Executable := FindDefaultExecutablePath('galculator');
  AProcess.Execute;
  {$ENDIF}

  AProcess.Free;
end;

procedure TfrmMain.mnuCashCounterClick(Sender: TObject);
begin
  frmCounter.ShowModal;
end;

procedure TfrmMain.btnHistoryClick(Sender: TObject);
begin
  if (Conn.Connected = False) or (pnlReport.Visible = True) or
    (btnHistory.Enabled = False) then
    Exit;

  frmHistory.ShowModal;
  VST.SetFocus;
end;

procedure TfrmMain.mnuWriteClick(Sender: TObject);
begin
  frmWrite.ShowModal;
end;

procedure TfrmMain.mnuPropertiesClick(Sender: TObject);
begin
  frmProperties.ShowModal;
end;

procedure TfrmMain.mnuRecycleClick(Sender: TObject);
begin
  frmRecycleBin.ShowModal;
end;

procedure TfrmMain.mnuReportsClick(Sender: TObject);
begin
  if btnReports.Flat = True then
  begin
    pnlClient.Visible := False;
    pnlReport.Visible := True;
    btnReports.Flat := False;
    mnuReports.Checked := True;
    VSTSummaries.Top := 1;
    VSTSummaries.Visible := False;
    VSTSummaries.Parent := pnlReport;
    case tabReports.TabIndex of
      0: tabBalanceHeaderChange(tabBalanceHeader);
      1: tabChronoHeaderChange(tabChrono);
      2: tabCrossTopChange(tabCrossTop);
    end;
    Exit;
  end;
  btnReportExitClick(btnReportExit);
end;

procedure TfrmMain.mnuSQLClick(Sender: TObject);
begin
  frmSQL.ShowModal;
end;

procedure TfrmMain.pnlButtonsResize(Sender: TObject);
begin
  btnAdd.Width := (pnlButtons.Width - 20) div 8;
  btnDuplicate.Width := btnAdd.Width;
  btnEdit.Width := btnAdd.Width;
  btnDelete.Width := btnAdd.Width;
  btnCopy.Width := btnAdd.Width;
  btnSelect.Width := btnAdd.Width;
  btnPrint.Width := btnAdd.Width;
  pnlButtons.Repaint;
end;

procedure TfrmMain.popFilterExpandClick(Sender: TObject);
var
  I: cardinal;
begin
  scrFilter.Visible := False; // due flickering of the components

  if Sender.ClassType = TAction then
    I := (Sender as TAction).Tag
  else
    I := (Sender as TMenuItem).Tag;

  // Type
  pnlTypeCaption.Tag := I;
  pnlTypeCaptionClick(pnlTypeCaption);
  // Date
  if pnlDayCaption.Tag = 1 then
  begin
    pnlDayCaption.Tag := I;
    pnlDateCaptionClick(pnlDayCaption);
  end
  else if pnlPeriodCaption.Tag = 1 then
  begin
    pnlPeriodCaption.Tag := I;
    pnlPeriodCaptionClick(pnlPeriodCaption);
  end
  else
  begin
    pnlMonthYearCaption.Tag := I;
    pnlMonthYearCaptionClick(pnlMonthYearCaption);
  end;
  pnlDateCaption.Tag := I;
  pnlDateCaptionClick(pnlDateCaption);
  pnlMonthYear.Top := 0;
  pnlDay.Top := 0;
  pnlDateCaption.Top := 0;

  // Currency
  pnlCurrencyCaption.Tag := I;
  pnlCurrencyCaptionClick(pnlCurrencyCaption);
  // Account
  pnlAccountCaption.Tag := I;
  pnlAccountCaptionClick(pnlAccountCaption);
  // Comment
  pnlCommentCaption.Tag := I;
  pnlCommentCaptionClick(pnlCommentCaption);
  // Amount
  pnlAmountCaption.Tag := I;
  pnlAmountCaptionClick(pnlAmountCaption);
  // Category
  pnlCategoryCaption.Tag := I;
  pnlCategoryCaptionClick(pnlCategoryCaption);
  // Person
  pnlPersonCaption.Tag := I;
  pnlPersonCaptionClick(pnlPersonCaption);
  // Payee
  pnlPayeeCaption.Tag := I;
  pnlPayeeCaptionClick(pnlPayeeCaption);
  // Tag
  pnlTagCaption.Tag := I;
  pnlTagCaptionClick(pnlTagCaption);

  scrFilter.Visible := True; // end of flickering
end;

procedure TfrmMain.ReportGetValue(const ParName: string; var ParValue: variant);
var
  X: double;
  Transactions: PTransactions;
  Person: PPerson;
  Category: PCategory;
  Summary: PSummary;
  Account: PAccount;
  Comment: PComment;
  Payee: PPayee;
  currency: PCurrency;
  Tagg: PTagg;
  Holiday: PHoliday;
  Link: PLink;
  Balance: PBalance;
begin

  try
    // set font name and size
    if ParName = 'FontNameX' then
      ParValue := frmSettings.cbxReportFont.Items[frmSettings.cbxReportFont.ItemIndex];
    if ParName = 'FontSizeX' then
      ParValue := frmSettings.spiReportSize.Value;

    // common properties
    case Report.Tag of
      1: begin
        if ParName = 'traDate' then
        begin
          Transactions := VST.GetNodeData(ReportNode);
          ParValue := DateToStr(StrToDate(Transactions.Date, 'YYYY-MM-DD', '-'));
        end;

        if ParName = 'traAmount' then
        begin
          Transactions := VST.GetNodeData(ReportNode);
          ParValue := Format('%n', [Transactions.Amount], FS_own);
        end;

        if ParName = 'traCurrency' then
        begin
          Transactions := VST.GetNodeData(ReportNode);
          ParValue := Transactions.currency;
        end;

        if ParName = 'traComment' then
        begin
          Transactions := VST.GetNodeData(ReportNode);
          ParValue := Transactions.Comment;
        end;

        if ParName = 'traAccount' then
        begin
          Transactions := VST.GetNodeData(ReportNode);
          ParValue := Transactions.Account;
        end;

        if ParName = 'traCategory' then
        begin
          Transactions := VST.GetNodeData(ReportNode);
          ParValue := AnsiUpperCase(Transactions.Category) +
            IfThen(Length(Transactions.SubCategory) = 0, '', separ_1 +
            Transactions.SubCategory);
        end;

        if ParName = 'traPerson' then
        begin
          Transactions := VST.GetNodeData(ReportNode);
          ParValue := Transactions.Person;
        end;

        if ParName = 'traPayee' then
        begin
          Transactions := VST.GetNodeData(ReportNode);
          ParValue := Transactions.Payee;
        end;

        if ParName = 'traID' then
        begin
          Transactions := VST.GetNodeData(ReportNode);
          ParValue := Transactions.ID;
        end;

        // =============================================================================================
        // REPORT SUMMARY AND CHRONOLOGY

        if ParName = 'sumAccount' then
        begin
          Summary := VSTSummary.GetNodeData(ReportNode);
          ParValue := Summary.Account;
        end;

        if ParName = 'sumStart' then
        begin
          Summary := VSTSummary.GetNodeData(ReportNode);
          ParValue := Format('%n', [Summary.AccountAmount + Summary.StartSum], FS_own);
        end;

        if ParName = 'sumCredit' then
        begin
          Summary := VSTSummary.GetNodeData(ReportNode);
          ParValue := Format('%n', [Summary.Credit], FS_own);
        end;

        if ParName = 'sumDebit' then
        begin
          Summary := VSTSummary.GetNodeData(ReportNode);
          ParValue := Format('%n', [Summary.Debit], FS_own);
        end;

        if ParName = 'sumTraPlus' then
        begin
          Summary := VSTSummary.GetNodeData(ReportNode);
          ParValue := Format('%n', [Summary.TransferP], FS_own);
        end;

        if ParName = 'sumTraMinus' then
        begin
          Summary := VSTSummary.GetNodeData(ReportNode);
          ParValue := Format('%n', [Summary.TransferM], FS_own);
        end;

        if ParName = 'sumBalance' then
        begin
          Summary := VSTSummary.GetNodeData(ReportNode);
          ParValue := Format('%n', [Summary.Credit + Summary.Debit +
            Summary.TransferP + Summary.TransferM], FS_own);
        end;

        if ParName = 'sumTotal' then
        begin
          Summary := VSTSummary.GetNodeData(ReportNode);
          ParValue := Format('%n', [Summary.AccountAmount + Summary.StartSum +
            Summary.Credit + Summary.Debit + Summary.TransferP +
            Summary.TransferM], FS_own);
        end;
        exit;
      end;
      2:
      begin
        // =============================================================================================
        // REPORT BALANCE AND CROSS TABLES
        if tabReports.TabIndex = 0 then
          Balance := VSTBalance.GetNodeData(ReportNode)
        else
          Balance := VSTCross.GetNodeData(ReportNode);

        if ParName = 'Name' then
        begin
          if tabReports.TabIndex = 0 then
            ParValue := Balance.Name1 + IfThen(Balance.Name2 = '',
              '', separ_1 + IfThen((tabBalanceHeader.TabIndex = 2) and
              (frmSettings.chkDisplaySubCatCapital.Checked = True),
              AnsiUpperCase(Balance.Name2), Balance.Name2))
          else if tabReports.TabIndex = 2 then
            if (tabCrossLeft.TabIndex in [3, 5, 6]) and
              (VSTCross.GetNodeLevel(ReportNode) = 1) then
              ParValue := Balance.Name1
            else if (tabCrossTop.TabIndex = 2) and (tabCrossLeft.TabIndex = 4) then
              ParValue := IfThen(VSTCross.GetNodeLevel(ReportNode) =
                0, Balance.Name1, Balance.Name2)
            else if (tabCrossLeft.TabIndex = 4) and
              (VSTCross.GetNodeLevel(ReportNode) = 1) then
              ParValue := Balance.Name1 + separ_1 + IfThen(
                frmSettings.chkDisplaySubCatCapital.Checked = True,
                AnsiUpperCase(Balance.Name2), Balance.Name2)
            else
              ParValue := Balance.Name1 + IfThen(Balance.Name2 = '',
                '', separ_1 + Balance.Name2);
        end;

        if ParName = 'Credits' then
        begin
          ParValue := Format('%n', [Balance.Credit], FS_own);
        end;

        if ParName = 'Debits' then
        begin
          ParValue := Format('%n', [Balance.Debit], FS_own);
        end;

        if ParName = 'Pluses' then
        begin
          ParValue := Format('%n', [Balance.TransferP], FS_own);
        end;

        if ParName = 'Minuses' then
        begin
          ParValue := Format('%n', [Balance.TransferM], FS_own);
        end;

        if ParName = 'Balance' then
        begin
          ParValue := Format('%n', [Balance.Credit + Balance.Debit +
            Balance.TransferP + Balance.TransferM], FS_own);
        end;

        if ParName = 'Level' then
        begin
          if (tabReports.TabIndex = 2) and (tabCrossLeft.TabIndex > 0) then
            ParValue := VSTCross.GetNodeLevel(ReportNode)
          else
            ParValue := 1;
        end;
        exit;
      end;
    end;

    // =============================================================================================
    // PERSONS
    if Report.Tag = 10 then
    begin
      Person := frmPersons.VST.GetNodeData(ReportNode);
      if ParName = 'perName' then
        ParValue := Person.Name;
      if ParName = 'perComment' then
        ParValue := Person.Comment;
      if ParName = 'perStatus' then
        ParValue := frmPersons.cbxStatus.Items[Person.Status];
      if ParName = 'perID' then
        ParValue := Person.ID;
    end;

    // =============================================================================================
    // CATEGORIES
    if Report.Tag = 11 then
    begin
      Category := frmCategories.VST.GetNodeData(ReportNode);
      if ParName = 'catName' then
        ParValue := IfThen(Category.Parent_ID = 0, Category.Name, '   ' + Category.Name);
      if ParName = 'catComment' then
        ParValue := Category.Comment;
      if ParName = 'catStatus' then
        ParValue := frmCategories.cbxStatus.Items[Category.Status];
      if ParName = 'catID' then
        ParValue := Category.ID;
      if ParName = 'catParentID' then
        ParValue := Category.Parent_ID;
    end;

    // =============================================================================================
    // ACCOUNTS
    if Report.Tag = 12 then
    begin
      Account := frmAccounts.VST.GetNodeData(ReportNode);
      if ParName = 'accName' then
        ParValue := Account.Name + ' (' + Account.currency + ')';
      if ParName = 'accAmount' then
        ParValue := Format('%n', [Account.Amount], FS_own);
      if ParName = 'accDate' then
        ParValue := DateToStr(StrToDate(Account.Date, 'YYYY-MM-DD', '-'));
      if ParName = 'accComment' then
        ParValue := Account.Comment;
      if ParName = 'accStatus' then
        ParValue := frmAccounts.cbxStatus.Items[Account.Status];
      if ParName = 'accID' then
        ParValue := Account.ID;
    end;

    // =============================================================================================
    // COMMENTS
    if Report.Tag = 13 then
    begin
      Comment := frmComments.VST.GetNodeData(ReportNode);
      if ParName = 'comComment' then
        ParValue := Comment.Text;
      if ParName = 'comID' then
        ParValue := Comment.ID;
    end;

    // =============================================================================================
    // PAYEES
    if Report.Tag = 14 then
    begin
      Payee := frmPayees.VST.GetNodeData(ReportNode);
      if ParName = 'payName' then
        ParValue := Payee.Name;
      if ParName = 'payComment' then
        ParValue := Payee.Comment;
      if ParName = 'payStatus' then
        ParValue := frmPayees.cbxStatus.Items[Payee.Status];
      if ParName = 'payID' then
        ParValue := Payee.ID;
    end;

    // =============================================================================================
    // CURRENCIES
    if Report.Tag = 15 then
    begin
      currency := frmCurrencies.VST.GetNodeData(ReportNode);
      if ParName = 'curCode' then
        ParValue := currency.Code;
      if ParName = 'curName' then
        ParValue := currency.Name;
      if ParName = 'curDefault' then
        ParValue := Abs(StrToInt(BoolToStr(currency.Default)));
      if ParName = 'curRate' then
        ParValue := currency.Rate;
      if ParName = 'curStatus' then
        ParValue := frmCurrencies.cbxStatus.Items[currency.Status];
      if ParName = 'curID' then
        ParValue := currency.ID;
    end;

    // =============================================================================================
    // TAGS
    if Report.Tag = 16 then
    begin
      Tagg := frmTags.VST.GetNodeData(ReportNode);
      if ParName = 'tagName' then
        ParValue := Tagg.Name;
      if ParName = 'tagComment' then
        ParValue := Tagg.Comment;
      if ParName = 'tagID' then
        ParValue := Tagg.ID;
    end;

    // =============================================================================================
    // HOLIDAYS
    if Report.Tag = 17 then
    begin
      Holiday := frmHolidays.VST.GetNodeData(ReportNode);
      if ParName = 'holDate' then
        ParValue := IntToStr(Holiday.Day) + '. ' +
          DefaultFormatSettings.LongMonthNames[Holiday.Month];
      if ParName = 'holName' then
        ParValue := Holiday.Name;
      if ParName = 'holID' then
        ParValue := Holiday.ID;
    end;

    // =============================================================================================
    // LINKS
    if Report.Tag = 18 then
    begin
      Link := frmLinks.VST.GetNodeData(ReportNode);
      if ParName = 'linName' then
        ParValue := Link.Name;
      if ParName = 'linLink' then
        ParValue := Link.Link;
      if ParName = 'linShortcut' then
        ParValue := Link.ShortCut;
      if ParName = 'linComment' then
        ParValue := Link.Comment;
      if ParName = 'linID' then
        ParValue := Link.ID;
    end;

    // =============================================================================================
    // CASH COUNTER
    if Report.Tag = 20 then

    begin
      if ParName = 'casNominal' then
      begin
        TryStrToFloat(Field(separ, slCounter.Strings[ReportNodesCount], 1), X);
        ParValue := Format('%n', [X], FS_own);
      end;

      if ParName = 'casCount' then
        ParValue := Field(separ, slCounter.Strings[ReportNodesCount], 2);

      if ParName = 'casSum' then
      begin
        TryStrToFloat(Field(separ, slCounter.Strings[ReportNodesCount], 3), X);
        ParValue := Format('%n', [X], FS_own);
      end;

      if ParName = 'casCurrency' then
        ParValue := Field(separ_1, frmCounter.cbxCurrency.Items[
          frmCounter.cbxCurrency.ItemIndex], 1);
    end;
  except
  end;
end;

procedure TfrmMain.mnuAboutClick(Sender: TObject);
begin
  frmAbout.ShowModal;
end;

procedure TfrmMain.mnuAccountsClick(Sender: TObject);
begin
  frmAccounts.ShowModal;
end;

procedure TfrmMain.mnuCategoriesClick(Sender: TObject);
begin
  frmCategories.ShowModal;
end;

procedure OpenFileX(FileName: string);
var
  Temp, T1, T2: string;
  s1, s2: TStringStream;
  bf: TBlowfishDecryptStream;
  ExistsCorruptedRecord: boolean;
  I: integer;
  slTemp: TStringList;
  D: double;
begin
  try
    // check zero size of the database
    if FileExists(FileName) then
      if FileSize(FileName) = 0 then
      begin
        ShowMessage(AnsiUpperCase(Filename) + sLineBreak + sLineBreak +
          AnsiReplaceStr(Error_11, '%', sLineBreak));
        Exit;
      end;

    // FILE DECRYPTION
    frmGate.ediGate.Clear;
    s1 := TStringStream.Create(''); //used as your source string
    s1.LoadFromFile(FileName);
    if LeftStr(s1.DataString, 6) <> 'SQLite' then
    begin
      frmGate.lblFileName2.Caption := FileName;
      if frmGate.ShowModal <> mrOk then
        Exit;

      s2 := TStringStream.Create('');  //make sure destination stream is blank
      bf := TBlowfishDecryptStream.Create(ReverseString(frmGate.ediGate.Text) +
        frmGate.ediGate.Text, s1);
      //reads from source stream
      s2.copyfrom(bf, s1.size);
      if LeftStr(s2.DataString, 6) <> 'SQLite' then
      begin
        ShowMessage(Error_21);
        bf.Free;
        s2.Free;
        s1.Free;
        Exit;
      end;

      s2.savetofile(FileName);
      bf.Free;
      s2.Free;
      frmProperties.lblEncryptionProtection.Tag := 1; // yes (protected by encryption)
    end
    else
     frmProperties.lblEncryptionProtection.Tag := 0; // no (protected by encryption)
  except
    Exit;
  end;

  // Create connectivity
  frmMain.conn.DatabaseName := FileName;
  try
    frmMain.conn.Open;

    if frmMain.conn.Connected = False then
    begin
      ShowMessage(Error_02 + sLineBreak + FileName);
      Exit;
    end;

    // check database version
    try
      // database check integrity
      frmMain.QRY.SQL.Text := 'PRAGMA integrity_check';
      frmMain.QRY.Open;
      Temp := frmMain.QRY.Fields[0].AsString;
      frmMain.QRY.Close;

      if Temp <> 'ok' then
      begin
        frmMain.QRY.SQL.Text := 'PRAGMA quick_check';
        frmMain.QRY.Open;
        Temp := frmMain.QRY.Fields[0].AsString;
        frmMain.QRY.Close;

        if frmMain.QRY.FieldCount > 0 then
          MessageDlg(AnsiReplaceStr(Error_11, '%', sLineBreak) +
            sLineBreak + sLineBreak + Temp,
            mtError, [mbOK], 0, mbOK);
        frmMain.Conn.Close(True);
        Exit;
      end;
    except
      ShowMessage(Error_18);
      frmMain.QRY.Close;
      frmMain.Conn.Close(True);
      Exit;
    end;

  except;
    begin
      frmMain.Conn.Close(True);
      MessageDlg(AnsiReplaceStr(Error_11, '%', sLineBreak) + sLineBreak +
        sLineBreak + FileName,
        mtError, [mbOK], 0, mbOK);
      Exit;
    end;
  end;

  try
    frmMain.QRY.SQL.Text :=
      'SELECT COUNT(*) AS CNTREC FROM pragma_table_info("settings") WHERE name="set_value"';
    frmMain.QRY.Open;
    if frmMain.QRY.Fields[0].AsInteger = 0 then
    begin
      ShowMessage(Error_18);
      frmMain.QRY.Close;
      frmMain.Conn.Close(True);
      Exit;
    end;
    frmMain.QRY.Close;

  except;
  end;

  // check version of database
  frmMain.QRY.SQL.Text :=
    'SELECT set_value FROM settings WHERE set_parameter = "program"';
  frmMain.QRY.Open;
  Temp := frmMain.QRY.Fields[0].AsString;
  frmMain.QRY.Close;

  if AnsiUpperCase(Temp) <> 'RQ3' then
  begin
    ShowMessage(Error_18);
    frmMain.Conn.Close(True);
    Exit;
  end;

  // check password
  frmMain.QRY.SQL.Text :=
    'SELECT set_value FROM settings WHERE set_parameter = "password"';
  frmMain.QRY.Open;
  Temp := XorDecode('5!9x4', frmMain.QRY.Fields[0].AsString);
  frmMain.QRY.Close;

  if Length(Temp) > 0 then
  begin
    if frmGate.ediGate.Text = '' then
      frmGate.ShowModal;
    if (Temp <> frmGate.ediGate.Text) then
    begin
      frmGate.ediGate.Clear;
      frmPassWord.Hint := '';
      frmMain.conn.Close();
      s1.savetofile(FileName);
      s1.Free;
      ShowMessage(Error_21);
      Exit;
    end;
    frmProperties.lblPasswordProtection.Tag := 1; // yes (protected by password)
  end
  else
  begin
    frmProperties.lblPasswordProtection.Tag := 0; // no password protection
    s1.Free;
  end;
  frmGate.ediGate.Clear;

  // DELETE EMPTY CATEGORIES IN SCHEDULER (IMPORTANT - THIS FIND OUT THE DUPLICITY OF OPENING DATABASES !!!)
  try
    frmMain.QRY.SQL.Text :=
      'DELETE FROM scheduler WHERE sch_category IS NULL OR LENGTH(TRIM(sch_category)) = 0;';
    frmMain.QRY.ExecSQL;
    frmMain.Tran.Commit;

  except
    on E: Exception do
    begin
      ShowMessage(AnsiReplaceStr(Error_32, '%', sLineBreak +
        AnsiUpperCase(FileName) + sLineBreak));
      frmMain.Tag := 1;
      frmMain.Conn.Close;
      Exit;
    end;
  end;

  // **************************************************************************
  // ========================================
  // BUG FIXES ERRORS IN DATABASE
  // ========================================
  // **************************************************************************

  // check version of database
  frmMain.QRY.SQL.Text :=
    'SELECT set_value FROM settings WHERE set_parameter = "version"';
  frmMain.QRY.Open;
  Temp := frmMain.QRY.Fields[0].AsString;
  frmMain.QRY.Close;

  // ==========
  // VERSION 01
  // ==========

  if Temp = '1' then
  begin
    frmMain.Tran.Commit;
    frmMain.Tran.StartTransaction;

    // ADD NEW COLUMN TO THE TABLE categories
    frmMain.QRY.SQL.Text :=
      'ALTER TABLE categories ADD cat_type INTEGER DEFAULT 0;';
    // type (0 = credit, 1 = debit, 2 = transfer, NULL = not specified)
    frmMain.QRY.ExecSQL;

    // CREATE TRIGGER AFTER UPDATE TYPE
    frmMain.QRY.SQL.Text := 'CREATE TRIGGER after_update_type ' +
      'AFTER UPDATE OF cat_type ON categories FOR EACH ROW BEGIN ' +     // after
      'UPDATE OR IGNORE categories SET cat_type = new.cat_type ' + // update
      'WHERE cat_parent_id = new.cat_id; END;'; // where
    frmMain.QRY.ExecSQL;

    // **************************************************************************
    // CREATE SORTING PARAMETERS ON DATABASE CLOSE
    frmMain.QRY.SQL.Text :=
      'INSERT OR IGNORE INTO settings (set_parameter, set_value) VALUES ' +
      // summary settings
      '("summary_sort_column", "1"),' + // sorting column for summary
      '("summary_sort_order", "0");'; // sorting order for summary
    frmMain.QRY.ExecSQL;

    // **************************************************************************
    // CREATE TABLE LINKS (INTERNET ADDRESSES)
    frmMain.QRY.SQL.Text :=
      'CREATE TABLE IF NOT EXISTS links (' +  // create table
      'lin_name TEXT, ' + //  name
      'lin_link TEXT UNIQUE, ' + // link
      'lin_shortcut TEXT, ' + // shortcut
      'lin_comment TEXT, ' + // comment
      'lin_id INTEGER PRIMARY KEY);'; // id
    frmMain.QRY.ExecSQL;

    // **************************************************************************
    // create table NOTES (internal comments)
    frmMain.QRY.SQL.Text :=
      'CREATE TABLE notes (' + // create table
      'not_name TEXT UNIQUE, ' + // name
      'not_text TEXT, ' + // text
      'not_id INTEGER PRIMARY KEY);';
    frmMain.QRY.ExecSQL;

    // **************************************************************************
    // DELETE WRONG TRIGGER AFTER DELETE BUDGET
    frmMain.QRY.SQL.Text := 'DROP TRIGGER after_delete_budgets;';
    frmMain.QRY.ExecSQL;

    // DELETE WRONG TRIGGER AFTER DELETE BUDGET_CATEGORIE
    frmMain.QRY.SQL.Text := 'DROP TRIGGER after_delete_budget_categories;';
    frmMain.QRY.ExecSQL;

    // CREATE TRIGGER AFTER DELETE BUDGET
    frmMain.QRY.SQL.Text := 'CREATE TRIGGER before_delete_budgets ' +
      'BEFORE DELETE ON budgets FOR EACH ROW BEGIN ' +     // 2
      'DELETE FROM budget_categories WHERE budcat_bud_id = old.bud_id;' +
      'DELETE FROM budget_periods WHERE budper_bud_id = old.bud_id; END;';
    frmMain.QRY.ExecSQL;

    // CREATE TRIGGER AFTER DELETE BUDGET_CATEGORIE
    frmMain.QRY.SQL.Text := 'CREATE TRIGGER before_delete_budget_categories ' +
      'BEFORE DELETE ON budget_categories FOR EACH ROW BEGIN ' +     // 2
      'DELETE FROM budget_periods ' + // delete
      'WHERE budper_cat_id = old.budcat_category ' + // where
      'AND budper_bud_id = old.budcat_bud_id; END;';
    frmMain.QRY.ExecSQL;

    // **************************************************************************
    // REPAIR EMPTY COMMENT_LOWER FIELD
    slTemp := TStringList.Create;
    frmMain.QRY.SQL.Text :=
      'SELECT d_comment FROM data WHERE ' + // select
      '(d_comment_lower IS NULL OR LENGTH(TRIM(d_comment_lower)) = 0) AND ' +
      // d_comment_lower
      '(NOT(d_comment is null) AND LENGTH(TRIM(d_comment)) > 0);';
    frmMain.QRY.Open;
    while not (frmMain.QRY.EOF) do
    begin
      slTemp.Add(frmMain.QRY.Fields[0].AsString);
      frmMain.QRY.Next;
    end;
    frmMain.QRY.Close;
    try
      if slTemp.Count > 0 then
      begin
        for I := 0 to slTemp.Count - 1 do
        begin
          frmMain.QRY.SQL.Text :=
            'UPDATE data SET d_comment_lower = :COMMENTLOWER WHERE (d_comment_lower IS NULL OR LENGTH(TRIM(d_comment_lower)) = 0) '
            + 'AND d_comment = :COMMENT;';
          frmMain.QRY.Params.ParamByName('COMMENT').AsString := slTemp.Strings[I];
          frmMain.QRY.Params.ParamByName('COMMENTLOWER').AsString :=
            AnsiLowerCase(slTemp.Strings[I]);
          frmMain.QRY.Prepare;
          frmMain.QRY.ExecSQL;
        end;
        frmMain.Tran.Commit;
      end;

    except
      on E: Exception do
      begin
        slTemp.Free;
        ShowMessage(AnsiReplaceStr(Error_32, '%', sLineBreak +
          AnsiUpperCase(FileName) + sLineBreak));
        frmMain.Tag := 1;
        frmMain.Conn.Close;
        Exit;
      end;
    end;
    slTemp.Free;

    // UPDATE VERSON TO 2
    frmMain.QRY.SQL.Text :=
      'UPDATE settings SET set_value = 2 WHERE set_parameter = "version";';
    frmMain.QRY.ExecSQL;
    frmMain.Tran.Commit;
  end;

  // **************************************************************************
  // ==========
  // VERSION 02
  // ==========
  // **************************************************************************

  // check version of database
  frmMain.QRY.SQL.Text :=
    'SELECT set_value FROM settings WHERE set_parameter = "version"';
  frmMain.QRY.Open;
  Temp := frmMain.QRY.Fields[0].AsString;
  frmMain.QRY.Close;

  if Temp = '2' then
  begin
    frmMain.Tran.Commit;
    frmMain.Tran.StartTransaction;

    // **************************************************************************
    // CREATE SORTING PARAMETERS ON DATABASE CLOSE
    frmMain.QRY.SQL.Text :=
      'INSERT OR IGNORE INTO settings (set_parameter, set_value) VALUES ' +
      '("last_transaction_type", NULL),' + // new transactions type
      '("last_transaction_date_from", NULL),' + // new transactions date frin
      '("last_transaction_date_to", NULL),' + // new transactions date to
      '("last_transaction_account_from", NULL),' + // new transactions account from
      '("last_transaction_account_to", NULL),' + // new transactions account to
      '("last_transaction_amount_from", NULL),' + // new transactions amount from
      '("last_transaction_amount_to", NULL),' + // new transactions amount to
      '("last_transaction_comment", NULL),' + // new comment
      '("last_transaction_category", NULL),' + // new category
      '("last_transaction_subcategory", NULL),' + // new subcategory
      '("last_transaction_person", NULL),' + // new person
      '("last_transaction_payee", NULL),' + // new transactions payee
      '("last_transaction_used", NULL);'; // boolean, if last image was used
    frmMain.QRY.ExecSQL;

    // UPDATE VERSON TO 3
    frmMain.QRY.SQL.Text :=
      'UPDATE settings SET set_value = 3 WHERE set_parameter = "version";';
    frmMain.QRY.ExecSQL;
    frmMain.Tran.Commit;
  end;

  // **************************************************************************
  // ========================================
  // CHECK CORRUPTED RECORDS IN DATABASE FIRST
  // ========================================
  // **************************************************************************
  ExistsCorruptedRecord := False;
  frmMain.QRY.SQL.Text :=
    'SELECT COUNT(d_date) FROM data ' + // 0
    'WHERE d_account IS NULL or d_category IS NULL or d_person IS NULL or d_payee IS NULL;';
  frmMain.QRY.Open;
  I := frmMain.QRY.Fields[0].AsInteger;
  frmMain.QRY.Close;

  if I > 0 then
  begin
    ExistsCorruptedRecord := True;
    if I = 1 then
    begin
      if MessageDlg(Message_00, Error_25 + sLineBreak + Question_26,
        mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
        ExistsCorruptedRecord := False;
    end
    else if I > 1 then
    begin
      if MessageDlg(Message_00, AnsiReplaceStr(Error_26, '%', IntToStr(I)) +
        sLineBreak + Question_26, mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
        ExistsCorruptedRecord := False;
    end;

    // delete corrupted records
    try
      if ExistsCorruptedRecord = True then
      begin
        frmMain.QRY.SQL.Text :=
          'DELETE FROM data ' + // 0
          'WHERE d_account IS NULL or d_category IS NULL or d_person IS NULL or d_payee IS NULL;';
        frmMain.QRY.ExecSQL;
        frmMain.Tran.Commit;
      end;
    except
      on E: Exception do
      begin
        ShowMessage(AnsiReplaceStr(Error_32, '%', sLineBreak +
          AnsiUpperCase(FileName) + sLineBreak));
        frmMain.Tag := 1;
        frmMain.Conn.Close;
        Exit;
      end;
    end;
  end;

  screen.Cursor := crHourGlass;
  try
    // frmMain
    frmMain.Caption := Application.Title + ' [ ' + FileName + ' ]';

    frmMain.pnlBottomClient.Visible := True;

    frmMain.pnlFilter.Enabled := True;
    frmMain.popFilterClear.Enabled := True;
    frmMain.popFilterExpand.Enabled := True;
    frmMain.popFilterCollapse.Enabled := True;
    frmMain.actFilterClear.Enabled := True;
    frmMain.actFilterExpand.Enabled := True;
    frmMain.actFilterCollapse.Enabled := True;

    frmMain.btnAdd.Enabled := True;
    frmMain.popAddSimple.Enabled := True;
    frmMain.popAddMulitple.Enabled := True;

    // update menu
    frmMain.mnuClose.Enabled := True;
    frmMain.mnuImport.Enabled := True;
    frmMain.mnuExport.Enabled := True;
    frmMain.mnuGuide.Enabled := True;
    frmMain.mnuPassword.Enabled := True;
    frmMain.mnuSQL.Enabled := True;
    frmMain.mnuProperties.Enabled := True;
    frmMain.mnuRecycle.Enabled := True;

    // update toolbar
    frmMain.btnClose.Enabled := True;
    frmMain.btnImport.Enabled := True;
    frmMain.btnExport.Enabled := True;
    frmMain.btnPassword.Enabled := True;
    frmMain.btnSQL.Enabled := True;
    frmMain.btnGuide.Enabled := True;
    frmMain.btnProperties.Enabled := True;
    frmMain.btnRecycle.Enabled := True;

    frmMain.VSTSummary.Enabled := True;

    // Lists updates
    UpdatePersons;
    UpdateCategories;
    UpdateCurrencies;
    UpdateAccounts;
    UpdatePayees;
    UpdateHolidays;
    UpdateComments;
    UpdateTags;
    UpdateScheduler;
    UpdateBudgets;
    UpdateLinks;

    // =========================================================================
    // LOAD SORTING PARAMETERS
    // =========================================================================

    // check sorted column
    frmMain.QRY.SQL.Text :=
      'SELECT set_value FROM settings WHERE set_parameter = "sort_column"';
    frmMain.QRY.Open;
    frmMain.VST.Header.SortColumn := StrToInt(frmMain.QRY.Fields[0].AsString);
    frmMain.QRY.Close;

    // check sorting order
    frmMain.QRY.SQL.Text :=
      'SELECT set_value FROM settings WHERE set_parameter = "sort_order"';
    frmMain.QRY.Open;
    if StrToBool(frmMain.QRY.Fields[0].AsString) = True then
      frmMain.VST.Header.SortDirection := sdAscending
    else
      frmMain.VST.Header.SortDirection := sdDescending;
    frmMain.QRY.Close;

    // check sorted column
    frmMain.QRY.SQL.Text :=
      'SELECT set_value FROM settings WHERE set_parameter = "summary_sort_column"';
    frmMain.QRY.Open;
    frmMain.VSTSummary.Header.SortColumn := StrToInt(frmMain.QRY.Fields[0].AsString);
    frmMain.QRY.Close;

    // check sorting order
    frmMain.QRY.SQL.Text :=
      'SELECT set_value FROM settings WHERE set_parameter = "summary_sort_order"';
    frmMain.QRY.Open;
    if StrToBool(frmMain.QRY.Fields[0].AsString) = True then
      frmMain.VSTSummary.Header.SortDirection := sdAscending
    else
      frmMain.VSTSummary.Header.SortDirection := sdDescending;
    frmMain.QRY.Close;

    // ==============================================================================
    // LOAD FILTER SETTINGS
    // ==============================================================================
    if frmSettings.chkLastUsedFilter.Checked = True then
    begin
      slTemp := TStringList.Create;

      // ==============================================================================
      // filter type
      frmMain.QRY.SQL.Text :=
        'SELECT set_value FROM settings WHERE set_parameter = "filter_type"';
      frmMain.QRY.Open;
      Temp := frmMain.QRY.Fields[0].AsString;
      frmMain.QRY.Close;

      frmMain.pnlTypeCaption.Tag := 1 - StrToInt(Field(separ, Temp, 1));
      frmMain.cbxType.ItemIndex := StrToInt(Field(separ, Temp, 2));

      if frmMain.cbxType.ItemIndex = -1 then
      begin
        frmMain.cbxType.Hint := Field(separ, Temp, 3);
        f_type := 'd_type IN (' + frmMain.cbxType.Hint + ') ';

        slTemp.Text := ReplaceStr(frmMain.cbxType.Hint, ',', sLineBreak);
        frmMain.pnlType.Hint := '';
        for I := 0 to slTemp.Count - 1 do
        begin
          frmMain.pnlType.Hint :=
            frmMain.pnlType.Hint + separ_1 + AnsiUpperCase(
            frmMain.cbxType.Items[StrToInt(slTemp.Strings[I]) + 1]);
        end;
      end;
      frmMain.pnlTypeCaptionClick(frmMain.pnlTypeCaption);
      frmMain.cbxTypeChange(frmMain.cbxType);

      // ==============================================================================
      // filter date type
      frmMain.QRY.SQL.Text :=
        'SELECT set_value FROM settings WHERE set_parameter = "filter_date_type"';
      frmMain.QRY.Open;
      Temp := frmMain.QRY.Fields[0].AsString;
      frmMain.QRY.Close;

      // set date caption
      if StrToInt(Temp[1]) = 1 then
      begin
        frmMain.pnlDateCaption.Tag := 0;
        frmMain.pnlDateCaptionClick(frmMain.pnlDateCaption);
      end;
      frmMain.pnlDateCaption.Tag := StrToInt(Temp[1]);

      // set day caption
      if StrToInt(Temp[2]) = 1 then
      begin
        frmMain.pnlDayCaption.Tag := 0;
        frmMain.pnlDayCaptionClick(frmMain.pnlDayCaption);
      end;
      frmMain.pnlDayCaption.Tag := StrToInt(Temp[2]);

      // set month / year caption
      if StrToInt(Temp[3]) = 1 then
      begin
        frmMain.pnlMonthYearCaption.Tag := 0;
        frmMain.pnlMonthYearCaptionClick(frmMain.pnlMonthYearCaption);
      end;
      frmMain.pnlMonthYearCaption.Tag := StrToInt(Temp[3]);

      // set period caption
      if StrToInt(Temp[4]) = 1 then
      begin
        frmMain.pnlPeriodCaption.Tag := 0;
        frmMain.pnlPeriodCaptionClick(frmMain.pnlPeriodCaption);
      end;
      frmMain.pnlPeriodCaption.Tag := StrToInt(Temp[4]);

      // ==============================================================================
      // filter date1
      if (frmMain.pnlDayCaption.Tag = 1) or (frmMain.pnlMonthYearCaption.Tag = 1) or
        (frmMain.pnlPeriodCaption.Tag = 1) then
      begin
        frmMain.QRY.SQL.Text :=
          'SELECT set_value FROM settings WHERE set_parameter = "filter_date_1"';
        frmMain.QRY.Open;
        Temp := frmMain.QRY.Fields[0].AsString;
        frmMain.QRY.Close;

        if frmMain.pnlDayCaption.Tag = 1 then
        begin
          frmMain.Calendar.Date :=
            IfThen(frmSettings.chkLastUsedFilterDate.Checked = True,
            Now(), StrToDate(Temp, 'YYYY-MM-DD', '-'));
          frmMain.CalendarDateChange(frmMain.Calendar);
        end
        else if frmMain.pnlMonthYearCaption.Tag = 1 then
          frmMain.cbxMonth.ItemIndex := StrToInt(Temp)
        else if frmMain.pnlPeriodCaption.Tag = 1 then
          frmMain.datDateFrom.Date := StrToDate(Temp, 'YYYY-MM-DD', '-');
      end;

      // ==============================================================================
      // filter date2
      if (frmMain.pnlMonthYearCaption.Tag = 1) or (frmMain.pnlPeriodCaption.Tag = 1) then
      begin
        frmMain.QRY.SQL.Text :=
          'SELECT set_value FROM settings WHERE set_parameter = "filter_date_2"';
        frmMain.QRY.Open;
        Temp := frmMain.QRY.Fields[0].AsString;
        frmMain.QRY.Close;
        if frmMain.pnlMonthYearCaption.Tag = 1 then
        begin
          frmMain.QRY.SQL.Text :=
            'SELECT DISTINCT strftime("%Y", d_date) as years FROM data ORDER BY years DESC';
          frmMain.QRY.Open;
          frmMain.cbxYear.Clear;
          while not frmMain.QRY.EOF do
          begin
            frmMain.cbxYear.Items.Add(frmMain.QRY.Fields[0].AsString);
            frmMain.QRY.Next;
          end;
          frmMain.QRY.Close;
          frmMain.cbxYear.Items.Insert(0, '*');
          frmMain.cbxYear.ItemIndex := StrToInt(Temp);
          frmMain.btnYearPlus.Enabled := frmMain.cbxYear.ItemIndex > 0;
          frmMain.btnYearMinus.Enabled :=
            frmMain.cbxYear.ItemIndex < frmMain.cbxYear.Items.Count - 1;
          frmMain.cbxMonthChange(frmMain.cbxMonth);
        end
        else
        begin
          frmMain.datDateTo.Date := StrToDate(Temp, 'YYYY-MM-DD', '-');
          frmMain.datDateFromChange(frmMain.datDateFrom);
        end;
      end;

      // ==============================================================================
      // filter Currency
      frmMain.QRY.SQL.Text :=
        'SELECT set_value FROM settings WHERE set_parameter = "filter_currency"';
      frmMain.QRY.Open;
      Temp := frmMain.QRY.Fields[0].AsString;
      frmMain.QRY.Close;
      frmMain.pnlCurrencyCaption.Tag := 1 - StrToInt(Field(separ, Temp, 1));
      frmMain.pnlCurrencyCaptionClick(frmMain.pnlCurrencyCaption);
      frmMain.pnlCurrencyCaption.Tag := StrToInt(Field(separ, Temp, 1));

      frmMain.cbxCurrency.ItemIndex := StrToInt(Field(separ, Temp, 2));

      case frmMain.cbxCurrency.ItemIndex of
        -1:
        begin
          frmMain.cbxCurrency.Hint := Field(separ + separ, Temp, 2);

          Temp := AnsiReplaceStr(frmMain.cbxCurrency.Hint, '"', '""');
          f_currency := 'AND acc_currency IN ("' +
            AnsiReplaceStr(Temp, separ, '","') + '") ';

          slTemp.Text := ReplaceStr(frmMain.cbxCurrency.Hint, separ, sLineBreak);
          frmMain.pnlCurrency.Hint := '';
          for I := 0 to slTemp.Count - 1 do
            frmMain.pnlCurrency.Hint :=
              frmMain.pnlCurrency.Hint + separ_1 + AnsiUpperCase(slTemp.Strings[I]);
        end;
        0: frmMain.cbxCurrency.Hint := ''
        else
          frmMain.cbxCurrency.Hint := Field(separ, Temp, 3);
      end;
      frmMain.cbxCurrencyChange(frmMain.cbxCurrency);

      // ==============================================================================
      // filter Account
      frmMain.QRY.SQL.Text :=
        'SELECT set_value FROM settings WHERE set_parameter = "filter_account"';
      frmMain.QRY.Open;
      Temp := frmMain.QRY.Fields[0].AsString;
      frmMain.QRY.Close;
      frmMain.pnlAccountCaption.Tag := 1 - StrToInt(Field(separ, Temp, 1));
      frmMain.pnlAccountCaptionClick(frmMain.pnlAccountCaption);
      frmMain.pnlAccountCaption.Tag := StrToInt(Field(separ, Temp, 1));

      frmMain.cbxAccount.ItemIndex := StrToInt(Field(separ, Temp, 2));

      case frmMain.cbxAccount.ItemIndex of
        -1:
        begin
          frmMain.cbxAccount.Hint := Field(separ + separ + separ, Temp, 2);
          slTemp.Text := ReplaceStr(frmMain.cbxAccount.Hint, separ + separ, sLineBreak);

          frmMain.pnlAccount.Hint := '';
          f_account := 'AND (';

          for I := 0 to slTemp.Count - 1 do
          begin
            frmMain.pnlAccount.Hint :=
              frmMain.pnlAccount.Hint + separ_1 + Field(separ, slTemp.Strings[I], 1) +
              ' (' + Field(separ, slTemp.Strings[I], 2) + ')';
            f_account := f_account + '(acc_name = "' + AnsiReplaceStr(
              Field(separ, slTemp.Strings[I], 1), '"', '""') +
              '" AND acc_currency = "' + AnsiReplaceStr(
              Field(separ, slTemp.Strings[I], 2), '"', '""') + '") OR ';
          end;
          f_account := UTF8Copy(f_account, 1, UTF8Length(f_account) - 4) + ') ';
        end;
        0: frmMain.cbxAccount.Hint := ''
        else
          frmMain.cbxAccount.Hint :=
            AnsiReplaceStr(frmMain.cbxAccount.Items[frmMain.cbxAccount.ItemIndex],
            separ_1, '˙');
      end;
      frmMain.cbxAccountChange(frmMain.cbxAccount);

      // ==============================================================================
      // filter Amount
      frmMain.QRY.SQL.Text :=
        'SELECT set_value FROM settings WHERE set_parameter = "filter_amount_type"';
      frmMain.QRY.Open;
      Temp := frmMain.QRY.Fields[0].AsString;
      frmMain.QRY.Close;

      frmMain.pnlAmountCaption.Tag := 1 - StrToInt(Temp[1]);
      frmMain.pnlAmountCaptionClick(frmMain.pnlAmountCaption);
      frmMain.pnlAmountCaption.Tag := StrToInt(Temp[1]);

      frmMain.cbxMin.ItemIndex := StrToInt(Temp[2]);
      frmMain.spiMin.Enabled := frmMain.cbxMin.ItemIndex > 0;
      frmMain.cbxMax.ItemIndex := StrToInt(Temp[3]);
      frmMain.spiMax.Enabled := frmMain.cbxMax.ItemIndex > 0;

      frmMain.QRY.SQL.Text :=
        'SELECT set_value FROM settings WHERE set_parameter = "filter_amount_value_1"';
      frmMain.QRY.Open;
      TryStrToFloat(frmMain.QRY.Fields[0].AsString, D);
      frmMain.spiMin.Value := D;
      frmMain.QRY.Close;

      frmMain.QRY.SQL.Text :=
        'SELECT set_value FROM settings WHERE set_parameter = "filter_amount_value_2"';
      frmMain.QRY.Open;
      TryStrToFloat(frmMain.QRY.Fields[0].AsString, D);
      frmMain.spiMax.Value := D;
      frmMain.QRY.Close;

      // ==============================================================================
      // filter Comment
      frmMain.QRY.SQL.Text :=
        'SELECT set_value FROM settings WHERE set_parameter = "filter_comment_type"';
      frmMain.QRY.Open;
      Temp := frmMain.QRY.Fields[0].AsString;
      frmMain.QRY.Close;

      frmMain.pnlCommentCaption.Tag := 1 - StrToInt(Temp[1]);
      frmMain.pnlCommentCaptionClick(frmMain.pnlCommentCaption);
      frmMain.pnlCommentCaption.Tag := StrToInt(Temp[1]);

      frmMain.cbxComment.ItemIndex := StrToInt(Temp[2]);

      frmMain.QRY.SQL.Text :=
        'SELECT set_value FROM settings WHERE set_parameter = "filter_comment_text"';
      frmMain.QRY.Open;
      frmMain.ediComment.Text := frmMain.QRY.Fields[0].AsString;
      frmMain.QRY.Close;

      // ==============================================================================
      // filter category
      frmMain.QRY.SQL.Text :=
        'SELECT set_value FROM settings WHERE set_parameter = "filter_category"';
      frmMain.QRY.Open;
      Temp := frmMain.QRY.Fields[0].AsString;
      frmMain.QRY.Close;

      frmMain.pnlCategoryCaption.Tag := 1 - StrToInt(Field(separ, Temp, 1));
      frmMain.cbxCategory.ItemIndex := StrToInt(Field(separ, Temp, 2));

      case frmMain.cbxCategory.ItemIndex of
        0: frmMain.cbxCategory.Hint := '';
        -1:
        begin
          frmMain.cbxCategory.Hint := Field(separ + separ + separ, Temp, 2);

          slTemp.Text := ReplaceStr(frmMain.cbxCategory.Hint, separ + separ, sLineBreak);
          frmMain.pnlCategory.Hint := '';
          f_category := 'AND (';

          for I := 0 to slTemp.Count - 1 do
          begin
            T1 := Field(separ, slTemp.Strings[I], 1);
            T2 := Field(separ, slTemp.Strings[I], 2);

            if UTF8Pos(separ, slTemp.Strings[I]) = 0 then
              f_category := f_category + '(cat_parent_name = "' +
                AnsiUpperCase(AnsiReplaceStr(T1, '"', '""')) + '") OR '
            else
              f_category := f_category + '(cat_parent_id <> 0 AND cat_name = "' +
                AnsiReplaceStr(T2, '"', '""') + '" AND cat_parent_name = "' +
                AnsiUpperCase(AnsiReplaceStr(T1, '"', '""')) + '") OR ';

            frmMain.pnlCategory.Hint :=
              frmMain.pnlCategory.Hint + separ_1 + AnsiUpperCase(T1) +
              ' (' + IfThen(T2 = '', '*', AnsiLowerCase(T2)) + ') ';
          end;
          f_category := UTF8Copy(f_category, 1, UTF8Length(f_category) - 4) + ') ';
        end
        else
        begin
          frmMain.cbxCategory.Hint := Field('˙', Temp, 1) + '˙' + Field('˙', Temp, 2);
        end;
      end;

      frmMain.pnlCategoryCaptionClick(frmMain.pnlCategoryCaption);
      frmMain.cbxCategoryChange(frmMain.cbxCategory);

      // ==============================================================================
      // filter Subcategory
      if frmMain.cbxCategory.ItemIndex > 0 then
      begin
        frmMain.cbxSubcategory.ItemIndex := StrToInt(Field(separ, Temp, 3));
        if frmMain.cbxSubcategory.ItemIndex > 0 then
          frmMain.cbxSubcategoryChange(frmMain.cbxSubcategory)
        else if frmMain.cbxSubcategory.ItemIndex = -1 then
        begin
          Temp := Field(separ + separ + separ, Temp, 2);
          frmMain.cbxSubcategory.Hint := Temp;
          slTemp.Text := ReplaceStr(frmMain.cbxSubcategory.Hint,
            separ + separ, sLineBreak);
          frmMain.pnlCategory.Hint := '';
          f_subcategory := '';

          for I := 0 to slTemp.Count - 1 do
            f_subcategory := f_subcategory + IntToStr(
              GetCategoryID(frmMain.cbxCategory.Items[frmMain.cbxCategory.ItemIndex] +
              separ_1 + slTemp.Strings[I])) + IfThen(I < slTemp.Count - 1, ',', '');
          f_subcategory := 'AND cat_id IN (' + f_subcategory + ') ';
          frmMain.pnlCategory.Hint :=
            separ_1 + frmMain.cbxCategory.Items[frmMain.cbxCategory.ItemIndex] +
            ' (' + AnsiReplaceStr(frmMain.cbxSubcategory.Hint, separ +
            separ, separ_1) + ')';
          frmMain.cbxSubcategoryChange(frmMain.cbxSubcategory);
        end;
      end;

      // ==============================================================================
      // filter Person
      frmMain.QRY.SQL.Text :=
        'SELECT set_value FROM settings WHERE set_parameter = "filter_person"';
      frmMain.QRY.Open;
      Temp := frmMain.QRY.Fields[0].AsString;
      frmMain.QRY.Close;
      frmMain.pnlPersonCaption.Tag := 1 - StrToInt(Field(separ, Temp, 1));
      frmMain.pnlPersonCaptionClick(frmMain.pnlPersonCaption);
      frmMain.pnlPersonCaption.Tag := StrToInt(Field(separ, Temp, 1));

      frmMain.cbxPerson.ItemIndex := StrToInt(Field(separ, Temp, 2));

      case frmMain.cbxPerson.ItemIndex of
        0: frmMain.cbxPerson.Hint := '';
        -1:
        begin
          frmMain.cbxPerson.Hint := Field(separ + separ, Temp, 2);
          slTemp.Text := ReplaceStr(frmMain.cbxPerson.Hint, separ, sLineBreak);
          Temp := '';

          frmMain.pnlPerson.Hint := '';
          for I := 0 to slTemp.Count - 1 do
          begin
            Temp := Temp + '"' + AnsiReplaceStr(slTemp.Strings[I], '"', '""') + '",';
            frmMain.pnlPerson.Hint :=
              frmMain.pnlPerson.Hint + separ_1 +
              Trim(AnsiReplaceStr(slTemp.Strings[I], '''', '"'));
          end;
          temp := UTF8Copy(Temp, 1, UTF8Length(Temp) - 1);
          f_person := 'AND per_name IN (' + Temp + ') ';
        end
        else
          frmMain.cbxPerson.Hint :=
            Trim(AnsiReplaceStr(Field(separ + separ, Temp, 2), '''', '"'));
      end;

      frmMain.cbxPersonChange(frmMain.cbxPerson);

      // ==============================================================================
      // filter Payee
      frmMain.QRY.SQL.Text :=
        'SELECT set_value FROM settings WHERE set_parameter = "filter_payee"';
      frmMain.QRY.Open;
      Temp := frmMain.QRY.Fields[0].AsString;
      frmMain.QRY.Close;
      frmMain.pnlPayeeCaption.Tag := 1 - StrToInt(Field(separ, Temp, 1));
      frmMain.pnlPayeeCaptionClick(frmMain.pnlPayeeCaption);
      frmMain.pnlPayeeCaption.Tag := StrToInt(Field(separ, Temp, 1));

      frmMain.cbxPayee.ItemIndex := StrToInt(Field(separ, Temp, 2));

      case frmMain.cbxPayee.ItemIndex of
        0: frmMain.cbxPayee.Hint := '';
        -1:
        begin
          frmMain.cbxPayee.Hint := Field(separ + separ, Temp, 2);
          slTemp.Text := ReplaceStr(frmMain.cbxPayee.Hint, separ, sLineBreak);
          Temp := '';

          frmMain.pnlPayee.Hint := '';
          for I := 0 to slTemp.Count - 1 do
          begin
            Temp := Temp + '"' + AnsiReplaceStr(slTemp.Strings[I], '"', '""') + '",';
            frmMain.pnlPayee.Hint :=
              frmMain.pnlPayee.Hint + separ_1 +
              Trim(AnsiReplaceStr(slTemp.Strings[I], '''', '"'));
          end;
          temp := UTF8Copy(Temp, 1, UTF8Length(Temp) - 1);
          f_Payee := 'AND pee_name IN (' + Temp + ') ';
        end
        else
          frmMain.cbxPayee.Hint :=
            Trim(AnsiReplaceStr(Field(separ + separ, Temp, 2), '''', '"'));
      end;

      frmMain.cbxPayeeChange(frmMain.cbxPayee);

      // ==============================================================================
      // filter Tag
      frmMain.QRY.SQL.Text :=
        'SELECT set_value FROM settings WHERE set_parameter = "filter_tag"';
      frmMain.QRY.Open;
      Temp := frmMain.QRY.Fields[0].AsString;
      frmMain.QRY.Close;
      frmMain.pnlTagCaption.Tag := 1 - StrToInt(Field(separ, Temp, 1));
      frmMain.pnlTagCaptionClick(frmMain.pnlTagCaption);
      frmMain.pnlTagCaption.Tag := StrToInt(Field(separ, Temp, 1));

      frmMain.cbxTag.ItemIndex := StrToInt(Field(separ, Temp, 2));

      case frmMain.cbxTag.ItemIndex of
        0: frmMain.cbxTag.Hint := '';
        -1:
        begin
          frmMain.cbxTag.Hint := Field(separ + separ, Temp, 2);
          slTemp.Text := ReplaceStr(frmMain.cbxTag.Hint, separ, sLineBreak);
          Temp := '';

          frmMain.pnlTag.Hint := '';
          for I := 0 to slTemp.Count - 1 do
          begin
            Temp := Temp + '"' + AnsiReplaceStr(slTemp.Strings[I], '"', '""') + '",';
            frmMain.pnlTag.Hint :=
              frmMain.pnlTag.Hint + separ_1 +
              Trim(AnsiReplaceStr(slTemp.Strings[I], '''', '"'));
          end;
          temp := UTF8Copy(Temp, 1, UTF8Length(Temp) - 1);
          f_tag := 'AND d_id IN (SELECT dt_data FROM data_tags WHERE dt_tag IN ' +
            '(SELECT tag_id FROM tags WHERE tag_name IN (' + Temp + '))) ';
        end
        else
          frmMain.cbxTag.Hint :=
            Trim(AnsiReplaceStr(Field(separ + separ, Temp, 2), '''', '"'));
      end;

      frmMain.cbxTagChange(frmMain.cbxTag);
      // ==============================================================================
      slTemp.Free;
    end;

    // main currency in calendar
    if frmMain.tabCurrency.TabIndex > -1 then
    begin
      frmCalendar.cbxCurrency.ItemIndex := frmMain.tabCurrency.TabIndex;
      frmCalendar.cbxCurrencyChange(frmCalendar.cbxCurrency);
    end;

    // main currency in cash counter
    if frmMain.tabCurrency.TabIndex > -1 then
      frmCounter.cbxCurrency.ItemIndex := frmMain.tabCurrency.TabIndex;

    // Show all transactions and summary
    AllowUpdateTransactions := True;
    UpdateTransactions;

    frmMain.pnlButtons.Enabled := True;
    frmMain.chkShowPieChart.Enabled := True;
    screen.Cursor := crDefault;
    frmMain.tmr.Enabled := True;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure Vacuum;
begin
  try
    if frmMain.Conn.Connected = False then
      Exit;
    // vyčistenie databázy od vymazaných záznamov
    frmMain.Conn.ExecuteDirect('END TRANSACTION');
    // End the transaction started by SQLdb
    frmMain.Conn.ExecuteDirect('VACUUM');
    frmMain.Conn.ExecuteDirect('BEGIN TRANSACTION');
    //Start a transaction for SQLdb to use
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure FindNewRecord(Sender: TLazVirtualStringTree; Column: integer);
var
  I, Max: integer;
  N: PVirtualNode;
begin
  try
    Sender.BeginUpdate;

    N := Sender.GetFirst;
    Max := 0;
    while Assigned(N) do
    begin
      I := StrToInt(Sender.Text[N, Column]);
      if I > Max then
      begin
        Max := I;
        Sender.ClearSelection;
        Sender.Selected[N] := True;
      end;
      N := Sender.GetNext(N);
    end;

  finally
    if Sender.SelectedCount = 1 then
    begin
      Sender.FocusedNode := Sender.GetFirstSelected();
      Sender.TopNode := Sender.GetFirstSelected();
    end;
    Sender.EndUpdate;
  end;
end;

procedure FindEditedRecord(Sender: TLazVirtualStringTree; Column, Number: integer);
var
  N: PVirtualNode;
begin
  try
    Sender.BeginUpdate;
    Sender.ClearSelection;
    N := Sender.GetFirst;
    while Assigned(N) do
    begin
      if StrToInt(Sender.Text[N, Column]) = Number then
      begin
        Sender.Selected[N] := True;
        Break;
      end;
      N := Sender.GetNext(N);
    end;

  finally
    if Sender.SelectedCount = 1 then
    begin
      Sender.FocusedNode := Sender.GetFirstSelected();
      Sender.TopNode := Sender.GetFirstSelected();
    end;
    Sender.EndUpdate;
  end;
end;

procedure UpdateTransactions;
var
  Transactions: PTransactions;
  P: PVirtualNode;
begin
  try
    frmMain.VST.Clear;
    frmMain.VST.RootNodeCount := 0;

    if (frmMain.Conn.Connected = False) or (AllowUpdateTransactions = False) then
      Exit;

    screen.Cursor := crHourGlass;
    frmMain.VST.BeginUpdate;

    frmMain.QRY.SQL.Text :=
      'SELECT d_date,' + sLineBreak + // date 0
      'd_comment,' + sLineBreak + // comment 1
      'Round(d_sum, 2) as d_sum, ' + sLineBreak + // rounded amount 2
      'acc_currency,' + sLineBreak + // currency 3
      'acc_name,' + sLineBreak + // account name 4
      'cat_parent_name,' + sLineBreak + // category name 5
      'cat_name,' + sLineBreak + // subcategory name 6
      'per_name,' + sLineBreak + // person 7
      'pee_name, ' + sLineBreak + // payee 8
      'd_id,' + sLineBreak + // ID 9
      'd_type, ' + sLineBreak +// type (credit, debit, transfer +, transfer -) 10
      'cat_parent_id, ' + // category parent ID 11
      'd_order ' + // order 12

      'FROM data ' + sLineBreak +// FROM tables
      'LEFT JOIN ' + sLineBreak +// JOIN
      'accounts ON (acc_id = d_account), ' + sLineBreak +// accounts
      'categories ON (cat_id = d_category), ' + sLineBreak +// categories
      'persons ON (per_id = d_person), ' + sLineBreak +// persons
      'payees ON (pee_id = d_payee) ' + sLineBreak +// payees
      'WHERE ' + // where clausule
      f_type + sLineBreak + // type filter
      f_date + sLineBreak + // date filter
      f_currency + sLineBreak + // currency filter
      f_account + sLineBreak + // account filter
      f_amount + sLineBreak +  // amount filter
      f_comment + sLineBreak + // comment filter
      f_category + sLineBreak + // category filter
      f_subcategory + sLineBreak + // subcategory filter
      f_person + sLineBreak + // person filter
      f_payee + sLineBreak + // payee filter
      f_tag; // tag filter

    // ShowMessage (frmMain.QRY.SQL.Text);

    frmMain.QRY.Open;

    while not frmMain.QRY.EOF do
    begin
      frmMain.VST.RootNodeCount := frmMain.VST.RootNodeCount + 1;
      P := frmMain.VST.GetLast();
      Transactions := frmMain.VST.GetNodeData(P);
      Transactions.Date := frmMain.QRY.Fields[0].AsString;
      Transactions.Comment := frmMain.QRY.Fields[1].AsString;
      TryStrToFloat(frmMain.QRY.Fields[2].AsString, Transactions.Amount);
      Transactions.currency := frmMain.QRY.Fields[3].AsString;
      Transactions.Account := frmMain.QRY.Fields[4].AsString;
      Transactions.Category := frmMain.QRY.Fields[5].AsString;
      Transactions.SubCategory :=
        IfThen(frmMain.QRY.Fields[11].AsInteger = 0, '', frmMain.QRY.Fields[6].AsString);
      Transactions.Person := frmMain.QRY.Fields[7].AsString;
      Transactions.Payee := frmMain.QRY.Fields[8].AsString;
      Transactions.ID := frmMain.QRY.Fields[9].AsInteger;
      Transactions.Kind := frmMain.QRY.Fields[10].AsInteger;
      Transactions.Order := frmMain.QRY.Fields[12].AsInteger;
      frmMain.QRY.Next;
    end;

    frmMain.QRY.Close;

    // LIST CAPTION
    frmMain.pnlListCaption.Caption :=
      AnsiUpperCase(Caption_25) + frmMain.pnlType.Hint + frmMain.pnlDate.Hint +
      frmMain.pnlCurrency.Hint + frmMain.pnlAccount.Hint + frmMain.pnlAmount.Hint +
      frmMain.pnlComment.Hint + frmMain.pnlCategory.Hint +
      AnsiUpperCase(frmMain.pnlPerson.Hint) + AnsiUpperCase(frmMain.pnlPayee.Hint) +
      frmMain.pnlTag.Hint;

    frmMain.pnlReportCaption.Caption :=
      AnsiUpperCase(AnsiReplaceStr(Menu_45, '&', '')) + frmMain.pnlType.Hint +
      frmMain.pnlDate.Hint + frmMain.pnlCurrency.Hint + frmMain.pnlAccount.Hint +
      frmMain.pnlAmount.Hint + frmMain.pnlComment.Hint + frmMain.pnlCategory.Hint +
      AnsiUpperCase(frmMain.pnlPerson.Hint) + AnsiUpperCase(frmMain.pnlPayee.Hint) +
      frmMain.pnlTag.Hint;

    // =====================================================================
    // items icon
    frmMain.lblItems.Caption := IntToStr(frmMain.VST.RootNodeCount);

    frmMain.popCopy.Enabled := frmMain.VST.RootNodeCount > 0;
    frmMain.btnCopy.Enabled := frmMain.popCopy.Enabled;

    frmMain.popPrint.Enabled := frmMain.popCopy.Enabled;
    frmMain.btnPrint.Enabled := frmMain.popCopy.Enabled;

    frmMain.popSelect.Enabled := frmMain.VST.RootNodeCount > 0;
    frmMain.btnSelect.Enabled := frmMain.VST.RootNodeCount > 0;

    frmMain.popDuplicate.Enabled := False;
    frmMain.btnDuplicate.Enabled := False;

    frmMain.popEdit.Enabled := False;
    frmMain.btnEdit.Enabled := False;

    frmMain.popDelete.Enabled := False;
    frmMain.btnDelete.Enabled := False;

    frmMain.btnHistory.Enabled := False;

    // ===========================================================================
    UpdateSummary;
    // ============================================================================

    // update years in the filter
    if frmMain.cbxYear.ItemIndex = 0 then
    begin
      frmMain.QRY.SQL.Text :=
        'SELECT DISTINCT strftime("%Y", d_date) as years FROM data ORDER BY years DESC';
      frmMain.QRY.Open;
      frmMain.QRY.Last;
      if (frmMain.QRY.RecordCount + 1 <> frmMain.cbxYear.Items.Count) or
        (frmMain.QRY.RecordCount > 0) then
      begin
        //ShowMessage(IntToStr(frmMain.QRY.RecordCount + 1) + sLineBreak +
        //  IntToStr(frmMain.cbxYear.Items.Count));
        frmMain.QRY.First;
        frmMain.cbxYear.Clear;
        while not frmMain.QRY.EOF do
        begin
          frmMain.cbxYear.Items.Add(frmMain.QRY.Fields[0].AsString);
          frmMain.QRY.Next;
        end;
        frmMain.cbxYear.Items.Insert(0, '*');
        frmMain.cbxYear.ItemIndex := 0;
        frmMain.btnYearPlus.Enabled := frmMain.cbxYear.ItemIndex > 0;
        frmMain.btnYearMinus.Enabled :=
          frmMain.cbxYear.ItemIndex < frmMain.cbxYear.Items.Count - 1;
      end;
      frmMain.QRY.Close;
    end;

    SetnodeHeight(frmMain.VST);
    frmMain.VST.EndUpdate;
    screen.Cursor := crDefault;

  except
    on E: Exception do
    begin
      frmMain.VST.EndUpdate;
      ShowErrorMessage(E);
    end;
  end;
end;

procedure UpdateSummary;
var
  DateFrom, DateTo, Temp: string; // Date interval
  LimitedDate: boolean;
  Summary: PSummary;
  P: PVirtualNode;
  AA, SS, C, D, TP, TM: double;
begin
  try

    //clear previous summary data
    frmMain.VSTSummary.Clear;
    frmMain.popSummaryCopy.Enabled := False;
    frmMain.popSummaryPrint.Enabled := False;

    // ==================================================================
    if (frmMain.Conn.Connected = False) or (frmMain.tabCurrency.Visible = False) then
      Exit;

    AA := 0.0;
    SS := 0.0;
    C := 0.0;
    D := 0.0;
    TP := 0.0;
    TM := 0.0;
    LimitedDate := False;

    frmMain.VSTSummary.BeginUpdate;
    Screen.Cursor := crHourGlass;

    Temp := frmMain.tabCurrency.Tabs[frmMain.tabCurrency.TabIndex];
    DateFrom := '1900-01-01';
    DateTo := '2222-12-31';

    // =============================================================================================
    // Date
    if frmMain.pnlDayCaption.Tag = 1 then
    begin
      DateFrom := FormatDateTime('yyyy-mm-dd', frmMain.Calendar.Date);
      DateTo := DateFrom;
      LimitedDate := True;
    end

    // Month - Year
    else if frmMain.pnlMonthYearCaption.Tag = 1 then
    begin
      if frmMain.cbxYear.ItemIndex = 0 then
      begin
        LimitedDate := False;
        DateFrom := '1900-01-01';
        DateTo := '2222-12-31';
      end
      else
      begin
        LimitedDate := True;
        if frmMain.cbxMonth.ItemIndex = 0 then
        begin
          DateFrom := frmMain.cbxYear.Text + '-01-01';
          DateTo := frmMain.cbxYear.Text + '-12-31';
        end
        else
        begin
          DateFrom := frmMain.cbxYear.Text + '-' +
            RightStr('0' + IntToStr(frmMain.cbxMonth.ItemIndex), 2) + '-01';
          DateTo := frmMain.cbxYear.Text + '-' +
            RightStr('0' + IntToStr(frmMain.cbxMonth.ItemIndex), 2) +
            '-' + IntToStr(DaysInAMonth(StrToInt(frmMain.cbxYear.Text),
            frmMain.cbxMonth.ItemIndex));
        end;
      end;
    end

    // Period
    else if frmMain.pnlPeriodCaption.Tag = 1 then
    begin
      LimitedDate := True;
      DateFrom := FormatDateTime('yyyy-mm-dd', frmMain.datDateFrom.Date);
      DateTo := FormatDateTime('yyyy-mm-dd', frmMain.datDateTo.Date);
    end;

    frmMain.QRY.SQL.Text :=
      'SELECT acc_name, acc_amount, acc_comment, acc_id, ' + sLineBreak +

      // STARTING BALANCE SUMMARY ======================================
      '(SELECT TOTAL(d_sum) FROM data ' + // from
      'LEFT JOIN ' + // JOIN
      'categories ON (cat_id = d_category), ' + // categories
      'persons ON (per_id = d_person), ' + // categories
      'payees ON (pee_id = d_payee) ' + // categories
      'WHERE d_account = acc_id AND d_date < "' + DateFrom + '"' +
      f_amount + f_comment + f_category + f_subcategory + f_person +
      f_payee + f_tag + ') as start_sum, ' + sLineBreak +

      // CREDIT ========================================================
      '(SELECT TOTAL(d_sum) FROM data ' + // select
      'LEFT JOIN ' + // JOIN
      'categories ON (cat_id = d_category), ' + // categories
      'persons ON (per_id = d_person), ' + // categories
      'payees ON (pee_id = d_payee) ' + // categories
      'WHERE d_account = acc_id AND d_type = 0 ' + f_date + f_amount +
      f_comment + f_category + f_subcategory + f_person + f_payee +
      f_tag + ') as credit, ' + sLineBreak +

      // DEBIT =========================================================
      '(SELECT TOTAL(d_sum) FROM data ' + 'LEFT JOIN ' + // JOIN
      'categories ON (cat_id = d_category), ' + // categories
      'persons ON (per_id = d_person), ' + // categories
      'payees ON (pee_id = d_payee) ' + // categories
      'WHERE d_account = acc_id AND d_type = 1 ' + f_date + f_amount +
      f_comment + f_category + f_subcategory + f_person + f_payee +
      f_tag + ') as debit, ' + sLineBreak +

      // TRANSFER + ====================================================
      '(SELECT TOTAL(d_sum) FROM data ' + 'LEFT JOIN ' + // JOIN
      'categories ON (cat_id = d_category), ' + // categories
      'persons ON (per_id = d_person), ' + // categories
      'payees ON (pee_id = d_payee) ' + // categories
      'WHERE d_account = acc_id AND d_type = 2 ' + f_date + f_amount +
      f_comment + f_category + f_subcategory + f_person + f_payee +
      f_tag + ') as transfer_plus, ' + sLineBreak +

      // TRANSFER - ====================================================
      '(SELECT TOTAL(d_sum) FROM data ' + 'LEFT JOIN ' + // JOIN
      'categories ON (cat_id = d_category), ' + // categories
      'persons ON (per_id = d_person), ' + // categories
      'payees ON (pee_id = d_payee) ' + // categories
      'WHERE d_account = acc_id AND d_type = 3 ' + f_date + f_amount +
      f_comment + f_category + f_subcategory + f_person + f_payee +
      f_tag + ') as transfer_minus ' + sLineBreak +

      // FROM ==========================================================
      'FROM accounts ' + sLineBreak + // FROM tables
      'WHERE acc_status = 0 AND acc_currency = "' + AnsiReplaceStr(Temp, '"', '""') +
      '" ' + IfThen(LimitedDate = True, 'AND acc_date <= "' + DateTo +
      '" ', '') + f_account;

    // ShowMessage (frmMain.QRY.SQL.Text);
    frmMain.QRY.Open;

    // --------------------------------------------------------------------------------------
    while not (frmMain.QRY.EOF) do
    begin
      frmMain.VSTSummary.RootNodeCount := frmMain.VSTSummary.RootNodeCount + 1;
      P := frmMain.VSTSummary.GetLast();
      Summary := frmMain.VSTSummary.GetNodeData(P);
      Summary.Account := frmMain.QRY.Fields[0].AsString;
      Summary.AccountAmount := frmMain.QRY.Fields[1].AsFloat;  // amount
      AA := AA + Summary.AccountAmount;
      Summary.Comment := frmMain.QRY.Fields[2].AsString;
      Summary.StartSum := frmMain.QRY.Fields[4].AsFloat; // start sum
      SS := SS + Summary.StartSum;
      Summary.Credit := frmMain.QRY.Fields[5].AsFloat; // credit
      C := C + Summary.Credit;
      Summary.Debit := frmMain.QRY.Fields[6].AsFloat; // debit
      D := D + Summary.Debit;
      Summary.TransferP := frmMain.QRY.Fields[7].AsFloat; // transfer +
      TP := TP + Summary.TransferP;
      Summary.TransferM := frmMain.QRY.Fields[8].AsFloat; // transfer -
      TM := TM + Summary.TransferM;
      frmMain.QRY.Next;
    end;
    frmMain.QRY.Close;

    // add summary row
    frmMain.VSTSummary.InsertNode(frmMain.VSTSummary.GetFirst(), amInsertBefore);
    P := frmMain.VSTSummary.GetFirst();
    Summary := frmMain.VSTSummary.GetNodeData(P);
    Summary.Account := AnsiUpperCase(Caption_16);
    Summary.AccountAmount := AA;
    Summary.StartSum := SS;
    Summary.Credit := C;
    Summary.Debit := D;
    Summary.TransferP := TP;
    Summary.TransferM := TM;

    SetNodeHeight(frmMain.VSTSummary);
    frmMain.VSTSummary.EndUpdate;
    Screen.Cursor := crDefault;

    if frmMain.pnlReport.Visible = True then
    begin
      frmMain.tabBalanceHeaderChange(frmMain.tabBalanceHeader);
      frmMain.tabChronoHeaderChange(frmMain.tabChronoHeader);
      frmMain.tabCrossLeftChange(frmMain.tabCrossLeft);
    end;

    frmMain.popSummaryCopy.Enabled := frmMain.VSTSummary.RootNodeCount > 0;
    frmMain.popSummaryPrint.Enabled := frmMain.VSTSummary.RootNodeCount > 0;


    // sort summary table
    frmMain.VSTSummary.SortTree(frmMain.VSTSummary.Header.SortColumn,
      frmMain.VSTSummary.Header.SortDirection, True);
  except
    on E: Exception do
    begin
      frmMain.VSTSummary.EndUpdate;
      Screen.Cursor := crDefault;
      ShowErrorMessage(E);
    end;
  end;
end;

end.
