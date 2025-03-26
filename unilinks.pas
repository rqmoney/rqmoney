unit uniLinks;

{$mode ObjFPC}{$H+}
{$ModeSwitch AutoDeref}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls, Math,
  Menus, ActnList, BCPanel, BCMDButtonFocus, LazUTF8, laz.VirtualTrees, StrUtils,
  LCLProc;

type
  TLink = record
    Name: string;
    Link: string;
    ShortCut: string;
    Comment: string;
    ID: integer;
  end;
  PLink = ^TLink;

type

  { TfrmLinks }

  TfrmLinks = class(TForm)
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
    chkCtrl: TCheckBox;
    chkShift: TCheckBox;
    chkAlt: TCheckBox;
    cbxShortCut: TComboBox;
    ediName: TEdit;
    ediLink: TEdit;
    imgHeight: TImage;
    imgItem: TImage;
    imgItems: TImage;
    imgWidth: TImage;
    lblComment: TLabel;
    lblHeight: TLabel;
    lblItem: TLabel;
    lblItems: TLabel;
    lblShortcut: TLabel;
    lblName: TLabel;
    lblLink: TLabel;
    lblWidth: TLabel;
    memComment: TMemo;
    pnlBottom: TPanel;
    pnlButton: TPanel;
    pnlButtons: TPanel;
    pnlClient: TPanel;
    pnlComment: TPanel;
    pnlDetail: TPanel;
    pnlDetailCaption: TBCPanel;
    pnlHeight: TPanel;
    pnlItem: TPanel;
    pnlItems: TPanel;
    pnlList: TPanel;
    pnlListCaption: TBCPanel;
    pnlName: TPanel;
    pnlLink: TPanel;
    pnlshortcut: TPanel;
    pnlTip: TPanel;
    pnlWidth: TPanel;
    popAdd: TMenuItem;
    popCopy: TMenuItem;
    popDelete: TMenuItem;
    popEdit: TMenuItem;
    popExit: TMenuItem;
    popList: TPopupMenu;
    popPause1: TMenuItem;
    popPrint: TMenuItem;
    popSelect: TMenuItem;
    splList: TSplitter;
    VST: TLazVirtualStringTree;
    procedure btnAddClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnCopyClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure btnPrintMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure btnSaveClick(Sender: TObject);
    procedure btnSelectClick(Sender: TObject);
    procedure chkCtrlEnter(Sender: TObject);
    procedure chkCtrlExit(Sender: TObject);
    procedure ediNameChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure pnlButtonsResize(Sender: TObject);
    procedure splListCanResize(Sender: TObject; var NewSize: integer;
      var Accept: boolean);
    procedure VSTBeforeCellPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
    procedure VSTChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure VSTDblClick(Sender: TObject);
    procedure VSTGetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Kind: TVTImageKind; Column: TColumnIndex; var Ghosted: boolean;
      var ImageIndex: integer);
    procedure VSTGetNodeDataSize(Sender: TBaseVirtualTree;
      var NodeDataSize: integer);
    procedure VSTGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure VSTResize(Sender: TObject);
  private

  public

  end;

var
  frmLinks: TfrmLinks;

procedure UpdateLinks;

implementation

{$R *.lfm}

{ TfrmLinks }

uses
  uniMain, uniSettings, uniResources;

procedure TfrmLinks.FormResize(Sender: TObject);
begin
  imgWidth.ImageIndex := 0;
  lblWidth.Caption := IntToStr(frmLinks.Width);
  imgHeight.ImageIndex := 1;
  lblHeight.Caption := IntToStr(frmLinks.Height);

  pnlListCaption.Repaint;
  pnlDetailCaption.Repaint;
  pnlButtons.Repaint;
  pnlButton.Repaint;
end;

procedure TfrmLinks.FormShow(Sender: TObject);
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

procedure TfrmLinks.btnExitClick(Sender: TObject);
begin
  frmLinks.Close;
end;

