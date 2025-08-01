unit uniWrite;

{$mode ObjFPC}{$H+}
{$ModeSwitch AutoDeref}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, ActnList, LazUtf8,
  StdCtrls, Menus, BCPanel, BCMDButtonFocus, laz.VirtualTrees, StrUtils, Math, ComCtrls,
  DateUtils;

type // main grid (Write)
  TWrite = record
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
  PWrite = ^TWrite;

type

  { TfrmWrite }

  TfrmWrite = class(TForm)
    actExit: TAction;
    actDelete: TAction;
    actEdit: TAction;
    actCalendar: TAction;
    actSettings: TAction;
    ActionList1: TActionList;
    actSave: TAction;
    btnExit: TBCMDButtonFocus;
    btnCalendar: TBCMDButtonFocus;
    btnDelete: TBCMDButtonFocus;
    btnEdit: TBCMDButtonFocus;
    btnSave: TBCMDButtonFocus;
    btnSettings: TBCMDButtonFocus;
    imgChecked1: TImage;
    imgHeight: TImage;
    imgItem: TImage;
    imgItems: TImage;
    imgChecked: TImage;
    imgSum2: TImage;
    imgSum1: TImage;
    imgSum3: TImage;
    imgWidth: TImage;
    lblHeight: TLabel;
    lblItem: TLabel;
    lblItems: TLabel;
    lblChecked: TLabel;
    lblSum2: TLabel;
    lblSum1: TLabel;
    lblWidth: TLabel;
    MenuItem3: TMenuItem;
    pnlBottom: TPanel;
    pnlButtons: TPanel;
    pnlSum2: TPanel;
    pnlSum1: TPanel;
    pnlHeight: TPanel;
    pnlItem: TPanel;
    pnlItems: TPanel;
    pnlList: TPanel;
    pnlListCaption: TBCPanel;
    pnlChecked: TPanel;
    pnlWidth: TPanel;
    popDelete: TMenuItem;
    popEdit: TMenuItem;
    popExit: TMenuItem;
    popList: TPopupMenu;
    popSave: TMenuItem;
    popCalendar: TMenuItem;
    Separator1: TMenuItem;
    VST: TLazVirtualStringTree;
    procedure btnExitClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCalendarClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnSettingsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    //procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure pnlBottomResize(Sender: TObject);
    procedure VSTBeforeCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas;
      Node: PVirtualNode; Column: TColumnIndex; CellPaintMode: TVTCellPaintMode;
      CellRect: TRect; var ContentRect: TRect);
    procedure VSTChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure VSTChecked(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure VSTCompareNodes(Sender: TBaseVirtualTree;
      Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: integer);
    procedure VSTDblClick(Sender: TObject);
    procedure VSTGetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Kind: TVTImageKind; Column: TColumnIndex; var Ghosted: boolean;
      var ImageIndex: integer);
    procedure VSTGetNodeDataSize(Sender: TBaseVirtualTree; var NodeDataSize: integer);
    procedure VSTGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure VSTHeaderClick(Sender: TVTHeader; HitInfo: TVTHeaderHitInfo);
    procedure VSTInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode;
      var InitialStates: TVirtualNodeInitStates);
    procedure VSTPaintText(Sender: TBaseVirtualTree; const TargetCanvas: TCanvas;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType);
    procedure VSTResize(Sender: TObject);
  private

  public

  end;

var
  frmWrite: TfrmWrite;

procedure UpdatePayments;

implementation

{$R *.lfm}

{ TfrmWrite }

uses
  uniMain, uniSettings, uniCalendar, uniResources, uniEdit, uniwriting, uniEdits;

procedure TfrmWrite.FormResize(Sender: TObject);
begin
  lblWidth.Caption := IntToStr((Sender as TForm).Width);
  lblHeight.Caption := IntToStr((Sender as TForm).Height);

  pnlListCaption.Repaint;
end;

procedure TfrmWrite.FormShow(Sender: TObject);
begin
  if frmMain.Conn.Connected = True then
    UpdatePayments;

  // btnEdit
  btnEdit.Enabled := VST.SelectedCount > 0;
  popEdit.Enabled := VST.SelectedCount > 0;
  actEdit.Enabled := VST.SelectedCount > 0;

  // btnDelete
  btnDelete.Enabled := VST.SelectedCount > 0;
  popDelete.Enabled := VST.SelectedCount > 0;
  actDelete.Enabled := VST.SelectedCount > 0;

  // btnSave
  btnSave.Enabled := VST.CheckedCount > 0;
  popSave.Enabled := VST.CheckedCount > 0;
  actSave.Enabled := VST.CheckedCount > 0;

  SetNodeHeight(VST);
  VST.SetFocus;
  VST.ClearSelection;
