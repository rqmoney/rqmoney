unit uniValues;

{$mode objfpc}{$H+}
{$ModeSwitch AutoDeref}

interface

uses
  Classes, SysUtils, FileUtil, laz.VirtualTrees, Forms, Controls, Graphics,
  Dialogs, Menus, ExtCtrls, ComCtrls, StdCtrls, Buttons, StrUtils, Clipbrd,
  ActnList, Spin, BCPanel, BCMDButtonFocus, Math, IniFiles;

type
  TNominal = record
    Value: double;
    Coin: boolean;
    Currency_id: integer;
    Time: string;
    ID: integer;
  end;
  PNominal = ^TNominal;

type

  { TfrmValues }

  TfrmValues = class(TForm)
    actAdd: TAction;
    actCopy: TAction;
    actDelete: TAction;
    actEdit: TAction;
    actExit: TAction;
    ActionList1: TActionList;
    actSave: TAction;
    actSelect: TAction;
    btnAdd: TBCMDButtonFocus;
    btnCancel: TBCMDButtonFocus;
    btnCopy: TBCMDButtonFocus;
    btnDelete: TBCMDButtonFocus;
    btnEdit: TBCMDButtonFocus;
    btnExit: TBCMDButtonFocus;
    btnSave: TBCMDButtonFocus;
    btnSelect: TBCMDButtonFocus;
    cbxType: TComboBox;
    spiValue: TFloatSpinEdit;
    imgHeight: TImage;
    imgItem: TImage;
    imgItems: TImage;
    imgList: TImageList;
    imgWidth: TImage;
    lblHeight: TLabel;
    lblItem: TLabel;
    lblItems: TLabel;
    lblType: TLabel;
    lblValue: TLabel;
    lblWidth: TLabel;
    popSelect: TMenuItem;
    VST: TLazVirtualStringTree;
    MenuItem1: TMenuItem;
    pnlButton: TPanel;
    pnlButtons: TPanel;
    pnlDetailCaption: TBCPanel;
    pnlHeight: TPanel;
    pnlItem: TPanel;
    pnlItems: TPanel;
    pnlListCaption: TBCPanel;
    pnlBottom: TPanel;
    pnlTip: TPanel;
    pnlType: TPanel;
    pnlDetail: TPanel;
    pnlList: TPanel;
    pnlValue: TPanel;
    pnlWidth: TPanel;
    popAdd: TMenuItem;
    popCopy: TMenuItem;
    popDelete: TMenuItem;
    popEdit: TMenuItem;
    popExit: TMenuItem;
    popList: TPopupMenu;
    splList: TSplitter;
    procedure btnSelectClick(Sender: TObject);
    procedure cbxTypeEnter(Sender: TObject);
    procedure cbxTypeExit(Sender: TObject);
    procedure cbxTypeKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure spiValueChange(Sender: TObject);
    procedure spiValueEnter(Sender: TObject);
    procedure spiValueExit(Sender: TObject);
    procedure spiValueKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure pnlButtonResize(Sender: TObject);
    procedure pnlButtonsResize(Sender: TObject);
    procedure btnCopyClick(Sender: TObject);
    procedure splListCanResize(Sender: TObject; var NewSize: integer;
      var Accept: boolean);
    procedure VSTBeforeCellPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
    procedure VSTChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure VSTDblClick(Sender: TObject);
    procedure VSTGetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Kind: TVTImageKind; Column: TColumnIndex; var Ghosted: boolean;
      var ImageIndex: integer);
    procedure VSTGetNodeDataSize(Sender: TBaseVirtualTree; var NodeDataSize: integer);
    procedure VSTGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure VSTResize(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmValues: TfrmValues;

procedure UpdateValues;

implementation

{$R *.lfm}

uses
  uniMain, uniSettings, uniCounter, uniResources;

  { TfrmValues }

procedure TfrmValues.FormCreate(Sender: TObject);
begin
  try
    // set components height
    VST.Header.Height := PanelHeight;
    pnlDetailCaption.Height := PanelHeight;
    pnlListCaption.Height := PanelHeight;
    pnlButtons.Height := ButtonHeight;
    pnlButton.Height := ButtonHeight;
    pnlBottom.Height := ButtonHeight;

    // get form icon
    frmMain.img16.GetIcon(23, (Sender as TForm).Icon);
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmValues.btnAddClick(Sender: TObject);
begin
  if (VST.Enabled = False) then
    Exit;

  try
    // panel Detail
    pnlDetail.Enabled := True;
    pnlDetail.Color := BrightenColor;
    pnlDetailCaption.Caption := AnsiUpperCase(Caption_45);

    // disabled ListView
    VST.Enabled := False;

    // enabled buttons
    pnlButtons.Visible := False;
    pnlButton.Visible := True;

    // enabled buttons
    btnSave.Enabled := False;
    btnSave.Tag := 0;

    // update fields
    //pnlStamp.Visible := False;
    spiValue.Value := 0.00;
    if cbxType.ItemIndex = -1 then
      cbxType.ItemIndex := 0;
    //txtStamp.Caption := '';
    spiValue.SetFocus;

    // disabled ActionList
    actAdd.Enabled := False;
    actEdit.Enabled := False;
    actDelete.Enabled := False;

  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;


procedure TfrmValues.btnEditClick(Sender: TObject);
begin
  if (VST.Enabled = False) or (VST.SelectedCount <> 1) then
    Exit;

  try
    // panel Detail
    pnlDetail.Enabled := True;
    pnlDetail.Color := BrightenColor;
    pnlDetailCaption.Caption := AnsiUpperCase(Caption_46);

    // disabled ListView
    VST.Enabled := False;

    // enabled buttons
    btnSave.Enabled := True;
    btnSave.Tag := 1;

    // enabled buttons
    pnlButtons.Visible := False;
    pnlButton.Visible := True;

    // update fields
    //pnlStamp.Visible := False;
    spiValue.SetFocus;

    // disabled ActionList
    actAdd.Enabled := False;
    actEdit.Enabled := False;
    actDelete.Enabled := False;

    spiValue.SelectAll;
  except
    on E: Exception do
      ShowMessage(E.Message + sLineBreak + E.ClassName);
  end;
end;

procedure TfrmValues.btnCancelClick(Sender: TObject);
begin
  try
    // panel Detail
    pnlDetail.Enabled := False;
    pnlDetail.Color := clDefault;
    pnlDetailCaption.Caption := AnsiUpperCase(Caption_43);

    // enabled buttons
    pnlButtons.Visible := True;
    pnlButton.Visible := False;

    // disabled buttons
    spiValue.Clear;
    cbxType.ItemIndex := -1;
    //pnlStamp.Visible := True;

    // enabled ListView
    VST.Enabled := True;
    VST.SetFocus;

    // enabled ActionList
    actAdd.Enabled := True;
    actEdit.Enabled := True;
    actDelete.Enabled := True;
  except
    on E: Exception do
      ShowMessage(E.Message + sLineBreak + E.ClassName);
  end;
end;

procedure TfrmValues.btnDeleteClick(Sender: TObject);
var
  IDs: string;
  N: PVirtualNode;
begin
  try
    if (frmMain.Conn.Connected = False) or (VST.SelectedCount = 0) then
      exit;

    // get IDs of all selected nodes
    IDs := '';
    N := VST.GetFirstSelected(False);
    try
      while Assigned(N) do
      begin
        IDs := IDs + VST.Text[N, 3] + ',';
        N := VST.GetNextSelected(N);
      end;
    finally
      IDs := LeftStr(IDs, Length(IDs) - 1);
    end;

    case VST.SelectedCount of
      1: if MessageDlg(Message_00, Question_01 + sLineBreak +
          sLineBreak + VST.Header.Columns[1].Text + ': ' + VST.Text[VST.FocusedNode, 1] +
          ' (' + VST.Text[VST.FocusedNode, 2] + ')', mtConfirmation,
          mbYesNo, 0) <> 6 then
          Exit;
      else
        if MessageDlg(Message_00, AnsiReplaceStr(
          Question_02, '%', IntToStr(VST.SelectedCount)), mtConfirmation,
          mbYesNo, 0) <> 6 then
          Exit;
    end;

    frmMain.QRY.SQL.Text := 'DELETE FROM nominal WHERE nom_id IN (' + IDs + ')';
    frmMain.QRY.ExecSQL;
    frmMain.Tran.Commit;
    UpdateValues;
    VST.SetFocus;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmValues.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var
  INI: TINIFile;
  INIFile: string;

begin
  try
    if pnlButton.Visible = True then
    begin
      btnCancelClick(btnCancel);
      CloseAction := Forms.caNone;
      Exit;
    end;

    // write position and window size
    if frmSettings.chkLastFormsSize.Checked = True then
    begin
      try
        INIFile := ChangeFileExt(ParamStr(0), '.ini');
        INI := TINIFile.Create(INIFile);
        if INI.ReadString('POSITION', frmValues.Name, '') <>
          IntToStr(frmValues.Left) + separ + // form left
        IntToStr(frmValues.Top) + separ + // form top
        IntToStr(frmValues.Width) + separ + // form width
        IntToStr(frmValues.Height) + separ + // form height
        IntToStr(frmValues.pnlDetail.Width) then
          INI.WriteString('POSITION', frmValues.Name,
            IntToStr(frmValues.Left) + separ + // form left
            IntToStr(frmValues.Top) + separ + // form top
            IntToStr(frmValues.Width) + separ + // form width
            IntToStr(frmValues.Height) + separ + // form height
            IntToStr(frmValues.pnlDetail.Width));
      finally
        INI.Free;
      end;
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmValues.spiValueChange(Sender: TObject);
var
  I: double;
begin
  try
    TryStrToFloat(spiValue.Text, I);
    btnSave.Enabled := I > 0;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmValues.cbxTypeKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  try
    if (Key = 13) then
    begin
      Key := 0;
      if (btnSave.Enabled = True) then
        btnSave.SetFocus
      else
        spiValue.SetFocus;
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmValues.btnSelectClick(Sender: TObject);
begin
  if (VST.Enabled = False) or (VST.RootNodeCount < 1) then
    Exit;
  VST.SelectAll(False);
  VST.SetFocus;
end;

procedure TfrmValues.cbxTypeEnter(Sender: TObject);
begin
  cbxType.Font.Bold := True;
end;

procedure TfrmValues.cbxTypeExit(Sender: TObject);
begin
  cbxType.Font.Bold := False;
end;

procedure TfrmValues.spiValueEnter(Sender: TObject);
begin
  try
    spiValue.Font.Bold := True;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmValues.spiValueExit(Sender: TObject);
begin
  try
    spiValue.Font.Bold := False;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmValues.spiValueKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  try
    if (Key = 13) then
    begin
      Key := 0;
      cbxType.SetFocus;
      cbxType.DroppedDown := True;
      Exit;
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmValues.btnExitClick(Sender: TObject);
begin
  frmValues.Close;
end;

procedure TfrmValues.btnSaveClick(Sender: TObject);
begin
  if (btnSave.Enabled = False) then
    Exit;

  try
    // Add new value
    if btnSave.Tag = 0 then
    begin
      frmMain.QRY.SQL.Text :=
        'INSERT INTO nominal (nom_value, nom_coin, nom_currency_id) VALUES (' +
        ':VALUE, :COIN, :CURRENCY);';
      frmMain.QRY.Params.ParamByName('VALUE').AsString :=
        ReplaceStr(FloatToStr(spiValue.Value), ',', '.');
      frmMain.QRY.Params.ParamByName('COIN').AsInteger := cbxType.ItemIndex;
      frmMain.QRY.Params.ParamByName('CURRENCY').AsInteger := frmValues.Tag;
      frmMain.QRY.Prepare;
      frmMain.QRY.ExecSQL;
      frmMain.Tran.Commit;
      UpdateValues;
      btnCancelClick(btnCancel);
      FindNewRecord(VST, 3);
      VST.SetFocus;
      Exit;
    end;

    // Edit selected value
    VST.Tag := StrToInt(VST.Text[VST.GetFirstSelected, 3]);
    frmMain.QRY.SQL.Text :=
      'UPDATE nominal SET nom_value = :VALUE, nom_coin = :COIN WHERE nom_id = :ID;';
    frmMain.QRY.Params.ParamByName('VALUE').AsString :=
      ReplaceStr(FloatToStr(spiValue.Value), ',', '.');
    frmMain.QRY.Params.ParamByName('COIN').AsInteger := cbxType.ItemIndex;
    frmMain.QRY.Params.ParamByName('ID').AsInteger := VST.Tag;
    frmMain.QRY.Prepare;
    frmMain.QRY.ExecSQL;
    frmMain.Tran.Commit;
    UpdateValues;
    btnCancelClick(btnCancel);
    FindEditedRecord(VST, 3, VST.Tag);
    VST.SetFocus;

  except
    on E: Exception do
    begin
      btnCancelClick(btnCancel);
      ShowErrorMessage(E);
    end;
  end;
end;

procedure TfrmValues.FormShow(Sender: TObject);
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
      frmValues.Position := poDesigned;
      S := INI.ReadString('POSITION', frmValues.Name, '-1•-1•0•0•220');

      // width
      TryStrToInt(Field(Separ, S, 3), I);
      if (I < 1) or (I > Screen.Width) then
        frmValues.Width := 650
      else
        frmValues.Width := I;

      /// height
      TryStrToInt(Field(Separ, S, 4), I);
      if (I < 1) or (I > Screen.Height) then
        frmValues.Height := 500
      else
        frmValues.Height := I;

      // left
      TryStrToInt(Field(Separ, S, 1), I);
      if (I < 0) or (I > Screen.Width) then
        frmValues.left := (Screen.Width - frmValues.Width) div 2
      else
        frmValues.Left := I;

      // top
      TryStrToInt(Field(Separ, S, 2), I);
      if (I < 0) or (I > Screen.Height) then
        frmValues.Top := ((Screen.Height - frmValues.Height) div 2) - 75
      else
        frmValues.Top := I;

      // detail panel
      TryStrToInt(Field(Separ, S, 5), I);
      if (I < 150) or (I > 350) then
        frmValues.pnlDetail.Width := 220
      else
        frmValues.pnlDetail.Width := I;
    end;
  finally
    INI.Free
  end;
  // ********************************************************************
  // FORM SIZE END
  // ********************************************************************

  UpdateValues;
  SetNodeHeight(VST);
end;

procedure TfrmValues.pnlButtonResize(Sender: TObject);
begin
  btnCancel.Width := (pnlButton.Width - 6) div 2;
end;

procedure TfrmValues.pnlButtonsResize(Sender: TObject);
begin
  btnEdit.Width := (pnlButtons.Width - 8) div 6;
  btnCopy.Width := btnEdit.Width;
  btnDelete.Width := btnEdit.Width;
  btnSelect.Width := btnEdit.Width;
  btnExit.Width := btnEdit.Width;
end;

procedure TfrmValues.btnCopyClick(Sender: TObject);
begin
  if (VST.Enabled = False) then
    Exit;
  CopyVST(VST);
end;

procedure TfrmValues.splListCanResize(Sender: TObject; var NewSize: integer;
  var Accept: boolean);
begin
  try
    imgWidth.ImageIndex := 3;
    lblWidth.Caption := IntToStr(frmValues.Width - pnlDetail.Width);

    imgHeight.ImageIndex := 2;
    lblHeight.Caption := IntToStr(pnlDetail.Width);

    pnlDetailCaption.Repaint;
    pnlListCaption.Repaint;
    pnlButton.Repaint;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmValues.VSTBeforeCellPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
begin
  TargetCanvas.Brush.Color := IfThen(Node.Index mod 2 = 0, clWhite,
    frmSettings.pnlOddRowColor.Color);
  TargetCanvas.FillRect(CellRect);
end;

procedure TfrmValues.VSTChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
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
      if VST.SelectedCount = VST.RootNodeCount then
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

    if (VST.RootNodeCount = 0) or (VST.SelectedCount <> 1) then
    begin
      spiValue.Value := 0.00;
      cbxType.ItemIndex := -1;
      Exit;
    end;

    if (VST.SelectedCount = 1) then
    begin
      spiValue.Text := VST.Text[VST.GetFirstSelected(False), 1];
      cbxType.ItemIndex := cbxType.Items.IndexOf(
        VST.Text[VST.GetFirstSelected(False), 2]);
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmValues.VSTDblClick(Sender: TObject);
begin
  if VST.SelectedCount = 1 then
    btnEditClick(btnEdit)
  else if VST.SelectedCount = 0 then
    btnAddClick(btnAdd);
end;

procedure TfrmValues.VSTGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: boolean; var ImageIndex: integer);
var
  Nominal: PNominal;
