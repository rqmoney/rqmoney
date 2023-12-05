unit uniBudget;

{$mode ObjFPC}{$H+}
{$ModeSwitch AutoDeref}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Math, Buttons, LazUTF8,
  ActnList, Menus, laz.VirtualTrees, BCPanel, BCMDButtonFocus, DateUtils, StrUtils;

type // bottom grid (Budget)
  TBudget = record
    Name: string;
    Comment: string;
    ID: integer;
  end;
  PBudget = ^TBudget;

type

  { TfrmBudget }

  TfrmBudget = class(TForm)
    actExit: TAction;
    ActionList: TActionList;
    actSave: TAction;
    btnCancel: TBCMDButtonFocus;
    btnSave: TBCMDButtonFocus;
    btnCategories: TBCMDButtonFocus;
    ediName: TEdit;
    imgChecked: TImage;
    imgHeight: TImage;
    imgItems: TImage;
    imgWidth: TImage;
    lblHint1: TLabel;
    lblChecked: TLabel;
    lblHeight: TLabel;
    lblHint2: TLabel;
    lblItems: TLabel;
    lblWidth: TLabel;
    pnlType: TPanel;
    pnlName: TPanel;
    pnlHint: TPanel;
    pnlCategories: TPanel;
    pnlCategoriesCaption: TBCPanel;
    pnlButtons: TPanel;
    pnlChecked: TPanel;
    pnlHeight: TPanel;
    pnlItems: TPanel;
    pnlLeft: TPanel;
    pnlNameCaption: TBCPanel;
    pnlTypeCaption: TBCPanel;
    pnlBottom: TPanel;
    pnlTip: TPanel;
    pnlWidth: TPanel;
    rbtCategories: TRadioButton;
    rbtSubcategories: TRadioButton;
    splBudget: TSplitter;
    VST: TLazVirtualStringTree;
    procedure btnCancelClick(Sender: TObject);
    procedure btnCategoriesClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure ediNameChange(Sender: TObject);
    procedure ediNameKeyPress(Sender: TObject; var Key: char);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure rbtCategoriesChange(Sender: TObject);
    procedure splBudgetCanResize(Sender: TObject; var NewSize: integer;
      var Accept: boolean);
    procedure VSTBeforeCellPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
    procedure VSTChecked(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure VSTCompareNodes(Sender: TBaseVirtualTree; Node1, Node2: PVirtualNode;
      Column: TColumnIndex; var Result: integer);
    procedure VSTEnter(Sender: TObject);
    procedure VSTGetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Kind: TVTImageKind; Column: TColumnIndex; var Ghosted: boolean;
      var ImageIndex: integer);
    procedure VSTGetNodeDataSize(Sender: TBaseVirtualTree; var NodeDataSize: integer);
    procedure VSTGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure VSTHeaderClick(Sender: TVTHeader; HitInfo: TVTHeaderHitInfo);
    procedure VSTInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode;
      var InitialStates: TVirtualNodeInitStates);
    procedure VSTKeyPress(Sender: TObject; var Key: char);
    procedure VSTResize(Sender: TObject);
  private

  public

  end;

var
  frmBudget: TfrmBudget;

procedure UpdateBudget;

implementation

{$R *.lfm}

uses
  uniResources, uniSettings, uniMain, uniCategories, uniBudgets;

  { TfrmBudget }

procedure TfrmBudget.FormShow(Sender: TObject);
var
  B, C: PVirtualNode;
  Budget: PBudget;
  BudCat: PBudcat;
  Budgets: PBudgets;

begin
  If ((frmBudget.Tag = 0) and (frmBudgets.popBudgetAdd.Tag = 1)) then   // duplicate mode
  begin
    Budgets := frmBudgets.VSTBudgets.GetNodeData(frmBudgets.VSTBudgets.GetFirstSelected());
    If Budgets.Kind = 0 then
      rbtCategories.Checked := True
    Else rbtSubcategories.Checked := True;
  end;

  UpdateBudget;

  if (frmBudget.Tag = 1) or   // edit mode
    ((frmBudget.Tag = 0) and (frmBudgets.popBudgetAdd.Tag = 1)) then   // duplicate mode
  begin
    B := VST.GetFirst();

    while Assigned(B) do
    begin
      Budget := VST.GetNodeData(B);
      C := frmBudgets.VSTBudCat.GetFirst();
      while Assigned(C) do
      begin
        BudCat := frmBudgets.VSTBudCat.GetNodeData(C);
        if BudCat.CategoryID = Budget.ID then
          B.CheckState := csCheckedNormal;
        C := frmBudgets.VSTBudCat.GetNext(C);
      end;
      B := frmBudget.VST.GetNext(B);
    end;
  end;
  ediName.SetFocus;
  ediName.SelectAll;
