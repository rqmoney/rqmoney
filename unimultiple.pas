unit uniMultiple;

{$mode objfpc}{$H+}
{$ModeSwitch AutoDeref}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  ComCtrls, Buttons, CheckLst, ActnList, Menus, Spin, laz.VirtualTrees,
  DateTimePicker, BCPanel, BCMDButtonFocus, StrUtils, DateUtils, Math;

type

  { TfrmMultiple }

  TfrmMultiple = class(TForm)
    actExit: TAction;
    actAdd: TAction;
    actEdit: TAction;
    actDelete: TAction;
    actDuplicate: TAction;
    actSelect: TAction;
    actSave: TAction;
    ActionList1: TActionList;
    btnAccount: TSpeedButton;
    btnAdd: TBCMDButtonFocus;
    btnAmount: TSpeedButton;
    btnCancel: TBCMDButtonFocus;
    btnCategory: TSpeedButton;
    btnComment: TSpeedButton;
    btnDelete: TBCMDButtonFocus;
    btnDuplicate: TBCMDButtonFocus;
    btnEdit: TBCMDButtonFocus;
    btnExit: TBCMDButtonFocus;
    btnPerson: TSpeedButton;
    btnSave: TBCMDButtonFocus;
    btnSelect: TBCMDButtonFocus;
    btnTags: TSpeedButton;
    btnPayee: TSpeedButton;
    btnWrite: TBCMDButtonFocus;
    cbxAccount: TComboBox;
    cbxCategory: TComboBox;
    cbxComment: TComboBox;
    cbxPayee: TComboBox;
    cbxPerson: TComboBox;
    cbxType: TComboBox;
    datDate: TDateTimePicker;
    spiSummary: TFloatSpinEdit;
    spiBalance: TFloatSpinEdit;
    lblDate1: TLabel;
    pnlDate1: TPanel;
    spiAmountMinus: TFloatSpinEdit;
    spiAmount: TFloatSpinEdit;
    lblAmount: TLabel;
    lblCategory: TLabel;
    lblComment: TLabel;
    lblPerson: TLabel;
    lblSummaryInList: TLabel;
    imgHeight: TImage;
    imgItem: TImage;
    imgItems: TImage;
    imgWidth: TImage;
    lblAccount: TLabel;
    chkAmountMinus: TCheckBox;
    lblDate: TLabel;
    lblHeight: TLabel;
    lblItem: TLabel;
    lblItems: TLabel;
    lblPayee: TLabel;
    lblBalance_: TLabel;
    lblTag: TLabel;
    lblType: TLabel;
    lblWidth: TLabel;
    lbxTags: TCheckListBox;
    popExit: TMenuItem;
    Panel1: TPanel;
    Separator1: TMenuItem;
    VST: TLazVirtualStringTree;
    pnlMenu: TPanel;
    popAdd: TMenuItem;
    popEdit: TMenuItem;
    popDelete: TMenuItem;
    popSelect: TMenuItem;
    popDuplicate: TMenuItem;
    pnlBottom: TPanel;
    pnlAmount: TPanel;
    pnlBasicCaption: TBCPanel;
    pnlButtons: TPanel;
    pnlCategory: TPanel;
    pnlComment: TPanel;
    pnlDetail: TPanel;
    pnlDetailCaption: TBCPanel;
    pnlListCaption: TBCPanel;
    pnlPerson: TPanel;
    pnlSummaryInList: TPanel;
    pnlHeight: TPanel;
    pnlItem: TPanel;
    pnlItems: TPanel;
    pnlClient: TPanel;
    pnlAccount: TPanel;
    pnlAmountMinus: TPanel;
    pnlDate: TPanel;
    pnlLeft: TPanel;
    pnlList: TPanel;
    pnlPayee: TPanel;
    pnlBalance: TPanel;
    pnlTag: TPanel;
    pnlType: TPanel;
    pnlWidth: TPanel;
    popList: TPopupMenu;
    splDetail: TSplitter;
    splDetail1: TSplitter;
    procedure btnAccountClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnAmountClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnCategoryClick(Sender: TObject);
    procedure btnCommentClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnDuplicateClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure btnPayeeClick(Sender: TObject);
    procedure btnPersonClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnSelectAllClick(Sender: TObject);
    procedure btnTagsClick(Sender: TObject);
    procedure btnWriteClick(Sender: TObject);
    procedure cbxAccountKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure cbxCategoryKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure cbxCommentExit(Sender: TObject);
    procedure cbxCommentKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure cbxPayeeKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure cbxPersonKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure cbxTypeEnter(Sender: TObject);
    procedure cbxTypeExit(Sender: TObject);
    procedure cbxTypeKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure datDateChange(Sender: TObject);
    procedure datDateKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure spiAmountEnter(Sender: TObject);
    procedure spiAmountExit(Sender: TObject);
    procedure spiAmountKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure spiAmountMinusChange(Sender: TObject);
    procedure spiAmountMinusKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure chkAmountMinusChange(Sender: TObject);
    procedure lbxTagsKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure pnlButtonsResize(Sender: TObject);
    procedure pnlMenuResize(Sender: TObject);
    procedure splDetailCanResize(Sender: TObject; var NewSize: integer;
      var Accept: boolean);
    procedure VSTBeforeCellPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
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
  frmMultiple: TfrmMultiple;
  slMultiple: TStringList;
  TMultiTag: TMultiTags;

