unit uniCalendar;

{$mode ObjFPC}{$H+}
{$ModeSwitch AutoDeref}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, ActnList,
  Buttons, StdCtrls, ComCtrls, laz.VirtualTrees, BCPanel, BGRABitmap,
  DateUtils, Math, StrUtils, BCMDButtonFocus, CalendarLite, IniFiles;

type // bottom grid (Calendar)
  TDailyPayment = record
    Date: string;
    Periodicity: integer;
    Amount: double;
    currency: string;
    Comment: string;
    Kind: integer;
    ID: integer;
  end;
  PDailyPayment = ^TDailyPayment;

type

  { TfrmCalendar }

  TfrmCalendar = class(TForm)
    actExit: TAction;
    actEdit: TAction;
    actDelete: TAction;
    actCurrencies: TAction;
    actAccounts: TAction;
    ActionList1: TActionList;
    btnAccounts: TSpeedButton;
    btnDelete: TBCMDButtonFocus;
    btnEdit: TBCMDButtonFocus;
    btnExit: TBCMDButtonFocus;
    btnCurrencies: TSpeedButton;
    Calendar: TCalendarLite;
    cbxAccount: TComboBox;
    cbxCurrency: TComboBox;
    imgCredit1: TImage;
    imgDebit1: TImage;
    imgHeight: TImage;
    imgTransferPlus1: TImage;
    imgTransferMinus1: TImage;
    imgAccount: TImage;
    imgCurrency: TImage;
    imgMonthYear: TImage;
    imgTotal1: TImage;
    imgWidth: TImage;
    lblCredit1: TLabel;
    lblDebit1: TLabel;
    lblHeight: TLabel;
    lblTransferPlus1: TLabel;
    lblTransferMinus1: TLabel;
    lblTotal1: TLabel;
    lblWidth: TLabel;
    pnlBottom: TPanel;
    pnlButtons: TPanel;
    pnlHeight: TPanel;
    pnlWidth: TPanel;
    tabCalendar: TPageControl;
    pnlDays: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    pnlTotalMonthYear: TBCPanel;
    pnlMonthYear: TPanel;
    Panel2: TPanel;
    pnlAccount: TPanel;
    pnlAccountCaption: TPanel;
    pnlCurrency: TPanel;
    pnlCurrency1: TPanel;
    pnlCurrencyCaption: TPanel;
    pnlMonthYearCaption: TPanel;
    pnlLeft: TPanel;
    pnlClient: TPanel;
    pnlFilter: TPanel;
    pnlCalendarCaption: TBCPanel;
    pnlFilterCaption: TBCPanel;
    pnlSummary: TPanel;
    pnlSummaryCaption: TBCPanel;
    pnlTotal1: TPanel;
    splCalendar: TSplitter;
    tabMonthly: TTabSheet;
    tabDaily: TTabSheet;
    VST: TLazVirtualStringTree;
    VSTFloat: TLazVirtualStringTree;
    procedure actExitExecute(Sender: TObject);
    procedure btnAccountsClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure btnCurrenciesClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure CalendarDateChange(Sender: TObject);
    procedure CalendarMonthChange(Sender: TObject);
    procedure cbxAccountChange(Sender: TObject);
    procedure cbxCurrencyChange(Sender: TObject);
    procedure cbxCurrencyDropDown(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure pnlAccountCaptionClick(Sender: TObject);
    procedure pnlClientResize(Sender: TObject);
    procedure pnlCurrencyCaptionClick(Sender: TObject);
    procedure pnlMonthYearCaptionClick(Sender: TObject);
    procedure splCalendarCanResize(Sender: TObject; var NewSize: integer;
      var Accept: boolean);
    procedure tabCalendarChange(Sender: TObject);
    procedure VSTBeforeCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas;
      Node: PVirtualNode; Column: TColumnIndex; CellPaintMode: TVTCellPaintMode;
      CellRect: TRect; var ContentRect: TRect);
    procedure VSTChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure VSTDblClick(Sender: TObject);
    procedure VSTFloatGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure VSTFloatResize(Sender: TObject);
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
    procedure PaintPanel(Sender: TObject);
    procedure ClickPanel(Sender: TObject);
    procedure ShowDailyPayments(Sender: TObject; Shift: TShiftState; X, Y: integer);
    procedure HideDailyPayments(Sender: TObject);
    procedure ReadDailyPayments(Sender: TObject);
  end;

var
  frmCalendar: TfrmCalendar;
  Week_day: array [0..6] of TPanel;
  Week_number: array [0..5] of TPanel;
  pnlDay: array [0..41] of TPanel;
  CalendarDay: TDate;

implementation

{$R *.lfm}

{ TfrmCalendar }

uses
  uniMain, uniCurrencies, uniAccounts, uniScheduler, uniSchedulers,
  uniSettings, uniResources, uniEdit, uniEdits;

procedure TfrmCalendar.FormCreate(Sender: TObject);
var
  I: byte;
