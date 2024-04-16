unit uniEdit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls, LazUTF8,
  DateUtils, Buttons, ComCtrls, ActnList, CheckLst, sqldb, DB, sqlite3conn, IniFiles,
  BCMDButtonFocus, StrUtils, laz.VirtualTrees, DateTimePicker, LCLType, Spin;

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
    gbxDate: TGroupBox;
    gbxPayee: TGroupBox;
    gbxPerson: TGroupBox;
    gbxType: TGroupBox;
    lblDate: TLabel;
    Panel1: TPanel;
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
    spiAmount: TEdit;
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
    procedure splEditCanResize(Sender: TObject; var NewSize: integer;
      var Accept: boolean);
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
var
  INI: TINIFile;
  INIFile: string;
begin
  // write position and window size
  if frmSettings.chkLastFormsSize.Checked = True then
  begin
    try
      INIFile := ChangeFileExt(ParamStr(0), '.ini');
      INI := TINIFile.Create(INIFile);
      if INI.ReadString('POSITION', frmEdit.Name, '') <>
        IntToStr(frmEdit.Left) + separ + // form left
      IntToStr(frmEdit.Top) + separ + // form top
      IntToStr(frmEdit.Width) + separ + // form width
      IntToStr(frmEdit.Height) + separ + // form height
      IntToStr(frmEdit.gbxTag.Width) then
        INI.WriteString('POSITION', frmEdit.Name,
          IntToStr(frmEdit.Left) + separ + // form left
          IntToStr(frmEdit.Top) + separ + // form top
          IntToStr(frmEdit.Width) + separ + // form width
          IntToStr(frmEdit.Height) + separ + // form height
          IntToStr(frmEdit.gbxTag.Width));
    finally
      INI.Free;
    end;
  end;
end;

procedure TfrmEdit.lblDateClick(Sender: TObject);
begin
  datDate.SetFocus;
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
  I: integer;
  D: double;
  INI: TINIFile;
  S: string;
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
      frmEdit.Position := poDesigned;
      S := INI.ReadString('POSITION', frmEdit.Name, '-1•-1•0•0•200');

      // width
      TryStrToInt(Field(Separ, S, 3), I);
      if (I < 1) or (I > Screen.Width) then
        frmEdit.Width := 600
      else
        frmEdit.Width := I;

      /// height
      TryStrToInt(Field(Separ, S, 4), I);
      if (I < 1) or (I > Screen.Height) then
        frmEdit.Height := 500
      else
        frmEdit.Height := I;

      // left
      TryStrToInt(Field(Separ, S, 1), I);
      if (I < 0) or (I > Screen.Width) then
        frmEdit.left := (Screen.Width - frmEdit.Width) div 2
      else
        frmEdit.Left := I;

      // top
      TryStrToInt(Field(Separ, S, 2), I);
      if (I < 0) or (I > Screen.Height) then
        frmEdit.Top := ((Screen.Height - frmEdit.Height) div 2) - 75
      else
        frmEdit.Top := I;

      // detail panel
      TryStrToInt(Field(Separ, S, 5), I);
      if (I < 150) or (I > 400) then
        frmEdit.gbxTag.Width := 220
      else
        frmEdit.gbxTag.Width := I;
    end;
  finally
    INI.Free
  end;
  // ********************************************************************
  // FORM SIZE END
  // ********************************************************************

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
      2: btnSave.Tag := StrToInt(frmRecycleBin.VST.Text[frmRecycleBin.VST.GetFirstSelected(), 10]);
      5: btnSave.Tag := StrToInt(frmWrite.VST.Text[frmWrite.VST.GetFirstSelected(), 10]);
      6: btnSave.Tag := StrToInt(frmSchedulers.VST1.Text[frmSchedulers.VST1.GetFirstSelected(), 4]);
      7: btnSave.Tag := StrToInt(frmCalendar.VST.Text[frmCalendar.VST.GetFirstSelected(), 6]);
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

procedure TfrmEdit.splEditCanResize(Sender: TObject; var NewSize: integer;
  var Accept: boolean);
begin
  imgWidth.ImageIndex := 2;
  lblWidth.Caption := IntToStr(gbxTag.Width);

  imgHeight.ImageIndex := 3;
  lblHeight.Caption := IntToStr(frmEdit.Width - gbxTag.Width);
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
      'UPDATE payments SET pay_date_paid = "' +
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
  if cbxCategory.ItemIndex = -1 then
  begin
    cbxSubcategory.Clear;
    Exit;
  end;

  if cbxCategory.Tag <> cbxCategory.ItemIndex then
    FillSubcategory(cbxCategory.Items[cbxCategory.ItemIndex], cbxSubcategory);

  cbxCategory.Tag := cbxCategory.ItemIndex;
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
