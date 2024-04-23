unit uniDetail;

{$mode objfpc}{$H+}
{$ModeSwitch AutoDeref}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  LazUtf8, CheckLst, Buttons, ComCtrls, ActnList, BCMDButtonFocus, ECTabCtrl,
  StrUtils, DateUtils, LCLType, Spin, Menus, BCPanel, laz.VirtualTrees, Math,
  DateTimePicker, SQLDB, IniFiles;

type

  { TfrmDetail }

  TfrmDetail = class(TForm)
    actExit: TAction;
    actAdd: TAction;
    actEdit: TAction;
    actDuplicate: TAction;
    actDelete: TAction;
    actCalc: TAction;
    actComments: TAction;
    actCategories: TAction;
    actTags: TAction;
    actPersons: TAction;
    actPayee: TAction;
    actAccounts: TAction;
    actSimple: TAction;
    actMultiple: TAction;
    actSelect: TAction;
    ActionList1: TActionList;
    actSave: TAction;
    btnAccountFrom: TSpeedButton;
    btnAccountTo: TSpeedButton;
    btnAccountX: TSpeedButton;
    btnAdd: TBCMDButtonFocus;
    btnAmountFrom: TSpeedButton;
    btnAmountTo: TSpeedButton;
    btnAmountX: TSpeedButton;
    btnCancel: TBCMDButtonFocus;
    btnCancelX: TBCMDButtonFocus;
    btnCategory: TSpeedButton;
    btnCategoryX: TSpeedButton;
    btnComment: TSpeedButton;
    btnCommentX: TSpeedButton;
    btnDelete: TBCMDButtonFocus;
    btnDuplicate: TBCMDButtonFocus;
    btnEdit: TBCMDButtonFocus;
    btnPayee: TSpeedButton;
    btnPayeeX: TSpeedButton;
    btnPerson: TSpeedButton;
    btnPersonX: TSpeedButton;
    btnSave: TBCMDButtonFocus;
    btnSaveX: TBCMDButtonFocus;
    btnSelect: TBCMDButtonFocus;
    btnSettings: TBCMDButtonFocus;
    btnTag: TSpeedButton;
    btnTagsX: TSpeedButton;
    cbxAccountFrom: TComboBox;
    cbxAccountTo: TComboBox;
    cbxAccountX: TComboBox;
    cbxCategory: TComboBox;
    cbxSubcategory: TComboBox;
    cbxCategoryX: TComboBox;
    cbxSubcategoryX: TComboBox;
    cbxComment: TComboBox;
    cbxCommentX: TComboBox;
    cbxPayee: TComboBox;
    cbxPayeeX: TComboBox;
    cbxPerson: TComboBox;
    cbxPersonX: TComboBox;
    cbxType: TComboBox;
    cbxTypeX: TComboBox;
    chkAmountMinus: TCheckBox;
    datDateFrom: TDateTimePicker;
    datDateTo: TDateTimePicker;
    datDateX: TDateTimePicker;
    gbxAccountFrom: TGroupBox;
    gbxAccountTo: TGroupBox;
    gbxAmountFrom: TGroupBox;
    gbxAmountTo: TGroupBox;
    gbxCategory: TGroupBox;
    gbxComment: TGroupBox;
    gbxDateFrom: TGroupBox;
    gbxDateTo: TGroupBox;
    gbxFrom: TPanel;
    gbxPayee: TGroupBox;
    gbxPerson: TGroupBox;
    gbxTag: TGroupBox;
    gbxTo: TPanel;
    gbxType: TGroupBox;
    imgHeight: TImage;
    imgWidth: TImage;
    lblAccountX: TLabel;
    lblAmountX: TLabel;
    lblBalance_: TLabel;
    lblCategoryX: TLabel;
    lblCommentX: TLabel;
    lblDateFrom: TLabel;
    lblDateTo: TLabel;
    lblDateX: TLabel;
    lblDateX1: TLabel;
    lblHeight: TLabel;
    lblPayeeX: TLabel;
    lblPersonX: TLabel;
    lblSummaryInList: TLabel;
    lblTagsX: TLabel;
    lblTypeX: TLabel;
    lblWidth: TLabel;
    lbxTag: TCheckListBox;
    lbxTagsX: TCheckListBox;
    Panel1: TPanel;
    Panel2: TPanel;
    pnlButtons: TPanel;
    pnlAccountX: TPanel;
    pnlAmountMinus: TPanel;
    pnlAmountX: TPanel;
    pnlBalance: TPanel;
    pnlBasicCaption: TBCPanel;
    pnlButtonsX: TPanel;
    pnlCategoryX: TPanel;
    pnlClientX: TPanel;
    pnlCommentX: TPanel;
    pnlDateX: TPanel;
    pnlDateX1: TPanel;
    pnlDetail: TPanel;
    pnlDetailCaption: TBCPanel;
    pnlLeft: TPanel;
    pnlList: TPanel;
    pnlListCaption: TBCPanel;
    pnlMenuX: TPanel;
    pnlMultiple: TPanel;
    pnlPayeeX: TPanel;
    pnlPersonX: TPanel;
    pnlSimple: TPanel;
    pnlBack: TPanel;
    pnlDateFrom: TPanel;
    pnlDateTo: TPanel;
    pnlClient: TScrollBox;
    pnlHeight: TPanel;
    pnlSimpleLeft: TPanel;
    pnlRight: TPanel;
    pnlSize: TPanel;
    pnlSummaryInList: TPanel;
    pnlTagLabel: TPanel;
    pnlTagsX1: TPanel;
    pnlTagX: TPanel;
    pnlTypeX: TPanel;
    pnlWidth: TPanel;
    popAdd: TMenuItem;
    popDelete: TMenuItem;
    popDuplicate: TMenuItem;
    popEdit: TMenuItem;
    popExit: TMenuItem;
    popList: TPopupMenu;
    popSelect: TMenuItem;
    Separator1: TMenuItem;
    spiAmountFrom: TEdit;
    spiAmountMinus: TFloatSpinEdit;
    spiAmountTo: TEdit;
    spiAmountX: TEdit;
    spiBalance: TFloatSpinEdit;
    spiSummary: TFloatSpinEdit;
    splSimple: TSplitter;
    splDetail: TSplitter;
    splMultiple: TSplitter;
    tabKind: TECTabCtrl;
    pnlBottom: TPanel;
    VST: TLazVirtualStringTree;
    procedure actAccountsExecute(Sender: TObject);
    procedure actCalcExecute(Sender: TObject);
    procedure actCategoriesExecute(Sender: TObject);
    procedure actCommentsExecute(Sender: TObject);
    procedure actPayeeExecute(Sender: TObject);
    procedure actPersonsExecute(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actSimpleExecute(Sender: TObject);
    procedure actTagsExecute(Sender: TObject);
    procedure btnAccountFromClick(Sender: TObject);
    procedure btnAccountToClick(Sender: TObject);
    procedure btnAccountXClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnAmountFromClick(Sender: TObject);
    procedure btnAmountToClick(Sender: TObject);
    procedure btnAmountXClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnCancelXClick(Sender: TObject);
    procedure btnCategoryClick(Sender: TObject);
    procedure btnCategoryXClick(Sender: TObject);
    procedure btnCommentClick(Sender: TObject);
    procedure btnCommentXClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnDuplicateClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnPayeeClick(Sender: TObject);
    procedure btnPayeeXClick(Sender: TObject);
    procedure btnPersonClick(Sender: TObject);
    procedure btnPersonXClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnSaveXClick(Sender: TObject);
    procedure btnSelectClick(Sender: TObject);
    procedure btnSettingsClick(Sender: TObject);
    procedure btnTagClick(Sender: TObject);
    procedure btnTagsXClick(Sender: TObject);
    procedure cbxAccountFromDropDown(Sender: TObject);
    procedure cbxAccountFromEnter(Sender: TObject);
    procedure cbxAccountFromExit(Sender: TObject);
    procedure cbxAccountFromKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure cbxAccountToKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure cbxAccountXKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure cbxCategoryChange(Sender: TObject);
    procedure cbxCategoryExit(Sender: TObject);
    procedure cbxCategoryKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure cbxCategoryXChange(Sender: TObject);
    procedure cbxCategoryXExit(Sender: TObject);
    procedure cbxCategoryXKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure cbxCommentEnter(Sender: TObject);
    procedure cbxCommentExit(Sender: TObject);
    procedure cbxCommentKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure cbxCommentXExit(Sender: TObject);
    procedure cbxCommentXKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure cbxPayeeKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure cbxPayeeXKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure cbxPersonKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure cbxPersonXKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure cbxSubcategoryExit(Sender: TObject);
    procedure cbxSubcategoryKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure cbxSubcategoryXKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure cbxTypeChange(Sender: TObject);
    procedure cbxTypeKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure cbxTypeXChange(Sender: TObject);
    procedure cbxTypeXEnter(Sender: TObject);
    procedure cbxTypeXExit(Sender: TObject);
    procedure cbxTypeXKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure chkAmountMinusChange(Sender: TObject);
    procedure datDateFromChange(Sender: TObject);
    procedure datDateFromDropDown(Sender: TObject);
    procedure datDateFromEnter(Sender: TObject);
    procedure datDateFromExit(Sender: TObject);
    procedure datDateFromKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure datDateFromKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure datDateToChange(Sender: TObject);
    procedure datDateToKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure datDateXChange(Sender: TObject);
    procedure datDateXKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure lblDateFromClick(Sender: TObject);
    procedure lblDateToClick(Sender: TObject);
    procedure lblWidthClick(Sender: TObject);
    procedure lbxTagsXKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure pnlBottomResize(Sender: TObject);
    procedure pnlMenuXResize(Sender: TObject);
    procedure pnlSizeResize(Sender: TObject);
    procedure spiAmountFromChange(Sender: TObject);
    procedure spiAmountFromClick(Sender: TObject);
    procedure spiAmountFromEnter(Sender: TObject);
    procedure spiAmountFromExit(Sender: TObject);
    procedure spiAmountFromKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure spiAmountMinusChange(Sender: TObject);
    procedure spiAmountMinusKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure spiAmountToKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lbxTagEnter(Sender: TObject);
    procedure lbxTagExit(Sender: TObject);
    procedure lbxTagKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure pnlClientResize(Sender: TObject);
    procedure spiAmountXKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure splSimpleCanResize(Sender: TObject; var NewSize: integer;
      var Accept: boolean);
    procedure tabKindChange(Sender: TObject);
    procedure tabKindChanging(Sender: TObject; var AllowChange: boolean);
    procedure VSTBeforeCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas;
      Node: PVirtualNode; Column: TColumnIndex; CellPaintMode: TVTCellPaintMode;
      CellRect: TRect; var ContentRect: TRect);
    procedure VSTChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure VSTDblClick(Sender: TObject);
    procedure VSTGetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Kind: TVTImageKind; Column: TColumnIndex; var Ghosted: boolean;
      var ImageIndex: integer);
    procedure VSTGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure VSTResize(Sender: TObject);
  private

  public

  end;

