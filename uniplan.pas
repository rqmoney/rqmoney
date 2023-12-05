unit uniPlan;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  ActnList, Spin, BCMDButtonFocus, BCPanel;

type

  { TfrmPlan }

  TfrmPlan = class(TForm)
    actSave: TAction;
    actCancel: TAction;
    ActionList1: TActionList;
    btnCancel: TBCMDButtonFocus;
    btnSave: TBCMDButtonFocus;
    lblNote: TLabel;
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
    procedure FormShow(Sender: TObject);
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
  frmPlan.ModalResult := mrOK;
end;

procedure TfrmPlan.FormCreate(Sender: TObject);
begin
  {$IFDEF WINDOWS}
  // form size
  (Sender as TForm).Width := Round(300 * (ScreenRatio / 100));
  (Sender as TForm).Constraints.MinWidth := Round(300 * (ScreenRatio / 100));
  (Sender as TForm).Height := Round(250 * (ScreenRatio / 100));
  (Sender as TForm).Constraints.MinHeight := Round(250 * (ScreenRatio / 100));

  // form position
  (Sender as TForm).Left := (Screen.Width - (Sender as TForm).Width) div 2;
  (Sender as TForm).Top := (Screen.Height - 200 - (Sender as TForm).Height) div 2;

  // set components height
  pnlPlanCaption1.Height := PanelHeight;
  pnlPlanCaption2.Height := PanelHeight;
  pnlButtons.Height := ButtonHeight;
  {$ENDIF}
end;

procedure TfrmPlan.FormShow(Sender: TObject);
begin
  spiPlan.SetFocus;
  spiPlan.SelectAll;
end;

procedure TfrmPlan.btnCancelClick(Sender: TObject);
begin
  frmPlan.ModalResult := mrCancel;
end;

end.

