unit uniBudgets;

{$mode ObjFPC}{$H+}
{$ModeSwitch AutoDeref}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, ActnList,
  ComCtrls, Menus, BCMDButtonFocus, BCPanel, ECTabCtrl, laz.VirtualTrees,
  StdCtrls, Buttons, Math, sqldb, StrUtils, DateUtils, LazUTF8;

type // left grid (Budgets)
  TBudgets = record
    Name: string;
    Kind: integer;
    ID: integer;
  end;
  PBudgets = ^TBudgets;

type // middle grid (Periods)
  TPeriods = record
    DateFrom: string;
    DateTo: string;
  end;
  PPeriods = ^TPeriods;

type // right grid (Budget_Categories)
  TBudCat = record
    Category: string;
    SubCategory: string;
    Level: integer;
    BudgetID: integer;
    Plan: array of double;
    Reality: array of double;
    Difference: array of double;
    Ratio: array of double;
    CategoryID: integer;
  end;
  PBudCat = ^TBudCat;

type

  { TfrmBudgets }

  TfrmBudgets = class(TForm)
    actBudgetAdd: TAction;
    actBudgetDuplicate: TAction;
    actBudgetDelete: TAction;
    actBudgetEdit: TAction;
    actExit: TAction;
    actPeriodAdd: TAction;
    actPeriodEdit: TAction;
    actPeriodDelete: TAction;
    actPeriodDuplicate: TAction;
    ActionList1: TActionList;
    btnBudgetAdd: TBCMDButtonFocus;
    btnBudgetDelete: TBCMDButtonFocus;
    btnBudgetDuplicate: TBCMDButtonFocus;
    btnBudgetEdit: TBCMDButtonFocus;
    btnCopy: TBCMDButtonFocus;
    btnPeriodAdd: TBCMDButtonFocus;
    btnPeriodDelete: TBCMDButtonFocus;
    btnPeriodDuplicate: TBCMDButtonFocus;
    btnPeriodEdit: TBCMDButtonFocus;
    btnSettings: TBCMDButtonFocus;
    btnExit: TBCMDButtonFocus;
    imgIndex: TImage;
    imgPlan: TImage;
    imgHeader: TImageList;
    imgHeight: TImage;
    imgItemBudCat: TImage;
    imgItemBudgets: TImage;
    imgItemPeriods: TImage;
    imgItemsBudCat: TImage;
    imgItemsBudgets: TImage;
    imgItemsPeriods: TImage;
    imgReality: TImage;
    imgDifference: TImage;
    imgWidth: TImage;
    lblIndex: TStaticText;
    lblHeight: TLabel;
    lblItemBudCat: TLabel;
    lblItemBudgets: TLabel;
    lblItemPeriods: TLabel;
    lblItemsBudCat: TLabel;
    lblItemsBudgets: TLabel;
    lblItemsPeriods: TLabel;
    lblReality: TStaticText;
    lblDifference: TStaticText;
    lblWidth: TLabel;
    Panel1: TPanel;
    pnlIndex: TPanel;
    pnlPlan: TPanel;
    pnlBottom: TPanel;
    pnlBottom1: TPanel;
    pnlBottom2: TPanel;
    pnlBudgetCaption: TBCPanel;
    pnlHeight: TPanel;
    pnlItemBudCat: TPanel;
    pnlItemBudgets: TPanel;
    pnlItemPeriods: TPanel;
    pnlItemsBudCat: TPanel;
    pnlItemsBudgets: TPanel;
    pnlItemsPeriods: TPanel;
    pnlReality: TPanel;
    pnlDifference: TPanel;
    pnlWidth: TPanel;
    lblPlan: TStaticText;
    tabCurrency: TECTabCtrl;
    tabLeft: TPageControl;
    pnlBudgets: TPanel;
    pnlButtons: TPanel;
    pnlCategories: TPanel;
    pnlCategoriesCaption: TBCPanel;
    pnlPeriods: TPanel;
    popBudgetAdd: TMenuItem;
    popPeriodAdd: TMenuItem;
    popPeriods: TPopupMenu;
    popPeriodDelete: TMenuItem;
    popBudgetDuplicate: TMenuItem;
    popBudgetDelete: TMenuItem;
    popPeriodDuplicate: TMenuItem;
    popBudgetEdit: TMenuItem;
    popBudgets: TPopupMenu;
    popPeriodEdit: TMenuItem;
    splBudget: TSplitter;
    tabBudgets: TTabSheet;
    tabPeriods: TTabSheet;
    tabLegend: TTabSheet;
    VSTBudCat: TLazVirtualStringTree;
    VSTBudgets: TLazVirtualStringTree;
    VSTPeriods: TLazVirtualStringTree;
    procedure actPeriodDeleteExecute(Sender: TObject);
    procedure btnCopyClick(Sender: TObject);
    procedure btnSettingsClick(Sender: TObject);
    procedure pnlBottom1Resize(Sender: TObject);
    procedure pnlBottom2Resize(Sender: TObject);
    procedure pnlBudgetsResize(Sender: TObject);
    procedure tabCurrencyChange(Sender: TObject);
    procedure tabLeftChange(Sender: TObject);
    //    procedure tabLeftChanging(Sender: TObject; var AllowChange: boolean);
    procedure tabLeftResize(Sender: TObject);
    procedure popBudgetAddClick(Sender: TObject);
    procedure popBudgetDeleteClick(Sender: TObject);
    procedure popBudgetDuplicateClick(Sender: TObject);
    procedure popBudgetEditClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure popPeriodAddClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure popPeriodDeleteClick(Sender: TObject);
    procedure popPeriodDuplicateClick(Sender: TObject);
    procedure popPeriodEditClick(Sender: TObject);
    procedure splBudgetCanResize(Sender: TObject; var NewSize: integer;
      var Accept: boolean);
    procedure splPeriodCanResize(Sender: TObject; var NewSize: integer;
      var Accept: boolean);
    procedure VSTBudCatChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure VSTBudCatCompareNodes(Sender: TBaseVirtualTree;
      Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: integer);
    procedure VSTBudCatResize(Sender: TObject);
    //    procedure VSTBudCatResize(Sender: TObject);
    procedure VSTBudgetsBeforeCellPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
    procedure VSTBudgetsChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure VSTBudgetsCompareNodes(Sender: TBaseVirtualTree;
      Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: integer);
    procedure VSTBudgetsDblClick(Sender: TObject);
    procedure VSTBudgetsEnter(Sender: TObject);
    procedure VSTBudgetsGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: boolean; var ImageIndex: integer);
    procedure VSTBudgetsGetNodeDataSize(Sender: TBaseVirtualTree;
      var NodeDataSize: integer);
    procedure VSTBudgetsGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure VSTBudgetsPaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      TextType: TVSTTextType);
    procedure VSTBudgetsResize(Sender: TObject);
    procedure VSTBudCatBeforeCellPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
    procedure VSTBudCatGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: boolean; var ImageIndex: integer);
    procedure VSTBudCatGetNodeDataSize(Sender: TBaseVirtualTree;
      var NodeDataSize: integer);
    procedure VSTBudCatGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure VSTBudCatPaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      TextType: TVSTTextType);
    procedure VSTPeriodsChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure VSTPeriodsCompareNodes(Sender: TBaseVirtualTree;
      Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: integer);
    procedure VSTPeriodsDblClick(Sender: TObject);
    procedure VSTPeriodsGetNodeDataSize(Sender: TBaseVirtualTree;
      var NodeDataSize: integer);
    procedure VSTPeriodsGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure VSTPeriodsResize(Sender: TObject);
  private

  public

  end;

var
  frmBudgets: TfrmBudgets;

procedure UpdateBudgets;
procedure UpdatePeriods;
procedure UpdateBudCategories;

implementation

{$R *.lfm}

uses
  uniMain, uniBudget, uniResources, uniSettings, uniPeriod;

  { TfrmBudgets }

procedure TfrmBudgets.VSTBudgetsResize(Sender: TObject);
var
  X: integer;
begin
  if frmSettings.chkAutoColumnWidth.Checked = False then Exit;

  (Sender as TLazVirtualStringTree).Header.Columns[0].Width :=
    Round(ScreenRatio * 25 / 100);
  X := (VSTBudgets.Width - VSTBudgets.Header.Columns[0].Width) div 100;
  VSTBudgets.Header.Columns[1].Width :=
    VSTBudgets.Width - VSTBudgets.Header.Columns[0].Width - ScrollBarWidth - (25 * X);
  // text
  VSTBudgets.Header.Columns[3].Width := 25 * X; // ID
end;

