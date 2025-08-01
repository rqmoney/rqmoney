unit uniEdit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls, LazUTF8,
  DateUtils, Buttons, ComCtrls, ActnList, CheckLst, sqldb, DB, sqlite3conn,
  BCMDButtonFocus, StrUtils, laz.VirtualTrees, DateTimePicker, LCLType, Spin, ECTabCtrl,
  LCLIntf;

type

  { TfrmEdit }

  TfrmEdit = class(TForm)
    actExit: TAction;
    actAccounts: TAction;
    actCalc: TAction;
    actComments: TAction;
    actCategories: TAction;
    actTags: TAction;
    actPersons: TAction;
    actPayees: TAction;
    actSave: TAction;
    ActionList1: TActionList;
    btnAccount: TSpeedButton;
    btnAmount: TSpeedButton;
    btnAttachmentAdd: TBCMDButtonFocus;
    btnAttachmentDelete: TBCMDButtonFocus;
    btnAttachmentEdit: TBCMDButtonFocus;
    btnAttachmentOpen: TBCMDButtonFocus;
    btnCancel: TBCMDButtonFocus;
    btnCategory: TSpeedButton;
    btnComment: TSpeedButton;
    btnPayee: TSpeedButton;
    btnPerson: TSpeedButton;
    btnSave: TBCMDButtonFocus;
    btnTag: TSpeedButton;
    cbxAccount: TComboBox;
    cbxCategory: TComboBox;
    cbxSubcategory: TComboBox;
    cbxComment: TComboBox;
    cbxPayee: TComboBox;
    cbxPerson: TComboBox;
    cbxType: TComboBox;
    datDate: TDateTimePicker;
    gbxAccount: TGroupBox;
    gbxAmount: TGroupBox;
    gbxCategory: TGroupBox;
    gbxComment: TGroupBox;
    gbxCommentEnergy: TGroupBox;
    gbxDate: TGroupBox;
    gbxMeter: TGroupBox;
    gbxPayee: TGroupBox;
    gbxPerson: TGroupBox;
    gbxPrice: TGroupBox;
    gbxType: TGroupBox;
    lblConsumption: TLabel;
    lblDate: TLabel;
    lblMeterEnd: TLabel;
    lblMeterStart: TLabel;
    lblTotalPrice: TLabel;
    lblUnitPrice: TLabel;
    lbxTag: TCheckListBox;
    lviAttachments: TListView;
    memComment: TMemo;
    od: TOpenDialog;
    Panel1: TPanel;
    pnlAttachments: TPanel;
    pnlButtons: TPanel;
    pnlConsumption: TPanel;
    pnlDate: TPanel;
    pnlEnergies: TPanel;
    pnlLeft: TPanel;
    imgHeight: TImage;
    imgWidth: TImage;
    lblHeight: TLabel;
    lblWidth: TLabel;
    pnlBottom: TPanel;
    pnlMeterEnd: TPanel;
    pnlMeterStart: TPanel;
    pnlRight: TPanel;
    pnlTagLabel: TPanel;
    pnlTags: TPanel;
    pnlTotalPrice: TPanel;
    pnlUnitPrice: TPanel;
    scrLeft: TScrollBox;
    pnlHeight: TPanel;
    pnlWidth: TPanel;
    spiAmount: TEdit;
    spiConsumption: TFloatSpinEdit;
    spiMeterEnd: TFloatSpinEdit;
    spiMeterStart: TFloatSpinEdit;
    spiTotalPrice: TFloatSpinEdit;
    spiUnitPrice: TFloatSpinEdit;
    splEdit: TSplitter;
    tabSimple: TECTabCtrl;
    procedure btnAccountClick(Sender: TObject);
    procedure btnAmountClick(Sender: TObject);
    procedure btnAttachmentAddClick(Sender: TObject);
    procedure btnAttachmentDeleteClick(Sender: TObject);
    procedure btnAttachmentEditClick(Sender: TObject);
    procedure btnAttachmentOpenClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnCategoryClick(Sender: TObject);
    procedure btnCommentClick(Sender: TObject);
    procedure btnPayeeClick(Sender: TObject);
    procedure btnPersonClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnTagClick(Sender: TObject);
    procedure cbxAccountDropDown(Sender: TObject);
    procedure cbxAccountKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure cbxCategoryChange(Sender: TObject);
    procedure cbxCategoryExit(Sender: TObject);
    procedure cbxCategoryKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure cbxCommentEnter(Sender: TObject);
    procedure cbxCommentExit(Sender: TObject);
    procedure cbxCommentKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure cbxPayeeKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure cbxPersonKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure cbxSubcategoryChange(Sender: TObject);
    procedure cbxSubcategoryExit(Sender: TObject);
    procedure cbxSubcategoryKeyUp(Sender: TObject; var Key: word;
      Shift: TShiftState);
    procedure cbxTypeChange(Sender: TObject);
    procedure cbxTypeEnter(Sender: TObject);
    procedure cbxTypeExit(Sender: TObject);
    procedure cbxTypeKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure chkTypeEnter(Sender: TObject);
    procedure chkTypeExit(Sender: TObject);
    procedure datDateChange(Sender: TObject);
    procedure datDateDropDown(Sender: TObject);
    procedure datDateEnter(Sender: TObject);
    procedure datDateExit(Sender: TObject);
    procedure datDateKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure lblDateClick(Sender: TObject);
    procedure lviAttachmentsChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure lviAttachmentsDblClick(Sender: TObject);
    procedure lviAttachmentsResize(Sender: TObject);
    procedure pnlAttachmentsResize(Sender: TObject);
    procedure spiAmountClick(Sender: TObject);
    procedure spiAmountEnter(Sender: TObject);
    procedure spiAmountExit(Sender: TObject);
    procedure spiAmountKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lbxTagEnter(Sender: TObject);
    procedure lbxTagExit(Sender: TObject);
    procedure lbxTagKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure pnlButtonsResize(Sender: TObject);
    procedure spiMeterStartChange(Sender: TObject);
    procedure splEditCanResize(Sender: TObject; var NewSize: integer;
      var Accept: boolean);
    procedure tabSimpleChange(Sender: TObject);
  private

  public

  end;

