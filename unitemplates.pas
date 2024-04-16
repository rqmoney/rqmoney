unit uniTemplates;

{$mode ObjFPC}{$H+}
{$ModeSwitch AutoDeref}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, ActnList,
  StdCtrls, Spin, Buttons, Menus, IniFiles, laz.VirtualTrees, SynEdit,
  BCPanel, BCMDButtonFocus, LazUTF8, StrUtils, Math, DateUtils;

type
  TLineX = record
    Value: array of string;
  end;
  PLineX = ^TLineX;

type

  { TfrmTemplates }

  TfrmTemplates = class(TForm)
    actExit: TAction;
    actExpand: TAction;
    actCollapse: TAction;
    actAdd: TAction;
    actEdit: TAction;
    actDelete: TAction;
    actSave: TAction;
    ActionList1: TActionList;
    btnAdd: TBCMDButtonFocus;
    btnExit: TBCMDButtonFocus;
    btnCancel: TBCMDButtonFocus;
    btnDelete: TBCMDButtonFocus;
    btnEdit: TBCMDButtonFocus;
    btnPanels: TBitBtn;
    btnImport: TBCMDButtonFocus;
    btnSave: TBCMDButtonFocus;
    cbxSubcategory: TComboBox;
    cbxPerson: TComboBox;
    cbxPayee: TComboBox;
    cbxAccount: TComboBox;
    cbxTemplates: TComboBox;
    cbxCategory: TComboBox;
    cbxComment: TComboBox;
    chkQuotes: TCheckBox;
    ediDecimal: TEdit;
    ediCredit: TEdit;
    ediFormat: TEdit;
    ediName: TEdit;
    ediSeparator: TEdit;
    ediThousand: TEdit;
    ediDebit: TEdit;
    gbxAmountTest: TGroupBox;
    gbxDateTest: TGroupBox;
    gbxImport: TGroupBox;
    imgAmount: TImage;
    imgCategory: TImage;
    imgHeight: TImage;
    imgOrigin: TImage;
    imgPerson: TImage;
    imgPayee: TImage;
    imgAccount: TImage;
    imgType: TImage;
    imgDate: TImage;
    imgComment: TImage;
    imgWidth: TImage;
    lblAmountColumn: TLabel;
    lblAmountTest: TLabel;
    lblEndLine: TLabel;
    lblHeight: TLabel;
    lblName: TLabel;
    lblSeparator: TLabel;
    lblStartLine: TLabel;
    lblTemplates: TLabel;
    lblWidth: TLabel;
    pnlAccount: TPanel;
    pnlAccountCaption: TPanel;
    pnlAccountClient: TPanel;
    pnlBottom1: TPanel;
    pnlEndLine: TPanel;
    pnlFirstLine: TPanel;
    pnlHeight: TPanel;
    pnlOrigin: TPanel;
    pnlOriginCaption: TPanel;
    pnlOriginClient: TPanel;
    pnlSeparator: TPanel;
    pnlTemplateName: TPanel;
    pnlWidth: TPanel;
    popFilter: TPopupMenu;
    popCollapse: TMenuItem;
    popExpand: TMenuItem;
    rbtAccountAuto: TRadioButton;
    rbtAccountManually: TRadioButton;
    spiFirst: TSpinEdit;
    spiLast: TSpinEdit;
    tabTemplates: TNotebook;
    Page1: TPage;
    Page2: TPage;
    pnlButtons: TPanel;
    pnlImport: TPanel;
    pnlImport1: TPanel;
    pnlPerson: TPanel;
    pnlPayee: TPanel;
    pnlPersonCaption: TPanel;
    pnlPayeeCaption: TPanel;
    pnlPersonClient: TPanel;
    pnlPayeeClient: TPanel;
    pnlTemplate: TPanel;
    rbtPersonAuto: TRadioButton;
    rbtCategoryManually: TRadioButton;
    lblDateColumn: TLabel;
    lblDateTest: TLabel;
    lblDecimal: TLabel;
    lblCredit: TLabel;
    lblFormat: TLabel;
    lblThousand: TLabel;
    lblDebit: TLabel;
    pnlComment: TPanel;
    pnlCommentCaption: TPanel;
    pnlCommentClient: TPanel;
    pnlCategory: TPanel;
    pnlCategoryCaption: TPanel;
    pnlCategoryClient: TPanel;
    rbtCategoryAuto: TRadioButton;
    rbtPayeeAuto: TRadioButton;
    rbtPersonManually: TRadioButton;
    rbtPayeeManually: TRadioButton;
    rbtTypeColumn: TRadioButton;
    rbtCommentManually: TRadioButton;
    rbtCommentColumn: TRadioButton;
    rbtTypeSymbol: TRadioButton;
    memTop: TSynEdit;
    pnlAmount: TPanel;
    pnlType: TPanel;
    pnlAmountCaption: TPanel;
    pnlTypeCaption: TPanel;
    pnlAmountClient: TPanel;
    pnlTypeClient: TPanel;
    pnlAmountColumn: TPanel;
    pnlTypeColumn: TPanel;
    pnlDate: TPanel;
    pnlDateCaption: TPanel;
    pnlDateClient: TPanel;
    pnlDateColumn: TPanel;
    pnlDecimal: TPanel;
    pnlCredit: TPanel;
    pnlFormat: TPanel;
    pnlSettingsCaption: TBCPanel;
    pnlThousand: TPanel;
    pnlDebit: TPanel;
    pnlTop: TPanel;
    pnlBottom: TPanel;
    pnlClient: TPanel;
    pnlTopCaption: TBCPanel;
    pnlBottomCaption: TBCPanel;
    pnlLeft: TPanel;
    rbtCommentAuto: TRadioButton;
    scrClient: TScrollBox;
    spiAmount: TSpinEdit;
    spiType: TSpinEdit;
    spiDate: TSpinEdit;
    spiComment: TSpinEdit;
    splTemplates: TSplitter;
    VST: TLazVirtualStringTree;
    procedure btnAddClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnPanelsClick(Sender: TObject);
    procedure btnImportClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure cbxCategoryChange(Sender: TObject);
    procedure cbxCommentEnter(Sender: TObject);
    procedure cbxCommentExit(Sender: TObject);
    procedure cbxTemplatesChange(Sender: TObject);
    procedure chkQuotesChange(Sender: TObject);
    procedure chkQuotesEnter(Sender: TObject);
    procedure chkQuotesExit(Sender: TObject);
    procedure ediCreditChange(Sender: TObject);
    procedure ediSeparatorChange(Sender: TObject);
    procedure ediNameChange(Sender: TObject);
    procedure ediNameEnter(Sender: TObject);
    procedure ediNameExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Page1BeforeShow(ASender: TObject; ANewPage: TPage; ANewIndex: integer);
    procedure pnlAccountCaptionClick(Sender: TObject);
    procedure pnlAmountCaptionClick(Sender: TObject);
    procedure pnlButtonsResize(Sender: TObject);
    procedure pnlCategoryCaptionClick(Sender: TObject);
    procedure pnlClientResize(Sender: TObject);
    procedure pnlCommentCaptionClick(Sender: TObject);
    procedure pnlDateCaptionClick(Sender: TObject);
    procedure pnlLeftResize(Sender: TObject);
    procedure pnlOriginCaptionClick(Sender: TObject);
    procedure pnlPayeeCaptionClick(Sender: TObject);
    procedure pnlPersonCaptionClick(Sender: TObject);
    procedure pnlTypeCaptionClick(Sender: TObject);
    procedure popExpandClick(Sender: TObject);
    procedure rbtAccountManuallyChange(Sender: TObject);
    procedure rbtCategoryManuallyChange(Sender: TObject);
    procedure rbtCommentAutoChange(Sender: TObject);
    procedure rbtCommentColumnChange(Sender: TObject);
    procedure rbtCommentManuallyChange(Sender: TObject);
    procedure rbtPayeeManuallyChange(Sender: TObject);
    procedure rbtPersonManuallyChange(Sender: TObject);
    procedure rbtTypeSymbolChange(Sender: TObject);
    procedure spiAmountChange(Sender: TObject);
    procedure spiCommentChange(Sender: TObject);
    procedure spiDateChange(Sender: TObject);
    procedure spiFirstChange(Sender: TObject);
    procedure spiFirstEnter(Sender: TObject);
    procedure spiFirstExit(Sender: TObject);
    procedure spiTypeChange(Sender: TObject);
    procedure VSTBeforeCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas;
      Node: PVirtualNode; Column: TColumnIndex; CellPaintMode: TVTCellPaintMode;
      CellRect: TRect; var ContentRect: TRect);
    procedure VSTGetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Kind: TVTImageKind; Column: TColumnIndex; var Ghosted: boolean;
      var ImageIndex: integer);
    procedure VSTGetNodeDataSize(Sender: TBaseVirtualTree; var NodeDataSize: integer);
    procedure VSTGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure VSTResize(Sender: TObject);
  private

  public

  end;

