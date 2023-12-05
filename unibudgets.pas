unit uniBudgets;

{$mode ObjFPC}{$H+}
{$ModeSwitch AutoDeref}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, ActnList, ComCtrls,
  Menus, BCMDButtonFocus, BCPanel, laz.VirtualTrees, StdCtrls, Buttons, Math, sqldb,
  StrUtils, DateUtils, LazUTF8;

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
    imgHeight: TImage;
    imgItemBudCat: TImage;
    imgItemBudgets: TImage;
    imgItemPeriods: TImage;
    imgItemsBudCat: TImage;
    imgItemsBudgets: TImage;
    imgItemsPeriods: TImage;
    imgWidth: TImage;
    lblHeight: TLabel;
    lblItemBudCat: TLabel;
    lblItemBudgets: TLabel;
    lblItemPeriods: TLabel;
    lblItemsBudCat: TLabel;
    lblItemsBudgets: TLabel;
    lblItemsPeriods: TLabel;
    lblWidth: TLabel;
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
    pnlTip: TPanel;
    pnlWidth: TPanel;
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
    VSTBudCat: TLazVirtualStringTree;
    VSTBudgets: TLazVirtualStringTree;
    VSTPeriods: TLazVirtualStringTree;
    procedure actPeriodDeleteExecute(Sender: TObject);
    procedure btnCopyClick(Sender: TObject);
    procedure btnSettingsClick(Sender: TObject);
    procedure pnlBottom1Resize(Sender: TObject);
    procedure pnlBottom2Resize(Sender: TObject);
    procedure pnlBudgetsResize(Sender: TObject);
    procedure tabLeftChange(Sender: TObject);
    procedure tabLeftChanging(Sender: TObject; var AllowChange: boolean);
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
    procedure splBudgetCanResize(Sender: TObject; var NewSize: integer; var Accept: boolean);
    procedure splPeriodCanResize(Sender: TObject; var NewSize: integer; var Accept: boolean);
    procedure VSTBudCatChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure VSTBudCatResize(Sender: TObject);
//    procedure VSTBudCatResize(Sender: TObject);
    procedure VSTBudgetsBeforeCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas;
      Node: PVirtualNode; Column: TColumnIndex; CellPaintMode: TVTCellPaintMode; CellRect: TRect;
      var ContentRect: TRect);
    procedure VSTBudgetsChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure VSTBudgetsCompareNodes(Sender: TBaseVirtualTree; Node1, Node2: PVirtualNode;
      Column: TColumnIndex; var Result: integer);
    procedure VSTBudgetsDblClick(Sender: TObject);
    procedure VSTBudgetsEnter(Sender: TObject);
    procedure VSTBudgetsGetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Kind: TVTImageKind; Column: TColumnIndex; var Ghosted: boolean; var ImageIndex: integer);
    procedure VSTBudgetsGetNodeDataSize(Sender: TBaseVirtualTree; var NodeDataSize: integer);
    procedure VSTBudgetsGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
      TextType: TVSTTextType; var CellText: string);
    procedure VSTBudgetsResize(Sender: TObject);
    procedure VSTBudCatBeforeCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas;
      Node: PVirtualNode; Column: TColumnIndex; CellPaintMode: TVTCellPaintMode; CellRect: TRect;
      var ContentRect: TRect);
    procedure VSTBudCatGetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Kind: TVTImageKind; Column: TColumnIndex; var Ghosted: boolean; var ImageIndex: integer);
    procedure VSTBudCatGetNodeDataSize(Sender: TBaseVirtualTree; var NodeDataSize: integer);
    procedure VSTBudCatGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
      TextType: TVSTTextType; var CellText: string);
    procedure VSTBudCatPaintText(Sender: TBaseVirtualTree; const TargetCanvas: TCanvas;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType);
    procedure VSTPeriodsChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure VSTPeriodsDblClick(Sender: TObject);
    procedure VSTPeriodsGetNodeDataSize(Sender: TBaseVirtualTree; var NodeDataSize: integer);
    procedure VSTPeriodsGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
      TextType: TVSTTextType; var CellText: string);
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
  X: Integer;