var
  frmEdit: TfrmEdit;

implementation

{$R *.lfm}

uses
  uniMain, uniPersons, uniPayees, uniCategories, uniAccounts, uniComments, uniTags,
  uniResources, uniWrite, uniSchedulers, uniCalendar, uniRecycleBin, uniTemplates,
  uniSettings;

  { TfrmEdit }

procedure TfrmEdit.btnCategoryClick(Sender: TObject);
begin
  frmCategories.ShowModal;
  cbxCategory.Tag := -1;
  cbxTypeChange(cbxType);
  cbxCategory.SetFocus;
end;

procedure TfrmEdit.btnCommentClick(Sender: TObject);
begin
  frmComments.ShowModal;
  cbxComment.SetFocus;
end;

procedure TfrmEdit.btnPayeeClick(Sender: TObject);
begin
  frmPayees.ShowModal;
  cbxPayee.SetFocus;
end;

procedure TfrmEdit.btnPersonClick(Sender: TObject);
begin
  frmPersons.ShowModal;
  cbxPerson.SetFocus;
end;

procedure TfrmEdit.btnAmountClick(Sender: TObject);
begin
  frmMain.mnuCalcClick(frmMain.mnuCalc);
  if frmEdit.Visible = True then
    spiAmount.SetFocus;
end;

procedure TfrmEdit.btnAttachmentAddClick(Sender: TObject);
var
  ItemX: TListItem;
begin
  if od.Execute = False then
    Exit;

  ItemX := TListItem.Create(lviAttachments.Items);
  ItemX.ImageIndex := 15;
  ItemX.Caption := ExtractFileName(OD.FileName);
  ItemX.SubItems.Add(ExtractFilePath(OD.FileName));
  lviAttachments.Items.AddItem(ItemX);
end;

procedure TfrmEdit.btnAttachmentDeleteClick(Sender: TObject);
begin
  If lviAttachments.ItemIndex = -1 then
    Exit;

  if MessageDlg(Message_00, Question_01 + sLineBreak +
    lviAttachments.Items[lviAttachments.ItemIndex].Caption + sLineBreak +
    lviAttachments.Items[lviAttachments.ItemIndex].SubItems[0],
    mtConfirmation, mbYesNo, 0) <> 6 then
    Exit;

  lviAttachments.Items.Delete(lviAttachments.ItemIndex);

  lviAttachments.ItemIndex := -1;
  btnAttachmentEdit.Enabled := False;
  btnAttachmentDelete.Enabled := False;
  btnAttachmentOpen.Enabled := False;
end;

procedure TfrmEdit.btnAttachmentEditClick(Sender: TObject);
begin
  if OD.Execute = False then
    Exit;

  lviAttachments.Items[lviAttachments.ItemIndex].Caption :=
    ExtractFileName(OD.FileName);
  lviAttachments.Items[lviAttachments.ItemIndex].SubItems[0] :=
    ExtractFilePath(OD.FileName);
end;

procedure TfrmEdit.btnAttachmentOpenClick(Sender: TObject);
var
  S: string;
begin
  if lviAttachments.ItemIndex = -1 then
    Exit;

  S := lviAttachments.Items[lviAttachments.ItemIndex].SubItems[0] +
    lviAttachments.Items[lviAttachments.ItemIndex].Caption;
  if FileExists(S) = True then
    OpenDocument(S)
  else
    ShowMessage(Error_33 + sLineBreak + S);
end;

procedure TfrmEdit.btnCancelClick(Sender: TObject);
begin
  frmEdit.ModalResult := mrCancel;
end;

procedure TfrmEdit.btnAccountClick(Sender: TObject);
begin
  frmAccounts.ShowModal;
end;

procedure TfrmEdit.chkTypeEnter(Sender: TObject);
begin
  (Sender as TCheckBox).Font.Bold := True;
end;

procedure TfrmEdit.chkTypeExit(Sender: TObject);
begin
  (Sender as TCheckBox).Font.Bold := False;
end;

procedure TfrmEdit.datDateChange(Sender: TObject);
begin
  lblDate.Caption := DefaultFormatSettings.LongDayNames[DayOfTheWeek(datDate.Date + 1)];
end;

procedure TfrmEdit.datDateDropDown(Sender: TObject);
begin
  datDate.Tag := 1;
end;

procedure TfrmEdit.datDateEnter(Sender: TObject);
begin
  datDate.Font.Style := [fsBold];
end;

procedure TfrmEdit.datDateExit(Sender: TObject);
begin
  datDate.Font.Style := [];
end;

procedure TfrmEdit.datDateKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 0;
    spiAmount.SetFocus;
  end
  else if (key = 27) and (datDate.Tag = 0) then
  begin
    Key := 0;
    btnCancelClick(btnCancel);
  end;
  datDate.Tag := 0;
end;

procedure TfrmEdit.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  frmEdit.tabSimple.Tabs[2].Options :=
    frmEdit.tabSimple.Tabs[2].Options - [etoVisible];
end;

procedure TfrmEdit.lblDateClick(Sender: TObject);
begin
  datDate.SetFocus;
end;

procedure TfrmEdit.lviAttachmentsChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
  btnAttachmentEdit.Enabled := lviAttachments.SelCount = 1;
  btnAttachmentDelete.Enabled := lviAttachments.SelCount = 1;
  btnAttachmentOpen.Enabled := lviAttachments.SelCount = 1;
end;

procedure TfrmEdit.lviAttachmentsDblClick(Sender: TObject);
begin
  if lviAttachments.ItemIndex = -1 then
    btnAttachmentAddClick(btnAttachmentAdd)
  else
    btnAttachmentOpenClick(btnAttachmentOpen);
end;

procedure TfrmEdit.lviAttachmentsResize(Sender: TObject);
begin
  lviAttachments.Columns[0].Width := lviAttachments.Width - 4;
end;

procedure TfrmEdit.pnlAttachmentsResize(Sender: TObject);
begin
  btnAttachmentAdd.Repaint;
  btnAttachmentEdit.Repaint;
  btnAttachmentDelete.Repaint;
  btnAttachmentOpen.Repaint;
end;

procedure TfrmEdit.spiAmountClick(Sender: TObject);
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

procedure TfrmEdit.spiAmountEnter(Sender: TObject);
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

