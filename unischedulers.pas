unit uniSchedulers;

{$mode objfpc}{$H+}
{$ModeSwitch AutoDeref}

interface

uses
  Classes, SysUtils, sqldb, DB, FileUtil, Forms, Controls, Graphics, Dialogs,
  Menus, ExtCtrls, BCPanel, Buttons, StdCtrls, DBGrids, ActnList, ExtDlgs, ComCtrls,
  LazUTF8, BCMDButtonFocus, laz.VirtualTrees, StrUtils, Math, DateUtils, IniFiles;

type // main grid (Scheduler)
  TScheduler = record
    DateFrom: string;
    DateTo: string;
    Periodicity: integer;
    Comment: string;
    Amount: double;
    currency: string;
    Account: string;
    Category: string;
    SubCategory: string;
    Person: string;
    Payee: string;
    Kind: integer;
    ID: integer;
  end;
  PScheduler = ^TScheduler;

type // main grid (Scheduler)
  TPayment = record
    DatePlan: string;
    DatePaid: string;
    Amount: double;
    Kind: integer;
    ID: integer;
  end;
  PPayment = ^TPayment;

type

  { TfrmSchedulers }

  TfrmSchedulers = class(TForm)
    actAdd: TAction;
    actDelete: TAction;
    actExit: TAction;
    actEdit: TAction;
    ActionList1: TActionList;
    actCalendar: TAction;
    btnAdd: TBCMDButtonFocus;
    btnAdd1: TBCMDButtonFocus;
    btnCalendar: TBCMDButtonFocus;
    btnDelete: TBCMDButtonFocus;
    btnDelete1: TBCMDButtonFocus;
    btnEdit1: TBCMDButtonFocus;
    btnExit: TBCMDButtonFocus;
    Calendar: TCalendarDialog;
    imgHeight: TImage;
    imgItem: TImage;
    imgItem1: TImage;
    imgItems: TImage;
    imgItems1: TImage;
    imgItems2: TImage;
    imgWidth: TImage;
    lblHeight: TLabel;
    lblItem: TLabel;
    lblItem1: TLabel;
    lblItems: TLabel;
    lblItems1: TLabel;
    lblAmount: TLabel;
    lblWidth: TLabel;
    pnlBottom1: TPanel;
    pnlItem1: TPanel;
    pnlItems1: TPanel;
    pnlItems2: TPanel;
    popDelete1: TMenuItem;
    popEdit1: TMenuItem;
    popAdd1: TMenuItem;
    popDeleteDate: TMenuItem;
    popEditDate: TMenuItem;
    popExit: TMenuItem;
    pnlButton: TPanel;
    pnlPaymentsCaption: TBCPanel;
    pnlRight: TPanel;
    pnlButtons: TPanel;
    pnlHeight: TPanel;
    pnlItem: TPanel;
    pnlItems: TPanel;
    pnlList: TPanel;
    pnlListCaption: TBCPanel;
    pnlBottom: TPanel;
    pnlTip: TPanel;
    pnlWidth: TPanel;
    popAdd: TMenuItem;
    popDelete: TMenuItem;
    popList: TPopupMenu;
    popCalendar: TMenuItem;
    popDate: TPopupMenu;
    Separator1: TMenuItem;
    Separator2: TMenuItem;
    splList: TSplitter;
    VST: TLazVirtualStringTree;
    VST1: TLazVirtualStringTree;
    procedure btnAdd1Click(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnCalendarClick(Sender: TObject);
    procedure btnDelete1Click(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnEdit1Click(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure pnlButtonResize(Sender: TObject);
    procedure popDeleteDateClick(Sender: TObject);
    procedure popEditDateClick(Sender: TObject);
    procedure splListCanResize(Sender: TObject; var NewSize: integer;
      var Accept: boolean);
    procedure VST1Change(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure VST1CompareNodes(Sender: TBaseVirtualTree;
      Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: integer);
    procedure VST1DblClick(Sender: TObject);
    procedure VST1GetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Kind: TVTImageKind; Column: TColumnIndex; var Ghosted: boolean;
      var ImageIndex: integer);
    procedure VST1GetNodeDataSize(Sender: TBaseVirtualTree; var NodeDataSize: integer);
    procedure VST1GetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure VST1Resize(Sender: TObject);
    procedure VSTBeforeCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas;
      Node: PVirtualNode; Column: TColumnIndex; CellPaintMode: TVTCellPaintMode;
      CellRect: TRect; var ContentRect: TRect);
    procedure VSTChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure VSTCompareNodes(Sender: TBaseVirtualTree; Node1,
      Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
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

  public

  end;

procedure UpdateScheduler;
procedure GeneratePayments(ID: string);

var
  frmSchedulers: TfrmSchedulers;

implementation

{$R *.lfm}

{ TfrmSchedulers }

uses
  uniMain, uniScheduler, uniSettings, uniCalendar, uniResources, uniEdits, uniEdit,
  uniHolidays;

procedure TfrmSchedulers.btnAddClick(Sender: TObject);
var
  S, Sum: string;
  Amount: double;
  I: word;
begin
  if (frmMain.Conn.Connected = False) then
    Exit;

  try
    // panel Detail
    if frmScheduler.cbxType.ItemIndex = -1 then
      frmScheduler.cbxType.ItemIndex := 1;
    frmScheduler.cbxTypeChange(frmScheduler.cbxType);

    // set all fields FROM
    if frmScheduler.cbxPeriodicity.ItemIndex = -1 then
      frmScheduler.cbxPeriodicity.ItemIndex := 5;
    frmScheduler.datDateFrom.Date := Now();
    frmScheduler.datDateTo.Date := Now() + 364;

    frmScheduler.spiAmountFrom.Text := Format('%n', [0.0]);
    frmScheduler.cbxComment.ItemIndex := -1;
    if (frmScheduler.cbxPerson.ItemIndex = -1) and
      (frmScheduler.cbxPerson.Items.Count > 0) then
      frmScheduler.cbxPerson.ItemIndex := 0;
    if (frmScheduler.cbxAccountFrom.ItemIndex = -1) and
      (frmScheduler.cbxAccountFrom.Items.Count > 0) then
      frmScheduler.cbxAccountFrom.ItemIndex := 0;
    if (frmScheduler.cbxPayee.ItemIndex = -1) and
      (frmScheduler.cbxPayee.Items.Count > 0) then
      frmScheduler.cbxPayee.ItemIndex := 0;
    if (frmScheduler.cbxCategory.ItemIndex = -1) and
      (frmScheduler.cbxCategory.Items.Count > 0) then
      frmScheduler.cbxCategory.ItemIndex := 0;
    frmScheduler.cbxCategoryChange(frmScheduler.cbxCategory);

    // set all fields TO
    frmScheduler.spiAmountTo.Text := Format('%n', [0.0]);
    if (frmScheduler.cbxAccountTo.ItemIndex = -1) and
      (frmScheduler.cbxAccountTo.Items.Count > 0) then
      frmScheduler.cbxAccountTo.ItemIndex := 0;

    frmScheduler.lbxTag.CheckAll(cbUnchecked, False, False);
    frmScheduler.lbxTag.ItemIndex := -1;

    frmScheduler.pnlDetailCaption.Caption := AnsiUpperCase(Caption_45);

    if frmScheduler.ShowModal <> mrOk then Exit;

    frmMain.QRY.SQL.Text :=
      'INSERT INTO scheduler (sch_date_from, sch_date_to, sch_period, sch_type, ' +
      'sch_sum1, sch_comment, sch_account1, sch_category, sch_person, sch_payee, ' +
      'sch_sum2, sch_account2) VALUES (' +
      ':DATE1, :DATE2, :PERIODICITY, :TYPE, :AMOUNT1, :COMMENT, ' +
      '(SELECT acc_id FROM accounts ' + sLineBreak + // account
      'WHERE acc_name = :ACCOUNT1 and acc_currency = :CURRENCY1), ' +
      sLineBreak + // d_account
      ':CATEGORY, ' +
      sLineBreak + // subcategory
      '(SELECT per_id FROM persons WHERE per_name = :PERSON), ' +
      sLineBreak + // d_person
      '(SELECT pee_id FROM payees WHERE pee_name = :PAYEE), ' + // d_payee
      IfThen(frmScheduler.cbxType.ItemIndex < 2, '0, NULL);',
      ':AMOUNT2, ' + '(SELECT acc_id FROM accounts ' + sLineBreak + // account
      'WHERE acc_name = :ACCOUNT2 and acc_currency = :CURRENCY2));');  // d_account

    frmMain.QRY.Params.ParamByName('DATE1').AsString :=
      FormatDateTime('YYYY-MM-DD', frmScheduler.datDateFrom.Date);
    if frmScheduler.cbxPeriodicity.ItemIndex = 0 then
      frmScheduler.datDateTo.Date := frmScheduler.datDateFrom.Date;
    frmMain.QRY.Params.ParamByName('DATE2').AsString :=
      FormatDateTime('YYYY-MM-DD', frmScheduler.datDateFrom.Date);
    frmMain.QRY.Params.ParamByName('PERIODICITY').AsInteger :=
      IfThen(frmScheduler.spiSpecial.Visible = True, frmScheduler.spiSpecial.Value *
      -1, frmScheduler.cbxPeriodicity.ItemIndex);
    frmMain.QRY.Params.ParamByName('TYPE').AsInteger :=
      frmScheduler.cbxType.ItemIndex;
    // IfThen(frmScheduler.cbxType.ItemIndex = 2, 3, frmScheduler.cbxType.ItemIndex);
    frmMain.QRY.Params.ParamByName('COMMENT').AsString :=
      Trim(frmScheduler.cbxComment.Text);
    frmMain.QRY.Params.ParamByName('PERSON').AsString := frmScheduler.cbxPerson.Text;
    frmMain.QRY.Params.ParamByName('PAYEE').AsString := frmScheduler.cbxPayee.Text;
    // account 1
    frmMain.QRY.Params.ParamByName('ACCOUNT1').AsString :=
      Field(separ_1, frmScheduler.cbxAccountFrom.Items[
      frmScheduler.cbxAccountFrom.ItemIndex], 1);
    frmMain.QRY.Params.ParamByName('CURRENCY1').AsString :=
      Field(separ_1, frmScheduler.cbxAccountFrom.Items[
      frmScheduler.cbxAccountFrom.ItemIndex], 2);

    // account 2
    if frmScheduler.cbxType.ItemIndex = 2 then
    begin
      frmMain.QRY.Params.ParamByName('ACCOUNT2').AsString :=
        Field(separ_1, frmScheduler.cbxAccountTo.Items[
        frmScheduler.cbxAccountTo.ItemIndex], 1);
      frmMain.QRY.Params.ParamByName('CURRENCY2').AsString :=
        Field(separ_1, frmScheduler.cbxAccountTo.Items[
        frmScheduler.cbxAccountTo.ItemIndex], 2);
    end;

    // Get category
    frmMain.QRY.Params.ParamByName('CATEGORY').AsInteger :=
      GetCategoryID(frmScheduler.cbxCategory.Items[frmScheduler.cbxCategory.ItemIndex] +
      IfThen(frmScheduler.cbxSubcategory.ItemIndex = 0, '', separ_1 +
      frmScheduler.cbxSubcategory.Items[frmScheduler.cbxSubcategory.ItemIndex]));

    // amount 1
    Sum := ReplaceStr(frmScheduler.spiAmountFrom.Text, FS_own.ThousandSeparator, '');
    Sum := ReplaceStr(Sum, '.', FS_own.DecimalSeparator);
    Sum := ReplaceStr(Sum, ',', FS_own.DecimalSeparator);
    TryStrToFloat(Sum, Amount);
    if frmScheduler.cbxType.ItemIndex > 0 then
      Amount := -Amount;
    Sum := FloatToStr(amount);
    frmMain.QRY.Params.ParamByName('AMOUNT1').AsString :=
      ReplaceStr(Sum, FS_own.DecimalSeparator, '.');

    // amount 2
    if frmScheduler.cbxType.ItemIndex = 2 then
    begin
    Sum := ReplaceStr(frmScheduler.spiAmountTo.Text, FS_own.ThousandSeparator, '');
    Sum := ReplaceStr(Sum, '.', FS_own.DecimalSeparator);
    Sum := ReplaceStr(Sum, ',', FS_own.DecimalSeparator);
    TryStrToFloat(Sum, Amount);
    Sum := FloatToStr(amount);
    frmMain.QRY.Params.ParamByName('AMOUNT2').AsString :=
        ReplaceStr(Sum, FS_own.DecimalSeparator, '.');
    end;

    frmMain.QRY.Prepare;
    frmMain.QRY.ExecSQL;

    S := frmMain.Conn.GetInsertID.ToString;

    // ***************************************************************************************
    // write tags to joined table SCHEDULERS_TAGS
    if (frmScheduler.lbxTag.Count > 0) then
    begin
      for I := 0 to frmScheduler.lbxTag.Count - 1 do
        if frmScheduler.lbxTag.Checked[I] = True then
        begin
          frmMain.QRY.SQL.Text :=
            'INSERT INTO schedulers_tags (st_scheduler, st_tag) VALUES (' +
            S + ', (SELECT tag_id FROM tags WHERE tag_name = :TAG));';
          frmMain.QRY.Params.ParamByName('TAG').AsString :=
            frmScheduler.lbxTag.Items[I];
          frmMain.QRY.Prepare;
          frmMain.QRY.ExecSQL;
        end;
    end;
    // ***************************************************************************************

    frmMain.Tran.Commit;

    GeneratePayments(S);

    UpdateScheduler;
    FindNewRecord(VST, 12);

  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure GeneratePayments(ID: string);
label
  ChangeDate;
var
  Period, Y, M, D: word;
  I: integer;
  D1, D2, D3, D4: TDate;
  Amount: double;
  S: string;
  N: PVirtualNode;
  GoodDate: boolean;
begin
  // =============================================================================================
  // GENERATE PAYMENTS
  // =============================================================================================

  D1 := frmScheduler.datDateFrom.Date;
  D2 := frmScheduler.datDateTo.Date;

  frmMain.Tran.Commit;
  frmMain.Tran.StartTransaction;

  while D1 <= D2 do
  begin

    D3 := D1;

    if frmScheduler.chkUseDateShift.Checked = True then
    begin
      // ========================================================================================
      // CHECK THE WRONG DAYS (SATURDAY, SUNDAY, PUBLIC HOLIDAYS)
      // IN MONTHLY, QUARTERLY, BIANNUALY AND YEARLY PERIODICITY
      // ========================================================================================

      if frmScheduler.cbxPeriodicity.ItemIndex in [5..8] then
      begin
        // label to jump when day is saturday, sunday or holiday
        ChangeDate:

          // compare SUNDAY
          if (frmSettings.chkSunday.Checked = True) and
            (DayOfTheWeek(D3) = DaySunday) then
          begin
            D3 := D3 + IfThen(frmSettings.rbtBefore.Checked = True, -1, 1);
            goto ChangeDate;
          end;

        // compare SATURDAY
        if (frmSettings.chkSaturday.Checked = True) and
          (DayOfTheWeek(D3) = DaySaturday) then
        begin
          D3 := D3 + IfThen(frmSettings.rbtBefore.Checked = True, -1, 1);
          goto ChangeDate;
        end;

        // compare PUBLIC HOLIDAYS
        if (frmSettings.chkHoliday.Checked = True) then
        begin
          GoodDate := True;
          N := frmHolidays.VST.GetFirst;
          while Assigned(N) do
          begin
            D4 := EncodeDate(YearOf(D3), StrToInt(frmHolidays.VST.Text[N, 4]),
              StrToInt(frmHolidays.VST.Text[N, 5]));

            if CompareDate(D3, D4) = 0 then
            begin
              GoodDate := False;
              D3 := D3 + IfThen(frmSettings.rbtBefore.Checked = True, -1, 1);
            end;
            if GoodDate = False then
              Break
            else
              N := frmHolidays.VST.GetNext(N);
          end;
          if GoodDate = False then
            goto ChangeDate;
        end;
      end;
    end;

    // ========================================================================================
    // END OF CHECKING
    // ========================================================================================

    frmMain.QRY.SQL.Text :=
      'INSERT INTO payments (pay_date_plan, pay_date_paid, pay_type, pay_sum, pay_comment, '
      + 'pay_account, pay_category, pay_person, pay_payee, pay_sch_id) VALUES (' +
      ':DATE, NULL, :TYPE, :SUM, :COMMENT, ' +
      // d_account
      '(SELECT acc_id FROM accounts ' +
      'WHERE acc_name = :ACCOUNT and acc_currency = :CURRENCY), ' + sLineBreak +
      // d_category
      ':CATEGORY, ' + sLineBreak +
      // d_person
      '(SELECT per_id FROM persons WHERE per_name = :PERSON), ' + sLineBreak +
      // d_payee
      '(SELECT pee_id FROM payees WHERE pee_name = :PAYEE),' + sLineBreak + ':ID);';

    frmMain.QRY.Params.ParamByName('DATE').AsString :=
      FormatDateTime('YYYY-MM-DD', D3);
    frmMain.QRY.Params.ParamByName('TYPE').AsInteger :=
      IfThen(frmScheduler.cbxType.ItemIndex = 2, 3, frmScheduler.cbxType.ItemIndex);
    frmMain.QRY.Params.ParamByName('COMMENT').AsString :=
      Trim(frmScheduler.cbxComment.Text);
    frmMain.QRY.Params.ParamByName('PERSON').AsString := frmScheduler.cbxPerson.Text;
    frmMain.QRY.Params.ParamByName('PAYEE').AsString := frmScheduler.cbxPayee.Text;
    frmMain.QRY.Params.ParamByName('ACCOUNT').AsString :=
      Field(separ_1, frmScheduler.cbxAccountFrom.Items[
      frmScheduler.cbxAccountFrom.ItemIndex], 1);
    frmMain.QRY.Params.ParamByName('CURRENCY').AsString :=
      Field(separ_1, frmScheduler.cbxAccountFrom.Items[
      frmScheduler.cbxAccountFrom.ItemIndex], 2);

    // Get category
    frmMain.QRY.Params.ParamByName('CATEGORY').AsInteger :=
      GetCategoryID(frmScheduler.cbxCategory.Items[frmScheduler.cbxCategory.ItemIndex] +
      IfThen(frmScheduler.cbxSubcategory.ItemIndex = 0, '', separ_1 +
      frmScheduler.cbxSubcategory.Items[frmScheduler.cbxSubcategory.ItemIndex]));

    // amount
    S := ReplaceStr(frmScheduler.spiAmountFrom.Text, FS_own.ThousandSeparator, '');
    S := ReplaceStr(S, '.', FS_own.DecimalSeparator);
    S := ReplaceStr(S, ',', FS_own.DecimalSeparator);
    TryStrToFloat(S, Amount);
    I := IfThen(frmScheduler.cbxType.ItemIndex = 2, 3, frmScheduler.cbxType.ItemIndex);
    if I in [1, 3] then
      Amount := -Amount;
    S := FloatToStr(amount);
    frmMain.QRY.Params.ParamByName('SUM').AsString :=
      ReplaceStr(S, FS_own.DecimalSeparator, '.');
    frmMain.QRY.Params.ParamByName('ID').AsString := ID;
    frmMain.QRY.Prepare;
    frmMain.QRY.ExecSQL;

    // ***************************************************************************************
    // write tags to joined table PAYMENTS_TAGS
    if (frmScheduler.lbxTag.Count > 0) then
    begin
      S := frmMain.Conn.GetInsertID.ToString;
      for I := 0 to frmScheduler.lbxTag.Count - 1 do
        if frmScheduler.lbxTag.Checked[I] = True then
        begin
          frmMain.QRY.SQL.Text :=
            'INSERT INTO payments_tags (pt_payment, pt_tag) VALUES (' +
            S + ', (SELECT tag_id FROM tags WHERE tag_name = :TAG));';

          frmMain.QRY.Params.ParamByName('TAG').AsString :=
            frmScheduler.lbxTag.Items[I];
          frmMain.QRY.Prepare;
          frmMain.QRY.ExecSQL;
        end;
    end;

    // ===========================================================================================
    if frmScheduler.cbxType.ItemIndex = 2 then
    begin
      frmMain.QRY.SQL.Text :=
        'INSERT INTO payments (pay_date_plan, pay_date_paid, pay_type, pay_sum, pay_comment, '
        + 'pay_account, pay_category, pay_person, pay_payee, pay_sch_id) VALUES ('
        + ':DATE, NULL, :TYPE, :S, :COMMENT, ' +
        // d_account
        '(SELECT acc_id FROM accounts ' +
        'WHERE acc_name = :ACCOUNT and acc_currency = :CURRENCY), ' + sLineBreak +
        // d_category
        ':CATEGORY, ' + sLineBreak +
        // d_person
        '(SELECT per_id FROM persons WHERE per_name = :PERSON), ' + sLineBreak +
        // d_payee
        '(SELECT pee_id FROM payees WHERE pee_name = :PAYEE),' + sLineBreak + ':ID);';

      frmMain.QRY.Params.ParamByName('DATE').AsString :=
        FormatDateTime('YYYY-MM-DD', D3);
      frmMain.QRY.Params.ParamByName('TYPE').AsInteger := 2;
      frmMain.QRY.Params.ParamByName('COMMENT').AsString :=
        Trim(frmScheduler.cbxComment.Text);
      frmMain.QRY.Params.ParamByName('PERSON').AsString := frmScheduler.cbxPerson.Text;
      frmMain.QRY.Params.ParamByName('PAYEE').AsString := frmScheduler.cbxPayee.Text;
      frmMain.QRY.Params.ParamByName('ACCOUNT').AsString :=
        Field(separ_1, frmScheduler.cbxAccountTo.Items[
        frmScheduler.cbxAccountTo.ItemIndex], 1);
      frmMain.QRY.Params.ParamByName('CURRENCY').AsString :=
        Field(separ_1, frmScheduler.cbxAccountTo.Items[
        frmScheduler.cbxAccountTo.ItemIndex], 2);
      // Get category
      frmMain.QRY.Params.ParamByName('CATEGORY').AsInteger :=
      GetCategoryID(frmScheduler.cbxCategory.Items[frmScheduler.cbxCategory.ItemIndex] +
      IfThen(frmScheduler.cbxSubcategory.ItemIndex = 0, '', separ_1 +
      frmScheduler.cbxSubcategory.Items[frmScheduler.cbxSubcategory.ItemIndex]));
    // amount

    S := ReplaceStr(frmScheduler.spiAmountTo.Text, FS_own.ThousandSeparator, '');
    S := ReplaceStr(S, '.', FS_own.DecimalSeparator);
    S := ReplaceStr(S, ',', FS_own.DecimalSeparator);

      TryStrToFloat(S, Amount);
      S := FloatToStr(amount);
      frmMain.QRY.Params.ParamByName('S').AsString :=
        ReplaceStr(S, FS_own.DecimalSeparator, '.');
      frmMain.QRY.Params.ParamByName('ID').AsString := ID;
      frmMain.QRY.Prepare;
      frmMain.QRY.ExecSQL;

      // ***************************************************************************************
      // write tags to joined table PAYMENTS_TAGS
      if (frmScheduler.lbxTag.Count > 0) then
      begin
        S := frmMain.Conn.GetInsertID.ToString;
        for I := 0 to frmScheduler.lbxTag.Count - 1 do
          if frmScheduler.lbxTag.Checked[I] = True then
          begin
            frmMain.QRY.SQL.Text :=
              'INSERT INTO payments_tags (pt_payment, pt_tag) VALUES (' +
              S + ', (SELECT tag_id FROM tags WHERE tag_name = :TAG));';
            frmMain.QRY.Params.ParamByName('TAG').AsString :=
              frmScheduler.lbxTag.Items[I];
            frmMain.QRY.Prepare;
            frmMain.QRY.ExecSQL;
          end;
      end;

      // ===========================================================================================
    end;

    case frmScheduler.cbxPeriodicity.ItemIndex of
      0..4: begin
        case frmScheduler.cbxPeriodicity.ItemIndex of
          0, 2: Period := 1; // daily
          1: Period := frmScheduler.spiSpecial.Value; // every X days
          3: Period := 7;  // weekly
          4: Period := 14; // fortnightly
        end;
        D1 := D1 + Period;
      end;
      5: begin // monthly
        Y := IfThen(MonthOf(D1) = 12, YearOf(D1) + 1, YearOf(D1));
        M := IfThen(MonthOf(D1) = 12, 1, MonthOf(D1) + 1);
        D := DayOf(frmScheduler.datDateFrom.Date);
        if D > DaysInAMonth(Y, M) then D := DaysInAMonth(Y, M);
        D1 := EncodeDate(Y, M, D);
      end;

      6: begin // quarterly
        Y := IfThen(MonthOf(D1) > 9, YearOf(D1) + 1, YearOf(D1));
        M := IfThen(MonthOf(D1) > 9, MonthOf(D1) - 9, MonthOf(D1) + 3);
        D := DayOf(frmScheduler.datDateFrom.Date);
        if D > DaysInAMonth(Y, M) then D := DaysInAMonth(Y, M);
        D1 := EncodeDate(Y, M, D);
      end;
      7: begin // biannualy
        Y := IfThen(MonthOf(D1) > 6, YearOf(D1) + 1, YearOf(D1));
        M := IfThen(MonthOf(D1) > 6, MonthOf(D1) - 6, MonthOf(D1) + 6);
        D := DayOf(frmScheduler.datDateFrom.Date);
        if D > DaysInAMonth(Y, M) then D := DaysInAMonth(Y, M);
        D1 := EncodeDate(Y, M, D);
      end;
      8: // yearly
        D1 := EncodeDate(YearOf(D1) + 1, MonthOf(D1), DayOf(D1));
    end;
    //ShowMessage (IntToStr(frmScheduler.cbxPeriodicity.ItemIndex) + sLineBreak + DateToStr(D1));
  end;

  // execute SQL commands
  frmMain.Tran.Commit;
end;

procedure TfrmSchedulers.btnCalendarClick(Sender: TObject);
begin
  frmCalendar.ShowModal;
end;

procedure TfrmSchedulers.btnDelete1Click(Sender: TObject);
var
  IDs: string;
  N: PVirtualNode;
begin
  try
    if (frmMain.Conn.Connected = False) or (VST1.RootNodeCount = 0) or
      (VST1.SelectedCount = 0) then
      exit;

    // get IDs of all selected nodes
    IDs := '';
    N := VST1.GetFirstSelected(False);
    try
      while Assigned(N) do
      begin
        IDs := IDs + VST1.Text[N, 4] + ',';
        N := VST1.GetNextSelected(N);
      end;
    finally
      IDs := LeftStr(IDs, Length(IDs) - 1);
    end;

    case VST1.SelectedCount of
      1: if MessageDlg(Message_00, Question_01 + sLineBreak +
          sLineBreak + VST1.Header.Columns[1].Text + ': ' +
          VST1.Text[VST1.FocusedNode, 1] + sLineBreak + VST1.Header.Columns[2].Text +
          ': ' + VST1.Text[VST1.FocusedNode, 2] + sLineBreak +
          VST1.Header.Columns[3].Text + ': ' + VST1.Text[VST1.FocusedNode, 3],
          mtConfirmation, mbYesNo, 0) <> 6 then
        begin
          //VST1.SetFocus;
          Exit;
        end;
      else
        if MessageDlg(Message_00, AnsiReplaceStr(Question_02, '%',
          IntToStr(VST1.SelectedCount)), mtConfirmation, mbYesNo, 0) <> 6 then
        begin
          //VST1.SetFocus;
          Exit;
        end;
    end;

    frmMain.QRY.SQL.Text := 'DELETE FROM payments WHERE pay_id IN (' + IDs + ')';
    frmMain.QRY.ExecSQL;
    frmMain.Tran.Commit;

  finally
    IDs := VST.Text[VST.GetFirstSelected(), 12];
    UpdateScheduler;
    FindEditedRecord(VST, 12, StrToInt(IDs));
    VST.SetFocus;
  end;
end;

procedure TfrmSchedulers.btnAdd1Click(Sender: TObject);
var
  I, Period, Y, M, D: integer;
  X: double;
  D1: TDate;
  S, L: string;
begin
  if (frmMain.Conn.Connected = False) or (VST.SelectedCount <> 1) then
    Exit;

  try
    // get values from table PAYMENTS
    frmMain.QRY.SQL.Text :=
      'SELECT ' + // SELECT statement
      'sch_period, ' + // period
      'sch_date_to, ' + // date from
      'sch_type, ' + // type
      'sch_comment, ' + // comment
      'Round(sch_sum1, 2) as sch_sum1, ' + // sum 1
      'Round(sch_sum2, 2) as sch_sum2, ' + // sum 2
      '(SELECT acc_currency FROM accounts WHERE acc_id = sch_account1) as currency1,' +
      sLineBreak + // currency 1
      '(SELECT acc_name FROM accounts WHERE acc_id = sch_account1) as account1,' +
      sLineBreak + // name 1
      '(SELECT acc_currency FROM accounts WHERE acc_id = sch_account2) as currency2,' +
      sLineBreak + // currency 2
      '(SELECT acc_name FROM accounts WHERE acc_id = sch_account2) as account2,' +
      sLineBreak + // name 2
      'cat_parent_name, cat_name, cat_parent_ID, ' + // category ID
      '(SELECT per_name FROM persons WHERE per_id = sch_person) as per_name, ' +
      // person;
      '(SELECT pee_name FROM payees WHERE pee_id = sch_payee) as pee_name, ' + // payee;
      'sch_id ' + // type
      'FROM scheduler ' + sLineBreak + // FROM table DATA
      'LEFT JOIN ' + sLineBreak +// JOIN
      'categories ON (cat_id = sch_category) ' + sLineBreak +// categories
      'WHERE sch_id = :ID;';

    frmMain.QRY.Params.ParamByName('ID').AsString :=
      VST.Text[VST.GetFirstSelected(), 12];
    frmMain.QRY.Prepare;

  finally
    //ShowMessage (frmMain.QRY.SQL.Text);
    frmMain.QRY.Open;

    // periodicity
    I := frmMain.QRY.FieldByName('sch_period').AsInteger;
    if I < 0 then
    begin
      frmScheduler.cbxPeriodicity.ItemIndex := 1;
      frmScheduler.spiSpecial.Value := ABS(I);
    end
    else
      frmScheduler.cbxPeriodicity.ItemIndex := I;
    frmScheduler.cbxPeriodicityChange(frmScheduler.cbxPeriodicity);

    // date from
    D1 := StrToDate(frmMain.QRY.FieldByName('sch_date_to').AsString, 'YYYY-MM-DD', '-');
    case frmScheduler.cbxPeriodicity.ItemIndex of
      0..4: begin
        case frmScheduler.cbxPeriodicity.ItemIndex of
          0: Period := 1; // once
          1: Period := frmScheduler.spiSpecial.Value; // every X days
          2: Period := 1; // daily
          3: Period := 7;  // weekly
          4: Period := 14; // fortnightly
        end;
        D1 := D1 + Period;
      end;
      5: begin // monthly
        Y := IfThen(MonthOf(D1) = 12, YearOf(D1) + 1, YearOf(D1));
        M := IfThen(MonthOf(D1) = 12, 1, MonthOf(D1) + 1);
        D := DayOf(frmScheduler.datDateFrom.Date);
        if D > DaysInAMonth(Y, M) then D := DaysInAMonth(Y, M);
        D1 := EncodeDate(Y, M, D);
      end;

      6: begin // quarterly
        Y := IfThen(MonthOf(D1) > 9, YearOf(D1) + 1, YearOf(D1));
        M := IfThen(MonthOf(D1) > 9, MonthOf(D1) - 9, MonthOf(D1) + 3);
        D := DayOf(frmScheduler.datDateFrom.Date);
        if D > DaysInAMonth(Y, M) then D := DaysInAMonth(Y, M);
        D1 := EncodeDate(Y, M, D);
      end;
      7: begin // biannualy
        Y := IfThen(MonthOf(D1) > 6, YearOf(D1) + 1, YearOf(D1));
        M := IfThen(MonthOf(D1) > 6, MonthOf(D1) - 6, MonthOf(D1) + 6);
        D := DayOf(frmScheduler.datDateFrom.Date);
        if D > DaysInAMonth(Y, M) then D := DaysInAMonth(Y, M);
        D1 := EncodeDate(Y, M, D);
      end;
      8: // yearly
        D1 := EncodeDate(YearOf(D1) + 1, MonthOf(D1), DayOf(D1));
    end;
    frmScheduler.datDateFrom.Date := D1;

    // date to
    frmScheduler.datDateTo.Date :=
      D1 + IfThen(frmScheduler.cbxPeriodicity.ItemIndex = 0, 0, 365);

    // type
    I := frmMain.QRY.FieldByName('sch_type').AsInteger;
    frmScheduler.cbxType.ItemIndex := IfThen(I = 3, 2, I);
    frmScheduler.cbxTypeChange(frmScheduler.cbxType);

    // account 1
    frmScheduler.cbxAccountFrom.ItemIndex :=
      frmScheduler.cbxAccountFrom.Items.IndexOf(
      frmMain.QRY.FieldByName('account1').AsString + separ_1 +
      frmMain.QRY.FieldByName('currency1').AsString);

    // account 2
    frmScheduler.cbxAccountTo.ItemIndex :=
      frmScheduler.cbxAccountTo.Items.IndexOf(frmMain.QRY.FieldByName(
      'account2').AsString + separ_1 + frmMain.QRY.FieldByName('currency2').AsString);

    // amount 1
    TryStrToFloat(frmMain.QRY.FieldByName('sch_sum1').AsString, X);
    if frmScheduler.cbxType.ItemIndex > 0 then X := ABS(X);
    frmScheduler.spiAmountFrom.Text := FloatToStr(X);

    // amount 2
    TryStrToFloat(frmMain.QRY.FieldByName('sch_sum2').AsString, X);
    frmScheduler.spiAmountTo.Text := FloatToStr(X);

    // comment
    frmScheduler.cbxComment.Text := frmMain.QRY.FieldByName('sch_comment').AsString;

    // category
    S := AnsiUpperCase(IfThen(frmMain.QRY.FieldByName('cat_parent_ID').AsInteger =
      0, frmMain.QRY.FieldByName('cat_name').AsString,
      frmMain.QRY.FieldByName('cat_parent_name').AsString)) +
      IfThen(frmMain.QRY.FieldByName('cat_parent_ID').AsInteger = 0,
      '', separ_1 + frmMain.QRY.FieldByName('cat_name').AsString);
    frmScheduler.cbxCategory.ItemIndex := frmScheduler.cbxCategory.Items.IndexOf(S);

    // person
    frmScheduler.cbxPerson.ItemIndex :=
      frmScheduler.cbxPerson.Items.IndexOf(frmMain.QRY.FieldByName('per_name').AsString);

    // payee
    frmScheduler.cbxPayee.ItemIndex :=
      frmScheduler.cbxPayee.Items.IndexOf(frmMain.QRY.FieldByName('pee_name').AsString);

    frmMain.QRY.Close;
  end;

  // *******************************************************************************
  // get values from table SCHEDULER-TAGS
  frmScheduler.lbxTag.CheckAll(cbUnchecked, False, False);
  frmMain.QRY.SQL.Text := 'SELECT tag_name FROM tags WHERE tag_id IN (' +
    'SELECT st_tag FROM schedulers_tags WHERE st_scheduler = ' +
    VST.Text[VST.FocusedNode, 12] + ');';
  frmMain.QRY.Open;
  while not (frmMain.QRY.EOF) do
  begin
    frmScheduler.lbxTag.Checked[frmScheduler.lbxTag.Items.IndexOf(
      frmMain.QRY.FieldByName('tag_name').AsString)] := True;
    frmMain.QRY.Next;
  end;
  frmScheduler.lbxTag.ItemIndex := -1;
  frmMain.QRY.Close;
  // *******************************************************************************

  if frmScheduler.ShowModal <> mrOk then
    Exit;

  L := VST.Text[VST.GetFirstSelected(), 12];
  GeneratePayments(L);

  UpdateScheduler;
  FindEditedRecord(VST, 12, StrToInt(L));
end;

procedure TfrmSchedulers.btnDeleteClick(Sender: TObject);
var
  IDs: string;
  N: PVirtualNode;
begin
  if (frmMain.Conn.Connected = False) or (VST.RootNodeCount = 0) or
    (VST.SelectedCount = 0) then
    exit;

  if VST1.Focused = True then
  begin
    btnDelete1Click(btnDelete1);
    Exit;
  end;

  try

    // get IDs of all selected nodes
    IDs := '';
    N := VST.GetFirstSelected(False);
    try
      while Assigned(N) do
      begin
        IDs := IDs + VST.Text[N, 12] + ',';
        N := VST.GetNextSelected(N);
      end;
    finally
      IDs := LeftStr(IDs, Length(IDs) - 1);
    end;

    case VST.SelectedCount of
      1: if MessageDlg(Message_00, Question_01 + sLineBreak +
          sLineBreak + VST.Header.Columns[1].Text + ': ' +
          VST.Text[VST.FocusedNode, 1] + sLineBreak + VST.Header.Columns[2].Text +
          ': ' + VST.Text[VST.FocusedNode, 2] + sLineBreak +
          VST.Header.Columns[3].Text + ': ' + VST.Text[VST.FocusedNode, 3] +
          sLineBreak + VST.Header.Columns[4].Text + ': ' +
          VST.Text[VST.FocusedNode, 4] + sLineBreak + VST.Header.Columns[5].Text +
          ': ' + VST.Text[VST.FocusedNode, 5], mtConfirmation, mbYesNo, 0) <> 6 then
          Exit;
      else
        if MessageDlg(Message_00, AnsiReplaceStr(Question_02, '%',
          IntToStr(VST.SelectedCount)), mtConfirmation, mbYesNo, 0) <> 6 then
          Exit;
    end;

    frmMain.QRY.SQL.Text := 'DELETE FROM scheduler WHERE sch_id IN (' + IDs + ')';
    frmMain.QRY.ExecSQL;
    frmMain.Tran.Commit;

    UpdateScheduler;

  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmSchedulers.btnEdit1Click(Sender: TObject);
var
  ID: integer;
begin
  case VST1.SelectedCount of
    0: Exit;
    1: begin
      frmEdit.Tag := 6;
      ID := StrToInt(VST1.Text[VST1.GetFirstSelected(), 4]);
      if frmEdit.ShowModal <> mrOk then
        Exit;
    end
    else
    begin
      frmEdits.Tag := 6;
      ID := 0;
      frmEdits.btnResetClick(frmEdits.btnReset);
      if frmEdits.ShowModal <> mrOk then
        Exit;
    end;
  end;

  VSTChange(VST, VST.GetFirstSelected);
  VST1.SetFocus;

  if ID > 0 then
    FindEditedRecord(VST1, 4, ID);

end;

procedure TfrmSchedulers.btnExitClick(Sender: TObject);
begin
  frmSchedulers.Close;
end;

procedure TfrmSchedulers.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
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
        if INI.ReadString('POSITION', frmSchedulers.Name, '') <>
          IntToStr(frmSchedulers.Left) + separ + // form left
        IntToStr(frmSchedulers.Top) + separ + // form top
        IntToStr(frmSchedulers.Width) + separ + // form width
        IntToStr(frmSchedulers.Height) + separ + // form height
        IntToStr(frmSchedulers.pnlRight.Width) then
          INI.WriteString('POSITION', frmSchedulers.Name,
            IntToStr(frmSchedulers.Left) + separ + // form left
            IntToStr(frmSchedulers.Top) + separ + // form top
            IntToStr(frmSchedulers.Width) + separ + // form width
            IntToStr(frmSchedulers.Height) + separ + // form height
            IntToStr(frmSchedulers.pnlRight.Width));
      finally
        INI.Free;
      end;
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmSchedulers.FormCreate(Sender: TObject);
begin
  try
  // set components height
    VST.Header.Height := PanelHeight;
    VST1.Header.Height := PanelHeight;
    pnlPaymentsCaption.Height := PanelHeight;
    pnlListCaption.Height := PanelHeight;
    pnlButtons.Height := ButtonHeight;
    pnlButton.Height := ButtonHeight;
    pnlBottom.Height := ButtonHeight;
    pnlBottom1.Height := ButtonHeight;

    // get form icon
    frmMain.img16.GetIcon(18, (Sender as TForm).Icon);

  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmSchedulers.FormResize(Sender: TObject);
begin
  imgWidth.ImageIndex := 0;
  lblWidth.Caption := IntToStr(frmSchedulers.Width);
  imgHeight.ImageIndex := 1;
  lblHeight.Caption := IntToStr(frmSchedulers.Height);

  pnlListCaption.Repaint;
  pnlPaymentsCaption.Repaint;
  pnlButtons.Repaint;
  pnlButton.Repaint;
end;

procedure TfrmSchedulers.FormShow(Sender: TObject);
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
      frmSchedulers.Position := poDesigned;
      S := INI.ReadString('POSITION', frmSchedulers.Name, '-1•-1•0•0•380');

      // width
      TryStrToInt(Field(Separ, S, 3), I);
      if (I < 1) or (I > Screen.Width) then
        frmSchedulers.Width := Screen.Width - 200 - (200 - ScreenRatio)
      else
        frmSchedulers.Width := I;

      /// height
      TryStrToInt(Field(Separ, S, 4), I);
      if (I < 1) or (I > Screen.Height) then
        frmSchedulers.Height := Screen.Height - 300 - (200 - ScreenRatio)
      else
        frmSchedulers.Height := I;

      // left
      TryStrToInt(Field(Separ, S, 1), I);
      if (I < 0) or (I > Screen.Width) then
        frmSchedulers.left := (Screen.Width - frmSchedulers.Width) div 2
      else
        frmSchedulers.Left := I;

      // top
      TryStrToInt(Field(Separ, S, 2), I);
      if (I < 0) or (I > Screen.Height) then
        frmSchedulers.Top := ((Screen.Height - frmSchedulers.Height) div 2) - 75
      else
        frmSchedulers.Top := I;

      // right panel
      TryStrToInt(Field(Separ, S, 5), I);
      if (I < 1) or (I > 650) then
        frmSchedulers.pnlRight.Width := 220
      else
        frmSchedulers.pnlRight.Width := I;
    end;
  finally
    INI.Free
  end;
  // ********************************************************************
  // FORM SIZE END
  // ********************************************************************

  // btnAdd
  btnAdd.Enabled := frmMain.Conn.Connected = True;
  popAdd.Enabled := frmMain.Conn.Connected = True;
  actAdd.Enabled := frmMain.Conn.Connected = True;

  // btnAdd1
  btnAdd1.Enabled := VST.SelectedCount = 1;
  popDeleteDate.Enabled := VST1.SelectedCount > 0;
  popEditDate.Enabled := VST1.SelectedCount > 0;

  // btnEdit1
  btnEdit1.Enabled := False;

  // btnDelete
  btnDelete.Enabled := False;
  popDelete.Enabled := False;
  actDelete.Enabled := False;

  // btnDelete1
  btnDelete1.Enabled := VST1.SelectedCount > 0;

  UpdateScheduler;
  VST.SetFocus;
  VST.ClearSelection;

  if VST.SelectedCount = 1 then
  begin
    I := StrToInt(VST.Text[VST.GetFirstSelected(), 12]);
    UpdateScheduler;
    FindEditedRecord(VST, 12, I);
    VST.SetFocus;
  end
  else
    VST.SetFocus;
end;

procedure TfrmSchedulers.pnlButtonResize(Sender: TObject);
begin
  btnEdit1.Width := (VST1.Width - 8) div 3;
  btnDelete1.Width := btnEdit1.Width;
end;

procedure TfrmSchedulers.popDeleteDateClick(Sender: TObject);
var
  Str: string;
  N: PVirtualNode;
begin
  if MessageDlg(Application.Title, Question_18, mtConfirmation, [mbYes, mbNo], 0) <>
    mrYes then
    Exit;

  // ===========================================================
  // get ID of selected Scheduler
  // ===========================================================
  Str := '';
  N := VST1.GetFirstSelected(False);
  try
    while Assigned(N) do
    begin
      Str := Str + VST1.Text[N, 4] + ',';
      N := VST1.GetNextSelected(N);
    end;
  finally
    Str := LeftStr(Str, Length(Str) - 1);
  end;

  frmMain.QRY.SQL.Text :=
    'UPDATE payments SET pay_date_paid = NULL WHERE pay_id IN (' + Str + ');';
  frmMain.QRY.ExecSQL;
  frmMain.Tran.Commit;
  VSTChange(VST, VST.FocusedNode);
  VST1.SetFocus;
end;

procedure TfrmSchedulers.popEditDateClick(Sender: TObject);
var
  Str: string;
  N: PVirtualNode;
begin
  Calendar.Date := Now();
  if Calendar.Execute = False then
    Exit;

  // ===========================================================
  // get ID of selected Scheduler
  // ===========================================================
  Str := '';
  N := VST1.GetFirstSelected(False);
  try
    while Assigned(N) do
    begin
      Str := Str + VST1.Text[N, 4] + ',';
      N := VST1.GetNextSelected(N);
    end;
  finally
    Str := LeftStr(Str, Length(Str) - 1);
  end;

  frmMain.QRY.SQL.Text :=
    'UPDATE payments SET pay_date_paid = :DATE ' + 'WHERE pay_id IN (' + Str + ');';
  frmMain.QRY.Params.ParamByName('DATE').AsString :=
    FormatDateTime('YYYY-MM-DD', Calendar.Date);
  frmMain.QRY.Prepare;
  frmMain.QRY.ExecSQL;
  frmMain.Tran.Commit;
  VSTChange(VST, VST.FocusedNode);
  VST1.SetFocus;
end;

procedure TfrmSchedulers.splListCanResize(Sender: TObject; var NewSize: integer;
  var Accept: boolean);
begin
  imgWidth.ImageIndex := 3;
  lblWidth.Caption := IntToStr(frmSchedulers.Width - pnlRight.Width);

  imgHeight.ImageIndex := 2;
  lblHeight.Caption := IntToStr(pnlRight.Width);

  pnlListCaption.Repaint;
  pnlPaymentsCaption.Repaint;
  pnlButtons.Repaint;
  pnlButton.Repaint;
end;

procedure TfrmSchedulers.VST1Change(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  N: PVirtualNode;
  D: double;
  Payment: PPayment;
begin

  // set images
  if VST1.SelectedCount = 0 then
  begin
    imgItem1.ImageIndex := -1;
    lblItem1.Caption := '';
  end
  else
  begin
    if VST1.SelectedCount = VST1.TotalCount then
    begin
      imgItem1.ImageIndex := 7;
      lblItem1.Caption := '# ' + IntToStr(VST1.TotalCount);
    end
    else if VST1.SelectedCount = 1 then
    begin
      imgItem1.ImageIndex := 5;
      lblItem1.Caption := IntToStr(VST1.GetFirstSelected(False).Index + 1) + '.';
    end
    else
    begin
      imgItem1.ImageIndex := 6;
      lblItem1.Caption := '# ' + IntToStr(VST1.SelectedCount);
    end;
  end;

  popEdit1.Enabled := VST1.SelectedCount > 0;
  btnEdit1.Enabled := VST1.SelectedCount > 0;
  btnDelete1.Enabled := VST1.SelectedCount > 0;
  popDelete1.Enabled := VST1.SelectedCount > 0;
  popDeleteDate.Enabled := (VST1.SelectedCount > 0) and
    (Length(VST1.Text[VST1.GetFirstSelected(), 3]) > 0);
  popEditDate.Enabled := VST1.SelectedCount > 0;

  if VST1.SelectedCount = 0 then
  begin
    lblAmount.Caption := '';
    Exit;
  end;

  N := VST1.GetFirstSelected();
  D := 0.0;

  while Assigned(N) do
  begin
    Payment := Sender.GetNodeData(N);
    D := D + Payment.Amount;
    N := VST1.GetNextSelected(N);
  end;
  lblAmount.Caption := Format('%n', [D], FS_own);
end;

procedure TfrmSchedulers.VST1CompareNodes(Sender: TBaseVirtualTree;
  Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: integer);
var
  Data1, Data2: PPayment;
begin
  try
    Data1 := Sender.GetNodeData(Node1);
    Data2 := Sender.GetNodeData(Node2);
    case Column of
      0: Result := CompareValue(Data1.Kind, Data2.Kind);
      1:
        Result := CompareStr( // compare
          Data1.DatePlan + IntToStr(Data1.ID), // 1
          Data2.DatePlan + IntToStr(Data2.ID)); // 2
      2: Result := CompareValue(Data1.Amount, Data2.Amount);
      3: Result := CompareStr( // compare
          Data1.DatePaid, // 1
          Data2.DatePaid); // 2
      4: Result := CompareValue(Data1.ID, Data2.ID);
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;

end;

procedure TfrmSchedulers.VST1DblClick(Sender: TObject);
begin
  if (frmMain.Conn.Connected = False) or (VST.SelectedCount <> 1) then Exit;

  if VST1.SelectedCount = 0 then
    btnAdd1Click(btnAdd1)
  else
    btnEdit1Click(btnEdit1);
end;

procedure TfrmSchedulers.VST1GetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: boolean; var ImageIndex: integer);
var
  Payment: PPayment;
begin
  Payment := Sender.GetNodeData(Node);
  if Column = 0 then
    ImageIndex := Payment.Kind;
end;

procedure TfrmSchedulers.VST1GetNodeDataSize(Sender: TBaseVirtualTree;
  var NodeDataSize: integer);
begin
  NodeDataSize := SizeOf(TPayment);
end;

procedure TfrmSchedulers.VST1GetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  Payment: PPayment;
  M: byte;
begin
  Payment := Sender.GetNodeData(Node);
  case Column of
    // date (plan)
    1: begin
      M := DayOfTheWeek(StrToDate(Payment.DatePlan, 'YYYY-MM-DD', '-')) + 1;
      if M = 8 then
        M := 1;
      CellText := FS_own.ShortDayNames[M] + ' ' +
        DateToStr(StrToDate(Payment.DatePlan, 'YYYY-MM-DD', '-'));
    end;
    // amount
    2: CellText := Format('%n', [Payment.Amount], FS_own);
    // date (paid)
    3: if Length(Payment.DatePaid) = 10 then
      begin
        M := DayOfTheWeek(StrToDate(Payment.DatePaid, 'YYYY-MM-DD', '-')) + 1;
        if M = 8 then
          M := 1;
        CellText := FS_own.ShortDayNames[M] + ' ' +
          DateToStr(StrToDate(Payment.DatePaid, 'YYYY-MM-DD', '-'));
      end;
    // ID
    4: CellText := IntToStr(Payment.ID);
  end;
end;

procedure TfrmSchedulers.VST1Resize(Sender: TObject);
var
  X: integer;
begin
  try
    if frmSettings.chkAutoColumnWidth.Checked = False then Exit;

    (Sender as TLazVirtualStringTree).Header.Columns[0].Width :=
      Round(ScreenRatio * 25 / 100);
    X := (VST1.Width - VST1.Header.Columns[0].Width) div 100;
    VST1.Header.Columns[1].Width := 35 * X; // date plan
    VST1.Header.Columns[2].Width := 26 * X; // amount
    VST1.Header.Columns[3].Width := 35 * X; // payment date
    VST1.Header.Columns[4].Width :=
      VST1.Width - VST1.Header.Columns[0].Width - ScrollBarWidth - (96 * X); // ID
  except
  end;
end;

procedure TfrmSchedulers.VSTBeforeCellPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
begin
  TargetCanvas.Brush.Color := IfThen(Node.Index mod 2 = 0, clWhite,
    frmSettings.pnlOddRowColor.Color);
  TargetCanvas.FillRect(CellRect);
end;

procedure TfrmSchedulers.VSTChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  Payment: PPayment;
  P: PVirtualNode;
begin
  frmSchedulers.VST1.Clear;
  frmSchedulers.VST1.rootnodecount := 0;

  btnAdd1.Enabled := VST.SelectedCount = 1;
  popAdd1.Enabled := VST.SelectedCount = 1;

  actDelete.Enabled := VST.SelectedCount > 0;
  btnDelete.Enabled := VST.SelectedCount > 0;
  popDelete.Enabled := VST.SelectedCount > 0;

  actEdit.Enabled := False;
  btnEdit1.Enabled := False;
  popEdit1.Enabled := False;

  try
    // set images
    if VST.SelectedCount = 0 then
    begin
      imgItem.ImageIndex := -1;
      lblItem.Caption := '';
      lblItemS1.Caption := '';
    end
    else
    begin
      if (VST.SelectedCount = VST.TotalCount) and (VST.SelectedCount > 1) then
      begin
        imgItem.ImageIndex := 7;
        lblItem.Caption := '# ' + IntToStr(VST.SelectedCount);
        lblItemS1.Caption := IntToStr(VST1.SelectedCount);
      end
      else if VST.SelectedCount = 1 then
      begin
        // ===============================================================================================
        // UPDATE PAYMENTS
        // ===============================================================================================
        screen.Cursor := crHourGlass;
        frmSchedulers.VST1.BeginUpdate;

        frmMain.QRY.SQL.Text :=
          'SELECT pay_date_plan, pay_date_paid, round(pay_sum, 2), pay_type, pay_id ' +
          'FROM payments ' + sLineBreak + // FROM tables
          'WHERE pay_sch_id = ' + VST.Text[VST.GetFirstSelected, 12] +
          ' ORDER BY pay_date_plan ASC;';
        frmMain.QRY.Open;

        while not frmMain.QRY.EOF do
        begin
          frmSchedulers.VST1.RootNodeCount := frmSchedulers.VST1.RootNodeCount + 1;
          P := frmSchedulers.VST1.GetLast();
          Payment := frmSchedulers.VST1.GetNodeData(P);
          Payment.DatePlan := frmMain.QRY.Fields[0].AsString;
          Payment.DatePaid := frmMain.QRY.Fields[1].AsString;
          TryStrToFloat(frmMain.QRY.Fields[2].AsString, Payment.Amount);
          Payment.Kind := frmMain.QRY.Fields[3].AsInteger;
          Payment.ID := frmMain.QRY.Fields[4].AsInteger;
          frmMain.QRY.Next;
        end;
        frmMain.QRY.Close;

        // frmSchedulers.VST1.SortTree(1, sdAscending);
        SetNodeHeight(VST1);
        frmSchedulers.VST1.EndUpdate;
        screen.Cursor := crDefault;
        imgItem.ImageIndex := 5;
        lblItem.Caption := IntToStr(VST.GetFirstSelected(False).Index + 1) + '.';
        lblItemS1.Caption := IntToStr(VST1.TotalCount);
      end
      else
      begin
        imgItem.ImageIndex := 6;
        lblItem.Caption := '# ' + IntToStr(VST.SelectedCount);
        lblItems1.Caption := '';
      end;
    end;

  except
  end;
end;

procedure TfrmSchedulers.VSTCompareNodes(Sender: TBaseVirtualTree; Node1,
  Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
var
  Data1, Data2: PScheduler;
begin
  Data1 := Sender.GetNodeData(Node1);
  Data2 := Sender.GetNodeData(Node2);
  case Column of
    1: Result := UTF8CompareText(Data1.DateFrom, Data2.DateFrom);
    2: Result := UTF8CompareText(Data1.DateTo, Data2.DateTo);
    3: Result := CompareValue(Data1.Periodicity, Data2.Periodicity);
    4: Result := CompareValue(Data1.Amount, Data2.Amount);
    5: Result := UTF8CompareText(Data1.currency, Data2.currency);
    6: Result := UTF8CompareText(Data1.Comment, Data2.Comment);
    7: Result := UTF8CompareText(Data1.Account, Data2.Account);
    8: Result := UTF8CompareText(Data1.Category, Data2.Category);
    9: Result := UTF8CompareText(Data1.SubCategory, Data2.SubCategory);
    10: Result := UTF8CompareText(Data1.Person, Data2.Person);
    11: Result := UTF8CompareText(Data1.Payee, Data2.Payee);
    12: Result := CompareValue(Data1.ID, Data2.Id)
  end;
end;

procedure TfrmSchedulers.VSTDblClick(Sender: TObject);
begin
  if frmMain.Conn.Connected = False then Exit;

  if VST.SelectedCount = 0 then
    btnAddClick(btnAdd);
end;

procedure TfrmSchedulers.VSTGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: boolean; var ImageIndex: integer);
var
  Scheduler: PScheduler;
begin
  if Column = 0 then
  begin
    Scheduler := Sender.GetNodeData(Node);
    if Scheduler.Kind < 2 then
      ImageIndex := Scheduler.Kind
    else
      ImageIndex := 4;
  end;
end;

procedure TfrmSchedulers.VSTGetNodeDataSize(Sender: TBaseVirtualTree;
  var NodeDataSize: integer);
begin
  NodeDataSize := SizeOf(TScheduler);
end;

procedure TfrmSchedulers.VSTGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  Scheduler: PScheduler;
begin
  Scheduler := Sender.GetNodeData(Node);

  case Column of
    1: CellText := DateToStr(StrToDate(Scheduler.DateFrom, 'YYYY-MM-DD', '-'), FS_own);
    2: CellText := DateToStr(StrToDate(Scheduler.DateTo, 'YYYY-MM-DD', '-'), FS_own);
    3: if Scheduler.Periodicity < 0 then
        CellText := AnsiReplaceStr(frmScheduler.cbxPeriodicity.Items[1],
          'X', IntToStr(ABS(Scheduler.Periodicity)))
      else
        CellText := frmScheduler.cbxPeriodicity.Items[Scheduler.Periodicity];
    4: CellText := Format('%n', [Scheduler.Amount], FS_own);
    5: CellText := Scheduler.currency;
    6: CellText := Scheduler.Comment;
    7: CellText := Scheduler.Account;
    8: CellText := AnsiUpperCase(Scheduler.Category);
    9: CellText := IfThen(frmSettings.chkDisplaySubCatCapital.Checked =
        True, AnsiUpperCase(Scheduler.SubCategory), Scheduler.SubCategory);
    10: CellText := Scheduler.Person;
    11: CellText := Scheduler.Payee;
    12: CellText := IntToStr(Scheduler.ID);
  end;
end;

procedure TfrmSchedulers.VSTPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
var
  Scheduler: PScheduler;
begin
  TargetCanvas.Font.Bold := (Column = 4) and
    (frmSettings.chkDisplayFontBold.Checked = True);
  if vsSelected in node.States then exit;

  Scheduler := Sender.GetNodeData(Node);
  case Scheduler.Kind of

    // credit color
    0: case frmSettings.pnlCreditTransactionsColor.Tag of
        0: TargetCanvas.Font.Color := clDefault;
        1: begin
          if Column = 4 then
            TargetCanvas.Font.Color := clBlue
          else
            TargetCanvas.Font.Color := clDefault;
        end
        else
          TargetCanvas.Font.Color := clBlue;
      end;

    // debit color                                                                                                                   ´
    1: case frmSettings.pnlDebitTransactionsColor.Tag of
        0: TargetCanvas.Font.Color := clDefault;
        1: begin
          if Column = 4 then
            TargetCanvas.Font.Color := clRed
          else
            TargetCanvas.Font.Color := clDefault;
        end
        else
          TargetCanvas.Font.Color := clRed;
      end;

    // transfer plus color
    2: case frmSettings.pnlTransferPTransactionsColor.Tag of
        0: TargetCanvas.Font.Color := clDefault;
        1: begin
          if Column = 4 then
            TargetCanvas.Font.Color := clGreen
          else
            TargetCanvas.Font.Color := clDefault;
        end
        else
          TargetCanvas.Font.Color := clGreen;
      end;

      // transfer minus color
    else
      case frmSettings.pnlTransferMTransactionsColor.Tag of
        0: TargetCanvas.Font.Color := clDefault;
        1: begin
          if Column = 4 then
            TargetCanvas.Font.Color := rgbToColor(240, 160, 0)
          else
            TargetCanvas.Font.Color := clDefault;
        end
        else
          TargetCanvas.Font.Color := rgbToColor(240, 160, 0);
      end;
  end;
end;

procedure TfrmSchedulers.VSTResize(Sender: TObject);
var
  X: integer;
begin
  try
    // set transactions columns width
    if frmSettings.chkAutoColumnWidth.Checked = False then Exit;

    (Sender as TLazVirtualStringTree).Header.Columns[0].Width :=
      round(ScreenRatio * 25 / 100);
    X := (VST.Width - VST.Header.Columns[0].Width) div 100;

    VST.Header.Columns[1].Width := 7 * X; // date from
    VST.Header.Columns[2].Width := 7 * X; // date to
    VST.Header.Columns[3].Width := 8 * X; // periodicity
    VST.Header.Columns[4].Width := 8 * X; // amount
    VST.Header.Columns[5].Width := 5 * X; // currency
    VST.Header.Columns[6].Width :=
      VST.Width - VST.Header.Columns[0].Width - ScrollBarWidth - (82 * X); // comment
    VST.Header.Columns[7].Width := 10 * X; // account
    VST.Header.Columns[8].Width := 9 * X; // category
    VST.Header.Columns[9].Width := 9 * X; // subcategory
    VST.Header.Columns[10].Width := 8 * X; // person
    VST.Header.Columns[11].Width := 8 * X; // payee
    VST.Header.Columns[12].Width := 3 * X; // ID
  except
  end;
end;

procedure UpdateScheduler;
var
  Scheduler: PScheduler;
  P: PVirtualNode;
begin

  // ===============================================================================================
  // UPDATE SCHEDULER
  // ===============================================================================================

  frmSchedulers.VST.Clear;
  frmSchedulers.VST.rootnodecount := 0;

  if frmMain.Conn.Connected = False then
    exit;

  screen.Cursor := crHourGlass;
  frmSchedulers.VST.BeginUpdate;

  frmMain.QRY.SQL.Text :=
    'SELECT sch_date_from, sch_date_to, sch_period, ' +
    'round(sch_sum1 + sch_sum2, 2), sch_comment, acc_currency,' +
    sLineBreak + 'acc_name,' + sLineBreak + // account name 6
    'cat_parent_name,' + sLineBreak + // category name 7
    'cat_name,' + sLineBreak + // subcategory name 8
    'per_name,' + sLineBreak + // Scheduler 9
    'pee_name, ' + sLineBreak + // payee 10
    'sch_id,' + sLineBreak + // ID 11
    'sch_type, ' + sLineBreak +// type (credit, debit, transfer +, transfer -) 12
    'cat_parent_ID ' + // category parent ID 13
    'FROM scheduler ' + sLineBreak +// FROM tables
    'JOIN ' + sLineBreak +// JOIN
    'accounts ON (acc_id = sch_account1), ' + sLineBreak +// accounts
    'categories ON (cat_id = sch_category), ' + sLineBreak +// categories
    'persons ON (per_id = sch_person), ' + sLineBreak +// persons
    'payees ON (pee_id = sch_payee) ' + // payees
    'ORDER BY sch_date_from DESC, sch_date_to DESC;';
  frmMain.QRY.Open;

  while not frmMain.QRY.EOF do
  begin
    frmSchedulers.VST.RootNodeCount := frmSchedulers.VST.RootNodeCount + 1;
    P := frmSchedulers.VST.GetLast();
    Scheduler := frmSchedulers.VST.GetNodeData(P);
    Scheduler.DateFrom := frmMain.QRY.Fields[0].AsString;
    Scheduler.DateTo := frmMain.QRY.Fields[1].AsString;
    Scheduler.Periodicity := frmMain.QRY.Fields[2].AsInteger;
    TryStrToFloat(frmMain.QRY.Fields[3].AsString, Scheduler.Amount);
    // ShowMessage('From: ' + frmMain.QRY.Fields[3].AsString + sLineBreak + 'To: ' + FLoatToStr(Scheduler.Amount));
    Scheduler.Comment := frmMain.QRY.Fields[4].AsString;
    Scheduler.currency := frmMain.QRY.Fields[5].AsString;
    Scheduler.Account := frmMain.QRY.Fields[6].AsString;
    Scheduler.Category := AnsiUpperCase(frmMain.QRY.Fields[7].AsString);
    Scheduler.SubCategory := IfThen(frmMain.QRY.Fields[13].AsInteger =
      0, '', frmMain.QRY.Fields[8].AsString);
    Scheduler.Person := frmMain.QRY.Fields[9].AsString;
    Scheduler.Payee := frmMain.QRY.Fields[10].AsString;
    Scheduler.ID := frmMain.QRY.Fields[11].AsInteger;
    Scheduler.Kind := frmMain.QRY.Fields[12].AsInteger;

    frmMain.QRY.Next;
  end;
  frmMain.QRY.Close;

  SetNodeHeight(frmSchedulers.VST);
  frmSchedulers.VST.SortTree(1, sdAscending);
  frmSchedulers.VST.EndUpdate;
  screen.Cursor := crDefault;

  // items icon
  frmSchedulers.lblItems.Caption := IntToStr(frmSchedulers.VST.RootNodeCount);

  frmSchedulers.actDelete.Enabled := False;
  frmSchedulers.popDelete.Enabled := False;
  frmSchedulers.btnDelete.Enabled := False;

  frmSchedulers.popAdd1.Enabled := False;
  frmSchedulers.btnAdd1.Enabled := False;

  frmSchedulers.btnEdit1.Enabled := False;
  frmSchedulers.popEdit1.Enabled := False;
  frmSchedulers.actEdit.Enabled := False;

  frmSchedulers.btnDelete.Enabled := False;
  frmSchedulers.popDelete1.Enabled := False;

end;

end.