begin
  frmMain.imgArrows.GetBitmap(1, imgMonthYear.Picture.Bitmap);
  frmMain.imgArrows.GetBitmap(0, imgCurrency.Picture.Bitmap);
  frmMain.imgArrows.GetBitmap(0, imgAccount.Picture.Bitmap);

  // create daily panels
  for I := 0 to 6 do
  begin
    Week_day[I] := TPanel.Create(pnlClient);
    Week_day[I].Parent := pnlDays;
    Week_day[I].Top := 0;
    Week_day[I].Height := 20;
    Week_day[I].BevelOuter := bvRaised;
    Week_day[I].Font.Color := clWhite;
    Week_day[I].Font.Bold := True;
    Week_day[I].Color := clDkGray;
  end;

  for I := 0 to 5 do
  begin
    Week_number[I] := TPanel.Create(pnlClient);
    Week_number[I].Parent := pnlDays;
    Week_number[I].Left := 0;
    Week_number[I].Width := 25;
    Week_number[I].BevelOuter := bvRaised;
    Week_number[I].Font.Color := clWhite;
    Week_number[I].Font.Bold := True;
    Week_number[I].Color := clDkGray;
  end;

  for I := 0 to 41 do
  begin
    pnlDay[I] := TPanel.Create(pnlClient);
    pnlDay[I].Parent := pnlDays;
    pnlDay[I].BevelOuter := bvRaised;
    pnlDay[I].Cursor := crHandPoint;
    pnlDay[I].Tag := I;

    pnlDay[I].OnMouseEnter := @ReadDailyPayments;
    pnlDay[I].OnMouseMove := @ShowDailyPayments;
    pnlDay[I].OnMouseLeave := @HideDailyPayments;

  end;

  tabCalendar.TabIndex := 0;
  Calendar.Date := Today();

  // input day long names
  for I := 1 to 7 do
  begin
    Calendar.DayNames :=
      Calendar.DayNames + sLineBreak + DefaultFormatSettings.ShortDayNames[I];
  end;
  for I := 0 to 11 do
    Calendar.MonthNames :=
      Calendar.MonthNames + sLineBreak +
      DefaultFormatSettings.LongMonthNames[I + 1];

  cbxAccount.Clear;
  cbxAccount.Items.Add('*');
  cbxAccount.ItemIndex := 0;

  // set components height
  VST.Header.Height := PanelHeight;
  VSTFloat.Header.Height := PanelHeight;
  pnlCalendarCaption.Height := PanelHeight;
  pnlFilterCaption.Height := PanelHeight;
  pnlSummaryCaption.Height := PanelHeight;
  pnlTotalMonthYear.Height := PanelHeight;
  pnlCurrencyCaption.Height := PanelHeight;
  pnlAccountCaption.Height := PanelHeight;
  pnlMonthYearCaption.Height := PanelHeight;
  pnlButtons.Height := ButtonHeight;
  btnExit.Height := ButtonHeight;
  pnlBottom.Height := ButtonHeight;

  // get form icon
  frmMain.img16.GetIcon(20, (Sender as TForm).Icon);
end;

procedure TfrmCalendar.FormResize(Sender: TObject);
begin
  imgWidth.ImageIndex := 0;
  lblWidth.Caption := IntToStr(frmCalendar.Width);
  imgHeight.ImageIndex := 1;
  lblHeight.Caption := IntToStr(frmCalendar.Height);

  pnlCalendarCaption.Repaint;
  pnlFilterCaption.Repaint;
  pnlSummaryCaption.Repaint;
end;

procedure TfrmCalendar.FormShow(Sender: TObject);
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
      frmCalendar.Position := poDesigned;
      S := INI.ReadString('POSITION', frmCalendar.Name, '-1•-1•0•0•200');

      // width
      TryStrToInt(Field(Separ, S, 3), I);
      if (I < 1) or (I > Screen.Width) then
        frmCalendar.Width := Screen.Width - 200 - (200 - ScreenRatio)
      else
        frmCalendar.Width := I;

      /// height
      TryStrToInt(Field(Separ, S, 4), I);
      if (I < 1) or (I > Screen.Height) then
        frmCalendar.Height := Screen.Height - 200 - (200 - ScreenRatio)
      else
        frmCalendar.Height := I;

      // left
      TryStrToInt(Field(Separ, S, 1), I);
      if (I < 0) or (I > Screen.Width) then
        frmCalendar.left := (Screen.Width - frmCalendar.Width) div 2
      else
        frmCalendar.Left := I;

      // top
      TryStrToInt(Field(Separ, S, 2), I);
      if (I < 0) or (I > Screen.Height) then
        frmCalendar.Top := ((Screen.Height - frmCalendar.Height) div 2) - 75
      else
        frmCalendar.Top := I;

      // detail panel
      TryStrToInt(Field(Separ, S, 5), I);
      if (I < 150) or (I > 400) then
        frmCalendar.pnlLeft.Width := 250
      else
        frmCalendar.pnlLeft.Width := I;
    end;
  finally
    INI.Free
  end;
  // ********************************************************************
  // FORM SIZE END
  // ********************************************************************

  // btnEdit
  btnEdit.Enabled := VST.SelectedCount = 1;
  actEdit.Enabled := VST.SelectedCount = 1;

  // btnDelete
  btnDelete.Enabled := VST.SelectedCount > 0;
  actDelete.Enabled := VST.SelectedCount > 0;

  pnlCurrency.Tag := 0;
  pnlCurrencyCaptionClick(pnlCurrencyCaption);
  pnlAccount.Tag := 0;
  pnlAccountCaptionClick(pnlAccountCaption);
  CalendarMonthChange(Calendar);
  btnCurrencies.Enabled := frmMain.Conn.Connected = True;
  btnAccounts.Enabled := frmMain.Conn.Connected = True;
end;

