unit uniRecycleBin;

{$mode objfpc}{$H+}
{$ModeSwitch AutoDeref}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  ComCtrls, SQLDB, LazUTF8, DateUtils, ActnList, StdCtrls, laz.VirtualTrees,
  BCPanel, BCMDButtonFocus, StrUtils, Math;

type // main grid (Trash)
  TTrash = record
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
  PTrash = ^TTrash;

type

  { TfrmRecycleBin }

  TfrmRecycleBin = class(TForm)
    actExit: TAction;
    actDelete: TAction;
    actEdit: TAction;
    actSelect: TAction;
    actRestore: TAction;
    ActionList1: TActionList;
    btnDelete: TBCMDButtonFocus;
    btnEdit: TBCMDButtonFocus;
    btnExit: TBCMDButtonFocus;
    btnRestore: TBCMDButtonFocus;
    btnSelect: TBCMDButtonFocus;
    cbxView: TComboBox;
    imgHeight: TImage;
    imgItem: TImage;
    imgItems: TImage;
    imgWidth: TImage;
    lblView: TLabel;
    lblHeight: TLabel;
    lblItem: TLabel;
    lblItems: TLabel;
    lblWidth: TLabel;
    pnlView: TPanel;
    pnlButtons: TPanel;
    pnlHeight: TPanel;
    pnlItem: TPanel;
    pnlItems: TPanel;
    pnlList: TPanel;
    pnlListCaption: TBCPanel;
    pnlBottom: TPanel;
    pnlWidth: TPanel;
    VST: TLazVirtualStringTree;
    procedure btnDeleteClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure btnRestoreClick(Sender: TObject);
    procedure btnSelectClick(Sender: TObject);
    procedure cbxViewChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure pnlButtonsResize(Sender: TObject);
    procedure VSTBeforeCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas;
      Node: PVirtualNode; Column: TColumnIndex; CellPaintMode: TVTCellPaintMode;
      CellRect: TRect; var ContentRect: TRect);
    procedure VSTChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure VSTCompareNodes(Sender: TBaseVirtualTree; Node1, Node2: PVirtualNode;
      Column: TColumnIndex; var Result: integer);
    procedure VSTDblClick(Sender: TObject);
    procedure VSTGetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Kind: TVTImageKind; Column: TColumnIndex; var Ghosted: boolean;
      var ImageIndex: integer);
    procedure VSTGetNodeDataSize(Sender: TBaseVirtualTree; var NodeDataSize: integer);
    procedure VSTGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure VSTPaintText(Sender: TBaseVirtualTree; const TargetCanvas: TCanvas;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType);
    procedure VSTResize(Sender: TObject);
    //procedure lviListClick(Sender: TObject);
    //procedure lviListCustomDrawSubItem(Sender: TCustomListView;
    //  Item: TListItem; SubItem: integer; State: TCustomDrawState;
    //  var DefaultDraw: boolean);
    //procedure lviListData(Sender: TObject; Item: TListItem);
    //procedure lviListSelectItem(Sender: TObject; Item: TListItem;
    //  Selected: boolean);
  private

  public

  end;

var
  frmRecycleBin: TfrmRecycleBin;

procedure UpdateRecycles;

implementation

{$R *.lfm}

uses
  uniMain, uniSettings, uniResources, uniEdit, uniEdits;

  { TfrmRecycleBin }

procedure TfrmRecycleBin.FormResize(Sender: TObject);
begin
  try
    lblWidth.Caption := IntToStr(frmRecycleBin.Width);
    lblHeight.Caption := IntToStr(frmRecycleBin.Height);
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmRecycleBin.FormShow(Sender: TObject);
begin
  UpdateRecycles;
end;

