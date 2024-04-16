unit uniTags;

{$mode objfpc}{$H+}
{$ModeSwitch AutoDeref}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Clipbrd, Math, ExtCtrls, ComCtrls, Buttons, Menus, ActnList, LazUTF8,
  BCPanel, BCMDButtonFocus, laz.VirtualTrees, StrUtils, IniFiles;

type
  TTagg = record
    Name: String;
    Comment: String;
    Time: String;
    ID: Integer;
  end;
  PTagg = ^TTagg;

type

  { TfrmTags }

  TfrmTags = class(TForm)
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
    ediName: TEdit;
    imgHeight: TImage;
    imgItem: TImage;
    imgItems: TImage;
    imgWidth: TImage;
    lblHeight: TLabel;
    lblItems: TLabel;
    lblName: TLabel;
    lblWidth: TLabel;
    lblComment: TLabel;
    lblItem: TLabel;
    memComment: TMemo;
    popSelect: TMenuItem;
    MenuItem3: TMenuItem;
    pnlButton: TPanel;
    pnlButtons: TPanel;
    pnlDetailCaption: TBCPanel;
    pnlListCaption: TBCPanel;
    pnlName: TPanel;
    popAdd: TMenuItem;
    pnlComment: TPanel;
    pnlList: TPanel;
    pnlDetail: TPanel;
    pnlItems: TPanel;
    pnlBottom: TPanel;
    pnlHeight: TPanel;
    pnlWidth: TPanel;
    pnlItem: TPanel;
    popCopy: TMenuItem;
    popDelete: TMenuItem;
    popEdit: TMenuItem;
    popExit: TMenuItem;
    popList: TPopupMenu;
    popPrint: TMenuItem;
    splList: TSplitter;
    VST: TLazVirtualStringTree;
    procedure btnCancelClick(Sender: TObject);
    procedure btnCopyClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure btnPrintMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure btnSaveClick(Sender: TObject);
    procedure btnSelectClick(Sender: TObject);
    procedure ediNameEnter(Sender: TObject);
    procedure ediNameExit(Sender: TObject);
    procedure ediNameKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure memCommentEnter(Sender: TObject);
    procedure memCommentExit(Sender: TObject);
    procedure memCommentKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure btnAddClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure ediNameChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure pnlButtonResize(Sender: TObject);
    procedure pnlButtonsResize(Sender: TObject);
    procedure pnlDetailCaptionResize(Sender: TObject);
    procedure pnlListCaptionResize(Sender: TObject);
    procedure splListCanResize(Sender: TObject);
    procedure VSTBeforeCellPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
    procedure VSTCompareNodes(Sender: TBaseVirtualTree; Node1, Node2: PVirtualNode; Column: TColumnIndex;
      var Result: Integer);
    procedure VSTGetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Kind: TVTImageKind; Column: TColumnIndex; var Ghosted: boolean;
      var ImageIndex: integer);
    procedure VSTGetNodeDataSize(Sender: TBaseVirtualTree; var NodeDataSize: Integer);
    procedure VSTGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure VSTChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure VSTDblClick(Sender: TObject);
    procedure VSTResize(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmTags: TfrmTags;

procedure UpdateTags;

implementation

{$R *.lfm}

uses
  uniMain, uniSettings, uniScheduler, uniProperties, uniDetail, uniEdit,
  uniResources, uniEdits;

{ TfrmTags }

procedure TfrmTags.FormCreate(Sender: TObject);
begin
  try
    // images
    VST.Images := frmMain.img16;
    popList.Images := frmMain.imgButtons;
    imgHeight.Images := frmMain.imgSize;
    imgWidth.Images := frmMain.imgSize;
    imgItem.Images := frmMain.imgSize;
    imgItems.Images := frmMain.imgSize;

    // get form icon
    frmMain.img16.GetIcon(11, (Sender as TForm).Icon);

    // set components height
    VST.Header.Height := PanelHeight;
    pnlDetailCaption.Height := PanelHeight;
    pnlListCaption.Height := PanelHeight;
    pnlButtons.Height := ButtonHeight;
    pnlButton.Height := ButtonHeight;
    pnlBottom.Height := ButtonHeight;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmTags.btnAddClick(Sender: TObject);
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


procedure TfrmTags.btnEditClick(Sender: TObject);
begin
  if (VST.Enabled = False) or (VST.SelectedCount <> 1) or (frmMain.Conn.Connected = False) then
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
    // pnlTools.Visible := True;

    // disabled ActionList
    actAdd.Enabled := False;
    actEdit.Enabled := False;
    actDelete.Enabled := False;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmTags.btnCancelClick(Sender: TObject);
begin
  try
    // enabled TDBGrid
    VST.Enabled := True;
    VST.SetFocus;

    // panel Detail
    pnlDetail.Enabled := False;
    pnlDetail.Color := clDefault;
    pnlDetailCaption.Caption := AnsiUpperCase(Caption_43);

    // disabled menu
    pnlButtons.Visible := True;
    pnlButton.Visible := False;

    // disabled buttons
    //pnlStamp.Visible := True;

    ediName.Clear;
    memComment.Clear;
    //txtStamp.Caption := '';

    // enabled ActionList
    actAdd.Enabled := True;
    actEdit.Enabled := True;
    actDelete.Enabled := True;

  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmTags.ediNameEnter(Sender: TObject);
begin
  ediName.Font.Bold := True;
end;

procedure TfrmTags.btnCopyClick(Sender: TObject);
begin
  if (VST.Enabled = False) or (VST.RootNodeCount = 0) then
    Exit;
  CopyVST(VST);
end;

procedure TfrmTags.btnPrintClick(Sender: TObject);
var
 FileName: String;

begin
  if btnPrint.Enabled = False then Exit;

  FileName := ExtractFileDir(Application.ExeName) + DirectorySeparator + 'Templates' +
     DirectorySeparator + 'tags.lrf';

  if FileExists(FileName) = False then
  begin
   ShowMessage(Error_14 + sLineBreak + FileName);
   Exit;
  end;

  // left mouse button = show report
  try
    frmMain.Report.LoadFromFile(FileName);
    frmMain.Report.FindObject('lblName').Memo.Text := AnsiUpperCase(lblName.Caption);
    frmMain.Report.FindObject('lblComment').Memo.Text :=
      AnsiUpperCase(lblComment.Caption);
    frmMain.Report.FindObject('lblID').Memo.Text :=
      AnsiUpperCase(VST.Header.Columns[3].Text);
    frmMain.Report.FindObject('lblFooter').Memo.Text :=
      AnsiUpperCase(Application.Title + ' - ' + frmTags.Caption);

    frmMain.Report.Tag := 16;
    frmMain.Report.ShowReport;
    VST.SetFocus;
  except
  on E: Exception do
    ShowErrorMessage(E);
  end;
end;

procedure TfrmTags.btnPrintMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
 FileName: String;

begin
  FileName := ExtractFileDir(Application.ExeName) + DirectorySeparator + 'Templates' +
     DirectorySeparator + 'tags.lrf';

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

procedure TfrmTags.btnSelectClick(Sender: TObject);
begin
  if (VST.Enabled = False) or (VST.RootNodeCount < 1) or (frmMain.Conn.Connected = False) then
    Exit;
  VST.SelectAll(False);
  VST.SetFocus;
end;

procedure TfrmTags.ediNameExit(Sender: TObject);
begin
  ediName.Font.Bold := False;
end;

procedure TfrmTags.ediNameKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  btnSave.Enabled := Length(ediName.Text) > 0;
  if (Key = 13) and (memComment.Enabled = True) then
  begin
    Key := 0;
    memComment.SetFocus;
  end;
end;

procedure TfrmTags.VSTChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
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
        lblItem.Caption := IntToStr(VST.GetFirstSelected().Index + 1) + '.';
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
      memComment.Clear;
      Exit;
    end;

    if (VST.SelectedCount = 1) then
    begin
      ediName.Text := VST.Text[VST.GetFirstSelected(False), 1];
      memComment.Text := ReplaceStr(VST.Text[VST.GetFirstSelected(False), 2],
        '☼', sLineBreak);
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmTags.memCommentEnter(Sender: TObject);
begin
  try
    memComment.Font.Bold := True;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmTags.memCommentExit(Sender: TObject);
begin
  try
    memComment.Font.Bold := False;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmTags.memCommentKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
//  var
//   prm: TFontParams;
begin
  if Key = 13 then
  begin
    Key := 0;
    if btnSave.Enabled = True then
      btnSave.SetFocus
    else
      ediName.SetFocus;
  end;
end;

procedure TfrmTags.btnDeleteClick(Sender: TObject);
var
  IDs: string;
  N: PVirtualNode;

begin
  try
    if (frmMain.Conn.Connected = False) or (VST.SelectedCount = 0) or (frmMain.Conn.Connected = False) then
      exit;

    // get IDs of all selected nodes
    IDs := '';
    N := VST.GetFirstSelected(False);
    try
      while Assigned(N) do
      begin
        IDs := IDs + VST.Text[N, 3] + ',';
        N := VST.GetNextSelected(N);
      end;
    finally
      IDs := LeftStr(IDs, Length(IDs) - 1);
    end;

    // confirm deleting
    case VST.SelectedCount of
      1: if MessageDlg(Message_00, Question_01 + sLineBreak +
          sLineBreak + VST.Header.Columns[1].Text + ': ' + VST.Text[VST.FocusedNode, 1],
          mtConfirmation, mbYesNo, 0) <> 6 then
          Exit;
      else
        if MessageDlg(Message_00, AnsiReplaceStr(
          Question_02, '%', IntToStr(VST.SelectedCount)), mtConfirmation,
          mbYesNo, 0) <> 6 then
          Exit;
    end;

    frmMain.QRY.SQL.Text := 'DELETE FROM tags WHERE tag_id IN (' + Ids + ');';
    frmMain.QRY.ExecSQL;
    frmMain.Tran.Commit;
    UpdateTags;

  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmTags.btnSaveClick(Sender: TObject);
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
    // Add new record
    if btnSave.Tag = 0 then
      frmMain.QRY.SQL.Text :=
        'INSERT OR IGNORE INTO tags (tag_name, tag_comment) VALUES (:NAME, :COMMENT);'
    else
    begin
      // Edit selected record
      VST.Tag := StrToInt(VST.Text[VST.GetFirstSelected(False), 3]);
      frmMain.QRY.SQL.Text :=
        'UPDATE OR IGNORE tags SET tag_name = :NAME, tag_comment = :COMMENT WHERE tag_id = :ID;';
      frmMain.QRY.Params.ParamByName('ID').AsInteger := VST.Tag;
    end;

    frmMain.QRY.Params.ParamByName('NAME').AsString := ediName.Text;
    frmMain.QRY.Params.ParamByName('COMMENT').AsString := Trim(memComment.Text);
    frmMain.QRY.Prepare;
    frmMain.QRY.ExecSQL;
    frmMain.Tran.Commit;

    UpdateTags;
    btnCancelClick(btnCancel);

    if btnSave.Tag = 0 then
      FindNewRecord(VST, 3)
    else
      FindEditedRecord(VST, 3, VST.Tag);
    VST.SetFocus;

  except
    on E: Exception do
    begin

      btnCancelClick(btnCancel);
      ShowErrorMessage(E);
    end;
  end;
end;

procedure TfrmTags.VSTDblClick(Sender: TObject);
begin
  if frmMain.Conn.Connected = False then Exit;

  if VST.SelectedCount = 1 then
    btnEditClick(btnEdit)
  else
    btnAddClick(btnAdd);
end;

procedure TfrmTags.pnlButtonResize(Sender: TObject);
begin
  btnCancel.Width := (pnlButton.Width - 6) div 2;
end;

procedure TfrmTags.pnlButtonsResize(Sender: TObject);
begin
  btnEdit.Width := (pnlButtons.Width - 10) div 7;
  btnDelete.Width := btnEdit.Width;
  btnCopy.Width := btnEdit.Width;
  btnPrint.Width := btnEdit.Width;
  btnExit.Width := btnEdit.Width;
  btnSelect.Width := btnEdit.Width;
  pnlButtons.Repaint;
end;

procedure TfrmTags.pnlDetailCaptionResize(Sender: TObject);
begin
  pnlDetailCaption.Repaint;
end;

procedure TfrmTags.pnlListCaptionResize(Sender: TObject);
begin
  pnlListCaption.Repaint;
end;

procedure TfrmTags.splListCanResize(Sender: TObject);
begin
  imgWidth.ImageIndex := 3;
  lblWidth.Caption := IntToStr(frmTags.Width - pnlDetail.Width);

  imgHeight.ImageIndex := 2;
  lblHeight.Caption := IntToStr(pnlDetail.Width);

  pnlListCaption.Repaint;
  pnlDetailCaption.Repaint;
  pnlButton.Repaint;
end;

procedure TfrmTags.VSTBeforeCellPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
begin
  TargetCanvas.Brush.Color := IfThen(Node.Index mod 2 = 0, clWhite,
    frmSettings.pnlOddRowColor.Color);
  TargetCanvas.FillRect(CellRect);
end;

procedure TfrmTags.VSTCompareNodes(Sender: TBaseVirtualTree; Node1, Node2: PVirtualNode; Column: TColumnIndex;
  var Result: Integer);
var
  Data1, Data2: PTagg;

begin
  Data1 := Sender.GetNodeData(Node1);
  Data2 := Sender.GetNodeData(Node2);
  case Column of
    1: Result := UTF8CompareText(Data1.Name, Data2.Name);
  end;
end;

procedure TfrmTags.VSTGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: boolean; var ImageIndex: integer);
begin
  if Column = 0 then
    ImageIndex := 11;