procedure TfrmCalendar.pnlAccountCaptionClick(Sender: TObject);
begin
  pnlAccount.Tag := 1 - pnlAccount.Tag;
  cbxAccount.Visible := pnlAccount.Tag = 1;
  btnAccounts.Visible := pnlAccount.Tag = 1;
  frmMain.imgArrows.GetBitmap(pnlAccount.Tag, imgAccount.Picture.Bitmap);
end;

procedure TfrmCalendar.ClickPanel(Sender: TObject);
begin
  if (Sender as TPanel).Hint = '' then Exit;
  tabCalendar.TabIndex := 1;
  Calendar.Date := StrToDate(LeftStr((Sender as TPanel).Hint, 10), 'YYYY-MM-DD', '-');
  pnlCalendarCaption.Caption := DateToStr(Calendar.Date);
  CalendarDateChange(Calendar);
end;

procedure TfrmCalendar.PaintPanel(Sender: TObject);
var
  slDay: TStringList;
  I: byte;
  L, T: integer;   // Left, Top
  S: string;
  A: double;
  B: TBitmap;
begin
  try
    slDay := TStringList.Create;
    slDay.Text := (Sender as TPanel).Hint;

    // Date
    (Sender as TPanel).Canvas.Font.Size := (Sender as TPanel).Height div 3;
    (Sender as TPanel).Canvas.Font.Bold := True;

    case (Sender as TPanel).Color of
      clWhite: (Sender as TPanel).Canvas.Font.Color := rgbToColor(220, 220, 220)
      else
        (Sender as TPanel).Canvas.Font.Color := Brighten(BrightenColor, 190);
    end;
    (Sender as TPanel).Canvas.Brush.Style := bsClear;
    (Sender as TPanel).Canvas.TextOut(5, 5, RightStr(slDay.Strings[0], 2));

    // AMOUNTS
    if slDay.Count > 1 then
      (Sender as TPanel).Canvas.Font.Bold := False;
    (Sender as TPanel).Canvas.Font.Size := (Sender as TPanel).Height div 9;

    case (Sender as TPanel).Color of
      clWhite: (Sender as TPanel).Canvas.Font.Color := rgbToColor(100, 100, 100);
      else
        (Sender as TPanel).Canvas.Font.Color := clBlack;
    end;

    for I := 1 to slDay.Count - 1 do
    begin
      // ----------------------------------------------------------------
      // Amounts

      TryStrToFloat(Field(Separ, slDay.Strings[I], 2), A);
      (Sender as TPanel).Canvas.Font.Bold := I = slDay.Count - 1;
      S := Format('%n', [A], FS_own);
      L := (Sender as TPanel).Width - (Sender as TPanel).Canvas.TextWidth(S) - 27;
      T := ((Sender as TPanel).Height div 5 - 3) * (5 - slDay.Count + I);
      (Sender as TPanel).Canvas.TextOut(L, T, S);

      // ----------------------------------------------------------------
      // image
      B := TBitmap.Create;
      if I < slDay.Count - 1 then
        frmMain.imgTypes.GetBitmap(StrToInt(Field(Separ, slDay.Strings[I], 1)), B)
      else
        frmMain.imgSize.GetBitmap(9, B);
      (Sender as TPanel).Canvas.Draw(
        (Sender as TPanel).Width - 20,
        T + (Sender as TPanel).Height div 40 + 5, B);
      B.Free;
      // ----------------------------------------------------------------

    end;
  finally
    slDay.Free;
  end;
end;

procedure TfrmCalendar.pnlClientResize(Sender: TObject);
var
  I: byte;
  H, W: word;
begin
  try
    H := (pnlDays.Height - Round(20 * (ScreenRatio / 100))) div 6; // day height
    W := (pnlDays.Width - Round(25 * (ScreenRatio / 100))) div 7; // day width

    pnlDays.Visible := False;
    // days captions (monday..sunday)
    for I := 0 to 6 do
    begin
      Week_day[I].Width := W;
      Week_day[I].Left := Round(25 * (ScreenRatio / 100)) + (I * Week_day[I].Width);
    end;

    // weeks numbers (1..52)
    for I := 0 to 5 do
    begin
      Week_number[I].Height := H;
      Week_number[I].Top := Round(20 * (ScreenRatio / 100)) +
        (I * Week_number[I].Height);
    end;

    // days in calendar
    for I := 0 to 41 do
    begin
      pnlDay[I].Height := H;
      pnlDay[I].Top := Round(20 * (ScreenRatio / 100)) + ((I div 7) * H);
      pnlDay[I].Width := W;
      pnlDay[I].Left := Round(25 * (ScreenRatio / 100)) + ((I mod 7) * W);
      pnlDay[I].OnPaint := @PaintPanel;
      pnlDay[I].OnClick := @ClickPanel;
    end;
    pnlDays.Visible := True;

  finally
  end;
end;

procedure TfrmCalendar.pnlCurrencyCaptionClick(Sender: TObject);
begin
  pnlCurrency.Tag := 1 - pnlCurrency.Tag;
  cbxCurrency.Visible := pnlCurrency.Tag = 1;
  btnCurrencies.Visible := pnlCurrency.Tag = 1;
  frmMain.imgArrows.GetBitmap(pnlCurrency.Tag, imgCurrency.Picture.Bitmap);
end;