begin
  if frmSettings.chkAutoColumnWidth.Checked = False then Exit;

  (Sender as TLazVirtualStringTree).Header.Columns[0].Width :=
    Round(ScreenRatio * 25 / 100);
  X := (VSTBudgets.Width - VSTBudgets.Header.Columns[0].Width) div 100;
  VSTBudgets.Header.Columns[1].Width := VSTBudgets.Width -
    VSTBudgets.Header.Columns[0].Width - ScrollBarWidth - (25 * X); // text
  VSTBudgets.Header.Columns[3].Width := 25 * X; // ID
end;

procedure TfrmBudgets.VSTBudCatBeforeCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas;
  Node: PVirtualNode; Column: TColumnIndex; CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
var
  Co: integer;
begin
  if Column < 4 then
    TargetCanvas.Brush.Color :=
      IfThen(Node.Index mod 2 = 0, clWhite, RGBToColor(230, 230, 230))
  else
  begin
    Co := Column mod 4;
    TargetCanvas.Brush.Color :=
      IfThen(Node.Index mod 2 = 0, RGBToColor(255, 255, 255 - (Co * 25)),
      RGBToColor(230, 230, 230 - (Co + 1) * 15));
  end;
  TargetCanvas.FillRect(CellRect);
end;

procedure TfrmBudgets.VSTBudCatGetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Kind: TVTImageKind; Column: TColumnIndex; var Ghosted: boolean; var ImageIndex: integer);
var
  BudCat: PBudCat;
begin
  if Column = 0 then
  begin
    BudCat := VSTBudCat.GetNodeData(Node);
    ImageIndex := BudCat.Level;
  end;
end;

procedure TfrmBudgets.VSTBudCatGetNodeDataSize(Sender: TBaseVirtualTree; var NodeDataSize: integer);
begin
  NodeDataSize := SizeOf(TBudCat);
end;

procedure TfrmBudgets.VSTBudCatGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
var
  BudCat: PBudCat;
begin
  if Column = 0 then Exit;
  try
    BudCat := VSTBudCat.GetNodeData(Node);
    case Column of
      1: CellText := BudCat.Category;  // category
      2: if BudCat.Level = 0 then // subcategory
          CellText := ''
        else
          CellText := IfThen(frmSettings.chkDisplaySubCatCapital.Checked = true,
        AnsiUpperCase(BudCat.SubCategory), BudCat.SubCategory);
      3: CellText := IntToStr(BudCat.CategoryID); // category ID
      else
        case Column mod 4 of
          0: CellText := Format('%n', [BudCat.Plan[Column div 4 - 1]], FS_own);
          1: CellText := Format('%n', [BudCat.Reality[Column div 4 - 1]], FS_own);
          2: CellText := Format('%n', [BudCat.Difference[Column div 4 - 1]], FS_own)
          else
            CellText := Format('%n', [BudCat.Ratio[Column div 4 - 1]], FS_own);
        end;
    end;
  finally
  end;
end;

procedure TfrmBudgets.VSTBudCatPaintText(Sender: TBaseVirtualTree; const TargetCanvas: TCanvas;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType);
begin
  TargetCanvas.Font.Bold := (Column > 3) and ((Column mod 4) in [0..1]);
end;

procedure TfrmBudgets.VSTPeriodsChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
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
      lblItemPeriods.Caption := IntToStr(VSTPeriods.GetFirstSelected(False).Index + 1) + '.';
    end
    else
    begin
      imgItemPeriods.ImageIndex := 6;
      lblItemPeriods.Caption := '# ' + IntToStr(VSTPeriods.SelectedCount);
    end;
  end;


  UpdateBudCategories;

  lblItemBudCat.Caption := '';
  lblItemsBudCat.Caption := IntToStr(VSTBudCat.RootNodeCount);
end;

procedure TfrmBudgets.VSTPeriodsDblClick(Sender: TObject);
begin
  if VSTPeriods.SelectedCount = 0 then
    popPeriodAddClick(popPeriodAdd)
  else if VSTPeriods.SelectedCount = 1 then
    popPeriodEditClick(popPeriodEdit);
end;

procedure TfrmBudgets.VSTPeriodsGetNodeDataSize(Sender: TBaseVirtualTree; var NodeDataSize: integer);
begin
  NodeDataSize := SizeOf(TPeriods);
end;

procedure TfrmBudgets.VSTPeriodsGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
var
  Periods: PPeriods;
