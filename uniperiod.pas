unit uniPeriod;

{$mode ObjFPC}{$H+}
{$ModeSwitch AutoDeref}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, BCPanel, ExtCtrls,
  StdCtrls, Buttons, Menus, ActnList, laz.VirtualTrees, DateTimePicker, LazUTF8,
  Math, BCMDButtonFocus, StrUtils, DateUtils;

type // middle grid (Periods)
  TBudPer = record
    Category: string;
    SubCategory: string;
    Plan: double;
    CategoryID: integer;
    Level: integer;
  end;
  PBudPer = ^TBudPer;

type

  { TfrmPeriod }

  TfrmPeriod = class(TForm)
    actExit: TAction;
    actEdit: TAction;
    ActionList1: TActionList;
    actSave: TAction;
    btnCancel: TBCMDButtonFocus;
    btnEdit: TBCMDButtonFocus;
    btnSave: TBCMDButtonFocus;
    datDateFrom: TDateTimePicker;
    datDateTo: TDateTimePicker;
    imgHeight: TImage;
    imgItems: TImage;
    imgItem: TImage;
    imgWidth: TImage;
    lblDateFrom: TLabel;
    lblDateTo: TLabel;
    lblFromDate: TLabel;
    lblHeight: TLabel;
    lblItems: TLabel;
    lblItem: TLabel;
    lblToDate: TLabel;
    lblWidth: TLabel;
    pnlBudget: TPanel;
    pnlBudgetCaption: TBCPanel;
    pnlButtons: TPanel;
    pnlDateFrom: TPanel;
    pnlDateTo: TPanel;
    pnlHeight: TPanel;
    pnlItems: TPanel;
    pnlItem: TPanel;
    pnlLeft: TPanel;
    pnlPeriodCaption: TBCPanel;
    pnlBottom: TPanel;
    pnlWidth: TPanel;
    splBudget: TSplitter;
    VST: TLazVirtualStringTree;
    procedure btnCancelClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure datDateFromChange(Sender: TObject);
    procedure datDateFromKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure datDateToChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lblDateFromClick(Sender: TObject);
    procedure lblDateToClick(Sender: TObject);
    procedure pnlButtonsResize(Sender: TObject);
    procedure splBudgetCanResize(Sender: TObject; var NewSize: integer;
      var Accept: boolean);
    procedure VSTBeforeCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas;
      Node: PVirtualNode; Column: TColumnIndex; CellPaintMode: TVTCellPaintMode;
      CellRect: TRect; var ContentRect: TRect);
    procedure VSTChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure VSTCompareNodes(Sender: TBaseVirtualTree;
      Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: integer);
    procedure VSTDblClick(Sender: TObject);
    procedure VSTEnter(Sender: TObject);
    procedure VSTGetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Kind: TVTImageKind; Column: TColumnIndex; var Ghosted: boolean;
      var ImageIndex: integer);
    procedure VSTGetNodeDataSize(Sender: TBaseVirtualTree; var NodeDataSize: integer);
    procedure VSTGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure VSTResize(Sender: TObject);
  private

  public

  end;

var
  frmPeriod: TfrmPeriod;

implementation

{$R *.lfm}

{ TfrmPeriod }

uses
  uniMain, uniSettings, uniResources, uniBudgets, uniPlan;

procedure TfrmPeriod.VSTResize(Sender: TObject);
var
  X: integer;
begin
  if frmSettings.chkAutoColumnWidth.Checked = False then Exit;

  (Sender as TLazVirtualStringTree).Header.Columns[0].Width :=
    round(Screen.PixelsPerInch div 96 * 25);
  X := (VST.Width - VST.Header.Columns[0].Width) div 100;
  VST.Header.Columns[1].Width :=
    VST.Width - VST.Header.Columns[0].Width - ScrollBarWidth - (65 * X); // category
  VST.Header.Columns[2].Width := 35 * X; // subcategory
  VST.Header.Columns[3].Width := 20 * X; // budget (amount)
  VST.Header.Columns[4].Width := 10 * X; // ID
end;

procedure TfrmPeriod.VSTGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
var
  BudPer: PBudPer;
begin
  BudPer := VST.GetNodeData(Node);
  if Column = 0 then Exit;

  case Column of
    1: CellText := BudPer.Category; // category
    2: if BudPer.Level = 0 then
        CellText := ''
      else
        CellText := IfThen(frmSettings.chkDisplaySubCatCapital.Checked =
          True, AnsiUpperCase(BudPer.SubCategory), BudPer.SubCategory);  // subcategory
    3: CellText := Format('%n', [BudPer.Plan], FS_own);
    4: CellText := IntToStr(BudPer.CategoryID); // category id
  end;
end;

procedure TfrmPeriod.VSTBeforeCellPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
begin
  TargetCanvas.Brush.Color :=
    IfThen(Node.Index mod 2 = 0, clWhite, frmSettings.pnlOddRowColor.Color);
  TargetCanvas.FillRect(CellRect);