procedure TfrmEdit.spiAmountExit(Sender: TObject);
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

procedure TfrmEdit.spiAmountKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 0;
    cbxComment.SetFocus;
  end;
end;

procedure TfrmEdit.FormCreate(Sender: TObject);
begin
  // set components height
  pnlBottom.Height := ButtonHeight + 4;
  lblDate.Caption := DefaultFormatSettings.LongDayNames[DayOfTheWeek(datDate.Date + 1)];

  // get form icon
  frmMain.img16.GetIcon(19, (Sender as TForm).Icon);
  frmEdit.tabSimple.TabIndex := 0;
end;

procedure TfrmEdit.FormResize(Sender: TObject);
begin
  imgWidth.ImageIndex := 0;
  lblWidth.Caption := IntToStr((Sender as TForm).Width);

  imgHeight.ImageIndex := 1;
  lblHeight.Caption := IntToStr((Sender as TForm).Height);
end;

procedure TfrmEdit.FormShow(Sender: TObject);
var
  I: Integer;
  D: double;
  ItemX: TListItem;
begin
  if (frmMain.Conn.Connected = False) then
    Exit;

  // import
  try
    if (frmEdit.Tag = 100) then
    begin
      if frmTemplates.rbtPayeeManually.Checked = True then
        cbxPayee.SetFocus;
      if frmTemplates.rbtPersonManually.Checked = True then
        cbxPerson.SetFocus;
      if frmTemplates.rbtCategoryManually.Checked = True then
        cbxCategory.SetFocus;
      if frmTemplates.rbtCommentManually.Checked = True then
        cbxComment.SetFocus;
      Exit;
    end;

    case frmEdit.Tag of
      1: btnSave.Tag := StrToInt(frmMain.VST.Text[frmMain.VST.GetFirstSelected(), 10]);
      2: btnSave.Tag := StrToInt(
          frmRecycleBin.VST.Text[frmRecycleBin.VST.GetFirstSelected(), 10]);
      5: btnSave.Tag := StrToInt(frmWrite.VST.Text[frmWrite.VST.GetFirstSelected(), 10]);
      6: btnSave.Tag := StrToInt(
          frmSchedulers.VST1.Text[frmSchedulers.VST1.GetFirstSelected(), 4]);
      7: btnSave.Tag := StrToInt(
          frmCalendar.VST.Text[frmCalendar.VST.GetFirstSelected(), 6]);
      8: btnSave.Tag := StrToInt(frmWrite.VST.Text[frmWrite.VST.GetFirstChecked(), 10]);
    end;
  except
  end;

  // ===========================================================================================
  // EDIT ONE TRANSACTION
  // ===========================================================================================
  try
    case frmEdit.Tag of
      // table DATA
      1: frmMain.QRY.SQL.Text :=
          'SELECT ' + // SELECT statement
          'd_date as date, ' + // date
          'Round(d_sum, 2) as amount, ' + // sum
          'd_comment as comment, ' + // comment
          'cat_parent_name, cat_name, cat_parent_ID, ' + // category ID
          'acc_name as account, ' + // account
          'acc_currency as currency, ' + // currency
          'per_name as person, ' + // person;
          'pee_name as payee, ' + // payee;
          'd_type as type, d_id as ID ' + // type
          'FROM data ' + sLineBreak + // FROM table DATA
          'LEFT JOIN ' + sLineBreak +// JOIN
          'categories ON (cat_id = d_category), ' + sLineBreak +// categories
          'payees ON (pee_id = d_payee), ' + sLineBreak +// payees
          'persons ON (per_id = d_person), ' + sLineBreak +// payees
          'accounts ON (acc_id = d_account) ' + sLineBreak +// payees
          'WHERE d_id = :ID;';

      // table RECYCLE
      2: frmMain.QRY.SQL.Text :=
          'SELECT rec_date as date, ' + // 0
          'rec_comment as comment, ' + // 1
          'rec_sum as amount, ' + sLineBreak + // 2
          '(SELECT acc_currency FROM accounts WHERE acc_id = rec_account) as currency, '
          +
          // 3
          sLineBreak +
          '(SELECT acc_name FROM accounts WHERE acc_id = rec_account) as account, ' + // 4
          sLineBreak +
          '(SELECT cat_parent_id FROM categories WHERE cat_id = rec_category) as cat_parent_id, '
          +
          sLineBreak + // cat_parent_id  5
          '(SELECT cat_parent_name FROM categories WHERE cat_id = rec_category) as cat_parent_name, '
          + sLineBreak + // cat_parent_name 6
          '(SELECT cat_name FROM categories WHERE cat_id = rec_category) as cat_name, ' +
          sLineBreak +
          // cat_name 7
          '(SELECT per_name FROM persons WHERE per_id = rec_person) as person, ' +
          sLineBreak +
          // person 8
          '(SELECT pee_name FROM payees WHERE pee_id = rec_payee) as payee, ' + // 9
          'rec_id as ID, ' + // 10
          'rec_type as type' + // 11
          sLineBreak + // other fields 9
          'FROM recycles ' + sLineBreak + // FROM tables
          'WHERE rec_id = :ID;';

      else

        // table PAYMENTS
        frmMain.QRY.SQL.Text :=
          'SELECT ' + // SELECT statement
          'pay_date_plan as date, ' + // date
          'Round(pay_sum, 2) as amount, ' + // Temp
          'pay_comment as comment, ' + // comment
          'cat_parent_name, cat_name, cat_parent_ID, ' + // category ID
          'acc_name as account, ' + // account
          'acc_currency as currency,' + // currencz
          'per_name as person, ' + // person;
          'pee_name as payee, ' + // payee;
          'pay_type as type, pay_id as ID ' + // type
          'FROM payments ' + sLineBreak + // FROM table DATA
          'LEFT JOIN ' + sLineBreak +// JOIN
          'accounts ON (acc_id = pay_account), ' + sLineBreak +// categories
          'categories ON (cat_id = pay_category), ' + sLineBreak +// categories
          'persons ON (per_id = pay_person), ' + sLineBreak +// payees
          'payees ON (pee_id = pay_payee) ' + sLineBreak +// payees
          'WHERE pay_id = :ID;';
    end;
  finally
  end;

  frmMain.QRY.Params.ParamByName('ID').AsInteger := btnSave.Tag;
  frmMain.QRY.Open;

  try
    // type
    cbxType.ItemIndex := frmMain.QRY.FieldByName('type').AsInteger;
    cbxType.Tag := frmMain.QRY.FieldByName('type').AsInteger;
    cbxType.Hint := IfThen(frmEdit.cbxType.Tag in [1, 3], '-', '+');
  finally
    cbxTypeChange(cbxType);
  end;

  // date 2
  try
    datDate.Date :=
      StrToDate(frmMain.QRY.FieldByName('date').AsString, 'YYYY-MM-DD', '-');
    frmEdit.datDate.Hint := frmMain.QRY.FieldByName('date').AsString;
  finally
  end;

  // amount 3
  try
    TryStrToFloat(frmMain.QRY.FieldByName('amount').AsString, D);
    spiAmount.Hint := FloatToStr(-D);
    spiAmount.Hint := AnsiReplaceStr(frmEdit.spiAmount.Hint,
      DefaultFormatSettings.DecimalSeparator, '.');

    if frmMain.QRY.FieldByName('type').AsInteger in [1, 3] then
      D := -D;
    spiAmount.Text := Format('%n', [D], FS_own);
  finally
  end;

  // comment 5
  try
    cbxComment.Text := frmMain.QRY.FieldByName('comment').AsString;
    cbxComment.Hint := frmMain.QRY.FieldByName('comment').AsString;
  finally
  end;

  // account
  try
    gbxAccount.Caption :=
      IfThen(frmEdit.cbxType.ItemIndex in [0, 2], Caption_78, Caption_77);

    if not (frmMain.QRY.FieldByName('account').IsNull) then
    begin
      cbxAccount.ItemIndex :=
        frmEdit.cbxAccount.Items.IndexOf(frmMain.QRY.FieldByName('account').AsString +
        separ_1 + frmMain.QRY.FieldByName('currency').AsString);
    end;
  finally
  end;

  // category
  try
    if not (frmMain.QRY.FieldByName('cat_parent_ID').IsNull) then
    begin
      I := frmMain.QRY.FieldByName('cat_parent_ID').AsInteger;
      if I = 0 then
      begin
        cbxCategory.ItemIndex :=
          cbxCategory.Items.IndexOf(frmMain.QRY.FieldByName('cat_name').AsString);
        cbxCategoryChange(cbxCategory);
        cbxSubcategory.ItemIndex := 0;
      end
      else
      begin
        cbxCategory.ItemIndex :=
          cbxCategory.Items.IndexOf(frmMain.QRY.FieldByName('cat_parent_name').AsString);
        cbxCategoryChange(cbxCategory);
        cbxSubcategory.ItemIndex :=
          cbxSubcategory.Items.IndexOf(frmMain.QRY.FieldByName('cat_name').AsString);
      end;
    end;
  finally
    cbxSubcategoryChange(cbxSubcategory);
  end;

  // person
  try
    if not (frmMain.QRY.FieldByName('person').IsNull) then
    begin
      cbxPerson.ItemIndex :=
        cbxPerson.Items.IndexOf(frmMain.QRY.FieldByName('person').AsString);
      cbxPerson.Hint := cbxPerson.Items[cbxPerson.ItemIndex];
    end;
  finally
  end;

  // payee
  try
    if not (frmMain.QRY.FieldByName('payee').IsNull) then
    begin
      cbxPayee.ItemIndex :=
        cbxPayee.Items.IndexOf(frmMain.QRY.FieldByName('payee').AsString);
      cbxPayee.Hint := cbxPayee.Items[cbxPayee.ItemIndex];
    end;
  finally
  end;

  pnlButtons.Tag := frmMain.QRY.FieldByName('ID').AsInteger;
  frmMain.QRY.Close;

  // update tags ================================================================
  lbxTag.CheckAll(cbUnchecked, False, False);
  try
    case frmEdit.Tag of
      1: frmMain.QRY.SQL.Text :=
          'SELECT tag_name FROM tags WHERE tag_id IN (' +
          'SELECT dt_tag FROM data_tags WHERE dt_data = :ID);';
      2: frmMain.QRY.SQL.Text :=
          'SELECT tag_name FROM tags WHERE tag_id IN (' +
          'SELECT rt_tag FROM recycle_tags WHERE rt_recycle = :ID);';
      else
        frmMain.QRY.SQL.Text :=
          'SELECT tag_name FROM tags WHERE tag_id IN (' +
          'SELECT pt_tag FROM payments_tags WHERE pt_payment = :ID);';
    end;

    // Get ID
    frmMain.QRY.Params.ParamByName('ID').AsInteger := btnSave.Tag;
  finally
  end;

  frmMain.QRY.Open;

  try
    while not (frmMain.QRY.EOF) do
    begin
      lbxTag.Checked[lbxTag.Items.IndexOf(frmMain.QRY.Fields[0].AsString)] :=
        True;
      frmMain.QRY.Next;
    end;
  finally
    frmMain.QRY.Close;
  end;

  // =================================
  // get attachment to the transaction
  // =================================
  lviAttachments.Clear;
  frmMain.QRY.SQL.Text :=
    'SELECT att_path FROM attachments WHERE att_d_id = ' + IntToStr(btnSave.Tag);
  frmMain.QRY.Open;
  while not frmMain.QRY.EOF do
  begin
    ItemX := TListItem.Create(lviAttachments.Items);
    ItemX.ImageIndex := 15;
    ItemX.Caption := ExtractFileName(frmMain.QRY.Fields[0].AsString);
    ItemX.SubItems.Add(ExtractFilePath(frmMain.QRY.Fields[0].AsString));
    lviAttachments.Items.AddItem(ItemX);
    frmMain.QRY.Next;
  end;
  frmMain.QRY.Close;

  if (frmEdit.Tag = 1) and (tabSimple.Tabs[2].Options = [etoVisible]) then
  begin
    // get energies
    spiMeterStart.Value := 0;
    spiMeterEnd.Value := 0;

    frmMain.QRY.SQL.Text :=
      'SELECT ene_reading1, ene_reading2, ene_price, ene_comment ' +
      'FROM energies WHERE ene_d_id = ' +
      IntToStr(btnSave.Tag);

    frmMain.QRY.Open;
    while not frmMain.QRY.EOF do
    begin
      spiMeterStart.Value := StrToFLoat(frmMain.QRY.Fields[0].AsString);
      spiMeterEnd.Value := StrToFLoat(frmMain.QRY.Fields[1].AsString);
      TryStrToFLoat(frmMain.QRY.Fields[2].AsString, D);
      memComment.Text := frmMain.QRY.Fields[3].AsString;
      spiUnitPrice.Value := D;
      frmMain.QRY.Next;
    end;
    frmMain.QRY.Close;
    spiMeterStartChange(spiMeterStart);
  end
  else
  begin
    If Not(tabSimple.TabIndex In [0, 1]) then
    begin
    frmEdit.tabSimple.TabIndex := 0;
    tabSimpleChange(tabSimple);
        end;
  end;

  lbxTag.ItemIndex := -1;
  cbxType.SetFocus;