procedure TfrmCalendar.pnlMonthYearCaptionClick(Sender: TObject);
begin
  pnlMonthYearCaption.Tag := 1 - pnlMonthYearCaption.Tag;
  Calendar.Visible := pnlMonthYearCaption.Tag = 1;
  frmMain.imgArrows.GetBitmap(pnlMonthYearCaption.Tag, imgMonthYear.Picture.Bitmap);
end;

procedure TfrmCalendar.splCalendarCanResize(Sender: TObject;
  var NewSize: integer; var Accept: boolean);
begin

  try
    imgWidth.ImageIndex := 3;
    lblWidth.Caption := IntToStr(pnlLeft.Width);

    imgHeight.ImageIndex := 2;
    lblHeight.Caption := IntToStr(frmMain.Width - pnlLeft.Width);

    pnlCalendarCaption.Repaint;
    pnlFilterCaption.Repaint;
    pnlSummaryCaption.Repaint;
    pnlTotalMonthYear.Repaint;
    btnExit.Repaint;
    Calendar.Repaint;
  finally
  end;
end;

procedure TfrmCalendar.tabCalendarChange(Sender: TObject);
begin
  pnlButtons.Visible := tabCalendar.TabIndex = 1;
  if tabCalendar.TabIndex = 1 then
    VSTFloat.Visible := False;

  case tabCalendar.TabIndex of
    0: begin
      pnlCalendarCaption.Caption :=
        AnsiUpperCase(DefaultFormatSettings.LongMonthNames[MonthOf(Calendar.Date)]) +
        '   ' + IntToStr(YearOf(Calendar.Date));
      CalendarMonthChange(Calendar);
    end
    else
    begin
      CalendarDateChange(Calendar);
    end;
  end;
end;

procedure TfrmCalendar.VSTBeforeCellPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
begin
  TargetCanvas.Brush.Color := IfThen(Node.Index mod 2 = 0, clWhite,
    frmSettings.pnlOddRowColor.Color);
  TargetCanvas.FillRect(CellRect);
end;

procedure TfrmCalendar.VSTChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
begin
  btnEdit.Enabled := VST.SelectedCount > 0;
  btnDelete.Enabled := VST.SelectedCount > 0;
  actEdit.Enabled := VST.SelectedCount > 0;
  actDelete.Enabled := VST.SelectedCount > 0;
end;

procedure TfrmCalendar.VSTDblClick(Sender: TObject);
begin
  if (frmMain.Conn.Connected = False) or (VST.SelectedCount <> 1) then Exit;

  if VST.SelectedCount > 0 then
    btnEditClick(btnEdit);
end;

procedure TfrmCalendar.VSTFloatGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  DailyPayment: PDailyPayment;
begin
  DailyPayment := Sender.GetNodeData(Node);

  case Column of
    1: CellText := Format('%n', [DailyPayment.Amount], FS_own); // sum
    2: CellText := DailyPayment.currency; // currency
    3: CellText := DailyPayment.Comment; // comment
  end;
end;

procedure TfrmCalendar.VSTFloatResize(Sender: TObject);
begin
  (Sender as TLazVirtualStringTree).Header.Columns[0].Width :=
    round(ScreenRatio * 25 / 100);
end;

procedure TfrmCalendar.VSTGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: boolean; var ImageIndex: integer);
var
  DailyPayment: PDailyPayment;
begin
  DailyPayment := Sender.GetNodeData(Node);
  if Column = 0 then
    ImageIndex := DailyPayment.Kind;
end;

procedure TfrmCalendar.VSTGetNodeDataSize(Sender: TBaseVirtualTree;
  var NodeDataSize: integer);
begin
  NodeDataSize := SizeOf(TDailyPayment);
end;

procedure TfrmCalendar.VSTGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
var
  DailyPayment: PDailyPayment;
  B: byte;
begin
  DailyPayment := Sender.GetNodeData(Node);

  case Column of
    1: begin
      B := DayOfTheWeek(StrToDate(DailyPayment.Date, 'YYYY-MM-DD', '-')) + 1;
      if B = 8 then
        B := 1;
      CellText := FS_own.ShortDayNames[B] + ' ' +
        DateToStr(StrToDate(DailyPayment.Date, 'YYYY-MM-DD', '-'), FS_own);
    end;
    2: begin // periodicity
      if DailyPayment.Periodicity < 0 then
        CellText := AnsiReplaceStr(frmScheduler.cbxPeriodicity.Items[1],
          'X', IntToStr(ABS(DailyPayment.Periodicity)))
      else
        CellText := frmScheduler.cbxPeriodicity.Items[DailyPayment.Periodicity];
    end;
    3: CellText := Format('%n', [DailyPayment.Amount], FS_own); // sum
    4: CellText := DailyPayment.currency; // currency
    5: CellText := DailyPayment.Comment; // comment
    6: CellText := IntToStr(DailyPayment.ID); // ID
  end;
end;

procedure TfrmCalendar.VSTPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
var
  DP: PDailyPayment;
begin
  TargetCanvas.Font.Bold := (Column = 3) and
    (frmSettings.chkDisplayFontBold.Checked = True);
  if vsSelected in node.States then exit;

  DP := Sender.GetNodeData(Node);
  case DP.Kind of

    // credit color
    0: case frmSettings.pnlCreditTransactionsColor.Tag of
        0: TargetCanvas.Font.Color := clDefault;
        1: begin
          if Column = 3 then
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
          if Column = 3 then
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
          if Column = 3 then
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
          if Column = 3 then
            TargetCanvas.Font.Color := rgbToColor(240, 160, 0)
          else
            TargetCanvas.Font.Color := clDefault;
        end
        else
          TargetCanvas.Font.Color := rgbToColor(240, 160, 0);
      end;
  end;
