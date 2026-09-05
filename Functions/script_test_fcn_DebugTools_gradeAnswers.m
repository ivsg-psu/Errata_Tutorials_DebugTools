% script_test_fcn_DebugTools_gradeAnswers

% REVISION HISTORY:
%
% 2026_01_12 by Sean Brennan, sbrennan@psu.edu
% - In script_test_fcn_DebugTools_gradeAnswers
%   % * First write of the code
%
% 2026_01_18 by Sean Brennan, sbrennan@psu.edu
% - In script_test_fcn_DebugTools_gradeAnswers
%   % * Reset bad input counter if good input detected
%   % * Allow multi-line questions if wrap-around needed for long text
%   % * Fixed bug where only part of line is being highlighted bold
%
% 2026_01_19 by Sean Brennan, sbrennan@psu.edu
% - In script_test_fcn_DebugTools_gradeAnswers
%   % * Now checks for empty entries prior to submitting
%   % * Now allows cell array of eval commands instead of one string
%   % * Now saves answers thus far into a holding "answers" data file
%   % * Saves the timeLog now
%
% 2026_01_26 by Sean Brennan, sbrennan@psu.edu
% - In script_test_fcn_DebugTools_gradeAnswers
%   % * Fixed bug where deactivated questions were still printing as active
%
% 2026_01_27 by Sean Brennan, sbrennan@psu.edu
% - In script_test_fcn_DebugTools_gradeAnswers
%   % * Updated the previous answers datafile naming to avoid prior
%   %   % assignments putting data into future assignments.
% 
% 2026_02_02 by Sean Brennan, sbrennan@psu.edu
% - In script_test_fcn_DebugTools_gradeAnswers
%   % * Fixed incorrect capitalization in fcn_DebugTools_wrapLongText
% 
% 2026_09_04 by Sean Brennan, sbrennan@psu.edu
% - In script_test_fcn_DebugTools_gradeAnswers
%   % * Added 'within range' grading option
%   % * Added outputs to allow individual problem scores to be seen

% TO-DO:
% 2026_01_12 by Sean Brennan, sbrennan@psu.edu
% - (add items here)

%% Fill in the Canvas IDs
CanvasIDs = [
    7085227
    7085590
    7145438
    7155055
    7156922
    7157589
    7194990
    7197975
    7199509
    7199628
    7199973
    7199975
    7202486
    7202507
    7203486
    7203748
    7204194
    7205689
    7205928
    7210018
    7213254
    7215457
    7220197
    7222040
    7223846
    7273950
    7363368
    9000000
    9111111
    9222222
    ];

%%

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


numQuestions = numQuestions+1;
selections(numQuestions).MenuChar = sprintf('%.0d',numQuestions);
selections(numQuestions).Text = ') What is a number between 2 and 5?';
selections(numQuestions).AnswerDefault = '-missing-';
selections(numQuestions).AnswerType = '1column_of_numbers';
selections(numQuestions).AnswerConversionFunction = 'str2double';
selections(numQuestions).AnswerTypeOptions = [1 1];
selections(numQuestions).AnswerPrintFormat = '%.3f';
selections(numQuestions).FunctionMore = 'why';
selections(numQuestions).FunctionMoreInputs = {30};
selections(numQuestions).FunctionSubmission = '[answers, numBadOptionInputs, flag_exitMain] = fcn_INTERNAL_enterData(answers, selections, selectedOptionCharacters, numBadOptionInputs)';
selections(numQuestions).FunctionSubmissionOptions = {'.'};
selections(numQuestions).isAllowableMenuOption = true;

selections(numQuestions).AnswerGradingCorrect = 'grail';
selections(numQuestions).AnswerGradingPoints = 1;
selections(numQuestions).AnswerGradingType = 'within range';
selections(numQuestions).AnswerGradingOptions = {[2 5]};


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

% Enter menu loop?
% fcn_DebugTools_menuManageSelections(selections, (1))

answers = cell(length(selections),1);
answers{1}= '900000000';
answers{2}= '2';
answers{3}= 'B';
answers{4}= 'Grail';
answers{5}= '2.5';

% Grade assignment - one will be wrong
[overallScore, actualScoresEachQuestion, possibleScoresEachQuestion] = fcn_DebugTools_gradeAnswers(selections,answers);
assert(isequal(round(overallScore,2),0.75))

% Now change the 4th answer type
selections(4).AnswerGradingOptions = {'IgnoreCase'};
overallScore = fcn_DebugTools_gradeAnswers(selections,answers);
assert(isequal(round(overallScore,2),1.00))

% Hash the answer
assignmentString = selections(1).AssignmentString;
overallScoreString = sprintf('%.2f',overallScore);


studentNumberString = answers{1}; %  Grab the student number - it is always the first answer
resultString = cat(2,studentNumberString,overallScoreString);
gradeHash = fcn_DebugTools_hashStrings(assignmentString, resultString);