end;

procedure TfrmEdit.lbxTagEnter(Sender: TObject);
begin
  (Sender as TCheckListBox).Font.Bold := True;
end;

procedure TfrmEdit.lbxTagExit(Sender: TObject);
begin
  (Sender as TCheckListBox).Font.Bold := False;
end;

procedure TfrmEdit.lbxTagKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 0;
    btnSaveClick(btnSave);
  end;
end;

procedure TfrmEdit.pnlButtonsResize(Sender: TObject);
begin
  btnCancel.Width := (pnlButtons.Width - 10) div 3;
  btnSave.Width := (pnlButtons.Width - 10) div 3;
end;

procedure TfrmEdit.spiMeterStartChange(Sender: TObject);
begin
  spiConsumption.Value := spiMeterEnd.Value - spiMeterStart.Value;
  spiTotalPrice.Value := spiConsumption.Value * spiUnitPrice.Value;
end;

procedure TfrmEdit.splEditCanResize(Sender: TObject; var NewSize: integer;
  var Accept: boolean);
begin
  imgWidth.ImageIndex := 2;
  lblWidth.Caption := IntToStr(frmEdit.Width - pnlRight.Width);

  imgHeight.ImageIndex := 3;
  lblHeight.Caption := IntToStr(pnlRight.Width);