end;

procedure TfrmCalendar.VSTResize(Sender: TObject);
var
  X: integer;
begin
  if frmSettings.chkAutoColumnWidth.Checked = False then Exit;

  (Sender as TLazVirtualStringTree).Header.Columns[0].Width :=
    round(ScreenRatio * 25 / 100);
  X := (VST.Width - VST.Header.Columns[0].Width) div 100;

  VST.Header.Columns[1].Width := 15 * X; // date
  VST.Header.Columns[2].Width := 20 * X; // periodicity
  VST.Header.Columns[3].Width := 15 * X; // amount
  VST.Header.Columns[4].Width := 8 * X; // currency
  VST.Header.Columns[5].Width := VST.Width - 20 - VST.Header.Columns[0].Width - (66 * X);
  // comment
  VST.Header.Columns[6].Width := 8 * X; // ID
end;

procedure TfrmCalendar.actExitExecute(Sender: TObject);
begin
  frmCalendar.Close;
end;

procedure TfrmCalendar.btnAccountsClick(Sender: TObject);
begin
  if btnAccounts.Enabled = False then
    Exit;

  frmAccounts.ShowModal;
  cbxCurrencyChange(cbxCurrency);
  cbxAccount.SetFocus;
end;

procedure TfrmCalendar.btnExitClick(Sender: TObject);
begin
  frmCalendar.ModalResult := mrCancel;
end;

procedure TfrmCalendar.btnCurrenciesClick(Sender: TObject);
begin
  if btnCurrencies.Enabled = False then
    Exit;

  frmCurrencies.ShowModal;
  cbxCurrency.SetFocus;
end;

procedure TfrmCalendar.btnDeleteClick(Sender: TObject);
var
  N: PVirtualNode;
  IDs: string;
begin
  if (frmMain.Conn.Connected = False) or (VST.RootNodeCount = 0) or
    (VST.SelectedCount = 0) then
    exit;

  // get IDs of all selected nodes
  IDs := '';
  N := VST.GetFirstSelected(False);
  try
    while Assigned(N) do
    begin
      IDs := IDs + VST.Text[N, 7] + ',';
      N := VST.GetNextSelected(N);
    end;
  finally
    IDs := LeftStr(IDs, Length(IDs) - 1);
  end;

  //===============================================================================================
  //delete one item only
  if VST.SelectedCount = 1 then
  begin
    if MessageDlg(Message_00, Question_01 + sLineBreak + sLineBreak +
      VST.Header.Columns[1].Text + ': ' + VST.Text[VST.FocusedNode, 1] +
      sLineBreak + // date
      VST.Header.Columns[2].Text + ': ' + VST.Text[VST.FocusedNode, 2] +
      sLineBreak + VST.Header.Columns[3].Text + ': ' + VST.Text[VST.FocusedNode, 3] +
      '  ' + VST.Text[VST.FocusedNode, 4], mtConfirmation, mbYesNo, 0) <> 6 then
      Exit;


    //  // ===============================================================================================
    // delete multiple items
  end
  else
  begin
    if MessageDlg(Message_00, ReplaceStr(Question_02, '%', IntToStr(VST.SelectedCount)),
      mtConfirmation, mbYesNo, 0) <> 6 then
      Exit;
  end;

  if MessageDlg(Message_00, Format(Question_17, [sLineBreak]),
    mtConfirmation, mbYesNo, 0) <> 6 then
    Exit;

  frmMain.QRY.SQL.Text := 'DELETE FROM payments WHERE pay_id IN (' + IDs + ');';
  frmMain.QRY.ExecSQL;
  frmMain.Tran.Commit;

  Vacuum;
  CalendarDateChange(Calendar);
  if (frmSchedulers.Visible = True) and (frmSchedulers.VST.SelectedCount = 1) then
    frmSchedulers.VSTChange(frmSchedulers.VST, frmSchedulers.VST.GetFirstSelected());
end;

procedure TfrmCalendar.btnEditClick(Sender: TObject);
var
  ID: integer;
  DailyPayment: PDailyPayment;
begin
  case VST.SelectedCount of
    0: Exit;
    1: begin
      frmEdit.Tag := 7;
      DailyPayment := VST.GetNodeData(VST.GetFirstSelected());
      ID := DailyPayment.ID;
      if frmEdit.ShowModal <> mrOk then
        Exit;
    end
    else
    begin
      frmEdits.Tag := 7;
      ID := 0;
      frmEdits.btnResetClick(frmEdits.btnReset);
      if frmEdits.ShowModal <> mrOk then
        Exit;
    end;
  end;

  CalendarDateChange(Calendar);

  if ID > 0 then
    FindEditedRecord(VST, 6, ID);
  VST.SetFocus;
end;

procedure TfrmCalendar.CalendarDateChange(Sender: TObject);
var
  DailyPayment: PDailyPayment;
  P: PVirtualNode;