var
  frmTemplates: TfrmTemplates;

procedure FileToGrid;
procedure UpdateTemplates;

implementation

{$R *.lfm}

uses
  uniMain, uniSettings, uniImport, uniResources, uniEdit;

  { TfrmTemplates }

procedure TfrmTemplates.pnlClientResize(Sender: TObject);
begin
  pnlTop.Height := (pnlClient.Height - 15) div 2;
  pnlTopCaption.Repaint;
  pnlBottomCaption.Repaint;
  pnlSettingsCaption.Repaint;
end;

procedure TfrmTemplates.pnlCommentCaptionClick(Sender: TObject);
begin
  pnlCommentCaption.Tag := 1 - pnlCommentCaption.Tag;
  pnlCommentClient.Visible := pnlCommentCaption.Tag = 1;
  frmMain.imgArrows.GetBitmap(pnlCommentCaption.Tag, imgComment.Picture.Bitmap);
end;

procedure TfrmTemplates.pnlDateCaptionClick(Sender: TObject);
begin
  pnlDateCaption.Tag := 1 - pnlDateCaption.Tag;
  pnlDateClient.Visible := pnlDateCaption.Tag = 1;
  frmMain.imgArrows.GetBitmap(pnlDateCaption.Tag, imgDate.Picture.Bitmap);
end;

procedure TfrmTemplates.pnlLeftResize(Sender: TObject);
begin
  btnExit.Repaint;
  btnImport.Repaint;
  btnAdd.Repaint;
  btnEdit.Repaint;
  btnDelete.Repaint;
  btnSave.Repaint;
  btnCancel.Repaint;
end;

procedure TfrmTemplates.pnlOriginCaptionClick(Sender: TObject);
begin
  pnlOriginCaption.Tag := 1 - pnlOriginCaption.Tag;
  pnlOriginClient.Visible := pnlOriginCaption.Tag = 1;
  frmMain.imgArrows.GetBitmap(pnlOriginCaption.Tag, imgOrigin.Picture.Bitmap);
end;

procedure TfrmTemplates.pnlPayeeCaptionClick(Sender: TObject);
begin
  pnlPayeeCaption.Tag := 1 - pnlPayeeCaption.Tag;
  pnlPayeeClient.Visible := pnlPayeeCaption.Tag = 1;
  frmMain.imgArrows.GetBitmap(pnlPayeeCaption.Tag, imgPayee.Picture.Bitmap);
end;

procedure TfrmTemplates.pnlPersonCaptionClick(Sender: TObject);
begin
  pnlPersonCaption.Tag := 1 - pnlPersonCaption.Tag;
  pnlPersonClient.Visible := pnlPersonCaption.Tag = 1;
  frmMain.imgArrows.GetBitmap(pnlPersonCaption.Tag, imgPerson.Picture.Bitmap);
end;

procedure TfrmTemplates.pnlTypeCaptionClick(Sender: TObject);
begin
  pnlTypeCaption.Tag := 1 - pnlTypeCaption.Tag;
  pnlTypeClient.Visible := pnlTypeCaption.Tag = 1;
  frmMain.imgArrows.GetBitmap(pnlTypeCaption.Tag, imgType.Picture.Bitmap);
end;

procedure TfrmTemplates.popExpandClick(Sender: TObject);
var
  I: cardinal;
begin
  if tabTemplates.PageIndex = 0 then
    Exit;

  try
    scrClient.Visible := False; // due flickering of the components

    if Sender.ClassType = TAction then
      I := (Sender as TAction).Tag
    else
      I := (Sender as TMenuItem).Tag;

    // Origin
    pnlOriginCaption.Tag := I;
    pnlOriginCaptionClick(pnlOriginCaption);
    // Date
    pnlDateCaption.Tag := I;
    pnlDateCaptionClick(pnlDateCaption);
    // Amount
    pnlAmountCaption.Tag := I;
    pnlAmountCaptionClick(pnlAmountCaption);
    // Account
    pnlAccountCaption.Tag := I;
    pnlAccountCaptionClick(pnlAccountCaption);
    // Type
    pnlTypeCaption.Tag := I;
    pnlTypeCaptionClick(pnlTypeCaption);
    // Comment
    pnlCommentCaption.Tag := I;
    pnlCommentCaptionClick(pnlCommentCaption);
    // Category
    pnlCategoryCaption.Tag := I;
    pnlCategoryCaptionClick(pnlCategoryCaption);
    // Person
    pnlPersonCaption.Tag := I;
    pnlPersonCaptionClick(pnlPersonCaption);
    // Payee
    pnlPayeeCaption.Tag := I;
    pnlPayeeCaptionClick(pnlPayeeCaption);
  except
  end;

  scrClient.Visible := True;
end;

procedure TfrmTemplates.rbtAccountManuallyChange(Sender: TObject);
begin
  if (Sender as TRadioButton).Checked = False then
    Exit;

  case (Sender as TRadioButton).Tag of
    1: begin
      cbxAccount.Enabled := True;
      if cbxAccount.Items.Count > 0 then
        cbxAccount.ItemIndex := 0;
      if tabTemplates.PageIndex = 1 then
        cbxAccount.SetFocus;
    end
    else
    begin
      cbxAccount.Enabled := False;
      cbxAccount.ItemIndex := -1;
    end;
  end;
end;

procedure TfrmTemplates.rbtCategoryManuallyChange(Sender: TObject);
begin
  if (Sender as TRadioButton).Checked = False then
    Exit;

  case (Sender as TRadioButton).Tag of
    1: begin
      cbxCategory.Enabled := True;
      cbxSubcategory.Enabled := True;
      // read list of categories
      cbxCategory.Clear;
      cbxCategory.Items := frmMain.cbxCategory.Items;
      cbxCategory.Items.Delete(0);
      if cbxCategory.Items.Count > 0 then
        cbxCategory.ItemIndex := 0;
      cbxCategoryChange(cbxCategory);

      if cbxCategory.Items.Count > 0 then
      begin
        cbxCategory.ItemIndex := 0;
        cbxCategoryChange(cbxCategory);
      end;
      if (tabTemplates.PageIndex = 1) then
        cbxCategory.SetFocus;
    end
    else
    begin
      cbxCategory.Enabled := False;
      cbxSubcategory.Enabled := False;
      cbxCategory.ItemIndex := -1;
      cbxSubcategory.ItemIndex := -1;
    end;
  end;
end;

procedure TfrmTemplates.rbtCommentAutoChange(Sender: TObject);
begin
  if rbtCommentAuto.Checked = False then
    Exit;
  cbxComment.Enabled := True;
  spiComment.Enabled := False;
  spiComment.Value := 0;
end;

procedure TfrmTemplates.rbtCommentColumnChange(Sender: TObject);
begin
  if rbtCommentColumn.Checked = False then
    Exit;
  spiComment.Enabled := True;
  if spiComment.Value < 1 then
    spiComment.Value := 1;
  cbxComment.ItemIndex := -1;
  cbxComment.Enabled := False;
end;

procedure TfrmTemplates.rbtCommentManuallyChange(Sender: TObject);
begin
  if rbtCommentManually.Checked = False then
    Exit;
  cbxComment.ItemIndex := -1;
  cbxComment.Enabled := False;
  spiComment.Enabled := False;
  spiComment.Value := 0;
end;

