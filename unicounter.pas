unit uniCounter;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons, ComCtrls, ActnList, BCPanel, BCMDButtonFocus, StrUtils, Clipbrd,
  LazUTF8, Math;

type

  { TfrmCounter }

  TfrmCounter = class(TForm)
    actExit: TAction;
    actCopy: TAction;
    actPrint: TAction;
    ActionList1: TActionList;
    btnCopy: TBCMDButtonFocus;
    btnCurrencies: TSpeedButton;
    btnExit: TBCMDButtonFocus;
    btnPrint: TBCMDButtonFocus;
    btnReset: TBCMDButtonFocus;
    btnValues: TSpeedButton;
    cbxCurrency: TComboBox;
    imgHeight: TImage;
    imgWidth: TImage;
    lblHeight: TLabel;
    lblWidth: TLabel;
    pnlBottom: TPanel;
    pnlCurrencyCaption: TBCPanel;
    lblTotal: TLabel;
    lblValue: TLabel;
    lblTotalCaption: TLabel;
    pnlButtons: TPanel;
    pnlCurrency: TPanel;
    pnlHeight: TPanel;
    pnlSummary: TPanel;
    pnlValue: TPanel;
    pnlCurrencies: TPanel;
    pnlBackground: TPanel;
    BackGround: TScrollBox;
    pnlWidth: TPanel;
    procedure btnCurrenciesClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure btnPrintMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure btnResetClick(Sender: TObject);
    procedure btnCopyClick(Sender: TObject);
    procedure btnValuesClick(Sender: TObject);
    procedure cbxCurrencyChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lviListData(Sender: TObject; Item: TListItem);
    procedure pnlButtonsResize(Sender: TObject);
  private

  public
    procedure ediExit(Sender: TObject);
    procedure ediEnter(Sender: TObject);
    procedure ediChange(Sender: TObject);
    procedure ediKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);

  end;

var
  frmCounter: TfrmCounter;
  pnl: array [1..30] of TPanel;
  img: array [1..30] of TSpeedButton;
  lbl, sum: array [1..30] of TLabel;
  edi: array [1..30] of TEdit;
  slCounter: TStringList;

implementation

{$R *.lfm}

uses
  uniMain, uniValues, uniCurrencies, uniResources;

{ TfrmCounter }

procedure TfrmCounter.FormCreate(Sender: TObject);
begin
   // form size
  (Sender as TForm).Width := Round(800 div (ScreenIndex + 1) * (200 / ScreenRatio));
  (Sender as TForm).Height := Round(Screen.Height /
    IfThen(ScreenIndex = 0, 1, (ScreenRatio / 100))) - 2 * (250 - ScreenRatio);

  // form position
  (Sender as TForm).Left := (Screen.Width - (Sender as TForm).Width) div 2;
  (Sender as TForm).Top := (Screen.Height - 100 - (Sender as TForm).Height) div 2;

  slCounter := TStringList.Create;

  // set components height
  pnlCurrencyCaption.Height := PanelHeight;
  pnlButtons.Height := ButtonHeight;
end;

procedure TfrmCounter.FormDestroy(Sender: TObject);
begin
  slCounter.Free;
end;

procedure TfrmCounter.FormResize(Sender: TObject);
begin
  lblWidth.Caption := IntToStr((Sender as TForm).Width);
  lblHeight.Caption := IntToStr((Sender as TForm).Height);
  pnlCurrencyCaption.Repaint;
  pnlButtons.Repaint;
end;

procedure TfrmCounter.FormShow(Sender: TObject);
begin
  if (cbxCurrency.ItemIndex > -1) and (BackGround.Tag > 0) then
  begin
    edi[BackGround.Tag].SetFocus;
    edi[BackGround.Tag].SelectAll;
  end;

  btnCurrencies.Enabled := frmMain.Conn.Connected = True;
  cbxCurrency.Enabled := (frmMain.Conn.Connected = True) and (cbxCurrency.Items.Count > 0);
  btnValues.Enabled := (frmMain.Conn.Connected = True) and (cbxCurrency.ItemIndex > -1);
end;

