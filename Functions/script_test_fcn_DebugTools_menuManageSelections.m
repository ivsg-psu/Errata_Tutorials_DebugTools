

% Fill in test data
numQuestions = 0; % Initialize the number of questions
selections = struct(); % Create an empty structure array for selections
selections(1).AssignmentString = 'Week01_Quiz01';

numQuestions = numQuestions+1;
selections(numQuestions).MenuChar = '1';
selections(numQuestions).Name = 'WhatNumber';
selections(numQuestions).Text = ') What is folder number sent to you?';
selections(numQuestions).AnswerDefault = '-missing-';
selections(numQuestions).AnswerType = '1column_of_integers';
selections(numQuestions).AnswerConversionFunction = 'str2double';
selections(numQuestions).AnswerTypeOptions = [1 1];
selections(numQuestions).AnswerPrintFormat = '%.0f';
selections(numQuestions).FunctionMore = 'why';
selections(numQuestions).FunctionMoreInputs = {30};
selections(numQuestions).FunctionSubmission = '[answers, numBadOptionInputs, flag_exitMain] = fcn_INTERNAL_enterData(answers, selections, selectedOptionCharacters, numBadOptionInputs)';
selections(numQuestions).FunctionSubmissionOptions = {'.'};
selections(numQuestions).isAllowableMenuOption = true;

numQuestions = numQuestions+1;
selections(numQuestions).MenuChar = '2';
selections(numQuestions).Name = 'WhatName';
selections(numQuestions).Text = ') What is your name?';
selections(numQuestions).AnswerDefault = '-missing-';
selections(numQuestions).AnswerType = '_of_char_strings';
selections(numQuestions).AnswerConversionFunction = '';
selections(numQuestions).AnswerTypeOptions = [];
selections(numQuestions).AnswerPrintFormat = '%s';
selections(numQuestions).FunctionMore = 'why';
selections(numQuestions).FunctionMoreInputs = {30};
selections(numQuestions).FunctionSubmission = '[answers, numBadOptionInputs, flag_exitMain] = fcn_INTERNAL_enterData(answers, selections, selectedOptionCharacters, numBadOptionInputs)';
selections(numQuestions).FunctionSubmissionOptions = {'.'};
selections(numQuestions).isAllowableMenuOption = true;

numQuestions = numQuestions+1;
selections(numQuestions).MenuChar = '3';
selections(numQuestions).Name = 'WhatQuest';
selections(numQuestions).Text = ') What is your quest?';
selections(numQuestions).AnswerDefault = '-missing-';
selections(numQuestions).AnswerType = '_of_char_strings';
selections(numQuestions).AnswerConversionFunction = '';
selections(numQuestions).AnswerTypeOptions = [];
selections(numQuestions).AnswerPrintFormat = '%s';
selections(numQuestions).FunctionMore = 'why';
selections(numQuestions).FunctionMoreInputs = {30};
selections(numQuestions).FunctionSubmission = '[answers, numBadOptionInputs, flag_exitMain] = fcn_INTERNAL_enterData(answers, selections, selectedOptionCharacters, numBadOptionInputs)';
selections(numQuestions).FunctionSubmissionOptions = {'.'};
selections(numQuestions).isAllowableMenuOption = true;

numQuestions = numQuestions+1;
selections(numQuestions).MenuChar = '4';
selections(numQuestions).Name = 'WhatNumber';
selections(numQuestions).Text = ') What is your favorite integer?';
selections(numQuestions).AnswerDefault = '-missing-';
selections(numQuestions).AnswerType = '1column_of_integers';
selections(numQuestions).AnswerConversionFunction = 'str2double';
selections(numQuestions).AnswerTypeOptions = [1 1];
selections(numQuestions).AnswerPrintFormat = '%.0f';
selections(numQuestions).FunctionMore = '';
selections(numQuestions).FunctionMoreInputs = [];
selections(numQuestions).FunctionSubmission = '[answers, numBadOptionInputs, flag_exitMain] = fcn_INTERNAL_enterData(answers, selections, selectedOptionCharacters, numBadOptionInputs)';
selections(numQuestions).FunctionSubmissionOptions = {'.'};
selections(numQuestions).isAllowableMenuOption = true;

