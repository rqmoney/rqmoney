unit uniSplash;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls,
  ExtCtrls, BGRAFlashProgressBar, BCPanel;

type

  { TfrmSplash }

  TfrmSplash = class(TForm)
    lblSplash: TLabel;
    Panel1: TBCPanel;
    prgSplash: TBGRAFlashProgressBar;
  private

  public

  end;

var
  frmSplash: TfrmSplash;

implementation

{$R *.lfm}

end.

