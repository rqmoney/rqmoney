unit uniResources;

{$mode ObjFPC}{$H+}
{$ModeSwitch AutoDeref}

interface

uses
  Classes, SysUtils, Dialogs, StrUtils, LazUTF8, LCLProc, uniMain,
  DefaultTranslator, ComCtrls,
  laz.VirtualTrees, Forms;

procedure UpdateLanguage;

resourcestring
  // ===============================================================================================
  // Main menu
  // ===============================================================================================
  Menu_00 = '&Database';
  Menu_01 = '&New';
  Menu_02 = '&Open';
  Menu_03 = '&Close';
  Menu_04 = '&Import';
  Menu_05 = '&Export';
  Menu_06 = '&Password';
  Menu_07 = '&Tutorial';
  Menu_08 = 'S&QL manager';
  Menu_09 = '&Recycle bin';
  Menu_10 = 'Propertie&s';

  Menu_20 = '&Lists';
  Menu_21 = '&Holidays';
  Menu_22 = '&Tags';
  Menu_23 = '&Currencies';
  Menu_24 = '&Payees';
  Menu_25 = 'C&omments';
  Menu_26 = '&Accounts';
  Menu_27 = 'Cate&gories';
  Menu_28 = 'Per&sons';
  Menu_29 = 'Subcategories';
  Menu_30 = '&External links';

  Menu_40 = '&Financial tools';
  Menu_41 = '&Scheduler';
  Menu_42 = '&Write scheduled';
  Menu_43 = 'Calen&dar';
  Menu_44 = '&Budget';
  Menu_45 = '&Reports';
  Menu_46 = '&Cash counter';
  Menu_47 = 'Ca&lc';

  Menu_60 = '&Program';
  Menu_61 = '&Settings';
  Menu_62 = '&About';
  Menu_63 = '&Exit';
  Menu_64 = 'Check update';

  // Filter pop up menu
  Menu_F1 = 'Reset filter';
  Menu_F2 = 'Expand all filters';
  Menu_F3 = 'Collapse all filters';

  Menu_F5 = 'whenewer in the text';
  Menu_F6 = 'starting with the text';
  Menu_F7 = 'ending with the text';

  Menu_F8 = 'Apply filter';

  Menu_C1 = 'Expand selected category';
  Menu_C2 = 'Expand all categories';
  Menu_C3 = 'Collapse selected category';
  Menu_C4 = 'Collapse all categories';

  Menu_D1 = 'Delete date of payment';
  Menu_D2 = 'Edit date of payment';
  Menu_D3 = 'Select a date';

  // Menu Values
  Menu_V1 = 'banknote';
  Menu_V2 = 'coin';

  // About
  Menu_A01 = 'Author';
  Menu_A02 = 'E-mail';
  Menu_A03 = 'Version';
  Menu_A04 = 'License';
  Menu_A05 = 'Translator';
  Menu_A06 = 'Released';
  Menu_A07 = 'Official website';
  Menu_A08 = 'Developed in';
  Menu_A09 = 'Thanks';
  Menu_A10 = 'Thanks to all the users who helped me a lot in developing this ' +
    'program with their advices, ideas, bug fixes or financial support for this project.%'
    + 'Without their help, this program would not have been so successful in all those years.%'
    + 'Author';
  Menu_A11 = 'Donation';
  Menu_A12 = 'RQ Money is free software, which means you can use it without any fees.%' +
    'The author has already paid for this program with his free time ' +
    '(several thousand hours of development since 2005!), his energy and also paid several '
    + 'fees (buying software, renting a domain, buying an SSL certificate, etc.).%' +
    'So, if you like RQ Money and find it useful, the author will be grateful ' +
    'if you consider a small reward. Using the Paypal button below, you can send ' +
    'support to the author from your own debit / credit card or from your PayPal account.';
  Menu_A13 =
    'Click to open web page for donation%(via PayPal or other way - debit or credit card)';
  Menu_A14 = 'Use the left mouse button to display popup menu';
  Menu_T1 = 'Expand all panels';
  Menu_T2 = 'Collapse all panels';
  Menu_XX = 'Menu';
  Menu_B01 = 'Legend';


  // ===============================================================================================
  // Captions
  // ===============================================================================================
  Caption_00 = 'Add';
  Caption_01 = 'Add +';
  Caption_02 = 'Edit';
  Caption_03 = 'Delete';
  Caption_04 = 'Save';
  Caption_05 = 'Cancel';
  Caption_06 = 'Values';
  Caption_07 = 'Copy all';
  Caption_08 = 'Photo';
  Caption_09 = 'Print all';
  Caption_10 = 'Duplicate';
  Caption_11 = 'Payments';
  Caption_12 = 'Select';
  Caption_13 = 'Nominal value';
  Caption_14 = 'Count';
  Caption_15 = 'Summary';
  Caption_16 = 'Total';
  Caption_17 = 'Date and time';
  Caption_18 = 'Filter';
  Caption_19 = 'Month';
  Caption_20 = 'Year';
  Caption_21 = 'Reset';
  Caption_22 = 'Show INI file';
  Caption_23 = 'Back';
  Caption_24 = 'Next';
  Caption_25 = 'Transactions';
  Caption_26 = 'Date';
  Caption_27 = 'Day';
  Caption_28 = 'Period';
  Caption_29 = 'Copy selected';
  Caption_30 = 'Print selected';
  Caption_31 = 'Print transaction';
  Caption_32 = 'Scheduled date';
  Caption_33 = 'Swap order';
  Caption_34 = 'Account book';
  Caption_35 = 'Current balance';
  Caption_36 = 'Final balance';
  Caption_37 = 'Starting balance';
  Caption_38 = 'Credits';
  Caption_39 = 'Debits';
  Caption_40 = 'Transfers';
  Caption_41 = 'Average';
  Caption_42 = 'Amount';
  Caption_43 = 'Detail';
  Caption_44 = 'List';
  Caption_45 = 'New record';
  Caption_46 = 'Edit record';
  Caption_47 = 'Count of selected transactions:';
  Caption_48 = 'Restore';
  Caption_49 = 'Name';
  Caption_50 = 'Account';
  Caption_51 = 'Status';
  Caption_52 = 'Currency';
  Caption_53 = 'ID';
  Caption_54 = 'Category';
  Caption_55 = 'Active';
  Caption_56 = 'Comment';
  Caption_57 = 'Passive';
  Caption_58 = 'Person';
  Caption_59 = 'Archive';
  Caption_60 = 'Payee';
  Caption_61 = 'in the category';
  Caption_62 = 'Tag';
  Caption_63 = 'Type';
  Caption_64 = 'Records';
  Caption_65 = 'Database properties';
  Caption_66 = 'Scheduled payments';
  Caption_67 = 'History';
  Caption_68 = 'Print';
  Caption_69 = 'From the date';
  Caption_70 = 'To the date';
  Caption_71 = 'Code';
  Caption_72 = 'Write';
  Caption_73 = 'Common data';
  Caption_74 = 'Multiple additions';
  Caption_75 = 'Debit';
  Caption_76 = 'Credit';
  Caption_77 = 'From account';
  Caption_78 = 'To account';
  Caption_79 = 'Balance';
  Caption_80 = 'Subcategory';
  Caption_81 = 'Edited';
  Caption_82 = 'Statistics';
  Caption_83 = 'Paid';
  Caption_84 = 'Main currency';
  Caption_85 = 'Planning calendar';
  Caption_86 = 'EDIT TRANSACTION';
  Caption_87 = 'EDIT TRANSACTIONS';
  Caption_88 = 'Exchange rate';
  Caption_89 = 'Value';
  Caption_90 = 'Added';
  Caption_91 = 'Starting date';
  Caption_92 = 'Holiday name';
  Caption_93 = 'Deduct from the amount';
  Caption_94 = 'Summary of the list';
  Caption_95 = 'Periodicity';
  Caption_96 = 'File name';
  Caption_97 = 'Location';
  Caption_98 = 'File size';
  Caption_99 = 'Password protection';
  Caption_100 = 'RECORDS IN THE TABLES';
  Caption_101 = 'CHOOSE CURRENCY';
  Caption_102 = 'Select a nominal value and type its count';
  Caption_103 = 'MANY CURRENCIES';
  Caption_104 = 'SELECT MAIN CURRENCY';
  Caption_105 =
    'Only one currency can be designated as the main one!%0:sPlease, select one currency as main one.';
  Caption_106 = 'Execute !';
  Caption_107 = 'UNLOCK !';
  Caption_108 = 'Yes';
  Caption_109 = 'No';
  Caption_110 = 'CHOOSE FIELDS YOU WANT TO EDIT';
  Caption_111 = 'Monthly preview';
  Caption_112 = 'Daily preview';
  Caption_113 = 'PROTECTED DATABASE !';
  Caption_114 = 'Database name:';
  Caption_115 =
    'This database is protected by password.%0:sType correct password and then press the key ENTER to unlock the database.';
  Caption_116 = 'Backspace';
  Caption_117 = 'TRANSACTIONS TO DELETING';
  Caption_118 = 'Backup';
  Caption_119 = 'Global';
  Caption_120 = 'Visual';
  Caption_121 = 'On open';
  Caption_122 = 'ShortCuts';
  Caption_123 = 'HELPFUL INFO';
  Caption_124 = 'Operating system';
  Caption_125 = 'Program version';
  Caption_126 = 'SQLite library name';
  Caption_127 = 'SQLite library version';
  Caption_128 = 'Program folder';
  Caption_129 = 'GLOBAL SETTINGS';
  Caption_130 = 'Language';
  Caption_131 = 'Date and numeric format';
  Caption_132 = 'automatic (from OS)';
  Caption_133 = 'own settings';
  Caption_134 = 'Numeric format';
  Caption_135 = 'Thousand separator';
  Caption_136 = 'Decimal separator';
  Caption_137 = 'Example';
  Caption_138 = 'Date format';
  Caption_139 = '1. week day';
  Caption_140 = 'Short date';
  Caption_141 = 'Long date';
  Caption_142 = 'VISUAL SETTINGS';
  Caption_143 = 'Panels and buttons captions';
  Caption_144 = 'Shadowed font';
  Caption_145 = 'Bold font';
  Caption_146 = 'Gradient effect';
  Caption_147 = 'Background color';
  Caption_148 = 'Font color';
  Caption_149 = 'Tables';
  Caption_150 = 'Odd row color';
  Caption_151 = 'Transactions color scheme';
  Caption_152 = 'black for all fields in the row';
  Caption_153 = 'colored the field Amount only';
  Caption_154 = 'colored all fields in the row';
  Caption_155 = 'General font';
  Caption_156 = 'The quick brown fox jumps over the lazy dog.';
  Caption_157 = 'On run';
  Caption_158 = 'open last used forms size';
  Caption_159 =
    'when new transaction is added, open the window "New transaction" again to add another transaction';
  Caption_160 = 'open last used database';
  Caption_161 = 'open last used filter';
  Caption_162 = 'automatic columns width for all tables';
  Caption_163 = 'Miscellaneous';
  Caption_164 = 'KEYBOARD SHORTCUTS';
  Caption_165 = 'WRITE SCHEDULED PAYMENTS';
  Caption_166 = 'Write all %0:s selected scheduled payments';
  Caption_167 = 'at once';
  Caption_168 = 'gradually (in parts)';
  Caption_169 = 'Show transactions';
  Caption_170 = 'All';
  Caption_171 = 'Renewable only';
  Caption_172 = 'Non-renewable only (damaged)';
  Caption_173 = 'SQL COMMAND RESULTS';
  Caption_174 = 'MAKE A DATABASE BACKUP BEFORE USE !';
  Caption_175 = 'WRONG SQL COMMAND CAN CORRUPT YOUR DATABASE !';
  Caption_176 = 'Select SQL command:';
  Caption_177 = 'Show database structure ("master table")';
  Caption_178 = 'Show all transactions';
  Caption_179 = 'VACUUM (this command reduces database size by erasing deleted records)';
  Caption_180 = 'Own SQL command:';
  Caption_181 = 'Transfer';
  Caption_182 = 'IMPORT FILE';
  Caption_183 = 'SELECT FILE TO IMPORT';
  Caption_184 = 'To be strong, your password should contain:%' +
    '- at least one lower case letter%' + '- at least one upper case letter%' +
    '- at least one digit';
  Caption_185 = 'USE STRONG PASSWORD !';
  Caption_186 = 'Old password';
  Caption_187 = 'New password';
  Caption_188 = 'Confirm password';
  Caption_189 = 'CONGRATULATION !!!';
  Caption_190 = 'YOUR NEW DATABASE WAS SUCCESSFULY CREATED !';
  Caption_191 = 'Choose your next step now:';
  Caption_192 = 'Strongly reccomanded';
  Caption_193 = 'PROTECT THE DATABASE WITH THE PASSWORD';
  Caption_194 = 'For new users';
  Caption_195 = 'RUN THE BEGINNER''S GUIDE';
  Caption_196 = 'For old users';
  Caption_197 = 'IMPORT VERSION 2.x';
  Caption_198 = 'I am ready';
  Caption_199 = 'LET''S GO WORK';
  Caption_200 = 'ORIGINAL TRANSACTION';
  Caption_201 = 'CHANGED FIELDS';
  Caption_202 = 'SHORTCUT KEY';
  Caption_203 = 'New shortcut';
  Caption_204 = 'Action';
  Caption_205 = 'Current shortcut';
  Caption_206 = 'Shortcut';
  Caption_207 = 'Once';
  Caption_208 = 'Every X days';
  Caption_209 = 'Daily';
  Caption_210 = 'Weekly';
  Caption_211 = 'Fortnightly';
  Caption_212 = 'Monthly';
  Caption_213 = 'Quarterly';
  Caption_214 = 'Biannually';
  Caption_215 = 'Yearly';
  Caption_216 = 'If a scheduled payment falls on a';
  Caption_217 = 'move the payment to one day';
  Caption_218 = 'before';
  Caption_219 = 'after';
  Caption_220 = 'Note';
  Caption_221 =
    'These options work only for monthly, quarterly, biannually and yearly repeating transactions!';
  Caption_222 = 'public holiday';
  Caption_223 = 'to make backup of database';
  Caption_224 =
    'Your backup folder doesn''t exists.%Please, set the folder first or turn off the back up.';
  Caption_225 = 'Maximal count of backup files';
  Caption_226 = 'Show message about successful backup of the database';
  Caption_227 = 'Your database has been backed up successful to the folder';
  Caption_228 = 'Plan';
  Caption_229 = 'Reality';
  Caption_230 = 'Index';
  Caption_231 = 'Difference';
  Caption_232 = 'Planned amount';
  Caption_233 = 'Budgets';
  Caption_234 = 'Periods';
  Caption_235 = 'Budget type';
  Caption_236 = 'Hide column DIFFERENCE';
  Caption_237 = 'Hide column INDEX';
  Caption_238 = 'Main window';
  Caption_239 = 'Show marks';
  Caption_240 = 'Credit transactions color';
  Caption_241 = 'Transfers(+) transactions color';
  Caption_242 = 'Transfers(-) transactions color';
  Caption_243 = 'On close';
  Caption_244 = 'to show a confirmation dialog about closing the database';
  Caption_245 = 'List of reports';
  Caption_246 = 'Font of all lists';
  Caption_247 = 'Time';
  Caption_248 = 'Order';
  Caption_249 = 'File';
  Caption_250 = 'All files';
  Caption_251 = 'Template';
  Caption_252 = 'Template name';
  Caption_253 = 'TEMPLATE FOR IMPORT';
  Caption_254 = 'Do not import';
  Caption_255 = 'lines from the begining';
  Caption_256 = 'lines from the end';
  Caption_257 = 'Fields separator';
  Caption_258 = 'Cut quotes';
  Caption_259 = 'Origin text';
  Caption_260 = 'PREPARED DATA FOR IMPORT';
  Caption_261 = 'Imported file';
  Caption_262 = 'Column';
  Caption_263 = 'First value test';
  Caption_264 = 'Use amount sign (+/-)';
  Caption_265 = 'Credit symbol';
  Caption_266 = 'Debit symbol';
  Caption_267 = 'Set manually';
  Caption_268 = 'Set automatically';
  Caption_269 = 'Imported row';
  Caption_270 = 'Icons size';
  Caption_271 = 'Record';
  Caption_272 = 'Copy';
  Caption_273 = 'Select all';
  Caption_274 = 'Form';
  Caption_275 = 'Edit template';
  Caption_276 = 'Press a key (or keys) to set new shortcut for this action';
  Caption_277 = 'Old shortcut';
  Caption_278 = 'Default';
  Caption_279 = 'Check new version';
  Caption_280 = 'Confirm each payment separately';
  Caption_281 = 'Show scheduled payments for';
  Caption_282 = 'weeks too';
  Caption_283 = 'Wrong SQL command.%Please, check the name of the tables or fields.';
  Caption_284 = 'Backup folder';
  Caption_285 = 'External link';
  Caption_286 = 'NOTE% Don''t forget to use negative numbers for debits.';
  Caption_287 = 'Balance detail';
  Caption_288 = 'Print the transactions summary table on a separately page';
  Caption_299 = 'display the amount in bold';
  Caption_300 = 'display subcategories in capital letters';
  Caption_301 = 'enable transfer to the same account';
  Caption_302 = 'Weeks';
  Caption_303 = 'Months';
  Caption_304 = 'Quarters';
  Caption_305 = 'Restrictions';
  Caption_306 = 'no restrictions';
  Caption_307 = 'not older than';
  Caption_308 = 'Days';
  Caption_309 = 'Years';
  Caption_310 = 'Chronology';
  Caption_311 = 'Intervals';
  Caption_312 = 'Show pie chart of summary';
  Caption_313 = 'Icons by';
  Caption_314 = 'Show series';
  Caption_315 = 'Show points';
  Caption_316 = 'if a day is set in the filter, use the current date';
  Caption_317 = 'use the date shift according to the settings in the program';
  Caption_318 = 'Cross tables';
  Caption_319 = 'Simple transaction';
  Caption_320 = 'Multiple transaction';
  Caption_321 = 'Kind';
  Caption_322 = 'DB structure';
  Caption_323 = 'Created in Apricot software';
  Caption_324 = 'to show a confirmation dialog about backup of the database';
  Caption_325 = 'to encrypt the database (required database password protection!)';
  Caption_326 = 'Your database was not encrypt now.';
  Caption_327 = 'Red color for buttons DELETE';
  Caption_328 = 'Buttons bar';
  Caption_329 = 'Buttons size';
  Caption_330 = 'Buttons visibility';
  Caption_331 = 'remember the last used transactions in the New transaction form (when you exit the program)';
  Caption_332 = 'Encryption protection';
  Caption_333 = 'Attachments';
  Caption_334 = 'Energies';
  Caption_335 = 'Monitor energy consumption';
  Caption_336 = 'Meter reading';
  Caption_337 = 'at the beginning';
  Caption_338 = 'at the end';
  Caption_339 = 'consumption';
  Caption_340 = 'Meter';
  Caption_341 = 'Allow writing to the list of items';

  // ===============================================================================================
  // A BEGINNER'S GUIDE FORM
  // ===============================================================================================
  Guide_01 = 'A BEGINNER''S GUIDE';
  Guide_02 = 'WELCOME TO THE GUIDE !';
  Guide_03 = 'WELCOME TO THIS SIMPLE GUIDE!%' +
    'You can find here a simple and short instructioms of how to add one daily record ' +
    '(transaction) to the database.%' +
    'It is important to know, that each transaction is bounded with some:%' +
    'a) person,%b) account,%c) category (or subcategory) and%' +
    'd) payee.%' +
    'Therefore you have to add at least one person, one account (include the currency), '
    +
    'one category (or subcategory) and one payee to the database first.%' +
    'Let''s go work!';
  Guide_04 = 'ADD SOME PERSON TO THE LIST!%' +
    'Click on following button (with persons image), to show the form for the LIST OF ' +
    'PERSONS. You can add, edit or delete people, who will used in the program.%' +
    'You can NOW add the person''s name (like JOHN, JOAN, SUGAR, ...) or you can ' +
    'simply use other descriptions (like MOTHER, SON, ALL, etc.).%' +
    'Remember 4 basic commands (shortcuts), you can use for faster work with the lists:%'
    +
    '1) press key INSERT to input new record to the list%' +
    '2) press key SPACE to edit selected record in the list%' +
    '3) press key DELETE to delete selected record(s) from the list%' +
    '4) press key ESC to close any form (without any changes).';
  Guide_05 = 'NOW YOU CAN ADD YOUR ACCOUNT.%' +
    'It can be cash, wallet, bank account, etc.%' +
    'Call them whatever you want (like My Cash, BANK1, BANK2, etc.)%' +
    'You also have to fill at least 3 fields:%' +
    'a) define starting amount of this account%' + 'b) starting day (of evidence) and%' +
    'c) currency of this account.';
  Guide_06 = 'ADD CATEGORY TO THE LIST!%' +
    'For viewing easy it is better to split your credit and debit records into ' +
    'categories and subcategories.%' +
    'If you have a CAR (category), perhaps you would like to see all car expenses ' +
    'arranged by various  subcategories (eg. FUEL, SERVICE, TUNING, ...)%' +
    'To do so, Open List of categories (push button) and add category CAR.%' +
    'Then create subcategory FUEL.%' +
    'After saving this CATEGORY and SUBCATEGORY repeat all this activities ' +
    'with subcategory SERVICE and TUNING.%' +
    'Just select the category CAR from dropdown list.';
  Guide_07 = '... AND AT THE END ADD SOME PAYEE TO THE LIST!%' +
    'Click on following button (with basket image), to show the form for the ' +
    'LIST OF PAYEES.%' +
    'You can add, edit or delete your business partner (where you get used to ' +
    'spending your money or from whom you receive the money).%' +
    'You can NOW add the partner''s name (like WALLMART, TESCO, ' +
    'AMAZON, LIDL, ...) or you can simply use other descriptions ' +
    '(like PARTNER 1, PARTNER 2, EMPLOYER, etc.).';
  Guide_08 = 'ADD YOUR FIRST TRANSACTION!%' +
    'If you have added some persons, some accounts, some categories ' +
    '(with subcategories) and some payee, you can easily add new daily ' +
    'records (transactions) to the database.%' +
    'To add a new debit record into the daily records, use button ' +
    'to open transaction form and fill all necessary fields.%' +
    'Field AMOUNT and COMMENT are optional. If you did not previously add ' +
    'a required person, account, category (subcategory) or payee, ' +
    'just open the appropriate list again and add it to the list.%' +
    'If you are finished, save this record and take a look at the main window.%' +
    'Your new record should be visible there!!!%' +
    'There are a few other lists, but these four are the most important.';
  Guide_09 = 'FINISH! %We have reached the end of the guide!%' +
    'If you have added some transactions to the main window, congratulations!%' +
    'If not, go back and try again step by step.%' +
    'I wish you success with this program! Good luck!%' + 'Author of the program%%' +
    'If you won''t be satisfied with my program, e-mail me.%' +
    'But - if you are satisfied with it, tell your friends about it.';

  // ===============================================================================================
  // Hints
  // ===============================================================================================
  Hint_01 = 'Add new item';
  Hint_02 = 'Edit selected item(s)';
  Hint_03 = 'Delete selected item(s)';
  Hint_04 = 'Save item to the list';
  Hint_05 = 'Cancel this activity';
  Hint_06 = 'Exit this window';
  Hint_09 = 'Copy all item(s) to the clipboard';
  Hint_10 = 'Show all nominal values of selected currency';
  //  Hint_12 = 'Take a photo of current form';
  Hint_13 = 'Print the list';
  Hint_14 = 'Active = visible in all modules';
  Hint_15 = 'Passive = visible in module Statistics only';
  Hint_16 = 'Archive = hidden in all modules';
  Hint_17 = 'Show all scheduled payments in the selected schedule';
  Hint_18 = 'Duplicate selected item';
  //  Hint_19 = 'Add new multiple items';
  Hint_21 = 'Execute SQL command.%0:sThe results wil be shown in the second panel.';
  Hint_22 = 'Select all items in the list';
  Hint_23 = 'Save all items to the list at once';
  //  Hint_24 = 'Print the selected item detail';
  Hint_25 = 'Show history of changes of the transaction';
  Hint_26 = 'Filter for multiple selection of items';


  // btnDatabase
  Hint_30 = 'Create a new database'; // btnNew
  Hint_31 = 'Open an existing database'; // btnOpen
  Hint_32 = 'Close open database'; // btnClose
  Hint_33 = 'Import transactions to the database'; // btnImport
  Hint_34 = 'Export transactions from the database'; // btnExport
  Hint_35 = 'Change the database password'; // btnPassword
  Hint_36 = 'Run SQL manager'; // btnSQL
  Hint_37 = 'Run beginner''s guide'; // btnGuide
  Hint_38 = 'Show database properties'; // btnProperties
  Hint_39 = 'Show recycle bin'; // btnRecycle

  // btnLists
  Hint_40 = 'Show list of holidays';
  Hint_41 = 'Show list of tags';
  Hint_42 = 'Show list of currencies';
  Hint_43 = 'Show list of payees';
  Hint_44 = 'Show list of comments';
  Hint_45 = 'Show list of accounts';
  Hint_46 = 'Show list of categories';
  Hint_47 = 'Show list of persons';
  //  Hint_48 = 'Show list of values';
  Hint_49 = 'Show list of types';

  // btnFinancial_Tools
  Hint_50 = 'Show scheduler';
  Hint_51 = 'Write scheduled payments to the main table';
  Hint_52 = 'Show calendar';
  Hint_53 = 'Show budget';
  Hint_54 = 'Show reports';
  Hint_55 = 'Show cash counter';
  Hint_56 = 'Show calculator';
  Hint_57 = 'Show program settings';
  Hint_58 = 'Show About program';
  Hint_59 = 'Exit program';

  Hint_60 = 'Hint';
  Hint_61 = 'Name your budget and check some categories / subcategories, you want to watch '
    + '(compare plan and real amounts). Then SAVE this new budget.';
  Hint_62 = 'Now you can add the first period with the budgeted (planned) amounts.';

  // frmRecycle
  Hint_70 = 'Restore selected item(s)';

  // frmEdits
  Hint_80 = 'Reset all fields (to be unchecked)';
  Hint_81 = 'Check / uncheck all items';

  // other
  Hint_100 = 'Swap the order of both transactions within one day.';
  Hint_101 = 'Write all checked scheduled payments to the transactions';
  Hint_102 = 'Save your password to the database';

  // ===============================================================================================
  // Questions
  // ===============================================================================================
  Question_00 = 'Do you want to close opened database?';
  Question_01 = 'Do you want to delete selected item?';
  Question_02 = 'Do you want to delete % selected items?';
  Question_03 = 'Do you want to reset all filter items?';
  Question_04 = 'Do you want to save all program settings?';
  Question_05 =
    'IF YOU DELETE THIS ACCOUNT, FOLLOWING ITEMS WILL BE DELETED TOO';
  Question_06 =
    'IF YOU DELETE THIS CATEGORY, FOLLOWING ITEMS WILL BE DELETED TOO';
  Question_07 =
    'IF YOU DELETE THIS PERSON, FOLLOWING ITEMS WILL BE DELETED TOO';
  Question_08 =
    'IF YOU DELETE THIS PAYEE, FOLLOWING ITEMS WILL BE DELETED TOO';
  Question_09 =
    'Do you want to change the currency to %1 ?%2WARNING! All values in the cash counter will be reset to zero.';
  Question_10 = 'Do you want to reset all fields (to be unchecked) ?';
  Question_11 =
    'Do you want to run this command ?%%BE CAREFUL !%All selected transactions will be affected ...';
  Question_12 = 'Do you want to restore selected transactions to the main table ?';
  Question_13 =
    'Do you really want to close this window without writing created transaction(s)?%All created transactions in this window will be lost.';
  Question_14 = 'Do you want to write mass created transactions to the main table ?';
  Question_15 = 'Do you want to write scheduled transactions to the main table ?';
  Question_16 = 'Do you want to import following file ?';
  Question_17 =
    'All selected payments will be deleted from the scheduler !';
  Question_18 = 'Do you want to delete the date of payment from selected items?';
  Question_19 = 'Do you want to close this window without saving data?';
  Question_20 =
    'Do you want to create new budget and write all checked categories / subcategories to this budget?';
  Question_21 = 'Do you want to save changes to the selected budget?';
  Question_22 =
    'Do you want to write checked categories / subcategories with planned amounts to the budget?';
  Question_23 = 'Are you sure you want to delete entire budget with all periods?';
  Question_24 = 'Do you want to set default shortcuts for all actions?';
  Question_25 = 'There exists brand new stable version %1 of this program.%2Release date: %3 %2'
    + 'Do you want do visit official website to download it?';
  Question_26 =
    'Do you want to delete corrupted records now? You can view them later in the recycle bin.';
  Question_27 = 'Do you want to back up your database to the selected folder now?';
  Question_28 =
    'The encryption of your database requires password protection.% Do you want to set this password now?';

  // ===============================================================================================
  // Messages
  // ===============================================================================================
  Message_00 = 'WARNING';
  Message_01 = '%0:s item(s) was copied to the clipboard.';
  Message_02 = 'E-mail address was copied to the clipboard.';
  Message_03 = 'Database password was successfully created.';
  Message_04 = 'Database password was successfully changed.';
  Message_05 = 'SQL command was executed successful.';
  Message_06 = 'Import finished successful.';
  Message_07 = 'Selected picture was copied to the clipboard.%0:sSize: %1:s px x %2:s px.';
  //  Message_08 = '';
  Message_09 = 'You are using the current version of the program.';
  Message_10 = 'This feature is not available in this operating system';

  // ===============================================================================================
  // Errors
  // ===============================================================================================

  Error_00 = 'Missing SQLITE3.DLL library.%Database can not be created or opened.';
  Error_01 = 'There is a problem with deleting existing file.';
  Error_02 = 'The connectivity with database failed.%Program can not open the database.';
  Error_03 = 'You can not add or edit this item due the duplicity.';
  Error_04 = 'The field % is required. You have to fill it before saving ...';
  Error_05 = 'Wrong value of the number!';
  Error_06 = 'Forbidden character % in the text! Please, correct it first ...';
  Error_07 = 'Wrong day in selected month! Please, check it now ...';
  Error_08 = 'The minimum length of the password is 5 letters, digits or signs.';
  Error_09 = 'New and confirmed password are different!';
  Error_10 =
    'You can''t delete selected currency %2 [%1]%4because it is used in the account %3.%4Please, delete this account first ...';
  Error_11 = 'The database seems to be malformed.%Program can not open it.';
  Error_12 =
    'You can not use the same account %1 for transfer (credit and debit) at the same time. %2 Use two different accounts.';
  Error_13 =
    'You can not use in the transaction older date than the date, when the account % was created!';
  Error_14 = 'Program can not find a printing template assigned to this list:';
  Error_15 = 'Wrong date !';
  Error_16 =
    'Choose one account in the filter only and then try print "The account book" again.';
  Error_17 =
    'This function is not working yet.%Maybe in the next version it will be implemented.%Please be patient.';
  Error_18 =
    'Program can not open this type of database (perhaps created in different program).% ' +
    'If you try to open older database (with extension RQM), you can import it to the new database only.';
  Error_19 = 'Sorry, there are no data to show you ...';
  Error_20 =
    'The import failed due the problem with the file.%Please, be sure that the imported file is not encrypted!';
  Error_21 = 'Wrong password!';
  Error_22 =
    'Program requires SQLite3 library (libsqlite3-dev).%Program will be terminated now.';
  Error_23 = 'The table has more than 255 columns. The query will be closed.';
  Error_24 = 'Unrecognized character %1 in the formula.';
  Error_25 = 'There is 1 corrupted record in your database.';
  Error_26 = 'There are % corrupted records in your database.';
  Error_27 = 'Corrupted records will not be imported into your new database!';
  Error_28 = 'You can change this restriction in the program settings.';
  Error_29 = 'You can not add transactions older then';
  Error_30 = 'You can not edit transactions older then';
  Error_31 = 'You can not delete transactions older then';
  Error_32 =
    'The program cannot open your database % because another program is already using it.';
  Error_33 = 'The program cannot find the selected file to open';

  // ===============================================================================================
  // Version
  // ===============================================================================================
  Version_01 = 'stable';
  Version_02 = 'testing';

  // ===============================================================================================
  // License
  // ===============================================================================================
  License_01 =
    'RQ MONEY is free software: you can redistribute it and/or modify it under the terms of '
    + 'the GNU General Public License as published by the Free Software Foundation; either version 3 '
    + 'of the License, or (at your option) any later version.% %RQ MONEY is distributed in the hope that '
    + 'it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY '
    + 'or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.% %'
    + 'You should have received a copy of the GNU General Public License along with RQ MONEY. '
    + 'If not, see:';

  // ===============================================================================================
  // CHARTS
  // ===============================================================================================
  Chart_01 = 'Graphs';
  Chart_02 = 'left mouse click to switch between marks';
  Chart_03 = 'Show legend';
  Chart_04 = 'Labels on bottom axis';
  Chart_05 = 'Angle of rotation';
  Chart_06 = 'degree';
  Chart_07 = 'Show empty rows (with zero values)';
  Chart_08 = 'rows in the table';
  Chart_09 = 'The Chart has been copied to the clipboard';
  Chart_10 = 'Wrap the text string';
  Chart_11 = 'Graph';
  Chart_12 = 'Data';