end;

procedure TfrmBudget.rbtCategoriesChange(Sender: TObject);
begin
  UpdateBudget;
end;

procedure TfrmBudget.splBudgetCanResize(Sender: TObject; var NewSize: integer;
  var Accept: boolean);
begin
  try
    imgWidth.ImageIndex := 3;
    lblWidth.Caption := IntToStr(frmBudget.Width - pnlCategories.Width);

    imgHeight.ImageIndex := 2;
    lblHeight.Caption := IntToStr(pnlCategories.Width);

    pnlNameCaption.Repaint;
    pnlCategoriesCaption.Repaint;
    pnlTypeCaption.Repaint;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmBudget.VSTBeforeCellPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
begin
  TargetCanvas.Brush.Color :=
    IfThen(Node.Index mod 2 = 0, clWhite, frmSettings.pnlOddRowColor.Color);
  TargetCanvas.FillRect(CellRect);
end;

procedure TfrmBudget.VSTChecked(Sender: TBaseVirtualTree; Node: PVirtualNode);
begin
  btnSave.Enabled := (Length(ediName.Text) > 0) and (VST.CheckedCount > 0);
  lblChecked.Caption := IntToStr(VST.CheckedCount);
end;

procedure TfrmBudget.VSTCompareNodes(Sender: TBaseVirtualTree;
  Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: integer);
var
  Data1, Data2: PBudget;
begin
  Data1 := Sender.GetNodeData(Node1);
  Data2 := Sender.GetNodeData(Node2);
  case Column of
    1: begin
      Result := UTF8CompareText(Data1.Name, Data2.Name);
      if Result = 0 then
        Result := UTF8CompareText(Data1.Comment, Data2.Comment);
    end;
  end;
end;

procedure TfrmBudget.VSTEnter(Sender: TObject);
begin
  if VST.SelectedCount = 0 then
  begin
    VST.Selected[VST.GetFirst()] := True;
    VST.FocusedNode := VST.GetFirst();
  end;
end;

procedure TfrmBudget.VSTGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: boolean; var ImageIndex: integer);
begin
  if Column = 0 then
    ImageIndex := IfThen(rbtCategories.Checked = True, 0, 1);
end;

procedure TfrmBudget.VSTGetNodeDataSize(Sender: TBaseVirtualTree;
  var NodeDataSize: integer);
begin
  NodeDataSize := SizeOf(TBudget);
end;

procedure TfrmBudget.VSTGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
var
  Budget: PBudget;
begin
  Budget := Sender.GetNodeData(Node);
  case Column of
    0: CellText := AnsiUpperCase(Budget.Name);
    1: CellText := IfThen(frmSettings.chkDisplaySubCatCapital.Checked = True,
      AnsiUpperCase(Budget.Comment), Budget.Comment);
    2: CellText := IntToStr(Budget.ID);
  end;
end;

procedure TfrmBudget.VSTHeaderClick(Sender: TVTHeader; HitInfo: TVTHeaderHitInfo);
begin
  if (HitInfo.Column > 0) then Exit;
  VST.Tag := IfThen(Sender.Columns[0].CheckState = csCheckedNormal, 1, 0);
  CheckAllNodes(VST);
  VST.Repaint;
end;

