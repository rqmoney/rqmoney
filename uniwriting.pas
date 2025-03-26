unit uniwriting;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls, BCMDButtonFocus,
  ActnList;

type

  { TfrmWriting }

  TfrmWriting = class(TForm)
    actExit: TAction;
    actWrite: TActionList;
    actSave: TAction;
    btnCancel: TBCMDButtonFocus;
    btnWrite: TBCMDButtonFocus;
    imgHeight: TImage;
    imgWidth: TImage;
    lblHeight: TLabel;
    lblWidth: TLabel;
    lblWrite: TLabel;
    pnlBottom: TPanel;
    pnlHeight: TPanel;
    pnlWidth: TPanel;
    pnlWrite: TPanel;
    pnlButtons: TPanel;
    rbtWriteAtOnce: TRadioButton;
    rbtWriteGradually: TRadioButton;
    procedure btnCancelClick(Sender: TObject);
    procedure btnWriteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  frmWriting: TfrmWriting;

implementation

{$R *.lfm}

uses
  uniMain;

{ TfrmWriting }

procedure TfrmWriting.btnWriteClick(Sender: TObject);
begin
  frmWriting.ModalResult := mrOK;
end;

procedure TfrmWriting.FormCreate(Sender: TObject);
begin
  // set component size
  pnlButtons.Height := ButtonHeight;
  pnlBottom.Height := ButtonHeight;

  // get form icon
  frmMain.img16.GetIcon(19, (Sender as TForm).Icon);
end;

procedure TfrmWriting.FormKeyPress(Sender: TObject; var Key: char);
begin
  If Key = Chr(27) then
    btnCancelClick(btnCancel);
  If (Key = Chr(13)) and (btnWrite.Focused = False) then begin
    Key := Chr(0);
    btnWrite.SetFocus;
  end;
end;

procedure TfrmWriting.FormResize(Sender: TObject);
begin
  lblWidth.Caption := IntToStr((Sender as TForm).Width);
  lblHeight.Caption := IntToStr((Sender as TForm).Height);
end;

procedure TfrmWriting.FormShow(Sender: TObject);
begin
  rbtWriteAtOnce.SetFocus;
end;

procedure TfrmWriting.btnCancelClick(Sender: TObject);
begin
  frmWriting.ModalResult := mrCancel;
end;

end.