procedure TfrmCounter.lviListData(Sender: TObject; Item: TListItem);
begin
  if slCounter.Count > 0 then
    try
      Item.Caption := '';

      // nominal
      Item.SubItems.Add(Field(separ, slCounter.Strings[Item.Index], 1));

      // count
      Item.SubItems.Add(Field(separ, slCounter.Strings[Item.Index], 2));

      // summary
      Item.SubItems.Add(Field(separ, slCounter.Strings[Item.Index], 3));

    finally;
    end;
end;

procedure TfrmCounter.pnlButtonsResize(Sender: TObject);
begin
  btnCopy.Width := (pnlButtons.Width - 10) div 4;
  btnPrint.Width := btnCopy.Width;
  btnExit.Width := btnCopy.Width;
end;

procedure TfrmCounter.btnValuesClick(Sender: TObject);
begin
  frmValues.Caption := AnsiUpperCase(ReplaceStr(frmCurrencies.btnValues.Caption,
    '&', '')) + ' [' + cbxCurrency.Items[cbxCurrency.ItemIndex] + ']';

  frmMain.QRY.SQL.Text := 'SELECT cur_id FROM currencies WHERE cur_code = :CURRENCY;';
  frmMain.QRY.Params.ParamByName('CURRENCY').AsString :=
    Field(' | ', cbxCurrency.Items[cbxCurrency.ItemIndex], 1);

  frmMain.QRY.Open;
  frmValues.Tag := frmMain.QRY.Fields[0].AsInteger;
  frmMain.QRY.Close;
  frmValues.ShowModal;
  frmValues.Tag := 0;
end;

procedure TfrmCounter.btnCopyClick(Sender: TObject);
var
  cb: TClipboard;

begin
  if btnCopy.Enabled = False Then
    Exit;

  cb := TClipboard.Create;
  cb.AsText := Caption_13 + chr(9) + Caption_14 + chr(9) + Caption_15 + sLineBreak +
    AnsiReplaceStr(slCounter.Text, separ, chr(9)) +
    lblTotalCaption.Caption + chr(9) + chr(9) + lblTotal.Hint;
  ShowMessage(Format(Message_01, [IntToStr(slCounter.Count - 1)]));
end;

procedure TfrmCounter.btnResetClick(Sender: TObject);
var
  I: byte;
  S: string;

begin
  S := Field('%2', Question_09, 2);
  S := AnsiReplaceStr(S, '%1',
    Field(' | ', cbxCurrency.Items[cbxCurrency.ItemIndex], 1));
  if (MessageDlg(Application.Title, S, mtConfirmation, [mbYes, mbNo], 0) <> mrYes) then
    Exit;

  for I := 1 to BackGround.Tag do
    edi[I].Text := '0';
end;

procedure TfrmCounter.btnCurrenciesClick(Sender: TObject);
begin
  frmCurrencies.ShowModal;
end;

procedure TfrmCounter.btnExitClick(Sender: TObject);
begin
  frmCounter.Close;
end;

procedure TfrmCounter.btnPrintClick(Sender: TObject);
var
  FileName: String;

begin
  if btnPrint.Enabled = False then Exit;

  FileName := ExtractFileDir(Application.ExeName) + DirectorySeparator + 'Templates' +
     DirectorySeparator + 'cashcounter.lrf';

 if FileExists(FileName) = False then
 begin
   ShowMessage(Error_14 + sLineBreak + FileName);
   Exit;
 end;

 // left mouse button = show report
 try
    frmMain.Report.Tag := 20;
    frmMain.Report.LoadFromFile(FileName);
    frmMain.Report.FindObject('lblNominal').Memo.Text :=
      AnsiUpperCase(Caption_13);
    frmMain.Report.FindObject('lblCount').Memo.Text :=
      AnsiUpperCase(Caption_14);
    frmMain.Report.FindObject('lblSum').Memo.Text :=
      AnsiUpperCase(Caption_15);

    frmMain.Report.FindObject('lblFooter').Memo.Text :=
      AnsiUpperCase(Application.Title + ' - ' + frmCounter.Caption);

    frmMain.Report.FindObject('lblTotal').Memo.Text := lblTotal.Caption;
    frmMain.Report.FindObject('lblTotal1').Memo.Text := lblTotalCaption.Caption;

    frmMain.Report.ShowReport;

    if BackGround.Tag > 0 then
      edi[BackGround.Tag].SetFocus;

 except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmCounter.btnPrintMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  FileName: String;

