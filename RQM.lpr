program rqm;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms,
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
  uniSplash;

  {$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.Scaled := True;
  Application.Initialize;
  frmSplash := TfrmSplash.Create(nil);
  frmSplash.Show;
  Application.CreateForm(TfrmMain, frmMain);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 1;
  frmSplash.Update;

  Application.CreateForm(TfrmPassword, frmPassword);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 1;
  frmSplash.Update;

  Application.CreateForm(TfrmGate, frmGate);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 1;
  frmSplash.Update;

  Application.CreateForm(TfrmGuide, frmGuide);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 1;
  frmSplash.Update;

  Application.CreateForm(TfrmFilter, frmFilter);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 1;
  frmSplash.Update;

  Application.CreateForm(TfrmValues, frmValues);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 1;
  frmSplash.Update;

  Application.CreateForm(TfrmCurrencies, frmCurrencies);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 1;
  frmSplash.Update;

  Application.CreateForm(TfrmCounter, frmCounter);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 1;
  frmSplash.Update;

  Application.CreateForm(TfrmAccounts, frmAccounts);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 1;
  frmSplash.Update;

  Application.CreateForm(TfrmAbout, frmAbout);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 1;
  frmSplash.Update;

  Application.CreateForm(TfrmPersons, frmPersons);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 1;
  frmSplash.Update;

  Application.CreateForm(TfrmPayees, frmPayees);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 1;
  frmSplash.Update;

  Application.CreateForm(TfrmTags, frmTags);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 1;
  frmSplash.Update;

  Application.CreateForm(TfrmHolidays, frmHolidays);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 1;
  frmSplash.Update;

  Application.CreateForm(TfrmSuccess, frmSuccess);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 1;
  frmSplash.Update;

  Application.CreateForm(TfrmComments, frmComments);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 1;
  frmSplash.Update;

  Application.CreateForm(TfrmCategories, frmCategories);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 1;
  frmSplash.Update;

  Application.CreateForm(TfrmScheduler, frmScheduler);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 1;
  frmSplash.Update;

  Application.CreateForm(TfrmSchedulers, frmSchedulers);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 1;
  frmSplash.Update;

  Application.CreateForm(TfrmSQL, frmSQL);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 1;
  frmSplash.Update;

  Application.CreateForm(TfrmSQLResult, frmSQLResult);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 1;
  frmSplash.Update;

  Application.CreateForm(TfrmProperties, frmProperties);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 1;
  frmSplash.Update;

  Application.CreateForm(TfrmRecycleBin, frmRecycleBin);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 1;
  frmSplash.Update;

  Application.CreateForm(TfrmImport, frmImport);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 1;
  frmSplash.Update;

  Application.CreateForm(TfrmDetail, frmDetail);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 1;
  frmSplash.Update;

  Application.CreateForm(TfrmEdit, frmEdit);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 1;
  frmSplash.Update;

  Application.CreateForm(TfrmEdits, frmEdits);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 2;
  frmSplash.Update;

  Application.CreateForm(TfrmDelete, frmDelete);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 2;
  frmSplash.Update;

  Application.CreateForm(TfrmHistory, frmHistory);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 2;
  frmSplash.Update;

  Application.CreateForm(TfrmWrite, frmWrite);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 2;
  frmSplash.Update;

  Application.CreateForm(TfrmWriting, frmWriting);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 2;
  frmSplash.Update;

  Application.CreateForm(TfrmManyCurrencies, frmManyCurrencies);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 2;
  frmSplash.Update;

  Application.CreateForm(TfrmShortCut, frmShortCut);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 2;
  frmSplash.Update;

  Application.CreateForm(TfrmCalendar, frmCalendar);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 2;
  frmSplash.Update;

  Application.CreateForm(TfrmPlan, frmPlan);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 2;
  frmSplash.Update;

  Application.CreateForm(TfrmPeriod, frmPeriod);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 2;
  frmSplash.Update;

  Application.CreateForm(TfrmBudget, frmBudget);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 2;
  frmSplash.Update;

  Application.CreateForm(TfrmBudgets, frmBudgets);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 2;
  frmSplash.Update;

  Application.CreateForm(TfrmTemplates, frmTemplates);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 2;
  frmSplash.Update;

  Application.CreateForm(TfrmLinks, frmLinks);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 2;
  frmSplash.Update;

  Application.CreateForm(TfrmImage, frmImage);
  frmSplash.prgSplash.Value := frmSplash.prgSplash.Value + 2;
  frmSplash.Update;

  Application.CreateForm(TfrmSettings, frmSettings);

  frmSplash.Hide;

  Application.Run;
end.