type
  TMultiTags = array of array of integer;

var
  slMultiple: TStringList;
  TMultiTag: TMultiTags;
  frmDetail: TfrmDetail;

procedure UpdateMultiple;

implementation

{$R *.lfm}

uses
  uniMain, uniPersons, uniPayees, uniAccounts, uniCategories, uniTags, uniComments,
  uniResources, uniSettings;

  { TfrmDetail }

procedure TfrmDetail.cbxTypeChange(Sender: TObject);
begin
  if (cbxType.ItemIndex = -1) or (frmMain.Conn.Connected = False) then Exit;

  pnlClient.DisableAlign;
  case cbxType.ItemIndex of
    0, 1: begin
      if cbxType.ItemIndex = 0 then
        gbxAccountFrom.Caption := Caption_78
      else
        gbxAccountFrom.Caption := Caption_77;
      gbxTo.Visible := False;
      pnlRight.Width := pnlRight.Tag;
    end
    else
    begin
      gbxAccountFrom.Caption := Caption_77;
      gbxAccountTo.Caption := Caption_78;
      gbxFrom.Visible := True;
      gbxTo.Visible := True;
      pnlRight.Width := 150;
    end;
  end;
  pnlClient.EnableAlign;
  cbxCategory.Tag := -1;
  FillCategory(cbxCategory, cbxType.ItemIndex);
  cbxCategoryChange(cbxCategory);
end;

procedure TfrmDetail.btnCancelClick(Sender: TObject);
begin
  try
    frmDetail.ModalResult := mrCancel;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmDetail.btnCancelXClick(Sender: TObject);
begin
  try
    // panel Detail
    pnlDetail.Visible := False;
    splDetail.Visible := False;
    pnlDetail.Enabled := False;
    pnlDetail.Color := clDefault;
    pnlDetailCaption.Caption := AnsiUpperCase(Caption_43);
    pnlMenuX.Visible := True;

    // disabled menu
    pnlButtonsX.Visible := False;

    actSelect.Enabled := True;
    actAdd.Enabled := True;
    actEdit.Enabled := True;
    actDelete.Enabled := True;
    actSave.Enabled := VST.TotalCount > 0;
    pnlButtons.Visible := True;

    // enabled components
    splMultiple.Visible := True;
    pnlLeft.Visible := True;
    splMultiple.Left := 0;
    pnlLeft.Left := 0;
    pnlLeft.Enabled := True;
    VST.Enabled := True;
    VST.SetFocus;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmDetail.btnCategoryClick(Sender: TObject);
begin
  frmCategories.ShowModal;
  cbxCategory.Tag := -1;
  cbxTypeChange(cbxType);
  cbxCategory.SetFocus;
end;

procedure TfrmDetail.btnCategoryXClick(Sender: TObject);
begin
  frmCategories.ShowModal;
  if pnlDetail.Visible = True then
  begin
    cbxCategoryX.Tag := -1;
    cbxTypeXChange(cbxTypeX);
    cbxCategoryX.SetFocus;
  end;
end;

procedure TfrmDetail.btnCommentClick(Sender: TObject);
begin
  frmComments.ShowModal;
  cbxComment.SetFocus;
end;

procedure TfrmDetail.btnCommentXClick(Sender: TObject);
begin
  frmComments.ShowModal;
  if pnlDetail.Visible = True then
    cbxCommentX.SetFocus;
end;

procedure TfrmDetail.btnDeleteClick(Sender: TObject);
var
  F: PVirtualNode;
  S: TStringList;
  I: word;
begin
  if (VST.RootNodeCount = 0) or (VST.SelectedCount = 0) or
    (btnDelete.Enabled = False) or (tabKind.TabIndex = 0) then
    exit;

  if VST.SelectedCount = 1 then
  begin
    if MessageDlg(Message_00, Question_01, mtWarning, mbYesNo, 0) <> 6 then
      Exit;
  end
  else
  if MessageDlg(Message_00, ReplaceStr(Question_02, '%', IntToStr(VST.SelectedCount)),
    mtWarning, mbYesNo, 0) <> 6 then
    Exit;

  VST.BeginUpdate;
  S := TStringList.Create;
  F := VST.GetFirstSelected(False);
  while Assigned(F) do
  begin
    S.Add(IntToStr(F.Index));
    F := VST.GetNextSelected(F, False);
  end;
  VST.EndUpdate;

  for I := S.Count - 1 downto 0 do
    slMultiple.Delete(StrToInt(S.Strings[I]));

  S.Free;
  UpdateMultiple;
  VST.Repaint;
end;

procedure TfrmDetail.btnDuplicateClick(Sender: TObject);
begin
  if (btnDuplicate.Enabled = False) or (tabKind.TabIndex = 0) then
    Exit;
  btnDuplicate.Tag := 1;
  btnEditClick(btnEdit);
end;

procedure TfrmDetail.btnEditClick(Sender: TObject);
begin
  if (btnEdit.Enabled = False) or (tabKind.TabIndex = 0) then
    Exit;

  // panel Detail
  pnlDetail.Visible := True;
  splDetail.Visible := True;
  pnlDetail.Enabled := True;
  pnlDetail.Left := 0;
  splDetail.Left := 0;
  pnlDetail.Color := frmSettings.btnCaptionColorFont.Tag;
  if btnDuplicate.Tag = 1 then
    pnlDetailCaption.Caption := AnsiUpperCase(Caption_45)
  else
    pnlDetailCaption.Caption := AnsiUpperCase(Caption_46);
  pnlButtonsX.Visible := True;
  pnlMenuX.Visible := False;

  // disabled components
  VST.Enabled := False;
  pnlLeft.Enabled := False;
  pnlLeft.Visible := False;
  splMultiple.Visible := False;

  // disabled menu
  btnSaveX.Tag := 1 - btnDuplicate.Tag;
  btnDuplicate.Tag := 0;
  cbxTypeX.SetFocus;

  pnlButtons.Visible := False;

  // disabled ActionList
  actSelect.Enabled := False;
  actAdd.Enabled := False;
  actEdit.Enabled := False;
  actDelete.Enabled := False;
  actSave.Enabled := True;

  // get data
  spiAmountX.Text := ReplaceStr(VST.Text[VST.FocusedNode, 1],
    FS_own.ThousandSeparator, '');
  cbxCommentX.Text := VST.Text[VST.FocusedNode, 2];
  cbxCategoryX.ItemIndex := cbxCategoryX.Items.IndexOf(VST.Text[VST.FocusedNode, 3]);
  cbxPersonX.ItemIndex := cbxPersonX.Items.IndexOf(VST.Text[VST.FocusedNode, 4]);
  cbxTypeX.ItemIndex := StrToInt(VST.Text[VST.FocusedNode, 5]);
end;

procedure TfrmDetail.btnPayeeClick(Sender: TObject);
begin
  frmPayees.ShowModal;
  if cbxPayee.Items.Count > 0 then
    cbxPayee.ItemIndex := 0;
  cbxPayee.SetFocus;
end;

procedure TfrmDetail.btnPayeeXClick(Sender: TObject);
begin
  frmPayees.ShowModal;
  if cbxPayeeX.Items.Count > 0 then
    cbxPayeeX.ItemIndex := 0;
  cbxPayeeX.SetFocus;
end;

procedure TfrmDetail.btnAccountFromClick(Sender: TObject);
begin
  frmAccounts.ShowModal;
  if cbxAccountFrom.Items.Count > 0 then
    cbxAccountFrom.ItemIndex := 0;
  cbxAccountFrom.SetFocus;
end;

procedure TfrmDetail.actSaveExecute(Sender: TObject);
begin
  if pnlDetail.Visible = True then
  begin
    btnSaveXClick(btnSaveX);
    exit;
  end;

  if (btnSave.Enabled = True) then
    btnSaveClick(btnSave);
end;

procedure TfrmDetail.actAccountsExecute(Sender: TObject);
begin
  if tabKind.TabIndex = 0 then
    btnAccountFromClick(btnAccountFrom)
  else
    btnAccountXClick(btnAccountX);
end;

procedure TfrmDetail.actCalcExecute(Sender: TObject);
begin
  if tabKind.TabIndex = 0 then
    btnAmountFromClick(btnAmountFrom)
  else
    btnAmountXClick(btnAmountX);
end;

procedure TfrmDetail.actCategoriesExecute(Sender: TObject);
begin
  if tabKind.TabIndex = 0 then
    btnCategoryClick(btnCategory)
  else
    btnCategoryXClick(btnCategoryX);
end;

procedure TfrmDetail.actCommentsExecute(Sender: TObject);
begin
  if tabKind.TabIndex = 0 then
    btnCommentClick(btnComment)
  else
    btnCommentXClick(btnCommentX);
end;

procedure TfrmDetail.actPayeeExecute(Sender: TObject);
begin
  if tabKind.TabIndex = 0 then
    btnPayeeClick(btnPayee)
  else
    btnPayeeXClick(btnPayeeX);
end;

procedure TfrmDetail.actPersonsExecute(Sender: TObject);
begin
  if tabKind.TabIndex = 0 then
    btnPersonClick(btnPerson)
  else
    btnPersonXClick(btnPersonX);
end;

procedure TfrmDetail.actSimpleExecute(Sender: TObject);
begin
  tabKind.TabIndex := (Sender as TAction).Tag;
end;