begin
  pnlButtons.Visible := tabCalendar.TabIndex = 1;
  if tabCalendar.TabIndex = 1 then
    pnlCalendarCaption.Caption := DateToStr(Calendar.Date);

  if (Yearof(CalendarDay) <> YearOf(Calendar.Date)) then
    CalendarMonthChange(Calendar);

  if (frmCalendar.Visible = False) or (cbxAccount.ItemIndex = -1) or
    (frmMain.Conn.Connected = False) then
    Exit;

  if cbxCurrency.ItemIndex = -1 then
    Exit;

  Screen.Cursor := crHourGlass;
  VST.BeginUpdate;
  VSTFloat.BeginUpdate;

  try
    frmMain.QRY.SQL.Text := 'SELECT pay_date_plan,  ' +
      '(SELECT sch_period FROM scheduler WHERE sch_id = pay_sch_id), ' + // periodicity
      'pay_sum, ' + // payment
      '(SELECT acc_currency FROM ACCOUNTS WHERE acc_id = pay_account) as currency, ' +
      // currency
      'pay_comment, pay_type, pay_id ' + sLineBreak + // comment
      'FROM payments ' + sLineBreak + // from
      'WHERE pay_date_paid IS NULL AND pay_date_plan = :DATE ' + sLineBreak + // where
      'AND currency = :CURRENCY1 ' + sLineBreak +
      IfThen(cbxAccount.ItemIndex > 0, ' AND pay_account = ' +
      '(SELECT acc_id FROM ACCOUNTS WHERE acc_name = :ACCOUNT AND acc_currency = :CURRENCY2) ',
      '') + sLineBreak + 'ORDER BY pay_type;';

    frmMain.QRY.Params.ParamByName('DATE').AsString :=
      IfThen(tabCalendar.TabIndex = 1, FormatDateTime('YYYY-MM-DD', Calendar.Date),
      pnlDays.Hint);

    frmMain.QRY.Params.ParamByName('CURRENCY1').AsString :=
      Field(separ_1, cbxCurrency.Items[cbxCurrency.ItemIndex], 1);

    if cbxAccount.ItemIndex > 0 then
    begin
      frmMain.QRY.Params.ParamByName('ACCOUNT').AsString :=
        Field(separ_1, cbxAccount.Items[cbxAccount.ItemIndex], 1);
      frmMain.QRY.Params.ParamByName('CURRENCY2').AsString :=
        Field(separ_1, cbxAccount.Items[cbxAccount.ItemIndex], 2);
    end;

    try
      // SQL
      VST.Clear;
      VST.RootNodeCount := 0;
      VSTFloat.Clear;
      VSTFloat.RootNodeCount := 0;
    finally
    end;

    frmMain.QRY.Prepare;
    frmMain.QRY.Open;
    while not frmMain.QRY.EOF do
    begin
      if tabCalendar.TabIndex = 1 then
      begin
        VST.RootNodeCount := VST.RootNodeCount + 1;
        P := VST.GetLast();
        DailyPayment := VST.GetNodeData(P);
        DailyPayment.Date := frmMain.QRY.Fields[0].AsString;
        DailyPayment.Periodicity := frmMain.QRY.Fields[1].AsInteger;
        TryStrToFloat(frmMain.QRY.Fields[2].AsString, DailyPayment.Amount);
        DailyPayment.currency := frmMain.QRY.Fields[3].AsString;
        DailyPayment.Comment := frmMain.QRY.Fields[4].AsString;
        DailyPayment.Kind := frmMain.QRY.Fields[5].AsInteger;
        DailyPayment.ID := frmMain.QRY.Fields[6].AsInteger;
      end;

      if tabCalendar.TabIndex = 0 then
      begin
        VSTFloat.RootNodeCount := VSTFloat.RootNodeCount + 1;
        P := VSTFloat.GetLast();
        DailyPayment := VSTFloat.GetNodeData(P);
        TryStrToFloat(frmMain.QRY.Fields[2].AsString, DailyPayment.Amount);
        DailyPayment.currency := frmMain.QRY.Fields[3].AsString;
        DailyPayment.Comment := frmMain.QRY.Fields[4].AsString;
        DailyPayment.Kind := frmMain.QRY.Fields[5].AsInteger;
      end;

      frmMain.QRY.Next;
    end;

  finally
    frmMain.QRY.Close;

    SetNodeHeight(VST);
    VST.EndUpdate;
    VSTFloat.EndUpdate;
    Screen.Cursor := crDefault;
  end;

  btnEdit.Enabled := False;
  btnDelete.Enabled := False;
  CalendarDay := Calendar.Date;
end;

procedure TfrmCalendar.CalendarMonthChange(Sender: TObject);
var
  I: byte;
  M, Y, W: integer;
  A, B: double;
  D1, D2: TDateTime; // First day of the calendar
