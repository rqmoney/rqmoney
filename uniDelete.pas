unit uniDelete;

{$mode objfpc}{$H+}
{$ModeSwitch AutoDeref}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, ComCtrls, StdCtrls,
  ActnList, Buttons, BCPanel, BCMDButtonFocus, LazUTF8, Math, laz.VirtualTrees, StrUtils;

type // main grid (Delete1)
  TDelete1 = record
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
  end;
  PDelete1 = ^TDelete1;

type // main grid (Delete2)
  TDelete2 = record
    DateFrom: string;
    DateTo: string;
    Periodicity: integer;
    Comment: string;
    Amount: double;
    currency: string;
    Account: string;
    Category: string;
    SubCategory: string;
    Person: string;
    Payee: string;
    Kind: integer;
    ID: integer;
  end;
  PDelete2 = ^TDelete2;

type // main grid (Delete3)
  TDelete3 = record
    BudgetName: string;
    Category: string;
    SubCategory: string;
    ID: integer;
  end;
  PDelete3 = ^TDelete3;

type

  { TfrmDelete }

  TfrmDelete = class(TForm)
    actExit: TAction;
    ActionList1: TActionList;
    btnCancel: TBCMDButtonFocus;
    btnDelete: TBCMDButtonFocus;
    imgHeight: TImage;
    imgWidth: TImage;
    lblHeight: TLabel;
    lblWidth: TLabel;
    tabDelete: TPageControl;
    pnlCaption1: TBCPanel;
    pnlCaption2: TBCPanel;
    pnlHeight: TPanel;
    pnlList: TPanel;
    pnlBottom: TPanel;
    pnlWidth: TPanel;
    tabTransactions: TTabSheet;
    tabSchedulers: TTabSheet;
    tabBudget: TTabSheet;
    VST3: TLazVirtualStringTree;
    VST1: TLazVirtualStringTree;
    VST2: TLazVirtualStringTree;
    procedure btnCancelClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure pnlBottomResize(Sender: TObject);
    procedure VST1BeforeCellPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
    procedure VST1CompareNodes(Sender: TBaseVirtualTree;
      Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: integer);
    procedure VST1GetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Kind: TVTImageKind; Column: TColumnIndex; var Ghosted: boolean;
      var ImageIndex: integer);
    procedure VST2GetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Kind: TVTImageKind; Column: TColumnIndex; var Ghosted: boolean;
      var ImageIndex: integer);
    procedure VST2GetNodeDataSize(Sender: TBaseVirtualTree; var NodeDataSize: integer);
    procedure VST1GetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure VST1Resize(Sender: TObject);
    procedure VST2GetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure VST2Resize(Sender: TObject);
    procedure VST3GetNodeDataSize(Sender: TBaseVirtualTree; var NodeDataSize: integer);
    procedure VST3GetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure VST3Resize(Sender: TObject);

  private

  public

  end;

var
  frmDelete: TfrmDelete;

implementation

{$R *.lfm}

uses
  uniMain, uniResources, uniScheduler, uniSettings;

  { TfrmDelete }

procedure TfrmDelete.FormCreate(Sender: TObject);
begin
  // form size and position
  frmDelete.Width := IfThen(Screen.PixelsPerInch / 96 > 1, Screen.Width, Round(0.8 * Screen.Width));
  frmDelete.Height := IfThen(Screen.PixelsPerInch / 96 > 1, Screen.Height - 150, Round(0.8 * Screen.Height));
  frmDelete.Left := IfThen(Screen.PixelsPerInch / 96 > 1, 0, (Screen.Width - frmDelete.Width) div 2);
  frmDelete.Top := IfThen(Screen.PixelsPerInch / 96 > 1, 0, (Screen.Height - 100 - frmDelete.Height) div 2);

  VST1.Images := frmMain.ImgTypes;

  // set components height
  VST1.Header.Height := ProgramFontSize + 4;
  if VST1.Header.Height < 20 then
    VST1.Header.Height := 20;

  VST2.Header.Height := ProgramFontSize + 4;
  if VST2.Header.Height < 20 then
    VST2.Header.Height := 20;

  VST3.Header.Height := ProgramFontSize + 4;
  if VST3.Header.Height < 20 then
    VST3.Header.Height := 20;

  pnlCaption1.Height := ProgramFontSize + 4;
  pnlCaption2.Height := ProgramFontSize + 4;

  pnlBottom.Height := ProgramFontSize + 4;