procedure TfrmBudget.VSTInitNode(Sender: TBaseVirtualTree;
  ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
begin
  Node.CheckType := ctCheckBox;
end;

procedure TfrmBudget.VSTKeyPress(Sender: TObject; var Key: char);
begin
  if Ord(Key) = 13 then
    if btnSave.Enabled = True then
      btnSave.SetFocus;
end;

procedure TfrmBudget.VSTResize(Sender: TObject);
var
  X: integer;
begin
  if frmSettings.chkAutoColumnWidth.Checked = False then Exit;
  X := VST.Width div 100;
  VST.Header.Columns[0].Width := VST.Width - ScrollBarWidth - (54 * X); // category
  VST.Header.Columns[1].Width := 44 * X; // subcategory
  VST.Header.Columns[2].Width := 10 * x; // ID
end;

procedure TfrmBudget.ediNameKeyPress(Sender: TObject; var Key: char);
begin
  if Ord(Key) = 13 then
    VST.SetFocus;
end;

procedure TfrmBudget.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  if (btnSave.Tag = 0) and (VST.CheckedCount > 0) then
    if MessageDlg(Application.Title, Question_19, mtConfirmation, [mbYes, mbNo], 0) <>
      mrYes then
    begin
      CloseAction := caNone;
      Exit;
    end;
  btnSave.Tag := 0;
end;

procedure TfrmBudget.FormCreate(Sender: TObject);
begin
  {$IFDEF WINDOWS}
  // form size
  (Sender as TForm).Width := Round(700 * (ScreenRatio / 100));
  (Sender as TForm).Constraints.MinWidth := Round(700 * (ScreenRatio / 100));
  (Sender as TForm).Height := Round(400 * (ScreenRatio / 100));
  (Sender as TForm).Constraints.MinHeight := Round(400 * (ScreenRatio / 100));

  // form position
  (Sender as TForm).Left := (Screen.Width - (Sender as TForm).Width) div 2;
  (Sender as TForm).Top := (Screen.Height - 200 - (Sender as TForm).Height) div 2;

  // set components height
  VST.Header.Height := PanelHeight;
  pnlTypeCaption.Height := PanelHeight;
  pnlCategoriesCaption.Height := PanelHeight;
  pnlNameCaption.Height := PanelHeight;

  pnlButtons.Height := ButtonHeight;
  pnlBottom.Height := ButtonHeight;
  {$ENDIF}
end;

procedure TfrmBudget.FormResize(Sender: TObject);
begin
  imgWidth.ImageIndex := 0;
  lblWidth.Caption := IntToStr(frmBudget.Width);
  imgHeight.ImageIndex := 1;
  lblHeight.Caption := IntToStr(frmBudget.Height);

  pnlCategoriesCaption.Repaint;
end;

procedure TfrmBudget.btnSaveClick(Sender: TObject);
var
  I: integer;
begin
  case frmBudget.Tag of
    0: begin
      if MessageDlg(Application.Title, Question_20, mtConfirmation, [mbYes, mbNo], 0) <>
        mrYes then Exit;
      frmBudget.ModalResult := mrOk;
    end;
    1: begin
      if MessageDlg(Application.Title, Question_21, mtConfirmation, [mbYes, mbNo], 0) <>
        mrYes then Exit;
      I := MessageDlg(Application.Title, AnsiReplaceStr(Message_08, '%', sLineBreak),
        mtWarning, [mbYes, mbNo, mbCancel], 0);
      case I of
        mrYes: frmBudget.ModalResult := mrOk;
        mrNo: frmBudget.ModalResult := mrCancel;
        mrCancel: Exit;
      end;
    end;
  end;
  btnSave.Tag := 1;
end;

procedure TfrmBudget.ediNameChange(Sender: TObject);
begin
  btnSave.Enabled := (Length(ediName.Text) > 0) and (VST.CheckedCount > 0);
end;

procedure TfrmBudget.btnCancelClick(Sender: TObject);
begin
  frmBudget.Close;
end;

procedure TfrmBudget.btnCategoriesClick(Sender: TObject);
begin
  frmCategories.ShowModal;
end;

procedure UpdateBudget;
var
  Budget: PBudget;
  P: PVirtualNode;
begin
  frmBudget.VST.Clear;
  frmBudget.VST.RootNodeCount := 0;

  if frmMain.Conn.Connected = False then
    Exit;

  try
    Screen.Cursor := crHourGlass;
    frmBudget.VST.BeginUpdate;

    if frmBudget.rbtCategories.Checked = True then
      frmMain.QRY.SQL.Text :=
        'SELECT cat_name, cat_comment, cat_id FROM categories WHERE cat_parent_id = 0;'
    else
      frmMain.QRY.SQL.Text :=
        'SELECT cat_parent_name, cat_name, cat_id FROM categories WHERE cat_parent_id > 0;';
    frmMain.QRY.Open;

    while not (frmMain.QRY.EOF) do
    begin
      frmBudget.VST.RootNodeCount := frmBudget.VST.RootNodeCount + 1;
      P := frmBudget.VST.GetLast();
      Budget := frmBudget.VST.GetNodeData(P);
      Budget.Name := frmMain.QRY.Fields[0].AsString;
      Budget.Comment := frmMain.QRY.Fields[1].AsString;
      Budget.ID := frmMain.QRY.Fields[2].AsInteger;
      frmMain.QRY.Next;
    end;
    frmMain.QRY.Close;

    frmBudget.VST.SortTree(1, sdAscending, True);
    SetNodeHeight(frmBudget.VST);

  finally
    frmBudget.VST.EndUpdate;
    Screen.Cursor := crDefault;
  end;



  // uncheck all nodes
  frmBudget.VST.Tag := 0;
  CheckAllNodes(frmBudget.VST);

  // update labels
  frmBudget.lblChecked.Caption := IntToStr(frmBudget.VST.CheckedCount);
  frmBudget.ediNameChange(frmBudget.ediName);
  frmBudget.lblItems.Caption := IntToStr(frmBudget.VST.TotalCount);
end;

end.