end;

procedure TfrmEdit.tabSimpleChange(Sender: TObject);
begin
  if frmEdit.Visible = False then
    Exit;
  pnlTags.Visible := tabSimple.TabIndex = 0;
  pnlAttachments.Visible := tabSimple.TabIndex = 1;
  pnlEnergies.Visible := tabSimple.TabIndex = 2;
  If pnlEnergies.Visible = True then
    spiMeterStart.SetFocus;
end;

procedure TfrmEdit.btnSaveClick(Sender: TObject);
var
  Temp: string;
  D: double;
  I, J: integer;
begin
  if btnSave.Enabled = False then Exit;

  // check type
  if (cbxType.ItemIndex = -1) then
  begin
    ShowMessage(ReplaceStr(Error_04, '%', AnsiUpperCase(gbxType.Caption)));
    cbxType.SetFocus;
    Exit;
  end;

  // check account
  if cbxAccount.ItemIndex = -1 then
  begin
    ShowMessage(ReplaceStr(Error_04, '%', AnsiUpperCase(gbxAccount.Caption)));
    cbxAccount.SelStart := Length(cbxAccount.Text);
    cbxAccount.SetFocus;
    Exit;
  end;

  // check comment
  cbxCommentExit(cbxComment);

  // check categories
  if cbxCategory.ItemIndex = -1 then
  begin
    ShowMessage(ReplaceStr(Error_04, '%', AnsiUpperCase(gbxCategory.Caption)));
    cbxCategory.SelStart := Length(cbxCategory.Text);
    cbxCategory.SetFocus;
    Exit;
  end;

  // check subcategories
  if cbxSubcategory.ItemIndex = -1 then
  begin
    ShowMessage(ReplaceStr(Error_04, '%', AnsiUpperCase(gbxCategory.Caption)));
    cbxSubcategory.SelStart := Length(cbxSubcategory.Text);
    cbxSubcategory.SetFocus;
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

  // check date restrictions
  if frmSettings.rbtTransactionsAddDate.Checked = True then
    if (datDate.date < frmSettings.datTransactionsAddDate.Date) then
    begin
      ShowMessage(Error_29 + ' ' + DateToStr(frmSettings.datTransactionsAddDate.Date) +
        sLineBreak + Error_28);
      Exit;
    end;

  // check days restrictions
  if frmSettings.rbtTransactionsAddDays.Checked = True then
    if (datDate.date < Round(Now - frmSettings.spiTransactionsAddDays.Value)) then
    begin
      ShowMessage(Error_29 + ' ' +
        DateToStr(Round(Now - frmSettings.spiTransactionsAddDays.Value)) +
        sLineBreak + Error_28);
      Exit;
    end;

  // for import
  if frmEdit.Tag = 100 then
  begin
    frmEdit.ModalResult := mrOk;
    Exit;
  end;

  // ===========================================================================
  // DELETE TAGS
  // ===========================================================================

  try
    if frmEdit.Tag <> 8 then
    begin
      case frmEdit.Tag of
        1: frmMain.QRY.SQL.Text := 'DELETE FROM data_tags WHERE dt_data = :ID;';
        2: frmMain.QRY.SQL.Text := 'DELETE FROM recycle_tags WHERE rt_recycle = :ID;';
        else
          frmMain.QRY.SQL.Text := 'DELETE FROM payments_tags WHERE pt_payment = :ID;';
      end;

      frmMain.QRY.Params.ParamByName('ID').AsInteger := btnSave.Tag;
      frmMain.QRY.Prepare;
      frmMain.QRY.ExecSQL;
      frmMain.Tran.Commit;
    end;
  except
  end;

  // ===========================================================================
  // GET FIELDS VALUE
  // ===========================================================================

  case frmEdit.Tag of
    1: frmMain.QRY.SQL.Text := // QUERY
        'UPDATE data SET ' + // update
        'd_date = :DATE, ' + sLineBreak + // date
        'd_type = :TYPE, ' + sLineBreak + // type
        'd_sum = :AMOUNT, ' + sLineBreak + // sum
        'd_comment = :COMMENT, ' + sLineBreak + // comment
        'd_comment_lower = :COMMENTLOWER, ' + sLineBreak + // comment lower case
        'd_account = (SELECT acc_id FROM accounts WHERE acc_name = :ACCOUNT ' +
        'and acc_currency = :CURRENCY), ' + sLineBreak + // account
        'd_category = :CATEGORY, ' + sLineBreak + // category
        'd_person = (SELECT per_id FROM persons WHERE per_name = :PERSON), ' +
        sLineBreak + // person
        'd_payee = (SELECT pee_id FROM payees WHERE pee_name = :PAYEE) ' +
        sLineBreak + // payee
        ' WHERE d_id = :ID;'; // where clausule

    2: frmMain.QRY.SQL.Text := 'UPDATE recycles SET ' + // update
        'rec_date = :DATE, ' + sLineBreak + // date
        'rec_type = :TYPE, ' + sLineBreak + // type
        'rec_sum = :AMOUNT, ' + sLineBreak + // sum
        'rec_comment = :COMMENT, ' + sLineBreak + // comment
        'rec_account = (SELECT acc_id FROM accounts WHERE acc_name = :ACCOUNT ' +
        'and acc_currency = :CURRENCY), ' + sLineBreak + // account
        'rec_category = :CATEGORY, ' + sLineBreak + // category
        'rec_person = (SELECT per_id FROM persons WHERE per_name = :PERSON), ' +
        sLineBreak + // person
        'rec_payee = (SELECT pee_id FROM payees WHERE pee_name = :PAYEE) ' +
        sLineBreak + // payee
        ' WHERE rec_id = :ID;'; // where clausule

    8: // Add scheduled payment to main table
      frmMain.QRY.SQL.Text := 'INSERT OR IGNORE INTO data (' +
        'd_date, d_type, d_comment, d_comment_lower, d_sum, ' +
        'd_person, d_category, d_account, d_payee, d_order) ' +
        sLineBreak + 'VALUES (:DATE, :TYPE, :COMMENT, :COMMENTLOWER, :AMOUNT, '
        + // d_sum
        '(SELECT per_id FROM persons WHERE per_name = :PERSON), ' +
        sLineBreak + // d_person
        ':CATEGORY, ' + sLineBreak + // d_category
        '(SELECT acc_id FROM accounts ' +
        'WHERE acc_name = :ACCOUNT and acc_currency = :CURRENCY), ' +
        sLineBreak + // d_account
        '(SELECT pee_id FROM payees WHERE pee_name = :PAYEE),' + sLineBreak + // d_payee
        '(SELECT COUNT(d_date) FROM data WHERE d_date = :DATE) + 1);';

    else
      frmMain.QRY.SQL.Text := 'UPDATE payments SET ' + // update
        'pay_date_plan = :DATE, ' + sLineBreak + // date
        'pay_sum = :AMOUNT, ' + sLineBreak + // Temp
        'pay_comment = :COMMENT, ' + // comment
        'pay_account = (SELECT acc_id FROM accounts WHERE acc_name = :ACCOUNT ' +
        'and acc_currency = :CURRENCY), ' + sLineBreak + // account
        'pay_category = :CATEGORY, ' + sLineBreak + // category
        'pay_person = (SELECT per_id FROM persons WHERE per_name = :PERSON), ' +
        sLineBreak + // person
        'pay_payee = (SELECT pee_id FROM payees WHERE pee_name = :PAYEE), ' +
        sLineBreak + // payee
        'pay_type = :TYPE ' + sLineBreak + // type
        ' WHERE pay_id = :ID;'; // where clausule
  end;

  // Get ID
  if frmEdit.Tag <> 8 then
    frmMain.QRY.Params.ParamByName('ID').AsInteger := btnSave.Tag;

  // Get Type
  frmMain.QRY.Params.ParamByName('TYPE').AsInteger :=
    frmEdit.cbxType.ItemIndex;

  // Get date
  frmMain.QRY.Params.ParamByName('DATE').AsString :=
    FormatDateTime('YYYY-MM-DD', frmEdit.datDate.Date);

  // Get amount
  Temp := AnsiReplaceStr(frmEdit.spiAmount.Text, FS_own.ThousandSeparator, '');
  Temp := AnsiReplaceStr(Temp, '.', FS_own.DecimalSeparator);
  Temp := AnsiReplaceStr(Temp, ',', FS_own.DecimalSeparator);
  TryStrToFloat(Temp, D);
  if (frmEdit.cbxType.ItemIndex in [1, 3]) then
    D := -D;

  Temp := FloatToStr(D);
  frmMain.QRY.Params.ParamByName('AMOUNT').AsString :=
    ReplaceStr(Temp, DefaultFormatSettings.DecimalSeparator, '.');

  // Get comment
  if frmEdit.cbxComment.ItemIndex > -1 then
    frmMain.QRY.Params.ParamByName('COMMENT').AsString :=
      frmEdit.cbxComment.Items[frmEdit.cbxComment.ItemIndex]
  else
    frmMain.QRY.Params.ParamByName('COMMENT').AsString :=
      frmEdit.cbxComment.Text;

  if frmEdit.Tag in [1, 8] then
  begin
    if frmEdit.cbxComment.ItemIndex > -1 then
      frmMain.QRY.Params.ParamByName('COMMENTLOWER').AsString :=
        AnsiLowerCase(frmEdit.cbxComment.Items[frmEdit.cbxComment.ItemIndex])
    else
      frmMain.QRY.Params.ParamByName('COMMENTLOWER').AsString :=
        AnsiLowerCase(frmEdit.cbxComment.Text);
  end;

  // Get account and currency
  frmMain.QRY.Params.ParamByName('ACCOUNT').AsString :=
    Field(separ_1, frmEdit.cbxAccount.Items[frmEdit.cbxAccount.ItemIndex], 1);
  frmMain.QRY.Params.ParamByName('CURRENCY').AsString :=
    Field(separ_1, frmEdit.cbxAccount.Items[frmEdit.cbxAccount.ItemIndex], 2);

  // Get category
  frmMain.QRY.Params.ParamByName('CATEGORY').AsInteger :=
    GetCategoryID(cbxCategory.Items[cbxCategory.ItemIndex] +
    IfThen(cbxSubcategory.ItemIndex = 0, '', separ_1 +
    cbxSubcategory.Items[cbxSubcategory.ItemIndex]));

  // Get person
  frmMain.QRY.Params.ParamByName('PERSON').AsString :=
    frmEdit.cbxPerson.Text;

  // Get payee
  frmMain.QRY.Params.ParamByName('PAYEE').AsString :=
    frmEdit.cbxPayee.Text;

  //Showmessage (frmMain.QRY.SQL.Text);
  frmMain.QRY.ExecSQL;
  frmMain.Tran.Commit;

  if frmEdit.Tag = 8 then
  begin
    J := frmMain.Conn.GetInsertID;

    // =========================================================================================
    // update date of writed payment
    // =========================================================================================
    frmMain.QRY.SQL.Text :=
      'UPDATE OR IGNORE payments SET pay_date_paid = "' +
      FormatDateTime('YYYY-MM-DD', frmEdit.datDate.Date) + '" WHERE pay_id = ' +
      frmWrite.VST.Text[frmWrite.VST.GetFirstChecked(), 10] + ';';
    frmMain.QRY.ExecSQL;
    frmMain.Tran.Commit;
  end;

  for I := 0 to frmEdit.lbxTag.Count - 1 do
    if frmEdit.lbxTag.Checked[I] = True then
    begin
      case frmEdit.Tag of
        1, 8: frmMain.QRY.SQL.Text :=
            'INSERT INTO data_tags (dt_data, dt_tag) VALUES (:ID, ' +
            '(SELECT tag_id FROM tags WHERE tag_name = :TAG_NAME));';
        2: frmMain.QRY.SQL.Text :=
            'INSERT INTO recycle_tags (rt_recycle, rt_tag) VALUES (:ID, ' +
            '(SELECT tag_id FROM tags WHERE tag_name = :TAG_NAME));';
        else
          frmMain.QRY.SQL.Text :=
            'INSERT INTO payments_tags (pt_payment, pt_tag) VALUES (:ID, ' +
            '(SELECT tag_id FROM tags WHERE tag_name = :TAG_NAME));';
      end;

      if frmEdit.Tag = 8 then
        frmMain.QRY.Params.ParamByName('ID').AsInteger := J
      else
        frmMain.QRY.Params.ParamByName('ID').AsInteger := btnSave.Tag;

      frmMain.QRY.Params.ParamByName('TAG_NAME').AsString := frmEdit.lbxTag.Items[I];
      frmMain.QRY.Prepare;
      frmMain.QRY.ExecSQL;
      frmMain.Tran.Commit;
    end;

  // ================================================
  // UPDATE ATTACHMENTS
  // ================================================
  // delete all previous attamchments
  frmMain.QRY.SQL.Text := 'DELETE FROM attachments WHERE att_d_id = :ID;';
  frmMain.QRY.Params.ParamByName('ID').AsInteger := btnSave.Tag;
  frmMain.QRY.Prepare;
  frmMain.QRY.ExecSQL;

  // write attachments to the table attachments
  if lviAttachments.Items.Count > 0 then
  begin
    for I := 0 to lviAttachments.Items.Count - 1 do
    begin
      frmMain.QRY.SQL.Text :=
        'INSERT OR IGNORE INTO attachments (att_path, att_d_id) VALUES (:PATH, :ID);';
      frmMain.QRY.Params.ParamByName('PATH').AsString :=
        lviAttachments.Items[I].SubItems[0] + lviAttachments.Items[I].Caption;
      frmMain.QRY.Params.ParamByName('ID').AsInteger := btnSave.Tag;
      frmMain.QRY.Prepare;
      frmMain.QRY.ExecSQL;
    end;
  end;
  frmMain.Tran.Commit;

  // =====================================================================
  // WRITE ENERGIES
  // =====================================================================
  if frmEdit.Tag = 1 then
  try
    if tabSimple.Tabs[2].Options = [etoVisible] then
    begin
      // find out if exists energy records
      frmMain.QRY.SQL.Text :=
        'SELECT COUNT(ene_reading1) FROM energies WHERE ene_d_id = :ID';
      frmMain.QRY.Params.ParamByName('ID').AsInteger := btnSave.Tag;
      frmMain.QRY.Prepare;
      frmMain.QRY.Open;
      I := frmMain.QRY.Fields[0].AsInteger;
      frmMain.QRY.Close;

      if I = 0 then
      begin
        frmMain.QRY.SQL.Text :=
          'INSERT OR IGNORE INTO energies (ene_reading1, ene_reading2, ' +
          'ene_price, ene_comment, ene_d_id) VALUES (:R1,:R2,:PRICE,:COMMENT,:ID);';
        frmMain.QRY.Params.ParamByName('R1').AsString :=
          ReplaceStr(FloatToStr(spiMeterStart.Value), FS_own.DecimalSeparator, '.');
        frmMain.QRY.Params.ParamByName('R2').AsString :=
          ReplaceStr(FloatToStr(spiMeterEnd.Value), FS_own.DecimalSeparator, '.');
        frmMain.QRY.Params.ParamByName('PRICE').AsString :=
          ReplaceStr(FloatToStr(spiUnitPrice.Value), FS_own.DecimalSeparator, '.');
        frmMain.QRY.Params.ParamByName('COMMENT').AsString := memComment.Text;
      frmMain.QRY.Params.ParamByName('ID').AsInteger := btnSave.Tag;
        frmMain.QRY.Prepare;
        frmMain.QRY.ExecSQL;
        frmMain.Tran.Commit;
      end
      else
      begin
        frmMain.QRY.SQL.Text :=
          'UPDATE OR IGNORE energies SET ' +
            'ene_reading1 = :R1, ene_reading2 = :R2,' +
            'ene_price = :PRICE, ene_comment = :COMMENT ' +
            'WHERE ene_d_id = :ID;';
        frmMain.QRY.Params.ParamByName('R1').AsString :=
          ReplaceStr(FloatToStr(spiMeterStart.Value), FS_own.DecimalSeparator, '.');
        frmMain.QRY.Params.ParamByName('R2').AsString :=
          ReplaceStr(FloatToStr(spiMeterEnd.Value), FS_own.DecimalSeparator, '.');
        frmMain.QRY.Params.ParamByName('PRICE').AsString :=
          ReplaceStr(FloatToStr(spiUnitPrice.Value), FS_own.DecimalSeparator, '.');
        frmMain.QRY.Params.ParamByName('COMMENT').AsString := memComment.Text;
        frmMain.QRY.Params.ParamByName('ID').AsInteger := btnSave.Tag;
        frmMain.QRY.Prepare;
        frmMain.QRY.ExecSQL;
        frmMain.Tran.Commit;
      end;
    end;
  except
  end;

  frmEdit.ModalResult := mrOk;
