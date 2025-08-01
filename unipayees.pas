unit uniPayees;

{$mode objfpc}{$H+}
{$ModeSwitch AutoDeref}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Clipbrd, ExtCtrls, ComCtrls, Buttons, Menus, ActnList, BCPanel,
  BCMDButtonFocus, LazUTF8, laz.VirtualTrees, StrUtils, Math;

type
  TPayee = record
    Name: string;
    NameLower: string;
    Comment: string;
    Status: Integer;
    Time: String;
    ID: Integer;
  end;
  PPayee = ^TPayee;

type

  { TfrmPayees }

  TfrmPayees = class(TForm)
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
    btnDelete: TBCMDButtonFocus;
    btnEdit: TBCMDButtonFocus;
    btnExit: TBCMDButtonFocus;
    btnPrint: TBCMDButtonFocus;
    btnSave: TBCMDButtonFocus;
    btnSelect: TBCMDButtonFocus;
    btnStatusInfo: TImage;
    cbxStatus: TComboBox;
    ediName: TEdit;
    imgHeight: TImage;
    imgItems: TImage;
    imgWidth: TImage;
    imgItem: TImage;
    lblComment: TLabel;
    lblHeight: TLabel;
    lblItems: TLabel;
    lblName: TLabel;
    lblStatus: TLabel;
    lblWidth: TLabel;
    lblItem: TLabel;
    popSelect: TMenuItem;
    pnlClient: TPanel;
    VST: TLazVirtualStringTree;
    memComment: TMemo;
    MenuItem1: TMenuItem;
    pnlButton: TPanel;
    pnlButtons: TPanel;
    pnlComment: TPanel;
    pnlDetail: TPanel;
    pnlDetailCaption: TBCPanel;
    pnlListCaption: TBCPanel;
    pnlName: TPanel;
    pnlStatus: TPanel;
    pnlStatusTop: TPanel;
    popPrint: TMenuItem;
    pnlList: TPanel;
    pnlItems: TPanel;
    pnlBottom: TPanel;
    pnlHeight: TPanel;
    pnlWidth: TPanel;
    pnlItem: TPanel;
    popAdd: TMenuItem;
    popCopy: TMenuItem;
    popDelete: TMenuItem;
    popEdit: TMenuItem;
    popExit: TMenuItem;
    popList: TPopupMenu;
    splList: TSplitter;
    procedure btnAddClick(Sender: TObject);
    procedure btnCopyClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure btnPrintMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure btnSelectClick(Sender: TObject);
    procedure cbxStatusEnter(Sender: TObject);
    procedure cbxStatusExit(Sender: TObject);
    procedure cbxStatusKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure ediNameEnter(Sender: TObject);
    procedure ediNameExit(Sender: TObject);
    procedure ediNameKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure memCommentEnter(Sender: TObject);
    procedure memCommentExit(Sender: TObject);
    procedure memCommentKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure btnCancelClick(Sender: TObject);
    procedure pnlButtonResize(Sender: TObject);
    procedure pnlButtonsResize(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure ediNameChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure splListCanResize(Sender: TObject);
    procedure VSTBeforeCellPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
    procedure VSTChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure VSTCompareNodes(Sender: TBaseVirtualTree; Node1,
      Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
    procedure VSTDblClick(Sender: TObject);
    procedure VSTGetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Kind: TVTImageKind; Column: TColumnIndex; var Ghosted: boolean;
      var ImageIndex: integer);
    procedure VSTGetNodeDataSize(Sender: TBaseVirtualTree;
      var NodeDataSize: Integer);
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
  frmPayees: TfrmPayees;

procedure UpdatePayees;

implementation

{$R *.lfm}

uses
  uniMain, uniScheduler, uniSettings, uniEdit, uniProperties, uniTemplates,
  uniDetail, uniDelete, uniResources, uniEdits;

{ TfrmPayees }


procedure TfrmPayees.FormCreate(Sender: TObject);
begin
  try
    // cbxStatus
    frmPayees.cbxStatus.Clear;
    frmPayees.cbxStatus.Items.Add(Caption_55);
    frmPayees.cbxStatus.Items.Add(Caption_57);
    frmPayees.cbxStatus.Items.Add(Caption_59);

    // set component height
    VST.Header.Height := PanelHeight;
    pnlDetailCaption.Height := PanelHeight;
    pnlListCaption.Height := PanelHeight;
    pnlButtons.Height := ButtonHeight;
    pnlButton.Height := ButtonHeight;
    pnlBottom.Height := ButtonHeight;

    // get form icon
    frmMain.img16.GetIcon(13, (Sender as TForm).Icon);
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmPayees.btnAddClick(Sender: TObject);
begin
  if (VST.Enabled = False) or (frmMain.Conn.Connected = False) then
    Exit;

  try
    // panel Detail
    pnlDetail.Enabled := True;
    pnlDetail.Color := IfThen(Dark = False,
      frmSettings.btnCaptionColorFont.Tag, rgbToColor(44,44,44));
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
    //pnlStamp.Visible := False;
    cbxStatus.ItemIndex := 0;
    ediName.Clear;
    memComment.Clear;
    //txtStamp.Caption := '';
    lblItem.Caption := '';

    // disabled ActionList
    actAdd.Enabled := False;
    actEdit.Enabled := False;
    actDelete.Enabled := False;

    ediName.SetFocus;

  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmPayees.btnEditClick(Sender: TObject);
begin
  if (VST.Enabled = False) or (VST.SelectedCount <> 1) or (frmMain.Conn.Connected = False) then
    Exit;

  try
    // panel Detail
    pnlDetail.Enabled := True;
    pnlDetail.Color := IfThen(Dark = False,
      frmSettings.btnCaptionColorFont.Tag, rgbToColor(44,44,44));
    pnlDetailCaption.Caption := AnsiUpperCase(Caption_46);

    // disabled ListView
    VST.Enabled := False;

    // enabled buttons
    btnSave.Enabled := True;
    btnSave.Tag := 1;

    // disabled menu
    pnlButtons.Visible := False;
    pnlButton.Visible := True;
    //pnlStamp.Visible := False;

    // update fields
    ediName.Enabled := True;
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

procedure TfrmPayees.btnPrintClick(Sender: TObject);
var
 FileName: String;

begin
  if btnPrint.Enabled = False then Exit;

  FileName := ExtractFileDir(Application.ExeName) + DirectorySeparator + 'Templates' +
     DirectorySeparator + 'payees.lrf';

  if FileExists(FileName) = False then
  begin
   ShowMessage(Error_14 + sLineBreak + FileName);
   Exit;
  end;

  // left mouse button = show report
  try
    frmMain.Report.LoadFromFile(FileName);

    // set header captions
    frmMain.Report.FindObject('lblName').Memo.Text := AnsiUpperCase(lblName.Caption);
    frmMain.Report.FindObject('lblComment').Memo.Text := AnsiUpperCase(lblComment.Caption);
    frmMain.Report.FindObject('lblStatus').Memo.Text := AnsiUpperCase(lblStatus.Caption);
    frmMain.Report.FindObject('lblID').Memo.Text :=
      AnsiUpperCase(VST.Header.Columns[4].Text);
    frmMain.Report.FindObject('lblFooter').Memo.Text :=
      AnsiUpperCase(Application.Title + ' - ' + frmPayees.Caption);

    frmMain.Report.Tag := 14;
    frmMain.Report.ShowReport;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;

  VST.SetFocus;
end;

procedure TfrmPayees.btnPrintMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
 FileName: String;

begin
  FileName := ExtractFileDir(Application.ExeName) + DirectorySeparator + 'Templates' +
     DirectorySeparator + 'payees.lrf';

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

procedure TfrmPayees.btnCancelClick(Sender: TObject);
begin
  try
    // panel Detail
    pnlDetail.Enabled := False;
    pnlDetail.Color := clDefault;
    pnlDetailCaption.Caption := AnsiUpperCase(Caption_43);

    // disabled menu
    pnlButtons.Visible := True;
    pnlButton.Visible := False;

    // disabled buttons
    //pnlStamp.Visible := True;

    // enabled ListView
    VST.Enabled := True;
    VST.SetFocus;
    VSTChange(VST, VST.FocusedNode);

    // disabled ActionList
    actAdd.Enabled := True;
    actEdit.Enabled := True;
    actDelete.Enabled := True;

    // disabled ActionList
    actAdd.Enabled := False;
    actEdit.Enabled := False;
    actDelete.Enabled := False;

  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmPayees.pnlButtonResize(Sender: TObject);
begin
  btnCancel.Width := (pnlButton.Width - 6) div 2;
end;

procedure TfrmPayees.pnlButtonsResize(Sender: TObject);
begin
  btnEdit.Width := (pnlButtons.Width - 14) div 7;
  btnDelete.Width := btnEdit.Width;
  btnCopy.Width := btnEdit.Width;
  btnPrint.Width := btnEdit.Width;
  btnExit.Width := btnEdit.Width;
  btnSelect.Width := btnEdit.Width;
  pnlButtons.Repaint;
end;

procedure TfrmPayees.btnDeleteClick(Sender: TObject);
var
  I: integer;
  IDs: string;
  N: PVirtualNode;

begin
  try
    if (frmMain.Conn.Connected = False) or (VST.SelectedCount = 0) then
      exit;

    // get IDs of all selected nodes
    IDs := '';
    N := VST.GetFirstSelected(False);
    try
      while Assigned(N) do
      begin
        IDs := IDs + VST.Text[N, 4] + ',';
        N := VST.GetNextSelected(N);
      end;
    finally
      IDs := LeftStr(IDs, Length(IDs) - 1);
    end;

    frmMain.QRY.SQL.Text := 'SELECT COUNT(*) FROM data WHERE d_payee IN (' + IDs + ')';
    frmMain.QRY.Open;
    I := frmMain.QRY.Fields[0].AsInteger;
    frmMain.QRY.Close;

    // if the count of the transactions is > 0, then show all transaction to delete
    if I = 0 then
      // confirm deleting
      case VST.SelectedCount of
        1: if MessageDlg(Message_00, Question_01 + sLineBreak +
            sLineBreak + VST.Header.Columns[1].Text + ': ' +
            VST.Text[VST.FocusedNode, 1], mtConfirmation, mbYesNo, 0) <> 6 then
            Exit;
        else
          if MessageDlg(Message_00, AnsiReplaceStr(
            Question_02, '%', IntToStr(VST.SelectedCount)),
            mtConfirmation, mbYesNo, 0) <> 6 then
            Exit;
      end
    else if I > 0 then
    begin
      frmDelete.Hint := 'd_payee IN (' + IDs + ')' + separ +
        'sch_payee IN (' + IDs + ')' + separ;
      frmDelete.pnlCaption2.Caption := Question_08;
      if frmDelete.ShowModal <> mrOk then
        Exit;
    end;

    frmMain.QRY.SQL.Text := 'DELETE FROM payees WHERE pee_id IN (' + IDs + ')';
    frmMain.QRY.ExecSQL;
    frmMain.Tran.Commit;

    UpdatePayees;

  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmPayees.ediNameEnter(Sender: TObject);
begin
  ediName.Font.Bold := True;
end;

procedure TfrmPayees.cbxStatusKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if (Key = 13) then
  begin
    Key := 0;
    if btnSave.Enabled = True then
      btnSave.SetFocus
    else
      ediName.SetFocus;
  end;
end;

procedure TfrmPayees.btnCopyClick(Sender: TObject);
begin
  if (VST.Enabled = False) or (frmMain.Conn.Connected = False) then
    Exit;
  CopyVST(VST);
end;

procedure TfrmPayees.btnSelectClick(Sender: TObject);
begin
  if (VST.Enabled = False) or (VST.RootNodeCount < 1) or (frmMain.Conn.Connected = False) then
    Exit;
  VST.SelectAll(False);
  VST.SetFocus;
end;

procedure TfrmPayees.cbxStatusEnter(Sender: TObject);
begin
  cbxStatus.Font.Bold := True;
end;

procedure TfrmPayees.cbxStatusExit(Sender: TObject);
begin
  cbxStatus.Font.Bold := False;
end;

procedure TfrmPayees.ediNameExit(Sender: TObject);
begin
  ediName.Font.Bold := False;
end;

procedure TfrmPayees.ediNameKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if (Key = 13) then
  begin
    Key := 0;
    memComment.SetFocus;
  end;
end;

procedure TfrmPayees.memCommentEnter(Sender: TObject);
begin
  try
    memComment.Font.Bold := True;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmPayees.memCommentExit(Sender: TObject);
begin
  try
    memComment.Font.Bold := False;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmPayees.memCommentKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if (Key = 13) then
  begin
    Key := 0;
    cbxStatus.SetFocus;
    cbxStatus.DroppedDown := True;
  end;
end;

procedure TfrmPayees.btnSaveClick(Sender: TObject);
begin
  if (btnSave.Enabled = False) then
    Exit;

  // check forbidden chars in the text
  if CheckForbiddenChar(ediName) = True then
    Exit;

  // check forbidden chars in the text
  if CheckForbiddenChar(memComment) = True then
    Exit;

  try
    // Add new category
    if btnSave.Tag = 0 then
      frmMain.QRY.SQL.Text :=
        'INSERT OR IGNORE INTO payees (pee_name, pee_name_lower, pee_status, pee_comment) VALUES ('
        +
        ':NAME, :NAMELOWER, :STATUS, :COMMENT);'
    else
    begin
      // Edit selected category
      VST.Tag := StrToInt(VST.Text[VST.FocusedNode, 4]);
      frmMain.QRY.SQL.Text := 'UPDATE OR IGNORE payees SET ' +  // update
        'pee_name = :NAME, ' +               // name
        'pee_name_lower = :NAMELOWER, ' +   // name lower
        'pee_status = :STATUS, ' +          // status
        'pee_comment = :COMMENT ' +         // comment
        'WHERE pee_id = :ID;';              // ID
      frmMain.QRY.Params.ParamByName('ID').AsInteger := VST.Tag;
    end;

    frmMain.QRY.Params.ParamByName('NAME').AsString := ediName.Text;
    frmMain.QRY.Params.ParamByName('NAMELOWER').AsString := AnsiLowerCase(ediName.Text);
    frmMain.QRY.Params.ParamByName('COMMENT').AsString := Trim(memComment.Text);
    frmMain.QRY.Params.ParamByName('STATUS').AsInteger := cbxStatus.ItemIndex;
    frmMain.QRY.Prepare;
    frmMain.QRY.ExecSQL;
    frmMain.Tran.Commit;

    UpdatePayees;
    btnCancelClick(btnCancel);


    if btnSave.Tag = 0 then
      FindNewRecord(VST, 4)
    else
      FindEditedRecord(VST, 4, VST.Tag);
    VST.SetFocus;

  except
    on E: Exception do
    begin
      btnCancelClick(btnCancel);
      ShowErrorMessage(E);
    end;
  end;
end;

procedure TfrmPayees.splListCanResize(Sender: TObject);
begin
  imgWidth.ImageIndex := 3;
  lblWidth.Caption := IntToStr(frmPayees.Width - pnlDetail.Width);

  imgHeight.ImageIndex := 2;
  lblHeight.Caption := IntToStr(pnlDetail.Width);

  pnlListCaption.Repaint;
  pnlDetailCaption.Repaint;
  pnlButton.Repaint;
end;

procedure TfrmPayees.VSTBeforeCellPaint(Sender: TBaseVirtualTree;
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

procedure TfrmPayees.VSTChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
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

    if (VST.RootNodeCount = 0) or (VST.SelectedCount <> 1) then
    begin
      ediName.Clear;
      cbxStatus.ItemIndex := -1;
      memComment.Clear;
      Exit;
    end;

    if (VST.SelectedCount = 1) then
    begin
      ediName.Text := VST.Text[VST.GetFirstSelected(False), 1];
      memComment.Text := VST.Text[VST.GetFirstSelected(False), 2];
      cbxStatus.ItemIndex := cbxStatus.Items.IndexOf(
        VST.Text[VST.GetFirstSelected(False), 3]);
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmPayees.VSTCompareNodes(Sender: TBaseVirtualTree; Node1,
  Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
var
  Data1, Data2: PPayee;

begin
  Data1 := Sender.GetNodeData(Node1);
  Data2 := Sender.GetNodeData(Node2);
  case Column of
    1: Result := UTF8CompareText(Data1.Name, Data2.Name);
  end;
end;

procedure TfrmPayees.VSTDblClick(Sender: TObject);
begin
  if frmMain.Conn.Connected = False then Exit;

  if VST.SelectedCount = 1 then
    btnEditClick(btnEdit)
  else if VST.SelectedCount = 0 then
    btnAddClick(btnAdd);
end;

procedure TfrmPayees.VSTGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: boolean; var ImageIndex: integer);
begin
  if Column = 0 then
    ImageIndex := 13;
end;

procedure TfrmPayees.VSTGetNodeDataSize(Sender: TBaseVirtualTree;
  var NodeDataSize: Integer);
begin
  NodeDataSize := SizeOf(TPayee);
end;

procedure TfrmPayees.VSTGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
var
  Payee: PPayee;

begin
  Payee := Sender.GetNodeData(Node);
  try
    case Column of
      1: CellText := Payee.Name;
      2: CellText := Payee.Comment;
      3: CellText := cbxStatus.Items[Payee.Status];
      4: CellText := IntToStr(Payee.ID);
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmPayees.VSTPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
var
  Payee: PPayee;

begin
  If vsSelected in node.States then exit;

  Payee := Sender.GetNodeData(Node);
  case Payee.Status of
     0: TargetCanvas.Font.Color := IfThen(Dark = False, clDefault, clSilver);
    1: TargetCanvas.Font.Color := IfThen(Dark = False, clDefault, clSkyBlue);
    2: TargetCanvas.Font.Color := IfThen(Dark = False, clDefault, $007873F4);
  end;
end;

procedure TfrmPayees.VSTResize(Sender: TObject);
var
  X: integer;

begin
  if frmSettings.chkAutoColumnWidth.Checked = False then Exit;

  (Sender as TLazVirtualStringTree).Header.Columns[0].Width := round(ScreenRatio * 25 / 100);
  X := (VST.Width - VST.Header.Columns[0].Width) div 100;
  VST.Header.Columns[1].Width := 33 * X; // name
  VST.Header.Columns[2].Width := VST.Width - ScrollBarWidth - VST.Header.Columns[0].Width - (60 * X); // comment
  VST.Header.Columns[3].Width := 17 * X; // status
  VST.Header.Columns[4].Width := 10 * X; // ID
end;

procedure TfrmPayees.btnExitClick(Sender: TObject);
begin
  frmPayees.Close;
end;

procedure TfrmPayees.ediNameChange(Sender: TObject);
begin
  btnSave.Enabled := Length(ediName.Text) > 0;
end;

procedure TfrmPayees.FormClose(Sender: TObject; var CloseAction: TCloseAction);
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

procedure TfrmPayees.FormResize(Sender: TObject);
begin
  imgWidth.ImageIndex := 0;
  lblWidth.Caption := IntToStr(frmPayees.Width);
  imgHeight.ImageIndex := 1;
  lblHeight.Caption := IntToStr(frmPayees.Height);

  pnlListCaption.Repaint;
  pnlDetailCaption.Repaint;
  pnlButtons.Repaint;
  pnlButton.Repaint;
end;

procedure TfrmPayees.FormShow(Sender: TObject);
begin
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

  SetNodeHeight(VST);
  VST.SetFocus;
  VST.ClearSelection;
end;

procedure UpdatePayees;
var
  Payee: PPayee;
  P: PVirtualNode;

begin
  try
    frmPayees.VST.Clear;
    frmPayees.VST.RootNodeCount := 0;

    // =============================================================================================
    // update list of Payees in form Payees
    if frmMain.Conn.Connected = False then
      Exit;

    screen.Cursor := crHourGlass;
    frmPayees.VST.BeginUpdate;

      frmMain.QRY.SQL.Text :=
        'SELECT pee_name, pee_name_lower, pee_comment, pee_status, ' +
        'pee_time, pee_ID FROM payees';
      frmMain.QRY.Open;
      while not (frmMain.QRY.EOF) do
      begin
        frmPayees.VST.RootNodeCount := frmPayees.VST.RootNodeCount + 1;
        P := frmPayees.VST.GetLast();
        Payee := frmPayees.VST.GetNodeData(P);
        Payee.Name := frmMain.QRY.Fields[0].AsString;
        Payee.NameLower := frmMain.QRY.Fields[1].AsString;
        Payee.Comment := frmMain.QRY.Fields[2].AsString;
        Payee.Status := frmMain.QRY.Fields[3].AsInteger;
        Payee.Time := frmMain.QRY.Fields[4].AsString;
        Payee.ID := frmMain.QRY.Fields[5].AsInteger;
        frmMain.QRY.Next;
      end;
      frmMain.QRY.Close;

      frmPayees.VST.SortTree(1, sdAscending);
      SetNodeHeight(frmPayees.VST);
      frmPayees.VST.EndUpdate;
      screen.Cursor := crDefault;

    // =============================================================================================
    // update list of Payees in form Main
    frmMain.cbxPayee.Clear;
    frmDetail.cbxPayee.Clear;

    // =============================================================================================
    // update list of payees in frmMain
    frmMain.cbxPayee.Clear;
    frmDetail.cbxPayee.Clear;

    for P in frmPayees.VST.Nodes() do
      // list of payees in frmMAIN and frmDETAIL [only active status]
      if (frmPayees.VST.Text[P, 3] = frmPayees.cbxStatus.Items[0]) then
      begin
        frmMain.cbxPayee.Items.Add(frmPayees.VST.Text[P, 1]);
        frmDetail.cbxPayee.Items.Add(frmPayees.VST.Text[P, 1]);
      end;

    frmMain.cbxPayee.Items.Insert(0, '*');
    frmMain.cbxPayee.ItemIndex := 0;
    frmMain.cbxPayeeChange(frmMain.cbxPayee);

    // =============================================================================================
    // update list of payees in form Multiple additions
    frmDetail.cbxPayeeX.Clear;
    frmDetail.cbxPayeeX.Items := frmDetail.cbxPayee.Items;

    // =============================================================================================
    // update list of payees in form Scheduler
    frmScheduler.cbxPayee.Clear;
    frmScheduler.cbxPayee.Items := frmDetail.cbxPayee.Items;

    // =============================================================================================
    // update list of payees in form Edit
    frmEdit.cbxPayee.Clear;
    frmEdit.cbxPayee.Items := frmDetail.cbxPayee.Items;

    // =============================================================================================
    // update list of payees in form Edits
    frmEdits.cbxPayee.Clear;
    frmEdits.cbxPayee.Items := frmDetail.cbxPayee.Items;

    // =============================================================================================
    // update list of payees in form Edits
    frmTemplates.cbxPayee.Clear;
    frmTemplates.cbxPayee.Items := frmDetail.cbxPayee.Items;

    // =============================================================================================

    // items icon
    frmPayees.lblItems.Caption := IntToStr(frmPayees.VST.RootNodeCount);

    frmPayees.popCopy.Enabled := frmPayees.VST.RootNodeCount > 0;
    frmPayees.btnCopy.Enabled := frmPayees.popCopy.Enabled;
    frmPayees.btnSelect.Enabled := frmPayees.VST.RootNodeCount > 0;
    frmPayees.popPrint.Enabled := frmPayees.popCopy.Enabled;
    frmPayees.btnPrint.Enabled := frmPayees.popCopy.Enabled;
    frmPayees.popEdit.Enabled := False;
    frmPayees.btnEdit.Enabled := False;
    frmPayees.popDelete.Enabled := False;
    frmPayees.btnDelete.Enabled := False;

    if (frmPayees.Visible = True) and (frmPayees.VST.Enabled = True) then
      frmPayees.VST.SetFocus;

    screen.Cursor := crDefault;

    if frmProperties.Visible = True then
      frmProperties.FormShow(frmProperties);
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

end.