end;

procedure TfrmTags.VSTGetNodeDataSize(Sender: TBaseVirtualTree; var NodeDataSize: Integer);
begin
  NodeDataSize := SizeOf(TTagg);
end;

procedure TfrmTags.VSTGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
var
  Tagg: PTagg;

begin
  Tagg := Sender.GetNodeData(Node);
  try
    case Column of
      1: CellText := Tagg.Name;
      2: CellText := Tagg.Comment;
      3: CellText := IntToStr(Tagg.ID);
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmTags.VSTResize(Sender: TObject);
var
  X: integer;

begin
  if frmSettings.chkAutoColumnWidth.Checked = False then Exit;

  (Sender as TLazVirtualStringTree).Header.Columns[0].Width :=
    round(ScreenRatio * 25 / 100);
  X := (VST.Width - VST.Header.Columns[0].Width) div 100;
  VST.Header.Columns[1].Width := 40 * X; // name
  VST.Header.Columns[2].Width := VST.Width - VST.Header.Columns[0].Width - ScrollBarWidth - (50 * X); // comment
  VST.Header.Columns[3].Width := 10 * X; // ID
end;

procedure TfrmTags.btnExitClick(Sender: TObject);
begin
  frmTags.Close;
end;

procedure TfrmTags.ediNameChange(Sender: TObject);
begin
  btnSave.Enabled := Length(ediName.Text) > 0;