end;

procedure TfrmEdit.btnTagClick(Sender: TObject);
begin
  frmTags.ShowModal;
  lbxTag.SetFocus;
end;

procedure TfrmEdit.cbxAccountDropDown(Sender: TObject);
begin
  {$IFDEF WINDOWS}
    ComboDDWidth(TComboBox(Sender));
  {$ENDIF}
end;

procedure TfrmEdit.cbxAccountKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 0;
    datDate.SetFocus;
  end;
end;

procedure TfrmEdit.cbxCategoryChange(Sender: TObject);
begin
  frmEdit.tabSimple.Tabs[2].Options :=
    frmEdit.tabSimple.Tabs[2].Options - [etoVisible];

  if cbxCategory.ItemIndex = -1 then
  begin
    cbxSubcategory.Clear;
    Exit;
  end;

  if cbxCategory.Tag <> cbxCategory.ItemIndex then
    FillSubcategory(cbxCategory.Items[cbxCategory.ItemIndex], cbxSubcategory);

  cbxCategory.Tag := cbxCategory.ItemIndex;
  cbxSubcategoryChange(cbxSubcategory);
end;

procedure TfrmEdit.cbxCategoryExit(Sender: TObject);
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

procedure TfrmEdit.cbxCategoryKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 0;
    cbxSubcategory.SetFocus;
  end;