numQuestions = numQuestions+1;
selections(numQuestions).MenuChar = 's';
selections(numQuestions).Name = 'Submit';
selections(numQuestions).Text = '(S)ubmit this assignment.';
selections(numQuestions).AnswerDefault = '-unsubmitted-';
selections(numQuestions).AnswerType = '1column_of_integers';
selections(numQuestions).AnswerConversionFunction = 'str2double';
selections(numQuestions).AnswerTypeOptions = [1 1];
selections(numQuestions).AnswerPrintFormat = '%.0f';
selections(numQuestions).FunctionMore = '';
selections(numQuestions).FunctionMoreInputs = [];
selections(numQuestions).FunctionSubmission = 'answers = fcn_INTERNAL_prepDataForSave(answers)';
selections(numQuestions).FunctionSubmissionOptions = {'.'};
selections(numQuestions).isAllowableMenuOption = true;

numQuestions = numQuestions+1;
selections(numQuestions).MenuChar = 'q';
selections(numQuestions).Name = 'Quit';
selections(numQuestions).Text = '(Q)uit this menu.';
selections(numQuestions).AnswerDefault = ' ';
selections(numQuestions).AnswerType = '1column_of_integers';
selections(numQuestions).AnswerConversionFunction = 'str2double';
selections(numQuestions).AnswerTypeOptions = [1 1];
selections(numQuestions).AnswerPrintFormat = '%.0f';
selections(numQuestions).FunctionMore = '';
selections(numQuestions).FunctionMoreInputs = [];
selections(numQuestions).FunctionSubmission = 'flag_exitMain = 1; fprintf(1,''Quitting\\n'');';
selections(numQuestions).FunctionSubmissionOptions = {'.'};
selections(numQuestions).isAllowableMenuOption = true;

% Enter menu loop
fcn_DebugTools_menuManageSelections(selections, (1))




%% Quiz type release
% script_Week01_Quiz01.m
% Assignment for: Week01
% Quiz: 01
% Written by: sbrennan@psu.edu
% 2026_08_24

% REVISION HISTORY:
%
% 2026_01_12 by Sean Brennan, sbrennan@psu.edu
% - First write of the code using the Laps repo as a starter
%
% 2026_01_14 by Sean Brennan, sbrennan@psu.edu
% - Added HW01 script
%
% 2026_01_19 by Sean Brennan, sbrennan@psu.edu
% - Finalized HW01 submission
%
% 2026_08_24 by Sean Brennan, sbrennan@psu.edu
% - Edited for Fall 2026 release
%
% (new release)


% TO-DO:
% - 2026_01_12 by Sean Brennan, sbrennan@psu.edu
%   % * (add help)



% Fill in test data
% Fill in test data
numQuestions = 0; % Initialize the number of questions
selections = struct(); % Create an empty structure array for selections
selections(1).AssignmentString = 'ExampleQuiz';

numQuestions = numQuestions+1;
selections(numQuestions).MenuChar = sprintf('%.0d',numQuestions);
selections(numQuestions).Name = 'CanvasNumber';
selections(numQuestions).Text = ') What is your Canvas number?';
selections(numQuestions).AnswerDefault = '-missing-';
selections(numQuestions).AnswerType = '1column_of_integers';
selections(numQuestions).AnswerConversionFunction = 'str2double';
selections(numQuestions).AnswerTypeOptions = [1 1];
selections(numQuestions).AnswerPrintFormat = '%.0f';
selections(numQuestions).FunctionMore = 'why';
selections(numQuestions).FunctionMoreInputs = {30};
selections(numQuestions).FunctionSubmission = '[answers, numBadOptionInputs, flag_exitMain] = fcn_INTERNAL_enterData(answers, selections, selectedOptionCharacters, numBadOptionInputs)';
selections(numQuestions).FunctionSubmissionOptions = {'.'};
selections(numQuestions).isAllowableMenuOption = true;