end;

procedure TfrmWrite.pnlBottomResize(Sender: TObject);
begin
  pnlWidth.Width := (pnlBottom.Width - 10) div 7;
  pnlHeight.Width := pnlWidth.Width;
  pnlChecked.Width := pnlWidth.Width;
  pnlSum1.Width := pnlWidth.Width;
  pnlSum2.Width := pnlWidth.Width;
  pnlItems.Width := pnlWidth.Width;
end;

procedure TfrmWrite.VSTBeforeCellPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
var
  Write: PWrite;
begin
  Write := Sender.GetNodeData(Node);
  if Write.Date > FormatDateTime('YYYY-MM-DD', Now()) then
    TargetCanvas.Brush.Color := FullColor
  else
    TargetCanvas.Brush.Color := // color
    IfThen(Node.Index mod 2 = 0, // odd row
    IfThen(Dark = False, clWhite, rgbToColor(22, 22, 22)),
    IfThen(Dark = False, frmSettings.pnlOddRowColor.Color,
    Brighten(frmSettings.pnlOddRowColor.Color, 44)));
  TargetCanvas.FillRect(CellRect);
end;

procedure TfrmWrite.VSTChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
begin
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

  // set buttons
  popEdit.Enabled := VST.SelectedCount > 0;
  popDelete.Enabled := VST.SelectedCount > 0;
  btnEdit.Enabled := VST.SelectedCount > 0;
  btnDelete.Enabled := VST.SelectedCount > 0;
end;

procedure TfrmWrite.VSTChecked(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  N: PVirtualNode;
  D, S: double;
begin
  lblChecked.Caption := IntToStr(VST.CheckedCount);
  btnSave.Enabled := VST.CheckedCount > 0;

  // get sum of checked nodes
  D := 0.0;
  N := VST.GetFirst;
  while Assigned(N) do
  begin
    if N.CheckState = csCheckedNormal then
    begin
      TryStrToFloat(AnsiReplaceStr(VST.Text[N, 3], FS_own.ThousandSeparator, ''), S);
      D := D + S;
    end;
    N := VST.GetNext(N);
  end;
  lblSum1.Caption := Format('%n', [D], FS_own);
end;

procedure TfrmWrite.VSTCompareNodes(Sender: TBaseVirtualTree;
  Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: integer);
var
  Data1, Data2: PWrite;
begin
  Data1 := Sender.GetNodeData(Node1);
  Data2 := Sender.GetNodeData(Node2);
  case Column of
    0: Result := CompareValue(Data1.Kind, Data2.Kind);
    1: Result := UTF8CompareText(Data1.Date, Data2.Date);
    2: Result := UTF8CompareText(Data1.Comment, Data2.Comment);
    3: Result := CompareValue(Data1.Amount, Data2.Amount);
    4: Result := UTF8CompareText(Data1.currency, Data2.currency);
    5: Result := UTF8CompareText(Data1.Account, Data2.Account);
    6: Result := UTF8CompareText(Data1.Category, Data2.Category);
    7: Result := UTF8CompareText(Data1.SubCategory, Data2.SubCategory);
    8: Result := UTF8CompareText(Data1.Person, Data2.Person);
    9: Result := UTF8CompareText(Data1.Payee, Data2.Payee);
    10: Result := CompareValue(Data1.ID, Data2.Id)
  end;
end;

procedure TfrmWrite.VSTDblClick(Sender: TObject);
begin
  if VST.SelectedCount > 0 then
    btnEditClick(btnEdit);
end;

procedure TfrmWrite.VSTGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: boolean; var ImageIndex: integer);
var
  Write: PWrite;
begin
  if Column = 0 then
  begin
    Write := Sender.GetNodeData(Node);
    ImageIndex := Write.Kind;
  end;
end;

procedure TfrmWrite.VSTGetNodeDataSize(Sender: TBaseVirtualTree;
  var NodeDataSize: integer);
