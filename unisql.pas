unit uniSQL;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, ComCtrls,
  Buttons, StdCtrls, LazUTF8, ActnList, BCPanel, BCMDButtonFocus, StrUtils,
  IniFiles;

type

  { TfrmSQL }

  TfrmSQL = class(TForm)
    actExit: TAction;
    ActionList1: TActionList;
    btnDiagram: TBCMDButtonFocus;
    btnExit: TBCMDButtonFocus;
    btnExecute: TBCMDButtonFocus;
    imgHeight: TImage;
    imgWidth: TImage;
    lblHeight: TLabel;
    lblWidth: TLabel;
    memSQL: TMemo;
    pnlBottom: TPanel;
    pnlCaption: TBCPanel;
    pnlCaption1: TBCPanel;
    pnlCaption2: TBCPanel;
    pnlHeight: TPanel;
    pnlSQL: TPanel;
    pnlButtons: TPanel;
    pnlList: TPanel;
    pnlWidth: TPanel;
    rbtMaster: TRadioButton;
    rbtData: TRadioButton;
    rbtVacuum: TRadioButton;
    rbtOwn: TRadioButton;
    lblCommand: TStaticText;
    procedure btnDiagramClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure btnExecuteClick(Sender: TObject);
    procedure btnExecuteEnter(Sender: TObject);
    procedure btnExecuteExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure memSQLChange(Sender: TObject);
    procedure rbtDataChange(Sender: TObject);
    procedure rbtMasterChange(Sender: TObject);
    procedure rbtOwnChange(Sender: TObject);
    procedure rbtVacuumChange(Sender: TObject);
  private

  public

  end;

var
  frmSQL: TfrmSQL;

implementation

{$R *.lfm}

uses
  uniMain, uniSQLResults, uniResources, uniImage, uniSettings;

  { TfrmSQL }

procedure TfrmSQL.FormCreate(Sender: TObject);
begin
  memSQL.Enabled := True;
  memSQL.ReadOnly := False;
  memSQL.Text := 'SELECT * FROM ';

  // set components height
  pnlCaption.Height := PanelHeight;
  pnlCaption1.Height := PanelHeight;
  pnlCaption2.Height := PanelHeight;
  memSQL.Font.Height := PanelHeight;
  pnlButtons.Height := ButtonHeight;
  pnlBottom.Height := ButtonHeight;

  // get form icon
  frmMain.img16.GetIcon(7, (Sender as TForm).Icon);

  rbtOwn.Checked := True;
  rbtOwnChange(rbtOwn);
end;

procedure TfrmSQL.FormResize(Sender: TObject);
begin
  lblWidth.Caption := IntToStr((Sender as TForm).Width);
  lblHeight.Caption := IntToStr((Sender as TForm).Height);

  pnlCaption.Repaint;
  pnlCaption1.Repaint;
  pnlCaption2.Repaint;
end;

procedure TfrmSQL.FormShow(Sender: TObject);
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
      frmSQL.Position := poDesigned;
      S := INI.ReadString('POSITION', frmSQL.Name, '-1•-1•0•0');

      // width
      TryStrToInt(Field(Separ, S, 3), I);
      if (I < 1) or (I > Screen.Width) then
        frmSQL.Width := Screen.Width - 500 - (200 - ScreenRatio)
      else
        frmSQL.Width := I;

      /// height
      TryStrToInt(Field(Separ, S, 4), I);
      if (I < 1) or (I > Screen.Height) then
        frmSQL.Height := Screen.Height - 300 - (200 - ScreenRatio)
      else
        frmSQL.Height := I;

      // left
      TryStrToInt(Field(Separ, S, 1), I);
      if (I < 0) or (I > Screen.Width) then
        frmSQL.left := (Screen.Width - frmSQL.Width) div 2
      else
        frmSQL.Left := I;

      // top
      TryStrToInt(Field(Separ, S, 2), I);
      if (I < 0) or (I > Screen.Height) then
        frmSQL.Top := ((Screen.Height - frmSQL.Height) div 2) - 75
      else
        frmSQL.Top := I;
    end;
  finally
    INI.Free
  end;
  // ********************************************************************
  // FORM SIZE END
  // ********************************************************************

  if (memSQL.Enabled = True) and (rbtOwn.Checked = True) then
  begin
    memSQL.SetFocus;
    memSQL.SelStart := 14;
  end;
end;

procedure TfrmSQL.memSQLChange(Sender: TObject);
begin
  btnExecute.Enabled := (rbtOwn.Checked = False) or
    ((Length(memSQL.Text) > 0) and (rbtOwn.Checked = True));
end;

procedure TfrmSQL.btnExitClick(Sender: TObject);
begin
  frmSQL.Close;
end;