begin
  FileName := ExtractFileDir(Application.ExeName) + DirectorySeparator + 'Templates' +
     DirectorySeparator + 'cashcounter.lrf';

 if FileExists(FileName) = False then
 begin
   ShowMessage(Error_14 + sLineBreak + FileName);
   Exit;
 end;

 // right mouse button = show design report
 if Button = mbRight then
   begin
     frmMain.Report.LoadFromFile(FileName);
     frmMain.Report.DesignReport;
   end
   else if Button = mbLeft then
     btnPrintClick(btnPrint);
end;

procedure TfrmCounter.ediEnter(Sender: TObject);
begin
  edi[(Sender as TEdit).Tag].SelStart := 0;
  edi[(Sender as TEdit).Tag].SelLength := Length(edi[(Sender as TEdit).Tag].Text);
end;

procedure TfrmCounter.ediKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if Key in [9] then
  begin
    Key := 0;
  end
  else if Key in [13, 40] then
  begin
    Key := 0;
    if (Sender as TEdit).Tag = 1 then
      edi[BackGround.Tag].SetFocus
    else
      edi[(Sender as TEdit).Tag - 1].SetFocus;
  end
  else if Key in [38] then
  begin
    Key := 0;
    if (Sender as TEdit).Tag = BackGround.Tag then
      edi[1].SetFocus
    else
      edi[(Sender as TEdit).Tag + 1].SetFocus;
  end;

end;

procedure TfrmCounter.ediChange(Sender: TObject);
var
  Nominal, Total: double;
  Count: Integer;
  I: byte;

begin
  Total := 0.00; // Total
  for I := 1 to BackGround.Tag do
  begin
    TryStrToInt(edi[I].Text, Count);
    TryStrToFloat(lbl[I].Hint, Nominal);

    sum[I].Caption := Format('%n', [Count * Nominal], FS_own);
    sum[I].Hint := FloatToStr(Round((Count * Nominal) * 100) / 100);
    if (Count * Nominal) = 0.00 then
      sum[I].Font.Style := []
    else
      sum[I].Font.Style := [fsBold];
    Total := Total + Round((Count * Nominal) * 100) / 100;
  end;
  lblTotal.Hint := FloatToStr(Total);
  lblTotal.Caption := Format('%n', [Total], FS_own);

  // enumerate
  slCounter.Clear;
  for I := BackGround.Tag downto 1 do
    slCounter.Add(lbl[I].Hint + separ + edi[I].Text + separ + sum[I].Hint);
end;

procedure TfrmCounter.cbxCurrencyChange(Sender: TObject);
var
  I: byte;
  S: String;