end;

procedure TfrmDelete.btnCancelClick(Sender: TObject);
begin
  frmDelete.ModalResult := mrCancel;
end;

procedure TfrmDelete.btnDeleteClick(Sender: TObject);
begin
  frmDelete.ModalResult := mrOk;
end;

procedure TfrmDelete.FormResize(Sender: TObject);
begin
  frmMain.imgSize.GetBitmap(0, imgWidth.Picture.Bitmap);
  lblWidth.Caption := IntToStr(frmDelete.Width);
  frmMain.imgSize.GetBitmap(1, imgHeight.Picture.Bitmap);
  lblHeight.Caption := IntToStr(frmDelete.Height);
  pnlCaption1.Repaint;
  pnlCaption2.Repaint;
end;

procedure TfrmDelete.FormShow(Sender: TObject);
var
  Delete1: PDelete1;
  Delete2: PDelete2;
  Delete3: PDelete3;
  P: PVirtualNode;
begin
  frmDelete.tabDelete.TabIndex := 0;

  // =======================================================================================
  // TAB TRANSACTIONS
  // =======================================================================================

  VST1.Clear;
  VST1.RootNodeCount := 0;

  screen.Cursor := crHourGlass;
  frmDelete.VST1.BeginUpdate;

  frmMain.QRY.Close;
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
    'cat_parent_id ' + // category parent ID 11

    'FROM data ' + sLineBreak +// FROM tables
    'LEFT JOIN ' + sLineBreak +// JOIN
    'accounts ON (acc_id = d_account), ' + sLineBreak +// accounts
    'categories ON (cat_id = d_category), ' + sLineBreak +// categories
    'persons ON (per_id = d_person), ' + sLineBreak +// categories
    'payees ON (pee_id = d_payee) ' + sLineBreak +// categories
    'WHERE ' + Field(Separ, frmDelete.Hint, 1) + sLineBreak + // WHERE
    'ORDER BY d_date DESC, d_order DESC;'; // order by date and the sorting order

  //ShowMessage(frmMain.QRY.SQL.Text);
  frmMain.QRY.Open;
  while not frmMain.QRY.EOF do
  begin
    frmDelete.VST1.RootNodeCount := frmDelete.VST1.RootNodeCount + 1;
    P := frmDelete.VST1.GetLast();
    Delete1 := frmDelete.VST1.GetNodeData(P);
    Delete1.Date := frmMain.QRY.Fields[0].AsString;
    Delete1.Comment := frmMain.QRY.Fields[1].AsString;
    TryStrToFloat(frmMain.QRY.Fields[2].AsString, Delete1.Amount);
    Delete1.currency := frmMain.QRY.Fields[3].AsString;
    Delete1.Account := frmMain.QRY.Fields[4].AsString;
    Delete1.Category := frmMain.QRY.Fields[5].AsString;
    if frmMain.QRY.Fields[11].AsInteger = 0 then
      Delete1.SubCategory := ''
    else
      Delete1.SubCategory := frmMain.QRY.Fields[6].AsString;
    Delete1.Person := frmMain.QRY.Fields[7].AsString;
    Delete1.Payee := frmMain.QRY.Fields[8].AsString;
    Delete1.ID := frmMain.QRY.Fields[9].AsInteger;
    Delete1.Kind := frmMain.QRY.Fields[10].AsInteger;
    frmMain.QRY.Next;
  end;
  frmMain.QRY.Close;

  SetNodeHeight(frmDelete.VST1);
  frmDelete.VST1.EndUpdate;
  screen.Cursor := crDefault;

  frmDelete.tabTransactions.Caption :=
    Caption_25 + ' (' + IntToStr(VST1.RootNodeCount) + ')';

  if tabDelete.TabIndex = 0 then
    VST1.SetFocus;

  // =======================================================================================
  // TAB SCHEDULER
  // =======================================================================================
  VST2.Clear;
  VST2.RootNodeCount := 0;

  screen.Cursor := crHourGlass;
  frmDelete.VST2.BeginUpdate;

  frmMain.QRY.Close;
  frmMain.QRY.SQL.Text :=
    'SELECT sch_date_from, sch_date_to, sch_period, ' +
    'round(sch_sum1, 2) as sch_sum, sch_comment, acc_currency,' +
    sLineBreak + 'acc_name,' + sLineBreak + // account name 6
    'cat_parent_name,' + sLineBreak + // category name 7
    'cat_name,' + sLineBreak + // subcategory name 8
    'per_name,' + sLineBreak + // Scheduler 9
    'pee_name, ' + sLineBreak + // payee 10
    'sch_id,' + sLineBreak + // ID 11
    'sch_type, ' + sLineBreak +// type (credit, debit, transfer +, transfer -) 12
    'cat_parent_ID ' + // category parent ID 13
    'FROM scheduler ' + sLineBreak +// FROM tables
    'JOIN ' + sLineBreak +// JOIN
    'accounts ON (acc_id = sch_account1), ' + sLineBreak +// accounts
    'categories ON (cat_id = sch_category), ' + sLineBreak +// categories
    'persons ON (per_id = sch_person), ' + sLineBreak +// persons
    'payees ON (pee_id = sch_payee) ' + // payees
    'WHERE ' + Field(Separ, frmDelete.Hint, 2) + sLineBreak + // WHERE
    'ORDER BY sch_date_from;'; // order by date and the sorting order

  //ShowMessage(frmMain.QRY.SQL.Text);
  frmMain.QRY.Open;
  while not frmMain.QRY.EOF do
  begin
    frmDelete.VST2.RootNodeCount := frmDelete.VST2.RootNodeCount + 1;
    P := frmDelete.VST2.GetLast();
    Delete2 := frmDelete.VST2.GetNodeData(P);
    Delete2.DateFrom := frmMain.QRY.Fields[0].AsString;
    Delete2.DateTo := frmMain.QRY.Fields[1].AsString;
    Delete2.Periodicity := frmMain.QRY.Fields[2].AsInteger;
    TryStrToFloat(frmMain.QRY.Fields[3].AsString, Delete2.Amount);
    Delete2.Comment := frmMain.QRY.Fields[4].AsString;
    Delete2.currency := frmMain.QRY.Fields[5].AsString;
    Delete2.Account := frmMain.QRY.Fields[6].AsString;
    Delete2.Category := AnsiUpperCase(frmMain.QRY.Fields[7].AsString);
    if frmMain.QRY.Fields[13].AsInteger = 0 then
      Delete2.SubCategory := ''
    else
      Delete2.SubCategory := AnsiLowerCase(frmMain.QRY.Fields[8].AsString);
    Delete2.Person := frmMain.QRY.Fields[9].AsString;
    Delete2.Payee := frmMain.QRY.Fields[10].AsString;
    Delete2.ID := frmMain.QRY.Fields[11].AsInteger;
    Delete2.Kind := frmMain.QRY.Fields[12].AsInteger;
    frmMain.QRY.Next;
  end;
  frmMain.QRY.Close;

  SetNodeHeight(frmDelete.VST2);
  frmDelete.VST2.EndUpdate;
  screen.Cursor := crDefault;

  frmDelete.tabSchedulers.Caption :=
    AnsiReplaceStr(Menu_41, '&', '') + ' (' + IntToStr(VST2.RootNodeCount) + ')';

  // =======================================================================================
  // TAB BUDGET
  // =======================================================================================
  VST3.Clear;
  VST3.RootNodeCount := 0;

  if Length(Field(Separ, frmDelete.Hint, 3)) > 0 then
  begin
    screen.Cursor := crHourGlass;
    frmDelete.VST3.BeginUpdate;

    frmMain.QRY.Close;
    frmMain.QRY.SQL.Text :=
      'SELECT bud_name, cat_name, cat_parent_name, cat_parent_id, budcat_id ' +
      'FROM budget_categories ' + sLineBreak +// FROM
      'JOIN ' + sLineBreak +// JOIN
      'budgets ON (bud_id = budcat_bud_id), ' + sLineBreak + // budgets
      'categories ON (cat_id = budcat_category) ' + sLineBreak + // categories
      'WHERE ' + Field(Separ, frmDelete.Hint, 3); // WHERE

    //ShowMessage(frmMain.QRY.SQL.Text);
    frmMain.QRY.Open;
    while not frmMain.QRY.EOF do
    begin
      frmDelete.VST3.RootNodeCount := frmDelete.VST3.RootNodeCount + 1;
      P := frmDelete.VST3.GetLast();
      Delete3 := frmDelete.VST3.GetNodeData(P);
      Delete3.BudgetName := frmMain.QRY.Fields[0].AsString;
      Delete3.Category := AnsiUpperCase(frmMain.QRY.Fields[2].AsString);
      if frmMain.QRY.Fields[3].AsInteger = 0 then
        Delete3.SubCategory := ''
      else
        Delete3.SubCategory := AnsiLowerCase(frmMain.QRY.Fields[1].AsString);
      Delete3.ID := frmMain.QRY.Fields[4].AsInteger;
      frmMain.QRY.Next;
    end;
    frmMain.QRY.Close;

    SetNodeHeight(frmDelete.VST3);
    frmDelete.VST3.EndUpdate;
    screen.Cursor := crDefault;
  end;

  frmDelete.tabBudget.Caption :=
    AnsiReplaceStr(Menu_44, '&', '') + ' (' + IntToStr(VST3.RootNodeCount) + ')';