procedure TfrmBudgets.VSTBudCatBeforeCellPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
begin
  if (Column in [2..7]) and (Node.Index <> 0) then
    TargetCanvas.Brush.Color :=
      Ifthen(Dark = False,
      IfThen(Node.Index mod 2 = 0, Brighten(FullColor, 200), Brighten(FullColor, 230)),
      IfThen(Node.Index mod 2 = 0, RGBToColor(44, 44, 44), RGBToColor(22, 22, 22)))
  else
  begin
    if (Node.Index = 0) or (VSTBudcat.Header.Columns[Column].Tag = 1) then
      TargetCanvas.Brush.Color :=
        Brighten(FullColor, 60)
    else
      TargetCanvas.Brush.Color :=
        IfThen(Node.Index mod 2 = 0, IfThen(Dark = False, clWhite, rgbtoColor(44, 44, 44)),
        IfThen(Dark = False, frmSettings.pnlOddRowColor.Color,
        InvertColor(frmSettings.pnlOddRowColor.Color)));
  end;
  TargetCanvas.FillRect(CellRect);
end;

procedure TfrmBudgets.VSTBudCatGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: boolean; var ImageIndex: integer);
var
  BudCat: PBudCat;
begin
  if Column = 0 then
  begin
    BudCat := VSTBudCat.GetNodeData(Node);
    ImageIndex := BudCat.Level;
  end;
end;

procedure TfrmBudgets.VSTBudCatGetNodeDataSize(Sender: TBaseVirtualTree;
  var NodeDataSize: integer);
begin
  NodeDataSize := SizeOf(TBudCat);
end;

procedure TfrmBudgets.VSTBudCatGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  BudCat: PBudCat;
begin
  if (Column = 0) then Exit;
  try
    BudCat := VSTBudCat.GetNodeData(Node);
    if Assigned(BudCat) then
    begin
      case Column of
        1: CellText := BudCat.Category;  // category
        2: if BudCat.Level = 0 then // subcategory
            CellText := ''
          else
            CellText := IfThen(frmSettings.chkDisplaySubCatCapital.Checked =
              True, AnsiUpperCase(BudCat.SubCategory), BudCat.SubCategory);
        3: CellText := IntToStr(BudCat.CategoryID); // category ID
        else
          case Column mod 4 of
            0:
            try
              //If (VSTBudCat.Tag = 0) then
              CellText := Format('%n', [BudCat.Plan[Column div 4 - 1]], FS_own);
            except
              CellText := '';
            end;
            1:
            try
              //If (VSTBudCat.Tag = 0) then
              CellText := Format('%n', [BudCat.Reality[Column div 4 - 1]], FS_own);
            except
              CellText := '';
            end;
            2:
            try
              //If (VSTBudCat.Tag = 0) then
              CellText := Format('%n', [BudCat.Difference[Column div 4 - 1]], FS_own)
            except
              CellText := '';
            end
            else
            try
              //If (VSTBudCat.Tag = 0) then
              CellText := Format('%n', [BudCat.Ratio[Column div 4 - 1]], FS_own);
            except
              CellText := '';
            end;
          end;
      end;
    end;
  finally
  end;
end;

procedure TfrmBudgets.VSTBudCatPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
begin
  if Node.Index = 0 then
  begin
    TargetCanvas.Font.Color :=
      Ifthen(Dark = False, clYellow, $0000B5BF);
    TargetCanvas.Font.Bold := True;
    Exit;
  end;

  if (Column in [1..7]) then
    TargetCanvas.Font.Color := Ifthen(Dark = False, clDefault, clSilver)
  else if VSTBudCat.Header.Columns[Column].Tag = 1 then
    TargetCanvas.Font.Color := Ifthen(Dark = False, clDefault, clSilver)
  else
    case (Column mod 4) of
      0, 1: TargetCanvas.Font.Color :=
          Ifthen(Dark = False, clDefault, clSilver);
      2: TargetCanvas.Font.Color :=
          Ifthen(Dark = False, clFuchsia, $00C47DC3)
      else
        TargetCanvas.Font.Color :=
          Ifthen(Dark = False, clBlue, clSkyBlue);
    end;

  TargetCanvas.Font.Bold := (Column > 3) and ((Column mod 4) in [0..1]);
  TargetCanvas.Font.Italic := (Column > 3) and ((Column mod 4) = 3);
end;

procedure TfrmBudgets.VSTPeriodsChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  I: byte;
begin
  // update buttons
  btnPeriodEdit.Enabled := VSTPeriods.SelectedCount = 1;
  btnPeriodDelete.Enabled := VSTPeriods.SelectedCount > 0;
  btnPeriodDuplicate.Enabled := VSTPeriods.SelectedCount = 1;

  // update popup
  popPeriodEdit.Enabled := VSTPeriods.SelectedCount = 1;
  popPeriodDelete.Enabled := VSTPeriods.SelectedCount > 0;
  popPeriodDuplicate.Enabled := VSTPeriods.SelectedCount = 1;

  // set images
  if VSTPeriods.SelectedCount = 0 then
  begin
    imgItemPeriods.ImageIndex := -1;
    lblItemPeriods.Caption := '';
  end
  else
  begin
    if VSTPeriods.SelectedCount = VSTPeriods.TotalCount then
    begin
      imgItemPeriods.ImageIndex := 7;
      lblItemPeriods.Caption := '# ' + IntToStr(VSTPeriods.SelectedCount);
    end
    else if VSTPeriods.SelectedCount = 1 then
    begin
      imgItemPeriods.ImageIndex := 5;
      lblItemPeriods.Caption :=
        IntToStr(VSTPeriods.GetFirstSelected(False).Index + 1) + '.';
    end
    else
    begin
      imgItemPeriods.ImageIndex := 6;
      lblItemPeriods.Caption := '# ' + IntToStr(VSTPeriods.SelectedCount);
    end;
  end;

  // =================================================
  // GET CURRENCIES
  // =================================================

  // Get minimal and maximal range of dates (from Periods)
  frmBudgets.tabCurrency.Tag := 1;
  while frmBudgets.tabCurrency.Tabs.Count > 0 do
    frmBudgets.tabCurrency.DeleteTab(0);

  if frmBudgets.VSTPeriods.SelectedCount > 0 then
  begin
    frmMain.QRY.SQL.Text :=
      'SELECT DISTINCT acc_currency FROM data ' + // select
      'LEFT JOIN accounts ON (acc_id = d_account);'; // accounts
    frmMain.QRY.Open;

    I := 0;

    try
      while not (frmMain.QRY.EOF) do
      begin
        frmBudgets.tabCurrency.AddTab(etaLast, True);
        frmBudgets.tabCurrency.Tabs[frmBudgets.tabCurrency.Tabs.Count - 1].Text :=
          frmMain.QRY.Fields[0].AsString;
        if (frmBudgets.tabCurrency.Tabs[frmBudgets.tabCurrency.Tabs.Count - 1].Text) =
          GetMainCurrency then
          I := frmMain.QRY.RecNo - 1;
        frmMain.QRY.Next;
      end;
    finally
      frmMain.QRY.Close;
    end;

    frmBudgets.tabCurrency.Tag := 0;
    if frmBudgets.tabCurrency.Tabs.Count > 0 then
      frmBudgets.tabCurrency.TabIndex := I;
    frmBudgets.tabCurrencyChange(frmBudgets.tabCurrency);
  end;

  lblItemBudCat.Caption := '';
  lblItemsBudCat.Caption := IntToStr(VSTBudCat.RootNodeCount);
end;

procedure TfrmBudgets.VSTPeriodsCompareNodes(Sender: TBaseVirtualTree;
  Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: integer);
var
  Data1, Data2: PPeriods;
begin
  Data1 := Sender.GetNodeData(Node1);
  Data2 := Sender.GetNodeData(Node2);
  case Column of
    1: Result := UTF8CompareText(AnsiLowerCase(Data1.DateFrom),
        AnsiLowerCase(Data2.DateFrom));
    2: Result := UTF8CompareText(AnsiLowerCase(Data1.DateTo),
        AnsiLowerCase(Data2.DateTo));
  end;
end;

procedure TfrmBudgets.VSTPeriodsDblClick(Sender: TObject);
begin
  if VSTPeriods.SelectedCount = 0 then
    popPeriodAddClick(popPeriodAdd)
  else if VSTPeriods.SelectedCount = 1 then
    popPeriodEditClick(popPeriodEdit);
end;

procedure TfrmBudgets.VSTPeriodsGetNodeDataSize(Sender: TBaseVirtualTree;
  var NodeDataSize: integer);
begin
  NodeDataSize := SizeOf(TPeriods);