procedure TfrmTemplates.rbtPayeeManuallyChange(Sender: TObject);
begin
  if (Sender as TRadioButton).Checked = False then
    Exit;

  case (Sender as TRadioButton).Tag of
    1: begin
      cbxPayee.Enabled := True;
      if cbxPayee.Items.Count > 0 then
        cbxPayee.ItemIndex := 0;
      if tabTemplates.PageIndex = 1 then
        cbxPayee.SetFocus;
    end
    else
    begin
      cbxPayee.Enabled := False;
      cbxPayee.ItemIndex := -1;
    end;
  end;
end;

procedure TfrmTemplates.rbtPersonManuallyChange(Sender: TObject);
begin
  if (Sender as TRadioButton).Checked = False then
    Exit;

  case (Sender as TRadioButton).Tag of
    1: begin
      cbxPerson.Enabled := True;
      if cbxPerson.Items.Count > 0 then
        cbxPerson.ItemIndex := 0;
      if tabTemplates.PageIndex = 1 then
        cbxPerson.SetFocus;
    end
    else
    begin
      cbxPerson.Enabled := False;
      cbxPerson.ItemIndex := -1;
    end;
  end;
end;

procedure TfrmTemplates.rbtTypeSymbolChange(Sender: TObject);
begin
  if (Sender as TRadioButton).Checked = False then
    Exit;

  spiType.Enabled := (Sender as TRadioButton).Tag = 1;
  pnlCredit.Enabled := (Sender as TRadioButton).Tag = 1;
  pnlDebit.Enabled := (Sender as TRadioButton).Tag = 1;
  if frmTemplates.Tag = 0 then
    VST.Repaint;
end;

procedure TfrmTemplates.spiAmountChange(Sender: TObject);
begin
  (Sender as TSpinEdit).Color :=
    IfThen((Sender as TSpinEdit).Value = 0, clWhite, rgbToColor(255, 200, 255));
  if frmTemplates.Tag = 0 then
    FileToGrid;
end;

procedure TfrmTemplates.spiCommentChange(Sender: TObject);
begin
  (Sender as TSpinEdit).Color :=
    IfThen((Sender as TSpinEdit).Value = 0, clWhite, rgbToColor(200, 255, 255));
  if frmTemplates.Tag = 0 then
    FileToGrid;
end;

procedure TfrmTemplates.spiDateChange(Sender: TObject);
begin
  try
    (Sender as TSpinEdit).Color :=
      IfThen((Sender as TSpinEdit).Value = 0, clWhite, rgbToColor(255, 255, 200));
    if frmTemplates.Tag = 0 then
      FileToGrid;
  finally
  end;
end;

procedure TfrmTemplates.spiFirstChange(Sender: TObject);
begin
  if frmTemplates.Tag = 0 then
    FileToGrid;
end;

procedure TfrmTemplates.spiFirstEnter(Sender: TObject);
begin
  (Sender as TSpinEdit).Font.Style := [fsBold];
  (Sender as TSpinEdit).Parent.Color := Color_panel_focus;
end;

procedure TfrmTemplates.spiFirstExit(Sender: TObject);
begin
  (Sender as TSpinEdit).Font.Style := [];
  (Sender as TSpinEdit).Parent.Color := frmTemplates.Color;
end;

procedure TfrmTemplates.spiTypeChange(Sender: TObject);
begin
  (Sender as TSpinEdit).Color :=
    IfThen((Sender as TSpinEdit).Value = 0, clWhite, rgbToColor(222, 222, 222));
  if frmTemplates.Tag = 0 then
    FileToGrid;
end;

procedure TfrmTemplates.VSTBeforeCellPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
begin
  TargetCanvas.Brush.Color := IfThen(Node.Index mod 2 = 0, clWhite,
    frmSettings.pnlOddRowColor.Color);

  // date color
  if (spiDate.Value > 0) and (Column = spiDate.Value) then
    TargetCanvas.Brush.Color :=
      IfThen(Node.Index mod 2 = 0, spiDate.Color, frmSettings.pnlOddRowColor.Color);

  // amount color
  if (spiAmount.Value > 0) and (Column = spiAmount.Value) then
    TargetCanvas.Brush.Color :=
      IfThen(Node.Index mod 2 = 0, spiAmount.Color, frmSettings.pnlOddRowColor.Color);

  // type color
  if (rbtTypeColumn.Checked = True) and (spiType.Value > 0) and
    (Column = spiType.Value) then
    TargetCanvas.Brush.Color :=
      IfThen(Node.Index mod 2 = 0, spiType.Color, frmSettings.pnlOddRowColor.Color);

  // comment color
  if (rbtCommentColumn.Checked = True) and (spiComment.Value > 0) and
    (Column = spiComment.Value) then
    TargetCanvas.Brush.Color :=
      IfThen(Node.Index mod 2 = 0, spiComment.Color, frmSettings.pnlOddRowColor.Color);

  TargetCanvas.FillRect(CellRect);
end;

procedure TfrmTemplates.VSTGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: boolean; var ImageIndex: integer);
var
  LineX: PLineX;
begin
  if Column = 0 then
  begin
    try
      if Length(lblAmountTest.Caption) = 0 then
        ImageIndex := 5
      else
      begin
        LineX := Sender.GetNodeData(Node);
        if rbtTypeSymbol.Checked = True then
        begin
          if (Length(Linex.Value[spiAmount.Value - 1]) > 0) then
          begin
            if (LeftStr(Linex.Value[spiAmount.Value - 1], 1) = '-') then
              ImageIndex := 1
            else
              ImageIndex := 0;
          end;
        end
        else
        begin
          if (Length(Linex.Value[spiType.Value - 1]) > 0) then
          begin
            if Linex.Value[spiType.Value - 1] = ediCredit.Text then
              ImageIndex := 0
            else if Linex.Value[spiType.Value - 1] = ediDebit.Text then
              ImageIndex := 1
            else
              ImageIndex := 5;
          end
          else
            ImageIndex := 5;
        end;
      end;
    except
      ImageIndex := 5;
    end;
  end;
end;

procedure TfrmTemplates.ediNameEnter(Sender: TObject);
begin
  (Sender as TEdit).Color := Color_focus;
  (Sender as TEdit).Font.Style := [fsBold];
  (Sender as TEdit).Parent.Color := Color_panel_focus;
  (Sender as TEdit).SelStart := 0;
  (Sender as TEdit).SelLength := UTF8Length((Sender as TEdit).Text);
end;

procedure TfrmTemplates.btnExitClick(Sender: TObject);
begin
  if tabTemplates.PageIndex = 1 then
  begin
    btnCancelClick(btnCancel);
    Exit;
  end;
  frmTemplates.ModalResult := mrCancel;
end;

procedure TfrmTemplates.btnCancelClick(Sender: TObject);
begin
  tabTemplates.PageIndex := 0;
  if cbxTemplates.ItemIndex = -1 then
    VST.Clear;
  cbxTemplates.SetFocus;
end;

procedure TfrmTemplates.btnAddClick(Sender: TObject);
begin
  actEdit.Enabled := False;
  actAdd.Enabled := False;
  actDelete.Enabled := False;

  btnSave.Tag := 0;
  frmTemplates.ediName.Clear;
  frmTemplates.ediSeparator.Text := ';';
  frmTemplates.ediFormat.Text := FS_own.ShortDateFormat;
  frmTemplates.ediDecimal.Text := FS_own.DecimalSeparator;
  frmTemplates.ediThousand.Text := FS_own.ThousandSeparator;
  frmTemplates.ediCredit.Text := '';
  frmTemplates.ediDebit.Text := '';
  frmTemplates.rbtTypeSymbol.Checked := True;
  frmTemplates.rbtTypeSymbolChange(frmTemplates.rbtTypeSymbol);
  frmTemplates.rbtCommentManually.Checked := True;
  frmTemplates.rbtCommentManuallyChange(frmTemplates.rbtCommentManually);
  frmTemplates.rbtAccountManually.Checked := True;
  frmTemplates.rbtAccountManuallyChange(frmTemplates.rbtAccountManually);
  frmTemplates.rbtCategoryManually.Checked := True;
  frmTemplates.rbtCategoryManuallyChange(frmTemplates.rbtCategoryManually);
  frmTemplates.rbtPersonManually.Checked := True;
  frmTemplates.rbtPersonManuallyChange(frmTemplates.rbtPersonManually);
  frmTemplates.spiDate.Tag := 0;
  frmTemplates.spiAmount.Tag := 0;
  frmTemplates.Tag := 0;

  tabTemplates.PageIndex := 1;
  spiDate.Value := 0;
  spiAmount.Value := 0;
  spiFirst.Value := 0;

  // set max values
  frmTemplates.spiFirst.MaxValue := memTop.Lines.Count;
  frmTemplates.spiLast.MaxValue := memTop.Lines.Count;

  // set quotes (if exists)
  if (Pos('"', memTop.Lines[0]) > 0) then
    chkQuotes.Checked := True;

  // prepare origin file to grid
  FileToGrid;
  ediName.SetFocus;
