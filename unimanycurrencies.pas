unit uniManyCurrencies;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  ActnList, BCPanel, BCMDButtonFocus, StrUtils;

type

  { TfrmManyCurrencies }

  TfrmManyCurrencies = class(TForm)
    actExit: TAction;
    ActionList1: TActionList;
    btnCancel: TBCMDButtonFocus;
    btnSave: TBCMDButtonFocus;
    cbxCurrency: TComboBox;
    imgHeight: TImage;
    imgWidth: TImage;
    lblHeight: TLabel;
    lblManyCurrencies: TLabel;
    lblWidth: TLabel;
    pnlBottom: TPanel;
    pnlButtons: TPanel;
    pnlHeight: TPanel;
    pnlManyCurrenciesCaption: TBCPanel;
    pnlWidth: TPanel;
    procedure btnCancelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure cbxCurrencyChange(Sender: TObject);
    procedure cbxCurrencyEnter(Sender: TObject);
    procedure cbxCurrencyExit(Sender: TObject);
    procedure cbxCurrencyKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  frmManyCurrencies: TfrmManyCurrencies;

implementation

{$R *.lfm}

uses
  uniMain, uniCurrencies;

{ TfrmManyCurrencies }

procedure TfrmManyCurrencies.cbxCurrencyChange(Sender: TObject);
begin
  btnSave.Enabled := cbxCurrency.ItemIndex > -1;
end;

procedure TfrmManyCurrencies.cbxCurrencyEnter(Sender: TObject);
begin
  cbxCurrency.Font.Bold := True;
end;

procedure TfrmManyCurrencies.cbxCurrencyExit(Sender: TObject);
begin
  cbxCurrency.Font.Bold := False;
end;

procedure TfrmManyCurrencies.cbxCurrencyKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If Key = 13 then begin
    Key := 0;
    If cbxCurrency.ItemIndex > -1 then
      btnSave.SetFocus;
  end;
end;

procedure TfrmManyCurrencies.FormCreate(Sender: TObject);
begin
  try
  // set component height
  pnlManyCurrenciesCaption.Height := PanelHeight;
  pnlButtons.Height := ButtonHeight;
  pnlBottom.Height := ButtonHeight;

  // get form icon
  frmMain.img16.GetIcon(12, (Sender as TForm).Icon);

  except
  end;
end;

procedure TfrmManyCurrencies.FormResize(Sender: TObject);
begin
  try
    lblWidth.Caption := IntToStr(frmManyCurrencies.Width);
    lblHeight.Caption := IntToStr(frmManyCurrencies.Height);

    pnlManyCurrenciesCaption.Repaint;
    pnlButtons.Repaint;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmManyCurrencies.FormShow(Sender: TObject);
{var
  INI: TINIFile;
  S: string;
  I: integer;}
begin
  // ********************************************************************
  // FORM SIZE START
  // ********************************************************************
{  try
    S := ChangeFileExt(ParamStr(0), '.ini');
    // INI file READ procedure (if file exists) =========================
    if FileExists(S) = True then
    begin
      INI := TINIFile.Create(S);
      frmManyCurrencies.Position := poDesigned;
      S := INI.ReadString('POSITION', frmManyCurrencies.Name, '-1•-1•0•0');

      // width
      TryStrToInt(Field(Separ, S, 3), I);
      if (I < 1) or (I > Screen.Width) then
        frmManyCurrencies.Width := Round(350 * (ScreenRatio / 100))
      else
        frmManyCurrencies.Width := I;

      /// height
      TryStrToInt(Field(Separ, S, 4), I);
      if (I < 1) or (I > Screen.Height) then
        frmManyCurrencies.Height := Round(170 * (ScreenRatio / 100))
      else
        frmManyCurrencies.Height := I;

      // left
      TryStrToInt(Field(Separ, S, 1), I);
      if (I < 0) or (I > Screen.Width) then
        frmManyCurrencies.left := (Screen.Width - frmManyCurrencies.Width) div 2
      else
        frmManyCurrencies.Left := I;

      // top
      TryStrToInt(Field(Separ, S, 2), I);
      if (I < 0) or (I > Screen.Height) then
        frmManyCurrencies.Top := ((Screen.Height - frmManyCurrencies.Height) div 2) - 75
      else
        frmManyCurrencies.Top := I;
    end;
  finally
    INI.Free
  end;}
  // ********************************************************************
  // FORM SIZE END
  // ********************************************************************
end;

procedure TfrmManyCurrencies.btnCancelClick(Sender: TObject);
begin
  frmManyCurrencies.Close;
end;

procedure TfrmManyCurrencies.btnSaveClick(Sender: TObject);
begin
  frmMain.QRY.SQL.Text :=
    'UPDATE currencies SET ' + // update
    'cur_default = 0;'; // all
  frmMain.QRY.ExecSQL;
  frmMain.Tran.Commit;

  frmMain.QRY.SQL.Text :=
    'UPDATE currencies SET ' + // update
    'cur_default = 1 ' + // one main currency
    'WHERE cur_code = "' + AnsiReplaceStr(Field(separ_1, cbxCurrency.Items[cbxCurrency.ItemIndex], 1), '"', '""') + '"';
  frmMain.QRY.ExecSQL;
  frmMain.Tran.Commit;
  frmManyCurrencies.Close;

  UpdateCurrencies;
end;

end.

