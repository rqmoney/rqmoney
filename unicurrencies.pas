unit uniCurrencies;

{$mode objfpc}{$H+}
{$ModeSwitch AutoDeref}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Clipbrd, ExtCtrls, ComCtrls, Buttons, Menus, ActnList, Spin, BCPanel,
  BCMDButtonFocus, LazUTF8, laz.VirtualTrees, Math, StrUtils;

type
  TCurrency = record
    Code: string;
    Name: string;
    Default: boolean;
    Rate: double;
    Status: integer;
    Time: string;
    ID: integer;
  end;
  PCurrency = ^TCurrency;

type

  { TfrmCurrencies }

  TfrmCurrencies = class(TForm)
    actAdd: TAction;
    actCopy: TAction;
    actDelete: TAction;
    actEdit: TAction;
    actExit: TAction;
    actValues: TAction;
    ActionList1: TActionList;
    actPrint: TAction;
    actSave: TAction;
    actSelect: TAction;
    btnAdd: TBCMDButtonFocus;
    btnCancel: TBCMDButtonFocus;
    btnCopy: TBCMDButtonFocus;
    btnDelete: TBCMDButtonFocus;
    btnEdit: TBCMDButtonFocus;
    btnExit: TBCMDButtonFocus;
    btnPrint: TBCMDButtonFocus;
    btnSave: TBCMDButtonFocus;
    btnSelect: TBCMDButtonFocus;
    btnStatusInfo: TImage;
    btnValues: TBCMDButtonFocus;
    cbxDefault: TComboBox;
    cbxStatus: TComboBox;
    ediName: TEdit;
    ediCode: TEdit;
    ediRate: TFloatSpinEdit;
    imgHeight: TImage;
    imgItems: TImage;
    imgWidth: TImage;
    imgItem: TImage;
    lblHeight: TLabel;
    lblItems: TLabel;
    lblDefault: TLabel;
    lblRate: TLabel;
    lblStatus: TLabel;
    lblWidth: TLabel;
    lblName: TLabel;
    lblCode: TLabel;
    lblItem: TLabel;
    popSelect: TMenuItem;
    Separator1: TMenuItem;
    VST: TLazVirtualStringTree;
    MenuItem2: TMenuItem;
    pnlButton: TPanel;
    pnlButtons: TPanel;
    pnlDetailCaption: TBCPanel;
    pnlListCaption: TBCPanel;
    pnlValues: TPanel;
    pnlRight: TPanel;
    pnlStatusTop: TPanel;
    popPrint: TMenuItem;
    popValues: TMenuItem;
    pnlStatus: TPanel;
    pnlDefault: TPanel;
    pnlCode: TPanel;
    pnlName: TPanel;
    pnlList: TPanel;
    pnlDetail: TPanel;
    pnlRate: TPanel;
    pnlItems: TPanel;
    pnlBottom: TPanel;
    pnlHeight: TPanel;
    pnlTip: TPanel;
    pnlWidth: TPanel;
    pnlItem: TPanel;
    popAdd: TMenuItem;
    popCopy: TMenuItem;
    popDelete: TMenuItem;
    popEdit: TMenuItem;
    popExit: TMenuItem;
    popList: TPopupMenu;
    splList: TSplitter;
    procedure btnCopyClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure btnPrintMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure btnSelectClick(Sender: TObject);
    procedure cbxDefaultChange(Sender: TObject);
    procedure cbxDefaultKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure cbxStatusKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure ediCodeEnter(Sender: TObject);
    procedure ediCodeExit(Sender: TObject);
    procedure ediCodeKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure btnAddClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure ediCodeChange(Sender: TObject);
    procedure ediNameKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure ediRateKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure VSTBeforeCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas;
      Node: PVirtualNode; Column: TColumnIndex; CellPaintMode: TVTCellPaintMode;
      CellRect: TRect; var ContentRect: TRect);
    procedure VSTChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure VSTCompareNodes(Sender: TBaseVirtualTree; Node1, Node2: PVirtualNode;
      Column: TColumnIndex; var Result: integer);
    procedure VSTDblClick(Sender: TObject);
    procedure btnValuesClick(Sender: TObject);
    procedure pnlButtonResize(Sender: TObject);
    procedure pnlButtonsResize(Sender: TObject);
    procedure splListCanResize(Sender: TObject);
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
    { private declarations }
  public
    { public declarations }
  end;

