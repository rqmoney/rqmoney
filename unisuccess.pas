unit uniSuccess;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, Buttons, ActnList, BCPanel, BCMDButtonFocus, Math;

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
    lblImport: TLabel;
    lblChoice:TLabel;
    lblPassword: TLabel;
    lblGuide: TLabel;
    lblCancel: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    pnlSuccessCaption: TBCPanel;
    pnlSuccess:TPanel;
    procedure actExitExecute(Sender: TObject);
    procedure btnGuideClick(Sender:TObject);
    procedure btnImportClick(Sender: TObject);
    procedure btnPasswordClick(Sender:TObject);
    procedure FormCreate(Sender: TObject);

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
  {$IFDEF WINDOWS}
  pnlSuccessCaption.Height := PanelHeight;
  btnPassword.Height := ButtonHeight;
  btnGuide.Height := ButtonHeight;
  btnCancel.Height := ButtonHeight;
  btnImport.Height := ButtonHeight;
  {$ENDIF}
end;

end.