end;

procedure TfrmBudgets.VSTPeriodsGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  Periods: PPeriods;
begin
  Periods := VSTPeriods.GetNodeData(Node);

  case Column of
    0: if VSTPeriods.Header.SortDirection = sdAscending then
        CellText := IntToStr(Node.Index + 1)
      else
        CellText := IntToStr(VSTPeriods.TotalCount - Node.Index);
    1: CellText := DateToStr(StrToDate(Periods.DateFrom, 'YYYY-MM-DD', '-'));
    2: CellText := DateToStr(StrToDate(Periods.DateTo, 'YYYY-MM-DD', '-'));
  end;
end;

procedure TfrmBudgets.VSTPeriodsResize(Sender: TObject);
var
  X: integer;
begin
  if frmSettings.chkAutoColumnWidth.Checked = False then Exit;

  (Sender as TLazVirtualStringTree).Header.Columns[0].Width :=
    round(ScreenRatio * 25 / 100);
  X := (VSTPeriods.Width - VSTPeriods.Header.Columns[0].Width) div 100;
  VSTPeriods.Header.Columns[0].Width := 20 * X; // Order number
  VSTPeriods.Header.Columns[1].Width :=
    (VSTPeriods.Width - ScrollBarWidth - (20 * X)) div 2; // Date from
  VSTPeriods.Header.Columns[2].Width := VSTPeriods.Header.Columns[1].Width; // Date to
end;

procedure TfrmBudgets.splBudgetCanResize(Sender: TObject; var NewSize: integer;
  var Accept: boolean);
begin
  try
    imgWidth.ImageIndex := 3;
    lblWidth.Caption := IntToStr(pnlBudgets.Width);

    imgHeight.ImageIndex := 2;
    lblHeight.Caption := IntToStr(frmBudgets.Width - tabLeft.Width);

    pnlCategoriesCaption.Repaint;
    pnlBudgetCaption.Repaint;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmBudgets.splPeriodCanResize(Sender: TObject; var NewSize: integer;
  var Accept: boolean);
begin
  tabLeftResize(tabLeft);
end;

procedure TfrmBudgets.VSTBudCatChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
begin
  // set images
  if VSTBudCat.SelectedCount = 0 then
  begin
    imgItemBudCat.ImageIndex := -1;
    lblItemBudCat.Caption := '';
  end
  else
  begin
    if VSTBudCat.SelectedCount = VSTBudCat.TotalCount then
    begin
      imgItemBudCat.ImageIndex := 7;
      lblItemBudCat.Caption := '# ' + IntToStr(VSTBudCat.SelectedCount);
    end
    else if VSTBudCat.SelectedCount = 1 then
    begin
      imgItemBudCat.ImageIndex := 5;
      lblItemBudCat.Caption :=
        IntToStr(VSTBudCat.GetFirstSelected(False).Index + 1) + '.';
    end
    else
    begin
      imgItemBudCat.ImageIndex := 6;
      lblItemBudCat.Caption := '# ' + IntToStr(VSTBudCat.SelectedCount);
    end;
  end;

end;

procedure TfrmBudgets.VSTBudCatCompareNodes(Sender: TBaseVirtualTree;
  Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: integer);
var
  Data1, Data2: PBudCat;
begin
  if ((Sender as TLazVirtualStringTree).AbsoluteIndex(Node1) = 0) or
    ((Sender as TLazVirtualStringTree).AbsoluteIndex(Node2) = 0) then Exit;
  try
    Data1 := Sender.GetNodeData(Node1);
    Data2 := Sender.GetNodeData(Node2);
    case Column of
      1, 2: Result := UTF8CompareText(AnsiLowerCase(Data1.Category + Data1.SubCategory),
          AnsiLowerCase(Data2.Category + Data2.SubCategory));
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmBudgets.VSTBudCatResize(Sender: TObject);
begin
  (Sender as TLazVirtualStringTree).Header.Columns[0].Width :=
    round(ScreenRatio * 25 / 100);
end;

procedure TfrmBudgets.VSTBudgetsBeforeCellPaint(Sender: TBaseVirtualTree;
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

procedure TfrmBudgets.VSTBudgetsChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  Budgets: PBudgets;
begin

  // update buttons
  btnPeriodAdd.Enabled := VSTBudgets.SelectedCount = 1;
  btnBudgetEdit.Enabled := VSTBudgets.SelectedCount = 1;
  btnBudgetDelete.Enabled := VSTBudgets.SelectedCount > 0;
  btnBudgetDuplicate.Enabled := VSTBudgets.SelectedCount = 1;

  // update popup
  popPeriodAdd.Enabled := VSTBudgets.SelectedCount = 1;
  popBudgetEdit.Enabled := VSTBudgets.SelectedCount = 1;
  popBudgetDelete.Enabled := VSTBudgets.SelectedCount > 0;
  popBudgetDuplicate.Enabled := VSTBudgets.SelectedCount = 1;

  // update actions
  actPeriodAdd.Enabled := VSTBudgets.SelectedCount = 1;
  actBudgetEdit.Enabled := VSTBudgets.SelectedCount = 1;
  actBudgetDelete.Enabled := VSTBudgets.SelectedCount > 0;
  actBudgetDuplicate.Enabled := VSTBudgets.SelectedCount = 1;

  UpdatePeriods;
  if VSTPeriods.RootNodeCount = 0 then
    UpdateBudCategories;

  // set images
  if VSTBudgets.SelectedCount = 0 then
  begin
    imgItemBudgets.ImageIndex := -1;
    lblItemsBudgets.Caption := '';
    lblItemBudCat.Caption := '';
    lblItemsBudCat.Caption := IntToStr(VSTBudCat.RootNodeCount);
  end
  else
  begin
    if VSTBudgets.SelectedCount = VSTBudgets.TotalCount then
    begin
      imgItemBudgets.ImageIndex := 7;
      lblItemsBudgets.Caption := '# ' + IntToStr(VSTBudgets.SelectedCount);
    end
    else if VSTBudgets.SelectedCount = 1 then
    begin
      imgItemBudgets.ImageIndex := 5;
      lblItemsBudgets.Caption :=
        IntToStr(VSTBudgets.GetFirstSelected(False).Index + 1) + '.';
    end
    else
    begin
      imgItemBudgets.ImageIndex := 6;
      lblItemsBudgets.Caption := '# ' + IntToStr(VSTBudgets.SelectedCount);
    end;
  end;

  if VSTBudgets.SelectedCount <> 1 then
    Exit;

  VSTPeriods.SelectAll(False);

  // get budget name
  Budgets := VSTBudgets.GetNodeData(VSTBudgets.GetFirstSelected());
  pnlBudgetCaption.Visible := True;
  pnlBudgetCaption.Caption := Budgets.Name;

  if Budgets.Kind = 0 then
    VSTBudCat.Header.Columns[2].Options :=
      VSTBudCat.Header.Columns[2].Options - [coVisible]
  else
    VSTBudCat.Header.Columns[2].Options :=
      VSTBudCat.Header.Columns[2].Options + [coVisible];
end;

procedure TfrmBudgets.VSTBudgetsCompareNodes(Sender: TBaseVirtualTree;
  Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: integer);
var
  Data1, Data2: PBudgets;
begin
  Data1 := Sender.GetNodeData(Node1);
  Data2 := Sender.GetNodeData(Node2);
  case Column of
    1: Result := UTF8CompareText(AnsiLowerCase(Data1.Name), AnsiLowerCase(Data2.Name));
  end;
end;

procedure TfrmBudgets.VSTBudgetsDblClick(Sender: TObject);
begin
  if VSTBudgets.SelectedCount = 0 then
    popBudgetAddClick(popBudgetAdd)
  else if VSTBudgets.SelectedCount = 1 then
    popBudgetEditClick(popBudgetEdit);
end;

procedure TfrmBudgets.VSTBudgetsEnter(Sender: TObject);
begin
  if (VSTBudgets.SelectedCount = 0) and (VSTBudgets.RootNodeCount > 0) then
  begin
    VSTBudgets.Selected[VSTBudgets.GetFirst()] := True;
    VSTBudgets.FocusedNode := VSTBudgets.GetFirst();
  end;
end;

procedure TfrmBudgets.VSTBudgetsGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: boolean; var ImageIndex: integer);
var
  Budgets: PBudgets;
begin
  if Column = 0 then
  begin
    Budgets := VSTBudgets.GetNodeData(Node);
    ImageIndex := Budgets.Kind;
  end;
end;

procedure TfrmBudgets.VSTBudgetsGetNodeDataSize(Sender: TBaseVirtualTree;
  var NodeDataSize: integer);