begin
  Periods := VSTPeriods.GetNodeData(Node);

  case Column of
    0: CellText := IntToStr(Node.Index + 1);
    1: CellText := DateToStr(StrToDate(Periods.DateFrom, 'YYYY-MM-DD', '-'));
    2: CellText := DateToStr(StrToDate(Periods.DateTo, 'YYYY-MM-DD', '-'));
  end;
end;

procedure TfrmBudgets.VSTPeriodsResize(Sender: TObject);
var
  X: Integer;

begin
  if frmSettings.chkAutoColumnWidth.Checked = False then Exit;

  (Sender as TLazVirtualStringTree).Header.Columns[0].Width :=
        round(ScreenRatio * 25 / 100);
  X := (VSTPeriods.Width - VSTPeriods.Header.Columns[0].Width) div 100;
  VSTPeriods.Header.Columns[0].Width := 12 * X; // Order number
  VSTPeriods.Header.Columns[1].Width := (VSTPeriods.Width - ScrollBarWidth - (12 * X)) div 2; // Date from
  VSTPeriods.Header.Columns[2].Width := VSTPeriods.Header.Columns[1].Width; // Date to
end;

procedure TfrmBudgets.splBudgetCanResize(Sender: TObject; var NewSize: integer; var Accept: boolean);
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

procedure TfrmBudgets.splPeriodCanResize(Sender: TObject; var NewSize: integer; var Accept: boolean);
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
      lblItemBudCat.Caption := IntToStr(VSTBudCat.GetFirstSelected(False).Index + 1) + '.';
    end
    else
    begin
      imgItemBudCat.ImageIndex := 6;
      lblItemBudCat.Caption := '# ' + IntToStr(VSTBudCat.SelectedCount);
    end;
  end;

end;

procedure TfrmBudgets.VSTBudCatResize(Sender: TObject);
begin
  (Sender as TLazVirtualStringTree).Header.Columns[0].Width :=
    round(ScreenRatio * 25 / 100);
end;

procedure TfrmBudgets.VSTBudgetsBeforeCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas;
  Node: PVirtualNode; Column: TColumnIndex; CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
begin
  TargetCanvas.Brush.Color := IfThen(Node.Index mod 2 = 0, clWhite, frmSettings.pnlOddRowColor.Color);
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
        lblItemsBudgets.Caption := IntToStr(VSTBudgets.GetFirstSelected(False).Index + 1) + '.';
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

procedure TfrmBudgets.VSTBudgetsCompareNodes(Sender: TBaseVirtualTree; Node1, Node2: PVirtualNode;
  Column: TColumnIndex; var Result: integer);
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

procedure TfrmBudgets.VSTBudgetsGetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Kind: TVTImageKind; Column: TColumnIndex; var Ghosted: boolean; var ImageIndex: integer);
var
  Budgets: PBudgets;
begin
  if Column = 0 then
  begin
    Budgets := VSTBudgets.GetNodeData(Node);
    ImageIndex := Budgets.Kind;
  end;
end;

procedure TfrmBudgets.VSTBudgetsGetNodeDataSize(Sender: TBaseVirtualTree; var NodeDataSize: integer);
begin
  NodeDataSize := SizeOf(TBudgets);
end;

procedure TfrmBudgets.VSTBudgetsGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
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

  if tabLeft.TabIndex = 1 then begin
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
end;

procedure TfrmBudgets.pnlBudgetsResize(Sender: TObject);
begin
  tabLeftResize(tabLeft);
end;

procedure TfrmBudgets.tabLeftChange(Sender: TObject);
begin
  if tabLeft.TabIndex = 0 then
    VSTBudgets.SetFocus
  else
  begin
    VSTPeriods.SetFocus;
    if (VSTBudgets.SelectedCount = 1) and (VSTPeriods.RootNodeCount > 0) then
      VSTPeriods.SelectAll(False);
  end;
end;

procedure TfrmBudgets.tabLeftChanging(Sender: TObject; var AllowChange: boolean);
begin
  if (VSTBudgets.SelectedCount <> 1) then
    AllowChange := False;
