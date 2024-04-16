unit uniScheduler;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, ComCtrls, Buttons, Menus, CheckLst, Spin, ActnList, IniFiles,
  BCPanel, BCMDButtonFocus, LazUTF8, DateTimePicker, StrUtils, dateutils;

type

  { TfrmScheduler }

  TfrmScheduler = class(TForm)
    actExit: TAction;
    actAccounts: TAction;
    actCalc: TAction;
    actComments: TAction;
    actCategories: TAction;
    actPersons: TAction;
    actPayees: TAction;
    actTags: TAction;
    actSettings: TAction;
    actSave: TAction;
    ActionList1: TActionList;
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
    cbxSubcategory: TComboBox;
    cbxComment: TComboBox;
    cbxPayee: TComboBox;
    cbxPeriodicity: TComboBox;
    cbxPerson: TComboBox;
    cbxType: TComboBox;
    chkUseDateShift: TCheckBox;
    datDateFrom: TDateTimePicker;
    datDateTo: TDateTimePicker;
    lblDateFrom1: TLabel;
    lblDateTo1: TLabel;
    lblTag: TLabel;
    lbxTag: TCheckListBox;
    Panel2: TPanel;
    pnlDate: TPanel;
    pnlButtons: TPanel;
    pnlDateFrom1: TPanel;
    pnlDateTo1: TPanel;
    pnlRight: TPanel;
    pnlTagTop: TPanel;
    spiAmountFrom: TEdit;
    imgHeight: TImage;
    imgWidth: TImage;
    lblAccountFrom: TLabel;
    lblAccountTo: TLabel;
    lblAmountFrom: TLabel;
    lblAmountTo: TLabel;
    lblCategory: TLabel;
    lblComment: TLabel;
    lblDateFrom: TLabel;
    lblDateTo: TLabel;
    lblHeight: TLabel;
    lblPayee: TLabel;
    lblPeriodicity: TLabel;
    lblPerson: TLabel;
    lblSpecial: TLabel;
    lblType: TLabel;
    lblWidth: TLabel;
    Panel1: TPanel;
    pnlAccountFrom: TPanel;
    pnlAccounts: TPanel;
    pnlAccountTo: TPanel;
    pnlAmountFrom: TPanel;
    pnlAmountTo: TPanel;
    pnlCategory: TPanel;
    pnlComment: TPanel;
    pnlDateFrom: TPanel;
    pnlDateTo: TPanel;
    pnlFrom: TPanel;
    pnlClientLeft: TScrollBox;
    pnlPayee: TPanel;
    pnlPeriodicity: TPanel;
    pnlPerson: TPanel;
    pnlLeft: TPanel;
    pnlDetailCaption: TBCPanel;
    pnlTo: TPanel;
    pnlType: TPanel;
    spiAmountTo: TEdit;
    spiSpecial: TSpinEdit;
    splList: TSplitter;
    pnlHeight: TPanel;
    pnlBottom: TPanel;
    pnlWidth: TPanel;
    procedure btnAccountFromClick(Sender: TObject);
    procedure btnAmountFromClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnCategoriesClick(Sender: TObject);
    procedure btnCategoryClick(Sender: TObject);
    procedure btnCommentClick(Sender: TObject);
    procedure btnPayeeClick(Sender: TObject);
    procedure btnPayeesClick(Sender: TObject);
    procedure btnPersonClick(Sender: TObject);
    procedure btnSettingsClick(Sender: TObject);
    procedure btnTagClick(Sender: TObject);
    procedure cbxAccountFromDropDown(Sender: TObject);
    procedure cbxAccountFromKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure cbxAccountToKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure cbxCategoryChange(Sender: TObject);
    procedure cbxCategoryExit(Sender: TObject);
    procedure cbxCategoryKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure cbxCommentExit(Sender: TObject);
    procedure cbxCommentKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure cbxPayeeKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure cbxPeriodicityChange(Sender: TObject);
    procedure cbxPeriodicityEnter(Sender: TObject);
    procedure cbxPeriodicityExit(Sender: TObject);
    procedure cbxPeriodicityKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure cbxPersonKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure cbxSubcategoryKeyUp(Sender: TObject; var Key: word;
      Shift: TShiftState);
    procedure cbxTypeChange(Sender: TObject);
    procedure cbxTypeKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure datDateFromChange(Sender: TObject);
    procedure datDateFromEnter(Sender: TObject);
    procedure datDateFromExit(Sender: TObject);
    procedure datDateFromKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure datDateToChange(Sender: TObject);
    procedure datDateToKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure lblDateFrom1Click(Sender: TObject);
    procedure lblDateTo1Click(Sender: TObject);
    procedure pnlButtonsResize(Sender: TObject);
    procedure pnlDateResize(Sender: TObject);
    procedure spiAmountFromClick(Sender: TObject);
    procedure spiAmountFromEnter(Sender: TObject);
    procedure spiAmountFromExit(Sender: TObject);
    procedure spiAmountFromKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure spiAmountToKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure pnlAccountsResize(Sender: TObject);
    procedure spiSpecialEnter(Sender: TObject);
    procedure spiSpecialExit(Sender: TObject);
    procedure spiSpecialKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);

    procedure btnExitClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure lbxTagEnter(Sender: TObject);
    procedure lbxTagExit(Sender: TObject);
    procedure lbxTagKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure splListCanResize(Sender: TObject; var NewSize: integer;
      var Accept: boolean);
    procedure tabTypeChanging(Sender: TObject; var AllowChange: boolean);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmScheduler: TfrmScheduler;