procedure TfrmDetail.actTagsExecute(Sender: TObject);
begin
  if tabKind.TabIndex = 0 then
    btnTagClick(btnTag)
  else
    btnTagsXClick(btnTagsX);
end;

procedure TfrmDetail.btnAccountToClick(Sender: TObject);
begin
  frmAccounts.ShowModal;
  if cbxAccountTo.Items.Count > 0 then
    cbxAccountTo.ItemIndex := 0;
  cbxAccountTo.SetFocus;
end;

procedure TfrmDetail.btnAccountXClick(Sender: TObject);
begin
  frmAccounts.ShowModal;
  if cbxAccountX.Items.Count > 0 then
    cbxAccountX.ItemIndex := 0;
  cbxAccountX.SetFocus;
end;

procedure TfrmDetail.btnAddClick(Sender: TObject);
begin
  if tabKind.TabIndex = 0 then
    Exit;

  try
    // panel Detail
    pnlDetail.Visible := True;
    pnlDetail.Enabled := True;
    pnlDetail.Left := 0;

    splDetail.Visible := True;
    splDetail.Left := 0;

    pnlDetail.Color := frmSettings.btnCaptionColorFont.Tag;
    pnlDetailCaption.Caption := AnsiUpperCase(Caption_45);

    pnlButtonsX.Visible := True; // save and cancel
    pnlButtonsX.Repaint;
    pnlMenuX.Visible := False;

    // disabled components
    pnlLeft.Visible := False;
    pnlLeft.Enabled := False;
    splMultiple.Visible := False;
    VST.Enabled := False;

    // enabled buttons
    btnSaveX.Tag := 0;

    // set all fields FROM
    if chkAmountMinus.Checked = True then
      spiAmountX.Text := Format('%n', [spiBalance.Value])
    else
      spiAmountX.Text := Format('%n', [0.00]);

    if VST.TotalCount = 0 then
    begin
      cbxCommentX.ItemIndex := -1;
      if (cbxCategoryX.Items.Count > 0) then
      begin
        cbxCategoryX.ItemIndex := 0;
        cbxCategoryXChange(cbxCategoryX);
      end;
    end;

    if (cbxPersonX.ItemIndex = -1) and (cbxPersonX.Items.Count > 0) then
      cbxPersonX.ItemIndex := 0;

    // clear checked tags
    lbxTagsX.CheckAll(cbUnchecked, False, False);

    // disabled ActionList
    actAdd.Enabled := False;
    actEdit.Enabled := False;
    actDelete.Enabled := False;
    actSelect.Enabled := False;
    actSave.Enabled := True;

    pnlButtons.Visible := False;
    // panel Detail
    if cbxTypeX.ItemIndex = -1 then
    begin
      cbxTypeX.ItemIndex := 1;
      cbxTypeXChange(cbxTypeX);
    end;
    cbxTypeX.SetFocus;
  except
  end;
end;

procedure TfrmDetail.btnAmountFromClick(Sender: TObject);
begin
  frmMain.mnuCalcClick(frmMain.mnuCalc);
  spiAmountFrom.SetFocus;
end;

procedure TfrmDetail.btnAmountToClick(Sender: TObject);
begin
  frmMain.mnuCalcClick(frmMain.mnuCalc);
  spiAmountTo.SetFocus;
end;

procedure TfrmDetail.btnAmountXClick(Sender: TObject);
begin
  frmMain.mnuCalcClick(frmMain.mnuCalc);
  if pnlDetail.Visible = True then
    spiAmountX.SetFocus;
end;

procedure TfrmDetail.btnPersonClick(Sender: TObject);
begin
  frmPersons.ShowModal;
  if cbxPerson.Items.Count > 0 then
    cbxPerson.ItemIndex := 0;
  cbxPerson.SetFocus;
end;

procedure TfrmDetail.btnPersonXClick(Sender: TObject);
begin
  frmPersons.ShowModal;
  if pnlDetail.Visible = True then
  begin
    if cbxPersonX.Items.Count > 0 then
      cbxPersonX.ItemIndex := 0;
    cbxPersonX.SetFocus;
  end;
end;

procedure TfrmDetail.btnSaveClick(Sender: TObject);
label
  DoTransferPlusAlso;
var
  S: string;
  Amount: double;
  I, J, ID1, ID2: integer;
  N: PVirtualNode;
  Repeating: boolean;