begin
  NodeDataSize := SizeOf(TBudgets);
end;

procedure TfrmBudgets.VSTBudgetsGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  Budgets: PBudgets;
begin
  if Column = 0 then Exit;
  Budgets := Sender.GetNodeData(Node);
  case Column of
    1: CellText := Budgets.Name;
    2: CellText := IntToStr(Budgets.Kind);
    3: CellText := IntToStr(Budgets.ID);
  end;
end;

procedure TfrmBudgets.VSTBudgetsPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
begin
  TargetCanvas.Font.Color :=
    IfThen(Dark = False, clDefault, clSilver);
end;

procedure TfrmBudgets.btnExitClick(Sender: TObject);
begin
  frmBudgets.ModalResult := mrCancel;
end;

procedure TfrmBudgets.popBudgetAddClick(Sender: TObject);
var
  Node: PVirtualNode;
  X: integer;
begin
  if (frmMain.Conn.Connected = False) then
    Exit;

  if tabLeft.TabIndex = 1 then
  begin
    popPeriodAddClick(popPeriodAdd);
    Exit;
  end;

  try
    frmBudget.Caption := AnsiUpperCase(Caption_45);
    frmBudget.ediName.Clear;
    frmBudget.Tag := 0;
    if popBudgetAdd.Tag = 0 then
      frmBudget.rbtCategories.Checked := True
    else
    begin
      if VSTBudgets.Text[VSTBudgets.GetFirstSelected(), 2] = '0' then
        frmBudget.rbtSubcategories.Checked := True
      else
        frmBudget.rbtCategories.Checked := True;
    end;

    if frmBudget.ShowModal <> mrOk then Exit;

    // ==================================================================================
    // SAVE BUDGET NAME
    // ==================================================================================
    frmMain.QRY.SQL.Text :=
      'INSERT OR IGNORE INTO budgets (bud_name, bud_type) VALUES (:NAME, :TYPE);';
    frmMain.QRY.Params.ParamByName('NAME').AsString := frmBudget.ediName.Text;
    frmMain.QRY.Params.ParamByName('TYPE').AsInteger :=
      IfThen(frmBudget.rbtCategories.Checked = True, 0, 1);
    frmMain.QRY.Prepare;
    frmMain.QRY.ExecSQL;
    frmMain.Tran.Commit;

    // ==================================================================================
    // SAVE CATEGORIES
    // ==================================================================================

    X := frmMain.Conn.GetInsertID;
    Node := frmBudget.VST.GetFirstChecked(csCheckedNormal, False);
    frmMain.Tran.Commit;
    frmMain.Tran.StartTransaction;
    while Assigned(Node) do
      if Node.CheckState = csCheckedNormal then
      begin
        frmMain.QRY.SQL.Text :=
          'INSERT OR IGNORE INTO budget_categories (budcat_category, budcat_bud_id) VALUES (:CAT, :ID);';

        // category
        frmMain.QRY.Params.ParamByName('CAT').AsString := frmBudget.VST.Text[Node, 2];
        // ID
        frmMain.QRY.Params.ParamByName('ID').AsInteger := X;
        frmMain.QRY.Prepare;
        frmMain.QRY.ExecSQL;
        Node := frmBudget.VST.GetNextChecked(Node, False);
      end;

    frmMain.Tran.Commit;

    UpdateBudgets;
    FindNewRecord(VSTBudgets, 3);

    ShowMessage(Hint_62);
    if (btnPeriodAdd.Enabled = True) and (popBudgetAdd.Tag = 0) then
    begin
      tabLeft.TabIndex := 1;
      btnPeriodAdd.SetFocus;
    end;
  finally
  end;
end;

procedure TfrmBudgets.actPeriodDeleteExecute(Sender: TObject);
begin
  popPeriodDeleteClick(popPeriodDelete);
end;

procedure TfrmBudgets.btnCopyClick(Sender: TObject);
begin
  if (frmMain.Conn.Connected = False) then
    Exit;
  CopyVST(VSTBudCat);
end;

procedure TfrmBudgets.btnSettingsClick(Sender: TObject);
var
  vNode: TTreeNode;
begin
  for vNode in frmSettings.treSettings.Items do
  begin
    if vNode.AbsoluteIndex = 7 then
      vNode.Selected := True;
  end;
  frmSettings.tabTool.TabIndex := 2;
  frmSettings.ShowModal;
end;

procedure TfrmBudgets.pnlBottom1Resize(Sender: TObject);
begin
  pnlItemsBudgets.Width := pnlBottom1.Width div 2;
end;

procedure TfrmBudgets.pnlBottom2Resize(Sender: TObject);
begin
  pnlItemPeriods.Width := pnlBottom2.Width div 2;
  pnlItemBudgets.Width := pnlBottom2.Width div 2;
end;

procedure TfrmBudgets.pnlBudgetsResize(Sender: TObject);
begin
  tabLeftResize(tabLeft);
end;

procedure TfrmBudgets.tabCurrencyChange(Sender: TObject);
begin
  VSTBudCat.Clear;
  VSTBudCat.RootNodeCount := 0;

  if tabCurrency.TabIndex = -1 then
    exit;

  if (frmBudgets.tabCurrency.Tag = 1) or (tabCurrency.Tabs.Count = 0) or
    (tabCurrency.TabIndex = -1) or (tabCurrency.Tabs[tabCurrency.TabIndex].Text = '') or
    (VSTBudgets.SelectedCount = 0) or (VSTPeriods.SelectedCount = 0) then
    Exit;

  try
    UpdateBudCategories;
  except
  end;
end;

procedure TfrmBudgets.tabLeftChange(Sender: TObject);
begin
  case tabLeft.TabIndex of
    0: VSTBudgets.SetFocus;
    1: begin
      VSTPeriods.SetFocus;
      if (VSTBudgets.SelectedCount = 1) and (VSTPeriods.RootNodeCount > 0) then
        VSTPeriods.SelectAll(False);
    end
  end;
end;

{procedure TfrmBudgets.tabLeftChanging(Sender: TObject; var AllowChange: boolean);
begin
  if (VSTBudgets.SelectedCount <> 1) then
    AllowChange := False;
end;}

procedure TfrmBudgets.tabLeftResize(Sender: TObject);
begin
  // repaint budgets
  btnBudgetAdd.Repaint;
  btnBudgetEdit.Repaint;
  btnBudgetDuplicate.Repaint;
  btnBudgetDelete.Repaint;

  // repaint periods
  btnPeriodAdd.Repaint;
  btnPeriodEdit.Repaint;
  btnPeriodDuplicate.Repaint;
  btnPeriodDelete.Repaint;
end;

procedure TfrmBudgets.popBudgetEditClick(Sender: TObject);
var
  Budgets: PBudgets;
  Budget: PBudget;
  Node: PVirtualNode;
begin
  if VSTBudgets.SelectedCount <> 1 then
    Exit;

  if tabLeft.TabIndex = 1 then
  begin
    if (VSTPeriods.SelectedCount <> 1) then Exit;
    popPeriodEditClick(popPeriodEdit);
    Exit;
  end;

  frmBudget.Tag := 1;
  Budgets := VSTBudgets.GetNodeData(VSTBudgets.GetFirstSelected());
  VSTBudgets.Tag := Budgets.ID;
  frmBudget.ediName.Text := Budgets.Name;
  frmBudget.Caption := AnsiUpperCase(Caption_46);

  if Budgets.Kind = 0 then
    frmBudget.rbtCategories.Checked := True
  else
    frmBudget.rbtSubCategories.Checked := True;

  if frmBudget.ShowModal <> mrOk then
  begin
    VSTBudgets.SetFocus;
    Exit;
  end;

  // ==================================================================================
  // SAVE BUDGET NAME
  // ==================================================================================
  frmMain.QRY.SQL.Text :=
    'UPDATE OR IGNORE budgets SET bud_name = :NAME, bud_type = :TYPE WHERE bud_id = :ID';
  frmMain.QRY.Params.ParamByName('NAME').AsString := frmBudget.ediName.Text;
  frmMain.QRY.Params.ParamByName('TYPE').AsInteger :=
    IfThen(frmBudget.rbtCategories.Checked = True, 0, 1);

  frmMain.QRY.Params.ParamByName('ID').AsInteger := Budgets.ID;
  frmMain.QRY.Prepare;
  frmMain.QRY.ExecSQL;
  frmMain.Tran.Commit;

  // ==================================================================================
  // SAVE CATEGORIES
  // ==================================================================================
  // delete all previous checked categories (now unchecked)
  frmMain.Tran.StartTransaction;
  Node := frmBudget.VST.GetFirst();
  while Assigned(Node) do
  begin
    Budget := frmBudget.VST.GetNodeData(Node);

    if (Node.CheckState = csUncheckedNormal) and (Budget.Checked = True) then
    begin
      frmMain.QRY.SQL.Text :=
        'DELETE FROM budget_categories ' + // delete
        'WHERE budcat_category = :ID1 AND budcat_bud_id = :ID2;';
      frmMain.QRY.Params.ParamByName('ID1').AsInteger := Budget.ID;
      frmMain.QRY.Params.ParamByName('ID2').AsInteger := Budgets.ID;
      frmMain.QRY.Prepare;
      frmMain.QRY.ExecSQL;
    end;

    if (Node.CheckState = csCheckedNormal) and (Budget.Checked = False) then
    begin
      frmMain.QRY.SQL.Text :=
        'INSERT OR IGNORE INTO budget_categories (budcat_category, budcat_bud_id) VALUES (:CAT, :ID);';
      // category
      frmMain.QRY.Params.ParamByName('CAT').AsString := frmBudget.VST.Text[Node, 2];
      // ID
      frmMain.QRY.Params.ParamByName('ID').AsInteger := Budgets.ID;
      frmMain.QRY.Prepare;
      frmMain.QRY.ExecSQL;
    end;
    Node := frmBudget.VST.GetNext(Node);
  end;

  frmMain.Tran.Commit;
  UpdateBudgets;
  FindEditedRecord(VSTBudgets, 3, VSTBudgets.Tag);
