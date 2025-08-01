program rqm;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  {$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  {$IFDEF WINDOWS}
  Windows,
  {$ENDIF}
  Forms, SysUtils,
  uniTags,
  uniValues,
  uniAbout,
  uniAccounts,
  uniCounter,
  uniCategories,
  uniComments,
  uniCurrencies,
  uniEdit,
  uniEdits,
  uniFilter,
  uniGate,
  uniGuide,
  uniHolidays,
  uniMain,
  uniPassword,
  uniPayees,
  uniPersons,
  uniProperties,
  uniRecycleBin,
  uniSettings,
  uniScheduler,
  uniSQL,
  uniSQLResults,
  uniSuccess,
  lazcontrols,
  tachartlazaruspkg,
  datetimectrls,
  uniImport,
  uniDetail,
  uniDelete,
  uniHistory,
  uniSchedulers,
  uniWrite,
  uniManyCurrencies,
  uniShortCut,
  uniCalendar,
  Dialogs,
  uniwriting,
  uniResources,
  uniPeriod,
  uniPlan,
  uniBudgets,
  uniBudget,
  uniTemplates,
  uniLinks,
  uniImage,
  uniSplash,
  uniTimeStamp;

  {$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.Title := 'RQ MONEY';

  Application.Scaled := True;
  Application.Initialize;

  // frmSplash
  frmSplash := TfrmSplash.Create(nil);
  frmSplash.lblSplash.Caption := Application.Title;
  frmSplash.Show;

  // frmMain
  TimeStart := GetTickCount64;
  Application.CreateForm(TfrmMain, frmMain);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 1;
  frmSplash.Update;
  TimeLog[0, 0] := 'frmMain';
  TimeLog[0, 1] := IntToStr(GetTickCount64 - TimeStart);

  // frmPassword
  Application.CreateForm(TfrmPassword, frmPassword);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 1;
  frmSplash.Update;
  TimeLog[1, 0] := 'frmPassword';
  TimeLog[1, 1] := IntToStr(GetTickCount64 - TimeStart);

  // frmGate
  Application.CreateForm(TfrmGate, frmGate);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 1;
  frmSplash.Update;
  TimeLog[2, 0] := 'frmGate';
  TimeLog[2, 1] := IntToStr(GetTickCount64 - TimeStart);

  // frmGuide
  Application.CreateForm(TfrmGuide, frmGuide);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 1;
  frmSplash.Update;
  TimeLog[3, 0] := 'frmGuide';
  TimeLog[3, 1] := IntToStr(GetTickCount64 - TimeStart);

  // frmFilter
  Application.CreateForm(TfrmFilter, frmFilter);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 1;
  frmSplash.Update;
  TimeLog[4, 0] := 'frmFilter';
  TimeLog[4, 1] := IntToStr(GetTickCount64 - TimeStart);

  // frmValue
  Application.CreateForm(TfrmValues, frmValues);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 1;
  frmSplash.Update;
  TimeLog[5, 0] := 'frmValue';
  TimeLog[5, 1] := IntToStr(GetTickCount64 - TimeStart);

  // frmCurrencies
  Application.CreateForm(TfrmCurrencies, frmCurrencies);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 1;
  frmSplash.Update;
  TimeLog[6, 0] := 'frmCurrencies';
  TimeLog[6, 1] := IntToStr(GetTickCount64 - TimeStart);

  // frmCounter
  Application.CreateForm(TfrmCounter, frmCounter);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 1;
  frmSplash.Update;
  TimeLog[7, 0] := 'frmCounter';
  TimeLog[7, 1] := IntToStr(GetTickCount64 - TimeStart);

  // frmAccounts
  Application.CreateForm(TfrmAccounts, frmAccounts);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 1;
  frmSplash.Update;
  TimeLog[8, 0] := 'frmAccounts';
  TimeLog[8, 1] := IntToStr(GetTickCount64 - TimeStart);

  // frmAbout
  Application.CreateForm(TfrmAbout, frmAbout);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 1;
  frmSplash.Update;
  TimeLog[9, 0] := 'frmAbout';
  TimeLog[9, 1] := IntToStr(GetTickCount64 - TimeStart);

  // frmPersons
  Application.CreateForm(TfrmPersons, frmPersons);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 1;
  frmSplash.Update;
  TimeLog[10, 0] := 'frmPersons';
  TimeLog[10, 1] := IntToStr(GetTickCount64 - TimeStart);

  // frmPayees
  Application.CreateForm(TfrmPayees, frmPayees);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 1;
  frmSplash.Update;
  TimeLog[11, 0] := 'frmPayees';
  TimeLog[11, 1] := IntToStr(GetTickCount64 - TimeStart);

  // frmTags
  Application.CreateForm(TfrmTags, frmTags);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 1;
  frmSplash.Update;
  TimeLog[12, 0] := 'frmTags';
  TimeLog[12, 1] := IntToStr(GetTickCount64 - TimeStart);

  // frmHoidays
  Application.CreateForm(TfrmHolidays, frmHolidays);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 1;
  frmSplash.Update;
  TimeLog[13, 0] := 'frmHolidays';
  TimeLog[13, 1] := IntToStr(GetTickCount64 - TimeStart);

  // frmSuccess
  Application.CreateForm(TfrmSuccess, frmSuccess);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 1;
  frmSplash.Update;
  TimeLog[14, 0] := 'frmSuccess';
  TimeLog[14, 1] := IntToStr(GetTickCount64 - TimeStart);

  // frmComments
  Application.CreateForm(TfrmComments, frmComments);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 1;
  frmSplash.Update;
  TimeLog[15, 0] := 'frmComments';
  TimeLog[15, 1] := IntToStr(GetTickCount64 - TimeStart);

  // frmCategores
  Application.CreateForm(TfrmCategories, frmCategories);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 1;
  frmSplash.Update;
  TimeLog[16, 0] := 'frmCategories';
  TimeLog[16, 1] := IntToStr(GetTickCount64 - TimeStart);

  // frmScheduler
  Application.CreateForm(TfrmScheduler, frmScheduler);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 1;
  frmSplash.Update;
  TimeLog[17, 0] := 'frmScheduler';
  TimeLog[17, 1] := IntToStr(GetTickCount64 - TimeStart);

  // frmSchedulers
  Application.CreateForm(TfrmSchedulers, frmSchedulers);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 1;
  frmSplash.Update;
  TimeLog[18, 0] := 'frmSchedulers';
  TimeLog[18, 1] := IntToStr(GetTickCount64 - TimeStart);

  // frmSQL
  Application.CreateForm(TfrmSQL, frmSQL);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 1;
  frmSplash.Update;
  TimeLog[19, 0] := 'frmSQL';
  TimeLog[19, 1] := IntToStr(GetTickCount64 - TimeStart);

  // frmSQLResult
  Application.CreateForm(TfrmSQLResult, frmSQLResult);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 1;
  frmSplash.Update;
  TimeLog[20, 0] := 'frmSQLResult';
  TimeLog[20, 1] := IntToStr(GetTickCount64 - TimeStart);

  // frmProperties
  Application.CreateForm(TfrmProperties, frmProperties);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 1;
  frmSplash.Update;
  TimeLog[21, 0] := 'frmProperties';
  TimeLog[21, 1] := IntToStr(GetTickCount64 - TimeStart);

  // frmRecycleBin
  Application.CreateForm(TfrmRecycleBin, frmRecycleBin);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 1;
  frmSplash.Update;
  TimeLog[22, 0] := 'frmRecycleBin';
  TimeLog[22, 1] := IntToStr(GetTickCount64 - TimeStart);

  // frmImport
  Application.CreateForm(TfrmImport, frmImport);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 1;
  frmSplash.Update;
  TimeLog[23, 0] := 'frmImport';
  TimeLog[23, 1] := IntToStr(GetTickCount64 - TimeStart);

  // frmDetail
  Application.CreateForm(TfrmDetail, frmDetail);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 1;
  frmSplash.Update;
  TimeLog[24, 0] := 'frmDetail';
  TimeLog[24, 1] := IntToStr(GetTickCount64 - TimeStart);

  // frmEdit
  Application.CreateForm(TfrmEdit, frmEdit);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 1;
  frmSplash.Update;
  TimeLog[25, 0] := 'frmEdit';
  TimeLog[25, 1] := IntToStr(GetTickCount64 - TimeStart);

  // frmEdits
  Application.CreateForm(TfrmEdits, frmEdits);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 2;
  frmSplash.Update;
  TimeLog[26, 0] := 'frmEdits';
  TimeLog[26, 1] := IntToStr(GetTickCount64 - TimeStart);

  // frmDelete
  Application.CreateForm(TfrmDelete, frmDelete);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 2;
  frmSplash.Update;
  TimeLog[27, 0] := 'frmDelete';
  TimeLog[27, 1] := IntToStr(GetTickCount64 - TimeStart);

  // frmHistory
  Application.CreateForm(TfrmHistory, frmHistory);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 2;
  frmSplash.Update;
  TimeLog[28, 0] := 'frmHistory';
  TimeLog[28, 1] := IntToStr(GetTickCount64 - TimeStart);

  // frmWrite
  Application.CreateForm(TfrmWrite, frmWrite);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 2;
  frmSplash.Update;
  TimeLog[29, 0] := 'frmWrite';
  TimeLog[29, 1] := IntToStr(GetTickCount64 - TimeStart);

  // frmWriting
  Application.CreateForm(TfrmWriting, frmWriting);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 2;
  frmSplash.Update;
  TimeLog[30, 0] := 'frmWriting';
  TimeLog[30, 1] := IntToStr(GetTickCount64 - TimeStart);

  // frmManyCurrencies
  Application.CreateForm(TfrmManyCurrencies, frmManyCurrencies);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 2;
  frmSplash.Update;
  TimeLog[31, 0] := 'frmManyCurrencies';
  TimeLog[31, 1] := IntToStr(GetTickCount64 - TimeStart);

  // frmShortCut
  Application.CreateForm(TfrmShortCut, frmShortCut);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 2;
  frmSplash.Update;
  TimeLog[32, 0] := 'frmShortCut';
  TimeLog[32, 1] := IntToStr(GetTickCount64 - TimeStart);

  // frmCalendar
  Application.CreateForm(TfrmCalendar, frmCalendar);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 2;
  frmSplash.Update;
  TimeLog[33, 0] := 'frmCalendar';
  TimeLog[33, 1] := IntToStr(GetTickCount64 - TimeStart);

  // frmPlan
  Application.CreateForm(TfrmPlan, frmPlan);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 2;
  frmSplash.Update;
  TimeLog[34, 0] := 'frmPlan';
  TimeLog[34, 1] := IntToStr(GetTickCount64 - TimeStart);

  // frmPeriod
  Application.CreateForm(TfrmPeriod, frmPeriod);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 1;
  frmSplash.Update;
  TimeLog[35, 0] := 'frmPeriod';
  TimeLog[35, 1] := IntToStr(GetTickCount64 - TimeStart);

  // frmBudget
  Application.CreateForm(TfrmBudget, frmBudget);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 1;
  frmSplash.Update;
  TimeLog[36, 0] := 'frmBudget';
  TimeLog[36, 1] := IntToStr(GetTickCount64 - TimeStart);

  // frmBudgets
  Application.CreateForm(TfrmBudgets, frmBudgets);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 2;
  frmSplash.Update;
  TimeLog[37, 0] := 'frmBudgets';
  TimeLog[37, 1] := IntToStr(GetTickCount64 - TimeStart);

  // frmTemplates
  Application.CreateForm(TfrmTemplates, frmTemplates);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 2;
  frmSplash.Update;
  TimeLog[38, 0] := 'frmTemplates';
  TimeLog[38, 1] := IntToStr(GetTickCount64 - TimeStart);

  // frmLinks
  Application.CreateForm(TfrmLinks, frmLinks);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 1;
  frmSplash.Update;
  TimeLog[39, 0] := 'frmLinks';
  TimeLog[39, 1] := IntToStr(GetTickCount64 - TimeStart);

  // frmImage
  Application.CreateForm(TfrmImage, frmImage);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 2;
  frmSplash.Update;
  TimeLog[40, 0] := 'frmImage';
  TimeLog[40, 1] := IntToStr(GetTickCount64 - TimeStart);

  // frmTimeStamp
  Application.CreateForm(TfrmTimeStamp, frmTimeStamp);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 1;
  frmSplash.Update;
  TimeLog[41, 0] := 'frmTimeStamp';
  TimeLog[41, 1] := IntToStr(GetTickCount64 - TimeStart);

  // frmSettings
  Application.CreateForm(TfrmSettings, frmSettings);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 2;
  frmSplash.Update;
  TimeLog[42, 0] := 'frmSettings';
  TimeLog[42, 1] := IntToStr(GetTickCount64 - TimeStart);

  frmSplash.Hide;
  Application.Run;
  frmSplash.Free;
  TimeStart := 0;
end.