end;

procedure TfrmPeriod.VSTChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
begin
  btnEdit.Enabled := VST.SelectedCount = 1;

  try
    // set images
    if VST.SelectedCount = 0 then
    begin
      imgItem.ImageIndex := -1;
      lblItem.Caption := '';
    end
    else
    begin
      if VST.SelectedCount = VST.TotalCount then
      begin
        imgItem.ImageIndex := 7;
        lblItem.Caption := '# ' + IntToStr(VST.SelectedCount);
      end
      else if VST.SelectedCount = 1 then
      begin
        imgItem.ImageIndex := 5;
        lblItem.Caption := IntToStr(VST.GetFirstSelected(False).Index + 1) + '.';
      end
      else
      begin
        imgItem.ImageIndex := 6;
        lblItem.Caption := '# ' + IntToStr(VST.SelectedCount);
      end;
    end;
  except
  end;
end;

procedure TfrmPeriod.VSTCompareNodes(Sender: TBaseVirtualTree;
  Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: integer);
var
  Data1, Data2: PBudPer;
begin
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

procedure TfrmPeriod.VSTDblClick(Sender: TObject);
begin
  if VST.SelectedCount = 1 then
    btnEditClick(btnEdit);
end;

procedure TfrmPeriod.VSTEnter(Sender: TObject);
begin
  if VST.SelectedCount = 0 then
  begin
    VST.Selected[VST.GetFirst()] := True;
    VST.FocusedNode := VST.GetFirst();
  end;
end;

procedure TfrmPeriod.btnCancelClick(Sender: TObject);
begin
  frmPeriod.Close;
end;

procedure TfrmPeriod.btnEditClick(Sender: TObject);
var
  BudPer: PBudPer;
begin
  if VST.SelectedCount <> 1 then Exit;

  BudPer := frmPeriod.VST.GetNodeData(frmPeriod.VST.GetFirstSelected());

  frmPlan.pnlPlanCaption1.Caption := BudPer.Category;
  frmPlan.pnlPlanCaption2.Caption := BudPer.SubCategory;
  frmPlan.pnlPlanCaption2.Visible := Length(BudPer.SubCategory) > 0;

  frmPlan.lblDate.Caption := DateToStr(datDateFrom.date) + ' - ' +
    DateToStr(datDateTo.date);
  frmPlan.spiPlan.Value := BudPer.Plan;

  if frmPlan.ShowModal <> mrOk then Exit;

  BudPer.Plan := frmPlan.spiPlan.Value;
  VST.SetFocus;
end;

procedure TfrmPeriod.btnSaveClick(Sender: TObject);
begin
  if MessageDlg(Application.Title, Question_22, mtConfirmation, [mbYes, mbNo], 0) <>
    mrYes then Exit;

  btnSave.Tag := 1;
  frmPeriod.ModalResult := mrOk;
end;

procedure TfrmPeriod.datDateFromChange(Sender: TObject);
begin
  lblDateFrom.Caption := FS_own.LongDayNames[DayOfTheWeek(datDateFrom.Date + 1)];
end;