procedure TfrmRecycleBin.pnlButtonsResize(Sender: TObject);
begin
  btnDelete.Width := pnlButtons.Width div 9;
  btnEdit.Width := btnDelete.Width;
  btnSelect.Width := btnDelete.Width;
  btnRestore.Width := btnDelete.Width;
  btnExit.Width := btnDelete.Width;

  btnDelete.Repaint;
  btnExit.Repaint;
  btnEdit.Repaint;
  btnSelect.Repaint;
  btnRestore.Repaint;
end;

procedure TfrmRecycleBin.VSTBeforeCellPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
begin
  if (Column in [4..6, 8..9]) and (VST.Text[Node, Column] = '') then
    TargetCanvas.Brush.Color := clYellow
  else
    TargetCanvas.Brush.Color :=
      IfThen(Node.Index mod 2 = 0, IfThen(Dark = False, RGBToColor(100, 100, 100), RGBToColor(44, 44, 44)),
      IfThen(Dark = False, clGray, RGBToColor(22, 22, 22)));

  TargetCanvas.FillRect(CellRect);
end;

procedure TfrmRecycleBin.VSTChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  ReNewAble: boolean;
  N: PVirtualNode;
begin
  Renewable := False;
  if VST.SelectedCount > 0 then
  begin
    Renewable := True;
    for N in VST.Nodes(False) do
      if VST.Selected[N] = True then
        if ((VST.Text[N, 5] = '') or (VST.Text[N, 6] = '') or
          (VST.Text[N, 8] = '') or (VST.Text[N, 9] = '')) then
          Renewable := False;
  end;
  btnRestore.Enabled := ReNewAble;
  btnEdit.Enabled := VST.SelectedCount > 0;
  btnDelete.Enabled := VST.SelectedCount > 0;

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
end;

procedure TfrmRecycleBin.VSTCompareNodes(Sender: TBaseVirtualTree;
  Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: integer);
var
  Data1, Data2: PTrash;
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

procedure TfrmRecycleBin.VSTDblClick(Sender: TObject);
begin
  if VST.SelectedCount > 0 then
    btnEditClick(btnEdit);
end;

procedure TfrmRecycleBin.VSTGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: boolean; var ImageIndex: integer);
var
  Trash: PTrash;
begin
  if Column = 0 then
  begin
    Trash := Sender.GetNodeData(Node);
    ImageIndex := Trash.Kind;
  end;
end;

procedure TfrmRecycleBin.VSTGetNodeDataSize(Sender: TBaseVirtualTree;
  var NodeDataSize: integer);
begin
  NodeDataSize := SizeOf(TTrash);
end;

procedure TfrmRecycleBin.VSTGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  Trash: PTrash;
  B: byte;
begin
  Trash := Sender.GetNodeData(Node);
  try
    case Column of
      1: begin
        B := DayOfTheWeek(StrToDate(Trash.Date, 'YYYY-MM-DD', '-')) + 1;
        if B = 8 then
          B := 1;
        CellText := FS_own.ShortDayNames[B] + ' ' +
          DateToStr(StrToDate(Trash.Date, 'YYYY-MM-DD', '-'), FS_own);
      end;
      2: CellText := Trash.Comment;
      3: CellText := Format('%n', [Trash.Amount], FS_own);
      4: CellText := Trash.currency;
      5: CellText := Trash.Account;
      6: CellText := AnsiUpperCase(Trash.Category);
      7: CellText := IfThen(frmSettings.chkDisplaySubCatCapital.Checked =
          True, AnsiUpperCase(Trash.SubCategory), Trash.SubCategory);
      8: CellText := Trash.Person;
      9: CellText := Trash.Payee;
      10: CellText := IntToStr(Trash.ID);
    end;
  except
  end;
end;

procedure TfrmRecycleBin.VSTPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
var
  Trash: PTrash;
begin
  try
    if (Column > 4) and (VST.Text[Node, Column] = '') then
    begin
      TargetCanvas.Font.Color :=
        IfThen(Dark = False, clYellow, $0000B5BF);
      TargetCanvas.Font.Bold := True;
    end
    else
    begin
      Trash := (Sender as TLazVirtualStringTree).GetNodeData(Node);
      if (Column = 3) and (Trash.Amount < 0) then
        TargetCanvas.Font.Color :=
          IfThen(Dark = False, clRed, $007873F4)
      else
        TargetCanvas.Font.Color :=
          IfThen(Dark = False, clWhite, clSilver);
    end;
  except
  end;
