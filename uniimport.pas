unit uniImport;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons, ComCtrls, ActnList, sqldb, sqlite3conn, BCMDButtonFocus, BCPanel, StrUtils;

type

  { TfrmImport }

  TfrmImport = class(TForm)
    actExit: TAction;
    ActionList1: TActionList;
    btnExit: TBCMDButtonFocus;
    btnFile: TBitBtn;
    btnImport: TBCMDButtonFocus;
    imgHeight: TImage;
    imgWidth: TImage;
    odImport: TOpenDialog;
    lblProgress: TLabel;
    lblFileName: TLabel;
    lblFileName1: TLabel;
    lblHeight: TLabel;
    lblWidth: TLabel;
    pnlBottom: TPanel;
    pnlFile: TPanel;
    pnlFileName: TPanel;
    pnlHeight: TPanel;
    pnlImportCaption: TBCPanel;
    pnlButtons: TPanel;
    pnlWidth: TPanel;
    tabImport: TTabControl;
    procedure actExitExecute(Sender: TObject);
    procedure btnFileClick(Sender: TObject);
    procedure btnImport1Click(Sender: TObject);
    procedure btnImportClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tabImportChange(Sender: TObject);
  private

  public

  end;

var
  frmImport: TfrmImport;

procedure ImportRQM;

implementation

{$R *.lfm}

uses
  uniMain, uniResources, uniTemplates, uniCurrencies, uniAccounts,
  uniCategories, uniComments, uniPersons, uniPayees, uniHolidays;

  { TfrmImport }

procedure TfrmImport.btnImportClick(Sender: TObject);
begin
  if FileExists(lblFileName.Caption) = False then
    Exit;

  case tabImport.TabIndex of
    0: ImportRQM
    else
      frmTemplates.ShowModal;
  end;
end;

procedure ImportRQM;
var
  SS: TStringStream;
  S: TSQLite3Connection;
  T: TSQLTransaction;
  Q1, Q2: TSQLQuery;
  ID, IDC, IDD: integer;
  Temp, AmountX: string;