begin
  // ============================
  // MULTIPLE ADDING TRANSACTIONS
  // ============================
  if tabKind.TabIndex = 1 then
  begin
    if (MessageDlg(Message_00, AnsiReplaceStr(Question_14, '%', sLineBreak),
      mtWarning, mbYesNo, 0) <> 6) then
      Exit;

    // check account
    if cbxAccountX.ItemIndex = -1 then
    begin
      ShowMessage(ReplaceStr(Error_04, '%', AnsiUpperCase(lblAccountX.Caption)));
      cbxAccountX.SetFocus;
      cbxAccountX.SelStart := Length(cbxAccountX.Text);
      Exit;
    end;

    frmMain.QRY.Close;
    // check older payment than was account created
    frmMain.QRY.SQL.Text := 'SELECT acc_date FROM accounts ' +
      'WHERE acc_currency = :CURRENCY AND acc_name = :ACCOUNT;';
    frmMain.QRY.Params.ParamByName('ACCOUNT').AsString :=
      Field(separ_1, cbxAccountX.Items[cbxAccountX.ItemIndex], 1);
    frmMain.QRY.Params.ParamByName('CURRENCY').AsString :=
      Field(separ_1, cbxAccountX.Items[cbxAccountX.ItemIndex], 2);
    frmMain.QRY.Prepare;
    frmMain.QRY.Open;
    if frmMain.QRY.RecordCount > 0 then
      if StrToDate(frmMain.QRY.Fields[0].AsString, 'YYYY-MM-DD', '-') >
        datDateX.Date then
      begin
        ShowMessage(
          AnsiReplaceStr(Error_13, '%', cbxAccountX.Items[cbxAccountX.ItemIndex]) +
          sLineBreak + DateToStr(StrToDate(frmMain.QRY.Fields[0].AsString,
          'YYYY-MM-DD', '-')));
        frmMain.QRY.Close;
        datDateX.SetFocus;
        Exit;
      end;
    frmMain.QRY.Close;

    // check date
    if IsValidDate(YearOf(datDateX.Date), MonthOf(datDateX.Date),
      DayOf(datDateX.Date)) = False then
    begin
      ShowMessage(ReplaceStr(Error_04, '%', AnsiUpperCase(lblDateX.Caption)));
      datDateX.SetFocus;
      Exit;
    end;

    // check payees
    if cbxPayeeX.ItemIndex = -1 then
    begin
      ShowMessage(ReplaceStr(Error_04, '%', AnsiUpperCase(lblPayeeX.Caption)));
      cbxPayeeX.SetFocus;
      cbxPayeeX.SelStart := Length(cbxPayeeX.Text);
      Exit;
    end;

    frmMain.Tran.Commit;
    // =========================================================================================

    for N in VST.Nodes() do
    begin
      frmMain.Tran.StartTransaction;
      frmMain.QRY.SQL.Text := 'INSERT INTO data (' +
        'd_date, d_type, d_comment, d_comment_lower, d_sum, d_person, ' +
        'd_category, d_account, d_payee, d_order) ' + sLineBreak +
        'VALUES (:DATE, :TYPE, :COMMENT, :COMMENTLOWER, :AMOUNT, ' +
        '(SELECT per_id FROM persons WHERE per_name = :PERSON), ' +
        sLineBreak + ':CATEGORY, ' + // d_category
        '(SELECT acc_id FROM accounts WHERE acc_name = :ACCOUNT and acc_currency = :CURRENCY), '
        + sLineBreak + '(SELECT pee_id FROM payees WHERE pee_name = :PAYEE),' +
        sLineBreak + '(SELECT COUNT (d_date) FROM data WHERE d_date = :DATE) + 1);';

      // set parameters  =========================================================================
      // date
      frmMain.QRY.Params.ParamByName('DATE').AsString :=
        FormatDateTime('YYYY-MM-DD', datDateX.Date);
      // type
      frmMain.QRY.Params.ParamByName('TYPE').AsString := VST.Text[N, 5];
      // comment
      frmMain.QRY.Params.ParamByName('COMMENT').AsString := VST.Text[N, 2];
      frmMain.QRY.Params.ParamByName('COMMENTLOWER').AsString :=
        AnsiLowerCase(VST.Text[N, 2]);
      // amount
      S := ReplaceStr(VST.Text[N, 1], FS_own.ThousandSeparator, '');
      TryStrToFloat(S, amount);
      S := AnsiReplaceStr(FloatToStr(amount), FS_own.DecimalSeparator, '.');
      frmMain.QRY.Params.ParamByName('AMOUNT').AsString := S;
      // account
      frmMain.QRY.Params.ParamByName('ACCOUNT').AsString :=
        Field(separ_1, cbxAccountX.Items[cbxAccountX.ItemIndex], 1);
      // currency
      frmMain.QRY.Params.ParamByName('CURRENCY').AsString :=
        Field(separ_1, cbxAccountX.Items[cbxAccountX.ItemIndex], 2);
      // person
      frmMain.QRY.Params.ParamByName('PERSON').AsString := VST.Text[N, 4];
      // payee
      frmMain.QRY.Params.ParamByName('PAYEE').AsString :=
        cbxPayeeX.Items[cbxPayeeX.ItemIndex];

      // category
      frmMain.QRY.Params.ParamByName('CATEGORY').AsInteger :=
        GetCategoryID(AnsiUpperCase(VST.Text[N, 3]));

      frmMain.QRY.Prepare;

      //ShowMessage (frmMain.QRY.SQL.Text);
      frmMain.QRY.ExecSQL;
      frmMain.Tran.Commit;

      // Write TAGS
      if Length(VST.Text[N, 7]) > 0 then
        if StrToInt(VST.Text[N, 7]) <> 0 then
        begin
          S := frmMain.Conn.GetInsertID.ToString;
          frmMain.Tran.StartTransaction;
          for I := 1 to StrToInt(VST.Text[N, 7]) do
          begin
            frmMain.QRY.SQL.Text :=
              'INSERT OR IGNORE INTO data_tags (dt_data, dt_tag) VALUES (' +
              S + ', (SELECT tag_id FROM tags WHERE tag_name = :TAG));';
            // ShowMessage(frmMain.QRY.SQL.Text);
            frmMain.QRY.Params.ParamByName('TAG').AsString :=
              Field('|', VST.Text[N, 6], I);
            frmMain.QRY.Prepare;
            frmMain.QRY.ExecSQL;
          end;
          frmMain.Tran.Commit;
        end;
    end;

    // ========================================================================================
    UpdateTransactions;
    btnSave.Tag := 1;
    frmDetail.ModalResult := mrOk;
    Exit;
  end;

  // =================================
  // SIMPLE ADDING TRANSACTION
  // =================================

  // check type
  if (cbxType.ItemIndex = -1) then
  begin
    ShowMessage(ReplaceStr(Error_04, '%', AnsiUpperCase(gbxType.Caption)));
    cbxType.SetFocus;
    Exit;
  end;

  // =================================================================================
  // check transfer transaction
  if (cbxType.ItemIndex = 2) and (cbxType.Enabled = True) then
  begin
    // check account to
    if cbxAccountTo.ItemIndex = -1 then
    begin
      ShowMessage(ReplaceStr(Error_04, '%', AnsiUpperCase(gbxAccountTo.Caption)));
      cbxAccountTo.SelStart := Length(cbxAccountTo.Text);
      cbxAccountTo.SetFocus;
      Exit;
    end;

    // check date
    if IsValidDate(YearOf(datDateTo.Date), MonthOf(datDateTo.Date),
      DayOf(datDateTo.Date)) = False then
    begin
      ShowMessage(ReplaceStr(Error_04, '%', AnsiUpperCase(gbxDateTo.Caption)));
      datDateTo.SetFocus;
      Exit;
    end;

    // check older payment than was account created
    frmMain.QRY.SQL.Text :=
      'SELECT acc_date FROM accounts WHERE acc_currency = :CURRENCY AND ' +
      'acc_name = :ACCOUNT;';
    frmMain.QRY.Params.ParamByName('ACCOUNT').AsString :=
      Field(separ_1, cbxAccountTo.Items[cbxAccountTo.ItemIndex], 1);
    frmMain.QRY.Params.ParamByName('CURRENCY').AsString :=
      Field(separ_1, cbxAccountTo.Items[cbxAccountTo.ItemIndex], 2);
    frmMain.QRY.Prepare;
    frmMain.QRY.Open;
    if frmMain.QRY.RecordCount > 0 then
      if StrToDate(frmMain.QRY.Fields[0].AsString, 'YYYY-MM-DD', '-') >
        datDateTo.Date then
      begin
        ShowMessage(
          AnsiReplaceStr(Error_13, '%', cbxAccountTo.Items[cbxAccountTo.ItemIndex]) +
          sLineBreak + DateToStr(StrToDate(frmMain.QRY.Fields[0].AsString,
          'YYYY-MM-DD', '-')));
        frmMain.QRY.Close;
        datDateTo.SetFocus;
        Exit;
      end;
    frmMain.QRY.Close;

    // check different accounts on transfer
    if (frmSettings.chkEnableSelfTransfer.Checked = False) and
      (cbxAccountFrom.ItemIndex = cbxAccountTo.ItemIndex) then
    begin
      S := ReplaceStr(Error_12, ' %1 ', sLineBreak + AnsiUpperCase(
        cbxAccountTo.Items[cbxAccountTo.ItemIndex]) + sLineBreak);
      S := ReplaceStr(S, ' %2 ', sLineBreak);
      ShowMessage(S + sLineBreak + sLineBreak + Error_28);
      cbxAccountFrom.SetFocus;
      Exit;
    end;
  end;

  // check restrictions
  if frmSettings.rbtTransactionsAddDate.Checked = True then
    if ((cbxType.ItemIndex < 2) and (datDateFrom.date <
      frmSettings.datTransactionsAddDate.Date)) or
      ((cbxType.ItemIndex = 2) and
      ((datDateTo.date < frmSettings.datTransactionsAddDate.Date) or
      (datDateFrom.date < frmSettings.datTransactionsAddDate.Date))) then
    begin
      ShowMessage(Error_29 + ' ' + DateToStr(frmSettings.datTransactionsAddDate.Date) +
        sLineBreak + Error_28);
      Exit;
    end;

  // check restrictions
  if frmSettings.rbtTransactionsAddDays.Checked = True then
    if ((cbxType.ItemIndex < 2) and (datDateFrom.Date <
      Round(Now - frmSettings.spiTransactionsAddDays.Value))) or
      ((cbxType.ItemIndex = 2) and
      ((datDateTo.Date < Round(Now - frmSettings.spiTransactionsAddDays.Value)) or
      (datDateFrom.Date < Round(Now - frmSettings.spiTransactionsAddDays.Value)))) then
    begin
      ShowMessage(Error_29 + ' ' +
        DateToStr(Now - frmSettings.spiTransactionsAddDays.Value) +
        sLineBreak + Error_28);
      Exit;
    end;

  // ==================================================================================
  // check all transactions
  // check account
  if cbxAccountFrom.ItemIndex = -1 then
  begin
    ShowMessage(ReplaceStr(Error_04, '%', AnsiUpperCase(gbxAccountFrom.Caption)));
    cbxAccountFrom.SetFocus;
    cbxAccountFrom.SelStart := Length(cbxAccountFrom.Text);
    Exit;
  end;

  // check date
  if IsValidDate(YearOf(datDateFrom.Date), MonthOf(datDateFrom.Date),
    DayOf(datDateFrom.Date)) = False then
  begin
    ShowMessage(ReplaceStr(Error_04, '%', AnsiUpperCase(gbxDateFrom.Caption)));
    datDateFrom.SetFocus;
    Exit;
  end;

  // check older payment than was account created
  frmMain.QRY.SQL.Text :=
    'SELECT acc_date FROM accounts WHERE acc_currency = :CURRENCY AND acc_name = :ACCOUNT;';

  frmMain.QRY.Params.ParamByName('CURRENCY').AsString :=
    Field(separ_1, cbxAccountFrom.Items[cbxAccountFrom.ItemIndex], 2);
  frmMain.QRY.Params.ParamByName('ACCOUNT').AsString :=
    Field(separ_1, cbxAccountFrom.Items[cbxAccountFrom.ItemIndex], 1);
  frmMain.QRY.Prepare;
  frmMain.QRY.Open;

  if frmMain.QRY.RecordCount > 0 then
    if StrToDate(frmMain.QRY.Fields[0].AsString, 'YYYY-MM-DD', '-') >
      datDateFrom.Date then
    begin
      ShowMessage(
        AnsiReplaceStr(Error_13, '%', cbxAccountFrom.Items[cbxAccountFrom.ItemIndex]) +
        sLineBreak + DateToStr(StrToDate(frmMain.QRY.Fields[0].AsString,
        'YYYY-MM-DD', '-')));
      frmMain.QRY.Close;
      datDateFrom.SetFocus;
      Exit;
    end;
  frmMain.QRY.Close;

  // check comment
  cbxCommentExit(cbxComment);

  // check categories
  if cbxCategory.ItemIndex = -1 then
  begin
    ShowMessage(ReplaceStr(Error_04, '%', AnsiUpperCase(gbxCategory.Caption)));
    cbxCategory.SetFocus;
    cbxCategory.SelStart := Length(cbxCategory.Text);
    Exit;
  end;

  // check subcategories
  if cbxSubcategory.ItemIndex = -1 then
  begin
    ShowMessage(ReplaceStr(Error_04, '%', AnsiUpperCase(gbxCategory.Caption)));
    cbxSubcategory.SetFocus;
    cbxSubcategory.SelStart := 0;
    cbxSubcategory.SelLength := Length(cbxSubcategory.Text);
    Exit;
  end;

  // check persons
  if cbxPerson.ItemIndex = -1 then
  begin
    ShowMessage(ReplaceStr(Error_04, '%', AnsiUpperCase(gbxPerson.Caption)));
    cbxPerson.SelStart := Length(cbxPerson.Text);
    cbxPerson.SetFocus;
    Exit;
  end;

  // check payees
  if cbxPayee.ItemIndex = -1 then
  begin
    ShowMessage(ReplaceStr(Error_04, '%', AnsiUpperCase(gbxPayee.Caption)));
    cbxPayee.SelStart := Length(cbxPayee.Text);
    cbxPayee.SetFocus;
    Exit;
  end;

  Repeating := False;
  case frmDetail.cbxType.ItemIndex of
    0: J := 0;
    1: J := 1;
    2: J := IfThen(frmMain.VST.Tag = 0, 3, cbxType.Tag);
  end;

  DoTransferPlusAlso:

      // =============================================================================================
      // ADD CREDIT, DEBIT OR TRANSFER DEBIT
      // =============================================================================================

    try
      // Add new category
      frmMain.QRY.SQL.Text := 'INSERT OR IGNORE INTO data (' +
        'd_date, d_type, d_comment, d_comment_lower, d_sum, ' +
        'd_person, d_category, d_account, d_payee, d_order) ' +
        sLineBreak + 'VALUES (:DATE, :TYPE, :COMMENT, :COMMENTLOWER, :AMOUNT, '
      + // d_sum
        '(SELECT per_id FROM persons WHERE per_name = :PERSON), ' +
        sLineBreak + // d_person
        ':CATEGORY, ' + sLineBreak + // d_category
        '(SELECT acc_id FROM accounts WHERE acc_name = :ACCOUNT and acc_currency = :CURRENCY), '
      + sLineBreak + // d_account
        '(SELECT pee_id FROM payees WHERE pee_name = :PAYEE),' + sLineBreak + // d_payee
        '(SELECT COUNT(d_date) FROM data WHERE d_date = :DATE) + 1);';

      // date
      if Repeating = False then
        frmMain.QRY.Params.ParamByName('DATE').AsString :=
          FormatDateTime('YYYY-MM-DD', frmDetail.datDateFrom.Date)
      else
        frmMain.QRY.Params.ParamByName('DATE').AsString :=
          FormatDateTime('YYYY-MM-DD', frmDetail.datDateTo.Date);

      // type
      frmMain.QRY.Params.ParamByName('TYPE').AsInteger := J;

      // comment
      if frmDetail.cbxComment.ItemIndex > -1 then
        frmMain.QRY.Params.ParamByName('COMMENT').AsString :=
          Trim(frmDetail.cbxComment.Items[frmDetail.cbxComment.ItemIndex])
      else
        frmMain.QRY.Params.ParamByName('COMMENT').AsString :=
          Trim(frmDetail.cbxComment.Text);

      // comment lower
      if frmDetail.cbxComment.ItemIndex > -1 then
        frmMain.QRY.Params.ParamByName('COMMENTLOWER').AsString :=
          Trim(AnsiLowerCase(frmDetail.cbxComment.Items[frmDetail.cbxComment.ItemIndex]))
      else
        frmMain.QRY.Params.ParamByName('COMMENTLOWER').AsString :=
          Trim(frmDetail.cbxComment.Text);

      // amount
      if Repeating = False then
        Amount := StrToFloat(Eval(frmDetail.spiAmountFrom.Text))
      else
        Amount := StrToFloat(Eval(frmDetail.spiAmountTo.Text));

      if J in [1, 3] then
        Amount := -Amount;
      S := FloatToStr(amount);
      frmMain.QRY.Params.ParamByName('AMOUNT').AsString :=
        ReplaceStr(S, FS_own.DecimalSeparator, '.');

      frmMain.QRY.Params.ParamByName('PERSON').AsString :=
        frmDetail.cbxPerson.Items[frmDetail.cbxPerson.ItemIndex];

      frmMain.QRY.Params.ParamByName('PAYEE').AsString :=
        frmDetail.cbxPayee.Items[frmDetail.cbxPayee.ItemIndex];

      if Repeating = False then
        frmMain.QRY.Params.ParamByName('ACCOUNT').AsString :=
          Field(separ_1, frmDetail.cbxAccountFrom.Items[
        frmDetail.cbxAccountFrom.ItemIndex], 1)
      else
        frmMain.QRY.Params.ParamByName('ACCOUNT').AsString :=
          Field(separ_1, frmDetail.cbxAccountTo.Items[
        frmDetail.cbxAccountTo.ItemIndex], 1);

      if Repeating = False then
        frmMain.QRY.Params.ParamByName('CURRENCY').AsString :=
          Field(separ_1, frmDetail.cbxAccountFrom.Items[
        frmDetail.cbxAccountFrom.ItemIndex], 2)
      else
        frmMain.QRY.Params.ParamByName('CURRENCY').AsString :=
          Field(separ_1, frmDetail.cbxAccountTo.Items[
        frmDetail.cbxAccountTo.ItemIndex], 2);

      // Get category
      frmMain.QRY.Params.ParamByName('CATEGORY').AsInteger :=
        GetCategoryID(cbxCategory.Items[cbxCategory.ItemIndex] +
      IfThen(cbxSubcategory.ItemIndex = 0, '', separ_1 +
      cbxSubcategory.Items[cbxSubcategory.ItemIndex]));

      frmMain.QRY.Prepare;
      frmMain.QRY.ExecSQL;
      frmMain.Tran.Commit;
    finally
    end;

  if Repeating = False then
    ID1 := frmMain.Conn.GetInsertID
  else
    ID2 := frmMain.Conn.GetInsertID;

  // write tags to joined table DATA_TAGS
  try
    if frmDetail.lbxTag.Count > 0 then
      for I := 0 to frmDetail.lbxTag.Count - 1 do
        if frmDetail.lbxTag.Checked[I] = True then
        begin
          frmMain.QRY.SQL.Text :=
            'INSERT OR IGNORE INTO data_tags (dt_data, dt_tag) VALUES (:ID, ' +
            '(SELECT tag_id FROM tags WHERE tag_name = :TAG));';
          frmMain.QRY.Params.ParamByName('ID').AsInteger :=
            IfThen(Repeating = False, ID1, ID2);
          frmMain.QRY.Params.ParamByName('TAG').AsString := frmDetail.lbxTag.Items[I];
          frmMain.QRY.Prepare;
          frmMain.QRY.ExecSQL;
          frmMain.Tran.Commit;
        end;
  except
  end;

  if (frmMain.VST.Tag = 0) and (frmDetail.cbxType.ItemIndex = 2) and
    (Repeating = False) then
  begin
    J := 2;
    Repeating := True;
    goto DoTransferPlusAlso;
  end;

  // write transfer debit to special table "transfers"
  try
    if frmDetail.cbxType.ItemIndex = 2 then
    begin
      frmMain.QRY.SQL.Text :=
        'INSERT OR IGNORE INTO transfers (tra_data1, tra_data2) VALUES (:ID1, :ID2);';
      frmMain.QRY.Params.ParamByName('ID1').AsInteger := ID1;
      frmMain.QRY.Params.ParamByName('ID2').AsInteger := ID2;
      frmMain.QRY.Prepare;
      frmMain.QRY.ExecSQL;
      frmMain.Tran.Commit;
    end;
  finally
  end;

  try
    UpdateTransactions;
    FindNewRecord(frmMain.VST, 10);
  finally
  end;

  // close form
  frmDetail.ModalResult := mrOk;
