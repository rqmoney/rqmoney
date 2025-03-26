unit uniImage;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  ActnList, BCMDButtonFocus, Clipbrd, LCLIntf;

type

  { TfrmImage }

  TfrmImage = class(TForm)
    actExit: TAction;
    actCopy: TAction;
    ActionList1: TActionList;
    btnCopy: TBCMDButtonFocus;
    btnExit: TBCMDButtonFocus;
    imgDiagram: TImage;
    imgHeight: TImage;
    imgWidth: TImage;
    lblApricotDB: TLabel;
    lblHeight: TLabel;
    lblWidth: TLabel;
    pnlBottom: TPanel;
    pnlButtons: TPanel;
    pnlHeight: TPanel;
    pnlWidth: TPanel;
    procedure btnCopyClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure lblApricotDBClick(Sender: TObject);
    procedure lblApricotDBMouseEnter(Sender: TObject);
    procedure lblApricotDBMouseLeave(Sender: TObject);
  private

  public

  end;

var
  frmImage: TfrmImage;

implementation

{$R *.lfm}

uses
  uniMain, uniResources;

{ TfrmImage }

procedure TfrmImage.FormResize(Sender: TObject);
begin
  lblWidth.Caption := IntToStr((Sender as TForm).Width);
  lblHeight.Caption := IntToStr((Sender as TForm).Height);
end;

procedure TfrmImage.lblApricotDBClick(Sender: TObject);
begin
  OpenURL((Sender as TLabel).Hint);
end;

procedure TfrmImage.lblApricotDBMouseEnter(Sender: TObject);
begin
    (Sender as TLabel).Font.Underline := True;
    (Sender as TLabel).Font.Bold := True;
    (Sender as TLabel).Font.Color := clBlue;
    (Sender as TLabel).Cursor := crHandPoint;
end;

procedure TfrmImage.lblApricotDBMouseLeave(Sender: TObject);
begin
  (Sender as TLabel).Font.Underline := False;
  (Sender as TLabel).Font.Bold := False;
  (Sender as TLabel).Font.Color := clDefault;
  (Sender as TLabel).Cursor := crDefault;
end;

procedure TfrmImage.btnExitClick(Sender: TObject);
begin
  frmImage.ModalResult := mrCancel;
end;

procedure TfrmImage.FormCreate(Sender: TObject);
begin
  // set component height
  pnlBottom.Height := ButtonHeight;

    // get form icon
  frmMain.img16.GetIcon(7, (Sender as TForm).Icon);

  lblApricotDB.Hint := 'https://www.apricotdb.co.za/joomla/';
end;

procedure TfrmImage.btnCopyClick(Sender: TObject);
begin
  Clipboard.Assign(imgDiagram.Picture.Bitmap);
  ShowMessage(Format(Message_07, [sLineBreak, IntToStr(imgDiagram.Picture.Bitmap.Width),
    IntToStr(imgDiagram.Picture.Bitmap.Height)]));
end;

end.