procedure UpdateMultiple;

implementation

{$R *.lfm}

uses
  uniMain, uniPersons, uniAccounts, uniPayees, uniCategories, uniTags,
  uniComments, uniSettings, uniResources;

  { TfrmMultiple }

procedure TfrmMultiple.btnAddClick(Sender: TObject);
begin
  // panel Detail
  pnlDetail.Enabled := True;
  pnlDetail.Color := frmSettings.btnCaptionColorFont.Tag;
  pnlDetailCaption.Caption := AnsiUpperCase(Caption_45);
  pnlButtons.Visible := True;
  pnlMenu.Visible := False;

  // disabled components
  VST.Enabled := False;
  pnlLeft.Enabled := False;

  // enabled buttons
  btnSave.Tag := 0;

  // panel Detail
  if cbxType.ItemIndex = -1 then
    cbxType.ItemIndex := 1;

  // set all fields FROM
  if chkAmountMinus.Checked = True then
    spiAmount.Value := spiBalance.Value
  else
    spiAmount.Value := 0.00;

  cbxComment.Text := '';
  if (cbxPerson.ItemIndex = -1) and (cbxPerson.Items.Count > 0) then
    cbxPerson.ItemIndex := 0;
  if (cbxCategory.ItemIndex = -1) and (cbxCategory.Items.Count > 0) then
    cbxCategory.ItemIndex := 0;

  // clear checked tags
  lbxTags.CheckAll(cbUnchecked, False, False);
  cbxType.SetFocus;

  // disabled ActionList
  actAdd.Enabled := False;
  actEdit.Enabled := False;
  actDelete.Enabled := False;
  actSelect.Enabled := False;
  actSave.Enabled := True;
end;

procedure TfrmMultiple.btnEditClick(Sender: TObject);
begin
  if (btnEdit.Enabled = False) then
    Exit;

  // panel Detail
  pnlDetail.Enabled := True;
  pnlDetail.Color := frmSettings.btnCaptionColorFont.Tag;
  if btnDuplicate.Tag = 1 then
    pnlDetailCaption.Caption := AnsiUpperCase(Caption_45)
  else
    pnlDetailCaption.Caption := AnsiUpperCase(Caption_46);
  pnlButtons.Visible := True;
  pnlMenu.Visible := False;

  // disabled components
  VST.Enabled := False;
  pnlLeft.Enabled := False;

  // disabled menu
  btnSave.Tag := 1 - btnDuplicate.Tag;
  btnDuplicate.Tag := 0;
  cbxType.SetFocus;

  // disabled ActionList
  actSave.Enabled := True;
  actSelect.Enabled := False;
  actAdd.Enabled := False;
  actEdit.Enabled := False;
  actDelete.Enabled := False;
end;

procedure TfrmMultiple.btnCancelClick(Sender: TObject);
begin
  try
    // panel Detail
    pnlDetail.Enabled := False;
    pnlDetail.Color := clDefault;
    pnlDetailCaption.Caption := AnsiUpperCase(Caption_43);
    pnlMenu.Visible := True;

    // disabled menu
    pnlButtons.Visible := False;

    actSave.Enabled := False;
    actSelect.Enabled := True;
    actAdd.Enabled := True;
    actEdit.Enabled := True;
    actDelete.Enabled := True;

    // enabled components
    pnlLeft.Enabled := True;
    VST.Enabled := True;
    VST.SetFocus;

  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmMultiple.btnSaveClick(Sender: TObject);