var
  frmCurrencies: TfrmCurrencies;

procedure UpdateCurrencies;

implementation

{$R *.lfm}

uses
  uniMain, uniValues, uniSettings, uniAccounts, uniCounter, uniManyCurrencies,
  uniCalendar, uniResources;

  { TfrmCurrencies }

procedure TfrmCurrencies.FormCreate(Sender: TObject);
begin
  try
    VST.Images := frmMain.img16;

    // cbxStatus
    frmCurrencies.cbxStatus.Clear;
    frmCurrencies.cbxStatus.Items.Add(Caption_55);
    frmCurrencies.cbxStatus.Items.Add(Caption_57);
    frmCurrencies.cbxStatus.Items.Add(Caption_59);

    // set components height
    VST.Header.Height := PanelHeight;
    pnlDetailCaption.Height := PanelHeight;
    pnlListCaption.Height := PanelHeight;
    pnlButtons.Height := ButtonHeight;
    pnlButton.Height := ButtonHeight;
    pnlBottom.Height := ButtonHeight;
    btnValues.Height := ButtonHeight;

    // get form icon
    frmMain.img16.GetIcon(12, (Sender as TForm).Icon);
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmCurrencies.btnAddClick(Sender: TObject);
begin
  if (VST.Enabled = False) or (frmMain.Conn.Connected = False) then
    Exit;
  try
    // panel Detail
    pnlDetail.Enabled := True;
    pnlDetail.Color := IfThen(Dark = False,
      frmSettings.btnCaptionColorFont.Tag, rgbToColor(44,44,44));
    pnlDetailCaption.Caption := AnsiUpperCase(Caption_45);

    // disabled ListView
    VST.Enabled := False;

    // disabled menu
    pnlButtons.Visible := False;
    pnlButton.Visible := True;
    pnlValues.Visible := False;

    btnSave.Enabled := False;
    btnSave.Tag := 0;

    // update fields
    ediName.Clear;
    ediCode.Clear;
    cbxDefault.ItemIndex := 0;
    pnlRate.Enabled := False;
    ediRate.Text := Format('%0.5n', [1.00], DefaultFormatSettings);
    cbxStatus.ItemIndex := 0;
    ediCode.SetFocus;
    //pnlStamp.Visible := False;

    // disabled ActionList
    actAdd.Enabled := False;
    actEdit.Enabled := False;
    actDelete.Enabled := False;

  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmCurrencies.btnEditClick(Sender: TObject);
begin
  if (VST.Enabled = False) or (VST.SelectedCount <> 1) or
    (frmMain.Conn.Connected = False) then
    Exit;

  try
    // panel Detail
    pnlDetail.Enabled := True;
    pnlDetail.Color := IfThen(Dark = False,
      frmSettings.btnCaptionColorFont.Tag, rgbToColor(44,44,44));
    pnlDetailCaption.Caption := AnsiUpperCase(Caption_46);

    // disabled ListView
    VST.Enabled := False;

    // enabled buttons
    btnSave.Tag := 1;

    // disabled menu
    pnlButtons.Visible := False;
    pnlButton.Visible := True;
    pnlValues.Visible := False;

    // update fields
    //pnlStamp.Visible := False;
    pnlRate.Enabled := cbxDefault.ItemIndex = 1;
    ediRate.Text := ReplaceStr(ediRate.Text,
      DefaultFormatSettings.ThousandSeparator, '');

    // disabled ActionList
    actAdd.Enabled := False;
    actEdit.Enabled := False;
    actDelete.Enabled := False;

    ediCode.SetFocus;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmCurrencies.btnCancelClick(Sender: TObject);
