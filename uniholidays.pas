unit uniHolidays;

{$mode objfpc}{$H+}
{$ModeSwitch AutoDeref}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Clipbrd, Variants, ExtCtrls, ComCtrls, Buttons, Menus, ActnList,
  BCPanel, BCMDButtonFocus, LazUTF8, laz.VirtualTrees, SpinEx, IniFiles,
  StrUtils, dateutils, Math;

type
  THoliday = record
    Day: integer;
    Month: integer;
    Name: string;
    Time: string;
    ID: integer;
  end;
  PHoliday = ^THoliday;

type

  { TfrmHolidays }

  TfrmHolidays = class(TForm)
    actExit: TAction;
    actAdd: TAction;
    actEdit: TAction;
    actDelete: TAction;
    actCopy: TAction;
    actPrint: TAction;
    actSelect: TAction;
    actSave: TAction;
    ActionList1: TActionList;
    btnAdd: TBCMDButtonFocus;
    btnCancel: TBCMDButtonFocus;
    btnCopy: TBCMDButtonFocus;
    btnDelete: TBCMDButtonFocus;
    btnEdit: TBCMDButtonFocus;
    btnExit: TBCMDButtonFocus;
    btnPrint: TBCMDButtonFocus;
    btnSave: TBCMDButtonFocus;
    btnSelect: TBCMDButtonFocus;
    lbxMonth: TListBox;
    imgHeight: TImage;
    imgItems: TImage;
    imgWidth: TImage;
    imgItem: TImage;
    lblHeight: TLabel;
    lblItems: TLabel;
    lblMonth: TLabel;
    lblWidth: TLabel;
    lblDay: TLabel;
    lblName: TLabel;
    lblItem: TLabel;
    memComment: TMemo;
    popSelect: TMenuItem;
    MenuItem3: TMenuItem;
    pnlButton: TPanel;
    pnlButtons: TPanel;
    pnlDetailCaption: TBCPanel;
    pnlListCaption: TBCPanel;
    popPrint: TMenuItem;
    pnlMonth: TPanel;
    pnlDay: TPanel;
    pnlName: TPanel;
    pnlList: TPanel;
    pnlDetail: TPanel;
    pnlItems: TPanel;
    pnlBottom: TPanel;
    pnlHeight: TPanel;
    pnlWidth: TPanel;
    pnlItem: TPanel;
    popAdd: TMenuItem;
    popCopy: TMenuItem;
    popDelete: TMenuItem;
    popEdit: TMenuItem;
    popExit: TMenuItem;
    popList: TPopupMenu;
    spiDay: TSpinEditEx;
    splList: TSplitter;
    VST: TLazVirtualStringTree;
    procedure btnCopyClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure btnPrintMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure btnSelectClick(Sender: TObject);
    procedure lbxMonthEnter(Sender: TObject);
    procedure lbxMonthExit(Sender: TObject);
    procedure spiDayEnter(Sender: TObject);
    procedure spiDayExit(Sender: TObject);
    procedure spiDayKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure lbxMonthKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure memCommentChange(Sender: TObject);
    procedure memCommentEnter(Sender: TObject);
    procedure memCommentExit(Sender: TObject);
    procedure memCommentKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure VSTBeforeCellPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
    procedure VSTChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure VSTFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure VSTGetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Kind: TVTImageKind; Column: TColumnIndex; var Ghosted: boolean;
      var ImageIndex: integer);
    procedure VSTGetNodeDataSize(Sender: TBaseVirtualTree; var NodeDataSize: integer);
    procedure VSTGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure VSTResize(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure VSTDblClick(Sender: TObject);
    procedure pnlButtonResize(Sender: TObject);
    procedure pnlButtonsResize(Sender: TObject);
    procedure splListCanResize(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmHolidays: TfrmHolidays;

procedure UpdateHolidays;

implementation

{$R *.lfm}

uses
  uniMain, uniSettings, uniProperties, uniResources;

  { TfrmHolidays }


procedure TfrmHolidays.FormCreate(Sender: TObject);
var
  I: byte;
begin
  try
    // create list of months
    for I := 1 to 12 do
      lbxMonth.Items.Add(FormatDateTime('MMMM', EncodeDate(2000, I, 1)));
    lbxMonth.ItemIndex := -1;

    VST.Header.Height := PanelHeight;
    pnlDetailCaption.Height := PanelHeight;
    pnlListCaption.Height := PanelHeight;
    pnlButtons.Height := ButtonHeight;
    pnlButton.Height := ButtonHeight;
    pnlBottom.Height := ButtonHeight;

    // get form icon
    frmMain.img16.GetIcon(10, (Sender as TForm).Icon);
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmHolidays.btnAddClick(Sender: TObject);
begin
  if (VST.Enabled = False) or (frmMain.Conn.Connected = False) then
    Exit;

  try
    // panel Detail
    pnlDetail.Enabled := True;
    pnlDetail.Color := BrightenColor;
    pnlDetailCaption.Caption := AnsiUpperCase(Caption_45);

    // disabled ListView
    VST.Enabled := False;

    // disabled menu
    pnlButtons.Visible := False;
    pnlButton.Visible := True;

    // enabled buttons
    btnSave.Enabled := False;
    btnSave.Tag := 0;

    // update fields
    spiDay.Value := 1;
    lbxMonth.ItemIndex := 0;
    memComment.Clear;

    // disabled ActionList
    actAdd.Enabled := False;
    actEdit.Enabled := False;
    actDelete.Enabled := False;

    //pnlStamp.Visible := False;

    spiDay.SetFocus;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;


procedure TfrmHolidays.btnEditClick(Sender: TObject);
begin
  if (VST.Enabled = False) or (VST.SelectedCount <> 1) or
    (frmMain.Conn.Connected = False) then
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

    // disabled menu
    pnlButtons.Visible := False;
    pnlButton.Visible := True;
    actExit.Enabled := True;

    // disabled ActionList
    actAdd.Enabled := False;
    actEdit.Enabled := False;
    actDelete.Enabled := False;

    // update fields
    //pnlStamp.Visible := False;
    spiDay.SetFocus;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmHolidays.btnCancelClick(Sender: TObject);
begin
  try
    // panel Detail
    pnlDetail.Enabled := False;
    pnlDetail.Color := clDefault;
    pnlDetailCaption.Caption := AnsiUpperCase(Caption_43);

    // disabled menu
    pnlButtons.Visible := True;
    pnlButton.Visible := False;

    // disabled buttons
    spiDay.Clear;
    lbxMonth.ItemIndex := -1;
    memComment.Clear;

    //pnlStamp.Visible := True;

    // enabled ListView
    VST.Enabled := True;
    VST.SetFocus;

    // disabled ActionList
    actAdd.Enabled := True;
    actEdit.Enabled := True;
    actDelete.Enabled := True;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmHolidays.btnCopyClick(Sender: TObject);
begin
  if (VST.Enabled = False) or (frmMain.Conn.Connected = False) then
    Exit;
  CopyVST(VST);
end;

procedure TfrmHolidays.btnPrintClick(Sender: TObject);
var
  FileName: string;
begin
  if btnPrint.Enabled = False then Exit;

  FileName := ExtractFileDir(Application.ExeName) + DirectorySeparator +
    'Templates' + DirectorySeparator + 'holidays.lrf';

  if FileExists(FileName) = False then
  begin
    ShowMessage(Error_14 + sLineBreak + FileName);
    Exit;
  end;

  // left mouse button = show report
  try
    frmMain.Report.LoadFromFile(FileName);
    frmMain.Report.FindObject('lblName').Memo.Text := AnsiUpperCase(lblName.Caption);
    frmMain.Report.FindObject('lblDate').Memo.Text :=
      AnsiUpperCase(VST.Header.Columns[1].Text);
    frmMain.Report.FindObject('lblID').Memo.Text :=
      AnsiUpperCase(VST.Header.Columns[3].Text);
    frmMain.Report.FindObject('lblFooter').Memo.Text :=
      AnsiUpperCase(Application.Title + ' - ' + frmHolidays.Caption);

    frmMain.Report.Tag := 17;
    frmMain.Report.ShowReport;
    VST.SetFocus;

  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmHolidays.btnPrintMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
var
  FileName: string;
begin
  FileName := ExtractFileDir(Application.ExeName) + DirectorySeparator +
    'Templates' + DirectorySeparator + 'holidays.lrf';

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

procedure TfrmHolidays.btnSelectClick(Sender: TObject);
begin
  if (VST.RootNodeCount < 1) or (VST.Enabled = False) or
    (frmMain.Conn.Connected = False) then
    Exit;

  VST.SelectAll(False);
  VST.SetFocus;
end;

procedure TfrmHolidays.lbxMonthEnter(Sender: TObject);
begin
  lbxMonth.Font.Bold := True;
end;

procedure TfrmHolidays.lbxMonthExit(Sender: TObject);
begin
  lbxMonth.Font.Bold := False;
end;

procedure TfrmHolidays.spiDayEnter(Sender: TObject);
begin
  spiDay.Font.Bold := True;
end;

procedure TfrmHolidays.spiDayExit(Sender: TObject);
begin
  spiDay.Font.Bold := False;
end;

procedure TfrmHolidays.spiDayKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  case Key of
    13: begin
      Key := 0;
      lbxMonth.SetFocus;
    end;
    27: frmHolidays.Close;
  end;
end;

procedure TfrmHolidays.lbxMonthKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if (Key = 13) then
  begin
    Key := 0;
    memComment.SetFocus;
    memComment.SelectAll;
  end;
end;

procedure TfrmHolidays.memCommentChange(Sender: TObject);
begin
  btnSave.Enabled := Length(memComment.Text) > 0;
end;

procedure TfrmHolidays.memCommentEnter(Sender: TObject);
begin
  try
    memComment.Font.Bold := True;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmHolidays.memCommentExit(Sender: TObject);
begin
  try
    memComment.Font.Bold := False;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmHolidays.memCommentKeyUp(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  if (Key = 13) then
  begin
    Key := 0;
    if btnSave.Enabled = True then
      btnSave.SetFocus
    else
      spiDay.SetFocus;
  end;
end;

procedure TfrmHolidays.VSTBeforeCellPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
begin
  TargetCanvas.Brush.Color := IfThen(Node.Index mod 2 = 0, clWhite,
    frmSettings.pnlOddRowColor.Color);
  TargetCanvas.FillRect(CellRect);
end;

procedure TfrmHolidays.VSTChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
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

    if (VST.RootNodeCount = 0) or (VST.SelectedCount <> 1) then
    begin
      spiDay.Clear;
      lbxMonth.ItemIndex := -1;
      memComment.Clear;
      Exit;
    end;

    if (VST.SelectedCount = 1) then
    begin
      spiDay.Value := StrToInt(VST.Text[VST.GetFirstSelected(False), 5]);
      lbxMonth.ItemIndex := StrToInt(VST.Text[VST.GetFirstSelected(False), 4]) - 1;
      memComment.Text := VST.Text[VST.GetFirstSelected(False), 2];
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmHolidays.VSTFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  Holiday: PHoliday;
begin
  Holiday := Sender.GetNodeData(Node);
  Holiday.Day := 0;
  Holiday.ID := 0;
  Holiday.Month := 0;
  Holiday.Name := '';
  Holiday.Time := '';
end;

procedure TfrmHolidays.VSTGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: boolean; var ImageIndex: integer);
begin
  if Column = 0 then
    ImageIndex := 10;
end;

procedure TfrmHolidays.VSTGetNodeDataSize(Sender: TBaseVirtualTree;
  var NodeDataSize: integer);
begin
  NodeDataSize := SizeOf(THoliday);
end;

procedure TfrmHolidays.VSTGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
var
  Holiday: PHoliday;
begin
  Holiday := Sender.GetNodeData(Node);
  try
    case Column of
      1: CellText := IntToStr(Holiday.Day) + '. ' +
          DefaultFormatSettings.LongMonthNames[Holiday.Month];
      2: CellText := Holiday.Name;
      3: CellText := IntToStr(Holiday.ID);
      4: CellText := IntToStr(Holiday.Month);
      5: CellText := IntToStr(Holiday.Day);
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmHolidays.VSTResize(Sender: TObject);
var
  X: integer;
begin
  if frmSettings.chkAutoColumnWidth.Checked = False then Exit;

  (Sender as TLazVirtualStringTree).Header.Columns[0].Width :=
    Round(ScreenRatio * 25 / 100);
  X := (VST.Width - VST.Header.Columns[0].Width) div 100;
  VST.Header.Columns[1].Width := 25 * X; // ID
  VST.Header.Columns[2].Width :=
    VST.Width - VST.Header.Columns[0].Width - ScrollBarWidth - (36 * X); // text
  VST.Header.Columns[3].Width := 11 * X; // ID
end;

procedure TfrmHolidays.btnDeleteClick(Sender: TObject);
var
  IDs: string;
  N: PVirtualNode;
begin
  try
    if (frmMain.Conn.Connected = False) or (VST.SelectedCount = 0) or
      (frmMain.Conn.Connected = False) then
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

    // confirm deleting
    case VST.SelectedCount of
      1: if MessageDlg(Message_00, Question_01 + sLineBreak +
          sLineBreak + Trim(VST.Header.Columns[1].Text) + ': ' +
          VST.Text[VST.FocusedNode, 1] + sLineBreak + VST.Header.Columns[2].Text +
          ': ' + VST.Text[VST.FocusedNode, 2], mtConfirmation, mbYesNo, 0) <> 6 then
          Exit;
      else
        if MessageDlg(Message_00, AnsiReplaceStr(
          Question_02, '%', IntToStr(VST.SelectedCount)), mtConfirmation,
          mbYesNo, 0) <> 6 then
          Exit;
    end;

    frmMain.QRY.SQL.Text := 'DELETE FROM holidays WHERE hol_id IN (' + IDs + ');';
    frmMain.QRY.ExecSQL;
    frmMain.Tran.Commit;

    UpdateHolidays;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmHolidays.btnSaveClick(Sender: TObject);
begin
  if (btnSave.Enabled = False) then
    Exit;

  // check forbidden chars in the text
  if CheckForbiddenChar(memComment) = True then
    Exit;

  // check the date validity
  if IsValidDate(2000, lbxMonth.ItemIndex + 1, spiDay.Value) = False then
  begin
    ShowMessage(Error_07);
    spiDay.SetFocus;
    Exit;
  end;

  try
    // Add new category
    if btnSave.Tag = 0 then
      frmMain.QRY.SQL.Text :=
        'INSERT OR IGNORE INTO holidays (hol_day, hol_month, hol_name) VALUES (:DAY, :MONTH, :NAME);'
    else
    begin
      // Edit selected
      VST.Tag := StrToInt(VST.Text[VST.GetFirstSelected(False), 3]);
      frmMain.QRY.SQL.Text :=
        'UPDATE OR IGNORE holidays SET ' + // update
        'hol_day = :DAY, ' +     // day
        'hol_month = :MONTH, ' + // month
        'hol_name = :NAME ' +   // name
        'WHERE hol_id = :ID';
      frmMain.QRY.Params.ParamByName('ID').AsInteger := VST.Tag;
    end;

    frmMain.QRY.Params.ParamByName('DAY').AsInteger := spiDay.Value;
    frmMain.QRY.Params.ParamByName('MONTH').AsInteger := lbxMonth.ItemIndex + 1;
    frmMain.QRY.Params.ParamByName('NAME').AsString := memComment.Text;
    frmMain.QRY.Prepare;
    frmMain.QRY.ExecSQL;
    frmMain.Tran.Commit;

    UpdateHolidays;
    btnCancelClick(btnCancel);
    if btnSave.Tag = 0 then
      FindNewRecord(VST, 3)
    else
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

procedure TfrmHolidays.splListCanResize(Sender: TObject);
begin
  imgWidth.ImageIndex := 3;
  lblWidth.Caption := IntToStr(frmHolidays.Width - pnlDetail.Width);

  imgHeight.ImageIndex := 2;
  lblHeight.Caption := IntToStr(pnlDetail.Width);

  pnlListCaption.Repaint;
  pnlDetailCaption.Repaint;
end;

procedure TfrmHolidays.btnExitClick(Sender: TObject);
begin
  frmHolidays.Close;
end;

procedure TfrmHolidays.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var
  INI: TINIFile;
  INIFile: string;

begin
  if (pnlDetail.Enabled = True) then
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
      if INI.ReadString('POSITION', frmHolidays.Name, '') <>
          IntToStr(frmHolidays.Left) + separ + // form left
          IntToStr(frmHolidays.Top) + separ + // form top
          IntToStr(frmHolidays.Width) + separ + // form width
          IntToStr(frmHolidays.Height) + separ + // form height
          IntToStr(frmHolidays.pnlDetail.Width) then
        INI.WriteString('POSITION', frmHolidays.Name,
          IntToStr(frmHolidays.Left) + separ + // form left
          IntToStr(frmHolidays.Top) + separ + // form top
          IntToStr(frmHolidays.Width) + separ + // form width
          IntToStr(frmHolidays.Height) + separ + // form height
          IntToStr(frmHolidays.pnlDetail.Width));
    finally
      INI.Free;
    end;
  end;
end;

procedure TfrmHolidays.FormResize(Sender: TObject);
begin
  imgWidth.ImageIndex := 0;
  lblWidth.Caption := IntToStr(frmHolidays.Width);
  imgHeight.ImageIndex := 1;
  lblHeight.Caption := IntToStr(frmHolidays.Height);

  pnlButtons.Repaint;
  pnlButton.Repaint;
  pnlListCaption.Repaint;
  pnlDetailCaption.Repaint;
end;

procedure TfrmHolidays.FormShow(Sender: TObject);
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
      frmHolidays.Position := poDesigned;
      S := INI.ReadString('POSITION', frmHolidays.Name, '-1•-1•0•0•200');

      // width
      TryStrToInt(Field(Separ, S, 3), I);
      if (I < 1) or (I > Screen.Width) then
        frmHolidays.Width := Screen.Width div 2
      else
        frmHolidays.Width := I;

      /// height
      TryStrToInt(Field(Separ, S, 4), I);
      if (I < 1) or (I > Screen.Height) then
        frmHolidays.Height := Screen.Height div 2
      else
        frmHolidays.Height := I;

      // left
      TryStrToInt(Field(Separ, S, 1), I);
      if (I < 0) or (I > Screen.Width) then
        frmHolidays.left := (Screen.Width - frmHolidays.Width) div 2
      else
        frmHolidays.Left := I;

      // top
      TryStrToInt(Field(Separ, S, 2), I);
      if (I < 0) or (I > Screen.Height) then
        frmHolidays.Top := ((Screen.Height - frmHolidays.Height) div 2) - 75
      else
        frmHolidays.Top := I;

      // detail panel
      TryStrToInt(Field(Separ, S, 5), I);
      if (I < 150) or (I > 350) then
        frmHolidays.pnlDetail.Width := 220
      else
        frmHolidays.pnlDetail.Width := I;
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

  SetNodeHeight(VST);
  VST.SetFocus;
  VST.ClearSelection;
  spiDay.Clear;
  lbxMonth.ItemIndex := -1;
  memComment.Clear;
end;

procedure TfrmHolidays.VSTDblClick(Sender: TObject);
begin
  if frmMain.Conn.Connected = False then Exit;

  if VST.SelectedCount = 1 then
    btnEditClick(btnEdit)
  else if VST.SelectedCount = 0 then
    btnAddClick(btnAdd);
end;

procedure TfrmHolidays.pnlButtonResize(Sender: TObject);
begin
  btnCancel.Width := (pnlButton.Width - 6) div 2;
end;

procedure TfrmHolidays.pnlButtonsResize(Sender: TObject);
begin
  btnEdit.Width := (pnlButtons.Width - 10) div 7;
  btnDelete.Width := btnEdit.Width;
  btnCopy.Width := btnEdit.Width;
  btnPrint.Width := btnEdit.Width;
  btnExit.Width := btnEdit.Width;
  btnSelect.Width := btnEdit.Width;
end;

procedure UpdateHolidays;
var
  Holiday: PHoliday;
  P: PVirtualNode;
begin
  try
    frmHolidays.VST.Clear;
    frmHolidays.VST.RootNodeCount := 0;

    // =============================================================================================
    // update list of Holidays in form Holidays
    if frmMain.Conn.Connected = False then
      Exit;

    screen.Cursor := crHourGlass;
    frmHolidays.VST.BeginUpdate;

    frmMain.QRY.SQL.Text := 'SELECT hol_month, hol_day, hol_name, hol_time, hol_ID ' +
      'FROM holidays ORDER BY hol_month, hol_day;';
    frmMain.QRY.Open;
    while not (frmMain.QRY.EOF) do
    begin
      frmHolidays.VST.RootNodeCount := frmHolidays.VST.RootNodeCount + 1;
      P := frmHolidays.VST.GetLast();
      Holiday := frmHolidays.VST.GetNodeData(P);
      Holiday.Month := frmMain.QRY.Fields[0].AsInteger;
      Holiday.Day := frmMain.QRY.Fields[1].AsInteger;
      Holiday.Name := frmMain.QRY.Fields[2].AsString;
      Holiday.Time := frmMain.QRY.Fields[3].AsString;
      Holiday.ID := frmMain.QRY.Fields[4].AsInteger;

      frmMain.QRY.Next;
    end;
    frmMain.QRY.Close;

    frmHolidays.VST.EndUpdate;
    screen.Cursor := crDefault;

    // ==============================================================================================
    // items icon
    frmHolidays.lblItems.Caption := IntToStr(frmHolidays.VST.RootNodeCount);

    frmHolidays.popCopy.Enabled := frmHolidays.VST.RootNodeCount > 0;
    frmHolidays.btnCopy.Enabled := frmHolidays.popCopy.Enabled;
    frmHolidays.btnSelect.Enabled := frmHolidays.VST.RootNodeCount > 0;
    frmHolidays.popPrint.Enabled := frmHolidays.popCopy.Enabled;
    frmHolidays.btnPrint.Enabled := frmHolidays.popCopy.Enabled;
    frmHolidays.popEdit.Enabled := False;
    frmHolidays.btnEdit.Enabled := False;
    frmHolidays.popDelete.Enabled := False;
    frmHolidays.btnDelete.Enabled := False;

    frmHolidays.spiDay.Clear;
    frmHolidays.lbxMonth.ItemIndex := -1;
    frmHolidays.memComment.Clear;

    if (frmHolidays.Visible = True) and (frmHolidays.VST.Enabled = True) then
      frmHolidays.VST.SetFocus;

    if frmProperties.Visible = True then frmProperties.FormShow(frmProperties);
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

end.