var
  Sum, Tags1, Tags2: string;
  Amount: double;
  I, J: word;
begin
  if pnlDetail.Enabled = False then
  begin
    if btnWrite.Enabled = True then btnWriteClick(btnWrite);
    Exit;
  end;

  // check type
  if (cbxType.ItemIndex = -1) then
  begin
    Sum := ReplaceStr(Error_04, '%', AnsiUpperCase(lblType.Caption));
    ShowMessage(Sum);
    cbxType.SetFocus;
    Exit;
  end;

  // check comment
  cbxCommentExit(cbxComment);

  // check categories
  if cbxCategory.ItemIndex = -1 then
  begin
    Sum := ReplaceStr(Error_04, '%', AnsiUpperCase(lblCategory.Caption));
    ShowMessage(Sum);
    cbxCategory.SetFocus;
    cbxCategory.SelStart := Length(cbxCategory.Text);
    Exit;
  end;

  // check persons
  if cbxPerson.ItemIndex = -1 then
  begin
    Sum := ReplaceStr(Error_04, '%', AnsiUpperCase(lblPerson.Caption));
    ShowMessage(Sum);
    cbxPerson.SetFocus;
    cbxPerson.SelStart := Length(cbxPerson.Text);
    Exit;
  end;

  // Get amount
  Sum := spiAmount.Text;
  Sum := ReplaceStr(Sum, DefaultFormatSettings.ThousandSeparator, '');
  Sum := ReplaceStr(Sum, ',', DefaultFormatSettings.DecimalSeparator);
  Sum := ReplaceStr(Sum, '.', DefaultFormatSettings.DecimalSeparator);

  TryStrToFloat(Sum, amount);
  if (cbxType.ItemIndex = 1) and (Amount <> 0.00) then
    Amount := -Amount;
  Sum := FloatToStr(amount);

  // =============================================================================================
  Tags1 := '';
  Tags2 := '';
  J := 0;

  if lbxTags.Items.Count > 0 then
  begin
    for I := 0 to lbxTags.Items.Count - 1 do
      if lbxTags.Checked[I] = True then
      begin
        Inc(J);
        Tags1 := Tags1 + lbxTags.Items[I] + '|';
        // NUTNÉ UPRAVIŤ !!!
        // Tags2 := Tags2 + Field(Separ, slTags.Strings[I], 1) + '|';
      end;
    Tags1 := LeftStr(Tags1, Length(Tags1) - 1);
    Tags2 := IntToStr(J);
  end;

  if btnSave.Tag = 0 then
  begin
    slMultiple.Add( // add to the stringlist
      Sum + separ + // amount 1
      cbxComment.Text + separ + // comment 2
      cbxCategory.Items[cbxCategory.ItemIndex] + separ + // category 3
      cbxPerson.Items[cbxPerson.ItemIndex] + separ + // person 4
      IntToStr(cbxType.ItemIndex) + separ + // credit or debit 5
      Tags1 + separ + Tags2);
  end
  else
  begin
    slMultiple.Strings[VST.FocusedNode.Index] :=  // add to the stringlist
      Sum + separ + // amount 1
      cbxComment.Text + separ + // comment 2
      cbxCategory.Items[cbxCategory.ItemIndex] + separ + // category 3
      cbxPerson.Items[cbxPerson.ItemIndex] + separ + // person 4
      IntToStr(cbxType.ItemIndex) + separ + // credit or debit 5
      Tags1 + separ + Tags2;
  end;

  btnCancelClick(btnCancel);
  UpdateMultiple;
  VST.Repaint;
  SetNodeHeight(frmMultiple.VST);

  // open form NewTransaction again
  if frmSettings.chkOpenNewTransaction.Checked = True then
    btnAddClick(btnAdd);
end;

procedure TfrmMultiple.btnExitClick(Sender: TObject);
begin
  frmMultiple.ModalResult := mrCancel;
end;

procedure TfrmMultiple.btnPayeeClick(Sender: TObject);
begin
  frmPayees.ShowModal;
  if cbxPayee.Items.Count > 0 then
    cbxPayee.ItemIndex := 0;
  cbxPayee.SetFocus;
