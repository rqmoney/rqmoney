unit uniEdit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls, LazUTF8,
  DateUtils, Buttons, ComCtrls, ActnList, CheckLst, sqldb, DB, sqlite3conn,
  BCMDButtonFocus, StrUtils, laz.VirtualTrees, DateTimePicker, LCLType, Spin;

type

  { TfrmEdit }

  TfrmEdit = class(TForm)
    actExit: TAction;
    actSave: TAction;
    ActionList1: TActionList;
    btnAccount: TSpeedButton;
    btnAmount: TSpeedButton;
    btnCancel: TBCMDButtonFocus;
    btnCategory: TSpeedButton;
    btnComment: TSpeedButton;
    btnPayee: TSpeedButton;
    btnPerson: TSpeedButton;
    btnSave: TBCMDButtonFocus;
    btnTag: TSpeedButton;
    cbxAccount: TComboBox;
    cbxCategory: TComboBox;
    cbxComment: TComboBox;
    cbxPayee: TComboBox;
    cbxPerson: TComboBox;
    cbxType: TComboBox;
    datDate: TDateTimePicker;
    gbxAccount: TGroupBox;
    gbxAmount: TGroupBox;
    gbxCategory: TGroupBox;
    gbxComment: TGroupBox;
    gbxDate: TGroupBox;
    gbxPayee: TGroupBox;
    gbxPerson: TGroupBox;
    gbxType: TGroupBox;
    lblDate: TLabel;
    pnlButtons: TPanel;
    pnlDate: TPanel;
    pnlLeft: TPanel;
    imgHeight: TImage;
    imgWidth: TImage;
    lblHeight: TLabel;
    gbxTag: TGroupBox;
    lblWidth: TLabel;
    lbxTag: TCheckListBox;
    pnlBottom: TPanel;
    scrLeft: TScrollBox;
    pnlHeight: TPanel;
    pnlTagTop: TPanel;
    pnlWidth: TPanel;
    spiAmount: TFloatSpinEdit;
    splEdit: TSplitter;
    procedure btnAccountClick(Sender: TObject);
    procedure btnAmountClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnCategoryClick(Sender: TObject);
    procedure btnCommentClick(Sender: TObject);
    procedure btnPayeeClick(Sender: TObject);
    procedure btnPersonClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnTagClick(Sender: TObject);
    procedure cbxAccountKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure cbxCategoryKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure cbxCommentEnter(Sender: TObject);
    procedure cbxCommentExit(Sender: TObject);
    procedure cbxCommentKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure cbxPayeeKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure cbxPersonKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
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
    procedure lblDateClick(Sender: TObject);
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
    procedure splEditCanResize(Sender: TObject; var NewSize: integer; var Accept: boolean);
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
end;

procedure TfrmEdit.btnCommentClick(Sender: TObject);
begin
  frmComments.ShowModal;
end;

procedure TfrmEdit.btnPayeeClick(Sender: TObject);
begin
  frmPayees.ShowModal;
end;

procedure TfrmEdit.btnPersonClick(Sender: TObject);
begin
  frmPersons.ShowModal;
end;

procedure TfrmEdit.btnAmountClick(Sender: TObject);
begin
  frmMain.mnuCalcClick(frmMain.mnuCalc);
  if frmEdit.Visible = True then
    spiAmount.SetFocus;
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
  lblDate.Caption := DefaultFormatSettings.LongDayNames[DayOfTheWeek(datDate.Date+1)];
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
  Else If (key = 27) and (datDate.Tag = 0) then
  begin
    Key := 0;
    btnCancelClick(btnCancel);
  end;
  datDate.Tag := 0;
end;

procedure TfrmEdit.lblDateClick(Sender: TObject);
begin
  datDate.SetFocus;
end;

procedure TfrmEdit.spiAmountEnter(Sender: TObject);
begin
  (Sender as TFloatSpinEdit).Font.Style := [fsBold];
  (Sender as TFloatSpinEdit).Hint := '';
end;

procedure TfrmEdit.spiAmountExit(Sender: TObject);
begin
  (Sender as TFloatSpinEdit).Font.Style := [];
  (Sender as TFloatSpinEdit).SelLength := 0;
  (Sender as TFloatSpinEdit).SelStart := Length((Sender as TFloatSpinEdit).Text);

  if (Pos('+', (Sender as TFloatSpinEdit).Hint) > 0) or (Pos('-', (Sender as TFloatSpinEdit).Hint) > 0) then
    (Sender as TFloatSpinEdit).Value := CalculateText(Sender);

  (Sender as TFloatSpinEdit).SelLength := 0;
end;

procedure TfrmEdit.spiAmountKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  (Sender as TFloatSpinEdit).Hint := (Sender as TFloatSpinEdit).Text;

  if Key = 13 then
  begin
    Key := 0;
    cbxComment.SetFocus;
  end;