procedure TfrmLinks.btnPrintClick(Sender: TObject);
var
  FileName: string;
begin
  if btnPrint.Enabled = False then Exit;

  FileName := ExtractFileDir(Application.ExeName) + DirectorySeparator +
    'Templates' + DirectorySeparator + 'links.lrf';

  if FileExists(FileName) = False then
  begin
    ShowMessage(Error_14 + sLineBreak + FileName);
    Exit;
  end;

  // left mouse button = show report
  try
    frmMain.Report.Tag := 18;
    frmMain.Report.LoadFromFile(FileName);
    frmMain.Report.FindObject('lblName').Memo.Text := AnsiUpperCase(lblName.Caption);
    frmMain.Report.FindObject('lblLink').Memo.Text := AnsiUpperCase(lblLink.Caption);
    frmMain.Report.FindObject('lblShortcut').Memo.Text :=
      AnsiUpperCase(lblShortcut.Caption);
    frmMain.Report.FindObject('lblComment').Memo.Text :=
      AnsiUpperCase(lblComment.Caption);
    frmMain.Report.FindObject('lblID').Memo.Text :=
      AnsiUpperCase(VST.Header.Columns[5].Text);
    frmMain.Report.FindObject('lblFooter').Memo.Text :=
      AnsiUpperCase(Application.Title + ' - ' + frmLinks.Caption);

    frmMain.Report.ShowReport;

    VST.SetFocus;

  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmLinks.btnPrintMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
var
  FileName: string;
begin
  FileName := ExtractFileDir(Application.ExeName) + DirectorySeparator +
    'Templates' + DirectorySeparator + 'links.lrf';

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

procedure TfrmLinks.btnSaveClick(Sender: TObject);
begin
  if (btnSave.Enabled = False) then
    Exit;

  // check forbidden chars in the text
  if CheckForbiddenChar(ediName) = True then
    Exit;

  if CheckForbiddenChar(ediLink) = True then
    Exit;

  // check forbidden chars in the text
  if CheckForbiddenChar(memComment) = True then
    Exit;

  try
    if btnSave.Tag = 0 then
      // Add new record
      frmMain.QRY.SQL.Text :=
        'INSERT OR IGNORE INTO links (lin_name, lin_link, lin_shortcut, lin_comment) ' +
          'VALUES (:NAME, :LINK, :SHORTCUT, :COMMENT)'
    else
    begin
      // Edit selected record
      VST.Tag := StrToInt(VST.Text[VST.FocusedNode, 5]);
      frmMain.QRY.SQL.Text :=
        'UPDATE OR IGNORE links SET ' +            // update
        'lin_name = :NAME, ' +            // name
        'lin_link = :LINK, ' + // link
        'lin_shortcut = :SHORTCUT, ' +        // status
        'lin_comment = :COMMENT ' +       // comment
        'WHERE lin_id = :ID;';
      frmMain.QRY.Params.ParamByName('ID').AsInteger := VST.Tag;
    end;

    frmMain.QRY.Params.ParamByName('NAME').AsString := ediName.Text;
    frmMain.QRY.Params.ParamByName('LINK').AsString := ediLink.Text;
    frmMain.QRY.Params.ParamByName('SHORTCUT').AsString :=
      IfThen(chkCtrl.Checked = True, 'Ctrl+', '') +
      IfThen(chkShift.Checked = True, 'Shift+', '') +
      IfThen(chkAlt.Checked = True, 'Alt+', '') +
      cbxShortCut.Items[cbxShortCut.ItemIndex];
    if Length(Trim(memComment.Text)) = 0 then
      frmMain.QRY.Params.ParamByName('COMMENT').Value := NULL
    else
      frmMain.QRY.Params.ParamByName('COMMENT').AsString := Trim(memComment.Text);
    frmMain.QRY.Prepare;
    frmMain.QRY.ExecSQL;
    frmMain.Tran.Commit;

    UpdateLinks;
    btnCancelClick(btnCancel);
    if btnSave.Tag = 0 then
      FindNewRecord(VST, 5)
    else
      FindEditedRecord(VST, 5, VST.Tag);
    VST.SetFocus;

  except
    on E: Exception do
    begin
      btnCancelClick(btnCancel);
      ShowErrorMessage(E);
    end;
  end;
