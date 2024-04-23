unit uniAbout;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls, LCLIntf,
  ExtCtrls, Clipbrd, ComCtrls, ActnList, BCMDButtonFocus, dateutils;

type

  { TfrmAbout }

  TfrmAbout = class(TForm)
    actExit: TAction;
    ActionList1: TActionList;
    btnExit: TBCMDButtonFocus;
    imgDonate: TImage;
    imgHeight: TImage;
    imgWidth: TImage;
    lblHeight: TLabel;
    lblLink1: TLabel;
    lblLink2: TLabel;
    lblLGPL: TLabel;
    lblLicense: TLabel;
    lblThanks: TLabel;
    lblDonate: TLabel;
    lblEmail: TLabel;
    lblWidth: TLabel;
    pnlBottom: TPanel;
    pnlHeight: TPanel;
    pnlLicense: TPanel;
    pnlWebsite: TLabel;
    lblWebsite: TLabel;
    pnlAuthor: TLabel;
    lblAuthor: TLabel;
    pnlLocation: TLabel;
    lblLocation: TLabel;
    pnlEmail: TLabel;
    pnlProgram6: TPanel;
    pnlWidth: TPanel;
    scrDonate: TScrollBox;
    tabAbout: TPageControl;
    pnlBack: TPanel;
    pnlBack1: TPanel;
    pnlButtons: TPanel;
    pnlProgram: TLabel;
    lblProgram: TLabel;
    lblCopyright: TLabel;
    pnlVersion: TLabel;
    pnlReleased: TLabel;
    pnlDeveloped: TLabel;
    lblDeveloped: TLabel;
    pnlCopyright: TLabel;
    pnlProgram0: TPanel;
    pnlProgram1: TPanel;
    pnlProgram11: TPanel;
    pnlProgram12: TPanel;
    pnlProgram13: TPanel;
    pnlProgram2: TPanel;
    pnlProgram7: TPanel;
    pnlProgram5: TPanel;
    lblVersion: TLabel;
    lblReleased: TLabel;
    tabProgram: TTabSheet;
    tabAuthor: TTabSheet;
    tabDonate: TTabSheet;
    tabLicense: TTabSheet;
    tabThanks: TTabSheet;
    procedure btnExitClick(Sender: TObject);
    procedure FormCreate(Sender:TObject);
    procedure FormResize(Sender: TObject);
    procedure imgDonateClick(Sender: TObject);
    procedure lblDevelopedClick(Sender: TObject);
    procedure lblDevelopedMouseEnter(Sender: TObject);
    procedure lblDevelopedMouseLeave(Sender: TObject);
    procedure lblLicenseClick(Sender: TObject);
    procedure lblLink2MouseEnter(Sender: TObject);
    procedure lblLink2MouseLeave(Sender: TObject);
    procedure pnlEmailClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmAbout: TfrmAbout;

implementation

{$R *.lfm}

uses
  uniMain, uniResources;

{ TfrmAbout }

procedure TfrmAbout.lblDevelopedClick(Sender: TObject);
begin
  OpenURL((Sender as TLabel).Hint);
end;

procedure TfrmAbout.lblDevelopedMouseEnter(Sender: TObject);
begin
  (Sender as TLabel).Font.Style := [fsUnderline, fsBold];
end;

procedure TfrmAbout.lblDevelopedMouseLeave(Sender: TObject);
begin
  (Sender as TLabel).Font.Style := [fsBold];
end;

procedure TfrmAbout.lblLicenseClick(Sender: TObject);
begin
  OpenURL((Sender as TLabel).Hint);
end;

procedure TfrmAbout.lblLink2MouseEnter(Sender: TObject);
begin
  lblLink2.Font.Color := clBlue;
end;

procedure TfrmAbout.lblLink2MouseLeave(Sender: TObject);
begin
  lblLink2.Font.Color := clBlack;
end;

procedure TfrmAbout.pnlEmailClick(Sender: TObject);
begin
  Clipboard.AsText := lblEmail.Caption;
  ShowMessage (Message_02);
end;

procedure TfrmAbout.FormCreate(Sender:TObject);
begin
  // form size
  (Sender as TForm).Width := Round(400 * (ScreenRatio / 100));
  (Sender as TForm).Constraints.MinWidth := Round(400 * (ScreenRatio / 100));
  (Sender as TForm).Height := Round(400 * (ScreenRatio / 100));
  (Sender as TForm).Constraints.MinHeight := Round(400 * (ScreenRatio / 100));

  // form position
  (Sender as TForm).Left := (Screen.Width - (Sender as TForm).Width) div 2;
  (Sender as TForm).Top := (Screen.Height - 200 - (Sender as TForm).Height) div 2;

  // get form icon
  frmMain.img16.GetIcon(26, (Sender as TForm).Icon);

  pnlBottom.Height := ButtonHeight;

  tabAbout.TabIndex := 0;

  lblProgram.Caption := Application.Title;
  // ===========================================================================
  // ***************************************************************************
  lblReleased.Hint := '2024-04-21'; // IMPORTANT DATE OF RELEASE !!!
  // ***************************************************************************
  // ===========================================================================
  lblReleased.Caption := FormatDateTime(FS_own.LongDateFormat,
    StrToDate(lblReleased.Hint, 'YYYY-MM-DD', '-'));
  lblVersion.Hint := '3.9.2';
  lblLicense.Hint := 'https://en.wikipedia.org/wiki/GNU_General_Public_License';
  lblWebsite.Caption := 'www.rqmoney.eu';
  lblDeveloped.Caption := 'Lazarus';
  lblDeveloped.Hint := 'https://www.lazarus-ide.org/';
  pnlCopyright.Caption := 'Copyright:';
  lblCopyright.Caption := '© 2005 - ' + IntToStr(YearOf(Today));
  If (LeftStr(GetLang, 2) = 'sk') or (LeftStr(GetLang, 2) = 'cz') then begin
    lblWebsite.Hint := 'https://www.rqmoney.eu/program.html';
    lblAuthor.Caption := 'Slavomír Svetlík';
    lblLocation.Caption := 'Banská Bystrica';
  end
  else begin
    lblWebsite.Hint := 'https://www.rqmoney.eu/index.html';
    lblAuthor.Caption := 'Slavomir Svetlik';
    lblLocation.Caption := 'Banska Bystrica (Slovakia)';
  end;
  lblEmail.Caption := 'rqmoney@gmail.com';
  lblLGPL.Caption := 'https://www.gnu.org/licenses/';
  lblLGPL.Hint := lblLGPL.Caption;

  pnlButtons.Height := PanelHeight;
  lblLink2.Caption := 'Icons8';
  lblLink2.Hint := 'https://icons8.com/';
end;

procedure TfrmAbout.FormResize(Sender: TObject);
begin
  lblWidth.Caption := IntToStr((Sender as TForm).Width);
  lblHeight.Caption := IntToStr((Sender as TForm).Height);
end;

procedure TfrmAbout.imgDonateClick(Sender: TObject);
begin
  OpenURL('https://www.paypal.com/donate/?hosted_button_id=ZLDQPUWAKD7AL');
end;

procedure TfrmAbout.btnExitClick(Sender: TObject);
begin
  frmAbout.Close;
end;

end.