end;

procedure TfrmDelete.pnlBottomResize(Sender: TObject);
begin
  btnCancel.BorderSpacing.Left :=
    (pnlBottom.Width - btnDelete.Width - btnCancel.Width - 2) div 2;
end;

procedure TfrmDelete.VST1BeforeCellPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
begin
  TargetCanvas.Brush.Color := IfThen(Node.Index mod 2 = 0, clRed,
    RGBToColor(255, 120, 120)); //frmSettings.pnlOddRowColor.Color);
  TargetCanvas.FillRect(CellRect);
end;

procedure TfrmDelete.VST1CompareNodes(Sender: TBaseVirtualTree;
  Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: integer);
var
  Data1, Data2: PDelete1;
begin
  Data1 := Sender.GetNodeData(Node1);
  Data2 := Sender.GetNodeData(Node2);
  case Column of
    1: Result := CompareStr(Data1.Date, Data2.Date);
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
end;

procedure TfrmDelete.VST1GetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: boolean; var ImageIndex: integer);
var
  Delete1: PDelete1;
begin
  if Column = 0 then
  begin
    Delete1 := Sender.GetNodeData(Node);
    ImageIndex := Delete1.Kind;
  end;
end;

procedure TfrmDelete.VST2GetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: boolean; var ImageIndex: integer);
var
  Delete2: PDelete2;
