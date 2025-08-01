unit uniShortCut;

{$mode ObjFPC}{$H+}
{$ModeSwitch AutoDeref}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  ActnList, StrUtils, LCLType, LCLProc, laz.VirtualTrees, Buttons, Math;

type

  { TfrmShortCut }

  TfrmShortCut = class(TForm)
    actCancel: TAction;
    ActionList1: TActionList;
    btnSave: TBitBtn;
    imgHeight: TImage;
    imgWidth: TImage;
    lblHeight: TLabel;
    lblShortcut: TStaticText;
    lblAction1: TLabel;
    lblAction: TLabel;
    lblShortcutOld1: TLabel;
    lblShortCutOld: TLabel;
    lblShortCutNew: TLabel;
    lblTip: TLabel;
    lblWidth: TLabel;
    pnlBottom: TPanel;
    pnlHeight: TPanel;
    pnlOld: TPanel;
    pnlNew: TPanel;
    pnlShortCut: TPanel;
    pnlAction: TPanel;
    pnlWidth: TPanel;
    procedure btnCancelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnSaveKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure btnSaveKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private

  public

  end;

var
  frmShortCut: TfrmShortCut;

implementation

{$R *.lfm}

uses
  uniMain, uniResources, uniSettings;

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

procedure TfrmShortCut.FormCreate(Sender: TObject);
begin
  // set height
  pnlBottom.Height := ButtonHeight;

  // get form icon
  frmMain.img16.GetIcon(32, (Sender as TForm).Icon);

  // colors
  lblAction.Font.Color := IfThen(Dark = False, clGreen, $0062FF52);
  lblShortCutOld.Font.Color := IfThen(Dark = False, clBlue, $00FFB852);
  lblShortcut.Font.Color := IfThen(Dark = False, clRed, $006A64FF);
end;

procedure TfrmShortCut.FormResize(Sender: TObject);
begin
  try
    lblWidth.Caption := IntToStr(frmShortCut.Width);
    lblHeight.Caption := IntToStr(frmShortCut.Height);
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

end.
