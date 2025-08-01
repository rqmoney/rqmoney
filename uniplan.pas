unit uniPlan;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  ActnList, Spin, BCMDButtonFocus, BCPanel, Math;

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
  uniMain;

  { TfrmPlan }

procedure TfrmPlan.btnSaveClick(Sender: TObject);
begin
  frmPlan.ModalResult := mrOk;
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

    // font color
    lblNote.Font.Color := IfThen(Dark = False, clRed, $007873F4);

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
begin
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