fcn_DebugTools_cprintf('*Green','Grading completed.');
fprintf(1,'\nThe assignment: \t%s\nwas just graded.\n',assignmentString)
fprintf(1,'Your score:\t%s\n',overallScoreString)
fprintf(1,'As the final step, please enter the following code into Canvas for this assignment.\n%s\n',gradeHash);
fprintf(1,'Press any key to continue\n');
pause;
answers{end-2} = 'GRADED';




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
numQuestions = 0; % Initialize the number of questions
selections = struct(); % Create an empty structure array for selections
selections(1).AssignmentString = 'Week01_Quiz01';

numQuestions = numQuestions+1;
selections(numQuestions).MenuChar = num2str(numQuestions);
selections(numQuestions).Name = 'WhatNumber';
selections(numQuestions).Text = ') Identity information: What is the 7-digit folder number that was emailed to you?';
selections(numQuestions).AnswerDefault = '-missing-';
selections(numQuestions).AnswerType = '1column_of_integers';
selections(numQuestions).AnswerConversionFunction = 'str2double';
selections(numQuestions).AnswerTypeOptions = [1 1];
selections(numQuestions).AnswerPrintFormat = '%.0f';
selections(numQuestions).FunctionMore = sprintf('fcn_help_Week01_HW01(%.0f)',numQuestions);
selections(numQuestions).FunctionMoreInputs = {30};
selections(numQuestions).FunctionSubmission = '[answers, numBadOptionInputs, flag_exitMain] = fcn_INTERNAL_enterData(answers, selections, selectedOptionCharacters, numBadOptionInputs)';
selections(numQuestions).FunctionSubmissionOptions = {'.'};
selections(numQuestions).isAllowableMenuOption = true;
selections(numQuestions).CorrectAnswer = nan;

selections(numQuestions).AnswerGradingCorrect = nan;
selections(numQuestions).AnswerGradingPoints = 1;
selections(numQuestions).AnswerGradingType = 'not empty';
selections(numQuestions).AnswerGradingOptions = {[]};


numTrueFalse = 1;
for ith_question = 1:numTrueFalse
    numQuestions = numQuestions+1;
    selections(numQuestions).MenuChar = num2str(numQuestions);
    selections(numQuestions).Name = 'OKtoEmailSubmissionConfirmation';
    selections(numQuestions).Text = ') Preferences: do you want to receive automated emails indicating when your assignment has been successfully uploaded?  (1=yes, 0=no)';
    selections(numQuestions).AnswerDefault = '-missing-';
    selections(numQuestions).AnswerType = '1column_of_integers';
    selections(numQuestions).AnswerConversionFunction = 'str2double';
    selections(numQuestions).AnswerTypeOptions = [1 1];
    selections(numQuestions).AnswerPrintFormat = '%.0f';
    selections(numQuestions).FunctionMore = sprintf('fcn_help_Week01_HW01(%.0f)',numQuestions);
    selections(numQuestions).FunctionMoreInputs = {30};
    selections(numQuestions).FunctionSubmission = '[answers, numBadOptionInputs, flag_exitMain] = fcn_INTERNAL_enterData(answers, selections, selectedOptionCharacters, numBadOptionInputs)';
    selections(numQuestions).FunctionSubmissionOptions = {'.'};
    selections(numQuestions).isAllowableMenuOption = true;
    selections(numQuestions).CorrectAnswer = nan;

    selections(numQuestions).AnswerGradingCorrect = nan;
    selections(numQuestions).AnswerGradingPoints = 1;
    selections(numQuestions).AnswerGradingType = 'exact match';
    selections(numQuestions).AnswerGradingOptions = {[]};


end

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
selections(numQuestions).AnswerPrintFormat = '%s';
selections(numQuestions).FunctionMore = sprintf('fcn_help_Week01_HW01(%.0f)',numQuestions);
selections(numQuestions).FunctionMoreInputs = [];
selections(numQuestions).FunctionSubmission = { ...
    'submissionFileName = cat(2,''SUBMISSION_Week01_HW01_'',answers{1});';
    'zipName = fullfile(pwd,''Submissions'',submissionFileName);';
    'typeList = {''var'', ''var''};';
    'nameList = {''answers'', ''timelog''};';
    'fcn_PrepareSubmission_packageAnswers(zipName, typeList, nameList, answers, timelog, (1));';
    'fcn_DebugTools_cprintf(''*Green'',''Submission prepared.'');';
    'fprintf(1,''\\nThe file: \\n\\t%%s\\nwas just created.\\n'',zipName)';
    'fprintf(1,''As the final step, you must manually copy this SUBMISSION zip file out of \\nthe ''''Submissions'''' folder and into the OneDrive folder shared with you.\\n This is to force the user to check that files were created and uploaded, before exiting.\\n'');';
    'fprintf(1,''Press any key to continue'');';
    'pause;';
    'answers{end-1} = ''SUBMITTED'';';
    };
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
selections(numQuestions).FunctionMore = sprintf('fcn_help_Week01_HW01(%.0f)',numQuestions);
selections(numQuestions).FunctionMoreInputs = [];
selections(numQuestions).FunctionSubmission = 'flag_exitMain = 1; fprintf(1,''Quitting\\n'');';
selections(numQuestions).FunctionSubmissionOptions = {'.'};
selections(numQuestions).isAllowableMenuOption = true;

