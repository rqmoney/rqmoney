unit uniHistory;

{$mode objfpc}{$H+}
{$ModeSwitch AutoDeref}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, ComCtrls, StrUtils,
  ActnList, StdCtrls, BCPanel, BCMDButtonFocus, LazUTF8, laz.VirtualTrees, Math;

type

  { TfrmHistory }

  TfrmHistory = class(TForm)
    actExit: TAction;
    ActionList1: TActionList;
    btnCancel: TBCMDButtonFocus;
    imgHeight: TImage;
    imgWidth: TImage;
    lblHeight: TLabel;
    lblWidth: TLabel;
    pnlBottom: TPanel;
    pnlHeight: TPanel;
    pnlTop: TPanel;
    pnlList: TPanel;
    pnlHistoryCaption: TBCPanel;
    pnlOriginalCaption: TBCPanel;
    pnlButtons: TPanel;
    pnlWidth: TPanel;
    Splitter1: TSplitter;
    VST1: TLazVirtualStringTree;
    VST2: TLazVirtualStringTree;
    procedure actExitExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure pnlButtonsResize(Sender: TObject);
    procedure VST1BeforeCellPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
    procedure VST1GetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Kind: TVTImageKind; Column: TColumnIndex; var Ghosted: Boolean;
      var ImageIndex: Integer);
    procedure VST1GetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure VST1Resize(Sender: TObject);
    procedure VST2BeforeCellPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
    procedure VST2GetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Kind: TVTImageKind; Column: TColumnIndex; var Ghosted: Boolean;
      var ImageIndex: Integer);
    procedure VST2GetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
  private

  public

  end;

var
  frmHistory: TfrmHistory;

  slHistory, slOriginal: TStringList;

implementation

{$R *.lfm}

uses
  uniMain, uniSettings;

{ TfrmHistory }

procedure TfrmHistory.FormCreate(Sender: TObject);
begin
  slHistory := TStringList.Create();
  slOriginal := TStringList.Create();

  VST1.Images := frmMain.ImgTypes;
  VST2.Images := frmMain.ImgTypes;

  // set components height
  VST1.Header.Height := ProgramFontSize + 4;
  if VST1.Header.Height < 20 then
    VST1.Header.Height := 20;

  VST2.Header.Height := ProgramFontSize + 4;
  if VST2.Header.Height < 20 then
    VST2.Header.Height := 20;

  pnlOriginalCaption.Height := ProgramFontSize + 4;
  pnlHistoryCaption.Height := ProgramFontSize + 4;

  pnlButtons.Height := ProgramFontSize + 4;
  pnlBottom.Height := ProgramFontSize + 4;

end;

procedure TfrmHistory.FormDestroy(Sender: TObject);
begin
  slHistory.Free;
  slOriginal.Free;
end;

procedure TfrmHistory.FormResize(Sender: TObject);
begin
  frmMain.imgSize.GetBitmap(0, imgWidth.Picture.Bitmap);
  lblWidth.Caption := IntToStr((Sender as TForm).Width);
  frmMain.imgSize.GetBitmap(1, imgHeight.Picture.Bitmap);
  lblHeight.Caption := IntToStr((Sender as TForm).Height);

  pnlOriginalCaption.Repaint;
  pnlHistoryCaption.Repaint;
end;

