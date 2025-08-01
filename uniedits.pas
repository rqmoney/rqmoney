unit uniEdits;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  BCPanel, DateUtils, Buttons, ComCtrls, ActnList, CheckLst, Spin, Math,
  LazUtf8, BCMDButtonFocus, StrUtils, laz.VirtualTrees, DateTimePicker;

type

  { TfrmEdits }

  TfrmEdits = class(TForm)
    actExit: TAction;
    actAccounts: TAction;
    actCalc: TAction;
    actComments: TAction;
    actCategories: TAction;
    actPersons: TAction;
    actPayees: TAction;
    actTags: TAction;
    actSave: TAction;
    ActionList1: TActionList;
    btnAccount: TSpeedButton;
    btnAmount: TSpeedButton;
    btnCancel: TBCMDButtonFocus;
    btnCategory: TSpeedButton;
    btnComment: TSpeedButton;
    btnPayee: TSpeedButton;
    btnPerson: TSpeedButton;
    btnReset: TBCMDButtonFocus;
    btnSave: TBCMDButtonFocus;
    btnTag: TSpeedButton;
    cbxAccount: TComboBox;
    cbxCategory: TComboBox;
    cbxComment: TComboBox;
    cbxPayee: TComboBox;
    cbxPerson: TComboBox;
    cbxSubcategory: TComboBox;
    cbxType: TComboBox;
    chkAccount: TCheckBox;
    chkAmount: TCheckBox;
    chkCategory: TCheckBox;
    chkComment: TCheckBox;
    chkDate: TCheckBox;
    chkPayee: TCheckBox;
    chkPerson: TCheckBox;
    chkTag: TCheckBox;
    chkType: TCheckBox;
    datDate: TDateTimePicker;
    lblDate: TLabel;
    pnlDate1: TPanel;
    pnlSubcategory: TPanel;
    imgHeight: TImage;
    imgWidth: TImage;
    lblHeight: TLabel;
    lblWidth: TLabel;
    lbxTag: TCheckListBox;
    pnlAccount: TPanel;
    pnlAmount: TPanel;
    pnlBottom: TPanel;
    pnlButtons: TPanel;
    pnlCategory: TPanel;
    pnlComment: TPanel;
    pnlDate: TPanel;
    pnlEdit: TScrollBox;
    pnlHeight: TPanel;
    pnlPayee: TPanel;
    pnlPerson: TPanel;
    pnlTagTop: TPanel;
    pnlTag: TPanel;
    pnlCount: TPanel;
    pnlEditCaption: TBCPanel;
    pnlType: TPanel;
    pnlWidth: TPanel;
    spiAmount: TEdit;
    splEdit: TSplitter;
    txtSelected: TStaticText;
    txtCount: TStaticText;
    procedure btnAccountClick(Sender: TObject);
    procedure btnAmountClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnCategoryClick(Sender: TObject);
    procedure btnCommentClick(Sender: TObject);
    procedure btnPayeeClick(Sender: TObject);
    procedure btnPersonClick(Sender: TObject);
    procedure btnResetClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnTagClick(Sender: TObject);
    procedure cbxAccountDropDown(Sender: TObject);
    procedure cbxCategoryChange(Sender: TObject);
    procedure cbxCommentEnter(Sender: TObject);
    procedure cbxCommentExit(Sender: TObject);
    procedure cbxTypeChange(Sender: TObject);
    procedure cbxTypeEnter(Sender: TObject);
    procedure cbxTypeExit(Sender: TObject);
    procedure chkAccountChange(Sender: TObject);
    procedure chkAmountChange(Sender: TObject);
    procedure chkCategoryChange(Sender: TObject);
    procedure chkCommentChange(Sender: TObject);
    procedure chkDateChange(Sender: TObject);
    procedure chkPayeeChange(Sender: TObject);
    procedure chkPersonChange(Sender: TObject);
    procedure chkTagChange(Sender: TObject);
    procedure chkTypeChange(Sender: TObject);
    procedure chkTypeEnter(Sender: TObject);
    procedure chkTypeExit(Sender: TObject);
    procedure datDateChange(Sender: TObject);
    procedure datDateEnter(Sender: TObject);
    procedure datDateExit(Sender: TObject);
    procedure lblDateClick(Sender: TObject);
    procedure spiAmountClick(Sender: TObject);
    procedure spiAmountEnter(Sender: TObject);
    procedure spiAmountExit(Sender: TObject);
    procedure spiAmountKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lbxTagClickCheck(Sender: TObject);
    procedure lbxTagEnter(Sender: TObject);
    procedure lbxTagExit(Sender: TObject);
    procedure pnlButtonsResize(Sender: TObject);
    procedure splEditCanResize(Sender: TObject; var NewSize: integer;
      var Accept: boolean);
  private

  public

  end;