end;

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
  // delete all previous categories
  frmMain.QRY.SQL.Text := 'DELETE FROM budget_categories WHERE budcat_bud_id = :ID';
  frmMain.QRY.Params.ParamByName('ID').AsInteger := Budgets.ID;
  frmMain.QRY.Prepare;
  frmMain.QRY.ExecSQL;
  frmMain.Tran.Commit;

  // write all checked categories
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
      frmMain.QRY.Params.ParamByName('ID').AsInteger := Budgets.ID;
      frmMain.QRY.Prepare;
      frmMain.QRY.ExecSQL;
      Node := frmBudget.VST.GetNextChecked(Node);
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
    if (frmMain.Conn.Connected = False) or (vSTBudgets.RootNodeCount = 0) or (VSTBudgets.SelectedCount = 0) then
      exit;
    case VSTBudgets.SelectedCount of
      1: if MessageDlg(Message_00, Question_01 + sLineBreak + sLineBreak +
          VSTBudgets.Header.Columns[1].Text + ': ' + VSTBudgets.Text[VSTBudgets.FocusedNode, 1],
          mtConfirmation, mbYesNo, 0) <> 6 then
          Exit;
      else
        if MessageDlg(Message_00, AnsiReplaceStr(Question_02, '%', IntToStr(VSTBudgets.SelectedCount)),
          mtConfirmation, mbYesNo, 0) <> 6 then
          Exit;
    end;
    if MessageDlg(Message_00, AnsiReplaceStr(Question_23, '%', IntToStr(VSTBudgets.SelectedCount)),
      mtConfirmation, mbYesNo, 0) <> 6 then
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
    // form size
    (Sender as TForm).Width :=
      Round((Screen.Width / IfThen(ScreenIndex = 0, 1, (ScreenRatio / 100))) -
      (Round(420 / (ScreenRatio / 100)) - ScreenRatio));
    (Sender as TForm).Height :=
      Round(Screen.Height / IfThen(ScreenIndex = 0, 1, (ScreenRatio / 100))) -
      2 * (250 - ScreenRatio);

    // form position
    (Sender as TForm).Left := (Screen.Width - (Sender as TForm).Width) div 2;
    (Sender as TForm).Top := (Screen.Height - 100 - (Sender as TForm).Height) div 2;

    {$IFDEF WINDOWS}
    // set components height
    VSTBudgets.Header.Height := PanelHeight;
    VSTPeriods.Header.Height := PanelHeight;
    VSTBudCat.Header.Height := PanelHeight;
    pnlCategoriesCaption.Height := PanelHeight;
    pnlBudgetCaption.Height := PanelHeight;

    pnlButtons.Height := ButtonHeight;
    pnlBottom.Height := ButtonHeight;
    {$ENDIF}
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
  popPeriodAdd.Enabled := (frmMain.Conn.Connected = True) and (VSTBudgets.SelectedCount = 1);

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
    if (frmMain.Conn.Connected = False) or (VSTPeriods.RootNodeCount = 0) or (VSTPeriods.SelectedCount = 0) then
      exit;
    case VSTPeriods.SelectedCount of
      1: if MessageDlg(Message_00, Question_01 + sLineBreak + sLineBreak +
          VSTPeriods.Header.Columns[1].Text + ': ' + VSTPeriods.Text[VSTPeriods.GetFirstSelected(), 1] +
          sLineBreak + VSTPeriods.Header.Columns[2].Text + ': ' +
          VSTPeriods.Text[VSTPeriods.GetFirstSelected(), 2], mtConfirmation, mbYesNo, 0) <> 6 then
          Exit;
      else
        if MessageDlg(Message_00, AnsiReplaceStr(Question_02, '%', IntToStr(VSTPeriods.SelectedCount)),
          mtConfirmation, mbYesNo, 0) <> 6 then
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
          'WHERE budper_date1 = :DATE1 AND budper_date2 = :DATE2 ' + 'AND budper_bud_id = :ID;';
        frmMain.QRY.Params.ParamByName('DATE1').AsString := Periods.DateFrom;
        frmMain.QRY.Params.ParamByName('DATE2').AsString := Periods.DateTo;
        frmMain.QRY.Params.ParamByName('ID').AsInteger := Budgets.ID;

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
    frmPeriod.datDateTo.Date := EncodeDate(YearOf(now), MonthOf(now), DaysInAMonth(YearOf(now), MonthOf(now)));

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
          'INSERT OR IGNORE INTO budget_periods (budper_date1, budper_date2, budper_sum, ' +
          'budper_bud_id, budper_cat_id) VALUES (:DATE1, :DATE2, :SUM, :ID, :CAT);';

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
begin
  if (VSTBudgets.SelectedCount <> 1) then Exit;

  // set date
  frmPeriod.Tag := 1;
  Periods := VSTPeriods.GetNodeData(VSTPeriods.GetFirstSelected());
  VSTPeriods.Tag := StrToInt(VSTPeriods.Text[VSTPeriods.GetFirstSelected(), 0]);
  frmPeriod.datDateFrom.Date := StrToDate(Periods.DateFrom, 'YYYY-MM-DD', '-');
  frmPeriod.datDateTo.Date := StrToDate(Periods.DateTo, 'YYYY-MM-DD', '-');
  frmPeriod.Caption := AnsiUpperCase(Caption_46);

  if frmPeriod.ShowModal <> mrOk then begin
    VSTPeriods.SetFocus;
    Exit;
  end;

  N := frmPeriod.VST.GetFirst();
  while Assigned(N) do
  begin
    BudPer := frmPeriod.VST.GetNodeData(N);
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

    // date1
    frmMain.QRY.Params.ParamByName('DATE1').AsString :=
      FormatDateTime('YYYY-MM-DD', frmPeriod.datDateFrom.Date);
    // date2
    frmMain.QRY.Params.ParamByName('DATE2').AsString :=
      FormatDateTime('YYYY-MM-DD', frmPeriod.datDateTo.Date);
    // date3
    frmMain.QRY.Params.ParamByName('DATE3').AsString := Periods.DateFrom;
    // date4
    frmMain.QRY.Params.ParamByName('DATE4').AsString := Periods.DateTo;

    // amount
    frmMain.QRY.Params.ParamByName('SUM').AsString :=
      AnsiReplaceStr(FloatToStr(BudPer.Plan), FS_own.DecimalSeparator, '.');
    // category
    frmMain.QRY.Params.ParamByName('CAT').AsInteger := BudPer.CategoryID;
    // ID
    frmMain.QRY.Params.ParamByName('ID').AsString :=
      VSTBudgets.Text[VSTBudgets.GetFirstSelected(), 3];
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
  if frmMain.Conn.Connected = True then
  begin
    frmMain.QRY.SQL.Text :=
      'SELECT DISTINCT budper_date1, budper_date2 ' + // select
      'FROM budget_periods ' + // from
      'WHERE budper_bud_id = :ID ' + // where
      'ORDER BY budper_date1 DESC;'; // order
    frmMain.QRY.Params.ParamByName('ID').AsInteger := Budgets.ID;
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
end;

