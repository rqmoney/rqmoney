unit uniComments;

{$mode objfpc}{$H+}
{$ModeSwitch AutoDeref}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Math, ExtCtrls, ComCtrls, Buttons, Menus, DBGrids, ActnList,
  BCPanel, BCMDButtonFocus, LazUTF8, laz.VirtualTrees, StrUtils;

type
  TComment = record
    Text: string;
    Time: string;
    ID: integer;
  end;
  PComment = ^TComment;

type

  { TfrmComments }

  TfrmComments = class(TForm)
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
    imgHeight: TImage;
    imgWidth: TImage;
    imgItems: TImage;
    imgItem: TImage;
    lblHeight: TLabel;
    lblItems: TLabel;
    lblWidth: TLabel;
    lblComment: TLabel;
    lblItem: TLabel;
    memComment: TMemo;
    pnlTip: TPanel;
    popSelect: TMenuItem;
    MenuItem2: TMenuItem;
    pnlButton: TPanel;
    pnlButtons: TPanel;
    pnlComment: TPanel;
    pnlDetailCaption: TBCPanel;
    pnlList: TPanel;
    pnlDetail: TPanel;
    pnlItems: TPanel;
    pnlListCaption: TBCPanel;
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
    popPrint: TMenuItem;
    splList: TSplitter;
    VST: TLazVirtualStringTree;
    procedure btnCopyClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure btnPrintMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure btnSelectClick(Sender: TObject);
    procedure memCommentEnter(Sender: TObject);
    procedure memCommentExit(Sender: TObject);
    procedure memCommentChange(Sender: TObject);
    procedure memCommentKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure btnAddClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure pnlButtonResize(Sender: TObject);
    procedure pnlButtonsResize(Sender: TObject);
    procedure splListCanResize(Sender: TObject);
    procedure VSTBeforeCellPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
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
    procedure VSTResize(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmComments: TfrmComments;

procedure UpdateComments;

implementation

{$R *.lfm}

uses
  uniMain, uniSettings, uniScheduler, uniEdit, uniProperties, uniMultiple, uniDetail,
  uniResources, uniEdits, uniTemplates;

  { TfrmComments }

procedure TfrmComments.btnAddClick(Sender: TObject);
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
    //    pnlStamp.Visible := False;
    memComment.Clear;
    //txtStamp.Caption := '';
    lblItem.Caption := '';

    // disabled ActionList
    actAdd.Enabled := False;
    actEdit.Enabled := False;
    actDelete.Enabled := False;

    memComment.SetFocus;

  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;


procedure TfrmComments.btnEditClick(Sender: TObject);
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
    btnSave.Enabled := True;
    btnSave.Tag := 1;

    // disabled menu
    pnlButtons.Visible := False;
    pnlButton.Visible := True;

    // update fields
    //pnlStamp.Visible := False;
    memComment.Enabled := True;
    memComment.SetFocus;
    memComment.SelectAll;

    // disabled ActionList
    actAdd.Enabled := False;
    actEdit.Enabled := False;
    actDelete.Enabled := False;

  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmComments.btnCancelClick(Sender: TObject);
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
    memComment.Clear;

    // enabled ListView
    VST.Enabled := True;
    VST.SetFocus;

    // enabled ActionList
    actAdd.Enabled := True;
    actEdit.Enabled := True;
    actDelete.Enabled := True;

    VSTChange(VST, VST.GetFirstSelected());
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmComments.memCommentEnter(Sender: TObject);
begin
  try
    memComment.Font.Bold := True;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmComments.memCommentExit(Sender: TObject);
begin
  memComment.Font.Bold := False;
end;

procedure TfrmComments.btnCopyClick(Sender: TObject);
begin
  if (VST.Enabled = False) or (frmMain.Conn.Connected = False) then
    Exit;
  CopyVST(VST);
end;

procedure TfrmComments.btnPrintClick(Sender: TObject);
var
  FileName: string;
begin
  if btnPrint.Enabled = False then Exit;

  FileName := ExtractFileDir(Application.ExeName) + DirectorySeparator +
    'Templates' + DirectorySeparator + 'comments.lrf';

  if FileExists(FileName) = False then
  begin
    ShowMessage(Error_14 + sLineBreak + FileName);
    Exit;
  end;

  // left mouse button = show report
  try
    frmMain.Report.LoadFromFile(FileName);

    frmMain.Report.FindObject('lblName').Memo.Text := AnsiUpperCase(lblComment.Caption);
    frmMain.Report.FindObject('lblID').Memo.Text :=
      AnsiUpperCase(VST.Header.Columns[2].Text);
    frmMain.Report.FindObject('lblFooter').Memo.Text :=
      AnsiUpperCase(Application.Title + ' - ' + frmComments.Caption);

    frmMain.Report.Tag := 13;
    frmMain.Report.ShowReport;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;

  VST.SetFocus;
end;

procedure TfrmComments.btnPrintMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
var
  FileName: string;
begin
  FileName := ExtractFileDir(Application.ExeName) + DirectorySeparator +
    'Templates' + DirectorySeparator + 'comments.lrf';

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

procedure TfrmComments.btnSelectClick(Sender: TObject);
begin
  if (VST.Enabled = False) or (VST.RootNodeCount < 1) or
    (frmMain.Conn.Connected = False) then
    Exit;
  VST.SelectAll(False);
  VST.SetFocus;
end;

procedure TfrmComments.memCommentChange(Sender: TObject);
begin
  btnSave.Enabled := Length(memComment.Text) > 0;
end;

procedure TfrmComments.memCommentKeyUp(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  if (Key = 13) then
  begin
    Key := 0;
    if btnSave.Enabled = True then
      btnSave.SetFocus;
  end;
end;

procedure TfrmComments.btnDeleteClick(Sender: TObject);
var
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
        IDs := IDs + VST.Text[N, 2] + ',';
        N := VST.GetNextSelected(N);
      end;
    finally
      IDs := LeftStr(IDs, Length(IDs) - 1);
    end;

    // confirm deleting
    case VST.SelectedCount of
      1: if MessageDlg(Message_00, Question_01 + sLineBreak +
          sLineBreak + VST.Header.Columns[1].Text + ': ' +
          VST.Text[VST.FocusedNode, 1], mtConfirmation, mbYesNo, 0) <> 6 then
          Exit;
      else
        if MessageDlg(Message_00, AnsiReplaceStr(
          Question_02, '%', IntToStr(VST.SelectedCount)), mtConfirmation,
          mbYesNo, 0) <> 6 then
          Exit;
    end;

    frmMain.QRY.SQL.Text := 'DELETE FROM comments WHERE com_id IN (' + IDs + ')';
    frmMain.QRY.ExecSQL;
    frmMain.Tran.Commit;

    UpdateComments;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmComments.btnSaveClick(Sender: TObject);
begin

  // check forbidden chars in the text
  if CheckForbiddenChar(memComment) = True then
    Exit;
  if (btnSave.Enabled = False) then
    Exit;

  try
    // Add new category
    if btnSave.Tag = 0 then
      frmMain.QRY.SQL.Text :=
        'INSERT INTO comments (com_text) VALUES (:COMMENT);'
    else
    begin
      // Edit selected record
      VST.Tag := StrToInt(VST.Text[VST.GetFirstSelected(False), 2]);
      frmMain.QRY.SQL.Text :=
        'UPDATE comments SET com_text = :COMMENT WHERE com_id = :ID;';
      frmMain.QRY.Params.ParamByName('ID').AsInteger := VST.Tag;
    end;

    frmMain.QRY.Params.ParamByName('COMMENT').AsString := Trim(memComment.Text);
    frmMain.QRY.Prepare;
    frmMain.QRY.ExecSQL;
    frmMain.Tran.Commit;

    UpdateComments;
    btnCancelClick(btnCancel);

    if btnSave.Tag = 0 then
      FindNewRecord(VST, 2)
    else
      FindEditedRecord(VST, 2, VST.Tag);
    VST.SetFocus;

  except
    on E: Exception do
    begin

      btnCancelClick(btnCancel);
      ShowErrorMessage(E);
    end;
  end;
end;

procedure TfrmComments.VSTDblClick(Sender: TObject);
begin
  if frmMain.Conn.Connected = False then Exit;

  if VST.SelectedCount = 1 then
    btnEditClick(btnEdit)
  else if VST.SelectedCount = 0 then
    btnAddClick(btnAdd);
end;

procedure TfrmComments.VSTGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: boolean; var ImageIndex: integer);
begin
  if Column = 0 then
    ImageIndex := 14;
end;

procedure TfrmComments.VSTGetNodeDataSize(Sender: TBaseVirtualTree;
  var NodeDataSize: integer);
begin
  NodeDataSize := SizeOf(TComment);
end;

procedure TfrmComments.VSTGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
var
  Comment: PComment;
begin
  Comment := Sender.GetNodeData(Node);
  try
    case Column of
      1: CellText := Comment.Text;
      2: CellText := IntToStr(Comment.ID);
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmComments.VSTResize(Sender: TObject);
var
  X: integer;
begin
  if frmSettings.chkAutoColumnWidth.Checked = False then Exit;

  (Sender as TLazVirtualStringTree).Header.Columns[0].Width :=
    Round(ScreenRatio / 100 * 25);
  X := (VST.Width - VST.Header.Columns[0].Width) div 100;
  VST.Header.Columns[1].Width :=
    VST.Width - VST.Header.Columns[0].Width - ScrollBarWidth - (12 * X); // text
  VST.Header.Columns[2].Width := 12 * X; // ID
end;

procedure TfrmComments.pnlButtonResize(Sender: TObject);
begin
  btnCancel.Width := (pnlButton.Width - 6) div 2;
end;

procedure TfrmComments.pnlButtonsResize(Sender: TObject);
begin
  btnEdit.Width := (pnlButtons.Width - 14) div 7;
  btnDelete.Width := btnEdit.Width;
  btnCopy.Width := btnEdit.Width;
  btnPrint.Width := btnEdit.Width;
  btnExit.Width := btnEdit.Width;
  btnSelect.Width := btnEdit.Width;
end;

procedure TfrmComments.splListCanResize(Sender: TObject);
begin
  try
    imgWidth.ImageIndex := 3;
    lblWidth.Caption := IntToStr(frmComments.Width - pnlDetail.Width);

    imgHeight.ImageIndex := 2;
    lblHeight.Caption := IntToStr(pnlDetail.Width);


    pnlListCaption.Repaint;
    pnlDetailCaption.Repaint;
    pnlButton.Repaint;
  except
    on E: Exception do
      ShowMessage(E.Message + sLineBreak + E.ClassName + sLineBreak + E.UnitName);
  end;
end;

procedure TfrmComments.VSTBeforeCellPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
begin
  TargetCanvas.Brush.Color := IfThen(Node.Index mod 2 = 0, clWhite,
    frmSettings.pnlOddRowColor.Color);
  TargetCanvas.FillRect(CellRect);
end;

procedure TfrmComments.VSTChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
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

    if (VST.SelectedCount = 1) then
      memComment.Text := VST.Text[VST.GetFirstSelected(False), 1]
    else
      memComment.Clear;

  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmComments.VSTCompareNodes(Sender: TBaseVirtualTree;
  Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: integer);
var
  Data1, Data2: PComment;
begin
  Data1 := Sender.GetNodeData(Node1);
  Data2 := Sender.GetNodeData(Node2);
  case Column of
    1: Result := UTF8CompareText(Data1.Text, Data2.Text);
  end;
end;

procedure TfrmComments.btnExitClick(Sender: TObject);
begin
  frmComments.Close;
end;

procedure TfrmComments.FormClose(Sender: TObject; var CloseAction: TCloseAction);
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

procedure TfrmComments.FormCreate(Sender: TObject);
begin
  // form size
  (Sender as TForm).Width := Round((Screen.Width /
    IfThen(ScreenIndex = 0, 1, (ScreenRatio / 100))) - (Round(1020 / (ScreenRatio / 100)) - ScreenRatio));
  (Sender as TForm).Height := Round(Screen.Height /
    IfThen(ScreenIndex = 0, 1, (ScreenRatio / 100))) - 3 * (250 - ScreenRatio);

  // form position
  (Sender as TForm).Left := (Screen.Width - (Sender as TForm).Width) div 2;
  (Sender as TForm).Top := (Screen.Height - 100 - (Sender as TForm).Height) div 2;

  {$IFDEF WINDOWS}
  // set components height
  VST.Header.Height := PanelHeight;
  pnlDetailCaption.Height := PanelHeight;
  pnlListCaption.Height := PanelHeight;
  pnlBottom.Height := ButtonHeight + 2;
  pnlButtons.Height := ButtonHeight;
  pnlButton.Height := ButtonHeight;
  {$ENDIF}
end;

procedure TfrmComments.FormResize(Sender: TObject);
begin
  try
    imgWidth.ImageIndex := 0;
    lblWidth.Caption := IntToStr(frmComments.Width);
    imgHeight.ImageIndex := 1;
    lblHeight.Caption := IntToStr(frmComments.Height);

    pnlListCaption.Repaint;
    pnlDetailCaption.Repaint;
    pnlButtons.Repaint;
    pnlButton.Repaint;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmComments.FormShow(Sender: TObject);
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

  SetNodeHeight(frmComments.VST);
  VST.SetFocus;
  VST.ClearSelection;
end;

procedure UpdateComments;
var
  Comment: PComment;
  P: PVirtualNode;
begin
  try
    frmComments.VST.Clear;
    frmComments.VST.RootNodeCount := 0;

    // =============================================================================================
    // update list of comments in form Comments
    if frmMain.Conn.Connected = False then
      Exit;

    frmMain.QRY.SQL.Text := 'SELECT com_text, com_time, com_id FROM comments';
    frmMain.QRY.Open;
    while not (frmMain.QRY.EOF) do
    begin
      frmComments.VST.RootNodeCount := frmComments.VST.RootNodeCount + 1;
      P := frmComments.VST.GetLast();
      Comment := frmComments.VST.GetNodeData(P);
      Comment.Text := frmMain.QRY.Fields[0].AsString;
      Comment.Time := frmMain.QRY.Fields[1].AsString;
      Comment.ID := frmMain.QRY.Fields[2].AsInteger;
      frmMain.QRY.Next;
    end;

    frmMain.QRY.Close;

    frmComments.VST.SortTree(1, sdAscending);
    frmComments.VST.EndUpdate;
    SetNodeHeight(frmComments.VST);
    screen.Cursor := crDefault;

    // =============================================================================================
    // update list of comments in form Main
    frmDetail.cbxComment.Clear;

    for P in frmComments.VST.Nodes(False) do
      frmDetail.cbxComment.Items.Add(frmComments.VST.Text[P, 1]);

    // =============================================================================================
    // update list of comments in form Scheduler
    frmScheduler.cbxComment.Clear;
    frmScheduler.cbxComment.Items := frmDetail.cbxComment.Items;

    // =============================================================================================
    // update list of comments in form Edit
    frmEdit.cbxComment.Clear;
    frmEdit.cbxComment.Items := frmDetail.cbxComment.Items;

    // =============================================================================================
    // update list of comments in form Edits
    frmEdits.cbxComment.Clear;
    frmEdits.cbxComment.Items := frmDetail.cbxComment.Items;

    // =============================================================================================
    // update list of comments in form Multiple addtions
    frmMultiple.cbxComment.Clear;
    frmMultiple.cbxComment.Items := frmDetail.cbxComment.Items;

    // =============================================================================================
    // update list of comments in form Multiple addtions
    frmTemplates.cbxComment.Clear;
    frmTemplates.cbxComment.Items := frmDetail.cbxComment.Items;

    // =============================================================================================
    // item icon
    frmComments.imgItem.ImageIndex := -1;
    frmComments.lblItems.Caption := IntToStr(frmComments.VST.RootNodeCount);

    frmComments.popCopy.Enabled := frmComments.VST.RootNodeCount > 0;
    frmComments.btnCopy.Enabled := frmComments.popCopy.Enabled;
    frmComments.btnSelect.Enabled := frmComments.VST.RootNodeCount > 0;
    frmComments.popPrint.Enabled := frmComments.popCopy.Enabled;
    frmComments.btnPrint.Enabled := frmComments.popCopy.Enabled;
    frmComments.popEdit.Enabled := False;
    frmComments.btnEdit.Enabled := False;
    frmComments.popDelete.Enabled := False;
    frmComments.btnDelete.Enabled := False;

    if (frmComments.Visible = True) and (frmComments.VST.Enabled = True) then
      frmComments.VST.SetFocus;

    if frmProperties.Visible = True then frmProperties.FormShow(frmProperties);
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

end.