var
  frmEdits: TfrmEdits;

procedure CheckBoxes;

implementation

{$R *.lfm}

uses
  uniMain, uniPersons, uniPayees, uniCategories, uniAccounts, uniComments, uniTags,
  uniResources, uniWrite, uniRecycleBin, uniCalendar, uniSchedulers, uniSettings;

  { TfrmEdits }

procedure TfrmEdits.chkAccountChange(Sender: TObject);
begin
  cbxAccount.Enabled := chkAccount.Checked;
  btnAccount.Enabled := chkAccount.Checked;

  if chkAccount.Checked = True then
  begin
    chkAccount.Font.Style := [fsbold];
    if cbxAccount.Items.Count > 0 then
      cbxAccount.ItemIndex := 0;
    if frmEdits.Visible = True then
      cbxAccount.SetFocus;
  end
  else
  begin
    chkAccount.Font.Style := [];
    cbxAccount.ItemIndex := -1;
  end;
  CheckBoxes;
end;

procedure TfrmEdits.chkAmountChange(Sender: TObject);
begin
  spiAmount.Enabled := chkAmount.Checked;
  btnAmount.Enabled := chkAmount.Checked;

  if chkAmount.Checked = True then
  begin
    chkAmount.Font.Style := [fsbold];
    spiAmount.Text := Format('%n', [0.0]);
    if frmEdits.Visible = True then
      spiAmount.SetFocus;
  end
  else
  begin
    chkAmount.Font.Style := [];
  end;
  CheckBoxes;
end;

procedure TfrmEdits.btnCategoryClick(Sender: TObject);
begin
  If chkCategory.Checked = False then
    Exit;
  frmCategories.ShowModal;
  cbxCategory.Tag := -1;
  cbxTypeChange(cbxType);
  cbxCategory.SetFocus;
end;

procedure TfrmEdits.btnCommentClick(Sender: TObject);
begin
  If chkComment.Checked = False then
    Exit;
  frmComments.ShowModal;
  cbxComment.SetFocus;
end;

procedure TfrmEdits.btnPayeeClick(Sender: TObject);
begin
  If chkPayee.Checked = False then
    Exit;
  frmPayees.ShowModal;
  cbxPayee.SetFocus;
end;

procedure TfrmEdits.btnPersonClick(Sender: TObject);
begin
  If chkPerson.Checked = False then
    Exit;
  frmPersons.ShowModal;
  cbxPerson.SetFocus;
end;

procedure TfrmEdits.btnResetClick(Sender: TObject);
begin
  if frmEdits.Visible = True then
    if MessageDlg(Application.Title, Question_10, mtConfirmation, [mbYes, mbNo], 0) <>
      mrYes then
      Exit;

  btnReset.Enabled := False;
  chkType.Checked := False;
  chkDate.Checked := False;
  chkAmount.Checked := False;
  chkComment.Checked := False;
  cbxComment.Text := '';
  chkAccount.Checked := False;
  chkCategory.Checked := False;
  chkPerson.Checked := False;
  chkPayee.Checked := False;
  chkTag.Checked := False;

  if frmEdits.Visible = True then
    chkDate.SetFocus;
end;

procedure TfrmEdits.btnAmountClick(Sender: TObject);
begin
  If chkAmount.Checked = False then
    Exit;
  frmMain.mnuCalcClick(frmMain.mnuCalc);
  spiAmount.SetFocus;
end;

procedure TfrmEdits.btnCancelClick(Sender: TObject);
begin
  frmEdits.ModalResult := mrCancel;
end;

procedure TfrmEdits.btnAccountClick(Sender: TObject);
begin
  if chkAccount.Checked = True then
    frmAccounts.ShowModal;
end;

procedure TfrmEdits.chkCategoryChange(Sender: TObject);
var
  I: byte;
begin
  cbxCategory.Enabled := chkCategory.Checked;
  cbxSubcategory.Enabled := chkCategory.Checked;
  btnCategory.Enabled := chkCategory.Checked;

  if chkCategory.Checked = True then
  begin
    chkCategory.Font.Style := [fsbold];
    cbxCategory.Tag := -1;
    if (chkType.Checked = False) then
    begin
      I := 0;
      cbxCategory.Items := frmMain.cbxCategory.Items;
      cbxCategory.Items.Delete(0);
    end
    else
    begin
      I := cbxType.ItemIndex;
      FillCategory(cbxCategory, I);
    end;


    if cbxCategory.Items.Count > 0 then
    begin
      cbxCategory.ItemIndex := 0;
      cbxCategoryChange(cbxCategory);
    end;
    if frmEdits.Visible = True then
      cbxCategory.SetFocus;
  end
  else
  begin
    chkCategory.Font.Style := [];
    cbxCategory.ItemIndex := -1;
    cbxSubcategory.ItemIndex := -1;
  end;
  CheckBoxes;