begin
  if (frmCounter.Visible = True) and (BackGround.Tag > 0) and (cbxCurrency.Tag <> cbxCurrency.ItemIndex) then
  begin
    S := AnsiReplaceStr(Question_09, '%1',
      Field(' | ', cbxCurrency.Items[cbxCurrency.ItemIndex], 1));
    S := AnsiReplaceStr(S, '%2', sLineBreak);
    if (MessageDlg(Application.Title, S, mtConfirmation, [mbYes, mbNo], 0) <> mrYes) then
    begin
      cbxCurrency.ItemIndex := cbxCurrency.Tag;
      Exit;
    end;
  end;

  btnValues.Enabled := cbxCurrency.ItemIndex > -1;
  btnPrint.Enabled := cbxCurrency.ItemIndex > -1;
  btnCopy.Enabled := cbxCurrency.ItemIndex > -1;
  btnReset.Enabled := cbxCurrency.ItemIndex > -1;
  lblTotal.Caption := Format('%n', [0.00]);
  cbxCurrency.Enabled := cbxCurrency.Items.Count > 0;

  // clear previous fields
  while BackGround.ControlCount > 0 do
    BackGround.Controls[0].Free;

  If (cbxCurrency.ItemIndex = -1) or (frmMain.Conn.Connected = False) then begin
     lblTotalCaption.Caption := lblTotalCaption.Hint;
     BackGround.Visible := False;
     Exit;
   end;

  lblTotalCaption.Caption := Field(' | ', cbxCurrency.Items[cbxCurrency.ItemIndex],
    1) + ' ' + lblTotalCaption.Hint;
  frmMain.QRY.SQL.Text := 'SELECT nom_value, nom_coin FROM nominal WHERE nom_currency_id = ' +
    '(SELECT cur_id FROM currencies WHERE cur_code = :CURRENCY) ' +
    ' ORDER BY nom_value;';
  frmMain.QRY.Params.ParamByName('CURRENCY').AsString :=
    Field(' | ', cbxCurrency.Items[cbxCurrency.ItemIndex], 1);

  frmMain.QRY.Open;

  I := 1;

  while not (frmMain.QRY.EOF) do
  begin
    pnl[I] := TPanel.Create(BackGround);
    pnl[I].Parent := BackGround;
    pnl[I].Align := alTop;
    pnl[I].BevelOuter := bvLowered;
    pnl[I].Font.Style := [];
    pnl[I].AutoSize := True;

    edi[I] := TEdit.Create(pnl[I]);
    edi[I].Parent := pnl[I];
    edi[I].Align := alLeft;
    edi[I].Width := 80;
    edi[I].Constraints.MinWidth := 80;
    edi[I].BorderSpacing.Top := 0;
    edi[I].BorderSpacing.Left := 20;
    edi[I].BorderSpacing.Bottom := 0;
    edi[I].BorderSpacing.Right := 20;
    edi[I].Alignment := taRightJustify;
    edi[I].Text := '0';
    edi[I].NumbersOnly := True;
    edi[I].Tag := I;
    edi[I].OnEnter := @ediEnter;
    edi[I].OnChange := @ediChange;
    edi[I].OnKeyUp := @ediKeyUp;
    edi[I].OnExit := @ediExit;
    edi[I].AutoSize := True;


    lbl[I] := TLabel.Create(pnl[I]);
    lbl[I].Parent := pnl[I];
    lbl[I].Width := 200;
    lbl[I].Constraints.MinWidth := 200;
    lbl[I].AutoSize := True;
    lbl[I].Align := alLeft;
    lbl[I].Alignment := taRightJustify;
    lbl[I].BorderSpacing.left := 5;
    lbl[I].Layout := tlCenter;
    lbl[I].Caption := Format('%n', [frmMain.QRY.Fields[0].AsFloat], FS_own) +
      ' ' + Field(' | ', cbxCurrency.Items[cbxCurrency.ItemIndex], 1);
    lbl[I].Hint := FloatToStr(frmMain.QRY.Fields[0].AsFloat);
    // lbl[I].ShowHint := True;

    sum[I] := TLabel.Create(pnl[I]);
    sum[I].Parent := pnl[I];
    sum[I].Align := alClient;
    sum[I].BorderSpacing.Right := 5;
    sum[I].Alignment := taRightJustify;
    sum[I].Layout := tlCenter;
    sum[I].Caption := Format('%n', [0.00]);
    sum[I].Hint := Format('%n', [0.00]);
    sum[I].AutoSize := True;

    img[I] := TSpeedButton.Create(pnl[I]);
    img[I].Parent := pnl[I];
    img[I].Align := alLeft;
    img[I].BorderSpacing.Left := 3;
    img[I].AutoSize := True;
    img[I].Flat := True;
    img[I].Spacing := 1;
    img[I].Images := frmValues.imgList;
    img[I].ImageIndex := frmMain.QRY.Fields[1].AsInteger;

    Inc(I);
    frmMain.QRY.Next;
  end;

  BackGround.Visible := True;
  BackGround.Tag := I - 1;

  // buttons enabling
  btnPrint.Enabled := BackGround.Tag > 0;
  btnCopy.Enabled := BackGround.Tag > 0;
  btnReset.Enabled := BackGround.Tag > 0;

  if frmCounter.Visible = True then edi[I - 1].SetFocus;

  frmMain.QRY.Close;
  cbxCurrency.Tag := cbxCurrency.ItemIndex;

  // enumerate
  slCounter.Clear;
  for I := BackGround.Tag downto 1 do
    slCounter.Add(lbl[I].Hint + separ + edi[I].Text + separ + sum[I].Hint);
end;

procedure TfrmCounter.ediExit(Sender: TObject);
var
  I: integer;

begin
  //If (Sender as TEdit).Text = '' then  (Sender as TEdit).Text := '0';
  TryStrToInt((Sender as TEdit).Text, I);
  (Sender as TEdit).Text := IntToStr(I);
end;

end.