implementation

{$R *.lfm}

uses
  uniMain, uniAccounts, uniCategories, uniPersons, uniPayees,
  uniComments, uniTags, uniResources, uniSettings;

  { TfrmScheduler }


procedure TfrmScheduler.btnPayeesClick(Sender: TObject);
begin
  frmPayees.ShowModal;
end;

procedure TfrmScheduler.btnPersonClick(Sender: TObject);
begin
  frmPersons.ShowModal;
end;

procedure TfrmScheduler.btnSettingsClick(Sender: TObject);
var
  vNode: TTreeNode;
begin
  for vNode in frmSettings.treSettings.Items do
  begin
    if vNode.AbsoluteIndex = 7 then
      vNode.Selected := True;
  end;
  frmSettings.tabTool.TabIndex := 0;
  frmSettings.ShowModal;
end;

procedure TfrmScheduler.btnTagClick(Sender: TObject);
begin
  frmTags.ShowModal;
  lbxTag.SetFocus;
end;

procedure TfrmScheduler.cbxAccountFromDropDown(Sender: TObject);
begin
  {$IFDEF WINDOWS}
    ComboDDWidth(TComboBox(Sender));
  {$ENDIF}
end;

procedure TfrmScheduler.cbxAccountFromKeyUp(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 0;
    spiAmountFrom.SetFocus;
  end;
end;

procedure TfrmScheduler.cbxAccountToKeyUp(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 0;
    spiAmountTo.SetFocus;
  end;
end;

procedure TfrmScheduler.cbxCategoryChange(Sender: TObject);
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

procedure TfrmScheduler.cbxCategoryExit(Sender: TObject);
var
  NeedUpdate: boolean;
begin
  ComboBoxExit((Sender as TCombobox));
  NeedUpdate := False;

  if (cbxCategory.ItemIndex = -1) then
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

procedure TfrmScheduler.cbxCategoryKeyUp(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 0;
    cbxSubcategory.SetFocus;
  end;
end;

procedure TfrmScheduler.cbxCommentExit(Sender: TObject);
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

procedure TfrmScheduler.cbxCommentKeyUp(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 0;
    cbxCategory.SetFocus;
  end;
end;

procedure TfrmScheduler.cbxPayeeKeyUp(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 0;
    lbxTag.SetFocus;
  end;
end;

procedure TfrmScheduler.cbxPeriodicityChange(Sender: TObject);
begin
  lblSpecial.Visible := cbxPeriodicity.ItemIndex = 1;
  spiSpecial.Visible := cbxPeriodicity.ItemIndex = 1;
  pnlDateTo.Visible := cbxPeriodicity.ItemIndex > 0;
  if cbxPeriodicity.ItemIndex = 0 then
    lblDateFrom.Caption := Trim(frmMain.pnlDateCaption.Caption)
  else
    lblDateFrom.Caption := Trim(frmMain.gbxDateFrom.Caption);
end;

procedure TfrmScheduler.cbxPeriodicityEnter(Sender: TObject);
begin
  (Sender as TComboBox).Font.Style := [fsBold];
end;

procedure TfrmScheduler.cbxPeriodicityExit(Sender: TObject);
begin
  ComboBoxExit((Sender as TComboBox));
end;

procedure TfrmScheduler.cbxPeriodicityKeyUp(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 0;
    if spiSpecial.Visible = True then
      spiSpecial.SetFocus
    else
      datDateFrom.SetFocus;
  end;
end;

procedure TfrmScheduler.cbxPersonKeyUp(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 0;
    cbxPayee.SetFocus;
  end;
end;

procedure TfrmScheduler.cbxSubcategoryKeyUp(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 0;
    cbxPerson.SetFocus;
  end;
end;

procedure TfrmScheduler.cbxTypeChange(Sender: TObject);
begin
  pnlTo.Visible := cbxType.ItemIndex = 2;
  if cbxType.ItemIndex = 2 then
    pnlTo.Width := (pnlAccounts.Width - 6) div 2;
  case cbxType.ItemIndex of
    0: lblAccountFrom.Caption := Caption_78;
    1: lblAccountFrom.Caption := Caption_77
    else
    begin
      lblAccountFrom.Caption := Caption_77;
      lblAccountTo.Caption := Caption_78;
    end;
  end;
  cbxCategory.Tag := -1;
  FillCategory(cbxCategory, cbxType.ItemIndex);
  cbxCategoryChange(cbxCategory);
end;

procedure TfrmScheduler.cbxTypeKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 0;
    cbxAccountFrom.SetFocus;
  end;
end;

procedure TfrmScheduler.datDateFromChange(Sender: TObject);
begin
  lblDateFrom1.Caption := FS_own.ShortDayNames[DayOfTheWeek(datDateFrom.Date + 1)];
end;

procedure TfrmScheduler.datDateFromEnter(Sender: TObject);
begin
  (Sender as TDateTimePicker).Font.Style := [fsBold];
end;

procedure TfrmScheduler.datDateFromExit(Sender: TObject);
begin
  (Sender as TDateTimePicker).Font.Style := [];
end;

procedure TfrmScheduler.datDateFromKeyUp(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 0;
    if pnlDateTo.Visible = True then
      datDateTo.SetFocus
    else
      cbxType.SetFocus;
  end;
end;

procedure TfrmScheduler.datDateToChange(Sender: TObject);
begin
  lblDateTo1.Caption := FS_own.ShortDayNames[DayOfTheWeek(datDateTo.Date + 1)];
end;

procedure TfrmScheduler.datDateToKeyUp(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 0;
    cbxType.SetFocus;
  end;
end;

procedure TfrmScheduler.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var
  INI: TINIFile;
  INIFile: string;
begin
  try
    // write position and window size
    if frmSettings.chkLastFormsSize.Checked = True then
    begin
      try
        INIFile := ChangeFileExt(ParamStr(0), '.ini');
        INI := TINIFile.Create(INIFile);
        if INI.ReadString('POSITION', frmScheduler.Name, '') <>
          IntToStr(frmScheduler.Left) + separ + // form left
        IntToStr(frmScheduler.Top) + separ + // form top
        IntToStr(frmScheduler.Width) + separ + // form width
        IntToStr(frmScheduler.Height) + separ + // form height
        IntToStr(frmScheduler.pnlRight.Width) then
          INI.WriteString('POSITION', frmScheduler.Name,
            IntToStr(frmScheduler.Left) + separ + // form left
            IntToStr(frmScheduler.Top) + separ + // form top
            IntToStr(frmScheduler.Width) + separ + // form width
            IntToStr(frmScheduler.Height) + separ + // form height
            IntToStr(frmScheduler.pnlRight.Width));
      finally
        INI.Free;
      end;
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmScheduler.lblDateFrom1Click(Sender: TObject);
begin
  datDateFrom.SetFocus;
end;

procedure TfrmScheduler.lblDateTo1Click(Sender: TObject);
begin
  datDateTo.SetFocus;
end;

procedure TfrmScheduler.pnlButtonsResize(Sender: TObject);
begin
  btnCancel.Repaint;
  btnSettings.Repaint;
  btnSave.Repaint;
end;

procedure TfrmScheduler.pnlDateResize(Sender: TObject);
begin
  pnlDateFrom.Width := (pnlClientLeft.Width - 7) div 2;
end;

procedure TfrmScheduler.spiAmountFromClick(Sender: TObject);
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

procedure TfrmScheduler.spiAmountFromEnter(Sender: TObject);
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

procedure TfrmScheduler.spiAmountFromExit(Sender: TObject);
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

procedure TfrmScheduler.spiAmountFromKeyUp(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 0;
    if pnlTo.Visible = True then
      cbxAccountTo.SetFocus
    else
      cbxComment.SetFocus;
  end;
end;

procedure TfrmScheduler.spiAmountToKeyUp(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 0;
    cbxComment.SetFocus;
  end;
end;

procedure TfrmScheduler.FormCreate(Sender: TObject);
begin
  lblSpecial.Caption := 'X =';

  // set components height
  pnlDetailCaption.Height := PanelHeight;
  pnlBottom.Height := ButtonHeight;
  pnlDate.Height := Round((lblDateFrom.Height + datDateFrom.Height + 10) *
    ScreenRatio / 100);

  // get form icon
  frmMain.img16.GetIcon(18, (Sender as TForm).Icon);
end;

procedure TfrmScheduler.pnlAccountsResize(Sender: TObject);
begin
  if cbxType.ItemIndex = 2 then
    pnlTo.Width := (pnlAccounts.Width - 6) div 2;
end;

procedure TfrmScheduler.btnAmountFromClick(Sender: TObject);
begin
  frmMain.mnuCalcClick(frmMain.mnuCalc);
  if Sender.ClassName = 'TSpeedButton' then
    case (Sender as TSpeedButton).Tag of
      0: spiAmountFrom.SetFocus
      else
        spiAmountTo.SetFocus
    end;
end;

procedure TfrmScheduler.btnAccountFromClick(Sender: TObject);
begin
  frmAccounts.ShowModal;
  if Sender.ClassName = 'TSpeedButton' then
    case (Sender as TSpeedButton).Tag of
      0: cbxAccountFrom.SetFocus;
      else
        cbxAccountTo.SetFocus
    end;
end;

procedure TfrmScheduler.btnCancelClick(Sender: TObject);
begin
  frmScheduler.ModalResult := mrCancel;
end;

procedure TfrmScheduler.btnCategoriesClick(Sender: TObject);
begin
  frmCategories.ShowModal;
  cbxCategory.SetFocus;
end;

procedure TfrmScheduler.btnCategoryClick(Sender: TObject);
begin
  frmCategories.ShowModal;
  cbxCategory.Tag := -1;
  cbxTypeChange(cbxType);
  cbxCategory.SetFocus;
end;

procedure TfrmScheduler.btnCommentClick(Sender: TObject);
begin
  frmComments.Showmodal;
  cbxComment.SetFocus;
end;

procedure TfrmScheduler.btnPayeeClick(Sender: TObject);
begin
  frmPayees.ShowModal;
end;

procedure TfrmScheduler.splListCanResize(Sender: TObject; var NewSize: integer;
  var Accept: boolean);
begin
  imgWidth.ImageIndex := 3;
  lblWidth.Caption := IntToStr(frmScheduler.Width - pnlRight.Width);

  imgHeight.ImageIndex := 2;
  lblHeight.Caption := IntToStr(pnlRight.Width);

  pnlButtons.Repaint;
end;

procedure TfrmScheduler.tabTypeChanging(Sender: TObject; var AllowChange: boolean);
begin
  AllowChange := cbxType.ItemIndex = 2;
end;

procedure TfrmScheduler.spiSpecialEnter(Sender: TObject);
begin
  spiSpecial.Font.Style := [fsBold];
end;

procedure TfrmScheduler.spiSpecialExit(Sender: TObject);
begin
  spiSpecial.Font.Style := [];
end;

procedure TfrmScheduler.spiSpecialKeyUp(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 0;
    datDateFrom.SetFocus;
  end;
end;

procedure TfrmScheduler.FormResize(Sender: TObject);
begin
  imgWidth.ImageIndex := 0;
  lblWidth.Caption := IntToStr(frmScheduler.Width);
  imgHeight.ImageIndex := 1;
  lblHeight.Caption := IntToStr(frmScheduler.Height);

  pnlDetailCaption.Repaint;
  pnlButtons.Repaint;
end;

procedure TfrmScheduler.FormShow(Sender: TObject);
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
      frmScheduler.Position := poDesigned;
      S := INI.ReadString('POSITION', frmScheduler.Name, '-1•-1•0•0•220');

      // width
      TryStrToInt(Field(Separ, S, 3), I);
      if (I < 1) or (I > Screen.Width) then
        frmScheduler.Width := Screen.Width div 3
      else
        frmScheduler.Width := I;

      /// height
      TryStrToInt(Field(Separ, S, 4), I);
      if (I < 1) or (I > Screen.Height) then
        frmScheduler.Height := Screen.Height - 300 - (200 - ScreenRatio)
      else
        frmScheduler.Height := I;

      // left
      TryStrToInt(Field(Separ, S, 1), I);
      if (I < 0) or (I > Screen.Width) then
        frmScheduler.left := (Screen.Width - frmScheduler.Width) div 2
      else
        frmScheduler.Left := I;

      // top
      TryStrToInt(Field(Separ, S, 2), I);
      if (I < 0) or (I > Screen.Height) then
        frmScheduler.Top := ((Screen.Height - frmScheduler.Height) div 2) - 75
      else
        frmScheduler.Top := I;

      // detail panel
      TryStrToInt(Field(Separ, S, 5), I);
      if (I < 100) or (I > 300) then
        frmScheduler.pnlRight.Width := 220
      else
        frmScheduler.pnlRight.Width := I;
    end;
  finally
    INI.Free
  end;
  // ********************************************************************
  // FORM SIZE END
  // ********************************************************************

  lblDateFrom1.Caption := FS_own.ShortDayNames[DayOfTheWeek(datDateFrom.Date + 1)];
  lblDateTo1.Caption := FS_own.ShortDayNames[DayOfTheWeek(datDateTo.Date + 1)];
  cbxPeriodicity.SetFocus;
end;

procedure TfrmScheduler.btnExitClick(Sender: TObject);
begin
  frmScheduler.Close;
end;

procedure TfrmScheduler.btnSaveClick(Sender: TObject);
var
  S: string;
begin
  // =================================================================================
  // check type
  if (cbxPeriodicity.ItemIndex = -1) then
  begin
    ShowMessage(ReplaceStr(Error_04, '%', AnsiUpperCase(lblPeriodicity.Caption)));
    cbxPeriodicity.SetFocus;
    Exit;
  end;

  // check transfer transaction
  if (cbxType.ItemIndex = 2) and (cbxType.Enabled = True) then
  begin
    // check account to
    if cbxAccountTo.ItemIndex = -1 then
    begin
      S := ReplaceStr(Error_04, '%', AnsiUpperCase(lblAccountTo.Caption));
      ShowMessage(S);
      cbxAccountTo.SetFocus;
      cbxAccountTo.SelStart := Length(cbxAccountTo.Text);
      Exit;
    end;

    // check date
    if IsValidDate(YearOf(datDateTo.Date), MonthOf(datDateTo.Date),
      DayOf(datDateTo.Date)) = False then
    begin
      S := ReplaceStr(Error_04, '%', AnsiUpperCase(lblDateTo.Caption));
      ShowMessage(S);
      datDateTo.SetFocus;
      Exit;
    end;

    // check older payment than was account created
    frmMain.QRY.SQL.Text := 'SELECT acc_date FROM accounts ' +
      'WHERE acc_currency = :CURRENCY AND acc_name = :ACCOUNT;';

    frmMain.QRY.Params.ParamByName('CURRENCY').AsString :=
      Field(separ_1, cbxAccountTo.Items[cbxAccountTo.ItemIndex], 2);
    frmMain.QRY.Params.ParamByName('ACCOUNT').AsString :=
      Field(separ_1, cbxAccountTo.Items[cbxAccountTo.ItemIndex], 1);

    frmMain.QRY.Open;
    if frmMain.QRY.RecordCount > 0 then
      if StrToDate(frmMain.QRY.FieldByName('acc_date').AsString, 'YYYY-MM-DD', '-') >
        datDateTo.Date then
      begin
        ShowMessage(
          AnsiReplaceStr(Error_13, '%', cbxAccountTo.Items[cbxAccountTo.ItemIndex]) +
          sLineBreak + DateToStr(StrToDate(frmMain.QRY.FieldByName('acc_date').AsString,
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
      S := ReplaceStr(Error_12, ' %1 ', sLineBreak +
        AnsiUpperCase(cbxAccountTo.Items[cbxAccountTo.ItemIndex]) + sLineBreak);
      S := ReplaceStr(S, ' %2 ', sLineBreak);
      ShowMessage(S + sLineBreak + sLineBreak + Error_28);
      cbxAccountFrom.SetFocus;
      Exit;
    end;
  end;

  // ==================================================================================
  // check all transactions
  // check account
  if cbxAccountFrom.ItemIndex = -1 then
  begin
    S := ReplaceStr(Error_04, '%', AnsiUpperCase(lblAccountFrom.Caption));
    ShowMessage(S);
    cbxAccountFrom.SetFocus;
    cbxAccountFrom.SelStart := Length(cbxAccountFrom.Text);
    Exit;
  end;

  // check date
  if IsValidDate(YearOf(datDateFrom.Date), MonthOf(datDateFrom.Date),
    DayOf(datDateFrom.Date)) = False then
  begin
    S := ReplaceStr(Error_04, '%', AnsiUpperCase(lblDateFrom.Caption));
    ShowMessage(S);
    datDateFrom.SetFocus;
    Exit;
  end;

  // check older payment than was account created
  frmMain.QRY.SQL.Text := 'SELECT acc_date FROM accounts ' +
    'WHERE acc_currency = :CURRENCY AND acc_name = :ACCOUNT;';

  frmMain.QRY.Params.ParamByName('CURRENCY').AsString :=
    Field(separ_1, cbxAccountFrom.Items[cbxAccountFrom.ItemIndex], 2);
  frmMain.QRY.Params.ParamByName('ACCOUNT').AsString :=
    Field(separ_1, cbxAccountFrom.Items[cbxAccountFrom.ItemIndex], 1);

  frmMain.QRY.Open;
  if frmMain.QRY.RecordCount > 0 then
    if StrToDate(frmMain.QRY.FieldByName('acc_date').AsString, 'YYYY-MM-DD', '-') >
      datDateFrom.Date then
    begin
      ShowMessage(
        AnsiReplaceStr(Error_13, '%', cbxAccountFrom.Items[cbxAccountFrom.ItemIndex]) +
        sLineBreak + DateToStr(StrToDate(frmMain.QRY.FieldByName('acc_date').AsString,
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
    ShowMessage(ReplaceStr(Error_04, '%', AnsiUpperCase(lblCategory.Caption)));
    cbxCategory.SetFocus;
    cbxCategory.SelStart := Length(cbxCategory.Text);
    Exit;
  end;

  // check subcategories
  if cbxSubcategory.ItemIndex = -1 then
  begin
    ShowMessage(ReplaceStr(Error_04, '%', AnsiUpperCase(lblCategory.Caption)));
    cbxSubcategory.SetFocus;
    cbxSubcategory.SelStart := 0;
    cbxSubcategory.SelLength := Length(cbxSubcategory.Text);
    Exit;
  end;

  // check persons
  if cbxPerson.ItemIndex = -1 then
  begin
    S := ReplaceStr(Error_04, '%', AnsiUpperCase(lblPerson.Caption));
    ShowMessage(S);
    cbxPerson.SetFocus;
    cbxPerson.SelStart := Length(cbxPerson.Text);
    Exit;
  end;

  // check payees
  if cbxPayee.ItemIndex = -1 then
  begin
    S := ReplaceStr(Error_04, '%', AnsiUpperCase(lblPayee.Caption));
    ShowMessage(S);
    cbxPayee.SetFocus;
    cbxPayee.SelStart := Length(cbxPayee.Text);
    Exit;
  end;

  // compare two dates
  if (cbxPeriodicity.ItemIndex > 0) and (frmScheduler.datDateFrom.Date >
    frmScheduler.datDateTo.Date) then
  begin
    ShowMessage(Error_15);
    datDateTo.SetFocus;
    Exit;
  end;

  frmScheduler.ModalResult := mrOk;
end;

procedure TfrmScheduler.lbxTagEnter(Sender: TObject);
begin
  (Sender as TCheckListBox).Parent.Color := Color_panel_focus;
  (Sender as TCheckListBox).Color := Color_focus;
  if (Sender as TCheckListBox).Items.Count > 0 then
    (Sender as TCheckListBox).ItemIndex := 0;
end;

procedure TfrmScheduler.lbxTagExit(Sender: TObject);
begin
  (Sender as TCheckListBox).Parent.Color := frmScheduler.Color;
  (Sender as TCheckListBox).Color := clDefault;
  (Sender as TCheckListBox).ItemIndex := -1;
end;

procedure TfrmScheduler.lbxTagKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 0;
    btnSave.SetFocus;
  end;
end;

end.