end;

procedure TfrmDetail.btnSaveXClick(Sender: TObject);
var
  Sum, Tags1, Tags2: string;
  Amount: double;
  I, J: word;
begin
  // check type
  if (cbxTypeX.ItemIndex = -1) then
  begin
    Sum := ReplaceStr(Error_04, '%', AnsiUpperCase(lblTypeX.Caption));
    ShowMessage(Sum);
    cbxTypeX.SetFocus;
    Exit;
  end;

  // check comment
  cbxCommentXExit(cbxCommentX);

  // check categories
  if cbxCategoryX.ItemIndex = -1 then
  begin
    ShowMessage(ReplaceStr(Error_04, '%', AnsiUpperCase(lblCategoryX.Caption)));
    cbxCategoryX.SetFocus;
    cbxCategoryX.SelStart := 0;
    cbxCategoryX.SelLength := Length(cbxCategoryX.Text);
    Exit;
  end;

  // check subcategories
  if cbxSubcategoryX.ItemIndex = -1 then
  begin
    ShowMessage(ReplaceStr(Error_04, '%', AnsiUpperCase(lblCategoryX.Caption)));
    cbxSubcategoryX.SetFocus;
    cbxSubcategoryX.SelStart := 0;
    cbxSubcategoryX.SelLength := Length(cbxSubcategoryX.Text);
    Exit;
  end;

  // check persons
  if cbxPersonX.ItemIndex = -1 then
  begin
    Sum := ReplaceStr(Error_04, '%', AnsiUpperCase(lblPersonX.Caption));
    ShowMessage(Sum);
    cbxPersonX.SetFocus;
    cbxPersonX.SelStart := Length(cbxPersonX.Text);
    Exit;
  end;

  // Get amount
  spiAmountX.Text := Eval(spiAmountX.Text);
  TryStrToFloat(spiAmountX.Text, amount);
  if (cbxTypeX.ItemIndex = 1) and (Amount <> 0.00) then
    Amount := -Amount;
  Sum := FloatToStr(amount);

  // =============================================================================================
  Tags1 := '';
  Tags2 := '';
  J := 0;

  if lbxTagsX.Items.Count > 0 then
  begin
    for I := 0 to lbxTagsX.Items.Count - 1 do
      if lbxTagsX.Checked[I] = True then
      begin
        Inc(J);
        Tags1 := Tags1 + lbxTagsX.Items[I] + '|';
        // NUTNÉ UPRAVIŤ !!!
        // Tags2 := Tags2 + Field(Separ, slTags.Strings[I], 1) + '|';
      end;
    Tags1 := LeftStr(Tags1, Length(Tags1) - 1);
    Tags2 := IntToStr(J);
  end;

  if btnSaveX.Tag = 0 then   // add new transaction
  begin
    slMultiple.Add( // add to the stringlist
      Sum + separ + // amount 1
      cbxCommentX.Text + separ + // comment 2
      cbxCategoryX.Items[cbxCategoryX.ItemIndex] +
      IfThen(cbxSubcategoryX.ItemIndex = 0, '', separ_1 +
      cbxSubcategoryX.Items[cbxSubcategoryX.ItemIndex]) + separ + // category 3
      cbxPersonX.Items[cbxPersonX.ItemIndex] + separ + // person 4
      IntToStr(cbxTypeX.ItemIndex) + separ + // credit or debit 5
      Tags1 + separ + Tags2);
  end
  else      // edit selected transaction
  begin
    slMultiple.Strings[VST.AbsoluteIndex(VST.GetFirstSelected())] :=
      // add to the stringlist
      Sum + separ + // amount 1
      cbxCommentX.Text + separ + // comment 2
      cbxCategoryX.Items[cbxCategoryX.ItemIndex] +
      IfThen(cbxSubcategoryX.ItemIndex = 0, '', separ_1 +
      cbxSubcategoryX.Items[cbxSubcategoryX.ItemIndex]) + separ + // category 3
      cbxPersonX.Items[cbxPersonX.ItemIndex] + separ + // person 4
      IntToStr(cbxTypeX.ItemIndex) + separ + // credit or debit 5
      Tags1 + separ + Tags2;
  end;

  btnCancelXClick(btnCancelX);
  UpdateMultiple;

  // open form NewTransaction again
  if frmSettings.chkOpenNewTransaction.Checked = True then
    btnAddClick(btnAdd);
end;

procedure TfrmDetail.btnSelectClick(Sender: TObject);
begin
  if (VST.Enabled = False) or (btnSelect.Enabled = False) or
    (frmMain.Conn.Connected = False) or (tabKind.TabIndex = 0) then
    Exit;

  VST.SelectAll(False);
  VST.SetFocus;
end;

procedure TfrmDetail.btnSettingsClick(Sender: TObject);
var
  vNode: TTreeNode;
begin
  for vNode in frmSettings.treSettings.Items do
    if vNode.AbsoluteIndex = 4 then
      vNode.Selected := True;
  frmSettings.ShowModal;
end;

procedure TfrmDetail.btnTagClick(Sender: TObject);
begin
  frmTags.ShowModal;
  lbxTag.SetFocus;
end;

procedure TfrmDetail.btnTagsXClick(Sender: TObject);
begin
  frmTags.ShowModal;
  if pnlDetail.Visible = True then
    lbxTagsX.SetFocus;