end;

procedure TfrmTemplates.btnDeleteClick(Sender: TObject);
begin
  if cbxTemplates.ItemIndex = -1 then
    Exit;

  if MessageDlg(Message_00, Question_01 + sLineBreak + sLineBreak +
    cbxTemplates.Items[cbxTemplates.ItemIndex], mtConfirmation, mbYesNo, 0) <> 6 then
    Exit;

  frmMain.QRY.SQL.Text := 'DELETE FROM templates WHERE tem_name = :NAME;';
  frmMain.QRY.Params.ParamByName('NAME').AsString :=
    cbxTemplates.Items[cbxTemplates.ItemIndex];
  frmMain.QRY.Prepare;
  frmMain.QRY.ExecSQL;
  frmMain.Tran.Commit;

  UpdateTemplates;
end;

procedure TfrmTemplates.btnEditClick(Sender: TObject);
var
  S: string;
begin
  if btnEdit.Tag = 0 then
    tabTemplates.PageIndex := 1;

  btnSave.Tag := 1;
  // =========================================================================================
  frmTemplates.Tag := 1;

  if cbxTemplates.ItemIndex > -1 then
  begin
    frmMain.QRY.SQL.Text :=
      'SELECT * FROM templates WHERE tem_name = :NAME';
    frmMain.QRY.Params.ParamByName('NAME').AsString := cbxTemplates.Text;
    frmMain.QRY.Prepare;
    frmMain.QRY.Open;
    while not (frmMain.QRY.EOF) do
    begin
      frmTemplates.spiDate.MaxValue := frmMain.QRY.FieldByName('tem_columns').AsInteger;
      frmTemplates.spiAmount.MaxValue :=
        frmMain.QRY.FieldByName('tem_columns').AsInteger;
      frmTemplates.spiComment.MaxValue :=
        frmMain.QRY.FieldByName('tem_columns').AsInteger;
      frmTemplates.spiType.MaxValue := frmMain.QRY.FieldByName('tem_columns').AsInteger;

      frmTemplates.ediName.Text := frmMain.QRY.FieldByName('tem_name').AsString;
      frmTemplates.spiFirst.Value := frmMain.QRY.FieldByName('tem_first').AsInteger;
      frmTemplates.spiLast.Value := frmMain.QRY.FieldByName('tem_last').AsInteger;
      frmTemplates.ediSeparator.Text :=
        frmMain.QRY.FieldByName('tem_separator').AsString;
      frmTemplates.chkQuotes.Checked := frmMain.QRY.FieldByName('tem_quotes').AsBoolean;

      // date
      frmTemplates.spiDate.Text := frmMain.QRY.FieldByName('tem_date').AsString;
      frmTemplates.spiDate.Value := frmMain.QRY.FieldByName('tem_date').AsInteger;
      frmTemplates.ediFormat.Text := frmMain.QRY.FieldByName('tem_format').AsString;

      // amount
      frmTemplates.spiAmount.Value := frmMain.QRY.FieldByName('tem_amount').AsInteger;
      frmTemplates.ediDecimal.Text := frmMain.QRY.FieldByName('tem_decimal').AsString;
      frmTemplates.ediThousand.Text := frmMain.QRY.FieldByName('tem_thousand').AsString;

      // type
      case frmMain.QRY.FieldByName('tem_type').AsInteger of
        0: begin
          frmTemplates.rbtTypeSymbol.Checked := True;
          frmTemplates.rbtTypeSymbolChange(frmTemplates.rbtTypeSymbol);
          frmTemplates.ediCredit.Clear;
          frmTemplates.ediDebit.Clear;
        end
        else
        begin
          frmTemplates.rbtTypeColumn.Checked := True;
          frmTemplates.rbtTypeSymbolChange(frmTemplates.rbtTypeSymbol);
          frmTemplates.spiType.Value := frmMain.QRY.FieldByName('tem_type').AsInteger;
          frmTemplates.ediCredit.Text := frmMain.QRY.FieldByName('tem_credit').AsString;
          frmTemplates.ediDebit.Text := frmMain.QRY.FieldByName('tem_debit').AsString;
        end;
      end;

      // comment
      case frmMain.QRY.FieldByName('tem_comment').AsInteger of
        -1: begin
          rbtCommentAuto.Checked := True;
          rbtCommentAutoChange(rbtCommentAuto);
          cbxComment.ItemIndex :=
            cbxComment.Items.IndexOf(frmMain.QRY.FieldByName(
            'tem_comment_text').AsString);
        end;
        0: begin
          rbtCommentManually.Checked := True;
          rbtCommentManuallyChange(rbtCommentManually);
        end
        else
        begin
          rbtCommentColumn.Checked := True;
          rbtCommentColumnChange(rbtCommentColumn);
          spiComment.Value := frmMain.QRY.FieldByName('tem_comment').AsInteger;
        end;
      end;

      // Account
      try
        if frmMain.QRY.FieldByName('tem_account').AsString = '' then
        begin
          rbtAccountManually.Checked := True;
          rbtAccountManuallyChange(rbtAccountManually);
        end
        else
        begin
          rbtAccountAuto.Checked := True;
          cbxAccount.ItemIndex :=
            cbxAccount.Items.IndexOf(frmMain.QRY.FieldByName('tem_account').AsString);
        end;
      except
        begin
          rbtAccountManually.Checked := True;
          rbtAccountManuallyChange(rbtAccountManually);
        end;
      end;

      // category
      try
        S := frmMain.QRY.FieldByName('tem_category').AsString;

        if Length(S) = 0 then
        begin
          rbtCategoryManually.Checked := True;
          rbtCategoryManuallyChange(rbtCategoryManually);
        end
        else
        begin
          rbtCategoryAuto.Checked := True;
          if UTF8Pos(separ_1, S) > 0 then
          begin
            cbxCategory.ItemIndex := cbxCategory.Items.IndexOf(Field(separ_1, S, 1));
            cbxCategoryChange(cbxCategory);
            cbxSubcategory.ItemIndex :=
              cbxSubcategory.Items.IndexOf(Field(separ_1, S, 2));
          end
          else
          begin
            cbxCategory.ItemIndex := cbxCategory.Items.IndexOf(S);
            cbxCategoryChange(cbxCategory);
          end;
        end;
      except
        begin
          rbtCategoryManually.Checked := True;
          rbtCategoryManuallyChange(rbtCategoryManually);
        end;
      end;

      // person
      try
        if frmMain.QRY.FieldByName('tem_person').AsString = '' then
        begin
          rbtPersonManually.Checked := True;
          rbtPersonManuallyChange(rbtPersonManually);
        end
        else
        begin
          rbtPersonAuto.Checked := True;
          cbxPerson.ItemIndex :=
            cbxPerson.Items.IndexOf(frmMain.QRY.FieldByName('tem_person').AsString);
        end;
      except
        begin
          rbtPersonManually.Checked := True;
          rbtPersonManuallyChange(rbtPersonManually);
        end;
      end;

      //payee
      try
        if frmMain.QRY.FieldByName('tem_payee').AsString = '' then
        begin
          rbtPayeeManually.Checked := True;
          rbtPayeeManuallyChange(rbtPayeeManually);
        end
        else
        begin
          rbtPayeeAuto.Checked := True;
          cbxPayee.ItemIndex :=
            cbxPayee.Items.IndexOf(frmMain.QRY.FieldByName('tem_payee').AsString);
        end;
      except
        begin
          rbtPayeeManually.Checked := True;
          rbtPayeeManuallyChange(rbtPayeeManually);
        end;
      end;

      // tag
      VST.Tag := frmMain.QRY.FieldByName('tem_id').AsInteger;
      frmMain.QRY.Next;
    end;

    frmMain.QRY.Close;
    frmTemplates.Tag := 0;
  end;

  FileToGrid;
  if tabTemplates.PageIndex = 1 then
    ediName.SetFocus;