begin
  try
    VST.Enabled := True;

    // panel Detail
    pnlDetail.Enabled := False;
    pnlDetail.Color := clDefault;
    pnlDetailCaption.Caption := AnsiUpperCase(Caption_43);

    // enabled menu
    // disabled menu
    pnlButtons.Visible := True;
    pnlButton.Visible := False;
    pnlValues.Visible := True;
    //pnlStamp.Visible := True;

    // enabled ListView
    if VST.Enabled = True then
      VST.SetFocus;

    // enabled ActionList
    actAdd.Enabled := True;
    actEdit.Enabled := True;
    actDelete.Enabled := True;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmCurrencies.ediCodeEnter(Sender: TObject);
begin
  try
    if Sender.ClassType = TEdit then
      (Sender as TEdit).Font.Bold := True
    else if Sender.ClassType = TComboBox then
      (Sender as TCombobox).Font.Bold := True
    else if Sender.ClassType = TFloatSpinEdit then
      (Sender as TFloatSpinEdit).Font.Bold := True;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmCurrencies.btnCopyClick(Sender: TObject);
begin
  if (VST.Enabled = False) or (frmMain.Conn.Connected = False) then
    Exit;
  CopyVST(VST);
end;

procedure TfrmCurrencies.btnPrintClick(Sender: TObject);
var
  FileName: string;
begin
  if btnPrint.Enabled = False then Exit;

  FileName := ExtractFileDir(Application.ExeName) + DirectorySeparator +
    'Templates' + DirectorySeparator + 'currencies.lrf';

  if FileExists(FileName) = False then
  begin
    ShowMessage(Error_14 + sLineBreak + FileName);
    Exit;
  end;

  // left mouse button = show report
  try
    frmMain.Report.LoadFromFile(FileName);
    frmMain.Report.FindObject('lblCode').Memo.Text := AnsiUpperCase(lblCode.Caption);
    frmMain.Report.FindObject('lblName').Memo.Text := AnsiUpperCase(lblName.Caption);
    frmMain.Report.FindObject('lblRate').Memo.Text := AnsiUpperCase(lblRate.Caption);
    frmMain.Report.FindObject('lblDefault').Memo.Text :=
      AnsiUpperCase(lblDefault.Caption);
    frmMain.Report.FindObject('lblStatus').Memo.Text := AnsiUpperCase(lblStatus.Caption);
    frmMain.Report.FindObject('lblID').Memo.Text :=
      AnsiUpperCase(VST.Header.Columns[6].Text);
    frmMain.Report.FindObject('lblFooter').Memo.Text :=
      AnsiUpperCase(Application.Title + ' - ' + frmCurrencies.Caption);

    frmMain.Report.Tag := 15;
    frmMain.Report.ShowReport;
    VST.SetFocus;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmCurrencies.btnPrintMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: integer);
var
  FileName: string;
begin
  FileName := ExtractFileDir(Application.ExeName) + DirectorySeparator +
    'Templates' + DirectorySeparator + 'currencies.lrf';

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

procedure TfrmCurrencies.btnSelectClick(Sender: TObject);
begin
  if (VST.Enabled = False) or (VST.RootNodeCount < 1) or
    (frmMain.Conn.Connected = False) then
    Exit;
  VST.SelectAll(False);
  VST.SetFocus;
end;