selections(numQuestions).AnswerGradingCorrect = nan;
selections(numQuestions).AnswerGradingPoints = 0;
selections(numQuestions).AnswerGradingType = 'not empty';
selections(numQuestions).AnswerGradingOptions = {[]};



numQuestions = numQuestions+1;
selections(numQuestions).MenuChar = sprintf('%.0d',numQuestions);
selections(numQuestions).Name = 'WhatNumber';
selections(numQuestions).Text = ') What is 1+1?';
selections(numQuestions).AnswerDefault = '-missing-';
selections(numQuestions).AnswerType = '1column_of_integers';
selections(numQuestions).AnswerConversionFunction = 'str2double';
selections(numQuestions).AnswerTypeOptions = [1 1];
selections(numQuestions).AnswerPrintFormat = '%.0f';
selections(numQuestions).FunctionMore = 'why';
selections(numQuestions).FunctionMoreInputs = {30};
selections(numQuestions).FunctionSubmission = '[answers, numBadOptionInputs, flag_exitMain] = fcn_INTERNAL_enterData(answers, selections, selectedOptionCharacters, numBadOptionInputs)';
selections(numQuestions).FunctionSubmissionOptions = {'.'};
selections(numQuestions).isAllowableMenuOption = true;

selections(numQuestions).AnswerGradingCorrect = '2';
selections(numQuestions).AnswerGradingPoints = 1;
selections(numQuestions).AnswerGradingType = 'exact match';
selections(numQuestions).AnswerGradingOptions = {[]};


numQuestions = numQuestions+1;
selections(numQuestions).MenuChar = sprintf('%.0d',numQuestions);
selections(numQuestions).Name = 'WhatName';
selections(numQuestions).Text = ') What is the letter after "A"?';
selections(numQuestions).AnswerDefault = '-missing-';
selections(numQuestions).AnswerType = '_of_char_strings';
selections(numQuestions).AnswerConversionFunction = '';
selections(numQuestions).AnswerTypeOptions = [];
selections(numQuestions).AnswerPrintFormat = '%s';
selections(numQuestions).FunctionMore = 'why';
selections(numQuestions).FunctionMoreInputs = {30};
selections(numQuestions).FunctionSubmission = '[answers, numBadOptionInputs, flag_exitMain] = fcn_INTERNAL_enterData(answers, selections, selectedOptionCharacters, numBadOptionInputs)';
selections(numQuestions).FunctionSubmissionOptions = {'.'};
selections(numQuestions).isAllowableMenuOption = true;

selections(numQuestions).AnswerGradingCorrect = 'B';
selections(numQuestions).AnswerGradingPoints = 1;
selections(numQuestions).AnswerGradingType = 'exact match';
selections(numQuestions).AnswerGradingOptions = {[]};

numQuestions = numQuestions+1;
selections(numQuestions).MenuChar = '3';
selections(numQuestions).MenuChar = sprintf('%.0d',numQuestions);
selections(numQuestions).Text = ') What is your quest?';
selections(numQuestions).AnswerDefault = '-missing-';
selections(numQuestions).AnswerType = '_of_char_strings';
selections(numQuestions).AnswerConversionFunction = '';
selections(numQuestions).AnswerTypeOptions = [];
selections(numQuestions).AnswerPrintFormat = '%s';
selections(numQuestions).FunctionMore = 'why';
selections(numQuestions).FunctionMoreInputs = {30};
selections(numQuestions).FunctionSubmission = '[answers, numBadOptionInputs, flag_exitMain] = fcn_INTERNAL_enterData(answers, selections, selectedOptionCharacters, numBadOptionInputs)';
selections(numQuestions).FunctionSubmissionOptions = {'.'};
selections(numQuestions).isAllowableMenuOption = true;