procedure TfrmHistory.FormShow(Sender: TObject);
begin
  pnlTop.Height := (5 * ProgramFontSize);

  slOriginal.Clear;
  VST1.Clear;

  slHistory.Clear;
  VST2.Clear;

  try
    // ========================================================================
    // get values from table HISTORY
    frmMain.QRY.SQL.Text :=
      'SELECT his_date, Round(his_sum, 2) as his_sum, his_changed, his_comment, ' +
      'acc_currency, acc_name, per_name, pee_name, cat_parent_id, cat_parent_name, ' +
      'cat_name, his_type, his_id, his_d_id ' + // data
      'FROM history ' + // FROM
      'LEFT JOIN ' + sLineBreak +// JOIN
      'accounts ON (acc_id = his_account), ' + sLineBreak +// accounts
      'categories ON (cat_id = his_category), ' + sLineBreak +// categories
      'persons ON (per_id = his_person), ' + sLineBreak +// categories
      'payees ON (pee_id = his_payee) ' + sLineBreak +// categories
      'WHERE his_d_id = :ID ' + // where
      'ORDER BY his_id;';

    frmMain.QRY.Params.ParamByName('ID').AsString :=
      frmMain.VST.Text[frmMain.VST.GetFirstSelected(), 10];
    frmMain.QRY.Prepare;
    frmMain.QRY.Open;

    while not (frmMain.QRY.EOF) do
    begin
      slHistory.Add(
        frmMain.QRY.FieldByName('his_date').AsString + separ + // date  1
        frmMain.QRY.FieldByName('his_comment').AsString + separ + // comment 2
        frmMain.QRY.FieldByName('his_sum').AsString + separ + // amount 3
        frmMain.QRY.FieldByName('acc_currency').AsString + separ + // currency 4
        frmMain.QRY.FieldByName('acc_name').AsString + separ + // account 5
        frmMain.QRY.FieldByName('cat_parent_name').AsString + separ + // 6
        frmMain.QRY.FieldByName('cat_name').AsString + separ + // category name 7
        frmMain.QRY.FieldByName('per_name').AsString + separ + // person 8
        frmMain.QRY.FieldByName('pee_name').AsString + separ + // payee 9
        frmMain.QRY.FieldByName('his_changed').AsString + separ + // time 10
        frmMain.QRY.FieldByName('his_d_id').AsString + separ + // ID 11
        frmMain.QRY.FieldByName('his_type').AsString + separ +   // type 12
        frmMain.QRY.FieldByName('cat_parent_ID').AsString); // 13

      frmMain.QRY.Next;
    end;
    frmMain.QRY.Close;

    // ========================================================================
    // get values from table DATA
    frmMain.QRY.SQL.Text :=
      'SELECT ' + // SELECT statement
      'd_date, ' + // date
      'Round(d_sum, 2) as d_sum, ' + // sum
      'd_comment, acc_currency, acc_name, cat_parent_id, cat_parent_name, cat_name, ' +
      // fields
      'per_name, pee_name, d_time, d_id, d_type ' + sLineBreak +// other fields
      'FROM data ' + sLineBreak +// FROM table DATA
      'LEFT JOIN ' + sLineBreak +// JOIN
      'accounts ON (acc_id = d_account), ' + sLineBreak +// accounts
      'categories ON (cat_id = d_category), ' + sLineBreak +// categories
      'persons ON (per_id = d_person), ' + sLineBreak +// categories
      'payees ON (pee_id = d_payee) ' + sLineBreak +// categories
      'WHERE d_id = :ID;';

    frmMain.QRY.Params.ParamByName('ID').AsString :=
      frmMain.VST.Text[frmMain.VST.GetFirstSelected(), 10];
    frmMain.QRY.Prepare;
    frmMain.QRY.Open;

    // date 2
    slOriginal.Add(
      frmMain.QRY.FieldByName('d_date').AsString + separ + // date  1
      frmMain.QRY.FieldByName('d_comment').AsString + separ + // comment 2
      frmMain.QRY.FieldByName('d_sum').AsString + separ + // amount 3
      frmMain.QRY.FieldByName('acc_currency').AsString + separ + // currency 4
      frmMain.QRY.FieldByName('acc_name').AsString + separ + // account 5
      frmMain.QRY.FieldByName('cat_parent_name').AsString + separ + // 6
      frmMain.QRY.FieldByName('cat_name').AsString + separ + // category name 7
      frmMain.QRY.FieldByName('per_name').AsString + separ + // person 8
      frmMain.QRY.FieldByName('pee_name').AsString + separ + // payee 9
      frmMain.QRY.FieldByName('d_time').AsString + separ + // time 10
      frmMain.QRY.FieldByName('d_id').AsString + separ + // ID 11
      frmMain.QRY.FieldByName('d_type').AsString + separ +  // type 12
    frmMain.QRY.FieldByName('cat_parent_ID').AsString); // 13

    frmMain.QRY.Close;

    //showMessage ('history: ' + sLineBreak + slHistory.Text + sLineBreak + sLineBreak + 'original: ' + sLineBreak + slOriginal.Text);

    if (slHistory.Count > 0) then
    begin
      slHistory.Add(slOriginal.Strings[0]);
      slOriginal.Delete(0);
      slOriginal.Add(slHistory.Strings[0]);
      slHistory.Delete(0);
    end;

    // ===========================================================
    // GET CURRENT TRANSACTIONS
    // ===========================================================

  finally
    if slHistory.Count > 0 then
      VST2.RootNodeCount := slHistory.Count;

    if slOriginal.Count > 0 then
      VST1.RootNodeCount := slOriginal.Count;
  end;

  SetNodeHeight(frmHistory.VST1);
  SetNodeHeight(frmHistory.VST2);
