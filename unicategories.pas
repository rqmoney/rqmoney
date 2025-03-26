unit uniCategories;

{$mode objfpc}{$H+}
{$ModeSwitch AutoDeref}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ComCtrls, ExtCtrls, Buttons, Menus, StrUtils, Math, DB, sqldb, LCLProc,
  LCLType, DBGrids, DBCtrls, LazUTF8, laz.VirtualTrees, Clipbrd, ActnList,
  BCPanel, BCMDButtonFocus, Variants;

type
  TCategory = record
    Name: string;
    Comment: string;
    Status: integer;
    Parent_ID: integer;
    Parent_name: string;
    Time: string;
    Kind: integer;
    Energy: integer;
    ID: integer;
  end;
  PCategory = ^TCategory;

type

  { TfrmCategories }

  TfrmCategories = class(TForm)
    actAdd: TAction;
    actCopy: TAction;
    actDelete: TAction;
    actEdit: TAction;
    actExit: TAction;
    actCollapseAll: TAction;
    actCollapseOne: TAction;
    actExpandAll: TAction;
    actExpandOne: TAction;
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
    btnMenu: TBitBtn;
    btnPrint: TBCMDButtonFocus;
    btnSave: TBCMDButtonFocus;
    btnSelect: TBCMDButtonFocus;
    btnStatusInfo: TImage;
    cbxEnergy: TComboBox;
    cbxStatus: TComboBox;
    cbxType: TComboBox;
    cbxTo: TComboBox;
    cbxKind: TComboBox;
    imgList: TImageList;
    lblComment: TLabel;
    ediName: TEdit;
    imgHeight: TImage;
    imgItem: TImage;
    imgItems: TImage;
    imgWidth: TImage;
    lblEnergy: TLabel;
    lblHeight: TLabel;
    lblItem: TLabel;
    lblItems: TLabel;
    lblName: TLabel;
    lblStatus: TLabel;
    lblTo: TLabel;
    lblKind: TLabel;
    lblType: TLabel;
    lblWidth: TLabel;
    memComment: TMemo;
    pnlEnergy: TPanel;
    pnlTip: TPanel;
    pnlKind: TPanel;
    popExpandOne: TMenuItem;
    popCollapseOne: TMenuItem;
    popExpandAll: TMenuItem;
    popCollapseAll: TMenuItem;
    popSelect: TMenuItem;
    pnlButton: TPanel;
    pnlButtons: TPanel;
    pnlDetailCaption: TBCPanel;
    pnlListCaption: TBCPanel;
    popPrint: TMenuItem;
    MenuItem4: TMenuItem;
    pnlTop: TPanel;
    pnlComment: TPanel;
    pnlStatus: TPanel;
    pnlCategory: TPanel;
    pnlDetail: TPanel;
    pnlHeight: TPanel;
    pnlItem: TPanel;
    pnlItems: TPanel;
    pnlList: TPanel;
    pnlStatusTop: TPanel;
    pnlBottom: TPanel;
    pnlWidth: TPanel;
    popAdd: TMenuItem;
    popCopy: TMenuItem;
    popDelete: TMenuItem;
    popEdit: TMenuItem;
    popExit: TMenuItem;
    popList: TPopupMenu;
    popMenu: TPopupMenu;
    Separator1: TMenuItem;
    splList: TSplitter;
    VST: TLazVirtualStringTree;
    procedure btnCopyClick(Sender: TObject);
    procedure btnMenuClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure btnPrintMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure btnSelectClick(Sender: TObject);
    procedure cbxEnergyKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure cbxKindKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure cbxStatusKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure cbxToKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure cbxTypeKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure ediNameExit(Sender: TObject);
    procedure ediNameEnter(Sender: TObject);
    procedure ediNameKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure memCommentKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure btnCancelClick(Sender: TObject);
    procedure pnlButtonResize(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure cbxTypeChange(Sender: TObject);
    procedure ediNameChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure pnlButtonsResize(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure popCollapseAllClick(Sender: TObject);
    procedure popCollapseOneClick(Sender: TObject);
    procedure popExpandAllClick(Sender: TObject);
    procedure popExpandOneClick(Sender: TObject);
    procedure splListCanResize(Sender: TObject; var NewSize: integer;
      var Accept: boolean);
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
  frmCategories: TfrmCategories;

  //  slPrintCategories: TStringList;

procedure UpdateCategories;

implementation

{$R *.lfm}

uses
  uniMain, uniSettings, uniProperties, uniDetail, uniDelete, uniResources, uniBudget;

  { TfrmCategories }

procedure TfrmCategories.FormCreate(Sender: TObject);
begin
  try
    // cbxStatus
    frmCategories.cbxStatus.Clear;
    frmCategories.cbxStatus.Items.Add(Caption_55); // active
    frmCategories.cbxStatus.Items.Add(Caption_57); // passive
    frmCategories.cbxStatus.Items.Add(Caption_59); // archive

    // set components height
    VST.Header.Height := PanelHeight;
    pnlDetailCaption.Height := PanelHeight;
    pnlListCaption.Height := PanelHeight;
    pnlButtons.Height := ButtonHeight;
    pnlButton.Height := ButtonHeight;
    pnlBottom.Height := ButtonHeight;

    // get form icon
    frmMain.img16.GetIcon(16, (Sender as TForm).Icon);
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmCategories.btnAddClick(Sender: TObject);
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

    /// disabled menu
    pnlButtons.Visible := False;
    pnlButton.Visible := True;

    actCollapseAll.Enabled := False;
    actExpandAll.Enabled := False;
    actCollapseOne.Enabled := False;
    actExpandOne.Enabled := False;
    btnMenu.Enabled := False;

    // enabled buttons
    btnSave.Enabled := False;
    btnSave.Tag := 0;

    ediName.Clear;
    memComment.Clear;
    if cbxStatus.ItemIndex = -1 then
      cbxStatus.ItemIndex := 0;
    cbxKind.ItemIndex := 0;

    //pnlStamp.Visible := False;

    if VST.RootNodeCount = 0 then
    begin
      cbxType.Enabled := False;
      cbxType.ItemIndex := 0;
      cbxTypeChange(cbxType);
      cbxTo.Visible := False;
      ediName.SetFocus;
    end
    else
    begin
      cbxType.Enabled := True;
      cbxType.SetFocus;
      //cbxType.DroppedDown := True;

      if cbxType.ItemIndex = 1 then
      begin
        cbxTo.Visible := True;
        lblTo.Caption := Caption_61;
      end
      else
      begin
        cbxTo.Visible := False;
        lblTo.Caption := '';
      end;
    end;

    // cbxenergy
    cbxEnergy.ItemIndex := 1;

    // disabled ActionList
    actAdd.Enabled := False;
    actEdit.Enabled := False;
    actDelete.Enabled := False;

    if cbxType.ItemIndex = -1 then
      cbxType.ItemIndex := 0;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmCategories.btnEditClick(Sender: TObject);
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

    actCollapseAll.Enabled := False;
    actExpandAll.Enabled := False;
    actCollapseOne.Enabled := False;
    actExpandOne.Enabled := False;
    btnMenu.Enabled := False;

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

procedure TfrmCategories.popCollapseAllClick(Sender: TObject);
begin
  VST.FullCollapse();
  //frmCategories.Caption := 'Collapse';
end;

procedure TfrmCategories.popCollapseOneClick(Sender: TObject);
var
  N: PVirtualNode;
begin
  N := VST.GetFirstSelected();
  if VST.GetNodeLevel(N) = 1 then
    N := N.Parent;
  VST.ClearSelection;
  VST.Expanded[N] := False;
  VST.Selected[N] := True;
end;

procedure TfrmCategories.popExpandAllClick(Sender: TObject);
begin
  VST.FullExpand();
  //frmCategories.Caption := 'Expand';
end;

procedure TfrmCategories.popExpandOneClick(Sender: TObject);
var
  N: PVirtualNode;
begin
  N := VST.GetFirstSelected();
  if VST.GetNodeLevel(N) = 1 then
    N := N.Parent;
  VST.ClearSelection;
  VST.Expanded[N] := True;
  VST.Selected[N] := True;
end;

procedure TfrmCategories.btnCancelClick(Sender: TObject);
begin
  try
    // panel Detail
    pnlDetail.Enabled := False;
    pnlDetail.Color := clDefault;
    pnlDetailCaption.Caption := AnsiUpperCase(Caption_43);

    // disabled menu
    pnlButtons.Visible := True;
    pnlButton.Visible := False;

    actCollapseAll.Enabled := True;
    actExpandAll.Enabled := True;
    btnMenu.Enabled := True;

    // disabled buttons
    //pnlStamp.Visible := True;
    frmCategories.cbxTo.ItemIndex := -1;
    frmCategories.cbxType.ItemIndex := -1;
    ediName.Caption := '';
    memComment.Caption := '';
    cbxStatus.ItemIndex := -1;

    // enabled ListView
    VST.Enabled := True;
    VST.SetFocus;
    if VST.SelectedCount = 1 then
      VSTChange(VST, VST.GetFirstSelected());

    // enabled ActionList
    actAdd.Enabled := True;
    actEdit.Enabled := True;
    actDelete.Enabled := True;

  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmCategories.pnlButtonResize(Sender: TObject);
begin
  btnCancel.Width := (pnlButton.Width - 6) div 2;
end;

procedure TfrmCategories.splListCanResize(Sender: TObject; var NewSize: integer;
  var Accept: boolean);
begin
  imgWidth.ImageIndex := 3;
  lblWidth.Caption := IntToStr(frmCategories.Width - pnlDetail.Width);

  imgHeight.ImageIndex := 2;
  lblHeight.Caption := IntToStr(pnlDetail.Width);

  pnlListCaption.Repaint;
  pnlDetailCaption.Repaint;
  pnlButton.Repaint;
end;

procedure TfrmCategories.VSTBeforeCellPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
begin
  if Sender.GetNodeLevel(Node) = 0 then
    TargetCanvas.Brush.Color := clSilver
  else
    TargetCanvas.Brush.Color :=
      IfThen(Node.Index mod 2 = 0, clWhite, frmSettings.pnlOddRowColor.Color);
  TargetCanvas.FillRect(CellRect);
end;

procedure TfrmCategories.VSTChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
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
    popCollapseOne.Enabled := VST.SelectedCount = 1;
    popExpandOne.Enabled := VST.SelectedCount = 1;

    if (VST.RootNodeCount = 0) or (VST.SelectedCount <> 1) then
    begin
      cbxType.ItemIndex := -1;
      cbxTo.ItemIndex := -1;
      ediName.Clear;
      cbxStatus.ItemIndex := -1;
      memComment.Clear;
      cbxKind.ItemIndex := 0;
      cbxEnergy.ItemIndex := -1;
      Exit;
    end;

    if (VST.SelectedCount = 1) then
    begin
      cbxType.ItemIndex := VST.GetNodeLevel(VST.GetFirstSelected());
      cbxTypeChange(cbxType);
      if cbxType.ItemIndex = 1 then
        cbxTo.ItemIndex := cbxTo.Items.IndexOf(
          VST.Text[VST.GetFirstSelected(False).Parent, 1]);
      ediName.Text := Trim(VST.Text[VST.GetFirstSelected(False), 1]);
      memComment.Text := VST.Text[VST.GetFirstSelected(False), 2];
      cbxStatus.ItemIndex := cbxStatus.Items.IndexOf(
        VST.Text[VST.GetFirstSelected(False), 3]);
      if VST.GetNodeLevel(VST.GetFirstSelected()) = 0 then
        cbxKind.ItemIndex := StrToInt(VST.Text[VST.GetFirstSelected(), 7])
      else
        cbxKind.ItemIndex := StrToInt(VST.Text[VST.GetFirstSelected().Parent, 7]);
      cbxEnergy.ItemIndex := StrToInt(VST.Text[VST.GetFirstSelected(), 8]);
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmCategories.VSTCompareNodes(Sender: TBaseVirtualTree;
  Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: integer);
var
  Data1, Data2: PCategory;
begin
  try
    Data1 := Sender.GetNodeData(Node1);
    Data2 := Sender.GetNodeData(Node2);
    case Column of
      1:
        Result := UTF8CompareText( // compare
          AnsiLowerCase(Data1.Parent_name + Data1.Name), // 1
          AnsiLowerCase(Data2.Parent_name + Data2.Name)); // 2
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmCategories.VSTDblClick(Sender: TObject);
begin
  if frmMain.Conn.Connected = False then Exit;

  if VST.SelectedCount = 0 then
    btnAddClick(btnAdd)
  else if VST.SelectedCount = 1 then
    btnEditClick(btnEdit);
end;

procedure TfrmCategories.VSTGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: boolean; var ImageIndex: integer);
begin
  if Column = 1 then
    ImageIndex := VST.GetNodeLevel(Node);
end;

procedure TfrmCategories.VSTGetNodeDataSize(Sender: TBaseVirtualTree;
  var NodeDataSize: integer);
begin
  NodeDataSize := SizeOf(TCategory);
end;

procedure TfrmCategories.VSTGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  Category: PCategory;
begin
  Category := Sender.GetNodeData(Node);
  try
    case Column of
      1: CellText := Category.Name;
      2: CellText := Category.Comment;
      3: CellText := cbxStatus.Items[Category.Status];
      4: CellText := IntToStr(Category.ID);
      5: CellText := IntToStr(Category.Parent_ID);
      6: CellText := Category.Parent_name;
      7: CellText := IntToStr(Category.Kind);
      8: CellText := IntToStr(Category.Energy);
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmCategories.VSTPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
var
  Category: PCategory;
begin
  Category := Sender.GetNodeData(Node);

  case Category.Status of
    0: TargetCanvas.Font.Color := clDefault;
    1: TargetCanvas.Font.Color := clBlue;
    2: TargetCanvas.Font.Color := clRed;
  end;
  TargetCanvas.Font.Bold := Sender.GetNodeLevel(Node) = 0;
end;

procedure TfrmCategories.VSTResize(Sender: TObject);
var
  X: integer;
begin
  if frmSettings.chkAutoColumnWidth.Checked = False then Exit;

  try
    (Sender as TLazVirtualStringTree).Header.Columns[0].Width :=
      round(ScreenRatio * 25 / 100);
    X := (VST.Width - VST.Header.Columns[0].Width) div 100;
    VST.Header.Columns[1].Width := 37 * X; // category / subcategory
    VST.Header.Columns[2].Width :=
      VST.Width - VST.Header.Columns[0].Width - ScrollBarWidth - (64 * X); // comment
    VST.Header.Columns[3].Width := 13 * X; // status
    VST.Header.Columns[4].Width := 7 * X; // ID
    VST.Header.Columns[7].Width := 7 * X; // type
  except
  end;
end;

procedure TfrmCategories.cbxTypeKeyUp(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  if Key = 13 then
  begin
    ediName.SetFocus;
    ediName.SelectAll;
  end;
end;

procedure TfrmCategories.ediNameExit(Sender: TObject);
begin
  if Sender.ClassType = TEdit then
    (Sender as TEdit).Font.Bold := False
  else if Sender.ClassType = TComboBox then
  begin
    (Sender as TComboBox).Font.Bold := False;
    ComboBoxExit((Sender as TComboBox));
  end
  else if Sender.ClassType = TMemo then
    (Sender as TMemo).Font.Bold := False;
end;

procedure TfrmCategories.ediNameEnter(Sender: TObject);
begin
  if Sender.ClassType = TEdit then
    (Sender as TEdit).Font.Bold := True
  else if Sender.ClassType = TComboBox then
    (Sender as TComboBox).Font.Bold := True
  else if Sender.ClassType = TMemo then
    (Sender as TMemo).Font.Bold := True;
end;

procedure TfrmCategories.ediNameKeyUp(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  try
    if (Key = 13) then
    begin
      if (cbxTo.Visible = True) then
        cbxTo.SetFocus
      else
      begin
        if cbxKind.Enabled = True then
          cbxKind.SetFocus
        else
          memComment.SetFocus;
      end;
    end;
  except
    On E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmCategories.FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  // CTRL+ENTER key pressed
  if (pnlDetail.Enabled = True) and (Key = 13) and (ssCtrl in Shift) and
    (btnSave.Enabled = True) then
  begin
    Key := 0;
    btnSaveClick(btnSave);
  end;
end;

procedure TfrmCategories.memCommentKeyUp(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  if (Key = 13) then
  begin
    Key := 0;
    cbxStatus.SetFocus;
    //cbxStatus.DroppedDown := True;
  end;
end;

procedure TfrmCategories.cbxStatusKeyUp(Sender: TObject; var Key: word;
  Shift: TShiftState);
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

procedure TfrmCategories.btnCopyClick(Sender: TObject);
begin
  if (VST.Enabled = False) or (frmMain.Conn.Connected = False) then
    Exit;
  CopyVST(VST);
end;

procedure TfrmCategories.btnMenuClick(Sender: TObject);
begin
  popMenu.PopUp;
end;

procedure TfrmCategories.btnPrintClick(Sender: TObject);
var
  FileName: string;
begin
  FileName := ExtractFileDir(Application.ExeName) + DirectorySeparator +
    'Templates' + DirectorySeparator + 'categories.lrf';

  if FileExists(FileName) = False then
  begin
    ShowMessage(Error_14 + sLineBreak + FileName);
    Exit;
  end;

  // left mouse button = show report
  try
    frmMain.Report.LoadFromFile(FileName);
    frmMain.Report.FindObject('lblName').Memo.Text := AnsiUpperCase(cbxType.Items[0]);
    frmMain.Report.FindObject('lblComment').Memo.Text :=
      AnsiUpperCase(lblComment.Caption);
    frmMain.Report.FindObject('lblStatus').Memo.Text :=
      AnsiUpperCase(lblStatus.Caption);
    frmMain.Report.FindObject('lblID').Memo.Text :=
      AnsiUpperCase(VST.Header.Columns[4].Text);
    frmMain.Report.FindObject('lblFooter').Memo.Text :=
      AnsiUpperCase(Application.Title + ' - ' + frmCategories.Caption);

    frmMain.Report.Tag := 11;
    frmMain.Report.ShowReport;

    VST.SetFocus;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;

end;

procedure TfrmCategories.btnPrintMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: integer);
var
  FileName: string;
begin
  if btnPrint.Enabled = False then Exit;

  FileName := ExtractFileDir(Application.ExeName) + DirectorySeparator +
    'Templates' + DirectorySeparator + 'categories.lrf';

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

procedure TfrmCategories.btnSelectClick(Sender: TObject);
begin
  if (VST.Enabled = False) or (VST.RootNodeCount < 1) or
    (frmMain.Conn.Connected = False) then
    Exit;
  VST.SelectAll(False);
  VST.SetFocus;
end;

procedure TfrmCategories.cbxEnergyKeyUp(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  if (Key = 13) then
  begin
    memComment.SetFocus;
  end;
end;

procedure TfrmCategories.cbxKindKeyUp(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  if (Key = 13) then
  begin
    cbxEnergy.SetFocus;
  end;
end;

procedure TfrmCategories.cbxToKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if (Key = 13) then
  begin
    if cbxKind.Enabled = True then
      cbxKind.SetFocus
    else
      if cbxEnergy.Enabled = True then
      cbxEnergy.SetFocus
    else
      memComment.SetFocus;
  end;
end;

procedure TfrmCategories.btnDeleteClick(Sender: TObject);
var
  I: integer;
  slDel: TStringList;
  N: PVirtualNode;
  S: string;
begin
  try
    if (frmMain.Conn.Connected = False) or (VST.SelectedCount = 0) or
      (frmMain.Conn.Connected = False) then
      exit;

    // get slDel of all selected nodes
    slDel := TStringList.Create;
    N := VST.GetFirstSelected(False);

    try
      while Assigned(N) do
      begin
        slDel.Add(VST.Text[N, 4] + separ + VST.Text[N, 5]);
        if (VST.GetNodeLevel(N) = 0) and (VST.ChildCount[N] > 0) then
          N := VST.GetLastChild(N);
        N := VST.GetNextSelected(N);
      end;
    finally
    end;

    S := '';
    for I := 0 to slDel.Count - 1 do
    begin
      S := S + Field(separ, slDel.Strings[I], 1) + ',';
      if Field(separ, slDel.Strings[I], 2) = '0' then
      begin
        frmMain.QRY.SQL.Text :=
          'SELECT cat_id FROM categories WHERE cat_parent_id = ' +
          Field(separ, slDel.Strings[I], 1) + ';';
        frmMain.QRY.Open;
        while not frmMain.QRY.EOF do
        begin
          S := S + frmMain.QRY.Fields[0].AsString + ',';
          frmMain.QRY.Next;
        end;
        frmMain.QRY.Close;
      end;
    end;

    slDel.Free;
    S := UTF8Copy(S, 1, UTF8Length(S) - 1);

    frmMain.QRY.SQL.Text := 'SELECT COUNT(*) FROM data WHERE d_category IN (' + S + ')';
    frmMain.QRY.Open;
    I := frmMain.QRY.Fields[0].AsInteger;
    frmMain.QRY.Close;

    // if the count of the transactions is > 0, then show all transaction to delete
    if I = 0 then
      // confirm deleting
      case VST.SelectedCount of
        1: if MessageDlg(Message_00, Question_01 + sLineBreak +
            sLineBreak + VST.Header.Columns[1].Text + ': ' +
            VST.Text[VST.FocusedNode, 1], mtConfirmation, mbYesNo, 0) <> mrYes then
            Exit;
        else
          if MessageDlg(Message_00, AnsiReplaceStr(Question_02, '%',
            IntToStr(VST.SelectedCount)), mtConfirmation, mbYesNo, 0) <> mrYes then
            Exit;
      end
    else if I > 0 then // show all transaction to delete
    begin
      frmDelete.Hint := 'd_category IN (' + S + ')' + separ +
        'sch_category IN (' + S + ')' + separ + 'budcat_category IN (' + S + ')';
      frmDelete.pnlCaption2.Caption := Question_06;

      if frmDelete.ShowModal <> mrOk then
        Exit;
    end;

    // delete categories
    frmMain.QRY.SQL.Text := 'DELETE FROM categories WHERE cat_id IN (' + S + ') ';
    frmMain.QRY.ExecSQL;
    frmMain.Tran.Commit;

    UpdateCategories;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmCategories.btnSaveClick(Sender: TObject);
begin
  // check category
  if (cbxTo.ItemIndex = -1) and (cbxType.ItemIndex = 1) then
  begin
    ShowMessage(ReplaceStr(Error_04, '%', AnsiUpperCase(lblTo.Caption)));
    cbxTo.SetFocus;
    Exit;
  end;

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
    begin
      if (cbxType.ItemIndex = 0) then
        frmMain.QRY.SQL.Text :=
          'INSERT OR IGNORE INTO categories ' +
          '(cat_name, cat_parent_ID, cat_parent_name, cat_status, cat_comment, cat_type, cat_energy) VALUES '
          + '(:NAME, 0, :PARENTNAME, :STATUS, :COMMENT, :TYPE, :ENERGY);'
      else
        frmMain.QRY.SQL.Text :=
          'INSERT OR IGNORE INTO categories ' +
          '(cat_name, cat_parent_ID, cat_parent_name, cat_status, cat_comment, cat_type, cat_energy) VALUES '
          + '(:NAME, (SELECT cat_id FROM categories WHERE cat_parent_ID = 0 AND cat_parent_name = :CATEGORY), '
          + ':PARENTNAME, :STATUS, :COMMENT, :TYPE, :ENERGY);';
    end
    else
    begin
      // Edit selected category
      VST.Tag := StrToInt(VST.Text[VST.GetFirstSelected(), 4]);
      frmMain.QRY.SQL.Text :=
        'UPDATE OR IGNORE categories SET ' +                  // update
        'cat_name = :NAME, ' +                                // name
        'cat_parent_ID = ' + IfThen(cbxType.ItemIndex = 0, '0',
        '(SELECT cat_id FROM categories WHERE cat_parent_ID = 0 AND cat_parent_name = :CATEGORY)')
        + ', cat_parent_name = :PARENTNAME, ' +                 // parent name
        'cat_status = :STATUS, ' +                           // status
        'cat_comment = :COMMENT, ' +                         // comment
        'cat_type = :TYPE, ' + // type (0 = all, 1 = credit, 2 = debit, 3 = transfer)
        'cat_energy = :ENERGY ' + // energy
        'WHERE cat_id = :ID;';

      frmMain.QRY.Params.ParamByName('ID').AsInteger := VST.Tag;
    end;

    frmMain.QRY.Params.ParamByName('NAME').AsString := ediName.Text;
    frmMain.QRY.Params.ParamByName('STATUS').AsInteger := cbxStatus.ItemIndex;
    frmMain.QRY.Params.ParamByName('COMMENT').AsString := memComment.Text;
    if cbxTo.Visible = True then
      frmMain.QRY.Params.ParamByName('CATEGORY').AsString :=
        cbxTo.Items[cbxTo.ItemIndex];

    // energy
    frmMain.QRY.Params.ParamByName('ENERGY').AsInteger := cbxEnergy.ItemIndex;

    // get parent ID
    if cbxType.ItemIndex = 0 then
      //      CategoryAdded := True;
      frmMain.QRY.Params.ParamByName('PARENTNAME').AsString :=
        AnsiUpperCase(ediName.Text)
    else       //      CategoryAdded := False;
      frmMain.QRY.Params.ParamByName('PARENTNAME').AsString :=
        AnsiUpperCase(cbxTo.Items[cbxTo.ItemIndex]);
    frmMain.QRY.Params.ParamByName('TYPE').AsInteger := cbxKind.ItemIndex;

    //ShowMessage(frmmain.QRY.SQL.Text + sLineBreak + sLineBreak + cbxTo.Items[cbxTo.ItemIndex]);
    frmMain.QRY.Prepare;
    frmMain.QRY.ExecSQL;
    frmMain.Tran.Commit;

    UpdateCategories;
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

procedure TfrmCategories.cbxTypeChange(Sender: TObject);
begin
  try
    case cbxType.ItemIndex of
      0:
      begin
        ediName.CharCase := ecUppercase;
        lblTo.Caption := '';
        lblTo.Visible := False;
        cbxTo.Visible := False;
        pnlDetail.Tag := 1;
        cbxTo.Tag := 0;
        cbxKind.Enabled := True;
      end
      else
      begin
        ediName.CharCase := ecLowerCase;
        lblTo.Caption := Caption_61;
        lblTo.Visible := True;
        cbxTo.Visible := True;
        cbxKind.Enabled := False;

        // adding record
        if btnSave.Tag = 0 then
        begin
          cbxTo.Enabled := True;
          lblTo.Caption := Caption_61;
          if (cbxTo.Items.Count > 0) then
          begin
            cbxTo.ItemIndex := 0;
            frmMain.QRY.SQL.Text :=
              'SELECT cat_parent_name, cat_id FROM categories ORDER BY cat_id DESC LIMIT 1';
            frmMain.QRY.Open;
            while not (frmMain.QRY.EOF) do
            begin
              if frmMain.QRY.RecNo = 1 then
                cbxTo.ItemIndex :=
                  cbxTo.Items.IndexOf(AnsiUpperCase(frmMain.QRY.Fields[0].AsString));
              frmMain.QRY.Next;
            end;
            frmMain.QRY.Close;
          end;
        end
        else if btnSave.Tag = 1 then
        begin
          lblTo.Caption := Caption_61; // ???
        end;
      end;
    end;

  except
    on E: Exception do
      ShowMessage(E.Message + sLineBreak + E.ClassName + sLineBreak + E.UnitName);
  end;
end;

procedure TfrmCategories.ediNameChange(Sender: TObject);
begin
  btnSave.Enabled := Length(ediName.Text) > 0;
end;

procedure TfrmCategories.btnExitClick(Sender: TObject);
begin
  frmCategories.Close;
end;

procedure TfrmCategories.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  if pnlButton.Visible = True then
  begin
    btnCancelClick(btnCancel);
    CloseAction := Forms.caNone;
    Exit;
  end;
end;

procedure TfrmCategories.FormResize(Sender: TObject);
begin
  imgWidth.ImageIndex := 0;
  lblWidth.Caption := IntToStr(frmCategories.Width);
  imgHeight.ImageIndex := 1;
  lblHeight.Caption := IntToStr(frmCategories.Height);

  pnlListCaption.Repaint;
  pnlDetailCaption.Repaint;
  pnlButtons.Repaint;
  pnlButton.Repaint;
end;

procedure TfrmCategories.FormShow(Sender: TObject);
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

procedure TfrmCategories.pnlButtonsResize(Sender: TObject);
begin
  btnEdit.Width := (pnlButtons.Width - 14) div 7;
  btnDelete.Width := btnEdit.Width;
  btnCopy.Width := btnEdit.Width;
  btnPrint.Width := btnEdit.Width;
  btnExit.Width := btnEdit.Width;
  btnSelect.Width := btnEdit.Width;
end;

procedure UpdateCategories;
var
  Category: PCategory;
  P, C: PVirtualNode;
  Cat, Subcat: string;
begin
  try
    // update list of all items
    frmCategories.VST.Clear;
    frmCategories.VST.RootNodeCount := 0;
    frmCategories.cbxTo.Clear;

    if frmMain.Conn.Connected = False then
      Exit;

    Screen.Cursor := crHourGlass;
    frmCategories.VST.BeginUpdate;

    // GET CATEGORIES ===========================================================================
    frmMain.QRY.SQL.Text := // query
      'SELECT ' + // select
      'cat_name,' + // category name
      'cat_comment,' + // comment
      'cat_status,' + // status
      'cat_parent_ID,' + // cat_parent_ID
      'cat_parent_name,' + // parent name
      'cat_time,' + // time
      'cat_id, ' + // id
      'cat_type, ' + // kind
      'cat_energy ' + // energy
      'FROM categories ' + // from
      'ORDER BY cat_parent_name, cat_parent_ID;';
    frmMain.QRY.Open;

    while not frmMain.QRY.EOF do
    begin
      // parent node (category)
      if frmMain.QRY.Fields[3].AsInteger = 0 then
      begin
        frmCategories.VST.RootNodeCount := frmCategories.VST.RootNodeCount + 1;
        P := frmCategories.VST.GetLast();
        Category := frmCategories.VST.GetNodeData(P);
        Category.Name := AnsiUpperCase(frmMain.QRY.Fields[0].AsString);
        frmCategories.cbxTo.Items.Add(Category.Name);
      end
      else
      begin
        // child node (subcategory)
        frmCategories.VST.ChildCount[P] := frmCategories.VST.ChildCount[P] + 1;
        C := frmCategories.VST.GetLastChild(P);
        Category := frmCategories.VST.GetNodeData(C);
        Category.Name :=
          IfThen(frmSettings.chkDisplaySubCatCapital.Checked = True,
          AnsiUpperCase(frmMain.QRY.Fields[0].AsString), AnsiLowerCase(
          frmMain.QRY.Fields[0].AsString));
      end;

      // common data
      Category.Comment := frmMain.QRY.Fields[1].AsString;
      Category.Status := frmMain.QRY.Fields[2].AsInteger;
      Category.Parent_ID := frmMain.QRY.Fields[3].AsInteger;
      Category.Parent_name := frmMain.QRY.Fields[4].AsString;
      Category.Time := frmMain.QRY.Fields[5].AsString;
      Category.ID := frmMain.QRY.Fields[6].AsInteger;
      Category.Kind := frmMain.QRY.Fields[7].AsInteger;
      Category.Energy := frmMain.QRY.Fields[8].AsInteger;
      frmMain.QRY.Next;
    end;
    frmMain.QRY.Close;

    frmCategories.VST.FullExpand();
    frmCategories.VST.EndUpdate;
    Screen.Cursor := crDefault;

    if frmCategories.cbxTo.Items.Count > 0 then
      frmCategories.cbxTo.ItemIndex := 0;

    // =============================================================================================
    // update list of categories in frmMain
    Cat := '';
    SubCat := '';

    if frmMain.cbxCategory.ItemIndex > -1 then
      Cat := frmMain.cbxCategory.Items[frmMain.cbxCategory.ItemIndex];
    if frmMain.cbxSubcategory.ItemIndex > -1 then
      Subcat := frmMain.cbxSubcategory.Items[frmMain.cbxSubcategory.ItemIndex];

    frmMain.cbxCategory.Clear;

    if (frmCategories.VST.RootNodeCount > 0) and
      (frmCategories.cbxStatus.Items.Count > 0) then
      for P in frmCategories.VST.Nodes() do
        // list of categories in frmMAIN [only active status]
        if (frmCategories.VST.GetNodeLevel(P) = 0) and
          (frmCategories.VST.Text[P, 3] = frmCategories.cbxStatus.Items[0]) then
          frmMain.cbxCategory.Items.Add(frmCategories.VST.Text[P, 1]);

    frmMain.cbxCategory.Items.Insert(0, '*');

    try
      if Cat = '' then
        frmMain.cbxCategory.ItemIndex := 0
      else
        frmMain.cbxCategory.ItemIndex := frmMain.cbxCategory.Items.IndexOf(Cat);
      frmMain.cbxCategorySelect(frmMain.cbxCategory);

      if SubCat = '' then
        frmMain.cbxSubcategory.ItemIndex := 0
      else
        frmMain.cbxSubcategory.ItemIndex :=
          frmMain.cbxSubcategory.Items.IndexOf(SubCat);
      frmMain.cbxSubcategorySelect(frmMain.cbxSubcategory);
    except
    end;

    // =============================================================================================
    // items icon
    frmCategories.lblItems.Caption := IntToStr(frmCategories.VST.TotalCount);

    frmCategories.popCopy.Enabled := frmCategories.VST.RootNodeCount > 0;
    frmCategories.btnCopy.Enabled := frmCategories.popCopy.Enabled;
    frmCategories.btnSelect.Enabled := frmCategories.VST.RootNodeCount > 0;
    frmCategories.popPrint.Enabled := frmCategories.popCopy.Enabled;
    frmCategories.btnPrint.Enabled := frmCategories.popCopy.Enabled;
    frmCategories.popEdit.Enabled := False;
    frmCategories.btnEdit.Enabled := False;
    frmCategories.popDelete.Enabled := False;
    frmCategories.btnDelete.Enabled := False;

    frmCategories.popCollapseOne.Enabled := False;
    frmCategories.popExpandOne.Enabled := False;
    frmCategories.cbxType.ItemIndex := -1;
    frmCategories.cbxTo.ItemIndex := -1;

    if (frmCategories.Visible = True) and (frmCategories.VST.Enabled = True) then
      frmCategories.VST.SetFocus;

    if frmProperties.Visible = True then
      frmProperties.FormShow(frmProperties);

    if frmBudget.Visible = True then
      UpdateBudget;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

end.