begin
  if (frmCalendar.Visible = False) then
    Exit;

  pnlClient.Visible := False;
  M := MonthOf(Calendar.Date);
  Y := YearOf(Calendar.Date);
  if tabCalendar.TabIndex = 0 then
    pnlCalendarCaption.Caption :=
      AnsiUpperCase(DefaultFormatSettings.LongMonthNames[M]) + '   ' + IntToStr(Y);
  pnlTotalMonthYear.Caption :=
    AnsiUpperCase(DefaultFormatSettings.LongMonthNames[M]) + '   ' + IntToStr(Y);

  D1 := EncodeDate(Y, M, 1);
  W := WeekOf(D1);

  D1 := StartOfAWeek(IfThen((M = 1) and (W > 10), Y - 1, Y), W);

  for I := 0 to 6 do
    Week_day[I].Caption := AnsiLowerCase(
      DefaultFormatSettings.LongDayNames[DayOfWeek(D1 + I)]);

  for I := 0 to 41 do
  begin
    if I mod 7 = 0 then
      Week_number[I div 7].Caption := IntToStr(WeekOf(D1 + I)) + '.';

    D2 := D1 + I;
    pnlDay[I].Hint := FormatDateTime('YYYY-MM-DD', D2);

    if MonthOf(D1 + I) = M then
    begin
      pnlDay[I].Color := BrightenColor;
    end
    else
    begin
      pnlDay[I].Color := clWhite;
    end;

    if (frmMain.Conn.Connected = True) and (cbxCurrency.Items.Count > 0) then
    begin

      B := 0.0;

      // ============================================================================================
      // ENUMERATION
      // ============================================================================================

      frmMain.QRY.SQL.Text := 'SELECT pay_type, TOTAL(pay_sum) as total, ' + // select
        '(SELECT acc_currency FROM accounts WHERE acc_id = pay_account) as currency ' +
        'FROM payments ' + sLineBreak + // from
        'WHERE pay_date_paid IS NULL AND pay_date_plan = :DATE ' + // where
        'AND currency = :CURRENCY1 ' + sLineBreak +
        IfThen(cbxAccount.ItemIndex = 0, '', ' AND pay_account = ' +
        '(SELECT acc_id FROM ACCOUNTS WHERE acc_name = :ACCOUNT AND ' +
        'acc_currency = :CURRENCY2) ') + 'GROUP BY currency, pay_type;'; // group

      // ShowMessage (frmMain.QRY.SQL.Text);

      // Get date
      frmMain.QRY.Params.ParamByName('DATE').AsString :=
        FormatDateTime('YYYY-MM-DD', D2);

      // Get account
      if cbxAccount.ItemIndex > 0 then
        frmMain.QRY.Params.ParamByName('ACCOUNT').AsString :=
          Field(separ_1, cbxAccount.Items[cbxAccount.ItemIndex], 1);


      {If (cbxCurrency.Items.Count = 0) or (cbxCurrency.Itemindex = -1) then
      frmMain.QRY.Params.ParamByName('CURRENCY').AsString :=  'EUR'
      Else}
      frmMain.QRY.Params.ParamByName('CURRENCY1').AsString :=
        Field(separ_1, cbxCurrency.Items[cbxCurrency.ItemIndex], 1);

      if cbxAccount.ItemIndex > 0 then
        frmMain.QRY.Params.ParamByName('CURRENCY2').AsString :=
          Field(separ_1, cbxAccount.Items[cbxAccount.ItemIndex], 2);

      frmMain.QRY.Open;

      while not frmMain.QRY.EOF do
      begin
        A := frmMain.QRY.FieldByName('total').AsFloat;
        B := B + A;
        pnlDay[I].Hint := pnlDay[I].Hint + sLineBreak +
          frmMain.QRY.FieldByName('pay_type').AsString + separ + FloatToStr(A);
        frmMain.QRY.Next;
      end;
      frmMain.QRY.Close;
      if Length(pnlDay[I].Hint) > 10 then
        pnlDay[I].Hint := pnlDay[I].Hint + sLineBreak + 'T' + separ + FloatToStr(B);
    end;
  end;

  pnlClient.Visible := True;

  B := 0.0;
  lblCredit1.Caption := Format('%n', [B], FS_own);
  lblDebit1.Caption := Format('%n', [B], FS_own);
  lblTransferPlus1.Caption := Format('%n', [B], FS_own);
  lblTransferMinus1.Caption := Format('%n', [B], FS_own);
  lblTotal1.Caption := Format('%n', [B], FS_own);

  if frmMain.Conn.Connected = False then Exit;

  // =============================================================================
  // TOTAL ENUMERATION
  // =============================================================================

  frmMain.QRY.SQL.Text := 'SELECT pay_type, TOTAL(pay_sum) as total, ' + // select
    '(SELECT acc_currency FROM accounts WHERE acc_id = pay_account) as currency ' +
    'FROM payments ' + sLineBreak + // from
    'WHERE pay_date_paid IS NULL AND pay_date_plan LIKE "' +
    FormatDateTime('YYYY-MM%', Calendar.Date) + // where
    '" AND currency = :CURRENCY ' + sLineBreak + 'GROUP BY currency, pay_type;';

  //ShowMessage (frmMain.QRY.SQL.Text);

  if (cbxCurrency.Items.Count = 0) or (cbxCurrency.ItemIndex = -1) then
    frmMain.QRY.Params.ParamByName('CURRENCY').AsString := 'EUR'
  else
    frmMain.QRY.Params.ParamByName('CURRENCY').AsString :=
      Field(separ_1, cbxCurrency.Items[cbxCurrency.ItemIndex], 1);

  frmMain.QRY.Open;
  while not frmMain.QRY.EOF do
  begin
    A := frmMain.QRY.FieldByName('total').AsFloat;
    B := B + A;
    case frmMain.QRY.FieldByName('pay_type').AsInteger of
      0: lblCredit1.Caption := Format('%n', [A], FS_own);
      1: lblDebit1.Caption := Format('%n', [A], FS_own);
      2: lblTransferPlus1.Caption := Format('%n', [A], FS_own)
      else
        lblTransferMinus1.Caption := Format('%n', [A], FS_own);
    end;
    lblTotal1.Caption := Format('%n', [B], FS_own);
    frmMain.QRY.Next;
  end;
  frmMain.QRY.Close;