end;

procedure TfrmHistory.pnlButtonsResize(Sender: TObject);
begin
  btnCancel.BorderSpacing.Left := (pnlButtons.Width - btnCancel.Width) div 2;
end;

procedure TfrmHistory.VST1BeforeCellPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
begin
    TargetCanvas.Brush.Color := IfThen(Node.Index mod 2 = 0, clWhite,
    frmSettings.pnlOddRowColor.Color);
  TargetCanvas.FillRect(CellRect);
end;

procedure TfrmHistory.VST1GetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: Integer);
begin
  If  Column = 0 then
    ImageIndex := StrToInt(Field(separ, slOriginal.Strings[Node.Index], 12));
end;

procedure TfrmHistory.VST1GetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
var
  M: integer;
  A: double;

begin
  M := Node.Index;

  case Column of
    // date
    1: CellText :=
        DateToStr(StrToDate(Field(separ, slOriginal.Strings[M], 1),
        'YYYY-MM-DD', '-'));
    // comment
    2: CellText := Field(Separ, slOriginal.Strings[M], 2);
    // amount
    3: begin
      TryStrToFloat(Field(separ, slOriginal.Strings[M], 3), A);
      CellText := Format('%n', [A], FS_own);
    end;
    // currency
    4: CellText := Field(Separ, slOriginal.Strings[M], 4);
    // account
    5: CellText := Field(Separ, slOriginal.Strings[M], 5);
    // category
    6: CellText := AnsiUpperCase(Field(separ, slOriginal.Strings[M],
        IfThen(Field(separ, slOriginal.Strings[M], 13) = '0', 7, 6)));
    // subcategory
    7: if Field(separ, slOriginal.Strings[M], 13) = '0' then
        CellText := ''
      else
        CellText := IfThen(frmSettings.chkDisplaySubCatCapital.Checked = True,
          AnsiUpperCase(Field(separ, slOriginal.Strings[M], 7)), Field(separ, slOriginal.Strings[M], 7));
    // person
    8: CellText := Field(Separ, slOriginal.Strings[M], 8);
    // payee
    9: CellText := Field(Separ, slOriginal.Strings[M], 9);
    // ID
    10: CellText := Field(Separ, slOriginal.Strings[M], 10);
    // Type
    11: CellText := Field(Separ, slOriginal.Strings[M], 12);
  end;
end;

procedure TfrmHistory.VST1Resize(Sender: TObject);
var
  X: integer;