end;

procedure TfrmBudgets.popBudgetDeleteClick(Sender: TObject);
var
  IDs: string;
  N: PVirtualNode;
  Budgets: PBudgets;
begin
  try
    if (frmMain.Conn.Connected = False) or (vSTBudgets.RootNodeCount = 0) or
      (VSTBudgets.SelectedCount = 0) then
      exit;
    case VSTBudgets.SelectedCount of
      1: if MessageDlg(Message_00, Question_01 + sLineBreak +
          sLineBreak + VSTBudgets.Header.Columns[1].Text + ': ' +
          VSTBudgets.Text[VSTBudgets.FocusedNode, 1], mtConfirmation,
          mbYesNo, 0) <> 6 then
          Exit;
      else
        if MessageDlg(Message_00, AnsiReplaceStr(Question_02, '%',
          IntToStr(VSTBudgets.SelectedCount)), mtConfirmation, mbYesNo, 0) <> 6 then
          Exit;
    end;
    if MessageDlg(Message_00, AnsiReplaceStr(Question_23, '%',
      IntToStr(VSTBudgets.SelectedCount)), mtConfirmation, mbYesNo, 0) <> 6 then
      Exit;

    // get IDs of all selected nodes
    IDs := '';
    N := VSTBudgets.GetFirstSelected(False);
    try
      while Assigned(N) do
      begin
        Budgets := VSTBudgets.GetNodeData(N);
        IDs := IDs + IntToStr(Budgets.ID) + ',';
        N := VSTBudgets.GetNextSelected(N);
      end;
    finally
      IDs := LeftStr(IDs, Length(IDs) - 1);
    end;


    frmMain.QRY.SQL.Text := 'DELETE FROM budgets WHERE bud_id IN (' + IDs + ')';
    frmMain.QRY.ExecSQL;
    frmMain.Tran.Commit;

    UpdateBudgets;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmBudgets.popBudgetDuplicateClick(Sender: TObject);
begin
  popBudgetAdd.Tag := 1;
  popBudgetAddClick(popBudgetAdd);
  popBudgetAdd.Tag := 0;
end;

procedure TfrmBudgets.FormCreate(Sender: TObject);
begin
  try
    // set components height
    VSTBudgets.Header.Height := PanelHeight;
    VSTPeriods.Header.Height := PanelHeight;
    VSTBudCat.Header.Height := PanelHeight;
    pnlCategoriesCaption.Height := PanelHeight;
    pnlBudgetCaption.Height := PanelHeight;

    pnlButtons.Height := ButtonHeight;
    pnlBottom.Height := ButtonHeight;
    pnlBottom1.Height := ButtonHeight;
    pnlBottom2.Height := ButtonHeight;

    // get form icon
    frmMain.img16.GetIcon(21, (Sender as TForm).Icon);
  except
  end;
end;

procedure TfrmBudgets.FormResize(Sender: TObject);
begin
  imgWidth.ImageIndex := 0;
  lblWidth.Caption := IntToStr(frmBudgets.Width);
  imgHeight.ImageIndex := 1;
  lblHeight.Caption := IntToStr(frmBudgets.Height);

  pnlCategoriesCaption.Repaint;
  pnlBudgetCaption.Repaint;
end;

procedure TfrmBudgets.FormShow(Sender: TObject);
begin
  btnBudgetAdd.Enabled := frmMain.Conn.Connected = True;
  popBudgetAdd.Enabled := frmMain.Conn.Connected = True;
  popPeriodAdd.Enabled := (frmMain.Conn.Connected = True) and
    (VSTBudgets.SelectedCount = 1);

  tabLeft.tabIndex := 0;

  if (VSTBudgets.RootNodeCount > 0) or (frmMain.Conn.Connected = False) then
    VSTBudgets.SetFocus
  else
    btnBudgetAdd.SetFocus;
end;

procedure TfrmBudgets.popPeriodDeleteClick(Sender: TObject);
var
  N: PVirtualNode;
  Periods: PPeriods;
  Budgets: PBudgets;
begin
  try
    if (frmMain.Conn.Connected = False) or (VSTPeriods.RootNodeCount = 0) or
      (VSTPeriods.SelectedCount = 0) then
      exit;
    case VSTPeriods.SelectedCount of
      1: if MessageDlg(Message_00, Question_01 + sLineBreak +
          sLineBreak + VSTPeriods.Header.Columns[1].Text + ': ' +
          VSTPeriods.Text[VSTPeriods.GetFirstSelected(), 1] +
          sLineBreak + VSTPeriods.Header.Columns[2].Text + ': ' +
          VSTPeriods.Text[VSTPeriods.GetFirstSelected(), 2], mtConfirmation,
          mbYesNo, 0) <> 6 then
          Exit;
      else
        if MessageDlg(Message_00, AnsiReplaceStr(Question_02, '%',
          IntToStr(VSTPeriods.SelectedCount)), mtConfirmation, mbYesNo, 0) <> 6 then
          Exit;
    end;

    Budgets := VSTBudgets.GetNodeData(VSTBudgets.GetFirstSelected());
    frmMain.Tran.Commit;
    frmMain.Tran.StartTransaction;
    N := VSTPeriods.GetFirstSelected(False);
    try
      while Assigned(N) do
      begin
        Periods := VSTPeriods.GetNodeData(N);
        frmMain.QRY.SQL.Text := 'DELETE FROM budget_periods ' + // delete
          'WHERE budper_date1 = :DATE1 AND budper_date2 = :DATE2 ' +
          'AND budper_bud_id = :ID;';
        frmMain.QRY.Params.ParamByName('DATE1').AsString := Periods.DateFrom;
        frmMain.QRY.Params.ParamByName('DATE2').AsString := Periods.DateTo;
        frmMain.QRY.Params.ParamByName('ID').AsInteger := Budgets.ID;
        frmMain.QRY.Prepare;
        frmMain.QRY.ExecSQL;
        N := VSTPeriods.GetNextSelected(N);
      end;
    finally
      frmMain.Tran.Commit;
    end;

    UpdatePeriods;

  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmBudgets.popPeriodAddClick(Sender: TObject);
var
  N: PVirtualNode;
  Budgets: PBudgets;
  BudPer: PBudPer;