end;

procedure TfrmRecycleBin.VSTResize(Sender: TObject);
var
  X: integer;
begin
  if frmSettings.chkAutoColumnWidth.Checked = False then Exit;

  try
    VST.Header.Columns[0].Width := Round(ScreenRatio * 25 / 100);
    X := (VST.Width - VST.Header.Columns[0].Width) div 100;

    VST.Header.Columns[1].Width := 10 * X; // date
    VST.Header.Columns[2].Width :=
      VST.Width - VST.Header.Columns[0].Width - ScrollBarWidth - (81 * X); // comment
    VST.Header.Columns[3].Width := 10 * X; // amount
    VST.Header.Columns[4].Width := 5 * X; // currency
    VST.Header.Columns[5].Width := 12 * X; // account
    VST.Header.Columns[6].Width := 11 * X; // category
    VST.Header.Columns[7].Width := 12 * X; // subcategory
    VST.Header.Columns[8].Width := 7 * X; // person
    VST.Header.Columns[9].Width := 8 * X; // payee
    VST.Header.Columns[10].Width := 6 * X; // ID
    pnlListCaption.Repaint;
  except
  end;
end;

procedure TfrmRecycleBin.btnExitClick(Sender: TObject);
begin
  frmRecycleBin.Close;
end;

procedure TfrmRecycleBin.btnRestoreClick(Sender: TObject);
var
  N: PVirtualNode;
  Str: string;
begin
  if (VST.SelectedCount = 0) then
    exit;

  if MessageDlg(Message_00, Question_12, mtWarning, mbYesNo, 0) <> 6 then
    Exit;

  screen.Cursor := crHourGlass;

  try
    frmMain.QRY.Close;
    frmMain.Tran.Commit;
    frmMain.Tran.StartTransaction;

    for N in VST.Nodes(False) do
      if VST.Selected[N] = True then
      begin
        // insert transaction into data
        frmMain.QRY.SQL.Text :=
          'INSERT INTO data ' +
          '(d_date, d_type, d_sum, d_comment, d_person, d_category, d_account, d_payee, d_order) '
          + 'SELECT rec_date, rec_type, rec_sum, rec_comment, rec_person, rec_category, rec_account, rec_payee,'
          + '(SELECT COUNT(*) FROM data WHERE d_date = rec_date  AND d_account = rec_account) '
          + 'FROM recycles WHERE rec_id = :ID;';
        frmMain.QRY.Params.ParamByName('ID').AsString := VST.Text[N, 10];
        frmMain.QRY.Prepare;
        frmMain.QRY.ExecSQL;

        Str := frmMain.Conn.GetInsertID.ToString;
        frmMain.QRY.SQL.Text :=
          'INSERT INTO data_tags (dt_data, dt_tag) ' + 'SELECT "' +
          Str + '", rt_tag FROM recycle_tags WHERE rt_recycle = :ID;';
        frmMain.QRY.Params.ParamByName('ID').AsString := VST.Text[N, 10];
        frmMain.QRY.Prepare;
        frmMain.QRY.ExecSQL;

        frmMain.QRY.SQL.Text :=
          'DELETE FROM recycles WHERE rec_id = :ID;';
        frmMain.QRY.Params.ParamByName('ID').AsString := VST.Text[N, 10];
        frmMain.QRY.Prepare;
        frmMain.QRY.ExecSQL;
      end;

    frmMain.Tran.Commit;
    Vacuum;
    UpdateRecycles;
    UpdateTransactions;
    screen.Cursor := crDefault;
  except
    on E: Exception do
    begin
      screen.Cursor := crDefault;
      ShowErrorMessage(E);
    end;
  end;