end;

procedure TfrmLinks.btnCopyClick(Sender: TObject);
begin
  if (VST.Enabled = False) or (frmMain.Conn.Connected = False) then
    Exit;
  CopyVST(VST);
end;

procedure TfrmLinks.btnDeleteClick(Sender: TObject);
var
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
        IDs := IDs + VST.Text[N, 5] + ',';
        N := VST.GetNextSelected(N);
      end;
    finally
      IDs := LeftStr(IDs, Length(IDs) - 1);
    end;

    // confirm deleting
    case VST.SelectedCount of
      1: if MessageDlg(Message_00, Question_01 + sLineBreak +
          sLineBreak + VST.Header.Columns[1].Text + ': ' +
          VST.Text[VST.FocusedNode, 1] + sLineBreak + VST.Header.Columns[2].Text +
          ': ' + VST.Text[VST.FocusedNode, 2], mtConfirmation, mbYesNo, 0) <> 6 then
          Exit;
      else
        if MessageDlg(Message_00, AnsiReplaceStr(
          Question_02, '%', IntToStr(VST.SelectedCount)), mtConfirmation,
          mbYesNo, 0) <> 6 then
          Exit;
    end;

    frmMain.QRY.SQL.Text := 'DELETE FROM links WHERE lin_id IN (' + IDs + ')';
    frmMain.QRY.ExecSQL;
    frmMain.Tran.Commit;

    UpdateLinks;

  except
    on E: Exception do
      ShowErrorMessage(E);
  end;

end;

procedure TfrmLinks.btnEditClick(Sender: TObject);
begin
  if (VST.Enabled = False) or (VST.SelectedCount = 0) or
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

procedure TfrmLinks.btnAddClick(Sender: TObject);
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
    ediName.Clear;
    ediLink.Clear;
    chkCtrl.Checked := False;
    chkAlt.Checked := False;
    chkShift.Checked := False;
    cbxShortCut.ItemIndex := -1;
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

procedure TfrmLinks.btnCancelClick(Sender: TObject);
begin
  try
    // panel Detail
    pnlDetail.Enabled := False;
    pnlDetail.Color := clDefault;
    pnlDetailCaption.Caption := AnsiUpperCase(Caption_43);

    // disabled menu
    pnlButtons.Visible := True;
    pnlButton.Visible := False;

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

procedure TfrmLinks.btnSelectClick(Sender: TObject);
begin
  if (VST.Enabled = False) or (VST.RootNodeCount < 1) or
    (frmMain.Conn.Connected = False) then
    Exit;
  VST.SelectAll(False);
  VST.SetFocus;
end;

procedure TfrmLinks.chkCtrlEnter(Sender: TObject);
begin
  (Sender as TCheckBox).Font.Bold := True;
end;

procedure TfrmLinks.chkCtrlExit(Sender: TObject);
begin
  (Sender as TCheckBox).Font.Bold := False;
end;

procedure TfrmLinks.ediNameChange(Sender: TObject);
begin
  btnSave.Enabled := (Length(ediName.Text) > 0) and (Length(ediLink.Text) > 0) and
    (cbxShortCut.ItemIndex > -1);
end;

procedure TfrmLinks.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  if pnlButton.Visible = True then
  begin
    btnCancelClick(btnCancel);
    CloseAction := Forms.caNone;
    Exit;
  end;
end;