end;

procedure TfrmEdits.chkCommentChange(Sender: TObject);
begin
  cbxComment.Enabled := chkComment.Checked;
  btnComment.Enabled := chkComment.Checked;

  if chkComment.Checked = True then
  begin
    chkComment.Font.Style := [fsbold];
    if frmEdits.Visible = True then
    begin
      cbxComment.SetFocus;
      cbxComment.SelectAll;
    end;
  end
  else
    chkComment.Font.Style := [];
  CheckBoxes;
end;

procedure TfrmEdits.chkDateChange(Sender: TObject);
begin
  datDate.Enabled := chkDate.Checked;

  if chkDate.Checked = True then
  begin
    chkDate.Font.Style := [fsbold];
    if frmEdits.Visible = True then
      datDate.SetFocus;
  end
  else
  begin
    chkDate.Font.Style := [];
  end;
  CheckBoxes;
end;

procedure TfrmEdits.chkPayeeChange(Sender: TObject);
begin
  cbxPayee.Enabled := chkPayee.Checked;
  btnPayee.Enabled := chkPayee.Checked;

  if chkPayee.Checked = True then
  begin
    chkPayee.Font.Style := [fsbold];
    if cbxPayee.Items.Count > 0 then
      cbxPayee.ItemIndex := 0;
    if frmEdits.Visible = True then
      cbxPayee.SetFocus;
  end
  else
  begin
    chkPayee.Font.Style := [];
    cbxPayee.ItemIndex := -1;
  end;
  CheckBoxes;
end;

procedure TfrmEdits.chkPersonChange(Sender: TObject);
begin
  cbxPerson.Enabled := chkPerson.Checked;
  btnPerson.Enabled := chkPerson.Checked;

  if chkPerson.Checked = True then
  begin
    chkPerson.Font.Style := [fsbold];
    if cbxPerson.Items.Count > 0 then
      cbxPerson.ItemIndex := 0;
    if frmEdits.Visible = True then
      cbxPerson.SetFocus;
  end
  else
  begin
    chkPerson.Font.Style := [];
    cbxPerson.ItemIndex := -1;
  end;
  CheckBoxes;
end;

procedure TfrmEdits.chkTagChange(Sender: TObject);
begin
  lbxTag.Enabled := chkTag.Checked = True;
  btnTag.Enabled := chkTag.Checked = True;

  if chkTag.Checked = True then
  begin
    chkTag.Font.Style := [fsbold];
    if lbxTag.Items.Count > 0 then
      lbxTag.ItemIndex := 0;
    if frmEdits.Visible = True then
      lbxTag.SetFocus;
  end
  else
  begin
    chkTag.Font.Style := [];
    lbxTag.ItemIndex := -1;
    lbxTag.CheckAll(cbUnchecked, False, False);
  end;
  CheckBoxes;
end;

procedure TfrmEdits.chkTypeChange(Sender: TObject);
var
  I: byte;
begin
  cbxType.Enabled := chkType.Checked;

  if chkType.Checked = True then
  begin
    cbxType.ItemIndex := cbxType.Tag;
    chkType.Font.Style := [fsbold];
    if cbxType.Items.Count > 0 then
      cbxType.ItemIndex := 0;
    if frmEdits.Visible = True then
      cbxType.SetFocus;
  end
  else
  begin
    chkType.Font.Style := [];
    cbxType.Tag := cbxType.ItemIndex;
    cbxType.ItemIndex := -1;
  end;

  if chkCategory.Checked = True then
  begin
    cbxCategory.Tag := -1;
    if (chkType.Checked = False) then
    begin
      I := 0;
      cbxCategory.Items := frmMain.cbxCategory.Items;
      cbxCategory.Items.Delete(0);
    end
    else
    begin
      I := cbxType.ItemIndex + 1;
      FillCategory(cbxCategory, I);
    end;
    If cbxCategory.Items.Count > 0 then
      cbxCategory.ItemIndex := 0;
    cbxCategoryChange(cbxCategory);
  end;

  CheckBoxes;
end;

procedure TfrmEdits.chkTypeEnter(Sender: TObject);
begin
  (Sender as TCheckBox).Font.Bold := True;
  if (Sender as TCheckBox) = chkTag then
    pnlTag.Color := IfThen(Dark = False,
      Color_panel_focus, clDkGray)
  else
    (Sender as TCheckBox).Parent.Color := IfThen(Dark = False,
      Color_panel_focus, clDkGray);
