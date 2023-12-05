unit uniPersons;

{$mode objfpc}{$H+}
{$ModeSwitch AutoDeref}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, ComCtrls, Buttons, Menus, ActnList, BCPanel,
  BCMDButtonFocus, LazUTF8, laz.VirtualTrees, StrUtils, Math;

type
  TPerson = record
    Name: string;
    NameLower: string;
    Comment: string;
    Status: Integer;
    Time: String;
    ID: Integer;
  end;
  PPerson = ^TPerson;

type

  { TfrmPersons }

  TfrmPersons = class(TForm)
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
    btnSelect: TBCMDButtonFocus;
    btnDelete: TBCMDButtonFocus;
    btnEdit: TBCMDButtonFocus;
    btnExit: TBCMDButtonFocus;
    btnPrint: TBCMDButtonFocus;
    btnSave: TBCMDButtonFocus;
    btnStatusInfo: TImage;
    cbxStatus: TComboBox;
    ediName: TEdit;
    lblStatus: TLabel;
    memComment: TMemo;
    popSelect: TMenuItem;
    pnlButton: TPanel;
    pnlButtons: TPanel;
    pnlClient: TPanel;
    pnlDetailCaption: TBCPanel;
    pnlListCaption: TBCPanel;
    popPause1: TMenuItem;
    popPrint: TMenuItem;
    popExit: TMenuItem;
    pnlStatusTop: TPanel;
    popCopy: TMenuItem;
    imgHeight: TImage;
    imgItems: TImage;
    imgWidth: TImage;
    imgItem: TImage;
    lblHeight: TLabel;
    lblItems: TLabel;
    lblWidth: TLabel;
    lblName: TLabel;
    lblComment: TLabel;
    lblItem: TLabel;
    pnlPersons: TPanel;
    pnlStatus: TPanel;
    pnlName: TPanel;
    pnlComment: TPanel;
    pnlList: TPanel;
    pnlDetail: TPanel;
    pnlItems: TPanel;
    pnlBottom: TPanel;
    pnlHeight: TPanel;
    pnlTip: TPanel;
    pnlWidth: TPanel;
    pnlItem: TPanel;
    popAdd: TMenuItem;
    popDelete: TMenuItem;
    popEdit: TMenuItem;
    popList: TPopupMenu;
    splList: TSplitter;
    VST: TLazVirtualStringTree;
    procedure actSaveExecute(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnCancelEnter(Sender: TObject);
    procedure btnCancelExit(Sender: TObject);
    procedure btnCopyClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
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
    procedure btnDeleteClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure ediNameChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure pnlButtonResize(Sender: TObject);
    procedure pnlButtonsResize(Sender: TObject);
    procedure splListCanResize(Sender: TObject; var NewSize: integer;
      var Accept: boolean);
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
  frmPersons: TfrmPersons;

procedure UpdatePersons;

implementation

{$R *.lfm}

uses
  uniMain, uniSettings, uniScheduler, uniEdit, uniProperties, uniTemplates,
  uniMultiple, uniDetail, uniDelete, uniResources, uniEdits;

{ TfrmPersons }


procedure TfrmPersons.FormCreate(Sender: TObject);
begin
  try
    // cbxStatus
    frmPersons.cbxStatus.Clear;
    frmPersons.cbxStatus.Items.Add(Caption_55);
    frmPersons.cbxStatus.Items.Add(Caption_57);
    frmPersons.cbxStatus.Items.Add(Caption_59);

    // form size
    (Sender as TForm).Width := Round((Screen.Width /
      IfThen(ScreenIndex = 0, 1, (ScreenRatio / 100))) - (Round(1020 / (ScreenRatio / 100)) - ScreenRatio));
    (Sender as TForm).Height := Round(Screen.Height /
      IfThen(ScreenIndex = 0, 1, (ScreenRatio / 100))) - 3 * (250 - ScreenRatio);

    // form position
    (Sender as TForm).Left := (Screen.Width - (Sender as TForm).Width) div 2;
    (Sender as TForm).Top := (Screen.Height - 100 - (Sender as TForm).Height) div 2;

    {$IFDEF WINDOWS}
    VST.Header.Height := PanelHeight;
    pnlDetailCaption.Height := PanelHeight;
    pnlListCaption.Height := PanelHeight;
    pnlButtons.Height := ButtonHeight;
    pnlButton.Height := ButtonHeight;
    pnlBottom.Height := ButtonHeight;
    {$ENDIF}
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmPersons.btnAddClick(Sender: TObject);
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
    //pnlStamp.Visible := False;
    cbxStatus.ItemIndex := 0;
    ediName.Clear;
    memComment.Clear;

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

procedure TfrmPersons.actSaveExecute(Sender: TObject);
begin
  if (pnlButton.Visible = True) and (btnSave.Enabled = True) then
    btnSaveClick(btnSave);
end;

procedure TfrmPersons.btnEditClick(Sender: TObject);
begin
  if (VST.Enabled = False) or (VST.SelectedCount = 0) or (frmMain.Conn.Connected = False) then
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

procedure TfrmPersons.btnCancelClick(Sender: TObject);
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

    // disabled ActionList
    actAdd.Enabled := True;
    actEdit.Enabled := True;
    actDelete.Enabled := True;

  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;


procedure TfrmPersons.btnDeleteClick(Sender: TObject);
var
  I: integer;
  IDs: string;
  N: PVirtualNode;

begin
  try
    if (frmMain.Conn.Connected = False) or (vST.RootNodeCount = 0) or
      (VST.SelectedCount = 0) then
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

    frmMain.QRY.SQL.Text := 'SELECT COUNT(*) FROM data WHERE d_person IN (' +
      IDs + ');';
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
      frmDelete.Hint :=
        'd_person IN (' + IDs + ')' + separ + // for transactions
        'sch_person IN (' + IDs + ')' + separ; // for schedulers
      frmDelete.pnlCaption2.Caption := Question_07;
      if frmDelete.ShowModal <> mrOk then
        Exit;
    end;

    frmMain.QRY.SQL.Text := 'DELETE FROM persons WHERE per_id IN (' + IDs + ')';
    frmMain.QRY.ExecSQL;
    frmMain.Tran.Commit;

    UpdatePersons;

  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmPersons.ediNameEnter(Sender: TObject);
begin
  ediName.Font.Bold := True;
end;

procedure TfrmPersons.cbxStatusKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
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

procedure TfrmPersons.btnCancelExit(Sender: TObject);
begin
  (Sender as TBitBtn).Font.Bold := False;
end;

procedure TfrmPersons.btnCopyClick(Sender: TObject);
begin
  if (VST.Enabled = False) or (frmMain.Conn.Connected = False) then
    Exit;
  CopyVST(VST);
end;

procedure TfrmPersons.btnExitClick(Sender: TObject);
begin
  frmPersons.Close;
end;

procedure TfrmPersons.btnPrintClick(Sender: TObject);
var
 FileName: String;

begin
 if btnPrint.Enabled = False then Exit;

 FileName := ExtractFileDir(Application.ExeName) + DirectorySeparator + 'Templates' +
     DirectorySeparator + 'persons.lrf';

 if FileExists(FileName) = False then
 begin
   ShowMessage(Error_14 + sLineBreak + FileName);
   Exit;
 end;

 // left mouse button = show report
 try
   frmMain.Report.Tag := 10;
   frmMain.Report.LoadFromFile(FileName);
   frmMain.Report.FindObject('lblName').Memo.Text := AnsiUpperCase(lblName.Caption);
   frmMain.Report.FindObject('lblComment').Memo.Text :=
     AnsiUpperCase(lblComment.Caption);
   //    frmMain.Report.FindObject('lblStamp').Memo.Text := AnsiUpperCase(lblStamp.Caption);
   frmMain.Report.FindObject('lblStatus').Memo.Text :=
     AnsiUpperCase(lblStatus.Caption);
   frmMain.Report.FindObject('lblID').Memo.Text :=
     AnsiUpperCase(VST.Header.Columns[4].Text);
   frmMain.Report.FindObject('lblFooter').Memo.Text :=
     AnsiUpperCase(Application.Title + ' - ' + frmPersons.Caption);

   frmMain.Report.ShowReport;

   VST.SetFocus;

 except
   on E: Exception do
     ShowErrorMessage(E);
 end;
end;

procedure TfrmPersons.btnPrintMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
 FileName: String;

begin
 FileName := ExtractFileDir(Application.ExeName) + DirectorySeparator + 'Templates' +
     DirectorySeparator + 'persons.lrf';

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

procedure TfrmPersons.btnSelectClick(Sender: TObject);
begin
  if (VST.Enabled = False) or (VST.RootNodeCount < 1) or (frmMain.Conn.Connected = False) then
    Exit;
  VST.SelectAll(False);
  VST.SetFocus;
end;

procedure TfrmPersons.cbxStatusEnter(Sender: TObject);
begin
  cbxStatus.Font.Bold := True;
end;

procedure TfrmPersons.cbxStatusExit(Sender: TObject);
begin
  cbxStatus.Font.Bold := False;
end;

procedure TfrmPersons.btnCancelEnter(Sender: TObject);
begin
  (Sender as TBitBtn).Font.Bold := True;
end;

procedure TfrmPersons.ediNameExit(Sender: TObject);
begin
  ediName.Font.Bold := False;
end;

procedure TfrmPersons.ediNameKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if (Key = 13) then
  begin
    Key := 0;
    memComment.SetFocus;
  end;
end;

procedure TfrmPersons.memCommentEnter(Sender: TObject);
begin
  try
    memComment.Font.Bold := True;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmPersons.memCommentExit(Sender: TObject);
begin
  try
    memComment.Font.Bold := False;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmPersons.memCommentKeyUp(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  try
    if (ssCtrl in Shift) and (Key = 13) then
    begin
      Key := 0;
      memComment.Text := ReplaceStr(memComment.Text, sLineBreak, '');
      memComment.SelStart := UTF8Length(memComment.Text);
      memComment.SelLength := 0;
      Exit;
    end;
    if (Key = 13) then
    begin
      Key := 0;
      cbxStatus.SetFocus;
      cbxStatus.DroppedDown := True;
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmPersons.btnSaveClick(Sender: TObject);
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
    if btnSave.Tag = 0 then
      // Add new record
      frmMain.QRY.SQL.Text :=
        'INSERT INTO persons (per_name, per_name_lower, per_status, per_comment) VALUES ('
        + ':NAME, :NAMELOWER, :STATUS, :COMMENT)'
    else
    begin
      // Edit selected record
      VST.Tag := StrToInt(VST.Text[VST.FocusedNode, 4]);
      frmMain.QRY.SQL.Text :=
        'UPDATE persons SET ' +            // update
        'per_name = :NAME, ' +            // name
        'per_name_lower = :NAMELOWER, ' + // name lower
        'per_status = :STATUS, ' +        // status
        'per_comment = :COMMENT ' +       // comment
        'WHERE per_id = :ID;';
      frmMain.QRY.Params.ParamByName('ID').AsInteger := VST.Tag;
    end;

    frmMain.QRY.Params.ParamByName('NAME').AsString := ediName.Text;
    frmMain.QRY.Params.ParamByName('NAMELOWER').AsString := AnsiLowerCase(ediName.Text);
    if Length(Trim(memComment.Text)) = 0 then
      frmMain.QRY.Params.ParamByName('COMMENT').Value := NULL
    else
      frmMain.QRY.Params.ParamByName('COMMENT').AsString := Trim(memComment.Text);
    frmMain.QRY.Params.ParamByName('STATUS').AsInteger := cbxStatus.ItemIndex;
    frmMain.QRY.Prepare;
    frmMain.QRY.ExecSQL;
    frmMain.Tran.Commit;

    UpdatePersons;
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

procedure TfrmPersons.splListCanResize(Sender: TObject; var NewSize: integer;
  var Accept: boolean);
begin
  imgWidth.ImageIndex := 3;
  lblWidth.Caption := IntToStr(frmPersons.Width - pnlDetail.Width);

  imgHeight.ImageIndex := 2;
  lblHeight.Caption := IntToStr(pnlDetail.Width);

  pnlListCaption.Repaint;
  pnlDetailCaption.Repaint;
  pnlButton.Repaint;
end;

procedure TfrmPersons.VSTBeforeCellPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
begin
  TargetCanvas.Brush.Color := IfThen(Node.Index mod 2 = 0, clWhite,
    frmSettings.pnlOddRowColor.Color);
  TargetCanvas.FillRect(CellRect);
end;

procedure TfrmPersons.VSTChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
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

procedure TfrmPersons.VSTCompareNodes(Sender: TBaseVirtualTree; Node1,
  Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
var
  Data1, Data2: PPerson;

begin
  Data1 := Sender.GetNodeData(Node1);
  Data2 := Sender.GetNodeData(Node2);
  case Column of
    1: Result := UTF8CompareText(Data1.Name, Data2.Name);
  end;
end;

procedure TfrmPersons.VSTDblClick(Sender: TObject);
begin
  if frmMain.Conn.Connected = False then Exit;

  if VST.SelectedCount = 1 then
    btnEditClick(btnEdit)
  else if VST.SelectedCount = 0 then
    btnAddClick(btnAdd);
end;

procedure TfrmPersons.VSTGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: boolean; var ImageIndex: integer);
begin
  if Column = 0 then
    ImageIndex := 17;
end;

procedure TfrmPersons.VSTGetNodeDataSize(Sender: TBaseVirtualTree;
  var NodeDataSize: Integer);
begin
  NodeDataSize := SizeOf(TPerson);
end;

procedure TfrmPersons.VSTGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
var
  Person: PPerson;

begin
  Person := Sender.GetNodeData(Node);
  try
    case Column of
      1: CellText := Person.Name;
      2: CellText := Person.Comment;
      3: CellText := cbxStatus.Items[Person.Status];
      4: CellText := IntToStr(Person.ID);
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmPersons.VSTPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
var
  Person: PPerson;

begin
  If vsSelected in node.States then exit;

  Person := Sender.GetNodeData(Node);
  case Person.Status of
    0: TargetCanvas.Font.Color := clDefault;
    1: TargetCanvas.Font.Color := clBlue;
    2: TargetCanvas.Font.Color := clRed;
  end;
end;

procedure TfrmPersons.VSTResize(Sender: TObject);
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

procedure TfrmPersons.ediNameChange(Sender: TObject);
begin
  btnSave.Enabled := Length(ediName.Text) > 0;
end;

procedure TfrmPersons.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  if pnlButton.Visible = True then
  begin
    btnCancelClick(btnCancel);
    CloseAction := Forms.caNone;
    Exit;
  end;
end;

procedure TfrmPersons.FormResize(Sender: TObject);
begin
  imgWidth.ImageIndex := 0;
  lblWidth.Caption := IntToStr(frmPersons.Width);
  imgHeight.ImageIndex := 1;
  lblHeight.Caption := IntToStr(frmPersons.Height);

  pnlListCaption.Repaint;
  pnlDetailCaption.Repaint;
  pnlButtons.Repaint;
  pnlButton.Repaint;
end;

procedure TfrmPersons.FormShow(Sender: TObject);
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

  SetNodeHeight(frmPersons.VST);
  VST.SetFocus;
  VST.ClearSelection;
end;

procedure TfrmPersons.pnlButtonResize(Sender: TObject);
begin
  btnCancel.Width := (pnlButton.Width - 6) div 2;
end;

procedure TfrmPersons.pnlButtonsResize(Sender: TObject);
begin
  btnEdit.Width := (pnlButtons.Width - 14) div 7;
  btnDelete.Width := btnEdit.Width;
  btnCopy.Width := btnEdit.Width;
  btnPrint.Width := btnEdit.Width;
  btnExit.Width := btnEdit.Width;
  btnSelect.Width := btnEdit.Width;
  pnlButtons.Repaint;
end;

procedure UpdatePersons;
var
  Person: PPerson;
  P: PVirtualNode;

begin
  try
    frmPersons.VST.Clear;
    frmPersons.VST.RootNodeCount := 0;

    // =============================================================================================
    // update list of persons in form Persons
    if frmMain.Conn.Connected = False then
      Exit;

    screen.Cursor := crHourGlass;
    frmPersons.VST.BeginUpdate;

      frmMain.QRY.SQL.Text :=
        'SELECT per_name, per_name_lower, per_comment, per_status, ' +
        'per_time, per_ID FROM persons';
      frmMain.QRY.Open;
      while not (frmMain.QRY.EOF) do
      begin
        frmPersons.VST.RootNodeCount := frmPersons.VST.RootNodeCount + 1;
        P := frmPersons.VST.GetLast();
        Person := frmPersons.VST.GetNodeData(P);
        Person.Name := frmMain.QRY.Fields[0].AsString;
        Person.NameLower := frmMain.QRY.Fields[1].AsString;
        Person.Comment := frmMain.QRY.Fields[2].AsString;
        Person.Status := frmMain.QRY.Fields[3].AsInteger;
        Person.Time := frmMain.QRY.Fields[4].AsString;
        Person.ID := frmMain.QRY.Fields[5].AsInteger;
        frmMain.QRY.Next;
      end;
      frmMain.QRY.Close;

      frmPersons.VST.SortTree(1, sdAscending);
      frmPersons.VST.EndUpdate;
      screen.Cursor := crDefault;

    // =============================================================================================
    // update list of persons in form Main
    frmMain.cbxPerson.Clear;
    frmDetail.cbxPerson.Clear;

    if (frmPersons.VST.RootNodeCount > 0) and
      (frmPersons.cbxStatus.Items.Count > 0) then
      for P in frmPersons.VST.Nodes() do
      begin
        // list of Persons in frmMAIN [not archive status]
        if (frmPersons.VST.Text[P, 3] <> frmPersons.cbxStatus.Items[2]) then
          frmMain.cbxPerson.Items.Add(frmPersons.VST.Text[P, 1]);

        // list of Persons in frmDETAIL [active status only !!!]
        if (frmPersons.VST.Text[P, 3] = frmPersons.cbxStatus.Items[0]) then
          frmDetail.cbxPerson.Items.Add(frmPersons.VST.Text[P, 1]);
      end;

    frmMain.cbxPerson.Items.Insert(0, '*');
    frmMain.cbxPerson.ItemIndex := 0;
    frmMain.cbxPersonChange(frmMain.cbxPerson);

    // =============================================================================================
    // update list of persons in form Multiple Addtitions
    frmMultiple.cbxPerson.Clear;
    frmMultiple.cbxPerson.Items := frmDetail.cbxPerson.Items;

    // =============================================================================================
    // update list of persons in form Scheduler
    frmScheduler.cbxPerson.Clear;
    frmScheduler.cbxPerson.Items := frmDetail.cbxPerson.Items;
    if frmScheduler.cbxPerson.Items.Count > 0 then
      frmScheduler.cbxPerson.ItemIndex := 0;

    // =============================================================================================
    // update list of persons in form Edit
    frmEdit.cbxPerson.Clear;
    frmEdit.cbxPerson.Items := frmDetail.cbxPerson.Items;

    // =============================================================================================
    // update list of persons in form Edits
    frmEdits.cbxPerson.Clear;
    frmEdits.cbxPerson.Items := frmDetail.cbxPerson.Items;

    // =============================================================================================
    // update list of persons in form Edits
    frmTemplates.cbxPerson.Clear;
    frmTemplates.cbxPerson.Items := frmDetail.cbxPerson.Items;

    // =============================================================================================

    // items icon
    frmPersons.lblItems.Caption := IntToStr(frmPersons.VST.RootNodeCount);

    frmPersons.popCopy.Enabled := frmPersons.VST.RootNodeCount > 0;
    frmPersons.btnCopy.Enabled := frmPersons.popCopy.Enabled;
    frmPersons.btnSelect.Enabled := frmPersons.VST.RootNodeCount > 0;
    frmPersons.popPrint.Enabled := frmPersons.popCopy.Enabled;
    frmPersons.btnPrint.Enabled := frmPersons.popCopy.Enabled;
    frmPersons.popEdit.Enabled := False;
    frmPersons.btnEdit.Enabled := False;
    frmPersons.popDelete.Enabled := False;
    frmPersons.btnDelete.Enabled := False;

    if (frmPersons.Visible = True) and (frmPersons.VST.Enabled = True) then
      frmPersons.VST.SetFocus;

    if frmProperties.Visible = True then
      frmProperties.FormShow(frmProperties);
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

end.