begin
  try
    if (popPeriodAdd.Enabled = False) then Exit;

    frmPeriod.Caption := AnsiUpperCase(Caption_45);
    frmPeriod.Tag := 0;
    frmPeriod.datDateFrom.Date := EncodeDate(YearOf(now), MonthOf(now), 1);
    frmPeriod.datDateTo.Date :=
      EncodeDate(YearOf(now), MonthOf(now), DaysInAMonth(YearOf(now), MonthOf(now)));

    if frmPeriod.ShowModal <> mrOk then
      Exit;

    frmMain.Tran.Commit;
    frmMain.Tran.StartTransaction;

    N := frmPeriod.VST.GetFirst();
    while Assigned(N) do
    begin
      BudPer := frmPeriod.VST.GetNodeData(N);
      begin
        Budgets := VSTBudgets.GetNodeData(VSTBudgets.GetFirstSelected());
        frmMain.QRY.SQL.Text :=
          'INSERT OR IGNORE INTO budget_periods (budper_date1, budper_date2, budper_sum, '
          + 'budper_bud_id, budper_cat_id) VALUES (:DATE1, :DATE2, :SUM, :ID, :CAT);';

        // date1
        frmMain.QRY.Params.ParamByName('DATE1').AsString :=
          FormatDateTime('YYYY-MM-DD', frmPeriod.datDateFrom.Date);
        // date2
        frmMain.QRY.Params.ParamByName('DATE2').AsString :=
          FormatDateTime('YYYY-MM-DD', frmPeriod.datDateTo.Date);
        // amount
        frmMain.QRY.Params.ParamByName('SUM').AsString :=
          AnsiReplaceStr(FloatToStr(BudPer.Plan), FS_own.DecimalSeparator, '.');
        // category
        frmMain.QRY.Params.ParamByName('CAT').AsInteger := BudPer.CategoryID;
        // ID
        frmMain.QRY.Params.ParamByName('ID').AsInteger := Budgets.ID;
        frmMain.QRY.Prepare;
        frmMain.QRY.ExecSQL;
      end;
      N := frmPeriod.VST.GetNext(N);
    end;
  finally
    frmMain.Tran.Commit;
    UpdatePeriods;
  end;
end;

procedure TfrmBudgets.popPeriodEditClick(Sender: TObject);
var
  Periods: PPeriods;
  BudPer: PBudPer;
  N: PVirtualNode;
  CategoryExists: boolean;
begin
  if (VSTBudgets.SelectedCount <> 1) then Exit;

  // set date
  frmPeriod.Tag := 1;
  Periods := VSTPeriods.GetNodeData(VSTPeriods.GetFirstSelected());
  VSTPeriods.Tag := StrToInt(VSTPeriods.Text[VSTPeriods.GetFirstSelected(), 0]);
  frmPeriod.datDateFrom.Date := StrToDate(Periods.DateFrom, 'YYYY-MM-DD', '-');
  frmPeriod.datDateTo.Date := StrToDate(Periods.DateTo, 'YYYY-MM-DD', '-');
  frmPeriod.Caption := AnsiUpperCase(Caption_46);

  if frmPeriod.ShowModal <> mrOk then
  begin
    VSTPeriods.SetFocus;
    Exit;
  end;

  N := frmPeriod.VST.GetFirst();
  while Assigned(N) do
  begin
    BudPer := frmPeriod.VST.GetNodeData(N);
    // ===============================
    // FIND OUT IF CATEGORY EXISTS
    // ===============================
    frmMain.QRY.SQL.Text := 'SELECT COUNT(*) FROM budget_periods ' + // select
      'WHERE budper_date1 = :DATE3 AND ' + // date1
      'budper_date2 = :DATE4 AND ' + // date2
      'budper_bud_id = :ID AND ' + // budget id
      'budper_cat_id = :CAT;';  // cat_id

    // date3
    frmMain.QRY.Params.ParamByName('DATE3').AsString := Periods.DateFrom;
    // date4
    frmMain.QRY.Params.ParamByName('DATE4').AsString := Periods.DateTo;
    // ID
    frmMain.QRY.Params.ParamByName('ID').AsString :=
      VSTBudgets.Text[VSTBudgets.GetFirstSelected(), 3];
    // category ID
    frmMain.QRY.Params.ParamByName('CAT').AsInteger := BudPer.CategoryID;
    frmMain.QRY.Prepare;
    frmMain.QRY.Open;
    CategoryExists := frmMain.QRY.Fields[0].AsInteger > 0;
    frmMain.QRY.Close;


    // ===============================
    // CREATE PLAN (if does not exists
    // ===============================
    if CategoryExists = False then
      frmMain.QRY.SQL.Text :=
        'INSERT INTO budget_periods (budper_date1, budper_date2, budper_sum, budper_bud_id, budper_cat_id) VALUES ('
        + ':DATE1, :DATE2, :SUM, :ID, :CAT);'

    // ===============================
    // UPDATE PLAN (if exists)
    // ===============================
    else
    begin
      frmMain.QRY.SQL.Text :=
        'UPDATE OR IGNORE budget_periods SET ' + // update
        'budper_date1 = :DATE1, ' + // date1
        'budper_date2 = :DATE2, ' + // date2
        'budper_sum = :SUM, ' + // amount
        'budper_bud_id = :ID, ' + // budget id
        'budper_cat_id = :CAT ' + // cat_id
        'WHERE ' + // where
        'budper_date1 = :DATE3 AND ' + // date1
        'budper_date2 = :DATE4 AND ' + // date2
        'budper_bud_id = :ID AND ' + // budget id
        'budper_cat_id = :CAT;';

      // date3
      frmMain.QRY.Params.ParamByName('DATE3').AsString := Periods.DateFrom;
      // date4
      frmMain.QRY.Params.ParamByName('DATE4').AsString := Periods.DateTo;

    end;

    // date1
    frmMain.QRY.Params.ParamByName('DATE1').AsString :=
      FormatDateTime('YYYY-MM-DD', frmPeriod.datDateFrom.Date);
    // date2
    frmMain.QRY.Params.ParamByName('DATE2').AsString :=
      FormatDateTime('YYYY-MM-DD', frmPeriod.datDateTo.Date);
    // amount
    frmMain.QRY.Params.ParamByName('SUM').AsString :=
      AnsiReplaceStr(FloatToStr(BudPer.Plan), FS_own.DecimalSeparator, '.');
    // ID
    frmMain.QRY.Params.ParamByName('ID').AsString :=
      VSTBudgets.Text[VSTBudgets.GetFirstSelected(), 3];
    // category ID
    frmMain.QRY.Params.ParamByName('CAT').AsInteger := BudPer.CategoryID;

    frmMain.QRY.Prepare;
    frmMain.QRY.ExecSQL;
    N := frmPeriod.VST.GetNext(N);
  end;
  frmMain.Tran.Commit;

  UpdatePeriods;
  FindEditedRecord(VSTPeriods, 0, VSTPeriods.Tag);
end;

procedure TfrmBudgets.popPeriodDuplicateClick(Sender: TObject);
begin
  if VSTPeriods.SelectedCount <> 1 then
    Exit;

  popPeriodAdd.Tag := 1;
  popPeriodAddClick(popPeriodAdd);
end;

procedure UpdateBudgets;
var
  P: PVirtualNode;
  Budgets: PBudgets;
begin
  frmBudgets.VSTBudgets.BeginUpdate;
  frmBudgets.VSTBudCat.BeginUpdate;


  frmBudgets.VSTBudgets.Clear;
  frmBudgets.VSTBudCat.Clear;

  // =============================================================================================
  // update list of periods in frmPeriods
  if frmMain.Conn.Connected = True then
  begin
    frmMain.QRY.SQL.Text := 'SELECT bud_name, bud_type, bud_id FROM budgets;';
    frmMain.QRY.Open;

    while not (frmMain.QRY.EOF) do
    begin
      frmBudgets.VSTBudgets.RootNodeCount := frmBudgets.VSTBudgets.RootNodeCount + 1;
      P := frmBudgets.VSTBudgets.GetLast();
      Budgets := frmBudgets.VSTBudgets.GetNodeData(P);
      Budgets.Name := frmMain.QRY.Fields[0].AsString;
      Budgets.Kind := frmMain.QRY.Fields[1].AsInteger;
      Budgets.ID := frmMain.QRY.Fields[2].AsInteger;
      frmMain.QRY.Next;
    end;
    frmMain.QRY.Close;
  end;

  // sort budgets
  frmBudgets.VSTBudgets.SortTree(1, sdAscending, True);
  SetNodeHeight(frmBudgets.VSTBudgets);
  frmBudgets.VSTBudgets.EndUpdate;
  frmBudgets.VSTBudCat.EndUpdate;

  // update budget buttons
  frmBudgets.btnBudgetEdit.Enabled := False;
  frmBudgets.btnBudgetDuplicate.Enabled := False;
  frmBudgets.btnBudgetDelete.Enabled := False;

  // update budget popup
  frmBudgets.popBudgetEdit.Enabled := False;
  frmBudgets.popBudgetDuplicate.Enabled := False;
  frmBudgets.popBudgetDelete.Enabled := False;

  frmBudgets.lblItemsBudgets.Caption := IntToStr(frmBudgets.VSTBudgets.RootNodeCount);
  frmBudgets.lblItemBudgets.Caption := '';

  if (frmBudgets.Visible = True) and (frmBudgets.tabLeft.TabIndex = 0) then
    frmBudgets.VSTBudgets.SetFocus;
end;

