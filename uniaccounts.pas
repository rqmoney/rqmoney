unit uniAccounts;

{$mode objfpc}{$H+}
{$ModeSwitch AutoDeref}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ComCtrls, ExtCtrls, Buttons, Menus, StrUtils, Math, LCLProc, LazUTF8,
  laz.VirtualTrees, DateTimePicker, Clipbrd, ActnList, Spin, BCPanel,
  BCMDButtonFocus, Variants, DateUtils;

type // bottom grid (Account)
  TAccount = record
    Name: string;
    NameLower: string;
    currency: string;
    Amount: double;
    Date: string;
    Comment: string;
    Status: integer;
    Time: string;
    ID: integer;
  end;
  PAccount = ^TAccount;

type

  { TfrmAccounts }

  TfrmAccounts = class(TForm)
    actAdd: TAction;
    actCopy: TAction;
    actDelete: TAction;
    actEdit: TAction;
    actExit: TAction;
    ActionList1: TActionList;
    actPrint: TAction;
    actSave: TAction;
    actSelect: TAction;
    btnAdd: TBCMDButtonFocus;
    btnCancel: TBCMDButtonFocus;
    btnCopy: TBCMDButtonFocus;
    btnCurrency: TSpeedButton;
    btnDelete: TBCMDButtonFocus;
    btnEdit: TBCMDButtonFocus;
    btnExit: TBCMDButtonFocus;
    btnPrint: TBCMDButtonFocus;
    btnSave: TBCMDButtonFocus;
    btnSelect: TBCMDButtonFocus;
    btnStatusInfo: TImage;
    cbxCurrency: TComboBox;
    cbxStatus: TComboBox;
    datDate: TDateTimePicker;
    lblDate1: TLabel;
    pnlBack: TPanel;
    pnlDateFrom: TPanel;
    spiAmount: TFloatSpinEdit;
    ediName: TEdit;
    imgHeight: TImage;
    imgItem: TImage;
    imgItems: TImage;
    imgWidth: TImage;
    lblDate: TLabel;
    lblCurrency: TLabel;
    lblAmount: TLabel;
    lblHeight: TLabel;
    lblItem: TLabel;
    lblItems: TLabel;
    lblStatus: TLabel;
    lblName: TLabel;
    lblComment: TLabel;
    lblWidth: TLabel;
    memComment: TMemo;
    pnlButton: TPanel;
    popSelect: TMenuItem;
    MenuItem3: TMenuItem;
    pnlButtons: TPanel;
    pnlDetailCaption: TBCPanel;
    pnlListCaption: TBCPanel;
    pnlStatusTop: TPanel;
    pnlHeight: TPanel;
    pnlItem: TPanel;
    pnlItems: TPanel;
    pnlStatus: TPanel;
    pnlName: TPanel;
    pnlComment: TPanel;
    pnlDate: TPanel;
    pnlList: TPanel;
    pnlDetail: TPanel;
    pnlCurrency: TPanel;
    pnlAmount: TPanel;
    pnlBottom: TPanel;
    pnlTip: TPanel;
    pnlWidth: TPanel;
    popAdd: TMenuItem;
    popCopy: TMenuItem;
    popDelete: TMenuItem;
    popEdit: TMenuItem;
    popExit: TMenuItem;
    popList: TPopupMenu;
    popPrint: TMenuItem;
    splList: TSplitter;
    VST: TLazVirtualStringTree;
    procedure btnAddClick(Sender: TObject);
    procedure btnCopyClick(Sender: TObject);
    procedure btnCurrencyClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure btnPrintMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure btnSelectClick(Sender: TObject);
    procedure cbxCurrencyExit(Sender: TObject);
    procedure cbxCurrencyKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure cbxStatusKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure datDateChange(Sender: TObject);
    procedure datDateEnter(Sender: TObject);
    procedure datDateKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure lblDate1Click(Sender: TObject);
    procedure spiAmountKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure ediNameChange(Sender: TObject);
    procedure ediNameEnter(Sender: TObject);
    procedure ediNameExit(Sender: TObject);
    procedure ediNameKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure memCommentKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure pnlButtonResize(Sender: TObject);
    procedure pnlButtonsResize(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure splListCanResize(Sender: TObject);
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
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmAccounts: TfrmAccounts;

procedure UpdateAccounts;

implementation

{$R *.lfm}

uses
  uniMain, uniCurrencies, uniSettings, uniScheduler, uniEdit,
  uniProperties, uniMultiple, uniDetail, uniResources, uniTemplates,
  uniDelete, uniEdits;

  { TfrmAccounts }


procedure TfrmAccounts.FormCreate(Sender: TObject);
begin
  try
    // form size
    (Sender as TForm).Width := Round((Screen.Width /
      IfThen(ScreenIndex = 0, 1, (ScreenRatio / 100))) -
      (Round(620 / (ScreenRatio / 100)) - ScreenRatio));
    (Sender as TForm).Height := Round(Screen.Height /
      IfThen(ScreenIndex = 0, 1, (ScreenRatio / 100))) - 4 * (250 - ScreenRatio);

    // form position
    (Sender as TForm).Left := (Screen.Width - (Sender as TForm).Width) div 2;
    (Sender as TForm).Top := (Screen.Height - 200 - (Sender as TForm).Height) div 2;

    {$IFDEF WINDOWS}
    // set components height
    VST.Header.Height := PanelHeight;
    pnlDetailCaption.Height := PanelHeight;
    pnlListCaption.Height := PanelHeight;
    pnlBottom.Height := ButtonHeight;
    pnlButtons.Height := ButtonHeight;
    pnlButton.Height := ButtonHeight;
    {$ENDIF}

    datdate.Date := Now;
    lblDate1.Caption := DefaultFormatSettings.LongDayNames[DayOfTheWeek(
      datDate.Date + 1)];
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmAccounts.btnCancelClick(Sender: TObject);
begin
  try
    // panel Detail
    pnlDetail.Enabled := False;
    pnlDetail.Color := clDefault;
    pnlDetailCaption.Caption := AnsiUpperCase(Caption_43);

    // enabled menu
    pnlButtons.Visible := True;
    pnlButton.Visible := False;

    // disabled buttons
    ediName.Clear;
    cbxCurrency.ItemIndex := -1;
    spiAmount.Value := 0.0;
    memComment.Clear;
    cbxStatus.ItemIndex := -1;

    // enabled ListView
    VST.Enabled := True;
    VST.SetFocus;

    // enabled ActionList
    actAdd.Enabled := True;
    actEdit.Enabled := True;
    actDelete.Enabled := True;

    if VST.SelectedCount = 1 then
      VSTChange(VST, VST.GetFirstSelected());

  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmAccounts.btnCurrencyClick(Sender: TObject);
begin
  frmCurrencies.ShowModal;
end;

procedure TfrmAccounts.btnAddClick(Sender: TObject);
begin
  if (VST.Enabled = False) or (frmMain.Conn.Connected = False) then
    Exit;

  try
    // panel Detail
    pnlDetail.Enabled := True;
    pnlDetail.Color := BrightenColor;
    pnlDetailCaption.Caption := AnsiUpperCase(Caption_45);

    // disabled ListView
    VST.Enabled := False;

    // disabled menu
    pnlButtons.Visible := False;
    pnlButton.Visible := True;

    // enabled buttons
    btnSave.Enabled := False;
    btnSave.Tag := 0;

    // update fields
    ediName.Clear;
    if (cbxCurrency.ItemIndex = -1) and (cbxCurrency.Items.Count > 0) then
      cbxCurrency.ItemIndex := 0;

    spiAmount.Value := 0.0;
    datDate.Date := Now();
    cbxStatus.ItemIndex := 0;
    memComment.Clear;
    lblItem.Caption := '';

    ediName.SetFocus;

    // disabled ActionList
    actAdd.Enabled := False;
    actEdit.Enabled := False;
    actDelete.Enabled := False;

  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmAccounts.btnEditClick(Sender: TObject);
begin

  if (VST.Enabled = False) or (VST.SelectedCount <> 1) or
    (frmMain.Conn.Connected = False) then
    Exit;

  try
    // panel Detail
    pnlDetail.Enabled := True;
    pnlDetail.Color := BrightenColor;
    pnlDetailCaption.Caption := AnsiUpperCase(Caption_46);

    // disabled ListView
    VST.Enabled := False;

    // enabled buttons
    pnlButtons.Visible := False;
    pnlButton.Visible := True;

    btnSave.Enabled := True;
    btnSave.Tag := 1;

    // update fields
    ediName.SetFocus;
    ediName.SelectAll;

    // disabled ActionList
    actAdd.Enabled := False;
    actEdit.Enabled := False;
    actDelete.Enabled := False;

  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmAccounts.btnDeleteClick(Sender: TObject);
var
  I: integer;
  IDs: string;
  N: PVirtualNode;
begin
  try
    if (frmMain.Conn.Connected = False) or (VST.SelectedCount = 0) or
      (frmMain.Conn.Connected = False) then
      exit;

    // get IDs of all selected nodes
    IDs := '';
    N := VST.GetFirstSelected(False);
    try
      while Assigned(N) do
      begin
        IDs := IDs + VST.Text[N, 7] + ',';
        N := VST.GetNextSelected(N);
      end;
    finally
      IDs := LeftStr(IDs, Length(IDs) - 1);
    end;

    frmMain.QRY.SQL.Text := 'SELECT COUNT(*) FROM data WHERE d_account IN (' + IDs + ')';
    frmMain.QRY.Open;
    I := frmMain.QRY.Fields[0].AsInteger;
    frmMain.QRY.Close;

    // if the count of the transactions is > 0, then show all transaction to delete
    if I = 0 then
      // confirm deleting
      case VST.SelectedCount of
        1: if MessageDlg(Message_00, Question_01 + sLineBreak +
            sLineBreak + VST.Header.Columns[1].Text + ': ' +
            VST.Text[VST.FocusedNode, 1] + ' [' + VST.Text[VST.FocusedNode, 2] +
            ']', mtConfirmation, mbYesNo, 0) <> 6 then
            Exit;
        else
          if MessageDlg(Message_00, AnsiReplaceStr(Question_02, '%',
            IntToStr(VST.SelectedCount)), mtConfirmation, mbYesNo, 0) <> 6 then
            Exit;
      end
    else if I > 0 then
    begin
      frmDelete.Hint := 'd_account IN (' + IDs + ')' + separ +
        'sch_account1 IN (' + IDs + ') OR sch_account2 IN (' + IDs + ')' + separ;
      frmDelete.pnlCaption2.Caption := Question_05;
      if frmDelete.ShowModal <> mrOk then
        Exit;
    end;

    frmMain.QRY.SQL.Text := 'DELETE FROM accounts WHERE acc_id IN (' + IDs + ')';
    frmMain.QRY.ExecSQL;
    frmMain.Tran.Commit;

    UpdateAccounts;

  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmAccounts.btnExitClick(Sender: TObject);
begin
  frmAccounts.Close;
end;

procedure TfrmAccounts.btnPrintClick(Sender: TObject);
var
  FileName: string;
begin
  if btnPrint.Enabled = False then
    Exit;

  FileName := ExtractFileDir(Application.ExeName) + DirectorySeparator +
    'Templates' + DirectorySeparator + 'accounts.lrf';

  if FileExists(FileName) = False then
  begin
    ShowMessage(Error_14 + sLineBreak + FileName);
    Exit;
  end;

  // left mouse button = show report
  try
    frmMain.Report.Tag := 12;

    frmMain.Report.LoadFromFile(FileName);
    frmMain.Report.FindObject('lblName').Memo.Text :=
      AnsiUpperCase(lblName.Caption + ' (' + lblCurrency.Caption + ')');
    frmMain.Report.FindObject('lblAmount').Memo.Text := AnsiUpperCase(lblAmount.Caption);
    frmMain.Report.FindObject('lblDate').Memo.Text := AnsiUpperCase(lblDate.Caption);
    frmMain.Report.FindObject('lblStatus').Memo.Text := AnsiUpperCase(lblStatus.Caption);
    frmMain.Report.FindObject('lblComment').Memo.Text :=
      AnsiUpperCase(lblComment.Caption);
    frmMain.Report.FindObject('lblID').Memo.Text :=
      AnsiUpperCase(VST.Header.Columns[7].Text);
    frmMain.Report.FindObject('lblFooter').Memo.Text :=
      AnsiUpperCase(Application.Title + ' - ' + frmAccounts.Caption);

    frmMain.Report.ShowReport;
    VST.SetFocus;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;

end;

procedure TfrmAccounts.btnPrintMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
var
  FileName: string;
begin
  FileName := ExtractFileDir(Application.ExeName) + DirectorySeparator +
    'Templates' + DirectorySeparator + 'accounts.lrf';

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

procedure TfrmAccounts.btnSelectClick(Sender: TObject);
begin
  if (VST.Enabled = False) or (VST.RootNodeCount < 1) or
    (frmMain.Conn.Connected = False) then
    Exit;

  VST.SelectAll(False);
  VST.SetFocus;
end;

procedure TfrmAccounts.cbxCurrencyExit(Sender: TObject);
begin
  if (cbxCurrency.Items.Count = 0) then
  begin
    frmCurrencies.ShowModal;
    if (cbxCurrency.Items.Count > 0) then
      cbxCurrency.ItemIndex := 0;
  end;
  ComboBoxExit(cbxCurrency);
end;

procedure TfrmAccounts.btnCopyClick(Sender: TObject);
begin
  if (VST.Enabled = False) or (frmMain.Conn.Connected = False) then
    Exit;
  CopyVST(VST);
end;

procedure TfrmAccounts.cbxCurrencyKeyUp(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  try
    if (Key = 13) then
    begin
      Key := 0;
      spiAmount.SetFocus;
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmAccounts.cbxStatusKeyUp(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  try
    if Key = 13 then
    begin
      Key := 0;
      if btnSave.Enabled = True then
        btnSave.SetFocus
      else
        ediName.SetFocus;
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmAccounts.datDateChange(Sender: TObject);
begin
  lblDate1.Caption := DefaultFormatSettings.LongDayNames[DayOfTheWeek(datDate.Date + 1)];
end;

procedure TfrmAccounts.datDateEnter(Sender: TObject);
begin

end;

procedure TfrmAccounts.datDateKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  try
    if Key = 13 then
    begin
      Key := 0;
      memComment.SetFocus;
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmAccounts.lblDate1Click(Sender: TObject);
begin
  datDate.SetFocus;
end;

procedure TfrmAccounts.spiAmountKeyUp(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  (Sender as TFloatSpinEdit).Hint := (Sender as TFloatSpinEdit).Text;
  try
    if (Key = 13) then
    begin
      Key := 0;
      datDate.SetFocus;
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmAccounts.splListCanResize(Sender: TObject);
begin
  try
    imgWidth.ImageIndex := 3;
    lblWidth.Caption := IntToStr(frmAccounts.Width - pnlDetail.Width);

    imgHeight.ImageIndex := 2;
    lblHeight.Caption := IntToStr(pnlDetail.Width);

    pnlListCaption.Repaint;
    pnlDetailCaption.Repaint;
    pnlButton.Repaint;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmAccounts.VSTBeforeCellPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
begin
  TargetCanvas.Brush.Color := IfThen(Node.Index mod 2 = 0, clWhite,
    frmSettings.pnlOddRowColor.Color);
  TargetCanvas.FillRect(CellRect);
end;

procedure TfrmAccounts.VSTChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  I: byte;
  Account: PAccount;
begin
  try
    // set images
    if VST.SelectedCount = 0 then
    begin
      imgItem.ImageIndex := -1;
      lblItem.Caption := '';
    end
    else
    begin
      if VST.SelectedCount = VST.RootNodeCount then
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
    popEdit.Enabled := VST.SelectedCount = 1;
    popDelete.Enabled := VST.SelectedCount > 0;
    btnEdit.Enabled := VST.SelectedCount = 1;
    btnDelete.Enabled := VST.SelectedCount > 0;

    Account := Sender.GetNodeData(Node);

    if (VST.RootNodeCount = 0) or (VST.SelectedCount <> 1) then
    begin
      ediName.Clear;
      cbxCurrency.ItemIndex := -1;
      spiAmount.Value := 0.0;
      memComment.Clear;
      cbxStatus.ItemIndex := -1;
      Exit;
    end;

    if (VST.SelectedCount = 1) then
    begin
      ediName.Text := VST.Text[VST.GetFirstSelected(False), 1];

      for I := 0 to cbxCurrency.Items.Count - 1 do
        if LeftStr(cbxCurrency.Items[I], 3) =
          VST.Text[VST.GetFirstSelected(False), 2] then
          cbxCurrency.ItemIndex := I;

      spiAmount.Value := Account.Amount;
      datDate.Date := StrToDate(VST.Text[VST.GetFirstSelected(False), 4]);
      memComment.Text := Account.Comment;
      cbxStatus.ItemIndex := Account.Status;
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmAccounts.VSTCompareNodes(Sender: TBaseVirtualTree;
  Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: integer);
var
  Data1, Data2: PAccount;
begin
  Data1 := Sender.GetNodeData(Node1);
  Data2 := Sender.GetNodeData(Node2);
  case Column of
    1: begin
      Result := UTF8CompareText(Data1.Name, Data2.Name);
      if Result = 0 then
        Result := UTF8CompareText(Data1.currency, Data2.currency);
    end;
    2: Result := UTF8CompareText(Data1.currency, Data2.currency);
    3: Result := CompareValue(Data1.Amount, Data2.Amount);
    4: Result := CompareStr(Data1.Date, Data2.Date);
    5: Result := UTF8CompareText(Data1.Comment, Data2.Comment);
    6: Result := CompareValue(Data1.Status, Data2.Status);
    7: Result := CompareValue(Data1.ID, Data2.ID);
  end;
end;

procedure TfrmAccounts.VSTDblClick(Sender: TObject);
begin
  if frmMain.Conn.Connected = False then Exit;

  if VST.SelectedCount = 1 then
    btnEditClick(btnEdit)
  else if VST.SelectedCount = 0 then
    btnAddClick(btnAdd);
end;

procedure TfrmAccounts.VSTGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: boolean; var ImageIndex: integer);
begin
  if Column = 0 then
    ImageIndex := 15;
end;

procedure TfrmAccounts.VSTGetNodeDataSize(Sender: TBaseVirtualTree;
  var NodeDataSize: integer);
begin
  NodeDataSize := SizeOf(TAccount);
end;

procedure TfrmAccounts.VSTGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
var
  Account: PAccount;
begin
  Account := Sender.GetNodeData(Node);
  try
    case Column of
      1: CellText := Account.Name;
      2: CellText := Account.currency;
      3: CellText := Format('%n', [Account.Amount], FS_own);
      4: CellText := DateToStr(StrToDate(Account.Date, 'YYYY-MM-DD', '-'));
      5: CellText := Account.Comment;
      6: CellText := cbxStatus.Items[Account.Status];
      7: CellText := IntToStr(Account.ID);
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmAccounts.VSTPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
var
  Account: PAccount;
begin
  if vsSelected in node.States then exit;

  Account := Sender.GetNodeData(Node);
  case Account.Status of
    0: TargetCanvas.Font.Color := clDefault;
    1: TargetCanvas.Font.Color := clBlue;
    2: TargetCanvas.Font.Color := clRed;
  end;
end;

procedure TfrmAccounts.VSTResize(Sender: TObject);
var
  X: integer;
begin
  if frmSettings.chkAutoColumnWidth.Checked = False then Exit;

  (Sender as TLazVirtualStringTree).Header.Columns[0].Width :=
    round(ScreenRatio / 100 * 25);
  X := (VST.Width - VST.Header.Columns[0].Width) div 100;

  VST.Header.Columns[1].Width := 27 * X; // name
  VST.Header.Columns[2].Width := 8 * X; // currency
  VST.Header.Columns[3].Width := 14 * X; // starting balance
  VST.Header.Columns[4].Width := 13 * X; // date
  VST.Header.Columns[5].Width :=
    VST.Width - VST.Header.Columns[0].Width - ScrollBarWidth - (81 * x); // comment
  VST.Header.Columns[6].Width := 12 * X; // status
  VST.Header.Columns[7].Width := 7 * X; // ID
end;

procedure TfrmAccounts.ediNameChange(Sender: TObject);
begin
  btnSave.Enabled := Length(ediName.Text) > 0;
end;

procedure TfrmAccounts.ediNameEnter(Sender: TObject);
begin
  try
    if Sender.ClassType = TEdit then
      (Sender as TEdit).Font.Bold := True
    else if Sender.ClassType = TFloatSpinEdit then
    begin
      (Sender as TFloatSpinEdit).Font.Bold := True;
      (Sender as TFloatSpinEdit).Hint := '';
    end
    else if Sender.ClassType = TMemo then
      (Sender as TMemo).Font.Bold := True
    else if Sender.ClassType = TDateTimePicker then
      (Sender as TDateTimePicker).Font.Bold := True
    else if Sender.ClassType = TComboBox then
      (Sender as TComboBox).Font.Bold := True;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmAccounts.ediNameExit(Sender: TObject);
begin
  try
    if Sender.ClassType = TEdit then
      (Sender as TEdit).Font.Bold := False
    else if Sender.ClassType = TFloatSpinEdit then
    begin
      (Sender as TFloatSpinEdit).Font.Bold := False;
      if (Pos('+', (Sender as TFloatSpinEdit).Hint) > 0) or
        (Pos('-', (Sender as TFloatSpinEdit).Hint) > 0) then
        (Sender as TFloatSpinEdit).Value := CalculateText(Sender);
    end
    else if Sender.ClassType = TMemo then
      (Sender as TMemo).Font.Bold := False
    else if Sender.ClassType = TDateTimePicker then
      (Sender as TDateTimePicker).Font.Bold := False
    else if Sender.ClassType = TComboBox then
      (Sender as TComboBox).Font.Bold := False;

  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmAccounts.ediNameKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  try
    if (Key = 13) then
    begin
      Key := 0;
      cbxCurrency.SetFocus;
      if cbxCurrency.Items.Count > 0 then
        cbxCurrency.DroppedDown := True;
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmAccounts.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  try
    if pnlButton.Visible = True then
    begin
      btnCancelClick(btnCancel);
      CloseAction := Forms.caNone;
      Exit;
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmAccounts.FormResize(Sender: TObject);
begin
  try
    imgWidth.ImageIndex := 0;
    lblWidth.Caption := IntToStr(frmAccounts.Width);
    imgHeight.ImageIndex := 1;
    lblHeight.Caption := IntToStr(frmAccounts.Height);

    pnlListCaption.Repaint;
    pnlDetailCaption.Repaint;
    pnlButtons.Repaint;
    pnlButton.Repaint;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmAccounts.FormShow(Sender: TObject);
begin
  try
    // btnAdd
    btnAdd.Enabled := frmMain.Conn.Connected = True;
    popAdd.Enabled := frmMain.Conn.Connected = True;
    actAdd.Enabled := frmMain.Conn.Connected = True;

    // btnEdit
    btnEdit.Enabled := VST.SelectedCount = 1;
    popEdit.Enabled := VST.SelectedCount = 1;
    actEdit.Enabled := VST.SelectedCount = 1;

    // btnDelete
    btnDelete.Enabled := VST.SelectedCount > 0;
    popDelete.Enabled := VST.SelectedCount > 0;
    actDelete.Enabled := VST.SelectedCount > 0;

    // btnCopy
    btnCopy.Enabled := VST.RootNodeCount > 0;
    popCopy.Enabled := VST.RootNodeCount > 0;
    actCopy.Enabled := VST.RootNodeCount > 0;

    // btnSelect
    btnSelect.Enabled := VST.RootNodeCount > 0;
    popSelect.Enabled := VST.RootNodeCount > 0;
    actSelect.Enabled := VST.RootNodeCount > 0;

    // btnPrint
    btnPrint.Enabled := VST.RootNodeCount > 0;
    popPrint.Enabled := VST.RootNodeCount > 0;
    actPrint.Enabled := VST.RootNodeCount > 0;

    VST.SetFocus;
    VST.ClearSelection;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmAccounts.memCommentKeyUp(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  try
    if (Key = 13) then
    begin
      Key := 0;
      if Pos(separ, memComment.Text) > 0 then
        Exit;
      cbxStatus.SetFocus;
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmAccounts.pnlButtonResize(Sender: TObject);
begin
  btnCancel.Width := (pnlButton.Width - 6) div 2;
end;

procedure TfrmAccounts.pnlButtonsResize(Sender: TObject);
begin
  btnEdit.Width := (pnlButtons.Width - 14) div 7;
  btnDelete.Width := btnEdit.Width;
  btnCopy.Width := btnEdit.Width;
  btnPrint.Width := btnEdit.Width;
  btnExit.Width := btnEdit.Width;
  btnSelect.Width := btnEdit.Width;
end;

procedure TfrmAccounts.btnSaveClick(Sender: TObject);
var
  I: integer;
begin
  if (btnSave.Enabled = False) then
    Exit;

  try
    // check forbidden chars in the text
    if CheckForbiddenChar(ediName) = True then
      Exit;

    // check forbidden chars in the text
    if CheckForbiddenChar(memComment) = True then
      Exit;

    // check for forbidden character - separ
    I := UTF8Pos(separ, memComment.Text);
    if I > 0 then
    begin
      ShowMessage(ReplaceStr(Error_06, '%', separ));
      memComment.SetFocus;
      memComment.SelStart := I - 1;
      memComment.SelLength := 1;
      Exit;
    end;

    // get currency ID
    if cbxCurrency.ItemIndex = -1 then
    begin
      ShowMessage(ReplaceStr(Error_04, '%', UpperCase(lblCurrency.Caption)));
      cbxCurrency.SetFocus;
      Exit;
    end;

    // Add new category
    if btnSave.Tag = 0 then
      frmMain.QRY.SQL.Text :=
        'INSERT INTO accounts (acc_name, acc_name_lower, acc_currency, acc_date, ' +
        'acc_amount, acc_status, acc_comment) ' +
        'VALUES (:NAME, :NAMELOWER, :CURRENCY, :DATE, :AMOUNT, :STATUS, :COMMENT);'
    else
    begin
      // Edit selected category
      VST.Tag := StrToInt(VST.Text[VST.GetFirstSelected(False), 7]);
      frmMain.QRY.SQL.Text :=
        'UPDATE accounts SET ' +  // update
        'acc_name = :NAME, ' +            // name
        'acc_name_lower = :NAMELOWER, ' + // name lower case
        'acc_currency = :CURRENCY, ' +    // currency
        'acc_date = :DATE, ' +            // date
        'acc_amount = :AMOUNT, ' +         // amount
        'acc_status = :STATUS, ' +         // status
        'acc_comment = :COMMENT ' +       // comment
        'WHERE acc_id = :ID;';
      frmMain.QRY.Params.ParamByName('ID').AsInteger := VST.Tag;
    end;

    frmMain.QRY.Params.ParamByName('NAME').AsString := ediName.Text;
    frmMain.QRY.Params.ParamByName('NAMELOWER').AsString := AnsiLowerCase(ediName.Text);
    frmMain.QRY.Params.ParamByName('CURRENCY').AsString :=
      Field(' | ', cbxCurrency.Items[cbxCurrency.ItemIndex], 1);
    frmMain.QRY.Params.ParamByName('DATE').AsString :=
      FormatDateTime('YYYY-MM-DD', datDate.Date);
    frmMain.QRY.Params.ParamByName('STATUS').AsInteger := cbxStatus.ItemIndex;
    frmMain.QRY.Params.ParamByName('COMMENT').AsString := Trim(memComment.Text);
    // get amount
    frmMain.QRY.Params.ParamByName('AMOUNT').AsString :=
      ReplaceStr(FloatToStr(spiAmount.Value),
      DefaultFormatSettings.DecimalSeparator, '.');
    frmMain.QRY.Prepare;
    frmMain.QRY.ExecSQL;
    frmMain.Tran.Commit;

    UpdateAccounts;
    btnCancelClick(btnCancel);

    if btnSave.Tag = 0 then
      FindNewRecord(VST, 7)
    else
      FindEditedRecord(VST, 7, VST.Tag);

    VST.SetFocus;

  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure UpdateAccounts;
var
  Account: PAccount;
  P: PVirtualNode;
begin
  try
    frmAccounts.VST.Clear;
    frmAccounts.VST.RootNodeCount := 0;

    // =============================================================================================
    // update list of accounts in form Accounts
    if frmMain.Conn.Connected = False then
      Exit;

    screen.Cursor := crHourGlass;
    frmAccounts.VST.BeginUpdate;

    frmMain.QRY.SQL.Text :=
      'SELECT acc_name, acc_name_lower, acc_currency, acc_date, acc_amount, ' +
      'acc_status, acc_comment, acc_time, acc_ID FROM accounts';
    frmMain.QRY.Open;

    try
      while not (frmMain.QRY.EOF) do
      begin
        frmAccounts.VST.RootNodeCount := frmAccounts.VST.RootNodeCount + 1;
        P := frmAccounts.VST.GetLast();
        Account := frmAccounts.VST.GetNodeData(P);
        Account.Name := frmMain.QRY.Fields[0].AsString;
        Account.NameLower := frmMain.QRY.Fields[1].AsString;
        Account.currency := frmMain.QRY.Fields[2].AsString;
        Account.Date := frmMain.QRY.Fields[3].AsString;
        TryStrToFloat(frmMain.QRY.Fields[4].AsString, Account.Amount);
        Account.Status := frmMain.QRY.Fields[5].AsInteger;
        Account.Comment := frmMain.QRY.Fields[6].AsString;
        Account.Time := frmMain.QRY.Fields[7].AsString;
        Account.ID := frmMain.QRY.Fields[8].AsInteger;
        frmMain.QRY.Next;
      end;

      frmMain.QRY.Close;

    except
      on E: Exception do
        ShowErrorMessage(E);
    end;

    SetNodeHeight(frmAccounts.VST);

    frmAccounts.VST.EndUpdate;
    frmAccounts.VST.SortTree(1, sdAscending);
    screen.Cursor := crDefault;

    // =============================================================================================
    // update list of accounts in frmMain
    frmMain.cbxCurrencyChange(frmMain.cbxCurrency);

    // =============================================================================================
    // update list of accounts in other forms
    frmDetail.cbxAccountFrom.Clear;
    frmDetail.cbxAccountTo.Clear;

    for P in frmAccounts.VST.Nodes() do
    begin
      // list of accounts in frmDETAIL [only active status !!!]
      if (frmAccounts.VST.Text[P, 6] = frmAccounts.cbxStatus.Items[0]) then
        frmDetail.cbxAccountFrom.Items.Add(frmAccounts.VST.Text[P, 1] +
          ' | ' + frmAccounts.VST.Text[P, 2]);
    end;

    if frmDetail.cbxAccountFrom.Items.Count > 0 then
      frmDetail.cbxAccountTo.Items := frmDetail.cbxAccountFrom.Items;

    // Accounts in form Multiple addition
    frmMultiple.cbxAccount.Clear;
    if frmDetail.cbxAccountFrom.Items.Count > 0 then
      frmMultiple.cbxAccount.Items := frmDetail.cbxAccountFrom.Items;

    // Accounts in Scheduler (panel Detail)
    frmScheduler.cbxAccountFrom.Clear;
    if frmDetail.cbxAccountFrom.Items.Count > 0 then
      frmScheduler.cbxAccountFrom.Items := frmDetail.cbxAccountFrom.Items;

    frmScheduler.cbxAccountTo.Clear;

    if frmDetail.cbxAccountFrom.Items.Count > 0 then
      frmScheduler.cbxAccountTo.Items := frmDetail.cbxAccountFrom.Items;

    // Accounts in form Edit
    frmEdit.cbxAccount.Clear;
    if frmDetail.cbxAccountFrom.Items.Count > 0 then
      frmEdit.cbxAccount.Items := frmDetail.cbxAccountFrom.Items;

    // Accounts in form Edits
    frmEdits.cbxAccount.Clear;
    if frmDetail.cbxAccountFrom.Items.Count > 0 then
      frmEdits.cbxAccount.Items := frmDetail.cbxAccountFrom.Items;

    // Accounts in form Templates
    frmTemplates.cbxAccount.Clear;
    if frmDetail.cbxAccountFrom.Items.Count > 0 then
      frmTemplates.cbxAccount.Items := frmDetail.cbxAccountFrom.Items;

    // pnlDetail components clear
    frmAccounts.ediName.Clear;
    frmAccounts.cbxCurrency.ItemIndex := -1;
    frmAccounts.spiAmount.Value := 0.0;
    frmAccounts.memComment.Clear;
    frmAccounts.cbxStatus.ItemIndex := -1;

    // =============================================================================================

    // items icon
    frmAccounts.lblItems.Caption := IntToStr(frmAccounts.VST.RootNodeCount);

    frmAccounts.popCopy.Enabled := frmAccounts.VST.RootNodeCount > 0;
    frmAccounts.btnCopy.Enabled := frmAccounts.popCopy.Enabled;
    frmAccounts.btnSelect.Enabled := frmAccounts.VST.RootNodeCount > 0;
    frmAccounts.popPrint.Enabled := frmAccounts.popCopy.Enabled;
    frmAccounts.btnPrint.Enabled := frmAccounts.popCopy.Enabled;
    frmAccounts.popEdit.Enabled := False;
    frmAccounts.btnEdit.Enabled := False;
    frmAccounts.popDelete.Enabled := False;
    frmAccounts.btnDelete.Enabled := False;
    if (frmAccounts.Visible = True) and (frmAccounts.VST.Enabled = True) then
      frmAccounts.VST.SetFocus;

    if frmProperties.Visible = True then frmProperties.FormShow(frmProperties);

  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

end.
