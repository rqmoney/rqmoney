unit uniSuccess;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, Buttons, ActnList, BCPanel, BCMDButtonFocus;

type

  { TfrmSuccess }

  TfrmSuccess = class(TForm)
    actExit: TAction;
    ActionList1: TActionList;
    btnCancel: TBCMDButtonFocus;
    btnGuide: TBCMDButtonFocus;
    btnImport: TBCMDButtonFocus;
    btnPassword: TBCMDButtonFocus;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    imgHeight: TImage;
    imgWidth: TImage;
    lblHeight: TLabel;
    lblImport: TLabel;
    lblChoice:TLabel;
    lblPassword: TLabel;
    lblGuide: TLabel;
    lblCancel: TLabel;
    lblWidth: TLabel;
    pnlPassword: TPanel;
    pnlGuide: TPanel;
    pnlImport: TPanel;
    pnlCancel: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    pnlBottom: TPanel;
    pnlHeight: TPanel;
    pnlSuccessCaption: TBCPanel;
    pnlSuccess:TPanel;
    pnlWidth: TPanel;
    procedure actExitExecute(Sender: TObject);
    procedure btnGuideClick(Sender:TObject);
    procedure btnImportClick(Sender: TObject);
    procedure btnPasswordClick(Sender:TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure pnlSuccessResize(Sender: TObject);

  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmSuccess: TfrmSuccess;

implementation

{$R *.lfm}

uses
  uniPassword, uniMain, uniGuide;

{ TfrmSuccess }



procedure TfrmSuccess.btnGuideClick(Sender:TObject);
begin
  frmSuccess.Visible := False;
  frmGuide.ShowModal;
  frmSuccess.Visible := True;
end;

procedure TfrmSuccess.actExitExecute(Sender: TObject);
begin
  if frmGuide.Visible = True Then
    Exit;
  frmSuccess.ModalResult := mrCancel;
end;

procedure TfrmSuccess.btnImportClick(Sender: TObject);
begin
  frmMain.mnuImportClick(frmMain.mnuImport);
end;

procedure TfrmSuccess.btnPasswordClick(Sender:TObject);
begin
  frmPassword.ShowModal;
end;

procedure TfrmSuccess.FormCreate(Sender: TObject);
begin
  // size
  pnlSuccessCaption.Height := PanelHeight;
  btnPassword.Height := ButtonHeight;
  btnGuide.Height := ButtonHeight;
  btnCancel.Height := ButtonHeight;
  btnImport.Height := ButtonHeight;
  pnlBottom.Height := ButtonHeight;

  // get form icon
  frmMain.img16.GetIcon(29, (Sender as TForm).Icon);
end;

procedure TfrmSuccess.FormResize(Sender: TObject);
begin
  lblWidth.Caption := IntToStr(frmSuccess.Width);
  lblHeight.Caption := IntToStr(frmSuccess.Height);

  btnGuide.Repaint;
  btnImport.Repaint;
  btnPassword.Repaint;
  btnCancel.Repaint;
  pnlSuccessCaption.Repaint;
end;

procedure TfrmSuccess.pnlSuccessResize(Sender: TObject);
begin
  pnlPassword.Height := (pnlSuccess.Height - 10) div 4;
  pnlImport.Height := pnlPassword.Height;
  pnlGuide.Height := pnlPassword.Height;
  pnlCancel.Height := pnlPassword.Height;
end;

end.