procedure UpdateBudCategories;
var
  J: integer;
  Plan, Reality: double;
  B, P: PVirtualNode;
  Periods: PPeriods;
  BudCat: PBudCat;
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
        '[' + IntToStr(P.Index + 1) + '] ' + Caption_228;

      // add reality column
      frmBudgets.VSTBudCat.Header.Columns.Add;
      frmBudgets.VSTBudCat.Header.Columns[3 + (J * 4) + 2].Width := 90;
      frmBudgets.VSTBudCat.Header.Columns[3 + (J * 4) + 2].Alignment :=
        taRightJustify;
      frmBudgets.VSTBudCat.Header.Columns[3 + (J * 4) + 2].Text :=
        '[' + IntToStr(P.Index + 1) + '] ' + Caption_229;

      // add difference column
      frmBudgets.VSTBudCat.Header.Columns.Add;
      frmBudgets.VSTBudCat.Header.Columns[3 + (J * 4) + 3].Width := 90;
      frmBudgets.VSTBudCat.Header.Columns[3 + (J * 4) + 3].Alignment :=
        taRightJustify;
      frmBudgets.VSTBudCat.Header.Columns[3 + (J * 4) + 3].Text :=
        '[' + IntToStr(P.Index + 1) + '] ' + Caption_231;
      if frmSettings.chkShowDifference.Checked = True then
        frmBudgets.VSTBudCat.Header.Columns[3 + (J * 4) + 3].Options :=
          frmBudgets.VSTBudCat.Header.Columns[3 + (J * 4) + 3].Options - [covisible];

      // add ratio column
      frmBudgets.VSTBudCat.Header.Columns.Add;
      frmBudgets.VSTBudCat.Header.Columns[3 + (J * 4) + 4].Width := 60;
      frmBudgets.VSTBudCat.Header.Columns[3 + (J * 4) + 4].Alignment :=
        taRightJustify;
      frmBudgets.VSTBudCat.Header.Columns[3 + (J * 4) + 4].Text :=
        '[' + IntToStr(P.Index + 1) + '] ' + Caption_230;
      if frmSettings.chkShowIndex.Checked = True then
        frmBudgets.VSTBudCat.Header.Columns[3 + (J * 4) + 4].Options :=
          frmBudgets.VSTBudCat.Header.Columns[3 + (J * 4) + 4].Options - [covisible];
      P := frmBudgets.VSTPeriods.GetNextSelected(P);
      Inc(J);
    end;
  end;

  // ============================================================================
  // HANDLE DATA HEADER
  // ============================================================================
  Budgets := frmBudgets.VSTBudgets.GetNodeData(frmBudgets.VSTBudgets.GetFirstSelected());

  frmMain.QRY.SQL.Text := 'SELECT ' +
    '(SELECT cat_parent_name FROM categories WHERE cat_id = budcat_category) as category, ' +
    '(SELECT cat_name FROM categories WHERE cat_id = budcat_category) as subcategory, ' +
    '(SELECT bud_type FROM budgets WHERE bud_id = :ID) as level, ' + // level
    'budcat_category, ' + // category ID
    'budcat_bud_id ' + // budget ID
    'FROM budget_categories ' + // from
    'WHERE budcat_bud_id = :ID';
  frmMain.QRY.Params.ParamByName('ID').AsInteger := Budgets.ID;
  frmMain.QRY.Open;

  try
    while not (frmMain.QRY.EOF) do
    begin
      frmBudgets.VSTBudCat.RootNodeCount := frmBudgets.VSTBudCat.RootNodeCount + 1;
      B := frmBudgets.VSTBudCat.GetLast();
      BudCat := frmBudgets.VSTBudCat.GetNodeData(B);
      BudCat.Category := AnsiUpperCase(frmMain.QRY.Fields[0].AsString); // category
      BudCat.SubCategory := frmMain.QRY.Fields[1].AsString; // subcategory
      BudCat.Level := frmMain.QRY.Fields[2].AsInteger; // level
      BudCat.CategoryID := frmMain.QRY.Fields[3].AsInteger; // category ID
      BudCat.BudgetID := frmMain.QRY.Fields[4].AsInteger; // budget ID

      // set length of arrays
      setLength(BudCat.Plan, frmBudgets.VSTPeriods.SelectedCount);
      setLength(BudCat.Reality, frmBudgets.VSTPeriods.SelectedCount);
      setLength(BudCat.Difference, frmBudgets.VSTPeriods.SelectedCount);
      setLength(BudCat.Ratio, frmBudgets.VSTPeriods.SelectedCount);

      // ============================================================================
      // HANDLE SUBDATA
      // ============================================================================
      if frmBudgets.VSTPeriods.SelectedCount > 0 then
      begin
        Q := TSQLQuery.Create(nil);
        Q.Transaction := frmMain.Tran;
        Q.Database := frmMain.Tran.DataBase;

        P := frmBudgets.VSTPeriods.GetFirstSelected();
        J := 0;
        while Assigned(P) do
        begin
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
            'WHERE d_date BETWEEN :DATE1 AND :DATE2 AND ' + // where
            IfThen(BudCat.Level = 0, 'd_category IN (SELECT cat_id FROM categories ' +
            'WHERE (cat_id = :CAT OR cat_parent_id = :CAT))', 'd_category = :CAT;');

          Q.Params.ParamByName('DATE1').AsString := Periods.DateFrom;
          Q.Params.ParamByName('DATE2').AsString := Periods.DateTo;
          Q.Params.ParamByName('CAT').AsInteger := BudCat.CategoryID;
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

  SetNodeHeight(frmBudgets.VSTBudCat);
  frmBudgets.VSTBudCat.EndUpdate;

  frmBudgets.btnCopy.Enabled := frmBudgets.VSTBudCat.RootNodeCount > 0;
  frmBudgets.lblItemBudCat.Caption := '';
  frmBudgets.lblItemsBudCat.Caption := IntToStr(frmBudgets.VSTBudCat.RootNodeCount);
end;

end.
