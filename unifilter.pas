unit uniFilter;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, CheckLst,
  ExtCtrls, StdCtrls, Buttons, BCMDButtonFocus, BCPanel;

type

  { TfrmFilter }

  TfrmFilter = class(TForm)
    btnApplyFilter: TBCMDButtonFocus;
    chkFilter:TCheckListBox;
    chkSelectAll: TCheckBox;
    imgHeight: TImage;
    imgChecked: TImage;
    imgWidth: TImage;
    lblHeight: TLabel;
    lblChecked: TLabel;
    lblWidth: TLabel;
    pnlButtons:TPanel;
    pnlHeight: TPanel;
    pnlFilterCaption: TBCPanel;
    pnlBottom: TPanel;
    pnlChecked: TPanel;
    pnlWidth: TPanel;
    procedure btnAllClick(Sender:TObject);
    procedure btnApplyFilterClick(Sender: TObject);
    procedure chkFilterClickCheck(Sender:TObject);
    procedure chkSelectAllChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender:TObject; var Key:char);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure pnlBottomResize(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmFilter: TfrmFilter;

implementation

{$R *.lfm}

uses
  uniMain;

{ TfrmFilter }

procedure TfrmFilter.FormKeyPress(Sender:TObject; var Key:char);
begin
  If Ord(Key) = 27 Then frmFilter.ModalResult := mrClose;
end;

procedure TfrmFilter.FormResize(Sender: TObject);
begin
  pnlFilterCaption.Repaint;
  btnApplyFilter.Repaint;

  imgWidth.ImageIndex := 0;
  lblWidth.Caption := IntToStr((Sender as TForm).Width);

  imgHeight.ImageIndex := 1;
  lblHeight.Caption := IntToStr((Sender as TForm).Height);
end;

procedure TfrmFilter.FormShow(Sender: TObject);
begin
  frmFilter.Caption := frmMain.pnlFilterCaption.Caption;
end;

procedure TfrmFilter.pnlBottomResize(Sender: TObject);
begin
  pnlWidth.Width := pnlBottom.Width div 3;
  pnlHeight.Width := pnlBottom.Width div 3;
end;

procedure TfrmFilter.chkFilterClickCheck(Sender:TObject);
var
  X, Z: Word;

begin
  // check if minimum one item is checked
  Z := 0;
  For X := 0 to chkFilter.Items.Count - 1 do
    If chkFilter.Checked[X] = True then Inc(Z);
  chkFilter.Tag := Z;
  lblChecked.Caption := IntToStr(Z);
  btnApplyFilter.Enabled := Z > 0;
  //lblChecked.Caption := IntToStr(Z) + ' / ' + IntToStr(chkFilter.Items.Count);
end;

procedure TfrmFilter.chkSelectAllChange(Sender: TObject);
begin
  If chkSelectAll.Checked = True then
    chkFilter.CheckAll(cbChecked, False, False)
  Else
    chkFilter.CheckAll(cbUnchecked, False, False);
  chkFilterClickCheck(chkFilter);
end;

procedure TfrmFilter.FormCreate(Sender: TObject);
begin
  {$IFDEF WINDOWS}
  // set components height
  pnlFilterCaption.Height := PanelHeight;
  pnlButtons.Height := ButtonHeight;
  pnlBottom.Height := ButtonHeight;
  {$ENDIF}
end;

procedure TfrmFilter.btnAllClick(Sender:TObject);
var
  W: Word;

begin
  For W := 0 to chkFilter.Items.Count - 1 do
    chkFilter.Checked[W] := (Sender as TBitBtn).Tag = 1;
  chkFilterClickCheck(chkFilter);
end;

procedure TfrmFilter.btnApplyFilterClick(Sender: TObject);
begin
  frmFilter.ModalResult := mrOK;
end;

end.

