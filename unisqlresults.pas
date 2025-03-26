unit uniSQLResults;

{$mode objfpc}{$H+}
{$ModeSwitch AutoDeref}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, ComCtrls, LazUTF8,
  Clipbrd, Buttons, ActnList, StdCtrls, BCPanel, BCMDButtonFocus, Math, laz.VirtualTrees,
  StrUtils;

type // bottom grid (SQL)
  TSQL = record
    Value: array [0..255] of string;
  end;
  PSQL = ^TSQL;

type
  { TfrmSQLResult }

  TfrmSQLResult = class(TForm)
    actExit: TAction;
    actCopy: TAction;
    actSelect: TAction;
    ActionList1: TActionList;
    btnExit: TBCMDButtonFocus;
    btnCopy: TBCMDButtonFocus;
    btnSelect: TBCMDButtonFocus;
    imgHeight: TImage;
    imgItem: TImage;
    imgItems: TImage;
    imgWidth: TImage;
    lblHeight: TLabel;
    lblItem: TLabel;
    lblItems: TLabel;
    lblWidth: TLabel;
    VST: TLazVirtualStringTree;
    pnlButtons: TPanel;
    pnlCaption: TBCPanel;
    pnlHeight: TPanel;
    pnlItem: TPanel;
    pnlItems: TPanel;
    pnlList: TPanel;
    pnlBottom: TPanel;
    pnlWidth: TPanel;
    procedure btnCopyClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure btnSelectClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure VSTBeforeCellPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
    procedure VSTChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure VSTCompareNodes(Sender: TBaseVirtualTree;
      Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: integer);
    procedure VSTGetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Kind: TVTImageKind; Column: TColumnIndex; var Ghosted: boolean;
      var ImageIndex: integer);
    procedure VSTGetNodeDataSize(Sender: TBaseVirtualTree;
      var NodeDataSize: integer);
    procedure VSTGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure VSTResize(Sender: TObject);
  private

  public
    slSQLresult: TStringList;
  end;

var
  frmSQLResult: TfrmSQLResult;

implementation

{$R *.lfm}

uses
  uniMain, uniSQL, uniSettings, uniResources;

  { TfrmSQLResult }

procedure TfrmSQLResult.FormCreate(Sender: TObject);
begin
  slSQLresult := TStringList.Create;

  // set components height
  pnlCaption.Height := PanelHeight;
  VST.Header.Height := PanelHeight;
  pnlButtons.Height := ButtonHeight;
  pnlBottom.Height := ButtonHeight;

  // get form icon
  frmMain.img16.GetIcon(7, (Sender as TForm).Icon);
end;

procedure TfrmSQLResult.btnExitClick(Sender: TObject);
begin
  frmSQLResult.Close;
end;

procedure TfrmSQLResult.btnSelectClick(Sender: TObject);
begin
  VST.SelectAll(False);
  VST.SetFocus;
end;

procedure TfrmSQLResult.btnCopyClick(Sender: TObject);
begin
  CopyVST(VST);
end;

procedure TfrmSQLResult.FormDestroy(Sender: TObject);
begin
  slSQLresult.Free;
end;

procedure TfrmSQLResult.FormResize(Sender: TObject);
begin
  lblWidth.Caption := IntToStr(frmSQLResult.Width);
  lblHeight.Caption := IntToStr(frmSQLResult.Height);

  pnlCaption.Repaint;
end;

procedure TfrmSQLResult.FormShow(Sender: TObject);
var
  SQL: PSQL;
  P: PVirtualNode;
  W: word;
  I: integer;
begin
  try
    // clear previous data
    VST.BeginUpdate;
    slSQLresult.Clear;
    VST.Clear;

    // clear grid table in form SQLresults
    VST.Header.Columns.Clear;

    // create new columns
    for I := 0 to frmMain.QRY.FieldCount do
    begin
      VST.Header.Columns.Add;
      if (I > 0) and (frmSQL.rbtData.Checked = False) then
        VST.Header.Columns[I].Text := frmMain.QRY.Fields[I - 1].FieldName;
    end;
    VST.Header.Columns[0].Options :=
      VST.Header.Columns[0].Options - [coAllowFocus, coAllowClick];

    if frmSQL.rbtData.Checked = True then
    begin
      VST.Header.Columns[1].Text := Caption_26; // date;
      VST.Header.Columns[2].Text := Caption_42; // amount
      VST.Header.Columns[3].Text := Caption_56; // comment
      VST.Header.Columns[4].Text := Caption_52; // currency
      VST.Header.Columns[5].Text := Caption_50; // account
      VST.Header.Columns[6].Text := AnsiReplaceStr(Caption_54, '&', ''); // category
      VST.Header.Columns[7].Text := Caption_80; // subcategory
      VST.Header.Columns[8].Text := Caption_58; // person
      VST.Header.Columns[9].Text := Caption_60; // payee
      VST.Header.Columns[10].Text := Caption_247; // Time
      VST.Header.Columns[11].Text := Caption_53; // ID
      VST.Header.Columns[12].Text := Caption_63; // Type
      VST.Header.Columns[13].Text := Caption_248 + '_'; // Order
    end;

    while not (frmMain.QRY.EOF) do
    begin
      VST.RootNodeCount := VST.RootNodeCount + 1;
      P := VST.GetLast();
      SQL := VST.GetNodeData(P);
      // SetLength(SQL.Value, frmMain.QRY.FieldCount - 1);

      for I := 0 to frmMain.QRY.FieldCount - 1 do
        SQL.Value[I] := frmMain.QRY.Fields[I].AsString;
      frmMain.QRY.Next;
    end;
    frmMain.QRY.Close;

    VST.Header.Columns[0].Width := Round(ScreenRatio * 25 / 100);

    W := VST.Width - 50;
    try
    if frmSQL.rbtMaster.Checked = True then
    begin
      VST.Header.Columns[1].Width := W div 11 * 1;
      VST.Header.Columns[2].Width := W div 11 * 2;
      VST.Header.Columns[3].Width := W div 11 * 1;
      VST.Header.Columns[4].Width := W div 11 * 1;
      VST.Header.Columns[5].Width := W div 11 * 6;
    end
    else
    if VST.Header.Columns.Count > 0 then
      for I := 1 to VST.Header.Columns.Count - 1 do
        VST.Header.Columns[I].Width :=
          W div (VST.Header.Columns.Count - 1);
    except
    end;

    SetNodeHeight(VST);
    VST.EndUpdate;

    // items icon
    lblItems.Caption := IntToStr(VST.RootNodeCount);
    lblItem.Caption := '';

    btnSelect.Enabled := VST.RootNodeCount > 0;
    VST.SetFocus;
  except
  end;
