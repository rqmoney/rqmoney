unit uniTimeStamp;

{$mode ObjFPC}{$H+}
{$ModeSwitch AutoDeref}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  ActnList, laz.VirtualTrees, BCMDButtonFocus, Math;

type // TimeStamp
  TTime = record
    Comment: string;
    TimeStamp: string;
  end;
  PTime = ^TTime;

type

  { TfrmTimeStamp }

  TfrmTimeStamp = class(TForm)
    actExit: TAction;
    ActionList1: TActionList;
    btnExit: TBCMDButtonFocus;
    imgHeight: TImage;
    imgWidth: TImage;
    lblHeight: TLabel;
    lblWidth: TLabel;
    pnlBottom: TPanel;
    pnlButtons: TPanel;
    pnlHeight: TPanel;
    pnlWidth: TPanel;
    VST: TLazVirtualStringTree;
    procedure btnExitClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure VSTBeforeCellPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
    procedure VSTGetNodeDataSize(Sender: TBaseVirtualTree;
      var NodeDataSize: integer);
    procedure VSTGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure VSTPaintText(Sender: TBaseVirtualTree; const TargetCanvas: TCanvas;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType);
    procedure VSTResize(Sender: TObject);
  private

  public

  end;

var
  frmTimeStamp: TfrmTimeStamp;

implementation

{$R *.lfm}

uses
  uniMain, uniSettings;

  { TfrmTimeStamp }

procedure TfrmTimeStamp.VSTGetNodeDataSize(Sender: TBaseVirtualTree;
  var NodeDataSize: integer);
begin
  NodeDataSize := SizeOf(TTimeStamp);
end;

procedure TfrmTimeStamp.VSTGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  Time: PTime;

begin
  Time := VST.GetNodeData(Node);
  try
    case Column of
      0: CellText := Time.Comment;
      1: CellText := Time.TimeStamp;
      2:
        case VST.GetNodeLevel(Node) of
          0: if (Node.Index = 0) then
              CellText := Time.TimeStamp
            else
              CellText := IntToStr(StrToInt(Time.TimeStamp) -
                StrToInt(VST.Text[Node.PrevSibling, 1]));
          1: if (Node.Index = 0) then
              begin
              CellText := IntToStr(StrToInt(Time.TimeStamp) -
                StrToInt(VST.Text[(Node.Parent).PrevSibling, 1]));
              end
            else
              CellText := IntToStr(StrToInt(Time.TimeStamp) -
                StrToInt(VST.Text[Node.PrevSibling, 1]));
        end;
    end;
  except
  end;
end;

procedure TfrmTimeStamp.VSTPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
begin
  TargetCanvas.Font.Color := IfThen(Dark = False, IfThen(
    (Sender as TLazVirtualStringTree).GetNodeLevel(Node) = 0, clDefault, clgray),
    IfThen((Sender as TLazVirtualStringTree).GetNodeLevel(Node) = 0, clSilver, $0000B5BF));
  // TargetCanvas.Font.Bold := (Sender as TLazVirtualStringTree).GetNodeLevel(Node) = 0;
end;

procedure TfrmTimeStamp.VSTResize(Sender: TObject);
var
  X: integer;
begin
  try
    X := round((VST.Width - ScrollBarWidth) / 100);
    VST.Header.Columns[0].Width := 49 * X;
    VST.Header.Columns[1].Width := 25 * X;
    VST.Header.Columns[2].Width := 25 * X;
  except
  end;
end;

procedure TfrmTimeStamp.FormResize(Sender: TObject);
begin
  lblWidth.Caption := IntToStr((Sender as TForm).Width);
  lblHeight.Caption := IntToStr((Sender as TForm).Height);
end;

procedure TfrmTimeStamp.btnExitClick(Sender: TObject);
begin
  frmTimeStamp.ModalResult := mrCancel;
end;

procedure TfrmTimeStamp.FormShow(Sender: TObject);
var
  Time: PTime;
  I, J: byte;
  N: PVirtualNode;
begin
  if frmTimeStamp.Tag = 1 then
    Exit;

  for I := 0 to 42 do
  begin
    if (I = 0) or ((I > 0) and (TimeLog[I, 1] <> TimeLog[I - 1, 1])) then
    begin
      VST.RootNodeCount := VST.RootNodeCount + 1;
      N := VST.GetLast();
      Time := VST.GetNodeData(N);
      Time.Comment := TimeLog[I, 0];
      Time.TimeStamp := TimeLog[I, 1];
      if I = 42 then
        for J := 43 to 67 do
        begin
          if (J = 43) or ((J > 43) and (TimeLog[J, 1] <> TimeLog[J - 1, 1])) and
            (TimeLog[J, 0] <> '') and (TimeLog[J, 1] <> '') then
          begin
            VST.ChildCount[N] := VST.ChildCount[N] + 1;
            Time := VST.GetNodeData(VST.GetLastChild(N));
            Time.Comment := TimeLog[J, 0];
            Time.TimeStamp := TimeLog[J, 1];
          end;
        end;
    end;
  end;
  frmTimeStamp.Tag := 1;
end;

procedure TfrmTimeStamp.VSTBeforeCellPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
begin
  TargetCanvas.Brush.Color := // color
    IfThen(Node.Index mod 2 = 0, // odd row
    IfThen(Dark = False, clWhite, rgbToColor(22, 22, 22)),
    IfThen(Dark = False, frmSettings.pnlOddRowColor.Color,
    Brighten(frmSettings.pnlOddRowColor.Color, 44)));
  TargetCanvas.FillRect(CellRect);
end;

end.