procedure UpdatePeriods;
var
  P: PVirtualNode;
  Periods: PPeriods;
  Budgets: PBudgets;
begin
  frmBudgets.VSTPeriods.Clear;
  frmBudgets.VSTPeriods.RootNodeCount := 0;

  frmBudgets.VSTBudCat.Clear;
  frmBudgets.VSTBudCat.RootNodeCount := 0;
  frmBudgets.btnCopy.Enabled := False;

  if frmBudgets.VSTBudgets.SelectedCount <> 1 then
    Exit;

  frmBudgets.VSTPeriods.BeginUpdate;
  Budgets := frmBudgets.VSTBudgets.GetNodeData(frmBudgets.VSTBudgets.GetFirstSelected());

  // =============================================================================================
  // update list of periods in frmPeriods
  if frmMain.Conn.Connected = False then
    Exit;

  frmMain.QRY.SQL.Text :=
    'SELECT DISTINCT budper_date1, budper_date2 ' + // select
    'FROM budget_periods ' + // from
    'WHERE budper_bud_id = :ID ' + // where
    'ORDER BY budper_date1 ASC;'; // order
  frmMain.QRY.Params.ParamByName('ID').AsInteger := Budgets.ID;
  frmMain.QRY.Prepare;
  frmMain.QRY.Open;

  while not (frmMain.QRY.EOF) do
  begin
    frmBudgets.VSTPeriods.RootNodeCount := frmBudgets.VSTPeriods.RootNodeCount + 1;
    P := frmBudgets.VSTPeriods.GetLast();
    Periods := frmBudgets.VSTPeriods.GetNodeData(P);
    Periods.DateFrom := frmMain.QRY.Fields[0].AsString;
    Periods.DateTo := frmMain.QRY.Fields[1].AsString;
    frmMain.QRY.Next;
  end;
  frmMain.QRY.Close;

  SetNodeHeight(frmBudgets.VSTPeriods);
  frmBudgets.VSTPeriods.EndUpdate;

  // update period buttons
  frmBudgets.btnPeriodEdit.Enabled := False;
  frmBudgets.btnPeriodDuplicate.Enabled := False;
  frmBudgets.btnPeriodDelete.Enabled := False;

  // update period buttons
  frmBudgets.popPeriodEdit.Enabled := False;
  frmBudgets.popPeriodDuplicate.Enabled := False;
  frmBudgets.popPeriodDelete.Enabled := False;

  frmBudgets.lblItemsPeriods.Caption := IntToStr(frmBudgets.VSTPeriods.RootNodeCount);
  frmBudgets.lblItemPeriods.Caption := '';

  frmBudgets.VSTPeriods.SelectAll(False);
end;

procedure UpdateBudCategories;
var
  I, J: integer;
  Plan, Reality: double;
  B, P: PVirtualNode;
  Periods: PPeriods;
  BudCat, SumRow: PBudCat;
  Budgets: PBudgets;
  Q: TSQLQuery;