begin
  // check the encryption of the file
  SS := TStringStream.Create(''); //used as your source string
  SS.LoadFromFile(frmImport.lblFileName.Caption);
  if LeftStr(SS.DataString, 6) <> 'SQLite' then
  begin
    SS.Free;
    ShowMessage(AnsiReplaceStr(Error_20, '%', sLineBreak));
    Exit;
  end;
  AmountX := '';

  // =====================================================

  // open db
  if FileExists(frmImport.lblFileName.Caption) then
  try
    begin
      // create components
      S := TSQLite3Connection.Create(nil);
      T := TSQLTransaction.Create(nil);
      Q1 := TSQLQuery.Create(nil);
      Q2 := TSQLQuery.Create(nil);

      // setup components
      S.Transaction := T;
      T.Database := S;
      Q1.Transaction := T;
      Q1.Database := S;
      Q2.Transaction := T;
      Q2.Database := S;


      // setup db
      S.DatabaseName := frmImport.lblFileName.Caption;
      S.HostName := 'localhost';
      S.Open;

      if S.Connected = False then
      begin
        ShowMessage(AnsiReplaceStr(Error_02, '%', sLineBreak));
        Exit;
      end;

      Screen.Cursor := crHourGlass;
      AllowUpdateTransactions := False;

      frmImport.btnImport.Enabled := False;
      frmImport.btnImport.Repaint;

      // ============================================================================================
      // CURRENCIES ------------------------------------------------------------------------
      Q1.SQL.Text := 'SELECT u_code, u_name from currencies;';
      Q1.Open;

      while not (Q1.EOF) do
      begin
        frmMain.QRY.SQL.Text :=
          'INSERT OR IGNORE INTO currencies (cur_code, cur_name, cur_default, cur_rate, cur_status) '
          + 'VALUES (:CODE,:NAME,0,1.00,0);';
        frmMain.QRY.Params.ParamByName('CODE').AsString := Q1.Fields[0].AsString;
        frmMain.QRY.Params.ParamByName('NAME').AsString := Q1.Fields[1].AsString;
        frmMain.QRY.Prepare;
        frmMain.QRY.ExecSQL;
        Q1.Next;
      end;
      Q1.Close;

      // ============================================================================================
      // ACCOUNTS ------------------------------------------------------------------------
      Q1.SQL.Text :=
        'SELECT a_name, a_currency, ' + // select
        'CASE Length(a_founded) WHEN 10 THEN a_founded ELSE date() END, ' +
        'CASE WHEN a_startsum < 100000000 THEN Round(a_startsum, 2) ELSE 0.00 END, ' +
        'CASE WHEN a_archive > 0 THEN a_archive ELSE 0 END, a_note, a_id FROM accounts;';
      Q1.Open;
      while not (Q1.EOF) do
      begin
        frmMain.QRY.SQL.Text :=
          'INSERT OR IGNORE INTO accounts (acc_name, acc_name_lower, acc_currency, ' +
          'acc_date, acc_amount, acc_status, acc_comment) VALUES (' +
          ':ACC0, :ACC1, :ACC2, :ACC3, :ACC4, :ACC5, :ACC6);';
        frmMain.QRY.Params.ParamByName('ACC0').AsString := Q1.Fields[0].AsString;
        frmMain.QRY.Params.ParamByName('ACC1').AsString :=
          AnsiLowerCase(Q1.Fields[0].AsString);
        frmMain.QRY.Params.ParamByName('ACC2').AsString := Q1.Fields[1].AsString;
        frmMain.QRY.Params.ParamByName('ACC3').AsString := Q1.Fields[2].AsString;
        frmMain.QRY.Params.ParamByName('ACC4').AsString :=
          AnsiReplaceStr(Q1.Fields[3].AsString, ',', '.');
        frmMain.QRY.Params.ParamByName('ACC5').AsInteger := Q1.Fields[4].AsInteger;
        frmMain.QRY.Params.ParamByName('ACC6').AsString := Q1.Fields[5].AsString;
        frmMain.QRY.Prepare;
        frmMain.QRY.ExecSQL;
        Q1.Next;
      end;
      Q1.Close;

      // ============================================================================================
      // CATEGORIES ------------------------------------------------------------------------
      Q1.SQL.Text := 'SELECT DISTINCT c_category FROM categories;';
      Q1.Open;
      while not (Q1.EOF) do
      begin
        frmMain.QRY.SQL.Text :=
          'INSERT OR IGNORE INTO categories (' +
          'cat_name, cat_parent_ID, cat_parent_name, cat_status, cat_comment, cat_energy) ' +
          'VALUES (:CATEGORY1, 0, :CATEGORY2, 0, NULL, 1);';
        frmMain.QRY.Params.ParamByName('CATEGORY1').AsString :=
          AnsiUpperCase(Trim(Q1.Fields[0].AsString));
        frmMain.QRY.Params.ParamByName('CATEGORY2').AsString :=
          AnsiUpperCase(Trim(Q1.Fields[0].AsString));
        frmMain.QRY.Prepare;
        frmMain.QRY.ExecSQL;
        Q1.Next;
      end;
      Q1.Close;

      Q1.SQL.Text :=
        'SELECT DISTINCT TRIM(c_category), TRIM(c_subcategory) FROM categories WHERE c_category <> "TRANSFER" ORDER BY c_category DESC;';
      Q1.Open;
      while not (Q1.EOF) do
      begin
        frmMain.QRY.SQL.Text :=
          'INSERT OR IGNORE INTO categories (' +
          'cat_name, cat_parent_ID, cat_parent_name, cat_status, cat_comment, cat_energy) ' +
          // select
          'VALUES (:SUBCATEGORY, ' +  // category
          '(SELECT cat_id FROM categories WHERE cat_name = :CATEGORY and cat_parent_ID = 0), '
          + // parent ID
          ':CATEGORY, 0, NULL, 1);';

        frmMain.QRY.Params.ParamByName('CATEGORY').AsString :=
          AnsiUpperCase(Q1.Fields[0].AsString);
        frmMain.QRY.Params.ParamByName('SUBCATEGORY').AsString :=
          AnsiLowerCase(Q1.Fields[1].AsString);
        frmMain.QRY.Prepare;
        frmMain.QRY.ExecSQL;
        Q1.Next;
      end;
      Q1.Close;

      // ============================================================================================
      // PERSONS ------------------------------------------------------------------------
      Q1.SQL.Text :=
        'SELECT p_name FROM persons;';
      Q1.Open;

      while not (Q1.EOF) do
      begin
        frmMain.QRY.SQL.Text :=
          'INSERT OR IGNORE INTO persons (per_name, per_name_lower, per_status, ' +
          'per_comment) VALUES (:PERSON1, :PERSON2, 0, NULL);';
        frmMain.QRY.Params.ParamByName('PERSON1').AsString := Q1.Fields[0].AsString;
        frmMain.QRY.Params.ParamByName('PERSON2').AsString :=
          AnsiLowerCase(Q1.Fields[0].AsString);
        frmMain.QRY.Prepare;
        frmMain.QRY.ExecSQL;
        Q1.Next;
      end;
      Q1.Close;

      // ============================================================================================
      // PAYEES ------------------------------------------------------------------------
      Q1.SQL.Text := 'SELECT e_name, e_note FROM payees;';
      Q1.Open;
      while not (Q1.EOF) do
      begin
        frmMain.QRY.SQL.Text :=
          'INSERT OR IGNORE INTO payees (pee_name, pee_name_lower, pee_status, pee_comment) '
          + 'VALUES (:PAYEE1, :PAYEE2, 0, :NOTE);';
        frmMain.QRY.Params.ParamByName('PAYEE1').AsString :=
          Ifthen(Length(Q1.Fields[0].AsString) = 0, '', Q1.Fields[0].AsString);
        frmMain.QRY.Params.ParamByName('PAYEE2').AsString :=
          AnsiLowerCase(Q1.Fields[0].AsString);
        frmMain.QRY.Params.ParamByName('NOTE').AsString := Q1.Fields[1].AsString;
        frmMain.QRY.Prepare;
        frmMain.QRY.ExecSQL;
        Q1.Next;
      end;
      Q1.Close;

      // ============================================================================================
      // COMMENTS ------------------------------------------------------------------------
      Q1.SQL.Text := 'SELECT d_name FROM descriptions;';
      Q1.Open;
      while not (Q1.EOF) do
      begin
        frmMain.QRY.SQL.Text :=
          'INSERT OR IGNORE INTO comments (com_text, com_time) ' +
          'VALUES (:COMMENT, DateTime("Now", "localtime"));';
        frmMain.QRY.Params.ParamByName('COMMENT').AsString := Q1.Fields[0].AsString;
        frmMain.QRY.Prepare;
        frmMain.QRY.ExecSQL;
        Q1.Next;
      end;
      Q1.Close;


      // ============================================================================================
      // HOLIDAYS ------------------------------------------------------------------------
      Q1.SQL.Text := 'SELECT h_date, h_description FROM holidays;';
      Q1.Open;
      while not (Q1.EOF) do
      begin
        frmMain.QRY.SQL.Text :=
          'INSERT OR IGNORE INTO holidays (hol_day, hol_month, hol_name, hol_time)' +
          'VALUES (:DAY, :MONTH, :COMMENT, DateTime("Now", "localtime"));';
        frmMain.QRY.Params.ParamByName('DAY').AsInteger :=
          StrToInt(RightStr(Q1.Fields[0].AsString, 2));
        frmMain.QRY.Params.ParamByName('MONTH').AsInteger :=
          StrToInt(LeftStr(Q1.Fields[0].AsString, 2));
        frmMain.QRY.Params.ParamByName('COMMENT').AsString := Q1.Fields[1].AsString;
        frmMain.QRY.Prepare;
        frmMain.QRY.ExecSQL;
        Q1.Next;
      end;
      Q1.Close;

      // ============================================================================================
      // Transactions -------------------------------------------------------------------------------

      // Check malformed records first
      Q1.SQL.Text :=
        'SELECT COUNT(d_date) FROM data ' + // 0
        'WHERE d_account IS NULL or d_category IS NULL or ' +
        'd_person IS NULL or d_payee IS NULL;';
      Q1.Open;
      if Q1.Fields[0].AsInteger = 1 then
        ShowMessage(Error_25 + sLineBreak + Error_27)
      else if Q1.Fields[0].AsInteger > 1 then
        ShowMessage(AnsiReplaceStr(Error_26, '%', Q1.Fields[0].AsString) +
          sLineBreak + Error_27);
      Q1.Close;

      // Get correct records now
      Q1.SQL.Text :=
        'SELECT d_date, ' + // 0
        'd_description, ' + // 1
        'CASE (SELECT c_kind FROM categories WHERE d_category = c_id) ' +
        'WHEN "-" THEN ROUND(-d_sum, 2) WHEN "m" THEN ROUND(-d_sum,2) ELSE ROUND(d_sum,2) END, '
        + // 2
        '(SELECT a_name FROM accounts WHERE a_id = d_account), ' + // 3
        '(SELECT a_currency FROM accounts WHERE a_id = d_account), ' + // 4
        '(SELECT c_category FROM categories WHERE c_id = d_category), ' + // 5
        '(SELECT c_subcategory FROM categories WHERE c_id = d_category), ' + // 6
        '(SELECT p_name FROM persons WHERE p_id = d_person), ' + // 7
        '(SELECT e_name FROM payees WHERE e_id = d_payee), ' + // 8
        'CASE (SELECT c_kind FROM categories WHERE d_category = c_id) ' +
        'WHEN "+" THEN 0 WHEN "-" THEN 1 WHEN "p" THEN 2 ELSE 3 END,' + // 9
        'd_time, ' + // time 10
        'd_id ' + // ID 11
        'FROM data ' + // from
        'WHERE NOT(d_account IS NULL or d_category IS NULL or ' +
        'd_person IS NULL or d_payee IS NULL) ' + 'ORDER BY d_id;';

      Q1.Open;
      Q1.Last;
      frmImport.lblProgress.Tag := Q1.RecordCount;
      Q1.First;

      ID := 0;
      IDC := 0;
      IDD := 0;
      //frmImport.prg.Visible := True;

      while not (Q1.EOF) do
      begin
        // insert data

         {ShowMessage(
         'date: ' + Q1.Fields[0].AsString + sLineBreak +
         'comment: ' + Q1.Fields[1].AsString + sLineBreak +
         'amount: ' + Q1.Fields[2].AsString + sLineBreak +
         'account: ' + Q1.Fields[3].AsString + sLineBreak +
         'currency: ' + Q1.Fields[4].AsString + sLineBreak +
         'category: ' + Q1.Fields[5].AsString + sLineBreak +
         'subcategory: ' + Q1.Fields[6].AsString + sLineBreak +
         'person: ' + Q1.Fields[7].AsString + sLineBreak +
         'payee: ' + Q1.Fields[8].AsString + sLineBreak +
         'kind: ' + Q1.Fields[9].AsString + sLineBreak +
         'time: ' + Q1.Fields[10].AsString + sLineBreak +
         'ID: ' + Q1.Fields[11].AsString);}

        frmMain.QRY.SQL.Text :=
          'INSERT OR IGNORE INTO data (d_date, d_comment, d_comment_lower, d_sum, ' +
          'd_account, d_category, d_person, d_payee, d_type, d_time, d_order) VALUES (' +
          ':DATE, :COMMENT1, :COMMENT2, :AMOUNT, ' +
          '(SELECT acc_id FROM accounts WHERE acc_name = :ACCOUNT and acc_currency = :CURRENCY), '
          + 'CASE :CATEGORY WHEN "TRANSFER" THEN (SELECT cat_id FROM categories WHERE ' +
          'cat_parent_name = "TRANSFER" and cat_parent_id = 0) ELSE ' +
          '(SELECT cat_id FROM categories WHERE cat_parent_name = TRIM(:CATEGORY) and ' +
          'cat_name = TRIM(:SUBCATEGORY) and cat_parent_id > 0) END, ' +
          '(SELECT per_id FROM persons WHERE per_name = :PERSON), ' +
          '(SELECT pee_id FROM payees WHERE pee_name = :PAYEE), ' + ':KIND, :TIME, 0);';

        frmMain.QRY.Params.ParamByName('DATE').AsString := Q1.Fields[0].AsString;

        if (Length(Q1.Fields[1].AsString) = 0) then
          frmMain.QRY.Params.ParamByName('COMMENT1').Value := NULL
        else
          frmMain.QRY.Params.ParamByName('COMMENT1').AsString := Q1.Fields[1].AsString;

        if (Length(Q1.Fields[1].AsString) = 0) then
          frmMain.QRY.Params.ParamByName('COMMENT2').Value := NULL
        else
          frmMain.QRY.Params.ParamByName('COMMENT2').AsString :=
            AnsiLowerCase(Q1.Fields[1].AsString);

        frmMain.QRY.Params.ParamByName('AMOUNT').AsString :=
          ReplaceStr(Q1.Fields[2].AsString, ',', '.');
        frmMain.QRY.Params.ParamByName('ACCOUNT').AsString := Q1.Fields[3].AsString;
        frmMain.QRY.Params.ParamByName('CURRENCY').AsString := Q1.Fields[4].AsString;
        frmMain.QRY.Params.ParamByName('CATEGORY').AsString :=
          AnsiUpperCase(Q1.Fields[5].AsString);
        frmMain.QRY.Params.ParamByName('SUBCATEGORY').AsString :=
          AnsiLowerCase(Q1.Fields[6].AsString);
        frmMain.QRY.Params.ParamByName('PERSON').AsString := Q1.Fields[7].AsString;
        frmMain.QRY.Params.ParamByName('PAYEE').AsString := Q1.Fields[8].AsString;
        frmMain.QRY.Params.ParamByName('KIND').AsString := Q1.Fields[9].AsString;
        frmMain.QRY.Params.ParamByName('TIME').AsString := Q1.Fields[10].AsString;
        frmMain.QRY.Prepare;
        frmMain.QRY.ExecSQL;

        // --------------------------------------------
        // update transfers pair (in case of transfers)
        // --------------------------------------------

        if (Q1.Fields[9].AsString = '2') then
        begin
          if ((ID + 1 = Q1.Fields[11].AsInteger) or
            (ID - 1 = Q1.Fields[11].AsInteger)) and
            (StrToFloat(AmountX) = -StrToFloat(Q1.Fields[2].AsString)) then
          begin
            frmMain.QRY.SQL.Text :=
              'INSERT OR IGNORE INTO TRANSFERS (tra_data1, tra_data2) ' +
              'VALUES (:D1, :D2);';
            frmMain.QRY.Params.ParamByName('D1').AsInteger := IDD;
            frmMain.QRY.Params.ParamByName('D2').AsInteger := frmMain.Conn.GetInsertID;
            frmMain.QRY.Prepare;
            frmMain.QRY.ExecSQL;
            ID := 0;
          end
          else
          begin
            AmountX := Q1.Fields[2].AsString;
            IDC := frmMain.Conn.GetInsertID;
            ID := Q1.Fields[11].AsInteger;
          end;
        end;

        if (Q1.Fields[9].AsString = '3') then
        begin
          if (amountX <> '') and ((ID + 1 = Q1.Fields[11].AsInteger) or
            (ID - 1 = Q1.Fields[11].AsInteger)) and
            (StrToFloat(AmountX) = -StrToFloat(Q1.Fields[2].AsString)) then
          begin
            frmMain.QRY.SQL.Text :=
              'INSERT OR IGNORE INTO TRANSFERS (tra_data1, tra_data2) ' +
              'VALUES (:D1, :D2);';
            frmMain.QRY.Params.ParamByName('D1').AsInteger := IDC;
            frmMain.QRY.Params.ParamByName('D2').AsInteger := frmMain.Conn.GetInsertID;
            frmMain.QRY.Prepare;
            frmMain.QRY.ExecSQL;
            AmountX := '';
            ID := 0;
          end
          else
          begin
            AmountX := Q1.Fields[2].AsString;
            IDD := frmMain.Conn.GetInsertID;
            ID := Q1.Fields[11].AsInteger;
          end;
        end;
        if Q1.RecNo mod 100 = 0 then
        begin
          frmImport.lblProgress.Caption :=
            IntToStr(Q1.RecNo) + ' / ' + IntToStr(frmImport.lblProgress.Tag);
          frmImport.lblProgress.Repaint;
        end;
        Q1.Next;
      end;
      Q1.Close;
      frmImport.lblProgress.Caption := '';

      // =====================================================
      // rename empty string of partner
      frmMain.QRY.SQL.Text :=
        'UPDATE OR IGNORE payees SET pee_name = " ", pee_name_lower = " " ' +
        'WHERE pee_name = "";';
      frmMain.QRY.ExecSQL;

      UpdateCurrencies;
      UpdateAccounts;
      UpdateCategories;
      UpdatePersons;
      UpdatePayees;
      UpdateComments;
      UpdateHolidays;

      // =====================================================
      // Scheduler
      // =====================================================
      // CREATE TABLE fixed (f_date_from TEXT, f_date_to TEXT, f_period TEXT, f_type TEXT, f_sum NUMBER,
      // f_description TEXT COLLATE NOCASE, f_account NUMBER, f_category NUMBER, f_person NUMBER,
      // f_payee NUMBER, f_id INTEGER PRIMARY KEY)|

      Q1.SQL.Text :=
        'SELECT f_date_from, ' + // date 0
        'f_date_to, ' + // date 1
        'CASE f_period WHEN "O" THEN 0 WHEN "D" THEN 2 WHEN "W" THEN 3 WHEN "F" THEN 4 WHEN "M" THEN 5 '
        + 'WHEN "Q" THEN 6 WHEN "B" THEN 7 WHEN "Y" THEN 8 END, ' + // period 2
        'CASE f_type WHEN "+" THEN 0 WHEN "-" THEN 1 ELSE 2 END, ' + // type 3
        'CASE f_type WHEN "-" THEN -f_sum ELSE f_sum END, ' + // sum 4
        'f_description, ' + // description 5
        '(SELECT a_name FROM accounts WHERE a_id = f_account),  ' + // account 6
        '(SELECT a_currency FROM accounts WHERE a_id = f_account), ' + // currency 7

        'CASE f_type WHEN "t" THEN ' + // a
        '(SELECT a_name FROM accounts WHERE a_id = f_category) ' + // b
        'ELSE ' + // c
        '(SELECT c_category FROM categories WHERE c_id = f_category) END, ' +
        // category 8

        'CASE f_type WHEN "t" THEN ' + // a
        '(SELECT a_currency FROM accounts WHERE a_id = f_category) ' + // b
        'ELSE ' + // c
        '(SELECT c_subcategory FROM categories WHERE c_id = f_category) END, ' +
        // subcategory 9

        '(SELECT p_name FROM PERSONS WHERE p_id = f_person), ' + // person 10
        '(SELECT e_name FROM PAYEES WHERE e_id = f_payee), ' + // payee 11
        'f_id ' + // ID 12
        'FROM fixed;';
      Q1.Open;

      while not (Q1.EOF) do
      begin
        {ShowMessage(
          Q1.Fields[0].AsString + sLineBreak + Q1.Fields[1].AsString + sLineBreak +
          Q1.Fields[2].AsString + sLineBreak + Q1.Fields[3].AsString + sLineBreak +
          Q1.Fields[4].AsString + sLineBreak + Q1.Fields[5].AsString + sLineBreak +
          'account: ' + Q1.Fields[6].AsString + sLineBreak +
          'currency: ' + Q1.Fields[7].AsString + sLineBreak +
          'category: ' + Q1.Fields[8].AsString + sLineBreak +
          'subcategory: ' +Q1.Fields[9].AsString + sLineBreak +
          'person: ' + Q1.Fields[10].AsString + sLineBreak +
          'payee: ' + Q1.Fields[11].AsString);}

        frmMain.QRY.SQL.Text :=
          'INSERT OR IGNORE INTO scheduler (sch_date_from, sch_date_to, sch_period, ' +
          'sch_type, sch_sum1, sch_comment, sch_account1, sch_category, sch_person, ' +
          'sch_payee, sch_sum2, sch_account2) VALUES (' +
          ':DATE1, :DATE2, :PERIODICITY, :TYPE, :AMOUNT1, :COMMENT, ' +
          '(SELECT acc_id FROM accounts ' + sLineBreak + // account
          'WHERE acc_name_lower = :ACCOUNT1 and acc_currency = :CURRENCY1), ' +
          sLineBreak + // d_account 1
          '(SELECT cat_id FROM categories ' + sLineBreak + // category
          'WHERE cat_name = :SUBCATEGORY and cat_parent_name = :CATEGORY ' +
          IfThen(Q1.Fields[3].AsInteger = 2, '), ', 'and cat_parent_id > 0), ') +
          sLineBreak + // subcategory
          '(SELECT per_id FROM persons WHERE per_name = :PERSON), ' +
          sLineBreak + // d_person
          '(SELECT pee_id FROM payees WHERE pee_name = :PAYEE), ' + // d_payee
          IfThen(Q1.Fields[3].AsInteger < 2, '0, NULL);', ':AMOUNT2, ' + // amount 2
          '(SELECT acc_id FROM accounts ' + sLineBreak + // account
          'WHERE acc_name_lower = :ACCOUNT2 and acc_currency = :CURRENCY2));');
        // d_account 2

        frmMain.QRY.Params.ParamByName('DATE1').AsString := Q1.Fields[0].AsString;
        frmMain.QRY.Params.ParamByName('DATE2').AsString := Q1.Fields[1].AsString;
        frmMain.QRY.Params.ParamByName('PERIODICITY').AsInteger :=
          Q1.Fields[2].AsInteger;
        frmMain.QRY.Params.ParamByName('TYPE').AsInteger := Q1.Fields[3].AsInteger;
        frmMain.QRY.Params.ParamByName('AMOUNT1').AsString :=
          ReplaceStr(Q1.Fields[4].AsString, ',', '.');
        frmMain.QRY.Params.ParamByName('COMMENT').AsString := Q1.Fields[5].AsString;
        frmMain.QRY.Params.ParamByName('ACCOUNT1').AsString :=
          AnsiLowerCase(Q1.Fields[6].AsString);
        frmMain.QRY.Params.ParamByName('CURRENCY1').AsString :=
          AnsiUpperCase(Q1.Fields[7].AsString);
        frmMain.QRY.Params.ParamByName('PERSON').AsString := Q1.Fields[10].AsString;
        frmMain.QRY.Params.ParamByName('PAYEE').AsString :=
          IfThen(Length(Q1.Fields[11].AsString) = 0, ' ', Q1.Fields[11].AsString);


        if Q1.Fields[3].AsInteger = 2 then
        begin
          frmMain.QRY.Params.ParamByName('AMOUNT2').AsString :=
            ReplaceStr(Q1.Fields[4].AsString, ',', '.');
          frmMain.QRY.Params.ParamByName('ACCOUNT2').AsString :=
            AnsiLowerCase(Q1.Fields[8].AsString);
          frmMain.QRY.Params.ParamByName('CURRENCY2').AsString :=
            AnsiUpperCase(Q1.Fields[9].AsString);
          frmMain.QRY.Params.ParamByName('CATEGORY').AsString := 'TRANSFER';
          frmMain.QRY.Params.ParamByName('SUBCATEGORY').AsString := 'TRANSFER';
        end
        else
        begin
          frmMain.QRY.Params.ParamByName('CATEGORY').AsString :=
            AnsiUpperCase(Q1.Fields[8].AsString);
          frmMain.QRY.Params.ParamByName('SUBCATEGORY').AsString :=
            AnsiLowerCase(Q1.Fields[9].AsString);
        end;

        frmMain.QRY.Prepare;
        frmMain.QRY.ExecSQL;

        // generate payments
        Temp := frmMain.Conn.GetInsertID.ToString;

        // write paying date to scheduled payments
        // CREATE TABLE schedule (sch_date TEXT, sch_sum NUMBER, sch_payd TEXT, sch_type TEXT,
        // sch_f_id NUMBER, sch_id INTEGER PRIMARY KEY)

        Q2.SQL.Text :=
          'SELECT sch_date, sch_payd, ' +
          'CASE sch_type WHEN "-" THEN -ROUND(sch_sum, 2) WHEN "m" THEN -ROUND(sch_sum, 2) ELSE ROUND(sch_sum, 2) END, '
          + // sum 4
          'CASE sch_type WHEN "+" THEN 0 WHEN "-" THEN 1 WHEN "p" THEN 2 ELSE 3 END, ' +
          // type 3
          'sch_f_id from schedule ' + // select
          'WHERE sch_f_id = ' + Q1.Fields[12].AsString; // where
        Q2.Open;

        while not (Q2.EOF) do
        begin
          frmMain.QRY.SQL.Text :=
            'INSERT OR IGNORE INTO payments (pay_date_plan, pay_date_paid, pay_type, pay_sum, pay_comment, '
            + 'pay_account, pay_category, pay_person, pay_payee, pay_sch_id) VALUES ('
            + ':DATE1, ' + IfThen(Length(Q2.Fields[1].AsString) = 0,
            'NULL, ', ':DATE2, ') + ' :TYPE, :SUM, :COMMENT, ' + // data
            '(SELECT acc_id FROM accounts ' + sLineBreak + // account
            'WHERE acc_name_lower = :ACCOUNT and acc_currency = :CURRENCY), ' +
            sLineBreak + // d_account
            '(SELECT cat_id FROM categories ' + sLineBreak + // category
            'WHERE cat_name = :SUBCATEGORY and cat_parent_name = :CATEGORY ' +
            IfThen(Q2.Fields[3].AsInteger > 1, '), ', 'and cat_parent_id > 0), ') +
            sLineBreak + // subcategory
            '(SELECT per_id FROM persons WHERE per_name = :PERSON), ' +
            sLineBreak + // d_person
            '(SELECT pee_id FROM payees WHERE pee_name = :PAYEE), ' + // d_payee
            ':ID);';

          frmMain.QRY.Params.ParamByName('DATE1').AsString := Q2.Fields[0].AsString;
          if Length(Q2.Fields[1].AsString) > 0 then
            frmMain.QRY.Params.ParamByName('DATE2').AsString := Q2.Fields[1].AsString;
          frmMain.QRY.Params.ParamByName('SUM').AsString :=
            AnsiReplaceStr(Q2.Fields[2].AsString, ',', '.');
          frmMain.QRY.Params.ParamByName('TYPE').AsInteger := Q2.Fields[3].AsInteger;
          frmMain.QRY.Params.ParamByName('ID').AsInteger := StrToInt(Temp);

          frmMain.QRY.Params.ParamByName('COMMENT').AsString := Q1.Fields[5].AsString;
          frmMain.QRY.Params.ParamByName('PERSON').AsString := Q1.Fields[10].AsString;
          frmMain.QRY.Params.ParamByName('PAYEE').AsString :=
            IfThen(Length(Q1.Fields[11].AsString) = 0, ' ', Q1.Fields[11].AsString);


          if Q2.Fields[3].AsInteger = 2 then
          begin
            frmMain.QRY.Params.ParamByName('ACCOUNT').AsString :=
              AnsiLowerCase(Q1.Fields[8].AsString);
            frmMain.QRY.Params.ParamByName('CURRENCY').AsString :=
              AnsiUpperCase(Q1.Fields[9].AsString);
            frmMain.QRY.Params.ParamByName('CATEGORY').AsString := 'TRANSFER';
            frmMain.QRY.Params.ParamByName('SUBCATEGORY').AsString := 'TRANSFER';
          end
          else
          begin
            frmMain.QRY.Params.ParamByName('ACCOUNT').AsString :=
              AnsiLowerCase(Q1.Fields[6].AsString);
            frmMain.QRY.Params.ParamByName('CURRENCY').AsString :=
              AnsiUpperCase(Q1.Fields[7].AsString);
            if Q2.Fields[3].AsInteger = 3 then
            begin
              frmMain.QRY.Params.ParamByName('CATEGORY').AsString := 'TRANSFER';
              frmMain.QRY.Params.ParamByName('SUBCATEGORY').AsString := 'TRANSFER';
            end
            else
            begin
              frmMain.QRY.Params.ParamByName('CATEGORY').AsString :=
                AnsiUpperCase(Q1.Fields[8].AsString);
              frmMain.QRY.Params.ParamByName('SUBCATEGORY').AsString :=
                AnsiLowerCase(Q1.Fields[9].AsString);
            end;
          end;

          frmMain.QRY.Prepare;
          frmMain.QRY.ExecSQL;

          Q2.Next;
        end;
        Q2.Close;
        Q1.Next;
      end;
      Q1.Close;

      // ============================================================================================
      // EXTERNAL LINKS      ------------------------------------------------------------------------
      try
        Q1.SQL.Text :=
          'SELECT Count(name) FROM sqlite_master WHERE type="table" and name = "links"';
        Q1.Open;
        if Q1.Fields[0].AsInteger > 0 then
        begin
          Q1.Close;
          Q1.SQL.Text :=
            'SELECT l_name, l_link, l_shortcut, l_comment, l_id FROM links;';
          Q1.Open;
          while not (Q1.EOF) do
          begin
            frmMain.QRY.SQL.Text :=
              'INSERT OR IGNORE INTO links (lin_name, lin_link, lin_shortcut, lin_comment)'
              + 'VALUES (:NAME, :LINK, :SHORTCUT, :COMMENT);';
            frmMain.QRY.Params.ParamByName('NAME').AsString := Q1.Fields[0].AsString;
            frmMain.QRY.Params.ParamByName('LINK').AsString := Q1.Fields[1].AsString;
            frmMain.QRY.Params.ParamByName('SHORTCUT').AsString := Q1.Fields[2].AsString;
            frmMain.QRY.Params.ParamByName('COMMENT').AsString := Q1.Fields[3].AsString;
            frmMain.QRY.Prepare;
            frmMain.QRY.ExecSQL;
            Q1.Next;
          end;
        end;
        Q1.Close;
      except
        on E: Exception do
        begin
          Q1.Close;
          ShowErrorMessage(E);
        end;
      end;

      // ============================================================================================
      // write all changes to the database
      frmMain.Tran.Commit;

      // =====================================================
      // disconnect
      if S.Connected then
      begin
        T.Commit;
        Q1.Close;
        Q2.Close;
        S.Close;
      end;

      // release
      Q1.Free;
      Q2.Free;
      T.Free;
      S.Free;

      Screen.Cursor := crDefault;
      ShowMessage(Message_06);
    end;

  except
    on E: Exception do
    begin
      screen.Cursor := crDefault;
      ShowErrorMessage(E);
    end;
  end;

  frmImport.ModalResult := mrOk;
