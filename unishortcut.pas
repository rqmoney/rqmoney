unit uniShortCut;

{$mode ObjFPC}{$H+}
{$ModeSwitch AutoDeref}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  ActnList, StrUtils, LCLType, LCLProc, laz.VirtualTrees, Buttons;

type

  { TfrmShortCut }

  TfrmShortCut = class(TForm)
    actCancel: TAction;
    ActionList1: TActionList;
    btnSave: TBitBtn;
    lblShortcut: TStaticText;
    lblAction1: TLabel;
    lblAction: TLabel;
    lblShortcutOld1: TLabel;
    lblShortCutOld: TLabel;
    lblShortCutNew: TLabel;
    lblTip: TLabel;
    pnlOld: TPanel;
    pnlNew: TPanel;
    pnlShortCut: TPanel;
    pnlAction: TPanel;
    procedure btnCancelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnSaveKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure btnSaveKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
  private

  public

  end;

var
  frmShortCut: TfrmShortCut;

implementation

{$R *.lfm}

uses
  uniResources, uniSettings;

{ TfrmShortCut }

procedure TfrmShortCut.btnCancelClick(Sender: TObject);
begin
  frmShortCut.ModalResult := mrCancel;
end;

procedure TfrmShortCut.btnSaveClick(Sender: TObject);
var
  Key: PKey;
  P: PVirtualNode;

begin
  If lblShortcut.Caption = '' then
    Exit;

  // check the duplicity
  P := frmSettings.VSTKeys.GetFirst();
  While Assigned(P) do begin
    Key := frmSettings.VSTKeys.GetNodeData(P);
    If Key.shortcut = lblShortcut.Caption then
      begin
        ShowMessage (Error_03 + sLineBreak + sLineBreak + Key.caption);
        Exit;
      end;

    P := frmSettings.VSTKeys.GetNext(P);
  end;
  frmShortCut.ModalResult := mrOk;
end;

procedure TfrmShortCut.btnSaveKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  //  frmShortCut.Caption := IntToStr(key);
  if key in [9, 20, 37..40, 92..93, 230, 144] then
  begin
    Key := 0;
    lblShortcut.Caption := '';
    Exit;
  end;

  If (key = 27) and (lblShortcut.Caption = 'ESC') then begin
    if MessageDlg(Application.Title, Question_19, mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      begin
      frmShortCut.ModalResult := mrCancel;
      Exit;
    end;
  end;

  lblShortcut.Tag := 0;

  if (ssCTRL in Shift) then
    lblShortcut.Hint := 'CTRL+'
  else if (ssShift in Shift) then
    lblShortcut.Hint := 'SHIFT+'
  else if (ssAlt in Shift) then
    lblShortcut.Hint := 'ALT+'
  else
    lblShortcut.Hint := '';

  lblShortcut.Caption := AnsiUpperCase(lblShortcut.Hint + ShortCutToText(Key));
  Key := 0;
end;

procedure TfrmShortCut.btnSaveKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  //  frmShortCut.Caption := IntToStr(key);
  if RightStr(lblShortcut.Caption, 1) = '+' then
    lblShortcut.Caption := '';
end;

end.
