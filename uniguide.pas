unit uniGuide;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Buttons, BCPanel, BCMDButtonFocus, Math;

type

  { TfrmGuide }

  TfrmGuide = class(TForm)
    btnAccount: TBitBtn;
    btnBack: TBCMDButtonFocus;
    btnCategory: TBitBtn;
    btnNext: TBCMDButtonFocus;
    btnPayee: TBitBtn;
    btnPerson: TBitBtn;
    btnTransaction: TBitBtn;
    imgHeight: TImage;
    imgWidth: TImage;
    lblHeight: TLabel;
    lblTip: TLabel;
    lblWidth: TLabel;
    notGuide: TNotebook;
    pagAccount: TPage;
    pagCategory: TPage;
    pagFinish: TPage;
    pagPayee: TPage;
    pagPerson: TPage;
    pagTransaction: TPage;
    pagWelcome: TPage;
    pnlAccount: TPanel;
    pnlButtons: TPanel;
    pnlCategory: TPanel;
    pnlGuideCaption: TBCPanel;
    pnlHeight: TPanel;
    pnlList: TScrollBox;
    pnlPayee: TPanel;
    pnlPerson: TPanel;
    pnlBottom: TPanel;
    pnlTip: TPanel;
    pnlTransaction: TPanel;
    pnlWidth: TPanel;
    txtAccount: TLabel;
    txtCategory: TLabel;
    txtFinish: TLabel;
    txtPayee: TLabel;
    txtPerson: TLabel;
    txtTransaction: TLabel;
    txtWelcome: TLabel;
    procedure btnAccountClick(Sender: TObject);
    procedure btnBackClick(Sender: TObject);
    procedure btnCategoryClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure btnPayeeClick(Sender: TObject);
    procedure btnPersonClick(Sender: TObject);
    procedure btnTransactionClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmGuide: TfrmGuide;

implementation

{$R *.lfm}

uses
  uniPersons, uniAccounts, uniCategories, uniPayees, uniMain;

  { TfrmGuide }

procedure TfrmGuide.FormResize(Sender: TObject);
begin
  try
    lblWidth.Caption := IntToStr((Sender as TForm).Width);
    lblHeight.Caption := IntToStr((Sender as TForm).Height);

    pnlGuideCaption.Repaint;
  except
    on E: Exception do
      ShowMessage(E.Message + sLineBreak + E.ClassName + sLineBreak + E.UnitName);
  end;
end;

procedure TfrmGuide.FormShow(Sender: TObject);
begin
  if pnlButtons.Tag = 0 then
  begin
    frmGuide.Tag := 0;
    lblTip.Caption := IntToStr(frmGuide.Tag + 1) + ' / 7';
    notGuide.PageIndex := 0;
    notGuide.Tag := 0;
    btnBack.Visible := False;
    btnNext.Visible := True;
  end
  else
    pnlButtons.Tag := 0;
end;

procedure TfrmGuide.FormKeyPress(Sender: TObject; var Key: char);
begin
  if Ord(Key) = 27 then
    frmGuide.Close;
end;

procedure TfrmGuide.btnNextClick(Sender: TObject);
begin
  frmGuide.Tag := frmGuide.Tag + 1;
  notGuide.PageIndex := frmGuide.Tag;
  btnBack.Visible := frmGuide.Tag > 0;
  btnNext.Visible := frmGuide.Tag < notGuide.PageCount - 1;
  lblTip.Caption := IntToStr(frmGuide.Tag + 1) + ' / 7';
end;

procedure TfrmGuide.btnPayeeClick(Sender: TObject);
begin
  frmPayees.ShowModal;
end;

procedure TfrmGuide.btnPersonClick(Sender: TObject);
begin
  frmPersons.ShowModal;
end;

procedure TfrmGuide.btnTransactionClick(Sender: TObject);
begin
  frmMain.btnAddClick(frmMain.btnAdd);
end;

procedure TfrmGuide.FormCreate(Sender: TObject);
begin
  // form size
  (Sender as TForm).Width :=
    Round((Screen.Width / IfThen(ScreenIndex = 0, 1, (ScreenRatio / 100))) -
    (Round(1220 / (ScreenRatio / 100)) - ScreenRatio));
  (Sender as TForm).Height :=
    Round(Screen.Height / IfThen(ScreenIndex = 0, 1, (ScreenRatio / 100))) -
    4 * (250 - ScreenRatio);

  // form position
  (Sender as TForm).Left := (Screen.Width - (Sender as TForm).Width) div 2;
  (Sender as TForm).Top := (Screen.Height - 100 - (Sender as TForm).Height) div 2;


  lblTip.Caption := '1 / 7';

  // set components height
  {$IFDEF WINDOWS}
  pnlGuideCaption.Height := PanelHeight;
  pnlButtons.Height := ButtonHeight;
  pnlBottom.Height := ButtonHeight;
  {$ENDIF}
end;

procedure TfrmGuide.btnBackClick(Sender: TObject);
begin
  frmGuide.Tag := frmGuide.Tag - 1;
  notGuide.PageIndex := frmGuide.Tag;
  btnBack.Visible := frmGuide.Tag > 0;
  btnNext.Visible := frmGuide.Tag < notGuide.PageCount - 1;
  lblTip.Caption := IntToStr(frmGuide.Tag + 1) + ' / 7';
end;

procedure TfrmGuide.btnCategoryClick(Sender: TObject);
begin
  frmCategories.ShowModal;
end;

procedure TfrmGuide.btnAccountClick(Sender: TObject);
begin
  frmAccounts.ShowModal;
end;

end.