end;

procedure TfrmTags.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var
  INI: TINIFile;
  INIFile: string;

begin
  try
    if pnlButton.Visible = True then
    begin
      btnCancelClick(btnCancel);
      CloseAction := Forms.caNone;
      Exit;
    end;

    // write position and window size
    if frmSettings.chkLastFormsSize.Checked = True then
    begin
      try
        INIFile := ChangeFileExt(ParamStr(0), '.ini');
        INI := TINIFile.Create(INIFile);
        if INI.ReadString('POSITION', frmTags.Name, '') <>
          IntToStr(frmTags.Left) + separ + // form left
        IntToStr(frmTags.Top) + separ + // form top
        IntToStr(frmTags.Width) + separ + // form width
        IntToStr(frmTags.Height) + separ + // form height
        IntToStr(frmTags.pnlDetail.Width) then
          INI.WriteString('POSITION', frmTags.Name,
            IntToStr(frmTags.Left) + separ + // form left
            IntToStr(frmTags.Top) + separ + // form top
            IntToStr(frmTags.Width) + separ + // form width
            IntToStr(frmTags.Height) + separ + // form height
            IntToStr(frmTags.pnlDetail.Width));
      finally
        INI.Free;
      end;
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmTags.FormResize(Sender: TObject);
begin
  imgWidth.ImageIndex := 0;
  lblWidth.Caption := IntToStr(frmTags.Width);
  imgHeight.ImageIndex := 1;
  lblHeight.Caption := IntToStr(frmTags.Height);

  pnlButtons.Repaint;
  pnlButton.Repaint;
  pnlListCaption.Repaint;
  pnlDetailCaption.Repaint;
