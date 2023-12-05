unit uniDetail;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  LazUtf8, CheckLst, Buttons, ComCtrls, ActnList, BCMDButtonFocus,
  StrUtils, DateUtils, LCLType, Spin, DateTimePicker;

type

  { TfrmDetail }

  TfrmDetail = class(TForm)
    actExit: TAction;
    ActionList1: TActionList;
    actSave: TAction;
    btnAccountFrom: TSpeedButton;
    btnAccountTo: TSpeedButton;
    btnAmountFrom: TSpeedButton;
    btnAmountTo: TSpeedButton;
    btnCancel: TBCMDButtonFocus;
    btnCategory: TSpeedButton;
    btnComment: TSpeedButton;
    btnPayee: TSpeedButton;
    btnPerson: TSpeedButton;
    btnSave: TBCMDButtonFocus;
    btnSettings: TBCMDButtonFocus;
    btnTag: TSpeedButton;
    cbxAccountFrom: TComboBox;
    cbxAccountTo: TComboBox;
    cbxCategory: TComboBox;
    cbxComment: TComboBox;
    cbxPayee: TComboBox;
    cbxPerson: TComboBox;
    cbxType: TComboBox;
    datDateFrom: TDateTimePicker;
    datDateTo: TDateTimePicker;
    lblDateFrom: TLabel;
    lblDateTo: TLabel;
    pnlDateFrom: TPanel;
    pnlDateTo: TPanel;
    spiAmountFrom: TFloatSpinEdit;
    spiAmountTo: TFloatSpinEdit;
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
    gbxTo: TPanel;
    gbxType: TGroupBox;
    imgHeight: TImage;
    imgWidth: TImage;
    lblHeight: TLabel;
    gbxTag: TGroupBox;
    lblWidth: TLabel;
    lbxTag: TCheckListBox;
    pnlButtons: TPanel;
    pnlLeft: TPanel;
    pnlBack: TPanel;
    pnlBottom: TPanel;
    pnlDetail: TScrollBox;
    pnlHeight: TPanel;
    pnlRight: TPanel;
    pnlTagLabel: TPanel;
    pnlWidth: TPanel;
    splDetail: TSplitter;
    procedure actExitExecute(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure btnAccountFromClick(Sender: TObject);
    procedure btnAccountToClick(Sender: TObject);
    procedure btnAmountFromClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnCategoryClick(Sender: TObject);
    procedure btnCommentClick(Sender: TObject);
    procedure btnPayeeClick(Sender: TObject);
    procedure btnPersonClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnSettingsClick(Sender: TObject);
    procedure btnTagClick(Sender: TObject);
    procedure cbxAccountFromEnter(Sender: TObject);
    procedure cbxAccountFromExit(Sender: TObject);
    procedure cbxAccountFromKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure cbxAccountToKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure cbxCategoryKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure cbxCommentEnter(Sender: TObject);
    procedure cbxCommentExit(Sender: TObject);
    procedure cbxCommentKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure cbxPayeeKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure cbxPersonKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure cbxTypeChange(Sender: TObject);
    procedure cbxTypeKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure datDateFromChange(Sender: TObject);
    procedure datDateFromDropDown(Sender: TObject);
    procedure datDateFromEnter(Sender: TObject);
    procedure datDateFromExit(Sender: TObject);
    procedure datDateFromKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure datDateFromKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure datDateToChange(Sender: TObject);
    procedure datDateToKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure lblDateFromClick(Sender: TObject);
    procedure lblDateToClick(Sender: TObject);
    procedure spiAmountFromChange(Sender: TObject);
    procedure spiAmountFromEnter(Sender: TObject);
    procedure spiAmountFromExit(Sender: TObject);
    procedure spiAmountFromKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure spiAmountToKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lbxTagEnter(Sender: TObject);
    procedure lbxTagExit(Sender: TObject);
    procedure lbxTagKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure pnlButtonsResize(Sender: TObject);
    procedure pnlDetailResize(Sender: TObject);
    procedure splDetailCanResize(Sender: TObject; var NewSize: integer; var Accept: boolean);
  private

  public

  end;

var
  frmDetail: TfrmDetail;

implementation

{$R *.lfm}

uses
  uniMain, uniPersons, uniPayees, uniAccounts, uniCategories, uniTags, uniComments,
  uniResources, uniSettings;

{ TfrmDetail }

procedure TfrmDetail.cbxTypeChange(Sender: TObject);
begin
  if (frmMain.Conn.Connected = False) then Exit;

  pnlDetail.DisableAlign;
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
  pnlDetail.EnableAlign;
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

procedure TfrmDetail.btnCategoryClick(Sender: TObject);
begin
  frmCategories.ShowModal;
  if cbxCategory.Items.Count > 0 then
    cbxCategory.ItemIndex := 0;
  cbxCategory.SetFocus;
end;

procedure TfrmDetail.btnCommentClick(Sender: TObject);
begin
  frmComments.ShowModal;
  cbxComment.SetFocus;
end;

procedure TfrmDetail.btnPayeeClick(Sender: TObject);
begin
  frmPayees.ShowModal;
  if cbxPayee.Items.Count > 0 then
    cbxPayee.ItemIndex := 0;
  cbxPayee.SetFocus;
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
  if (btnSave.Enabled = True) then
    btnSaveClick(btnSave);
end;

procedure TfrmDetail.actExitExecute(Sender: TObject);
begin
  frmDetail.ModalResult := mrCancel;
end;

procedure TfrmDetail.btnAccountToClick(Sender: TObject);
begin
  frmAccounts.ShowModal;
  if cbxAccountTo.Items.Count > 0 then
    cbxAccountTo.ItemIndex := 0;
  cbxAccountTo.SetFocus;
end;

procedure TfrmDetail.btnAmountFromClick(Sender: TObject);
begin
  frmMain.mnuCalcClick(frmMain.mnuCalc);
  spiAmountFrom.SetFocus;
end;

procedure TfrmDetail.btnPersonClick(Sender: TObject);
begin
  frmPersons.ShowModal;
  if cbxPerson.Items.Count > 0 then
    cbxPerson.ItemIndex := 0;
  cbxPerson.SetFocus;
end;

procedure TfrmDetail.btnSaveClick(Sender: TObject);
var
  S: string;

begin
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
    if IsValidDate(YearOf(datDateTo.Date), MonthOf(datDateTo.Date), DayOf(datDateTo.Date)) = False then
    begin
      ShowMessage(ReplaceStr(Error_04, '%', AnsiUpperCase(gbxDateTo.Caption)));
      datDateTo.SetFocus;
      Exit;
    end;

    // check older payment than was account created
    frmMain.QRY.SQL.Text := 'SELECT acc_date FROM accounts WHERE acc_currency = :CURRENCY AND ' +
      'acc_name = :ACCOUNT;';
    frmMain.QRY.Params.ParamByName('ACCOUNT').AsString :=
      Field(' | ', cbxAccountTo.Items[cbxAccountTo.ItemIndex], 1);
    frmMain.QRY.Params.ParamByName('CURRENCY').AsString :=
      Field(' | ', cbxAccountTo.Items[cbxAccountTo.ItemIndex], 2);

    frmMain.QRY.Open;
    if frmMain.QRY.RecordCount > 0 then
      if StrToDate(frmMain.QRY.Fields[0].AsString, 'YYYY-MM-DD', '-') > datDateTo.Date then
      begin
        ShowMessage(
          AnsiReplaceStr(Error_13, '%', cbxAccountTo.Items[cbxAccountTo.ItemIndex]) +
          sLineBreak + DateToStr(StrToDate(frmMain.QRY.Fields[0].AsString, 'YYYY-MM-DD', '-')));
        frmMain.QRY.Close;
        datDateTo.SetFocus;
        Exit;
      end;
    frmMain.QRY.Close;

    // check different accounts on transfer
    if (frmSettings.chkEnableSelfTransfer.Checked = False) and (cbxAccountFrom.ItemIndex = cbxAccountTo.ItemIndex) then
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
  If frmSettings.rbtTransactionsAddDate.Checked = True then
    If ((cbxType.ItemIndex < 2) and (datDateFrom.date < frmSettings.datTransactionsAddDate.Date)) or
      ((cbxType.ItemIndex = 2) and ((datDateTo.date < frmSettings.datTransactionsAddDate.Date)
        or (datDateFrom.date < frmSettings.datTransactionsAddDate.Date))) then
  begin
    ShowMessage(Error_29 + ' ' + DateToStr(frmSettings.datTransactionsAddDate.Date) + sLineBreak + Error_28);
    Exit;
  end;

  // check restrictions
  If frmSettings.rbtTransactionsAddDays.Checked = True then
    If ((cbxType.ItemIndex < 2) and (datDateFrom.Date < Round(Now - frmSettings.spiTransactionsAddDays.Value))) or
      ((cbxType.ItemIndex = 2) and ((datDateTo.Date < Round(Now - frmSettings.spiTransactionsAddDays.Value))
        or (datDateFrom.Date < Round(Now - frmSettings.spiTransactionsAddDays.Value)))) then
  begin
    ShowMessage(Error_29 + ' ' + DateToStr(Now - frmSettings.spiTransactionsAddDays.Value) + sLineBreak + Error_28);
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
  if IsValidDate(YearOf(datDateFrom.Date), MonthOf(datDateFrom.Date), DayOf(datDateFrom.Date)) = False then
  begin
    ShowMessage(ReplaceStr(Error_04, '%', AnsiUpperCase(gbxDateFrom.Caption)));
    datDateFrom.SetFocus;
    Exit;
  end;

  // check older payment than was account created
  frmMain.QRY.SQL.Text := 'SELECT acc_date FROM accounts WHERE acc_currency = :CURRENCY AND ' +
    'acc_name = :ACCOUNT;';

  frmMain.QRY.Params.ParamByName('CURRENCY').AsString :=
          Field(' | ', cbxAccountFrom.Items[cbxAccountFrom.ItemIndex], 2);
  frmMain.QRY.Params.ParamByName('ACCOUNT').AsString :=
          Field(' | ', cbxAccountFrom.Items[cbxAccountFrom.ItemIndex], 1);
  frmMain.QRY.Prepare;
  frmMain.QRY.Open;

  if frmMain.QRY.RecordCount > 0 then
    if StrToDate(frmMain.QRY.Fields[0].AsString, 'YYYY-MM-DD', '-') > datDateFrom.Date then
    begin
      ShowMessage(
        AnsiReplaceStr(Error_13, '%', cbxAccountFrom.Items[cbxAccountFrom.ItemIndex]) +
        sLineBreak + DateToStr(StrToDate(frmMain.QRY.Fields[0].AsString, 'YYYY-MM-DD', '-')));
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
  frmDetail.ModalResult := mrOk;
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

procedure TfrmDetail.cbxAccountFromEnter(Sender: TObject);
begin
  (Sender as TComboBox).Font.Bold := True;
end;

procedure TfrmDetail.cbxAccountFromExit(Sender: TObject);
begin
  ComboBoxExit((Sender as TCombobox));
end;

procedure TfrmDetail.cbxAccountFromKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
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

procedure TfrmDetail.cbxAccountToKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
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

procedure TfrmDetail.cbxCategoryKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if (Key = 13) then
  begin
    Key := 0;
    if cbxCategory.Items.Count = 0 then
      btnCategoryClick(btnCategory)
    else
      cbxPerson.SetFocus;
  end;
end;

procedure TfrmDetail.cbxCommentEnter(Sender: TObject);
begin
  cbxComment.Font.Style := [fsBold];
end;

procedure TfrmDetail.cbxCommentExit(Sender: TObject);
var
  W: Word;

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

procedure TfrmDetail.cbxCommentKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if (Key = 13) then
  begin
    Key := 0;
    cbxCategory.SetFocus;
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

procedure TfrmDetail.cbxTypeKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 0;
    cbxAccountFrom.SetFocus;
  end;
end;

procedure TfrmDetail.datDateFromChange(Sender: TObject);
begin
  lblDateFrom.Caption := DefaultFormatSettings.LongDayNames[DayOfTheWeek(datDateFrom.Date+1)];
  if (cbxType.ItemIndex = 2) and (btnSave.Tag = 0) then
    datDateTo.Date := datDateFrom.Date;
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

procedure TfrmDetail.datDateFromKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If (key = 27) and ((Sender as TDateTimePicker).Tag = 0) then
  begin
    Key := 0;
    btnCancelClick(btnCancel);
  end;
  datDateFrom.Tag := 0;
end;

procedure TfrmDetail.datDateFromKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if (Key = 13) then
  begin
    Key := 0;
    spiAmountFrom.SetFocus;
  end;
end;

procedure TfrmDetail.datDateToChange(Sender: TObject);
begin
  lblDateTo.Caption := DefaultFormatSettings.LongDayNames[DayOfTheWeek(datDateTo.Date+1)];
end;

procedure TfrmDetail.datDateToKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if (Key = 13) then
  begin
    Key := 0;
    spiAmountTo.SetFocus;
  end
  Else If (key = 27) and (datDateTo.Tag = 0) then
  begin
    Key := 0;
    btnCancelClick(btnCancel);
  end;
  datDateTo.Tag := 0;
end;

procedure TfrmDetail.lblDateFromClick(Sender: TObject);
begin
  datDateFrom.SetFocus;
end;

procedure TfrmDetail.lblDateToClick(Sender: TObject);
begin
  datDateTo.SetFocus;
end;

procedure TfrmDetail.spiAmountFromChange(Sender: TObject);
begin
    if (cbxType.ItemIndex = 2) and (btnSave.Tag = 0) then
    spiAmountTo.Value := spiAmountFrom.Value;
end;

procedure TfrmDetail.spiAmountFromEnter(Sender: TObject);
begin
  (Sender as TFloatSpinEdit).Font.Style := [fsBold];
  (Sender as TFloatSpinEdit).SelectAll;
  (Sender as TFloatSpinEdit).Hint := '';
end;

procedure TfrmDetail.spiAmountFromExit(Sender: TObject);
begin
  (Sender as TFloatSpinEdit).Font.Style := [];

  if (Pos('+', (Sender as TFloatSpinEdit).Hint) > 0) or (Pos('-', (Sender as TFloatSpinEdit).Hint) > 0) then
    (Sender as TFloatSpinEdit).Value := CalculateText(Sender);

  (Sender as TFloatSpinEdit).SelLength := 0;
end;

procedure TfrmDetail.spiAmountFromKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  (Sender as TFloatSpinEdit).Hint := (Sender as TFloatSpinEdit).Text;
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

procedure TfrmDetail.spiAmountToKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  (Sender as TFloatSpinEdit).Hint := (Sender as TFloatSpinEdit).Text;
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

  {$IFDEF WINDOWS}
  // form size
  (Sender as TForm).Width := Round(600 * (ScreenRatio / 100));
  (Sender as TForm).Constraints.MinWidth := Round(600 * (ScreenRatio / 100));
  (Sender as TForm).Height := Round(450 * (ScreenRatio / 100));
  (Sender as TForm).Constraints.MinHeight := Round(450 * (ScreenRatio / 100));

  // form position
  (Sender as TForm).Left := (Screen.Width - (Sender as TForm).Width) div 2;
  (Sender as TForm).Top := (Screen.Height - 200 - (Sender as TForm).Height) div 2;

  // set components height
  pnlBottom.Height := ButtonHeight + 4;
  {$ENDIF}
end;

procedure TfrmDetail.FormResize(Sender: TObject);
begin
  imgWidth.ImageIndex := 0;
  lblWidth.Caption := IntToStr((Sender as TForm).Width);

  imgHeight.ImageIndex := 1;
  lblHeight.Caption := IntToStr((Sender as TForm).Height);
end;

procedure TfrmDetail.FormShow(Sender: TObject);
begin
  datDateToChange(datDateTo);
  datDateFromChange(datDateFrom);

  if cbxType.Enabled = True then
    cbxType.SetFocus
  else
    cbxAccountFrom.SetFocus;
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

procedure TfrmDetail.pnlButtonsResize(Sender: TObject);
begin
  btnCancel.Width := (pnlButtons.Width - 8) div 3;
  btnSettings.Width := btnCancel.Width;

  btnSave.Repaint;
  btnCancel.Repaint;
  btnSettings.Repaint;
end;

procedure TfrmDetail.pnlDetailResize(Sender: TObject);
begin
  gbxTo.Width := (pnlDetail.Width - 12) div 2;
end;

procedure TfrmDetail.splDetailCanResize(Sender: TObject; var NewSize: integer; var Accept: boolean);
begin
  try
    imgWidth.ImageIndex := 2;
    lblWidth.Caption := IntToStr(pnlRight.Width);

    imgHeight.ImageIndex := 3;
    lblHeight.Caption := IntToStr(frmDetail.Width - pnlRight.Width);

    pnlRight.Tag := pnlRight.Width;
    pnlButtons.Repaint;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

end.