end;

procedure TfrmEdit.cbxCommentEnter(Sender: TObject);
begin
  cbxComment.Font.Style := [fsBold];
end;

procedure TfrmEdit.cbxCommentExit(Sender: TObject);
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

procedure TfrmEdit.cbxCommentKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 0;
    cbxCategory.SetFocus;
  end;
end;

procedure TfrmEdit.cbxPayeeKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if (Key = 13) then
  begin
    if cbxPayee.Items.Count = 0 then
      btnPayeeClick(btnPayee)
    else
    begin
      case tabSimple.TabIndex of
        0: lbxTag.SetFocus;
        1: lviAttachments.SetFocus;
      end;
    end;
  end;
end;

procedure TfrmEdit.cbxPersonKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 0;
    cbxPayee.SetFocus;
  end;
end;

procedure TfrmEdit.cbxSubcategoryChange(Sender: TObject);
var
  S: TSQLite3Connection;
  T: TSQLTransaction;
  Q: TSQLQuery;
begin
  // create components
  S := TSQLite3Connection.Create(nil);
  T := TSQLTransaction.Create(nil);
  Q := TSQLQuery.Create(nil);

  // setup components
  S.Transaction := T;
  T.Database := S;
  Q.Transaction := T;
  Q.Database := S;


  // setup db
  S.DatabaseName := frmMain.Conn.DatabaseName;
  S.HostName := 'localhost';
  S.Open;

  frmEdit.tabSimple.Tabs[2].Options :=
    frmEdit.tabSimple.Tabs[2].Options - [etoVisible];

  if (cbxCategory.ItemIndex > -1) and (cbxSubcategory.ItemIndex = 0) then
    Q.SQL.Text :=
      'SELECT cat_energy FROM categories WHERE cat_name = :CATEGORY AND cat_parent_id = 0;'
  else if (cbxCategory.ItemIndex > -1) and (cbxSubcategory.ItemIndex > 0) then
  begin
    Q.SQL.Text := 'SELECT cat_energy FROM categories WHERE ' +
      'cat_name = :SUBCATEGORY AND cat_parent_name = :CATEGORY AND cat_parent_id > 0;';
    Q.Params.ParamByName('SUBCATEGORY').AsString :=
      AnsiLowerCase(cbxSubcategory.Items[cbxSubcategory.ItemIndex]);
  end
  else
    Exit;

  Q.Params.ParamByName('CATEGORY').AsString :=
    AnsiUpperCase(cbxCategory.Items[cbxCategory.ItemIndex]);
  Q.Prepare;
  Q.Open;

  if Q.Fields[0].AsInteger = 0 then
    frmEdit.tabSimple.Tabs[2].Options :=
      frmEdit.tabSimple.Tabs[2].Options + [etoVisible]
  else
    frmEdit.tabSimple.Tabs[2].Options :=
      frmEdit.tabSimple.Tabs[2].Options - [etoVisible];
  Q.Close;

  // release
  Q.Free;
  T.Free;
  S.Free;