begin
  NodeDataSize := SizeOf(TWrite);
end;

procedure TfrmWrite.VSTGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
var
  Write: PWrite;
  B: byte;
begin
  Write := Sender.GetNodeData(Node);
  case Column of
    1: begin
      B := DayOfTheWeek(StrToDate(Write.Date, 'YYYY-MM-DD', '-')) + 1;
      if B = 8 then
        B := 1;
      CellText := FS_own.ShortDayNames[B] + ' ' +
        DateToStr(StrToDate(Write.Date, 'YYYY-MM-DD', '-'), FS_own);
    end;
    2: CellText := Write.Comment;
    3: CellText := Format('%n', [Write.Amount], FS_own);
    4: CellText := Write.currency;
    5: CellText := Write.Account;
    6: CellText := AnsiUpperCase(Write.Category);
    7: CellText := IfThen(frmSettings.chkDisplaySubCatCapital.Checked =
        True, AnsiUpperCase(Write.SubCategory), AnsiLowerCase(Write.SubCategory));
    8: CellText := Write.Person;
    9: CellText := Write.Payee;
    10: CellText := IntToStr(Write.ID);
    11: CellText := IntToStr(Write.Kind);
  end;
end;

procedure TfrmWrite.VSTHeaderClick(Sender: TVTHeader; HitInfo: TVTHeaderHitInfo);
begin
  if (HitInfo.Column > 0) then Exit;
  VST.Tag := IfThen(Sender.Columns[0].CheckState = csCheckedNormal, 1, 0);
  CheckAllNodes(VST);
  VST.Repaint;
end;