procedure TfrmPeriod.datDateFromKeyDown(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  if Key = 13 then
  begin
    case (Sender as TDateTimePicker).Tag of
      0: begin
        Key := 0;
        datDateTo.SetFocus;
      end;
      1: begin
        Key := 0;
        VST.SetFocus;
      end;
    end;
  end;
end;

procedure TfrmPeriod.datDateToChange(Sender: TObject);
begin
  lblDateTo.Caption := FS_own.LongDayNames[DayOfTheWeek(datDateTo.Date + 1)];
end;

procedure TfrmPeriod.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  if btnSave.Tag = 0 then
    if MessageDlg(Application.Title, Question_19, mtConfirmation, [mbYes, mbNo], 0) <>
      mrYes then
    begin
      CloseAction := caNone;
      Exit;
    end;
  btnSave.Tag := 0;
end;

procedure TfrmPeriod.FormCreate(Sender: TObject);
begin
  // set components height
  VST.Header.Height := PanelHeight;
  pnlPeriodCaption.Height := PanelHeight;
  pnlBudgetCaption.Height := PanelHeight;
  pnlButtons.Height := ButtonHeight;
  pnlBottom.Height := ButtonHeight;

  // get form icon
  frmMain.img16.GetIcon(21, (Sender as TForm).Icon);
end;

procedure TfrmPeriod.FormResize(Sender: TObject);
begin
  imgWidth.ImageIndex := 0;
  lblWidth.Caption := IntToStr(frmPeriod.Width);
  imgHeight.ImageIndex := 1;
  lblHeight.Caption := IntToStr(frmPeriod.Height);

  pnlBudgetCaption.Repaint;
end;

procedure TfrmPeriod.FormShow(Sender: TObject);
var
  N: PVirtualNode;
  BudPer: PBudPer;
  Budgets: PBudgets;
  Periods: PPeriods;

begin
  VST.BeginUpdate;
  VST.Clear;
  VST.RootNodeCount := 0;
  Budgets := frmBudgets.VSTBudgets.GetNodeData(frmBudgets.VSTBudgets.GetFirstSelected());

  if frmBudgets.popPeriodAdd.Tag = 1 then
  begin
    Periods := frmBudgets.VSTPeriods.GetNodeData(
      frmBudgets.VSTPeriods.GetFirstSelected());
    datDateFrom.Date := StrToDate(Periods.DateFrom, 'YYYY-MM-DD', '-');
    datDateTo.Date := StrToDate(Periods.DateTo, 'YYYY-MM-DD', '-');
    frmPeriod.Tag := 1;
  end;

  frmMain.QRY.SQL.Text :=
    'SELECT (SELECT cat_parent_name FROM categories WHERE cat_id = budcat_category), ' +
    // category
    '(SELECT CASE cat_parent_id WHEN 0 THEN "" ELSE cat_name END ' +
    sLineBreak + 'FROM categories WHERE cat_id = budcat_category), ' +
    sLineBreak + // subcategory
    '(SELECT bud_type FROM budgets WHERE bud_id = :ID), ' + sLineBreak + // level
    IfThen(frmPeriod.Tag = 1, '(SELECT budper_sum ' +
    'FROM budget_periods WHERE budper_date1 = :DATE1 AND budper_date2 = :DATE2 ' +
    ' AND budper_cat_id = budcat_category AND budper_bud_id = :ID),', '0,') +
    sLineBreak + 'budcat_category ' + sLineBreak + 'FROM budget_categories ' +
    sLineBreak + // from
    'WHERE budcat_bud_id = :ID;';

  frmMain.QRY.Params.ParamByName('ID').AsInteger := Budgets.ID;
  if (frmPeriod.Tag = 1) then
  begin
    frmMain.QRY.Params.ParamByName('DATE1').AsString :=
      FormatDateTime('YYYY-MM-DD', datDateFrom.Date);
    frmMain.QRY.Params.ParamByName('DATE2').AsString :=
      FormatDateTime('YYYY-MM-DD', datDateTo.Date);
  end;
  frmMain.QRY.Open;

  while not (frmMain.QRY.EOF) do
  begin
    VST.RootNodeCount := VST.RootNodeCount + 1;
    N := VST.GetLast();
    BudPer := frmPeriod.VST.GetNodeData(N);
    BudPer.Category := AnsiUpperCase(frmMain.QRY.Fields[0].AsString);
    BudPer.SubCategory := frmMain.QRY.Fields[1].AsString;
    BudPer.Level := frmMain.QRY.Fields[2].AsInteger;
    TryStrToFloat(frmMain.QRY.Fields[3].AsString, BudPer.Plan);
    BudPer.CategoryID := frmMain.QRY.Fields[4].AsInteger;
    frmMain.QRY.Next;
  end;
  frmMain.QRY.Close;

  VST.EndUpdate;

  if frmBudgets.popPeriodAdd.Tag = 1 then
  begin
    frmPeriod.Tag := 0;
    frmBudgets.popPeriodAdd.Tag := 0;
  end;
  lblItems.Caption := IntToStr(VST.TotalCount);
  lblDateTo.Caption := FS_own.LongDayNames[DayOfTheWeek(datDateTo.Date + 1)];
  lblDateFrom.Caption := FS_own.LongDayNames[DayOfTheWeek(datDateFrom.Date + 1)];
  datDateFrom.SetFocus;
  frmBudgets.popPeriodAdd.Tag := 0;
  SetNodeHeight(VST);
end;

procedure TfrmPeriod.lblDateFromClick(Sender: TObject);
begin
  datDateFrom.SetFocus;
end;

procedure TfrmPeriod.lblDateToClick(Sender: TObject);
begin
  datDateTo.SetFocus;
end;

procedure TfrmPeriod.pnlButtonsResize(Sender: TObject);
begin
  btnEdit.BorderSpacing.Left := (pnlButtons.Width - btnEdit.Width * 3 - 10) div 2;
end;

procedure TfrmPeriod.splBudgetCanResize(Sender: TObject; var NewSize: integer;
  var Accept: boolean);
begin
  imgWidth.ImageIndex := 3;
  lblWidth.Caption := IntToStr(pnlLeft.Width);

  imgHeight.ImageIndex := 2;
  lblHeight.Caption := IntToStr(frmPeriod.Width - pnlLeft.Width);

  pnlBudgetCaption.Repaint;
  pnlPeriodCaption.Repaint;
end;

procedure TfrmPeriod.VSTGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: boolean; var ImageIndex: integer);
var
  BudPer: PBudPer;
begin
  if Column = 0 then
  begin
    BudPer := VST.GetNodeData(Node);
    ImageIndex := BudPer.Level;
  end;
end;

procedure TfrmPeriod.VSTGetNodeDataSize(Sender: TBaseVirtualTree;
  var NodeDataSize: integer);
begin
  NodeDataSize := SizeOf(TBudPer);
end;

end.
