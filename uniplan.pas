unit uniPlan;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  ActnList, Spin, BCMDButtonFocus, BCPanel, IniFiles;

type

  { TfrmPlan }

  TfrmPlan = class(TForm)
    actSave: TAction;
    actCancel: TAction;
    ActionList1: TActionList;
    btnCancel: TBCMDButtonFocus;
    btnSave: TBCMDButtonFocus;
    imgHeight: TImage;
    imgWidth: TImage;
    lblHeight: TLabel;
    lblNote: TLabel;
    lblWidth: TLabel;
    pnlBottom: TPanel;
    pnlHeight: TPanel;
    pnlWidth: TPanel;
    spiPlan: TFloatSpinEdit;
    lblDate: TLabel;
    lblDate1: TLabel;
    lblPlan: TLabel;
    pnlButtons: TPanel;
    pnlPlanCaption2: TBCPanel;
    pnlClient: TPanel;
    pnlPlanCaption1: TBCPanel;
    procedure btnCancelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure pnlClientResize(Sender: TObject);
  private

  public

  end;

var
  frmPlan: TfrmPlan;

implementation

{$R *.lfm}

uses
  uniMain, uniSettings;

  { TfrmPlan }

procedure TfrmPlan.btnSaveClick(Sender: TObject);
begin
  frmPlan.ModalResult := mrOk;
end;

procedure TfrmPlan.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var
  INI: TINIFile;
  INIFile: string;
begin
  try
    // write position and window size
    if frmSettings.chkLastFormsSize.Checked = True then
    begin
      try
        INIFile := ChangeFileExt(ParamStr(0), '.ini');
        INI := TINIFile.Create(INIFile);
        if INI.ReadString('POSITION', frmPlan.Name, '') <>
          IntToStr(frmPlan.Left) + separ + // form left
        IntToStr(frmPlan.Top) + separ + // form top
        IntToStr(frmPlan.Width) + separ + // form width
        IntToStr(frmPlan.Height) then
          INI.WriteString('POSITION', frmPlan.Name,
            IntToStr(frmPlan.Left) + separ + // form left
            IntToStr(frmPlan.Top) + separ + // form top
            IntToStr(frmPlan.Width) + separ + // form width
            IntToStr(frmPlan.Height));
      finally
        INI.Free;
      end;
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmPlan.FormCreate(Sender: TObject);
begin
  try
    // set components height
    pnlPlanCaption1.Height := PanelHeight;
    pnlPlanCaption2.Height := PanelHeight;
    pnlButtons.Height := ButtonHeight;
    pnlBottom.Height := ButtonHeight;

    // get form icon
    frmMain.img16.GetIcon(21, (Sender as TForm).Icon);
  except
  end;
end;

procedure TfrmPlan.FormResize(Sender: TObject);
begin
  try
    lblWidth.Caption := IntToStr(frmPlan.Width);
    lblHeight.Caption := IntToStr(frmPlan.Height);
    pnlPlanCaption2.Repaint;
    pnlPlanCaption1.Repaint;
    pnlButtons.Repaint;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmPlan.FormShow(Sender: TObject);
var
  INI: TINIFile;
  S: string;
  I: integer;
begin
  // ********************************************************************
  // FORM SIZE START
  // ********************************************************************
  try
    S := ChangeFileExt(ParamStr(0), '.ini');
    // INI file READ procedure (if file exists) =========================
    if FileExists(S) = True then
    begin
      INI := TINIFile.Create(S);
      frmPlan.Position := poDesigned;
      S := INI.ReadString('POSITION', frmPlan.Name, '-1•-1•0•0');

      // width
      TryStrToInt(Field(Separ, S, 3), I);
      if (I < 1) or (I > Screen.Width) then
        frmPlan.Width := 500
      else
        frmPlan.Width := I;

      /// height
      TryStrToInt(Field(Separ, S, 4), I);
      if (I < 1) or (I > Screen.Height) then
        frmPlan.Height := 400
      else
        frmPlan.Height := I;

      // left
      TryStrToInt(Field(Separ, S, 1), I);
      if (I < 0) or (I > Screen.Width) then
        frmPlan.left := (Screen.Width - frmPlan.Width) div 2
      else
        frmPlan.Left := I;

      // top
      TryStrToInt(Field(Separ, S, 2), I);
      if (I < 0) or (I > Screen.Height) then
        frmPlan.Top := ((Screen.Height - frmPlan.Height) div 2) - 75
      else
        frmPlan.Top := I;
    end;
  finally
    INI.Free
  end;
  // ********************************************************************
  // FORM SIZE END
  // ********************************************************************

  spiPlan.SetFocus;
  spiPlan.SelectAll;
end;

procedure TfrmPlan.pnlClientResize(Sender: TObject);
begin
  spiPlan.BorderSpacing.Left := Round(pnlClient.Width div 3);
  spiPlan.BorderSpacing.Right := Round(pnlClient.Width div 3);
end;

procedure TfrmPlan.btnCancelClick(Sender: TObject);
begin
  frmPlan.ModalResult := mrCancel;
end;

end.
