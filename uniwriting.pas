unit uniwriting;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls, BCMDButtonFocus,
  ActnList, Math;

type

  { TfrmWriting }

  TfrmWriting = class(TForm)
    actExit: TAction;
    actWrite: TActionList;
    actSave: TAction;
    btnCancel: TBCMDButtonFocus;
    btnWrite: TBCMDButtonFocus;
    lblWrite: TLabel;
    pnlWrite: TPanel;
    pnlButtons: TPanel;
    rbtWriteAtOnce: TRadioButton;
    rbtWriteGradually: TRadioButton;
    procedure btnCancelClick(Sender: TObject);
    procedure btnWriteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: char);
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
  {$IFDEF WINDOWS}
  // form size
  (Sender as TForm).Width := Round(350 * (ScreenRatio / 100));
  (Sender as TForm).Constraints.MinWidth := Round(350 * (ScreenRatio / 100));
  (Sender as TForm).Height := Round(150 * (ScreenRatio / 100));
  (Sender as TForm).Constraints.MinHeight := Round(150 * (ScreenRatio / 100));

  // form position
  (Sender as TForm).Left := (Screen.Width - (Sender as TForm).Width) div 2;
  (Sender as TForm).Top := (Screen.Height - 200 - (Sender as TForm).Height) div 2;
  {$ENDIF}

  // set components height
  {$IFDEF WINDOWS}
  pnlButtons.Height := ButtonHeight;
  {$ENDIF}
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

procedure TfrmWriting.FormShow(Sender: TObject);
begin
  rbtWriteAtOnce.SetFocus;
end;

procedure TfrmWriting.btnCancelClick(Sender: TObject);
begin
  frmWriting.ModalResult := mrCancel;
end;

end.