end;

procedure TfrmRecycleBin.btnSelectClick(Sender: TObject);
begin
  if VST.RootNodeCount < 2 then
    Exit;
  VST.SelectAll(False);
  VST.SetFocus;
end;

procedure TfrmRecycleBin.cbxViewChange(Sender: TObject);
begin
  UpdateRecycles;
end;

procedure TfrmRecycleBin.FormCreate(Sender: TObject);
begin
  try
    // set components height
    VST.Header.Height := PanelHeight;
    pnlListCaption.Height := PanelHeight;
    pnlButtons.Height := ButtonHeight;
    pnlBottom.Height := ButtonHeight;

    // get form icon
    frmMain.img16.GetIcon(8, (Sender as TForm).Icon);
  except
  end;
end;

procedure TfrmRecycleBin.btnDeleteClick(Sender: TObject);
var
  N: PVirtualNode;
  IDs: string;
begin
  if (frmMain.Conn.Connected = False) or (VST.SelectedCount = 0) then
    exit;

  try
    case VST.SelectedCount of
      1: begin
        if MessageDlg(Message_00, Question_01 + sLineBreak + sLineBreak +
          VST.Header.Columns[1].Text + ': ' + VST.Text[VST.FocusedNode, 1] +
          sLineBreak + // date
          VST.Header.Columns[2].Text + ': ' + VST.Text[VST.FocusedNode, 2] +
          sLineBreak + VST.Header.Columns[3].Text + ': ' +
          VST.Text[VST.FocusedNode, 3] + '  ' + VST.Text[VST.FocusedNode, 4],
          mtConfirmation, mbYesNo, 0) <> 6 then
        begin
          VST.SetFocus;
          Exit;
        end;
      end
      else
        if MessageDlg(Message_00, AnsiReplaceStr(Question_02, '%',
          IntToStr(VST.SelectedCount)), mtConfirmation, mbYesNo, 0) <> 6 then
        begin
          VST.SetFocus;
          Exit;
        end;
    end;

    // get IDs of all selected nodes
    IDs := '';
    N := VST.GetFirstSelected(False);
    try
      while Assigned(N) do
      begin
        IDs := IDs + VST.Text[N, 10] + ',';
        N := VST.GetNextSelected(N);
      end;
    finally
      IDs := LeftStr(IDs, Length(IDs) - 1);
    end;

  finally
    frmMain.QRY.SQL.Text := 'DELETE FROM recycles WHERE rec_id IN (' + IDs + ');';
    frmMain.QRY.ExecSQL;
    frmMain.Tran.Commit;

    Vacuum;
    UpdateRecycles;
  end;
end;

procedure TfrmRecycleBin.btnEditClick(Sender: TObject);
var
  ID: integer;
begin
  case VST.SelectedCount of
    0: Exit;
    1: begin
      frmEdit.Tag := 2;
      ID := StrToInt(VST.Text[VST.GetFirstSelected(), 10]);
      if frmEdit.ShowModal <> mrOk then
        Exit;
    end
    else
    begin
      frmEdits.Tag := 2;
      ID := 0;
      frmEdits.btnResetClick(frmEdits.btnReset);
      if frmEdits.ShowModal <> mrOk then
        Exit;
    end;
  end;

  UpdateRecycles;

  if ID > 0 then
    FindEditedRecord(VST, 10, ID);

  VST.SetFocus;
end;

procedure UpdateRecycles;
var
  Trash: PTrash;
  H: PVirtualNode;