end;

procedure TfrmTags.FormShow(Sender: TObject);
var
  INI: TINIFile;
  S: string;
  I: integer;
begin
  // ********************************************************************
  // FORM SIZE START
  // ********************************************************************
  try
    S := ChangeFileExt(ParamStr(0), '.ini');
    // INI file READ procedure (if file exists) =========================
    if FileExists(S) = True then
    begin
      INI := TINIFile.Create(S);
      frmTags.Position := poDesigned;
      S := INI.ReadString('POSITION', frmTags.Name, '-1•-1•0•0•200');

      // width
      TryStrToInt(Field(Separ, S, 3), I);
      if (I < 1) or (I > Screen.Width) then
        frmTags.Width := Screen.Width - 600 - (200 - ScreenRatio)
      else
        frmTags.Width := I;

      /// height
      TryStrToInt(Field(Separ, S, 4), I);
      if (I < 1) or (I > Screen.Height) then
        frmTags.Height := Screen.Height - 400 - (200 - ScreenRatio)
      else
        frmTags.Height := I;

      // left
      TryStrToInt(Field(Separ, S, 1), I);
      if (I < 0) or (I > Screen.Width) then
        frmTags.left := (Screen.Width - frmTags.Width) div 2
      else
        frmTags.Left := I;

      // top
      TryStrToInt(Field(Separ, S, 2), I);
      if (I < 0) or (I > Screen.Height) then
        frmTags.Top := ((Screen.Height - frmTags.Height) div 2) - 75
      else
        frmTags.Top := I;

      // detail panel
      TryStrToInt(Field(Separ, S, 5), I);
      if (I < 100) or (I > 300) then
        frmTags.pnlDetail.Width := 220
      else
        frmTags.pnlDetail.Width := I;
    end;
  finally
    INI.Free
  end;
  // ********************************************************************
  // FORM SIZE END
  // ********************************************************************

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
  VST.ClearSelection;
  VST.SetFocus;