end;

procedure TfrmSQLResult.VSTBeforeCellPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
begin
  if frmSQL.rbtMaster.Checked = True then
    TargetCanvas.Brush.Color :=
      IfThen(VST.Text[Node, 1] = 'table', $00E5FCFD, // yellow
      IfThen(VST.Text[Node, 1] = 'trigger', $00FDF8E5, // blue
      IfThen(VST.Text[Node, 1] = 'index', $00EBE5FD, // red
      clWhite)))
  else
    TargetCanvas.Brush.Color :=
      IfThen(Node.Index mod 2 = 0, clWhite, frmSettings.pnlOddRowColor.Color);
  TargetCanvas.FillRect(CellRect);
end;

procedure TfrmSQLResult.VSTChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
begin
  // set images
  if VST.SelectedCount = 0 then
  begin
    imgItem.ImageIndex := -1;
    lblItem.Caption := '';
  end
  else
  begin
    if VST.SelectedCount = VST.TotalCount then
    begin
      imgItem.ImageIndex := 7;
      lblItem.Caption := '# ' + IntToStr(VST.SelectedCount);
    end
    else if VST.SelectedCount = 1 then
    begin
      imgItem.ImageIndex := 5;
      lblItem.Caption := IntToStr(VST.GetFirstSelected(False).Index + 1) + '.';
    end
    else
    begin
      imgItem.ImageIndex := 6;
      lblItem.Caption := '# ' + IntToStr(VST.SelectedCount);
    end;
  end;

  // set buttons
  btnSelect.Enabled := VST.SelectedCount > 0;
  btnCopy.Enabled := VST.SelectedCount > 0;
end;

procedure TfrmSQLResult.VSTCompareNodes(Sender: TBaseVirtualTree;
  Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: integer);
var
  Data1, Data2: PSQL;
begin

  Data1 := Sender.GetNodeData(Node1);
  Data2 := Sender.GetNodeData(Node2);
  if Column > 0 then
  begin
    if (Column = 2) and (frmSQL.rbtData.Checked = True) then
      Result := CompareValue(StrToFloat(Data1.Value[Column - 1]),
        StrToFloat(Data2.Value[Column - 1]))
    else if (Column in [11..12]) and (frmSQL.rbtData.Checked = True) then
      Result := CompareValue(StrToInt(Data1.Value[Column - 1]),
        StrToInt(Data2.Value[Column - 1]))
    else
      Result := UTF8CompareText(Data1.Value[Column - 1], Data2.Value[Column - 1]);
  end;
end;

procedure TfrmSQLResult.VSTGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: boolean; var ImageIndex: integer);
begin
  if Column = 0 then
    ImageIndex :=
      IfThen(VST.Text[Node, 1] = 'table', 3, // yellow
      IfThen(VST.Text[Node, 1] = 'trigger', 0, // blue
      IfThen(VST.Text[Node, 1] = 'index', 1, // red
      5)));
end;

procedure TfrmSQLResult.VSTGetNodeDataSize(Sender: TBaseVirtualTree;
  var NodeDataSize: integer);
begin
  NodeDataSize := SizeOf(TSQL);
end;

procedure TfrmSQLResult.VSTGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  SQL: PSQL;
begin
  SQL := Sender.GetNodeData(Node);
  if Column > 0 then
    CellText := SQL.Value[Column - 1];
end;

procedure TfrmSQLResult.VSTResize(Sender: TObject);
var
  Q: integer;
begin
  if VST.Header.Columns.Count = 0 then Exit;

  try
  VST.Header.Columns[0].Width := Round(ScreenRatio * 25 / 100);
  for Q := 1 to VST.Header.Columns.Count - 1 do
    VST.Header.Columns[Q].Width :=
      (VST.Width - VST.Header.Columns[0].Width) div (VST.Header.Columns.Count - 1);
  except
  end;
end;

end.