end;

procedure TfrmCalendar.cbxAccountChange(Sender: TObject);
begin
  if tabCalendar.TabIndex = 0 then
    CalendarMonthChange(Calendar)
  else
    CalendarDateChange(Calendar);
end;

procedure TfrmCalendar.cbxCurrencyChange(Sender: TObject);
begin
  cbxAccount.Clear;

  if (frmMain.Conn.Connected = False) then
  begin
    cbxAccount.Items.Add('*');
    cbxAccount.ItemIndex := 0;
    exit;
  end;

  // update list of accounts in the filter
  frmMain.QRY.SQL.Text :=
    'SELECT acc_name, acc_currency FROM currencies ' +
    'LEFT JOIN accounts ON (acc_currency = cur_code) ' +
    'WHERE acc_status < 2 AND cur_status < 2 AND acc_currency = :CURRENCY;';
  frmMain.QRY.Params.ParamByName('CURRENCY').AsString :=
    Field(separ_1, cbxCurrency.Items[cbxCurrency.ItemIndex], 1);

  frmMain.QRY.Open;
  frmMain.QRY.Last;

  if frmMain.QRY.RecordCount > 0 then
  begin
    frmMain.QRY.First;
    while not (frmMain.QRY.EOF) do
    begin
      cbxAccount.Items.Add(
        frmMain.QRY.FieldByName('acc_name').AsString + separ_1 +
        frmMain.QRY.FieldByName('acc_currency').AsString);
      frmMain.QRY.Next;
    end;
  end;
  frmMain.QRY.Close;

  cbxAccount.Items.Insert(0, '*');
  cbxAccount.ItemIndex := 0;

  if tabCalendar.TabIndex = 0 then
    CalendarMonthChange(Calendar)
  else
    CalendarDateChange(Calendar);
end;

procedure TfrmCalendar.cbxCurrencyDropDown(Sender: TObject);
begin
  {$IFDEF WINDOWS}
    ComboDDWidth(TComboBox(Sender));
  {$ENDIF}
end;

procedure TfrmCalendar.FormClose(Sender: TObject; var CloseAction: TCloseAction);
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
      if INI.ReadString('POSITION', frmCalendar.Name, '') <>
        IntToStr(frmCalendar.Left) + separ + // form left
      IntToStr(frmCalendar.Top) + separ + // form top
      IntToStr(frmCalendar.Width) + separ + // form width
      IntToStr(frmCalendar.Height) + separ + // form height
      IntToStr(frmCalendar.pnlLeft.Width) then
        INI.WriteString('POSITION', frmCalendar.Name,
          IntToStr(frmCalendar.Left) + separ + // form left
          IntToStr(frmCalendar.Top) + separ + // form top
          IntToStr(frmCalendar.Width) + separ + // form width
          IntToStr(frmCalendar.Height) + separ + // form height
          IntToStr(frmCalendar.pnlLeft.Width));
    finally
      INI.Free;
    end;
  end;
end;

procedure TfrmCalendar.ShowDailyPayments(Sender: TObject; Shift: TShiftState;
  X, Y: integer);
begin

  if Pos(sLineBreak, (Sender as TPanel).Hint) = 0 then
  begin
    VSTFloat.Visible := False;
    Exit;
  end;

  try
    // set left position
    VSTFloat.Left := pnlClient.Left + tabCalendar.Left + pnlDays.Left +
      (Sender as TPanel).Left + X + 30 - IfThen(
      (Sender as TPanel).Left > pnlDays.Width div 2, VSTFloat.Width + 40, 0);

    // set top position
    VSTFloat.Top := pnlClient.Top + tabCalendar.Top + pnlDays.Top +
      (Sender as TPanel).Top + Y + 30 - IfThen(
      (Sender as TPanel).Top > pnlDays.Height div 2, VSTFloat.Height, 0);

    // show component
    if VSTFloat.Visible = True then Exit;

    // set columns width
    VSTFloat.Header.AutoFitColumns(False, smaAllColumns, 1, 3);
    VSTFloat.Header.Columns[0].Width := round(ScreenRatio * 25 / 100);

    // set component width
    VSTFloat.Width :=
      VSTFloat.Header.Columns[0].Width + VSTFloat.Header.Columns[1].Width +
      VSTFloat.Header.Columns[2].Width + VSTFloat.Header.Columns[3].Width + 4;

    VSTFloat.Visible := True;

  finally
  end;
end;

procedure TfrmCalendar.HideDailyPayments(Sender: TObject);
begin
  try
    if VSTFloat.Visible = True then
    begin
      VSTFloat.Visible := False;
      pnlDays.Hint := '';
    end;
  finally
  end;
end;

procedure TfrmCalendar.ReadDailyPayments(Sender: TObject);
begin
  pnlDays.Hint := LeftStr((Sender as TPanel).Hint, 10);

  CalendarDateChange(Calendar);
  if VSTFloat.RootNodeCount = 0 then
    Exit;

  // set node height
  SetNodeHeight(VSTFloat);

  // set component height
  VSTFloat.Height := (VSTFloat.RootNodeCount) *
    VSTFloat.NodeHeight[VSTFloat.GetFirst()] + VSTFloat.Header.Height + 4;

end;

end.