end;

procedure TfrmEdits.chkTypeExit(Sender: TObject);
begin
  (Sender as TCheckBox).Font.Bold := False;
  (Sender as TCheckBox).Parent.Color := clDefault;
end;

procedure TfrmEdits.datDateChange(Sender: TObject);
begin
  lblDate.Caption := DefaultFormatSettings.LongDayNames[DayOfTheWeek(datDate.Date + 1)];
end;

procedure TfrmEdits.datDateEnter(Sender: TObject);
begin
  datDate.Font.Bold := True;
end;

procedure TfrmEdits.datDateExit(Sender: TObject);
begin
  datDate.Font.Bold := False;
end;

procedure TfrmEdits.lblDateClick(Sender: TObject);
begin
  if datDate.Enabled = True then
    datDate.SetFocus;
end;

procedure TfrmEdits.spiAmountClick(Sender: TObject);
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

procedure TfrmEdits.spiAmountEnter(Sender: TObject);
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

procedure TfrmEdits.spiAmountExit(Sender: TObject);
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

procedure TfrmEdits.spiAmountKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 0;
    chkComment.SetFocus;
  end;
end;

procedure TfrmEdits.FormCreate(Sender: TObject);
begin
  // set components height
  pnlEditCaption.Height := PanelHeight;
  pnlBottom.Height := ButtonHeight + 4;

  datDate.Date := Now();
  lblDate.Caption := DefaultFormatSettings.LongDayNames[DayOfTheWeek(datDate.Date + 1)];

  // get form icon
  frmMain.img16.GetIcon(19, (Sender as TForm).Icon);
end;

procedure TfrmEdits.FormResize(Sender: TObject);
begin
  imgWidth.ImageIndex := 0;
  lblWidth.Caption := IntToStr((Sender as TForm).Width);

  imgHeight.ImageIndex := 1;
  lblHeight.Caption := IntToStr((Sender as TForm).Height);

  pnlEditCaption.Repaint;
end;

procedure TfrmEdits.FormShow(Sender: TObject);
begin
  case frmEdits.Tag of
    1: frmEdits.txtCount.Caption := IntToStr(frmMain.VST.SelectedCount);
    2: frmEdits.txtCount.Caption := IntToStr(frmRecycleBin.VST.SelectedCount);
    5: frmEdits.txtCount.Caption := IntToStr(frmWrite.VST.SelectedCount);
    6: frmEdits.txtCount.Caption := IntToStr(frmSchedulers.VST1.SelectedCount);
    7: frmEdits.txtCount.Caption := IntToStr(frmCalendar.VST.SelectedCount);
  end;

  frmEdits.cbxType.ItemIndex := -1;
  frmEdits.cbxAccount.ItemIndex := -1;
  frmEdits.cbxCategory.ItemIndex := -1;
  frmEdits.cbxComment.Text := '';
  frmEdits.cbxPayee.ItemIndex := -1;
  frmEdits.cbxPerson.ItemIndex := -1;
  frmEdits.lbxTag.CheckAll(cbUnchecked, False, False);
  frmEdits.spiAmount.Text := Format('%n', [0.0]);
  chkType.SetFocus;
end;

procedure TfrmEdits.lbxTagClickCheck(Sender: TObject);
begin
  CheckBoxes;
end;

procedure TfrmEdits.lbxTagEnter(Sender: TObject);
begin
  lbxTag.Font.Bold := True;
end;

procedure TfrmEdits.lbxTagExit(Sender: TObject);
begin
  lbxTag.Font.Bold := False;
end;

procedure TfrmEdits.pnlButtonsResize(Sender: TObject);
begin
  btnCancel.Width := (pnlButtons.Width - 8) div 3;
  btnReset.Width := btnCancel.Width;

  btnSave.Repaint;
  btnCancel.Repaint;
  btnReset.Repaint;
end;

procedure TfrmEdits.splEditCanResize(Sender: TObject; var NewSize: integer;
  var Accept: boolean);
begin
  imgWidth.ImageIndex := 2;
  lblWidth.Caption := IntToStr(pnlTag.Width);

  imgHeight.ImageIndex := 3;
  lblHeight.Caption := IntToStr(frmEdits.Width - pnlTag.Width);
end;