end;

procedure TfrmTemplates.btnPanelsClick(Sender: TObject);
begin
  popFilter.PopUp;
end;

procedure TfrmTemplates.btnImportClick(Sender: TObject);
var
  LineX: PLineX;
  N: PVirtualNode;
  Amount: double;
  D: TDate;
  S, Temp: string;
  Import, Done: boolean;
  ImageIndex: integer;
begin

  if (cbxTemplates.ItemIndex = -1) or (VST.RootNodeCount = 0) then
    Exit;

  frmEdit.Tag := 100; // for import
  Temp := frmEdit.Caption;

  N := VST.GetFirst();
  frmEdit.cbxType.Enabled := False;
  Done := False;

  while Assigned(N) do
  begin
    // get node data
    Linex := VST.GetNodeData(N);

    // date
    TryStrToDate(Linex.Value[spiDate.Value - 1], D, frmTemplates.ediFormat.Text);
    frmEdit.datDate.Date := D;

    // amount
    S := Linex.Value[spiAmount.Value - 1];
    S := AnsiReplaceStr(S, FS_own.ThousandSeparator, '');
    S := AnsiReplaceStr(S, '.', FS_own.DecimalSeparator);
    S := AnsiReplaceStr(S, ',', FS_own.DecimalSeparator);
    TryStrToFloat(S, Amount);

    // type
    Import := False;
    VST.OnGetImageIndex(VST, N, ikNormal, 0, Import, ImageIndex);
    frmEdit.cbxType.ItemIndex := ImageIndex;
    if (rbtTypeColumn.Checked = True) and (spiType.Value > 0) then
      if ImageIndex = 1 then
        Amount := -Amount;

    frmEdit.spiAmount.Text := FloatToStr(Amount);

    // account
    frmEdit.cbxAccount.ItemIndex :=
      IfThen(rbtAccountManually.Checked = True, -1, cbxAccount.ItemIndex);

    // comment
    frmEdit.cbxComment.Text :=
      IfThen(rbtCommentColumn.Checked = True, LineX.Value[spiComment.Value - 1],
      IfThen(rbtCommentManually.Checked = True, '', cbxComment.Text));

    // category
    frmEdit.cbxCategory.Items := cbxCategory.Items;
    frmEdit.cbxCategory.ItemIndex := cbxCategory.ItemIndex;
    frmEdit.cbxSubcategory.Items := cbxSubcategory.Items;
    frmEdit.cbxSubcategory.ItemIndex := cbxSubcategory.ItemIndex;

    // Person
    frmEdit.cbxPerson.ItemIndex :=
      IfThen(rbtPersonManually.Checked = True, -1, cbxPerson.ItemIndex);

    // Payee
    frmEdit.cbxPayee.ItemIndex :=
      IfThen(rbtPayeeManually.Checked = True, -1, cbxPayee.ItemIndex);

    Import := True;

    // show form Edit
    if (rbtCategoryManually.Checked = True) or (rbtPersonManually.Checked = True) or
      (rbtPayeeManually.Checked = True) then
    begin

      frmEdit.Caption := AnsiUpperCase(Caption_269) + ' ' +
        IntToStr(N.Index + 1) + '/' + IntToStr(VST.RootNodeCount);

      if frmEdit.ShowModal <> mrOk then
        Import := False;
    end;

    if Import = True then
    begin
      Done := True;

      // =============================================================================================
      // ADD CREDIT, DEBIT OR TRANSFER DEBIT
      // =============================================================================================

      // Add new category
      frmMain.QRY.SQL.Text :=
        'INSERT OR IGNORE INTO data (' + // insert
        'd_date, d_type, d_comment, d_comment_lower, d_sum, ' +
        'd_person, d_category, d_account, d_payee, d_order) ' +
        sLineBreak + 'VALUES (:DATE, :TYPE, :COMMENT, :COMMENTLOWER, :AMOUNT, '
        + // d_sum
        '(SELECT per_id FROM persons WHERE per_name = :PERSON), ' +
        sLineBreak + // d_person
        ':CATEGORY, ' + sLineBreak + // d_category
        '(SELECT acc_id FROM accounts ' +
        'WHERE acc_name = :ACCOUNT and acc_currency = :CURRENCY), ' +
        sLineBreak + // d_account
        '(SELECT pee_id FROM payees WHERE pee_name = :PAYEE),' + sLineBreak + // d_payee
        '(SELECT COUNT(d_date) FROM data WHERE d_date = :DATE) + 1);';

      // date
      frmMain.QRY.Params.ParamByName('DATE').AsString :=
        FormatDateTime('YYYY-MM-DD', frmEdit.datDate.Date);

      // type
      frmMain.QRY.Params.ParamByName('TYPE').AsInteger := frmEdit.cbxType.ItemIndex;

      // comment
      frmMain.QRY.Params.ParamByName('COMMENT').AsString :=
        Trim(frmEdit.cbxComment.Text);

      // comment lower
      frmMain.QRY.Params.ParamByName('COMMENTLOWER').AsString :=
        AnsiLowerCase(Trim(frmEdit.cbxComment.Text));

      // amount
      TryStrToFloat(frmEdit.spiAmount.Text, Amount);
      //if frmEdit.cbxType.ItemIndex = 1 then
      //  Amount := -Amount;
      S := FloatToStr(amount);
      frmMain.QRY.Params.ParamByName('AMOUNT').AsString :=
        ReplaceStr(S, FS_own.DecimalSeparator, '.');

      // person
      frmMain.QRY.Params.ParamByName('PERSON').AsString := frmEdit.cbxPerson.Text;

      // payee
      frmMain.QRY.Params.ParamByName('PAYEE').AsString := frmEdit.cbxPayee.Text;

      // account
      frmMain.QRY.Params.ParamByName('ACCOUNT').AsString :=
        Field(separ_1, frmEdit.cbxAccount.Items[frmEdit.cbxAccount.ItemIndex], 1);

      // currency
      frmMain.QRY.Params.ParamByName('CURRENCY').AsString :=
        Field(separ_1, frmEdit.cbxAccount.Items[frmEdit.cbxAccount.ItemIndex], 2);

      // category
      frmMain.QRY.Params.ParamByName('CATEGORY').AsInteger :=
        GetCategoryID(frmEdit.cbxCategory.Items[frmEdit.cbxCategory.ItemIndex] +
        IfThen(frmEdit.cbxSubcategory.ItemIndex = 0, '', separ_1 +
        frmEdit.cbxSubcategory.Items[frmEdit.cbxSubcategory.ItemIndex]));

      frmMain.QRY.Prepare;
      //ShowMessage(frmMain.QRY.SQL.Text);
      frmMain.QRY.ExecSQL;
      // =============================================================================================
    end;
    // get next node
    N := VST.GetNext(N);
  end;
  frmEdit.cbxType.Enabled := True;
  if Done = True then
  begin
    frmMain.Tran.Commit;
    ShowMessage(Message_06);
    UpdateTransactions;
    frmTemplates.ModalResult := mrCancel;
  end;

  frmEdit.Caption := Temp;
end;