procedure TfrmSQL.btnDiagramClick(Sender: TObject);
begin
  frmImage.ShowModal;
end;

procedure TfrmSQL.btnExecuteClick(Sender: TObject);
var
  I: integer;
begin
  // VACUUM commant ========================================================
  if rbtVacuum.Checked = True then
  begin
    Vacuum;
    ShowMessage(Message_05);
    Exit;
  end;
  // =======================================================================

  if LowerCase(LeftStr(memSQL.Text, 7)) = 'select ' then
  begin
    try
      frmMain.QRY.SQL.Text := AnsiReplaceStr(memSQL.Text, sLineBreak, ' ');
      frmMain.QRY.Open; // get data
      frmMain.QRY.Last;
    except
      begin
        ShowMessage(Error_19);
        Exit;
      end;
    end;

    I := frmMain.QRY.RecordCount;

    // if there are no required data
    if I = 0 then
    begin
      frmMain.QRY.Close;
      ShowMessage(Error_19);
      Exit;
    end;

    // if columns count > 255
    if frmMain.QRY.FieldCount > 255 then
    begin
      frmMain.QRY.Close;
      ShowMessage(Error_23);
      Exit;
    end;
    frmMain.QRY.First;

    frmSQLResult.ShowModal;
  end
  else
  begin
    try
      frmMain.QRY.SQL.Text := memSQL.Text;
      frmMain.QRY.ExecSQL;
      frmMain.Tran.Commit;
    except
      Exit;
    end;
    ShowMessage(Message_05);
  end;
end;

procedure TfrmSQL.btnExecuteEnter(Sender: TObject);
begin
  (Sender as TBitBtn).Font.Style := [fsBold];
end;

procedure TfrmSQL.btnExecuteExit(Sender: TObject);
begin
  (Sender as TBitBtn).Font.Style := [];
end;

procedure TfrmSQL.FormClose(Sender: TObject; var CloseAction: TCloseAction);
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
        if INI.ReadString('POSITION', frmSQL.Name, '') <>
          IntToStr(frmSQL.Left) + separ + // form left
        IntToStr(frmSQL.Top) + separ + // form top
        IntToStr(frmSQL.Width) + separ + // form width
        IntToStr(frmSQL.Height) then
          INI.WriteString('POSITION', frmSQL.Name,
            IntToStr(frmSQL.Left) + separ + // form left
            IntToStr(frmSQL.Top) + separ + // form top
            IntToStr(frmSQL.Width) + separ + // form width
            IntToStr(frmSQL.Height));
      finally
        INI.Free;
      end;
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmSQL.rbtDataChange(Sender: TObject);
begin
  if (rbtData.Checked = True) and (frmSQL.Visible = True) then
  begin
    memSQL.Enabled := True;
    memSQL.ReadOnly := True;
    memSQL.Text :=
      'SELECT d_date, d_sum, d_comment, acc_currency, ' +
      'acc_name, cat_parent_name, cat_name, ' + // fields
      'per_name, pee_name, d_time, d_id, d_type, d_order ' + sLineBreak +// other fields
      'FROM data ' + sLineBreak + // FROM tables
      'LEFT JOIN ' + sLineBreak + // JOIN
      'accounts ON (acc_id = d_account), ' + sLineBreak + // accounts
      'categories ON (cat_id = d_category), ' + sLineBreak + // categories
      'persons ON (per_id = d_person), ' + sLineBreak + // categories
      'payees ON (pee_id = d_payee) ' + sLineBreak + // categories
      'ORDER BY d_date DESC, d_id DESC;'; // ORDER/
    memSQL.Font.Color := clGray;
  end;
end;

procedure TfrmSQL.rbtMasterChange(Sender: TObject);
begin
  if (rbtMaster.Checked = True) and (frmSQL.Visible = True) then
  begin
    memSQL.Enabled := True;
    memSQL.ReadOnly := True;
    memSQL.Text := 'SELECT * FROM sqlite_master;';
    memSQL.Font.Color := clGray;
  end;
end;

procedure TfrmSQL.rbtOwnChange(Sender: TObject);
begin
  if (rbtOwn.Checked = True) then
  begin
    memSQL.Enabled := True;
    memSQL.ReadOnly := False;
    memSQL.Text := 'SELECT * FROM ';
    if (frmSQL.Visible = True) then
      memSQL.SetFocus;
    memSQL.SelStart := 14;
    memSQL.Font.Color := FullColor;
  end;
end;

procedure TfrmSQL.rbtVacuumChange(Sender: TObject);
begin
  if (rbtVacuum.Checked = True) and (frmSQL.Visible = True) then
  begin
    memSQL.Enabled := True;
    memSQL.ReadOnly := True;
    memSQL.Text := 'VACUUM';
    memSQL.Font.Color := clGray;
  end;
end;

end.