procedure TfrmLinks.FormCreate(Sender: TObject);
begin
  try
    chkCtrl.Caption := 'Ctrl';
    chkAlt.Caption := 'Alt';
    chkShift.Caption := 'Shift';
    cbxShortCut.Items.AddCommaText(
      'F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,F11,F12,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z');
    cbxShortCut.ItemIndex := -1;

    // set components height
    VST.Header.Height := PanelHeight;
    pnlDetailCaption.Height := PanelHeight;
    pnlListCaption.Height := PanelHeight;
    pnlButtons.Height := ButtonHeight;
    pnlButton.Height := ButtonHeight;
    pnlBottom.Height := ButtonHeight;

    // get form icon
  frmMain.img16.GetIcon(31, (Sender as TForm).Icon);
  finally
  end;
end;

procedure TfrmLinks.pnlButtonsResize(Sender: TObject);
begin
  btnEdit.Width := (pnlButtons.Width - 14) div 7;
  btnDelete.Width := btnEdit.Width;
  btnCopy.Width := btnEdit.Width;
  btnPrint.Width := btnEdit.Width;
  btnExit.Width := btnEdit.Width;
  btnSelect.Width := btnEdit.Width;
  pnlButtons.Repaint;
end;

procedure TfrmLinks.splListCanResize(Sender: TObject; var NewSize: integer;
  var Accept: boolean);
begin
  imgWidth.ImageIndex := 3;
  lblWidth.Caption := IntToStr(frmLinks.Width - pnlDetail.Width);

  imgHeight.ImageIndex := 2;
  lblHeight.Caption := IntToStr(pnlDetail.Width);

  pnlListCaption.Repaint;
  pnlDetailCaption.Repaint;
  pnlButton.Repaint;
end;

procedure TfrmLinks.VSTBeforeCellPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
begin
  TargetCanvas.Brush.Color := IfThen(Node.Index mod 2 = 0, clWhite,
    frmSettings.pnlOddRowColor.Color);
  TargetCanvas.FillRect(CellRect);
end;

procedure TfrmLinks.VSTChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
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
      ediLink.Clear;
      chkAlt.Checked := False;
      chkCtrl.Checked := False;
      chkShift.Checked := False;
      cbxShortCut.ItemIndex := -1;
      memComment.Clear;
      Exit;
    end;

    if (VST.SelectedCount = 1) then
    begin
      ediName.Text := VST.Text[VST.GetFirstSelected(False), 1];
      ediLink.Text := VST.Text[VST.GetFirstSelected(False), 2];
      chkCtrl.Checked := AnsiLowerCase(Field('+', VST.Text[VST.GetFirstSelected(), 3],
        1)) = 'ctrl';
      chkShift.Checked :=
        (AnsiLowerCase(Field('+', VST.Text[VST.GetFirstSelected(), 3], 1)) = 'shift') or
        (AnsiLowerCase(Field('+', VST.Text[VST.GetFirstSelected(), 3], 2)) = 'shift');
      chkAlt.Checked :=
        (AnsiLowerCase(Field('+', VST.Text[VST.GetFirstSelected(), 3], 1)) = 'alt') or
        (AnsiLowerCase(Field('+', VST.Text[VST.GetFirstSelected(), 3], 2)) = 'alt') or
        (AnsiLowerCase(Field('+', VST.Text[VST.GetFirstSelected(), 3], 3)) = 'alt');
      cbxShortCut.ItemIndex :=
        cbxShortCut.Items.IndexOf(
        Field('+', ReverseString(VST.Text[VST.GetFirstSelected(), 3]), 1));
      memComment.Text := VST.Text[VST.GetFirstSelected(False), 4];
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmLinks.VSTDblClick(Sender: TObject);
begin
  if frmMain.Conn.Connected = False then Exit;

  if VST.SelectedCount = 1 then
    btnEditClick(btnEdit)
  else if VST.SelectedCount = 0 then
    btnAddClick(btnAdd);
end;

procedure TfrmLinks.VSTGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: boolean; var ImageIndex: integer);
begin
  if Column = 0 then
    ImageIndex := 31;
end;

procedure TfrmLinks.VSTGetNodeDataSize(Sender: TBaseVirtualTree;
  var NodeDataSize: integer);