end;

procedure TfrmEdit.FormCreate(Sender: TObject);
begin
  {$IFDEF WINDOWS}
  // form size
  (Sender as TForm).Width := Round(550 * (ScreenRatio / 100));
  (Sender as TForm).Constraints.MinWidth := Round(500 * (ScreenRatio / 100));
  (Sender as TForm).Height := Round(450 * (ScreenRatio / 100));
  (Sender as TForm).Constraints.MinHeight := Round(450 * (ScreenRatio / 100));

  // form position
  (Sender as TForm).Left := (Screen.Width - (Sender as TForm).Width) div 2;
  (Sender as TForm).Top := (Screen.Height - 200 - (Sender as TForm).Height) div 2;

  // set components height
  pnlBottom.Height := ButtonHeight + 4;
  {$ENDIF}

  lblDate.Caption := DefaultFormatSettings.LongDayNames[DayOfTheWeek(datDate.Date+1)];
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
  Temp: string;
  I, Column: integer;
  D: double;
  VSTX: TLazVirtualStringTree;
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
      1: begin
        VSTX := frmMain.VST;
        Column := 10;
      end;
      2: begin
        VSTX := frmRecycleBin.VST;
        Column := 10;
      end;
      5: begin // frmWrite for editing payments
        VSTX := frmWrite.VST;
        Column := 10;
      end;
      6: begin
        VSTX := frmSchedulers.VST1;
        Column := 4;
      end;
      7: begin
        VSTX := frmCalendar.VST;
        Column := 6;
      end;
      8: begin // frmWrite for Writing payments
        VSTX := frmWrite.VST;
        Column := 10;
      end;
    end;
  finally
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
          '(SELECT acc_currency FROM accounts WHERE acc_id = rec_account) as currency, ' + // 3
          sLineBreak + '(SELECT acc_name FROM accounts WHERE acc_id = rec_account) as account, ' + // 4
          sLineBreak + '(SELECT cat_parent_id FROM categories WHERE cat_id = rec_category) as cat_parent_id, '
          + sLineBreak + // cat_parent_id  5
          '(SELECT cat_parent_name FROM categories WHERE cat_id = rec_category) as cat_parent_name, ' +
          sLineBreak + // cat_parent_name 6
          '(SELECT cat_name FROM categories WHERE cat_id = rec_category) as cat_name, ' + sLineBreak +
          // cat_name 7
          '(SELECT per_name FROM persons WHERE per_id = rec_person) as person, ' + sLineBreak +
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

  if frmEdit.Tag = 8 then
    frmMain.QRY.Params.ParamByName('ID').AsString :=
      VSTX.Text[VSTX.GetFirstChecked(), Column]
  else
    frmMain.QRY.Params.ParamByName('ID').AsString :=
      VSTX.Text[VSTX.GetFirstSelected(), Column];

  frmMain.QRY.Open;
  try
    // type
    cbxType.ItemIndex := frmMain.QRY.FieldByName('type').AsInteger;
    cbxType.Tag := frmMain.QRY.FieldByName('type').AsInteger;
    cbxType.Hint := IfThen(frmEdit.cbxType.Tag in [1, 3], '-', '+');
  finally
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
    spiAmount.Hint := AnsiReplaceStr(frmEdit.spiAmount.Hint, DefaultFormatSettings.DecimalSeparator, '.');

    if frmMain.QRY.FieldByName('type').AsInteger in [1, 3] then
      D := -D;
    spiAmount.Value := D;
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
        ' | ' + frmMain.QRY.FieldByName('currency').AsString);
    end;
  finally
  end;

  // category
  try
    if not (frmMain.QRY.FieldByName('cat_parent_ID').IsNull) then
    begin
      I := frmMain.QRY.FieldByName('cat_parent_ID').AsInteger;
      if I = 0 then
        Temp := frmMain.QRY.FieldByName('cat_name').AsString
      else
        Temp := frmMain.QRY.FieldByName('cat_parent_name').AsString + ' | ' +
          IfThen(frmSettings.chkDisplaySubCatCapital.Checked = True,
          AnsiUpperCase(frmMain.QRY.FieldByName('cat_name').AsString),
          frmMain.QRY.FieldByName('cat_name').AsString);

      frmEdit.cbxCategory.ItemIndex :=
        frmEdit.cbxCategory.Items.IndexOf(Temp);
      frmEdit.cbxCategory.Hint :=
        frmEdit.cbxCategory.Items[frmEdit.cbxCategory.ItemIndex];
    end;
  except
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
    if frmEdit.Tag = 8 then
      frmMain.QRY.Params.ParamByName('ID').AsString :=
        VSTX.Text[VSTX.GetFirstChecked(), Column]
    else
      frmMain.QRY.Params.ParamByName('ID').AsString :=
        VSTX.Text[VSTX.GetFirstSelected(False), Column];
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
  end;

  lbxTag.ItemIndex := -1;
  frmMain.QRY.Close;
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