begin
  if Column = 0 then
  begin
    Delete2 := Sender.GetNodeData(Node);
    if Delete2.Kind < 2 then
      ImageIndex := Delete2.Kind
    else
      ImageIndex := 4;
  end;
end;

procedure TfrmDelete.VST2GetNodeDataSize(Sender: TBaseVirtualTree;
  var NodeDataSize: integer);
begin
  NodeDataSize := SizeOf(TDelete2);
end;

procedure TfrmDelete.VST1GetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
var
  Delete1: PDelete1;
begin
  Delete1 := Sender.GetNodeData(Node);
  case Column of
    1: CellText := DateToStr(StrToDate(Delete1.Date, 'YYYY-MM-DD', '-'));
    2: CellText := Delete1.Comment;
    3: CellText := Format('%n', [Delete1.Amount], FS_own);
    4: CellText := Delete1.currency;
    5: CellText := Delete1.Account;
    6: CellText := AnsiUpperCase(Delete1.Category);
    7: CellText := Delete1.SubCategory;
    8: CellText := Delete1.Person;
    9: CellText := Delete1.Payee;
    10: CellText := IntToStr(Delete1.ID);
    11: CellText := IntToStr(Delete1.Kind);
  end;
end;

procedure TfrmDelete.VST1Resize(Sender: TObject);
var
  X: integer;

begin
  if frmSettings.chkAutoColumnWidth.Checked = False then Exit;

  try
    (Sender as TLazVirtualStringTree).Header.Columns[0].Width := round(Screen.PixelsPerInch div 96 * 25);
    X := (VST1.Width - VST1.Header.Columns[0].Width) div 100;

    VST1.Header.Columns[1].Width := 10 * X; // date
    VST1.Header.Columns[2].Width := VST1.Width - VST2.Header.Columns[0].Width - ScrollBarWidth - (80 * X); // comment
    VST1.Header.Columns[3].Width := 10 * X; // amount
    VST1.Header.Columns[4].Width := 5 * X; // currency
    VST1.Header.Columns[5].Width := 11 * X; // account
    VST1.Header.Columns[6].Width := 11 * X; // category
    VST1.Header.Columns[7].Width := 11 * X; // subcategory
    VST1.Header.Columns[8].Width := 7 * X; // person
    VST1.Header.Columns[9].Width := 8 * X; // payee
    VST1.Header.Columns[10].Width := 7 * X; // I
  except
  end;