begin
  NodeDataSize := SizeOf(TLink);
end;

procedure TfrmLinks.VSTGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
var
  Link: PLink;
begin
  Link := Sender.GetNodeData(Node);
  try
    case Column of
      1: CellText := Link.Name;
      2: CellText := Link.Link;
      3: CellText := Link.ShortCut;
      4: CellText := Link.Comment;
      5: CellText := IntToStr(Link.ID);
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmLinks.VSTResize(Sender: TObject);
var
  X: integer;
begin
  if frmSettings.chkAutoColumnWidth.Checked = False then Exit;

  (Sender as TLazVirtualStringTree).Header.Columns[0].Width :=
    Round(ScreenRatio * 25 / 100);
  X := (VST.Width - VST.Header.Columns[0].Width) div 100;

  VST.Header.Columns[1].Width := 15 * X; // name
  VST.Header.Columns[2].Width :=
    VST.Width - ScrollBarWidth - VST.Header.Columns[0].Width - (70 * X); // link
  VST.Header.Columns[3].Width := 20 * X; // shortcut
  VST.Header.Columns[4].Width := 30 * X; // comment
  VST.Header.Columns[5].Width := 5 * X; // ID
end;

procedure UpdateLinks;
var
  Link: PLink;
  P: PVirtualNode;
  T: TMenuItem;
begin
  try
    frmLinks.VST.Clear;
    frmLinks.VST.RootNodeCount := 0;

    while frmMain.mnuLinks.Count > 2 do
      frmMain.mnuLinks.Items[2].Free;

    // =============================================================================================
    // update list of Links in form Links
    if frmMain.Conn.Connected = False then
      Exit;

    screen.Cursor := crHourGlass;
    frmLinks.VST.BeginUpdate;

    frmMain.QRY.SQL.Text :=
      'SELECT lin_name, lin_link, lin_shortcut, lin_comment, lin_ID FROM links';
    frmMain.QRY.Open;
    while not (frmMain.QRY.EOF) do
    begin
      frmLinks.VST.RootNodeCount := frmLinks.VST.RootNodeCount + 1;
      P := frmLinks.VST.GetLast();
      Link := frmLinks.VST.GetNodeData(P);
      Link.Name := frmMain.QRY.Fields[0].AsString;
      Link.Link := frmMain.QRY.Fields[1].AsString;
      Link.Shortcut := frmMain.QRY.Fields[2].AsString;
      Link.Comment := frmMain.QRY.Fields[3].AsString;
      Link.ID := frmMain.QRY.Fields[4].AsInteger;

      T := TMenuItem.Create(frmMain.mnuLinks);
      T.Caption := Link.Name;
      T.Hint := Link.Link;
      T.ShortCut := TextToShortCut(Link.ShortCut);
      T.OnClick := @frmMain.ExternalLinkClick;
      T.ImageIndex := 31;
      frmMain.mnuLinks.Add(T);

      frmMain.QRY.Next;
    end;
    frmMain.QRY.Close;

    frmLinks.VST.SortTree(1, sdAscending);

  finally
    frmLinks.VST.EndUpdate;
    screen.Cursor := crDefault;
  end;

  // popup
  frmLinks.popCopy.Enabled := frmLinks.VST.RootNodeCount > 0;
  frmLinks.btnCopy.Enabled := frmLinks.popCopy.Enabled;
  frmLinks.btnSelect.Enabled := frmLinks.VST.RootNodeCount > 0;
  frmLinks.popPrint.Enabled := frmLinks.popCopy.Enabled;
  frmLinks.btnPrint.Enabled := frmLinks.popCopy.Enabled;
  frmLinks.popEdit.Enabled := False;
  frmLinks.btnEdit.Enabled := False;
  frmLinks.popDelete.Enabled := False;
  frmLinks.btnDelete.Enabled := False;

  // items icon
  frmLinks.lblItems.Caption := IntToStr(frmLinks.VST.RootNodeCount);

end;

end.