end;

procedure UpdateTags;
var
  Tagg: PTagg;
  P: PVirtualNode;

begin
  try
    frmTags.VST.Clear;
    frmTags.VST.RootNodeCount := 0;

    // =============================================================================================
    // update list of Tags in form Tags
    if frmMain.Conn.Connected = False then
      exit;

    screen.Cursor := crHourGlass;
    frmTags.VST.BeginUpdate;

    frmMain.QRY.SQL.Text := 'SELECT tag_name, tag_comment, tag_time, tag_ID FROM tags;';
    frmMain.QRY.Open;
    while not (frmMain.QRY.EOF) do
    begin
      frmTags.VST.RootNodeCount := frmTags.VST.RootNodeCount + 1;
      P := frmTags.VST.GetLast();
      Tagg := frmTags.VST.GetNodeData(P);
      Tagg.Name := frmMain.QRY.Fields[0].AsString;
      Tagg.Comment := frmMain.QRY.Fields[1].AsString;
      Tagg.Time := frmMain.QRY.Fields[2].AsString;
      Tagg.ID := frmMain.QRY.Fields[3].AsInteger;

      frmMain.QRY.Next;
    end;
    frmMain.QRY.Close;

    frmTags.VST.SortTree(1, sdAscending);
    frmTags.VST.EndUpdate;
    screen.Cursor := crDefault;

    // =============================================================================================
    // frmMain update list
    frmDetail.lbxTag.Clear;
    for P in frmTags.VST.Nodes(False) do
      frmDetail.lbxTag.Items.Add(frmTags.VST.Text[P, 1]);

    frmMain.cbxTag.Items := frmDetail.lbxTag.Items;
    frmMain.cbxTag.Items.Insert(0, '*');
    frmMain.cbxTag.ItemIndex := 0;

    // =============================================================================================
    // frmScheduler update list
    frmScheduler.lbxTag.Clear;
    frmScheduler.lbxTag.Items := frmDetail.lbxTag.Items;

    // =============================================================================================
    // frmMultiple addtitions
    frmDetail.lbxTagsX.Clear;
    frmDetail.lbxTagsX.Items := frmDetail.lbxTag.Items;

    // =============================================================================================
    // frmEdit update list
    frmEdit.lbxTag.Clear;
    frmEdit.lbxTag.Items := frmDetail.lbxTag.Items;

    // =============================================================================================
    // frmEdits update list
    frmEdits.lbxTag.Clear;
    frmEdits.lbxTag.Items := frmDetail.lbxTag.Items;

    // =============================================================================================
    // items icon
    frmTags.lblItems.Caption := IntToStr(frmTags.VST.RootNodeCount);

    frmTags.popCopy.Enabled := frmTags.VST.RootNodeCount > 0;
    frmTags.btnCopy.Enabled := frmTags.popCopy.Enabled;
    frmTags.btnSelect.Enabled := frmTags.VST.RootNodeCount > 0;
    frmTags.popPrint.Enabled := frmTags.popCopy.Enabled;
    frmTags.btnPrint.Enabled := frmTags.popCopy.Enabled;
    frmTags.popEdit.Enabled := False;
    frmTags.btnEdit.Enabled := False;
    frmTags.popDelete.Enabled := False;
    frmTags.btnDelete.Enabled := False;

    if (frmTags.Visible = True) and (frmTags.VST.Enabled = True) then
      frmTags.VST.SetFocus;

    if frmProperties.Visible = True then
      frmProperties.FormShow(frmProperties);
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

end.