begin
  if Column = 0 then
  begin
    Nominal := Sender.GetNodeData(Node);
    ImageIndex := Abs(StrToInt(BoolToStr(Nominal.Coin))); // banknote or coin image
  end;
end;

procedure TfrmValues.VSTGetNodeDataSize(Sender: TBaseVirtualTree;
  var NodeDataSize: integer);
begin
  NodeDataSize := SizeOf(TNominal);
end;

procedure TfrmValues.VSTGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
var
  Nominal: PNominal;
begin
  Nominal := Sender.GetNodeData(Node);
  try
    case Column of
      1: begin
        CellText := Format('%n', [Nominal.Value], FS_own);
      end;
      2: CellText := cbxType.Items[Abs(StrToInt(BoolToStr(Nominal.Coin)))];
      3: CellText := IntToStr(Nominal.ID);
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmValues.VSTResize(Sender: TObject);
var
  X: integer;
begin
  if frmSettings.chkAutoColumnWidth.Checked = False then Exit;

  (Sender as TLazVirtualStringTree).Header.Columns[0].Width :=
    round(ScreenRatio * 25 / 100);
  X := (VST.Width - VST.Header.Columns[0].Width) div 100;
  VST.Header.Columns[1].Width := 40 * X; // name
  VST.Header.Columns[2].Width :=
    VST.Width - VST.Header.Columns[0].Width - ScrollBarWidth - (60 * X); // comment
  VST.Header.Columns[3].Width := 20 * X; // status