end;

procedure TfrmMultiple.btnPersonClick(Sender: TObject);
begin
  frmPersons.ShowModal;
  if cbxPerson.Items.Count > 0 then
    cbxPerson.ItemIndex := 0;
  cbxPerson.SetFocus;
end;

procedure TfrmMultiple.btnSelectAllClick(Sender: TObject);
begin
  if (VST.Enabled = False) or (btnSelect.Enabled = False) or
    (frmMain.Conn.Connected = False) then
    Exit;

  VST.SelectAll(False);
  VST.SetFocus;
end;

procedure TfrmMultiple.btnTagsClick(Sender: TObject);
begin
  frmTags.ShowModal;
  lbxTags.SetFocus;
end;

procedure TfrmMultiple.btnWriteClick(Sender: TObject);
var
  S, Category, SubCategory: string;
  Amount: double;
  I: integer;
  N: PVirtualNode;
begin
  if (VST.Enabled = False) then
    Exit;

  if (MessageDlg(Message_00, AnsiReplaceStr(Question_14, '%', sLineBreak),
    mtWarning, mbYesNo, 0) <> 6) then
    Exit;

  // check account
  if cbxAccount.ItemIndex = -1 then
  begin
    ShowMessage(ReplaceStr(Error_04, '%', AnsiUpperCase(lblAccount.Caption)));
    cbxAccount.SetFocus;
    cbxAccount.SelStart := Length(cbxAccount.Text);
    Exit;
  end;

  // check older payment than was account created
  frmMain.QRY.SQL.Text := 'SELECT acc_date FROM accounts ' +
    'WHERE acc_currency = :CURRENCY AND acc_name = :ACCOUNT;';
  frmMain.QRY.Params.ParamByName('ACCOUNT').AsString :=
    Field(' | ', cbxAccount.Items[cbxAccount.ItemIndex], 1);
  frmMain.QRY.Params.ParamByName('CURRENCY').AsString :=
    Field(' | ', cbxAccount.Items[cbxAccount.ItemIndex], 2);

  frmMain.QRY.Open;
  if frmMain.QRY.RecordCount > 0 then
    if StrToDate(frmMain.QRY.Fields[0].AsString, 'YYYY-MM-DD', '-') >
      datDate.Date then
    begin
      ShowMessage(
        AnsiReplaceStr(Error_13, '%', cbxAccount.Items[cbxAccount.ItemIndex]) +
        sLineBreak + DateToStr(StrToDate(frmMain.QRY.Fields[0].AsString,
        'YYYY-MM-DD', '-')));
      frmMain.QRY.Close;
      datDate.SetFocus;
      Exit;
    end;
  frmMain.QRY.Close;

  // check date
  if IsValidDate(YearOf(datDate.Date), MonthOf(datDate.Date),
    DayOf(datDate.Date)) = False then
  begin
    ShowMessage(ReplaceStr(Error_04, '%', AnsiUpperCase(lblDate.Caption)));
    datDate.SetFocus;
    Exit;
  end;

  // check payees
  if cbxPayee.ItemIndex = -1 then
  begin
    ShowMessage(ReplaceStr(Error_04, '%', AnsiUpperCase(lblPayee.Caption)));
    cbxPayee.SetFocus;
    cbxPayee.SelStart := Length(cbxPayee.Text);
    Exit;
  end;

  frmMain.Tran.Commit;
  // =========================================================================================

  for N in VST.Nodes() do
  begin
    frmMain.Tran.StartTransaction;
    frmMain.QRY.SQL.Text := 'INSERT INTO data (' +
      'd_date, d_type, d_comment, d_comment_lower, d_sum, d_person, d_category, d_account, d_payee, d_order) '
      + sLineBreak + 'VALUES (:DATE, :TYPE, :COMMENT, :COMMENTLOWER, :AMOUNT, ' +
      '(SELECT per_id FROM persons WHERE per_name = :PERSON), ' +
      sLineBreak +
      '(SELECT cat_id FROM categories WHERE cat_name = :CATEGORY and cat_parent_name = :SUBCATEGORY), '
      +
      // d_category
      '(SELECT acc_id FROM accounts WHERE acc_name = :ACCOUNT and acc_currency = :CURRENCY), '
      + sLineBreak + '(SELECT pee_id FROM payees WHERE pee_name = :PAYEE),' +
      sLineBreak + '(SELECT COUNT (d_date) FROM data WHERE d_date = :DATE) + 1);';

    // set parameters  =========================================================================
    // date
    frmMain.QRY.Params.ParamByName('DATE').AsString :=
      FormatDateTime('YYYY-MM-DD', datDate.Date);
    // type
    frmMain.QRY.Params.ParamByName('TYPE').AsString := VST.Text[N, 5];
    // comment
    frmMain.QRY.Params.ParamByName('COMMENT').AsString := VST.Text[N, 2];
    frmMain.QRY.Params.ParamByName('COMMENTLOWER').AsString :=
      AnsiLowerCase(VST.Text[N, 2]);
    // amount
    S := ReplaceStr(VST.Text[N, 1], DefaultFormatSettings.ThousandSeparator, '');
    S := ReplaceStr(S, ',', DefaultFormatSettings.DecimalSeparator);
    S := ReplaceStr(S, '.', DefaultFormatSettings.DecimalSeparator);
    TryStrToFloat(S, amount);
    frmMain.QRY.Params.ParamByName('AMOUNT').AsString :=
      ReplaceStr(FloatToStr(amount), DefaultFormatSettings.DecimalSeparator, '.');
    // account
    frmMain.QRY.Params.ParamByName('ACCOUNT').AsString :=
      Field(' | ', cbxAccount.Items[cbxAccount.ItemIndex], 1);
    // currency
    frmMain.QRY.Params.ParamByName('CURRENCY').AsString :=
      Field(' | ', cbxAccount.Items[cbxAccount.ItemIndex], 2);
    // person
    frmMain.QRY.Params.ParamByName('PERSON').AsString := VST.Text[N, 4];
    // payee
    frmMain.QRY.Params.ParamByName('PAYEE').AsString :=
      cbxPayee.Items[cbxPayee.ItemIndex];
    // category
    Category := AnsiUpperCase(VST.Text[N, 3]);
    SubCategory := AnsiUpperCase(Category);
    if Pos(' | ', Category) > 0 then
    begin
      SubCategory := AnsiUpperCase(Field(' | ', Category, 1));
      Category := AnsiLowerCase(Field(' | ', Category, 2));
    end;
    // Add new category
    frmMain.QRY.Params.ParamByName('CATEGORY').AsString := Category;
    frmMain.QRY.Params.ParamByName('SUBCATEGORY').AsString := Subcategory;

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
            'INSERT OR IGNORE INTO data_tags (dt_data, dt_tag) VALUES (' + S +
            ', (SELECT tag_id FROM tags WHERE tag_name = :TAG));';
          // ShowMessage(frmMain.QRY.SQL.Text);
          frmMain.QRY.Params.ParamByName('TAG').AsString :=
            Field('|', VST.Text[N, 6], I);
          frmMain.QRY.ExecSQL;
        end;
        frmMain.Tran.Commit;
      end;
  end;

  // ========================================================================================
  UpdateTransactions;
  btnWrite.Tag := 1;
  frmMultiple.ModalResult := mrOk;