begin
  frmBudgets.VSTBudCat.Clear;
  frmBudgets.VSTBudCat.RootNodeCount := 0;

  // delete columns over 3
  while frmBudgets.VSTBudCat.Header.Columns.Count > 4 do
    frmBudgets.VSTBudCat.Header.Columns.Delete(4);

  if (frmBudgets.VSTBudgets.SelectedCount <> 1) or (frmMain.Conn.Connected = False) then
  begin
    frmBudgets.VSTBudCat.EndUpdate;
    Exit;
  end;

  frmBudgets.VSTBudCat.BeginUpdate;

  // ============================================================================
  // HANDLE COLUMNS
  // ============================================================================

  if frmBudgets.VSTPeriods.SelectedCount > 0 then
  begin
    P := frmBudgets.VSTPeriods.GetFirstSelected();
    J := 0;
    while Assigned(P) do
    begin
      // ---------------------------------------------------------------------------
      // add budget column
      frmBudgets.VSTBudCat.Header.Columns.Add;
      frmBudgets.VSTBudCat.Header.Columns[3 + (J * 4) + 1].Width := 90;
      frmBudgets.VSTBudCat.Header.Columns[3 + (J * 4) + 1].Alignment :=
        taRightJustify;
      frmBudgets.VSTBudCat.Header.Columns[3 + (J * 4) + 1].Text :=
        '[' + IntToStr(P.Index + 1) + '] ';
      frmBudgets.VSTBudCat.Header.Columns[3 + (J * 4) + 1].ImageIndex := 0;

      // add reality column
      frmBudgets.VSTBudCat.Header.Columns.Add;
      frmBudgets.VSTBudCat.Header.Columns[3 + (J * 4) + 2].Width := 90;
      frmBudgets.VSTBudCat.Header.Columns[3 + (J * 4) + 2].Alignment :=
        taRightJustify;
      frmBudgets.VSTBudCat.Header.Columns[3 + (J * 4) + 2].Text :=
        '[' + IntToStr(P.Index + 1) + '] ';
      frmBudgets.VSTBudCat.Header.Columns[3 + (J * 4) + 2].ImageIndex := 1;

      // add difference column
      frmBudgets.VSTBudCat.Header.Columns.Add;
      frmBudgets.VSTBudCat.Header.Columns[3 + (J * 4) + 3].Width := 90;
      frmBudgets.VSTBudCat.Header.Columns[3 + (J * 4) + 3].Alignment :=
        taRightJustify;
      frmBudgets.VSTBudCat.Header.Columns[3 + (J * 4) + 3].Text :=
        '[' + IntToStr(P.Index + 1) + '] ';
      if frmSettings.chkShowDifference.Checked = True then
        frmBudgets.VSTBudCat.Header.Columns[3 + (J * 4) + 3].Options :=
          frmBudgets.VSTBudCat.Header.Columns[3 + (J * 4) + 3].Options - [covisible];
      frmBudgets.VSTBudCat.Header.Columns[3 + (J * 4) + 3].ImageIndex := 2;

      // add ratio column
      frmBudgets.VSTBudCat.Header.Columns.Add;
      frmBudgets.VSTBudCat.Header.Columns[3 + (J * 4) + 4].Width := 60;
      frmBudgets.VSTBudCat.Header.Columns[3 + (J * 4) + 4].Alignment :=
        taRightJustify;
      frmBudgets.VSTBudCat.Header.Columns[3 + (J * 4) + 4].Text :=
        '[' + IntToStr(P.Index + 1) + '] ';
      if frmSettings.chkShowIndex.Checked = True then
        frmBudgets.VSTBudCat.Header.Columns[3 + (J * 4) + 4].Options :=
          frmBudgets.VSTBudCat.Header.Columns[3 + (J * 4) + 4].Options - [covisible];
      frmBudgets.VSTBudCat.Header.Columns[3 + (J * 4) + 4].ImageIndex := 3;
      P := frmBudgets.VSTPeriods.GetNextSelected(P);
      Inc(J);
    end;
  end;

  // ============================================================================
  // HANDLE DATA HEADER
  // ============================================================================
  Budgets := frmBudgets.VSTBudgets.GetNodeData(
    frmBudgets.VSTBudgets.GetFirstSelected());
  frmMain.QRY.SQL.Text := 'SELECT ' +
    '(SELECT cat_parent_name FROM categories WHERE cat_id = budcat_category) as category, '
    + '(SELECT cat_name FROM categories WHERE cat_id = budcat_category) as subcategory, '
    + '(SELECT bud_type FROM budgets WHERE bud_id = :ID) as level, ' + // level
    'budcat_category, ' + // category ID
    'budcat_bud_id ' + // budget ID
    'FROM budget_categories ' + // from
    'WHERE budcat_bud_id = :ID';
  frmMain.QRY.Params.ParamByName('ID').AsInteger := Budgets.ID;
  frmMain.QRY.Prepare;
  frmMain.QRY.Open;
  try
    while not (frmMain.QRY.EOF) do
    begin
      frmBudgets.VSTBudCat.RootNodeCount := frmBudgets.VSTBudCat.RootNodeCount + 1;
      B := frmBudgets.VSTBudCat.GetLast();
      BudCat := frmBudgets.VSTBudCat.GetNodeData(B);

      setLength(BudCat.Plan, frmBudgets.VSTPeriods.SelectedCount + 1);
      setLength(BudCat.Reality, frmBudgets.VSTPeriods.SelectedCount + 1);
      setLength(BudCat.Difference, frmBudgets.VSTPeriods.SelectedCount + 1);
      setLength(BudCat.Ratio, frmBudgets.VSTPeriods.SelectedCount + 1);

      BudCat.Category := AnsiUpperCase(frmMain.QRY.Fields[0].AsString); // category
      BudCat.SubCategory := frmMain.QRY.Fields[1].AsString; // subcategory
      BudCat.Level := frmMain.QRY.Fields[2].AsInteger; // level
      BudCat.CategoryID := frmMain.QRY.Fields[3].AsInteger; // category ID
      BudCat.BudgetID := frmMain.QRY.Fields[4].AsInteger; // budget ID

      // ============================================================================
      // HANDLE SUBDATA
      // ============================================================================
      if frmBudgets.VSTPeriods.SelectedCount > 0 then
      begin
        Q := TSQLQuery.Create(nil);
        Q.Transaction := frmMain.Tran;
        Q.Database := frmMain.Tran.DataBase;

        P := frmBudgets.VSTPeriods.GetFirstSelected();
        J := 1;
        while Assigned(P) do
        begin
          Plan := 0.0;
          Reality := 0.0;

          Periods := frmBudgets.VSTPeriods.GetNodeData(P);

          Q.SQL.Text :=
            'SELECT Round(budper_sum, 2) FROM budget_periods ' + // select
            'WHERE budper_date1 = :DATE1 AND ' + // date1
            'budper_date2 = :DATE2 AND ' + // date2
            'budper_cat_id = :CAT AND ' + // cat_id
            'budper_bud_id = :BUDGET;';

          Q.Params.ParamByName('DATE1').AsString := Periods.DateFrom;
          Q.Params.ParamByName('DATE2').AsString := Periods.DateTo;
          Q.Params.ParamByName('CAT').AsInteger := BudCat.CategoryID;
          Q.Params.ParamByName('BUDGET').AsInteger := BudCat.BudgetID;
          Q.Prepare;
          Q.Open;

          try
            while not (Q.EOF) do
            begin
              TryStrToFloat(Q.Fields[0].AsString, Plan);
              Q.Next;
            end;
          finally
            Q.Close;
          end;
          BudCat.Plan[J] := Plan;

          // ============================================================================
          // ADD REAL AMOUNT
          // ============================================================================
          Q.SQL.Text :=
            'SELECT ROUND(TOTAL(d_sum), 2) as d_sum FROM data ' + // select
            'LEFT JOIN accounts ON (acc_id = d_account) ' + sLineBreak +// accounts
            'WHERE d_account IN (SELECT acc_id FROM accounts WHERE acc_currency = :CURRENCY) AND '
            +
            // currency
            'd_date BETWEEN :DATE1 AND :DATE2 AND ' + // where
            IfThen(BudCat.Level = 0, 'd_category IN (SELECT cat_id FROM categories ' +
            'WHERE (cat_id = :CAT OR cat_parent_id = :CAT))', 'd_category = :CAT;');

          Q.Params.ParamByName('DATE1').AsString := Periods.DateFrom;
          Q.Params.ParamByName('DATE2').AsString := Periods.DateTo;
          Q.Params.ParamByName('CAT').AsInteger := BudCat.CategoryID;
          Q.Params.ParamByName('CURRENCY').AsString :=
            frmBudgets.tabCurrency.Tabs[frmBudgets.tabCurrency.TabIndex].Text;
          Q.Prepare;
          Q.Open;

          try
            while not (Q.EOF) do
            begin
              TryStrToFloat(Q.Fields[0].AsString, Reality);
              Q.Next;
            end;
          finally
            Q.Close;
          end;
          BudCat.Reality[J] := Reality;
          BudCat.Difference[J] := RoundTo(Reality - Plan, -2);

          if Plan = 0.0 then
            BudCat.Ratio[J] := 0.0
          else
            BudCat.Ratio[J] := RoundTo(Reality / Plan, -2);

          Inc(J);
          P := frmBudgets.VSTPeriods.GetNextSelected(P);
        end;
        Q.Free;
      end;
      frmMain.QRY.Next;
    end;
  finally
    frmMain.QRY.Close;
  end;

  // ---------------------------------------
  // INSERT SUMMARY
  // ---------------------------------------
  if (frmBudgets.VSTBudCat.TotalCount > 0) and
    (frmBudgets.VSTBudCat.Header.Columns.Count > 4) then
  begin

    // ---------------------------------------
    // INSERT SUMMARY COLUMNS
    // ---------------------------------------

    for J := 0 to 3 do
    begin
      frmBudgets.VSTBudCat.Header.Columns.Insert(4 + J);
      I := 4 + J;
      frmBudgets.VSTBudCat.Header.Columns[I].Width := 90;
      frmBudgets.VSTBudCat.Header.Columns[I].Alignment := taRightJustify;
      frmBudgets.VSTBudCat.Header.Columns[I].ImageIndex := J;
      frmBudgets.VSTBudCat.Header.Columns[I].Text := Caption_16;
      frmBudgets.VSTBudCat.Header.Columns[I].Tag := 1;
      if (J = 2) and (frmSettings.chkShowDifference.Checked = True) then
        frmBudgets.VSTBudCat.Header.Columns[I].Options :=
          frmBudgets.VSTBudCat.Header.Columns[I].Options - [covisible];
      if (J = 3) and (frmSettings.chkShowIndex.Checked = True) then
        frmBudgets.VSTBudCat.Header.Columns[I].Options :=
          frmBudgets.VSTBudCat.Header.Columns[I].Options - [covisible];
    end;

    J := 0;
    B := frmBudgets.VSTBudCat.GetFirst();
    while Assigned(B) do
    begin
      BudCat := frmBudgets.VSTBudCat.GetNodeData(B);
      BudCat.Plan[J] := 0.0;
      BudCat.Reality[J] := 0.0;

      for I := 1 to frmBudgets.VSTPeriods.SelectedCount do
      begin
        BudCat.Plan[J] := BudCat.Plan[J] + BudCat.Plan[I];
        BudCat.Reality[J] := BudCat.Reality[J] + BudCat.Reality[I];
        BudCat.Difference[J] := RoundTo(BudCat.Reality[J] - BudCat.Plan[J], -2);
        if BudCat.Plan[J] = 0.0 then
          BudCat.Ratio[J] := 0.0
        else
          BudCat.Ratio[J] := RoundTo(BudCat.Reality[J] / BudCat.Plan[J], -2);
      end;
      B := frmBudgets.VSTBudCat.GetNext(B);
    end;

    // ---------------------------------------
    //  INSERT SUMMARY ROW
    // ---------------------------------------
    frmBudgets.VSTBudCat.InsertNode(frmBudgets.VSTBudCat.GetFirst(), amInsertBefore);
    B := frmBudgets.VSTBudCat.GetFirst();
    SumRow := frmBudgets.VSTBudCat.GetNodeData(B);
    SumRow.Category := AnsiUpperCase(Caption_16);
    SumRow.Level := 2;
    // set length of arrays
    setLength(SumRow.Plan, frmBudgets.VSTPeriods.SelectedCount + 1);
    setLength(SumRow.Reality, frmBudgets.VSTPeriods.SelectedCount + 1);
    setLength(SumRow.Difference, frmBudgets.VSTPeriods.SelectedCount + 1);
    setLength(SumRow.Ratio, frmBudgets.VSTPeriods.SelectedCount + 1);

    for J := 0 to frmBudgets.VSTPeriods.SelectedCount do
    begin
      SumRow.Plan[J] := 0.0;
      SumRow.Reality[J] := 0.0;

      // summary columns
      B := frmBudgets.VSTBudCat.GetNext(frmBudgets.VSTBudCat.GetFirst());
      while Assigned(B) do
      begin
        BudCat := frmBudgets.VSTBudCat.GetNodeData(B);
        SumRow.Plan[J] := SumRow.Plan[J] + BudCat.Plan[J];
        SumRow.Reality[J] := SumRow.Reality[J] + BudCat.Reality[J];
        B := frmBudgets.VSTBudCat.GetNext(B);
      end;

      SumRow.Difference[J] := RoundTo(SumRow.Reality[J] - SumRow.Plan[J], -2);
      if SumRow.Plan[J] = 0.0 then
        SumRow.Ratio[J] := 0.0
      else
        SumRow.Ratio[J] := RoundTo(SumRow.Reality[J] / SumRow.Plan[J], -2);
    end;
  end;

  SetNodeHeight(frmBudgets.VSTBudCat);
  frmBudgets.VSTBudCat.EndUpdate;

  frmBudgets.btnCopy.Enabled := frmBudgets.VSTBudCat.RootNodeCount > 0;
  frmBudgets.lblItemBudCat.Caption := '';
  frmBudgets.lblItemsBudCat.Caption := IntToStr(frmBudgets.VSTBudCat.RootNodeCount);
end;

end.