end;

procedure TfrmImport.btnFileClick(Sender: TObject);
begin
  // set filter file extension
  case tabImport.TabIndex of
    0: odImport.Filter := Caption_249 + ' RQ Money v 2.x (*.rqm)|*.rqm|' +
        Caption_250 + ' (*.*)|*.*';
    1: odImport.Filter := Caption_249 + ' CSV|*.csv|' + Caption_250 + ' (*.*)|*.*';
    2: odImport.Filter := Caption_249 + ' TXT|*.txt|' + Caption_250 + ' (*.*)|*.*';
  end;

  if odImport.Execute = False then
    Exit;

  lblFileName.Caption := odImport.FileName;
  lblFileName.Hint := odImport.FileName;
  lblFileName1.Visible := True;
  btnImport.Enabled := True;
  btnImport.SetFocus;
end;

procedure TfrmImport.actExitExecute(Sender: TObject);
begin
  frmImport.ModalResult := mrCancel;
end;

procedure TfrmImport.btnImport1Click(Sender: TObject);
begin
  frmImport.ModalResult := mrOk;
end;

procedure TfrmImport.FormCreate(Sender: TObject);
begin
  // set components height
  pnlImportCaption.Height := PanelHeight;
  pnlButtons.Height := ButtonHeight;
  pnlBottom.Height := ButtonHeight;

  // get form icon
  frmMain.img16.GetIcon(3, (Sender as TForm).Icon);

  tabImport.Tabs.Add('RQM');
  tabImport.Tabs.Add('CSV');
  tabImport.Tabs.Add('TXT');
  tabImport.TabIndex := 0;
  tabImportChange(tabImport);
end;

procedure TfrmImport.FormResize(Sender: TObject);
begin
  lblWidth.Caption := IntToStr((Sender as TForm).Width);
  lblHeight.Caption := IntToStr((Sender as TForm).Height);
  pnlImportCaption.Repaint;
end;

procedure TfrmImport.FormShow(Sender: TObject);
begin
  tabImport.TabIndex := 0;
  tabImportChange(tabImport);
  btnFile.SetFocus;
  lblProgress.Caption := '';
end;

procedure TfrmImport.tabImportChange(Sender: TObject);
begin
  lblFileName1.Visible := False;
  lblFileName.Caption := '';
  lblFileName.Hint := '';
  btnImport.Enabled := False;
  lblProgress.Caption := '';
end;

end.
