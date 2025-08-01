unit uniSQL;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, ComCtrls,
  Buttons, StdCtrls, LazUTF8, ActnList, BCPanel, BCMDButtonFocus, StrUtils, Math;

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
  uniMain, uniSQLResults, uniResources, uniImage;

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
begin
  if (memSQL.Enabled = True) and (rbtOwn.Checked = True) then
  begin
    memSQL.SetFocus;
    memSQL.SelStart := 14;
    memSQL.Font.Color := IfThen(Dark = False, $00C08000, clYellow);
  end
  else
    memSQL.Font.Color := IfThen(Dark = False, clGray, $0000B5BF);
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
    memSQL.Font.Color := IfThen(Dark = False, clGray, $0000B5BF);
  end;
end;

procedure TfrmSQL.rbtMasterChange(Sender: TObject);
begin
  if (rbtMaster.Checked = True) and (frmSQL.Visible = True) then
  begin
    memSQL.Enabled := True;
    memSQL.ReadOnly := True;
    memSQL.Text := 'SELECT * FROM sqlite_master;';
    memSQL.Font.Color := IfThen(Dark = False, clGray, $0000B5BF);
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
    memSQL.Font.Color := IfThen(Dark = False, $00C08000, clYellow);
  end;
end;

procedure TfrmSQL.rbtVacuumChange(Sender: TObject);
begin
  if (rbtVacuum.Checked = True) and (frmSQL.Visible = True) then
  begin
    memSQL.Enabled := True;
    memSQL.ReadOnly := True;
    memSQL.Text := 'VACUUM';
    memSQL.Font.Color := IfThen(Dark = False, clGray, $0000B5BF);
  end;
end;

end.
