program rqm;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, uniTags, uniValues, uniAbout, uniAccounts, uniCounter, uniCategories,
  uniComments, uniCurrencies, uniEdit, uniEdits, uniFilter, uniGate, uniGuide,
  uniHolidays, uniMain, uniPassword, uniPayees, uniPersons,
  uniProperties, uniRecycleBin, uniSettings, uniScheduler, uniSQL,
  uniSQLResults, uniSuccess, lazcontrols, tachartlazaruspkg, datetimectrls,
  uniImport, uniDetail, uniDelete, uniHistory, uniSchedulers, uniWrite,
  uniManyCurrencies, uniShortCut, uniCalendar, Dialogs, uniwriting,
  uniResources, uniPeriod, uniPlan, uniBudgets, uniBudget, uniTemplates,
  uniLinks, uniImage;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled := True;
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmPassword, frmPassword);
  Application.CreateForm(TfrmGate, frmGate);
  Application.CreateForm(TfrmGuide, frmGuide);
  Application.CreateForm(TfrmFilter, frmFilter);
  Application.CreateForm(TfrmValues, frmValues);
  Application.CreateForm(TfrmCurrencies, frmCurrencies);
  Application.CreateForm(TfrmCounter, frmCounter);
  Application.CreateForm(TfrmAccounts, frmAccounts);
  Application.CreateForm(TfrmAbout, frmAbout);
  Application.CreateForm(TfrmPersons, frmPersons);
  Application.CreateForm(TfrmPayees, frmPayees);
  Application.CreateForm(TfrmTags, frmTags);
  Application.CreateForm(TfrmHolidays, frmHolidays);
  Application.CreateForm(TfrmSuccess, frmSuccess);
  Application.CreateForm(TfrmComments, frmComments);
  Application.CreateForm(TfrmCategories, frmCategories);
  Application.CreateForm(TfrmScheduler, frmScheduler);
  Application.CreateForm(TfrmSchedulers, frmSchedulers);
  Application.CreateForm(TfrmSQL, frmSQL);
  Application.CreateForm(TfrmSQLResult, frmSQLResult);
  Application.CreateForm(TfrmProperties, frmProperties);
  Application.CreateForm(TfrmRecycleBin, frmRecycleBin);
  Application.CreateForm(TfrmImport, frmImport);
  Application.CreateForm(TfrmDetail, frmDetail);
  Application.CreateForm(TfrmEdit, frmEdit);
  Application.CreateForm(TfrmEdits, frmEdits);
  Application.CreateForm(TfrmDelete, frmDelete);
  Application.CreateForm(TfrmHistory, frmHistory);
  Application.CreateForm(TfrmWrite, frmWrite);
  Application.CreateForm(TfrmWriting, frmWriting);
  Application.CreateForm(TfrmManyCurrencies, frmManyCurrencies);
  Application.CreateForm(TfrmShortCut, frmShortCut);
  Application.CreateForm(TfrmCalendar, frmCalendar);
  Application.CreateForm(TfrmPlan, frmPlan);
  Application.CreateForm(TfrmPeriod, frmPeriod);
  Application.CreateForm(TfrmBudget, frmBudget);
  Application.CreateForm(TfrmBudgets, frmBudgets);
  Application.CreateForm(TfrmTemplates, frmTemplates);
  Application.CreateForm(TfrmLinks, frmLinks);
  Application.CreateForm(TfrmImage, frmImage);
  Application.CreateForm(TfrmSettings, frmSettings);
  Application.Run;
end.