procedure TfrmCurrencies.cbxDefaultChange(Sender: TObject);
begin
  try
    pnlRate.Enabled := cbxDefault.ItemIndex = 1;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmCurrencies.cbxDefaultKeyUp(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  try
    if (Key = 13) then
    begin
      Key := 0;
      if pnlRate.Enabled = True then
      begin
        ediRate.SetFocus;
        Exit;
      end
      else
        ediRate.Text := Format('%0.5n', [1.00], FS_own);
      cbxStatus.SetFocus;
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmCurrencies.cbxStatusKeyUp(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  try
    if (Key = 13) then
    begin
      Key := 0;
      if btnSave.Enabled = True then
        btnSave.SetFocus
      else
        ediCode.SetFocus;
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmCurrencies.ediCodeExit(Sender: TObject);
begin
  try
    if Sender.ClassType = TEdit then
      (Sender as TEdit).Font.Bold := False
    else if Sender.ClassType = TComboBox then
      (Sender as TCombobox).Font.Bold := False
    else if Sender.ClassType = TFloatSpinEdit then
      (Sender as TFloatSpinEdit).Font.Bold := False;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmCurrencies.ediCodeKeyUp(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  try
    if (Key = 13) then
    begin
      Key := 0;
      ediName.SetFocus;
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmCurrencies.btnDeleteClick(Sender: TObject);
var
  S: string;
begin
  try
    if (frmMain.Conn.Connected = False) or (VST.SelectedCount = 0) then
      exit;

    frmMain.QRY.SQL.Text :=
      'SELECT acc_name FROM accounts WHERE acc_currency = :CURRENCY';
    frmMain.QRY.Params.ParamByName('CURRENCY').AsString :=
      VST.Text[VST.GetFirstSelected(False), 1];
    frmMain.QRY.Prepare;
    frmMain.QRY.Open;

    if frmMain.QRY.RecordCount > 0 then
    begin
      S := AnsiReplaceStr(Error_10, '%1', VST.Text[VST.GetFirstSelected(False), 2]);
      S := AnsiReplaceStr(S, '%2', VST.Text[VST.GetFirstSelected(False), 1]);
      S := AnsiReplaceStr(S, '%3', AnsiUpperCase(frmMain.QRY.Fields[0].AsString));
      S := AnsiReplaceStr(S, '%4', sLineBreak);
      MessageDlg(Message_00, S, mtWarning, [mbOK], 0);
      frmMain.QRY.Close;
      VST.SetFocus;
      Exit;
    end;
    frmMain.QRY.Close;

  except
    on E: Exception do
    begin
      ShowMessage(E.Message + sLineBreak + E.ClassName);
    end;
  end;

  // ===================================================================================================================
  // delete one item only
  try
    if MessageDlg(Message_00, Question_01 + sLineBreak +
      VST.Text[VST.GetFirstSelected(False), 1] + ' [' +
      VST.Text[VST.GetFirstSelected(False), 2] + ']', mtConfirmation,
      mbYesNo, 0) <> 6 then
    begin
      VST.SetFocus;
      Exit;
    end;
    frmMain.QRY.SQL.Text := 'DELETE FROM currencies WHERE cur_id = ' +
      VST.Text[VST.GetFirstSelected(False), 6];

    frmMain.QRY.ExecSQL;
    frmMain.Tran.Commit;
    UpdateCurrencies;

  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmCurrencies.btnSaveClick(Sender: TObject);
var
  cur_rate: double;
begin
  if (btnSave.Enabled = False) then
    Exit;

  // check forbidden chars in the text
  if CheckForbiddenChar(ediCode) = True then
    Exit;

  // check forbidden chars in the text
  if CheckForbiddenChar(ediName) = True then
    Exit;

  try
    // Add new category
    if btnSave.Tag = 0 then
      frmMain.QRY.SQL.Text :=
        'INSERT OR IGNORE INTO currencies (cur_code, cur_name, cur_default, cur_rate, cur_status) VALUES ('
        + ':CODE, :NAME, :DEFAULT, :RATE, :STATUS);'
    else
    begin
      // Edit selected category
      VST.Tag := StrToInt(VST.Text[VST.GetFirstSelected(False), 6]);
      frmMain.QRY.SQL.Text := 'UPDATE OR IGNORE currencies SET ' + // update
        'cur_code = :CODE, ' + // code
        'cur_name = :NAME, ' + // name
        'cur_default = :DEFAULT, ' + // default
        'cur_rate = :RATE, ' + // rate
        'cur_status = :STATUS ' + // status
        'WHERE cur_id = ' + VST.Text[VST.GetFirstSelected(False), 6];
    end;

    frmMain.QRY.Params.ParamByName('CODE').AsString := ediCode.Text;
    frmMain.QRY.Params.ParamByName('NAME').AsString := ediName.Text;
    frmMain.QRY.Params.ParamByName('DEFAULT').AsBoolean := cbxDefault.ItemIndex = 0;

    ediRate.Text := AnsiReplaceStr(ediRate.Text, '.',
      DefaultFormatSettings.DecimalSeparator);
    ediRate.Text := AnsiReplaceStr(ediRate.Text, ',',
      DefaultFormatSettings.DecimalSeparator);
    TryStrToFloat(ediRate.Text, cur_rate, DefaultFormatSettings);
    frmMain.QRY.Params.ParamByName('RATE').AsString :=
      ReplaceStr(FloatToStr(cur_rate), DefaultFormatSettings.DecimalSeparator, '.');
    frmMain.QRY.Params.ParamByName('STATUS').AsInteger := cbxStatus.ItemIndex;
    frmMain.QRY.Prepare;

    //ShowMessage (frmMain.QRY.SQL.Text);
    frmMain.QRY.ExecSQL;
    frmMain.Tran.Commit;

    UpdateCurrencies;
    btnCancelClick(btnCancel);

    if btnSave.Tag = 0 then
      FindNewRecord(VST, 6)
    else
      FindEditedRecord(VST, 6, VST.Tag);

    VST.SetFocus;
    if btnSave.Tag = 0 then
      btnValuesClick(btnValues);

  except
    on E: Exception do
    begin
      btnCancelClick(btnCancel);
      ShowErrorMessage(E);
    end;
  end;
end;

procedure TfrmCurrencies.ediCodeChange(Sender: TObject);
begin
  try
    btnSave.Enabled := Length(ediCode.Text) > 0;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmCurrencies.ediNameKeyUp(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  try
    if (Key = 13) then
    begin
      Key := 0;
      cbxDefault.SetFocus;
      //cbxStatus.DroppedDown := True;
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;


procedure TfrmCurrencies.VSTDblClick(Sender: TObject);
begin
  if frmMain.Conn.Connected = False then Exit;

  if VST.SelectedCount = 1 then
    btnEditClick(btnEdit)
  else if VST.SelectedCount = 0 then
    btnAddClick(btnAdd);
end;

procedure TfrmCurrencies.splListCanResize(Sender: TObject);
begin
  try
    imgWidth.ImageIndex := 3;
    lblWidth.Caption := IntToStr(frmCurrencies.Width - pnlDetail.Width);

    imgHeight.ImageIndex := 2;
    lblHeight.Caption := IntToStr(pnlDetail.Width);

    pnlListCaption.Repaint;
    pnlDetailCaption.Repaint;
    pnlButton.Repaint;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmCurrencies.VSTGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: boolean; var ImageIndex: integer);
begin
  if Column = 0 then
    ImageIndex := 12;
end;

procedure TfrmCurrencies.VSTGetNodeDataSize(Sender: TBaseVirtualTree;
  var NodeDataSize: integer);
begin
  NodeDataSize := SizeOf(TCurrency);
end;

procedure TfrmCurrencies.VSTGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  currency: PCurrency;
begin
  currency := Sender.GetNodeData(Node);
  try
    case Column of
      1: CellText := currency.Code;
      2: CellText := currency.Name;
      3: CellText := cbxDefault.Items[1 - Abs(StrToInt(BoolToStr(currency.Default)))];
      4: CellText := Format('%0.5n', [currency.Rate], FS_own);
      5: CellText := cbxStatus.Items[currency.Status];
      6: CellText := IntToStr(currency.ID);
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmCurrencies.VSTPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
var
  currency: PCurrency;
begin
  if vsSelected in node.States then exit;
  currency := Sender.GetNodeData(Node);

  case currency.Status of
    0: TargetCanvas.Font.Color := IfThen(Dark = False, clDefault, clSilver);
    1: TargetCanvas.Font.Color := IfThen(Dark = False, clDefault, clSkyBlue);
    2: TargetCanvas.Font.Color := IfThen(Dark = False, clDefault, $007873F4);
  end;

  TargetCanvas.Font.Bold := currency.Default;
end;

procedure TfrmCurrencies.VSTResize(Sender: TObject);
var
  X: integer;
begin
  if frmSettings.chkAutoColumnWidth.Checked = False then Exit;

  try
    (Sender as TLazVirtualStringTree).Header.Columns[0].Width :=
      round(Screen.PixelsPerInch div 96 * 25);
    X := (VST.Width - VST.Header.Columns[0].Width) div 100;
    VST.Header.Columns[1].Width := 13 * X; // code
    VST.Header.Columns[2].Width :=
      VST.Width - VST.Header.Columns[0].Width - ScrollBarWidth - (70 * X); // name
    VST.Header.Columns[3].Width := 14 * X; // default
    VST.Header.Columns[4].Width := 19 * X; // rate
    VST.Header.Columns[5].Width := 17 * X; // status
    VST.Header.Columns[6].Width := 7 * X; // ID
  except
  end;
end;

procedure TfrmCurrencies.btnExitClick(Sender: TObject);
begin
  try
    frmCurrencies.Close;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmCurrencies.ediRateKeyUp(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  try
    if (Key = 13) then
    begin
      Key := 0;
      cbxStatus.SetFocus;
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmCurrencies.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  try
    if pnlButton.Visible = True then
    begin
      btnCancelClick(btnCancel);
      CloseAction := Forms.caNone;
      Exit;
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmCurrencies.FormResize(Sender: TObject);
begin
  try
    imgWidth.ImageIndex := 0;
    lblWidth.Caption := IntToStr(frmCurrencies.Width);
    imgHeight.ImageIndex := 1;
    lblHeight.Caption := IntToStr(frmCurrencies.Height);

    pnlButtons.Repaint;
    pnlButton.Repaint;
    pnlValues.Repaint;
    pnlListCaption.Repaint;
    pnlDetailCaption.Repaint;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmCurrencies.FormShow(Sender: TObject);
begin
  // btnAdd
  btnAdd.Enabled := frmMain.Conn.Connected = True;
  popAdd.Enabled := frmMain.Conn.Connected = True;
  actAdd.Enabled := frmMain.Conn.Connected = True;

  // btnEdit
  btnEdit.Enabled := VST.SelectedCount = 1;
  popEdit.Enabled := VST.SelectedCount = 1;
  actEdit.Enabled := VST.SelectedCount = 1;

  // btnDelete
  btnDelete.Enabled := VST.SelectedCount > 0;
  popDelete.Enabled := VST.SelectedCount > 0;
  actDelete.Enabled := VST.SelectedCount > 0;

  // btnCopy
  btnCopy.Enabled := VST.RootNodeCount > 0;
  popCopy.Enabled := VST.RootNodeCount > 0;
  actCopy.Enabled := VST.RootNodeCount > 0;

  // btnSelect
  btnSelect.Enabled := VST.RootNodeCount > 0;
  popSelect.Enabled := VST.RootNodeCount > 0;
  actSelect.Enabled := VST.RootNodeCount > 0;

  // btnPrint
  btnPrint.Enabled := VST.RootNodeCount > 0;
  popPrint.Enabled := VST.RootNodeCount > 0;
  actPrint.Enabled := VST.RootNodeCount > 0;

  // btnValue
  btnValues.Enabled := VST.SelectedCount = 1;
  popValues.Enabled := VST.SelectedCount = 1;
  actValues.Enabled := VST.SelectedCount = 1;

  SetNodeHeight(frmCurrencies.VST);
  VST.SetFocus;
  VST.ClearSelection;
end;

procedure TfrmCurrencies.VSTBeforeCellPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
begin
  TargetCanvas.Brush.Color := // color
    IfThen(Node.Index mod 2 = 0, // odd row
    IfThen(Dark = False, clWhite, rgbToColor(22, 22, 22)),
    IfThen(Dark = False, frmSettings.pnlOddRowColor.Color,
    Brighten(frmSettings.pnlOddRowColor.Color, 44)));
  TargetCanvas.FillRect(CellRect);
end;

procedure TfrmCurrencies.VSTChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
begin
  try
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
    popEdit.Enabled := VST.SelectedCount = 1;
    popDelete.Enabled := VST.SelectedCount > 0;
    btnEdit.Enabled := VST.SelectedCount = 1;
    btnDelete.Enabled := VST.SelectedCount > 0;
    btnValues.Enabled := VST.SelectedCount = 1;
    popValues.Enabled := VST.SelectedCount = 1;

    if (VST.RootNodeCount = 0) or (VST.SelectedCount <> 1) then
    begin
      ediCode.Clear;
      ediName.Clear;
      ediRate.Clear;
      cbxDefault.ItemIndex := -1;
      cbxStatus.ItemIndex := -1;
      Exit;
    end;

    if (VST.SelectedCount = 1) then
    begin
      ediCode.Text := VST.Text[VST.GetFirstSelected(False), 1];
      ediName.Text := VST.Text[VST.GetFirstSelected(False), 2];
      cbxDefault.ItemIndex :=
        cbxDefault.Items.IndexOf(VST.Text[VST.GetFirstSelected(False), 3]);
      ediRate.Text := ReplaceStr(VST.Text[VST.GetFirstSelected(False), 4],
        FS_own.ThousandSeparator, '');
      cbxStatus.ItemIndex := cbxStatus.Items.IndexOf(
        VST.Text[VST.GetFirstSelected(False), 5]);
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmCurrencies.VSTCompareNodes(Sender: TBaseVirtualTree;
  Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: integer);
var
  Data1, Data2: PCurrency;
begin
  Data1 := Sender.GetNodeData(Node1);
  Data2 := Sender.GetNodeData(Node2);
  case Column of
    1: Result := UTF8CompareText(Data1.Code, Data2.Code);
  end;
end;

procedure TfrmCurrencies.btnValuesClick(Sender: TObject);
begin
  try
    frmValues.Caption := AnsiUpperCase(ReplaceStr(btnValues.Caption, '&', '')) +
      ' [' + VST.Text[VST.GetFirstSelected(False), 1] + ' • ' +
      VST.Text[VST.GetFirstSelected(False), 2] + ']';
    frmValues.Tag := StrToInt(VST.Text[VST.GetFirstSelected(False), 6]);
    frmValues.ShowModal;
    frmValues.Tag := 0;
    VST.SetFocus;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmCurrencies.pnlButtonResize(Sender: TObject);
begin
  btnCancel.Width := (pnlButton.Width - 6) div 2;
end;

procedure TfrmCurrencies.pnlButtonsResize(Sender: TObject);
begin
  btnEdit.Width := (pnlButtons.Width - 14) div 7;
  btnDelete.Width := btnEdit.Width;
  btnCopy.Width := btnEdit.Width;
  btnPrint.Width := btnEdit.Width;
  btnExit.Width := btnEdit.Width;
  btnSelect.Width := btnEdit.Width;
  pnlButtons.Repaint;
end;

procedure UpdateCurrencies;
var
  currency: PCurrency;
  P: PVirtualNode;
  Q: byte;
begin
  try
    frmCurrencies.VST.Clear;

    //frmCalendar.cbxCurrency.ItemIndex := -1;

    // =============================================================================================
    // update list of currencies in form currencies
    if frmMain.Conn.Connected = False then
    begin
      frmCalendar.cbxCurrency.Clear;
      frmCalendar.cbxAccount.Clear;
      frmCalendar.cbxAccount.Items.Add('*');
      frmCalendar.cbxAccount.ItemIndex := 0;
      exit;
    end;

    screen.Cursor := crHourGlass;
    frmCurrencies.VST.BeginUpdate;

    frmMain.QRY.SQL.Text := 'SELECT cur_code, cur_name, cur_default, cur_rate, ' +
      'cur_status, cur_time, cur_id FROM currencies';
    frmMain.QRY.Open;

    Q := 0; // Count of default currencies

    while not (frmMain.QRY.EOF) do
    begin
      frmCurrencies.VST.RootNodeCount := frmCurrencies.VST.RootNodeCount + 1;
      P := frmCurrencies.VST.GetLast();
      currency := frmCurrencies.VST.GetNodeData(P);
      currency.Code := frmMain.QRY.Fields[0].AsString;
      currency.Name := frmMain.QRY.Fields[1].AsString;
      currency.Default := frmMain.QRY.Fields[2].AsBoolean;
      currency.Rate := frmMain.QRY.Fields[3].AsFloat;
      currency.Status := frmMain.QRY.Fields[4].AsInteger;
      currency.Time := frmMain.QRY.Fields[5].AsString;
      currency.ID := frmMain.QRY.Fields[6].AsInteger;

      if frmMain.QRY.Fields[2].AsBoolean = True then
        Inc(Q);

      frmMain.QRY.Next;
    end;
    frmMain.QRY.Close;

    frmCurrencies.VST.SortTree(1, sdAscending);
    frmCurrencies.VST.EndUpdate;
    screen.Cursor := crDefault;

    // =============================================================================================
    // update list of currencies in form Accounts
    frmAccounts.cbxCurrency.Clear;
    frmMain.cbxCurrency.Clear;

    for P in frmCurrencies.VST.Nodes() do
    begin
      currency := frmCurrencies.VST.GetNodeData(P);
      // list of Currencies in frmACCOUNTS [active status only !!!]
      if currency.Status = 0 then
      begin
        frmAccounts.cbxCurrency.Items.Add(currency.Code + separ_1 + currency.Name);
        frmMain.cbxCurrency.Items.Add(currency.Code + separ_1 + currency.Name);
      end;
    end;

    if frmAccounts.cbxCurrency.Items.Count > 0 then
      frmAccounts.cbxCurrency.ItemIndex := 0;

    frmMain.cbxCurrency.Items.Insert(0, '*');
    frmMain.cbxCurrency.ItemIndex := 0;
    frmMain.cbxCurrencyChange(frmMain.cbxCurrency);

    // ============================================================================================
    // Check main currency in case there is many currencies
    if (Q <> 1) and (frmAccounts.cbxCurrency.Items.Count > 1) then
    begin
      frmManyCurrencies.cbxCurrency.Clear;
      frmManyCurrencies.cbxCurrency.Items := frmAccounts.cbxCurrency.Items;
      frmManyCurrencies.cbxCurrency.ItemIndex := 0;
      frmManyCurrencies.btnSave.Enabled := True;
      frmManyCurrencies.ShowModal;
    end;

    // frmCounter
    frmCounter.cbxCurrency.Clear;
    frmCounter.cbxCurrency.Items := frmAccounts.cbxCurrency.Items;
    frmCounter.cbxCurrency.ItemIndex := -1;
    frmCounter.cbxCurrency.Enabled := frmCounter.cbxCurrency.Items.Count > 0;

    if frmCounter.cbxCurrency.Items.Count > 0 then
    begin
      // find default currency
      P := frmCurrencies.VST.GetFirst();
      while Assigned(P) do
      begin
        currency := frmCurrencies.VST.GetNodeData(P);
        if currency.Default = True then
        begin
          frmCounter.cbxCurrency.ItemIndex := P.Index;
          Break;
        end;
        P := frmCurrencies.VST.GetNext(P);
      end;
    end;
    frmCounter.cbxCurrencyChange(frmCounter.cbxCurrency);

    // frmCurrencies
    frmCurrencies.btnEdit.Enabled := False;
    frmCurrencies.btnDelete.Enabled := False;
    frmCurrencies.btnValues.Enabled := False;

    frmCurrencies.popEdit.Enabled := False;
    frmCurrencies.popDelete.Enabled := False;
    frmCurrencies.popValues.Enabled := False;

    frmCurrencies.popCopy.Enabled := frmCurrencies.VST.RootNodeCount > 0;
    frmCurrencies.btnCopy.Enabled := frmCurrencies.popCopy.Enabled;
    frmCurrencies.btnSelect.Enabled := frmCurrencies.VST.RootNodeCount > 0;
    frmCurrencies.popPrint.Enabled := frmCurrencies.popCopy.Enabled;
    frmCurrencies.btnPrint.Enabled := frmCurrencies.popCopy.Enabled;
    frmCurrencies.popEdit.Enabled := False;
    frmCurrencies.btnEdit.Enabled := False;
    frmCurrencies.popDelete.Enabled := False;
    frmCurrencies.btnDelete.Enabled := False;

    // frmCalendar
    frmCalendar.cbxCurrency.Items := frmAccounts.cbxCurrency.Items;
    if frmCalendar.cbxCurrency.Items.Count > 0 then
    begin
      frmCalendar.cbxCurrency.ItemIndex := 0;
      frmCalendar.cbxCurrencyChange(frmCalendar.cbxCurrency);
    end;

    // items icon
    frmCurrencies.lblItems.Caption := IntToStr(frmCurrencies.VST.RootNodeCount);

    if (frmCurrencies.Visible = True) and (frmCurrencies.VST.Enabled = True) then
      frmCurrencies.VST.SetFocus;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

end.