end;

procedure TfrmMultiple.cbxAccountKeyUp(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  if (Key = 13) then
  begin
    Key := 0;
    if cbxAccount.Items.Count = 0 then
      btnAccountClick(btnAccount)
    else
      datDate.SetFocus;
  end;
end;

procedure TfrmMultiple.cbxCategoryKeyUp(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 0;
    cbxPerson.SetFocus;
  end;
end;

procedure TfrmMultiple.cbxCommentExit(Sender: TObject);
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

procedure TfrmMultiple.cbxCommentKeyUp(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 0;
    cbxCategory.SetFocus;
  end;
end;

procedure TfrmMultiple.cbxPayeeKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 0;
    chkAmountMinus.SetFocus;
  end;
end;

procedure TfrmMultiple.cbxPersonKeyUp(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 0;
    lbxTags.SetFocus;
  end;
end;

procedure TfrmMultiple.cbxTypeEnter(Sender: TObject);
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

procedure TfrmMultiple.cbxTypeExit(Sender: TObject);
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

procedure TfrmMultiple.cbxTypeKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 0;
    spiAmount.SetFocus;
  end;
end;

procedure TfrmMultiple.datDateChange(Sender: TObject);
begin
  lblDate1.Caption := DefaultFormatSettings.LongDayNames[DayOfTheWeek(datDate.Date + 1)];
end;

procedure TfrmMultiple.datDateKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 0;
    cbxPayee.SetFocus;
  end;
end;

procedure TfrmMultiple.spiAmountEnter(Sender: TObject);
begin
  (Sender as TFloatSpinEdit).Font.Style := [fsBold];
  (Sender as TFloatSpinEdit).Hint := '';
end;

procedure TfrmMultiple.spiAmountExit(Sender: TObject);
begin
  (Sender as TFloatSpinEdit).Font.Style := [];

  try
    if (Pos('+', (Sender as TFloatSpinEdit).Hint) > 0) or
      (Pos('-', (Sender as TFloatSpinEdit).Hint) > 0) then
      (Sender as TFloatSpinEdit).Value := CalculateText(Sender);
  except
    (Sender as TFloatSpinEdit).Value := 0;
  end;
end;

procedure TfrmMultiple.spiAmountKeyUp(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  (Sender as TFloatSpinEdit).Hint := (Sender as TFloatSpinEdit).Text;
  if Key = 13 then
  begin
    Key := 0;
    cbxComment.SetFocus;
  end;
end;

procedure TfrmMultiple.spiAmountMinusChange(Sender: TObject);
begin
  UpdateMultiple;
end;

procedure TfrmMultiple.spiAmountMinusKeyUp(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 0;
    btnAdd.SetFocus;
  end;
end;

procedure TfrmMultiple.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  if (pnlButtons.Visible = True) then
  begin
    btnCancelClick(btnCancel);
    CloseAction := Forms.caNone;
    Exit;
  end;

  if (btnWrite.Tag = 0) and (VST.RootNodeCount > 0) and
    (MessageDlg(Message_00, AnsiReplaceStr(Question_13, '%', sLineBreak),
    mtWarning, mbYesNo, 0) <> 6) then
  begin
    CloseAction := Forms.caNone;
    Exit;
  end;
end;

procedure TfrmMultiple.btnCategoryClick(Sender: TObject);
begin
  frmCategories.ShowModal;
  if cbxCategory.Items.Count > 0 then
    cbxCategory.ItemIndex := 0;
  cbxCategory.SetFocus;
end;

procedure TfrmMultiple.btnCommentClick(Sender: TObject);
begin
  frmComments.ShowModal;
  cbxComment.SetFocus;
end;

procedure TfrmMultiple.btnDeleteClick(Sender: TObject);
var
  F: PVirtualNode;
  S: TStringList;
  I: word;
begin
  if (VST.RootNodeCount = 0) or (VST.SelectedCount = 0) or
    (btnDelete.Enabled = False) then
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

procedure TfrmMultiple.btnDuplicateClick(Sender: TObject);
begin
  if btnDuplicate.Enabled = False then
    Exit;
  btnDuplicate.Tag := 1;
  btnEditClick(btnEdit);
end;

procedure TfrmMultiple.btnAccountClick(Sender: TObject);
begin
  frmAccounts.ShowModal;
  if cbxAccount.Items.Count > 0 then
    cbxAccount.ItemIndex := 0;
  cbxAccount.SetFocus;
end;

procedure TfrmMultiple.btnAmountClick(Sender: TObject);
begin
  frmMain.mnuCalcClick(frmMain.mnuCalc);
  spiAmount.SetFocus;
end;

procedure TfrmMultiple.FormCreate(Sender: TObject);
begin
  // form size
  (Sender as TForm).Width :=
    Round((Screen.Width / IfThen(ScreenIndex = 0, 1, (ScreenRatio / 100))) -
    (Round(420 / (ScreenRatio / 100)) - ScreenRatio));
  (Sender as TForm).Height :=
    Round(Screen.Height / IfThen(ScreenIndex = 0, 1, (ScreenRatio / 100))) -
    3 * (250 - ScreenRatio);

  // form position
  (Sender as TForm).Left := (Screen.Width - (Sender as TForm).Width) div 2;
  (Sender as TForm).Top := (Screen.Height - 100 - (Sender as TForm).Height) div 2;

  {$IFDEF WINDOWS}
  VST.Header.Height := PanelHeight;
  pnlBasicCaption.Height := PanelHeight;
  pnlListCaption.Height := PanelHeight;
  pnlDetailCaption.Height := PanelHeight;

  pnlButtons.Height := ButtonHeight;
  pnlMenu.Height := ButtonHeight;
  pnlBottom.Height := ButtonHeight;
  {$ENDIF}

  // set the date format
  datDate.Date := Now;

  slMultiple := TStringList.Create;
end;

procedure TfrmMultiple.FormDestroy(Sender: TObject);
begin
  slMultiple.Free;
end;

procedure TfrmMultiple.FormResize(Sender: TObject);
begin
  try
    imgWidth.ImageIndex := 0;
    lblWidth.Caption := IntToStr(frmMultiple.Width);
    imgHeight.ImageIndex := 1;
    lblHeight.Caption := IntToStr(frmMultiple.Height);
    pnlListCaption.Repaint;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmMultiple.FormShow(Sender: TObject);
begin

  btnWrite.Tag := 0;

  if (cbxAccount.ItemIndex = -1) and (cbxAccount.Items.Count > 0) then
    cbxAccount.ItemIndex := 0;
  if (cbxPayee.ItemIndex = -1) and (cbxPayee.Items.Count > 0) then
    cbxPayee.ItemIndex := 0;
  datDate.Date := Now();
  spiAmountMinus.Value := 0.0;

  btnWrite.Enabled := False;
  lblItems.Caption := '';
  lblItem.Caption := '';
  pnlItems.Visible := False;
  pnlItem.Visible := False;

  VST.Clear;
  slMultiple.Clear;
  cbxAccount.SetFocus;

end;

procedure TfrmMultiple.chkAmountMinusChange(Sender: TObject);
begin
  spiAmountMinus.Enabled := chkAmountMinus.Checked;
  pnlBalance.Visible := chkAmountMinus.Checked;

  if spiAmountMinus.Enabled = True then
  begin
    spiAmountMinus.Value := 0.0;
    spiAmountMinus.SetFocus;
  end;
end;

procedure TfrmMultiple.lbxTagsKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 0;
    btnSaveClick(btnSave);
  end;
end;

procedure TfrmMultiple.pnlButtonsResize(Sender: TObject);
begin
  btnCancel.Width := (pnlButtons.Width - 6) div 2;
end;

procedure TfrmMultiple.pnlMenuResize(Sender: TObject);
begin
  pnlMenu.Repaint;
end;

procedure TfrmMultiple.splDetailCanResize(Sender: TObject; var NewSize: integer;
  var Accept: boolean);
begin
  imgHeight.ImageIndex := 3;
  lblHeight.Caption :=
    IfThen((Sender as TSplitter).Tag = 1, IntToStr(frmMultiple.Width - pnlLeft.Width),
    IntToStr(pnlDetail.Width));

  imgWidth.ImageIndex := 2;
  lblWidth.Caption :=
    IfThen((Sender as TSplitter).Tag = 1, IntToStr(pnlLeft.Width),
    IntToStr(frmMultiple.Width - pnlDetail.Width));

  frmMultiple.pnlWidth.Visible := True;
  frmMultiple.pnlHeight.Visible := True;

  pnlListCaption.Repaint;
  pnlDetailCaption.Repaint;
  pnlBasicCaption.Repaint;
end;

procedure TfrmMultiple.VSTBeforeCellPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
begin
  TargetCanvas.Brush.Color := IfThen(Node.Index mod 2 = 0, clWhite,
    frmSettings.pnlOddRowColor.Color);
  TargetCanvas.FillRect(CellRect);
end;

procedure TfrmMultiple.VSTChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
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
    btnDuplicate.Enabled := VST.SelectedCount = 1;
    popDuplicate.Enabled := VST.SelectedCount = 1;

    if (VST.RootNodeCount = 0) or (VST.SelectedCount <> 1) then
    begin
      cbxType.ItemIndex := -1;
      spiAmount.Clear;
      cbxComment.Text := '';
      cbxCategory.ItemIndex := -1;
      cbxPerson.ItemIndex := -1;
      Exit;
    end;

    if (VST.SelectedCount = 1) then
    begin
      spiAmount.Text := ReplaceStr(VST.Text[VST.FocusedNode, 1],
        FS_own.ThousandSeparator, '');
      cbxComment.Text := VST.Text[VST.FocusedNode, 2];
      cbxCategory.ItemIndex := cbxCategory.Items.IndexOf(VST.Text[VST.FocusedNode, 3]);
      cbxPerson.ItemIndex := cbxPerson.Items.IndexOf(VST.Text[VST.FocusedNode, 4]);
      cbxType.ItemIndex := StrToInt(VST.Text[VST.FocusedNode, 5]);
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmMultiple.VSTDblClick(Sender: TObject);
begin
  if VST.SelectedCount = 0 then
    btnAddClick(btnAdd)
  else if VST.SelectedCount = 1 then
    btnEditClick(popEdit);
end;

procedure TfrmMultiple.VSTGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: boolean; var ImageIndex: integer);
begin
  if Column = 0 then
    ImageIndex := StrToInt(VST.Text[Node, 5]);
end;

procedure TfrmMultiple.VSTGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
var
  MM: integer;
begin
  try
    MM := Node.Index;

  finally
    case Column of
      // amount
      1: CellText := Field(separ, slMultiple.Strings[MM], 1);
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

procedure TfrmMultiple.VSTResize(Sender: TObject);
var
  X: integer;
begin
  if frmSettings.chkAutoColumnWidth.Checked = False then Exit;

  (Sender as TLazVirtualStringTree).Header.Columns[0].Width :=
    round(Screen.PixelsPerInch div 96 * 25);
  X := (VST.Width - VST.Header.Columns[0].Width) div 100;
  VST.Header.Columns[1].Width := 24 * X; // amount
  VST.Header.Columns[2].Width :=
    VST.Width - VST.Header.Columns[0].Width - ScrollBarWidth - (68 * X); // comment
  VST.Header.Columns[3].Width := 22 * X; // category
  VST.Header.Columns[4].Width := 22 * X; // person
end;

procedure UpdateMultiple;
var
  D1, D2: double;
  I: word;
begin
  try
    frmMultiple.VST.rootnodecount := 0;
    frmMultiple.VST.Clear;
    frmMultiple.VST.RootNodeCount := slMultiple.Count;

    frmMultiple.btnEdit.Enabled := False;
    frmMultiple.actEdit.Enabled := False;
    frmMultiple.popEdit.Enabled := False;

    frmMultiple.btnDelete.Enabled := False;
    frmMultiple.actDelete.Enabled := False;
    frmMultiple.popDelete.Enabled := False;

    frmMultiple.btnDuplicate.Enabled := False;
    frmMultiple.actDuplicate.Enabled := False;
    frmMultiple.popDuplicate.Enabled := False;

    frmMultiple.btnSelect.Enabled := frmMultiple.VST.RootNodeCount > 0;
    frmMultiple.actSelect.Enabled := frmMultiple.VST.RootNodeCount > 0;
    frmMultiple.popSelect.Enabled := frmMultiple.VST.RootNodeCount > 0;

    frmMultiple.btnWrite.Enabled := frmMultiple.VST.RootNodeCount > 0;
    frmMultiple.actSave.Enabled := frmMultiple.VST.RootNodeCount > 0;

    D2 := 0.00;

    frmMultiple.spiBalance.Value := 0.00;
    frmMultiple.spiSummary.Value := 0.00;

    // summary of amounts in the list
    if slMultiple.Count > 0 then
    begin
      for I := 0 to slMultiple.Count - 1 do
      begin
        TryStrToFloat(Field(separ, slMultiple.Strings[I], 1), D1);
        D2 := D2 + D1;
      end;
      frmMultiple.spiSummary.Value := D2;
    end;

    // =====================================================================
    // item icon
    frmMultiple.pnlItem.Visible := frmMultiple.VST.RootNodeCount > 0;
    frmMultiple.lblItem.Caption := '';

    // items icon
    frmMultiple.pnlItems.Visible := frmMultiple.VST.RootNodeCount > 0;
    frmMultiple.lblItems.Caption := IntToStr(slMultiple.Count);

    if frmMultiple.pnlItem.Visible = True then frmMultiple.pnlItem.Left := 0;

    if frmMultiple.chkAmountMinus.Checked = False then
      Exit;

    // deducted amount
    frmMultiple.spiBalance.Value := frmMultiple.spiAmountMinus.Value + D2;
  except
  end;
end;

end.