procedure TfrmEdit.splEditCanResize(Sender: TObject; var NewSize: integer; var Accept: boolean);
begin
  imgWidth.ImageIndex := 2;
  lblWidth.Caption := IntToStr(gbxTag.Width);

  imgHeight.ImageIndex := 3;
  lblHeight.Caption := IntToStr(frmEdit.Width - gbxTag.Width);
end;

procedure TfrmEdit.btnSaveClick(Sender: TObject);
var
  Temp: string;
  VSTX: TLazVirtualStringTree;
  D: double;
  I, J, Column: integer;
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
  If frmSettings.rbtTransactionsAddDate.Checked = True then
    If (datDate.date < frmSettings.datTransactionsAddDate.Date) then
  begin
    ShowMessage(Error_29 + ' ' + DateToStr(frmSettings.datTransactionsAddDate.Date) + sLineBreak + Error_28);
    Exit;
  end;

  // check days restrictions
  If frmSettings.rbtTransactionsAddDays.Checked = True then
    If (datDate.date < Round(Now - frmSettings.spiTransactionsAddDays.Value)) then
  begin
    ShowMessage(Error_29 + ' ' + DateToStr(Round(Now - frmSettings.spiTransactionsAddDays.Value)) +
      sLineBreak + Error_28);
    Exit;
  end;

  // for import
  if frmEdit.Tag = 100 then
  begin
    frmEdit.ModalResult := mrOk;
    Exit;
  end;

  // edit transaction
  case frmEdit.Tag of
    1: begin
      VSTX := frmMain.VST;
      Column := 10;
    end;
    2: begin
      VSTX := frmRecycleBin.VST;
      Column := 10;
    end;
    5, 8: begin
      VSTX := frmWrite.VST;
      Column := 10;
    end;
    6: begin
      VSTX := frmSchedulers.VST1;
      Column := 4;
    end;
    7: begin
      VSTX := frmCalendar.VST;
      Column := 6;
    end;
  end;

  // ===========================================================================
  // DELETE TAGS
  // ===========================================================================

  if frmEdit.Tag <> 8 then
  begin
    case frmEdit.Tag of
      1: frmMain.QRY.SQL.Text := 'DELETE FROM data_tags WHERE dt_data = :ID;';
      2: frmMain.QRY.SQL.Text := 'DELETE FROM recycle_tags WHERE rt_recycle = :ID;';
      else
        frmMain.QRY.SQL.Text := 'DELETE FROM payments_tags WHERE pt_payment = :ID;';
    end;

    frmMain.QRY.Params.ParamByName('ID').AsString :=
      VSTX.Text[VSTX.GetFirstSelected(False), Column];

    frmMain.QRY.ExecSQL;
    frmMain.Tran.Commit;
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
        'd_category = (SELECT cat_id FROM categories WHERE cat_name = :CATEGORY1 ' +
        'and cat_parent_ID = CASE WHEN :CATEGORY2 = 0 THEN 0 ELSE ' +
        '(SELECT cat_id FROM categories WHERE cat_name = :CATEGORY2) END), ' + sLineBreak + // category
        'd_person = (SELECT per_id FROM persons WHERE per_name = :PERSON), ' + sLineBreak + // person
        'd_payee = (SELECT pee_id FROM payees WHERE pee_name = :PAYEE) ' + sLineBreak + // payee
        ' WHERE d_id = :ID;'; // where clausule

    2: frmMain.QRY.SQL.Text := 'UPDATE recycles SET ' + // update
        'rec_date = :DATE, ' + sLineBreak + // date
        'rec_type = :TYPE, ' + sLineBreak + // type
        'rec_sum = :AMOUNT, ' + sLineBreak + // sum
        'rec_comment = :COMMENT, ' + sLineBreak + // comment
        'rec_account = (SELECT acc_id FROM accounts WHERE acc_name = :ACCOUNT ' +
        'and acc_currency = :CURRENCY), ' + sLineBreak + // account
        'rec_category = (SELECT cat_id FROM categories WHERE cat_name = :CATEGORY1 ' +
        'and cat_parent_ID = CASE WHEN :CATEGORY2 = 0 THEN 0 ELSE ' +
        '(SELECT cat_id FROM categories WHERE cat_name = :CATEGORY2) END), ' + sLineBreak + // category
        'rec_person = (SELECT per_id FROM persons WHERE per_name = :PERSON), ' + sLineBreak + // person
        'rec_payee = (SELECT pee_id FROM payees WHERE pee_name = :PAYEE) ' + sLineBreak + // payee
        ' WHERE rec_id = :ID;'; // where clausule

    8: // Add scheduled payment to main table
      frmMain.QRY.SQL.Text := 'INSERT OR IGNORE INTO data (' +
        'd_date, d_type, d_comment, d_comment_lower, d_sum, ' +
        'd_person, d_category, d_account, d_payee, d_order) ' + sLineBreak +
        'VALUES (:DATE, :TYPE, :COMMENT, :COMMENTLOWER, :AMOUNT, ' + // d_sum
        '(SELECT per_id FROM persons WHERE per_name = :PERSON), ' + sLineBreak + // d_person
        ' (SELECT cat_id FROM categories WHERE cat_name = :CATEGORY1 ' +
        'and cat_parent_ID = CASE WHEN :CATEGORY2 = 0 THEN 0 ELSE ' +
        '(SELECT cat_id FROM categories WHERE cat_name = :CATEGORY2) END), ' + sLineBreak + // d_category
        '(SELECT acc_id FROM accounts ' + 'WHERE acc_name = :ACCOUNT and acc_currency = :CURRENCY), ' +
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
        'pay_category = (SELECT cat_id FROM categories WHERE cat_name = :CATEGORY1 ' +
        'and cat_parent_ID = CASE WHEN :CATEGORY2 = 0 THEN 0 ELSE ' +
        '(SELECT cat_id FROM categories WHERE cat_name = :CATEGORY2) END), ' + sLineBreak + // category
        'pay_person = (SELECT per_id FROM persons WHERE per_name = :PERSON), ' + sLineBreak + // person
        'pay_payee = (SELECT pee_id FROM payees WHERE pee_name = :PAYEE), ' + sLineBreak + // payee
        'pay_type = :TYPE ' + sLineBreak + // type
        ' WHERE pay_id = :ID;'; // where clausule
  end;

  // Get ID
  if frmEdit.Tag <> 8 then
    frmMain.QRY.Params.ParamByName('ID').AsString :=
      VSTX.Text[VSTX.GetFirstSelected(), Column];


  // Get Type
  frmMain.QRY.Params.ParamByName('TYPE').AsInteger :=
    frmEdit.cbxType.ItemIndex;

  // Get date
  frmMain.QRY.Params.ParamByName('DATE').AsString :=
    FormatDateTime('YYYY-MM-DD', frmEdit.datDate.Date);

  // Get amount
  D := frmEdit.spiAmount.Value;
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
    Field(' | ', frmEdit.cbxAccount.Items[frmEdit.cbxAccount.ItemIndex], 1);
  frmMain.QRY.Params.ParamByName('CURRENCY').AsString :=
    Field(' | ', frmEdit.cbxAccount.Items[frmEdit.cbxAccount.ItemIndex], 2);

  // Get category
  Temp := AnsiUpperCase(frmEdit.cbxCategory.Items[frmEdit.cbxCategory.ItemIndex]);
  if UTF8Pos(' | ', Temp) > 0 then
  begin
    frmMain.QRY.Params.ParamByName('CATEGORY1').AsString := AnsiLowerCase(Field(' | ', Temp, 2));
    frmMain.QRY.Params.ParamByName('CATEGORY2').AsString := AnsiUpperCase(Field(' | ', Temp, 1));
  end
  else
  begin
    frmMain.QRY.Params.ParamByName('CATEGORY1').AsString := Temp;
    frmMain.QRY.Params.ParamByName('CATEGORY2').AsInteger := 0;
  end;

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
      'UPDATE payments SET pay_date_paid = "' + FormatDateTime('YYYY-MM-DD', frmEdit.datDate.Date) +
      '" WHERE pay_id = ' + frmWrite.VST.Text[frmWrite.VST.GetFirstChecked(), 10] + ';';
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
        frmMain.QRY.Params.ParamByName('ID').AsString :=
          VSTX.Text[VSTX.GetFirstSelected(False), Column];

      frmMain.QRY.Params.ParamByName('TAG_NAME').AsString := frmEdit.lbxTag.Items[I];

      frmMain.QRY.ExecSQL;
      frmMain.Tran.Commit;
    end;

  frmEdit.ModalResult := mrOk;
end;

procedure TfrmEdit.btnTagClick(Sender: TObject);
begin
  frmTags.ShowModal;
  lbxTag.SetFocus;
end;

procedure TfrmEdit.cbxAccountKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 0;
    datDate.SetFocus;
  end;
end;

procedure TfrmEdit.cbxCategoryKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 0;
    cbxPerson.SetFocus;
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
      if AnsiLowerCase((Sender as TComboBox).Items[W]) = AnsiLowerCase((Sender as TComboBox).Text) then
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
      lbxTag.SetFocus;
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

procedure TfrmEdit.cbxTypeChange(Sender: TObject);
begin
  case cbxType.ItemIndex of
    0, 2: gbxAccount.Caption := Caption_78
    else
      gbxAccount.Caption := Caption_77;
  end;
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