procedure TfrmTemplates.btnSaveClick(Sender: TObject);
begin
  if (btnSave.Enabled = False) or (tabTemplates.PageIndex = 0) then
    Exit;

  // check comboboxes
  if (rbtAccountAuto.Checked = True) and (cbxAccount.ItemIndex = -1) then
  begin
    ShowMessage(ReplaceStr(Error_04, '%', AnsiUpperCase(pnlAccountCaption.Caption)));
    cbxAccount.SetFocus;
    Exit;
  end;

  if (rbtCategoryAuto.Checked = True) and (cbxCategory.ItemIndex = -1) then
  begin
    ShowMessage(ReplaceStr(Error_04, '%', AnsiUpperCase(pnlCategoryCaption.Caption)));
    cbxCategory.SetFocus;
    Exit;
  end;

  if (rbtPersonAuto.Checked = True) and (cbxPerson.ItemIndex = -1) then
  begin
    ShowMessage(ReplaceStr(Error_04, '%', AnsiUpperCase(pnlPersonCaption.Caption)));
    cbxPerson.SetFocus;
    Exit;
  end;

  if (rbtPayeeAuto.Checked = True) and (cbxPayee.ItemIndex = -1) then
  begin
    ShowMessage(ReplaceStr(Error_04, '%', AnsiUpperCase(pnlPayeeCaption.Caption)));
    cbxPayee.SetFocus;
    Exit;
  end;

  // SQL command
  try
    if btnSave.Tag = 0 then
      // insert new template
      frmMain.QRY.SQL.Text :=
        'INSERT INTO templates (tem_name, tem_first, tem_last, tem_separator, ' +
        'tem_quotes, tem_date, tem_format, tem_amount, tem_decimal, ' +
        'tem_thousand, tem_type, tem_credit, tem_debit, tem_account, tem_comment, ' +
        'tem_comment_text, tem_category, tem_person, tem_payee, tem_columns) VALUES (' +
        ':NAME, :FIRST, :LAST, :SEPAR, :QUOTES, :DATE, :FORMAT, :AMOUNT, :DECIMAL, ' +
        ':THOUSAND, :TYPE, :CREDIT, :DEBIT, :ACCOUNT, :COMMENT, :TEXT, :CATEGORY, :PERSON, '
        + ':PAYEE, :COLUMNS);'
    else
    begin
      // edit selected category
      frmMain.QRY.SQL.Text := 'UPDATE templates SET ' +
        'tem_name = :NAME, tem_first = :FIRST, tem_last = :LAST, tem_separator = :SEPAR,'
        +
        'tem_quotes = :QUOTES, tem_date = :DATE, tem_format = :FORMAT, tem_amount = :AMOUNT,'
        + 'tem_decimal = :DECIMAL, tem_thousand = :THOUSAND, tem_type = :TYPE,' +
        'tem_credit = :CREDIT, tem_debit = :DEBIT, tem_account = :ACCOUNT, tem_comment = :COMMENT,'
        + 'tem_comment_text = :TEXT, tem_category = :CATEGORY, tem_person = :PERSON,' +
        'tem_payee = :PAYEE, tem_columns = :COLUMNS WHERE tem_id = :ID;';
      frmMain.QRY.Params.ParamByName('ID').AsInteger := VST.Tag;
    end;

    frmMain.QRY.Params.ParamByName('NAME').AsString := ediName.Text;
    frmMain.QRY.Params.ParamByName('FIRST').AsInteger := spiFirst.Value;
    frmMain.QRY.Params.ParamByName('LAST').AsInteger := spiLast.Value;
    frmMain.QRY.Params.ParamByName('SEPAR').AsString := ediSeparator.Text;
    frmMain.QRY.Params.ParamByName('QUOTES').AsInteger :=
      IfThen(frmTemplates.chkQuotes.Checked = True, 1, 0);
    frmMain.QRY.Params.ParamByName('DATE').AsInteger := spiDate.Value;
    frmMain.QRY.Params.ParamByName('FORMAT').AsString := ediFormat.Text;
    frmMain.QRY.Params.ParamByName('AMOUNT').AsInteger := spiAmount.Value;
    frmMain.QRY.Params.ParamByName('DECIMAL').AsString := ediDecimal.Text;
    frmMain.QRY.Params.ParamByName('THOUSAND').AsString := ediThousand.Text;
    frmMain.QRY.Params.ParamByName('TYPE').AsInteger :=
      IfThen(rbtTypeSymbol.Checked = True, 0, spiType.Value);
    frmMain.QRY.Params.ParamByName('CREDIT').AsString := ediCredit.Text;
    frmMain.QRY.Params.ParamByName('DEBIT').AsString := ediDebit.Text;
    frmMain.QRY.Params.ParamByName('COMMENT').AsInteger :=
      IfThen(rbtCommentAuto.Checked = True, -1,
      IfThen(rbtCommentManually.Checked = True, 0, spiComment.Value));
    frmMain.QRY.Params.ParamByName('TEXT').AsString := cbxComment.Text;

    if rbtAccountManually.Checked = True then
      frmMain.QRY.Params.ParamByName('ACCOUNT').AsString := ''
    else
      frmMain.QRY.Params.ParamByName('ACCOUNT').AsString :=
        cbxAccount.Items[cbxAccount.ItemIndex];

    if rbtCategoryManually.Checked = True then
      frmMain.QRY.Params.ParamByName('CATEGORY').AsString := ''
    else
      frmMain.QRY.Params.ParamByName('CATEGORY').AsString :=
        cbxCategory.Items[cbxCategory.ItemIndex] +
        IfThen(cbxSubcategory.ItemIndex > 0, separ_1 +
        cbxSubcategory.Items[cbxSubcategory.ItemIndex], '');

    if rbtPersonManually.Checked = True then
      frmMain.QRY.Params.ParamByName('PERSON').AsString := ''
    else
      frmMain.QRY.Params.ParamByName('PERSON').AsString :=
        cbxPerson.Items[cbxPerson.ItemIndex];

    if rbtPayeeManually.Checked = True then
      frmMain.QRY.Params.ParamByName('PAYEE').AsString := ''
    else
      frmMain.QRY.Params.ParamByName('PAYEE').AsString :=
        cbxPayee.Items[cbxPayee.ItemIndex];


    frmMain.QRY.Params.ParamByName('COLUMNS').AsInteger := VST.Header.Columns.Count;

    frmMain.QRY.Prepare;
    frmMain.QRY.ExecSQL;
    frmMain.Tran.Commit;
  finally
    btnCancelClick(btnCancel);
    UpdateTemplates;
    cbxTemplates.ItemIndex := cbxTemplates.Items.IndexOf(ediName.Text);
    cbxTemplatesChange(cbxTemplates);
  end;
end;

procedure TfrmTemplates.cbxCategoryChange(Sender: TObject);
begin
  try
    if cbxCategory.ItemIndex > -1 then
      FillSubcategory(cbxCategory.Items[cbxCategory.ItemIndex],
        frmTemplates.cbxSubcategory);
  except
  end;
end;

procedure TfrmTemplates.cbxCommentEnter(Sender: TObject);
begin
  (Sender as TComboBox).Color := Color_focus;
  (Sender as TComboBox).Font.Style := [fsBold];
  (Sender as TComboBox).Parent.Color := Color_panel_focus;
end;

procedure TfrmTemplates.cbxCommentExit(Sender: TObject);
var
  W: integer;
begin
  (Sender as TComboBox).Color := clDefault;
  (Sender as TComboBox).Font.Style := [];
  (Sender as TComboBox).Parent.Color := frmTemplates.Color;

  if (Sender as TCombobox).Name = 'cbxComment' then
    Exit;

  if (Sender as TComboBox).ItemIndex = -1 then
    (Sender as TComboBox).Text := ''
  else
  begin
    W := (Sender as TComboBox).ItemIndex;
    (Sender as TComboBox).ItemIndex := -1;
    (Sender as TComboBox).Text := '';
    (Sender as TComboBox).ItemIndex := W;
  end;
end;

procedure TfrmTemplates.cbxTemplatesChange(Sender: TObject);
begin
  btnEdit.Enabled := cbxTemplates.ItemIndex > -1;
  btnDelete.Enabled := cbxTemplates.ItemIndex > -1;
  btnImport.Enabled := cbxTemplates.ItemIndex > -1;

  VST.Clear;
  VST.RootNodeCount := 0;

  // delete previous columns
  while frmTemplates.VST.Header.Columns.Count > 1 do
    frmTemplates.VST.Header.Columns.Delete(1);

  if cbxTemplates.ItemIndex = -1 then
    Exit;

  btnEdit.Tag := 1;
  btnEditClick(btnEdit);
  btnEdit.Tag := 0;
end;

procedure TfrmTemplates.chkQuotesChange(Sender: TObject);
begin
  if frmTemplates.Tag = 0 then
    FileToGrid;
