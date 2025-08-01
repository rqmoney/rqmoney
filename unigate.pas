unit uniGate;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, BCPanel, BCMDButtonFocus;

type

  { TfrmGate }

  TfrmGate = class(TForm)
    btn0: TBCMDButtonFocus;
    btn1: TBCMDButtonFocus;
    btn2: TBCMDButtonFocus;
    btn3: TBCMDButtonFocus;
    btn4: TBCMDButtonFocus;
    btn5: TBCMDButtonFocus;
    btn6: TBCMDButtonFocus;
    btn7: TBCMDButtonFocus;
    btn8: TBCMDButtonFocus;
    btn9: TBCMDButtonFocus;
    btnBack: TBCMDButtonFocus;
    btnOK: TBCMDButtonFocus;
    ediGate: TEdit;
    imgHeight: TImage;
    imgWidth: TImage;
    lblGate: TLabel;
    lblHeight: TLabel;
    lblWidth: TLabel;
    Panel1: TPanel;
    Panel13: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    pnlBottom: TPanel;
    pnlFileName: TPanel;
    Panel5: TPanel;
    Panel9: TPanel;
    pnlHeight: TPanel;
    pnlNumeric: TPanel;
    lblFileName1: TStaticText;
    lblFileName2: TStaticText;
    pnlCaption: TBCPanel;
    pnlWidth: TPanel;
    procedure btn0Click(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure btnBackClick(Sender: TObject);
    procedure ediGateChange(Sender: TObject);
    procedure ediGateExit(Sender: TObject);
    procedure ediGateKeyPress(Sender: TObject; var Key: char);
    procedure ediGateKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure pnlNumericResize(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmGate: TfrmGate;

implementation

uses
  uniMain, uniSplash;

  {$R *.lfm}

  { TfrmGate }

procedure TfrmGate.FormKeyPress(Sender: TObject; var Key: char);
begin
  if Ord(Key) = 27 then
    frmGate.Close;
end;

procedure TfrmGate.FormResize(Sender: TObject);
begin
  pnlCaption.Repaint;

  lblWidth.Caption := IntToStr((Sender as TForm).Width);
  lblHeight.Caption := IntToStr((Sender as TForm).Height);

  pnlNumeric.Width := frmGate.Width div 5 * 2;

  pnlCaption.Repaint;
  pnlNumeric.Repaint;
  btnOK.Repaint;
end;

procedure TfrmGate.FormShow(Sender: TObject);
begin
  if frmSplash.Visible = True then
    begin
    frmSplash.Hide;
    frmSplash.Tag := 1;
    end;
  ediGate.Clear;
  btnOK.Enabled := False;
  ediGate.SetFocus;
end;

procedure TfrmGate.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  If frmSplash.Tag = 1 then
  begin
    frmSplash.Tag := 0;
    frmSplash.Show;
  end;
end;

procedure TfrmGate.pnlNumericResize(Sender: TObject);
begin
  try
    btn0.Width := (Panel1.Width - 8) div 3;
    btn1.Width := btn0.Width;
    btn4.Width := btn0.Width;
    btn7.Width := btn0.Width;
    btn9.Width := btn0.Width;
    btn6.Width := btn0.Width;
    btn3.Width := btn0.Width;

    Panel1.Height := (pnlNumeric.Height - 15) div 4;
    Panel5.Height := Panel1.Height;
    Panel9.Height := Panel1.Height;
  except
  end;
end;

procedure TfrmGate.FormCreate(Sender: TObject);
begin
  frmGate.Caption := Application.Title;
  frmMain.img16.GetIcon(5, (Sender as TForm).Icon);
  btn0.Caption := IntToStr(btn0.Tag);
  btn1.Caption := IntToStr(btn1.Tag);
  btn2.Caption := IntToStr(btn2.Tag);
  btn3.Caption := IntToStr(btn3.Tag);
  btn4.Caption := IntToStr(btn4.Tag);
  btn5.Caption := IntToStr(btn5.Tag);
  btn6.Caption := IntToStr(btn6.Tag);
  btn7.Caption := IntToStr(btn7.Tag);
  btn8.Caption := IntToStr(btn8.Tag);
  btn9.Caption := IntToStr(btn9.Tag);

  // set components height
  pnlCaption.Height := PanelHeight;
  pnlBottom.Height := ButtonHeight + 2;

  // get form icon
  frmMain.img16.GetIcon(5, (Sender as TForm).Icon);
end;

procedure TfrmGate.btn0Click(Sender: TObject);
var
  Str: string;
begin
  Str := ediGate.Text;
  Insert((Sender as TBCMDButtonFocus).Caption, Str, lblGate.Tag + 1);
  ediGate.Text := Str;
  ediGate.SetFocus;
  ediGate.SelStart := lblGate.Tag + 1;
end;

procedure TfrmGate.btnOKClick(Sender: TObject);
begin
  frmGate.ModalResult := mrOk;
end;

procedure TfrmGate.btnBackClick(Sender: TObject);
var
  Str: ansistring;
begin
  Str := ediGate.Text;
  Delete(Str, lblGate.Tag, 1);
  ediGate.Text := Str;
  ediGate.SetFocus;
  ediGate.SelStart := lblGate.Tag - 1;
  frmGate.Caption := str + ' - ' + ediGate.Text;
end;

procedure TfrmGate.ediGateChange(Sender: TObject);
begin
  btnBack.Enabled := Length(ediGate.Text) > 0;
end;

procedure TfrmGate.ediGateExit(Sender: TObject);
begin
  lblGate.Tag := (Sender as TEdit).SelStart;
end;

procedure TfrmGate.ediGateKeyPress(Sender: TObject; var Key: char);
begin
  if Ord(Key) = 13 then
  begin
    Key := Chr(0);
    btnOKClick(btnOK);
  end;
end;

procedure TfrmGate.ediGateKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  btnOK.Enabled := Length(ediGate.Text) > 4;
end;

end.