end;

procedure TfrmDetail.cbxAccountFromDropDown(Sender: TObject);
begin
  {$IFDEF WINDOWS}
    ComboDDWidth(TComboBox(Sender));
  {$ENDIF}
end;

procedure TfrmDetail.cbxAccountFromEnter(Sender: TObject);
begin
  (Sender as TComboBox).Font.Bold := True;
end;

procedure TfrmDetail.cbxAccountFromExit(Sender: TObject);
begin
  ComboBoxExit((Sender as TCombobox));
end;

procedure TfrmDetail.cbxAccountFromKeyUp(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  if (Key = 13) then
  begin
    Key := 0;
    if cbxAccountFrom.Items.Count = 0 then
      btnAccountFromClick(btnAccountFrom)
    else
      datDateFrom.SetFocus;
    Exit;
  end;
end;

procedure TfrmDetail.cbxAccountToKeyUp(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  if (Key = 13) then
  begin
    Key := 0;
    if cbxAccountTo.Items.Count = 0 then
      btnAccountToClick(btnAccountTo)
    else
      datDateTo.SetFocus;
  end;
end;

procedure TfrmDetail.cbxAccountXKeyUp(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  if (Key = 13) then
  begin
    Key := 0;
    if cbxAccountX.Items.Count = 0 then
      btnAccountXClick(btnAccountX)
    else
      datDateX.SetFocus;
  end;
end;

procedure TfrmDetail.cbxCategoryChange(Sender: TObject);
begin
  if cbxCategory.ItemIndex = -1 then
  begin
    cbxSubcategory.Clear;
    Exit;
  end;
  if cbxCategory.Tag <> cbxCategory.ItemIndex then
    FillSubcategory(cbxCategory.Items[cbxCategory.ItemIndex], cbxSubcategory);

  cbxCategory.Tag := cbxCategory.ItemIndex;
end;

procedure TfrmDetail.cbxCategoryExit(Sender: TObject);
var
  NeedUpdate: boolean;
begin
  ComboBoxExit((Sender as TCombobox));
  NeedUpdate := False;

  if (cbxSubcategory.ItemIndex = -1) or (cbxCategory.ItemIndex = -1) then
  begin
    cbxCategory.ItemIndex := cbxCategory.Items.IndexOf(cbxCategory.Text);
    NeedUpdate := True;
  end;

  if (cbxCategory.ItemIndex = -1) then
    cbxSubcategory.Clear
  else
  if NeedUpdate = True then
    FillSubcategory(cbxCategory.Text, cbxSubcategory);
end;

procedure TfrmDetail.cbxCategoryKeyUp(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  if (Key = 13) then
  begin
    Key := 0;
    if cbxCategory.Items.Count = 0 then
      btnCategoryClick(btnCategory)
    else
      cbxSubcategory.SetFocus;
  end;
end;

procedure TfrmDetail.cbxCategoryXChange(Sender: TObject);
begin
  if cbxCategoryX.ItemIndex = -1 then
  begin
    cbxSubcategoryX.Clear;
    Exit;
  end;

  if cbxCategoryX.Tag <> cbxCategoryX.ItemIndex then
    FillSubcategory(cbxCategoryX.Items[cbxCategoryX.ItemIndex], cbxSubcategoryX);

  cbxCategoryX.Tag := cbxCategoryX.ItemIndex;
end;

procedure TfrmDetail.cbxCategoryXExit(Sender: TObject);
var
  NeedUpdate: boolean;
begin
  ComboBoxExit((Sender as TCombobox));
  NeedUpdate := False;

  if (cbxCategoryX.ItemIndex = -1) then
  begin
    cbxCategoryX.ItemIndex := cbxCategoryX.Items.IndexOf(cbxCategoryX.Text);
    NeedUpdate := True;
  end;

  if (cbxCategoryX.ItemIndex = -1) then
    cbxSubcategoryX.Clear
  else
  if NeedUpdate = True then
    FillSubcategory(cbxCategoryX.Text, cbxSubcategoryX);
end;

procedure TfrmDetail.cbxCategoryXKeyUp(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 0;
    cbxSubcategoryX.SetFocus;
  end;
end;

procedure TfrmDetail.cbxCommentEnter(Sender: TObject);
begin
  cbxComment.Font.Style := [fsBold];
end;

procedure TfrmDetail.cbxCommentExit(Sender: TObject);
var
  W: word;
begin
  if ((Sender as TComboBox).Items.Count > 0) and ((Sender as TComboBox).Text <> '') then
    for W := 0 to (Sender as TComboBox).Items.Count - 1 do
      if AnsiLowerCase((Sender as TComboBox).Items[W]) = AnsiLowerCase(
        (Sender as TComboBox).Text) then
      begin
        (Sender as TComboBox).ItemIndex := W;
        break;
      end;
  ComboBoxExit((Sender as TComboBox));
end;

procedure TfrmDetail.cbxCommentKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if (Key = 13) then
  begin
    Key := 0;
    cbxCategory.SetFocus;
  end;
end;

procedure TfrmDetail.cbxCommentXExit(Sender: TObject);
var
  W: word;
begin
  if ((Sender as TComboBox).Items.Count > 0) and ((Sender as TComboBox).Text <> '') then
    for W := 0 to (Sender as TComboBox).Items.Count - 1 do
      if AnsiLowerCase((Sender as TComboBox).Items[W]) = AnsiLowerCase(
        (Sender as TComboBox).Text) then
      begin
        (Sender as TComboBox).ItemIndex := W;
        break;
      end;
  ComboBoxExit((Sender as TComboBox));
end;

procedure TfrmDetail.cbxCommentXKeyUp(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 0;
    cbxCategoryX.SetFocus;
  end;
end;

procedure TfrmDetail.cbxPayeeKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if (Key = 13) then
  begin
    if cbxPayee.Items.Count = 0 then
      btnPayeeClick(btnPayee)
    else
      lbxTag.SetFocus;
  end;
end;

procedure TfrmDetail.cbxPayeeXKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 0;
    chkAmountMinus.SetFocus;
  end;
end;

procedure TfrmDetail.cbxPersonKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if (Key = 13) then
  begin
    Key := 0;
    if cbxPerson.Items.Count = 0 then
      btnPersonClick(btnPerson)
    else
      cbxPayee.SetFocus;
  end;
end;

procedure TfrmDetail.cbxPersonXKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 0;
    lbxTagsX.SetFocus;
  end;
end;

procedure TfrmDetail.cbxSubcategoryExit(Sender: TObject);
begin
  if (cbxSubcategory.ItemIndex = -1) then
    cbxSubcategory.ItemIndex := cbxSubcategory.Items.IndexOf(cbxSubcategory.Text);
  ComboBoxExit(cbxSubcategory);
end;

procedure TfrmDetail.cbxSubcategoryKeyUp(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  if (Key = 13) then
  begin
    Key := 0;
    cbxPerson.SetFocus;
  end;
end;

procedure TfrmDetail.cbxSubcategoryXKeyUp(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 0;
    cbxPersonX.SetFocus;
  end;
end;

procedure TfrmDetail.cbxTypeKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 0;
    cbxAccountFrom.SetFocus;
  end;
end;

procedure TfrmDetail.cbxTypeXChange(Sender: TObject);
begin
  cbxCategoryX.Tag := -1;
  FillCategory(cbxCategoryX, cbxTypeX.ItemIndex);
  cbxCategoryXChange(cbxCategoryX);
end;

procedure TfrmDetail.cbxTypeXEnter(Sender: TObject);
begin
  if Sender.ClassType = TComboBox then
    (Sender as TComboBox).Font.Style := [fsBold]
  else if Sender.ClassType = TEdit then
    (Sender as TEdit).Font.Style := [fsBold]
  else if Sender.ClassType = TCheckBox then
    (Sender as TCheckBox).Font.Style := [fsBold]
  else if Sender.ClassType = TCheckListBox then
    (Sender as TCheckListBox).Font.Style := [fsBold]
  else if Sender.ClassType = TDateTimePicker then
    (Sender as TDateTimePicker).Font.Style := [fsBold];
end;

procedure TfrmDetail.cbxTypeXExit(Sender: TObject);
begin
  if Sender.ClassType = TComboBox then
    ComboBoxExit((Sender as TComboBox))
  else if Sender.ClassType = TCheckBox then
    (Sender as TCheckBox).Font.Bold := False
  else if Sender.ClassType = TCheckListBox then
    (Sender as TCheckListBox).Font.Bold := False
  else if Sender.ClassType = TDateTimePicker then
    (Sender as TDateTimePicker).Font.Bold := False;
end;

procedure TfrmDetail.cbxTypeXKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 0;
    spiAmountX.SetFocus;
  end;
end;

procedure TfrmDetail.chkAmountMinusChange(Sender: TObject);
begin
  spiAmountMinus.Enabled := chkAmountMinus.Checked;
end;

procedure TfrmDetail.datDateFromChange(Sender: TObject);
begin
  lblDateFrom.Caption := DefaultFormatSettings.LongDayNames[DayOfTheWeek(
    datDateFrom.Date + 1)];
  if (cbxType.ItemIndex = 2) and (btnSave.Tag = 0) and (frmDetail.Visible = True) then
  begin
    datDateTo.Date := datDateFrom.Date;
    datDateToChange(datDateTo);
  end;
end;

procedure TfrmDetail.datDateFromDropDown(Sender: TObject);
begin
  (Sender as TDateTimePicker).Tag := 1;
end;

procedure TfrmDetail.datDateFromEnter(Sender: TObject);
begin
  (Sender as TDateTimePicker).Font.Style := [fsBold];
end;

procedure TfrmDetail.datDateFromExit(Sender: TObject);
begin
  (Sender as TDateTimePicker).Font.Style := [];
end;

procedure TfrmDetail.datDateFromKeyDown(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  if (key = 27) and ((Sender as TDateTimePicker).Tag = 0) then
  begin
    Key := 0;
    btnCancelClick(btnCancel);
  end;
  datDateFrom.Tag := 0;
end;

procedure TfrmDetail.datDateFromKeyUp(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  if (Key = 13) then
  begin
    Key := 0;
    spiAmountFrom.SetFocus;
  end;
end;

procedure TfrmDetail.datDateToChange(Sender: TObject);
begin
  lblDateTo.Caption := DefaultFormatSettings.LongDayNames[DayOfTheWeek(
    datDateTo.Date + 1)];
end;

procedure TfrmDetail.datDateToKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if (Key = 13) then
  begin
    Key := 0;
    spiAmountTo.SetFocus;
  end
  else if (key = 27) and (datDateTo.Tag = 0) then
  begin
    Key := 0;
    btnCancelClick(btnCancel);
  end;
  datDateTo.Tag := 0;
end;

procedure TfrmDetail.datDateXChange(Sender: TObject);
begin
  lblDateX1.Caption := DefaultFormatSettings.ShortDayNames[DayOfTheWeek(
    datDateX.Date + 1)];
end;

procedure TfrmDetail.datDateXKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 0;
    cbxPayeeX.SetFocus;
  end;
end;

procedure TfrmDetail.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var
  INI: TINIFile;
  INIFile: string;
begin
  if (pnlDetail.Visible = True) then
  begin
    btnCancelXClick(btnCancelX);
    CloseAction := Forms.caNone;
    Exit;
  end;

  if (tabKind.TabIndex = 1) and (btnSave.Tag = 0) and (VST.RootNodeCount > 0) and
    (MessageDlg(Message_00, AnsiReplaceStr(Question_13, '%', sLineBreak),
    mtWarning, mbYesNo, 0) <> 6) then
  begin
    CloseAction := Forms.caNone;
    Exit;
  end;

  // write position and window size
  if frmSettings.chkLastFormsSize.Checked = True then
  begin
    try
      INIFile := ChangeFileExt(ParamStr(0), '.ini');
      INI := TINIFile.Create(INIFile);
      if INI.ReadString('POSITION', frmDetail.Name, '') <>
        IntToStr(frmDetail.Left) + separ + // form left
      IntToStr(frmDetail.Top) + separ + // from top
      IntToStr(frmDetail.Height) + separ + // form height
      IntToStr(frmDetail.pnlSimple.Tag) + separ + // pnlSimple tag (aka width)
      IntToStr(frmDetail.pnlMultiple.Tag) + separ + // pnlMultiple tag (aka width)
      IntToStr(frmDetail.pnlRight.Width) + separ + // pnlRight width
      IntToStr(frmDetail.pnlLeft.Width) + separ + // pnlLeft width
      IntToStr(frmDetail.pnlDetail.Width) then
        INI.WriteString('POSITION', frmDetail.Name,
          IntToStr(frmDetail.Left) + separ + // form left
          IntToStr(frmDetail.Top) + separ + // from top
          IntToStr(frmDetail.Height) + separ + // form height
          IntToStr(frmDetail.pnlSimple.Tag) + separ + // pnlSimple tag (aka width)
          IntToStr(frmDetail.pnlMultiple.Tag) + separ + // pnlMultiple tag (aka width)
          IntToStr(frmDetail.pnlRight.Width) + separ + // pnlRight width
          IntToStr(frmDetail.pnlLeft.Width) + separ + // pnlLeft width
          IntToStr(frmDetail.pnlDetail.Width)); // pnlDetail width
    finally
      INI.Free;
    end;
  end;
end;

procedure TfrmDetail.FormDestroy(Sender: TObject);
begin
  slMultiple.Free;
end;

procedure TfrmDetail.lblDateFromClick(Sender: TObject);
begin
  datDateFrom.SetFocus;
end;

procedure TfrmDetail.lblDateToClick(Sender: TObject);
begin
  datDateTo.SetFocus;
end;

procedure TfrmDetail.lblWidthClick(Sender: TObject);
begin

end;

procedure TfrmDetail.lbxTagsXKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 0;
    btnSaveX.SetFocus;
  end;
end;

procedure TfrmDetail.pnlBottomResize(Sender: TObject);
begin
  btnCancel.Width := (pnlBottom.Width - pnlWidth.Width - pnlHeight.Width - 10) div 3;
  btnSettings.Width := btnCancel.Width;

  btnSave.Repaint;
  btnCancel.Repaint;
  btnSettings.Repaint;
end;

procedure TfrmDetail.pnlMenuXResize(Sender: TObject);
begin
  btnAdd.Width := (pnlMenuX.Width - 10) div 5;
  btnDuplicate.Width := btnAdd.Width;
  btnEdit.Width := btnAdd.Width;
  btnDelete.Width := btnAdd.Width;
  pnlMenuX.Repaint;
end;

procedure TfrmDetail.pnlSizeResize(Sender: TObject);
begin
  pnlWidth.Width := Round(pnlSize.Width div 2);
end;

procedure TfrmDetail.spiAmountFromChange(Sender: TObject);
begin
  if (cbxType.ItemIndex = 2) and (btnSave.Tag = 0) then
    spiAmountTo.Text := Eval(spiAmountFrom.Text);
end;

procedure TfrmDetail.spiAmountFromClick(Sender: TObject);
begin
  try
    if TEdit(Sender).Tag = 0 then
    begin
      TEdit(Sender).SelectAll;
      TEdit(Sender).Tag := 1;
    end;
  except
  end;
end;

procedure TfrmDetail.spiAmountFromEnter(Sender: TObject);
begin
  try
    if TEdit(Sender).Cursor = crHandPoint then
    begin
      TEdit(Sender).Cursor := crDefault;
      TEdit(Sender).Font.Bold := True;
    end;
  except
  end;
end;

procedure TfrmDetail.spiAmountFromExit(Sender: TObject);
var
  D: double;
begin
  try
    TryStrToFloat(Eval(TEdit(Sender).Text), D);
    TEdit(Sender).Text := Format('%n', [D], FS_own);
    TEdit(Sender).Font.Style := [];
    TEdit(Sender).SelStart := Length(TEdit(Sender).Text);
    TEdit(Sender).SelLength := 0;
    TEdit(Sender).Tag := 0;
    TEdit(Sender).Cursor := crHandPoint;
  except
  end;
end;

procedure TfrmDetail.spiAmountFromKeyUp(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  if (Key = 13) then
  begin
    Key := 0;
    if (cbxType.ItemIndex = 2) and (gbxTo.Visible = True) then
    begin
      cbxAccountTo.SetFocus;
    end
    else
      cbxComment.SetFocus;
  end;
end;

procedure TfrmDetail.spiAmountMinusChange(Sender: TObject);
begin
  UpdateMultiple;
end;

procedure TfrmDetail.spiAmountMinusKeyUp(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 0;
    btnAdd.SetFocus;
  end;
end;

procedure TfrmDetail.spiAmountToKeyUp(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  if (Key = 13) then
  begin
    Key := 0;
    cbxComment.SetFocus;
  end;
end;

procedure TfrmDetail.FormCreate(Sender: TObject);
begin
  // set dates
  frmDetail.datDateFrom.Date := Now();
  frmDetail.datDateTo.Date := Now();

  // set the date format
  datDateX.Date := Now;

  slMultiple := TStringList.Create;

  // set components height
  VST.Header.Height := PanelHeight;
  pnlBasicCaption.Height := PanelHeight;
  pnlListCaption.Height := PanelHeight;
  pnlDetailCaption.Height := PanelHeight;

  pnlButtonsX.Height := ButtonHeight;
  pnlMenuX.Height := ButtonHeight;
  pnlBottom.Height := ButtonHeight + 4;

  // get form icon
  frmMain.img16.GetIcon(19, (Sender as TForm).Icon);
end;

procedure TfrmDetail.FormResize(Sender: TObject);
begin
  imgWidth.ImageIndex := 0;
  lblWidth.Caption := IntToStr((Sender as TForm).Width);

  imgHeight.ImageIndex := 1;
  lblHeight.Caption := IntToStr((Sender as TForm).Height);

  if tabKind.TabIndex = 0 then
    pnlSimple.Tag := frmDetail.Width
  else
    pnlMultiple.Tag := frmDetail.Width;
end;

procedure TfrmDetail.FormShow(Sender: TObject);
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
      frmDetail.Position := poDesigned;
      S := INI.ReadString('POSITION', frmDetail.Name,
        '-1•-1•0•600•900•200•200•200');

      /// height
      TryStrToInt(Field(Separ, S, 3), I);
      if (I < 1) or (I > Screen.Height) then
        frmDetail.Height := 530
      else
        frmDetail.Height := I;

      // width of simple form
      TryStrToInt(Field(Separ, S, 4), I);
      if (I < 1) or (I > Screen.Width) then
        I := 700;
      frmDetail.pnlSimple.Tag := I;

      // width of multiple form
      TryStrToInt(Field(Separ, S, 5), I);
      if (I < 1) or (I > Screen.Width) then
        I := Screen.Width - 300 - (200 - ScreenRatio);
      frmDetail.pnlMultiple.Tag := I;

      if tabKind.TabIndex = 0 then
        frmDetail.Width := frmDetail.pnlSimple.Tag
      else
        frmDetail.Width := frmDetail.pnlMultiple.Tag;

      // left
      TryStrToInt(Field(Separ, S, 1), I);
      if (I < 0) or (I > Screen.Width) then
        frmDetail.left := (Screen.Width - frmDetail.Width) div 2
      else
        frmDetail.Left := I;

      // top
      TryStrToInt(Field(Separ, S, 2), I);
      if (I < 0) or (I > Screen.Height) then
        frmDetail.Top := ((Screen.Height - frmDetail.Height) div 2) - 75
      else
        frmDetail.Top := I;

      // right panel (simple)
      TryStrToInt(Field(Separ, S, 6), I);
      if (I < 150) or (I > 400) then
        frmDetail.pnlRight.Width := 220
      else
        frmDetail.pnlRight.Width := I;

      // left panel (multiple)
      TryStrToInt(Field(Separ, S, 7), I);
      if (I < 150) or (I > 400) then
        frmDetail.pnlLeft.Width := 220
      else
        frmDetail.pnlLeft.Width := I;

      // detail panel (multiple)
      TryStrToInt(Field(Separ, S, 8), I);
      if (I < 200) or (I > 400) then
        frmDetail.pnlDetail.Width := 220
      else
        frmDetail.pnlDetail.Width := I;
    end;
  finally
    INI.Free
  end;

  // ********************************************************************
  // FORM SIZE END
  // ********************************************************************

  lblDateFrom.Caption := DefaultFormatSettings.LongDayNames[DayOfTheWeek(
    datDateFrom.Date + 1)];
  lblDateTo.Caption := DefaultFormatSettings.LongDayNames[DayOfTheWeek(
    datDateTo.Date + 1)];
  popAdd.Enabled := frmMain.Conn.Connected = True;
  btnAdd.Enabled := frmMain.Conn.Connected = True;

  if tabKind.TabIndex = 0 then
  begin
    if frmDetail.Visible = True then
    begin
      actAdd.Enabled := False;
      actEdit.Enabled := False;
      actDuplicate.Enabled := False;
      actDelete.Enabled := False;
    end;
    if cbxType.Enabled = True then
      cbxType.SetFocus
    else
      cbxAccountFrom.SetFocus;
  end
  else
  begin
    if frmDetail.Visible = True then
    begin
      actAdd.Enabled := True;
      actEdit.Enabled := True;
      actDuplicate.Enabled := True;
      actDelete.Enabled := True;
    end;
    cbxAccountX.SetFocus;
  end;
end;

procedure TfrmDetail.lbxTagEnter(Sender: TObject);
begin
  (Sender as TCheckListBox).Font.Bold := True;

end;

procedure TfrmDetail.lbxTagExit(Sender: TObject);
begin
  (Sender as TCheckListBox).Font.Bold := False;
end;

procedure TfrmDetail.lbxTagKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 0;
    btnSaveClick(btnSave);
  end;
end;

procedure TfrmDetail.pnlClientResize(Sender: TObject);
begin
  gbxTo.Width := (pnlClient.Width - 12) div 2;
end;

procedure TfrmDetail.spiAmountXKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 0;
    cbxCommentX.SetFocus;
  end;
end;

procedure TfrmDetail.splSimpleCanResize(Sender: TObject; var NewSize: integer;
  var Accept: boolean);
begin
  try
    imgHeight.ImageIndex := 2;
    lblHeight.Caption := IntToStr(pnlRight.Width);

    imgWidth.ImageIndex := 3;
    lblWidth.Caption := IntToStr(frmDetail.Width - pnlRight.Width);

    pnlRight.Tag := pnlRight.Width;
    pnlBottom.Repaint;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmDetail.tabKindChange(Sender: TObject);
begin
  if frmMain.Visible = False then
    Exit;
  pnlSimple.Visible := tabKind.TabIndex = 0;
  pnlMultiple.Visible := tabKind.TabIndex = 1;

  case tabKind.TabIndex of
    0: begin
      frmDetail.Width := pnlSimple.Tag;
      if frmDetail.Visible = True then
      begin
        cbxAccountFrom.ItemIndex := cbxAccountX.ItemIndex;
        cbxPayee.ItemIndex := cbxPayeeX.ItemIndex;
        datDateFrom.Date := datDateX.Date;
        cbxType.SetFocus;
        actAdd.Enabled := False;
        actEdit.Enabled := False;
        actDuplicate.Enabled := False;
        actDelete.Enabled := False;
        frmDetail.btnSave.Enabled := True;
        frmDetail.actSave.Enabled := True;
      end;
    end
    else
    begin
      frmDetail.Width := pnlMultiple.Tag;
      btnSave.Tag := 0;
      cbxAccountX.ItemIndex := cbxAccountFrom.ItemIndex;
      cbxPayeeX.ItemIndex := cbxPayee.ItemIndex;
      datDateX.Date := datDateFrom.Date;
      chkAmountMinus.Checked := False;
      spiAmountMinus.Value := 0.0;
      VST.Clear;
      slMultiple.Clear;
      if frmDetail.Visible = True then
      begin
        actAdd.Enabled := True;
        actEdit.Enabled := True;
        actDuplicate.Enabled := True;
        actDelete.Enabled := True;
        cbxAccountX.SetFocus;
        frmDetail.btnSave.Enabled := frmDetail.VST.RootNodeCount > 0;
        frmDetail.actSave.Enabled := frmDetail.VST.RootNodeCount > 0;
      end;
    end;
  end;
  frmDetail.Left := (Screen.Width - frmDetail.Width) div 2;
end;

procedure TfrmDetail.tabKindChanging(Sender: TObject; var AllowChange: boolean);
begin
  if frmDetail.Visible = True then
    if tabKind.TabIndex = 0 then
      pnlSimple.Tag := frmDetail.Width
    else
      pnlMultiple.Tag := frmDetail.Width;

  if (frmDetail.Visible = True) and ((pnlDetail.Visible = True) or
    ((tabKind.TabIndex = 1) and (pnlDetail.Visible = False) and
    (VST.RootNodeCount > 0)) and
    (MessageDlg(Message_00, AnsiReplaceStr(Question_13, '%', sLineBreak),
    mtWarning, mbYesNo, 0) <> mrYes)) then
    AllowChange := False;
end;

procedure TfrmDetail.VSTBeforeCellPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
begin
  TargetCanvas.Brush.Color := IfThen(Node.Index mod 2 = 0, clWhite,
    frmSettings.pnlOddRowColor.Color);
  TargetCanvas.FillRect(CellRect);
end;

procedure TfrmDetail.VSTChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
begin
  // buttons
  btnEdit.Enabled := VST.SelectedCount = 1;
  btnDuplicate.Enabled := VST.SelectedCount = 1;
  btnDelete.Enabled := VST.SelectedCount > 0;

  // actions
  actEdit.Enabled := VST.SelectedCount = 1;
  actDuplicate.Enabled := VST.SelectedCount = 1;
  actDelete.Enabled := VST.SelectedCount > 0;

  // popup menu
  popEdit.Enabled := VST.SelectedCount = 1;
  popDuplicate.Enabled := VST.SelectedCount = 1;
  popDelete.Enabled := VST.SelectedCount > 0;
end;

procedure TfrmDetail.VSTDblClick(Sender: TObject);
begin
  if VST.SelectedCount = 0 then
    btnAddClick(btnAdd)
  else if VST.SelectedCount = 1 then
    btnEditClick(popEdit);
end;

procedure TfrmDetail.VSTGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: boolean; var ImageIndex: integer);
begin
  if Column > 0 then
    Exit;

  ImageIndex := StrToInt(VST.Text[Node, 5]);
end;

procedure TfrmDetail.VSTGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
var
  MM: integer;
  D: double;
begin
  try
    MM := Node.Index;
  finally
    case Column of
      // amount
      1: begin
        TryStrToFloat(Field(separ, slMultiple.Strings[MM], 1), D);
        CellText := Format('%n', [D], FS_own);
      end;
      // comment
      2: CellText := Field(Separ, slMultiple.Strings[MM], 2);
      // category
      3: CellText := Field(Separ, slMultiple.Strings[MM], 3);
      // person
      4: CellText := Field(Separ, slMultiple.Strings[MM], 4);
      // type
      5: CellText := Field(Separ, slMultiple.Strings[MM], 5);
      // tag
      6: CellText := Field(Separ, slMultiple.Strings[MM], 6);
      // tag id
      7: CellText := Field(Separ, slMultiple.Strings[MM], 7);
    end;
  end;
end;

procedure TfrmDetail.VSTResize(Sender: TObject);
var
  X: integer;
begin
  if frmSettings.chkAutoColumnWidth.Checked = False then Exit;

  (Sender as TLazVirtualStringTree).Header.Columns[0].Width :=
    round(Screen.PixelsPerInch div 96 * 25);
  X := (VST.Width - VST.Header.Columns[0].Width) div 100;
  VST.Header.Columns[1].Width := 20 * X; // amount
  VST.Header.Columns[2].Width :=
    VST.Width - VST.Header.Columns[0].Width - ScrollBarWidth - (65 * X); // comment
  VST.Header.Columns[3].Width := 30 * X; // category
  VST.Header.Columns[4].Width := 15 * X; // person
end;

procedure UpdateMultiple;
var
  D1, D2: double;
  I: word;
begin
  try
    frmDetail.VST.rootnodecount := 0;
    frmDetail.VST.Clear;
    frmDetail.VST.RootNodeCount := slMultiple.Count;
    SetNodeHeight(frmDetail.VST);
    frmDetail.VST.Repaint;

    frmDetail.btnEdit.Enabled := False;
    frmDetail.actEdit.Enabled := False;
    frmDetail.popEdit.Enabled := False;

    frmDetail.btnDelete.Enabled := False;
    frmDetail.actDelete.Enabled := False;
    frmDetail.popDelete.Enabled := False;

    frmDetail.btnDuplicate.Enabled := False;
    frmDetail.actDuplicate.Enabled := False;
    frmDetail.popDuplicate.Enabled := False;

    frmDetail.btnSelect.Enabled := frmDetail.VST.RootNodeCount > 0;
    frmDetail.actSelect.Enabled := frmDetail.VST.RootNodeCount > 0;
    frmDetail.popSelect.Enabled := frmDetail.VST.RootNodeCount > 0;

    frmDetail.btnSave.Enabled := frmDetail.VST.RootNodeCount > 0;
    frmDetail.actSave.Enabled := frmDetail.VST.RootNodeCount > 0;

    D2 := 0.00;

    frmDetail.spiBalance.Value := 0.00;
    frmDetail.spiSummary.Value := 0.00;

    // summary of amounts in the list
    if slMultiple.Count > 0 then
    begin
      for I := 0 to slMultiple.Count - 1 do
      begin
        TryStrToFloat(Field(separ, slMultiple.Strings[I], 1), D1);
        D2 := D2 + D1;
      end;
      frmDetail.spiSummary.Value := D2;
    end;

    // =====================================================================
    // item icon
    //frmDetail.pnlItem.Visible := frmDetail.VST.RootNodeCount > 0;
    //frmDetail.lblItem.Caption := '';

    // items icon
    //frmDetail.pnlItems.Visible := frmDetail.VST.RootNodeCount > 0;
    //frmDetail.lblItems.Caption := IntToStr(slMultiple.Count);

    //if frmDetail.pnlItem.Visible = True then frmDetail.pnlItem.Left := 0;

    if frmDetail.chkAmountMinus.Checked = False then
      Exit;

    // deducted amount
    frmDetail.spiBalance.Value := frmDetail.spiAmountMinus.Value + D2;
  except
  end;
end;

end.