end;

procedure TfrmTemplates.chkQuotesEnter(Sender: TObject);
begin
  (Sender as TCheckBox).Font.Style := [fsBold];
end;

procedure TfrmTemplates.chkQuotesExit(Sender: TObject);
begin
  (Sender as TCheckBox).Font.Style := [];
end;

procedure TfrmTemplates.ediCreditChange(Sender: TObject);
begin
  VST.Repaint;
end;

procedure TfrmTemplates.ediSeparatorChange(Sender: TObject);
begin
  if (frmTemplates.Tag = 0) and (Length(ediSeparator.Text) = 1) then
    FileToGrid;
end;

procedure TfrmTemplates.ediNameChange(Sender: TObject);
begin
  btnSave.Enabled := Length(ediName.Text) > 0;
end;

procedure TfrmTemplates.ediNameExit(Sender: TObject);
begin
  (Sender as TEdit).Color := clDefault;
  (Sender as TEdit).Font.Style := [];
  (Sender as TEdit).Parent.Color := frmTemplates.Color;
  (Sender as TEdit).SelStart := 1;
  (Sender as TEdit).SelLength := 0;
end;

procedure TfrmTemplates.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var
  INI: TINIFile;
  INIFile: string;
begin
  if tabTemplates.PageIndex = 1 then
  begin
    btnCancelClick(btnCancel);
    CloseAction := caNone;
  end;
  try
    // write position and window size
    if frmSettings.chkLastFormsSize.Checked = True then
    begin
      try
        INIFile := ChangeFileExt(ParamStr(0), '.ini');
        INI := TINIFile.Create(INIFile);
        if INI.ReadString('POSITION', frmTemplates.Name, '') <>
          IntToStr(frmTemplates.Left) + separ + // form left
        IntToStr(frmTemplates.Top) + separ + // form top
        IntToStr(frmTemplates.Width) + separ + // form width
        IntToStr(frmTemplates.Height) + separ + // form height
        IntToStr(frmTemplates.pnlLeft.Width) then
          INI.WriteString('POSITION', frmTemplates.Name,
            IntToStr(frmTemplates.Left) + separ + // form left
            IntToStr(frmTemplates.Top) + separ + // form top
            IntToStr(frmTemplates.Width) + separ + // form width
            IntToStr(frmTemplates.Height) + separ + // form height
            IntToStr(frmTemplates.pnlLeft.Width));
      finally
        INI.Free;
      end;
    end;
  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

procedure TfrmTemplates.FormCreate(Sender: TObject);
begin
  // images
  frmMain.imgArrows.GetBitmap(1, imgOrigin.Picture.Bitmap);
  frmMain.imgArrows.GetBitmap(1, imgDate.Picture.Bitmap);
  frmMain.imgArrows.GetBitmap(1, imgAmount.Picture.Bitmap);
  frmMain.imgArrows.GetBitmap(1, imgType.Picture.Bitmap);
  frmMain.imgArrows.GetBitmap(1, imgComment.Picture.Bitmap);
  frmMain.imgArrows.GetBitmap(1, imgCategory.Picture.Bitmap);
  frmMain.imgArrows.GetBitmap(1, imgPerson.Picture.Bitmap);
  frmMain.imgArrows.GetBitmap(1, imgPayee.Picture.Bitmap);
  frmMain.imgArrows.GetBitmap(1, imgAccount.Picture.Bitmap);

  // get form icon
  frmMain.img16.GetIcon(3, (Sender as TForm).Icon);

  pnlCommentCaptionClick(pnlCommentCaption);
  pnlCategoryCaptionClick(pnlCategoryCaption);
  pnlPersonCaptionClick(pnlPersonCaption);
  pnlPayeeCaptionClick(pnlPayeeCaption);

  pnlSettingsCaption.Height := PanelHeight;
  pnlTopCaption.Height := PanelHeight;
  btnSave.Height := ButtonHeight;
  btnImport.Height := ButtonHeight;
  btnCancel.Height := ButtonHeight;
  btnExit.Height := ButtonHeight;
  pnlBottomCaption.Height := ButtonHeight;
  pnlButtons.Height := ButtonHeight;
  pnlBottom1.Height := ButtonHeight;

  pnlOriginCaption.Height := PanelHeight;
  pnlDateCaption.Height := PanelHeight;
  pnlTypeCaption.Height := PanelHeight;
  pnlAmountCaption.Height := PanelHeight;
  pnlCommentCaption.Height := PanelHeight;
  pnlCategoryCaption.Height := PanelHeight;
  pnlPersonCaption.Height := PanelHeight;
  pnlPayeeCaption.Height := PanelHeight;
  pnlAccountCaption.Height := PanelHeight;

  VST.Header.Height := PanelHeight;
  if VST.Header.Height < 20 then
    VST.Header.Height := 20;
end;

procedure TfrmTemplates.FormResize(Sender: TObject);
begin
  lblWidth.Caption := IntToStr((Sender as TForm).Width);
  lblHeight.Caption := IntToStr((Sender as TForm).Height);
end;

procedure TfrmTemplates.FormShow(Sender: TObject);
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
      frmTemplates.Position := poDesigned;
      S := INI.ReadString('POSITION', frmTemplates.Name, '-1•-1•0•0•0');

      // width
      TryStrToInt(Field(Separ, S, 3), I);
      if (I < 1) or (I > Screen.Width) then
        frmTemplates.Width := Screen.Width - 300 - (200 - ScreenRatio)
      else
        frmTemplates.Width := I;

      /// height
      TryStrToInt(Field(Separ, S, 4), I);
      if (I < 1) or (I > Screen.Height) then
        frmTemplates.Height := Screen.Height - 400 - (200 - ScreenRatio)
      else
        frmTemplates.Height := I;

      // left
      TryStrToInt(Field(Separ, S, 1), I);
      if (I < 0) or (I > Screen.Width) then
        frmTemplates.left := (Screen.Width - frmTemplates.Width) div 2
      else
        frmTemplates.Left := I;

      // top
      TryStrToInt(Field(Separ, S, 2), I);
      if (I < 0) or (I > Screen.Height) then
        frmTemplates.Top := ((Screen.Height - frmTemplates.Height) div 2) - 75
      else
        frmTemplates.Top := I;

      // detail panel
      TryStrToInt(Field(Separ, S, 5), I);
      if (I < 200) or (I > 400) then
        frmTemplates.pnlLeft.Width := Round(200 * (ScreenRatio / 100))
      else
        frmTemplates.pnlLeft.Width := I;
    end;
  finally
    INI.Free
  end;
  // ********************************************************************
  // FORM SIZE END
  // ********************************************************************

  // read origin file
  memTop.Lines.LoadFromFile(frmImport.lblFileName.Caption);

  tabTemplates.PageIndex := 0;
  cbxTemplates.ItemIndex := -1;
  memTop.Font.Size := VST.Font.Size;

  // update list of templates
  UpdateTemplates;
  cbxTemplates.ItemIndex := -1;
  cbxTemplatesChange(cbxTemplates);
end;

procedure TfrmTemplates.Page1BeforeShow(ASender: TObject; ANewPage: TPage;
  ANewIndex: integer);
begin
  btnPanels.Visible := ANewIndex = 1;
  actDelete.Enabled := ANewIndex = 0;
  actAdd.Enabled := ANewIndex = 0;
  actEdit.Enabled := ANewIndex = 0;
  actDelete.Enabled := ANewIndex = 0;

end;

procedure TfrmTemplates.pnlAccountCaptionClick(Sender: TObject);
begin
  pnlAccountCaption.Tag := 1 - pnlAccountCaption.Tag;
  pnlAccountClient.Visible := pnlAccountCaption.Tag = 1;
  frmMain.imgArrows.GetBitmap(pnlAccountCaption.Tag, imgAccount.Picture.Bitmap);
end;

procedure TfrmTemplates.pnlAmountCaptionClick(Sender: TObject);
begin
  pnlAmountCaption.Tag := 1 - pnlAmountCaption.Tag;
  pnlAmountClient.Visible := pnlAmountCaption.Tag = 1;
  frmMain.imgArrows.GetBitmap(pnlAmountCaption.Tag, imgAmount.Picture.Bitmap);