end;

procedure TfrmValues.FormResize(Sender: TObject);
begin
  try
    imgWidth.ImageIndex := 0;
    lblWidth.Caption := IntToStr(frmValues.Width);
    imgHeight.ImageIndex := 1;
    lblHeight.Caption := IntToStr(frmValues.Height);

    pnlListCaption.Repaint;
    pnlDetailCaption.Repaint;
    pnlButtons.Repaint;
    pnlButton.Repaint;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure UpdateValues;
var
  Nominal: PNominal;
  P: PVirtualNode;
begin
  try
    frmValues.VST.Clear;
    frmValues.VST.RootNodeCount := 0;

    screen.Cursor := crHourGlass;
    frmValues.VST.BeginUpdate;

    // =============================================================================================
    // update list of Values in form Values
    frmMain.QRY.SQL.Text := 'SELECT nom_value, nom_coin, nom_time, nom_id ' +
      'FROM nominal WHERE nom_currency_id = :ID ORDER BY nom_value DESC';
    frmMain.QRY.Params.ParamByName('ID').AsInteger := frmValues.Tag;
    frmMain.QRY.Prepare;
    frmMain.QRY.Open;
    while not (frmMain.QRY.EOF) do
    begin
      frmValues.VST.RootNodeCount := frmValues.VST.RootNodeCount + 1;
      P := frmValues.VST.GetLast();
      Nominal := frmValues.VST.GetNodeData(P);
      Nominal.Value := frmMain.QRY.Fields[0].AsFloat;
      Nominal.Coin := frmMain.QRY.Fields[1].AsBoolean;
      Nominal.Time := frmMain.QRY.Fields[2].AsString;
      Nominal.Id := frmMain.QRY.Fields[3].AsInteger;

      frmMain.QRY.Next;
    end;
    frmMain.QRY.Close;

    frmValues.VST.EndUpdate;
    screen.Cursor := crDefault;

    // =============================================================================================
    // items icon
    frmValues.lblItems.Caption := IntToStr(frmValues.VST.TotalCount);

    frmValues.popCopy.Enabled := frmValues.VST.RootNodeCount > 0;
    frmValues.btnCopy.Enabled := frmValues.popCopy.Enabled;

    // buttons
    frmValues.popCopy.Enabled := frmValues.VST.RootNodeCount > 0;
    frmValues.btnCopy.Enabled := frmValues.popCopy.Enabled;
    frmValues.btnSelect.Enabled := frmValues.VST.RootNodeCount > 0;
    frmValues.popEdit.Enabled := False;
    frmValues.btnEdit.Enabled := False;
    frmValues.popDelete.Enabled := False;
    frmValues.btnDelete.Enabled := False;

    frmValues.cbxType.ItemIndex := -1;
    frmValues.spiValue.Value := 0.00;

    if (frmValues.Visible = True) and (frmValues.VST.Enabled = True) then
      frmValues.VST.SetFocus;

    if frmCounter.Visible = True then
      frmCounter.cbxCurrencyChange(frmCounter.cbxCurrency);
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

end.