procedure CheckBoxes;
begin
  frmEdits.btnSave.Enabled := // button Save
    (frmEdits.chkType.Checked = True) or // type
    (frmEdits.chkDate.Checked = True) or // date
    (frmEdits.chkAmount.Checked = True) or // amount
    (frmEdits.chkComment.Checked = True) or // comment
    (frmEdits.chkAccount.Checked = True) or // account
    (frmEdits.chkCategory.Checked = True) or // category
    (frmEdits.chkPerson.Checked = True) or // person
    (frmEdits.chkTag.Checked = True) or // tags
    (frmEdits.chkPayee.Checked = True); // payee

  frmEdits.btnReset.Enabled := frmEdits.btnSave.Enabled;
end;

procedure TfrmEdits.btnSaveClick(Sender: TObject);
var
  Temp: string;
  VSTX: TLazVirtualStringTree;
  D: double;
  I, Column: integer;
  N: PVirtualNode;
begin
  if btnSave.Enabled = False then Exit;

  // check chkType
  if (chkType.Checked = True) and (cbxType.ItemIndex = -1) then
  begin
    ShowMessage(AnsiReplaceStr(Error_04, '%', AnsiUpperCase(chkType.Caption)));
    cbxType.SetFocus;
    Exit;
  end;

  // check chkDate
  if (frmEdits.chkDate.Checked = True) and (frmEdits.datDate.Date < 1000) then
  begin
    ShowMessage(AnsiReplaceStr(Error_04, '%', AnsiUpperCase(chkDate.Caption)));
    datDate.SetFocus;
    Exit;
  end;

  // check chkAccount
  if (chkAccount.Checked = True) then
  begin
    if (cbxaccount.ItemIndex = -1) then
    begin
      ShowMessage(AnsiReplaceStr(Error_04, '%', AnsiUpperCase(chkAccount.Caption)));
      cbxAccount.SelStart := Length(cbxAccount.Text);
      cbxaccount.SetFocus;
      Exit;
    end;
  end;

  // check cbxComment
  if (chkComment.Checked = True) then
    cbxCommentExit(cbxComment);

  // check chkCategory
  if (chkCategory.Checked = True) then
  begin
    if (cbxCategory.ItemIndex = -1) then
    begin
      ShowMessage(AnsiReplaceStr(Error_04, '%', AnsiUpperCase(chkCategory.Caption)));
      cbxCategory.SelStart := Length(cbxCategory.Text);
      cbxCategory.SetFocus;
      Exit;
    end;
    if (cbxSubcategory.ItemIndex = -1) then
    begin
      ShowMessage(AnsiReplaceStr(Error_04, '%', AnsiUpperCase(chkCategory.Caption)));
      cbxSubcategory.SelStart := Length(cbxSubcategory.Text);
      cbxSubcategory.SetFocus;
      Exit;
    end;
  end;

  // check chkperson
  if (chkPerson.Checked = True) then
  begin
    if (cbxPerson.ItemIndex = -1) then
    begin
      ShowMessage(AnsiReplaceStr(Error_04, '%', AnsiUpperCase(chkPerson.Caption)));
      cbxPerson.SelStart := Length(cbxPerson.Text);
      cbxPerson.SetFocus;
      Exit;
    end;
  end;

  // check chkPayee
  if (chkPayee.Checked = True) then
  begin
    if (cbxPayee.ItemIndex = -1) then
    begin
      ShowMessage(AnsiReplaceStr(Error_04, '%', AnsiUpperCase(chkPayee.Caption)));
      cbxPayee.SelStart := Length(cbxPayee.Text);
      cbxPayee.SetFocus;
      Exit;
    end;
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

  case frmEdits.Tag of
    1: begin
      VSTX := frmMain.VST;
      Column := 10;
    end;
    2: begin
      VSTX := frmRecycleBin.VST;
      Column := 10;
    end;
    5: begin
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

  // ===========================================================
  // get ID of selected transactions
  // ===========================================================
  Temp := '';
  N := VSTX.GetFirstSelected(False);
  try
    while Assigned(N) do
    begin
      Temp := Temp + VSTX.Text[N, Column] + ',';
      N := VSTX.GetNextSelected(N);
    end;
  finally
    Temp := UTF8Copy(Temp, 1, UTF8Length(Temp) - 1);
  end;

  // find out, which CheckBox is checked
  I := 0;
  if frmEdits.chkDate.Checked = True then I := I + frmEdits.chkDate.Tag;
  if frmEdits.chkAmount.Checked = True then I := I + frmEdits.chkAmount.Tag;
  if frmEdits.chkComment.Checked = True then I := I + frmEdits.chkComment.Tag;
  if frmEdits.chkAccount.Checked = True then I := I + frmEdits.chkAccount.Tag;
  if frmEdits.chkCategory.Checked = True then I := I + frmEdits.chkCategory.Tag;
  if frmEdits.chkPerson.Checked = True then I := I + frmEdits.chkPerson.Tag;
  if frmEdits.chkPayee.Checked = True then I := I + frmEdits.chkPayee.Tag;
  if frmEdits.chkType.Checked = True then I := I + frmEdits.chkType.Tag;

  if I > 0 then
    // ===========================================================================
    // GET FIELDS VALUE
    // ===========================================================================

  begin
    case frmEdits.Tag of

      // Table DATA
      1: frmMain.QRY.SQL.Text := 'UPDATE data SET ' + // update
          IfThen(frmEdits.chkDate.Checked = True, 'd_date = :DATE' + // date
          IfThen(I < 2, ' ', ','), '') + // comma
          IfThen(frmEdits.chkAmount.Checked = True,
          IfThen(frmEdits.chkType.Checked = True, 'd_sum = :AMOUNT',
          'd_sum = CASE WHEN d_type in (1,3) THEN -:AMOUNT ELSE :AMOUNT END') + // sum
          IfThen(I < 4, ' ', ','), '') + // comma

          IfThen(frmEdits.chkComment.Checked = True, 'd_comment = :COMMENT, ' +
          'd_comment_lower = :COMMENTLOWER' + // comment
          IfThen(I < 8, ' ', ','), '') + // comma

          IfThen(frmEdits.chkAccount.Checked = True,
          'd_account = (SELECT acc_id FROM accounts WHERE acc_name = :ACCOUNT' +
          ' and acc_currency = :CURRENCY)' + // account
          IfThen(I < 16, ' ', ','), '') + // comma

          IfThen(frmEdits.chkCategory.Checked = True,
          'd_category = :CATEGORY' + // category / subcategory
          IfThen(I < 32, ' ', ','), '') + // comma

          IfThen(frmEdits.chkPerson.Checked = True,
          'd_person = (SELECT per_id FROM persons WHERE per_name = :PERSON)' + // person
          IfThen(I < 64, ' ', ','), '') + // person

          IfThen(frmEdits.chkPayee.Checked = True,
          'd_payee = (SELECT pee_id FROM payees WHERE pee_name = :PAYEE)' + // payee
          IfThen(I < 128, ' ', ','), '') + // payee

          IfThen(frmEdits.chkType.Checked = True, 'd_type = ' +
          IntToStr(frmEdits.cbxType.ItemIndex), '') + // type


          ' WHERE d_id IN (' + Temp + ');'; // where clausule

      // Table RECYCLE
      2: frmMain.QRY.SQL.Text := 'UPDATE recycles SET ' + // update
          IfThen(frmEdits.chkDate.Checked = True, 'rec_date = :DATE' + // date
          IfThen(I < 2, ' ', ','), '') + // comma

          IfThen(frmEdits.chkAmount.Checked = True,
          IfThen(frmEdits.chkType.Checked = True, 'rec_sum = :AMOUNT',
          'rec_sum = CASE WHEN rec_type in (1,3) THEN -:AMOUNT ELSE :AMOUNT END') +
          // sum
          IfThen(I < 4, ' ', ','), '') + // comma

          IfThen(frmEdits.chkComment.Checked = True, 'rec_comment = :COMMENT' +
          IfThen(I < 8, ' ', ','), '') + // comma

          IfThen(frmEdits.chkAccount.Checked = True,
          'rec_account = (SELECT acc_id FROM accounts WHERE acc_name = :ACCOUNT' +
          ' and acc_currency = :CURRENCY)' + // account
          IfThen(I < 16, ' ', ','), '') + // comma

          IfThen(frmEdits.chkCategory.Checked = True,
          'rec_category = :CATEGORY' + // category / subcategory
          IfThen(I < 32, ' ', ','), '') + // comma

          IfThen(frmEdits.chkPerson.Checked = True,
          'rec_person = (SELECT per_id FROM persons WHERE per_name = :PERSON)' +
          // person
          IfThen(I < 64, ' ', ','), '') + // person

          IfThen(frmEdits.chkPayee.Checked = True,
          'rec_payee = (SELECT pee_id FROM payees WHERE pee_name = :PAYEE)' + // payee
          IfThen(I < 128, ' ', ','), '') + // payee

          IfThen(frmEdits.chkType.Checked = True, 'rec_type = ' +
          IntToStr(frmEdits.cbxType.ItemIndex), '') + // type


          ' WHERE rec_id IN (' + Temp + ');' // where clausule

      else
        frmMain.QRY.SQL.Text := 'UPDATE payments SET ' + // update
          IfThen(frmEdits.chkDate.Checked = True, 'pay_date_plan = :DATE' + // date
          IfThen(I < 2, ' ', ','), '') + // comma

          IfThen(frmEdits.chkAmount.Checked = True,
          IfThen(frmEdits.chkType.Checked = True, 'pay_sum = :AMOUNT',
          'pay_sum = CASE WHEN pay_type in (1,3) THEN -:AMOUNT ELSE :AMOUNT END') +
          // sum
          IfThen(I < 4, ' ', ','), '') + // comma

          IfThen(frmEdits.chkComment.Checked = True,
          'pay_comment = :COMMENT' + // comment
          IfThen(I < 8, ' ', ','), '') + // comma

          IfThen(frmEdits.chkAccount.Checked = True,
          'pay_account = (SELECT acc_id FROM accounts WHERE acc_name = :ACCOUNT ' +
          'AND acc_currency = :CURRENCY)' + // account
          IfThen(I < 16, ' ', ','), '') + // comma

          IfThen(frmEdits.chkCategory.Checked = True,
          'pay_category = :CATEGORY' + // category / subcategory
          IfThen(I < 32, ' ', ','), '') + // comma

          IfThen(frmEdits.chkPerson.Checked = True,
          'pay_person = (SELECT per_id FROM persons WHERE per_name = :PERSON) ' +
          // person
          IfThen(I < 64, ' ', ','), '') + // person

          IfThen(frmEdits.chkPayee.Checked = True,
          'pay_payee = (SELECT pee_id FROM payees WHERE pee_name = :PAYEE) ' + // payee
          IfThen(I < 128, ' ', ','), '') + // payee

          IfThen(frmEdits.chkType.Checked = True, 'pay_type = ' +
          IntToStr(frmEdits.cbxType.ItemIndex), '') +  // type

          ' WHERE pay_id IN (' + Temp + ');'; // where clausule

    end;

    // ===============================================================================================
    // Get date
    if frmEdits.chkDate.Checked = True then
      frmMain.QRY.Params.ParamByName('DATE').AsString :=
        FormatDateTime('YYYY-MM-DD', frmEdits.datDate.Date);

    // Get amount
    if frmEdits.chkAmount.Checked = True then
    begin
      TryStrToFloat(spiAmount.Text, D);
      if (frmEdits.chkType.Checked = True) then
      begin
        if (frmEdits.cbxType.ItemIndex in [1, 3]) then
          D := -(D)
        else
          D := (D);
      end;

      Temp := FloatToStr(D);
      frmMain.QRY.Params.ParamByName('AMOUNT').AsString :=
        ReplaceStr(Temp, DefaultFormatSettings.DecimalSeparator, '.');
    end;

    // Get comment
    if frmEdits.chkComment.Checked = True then
    begin
      frmMain.QRY.Params.ParamByName('COMMENT').AsString :=
        frmEdits.cbxComment.Text;
      if frmEdits.Tag = 1 then
        frmMain.QRY.Params.ParamByName('COMMENTLOWER').AsString :=
          AnsiLowerCase(frmEdits.cbxComment.Text);
    end;

    // Get account and currency
    if frmEdits.chkAccount.Checked = True then
    begin
      frmMain.QRY.Params.ParamByName('ACCOUNT').AsString :=
        Field(separ_1, frmEdits.cbxAccount.Items[frmEdits.cbxAccount.ItemIndex], 1);
      frmMain.QRY.Params.ParamByName('CURRENCY').AsString :=
        Field(separ_1, frmEdits.cbxAccount.Items[frmEdits.cbxAccount.ItemIndex], 2);
    end;

    // Get category
    if frmEdits.chkCategory.Checked = True then
      frmMain.QRY.Params.ParamByName('CATEGORY').AsInteger :=
        GetCategoryID(cbxCategory.Items[cbxCategory.ItemIndex] +
        IfThen(cbxSubcategory.ItemIndex = 0, '', separ_1 +
        cbxSubcategory.Items[cbxSubcategory.ItemIndex]));


    // Get person
    if frmEdits.chkPerson.Checked = True then
      frmMain.QRY.Params.ParamByName('PERSON').AsString :=
        frmEdits.cbxPerson.Text;

    // Get payee
    if frmEdits.chkPayee.Checked = True then
      frmMain.QRY.Params.ParamByName('PAYEE').AsString :=
        frmEdits.cbxPayee.Text;

    //ShowMessage (frmMain.QRY.SQL.Text);
    frmMain.QRY.Prepare;
    frmMain.QRY.ExecSQL;
    frmMain.Tran.Commit;
  end;

  // EDIT TAGS =================================================================
  // DELETE PREVIOUS TAGS
  if frmEdits.chkTag.Checked = True then
  begin
    // ===========================================================================
    // DELETE TAGS
    // ===========================================================================

    case frmEdits.Tag of
      1: frmMain.QRY.SQL.Text :=
          'DELETE FROM data_tags WHERE dt_data IN (' + Temp + ');';
      2: frmMain.QRY.SQL.Text :=
          'DELETE FROM recycle_tags WHERE rt_recycle IN (' + Temp + ');'
      else
        frmMain.QRY.SQL.Text :=
          'DELETE FROM payments_tags WHERE pt_payment IN (' + Temp + ');';

    end;

    frmMain.QRY.ExecSQL;
    frmMain.Tran.Commit;
    // ===========================================================================
    // WRITE NEW TAGS
    // ===========================================================================

    if frmEdits.lbxTag.Count > 0 then
    begin
      N := VSTX.GetFirstSelected();
      while Assigned(N) do
      begin
        for I := 0 to frmEdits.lbxTag.Count - 1 do
          if frmEdits.lbxTag.Checked[I] = True then
          begin
            case frmEdits.Tag of
              1: frmMain.QRY.SQL.Text :=
                  'INSERT INTO data_tags (dt_data, dt_tag) VALUES (:ID, ' +
                  '(SELECT tag_id FROM tags WHERE tag_name = :TAG));';
              2: frmMain.QRY.SQL.Text :=
                  'INSERT INTO recycle_tags (rt_recycle, rt_tag) VALUES (:ID, ' +
                  '(SELECT tag_id FROM tags WHERE tag_name = :TAG));'
              else
                frmMain.QRY.SQL.Text :=
                  'INSERT INTO payments_tags (pt_payment, pt_tag) VALUES (:ID, ' +
                  '(SELECT tag_id FROM tags WHERE tag_name = :TAG));';

            end;

            frmMain.QRY.Params.ParamByName('ID').AsString := VSTX.Text[N, Column];
            frmMain.QRY.Params.ParamByName('TAG').AsString := frmEdits.lbxTag.Items[I];
            frmMain.QRY.Prepare;
            frmMain.QRY.ExecSQL;
            frmMain.Tran.Commit;
          end;
        N := VSTX.GetNextSelected(N);
      end;
    end;
  end;

  frmEdits.ModalResult := mrOk;