end;

procedure TfrmDelete.VST2GetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
var
  Delete2: PDelete2;
begin
  Delete2 := Sender.GetNodeData(Node);
  case Column of
    1: CellText := DateToStr(StrToDate(Delete2.DateFrom, 'YYYY-MM-DD', '-'));
    2: CellText := DateToStr(StrToDate(Delete2.DateTo, 'YYYY-MM-DD', '-'));
    3: if Delete2.Periodicity < 0 then
        CellText := AnsiReplaceStr(frmScheduler.cbxPeriodicity.Items[1],
          'X', IntToStr(ABS(Delete2.Periodicity)))
      else
        CellText := frmScheduler.cbxPeriodicity.Items[Delete2.Periodicity];
    4: CellText := Format('%n', [Delete2.Amount], FS_own);
    5: CellText := Delete2.currency;
    6: CellText := Delete2.Comment;
    7: CellText := Delete2.Account;
    8: CellText := AnsiUpperCase(Delete2.Category);
    9: CellText := Delete2.SubCategory;
    10: CellText := Delete2.Person;
    11: CellText := Delete2.Payee;
    12: CellText := IntToStr(Delete2.ID);
  end;
end;

procedure TfrmDelete.VST2Resize(Sender: TObject);
var
  X: integer;
begin
  if frmSettings.chkAutoColumnWidth.Checked = False then Exit;

  try
    (Sender as TLazVirtualStringTree).Header.Columns[0].Width := round(Screen.PixelsPerInch div 96 * 25);
    X := (VST2.Width - VST2.Header.Columns[0].Width) div 100;

    VST2.Header.Columns[1].Width := 11 * X; // date from
    VST2.Header.Columns[2].Width := 11 * X; // date to
    VST2.Header.Columns[3].Width := 5 * X; // periodicity
    VST2.Header.Columns[4].Width := 11 * X; // amount
    VST2.Header.Columns[5].Width := 5 * X; // currency
    VST2.Header.Columns[6].Width := VST2.Width - VST2.Header.Columns[0].Width - ScrollBarWidth - (88 * X);
    // comment
    VST2.Header.Columns[7].Width := 9 * X; // account
    VST2.Header.Columns[8].Width := 9 * X; // category
    VST2.Header.Columns[9].Width := 9 * X; // subcategory
    VST2.Header.Columns[10].Width := 7 * X; // person
    VST2.Header.Columns[11].Width := 7 * X; // payee
    VST2.Header.Columns[12].Width := 4 * X; // I
  except
  end;
end;

procedure TfrmDelete.VST3GetNodeDataSize(Sender: TBaseVirtualTree;
  var NodeDataSize: integer);
begin
  NodeDataSize := SizeOf(TDelete3);
end;

procedure TfrmDelete.VST3GetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
var
  Delete3: PDelete3;
begin
  Delete3 := Sender.GetNodeData(Node);
  case Column of
    1: CellText := Delete3.BudgetName;
    2: CellText := Delete3.Category;
    3: CellText := Delete3.SubCategory;
    4: CellText := IntToStr(Delete3.ID);
  end;
end;

procedure TfrmDelete.VST3Resize(Sender: TObject);
var
  X: integer;

begin
  if frmSettings.chkAutoColumnWidth.Checked = False then Exit;

  try
    (Sender as TLazVirtualStringTree).Header.Columns[0].Width := round(Screen.PixelsPerInch div 96 * 25);
    X := (VST3.Width - VST3.Header.Columns[0].Width) div 100;

    VST3.Header.Columns[1].Width := VST3.Width - VST3.Header.Columns[0].Width - ScrollBarWidth - (70 * X);
    VST3.Header.Columns[2].Width := 30 * X; // category
    VST3.Header.Columns[3].Width := 30 * X; // subcategory
    VST3.Header.Columns[4].Width := 10 * X; // ID
  except
  end;
end;

end.