end;

procedure TfrmTemplates.pnlButtonsResize(Sender: TObject);
begin
  btnAdd.Width := pnlButtons.Width div 3;
  btnDelete.Width := pnlButtons.Width div 3;
end;

procedure TfrmTemplates.pnlCategoryCaptionClick(Sender: TObject);
begin
  pnlCategoryCaption.Tag := 1 - pnlCategoryCaption.Tag;
  pnlCategoryClient.Visible := pnlCategoryCaption.Tag = 1;
  frmMain.imgArrows.GetBitmap(pnlCategoryCaption.Tag, imgCategory.Picture.Bitmap);
end;

procedure TfrmTemplates.VSTGetNodeDataSize(Sender: TBaseVirtualTree;
  var NodeDataSize: integer);
begin
  NodeDataSize := SizeOf(TLineX);
end;

procedure TfrmTemplates.VSTGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  LineX: PLineX;
begin
  if Column = 0 then Exit;
  LineX := Sender.GetNodeData(Node);
  CellText := LineX.Value[Column - 1];
end;

procedure TfrmTemplates.VSTResize(Sender: TObject);
var
  J: byte;
begin
  (Sender as TLazVirtualStringTree).Header.Columns[0].Width :=
    round(Screen.PixelsPerInch div 96 * 25);
  for J := 1 to frmTemplates.VST.Header.Columns.Count - 1 do
    frmTemplates.VST.Header.Columns[J].Width :=
      (frmTemplates.VST.Width - 50) div (frmTemplates.VST.Header.Columns.Count - 1);
end;

procedure FileToGrid;
var
  I, J, K: integer;
  S: string;
  LineX: PLineX;
  P: PVirtualNode;
  D: TDate;
  Amount: double;
begin

  // clear grid
  frmTemplates.VST.Clear;
  frmTemplates.VST.RootNodeCount := 0;
  frmTemplates.VST.Refresh;

  frmTemplates.lblDateTest.Caption := '';
  frmTemplates.lblAmountTest.Caption := '';
  Amount := 0.0;

  try
    // delete previous columns
    while frmTemplates.VST.Header.Columns.Count > 1 do
      frmTemplates.VST.Header.Columns.Delete(1);
  finally
  end;

  // add new columns
  S := frmTemplates.memTop.Lines[frmTemplates.spiFirst.Value];
  J := UTF8Pos(frmTemplates.ediSeparator.Text, S, 1);
  I := 1;
  try
    while J > 0 do
    begin
      frmTemplates.VST.Header.Columns.Add;
      frmTemplates.VST.Header.Columns[I].Text := IntToStr(I);
      Inc(I);
      J := UTF8Pos(frmTemplates.ediSeparator.Text, S, J + 1);
    end;
    frmTemplates.VST.Header.Columns.Add;
    frmTemplates.VST.Header.Columns[I].Text := IntToStr(I);
  finally
  end;

  try
    // set columns width
    for J := 1 to frmTemplates.VST.Header.Columns.Count - 1 do
      frmTemplates.VST.Header.Columns[J].Width :=
        (frmTemplates.VST.Width - 50) div (frmTemplates.VST.Header.Columns.Count - 1);

    // set max values
    frmTemplates.Tag := 1;
    frmTemplates.spiDate.MaxValue := frmTemplates.VST.Header.Columns.Count - 1;
    frmTemplates.spiAmount.MaxValue := frmTemplates.VST.Header.Columns.Count - 1;
    frmTemplates.spiType.MaxValue := frmTemplates.VST.Header.Columns.Count - 1;
    frmTemplates.spiComment.MaxValue := frmTemplates.VST.Header.Columns.Count - 1;
    frmTemplates.Tag := 0;
  finally
  end;

  // read lines
  try
    K := frmTemplates.memTop.Lines.Count - frmTemplates.spiLast.Value - 1;
    if K < 0 then
      Exit;
  finally
  end;

  try
    for I := frmTemplates.spiFirst.Value to K do
    begin
      frmTemplates.VST.RootNodeCount := frmTemplates.VST.RootNodeCount + 1;
      P := frmTemplates.VST.GetLast();
      LineX := frmTemplates.VST.GetNodeData(P);
      SetLength(LineX.Value, frmTemplates.VST.Header.Columns.Count - 1);

      for J := 1 to frmTemplates.VST.Header.Columns.Count - 1 do
      begin
        LineX.Value[J - 1] :=
          Trim(Field(frmTemplates.ediSeparator.Text[1],
          frmTemplates.memTop.Lines[I], J));
        if (frmTemplates.chkQuotes.Checked = True) then
          LineX.Value[J - 1] := AnsiReplaceStr(LineX.Value[J - 1], '"', '');
      end;
    end;
  finally
  end;

  // test the first date value
  try
    if (frmTemplates.spiDate.Value > 0) and (frmTemplates.ediFormat.Text <> '') then
    begin
      S := frmTemplates.VST.Text[frmTemplates.VST.GetFirst(),
        frmTemplates.spiDate.Value];
      try
        D := StrToDate(S, frmTemplates.ediFormat.Text);
        frmTemplates.lblDateTest.Caption := DateToStr(D, FS_own);
        frmTemplates.VST.Header.Columns[frmTemplates.spiDate.Value].Text :=
          Trim(frmTemplates.pnlDateCaption.Caption);
        frmTemplates.lblDateTest.Font.Color :=
          IfThen(frmTemplates.lblDateTest.Caption = '', clDefault, clGreen);
        frmTemplates.Caption := DateToStr(D) + ' - ' + frmTemplates.lblDateTest.Caption;
        frmTemplates.lblDateTest.Repaint;
      except
      end;
    end;
  except
  end;

  // test the first amount value
  try
    if (frmTemplates.spiAmount.Value > 0) and (frmTemplates.ediThousand.Text <> '') and
      (frmTemplates.ediDecimal.Text <> '') then
    begin
      try
        S := frmTemplates.VST.Text[frmTemplates.VST.GetFirst(),
          frmTemplates.spiAmount.Value];
        S := AnsiReplaceStr(S, FS_own.ThousandSeparator, '');
        S := AnsiReplaceStr(S, frmTemplates.ediThousand.Text, '');
        TryStrToFloat(S, Amount);
      finally
        if Amount <> 0 then
        begin
          frmTemplates.lblAmountTest.Caption := Format('%n', [Amount], FS_own);
          frmTemplates.VST.Header.Columns[frmTemplates.spiAmount.Value].Text :=
            Trim(frmTemplates.pnlAmountCaption.Caption);
          frmTemplates.lblAmountTest.Font.Color :=
            IfThen(Amount = 0, clDefault, clGreen);
        end;
      end;
    end;
  except
  end;

  // comment column caption
  try
    if (frmTemplates.rbtCommentColumn.Checked) and
      (frmTemplates.spiComment.Value > 0) then
      frmTemplates.VST.Header.Columns[frmTemplates.spiComment.Value].Text :=
        Trim(frmTemplates.pnlCommentCaption.Caption);
    SetNodeHeight(frmTemplates.VST);
  except
  end;
end;

procedure UpdateTemplates;
begin
  if frmMain.Conn.Connected = False then Exit;
  frmTemplates.cbxTemplates.Clear;
  frmMain.QRY.SQL.Text :=
    'SELECT tem_name FROM templates';
  frmMain.QRY.Open;
  while not (frmMain.QRY.EOF) do
  begin
    frmTemplates.cbxTemplates.Items.Add(frmMain.QRY.Fields[0].AsString);
    frmMain.QRY.Next;
  end;
  frmMain.QRY.Close;
  //  if frmTemplates.cbxTemplates.Items.Count = 0 then
  frmTemplates.cbxTemplates.ItemIndex := -1;
{  else
  begin
    frmTemplates.cbxTemplates.ItemIndex := 0;
    if Length(frmTemplates.ediName.Text) > 0 then
      frmTemplates.cbxTemplates.ItemIndex :=
        frmTemplates.cbxTemplates.Items.IndexOf(frmTemplates.ediName.Text);
  end;
  frmTemplates.cbxTemplatesChange(frmTemplates.cbxTemplates);}
end;

end.