% Fill in the true/false questions
numPossible = 0;

numPossible = numPossible+1;
possibleQuestions(numPossible).Name = 'Final';
possibleQuestions(numPossible).Text = ' Final: Is there a final in this class?  (1=yes, 0=no)';
possibleQuestions(numPossible).CorrectAnswer = '0';

numPossible = numPossible+1;
possibleQuestions(numPossible).Name = 'Emails';
possibleQuestions(numPossible).Text = ' Email: Will the emails to the professor, snb10@psu.edu and sbrennan@psu.edu go to the same inbox?  (1=yes, 0=no)';
possibleQuestions(numPossible).CorrectAnswer = '1';

numPossible = numPossible+1;
possibleQuestions(numPossible).Name = 'NumExams1';
possibleQuestions(numPossible).Text = ' : Are there 3 exams in this class?  (1=yes, 0=no)';
possibleQuestions(numPossible).CorrectAnswer = '1';

numPossible = numPossible+1;
possibleQuestions(numPossible).Name = 'NumExams2';
possibleQuestions(numPossible).Text = ' : Are there 4 exams in this class?  (1=yes, 0=no)';
possibleQuestions(numPossible).CorrectAnswer = '0';

numPossible = numPossible+1;
possibleQuestions(numPossible).Name = 'ClassNumber';
possibleQuestions(numPossible).Text = ' : Does the class number (452) go in every email subject line?  (1=yes, 0=no)';
possibleQuestions(numPossible).CorrectAnswer = '1';

numPossible = numPossible+1;
possibleQuestions(numPossible).Name = 'ExamsOpenNote';
possibleQuestions(numPossible).Text = ' : Are exams open-note?  (1=yes, 0=no)';
possibleQuestions(numPossible).CorrectAnswer = '0';

numPossible = numPossible+1;
possibleQuestions(numPossible).Name = 'AIonHW';
possibleQuestions(numPossible).Text = ' : Are AI tools allowed on the homework?  (1=yes, 0=no)';
possibleQuestions(numPossible).CorrectAnswer = '1';

numPossible = numPossible+1;
possibleQuestions(numPossible).Name = 'AIonExams';
possibleQuestions(numPossible).Text = ' : Are AI tools allowed on the exams?  (1=yes, 0=no)';
possibleQuestions(numPossible).CorrectAnswer = '0';

numPossible = numPossible+1;
possibleQuestions(numPossible).Name = 'MissClassReasonableExcuse';
possibleQuestions(numPossible).Text = ' : Can students miss two classes with reasonable excuses?  (1=yes, 0=no)';
possibleQuestions(numPossible).CorrectAnswer = '1';

numPossible = numPossible+1;
possibleQuestions(numPossible).Name = 'ThanksgivingFlight';
possibleQuestions(numPossible).Text = ' : Is getting a better Thanksgiving flight an excused reason to miss class?  (1=yes, 0=no)';
possibleQuestions(numPossible).CorrectAnswer = '0';

numPossible = numPossible+1;
possibleQuestions(numPossible).Name = 'StudnetsHelpEachOther';
possibleQuestions(numPossible).Text = ' : Are students allowed to help each other on the homework?  (1=yes, 0=no)';
possibleQuestions(numPossible).CorrectAnswer = '1';

% Select some of these and fill in details
rngSeed = input('Enter your 7-digit Canvas number:');
rng(rngSeed);
problemsToUse = randperm(numPossible, numTrueFalse);

% Fill in entries
for ith_problem = 1:numTrueFalse
    thisProblemID = problemsToUse(ith_problem);

    selections(ith_problem+1).Name                 =  possibleQuestions(thisProblemID).Name;
    selections(ith_problem+1).Text                 =  possibleQuestions(thisProblemID).Text;
    selections(ith_problem+1).AnswerGradingCorrect = possibleQuestions(thisProblemID).CorrectAnswer;
    selections(ith_problem+1).AnswerGradingPoints = 1;
    selections(ith_problem+1).AnswerGradingType = 'exact match';
    selections(ith_problem+1).AnswerGradingOptions = {[]};
end

% Enter menu loop?
fcn_DebugTools_menuManageSelections(selections, (1))

% Generate all hashes for Canvas

assignmentString = selections(1).AssignmentString;
overallScoreString = sprintf('%.2f',1.00);

fprintf(1,'\n\nGrade Hashes for: %s\n',assignmentString);
for ith_ID = 1:length(CanvasIDs)
    studentNumberString = sprintf('%.0d',CanvasIDs(ith_ID)); %  Grab the student number - it is always the first answer
    resultString = cat(2,studentNumberString,overallScoreString);
    gradeHash = fcn_DebugTools_hashStrings(assignmentString, resultString, (flagOutputs));
    fprintf(1,'%s\n',gradeHash);
end