selections(numQuestions).AnswerGradingCorrect = 'grail';
selections(numQuestions).AnswerGradingPoints = 1;
selections(numQuestions).AnswerGradingType = 'contains word';
selections(numQuestions).AnswerGradingOptions = {[]};

%%%

numQuestions = numQuestions+1;
selections(numQuestions).MenuChar = 'g';
selections(numQuestions).Name = 'Grade';
selections(numQuestions).Text = '(G)rade this assignment.';
selections(numQuestions).AnswerDefault = '-unsubmitted-';
selections(numQuestions).AnswerType = '1column_of_integers';
selections(numQuestions).AnswerConversionFunction = 'str2double';
selections(numQuestions).AnswerTypeOptions = [1 1];
selections(numQuestions).AnswerPrintFormat = '%s';
selections(numQuestions).FunctionMore = sprintf('fcn_help_Week01_HW01(%.0f)',numQuestions);
selections(numQuestions).FunctionMoreInputs = [];
selections(numQuestions).FunctionSubmission = { ...
    'overallScore = fcn_DebugTools_gradeAnswers(selections,answers);';
    'assignmentString = selections(1).AssignmentString;';
    'overallScoreString = sprintf(''%%.2f'',overallScore);';
    'studentNumberString = answers{1}; %%  Grab the student number - it is always the first answer';
    'resultString = cat(2,studentNumberString,overallScoreString);';
    'gradeHash = fcn_DebugTools_hashStrings(assignmentString, resultString, ([]));';
    'fcn_DebugTools_cprintf(''*Green'',''Grading completed.'');';
    'fprintf(1,''\\nThe assignment: \\t%%s\\nwas just graded.\\n'',assignmentString)';
    'fprintf(1,''Your score:\\t%%s\\n'',overallScoreString)';
    'fprintf(1,''As the final step, please enter the following code into Canvas for this assignment.\\n%%s\\n'',gradeHash);';
    'fprintf(1,''Press any key to continue\\n'');';
    'pause;';
    'answers{end-2} = ''GRADED'';';
    };
selections(numQuestions).FunctionSubmissionOptions = {'.'};
selections(numQuestions).isAllowableMenuOption = true;

numQuestions = numQuestions+1;
selections(numQuestions).MenuChar = 's';
selections(numQuestions).Name = 'Submit';
selections(numQuestions).Text = '(S)ubmit this assignment.';
selections(numQuestions).AnswerDefault = '-unsubmitted-';
selections(numQuestions).AnswerType = '1column_of_integers';
selections(numQuestions).AnswerConversionFunction = 'str2double';
selections(numQuestions).AnswerTypeOptions = [1 1];
selections(numQuestions).AnswerPrintFormat = '%.0f';
selections(numQuestions).FunctionMore = '';
selections(numQuestions).FunctionMoreInputs = [];
selections(numQuestions).FunctionSubmission = 'answers = fcn_INTERNAL_prepDataForSave(answers)';
selections(numQuestions).FunctionSubmissionOptions = {'.'};
selections(numQuestions).isAllowableMenuOption = true;

numQuestions = numQuestions+1;
selections(numQuestions).MenuChar = 'q';
selections(numQuestions).Name = 'Quit';
selections(numQuestions).Text = '(Q)uit this menu.';
selections(numQuestions).AnswerDefault = ' ';
selections(numQuestions).AnswerType = '1column_of_integers';
selections(numQuestions).AnswerConversionFunction = 'str2double';
selections(numQuestions).AnswerTypeOptions = [1 1];
selections(numQuestions).AnswerPrintFormat = '%.0f';
selections(numQuestions).FunctionMore = '';
selections(numQuestions).FunctionMoreInputs = [];
selections(numQuestions).FunctionSubmission = 'flag_exitMain = 1; fprintf(1,''Quitting\\n'');';
selections(numQuestions).FunctionSubmissionOptions = {'.'};
selections(numQuestions).isAllowableMenuOption = true;

% Enter menu loop
fcn_DebugTools_menuManageSelections(selections, (1))





