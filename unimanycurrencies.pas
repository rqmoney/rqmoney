unit uniManyCurrencies;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  ActnList, BCPanel, BCMDButtonFocus, StrUtils, Math;

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
    lblProgress: TLabel;
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
  {// form size
  (Sender as TForm).Width := Round((Screen.Width /
    IfThen(ScreenIndex = 0, 1, (ScreenRatio / 100))) - (Round(1020 / (ScreenRatio / 100)) - ScreenRatio));
  (Sender as TForm).Height := Round(Screen.Height /
    IfThen(ScreenIndex = 0, 1, (ScreenRatio / 100))) - 4 * (250 - ScreenRatio);

  // form position
  (Sender as TForm).Left := (Screen.Width - (Sender as TForm).Width) div 2;
  (Sender as TForm).Top := (Screen.Height - 100 - (Sender as TForm).Height) div 2;)}


  // set components height
  {$IFDEF WINDOWS}
  pnlManyCurrenciesCaption.Height := PanelHeight;
  pnlButtons.Height := ButtonHeight;
  pnlBottom.Height := ButtonHeight;
  {$ENDIF}
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
    'WHERE cur_code = "' + AnsiReplaceStr(Field(' | ', cbxCurrency.Items[cbxCurrency.ItemIndex], 1), '"', '""') + '"';
  frmMain.QRY.ExecSQL;
  frmMain.Tran.Commit;
  frmManyCurrencies.Close;

  UpdateCurrencies;
end;

end.

