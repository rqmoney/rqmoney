unit uniSplash;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls,
  ExtCtrls, BGRAFlashProgressBar;

type

  { TfrmSplash }

  TfrmSplash = class(TForm)
    Panel1: TPanel;
    prgSplash: TBGRAFlashProgressBar;
    lblSplash: TLabel;
  private

  public

  end;

var
  frmSplash: TfrmSplash;

implementation

{$R *.lfm}

{ TfrmSplash }

end.