end;

procedure TfrmEdits.btnTagClick(Sender: TObject);
begin
  if chkTag.Checked = False then
    Exit;
  frmTags.ShowModal;
  lbxTag.SetFocus;
end;

procedure TfrmEdits.cbxAccountDropDown(Sender: TObject);
begin
  {$IFDEF WINDOWS}
    ComboDDWidth(TComboBox(Sender));
  {$ENDIF}
end;

procedure TfrmEdits.cbxCategoryChange(Sender: TObject);
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

procedure TfrmEdits.cbxCommentEnter(Sender: TObject);
begin
  cbxComment.Color := IfThen(Dark = False,
      Color_focus, clDkGray);
  cbxComment.Font.Style := [fsBold];
  pnlComment.Color := IfThen(Dark = False, Color_panel_focus, clDkGray);
end;

procedure TfrmEdits.cbxCommentExit(Sender: TObject);
var
  W: word;
begin
  cbxComment.Color := clDefault;
  cbxComment.Font.Style := [];
  pnlComment.Color := clDefault;

  if ((Sender as TComboBox).Items.Count > 0) and ((Sender as TComboBox).Text <> '') then
    for W := 0 to (Sender as TComboBox).Items.Count - 1 do
      if AnsiLowerCase((Sender as TComboBox).Items[W]) = AnsiLowerCase(
        (Sender as TComboBox).Text) then
      begin
        (Sender as TComboBox).ItemIndex := W;
        break;
      end;
end;

procedure TfrmEdits.cbxTypeChange(Sender: TObject);
begin
  if chkCategory.Checked = False then
    Exit;

  cbxCategory.Tag := -1;
  FillCategory(cbxCategory, cbxType.ItemIndex);
  cbxCategoryChange(cbxCategory);
end;

procedure TfrmEdits.cbxTypeEnter(Sender: TObject);
begin
  (Sender as TComboBox).Font.Style := [fsBold];
  (Sender as TComboBox).Color := IfThen(Dark = False, Color_focus, clDkGray);
  (Sender as TComboBox).Parent.Color := IfThen(Dark = False, Color_panel_focus, clDkGray);
end;

procedure TfrmEdits.cbxTypeExit(Sender: TObject);
begin
  (Sender as TComboBox).Font.Style := [];
  (Sender as TComboBox).Color := clDefault;
  (Sender as TComboBox).Parent.Color := clDefault;

  if ((Sender as TComboBox).Name = 'cbxCategory') then
    if (cbxSubcategory.ItemIndex < 1) then
      cbxCategoryChange(cbxCategory);
end;


end.