end;

procedure TfrmEdit.cbxSubcategoryExit(Sender: TObject);
begin
  if (cbxSubcategory.ItemIndex = -1) then
    cbxSubcategory.ItemIndex := cbxSubcategory.Items.IndexOf(cbxSubcategory.Text);
  ComboBoxExit(cbxSubcategory);
end;

procedure TfrmEdit.cbxSubcategoryKeyUp(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 0;
    cbxPerson.SetFocus;
  end;
end;

procedure TfrmEdit.cbxTypeChange(Sender: TObject);
begin
  case cbxType.ItemIndex of
    0, 2: gbxAccount.Caption := Caption_78
    else
      gbxAccount.Caption := Caption_77;
  end;
  cbxCategory.Tag := -1;
  FillCategory(cbxCategory, cbxType.ItemIndex);
  cbxCategoryChange(cbxCategory);
end;

procedure TfrmEdit.cbxTypeEnter(Sender: TObject);
begin
  (Sender as TComboBox).Font.Style := [fsBold];
end;

procedure TfrmEdit.cbxTypeExit(Sender: TObject);
begin
  ComboBoxExit((Sender as TComboBox));
end;

procedure TfrmEdit.cbxTypeKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 0;
    cbxAccount.SetFocus;
  end;
end;


end.