begin
  if frmSettings.chkAutoColumnWidth.Checked = False then Exit;

  (Sender as TLazVirtualStringTree).Header.Columns[0].Width := round(Screen.PixelsPerInch div 96 * 25);
  X := ((Sender as TLazVirtualStringTree).Width - 45) div 100;

  (Sender as TLazVirtualStringTree).Header.Columns[1].Width := 10 * X; // date
  (Sender as TLazVirtualStringTree).Header.Columns[2].Width :=
    (Sender as TLazVirtualStringTree).Width - (Sender as TLazVirtualStringTree).Header.Columns[0].Width - ScrollBarWidth - (87 * X); // comment
  (Sender as TLazVirtualStringTree).Header.Columns[3].Width := 10 * X; // amount
  (Sender as TLazVirtualStringTree).Header.Columns[4].Width := 5 * X; // currency
  (Sender as TLazVirtualStringTree).Header.Columns[5].Width := 10 * X; // account
  (Sender as TLazVirtualStringTree).Header.Columns[6].Width := 10 * X; // category
  (Sender as TLazVirtualStringTree).Header.Columns[7].Width := 10 * X; // subcategory
  (Sender as TLazVirtualStringTree).Header.Columns[8].Width := 8 * X; // person
  (Sender as TLazVirtualStringTree).Header.Columns[9].Width := 8 * X; // payee
  (Sender as TLazVirtualStringTree).Header.Columns[10].Width := 16 * X; // date + time
end;

procedure TfrmHistory.VST2BeforeCellPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
begin
  TargetCanvas.Brush.Color :=
        IfThen(Node.Index mod 2 = 0, clWhite, frmSettings.pnlOddRowColor.Color);

  If (Node.Index > 0) then begin
    If ((Column in [1..9]) and (VST2.Text[VST2.GetPrevious(Node), Column] <> VST2.Text[Node, Column])) or
      ((Column = 0) and (VST2.Text[VST2.GetPrevious(Node), 11] <> VST2.Text[Node, 11])) then
      TargetCanvas.Brush.Color := clYellow;
  end
  Else
    If (Column in [1..9]) and (VST1.Text[VST1.GetFirst(), Column] <> VST2.Text[Node, Column]) or
      (Column = 0) and (VST1.Text[VST1.GetFirst(), 11] <> VST2.Text[Node, 11]) then
      TargetCanvas.Brush.Color := clYellow;

  TargetCanvas.FillRect(CellRect);
end;

procedure TfrmHistory.VST2GetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: Integer);
begin
  If  Column = 0 then
    ImageIndex := StrToInt(Field(separ, slHistory.Strings[Node.Index], 12));
end;

procedure TfrmHistory.VST2GetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
var
  M: integer;
  A: double;

begin
  M := Node.Index;

  case Column of
    // date
    1: CellText :=
        DateToStr(StrToDate(Field(separ, slHistory.Strings[M], 1),
        'YYYY-MM-DD', '-'));
    // comment
    2: CellText := Field(Separ, slHistory.Strings[M], 2);
    // amount
    3: begin
      TryStrToFloat(Field(separ, slHistory.Strings[M], 3), A);
      CellText := Format('%n', [A], FS_own);
    end;
    // currency
    4: CellText := Field(Separ, slHistory.Strings[M], 4);
    // account
    5: CellText := Field(Separ, slHistory.Strings[M], 5);
    // category
    6: CellText := AnsiUpperCase(Field(separ, slHistory.Strings[M],
        IfThen(Field(separ, slHistory.Strings[M], 13) = '0', 7, 6)));
    // subcategory
    7: if Field(separ, slHistory.Strings[M], 13) = '0' then
        CellText := ''
      else
        CellText := IfThen(frmSettings.chkDisplaySubCatCapital.Checked = True,
          AnsiUpperCase(Field(separ, slHistory.Strings[M], 7)),
          Field(separ, slHistory.Strings[M], 7));
    // person
    8: CellText := Field(Separ, slHistory.Strings[M], 8);
    // payee
    9: CellText := Field(Separ, slHistory.Strings[M], 9);
    // date and time
    10: CellText := Field(Separ, slHistory.Strings[M], 10);
    // Type
    11: CellText := Field(Separ, slHistory.Strings[M], 12);
  end;
end;

procedure TfrmHistory.actExitExecute(Sender: TObject);
begin
  frmHistory.ModalResult := mrCancel;
end;

end.