begin
  try
    screen.Cursor := crHourGlass;
    frmRecycleBin.VST.Clear;
    frmRecycleBin.VST.RootNodeCount := 0;

    if frmRecycleBin.cbxView.ItemIndex = -1 then Exit;

    // =============================================================================================

    frmMain.QRY.SQL.Text :=
      'SELECT rec_date, ' + // 0
      'rec_comment, ' + // 1
      'rec_sum, ' + sLineBreak + // 2
      '(SELECT acc_currency FROM accounts WHERE acc_id = rec_account) as acc_currency, '
      +
      // 3
      sLineBreak + '(SELECT acc_name FROM accounts WHERE acc_id = rec_account) as acc_name, '
      + // 4
      sLineBreak +
      '(SELECT cat_parent_id FROM categories WHERE cat_id = rec_category) as cat_parent_id, '
      +
      sLineBreak + // cat_parent_id  5
      '(SELECT cat_parent_name FROM categories WHERE cat_id = rec_category) as cat_parent_name, '
      + sLineBreak + // cat_parent_name 6
      '(SELECT cat_name FROM categories WHERE cat_id = rec_category) as cat_name, ' +
      sLineBreak +
      // cat_name 7
      '(SELECT per_name FROM persons WHERE per_id = rec_person) as per_name, ' +
      sLineBreak +
      // person 8
      '(SELECT pee_name FROM payees WHERE pee_id = rec_payee) as pee_name, ' + // 9
      'rec_id, ' + // 10
      'rec_type ' + // 11
      sLineBreak + // other fields 9
      'FROM recycles ' + sLineBreak + // FROM tables
      // order by
      'ORDER BY rec_date DESC;'; // order by date and the sorting order
  except
  end;

  try
    frmRecycleBin.VST.BeginUpdate;
    frmMain.QRY.Open;
    while not frmMain.QRY.EOF do
    begin
      if (frmRecycleBin.cbxView.ItemIndex = 0) or
        ((frmRecycleBin.cbxView.ItemIndex = 1) and
        ((frmMain.QRY.Fields[5].AsString <> '') and
        (frmMain.QRY.Fields[6].AsString <> '') and
        (frmMain.QRY.Fields[8].AsString <> '') and
        (frmMain.QRY.Fields[9].AsString <> ''))) or
        ((frmRecycleBin.cbxView.ItemIndex = 2) and
        ((frmMain.QRY.Fields[5].AsString = '') or
        (frmMain.QRY.Fields[6].AsString = '') or
        (frmMain.QRY.Fields[8].AsString = '') or
        (frmMain.QRY.Fields[9].AsString = ''))) then
      begin
        frmRecycleBin.VST.RootNodeCount := frmRecycleBin.VST.RootNodeCount + 1;
        H := frmRecycleBin.VST.GetLast();
        Trash := frmRecycleBin.VST.GetNodeData(H);

        Trash.Date := frmMain.QRY.Fields[0].AsString;
        Trash.Comment := frmMain.QRY.Fields[1].AsString;
        TryStrToFloat(frmMain.QRY.Fields[2].AsString, Trash.Amount);
        Trash.currency := frmMain.QRY.Fields[3].AsString;
        Trash.Account := frmMain.QRY.Fields[4].AsString;
        Trash.Category := frmMain.QRY.Fields[6].AsString;
        Trash.SubCategory := IfThen(frmMain.QRY.Fields[5].AsString =
          '0', '', frmMain.QRY.Fields[7].AsString);
        Trash.Person := frmMain.QRY.Fields[8].AsString;
        Trash.Payee := frmMain.QRY.Fields[9].AsString;
        Trash.ID := frmMain.QRY.Fields[10].AsInteger;
        Trash.Kind := frmMain.QRY.Fields[11].AsInteger;
      end;
      frmMain.QRY.Next;
    end;

  finally
    frmMain.QRY.Close;
    SetNodeHeight(frmRecycleBin.VST);
    frmRecycleBin.VST.EndUpdate;

    // buttons
    frmRecycleBin.btnDelete.Enabled := False;
    frmRecycleBin.btnRestore.Enabled := False;
    frmRecycleBin.btnSelect.Enabled := frmRecycleBin.VST.RootNodeCount > 1;

    // items icon
    frmRecycleBin.lblItems.Caption := IntToStr(frmRecycleBin.VST.RootNodeCount);
    screen.Cursor := crDefault;
  end;
end;

end.