procedure TfrmWrite.VSTInitNode(Sender: TBaseVirtualTree;
  ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
begin
  Node.CheckType := ctCheckBox;
end;

procedure TfrmWrite.VSTPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
var
  Write: PWrite;
begin
  TargetCanvas.Font.Bold := (Column = 3) and
    (frmSettings.chkDisplayFontBold.Checked = True);

  if vsSelected in node.States then exit;

  Write := Sender.GetNodeData(Node);
  if Write.Date > FormatDateTime('YYYY-MM-DD', Now()) then
    TargetCanvas.Font.Color := frmSettings.btnCaptionColorFont.Tag
  else
    case Write.Kind of

      // credit color
      0: case frmSettings.pnlCreditTransactionsColor.Tag of
          0: TargetCanvas.Font.Color :=
              IfThen(Dark = False, clDefault, clSilver);
          1: begin
            if Column = 3 then
              TargetCanvas.Font.Color :=
                IfThen(Dark = False, clBlue, $00FFB852)
            else
              TargetCanvas.Font.Color :=
                IfThen(Dark = False, clDefault, clSilver);
          end
          else
            TargetCanvas.Font.Color :=
              IfThen(Dark = False, clBlue, $00FFB852)
        end;

      // debit color
      1: case frmSettings.pnlDebitTransactionsColor.Tag of
          0: TargetCanvas.Font.Color :=
              IfThen(Dark = False, clDefault, clSilver);
          1: begin
            if Column = 3 then
              TargetCanvas.Font.Color :=
                IfThen(Dark = False, clRed, $006A64FF)
            else
              TargetCanvas.Font.Color :=
                IfThen(Dark = False, clDefault, clSilver);
          end
          else
            TargetCanvas.Font.Color :=
              IfThen(Dark = False, clRed, $006A64FF)
        end;

      // transfer plus color
      2: case frmSettings.pnlTransferPTransactionsColor.Tag of
          0: TargetCanvas.Font.Color :=
              IfThen(Dark = False, clDefault, clSilver);
          1: begin
            if Column = 3 then
              TargetCanvas.Font.Color :=
                IfThen(Dark = False, clGreen, $0062FF52)
            else
              TargetCanvas.Font.Color :=
                IfThen(Dark = False, clDefault, clSilver);
          end
          else
            TargetCanvas.Font.Color :=
              IfThen(Dark = False, clGreen, $0062FF52);
        end;

        // transfer minus color
      else
        case frmSettings.pnlTransferMTransactionsColor.Tag of
          0: TargetCanvas.Font.Color :=
              IfThen(Dark = False, clDefault, clSilver);
          1: begin
            if Column = 3 then
              TargetCanvas.Font.Color := rgbToColor(240, 160, 0)
            else
              TargetCanvas.Font.Color :=
                IfThen(Dark = False, clDefault, clSilver);
          end
          else
            TargetCanvas.Font.Color := rgbToColor(240, 160, 0);
        end;
    end;
end;

procedure TfrmWrite.VSTResize(Sender: TObject);
var
  X: integer;
begin
  if frmSettings.chkAutoColumnWidth.Checked = False then Exit;

  (Sender as TLazVirtualStringTree).Header.Columns[0].Width :=
    Round(ScreenRatio * 40 / 100);
  X := (VST.Width - VST.Header.Columns[0].Width) div 100;
  VST.Header.Columns[1].Width := 8 * X; // date 100
  VST.Header.Columns[2].Width :=
    VST.Width - ScrollBarWidth - VST.Header.Columns[0].Width - (83 * X); // comment
  VST.Header.Columns[3].Width := 8 * X; // amount 100
  VST.Header.Columns[4].Width := 5 * X; // currency 50
  VST.Header.Columns[5].Width := 12 * X; // account
  VST.Header.Columns[6].Width := 12 * X; // category
  VST.Header.Columns[7].Width := 12 * X; // subcategory
  VST.Header.Columns[8].Width := 10 * X; // person
  VST.Header.Columns[9].Width := 12 * X; // payee
  VST.Header.Columns[10].Width := 4 * X; // ID 50
end;

procedure TfrmWrite.btnExitClick(Sender: TObject);
begin
  frmWrite.ModalResult := mrCancel;
end;

procedure TfrmWrite.btnCalendarClick(Sender: TObject);
begin
  frmCalendar.Showmodal;
end;

procedure TfrmWrite.btnDeleteClick(Sender: TObject);
var
  N: PVirtualNode;
  IDs: string;
begin
  if (frmMain.Conn.Connected = False) or (VST.RootNodeCount = 0) or
    (VST.SelectedCount = 0) then
    exit;

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

  if MessageDlg(Message_00, Format(Question_17, [sLineBreak]),
    mtConfirmation, mbYesNo, 0) <> 6 then
    Exit;

  frmMain.QRY.SQL.Text := 'DELETE FROM payments WHERE pay_id IN (' + IDs + ')';
  //ShowMessage (frmMain.QRY.SQL.Text);
  frmMain.QRY.ExecSQL;
  frmMain.Tran.Commit;

  Vacuum;
  FormShow(frmWrite);
end;

procedure TfrmWrite.btnEditClick(Sender: TObject);
var
  ID: integer;
begin
  case VST.SelectedCount of
    0: Exit;
    1: begin
      frmEdit.Tag := 5;
      ID := StrToInt(VST.Text[VST.GetFirstSelected(), 10]);
      if frmEdit.ShowModal <> mrOk then
        Exit;
    end
    else
    begin
      frmEdits.Tag := 5;
      ID := 0;
      frmEdits.btnResetClick(frmEdits.btnReset);
      if frmEdits.ShowModal <> mrOk then
        Exit;
    end;
  end;

  FormShow(frmWrite);

  if ID > 0 then
    FindEditedRecord(VST, 10, ID);
  VST.SetFocus;
end;

procedure TfrmWrite.btnSettingsClick(Sender: TObject);
var
  vNode: TTreeNode;
begin
  for vNode in frmSettings.treSettings.Items do
  begin
    if vNode.AbsoluteIndex = 7 then
      vNode.Selected := True;
  end;
  frmSettings.tabTool.TabIndex := 1;
  frmSettings.ShowModal;
end;

procedure TfrmWrite.FormCreate(Sender: TObject);
begin
  VST.Header.Height := PanelHeight;
  pnlButtons.Height := ButtonHeight;
  pnlBottom.Height := ButtonHeight;
  pnlListCaption.Height := PanelHeight;

  // get form icon
  frmMain.img16.GetIcon(19, (Sender as TForm).Icon);
end;

procedure TfrmWrite.btnSaveClick(Sender: TObject);
var
  N: PVirtualNode;
  Write: PWrite;
  IDs, Str: string;
  T: TStringList;
  I: cardinal;
begin
  frmWriting.lblWrite.Caption := Format(Caption_166, [IntToStr(VST.CheckedCount)]);

  // set writing way - separately or all at once
  if frmSettings.chkPaymentSeparately.Checked = False then
    frmWriting.rbtWriteAtOnce.Checked := True
  else
    frmWriting.rbtWriteGradually.Checked := True;

  if frmWriting.ShowModal <> mrOk then Exit;

  // ---------------------
  // all at once writing
  // ---------------------
  if frmWriting.rbtWriteAtOnce.Checked = True then
  begin
    frmMain.Tran.Commit;
    N := VST.GetFirstChecked();

    try
      while Assigned(N) do
      begin
        // check date restrictions
        if frmSettings.rbtTransactionsAddDate.Checked = True then
        begin
          Write := VST.GetNodeData(N);
          if (Write.Date < FormatDateTime('YYYY-MM-DD',
            frmSettings.datTransactionsAddDate.Date)) then
          begin
            ShowMessage(Error_29 + ' ' + DateToStr(
              frmSettings.datTransactionsAddDate.Date) + sLineBreak + Error_28 +
              sLineBreak + sLineBreak + VST.Header.Columns[1].CaptionText +
              ': ' + VST.Text[N, 1] + sLineBreak + VST.Header.Columns[2].CaptionText +
              ': ' + VST.Text[N, 2] + sLineBreak + VST.Header.Columns[3].CaptionText +
              ': ' + VST.Text[N, 3] + ' ' + VST.Text[N, 4] + sLineBreak +
              VST.Header.Columns[5].CaptionText + ': ' + VST.Text[N, 5] +
              sLineBreak + VST.Header.Columns[6].CaptionText + ': ' +
              VST.Text[N, 6] + sLineBreak + VST.Header.Columns[7].CaptionText +
              ': ' + VST.Text[N, 7] + sLineBreak + VST.Header.Columns[8].CaptionText +
              ': ' + VST.Text[N, 8] + sLineBreak + VST.Header.Columns[9].CaptionText +
              ': ' + VST.Text[N, 9]);
            Screen.Cursor := crDefault;
            Exit;
          end;
        end;

        // check days restrictions
        if frmSettings.rbtTransactionsAddDays.Checked = True then
        begin
          Write := VST.GetNodeData(N);
          if (Write.Date < FormatDateTime('YYYY-MM-DD',
            Round(Now - frmSettings.spiTransactionsAddDays.Value))) then
          begin
            ShowMessage(Error_29 + ' ' + DateToStr(
              Round(Now - frmSettings.spiTransactionsAddDays.Value)) + sLineBreak +
              Error_28 + sLineBreak + sLineBreak + VST.Header.Columns[1].CaptionText +
              ': ' + VST.Text[N, 1] + sLineBreak + VST.Header.Columns[2].CaptionText +
              ': ' + VST.Text[N, 2] + sLineBreak + VST.Header.Columns[3].CaptionText +
              ': ' + VST.Text[N, 3] + ' ' + VST.Text[N, 4] + sLineBreak +
              VST.Header.Columns[5].CaptionText + ': ' + VST.Text[N, 5] +
              sLineBreak + VST.Header.Columns[6].CaptionText + ': ' +
              VST.Text[N, 6] + sLineBreak + VST.Header.Columns[7].CaptionText +
              ': ' + VST.Text[N, 7] + sLineBreak + VST.Header.Columns[8].CaptionText +
              ': ' + VST.Text[N, 8] + sLineBreak + VST.Header.Columns[9].CaptionText +
              ': ' + VST.Text[N, 9]);
            Screen.Cursor := crDefault;
            Exit;
          end;
        end;

        Screen.Cursor := crHourGlass;

        // =========================================================================================
        // create new transaction
        // =========================================================================================
        frmMain.QRY.SQL.Text :=
          'INSERT INTO data (d_date, d_type, d_sum, d_comment, d_comment_lower, ' +
          'd_account, d_category, d_person, d_payee, d_order) VALUES (' +
          '(SELECT pay_date_plan FROM payments WHERE pay_id = :ID), ' + // date
          '(SELECT pay_type FROM payments WHERE pay_id = :ID), ' + // type
          '(SELECT pay_sum FROM payments WHERE pay_id = :ID), ' + // sum
          ':COMMENT, :COMMENT_LOWER, ' + // comment + comment lower case
          '(SELECT pay_account FROM payments WHERE pay_id = :ID), ' + // account
          '(SELECT pay_category FROM payments WHERE pay_id = :ID), ' + // category
          '(SELECT pay_person FROM payments WHERE pay_id = :ID), ' + // person
          '(SELECT pay_payee FROM payments WHERE pay_id = :ID), ' + // payee
          'NULL);'; // order

        frmMain.QRY.Params.ParamByName('ID').AsString := VST.Text[N, 10];
        frmMain.QRY.Params.ParamByName('COMMENT').AsString := VST.Text[N, 2];
        frmMain.QRY.Params.ParamByName('COMMENT_LOWER').AsString :=
          AnsiLowerCase(VST.Text[N, 2]);
        frmMain.QRY.Prepare;
        frmMain.QRY.ExecSQL;
        frmMain.Tran.Commit;

        IDs := frmMain.Conn.GetInsertID.ToString;
        frmMain.QRY.SQL.Text :=
          'SELECT d_date FROM data WHERE d_id = ' + IDs;
        frmMain.QRY.Open;
        while not frmMain.QRY.EOF do
        begin
          Str := frmMain.QRY.FieldByName('d_date').AsString;
          frmMain.QRY.Next;
        end;
        frmMain.QRY.Close;

        // =========================================================================================
        // update date of writed payment
        // =========================================================================================
        frmMain.QRY.SQL.Text :=
          'UPDATE payments SET pay_date_paid = "' + Str +
          '" WHERE pay_id = ' + VST.Text[N, 10] + ';';
        frmMain.QRY.ExecSQL;
        frmMain.Tran.Commit;

        // =========================================================================================
        // read old tags
        // =========================================================================================
        frmMain.QRY.SQL.Text :=
          'SELECT pt_tag FROM payments_tags ' + // select
          'WHERE pt_payment = ' + VST.Text[N, 10];
        frmMain.QRY.Open;
        frmMain.QRY.Last;
        if frmMain.QRY.RecordCount > 0 then
        begin
          T := TStringList.Create;
          frmMain.QRY.First;
          while not frmMain.QRY.EOF do
          begin
            T.Add(frmMain.QRY.FieldByName('pt_tag').AsString);
            frmMain.QRY.Next;
          end;
          frmMain.QRY.Close;

          // =========================================================================================
          // create new tags
          // =========================================================================================

          frmMain.Tran.Commit;
          frmMain.Tran.StartTransaction;
          for I := 0 to T.Count - 1 do
          begin
            frmMain.QRY.SQL.Text :=
              'INSERT INTO data_tags (dt_data, dt_tag) VALUES (' +
              IDs + ',' + T.Strings[I] + ');';
            frmMain.QRY.ExecSQL;
          end;
          frmMain.Tran.Commit;
          T.Free;
        end
        else
          frmMain.QRY.Close;
        N.CheckState := csUncheckedNormal;

        VST.RepaintNode(N);
        N := VST.GetFirstChecked();
      end;

    except
      on E: Exception do
      begin
        screen.Cursor := crDefault;
        ShowErrorMessage(E);
      end;
    end;
  end

  // ---------------------
  // separately writing
  // ---------------------
  else
  begin
    frmEdit.Caption := AnsiReplaceStr(AnsiUpperCase(Menu_42), '&', '');
    frmEdit.Tag := 8;
    N := VST.GetFirstChecked();
    try
      while Assigned(N) do
      begin
        VST.Selected[N] := True;
        frmEdit.ShowModal;
        N.CheckState := csUncheckedNormal;
        VST.RepaintNode(N);
        N := VST.GetFirstChecked();
      end;
    finally
      frmEdit.Caption := Caption_86;
    end;
  end;

  UpdateTransactions;
  UpdatePayments;
  frmWrite.Close;
  screen.Cursor := crDefault;
end;

procedure UpdatePayments;
var
  D1, D2: double;
  Write: PWrite;
  P: PVirtualNode;
begin
  try
    frmWrite.btnSave.Enabled := False;

    frmWrite.VST.Clear;
    frmWrite.VST.rootnodecount := 0;

    if frmMain.Conn.Connected = True then
    begin
      D1 := 0.0;
      screen.Cursor := crHourGlass;
      frmWrite.VST.BeginUpdate;

      // =====================================================================
      frmMain.QRY.SQL.Text :=
        'SELECT ' + sLineBreak + // select
        'pay_date_plan,' + sLineBreak + // date 2
        'pay_comment,' + sLineBreak + // comment 3
        'Round(pay_sum, 2) as pay_sum, ' + sLineBreak + // rounded amount 4
        'acc_currency,' + sLineBreak + // currency 5
        'acc_name,' + sLineBreak + // account name 6
        'cat_parent_name,' + sLineBreak + // category name 7
        'cat_name,' + sLineBreak + // subcategory name 8
        'per_name,' + sLineBreak + // person 9
        'pee_name, ' + sLineBreak + // payee 10
        'pay_id,' + sLineBreak + // ID 11
        'pay_type, ' + sLineBreak +// type (credit, debit, transfer +, transfer -) 12
        'cat_parent_ID ' + // category parent ID 13
        'FROM payments ' + sLineBreak +// FROM tables
        'LEFT JOIN ' + sLineBreak +// JOIN
        'accounts ON (acc_id = pay_account), ' + sLineBreak +// accounts
        'categories ON (cat_id = pay_category), ' + sLineBreak +// categories
        'persons ON (per_id = pay_person), ' + sLineBreak +// persons
        'payees ON (pee_id = pay_payee) ' +  // payees
        'WHERE pay_date_plan <= "' + FormatDateTime('YYYY-MM-DD',
        Now() + (7 * frmSettings.spiPayments.Value)) + '" ' +
        sLineBreak + // Where clausule
        'AND pay_date_paid ISNULL ' + // not written payment
        'ORDER BY pay_date_plan ASC;';

      //ShowMessage (frmMain.QRY.SQL.Text);
      frmMain.QRY.Open;

      while not frmMain.QRY.EOF do
      begin
        TryStrToFloat(frmMain.QRY.FieldByName('pay_sum').AsString, D2);
        D1 := D1 + D2;

        {ShowMessage(
          frmMain.QRY.Fields[0].AsString + sLineBreak + frmMain.QRY.Fields[1].AsString + sLineBreak +
          frmMain.QRY.Fields[2].AsString + sLineBreak + frmMain.QRY.Fields[3].AsString + sLineBreak +
          frmMain.QRY.Fields[4].AsString + sLineBreak + frmMain.QRY.Fields[5].AsString + sLineBreak +
          frmMain.QRY.Fields[6].AsString + sLineBreak + frmMain.QRY.Fields[7].AsString + sLineBreak +
          frmMain.QRY.Fields[8].AsString + sLineBreak + frmMain.QRY.Fields[9].AsString + sLineBreak +
          frmMain.QRY.Fields[10].AsString + sLineBreak + frmMain.QRY.Fields[11].AsString);
         }
        frmWrite.VST.RootNodeCount := frmWrite.VST.RootNodeCount + 1;
        P := frmWrite.VST.GetLast();
        Write := frmWrite.VST.GetNodeData(P);
        Write.Date := frmMain.QRY.Fields[0].AsString;
        Write.Comment := frmMain.QRY.Fields[1].AsString;
        TryStrToFloat(frmMain.QRY.Fields[2].AsString, Write.Amount);
        Write.currency := frmMain.QRY.Fields[3].AsString;
        Write.Account := frmMain.QRY.Fields[4].AsString;
        Write.Category := AnsiUpperCase(frmMain.QRY.Fields[5].AsString);
        Write.SubCategory := frmMain.QRY.Fields[6].AsString;
        Write.Person := frmMain.QRY.Fields[7].AsString;
        Write.Payee := frmMain.QRY.Fields[8].AsString;
        Write.ID := frmMain.QRY.Fields[9].AsInteger;
        Write.Kind := frmMain.QRY.Fields[10].AsInteger;
        if StrToDate(Write.Date, 'YYYY-MM-DD', '-') <= Now() then
          frmWrite.VST.CheckState[P] := csCheckedNormal;

        frmMain.QRY.Next;
      end;

      frmMain.QRY.Close;
      // =====================================================================
      screen.Cursor := crDefault;

      frmWrite.VST.EndUpdate;
    end;

  finally
    // items icon
    frmWrite.lblItems.Caption := IntToStr(frmWrite.VST.RootNodeCount);

    // pnlSum2
    frmWrite.lblSum1.Caption := Format('%n', [D1], FS_own);
    frmWrite.lblSum2.Caption := Format('%n', [D1], FS_own);

    screen.Cursor := crDefault;
    if frmWrite.Visible = True then frmWrite.VST.SetFocus;
  end;
end;

end.
