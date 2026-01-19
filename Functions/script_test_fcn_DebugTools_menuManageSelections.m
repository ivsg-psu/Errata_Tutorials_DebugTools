

% Fill in test data
numQuestions = 0; % Initialize the number of questions
selections = struct(); % Create an empty structure array for selections

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