implementation

uses
  uniProperties, uniDetail, uniCurrencies, uniCategories, uniAccounts, uniPayees,
  uniHolidays, uniScheduler, uniSchedulers, uniCounter, uniManyCurrencies, uniCalendar,
  uniTags, uniAbout, uniComments, uniDelete, uniEdit, uniGate, uniHistory, uniImage,
  uniPassword, uniPersons, uniRecycleBin, uniSettings, uniShortCut, uniSQL, uniLinks,
  uniSQLResults, uniValues, uniWrite, uniwriting, uniEdits, uniFilter, uniGuide,
  uniImport, uniSuccess, uniPeriod, uniPlan, uniBudget, uniBudgets, uniTemplates;

procedure UpdateLanguage;
var
  Key: PKey;
  P: PVirtualNode;
  I: integer;
  Lang: PLang;
begin
  try
    // =============================================================================================
    // FRMMAIN
    // =============================================================================================

    // MAIN MENU CAPTIONS
    frmMain.mnuDatabase.Caption := Menu_00;
    frmMain.mnuNew.Caption := Menu_01;
    frmMain.mnuOpen.Caption := Menu_02;
    frmMain.mnuClose.Caption := Menu_03;
    frmMain.mnuImport.Caption := Menu_04;
    frmMain.mnuExport.Caption := Menu_05;
    frmMain.mnuPassword.Caption := Menu_06;
    frmMain.mnuGuide.Caption := Menu_07;
    frmMain.mnuSQL.Caption := Menu_08;
    frmMain.mnuRecycle.Caption := Menu_09;
    frmMain.mnuProperties.Caption := Menu_10;

    frmMain.mnuLists.Caption := Menu_20;
    frmMain.mnuHolidays.Caption := Menu_21;
    frmMain.mnuTags.Caption := Menu_22;
    frmMain.mnuCurrencies.Caption := Menu_23;
    frmMain.mnuPayees.Caption := Menu_24;
    frmMain.mnuComments.Caption := Menu_25;
    frmMain.mnuAccounts.Caption := Menu_26;
    frmMain.mnuCategories.Caption := Menu_27;
    frmMain.mnuPersons.Caption := Menu_28;
    frmMain.mnuLinks.Caption := Menu_30;
    frmMain.mnuSubLink.Caption := Menu_30;

    frmMain.mnuTools.Caption := Menu_40;
    frmMain.mnuSchedulers.Caption := Menu_41;
    frmMain.mnuWrite.Caption := Menu_42;
    frmMain.mnuCalendar.Caption := Menu_43;
    frmMain.mnuBudget.Caption := Menu_44;
    frmMain.mnuReports.Caption := Menu_45;
    frmMain.mnuCashCounter.Caption := Menu_46;
    frmMain.mnuCalc.Caption := Menu_47;

    frmMain.mnuProgram.Caption := Menu_60;
    frmMain.mnuSettings.Caption := Menu_61;
    frmMain.mnuCheckUpdate.Caption := Menu_64;
    frmMain.mnuAbout.Caption := Menu_62;
    frmMain.mnuExit.Caption := Menu_63;

    // PANELS CAPTION
    frmMain.pnlSummaryCaption.Caption := AnsiUpperCase(Caption_15);

    // FILTER CAPTIONS
    frmMain.popFilterClear.Caption := Menu_F1;
    frmMain.popFilterExpand.Caption := Menu_F2;
    frmMain.popFilterCollapse.Caption := Menu_F3;

    I := frmMain.cbxType.ItemIndex;
    frmMain.cbxType.Clear;
    frmMain.cbxType.Items.Add('*');
    frmMain.cbxType.Items.Add(AnsiUpperCase(Caption_76));
    frmMain.cbxType.Items.Add(AnsiUpperCase(Caption_75));
    frmMain.cbxType.Items.Add(AnsiUpperCase(Caption_181 + '+'));
    frmMain.cbxType.Items.Add(AnsiUpperCase(Caption_181 + '-'));
    frmMain.cbxType.ItemIndex := I;
    frmMain.cbxTypeChange(frmMain.cbxType);

    // filter buttons
    frmMain.btnType.Hint := Hint_26;
    frmMain.btnCurrency.Hint := Hint_26;
    frmMain.btnAccount.Hint := Hint_26;
    frmMain.btnCategory.Hint := Hint_26;
    frmMain.btnSubcategory.Hint := Hint_26;
    frmMain.btnPerson.Hint := Hint_26;
    frmMain.btnPayee.Hint := Hint_26;
    frmMain.btnTag.Hint := Hint_26;

    frmMain.pnlFilterCaption.Caption := AnsiUpperCase(Caption_18);
    frmMain.pnlListCaption.Caption :=
      AnsiUpperCase(Caption_25) + frmMain.pnlType.Hint + frmMain.pnlDate.Hint +
      frmMain.pnlCurrency.Hint + frmMain.pnlAccount.Hint + frmMain.pnlAmount.Hint +
      frmMain.pnlComment.Hint + frmMain.pnlCategory.Hint +
      AnsiUpperCase(frmMain.pnlPerson.Hint) + AnsiUpperCase(frmMain.pnlPayee.Hint) +
      frmMain.pnlTag.Hint;

    frmMain.pnlTypeCaption.Caption := '  ' + Caption_63; // Type
    frmMain.pnlDateCaption.Caption := '  ' + Caption_26; // Date
    frmMain.gbxDateFrom.Caption := Caption_69; // Date
    frmMain.gbxDateTo.Caption := Caption_70; // Date

    frmMain.pnlDayCaption.Caption := Caption_27 + '  '; // Day
    frmMain.pnlPeriodCaption.Caption := Caption_28 + '  '; // Period
    frmMain.pnlAccountCaption.Caption := '  ' + Caption_50; // Account
    frmMain.pnlAmountCaption.Caption := '  ' + Caption_42; // Amount
    frmMain.pnlCommentCaption.Caption := '  ' + Caption_56; // Comment
    frmMain.pnlCategoryCaption.Caption := '  ' + AnsiReplaceStr(Caption_54, '&', ''); // Category
    frmMain.pnlTagCaption.Caption := '  ' + Caption_62; // Tag
    frmMain.pnlPersonCaption.Caption := '  ' + Caption_58; // Person
    frmMain.pnlPayeeCaption.Caption := '  ' + Caption_60; // Payee

    frmMain.pnlCurrencyCaption.Caption := '  ' + Caption_52; // Currency
    frmMain.pnlMonthYearCaption.Caption := Caption_19 + ' + ' + Caption_20 + '  ';
    // Month + Year
    frmMain.gbxMonth.Caption := Caption_19; // Month
    frmMain.gbxYear.Caption := Caption_20; // Year

    frmMain.cbxComment.Clear;
    frmMain.cbxComment.Items.Add(Menu_F5);
    frmMain.cbxComment.Items.Add(Menu_F6);
    frmMain.cbxComment.Items.Add(Menu_F7);
    frmMain.cbxComment.ItemIndex := 0;

    //  TOOL MENU HINT -----------------------------------------------------------------------------

    // mnuDatabase
    frmMain.btnNew.Hint := Hint_30 + sLineBreak + '[' +
      ShortCutToText(frmMain.mnuNew.ShortCut) + ']';
    frmMain.btnOpen.Hint := Hint_31 + sLineBreak + '[' +
      ShortCutToText(frmMain.mnuOpen.ShortCut) + ']';
    frmMain.btnClose.Hint := Hint_32 + sLineBreak + '[' +
      ShortCutToText(frmMain.mnuClose.ShortCut) + ']';
    frmMain.btnImport.Hint := Hint_33 + sLineBreak + '[' +
      ShortCutToText(frmMain.mnuImport.ShortCut) + ']';
    frmMain.btnExport.Hint := Hint_34 + sLineBreak + '[' +
      ShortCutToText(frmMain.mnuExport.ShortCut) + ']';
    frmMain.btnPassword.Hint :=
      Hint_35 + sLineBreak + '[' + ShortCutToText(frmMain.mnuPassword.ShortCut) + ']';
    frmMain.btnSQL.Hint := Hint_36 + sLineBreak + '[' +
      ShortCutToText(frmMain.mnuSQL.ShortCut) + ']';
    frmMain.btnGuide.Hint := Hint_37 + sLineBreak + '[' +
      ShortCutToText(frmMain.mnuGuide.ShortCut) + ']';
    frmMain.btnProperties.Hint :=
      Hint_38 + sLineBreak + '[' + ShortCutToText(frmMain.mnuProperties.ShortCut) + ']';
    frmMain.btnRecycle.Hint :=
      Hint_39 + sLineBreak + '[' + ShortCutToText(frmMain.mnuRecycle.ShortCut) + ']';

    frmMain.btnHolidays.Hint :=
      Hint_40 + sLineBreak + '[' + ShortCutToText(frmMain.mnuHolidays.ShortCut) + ']';
    frmMain.btnTags.Hint := Hint_41 + sLineBreak + '[' +
      ShortCutToText(frmMain.mnuTags.ShortCut) + ']';
    frmMain.btnCurrencies.Hint :=
      Hint_42 + sLineBreak + '[' + ShortCutToText(frmMain.mnuCurrencies.ShortCut) + ']';
    frmMain.btnPayees.Hint := Hint_43 + sLineBreak + '[' +
      ShortCutToText(frmMain.mnuPayees.ShortCut) + ']';
    frmMain.btnComments.Hint :=
      Hint_44 + sLineBreak + '[' + ShortCutToText(frmMain.mnuComments.ShortCut) + ']';
    frmMain.btnAccounts.Hint :=
      Hint_45 + sLineBreak + '[' + ShortCutToText(frmMain.mnuAccounts.ShortCut) + ']';
    frmMain.btnCategories.Hint :=
      Hint_46 + sLineBreak + '[' + ShortCutToText(frmMain.mnuCategories.ShortCut) + ']';
    frmMain.btnPersons.Hint :=
      Hint_47 + sLineBreak + '[' + ShortCutToText(frmMain.mnuPersons.ShortCut) + ']';

    frmMain.btnSchedulers.Hint :=
      Hint_50 + sLineBreak + '[' + ShortCutToText(frmMain.mnuSchedulers.ShortCut) + ']';
    frmMain.btnWrite.Hint := Hint_51 + sLineBreak + '[' +
      ShortCutToText(frmMain.mnuWrite.ShortCut) + ']';
    frmMain.btnCalendar.Hint :=
      Hint_52 + sLineBreak + '[' + ShortCutToText(frmMain.mnuCalendar.ShortCut) + ']';
    frmMain.btnBudgets.Hint :=
      Hint_53 + sLineBreak + '[' + ShortCutToText(frmMain.mnuBudget.ShortCut) + ']';
    frmMain.btnReports.Hint :=
      Hint_54 + sLineBreak + '[' + ShortCutToText(frmMain.mnuReports.ShortCut) + ']';
    frmMain.btnCashCounter.Hint :=
      Hint_55 + sLineBreak + '[' + ShortCutToText(frmMain.mnuCashCounter.ShortCut) + ']';
    frmMain.btnCalc.Hint := Hint_56 + sLineBreak + '[' +
      ShortCutToText(frmMain.mnuCalc.ShortCut) + ']';

    frmMain.btnSettings.Hint :=
      Hint_57 + sLineBreak + '[' + ShortCutToText(frmMain.mnuSettings.ShortCut) + ']';
    frmMain.btnAbout.Hint := Hint_58 + sLineBreak + '[' +
      ShortCutToText(frmMain.mnuAbout.ShortCut) + ']';
    frmMain.btnExit.Hint := Hint_59 + sLineBreak + '[' +
      ShortCutToText(frmMain.mnuExit.ShortCut) + ']';

    // BUTTON CAPTION
    frmMain.btnAdd.Caption := Caption_00;
    frmMain.btnDuplicate.Caption := Caption_10;
    frmMain.btnEdit.Caption := Caption_02;
    frmMain.btnDelete.Caption := Caption_03;
    frmMain.btnCopy.Caption := Caption_272;
    frmMain.btnSelect.Caption := Caption_12;
    frmMain.btnPrint.Caption := Caption_68;
    frmMain.btnHistory.Caption := Caption_67;

    // POPUPMENU CAPTION
    frmMain.popAdd.Caption := Caption_00;
    frmMain.popAddMulti.Caption := Caption_01;
    frmMain.popEdit.Caption := Caption_02;
    frmMain.popDuplicate.Caption := Caption_10;
    frmMain.popDelete.Caption := Caption_03;
    frmMain.popPrint.Caption := Caption_68;
    frmMain.popCopy.Caption := Caption_272;
    frmMain.popSelect.Caption := Caption_12;
    frmMain.popHistory.Caption := Caption_67;

    // POPUPMENU SUMMARY
    frmMain.popSummaryCopy.Caption := Caption_272;
    frmMain.popSummaryPrint.Caption := Caption_68;

    // BUTTONS HINT
    frmMain.btnAdd.Hint := Hint_01 + ':' + sLineBreak + Caption_319 +
      ' [' + ShortCutToText(frmMain.popAdd.ShortCut) + ']' +
      sLineBreak + Caption_320 + ' [' + frmMain.pnlButtons.Hint + ']';
    frmMain.btnEdit.Hint := Hint_02 + sLineBreak + '[' +
      ShortCutToText(frmMain.popEdit.ShortCut) + ']';
    frmMain.btnDuplicate.Hint :=
      Hint_18 + sLineBreak + '[' + ShortCutToText(frmMain.popDuplicate.ShortCut) + ']';
    frmMain.btnDelete.Hint := Hint_03 + sLineBreak + '[' +
      ShortCutToText(frmMain.popDelete.ShortCut) + ']';
    frmMain.btnSelect.Hint := Hint_22 + sLineBreak + '[' +
      ShortCutToText(frmMain.popSelect.ShortCut) + ']';
    frmMain.btnCopy.Hint := Hint_09 + sLineBreak + '[' +
      ShortCutToText(frmMain.popCopy.ShortCut) + ']';
    frmMain.btnHistory.Hint :=
      Hint_25 + sLineBreak + '[' + ShortCutToText(frmMain.popHistory.ShortCut) + ']';

    // LIST HEADER CAPTION
    frmMain.VST.Header.Columns[1].Text := Caption_26; // date
    frmMain.VST.Header.Columns[2].Text := Caption_56; // comment
    frmMain.VST.Header.Columns[3].Text := Caption_42; // amount
    frmMain.VST.Header.Columns[4].Text := Caption_52; // currency
    frmMain.VST.Header.Columns[5].Text := Caption_50; // account
    frmMain.VST.Header.Columns[6].Text := AnsiReplaceStr(Caption_54, '&', ''); // category
    frmMain.VST.Header.Columns[7].Text := Caption_80; // subcategory
    frmMain.VST.Header.Columns[8].Text := Caption_58; // person
    frmMain.VST.Header.Columns[9].Text := Caption_60; // payee
    frmMain.VST.Header.Columns[10].Text := Caption_53; // ID
    frmMain.VST.Header.Columns[11].Text := Caption_63; // Type

    // SUMMARY HEADER CAPTION
    frmMain.VSTSummary.Header.Columns[1].Text := Caption_50; // account
    frmMain.VSTSummary.Header.Columns[2].Text := Caption_37; // starting balance
    frmMain.VSTSummary.Header.Columns[3].Text := Caption_38; // credits
    frmMain.VSTSummary.Header.Columns[4].Text := Caption_39; // debits
    frmMain.VSTSummary.Header.Columns[5].Text := Caption_40 + ' +'; // transfers (+)
    frmMain.VSTSummary.Header.Columns[6].Text := Caption_40 + ' -'; // transfers (-)
    frmMain.VSTSummary.Header.Columns[7].Text := Caption_35; // current balance
    frmMain.VSTSummary.Header.Columns[8].Text := Caption_36; // final balance

    for I := 2 to 8 do
      frmMain.VSTSummaries.Header.Columns[I - 1].Text :=
        frmMain.VSTSummary.Header.Columns[I].Text;

    frmMain.chkShowPieChart.Caption := Caption_312;

    // REPORTS
    frmMain.pnlReportCaption.Caption := AnsiUpperCase(AnsiReplaceStr(Menu_45, '&', ''));
    frmMain.btnReportExit.Caption := AnsiReplaceStr(Menu_63, '&', '');
    frmMain.btnReportExit.Hint :=
      Hint_06 + sLineBreak + '[' + ShortCutToText(frmCurrencies.actExit.ShortCut) + ']';
    frmMain.btnReportCopy.Caption := Caption_272;
    frmMain.btnReportCopy.Hint := frmMain.btnCopy.Hint;
    frmMain.btnReportPrint.Caption := Caption_68;
    frmMain.btnReportPrint.Hint :=
      Hint_13 + sLineBreak + '[' + ShortCutToText(frmCurrencies.popPrint.ShortCut) + ']';
    frmMain.btnReportSettings.Caption := AnsiReplaceStr(Menu_61, '&', '');
    frmMain.btnReportSettings.Hint := frmMain.btnSettings.Hint;

    frmMain.tabBalance.Caption := Caption_287;

    frmMain.tabBalanceHeader.Tabs[0].Text :=
      '  ' + AnsiReplaceStr(Menu_23, '&', '') + '  ';
    frmMain.tabBalanceHeader.Tabs[1].Text :=
      '  ' + AnsiReplaceStr(Menu_26, '&', '') + '  ';
    frmMain.tabBalanceHeader.Tabs[2].Text :=
      '  ' + AnsiReplaceStr(Menu_27, '&', '') + '  ';
    frmMain.tabBalanceHeader.Tabs[3].Text :=
      '  ' + AnsiReplaceStr(Menu_28, '&', '') + '  ';
    frmMain.tabBalanceHeader.Tabs[4].Text :=
      '  ' + AnsiReplaceStr(Menu_24, '&', '') + '  ';
    frmMain.tabBalanceHeader.TabIndex := 0;

    frmMain.tabBalanceShow.Tabs[0].Text := Chart_12;
    frmMain.tabBalanceShow.Tabs[1].Text := Chart_11;

    // REPORTS - BALANCE CHART SERIES
    frmMain.styBalanceCredit.Styles[0].Text := Caption_38; // credits
    frmMain.styBalanceCredit.Styles[1].Text := Caption_40 + ' +'; // transfers (+)
    frmMain.styBalanceDebit.Styles[0].Text := Caption_39; // debits
    frmMain.styBalanceDebit.Styles[1].Text := Caption_40 + ' -'; // transfers (-)

    // REPORTS - BALANCE HEADER CAPTION
    frmMain.VSTBalance.Header.Columns[2].Text := Caption_38; // credits
    frmMain.VSTBalance.Header.Columns[3].Text := Caption_39; // debits
    frmMain.VSTBalance.Header.Columns[4].Text := Caption_40 + ' +'; // transfers (+)
    frmMain.VSTBalance.Header.Columns[5].Text := Caption_40 + ' -'; // transfers (-)
    frmMain.VSTBalance.Header.Columns[6].Text := Caption_35; // current balance

    // POPUP BALANCE
    frmMain.popCopyChartBalance.Caption := Caption_272;
    // POPUP CHRONO
    frmMain.popCopyChartChrono.Caption := Caption_272;

    frmMain.tabChrono.Caption := Caption_310;

    frmMain.tabChronoHeader.Tabs[0].Text := Caption_308 + ' (1-7)';
    frmMain.tabChronoHeader.Tabs[1].Text := Caption_308 + ' (1-31)';
    frmMain.tabChronoHeader.Tabs[2].Text := Caption_308 + ' (1-365)';
    frmMain.tabChronoHeader.Tabs[3].Text := Caption_302 + ' (1-52)';
    frmMain.tabChronoHeader.Tabs[4].Text := Caption_303 + ' (1-12)';
    frmMain.tabChronoHeader.Tabs[5].Text := Caption_304 + ' (1-4)';
    frmMain.tabChronoHeader.Tabs[6].Text := Caption_309;

    frmMain.tabCross.Caption := Caption_318;

    // Cross tables - top header
    frmMain.tabCrossTop.Tabs[0].Text := '  ' + Caption_52 + '  '; // currency
    frmMain.tabCrossTop.Tabs[1].Text := '  ' + Caption_50 + '  '; // account
    frmMain.tabCrossTop.Tabs[2].Text := '  ' + AnsiReplaceStr(Caption_54, '&', '') + '  '; // category
    frmMain.tabCrossTop.Tabs[3].Text := '  ' + Caption_58 + '  '; // person
    frmMain.tabCrossTop.Tabs[4].Text := '  ' + Caption_60 + '  '; // payee

    // Cross tables - left header
    frmMain.tabCrossLeft.Tabs[1].Text := '  ' + Caption_52 + '  '; // currency
    frmMain.tabCrossLeft.Tabs[2].Text := '  ' + Caption_50 + '  '; // account
    frmMain.tabCrossLeft.Tabs[3].Text := '  ' + AnsiReplaceStr(Caption_54, '&', '') + '  '; // category
    frmMain.tabCrossLeft.Tabs[4].Text := '  ' + Caption_80 + '  '; // subcategory
    frmMain.tabCrossLeft.Tabs[5].Text := '  ' + Caption_58 + '  '; // person
    frmMain.tabCrossLeft.Tabs[6].Text := '  ' + Caption_60 + '  '; // payee

    // REPORTS - CROSS HEADER CAPTION
    frmMain.VSTCross.Header.Columns[2].Text := Caption_38; // credits
    frmMain.VSTCross.Header.Columns[3].Text := Caption_39; // debits
    frmMain.VSTCross.Header.Columns[4].Text := Caption_40 + ' +'; // transfers (+)
    frmMain.VSTCross.Header.Columns[5].Text := Caption_40 + ' -'; // transfers (-)
    frmMain.VSTCross.Header.Columns[6].Text := Caption_35; // current balance

    frmMain.VSTCross.Header.Columns[1].Text :=
      frmMain.tabCrossTop.Tabs[frmMain.tabCrossTop.TabIndex].Text +
      ' / ' + frmMain.tabCrossLeft.Tabs[frmMain.tabCrossLeft.TabIndex].Text;

    // SUMMARY HEADER CAPTION
    frmMain.VSTChrono.Header.Columns[1].Text := Caption_311; // intervals
    frmMain.VSTChrono.Header.Columns[2].Text := Caption_37; // starting balance
    frmMain.VSTChrono.Header.Columns[3].Text := Caption_38; // credits
    frmMain.VSTChrono.Header.Columns[4].Text := Caption_39; // debits
    frmMain.VSTChrono.Header.Columns[5].Text := Caption_40 + ' +'; // transfers (+)
    frmMain.VSTChrono.Header.Columns[6].Text := Caption_40 + ' -'; // transfers (-)
    frmMain.VSTChrono.Header.Columns[7].Text := Caption_35; // current balance
    frmMain.VSTChrono.Header.Columns[8].Text := Caption_36; // final balance

    // charts
    frmMain.chaChrono.Hint := Menu_A14;
    frmMain.serChronoStart.Title := Caption_37; // starting balance;
    frmMain.serChronoCredits.Title := Caption_38; // credits
    frmMain.serChronoDebits.Title := Caption_39; // debits
    frmMain.serChronoTPlus.Title := Caption_40 + ' +'; // transfers (+)
    frmMain.serChronoTMinus.Title := Caption_40 + ' -'; // transfers (-)
    frmMain.serChronoBalance.Title := Caption_35; // current balance
    frmMain.serChronoTotal.Title := Caption_36; // final balance

    // popup menu
    frmMain.popChartChronoShowSeries.Caption := Caption_314;
    frmMain.popChartChronoShowMarks.Caption := Caption_239;
    frmMain.popChartChronoShowPoints.Caption := Caption_315;

    frmMain.popChartChrono1.Caption := Caption_37; // starting balance;
    frmMain.popChartChrono2.Caption := Caption_38; // credits
    frmMain.popChartChrono3.Caption := Caption_39; // debits
    frmMain.popChartChrono4.Caption := Caption_40 + ' +'; // transfers (+)
    frmMain.popChartChrono5.Caption := Caption_40 + ' -'; // transfers (-)
    frmMain.popChartChrono6.Caption := Caption_35; // current balance
    frmMain.popChartChrono7.Caption := Caption_36; // final balance

    frmMain.popEditToolBar.Caption := Caption_02;

    // =============================================================================================
    // FRMDETAIL FORM
    // =============================================================================================

    frmDetail.pnlBasicCaption.Caption := AnsiUpperCase(Caption_73);
    frmDetail.pnlDetailCaption.Caption := AnsiUpperCase(Caption_43);
    frmDetail.pnlListCaption.Caption := AnsiUpperCase(Caption_25);

    // update menu items
    frmDetail.btnAdd.Caption := Caption_00;
    frmDetail.btnEdit.Caption := Caption_02;
    frmDetail.btnDelete.Caption := Caption_03;
    frmDetail.btnDuplicate.Caption := Caption_10;
    frmDetail.btnSelect.Caption := Caption_12;
    frmDetail.btnSave.Caption := Caption_04;
    frmDetail.btnCancel.Caption := Caption_05;

    // POPUPMENU CAPTION
    frmDetail.popAdd.Caption := Caption_00;
    frmDetail.popEdit.Caption := Caption_02;
    frmDetail.popDuplicate.Caption := Caption_10;
    frmDetail.popDelete.Caption := Caption_03;
    frmDetail.popSelect.Caption := Caption_12;
    frmDetail.popExit.Caption := Menu_63;

    // update hint of all menu
    frmDetail.btnAdd.Hint := Hint_01 + sLineBreak + '[' +
      ShortCutToText(frmMain.actAddSimple.ShortCut) + ']';
    frmDetail.btnEdit.Hint := frmMain.btnEdit.Hint;
    frmDetail.btnDuplicate.Hint := frmMain.btnDuplicate.Hint;
    frmDetail.btnSelect.Hint := frmMain.btnSelect.Hint;
    frmDetail.btnDelete.Hint := frmMain.btnDelete.Hint;
    frmDetail.btnSave.Hint := Hint_04 + sLineBreak + '[' +
      ShortCutToText(frmDetail.actSave.ShortCut) + ']';
    frmDetail.btnCancel.Hint :=
      Hint_05 + sLineBreak + '[' + ShortCutToText(frmDetail.actExit.ShortCut) + ']';

    frmDetail.lblAccountX.Caption := Caption_50;
    frmDetail.lblDateX.Caption := Caption_26;
    frmDetail.lblPayeeX.Caption := Caption_60;
    frmDetail.lblPersonX.Caption := Caption_58;
    frmDetail.lblCommentX.Caption := Caption_56;
    frmDetail.lblCategoryX.Caption := AnsiReplaceStr(Caption_54, '&', '') + ' / ' + Caption_80;
    frmDetail.lblTagsX.Caption := Caption_62;
    frmDetail.lblAmountX.Caption := Caption_42;
    frmDetail.lblTypeX.Caption := Caption_63;
    frmDetail.chkAmountMinus.Caption := Caption_93;
    frmDetail.lblSummaryInList.Caption := Caption_94;
    frmDetail.lblBalance_.Caption := Caption_79;

    frmDetail.VST.Header.Columns[1].Text := Caption_42; // amount
    frmDetail.VST.Header.Columns[2].Text := Caption_56; // comment
    frmDetail.VST.Header.Columns[3].Text := AnsiReplaceStr(Caption_54, '&', '');
    // category
    frmDetail.VST.Header.Columns[4].Text := Caption_58; // person
    frmDetail.VST.Header.Columns[5].Text := Caption_63; // type
    frmDetail.VST.Header.Columns[6].Text := Caption_62; // tag 1
    frmDetail.VST.Header.Columns[7].Text := Caption_62; // tag 2

    frmDetail.Caption := AnsiUpperCase(Caption_45);
    frmDetail.tabKind.Tabs[0].Text :=
      ' ' + Caption_319 + ' [' + ShortCutToText(frmDetail.actSimple.ShortCut) +
      ']' + ' ';
    frmDetail.tabKind.Tabs[1].Text :=
      ' ' + Caption_320 + ' [' + ShortCutToText(frmDetail.actMultiple.ShortCut) +
      ']' + ' ';

    frmDetail.tabSimple.Tabs[0].Text := AnsiReplaceStr(Menu_22, '&', '');
    frmDetail.tabSimple.Tabs[1].Text := Caption_333;
    frmDetail.tabSimple.Tabs[2].Text := Caption_334;

    frmDetail.btnSettings.Caption := AnsiReplaceStr(Menu_61, '&', '');
    frmDetail.btnSettings.Hint := frmMain.btnSettings.Hint;
    frmDetail.btnSaveX.Caption := Caption_04;
    frmDetail.btnSaveX.Hint := frmDetail.btnSave.Hint;
    frmDetail.btnCancelX.Caption := Caption_05;
    frmDetail.btnCancelX.Hint := frmDetail.btnCancel.Hint;

    // labels FROM
    frmDetail.gbxType.Caption := Caption_63; // Type;
    frmDetail.gbxDateFrom.Caption := Caption_26; // Date;
    frmDetail.gbxAccountFrom.Caption := Caption_77;
    frmDetail.gbxAmountFrom.Caption := Caption_42; // Amount;
    frmDetail.gbxAccountTo.Caption := Caption_78;
    frmDetail.gbxDateTo.Caption := Caption_26; // Date
    frmDetail.gbxAmountTo.Caption := Caption_42; // Amount;
    frmDetail.gbxComment.Caption := Caption_56; // Comment;
    frmDetail.gbxCategory.Caption := AnsiReplaceStr(Caption_54, '&', '') + ' / ' + Caption_80;
    // Category / Subcategory
    frmDetail.gbxPerson.Caption := Caption_58; // Person
    frmDetail.gbxPayee.Caption := Caption_60; // Payee
    //frmDetail.gbxTags.Caption := AnsiReplaceStr(Menu_22, '&', ''); // Tag

    //frmDetail.gbxAttachments.Caption := Caption_333; // Attachments
    frmDetail.lviAttachments.Columns[0].Caption := Caption_96;
    frmDetail.lviAttachments.Columns[1].Caption := Caption_97;
    frmDetail.btnAttachmentAdd.Caption := Caption_00;
    frmDetail.btnAttachmentEdit.Caption := Caption_02;
    frmDetail.btnAttachmentDelete.Caption := Caption_03;
    frmDetail.btnAttachmentOpen.Caption := AnsiReplaceStr(Menu_02, '&', '');

    frmDetail.gbxMeter.Caption := Caption_336;
    frmDetail.lblMeterStart.Caption := Caption_337;
    frmDetail.lblMeterEnd.Caption := Caption_338;
    frmDetail.lblConsumption.Caption := Caption_339;

    // hints
    frmDetail.btnComment.Hint := frmMain.btnComments.Hint;
    frmDetail.btnCommentX.Hint := frmMain.btnComments.Hint;
    frmDetail.btnCategory.Hint := frmMain.btnCategories.Hint;
    frmDetail.btnCategoryX.Hint := frmMain.btnCategories.Hint;
    frmDetail.btnPerson.Hint := frmMain.btnPersons.Hint;
    frmDetail.btnPersonX.Hint := frmMain.btnPersons.Hint;
    frmDetail.btnPayee.Hint := frmMain.btnPayees.Hint;
    frmDetail.btnPayeeX.Hint := frmMain.btnPayees.Hint;
    frmDetail.btnAccountFrom.Hint := frmMain.btnAccounts.Hint;
    frmDetail.btnAccountTo.Hint := frmMain.btnAccounts.Hint;
    frmDetail.btnAccountX.Hint := frmMain.btnAccounts.Hint;
    frmDetail.btnTag.Hint := frmMain.btnTags.Hint;
    frmDetail.btnTagsX.Hint := frmMain.btnTags.Hint;
    frmDetail.btnAmountFrom.Hint := frmMain.btnCalc.Hint;
    frmDetail.btnAmountTo.Hint := frmMain.btnCalc.Hint;
    frmDetail.btnAmountX.Hint := frmMain.btnCalc.Hint;
    I := frmDetail.cbxType.ItemIndex;
    frmDetail.cbxType.Clear;
    frmDetail.cbxType.Items.Add(AnsiUpperCase(Caption_76));
    frmDetail.cbxType.Items.Add(AnsiUpperCase(Caption_75));
    frmDetail.cbxType.Items.Add(AnsiUpperCase(Caption_181));
    frmDetail.cbxType.ItemIndex := I;
    frmDetail.cbxTypeX.Items := frmDetail.cbxType.Items;
    frmDetail.cbxTypeX.Items.Delete(2);
    frmScheduler.cbxType.Items := frmDetail.cbxType.Items;

    // =============================================================================================
    // FRMEDIT FORM
    // =============================================================================================

    frmEdit.Caption := Caption_86;
    frmEdit.btnCancel.Caption := Caption_05;
    frmEdit.btnSave.Caption := Caption_04;

    frmEdit.gbxType.Caption := Caption_63; // Type
    frmEdit.cbxType.Items := frmMain.cbxType.Items;
    frmEdit.cbxType.Items.Delete(0);

    frmEdit.gbxDate.Caption := Caption_26; // Date (also Scheduled Date)
    frmEdit.gbxAmount.Caption := Caption_42; // Amount
    frmEdit.gbxComment.Caption := Caption_56; // Comment
    frmEdit.gbxCategory.Caption := AnsiReplaceStr(Caption_54, '&', '') + ' / ' + Caption_80;
    // Category / Subcategory
    frmEdit.gbxPerson.Caption := Caption_58; // Person
    frmEdit.gbxPayee.Caption := Caption_60; // Payee
    frmEdit.gbxAccount.Caption := Caption_50; // Account

    frmEdit.tabSimple.Tabs[0].Text := AnsiReplaceStr(Menu_22, '&', '');
    frmEdit.tabSimple.Tabs[1].Text := Caption_333;
    frmEdit.tabSimple.Tabs[2].Text := Caption_334;
    frmEdit.btnAttachmentAdd.Caption := Caption_00;
    frmEdit.btnAttachmentEdit.Caption := Caption_02;
    frmEdit.btnAttachmentDelete.Caption := Caption_03;
    frmEdit.btnAttachmentOpen.Caption := AnsiReplaceStr(Menu_02, '&', '');

    frmEdit.lviAttachments.Columns[0].Caption := Caption_96;
    frmEdit.lviAttachments.Columns[1].Caption := Caption_97;

    frmEdit.gbxMeter.Caption := Caption_336;
    frmEdit.lblMeterStart.Caption := Caption_337;
    frmEdit.lblMeterEnd.Caption := Caption_338;
    frmEdit.lblConsumption.Caption := Caption_339;

    // hints
    frmEdit.btnComment.Hint := frmMain.btnComments.Hint;
    frmEdit.btnCategory.Hint := frmMain.btnCategories.Hint;
    frmEdit.btnPerson.Hint := frmMain.btnPersons.Hint;
    frmEdit.btnPayee.Hint := frmMain.btnPayees.Hint;
    frmEdit.btnAccount.Hint := frmMain.btnAccounts.Hint;
    frmEdit.btnTag.Hint := frmMain.btnTags.Hint;
    frmEdit.btnAmount.Hint := frmMain.btnCalc.Hint;
    frmEdit.btnSave.Hint := frmDetail.btnSave.Hint;
    frmEdit.btnCancel.Hint := frmDetail.btnCancel.Hint;

    // =============================================================================================
    // FRMEDITS FORM
    // =============================================================================================

    frmEdits.Caption := Caption_87;
    frmEdits.pnlEditCaption.Caption := AnsiUpperCase(Caption_110);
    frmEdits.txtSelected.Caption := Caption_47;
    frmEdits.btnCancel.Caption := Caption_05;
    frmEdits.btnSave.Caption := Caption_04;
    frmEdits.btnReset.Caption := Caption_21;

    frmEdits.btnSave.Hint := frmDetail.btnSave.Hint;
    frmEdits.btnCancel.Hint := frmDetail.btnCancel.Hint;
    frmEdits.btnReset.Hint := Hint_80;

    frmEdits.chkType.Caption := Caption_63; // Type
    frmEdits.cbxType.Items := frmMain.cbxType.Items;
    frmEdits.cbxType.Items.Delete(0);

    frmEdits.chkDate.Caption := Caption_26; // Date (also Scheduled Date)
    frmEdits.chkAmount.Caption := Caption_42; // Amount
    frmEdits.chkComment.Caption := Caption_56; // Comment
    frmEdits.chkCategory.Caption := AnsiReplaceStr(Caption_54, '&', '') + ' / ' + Caption_80;
    // Category / Subcategory
    frmEdits.chkPerson.Caption := Caption_58; // Person
    frmEdits.chkPayee.Caption := Caption_60; // Payee
    frmEdits.chkAccount.Caption := Caption_50; // Account
    frmEdits.chkTag.Caption := Caption_62; // Tag

    // hints
    frmEdits.btnComment.Hint := frmMain.btnComments.Hint;
    frmEdits.btnCategory.Hint := frmMain.btnCategories.Hint;
    frmEdits.btnPerson.Hint := frmMain.btnPersons.Hint;
    frmEdits.btnPayee.Hint := frmMain.btnPayees.Hint;
    frmEdits.btnAccount.Hint := frmMain.btnAccounts.Hint;
    frmEdits.btnTag.Hint := frmMain.btnTags.Hint;
    frmEdits.btnAmount.Hint := frmMain.btnCalc.Hint;

    // =============================================================================================
    // FRMCURRENCIES FORM
    // =============================================================================================

    frmCurrencies.Caption := AnsiReplaceStr(AnsiUpperCase(Menu_23), '&', '');
    frmCurrencies.pnlDetailCaption.Caption := AnsiUpperCase(Caption_43);
    frmCurrencies.pnlListCaption.Caption := AnsiUpperCase(Caption_44);

    // update menu items
    frmCurrencies.btnAdd.Caption := Caption_00;
    frmCurrencies.btnEdit.Caption := Caption_02;
    frmCurrencies.btnDelete.Caption := Caption_03;
    frmCurrencies.btnExit.Caption := AnsiReplaceStr(Menu_63, '&', '');
    frmCurrencies.btnSave.Caption := Caption_04;
    frmCurrencies.btnCancel.Caption := Caption_05;
    frmCurrencies.btnCopy.Caption := Caption_272;
    frmCurrencies.btnPrint.Caption := Caption_68;
    frmCurrencies.btnSelect.Caption := Caption_12;

    // update hint of all menu
    frmCurrencies.btnAdd.Hint := frmDetail.btnAdd.Hint;
    frmCurrencies.btnEdit.Hint := frmMain.btnEdit.Hint;
    frmCurrencies.btnDelete.Hint := frmMain.btnDelete.Hint;
    frmCurrencies.btnSave.Hint := frmDetail.btnSave.Hint;
    frmCurrencies.btnCancel.Hint := frmDetail.btnCancel.Hint;
    frmCurrencies.btnExit.Hint := frmMain.btnReportExit.Hint;
    frmCurrencies.btnCopy.Hint := frmMain.btnCopy.Hint;
    frmCurrencies.btnSelect.Hint := frmMain.btnSelect.Hint;
    frmCurrencies.btnPrint.Hint := frmMain.btnReportPrint.Hint;
    frmCurrencies.btnStatusInfo.Hint :=
      Hint_14 + sLineBreak + Hint_15 + sLineBreak + Hint_16;

    // update pop menu items
    frmCurrencies.popAdd.Caption := Caption_00;
    frmCurrencies.popEdit.Caption := Caption_02;
    frmCurrencies.popDelete.Caption := Caption_03;
    frmCurrencies.popExit.Caption := AnsiReplaceStr(Menu_63, '&', '');
    frmCurrencies.popCopy.Caption := Caption_272;
    frmCurrencies.popSelect.Caption := Caption_12;
    frmCurrencies.popPrint.Caption := Caption_68;
    frmCurrencies.popValues.Caption := Caption_06;

    // grid columns captions
    frmCurrencies.VST.Header.Columns[1].Text := Caption_71;
    frmCurrencies.VST.Header.Columns[2].Text := Caption_49;
    frmCurrencies.VST.Header.Columns[3].Text := Caption_84;
    frmCurrencies.VST.Header.Columns[4].Text := Caption_88;
    frmCurrencies.VST.Header.Columns[5].Text := Caption_51;
    frmCurrencies.VST.Header.Columns[6].Text := Caption_53; // ID

    frmCurrencies.btnValues.Caption := AnsiReplaceStr(Caption_06, '&', '');
    frmCurrencies.btnValues.Hint :=
      Hint_10 + sLineBreak + '[' + ShortCutToText(
      frmCurrencies.popValues.ShortCut) + ']';
    ;

    // labels
    frmCurrencies.lblCode.Caption := Caption_71;
    frmCurrencies.lblName.Caption := Caption_49;
    frmCurrencies.lblDefault.Caption := Caption_84;
    frmCurrencies.lblRate.Caption := Caption_88;
    frmCurrencies.lblStatus.Caption := Caption_51;

    // cbxStatus
    frmCurrencies.cbxStatus.Clear;
    frmCurrencies.cbxStatus.Items.Add(Caption_55);
    frmCurrencies.cbxStatus.Items.Add(Caption_57);
    frmCurrencies.cbxStatus.Items.Add(Caption_59);

    // cbxDefault
    frmCurrencies.cbxDefault.Items.Clear;
    frmCurrencies.cbxDefault.Items.Add(Caption_108);
    frmCurrencies.cbxDefault.Items.Add(Caption_109);

    // =============================================================================================
    // FRMVALUES FORM
    // =============================================================================================

    frmValues.pnlDetailCaption.Caption := AnsiUpperCase(Caption_43);
    frmValues.pnlListCaption.Caption := AnsiUpperCase(Caption_44);

    // update menu items
    frmValues.btnAdd.Caption := AnsiReplaceStr(Caption_00, '&', '');
    frmValues.btnEdit.Caption := AnsiReplaceStr(Caption_02, '&', '');
    frmValues.btnDelete.Caption := AnsiReplaceStr(Caption_03, '&', '');
    frmValues.btnExit.Caption := AnsiReplaceStr(Menu_63, '&', '');
    frmValues.btnSave.Caption := AnsiReplaceStr(Caption_04, '&', '');
    frmValues.btnCancel.Caption := AnsiReplaceStr(Caption_05, '&', '');
    frmValues.btnCopy.Caption := Caption_272;
    frmValues.btnSelect.Caption := Caption_12;

    // update hint of all menu
    frmValues.btnAdd.Hint := frmDetail.btnAdd.Hint;
    frmValues.btnEdit.Hint := frmMain.btnEdit.Hint;
    frmValues.btnDelete.Hint := frmMain.btnDelete.Hint;
    frmValues.btnSave.Hint := frmDetail.btnSave.Hint;
    frmValues.btnCancel.Hint := frmDetail.btnCancel.Hint;
    frmValues.btnExit.Hint := frmMain.btnReportExit.Hint;
    frmValues.btnCopy.Hint := frmMain.btnCopy.Hint;
    frmValues.btnSelect.Hint := frmMain.btnSelect.Hint;

    // update pop menu items
    frmValues.popAdd.Caption := Caption_00;
    frmValues.popEdit.Caption := Caption_02;
    frmValues.popDelete.Caption := Caption_03;
    frmValues.popExit.Caption := AnsiReplaceStr(Menu_63, '&', '');
    frmValues.popCopy.Caption := Caption_272;
    frmValues.popSelect.Caption := Caption_12;

    // grid columns caption
    frmValues.VST.Header.Columns[1].Text := Caption_89;
    frmValues.VST.Header.Columns[2].Text := Caption_63;
    frmValues.VST.Header.Columns[3].Text := Caption_53; // ID

    frmValues.lblValue.Caption := Caption_89;
    frmValues.lblType.Caption := Caption_63;

    // cbxType
    frmValues.cbxType.Clear;
    frmValues.cbxType.Items.Add(Menu_V1);
    frmValues.cbxType.Items.Add(Menu_V2);
    frmValues.cbxType.ItemIndex := 0;

    // =============================================================================================
    // FRMCATEGORIES FORM
    // =============================================================================================

    frmCategories.Caption := AnsiReplaceStr(AnsiUpperCase(Menu_27), '&', '');
    frmCategories.pnlDetailCaption.Caption := AnsiUpperCase(Caption_43);
    frmCategories.pnlListCaption.Caption := AnsiUpperCase(Caption_44);

    // update menu items
    frmCategories.btnAdd.Caption := Caption_00;
    frmCategories.btnEdit.Caption := Caption_02;
    frmCategories.btnDelete.Caption := Caption_03;
    frmCategories.btnExit.Caption := AnsiReplaceStr(Menu_63, '&', '');
    frmCategories.btnSave.Caption := Caption_04;
    frmCategories.btnCancel.Caption := Caption_05;
    frmCategories.btnCopy.Caption := Caption_272;
    frmCategories.btnSelect.Caption := Caption_12;
    frmCategories.btnPrint.Caption := Caption_68;

    // update hint of all menu
    frmCategories.btnAdd.Hint := frmDetail.btnAdd.Hint;
    frmCategories.btnEdit.Hint := frmMain.btnEdit.Hint;
    frmCategories.btnDelete.Hint := frmMain.btnDelete.Hint;
    frmCategories.btnSave.Hint := frmDetail.btnSave.Hint;
    frmCategories.btnCancel.Hint := frmDetail.btnCancel.Hint;
    frmCategories.btnExit.Hint := frmMain.btnReportExit.Hint;
    frmCategories.btnCopy.Hint := frmMain.btnCopy.Hint;
    frmCategories.btnSelect.Hint := frmMain.btnSelect.Hint;
    frmCategories.btnPrint.Hint := frmMain.btnReportPrint.Hint;
    frmCategories.btnStatusInfo.Hint := frmCurrencies.btnStatusInfo.Hint;

    // update pop menu items
    frmCategories.popAdd.Caption := Caption_00;
    frmCategories.popEdit.Caption := Caption_02;
    frmCategories.popDelete.Caption := Caption_03;
    frmCategories.popExit.Caption := Menu_63;
    frmCategories.popCopy.Caption := Caption_272;
    frmCategories.popSelect.Caption := Caption_12;
    frmCategories.popPrint.Caption := Caption_68;

    // popup menu
    frmCategories.popExpandOne.Caption := Menu_C1;
    frmCategories.popExpandAll.Caption := Menu_C2;
    frmCategories.popCollapseOne.Caption := Menu_C3;
    frmCategories.popCollapseAll.Caption := Menu_C4;

    // header columns captions
    frmCategories.VST.Header.Columns[1].Text := AnsiReplaceStr(Caption_54, '&', '');
    // category
    frmCategories.VST.Header.Columns[2].Text := Caption_56; // comment
    frmCategories.VST.Header.Columns[3].Text := Caption_51; // status
    frmCategories.VST.Header.Columns[4].Text := Caption_53; // ID
    frmCategories.VST.Header.Columns[7].Text := Caption_321; // Type
    frmCategories.VST.Header.Columns[8].Text := Caption_334; // Energies

    frmCategories.cbxType.Clear;
    frmCategories.cbxType.Items.Add(AnsiUpperCase(AnsiReplaceStr(Caption_54, '&', '')));
    frmCategories.cbxType.Items.Add(AnsiLowerCase(Caption_80));

    // labels
    frmCategories.lblType.Caption := Caption_63;
    frmCategories.lblName.Caption := Caption_49;
    frmCategories.lblTo.Caption := Caption_61;
    frmCategories.lblKind.Caption := Caption_321;
    frmCategories.lblComment.Caption := Caption_56;  // comment
    frmCategories.lblStatus.Caption := Caption_51; // status
    frmCategories.lblEnergy.Caption := Caption_335; // energies

    // cbxKind
    frmCategories.cbxKind.Clear;
    frmCategories.cbxKind.Items.Add(''); // active
    frmCategories.cbxKind.Items.Add(Caption_76); // credit
    frmCategories.cbxKind.Items.Add(Caption_75); // debit
    frmCategories.cbxKind.Items.Add(Caption_181); // transfer

    // cbxStatus
    frmCategories.cbxStatus.Clear;
    frmCategories.cbxStatus.Items.Add(Caption_55); // active
    frmCategories.cbxStatus.Items.Add(Caption_57); // passive
    frmCategories.cbxStatus.Items.Add(Caption_59); // archive

    // cbxEnergy
    frmCategories.cbxEnergy.Clear;
    frmCategories.cbxEnergy.Items.Add(Caption_108); // Yes
    frmCategories.cbxEnergy.Items.Add(Caption_109); // No

    // =============================================================================================
    // FRMACCOUNTS FORM
    // =============================================================================================

    frmAccounts.Caption := AnsiUpperCase(AnsiReplaceStr(Menu_26, '&', ''));
    frmAccounts.pnlDetailCaption.Caption := AnsiUpperCase(Caption_43);
    frmAccounts.pnlListCaption.Caption := AnsiUpperCase(Caption_44);

    // update menu items
    frmAccounts.btnAdd.Caption := Caption_00;
    frmAccounts.btnEdit.Caption := Caption_02;
    frmAccounts.btnDelete.Caption := Caption_03;
    frmAccounts.btnExit.Caption := AnsiReplaceStr(Menu_63, '&', '');
    frmAccounts.btnCopy.Caption := Caption_272;
    frmAccounts.btnSelect.Caption := Caption_12;
    frmAccounts.btnPrint.Caption := Caption_68;
    frmAccounts.btnSave.Caption := Caption_04;
    frmAccounts.btnCancel.Caption := Caption_05;
    frmAccounts.btnCurrency.Hint := frmMain.btnCurrencies.Hint;

    // update hint of all menu
    frmAccounts.btnAdd.Hint := frmDetail.btnAdd.Hint;
    frmAccounts.btnEdit.Hint := frmMain.btnEdit.Hint;
    frmAccounts.btnDelete.Hint := frmMain.btnDelete.Hint;
    frmAccounts.btnSave.Hint := frmDetail.btnSave.Hint;
    frmAccounts.btnCancel.Hint := frmDetail.btnCancel.Hint;
    frmAccounts.btnExit.Hint := frmMain.btnReportExit.Hint;
    frmAccounts.btnCopy.Hint := frmMain.btnCopy.Hint;
    frmAccounts.btnSelect.Hint := frmMain.btnSelect.Hint;
    frmAccounts.btnPrint.Hint := frmMain.btnReportPrint.Hint;
    frmAccounts.btnStatusInfo.Hint := frmCurrencies.btnStatusInfo.Hint;

    // update pop menu items
    frmAccounts.popAdd.Caption := Caption_00;
    frmAccounts.popEdit.Caption := Caption_02;
    frmAccounts.popDelete.Caption := Caption_03;
    frmAccounts.popExit.Caption := Menu_63;
    frmAccounts.popCopy.Caption := Caption_272;
    frmAccounts.popSelect.Caption := Caption_12;
    frmAccounts.popPrint.Caption := Caption_68;

    // header columns captions
    frmAccounts.VST.Header.Columns[1].Text := Caption_49; // name
    frmAccounts.VST.Header.Columns[2].Text := Caption_52; // currency
    frmAccounts.VST.Header.Columns[3].Text := Caption_37; // amount
    frmAccounts.VST.Header.Columns[4].Text := Caption_91; // date
    frmAccounts.VST.Header.Columns[5].Text := Caption_56; // comment
    frmAccounts.VST.Header.Columns[6].Text := Caption_51; // status
    frmAccounts.VST.Header.Columns[7].Text := Caption_53; // ID

    // labels
    frmAccounts.lblName.Caption := Caption_49;
    frmAccounts.lblCurrency.Caption := Caption_52;
    frmAccounts.lblAmount.Caption := Caption_37;
    frmAccounts.lblDate.Caption := Caption_91;
    frmAccounts.lblName.Caption := Caption_49;
    frmAccounts.lblComment.Caption := Caption_56;
    frmAccounts.lblStatus.Caption := Caption_51;

    // cbxStatus
    frmAccounts.cbxStatus.Clear;
    frmAccounts.cbxStatus.Items.Add(Caption_55);
    frmAccounts.cbxStatus.Items.Add(Caption_57);
    frmAccounts.cbxStatus.Items.Add(Caption_59);

    // =============================================================================================
    // FRMPERSONS FORM
    // =============================================================================================

    frmPersons.Caption := AnsiReplaceStr(AnsiUpperCase(Menu_28), '&', '');
    frmPersons.pnlDetailCaption.Caption := AnsiUpperCase(Caption_43);
    frmPersons.pnlListCaption.Caption := AnsiUpperCase(Caption_44);

    // update menu items
    frmPersons.btnAdd.Caption := Caption_00;
    frmPersons.btnEdit.Caption := Caption_02;
    frmPersons.btnDelete.Caption := Caption_03;
    frmPersons.btnExit.Caption := AnsiReplaceStr(Menu_63, '&', '');
    frmPersons.btnSave.Caption := Caption_04;
    frmPersons.btnCancel.Caption := Caption_05;
    frmPersons.btnCopy.Caption := Caption_272;
    frmPersons.btnPrint.Caption := Caption_68;
    frmPersons.btnSelect.Caption := Caption_12;

    // update hint of all menu
    frmPersons.btnAdd.Hint := frmDetail.btnAdd.Hint;
    frmPersons.btnEdit.Hint := frmMain.btnEdit.Hint;
    frmPersons.btnDelete.Hint := frmMain.btnDelete.Hint;
    frmPersons.btnSave.Hint := frmDetail.btnSave.Hint;
    frmPersons.btnCancel.Hint := frmDetail.btnCancel.Hint;
    frmPersons.btnExit.Hint := frmMain.btnReportExit.Hint;
    frmPersons.btnCopy.Hint := frmMain.btnCopy.Hint;
    frmPersons.btnSelect.Hint := frmMain.btnSelect.Hint;
    frmPersons.btnPrint.Hint := frmMain.btnReportPrint.Hint;
    frmPersons.btnStatusInfo.Hint := frmCurrencies.btnStatusInfo.Hint;

    // update pop menu items
    frmPersons.popAdd.Caption := Caption_00;
    frmPersons.popEdit.Caption := Caption_02;
    frmPersons.popDelete.Caption := Caption_03;
    frmPersons.popCopy.Caption := Caption_272;
    frmPersons.popExit.Caption := Menu_63;
    frmPersons.popPrint.Caption := Caption_68;
    frmPersons.popSelect.Caption := Caption_12;

    // VST columns caption
    frmPersons.VST.Header.Columns[1].Text := Caption_49; // name
    frmPersons.VST.Header.Columns[2].Text := Caption_56; // comment
    frmPersons.VST.Header.Columns[3].Text := Caption_51; // status
    frmPersons.VST.Header.Columns[4].Text := Caption_53; // ID

    frmPersons.lblName.Caption := Caption_49;
    frmPersons.lblComment.Caption := Caption_56;
    frmPersons.lblStatus.Caption := Caption_51;

    // cbxStatus
    frmPersons.cbxStatus.Clear;
    frmPersons.cbxStatus.Items.Add(Caption_55);
    frmPersons.cbxStatus.Items.Add(Caption_57);
    frmPersons.cbxStatus.Items.Add(Caption_59);

    // =============================================================================================
    // FRMPAYEES
    // =============================================================================================

    frmPayees.Caption := AnsiReplaceStr(AnsiUpperCase(Menu_24), '&', '');
    frmPayees.pnlDetailCaption.Caption := AnsiUpperCase(Caption_43);
    frmPayees.pnlListCaption.Caption := AnsiUpperCase(Caption_44);

    // update menu items
    frmPayees.btnAdd.Caption := Caption_00;
    frmPayees.btnEdit.Caption := Caption_02;
    frmPayees.btnDelete.Caption := Caption_03;
    frmPayees.btnExit.Caption := AnsiReplaceStr(Menu_63, '&', '');
    frmPayees.btnSave.Caption := Caption_04;
    frmPayees.btnCancel.Caption := Caption_05;
    frmPayees.btnCopy.Caption := Caption_272;
    frmPayees.btnPrint.Caption := Caption_68;
    frmPayees.btnSelect.Caption := Caption_12;

    // update hint of all menu
    frmPayees.btnAdd.Hint := frmDetail.btnAdd.Hint;
    frmPayees.btnEdit.Hint := frmMain.btnEdit.Hint;
    frmPayees.btnDelete.Hint := frmMain.btnDelete.Hint;
    frmPayees.btnSave.Hint := frmDetail.btnSave.Hint;
    frmPayees.btnCancel.Hint := frmDetail.btnCancel.Hint;
    frmPayees.btnExit.Hint := frmMain.btnReportExit.Hint;
    frmPayees.btnCopy.Hint := frmMain.btnCopy.Hint;
    frmPayees.btnSelect.Hint := frmMain.btnSelect.Hint;
    frmPayees.btnPrint.Hint := frmMain.btnReportPrint.Hint;
    frmPayees.btnStatusInfo.Hint := frmCurrencies.btnStatusInfo.Hint;

    // update pop menu items
    //popList.Images := frmMain.imgTransactions;
    frmPayees.popAdd.Caption := Caption_00;
    frmPayees.popEdit.Caption := Caption_02;
    frmPayees.popDelete.Caption := Caption_03;
    frmPayees.popCopy.Caption := Caption_272;
    frmPayees.popExit.Caption := Menu_63;
    frmPayees.popPrint.Caption := Caption_68;
    frmPayees.popSelect.Caption := Caption_12;

    frmPayees.lblName.Caption := Caption_49;
    frmPayees.lblComment.Caption := Caption_56;
    frmPayees.lblStatus.Caption := Caption_51;

    // VST columns caption
    frmPayees.VST.Header.Columns[1].Text := Caption_49; // name
    frmPayees.VST.Header.Columns[2].Text := Caption_56; // comment
    frmPayees.VST.Header.Columns[3].Text := Caption_51; // status
    frmPayees.VST.Header.Columns[4].Text := Caption_53; // ID

    // cbxStatus
    frmPayees.cbxStatus.Clear;
    frmPayees.cbxStatus.Items.Add(Caption_55);
    frmPayees.cbxStatus.Items.Add(Caption_57);
    frmPayees.cbxStatus.Items.Add(Caption_59);

    // =============================================================================================
    // FRMHOLIDAYS FORM
    // =============================================================================================

    frmHolidays.Caption := AnsiUpperCase(AnsiReplaceStr(Menu_21, '&', ''));
    frmHolidays.pnlDetailCaption.Caption := AnsiUpperCase(Caption_43);
    frmHolidays.pnlListCaption.Caption := AnsiUpperCase(Caption_44);

    // update menu items
    frmHolidays.btnAdd.Caption := Caption_00;
    frmHolidays.btnEdit.Caption := Caption_02;
    frmHolidays.btnDelete.Caption := Caption_03;
    frmHolidays.btnExit.Caption := AnsiReplaceStr(Menu_63, '&', '');
    frmHolidays.btnSave.Caption := Caption_04;
    frmHolidays.btnCancel.Caption := Caption_05;
    frmHolidays.btnCopy.Caption := Caption_272;
    frmHolidays.btnSelect.Caption := Caption_12;
    frmHolidays.btnPrint.Caption := Caption_68;

    // update hint of all menu
    frmHolidays.btnAdd.Hint := frmDetail.btnAdd.Hint;
    frmHolidays.btnEdit.Hint := frmMain.btnEdit.Hint;
    frmHolidays.btnDelete.Hint := frmMain.btnDelete.Hint;
    frmHolidays.btnSave.Hint := frmDetail.btnSave.Hint;
    frmHolidays.btnCancel.Hint := frmDetail.btnCancel.Hint;
    frmHolidays.btnExit.Hint := frmMain.btnReportExit.Hint;
    frmHolidays.btnCopy.Hint := frmMain.btnCopy.Hint;
    frmHolidays.btnSelect.Hint := frmMain.btnSelect.Hint;
    frmHolidays.btnPrint.Hint := frmMain.btnReportPrint.Hint;

    // update pop menu items
    frmHolidays.popAdd.Caption := Caption_00;
    frmHolidays.popEdit.Caption := Caption_02;
    frmHolidays.popDelete.Caption := Caption_03;
    frmHolidays.popCopy.Caption := Caption_272;
    frmHolidays.popExit.Caption := AnsiReplaceStr(Menu_63, '&', '');
    frmHolidays.popSelect.Caption := Caption_12;
    frmHolidays.popPrint.Caption := Caption_68;

    // VST columns caption
    frmHolidays.VST.Header.Columns[1].Text := Caption_26;
    frmHolidays.VST.Header.Columns[2].Text := Caption_92;
    frmHolidays.VST.Header.Columns[3].Text := Caption_53; // ID
    frmHolidays.VST.Header.Columns[4].Text := Caption_19;
    frmHolidays.VST.Header.Columns[5].Text := Caption_27;

    frmHolidays.lblDay.Caption := Caption_27;
    frmHolidays.lblMonth.Caption := Caption_19;
    frmHolidays.lblName.Caption := Caption_92;

    // =============================================================================================
    // FRMTAGS FORM
    // =============================================================================================

    frmTags.Caption := AnsiUpperCase(AnsiReplaceStr(Menu_22, '&', ''));
    frmTags.pnlDetailCaption.Caption := AnsiUpperCase(Caption_43);
    frmTags.pnlListCaption.Caption := AnsiUpperCase(Caption_44);

    // update menu items
    frmTags.btnAdd.Caption := Caption_00;
    frmTags.btnEdit.Caption := Caption_02;
    frmTags.btnDelete.Caption := Caption_03;
    frmTags.btnExit.Caption := AnsiReplaceStr(Menu_63, '&', '');
    frmTags.btnSave.Caption := Caption_04;
    frmTags.btnCancel.Caption := Caption_05;
    frmTags.btnCopy.Caption := Caption_272;
    frmTags.btnPrint.Caption := Caption_68;
    frmTags.btnSelect.Caption := Caption_12;

    // update hint of all menu
    frmTags.btnAdd.Hint := frmDetail.btnAdd.Hint;
    frmTags.btnEdit.Hint := frmMain.btnEdit.Hint;
    frmTags.btnDelete.Hint := frmMain.btnDelete.Hint;
    frmTags.btnSave.Hint := frmDetail.btnSave.Hint;
    frmTags.btnCancel.Hint := frmDetail.btnCancel.Hint;
    frmTags.btnExit.Hint := frmMain.btnReportExit.Hint;
    frmTags.btnCopy.Hint := frmMain.btnCopy.Hint;
    frmTags.btnSelect.Hint := frmMain.btnSelect.Hint;
    frmTags.btnPrint.Hint := frmMain.btnReportPrint.Hint;

    // update pop menu items
    frmTags.popAdd.Caption := Caption_00;
    frmTags.popEdit.Caption := Caption_02;
    frmTags.popDelete.Caption := Caption_03;
    frmTags.popCopy.Caption := Caption_272;
    frmTags.popExit.Caption := AnsiReplaceStr(Menu_63, '&', '');
    frmTags.popSelect.Caption := Caption_12;
    frmTags.popPrint.Caption := Caption_68;

    // header columns captions
    frmTags.VST.Header.Columns[1].Text := Caption_62;
    frmTags.VST.Header.Columns[2].Text := Caption_56;
    frmTags.VST.Header.Columns[3].Text := Caption_53; // ID

    frmTags.lblName.Caption := Caption_62;
    frmTags.lblComment.Caption := Caption_56;

    // =============================================================================================
    // FRMCOMMENTS FORM
    // =============================================================================================

    frmComments.Caption := AnsiUpperCase(AnsiReplaceStr(Menu_25, '&', ''));
    frmComments.pnlDetailCaption.Caption := AnsiUpperCase(Caption_43);
    frmComments.pnlListCaption.Caption := AnsiUpperCase(Caption_44);

    // update menu items
    frmComments.btnAdd.Caption := Caption_00;
    frmComments.btnEdit.Caption := Caption_02;
    frmComments.btnDelete.Caption := Caption_03;
    frmComments.btnExit.Caption := AnsiReplaceStr(Menu_63, '&', '');
    frmComments.btnSave.Caption := Caption_04;
    frmComments.btnCancel.Caption := Caption_05;
    frmComments.btnCopy.Caption := Caption_272;
    frmComments.btnPrint.Caption := Caption_68;
    frmComments.btnSelect.Caption := Caption_12;

    // update hint of all menu
    frmComments.btnAdd.Hint := frmDetail.btnAdd.Hint;
    frmComments.btnEdit.Hint := frmMain.btnEdit.Hint;
    frmComments.btnDelete.Hint := frmMain.btnDelete.Hint;
    frmComments.btnSave.Hint := frmDetail.btnSave.Hint;
    frmComments.btnCancel.Hint := frmDetail.btnCancel.Hint;
    frmComments.btnExit.Hint := frmMain.btnReportExit.Hint;
    frmComments.btnCopy.Hint := frmMain.btnCopy.Hint;
    frmComments.btnSelect.Hint := frmMain.btnSelect.Hint;
    frmComments.btnPrint.Hint := frmMain.btnReportPrint.Hint;

    // update btn menu items
    frmComments.popAdd.Caption := Caption_00;
    frmComments.popEdit.Caption := Caption_02;
    frmComments.popDelete.Caption := Caption_03;
    frmComments.popExit.Caption := AnsiReplaceStr(Menu_63, '&', '');
    frmComments.popCopy.Caption := Caption_272;
    frmComments.popPrint.Caption := Caption_68;
    frmComments.popSelect.Caption := Caption_12;

    // header columns captions
    frmComments.VST.Header.Columns[1].Text := Caption_56;
    frmComments.VST.Header.Columns[2].Text := Caption_53; // ID

    frmComments.lblComment.Caption := Caption_56;

    // =============================================================================================
    // FRMSCHEDULERS FORM
    // =============================================================================================

    frmSchedulers.Caption := AnsiUpperCase(AnsiReplaceStr(Menu_41, '&', ''));
    frmSchedulers.pnlListCaption.Caption := AnsiUpperCase(Caption_44);
    frmSchedulers.pnlPaymentsCaption.Caption := AnsiUpperCase(Caption_66);

    // update menu items
    frmSchedulers.btnAdd.Caption := Caption_00;
    frmSchedulers.btnDelete.Caption := Caption_03;
    frmSchedulers.btnExit.Caption := AnsiReplaceStr(Menu_63, '&', '');
    frmSchedulers.btnCalendar.Caption := AnsiReplaceStr(Menu_43, '&', '');

    // update hint of all menu
    frmSchedulers.btnAdd.Hint := frmDetail.btnAdd.Hint;
    frmSchedulers.btnDelete.Hint := frmMain.btnDelete.Hint;
    frmSchedulers.btnCalendar.Hint := frmMain.btnCalendar.Hint;
    frmSchedulers.btnExit.Hint := frmMain.btnReportExit.Hint;

    frmSchedulers.btnAdd1.Hint := frmDetail.btnAdd.Hint;
    frmSchedulers.btnEdit1.Hint := frmMain.btnEdit.Hint;
    frmSchedulers.btnDelete1.Hint := frmMain.btnDelete.Hint;

    // update pop menu items
    frmSchedulers.popAdd.Caption := Caption_00;
    frmSchedulers.popDelete.Caption := Caption_03;
    frmSchedulers.popCalendar.Caption := AnsiReplaceStr(Menu_43, '&', '');
    frmSchedulers.popExit.Caption := AnsiReplaceStr(Menu_63, '&', '');
    frmSchedulers.popAdd1.Caption := Caption_00;
    frmSchedulers.popDelete1.Caption := Caption_03;
    frmSchedulers.popEdit1.Caption := Caption_02;

    // update Payments buttons
    frmSchedulers.btnAdd1.Caption := Caption_00;
    frmSchedulers.btnEdit1.Caption := Caption_02;
    frmSchedulers.btnDelete1.Caption := Caption_03;

    // Grid columns title - list
    frmSchedulers.VST.Header.Columns[1].Text := Caption_69; // date from
    frmSchedulers.VST.Header.Columns[2].Text := Caption_70; // date to
    frmSchedulers.VST.Header.Columns[3].Text := Caption_95; // periodicity
    frmSchedulers.VST.Header.Columns[4].Text := Caption_42; // amount
    frmSchedulers.VST.Header.Columns[5].Text := Caption_52; // currency
    frmSchedulers.VST.Header.Columns[6].Text := Caption_56; // comment
    frmSchedulers.VST.Header.Columns[7].Text := Caption_50; // account
    frmSchedulers.VST.Header.Columns[8].Text := AnsiReplaceStr(Caption_54, '&', ''); // category
    frmSchedulers.VST.Header.Columns[9].Text := Caption_80; // subcategory
    frmSchedulers.VST.Header.Columns[10].Text := Caption_58; // person
    frmSchedulers.VST.Header.Columns[11].Text := Caption_60; // payee
    frmSchedulers.VST.Header.Columns[12].Text := Caption_53; // ID
    // frmSchedulers.VST.Header.Columns[13].Text := Caption_63; // Type

    frmSchedulers.VST1.Hint := Menu_A14;

    // Grid columns title - payments
    frmSchedulers.VST1.Header.Columns[1].Text := Caption_32; // scheduled date
    frmSchedulers.VST1.Header.Columns[2].Text := Caption_42; // amount
    frmSchedulers.VST1.Header.Columns[3].Text := Caption_83; // paid date
    frmSchedulers.VST1.Header.Columns[4].Text := Caption_53; // ID

    // ṕopup
    frmSchedulers.popDeleteDate.Caption := Menu_D1;
    frmSchedulers.popEditDate.Caption := Menu_D2;
    frmSchedulers.Calendar.Title := Menu_D3;
    frmSchedulers.Calendar.CancelCaption := Caption_05;
    frmSchedulers.Calendar.OKCaption := Caption_04;

    // =============================================================================================
    // FRMSCHEDULER FORM
    // =============================================================================================

    frmScheduler.Caption := AnsiUpperCase(AnsiReplaceStr(Menu_41, '&', ''));

    // hints
    frmScheduler.btnComment.Hint := frmMain.btnComments.Hint;
    frmScheduler.btnCategory.Hint := frmMain.btnCategories.Hint;
    frmScheduler.btnPerson.Hint := frmMain.btnPersons.Hint;
    frmScheduler.btnPayee.Hint := frmMain.btnPayees.Hint;
    frmScheduler.btnAccountFrom.Hint := frmMain.btnAccounts.Hint;
    frmScheduler.btnAccountTo.Hint := frmMain.btnAccounts.Hint;
    frmScheduler.btnTag.Hint := frmMain.btnTags.Hint;
    frmScheduler.btnAmountFrom.Hint := frmDetail.btnAmountFrom.Hint;
    frmScheduler.btnAmountTo.Hint := frmDetail.btnAmountTo.Hint;

    // buttons
    frmScheduler.btnSave.Caption := Caption_04;
    frmScheduler.btnCancel.Caption := Caption_05;
    frmScheduler.btnSave.Hint := frmDetail.btnSave.Hint;
    frmScheduler.btnCancel.Hint := frmDetail.btnCancel.Hint;
    frmScheduler.btnSettings.Caption := AnsiReplaceStr(Menu_61, '&', '');
    frmScheduler.btnSettings.Hint := frmMain.btnSettings.Hint;

    // labels FROM
    frmScheduler.lblDateFrom.Caption := Caption_69; // date from
    frmScheduler.lblAccountFrom.Caption := Caption_77; // from account
    frmScheduler.lblAmountFrom.Caption := Caption_42; // amount

    // labels TO
    frmScheduler.lblDateTo.Caption := Caption_70; // date to
    frmScheduler.lblAccountTo.Caption := Caption_78; // to account
    frmScheduler.lblAmountTo.Caption := Caption_42; // amount

    frmScheduler.lblType.Caption := Caption_63; // type
    frmScheduler.lblComment.Caption := Caption_56; // comment
    frmScheduler.lblCategory.Caption := AnsiReplaceStr(Caption_54, '&', '') + ' / ' + Caption_80; // Category / Subcategory
    frmScheduler.lblPerson.Caption := Caption_58; // person
    frmScheduler.lblPayee.Caption := Caption_60; // payee
    frmScheduler.lblTag.Caption := Caption_62; // tag
    frmScheduler.lblPeriodicity.Caption := Caption_95; // periodicity

    frmScheduler.cbxPeriodicity.Clear;
    frmScheduler.cbxPeriodicity.Items.Add(Caption_207); // Once
    frmScheduler.cbxPeriodicity.Items.Add(Caption_208); // Every X days
    frmScheduler.cbxPeriodicity.Items.Add(Caption_209); // Daily
    frmScheduler.cbxPeriodicity.Items.Add(Caption_210); // Weekly
    frmScheduler.cbxPeriodicity.Items.Add(Caption_211); // Fortnightly
    frmScheduler.cbxPeriodicity.Items.Add(Caption_212); // Monthly
    frmScheduler.cbxPeriodicity.Items.Add(Caption_213); // quarterly
    frmScheduler.cbxPeriodicity.Items.Add(Caption_214); // Biannualy
    frmScheduler.cbxPeriodicity.Items.Add(Caption_215); // Yearly

    frmScheduler.chkUseDateShift.Caption := Caption_317;

    // =============================================================================================
    // FRMPROPERTIES
    // =============================================================================================
    frmProperties.Caption := AnsiUpperCase(AnsiReplaceStr(Caption_65, '&', ''));
    frmProperties.pnlCaption.Caption := frmProperties.Caption;
    frmProperties.pnlCaption1.Caption := Caption_100;
    frmProperties.tabRecords.Caption := Caption_64;
    frmProperties.tabDatabase.Caption := AnsiReplaceStr(Menu_00, '&', '');

    frmProperties.btnExit.Caption := AnsiReplaceStr(Menu_63, '&', '');
    frmProperties.btnExit.Hint := frmMain.btnReportExit.Hint;

    //frmProperties.lblPasswordProtection.Caption := Caption_109;
    frmProperties.lblData.Caption := Caption_25;
    frmProperties.lblRecycle.Caption := AnsiReplaceStr(Menu_09, '&', '');
    frmProperties.lblAccounts.Caption := AnsiReplaceStr(Menu_26, '&', '');
    frmProperties.lblCurrencies.Caption := AnsiReplaceStr(Menu_23, '&', '');
    frmProperties.lblCategories.Caption := AnsiReplaceStr(Menu_27, '&', '');
    frmProperties.lblComments.Caption := AnsiReplaceStr(Menu_25, '&', '');
    frmProperties.lblPersons.Caption := AnsiReplaceStr(Menu_28, '&', '');
    frmProperties.lblPayees.Caption := AnsiReplaceStr(Menu_24, '&', '');
    frmProperties.lblHolidays.Caption := AnsiReplaceStr(Menu_21, '&', '');
    frmProperties.lblTags.Caption := AnsiReplaceStr(Menu_22, '&', '');
    frmProperties.lblSchedulers.Caption := AnsiReplaceStr(Menu_41, '&', '');
    frmProperties.lblPayments.Caption := AnsiReplaceStr(Caption_11, '&', '');
    frmProperties.lblBudget.Caption := AnsiReplaceStr(Menu_44, '&', '');
    frmProperties.lblLinks.Caption := AnsiReplaceStr(Menu_30, '&', '');

    frmProperties.lblFileName_.Caption := Caption_96;
    frmProperties.lblLocation_.Caption := Caption_97;
    frmProperties.lblSize_.Caption := Caption_98;
    frmProperties.lblPasswordProtection_.Caption := Caption_99;
    frmProperties.lblEncryptionProtection_.Caption := Caption_332;
    frmProperties.lblOS1.Caption := Caption_124;
    frmProperties.lblSQLiteName1.Caption := Caption_126;
    frmProperties.lblSQLiteVersion1.Caption := Caption_127;

    // =============================================================================================
    // CASH COUNTER FORM
    // =============================================================================================
    frmCounter.Caption := UTF8UpperCase(AnsiReplaceStr(Menu_46, '&', ''));
    frmCounter.btnReset.Caption := Caption_21;
    frmCounter.btnPrint.Caption := Caption_68;
    frmCounter.btnPrint.Hint := frmMain.btnReportPrint.Hint;
    frmCounter.btnCopy.Caption := frmMain.btnCopy.Caption;
    frmCounter.btnCopy.Hint := frmMain.btnCopy.Hint;
    frmCounter.btnCurrencies.Hint := frmMain.btnCurrencies.Hint;
    frmCounter.btnValues.Hint := frmCurrencies.btnValues.Hint;
    frmCounter.btnExit.Caption := AnsiReplaceStr(Menu_63, '&', '');
    frmCounter.btnExit.Hint := frmMain.btnReportExit.Hint;
    frmCounter.pnlCurrencyCaption.Caption := Caption_101;
    frmCounter.lblValue.Caption := Caption_102;
    frmCounter.lblTotalCaption.Hint := AnsiUpperCase(Caption_16) + ':';

    // =============================================================================================
    // MANY CURRENCIES FORM
    // =============================================================================================

    frmManyCurrencies.Caption := Caption_103;
    frmManyCurrencies.pnlManyCurrenciesCaption.Caption := Caption_104;
    frmManyCurrencies.lblManyCurrencies.Caption := Format(Caption_105, [sLineBreak]);

    frmManyCurrencies.btnSave.Caption := Caption_04;
    frmManyCurrencies.btnCancel.Caption := Caption_05;
    frmManyCurrencies.btnSave.Hint := frmDetail.btnSave.Hint;
    frmManyCurrencies.btnCancel.Hint := frmDetail.btnCancel.Hint;

    // =============================================================================================
    // FRMWRITE FORM
    // =============================================================================================
    frmWrite.Caption := AnsiUpperCase(AnsiReplaceStr(Menu_42, '&', ''));
    frmWrite.pnlListCaption.Caption := AnsiUpperCase(Caption_25);

    // Transactions grid columns title
    frmWrite.VST.Header.Columns[1].Text := Caption_26; // date
    frmWrite.VST.Header.Columns[2].Text := Caption_56; // comment
    frmWrite.VST.Header.Columns[3].Text := Caption_42; // amount
    frmWrite.VST.Header.Columns[4].Text := Caption_52; // currency
    frmWrite.VST.Header.Columns[5].Text := Caption_50; // account
    frmWrite.VST.Header.Columns[6].Text := AnsiReplaceStr(Caption_54, '&', '');
    // category
    frmWrite.VST.Header.Columns[7].Text := Caption_80;  // subcategory
    frmWrite.VST.Header.Columns[8].Text := Caption_58; // person
    frmWrite.VST.Header.Columns[9].Text := Caption_60; // payee
    frmWrite.VST.Header.Columns[10].Text := Caption_53; // ID
    frmWrite.VST.Header.Columns[11].Text := Caption_63; // Type

    // update pop menu items
    frmWrite.popEdit.Caption := Caption_02;
    frmWrite.popDelete.Caption := Caption_03;
    frmWrite.popCalendar.Caption := AnsiReplaceStr(Menu_43, '&', '');
    frmWrite.popSave.Caption := Caption_72;
    frmWrite.popExit.Caption := AnsiReplaceStr(Menu_63, '&', '');

    // captions
    frmWrite.btnCalendar.Caption := AnsiReplaceStr(Menu_43, '&', '');
    frmWrite.btnCalendar.Hint := frmMain.btnCalendar.Hint;
    frmWrite.btnSave.Caption := Caption_72;
    frmWrite.btnSave.Hint := frmDetail.btnSave.Hint;
    frmWrite.btnExit.Caption := AnsiReplaceStr(Menu_63, '&', '');
    frmWrite.btnExit.Hint := frmMain.btnReportExit.Hint;
    frmWrite.btnEdit.Caption := Caption_02;
    frmWrite.btnEdit.Hint := frmMain.btnEdit.Hint;
    frmWrite.btnDelete.Caption := Caption_03;
    frmWrite.btnDelete.Hint := frmMain.btnDelete.Hint;
    frmWrite.btnSettings.Caption := AnsiReplaceStr(Menu_61, '&', '');
    frmWrite.btnSettings.Hint := frmMain.btnSettings.Hint;

    // =============================================================================================
    // FRMWRITEAGREEMENT FORM
    // =============================================================================================
    frmWriting.Caption := Caption_165;
    frmWriting.rbtWriteAtOnce.Caption := Caption_167;
    frmWriting.rbtWriteGradually.Caption := Caption_168;
    frmWriting.btnCancel.Caption := Caption_05;
    frmWriting.btnWrite.Caption := Caption_72;

    // =============================================================================================
    // FRMCALENDAR FORM
    // =============================================================================================

    frmCalendar.Caption := AnsiUpperCase(AnsiReplaceStr(Menu_43, '&', ''));
    frmCalendar.pnlFilterCaption.Caption := AnsiUpperCase(Caption_18);
    frmCalendar.pnlMonthYearCaption.Caption :=
      '  ' + Caption_19 + ' + ' + Caption_20 + '  ';
    // Month & Year
    frmCalendar.pnlCurrencyCaption.Caption := '  ' + Caption_52;
    frmCalendar.pnlAccountCaption.Caption := '  ' + Caption_50;
    frmCalendar.pnlSummaryCaption.Caption := AnsiUpperCase(Caption_15);
    frmCalendar.tabMonthly.Caption := Caption_111;
    frmCalendar.tabDaily.Caption := Caption_112;

    // Grid columns title - list
    frmCalendar.VST.Header.Columns[1].Text := Caption_26; // Date
    frmCalendar.VST.Header.Columns[2].Text := Trim(frmScheduler.lblPeriodicity.Caption);

    // periodicity
    frmCalendar.VST.Header.Columns[3].Text := Caption_42; // Amount
    frmCalendar.VST.Header.Columns[4].Text := Caption_52; // Currency
    frmCalendar.VST.Header.Columns[5].Text := Caption_56; // Comment
    frmCalendar.VST.Header.Columns[6].Text := Caption_53; // ID

    frmCalendar.btnEdit.Caption := Caption_02;
    frmCalendar.btnDelete.Caption := Caption_03;
    frmCalendar.btnEdit.Hint := frmMain.btnEdit.Hint;
    frmCalendar.btnDelete.Hint := frmMain.btnDelete.Hint;
    frmCalendar.btnExit.Caption := AnsiReplaceStr(Menu_63, '&', '');
    frmCalendar.btnExit.Hint := frmMain.btnReportExit.Hint;

    // VST float
    frmCalendar.VSTFloat.Header.Columns[1].Text := Caption_42;
    frmCalendar.VSTFloat.Header.Columns[2].Text := Caption_52;
    frmCalendar.VSTFloat.Header.Columns[3].Text := Caption_56;

    // hints
    frmCalendar.btnCurrencies.Hint := frmMain.btnCurrencies.Hint;
    frmCalendar.btnAccounts.Hint := frmMain.btnAccounts.Hint;

    // =============================================================================================
    // FRMDELETE FORM
    // =============================================================================================

    frmDelete.Caption := Caption_117;
    frmDelete.pnlCaption1.Caption := Message_00;
    frmDelete.btnCancel.Caption := Caption_05;
    frmDelete.btnDelete.Caption := Caption_03;

    // tabs
    //    frmDelete.tabSchedulers.Caption := AnsiReplaceStr(Menu_41, '&', '');
    //    frmDelete.tabBudget.Caption := AnsiReplaceStr(Menu_44, '&', '');

    // Transactions grid columns title
    frmDelete.VST1.Header.Columns[1].Text := Caption_26; // Date
    frmDelete.VST1.Header.Columns[2].Text := Caption_56; // Comment
    frmDelete.VST1.Header.Columns[3].Text := Caption_42; // Amount
    frmDelete.VST1.Header.Columns[4].Text := Caption_52; // Currency
    frmDelete.VST1.Header.Columns[5].Text := Caption_50; // Account
    frmDelete.VST1.Header.Columns[6].Text := AnsiReplaceStr(Caption_54, '&', ''); // Category
    frmDelete.VST1.Header.Columns[7].Text := Caption_80; // subcategory
    frmDelete.VST1.Header.Columns[8].Text := Caption_58; // Person
    frmDelete.VST1.Header.Columns[9].Text := Caption_60; // Payee
    frmDelete.VST1.Header.Columns[10].Text := Caption_53; // ID
    frmDelete.VST1.Header.Columns[11].Text := Caption_63; // Type

    // Grid columns title - schedulers
    frmDelete.VST2.Header.Columns[1].Text := Caption_69; // date from
    frmDelete.VST2.Header.Columns[2].Text := Caption_70; // date to
    frmDelete.VST2.Header.Columns[3].Text := Caption_95; // periodicity
    frmDelete.VST2.Header.Columns[4].Text := Caption_42; // amount
    frmDelete.VST2.Header.Columns[5].Text := Caption_52; // currency
    frmDelete.VST2.Header.Columns[6].Text := Caption_56; // comment
    frmDelete.VST2.Header.Columns[7].Text := Caption_50; // account
    frmDelete.VST2.Header.Columns[8].Text := AnsiReplaceStr(Caption_54, '&', ''); // category
    frmDelete.VST2.Header.Columns[9].Text := Caption_80; // subcategory
    frmDelete.VST2.Header.Columns[10].Text := Caption_58; // person
    frmDelete.VST2.Header.Columns[11].Text := Caption_60; // payee
    frmDelete.VST2.Header.Columns[12].Text := Caption_53; // ID
    frmDelete.VST2.Header.Columns[13].Text := Caption_63; // Type

    // Grid columns title - budgets
    frmDelete.VST3.Header.Columns[1].Text := AnsiReplaceStr(Menu_44, '&', ''); // budget
    frmDelete.VST3.Header.Columns[2].Text := AnsiReplaceStr(Caption_54, '&', ''); // category
    frmDelete.VST3.Header.Columns[3].Text := Caption_80; // subcategory
    frmDelete.VST3.Header.Columns[4].Text := Caption_53; // ID

    // =============================================================================================
    // FRMABOUT FORM
    // =============================================================================================

    frmAbout.lblVersion.Caption := frmAbout.lblVersion.Hint + ' ' + Version_01;
    frmAbout.Caption := AnsiReplaceStr(AnsiUpperCase(Menu_62), '&', ''); // About
    frmAbout.tabProgram.Caption := AnsiReplaceStr(Menu_60, '&', ''); // Program
    frmAbout.pnlProgram.Caption := AnsiReplaceStr(Menu_60, '&', '') + ':'; // Program
    frmAbout.tabAuthor.Caption := Menu_A01; // Author
    frmAbout.pnlAuthor.Caption := Menu_A01 + ':'; // Author
    frmAbout.pnlLocation.Caption := Caption_97 + ':'; // Location
    frmAbout.pnlEmail.Caption := Menu_A02 + ':'; // E-mail
    frmAbout.pnlVersion.Caption := Menu_A03 + ':'; // Version
    frmAbout.tabLicense.Caption := Menu_A04; // License
    frmAbout.lblLicense.Caption := AnsiReplaceStr(License_01, '%', sLineBreak);
    // free software
    frmAbout.pnlReleased.Caption := Menu_A06 + ':'; // Released
    frmAbout.pnlWebsite.Caption := Menu_A07 + ':'; // Official website
    frmAbout.pnlDeveloped.Caption := Menu_A08 + ':'; // Developed in
    frmAbout.tabThanks.Caption := Menu_A09;  // Thanks
    frmAbout.lblThanks.Caption := AnsiReplaceStr(Menu_A10, '%', sLineBreak);
    frmAbout.tabDonate.Caption := Menu_A11; // Donation
    frmAbout.lblDonate.Caption := AnsiReplaceStr(Menu_A12, '%', sLineBreak);
    frmAbout.btnExit.Caption := AnsiReplaceStr(Menu_63, '&', ''); // Exit
    frmAbout.imgDonate.Hint := AnsiReplaceStr(Menu_A13, '%', sLineBreak);
    frmAbout.lblLink1.Caption := Caption_313;

    // =============================================================================================
    // BEGINNER'S GUIDE FORM
    // =============================================================================================
    frmGuide.Caption := Guide_01;
    frmGuide.pnlGuideCaption.Caption := Guide_02;
    frmGuide.txtWelcome.Caption := AnsiReplaceStr(Guide_03, '%', sLineBreak);
    frmGuide.btnPerson.Hint := Hint_47; // list of persons
    frmGuide.txtPerson.Caption := AnsiReplaceStr(Guide_04, '%', sLineBreak);
    frmGuide.btnAccount.Hint := Hint_45; // list of accounts;
    frmGuide.txtAccount.Caption := AnsiReplaceStr(Guide_05, '%', sLineBreak);
    frmGuide.btnCategory.Hint := Hint_46;
    frmGuide.txtCategory.Caption := AnsiReplaceStr(Guide_06, '%', sLineBreak);
    frmGuide.btnPayee.Hint := Hint_43;
    frmGuide.txtPayee.Caption := AnsiReplaceStr(Guide_07, '%', sLineBreak);
    frmGuide.btnTransaction.Hint := Hint_01;
    frmGuide.txtTransaction.Caption := AnsiReplaceStr(Guide_08, '%', sLineBreak);
    frmGuide.txtFinish.Caption := AnsiReplaceStr(Guide_09, '%', sLineBreak);
    frmGuide.btnBack.Caption := Caption_23;
    frmGuide.btnNext.Caption := Caption_24;

    // =============================================================================================
    // FRMHISTORY FORM
    // =============================================================================================

    frmHistory.Caption := AnsiUpperCase(Caption_67);
    frmHistory.btnCancel.Caption := AnsiReplaceStr(Menu_03, '&', '');
    frmHistory.pnlOriginalCaption.Caption := Caption_200;
    frmHistory.pnlHistoryCaption.Caption := Caption_201;

    // =============================================================================================
    // Transactions grid columns title
    // =============================================================================================

    frmHistory.VST1.Header.Columns[1].Text := Caption_26; // Date
    frmHistory.VST1.Header.Columns[2].Text := Caption_56; // Comment
    frmHistory.VST1.Header.Columns[3].Text := Caption_42; // Amount
    frmHistory.VST1.Header.Columns[4].Text := Caption_52; // Currency
    frmHistory.VST1.Header.Columns[5].Text := Caption_50; // Account
    frmHistory.VST1.Header.Columns[6].Text := AnsiReplaceStr(Caption_54, '&', ''); // Category
    frmHistory.VST1.Header.Columns[7].Text := Caption_80; // subcategory
    frmHistory.VST1.Header.Columns[8].Text := Caption_58; // Person
    frmHistory.VST1.Header.Columns[9].Text := Caption_60; // Payee
    frmHistory.VST1.Header.Columns[10].Text := Caption_17;  // date and time
    frmHistory.VST1.Header.Columns[11].Text := Caption_63; // Type

    frmHistory.VST2.Header.Columns[1].Text := Caption_26; // Date
    frmHistory.VST2.Header.Columns[2].Text := Caption_56; // Comment
    frmHistory.VST2.Header.Columns[3].Text := Caption_42; // Amount
    frmHistory.VST2.Header.Columns[4].Text := Caption_52; // Currency
    frmHistory.VST2.Header.Columns[5].Text := Caption_50; // Account
    frmHistory.VST2.Header.Columns[6].Text := AnsiReplaceStr(Caption_54, '&', ''); // Category
    frmHistory.VST2.Header.Columns[7].Text := Caption_80; // subcategory
    frmHistory.VST2.Header.Columns[8].Text := Caption_58; // Person
    frmHistory.VST2.Header.Columns[9].Text := Caption_60; // Payee
    frmHistory.VST2.Header.Columns[10].Text := Caption_17;  // date and time
    frmHistory.VST2.Header.Columns[11].Text := Caption_63; // Type

    // =============================================================================================
    // FRMPASSWORD FORM
    // =============================================================================================

    frmPassword.Caption := AnsiUpperCase(AnsiReplaceStr(Menu_06, '&', ''));

    frmPassword.btnSave.Caption := Caption_04;
    frmPassword.btnSave.Hint := Hint_102;
    frmPassword.btnExit.Caption := AnsiReplaceStr(Menu_63, '&', '');
    frmPassword.btnExit.Hint := frmMain.btnReportExit.Hint;

    frmPassword.lblPassword.Caption := AnsiReplaceStr(Caption_184, '%', sLineBreak);
    frmPassword.pnlPasswordCaption.Caption := Caption_185;
    frmPassword.lblOld.Caption := Caption_186;
    frmPassword.lblNew.Caption := Caption_187;
    frmPassword.lblConfirm.Caption := Caption_188;
    frmPassword.btnBack.Caption := Caption_116;

    // =============================================================================================
    // FRMRECYCLEBIN FORM
    // =============================================================================================
    frmRecycleBin.Caption := AnsiReplaceStr(AnsiUpperCase(Menu_09), '&', '');
    frmRecycleBin.pnlListCaption.Caption := AnsiUpperCase(Caption_25);
    frmRecycleBin.btnExit.Caption := AnsiReplaceStr(Menu_63, '&', '');
    frmRecycleBin.btnRestore.Caption := Caption_48;
    frmRecycleBin.btnEdit.Caption := Caption_02;
    frmRecycleBin.btnDelete.Caption := Caption_03;
    frmRecycleBin.btnSelect.Caption := Caption_12;
    frmRecycleBin.lblView.Caption := Caption_169;
    frmRecycleBin.cbxView.Clear;
    frmRecycleBin.cbxView.Items.Add(Caption_170);
    frmRecycleBin.cbxView.Items.Add(Caption_171);
    frmRecycleBin.cbxView.Items.Add(Caption_172);
    frmRecycleBin.cbxView.ItemIndex := 0;

    // buttons
    frmRecycleBin.btnEdit.Hint := frmMain.btnEdit.Hint;
    frmRecycleBin.btnDelete.Hint := frmMain.btnDelete.Hint;
    frmRecycleBin.btnSelect.Hint := frmMain.btnSelect.Hint;
    frmRecycleBin.btnExit.Hint := frmMain.btnReportExit.Hint;
    frmRecycleBin.btnRestore.Hint :=
      Hint_70 + sLineBreak + '[' +
      ShortCutToText(frmRecycleBin.actRestore.ShortCut) + ']';

    // Transactions grid columns title
    frmRecycleBin.VST.Header.Columns[1].Text := Caption_26; // Date
    frmRecycleBin.VST.Header.Columns[2].Text := Caption_56; // Comment
    frmRecycleBin.VST.Header.Columns[3].Text := Caption_42; // Amount
    frmRecycleBin.VST.Header.Columns[4].Text := Caption_52; // Currency
    frmRecycleBin.VST.Header.Columns[5].Text := Caption_50; // Account
    frmRecycleBin.VST.Header.Columns[6].Text := AnsiReplaceStr(Caption_54, '&', ''); // Category
    frmRecycleBin.VST.Header.Columns[7].Text := Caption_80; // subcategory
    frmRecycleBin.VST.Header.Columns[8].Text := Caption_58; // Person
    frmRecycleBin.VST.Header.Columns[9].Text := Caption_60; // Payee
    frmRecycleBin.VST.Header.Columns[10].Text := Caption_53; // ID
    // frmRecycleBin.VST.Header.Columns[11].Text := Caption_63; // Type

    // =============================================================================================
    // FRMSETTINGS FORM
    // =============================================================================================
    // buttons
    frmSettings.Caption := AnsiUpperCase(AnsiReplaceStr(Menu_61, '&', ''));
    frmSettings.btnCancel.Caption := Caption_05;
    frmSettings.btnSave.Caption := Caption_04;
    frmSettings.btnIniFile.Caption := Caption_22;

    // tree view
    frmSettings.treSettings.Items[0].Text := AnsiReplaceStr(Menu_60, '&', ''); // Program

    frmSettings.treSettings.Items[1].Text := Caption_119; // Global
    frmSettings.treSettings.Items[2].Text := Caption_121; // On run
    frmSettings.treSettings.Items[3].Text := Caption_120; // Visual
    frmSettings.treSettings.Items[4].Text := Caption_25; // Transactions
    frmSettings.treSettings.Items[5].Text := AnsiReplaceStr(Menu_45, '&', ''); // reports
    frmSettings.treSettings.Items[6].Text := Chart_01; // Charts
    frmSettings.treSettings.Items[7].Text := AnsiReplaceStr(Menu_40, '&', '');
    // financial tools
    frmSettings.treSettings.Items[8].Text := Caption_122; // shortcuts

    frmSettings.treSettings.Items[9].Text := AnsiReplaceStr(Menu_00, '&', '');
    // database
    frmSettings.treSettings.Items[10].Text := Caption_121; // on open
    frmSettings.treSettings.Items[11].Text := Caption_243; // on close

    frmSettings.tabFormat.Caption := Caption_131;
    frmSettings.pnlVisual.Caption := Caption_120;
    //frmSettings.lblMainWindow.Caption := Caption_238;

    // LANGUAGE
    frmSettings.tabLanguage.Caption := Caption_130;
    frmSettings.VSTLang.Header.Columns[1].Text := Caption_71;
    frmSettings.VSTLang.Header.Columns[2].Text := Caption_130;
    frmSettings.VSTLang.Header.Columns[3].Text := Menu_A05;
    frmSettings.VSTLang.Header.Columns[4].Text := Menu_A02;

    P := frmSettings.VSTLang.GetFirst();
    while Assigned(P) do
    begin
      Lang := frmSettings.VSTLang.GetNodeData(P);
      if (Lang.code = 'cs') or (Lang.code = 'en') or (Lang.code = 'sk') then
        Lang.translator := AnsiLowerCase(Menu_A01);
      P := frmSettings.VSTLang.GetNext(P);
    end;

    // GLOBAL SETTINGS
    frmSettings.rbtSettingsAutomatic.Caption := Caption_132;
    frmSettings.rbtSettingsUser.Caption := Caption_133;
    frmSettings.lblNumericFormat.Caption := Caption_134;
    frmSettings.lblThousandSeparator.Caption := Caption_135;
    frmSettings.lblDecimalSeparator.Caption := Caption_136;
    frmSettings.lblExampleLongDate.Caption := Caption_137;
    frmSettings.lblExampleShortDate.Caption := Caption_137;
    frmSettings.lblExampleSeparator.Caption := Caption_137;
    frmSettings.lblDateFormat.Caption := Caption_138;
    frmSettings.lblFirstWeekDay.Caption := Caption_139;
    frmSettings.lblDateShort1.Caption := Caption_140;
    frmSettings.lblDateLong1.Caption := Caption_141;

    frmSettings.tabProgram.Caption := AnsiReplaceStr(Menu_60, '&', '');
    frmSettings.lblPanelsColor.Caption := Caption_143;
    frmSettings.chkShadowedFont.Caption := Caption_144;
    frmSettings.chkBoldFont.Caption := Caption_145;
    frmSettings.chkGradientEffect.Caption := Caption_146;
    frmSettings.chkRedColorButtonDelete.Caption := Caption_327;
    frmSettings.btnCaptionColorBack.Caption := Caption_147;
    frmSettings.btnCaptionColorFont.Caption := Caption_148;
    frmSettings.tabTables.Caption := Caption_149;
    frmSettings.lblOddRowColor.Caption := Caption_150;
    frmSettings.btnOddRowColorBack.Caption := Caption_147;
    frmSettings.lblGridFont.Caption := Caption_246;

    frmSettings.tabFilter.Caption := Caption_18;
    frmSettings.chkFilterComboboxStyle.Caption := Caption_341;

    frmSettings.tabButtons.Caption := Caption_328;
    frmSettings.lblButtonsSize.Caption := Caption_329;
    frmSettings.lblButtonsVisibility.Caption := Caption_330;

    frmSettings.chkLastFormsSize.Caption := Caption_158;
    frmSettings.chkLastUsedFile.Caption := Caption_160;
    frmSettings.chkLastUsedFilter.Caption := Caption_161;
    frmSettings.chkLastUsedFilterDate.Caption := Caption_316;
    frmSettings.chkAutoColumnWidth.Caption := Caption_162;
    frmSettings.chkNewVersion.Caption := Caption_279;

    frmSettings.btnChange.Caption := Caption_02;
    frmSettings.btnDefault.Caption := Caption_278;
    frmSettings.VSTKeys.Header.Columns[1].Text := Caption_204;
    frmSettings.VSTKeys.Header.Columns[2].Text := Caption_206;

    frmSettings.btnchange.Hint := frmMain.btnEdit.Hint;

    // transactions font color
    frmSettings.tabCreditFontColor.Caption := Caption_38;
    frmSettings.tabDebitFontColor.Caption := Caption_39;
    frmSettings.tabTransferPFontColor.Caption := Caption_40 + '(+)';
    frmSettings.tabTransferMFontColor.Caption := Caption_40 + '(-)';

    for I := 0 to frmMain.tooMenu.ControlCount - 1 do
      frmSettings.chkButtonsVisibility.Items[I] :=
        Field(sLineBreak, frmMain.tooMenu.Controls[I].Hint, 1);

    frmSettings.chkSelectAll.Caption := Hint_81;

    // panel TRANSACTIONS
    frmSettings.lblTransactionsColor.Caption := Caption_151;
    frmSettings.chkOpenNewTransaction.Caption := Caption_159;
    frmSettings.chkOpenNewTransaction.AutoSize := False;
    frmSettings.chkOpenNewTransaction.AutoSize := True;
    frmSettings.chkDisplayFontBold.Caption := Caption_299;
    frmSettings.chkDisplaySubCatCapital.Caption := Caption_300;
    frmSettings.chkEnableSelfTransfer.Caption := Caption_301;

    frmSettings.rbtCreditColorBlack.Caption := Caption_152;
    frmSettings.rbtCreditColorMixed.Caption := Caption_153;
    frmSettings.rbtCreditColorAll.Caption := Caption_154;

    frmSettings.rbtDebitColorBlack.Caption := Caption_152;
    frmSettings.rbtDebitColorMixed.Caption := Caption_153;
    frmSettings.rbtDebitColorAll.Caption := Caption_154;

    frmSettings.rbtTransfersPColorBlack.Caption := Caption_152;
    frmSettings.rbtTransfersPColorMixed.Caption := Caption_153;
    frmSettings.rbtTransfersPColorAll.Caption := Caption_154;

    frmSettings.rbtTransfersMColorBlack.Caption := Caption_152;
    frmSettings.rbtTransfersMColorMixed.Caption := Caption_153;
    frmSettings.rbtTransfersMColorAll.Caption := Caption_154;

    // Restrictions
    //frmSettings.gbxTransactionsRestrictions.Caption :=
    frmSettings.gbxTransactionsAdd.Caption := Caption_00;
    frmSettings.gbxTransactionsEdit.Caption := Caption_02;
    frmSettings.gbxTransactionsDelete.Caption := Caption_03;
    frmSettings.rbtTransactionsAddNo.Caption := Caption_306;
    frmSettings.rbtTransactionsEditNo.Caption := Caption_306;
    frmSettings.rbtTransactionsDeleteNo.Caption := Caption_306;
    frmSettings.rbtTransactionsAddDate.Caption := Caption_307;
    frmSettings.rbtTransactionsEditDate.Caption := Caption_307;
    frmSettings.rbtTransactionsDeleteDate.Caption := Caption_307;
    frmSettings.rbtTransactionsAddDays.Caption := Caption_307;
    frmSettings.rbtTransactionsEditDays.Caption := Caption_307;
    frmSettings.rbtTransactionsDeleteDays.Caption := Caption_307;
    frmSettings.lblTransactionsAddDays.Caption := AnsiLowerCase(Caption_308);
    frmSettings.lblTransactionsEditDays.Caption := Caption_308;
    frmSettings.lblTransactionsDeleteDays.Caption := Caption_308;
    frmSettings.chkRememberNewTransactionsForm.Caption := Caption_331;
    frmSettings.tabTransactionsGlobal.Caption := Caption_119;
    frmSettings.tabTransactionsRestrictions.Caption := Caption_305;

    // PNL SHORTCUTS
    P := frmSettings.VSTKeys.GetFirst();
    while Assigned(P) do
    begin
      Key := frmSettings.VSTKeys.GetNodeData(P);
      case P.Index of
        // record
        0: Key.Caption := AnsiLowerCase(Caption_271 + ': ' + Caption_00); // record-add
        1: Key.Caption := AnsiLowerCase(Caption_271 + ': ' + Caption_01); // record-add+
        2: Key.Caption := AnsiLowerCase(Caption_271 + ': ' + Caption_02); // record-edit
        3: Key.Caption := AnsiLowerCase(Caption_271 + ': ' + Caption_10);
        // record-duplicate
        4: Key.Caption := AnsiLowerCase(Caption_271 + ': ' + Caption_03);
        // record-delete
        5: Key.Caption := AnsiLowerCase(Caption_271 + ': ' + Caption_07);
        // record-copy all
        6: Key.Caption := AnsiLowerCase(Caption_271 + ': ' + Caption_29);
        // record-copy selected
        7: Key.Caption := AnsiLowerCase(Caption_271 + ': ' + Caption_12);
        // record-select
        8: Key.Caption := AnsiLowerCase(Caption_271 + ': ' + Caption_09);
        // record-print all
        9: Key.Caption := AnsiLowerCase(Caption_271 + ': ' + Caption_30);
        // record-print selected
        10: Key.Caption := AnsiLowerCase(Caption_271 + ': ' + Caption_67);
        // record-history
        11: Key.Caption := AnsiLowerCase(Caption_271 + ': ' + Caption_04); // record-save
        12: Key.Caption := AnsiLowerCase(Caption_271 + ': ' + Caption_33); // record-swap

        // menu
        13: Key.Caption := AnsiLowerCase(Menu_XX + '-' +
            AnsiReplaceStr(Menu_00 + ': ' + Menu_01, '&', '')); // db new
        14: Key.Caption := AnsiLowerCase(Menu_XX + '-' +
            AnsiReplaceStr(Menu_00 + ': ' + Menu_02, '&', '')); // db open
        15: Key.Caption := AnsiLowerCase(Menu_XX + '-' +
            AnsiReplaceStr(Menu_00 + ': ' + Menu_03, '&', '')); // db close
        16: Key.Caption := AnsiLowerCase(Menu_XX + '-' +
            AnsiReplaceStr(Menu_00 + ': ' + Menu_04, '&', '')); // db import
        17: Key.Caption := AnsiLowerCase(Menu_XX + '-' +
            AnsiReplaceStr(Menu_00 + ': ' + Menu_05, '&', '')); // db import
        18: Key.Caption := AnsiLowerCase(Menu_XX + '-' +
            AnsiReplaceStr(Menu_00 + ': ' + Menu_06, '&', '')); // db password
        19: Key.Caption := AnsiLowerCase(Menu_XX + '-' +
            AnsiReplaceStr(Menu_00 + ': ' + Menu_10, '&', '')); // db properties
        20: Key.Caption := AnsiLowerCase(Menu_XX + '-' +
            AnsiReplaceStr(Menu_00 + ': ' + Menu_08, '&', '')); // db sql
        21: Key.Caption := AnsiLowerCase(Menu_XX + '-' +
            AnsiReplaceStr(Menu_00 + ': ' + Menu_09, '&', '')); // db trash
        22: Key.Caption := AnsiLowerCase(Menu_XX + '-' +
            AnsiReplaceStr(Menu_00 + ': ' + Menu_07, '&', '')); // db quide

        // lists
        23: Key.Caption := AnsiLowerCase(Menu_XX + '-' +
            AnsiReplaceStr(Menu_20 + ': ' + Menu_30, '&', '')); // external links
        24: Key.Caption := AnsiLowerCase(Menu_XX + '-' +
            AnsiReplaceStr(Menu_20 + ': ' + Menu_21, '&', '')); // list holidays
        25: Key.Caption := AnsiLowerCase(Menu_XX + '-' +
            AnsiReplaceStr(Menu_20 + ': ' + Menu_22, '&', '')); // list tags
        26: Key.Caption := AnsiLowerCase(Menu_XX + '-' +
            AnsiReplaceStr(Menu_20 + ': ' + Menu_23, '&', '')); // list currencies
        27: Key.Caption := AnsiLowerCase(Menu_XX + '-' +
            AnsiReplaceStr(Menu_20 + ': ' + Menu_24, '&', '')); // list payees
        28: Key.Caption := AnsiLowerCase(Menu_XX + '-' +
            AnsiReplaceStr(Menu_20 + ': ' + Menu_25, '&', '')); // list comments
        29: Key.Caption := AnsiLowerCase(Menu_XX + '-' +
            AnsiReplaceStr(Menu_20 + ': ' + Menu_26, '&', '')); // list accounts
        30: Key.Caption := AnsiLowerCase(Menu_XX + '-' +
            AnsiReplaceStr(Menu_20 + ': ' + Menu_27, '&', '')); // list categories
        31: Key.Caption := AnsiLowerCase(Menu_XX + '-' +
            AnsiReplaceStr(Menu_20 + ': ' + Menu_28, '&', '')); // list persons

        // tools
        32: Key.Caption := AnsiLowerCase(Menu_XX + '-' +
            AnsiReplaceStr(Menu_40 + ': ' + Menu_41, '&', '')); // tools scheduler
        33: Key.Caption := AnsiLowerCase(Menu_XX + '-' +
            AnsiReplaceStr(Menu_40 + ': ' + Menu_42, '&', '')); // tools write
        34: Key.Caption := AnsiLowerCase(Menu_XX + '-' +
            AnsiReplaceStr(Menu_40 + ': ' + Menu_43, '&', '')); // tools calendar
        35: Key.Caption := AnsiLowerCase(Menu_XX + '-' +
            AnsiReplaceStr(Menu_40 + ': ' + Menu_44, '&', '')); // tools budget
        36: Key.Caption := AnsiLowerCase(Menu_XX + '-' +
            AnsiReplaceStr(Menu_40 + ': ' + Menu_45, '&', '')); // tools report
        37: Key.Caption := AnsiLowerCase(Menu_XX + '-' +
            AnsiReplaceStr(Menu_40 + ': ' + Menu_46, '&', '')); // tools counter
        38: Key.Caption := AnsiLowerCase(Menu_XX + '-' +
            AnsiReplaceStr(Menu_40 + ': ' + Menu_47, '&', '')); // tools calc

        // program
        39: Key.Caption := AnsiLowerCase(Menu_XX + '-' +
            AnsiReplaceStr(Menu_60 + ': ' + Menu_61, '&', '')); // program settings
        40: Key.Caption := AnsiLowerCase(Menu_XX + '-' +
            AnsiReplaceStr(Menu_60 + ': ' + Menu_64, '&', '')); // check updates
        41: Key.Caption := AnsiLowerCase(Menu_XX + '-' +
            AnsiReplaceStr(Menu_60 + ': ' + Menu_62, '&', '')); // program about

        // filter
        42: Key.Caption := AnsiLowerCase(Menu_F1); // clear filter
        43: Key.Caption := AnsiLowerCase(Menu_F2); // expand filter
        44: Key.Caption := AnsiLowerCase(Menu_F3); // collapse filter

        // new transaction
        45: Key.Caption := AnsiLowerCase(Caption_45 + ': ' + Caption_319);
        // clear filter
        46: Key.Caption := AnsiLowerCase(Caption_45 + ': ' + Caption_320);
        // clear filter

      end;
      P := frmSettings.VSTKeys.GetNext(P);
    end;
    frmSettings.VSTKeys.Repaint;

    // PNL REPORTS - LISTS --------------------------------------------------------------------
    frmSettings.chkPrintSummarySeparately.Caption := Caption_288;
    frmSettings.lblReportFont.Caption := Caption_155;
    frmSettings.lblReportFontSample1.Caption := Caption_137;
    frmSettings.lblReportFontSample.Caption := Caption_156;
    frmSettings.lblListReports.Caption := Caption_245;
    frmSettings.btnEditTemplate.Caption := Caption_02;

    // PNL REPORTS - CHARTS -------------------------------------------------------------------
    frmSettings.pnlCharts.Caption := Chart_01;
    frmSettings.chkChartShowLegend.Caption := Chart_03;
    frmSettings.gbxChartBottomAxisLabels.Caption := Chart_04;
    frmSettings.chkChartRotateLabels.Caption := Chart_05;
    frmSettings.lblChartRotateDegree.Caption := Chart_06;
    frmSettings.chkChartZeroBalance.Caption := Chart_07;
    frmSettings.chkChartWrapLabelsText.Caption := Chart_10;
    frmSettings.gbxCharts.Caption := Chart_11;

    // PNLTOOLS -------------------------------------------------------------------------------
    // tab Scheduler
    frmSettings.tabScheduler.Caption := Menu_41;
    frmSettings.lblScheduler1.Caption := Caption_216;
    frmSettings.chkSaturday.Caption :=
      AnsiLowerCase(DefaultFormatSettings.LongDayNames[DayOfWeek(
      EncodeDate(2022, 8, 6))]);
    frmSettings.chkSunday.Caption :=
      AnsiLowerCase(DefaultFormatSettings.LongDayNames[DayOfWeek(
      EncodeDate(2022, 8, 7))]);
    frmSettings.chkHoliday.Caption := Caption_222;
    frmSettings.lblScheduler2.Caption := Caption_217;
    frmSettings.rbtBefore.Caption := Caption_218;
    frmSettings.rbtAfter.Caption := Caption_219;
    frmSettings.lblScheduler3.Caption := Caption_220;
    frmSettings.lblScheduler4.Caption := Caption_221;

    // tab Payments
    frmSettings.tabPayments.Caption := Caption_11;
    frmSettings.chkPaymentSeparately.Caption := Caption_280;
    frmSettings.lblPayments1.Caption := Caption_281;
    frmSettings.lblPayments2.Caption := Caption_282;

    // tab Budgets
    frmSettings.tabBudgets.Caption := Caption_233;
    frmSettings.chkShowDifference.Caption := Caption_236;
    frmSettings.chkShowIndex.Caption := Caption_237;

    // PNLBACKUP ------------------------------------------------------------------------------
    frmSettings.gbxBackup.Caption := Caption_118;
    frmSettings.chkDoBackup.Caption := Caption_223;
    frmSettings.gbxBackupFolder.Caption := Caption_284;
    frmSettings.gbxBackupCount.Caption := Caption_225;
    frmSettings.chkBackupMessage.Caption := Caption_226;
    frmSettings.chkBackupQuestion.Caption := Caption_324;

    // PNL ONCLOSEDATABASE --------------------------------------------------------------------
    frmSettings.chkCloseDbWarning.Caption := Caption_244;
    frmSettings.chkEncryptDatabase.Caption := Caption_325;

    // =============================================================================================
    // FRMSHORTCUT FORMS
    // =============================================================================================
    frmShortCut.Caption := Caption_202;
    frmShortCut.lblAction1.Caption := Caption_204;
    frmShortCut.lblTip.Caption := Caption_276;
    frmShortCut.lblShortcutOld1.Caption := Caption_277;
    frmShortCut.lblShortcutNew.Caption := Caption_203;

    frmShortCut.btnSave.Caption := Caption_04;
    frmShortCut.btnSave.Hint := frmDetail.btnSave.Hint;

    // =============================================================================================
    // FRMSQL FORMS
    // =============================================================================================
    frmSQL.Caption := UTF8UpperCase(AnsiReplaceStr(frmMain.mnuSQL.Caption, '&', ''));
    frmSQL.pnlCaption.Caption := Caption_174;
    frmSQL.pnlCaption1.Caption := Message_00;
    frmSQL.pnlCaption2.Caption := Caption_175;
    frmSQL.lblCommand.Caption := Caption_176;
    frmSQL.rbtMaster.Caption := Caption_177;
    frmSQL.rbtData.Caption := Caption_178;
    frmSQL.rbtVacuum.Caption := Caption_179;
    frmSQL.rbtOwn.Caption := Caption_180;

    frmSQL.btnExecute.Caption := Caption_106;
    frmSQL.btnExecute.Hint := Format(Hint_21, [sLineBreak]);
    frmSQL.btnExit.Caption := AnsiReplaceStr(Menu_63, '&', ''); // Exit
    frmSQL.btnExit.Hint := frmMain.btnReportExit.Hint;
    frmSQL.btnDiagram.Caption := Caption_322;
    frmSQL.btnDiagram.Hint := Caption_177;

    // =============================================================================================
    // FRMIMAGE FORMS
    // =============================================================================================
    frmImage.Caption := UTF8UpperCase(Caption_322);
    frmImage.btnExit.Caption := AnsiReplaceStr(Menu_63, '&', ''); // Exit
    frmImage.btnExit.Hint := frmMain.btnReportExit.Hint;
    frmImage.btnCopy.Caption := Caption_272;
    frmImage.btnCopy.Hint := frmMain.btnCopy.Hint;
    frmImage.lblApricotDB.Caption := Caption_323;

    // =============================================================================================
    // FRMSQLRESULT FORM
    // =============================================================================================
    frmSQLResult.Caption := Caption_173;

    frmSQLResult.pnlCaption.Caption := AnsiUpperCase(Caption_44);
    frmSQLResult.btnCopy.Caption := Caption_272;
    frmSQLResult.btnCopy.Hint := frmMain.btnCopy.Hint;
    frmSQLResult.btnExit.Caption := AnsiReplaceStr(Menu_63, '&', ''); // Exit
    frmSQLResult.btnExit.Hint := frmMain.btnReportExit.Hint;
    frmSQLResult.btnSelect.Caption := Caption_273;
    frmSQLResult.btnSelect.Hint := frmMain.btnSelect.Hint;

    // =============================================================================================
    // FRMFILTER FORM
    // =============================================================================================
    frmFilter.btnApplyFilter.Caption := Menu_F8;

    // =============================================================================================
    // FRMGATE FORM
    // =============================================================================================

    frmGate.btnOK.Caption := Caption_107;
    frmGate.pnlCaption.Caption := Caption_113;
    frmGate.lblFileName1.Caption := Caption_114;
    frmGate.lblGate.Caption := Format(Caption_115, [sLineBreak]);
    frmGate.btnBack.Caption := Caption_116;

    // =============================================================================================
    // FRMImport FORM
    // =============================================================================================
    frmImport.Caption := Caption_182;
    frmImport.pnlImportCaption.Caption := Caption_183;
    frmImport.btnFile.Hint := AnsiLowerCase(Caption_183);
    frmImport.btnImport.Caption := AnsiReplaceStr(Menu_04, '&', '');
    frmImport.btnExit.Caption := AnsiReplaceStr(Menu_63, '&', '');
    frmImport.btnExit.Hint := frmMain.btnReportExit.Hint;

    frmImport.lblFileName1.Caption := Caption_96 + ':';

    // =============================================================================================
    // FRMSUCCESS FORM
    // =============================================================================================
    frmSuccess.Caption := Caption_189;
    frmSuccess.pnlSuccessCaption.Caption := Caption_190;
    frmSuccess.lblChoice.Caption := Caption_191;
    frmSuccess.lblPassword.Caption := Caption_192;
    frmSuccess.btnPassword.Caption := Caption_193;
    frmSuccess.lblGuide.Caption := Caption_194;
    frmSuccess.btnGuide.Caption := Caption_195;
    frmSuccess.lblImport.Caption := Caption_196;
    frmSuccess.btnImport.Caption := Caption_197;
    frmSuccess.lblCancel.Caption := Caption_198;
    frmSuccess.btnCancel.Caption := Caption_199;

    // =============================================================================================
    // FRMBUDGETS FORM
    // =============================================================================================
    frmBudgets.Caption := AnsiUpperCase(AnsiReplaceStr(Caption_233, '&', ''));
    frmBudgets.tabBudgets.Caption := AnsiUpperCase(AnsiReplaceStr(Menu_44, '&', ''));
    frmBudgets.tabPeriods.Caption := AnsiUpperCase(Caption_234);
    frmBudgets.pnlCategoriesCaption.Caption :=
      AnsiUpperCase(AnsiReplaceStr(Menu_27, '&', '')) + ' & ' +
      AnsiUpperCase(Caption_234);
    frmBudgets.tabLegend.Caption := AnsiUpperCase(Menu_B01);

    // update menu Budget
    frmBudgets.btnBudgetAdd.Caption := Caption_00;
    frmBudgets.btnBudgetEdit.Caption := Caption_02;
    frmBudgets.btnBudgetDelete.Caption := Caption_03;
    frmBudgets.btnBudgetDuplicate.Caption := Caption_10;

    frmBudgets.btnExit.Caption := AnsiReplaceStr(Menu_63, '&', '');
    frmBudgets.btnSettings.Caption := AnsiReplaceStr(Menu_61, '&', '');
    frmBudgets.btnCopy.Caption := Caption_272;
    frmBudgets.btnCopy.Hint := frmMain.btnCopy.Hint;

    // update menu Periods
    frmBudgets.btnPeriodAdd.Caption := Caption_00;
    frmBudgets.btnPeriodEdit.Caption := Caption_02;
    frmBudgets.btnPeriodDelete.Caption := Caption_03;
    frmBudgets.btnPeriodDuplicate.Caption := Caption_10;

    // update hint of budget buttons
    frmBudgets.btnBudgetAdd.Hint := frmDetail.btnAdd.Hint;
    frmBudgets.btnBudgetEdit.Hint := frmMain.btnEdit.Hint;
    frmBudgets.btnBudgetDelete.Hint := frmMain.btnDelete.Hint;
    frmBudgets.btnBudgetDuplicate.Hint := frmMain.btnDuplicate.Hint;
    frmBudgets.btnExit.Hint := frmMain.btnReportExit.Hint;
    frmBudgets.btnSettings.Hint := frmMain.btnSettings.Hint;

    // update hint of period buttons
    frmBudgets.btnPeriodAdd.Hint := frmDetail.btnAdd.Hint;
    frmBudgets.btnPeriodEdit.Hint := frmMain.btnEdit.Hint;
    frmBudgets.btnPeriodDelete.Hint := frmMain.btnDelete.Hint;
    frmBudgets.btnPeriodDuplicate.Hint := frmMain.btnCopy.Hint;

    // update Budgets pop menu items
    frmBudgets.popBudgetAdd.Caption := Caption_00;
    frmBudgets.popBudgetEdit.Caption := Caption_02;
    frmBudgets.popBudgetDelete.Caption := Caption_03;
    frmBudgets.popBudgetDuplicate.Caption := Caption_10;

    // update Periods pop menu items
    frmBudgets.popPeriodAdd.Caption := Caption_00;
    frmBudgets.popPeriodEdit.Caption := Caption_02;
    frmBudgets.popPeriodDelete.Caption := Caption_03;
    frmBudgets.popPeriodDuplicate.Caption := Caption_10;

    // VSTBudgets
    frmBudgets.VSTBudgets.Header.Columns[1].Text := Caption_49; // name
    frmBudgets.VSTBudgets.Header.Columns[3].Text := Caption_53; // ID


    // VSTCategory
    frmBudgets.VSTBudCat.Header.Columns[1].Text := AnsiReplaceStr(Caption_54, '&', ''); // category
    frmBudgets.VSTBudCat.Header.Columns[2].Text := Caption_80; // subcategory
    frmBudgets.VSTBudCat.Header.Columns[3].Text := Caption_53; // ID

    frmBudgets.VSTPeriods.Header.Columns[1].Text := Caption_69; // date from
    frmBudgets.VSTPeriods.Header.Columns[2].Text := Caption_70; // date to

    // Legend
    frmBudgets.lblPlan.Caption := Caption_228;
    frmBudgets.lblReality.Caption := Caption_229;
    frmBudgets.lblDifference.Caption := Caption_231;
    frmBudgets.lblIndex.Caption := Caption_230;

    // =============================================================================================
    // FRMBUDGET FORM
    // =============================================================================================
    frmBudget.Caption := AnsiUpperCase(AnsiReplaceStr(Menu_44, '&', ''));
    frmBudget.pnlNameCaption.Caption := AnsiUpperCase(Caption_49); // name
    frmBudget.pnlCategoriesCaption.Caption :=
      AnsiUpperCase(AnsiReplaceStr(Menu_27, '&', ''));

    // header columns captions
    frmBudget.VST.Header.Columns[0].Text := AnsiReplaceStr(Caption_54, '&', ''); // category
    frmBudget.VST.Header.Columns[1].Text := Caption_80; // Subcategory
    frmBudget.VST.Header.Columns[2].Text := Caption_53; // ID

    frmBudget.btnSave.Caption := Caption_04;
    frmBudget.btnCancel.Caption := Caption_05;
    frmBudget.btnCategories.Caption := AnsiReplaceStr(Menu_27, '&', '');
    frmBudget.btnCategories.Hint := frmMain.btnCategories.Hint;

    frmBudget.btnSave.Hint := frmDetail.btnSave.Hint;
    frmBudget.btnCancel.Hint := frmDetail.btnCancel.Hint;

    // hint
    frmBudget.lblHint1.Caption := Hint_60;
    frmBudget.lblHint2.Caption := Hint_61;

    // radiobuttons
    frmBudget.rbtCategories.Caption := AnsiReplaceStr(Menu_27, '&', '');
    frmBudget.rbtSubcategories.Caption := Menu_29;
    frmBudget.pnlTypeCaption.Caption := AnsiUpperCase(Caption_235);

    // =============================================================================================
    // FRMPERIOD FORM
    // =============================================================================================
    frmPeriod.pnlPeriodCaption.Caption := AnsiUpperCase(Caption_28);
    frmPeriod.pnlBudgetCaption.Caption :=
      AnsiUpperCase(AnsiReplaceStr(Menu_44, '&', ''));

    // header columns captions
    frmPeriod.VST.Header.Columns[1].Text := AnsiReplaceStr(Caption_54, '&', ''); // category
    frmPeriod.VST.Header.Columns[2].Text := Caption_80; // subcategory
    frmPeriod.VST.Header.Columns[3].Text := Caption_232; // planned amount
    frmPeriod.VST.Header.Columns[4].Text := Caption_53; // ID

    frmPeriod.btnSave.Caption := Caption_04;
    frmPeriod.btnCancel.Caption := Caption_05;
    frmPeriod.btnEdit.Caption := Caption_02;

    frmPeriod.btnSave.Hint := frmDetail.btnSave.Hint;
    frmPeriod.btnCancel.Hint := frmDetail.btnCancel.Hint;
    frmPeriod.btnEdit.Hint := frmMain.btnEdit.Hint;

    // labels
    frmPeriod.lblFromDate.Caption := Caption_69; // date from
    frmPeriod.lblToDate.Caption := Caption_70; // date to

    // =============================================================================================
    // FRMPLAN FORM
    // =============================================================================================
    frmPlan.Caption := AnsiUpperCase(Caption_228);

    // buttons
    frmPlan.btnSave.Caption := Caption_04;
    frmPlan.btnCancel.Caption := Caption_05;
    frmPlan.btnSave.Hint := frmDetail.btnSave.Hint;
    frmPlan.btnCancel.Hint := frmDetail.btnCancel.Hint;

    // labels
    frmPlan.lblDate1.Caption := Caption_28;
    frmPlan.lblPlan.Caption := Caption_232 + ':';
    frmPlan.lblNote.Caption := AnsiReplaceStr(Caption_286, '% ', sLineBreak);

    // =============================================================================================
    // FRMTEMPLATES FORM
    // =============================================================================================
    frmTemplates.Caption := AnsiUpperCase(Caption_253);
    frmTemplates.pnlTopCaption.Caption := AnsiUpperCase(Caption_259);
    frmTemplates.pnlBottomCaption.Caption := Caption_260;

    frmTemplates.btnImport.Caption := AnsiReplaceStr(Menu_04, '&', '');
    frmTemplates.btnExit.Caption := AnsiReplaceStr(Menu_63, '&', '');
    frmTemplates.btnExit.Hint := frmMain.btnReportExit.Hint;

    frmTemplates.btnSave.Caption := Caption_04;
    frmTemplates.btnSave.Hint := frmDetail.btnSave.Hint;
    frmTemplates.lblTemplates.Caption := Caption_251;
    frmTemplates.btnAdd.Caption := Caption_00;
    frmTemplates.btnAdd.Hint := frmDetail.btnAdd.Hint;
    frmTemplates.btnEdit.Caption := Caption_02;
    frmTemplates.btnEdit.Hint := frmMain.btnEdit.Hint;
    frmTemplates.btnDelete.Caption := Caption_03;
    frmTemplates.btnDelete.Hint := frmMain.btnDelete.Hint;
    frmTemplates.btnCancel.Caption := Caption_05;
    frmTemplates.btnCancel.Hint := frmDetail.btnCancel.Hint;

    frmTemplates.pnlSettingsCaption.Caption :=
      AnsiUpperCase(AnsiReplaceStr(Menu_61, '&', ''));

    frmTemplates.pnlOriginCaption.Caption := '  ' + Caption_259;
    frmTemplates.gbxImport.Caption := Caption_254;
    frmTemplates.lblStartLine.Caption := Caption_255;
    frmTemplates.lblEndLine.Caption := Caption_256;
    frmTemplates.lblSeparator.Caption := Caption_257;
    frmTemplates.chkQuotes.Caption := Caption_258;
    frmTemplates.lblName.Caption := Caption_252;

    frmTemplates.pnlDateCaption.Caption := '  ' + Caption_26;
    frmTemplates.lblFormat.Caption := Caption_138;
    frmTemplates.lblDateColumn.Caption := Caption_262;
    frmTemplates.gbxDateTest.Caption := Caption_263;

    frmTemplates.pnlAmountCaption.Caption := '  ' + Caption_42;
    frmTemplates.lblAmountColumn.Caption := Caption_262;
    frmTemplates.lblThousand.Caption := Caption_135;
    frmTemplates.lblDecimal.Caption := Caption_136;
    frmTemplates.gbxAmountTest.Caption := Caption_263;

    frmTemplates.pnlTypeCaption.Caption := '  ' + Caption_63;
    frmTemplates.rbtTypeColumn.Caption := Caption_262;
    frmTemplates.rbtTypeSymbol.Caption := Caption_264;
    frmTemplates.lblCredit.Caption := Caption_265;
    frmTemplates.lblDebit.Caption := Caption_266;

    frmTemplates.pnlCommentCaption.Caption := '  ' + Caption_56;
    frmTemplates.rbtCommentColumn.Caption := Caption_262;
    frmTemplates.rbtCommentManually.Caption := Caption_267;
    frmTemplates.rbtCommentAuto.Caption := Caption_268;

    frmTemplates.pnlCategoryCaption.Caption :=
      '  ' + AnsiReplaceStr(Caption_54, '&', '') + ' / ' + Caption_80;
    frmTemplates.rbtCategoryManually.Caption := Caption_267;
    frmTemplates.rbtCategoryAuto.Caption := Caption_268;

    frmTemplates.pnlPersonCaption.Caption := '  ' + Caption_58;
    frmTemplates.rbtPersonManually.Caption := Caption_267;
    frmTemplates.rbtPersonAuto.Caption := Caption_268;

    frmTemplates.pnlPayeeCaption.Caption := '  ' + Caption_60;
    frmTemplates.rbtPayeeManually.Caption := Caption_267;
    frmTemplates.rbtPayeeAuto.Caption := Caption_268;

    frmTemplates.pnlAccountCaption.Caption := '  ' + Caption_50;
    frmTemplates.rbtAccountManually.Caption := Caption_267;
    frmTemplates.rbtAccountAuto.Caption := Caption_268;

    // popup
    frmTemplates.popExpand.Caption := Menu_T1;
    frmTemplates.popCollapse.Caption := Menu_T2;

    // =============================================================================================
    // FRMLINKS FORM
    // =============================================================================================
    frmLinks.Caption := AnsiUpperCase(AnsiReplaceStr(Menu_30, '&', ''));
    frmLinks.pnlDetailCaption.Caption := AnsiUpperCase(Caption_43);
    frmLinks.pnlListCaption.Caption := AnsiUpperCase(Caption_44);

    // update menu items
    frmLinks.btnAdd.Caption := Caption_00;
    frmLinks.btnEdit.Caption := Caption_02;
    frmLinks.btnDelete.Caption := Caption_03;
    frmLinks.btnExit.Caption := AnsiReplaceStr(Menu_63, '&', '');
    frmLinks.btnSave.Caption := Caption_04;
    frmLinks.btnCancel.Caption := Caption_05;
    frmLinks.btnCopy.Caption := Caption_272;
    frmLinks.btnPrint.Caption := Caption_68;
    frmLinks.btnSelect.Caption := Caption_12;

    // update hint of all menu
    frmLinks.btnAdd.Hint := frmDetail.btnAdd.Hint;
    frmLinks.btnEdit.Hint := frmMain.btnEdit.Hint;
    frmLinks.btnDelete.Hint := frmMain.btnDelete.Hint;
    frmLinks.btnSave.Hint := frmDetail.btnSave.Hint;
    frmLinks.btnCancel.Hint := frmDetail.btnCancel.Hint;
    frmLinks.btnExit.Hint := frmMain.btnReportExit.Hint;
    frmLinks.btnCopy.Hint := frmMain.btnCopy.Hint;
    frmLinks.btnSelect.Hint := frmMain.btnSelect.Hint;
    frmLinks.btnPrint.Hint := frmMain.btnReportPrint.Hint;

    // update pop menu items
    frmLinks.popAdd.Caption := Caption_00;
    frmLinks.popEdit.Caption := Caption_02;
    frmLinks.popDelete.Caption := Caption_03;
    frmLinks.popCopy.Caption := Caption_272;
    frmLinks.popExit.Caption := Menu_63;
    frmLinks.popPrint.Caption := Caption_68;
    frmLinks.popSelect.Caption := Caption_12;

    // VST columns caption
    frmLinks.VST.Header.Columns[1].Text := Caption_49; // name
    frmLinks.VST.Header.Columns[2].Text := Caption_285; // external link
    frmLinks.VST.Header.Columns[3].Text := Caption_206; // shortcut
    frmLinks.VST.Header.Columns[4].Text := Caption_56; // comment
    frmLinks.VST.Header.Columns[5].Text := Caption_53; // ID

    frmLinks.lblName.Caption := Caption_49;
    frmLinks.lblLink.Caption := Caption_285;
    frmLinks.lblComment.Caption := Caption_56;
    frmLinks.lblShortcut.Caption := Caption_206;

  except
    on E: Exception do
      ShowErrorMessage(E);
  end;
end;

end.
