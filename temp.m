% Fill in test data
numQuestions = 0; % Initialize the number of questions
selections = struct(); % Create an empty structure array for selections

numQuestions = numQuestions+1;
selections(numQuestions).Name = 'WhatName';
selections(numQuestions).Text = 'What is your name?';
selections(numQuestions).AnswerDefault = '-missing-'; 
selections(numQuestions).AnswerType = '_of_char_strings'; 
selections(numQuestions).AnswerTypeOptions = [];
selections(numQuestions).FunctionMore = 'why'; 
selections(numQuestions).FunctionMoreInputs = {30}; 
selections(numQuestions).FunctionSubmission = 'what'; 
selections(numQuestions).FunctionSubmission = {'.'}; 

numQuestions = numQuestions+1;
selections(numQuestions).Name = 'WhatQuest';
selections(numQuestions).Text = 'What is your quest?';
selections(numQuestions).AnswerDefault = '-missing-'; 
selections(numQuestions).AnswerType = '_of_char_strings'; 
selections(numQuestions).AnswerTypeOptions = [];
selections(numQuestions).FunctionMore = 'why'; 
selections(numQuestions).FunctionMoreInputs = {30}; 
selections(numQuestions).FunctionSubmission = 'what'; 
selections(numQuestions).FunctionSubmission = {'.'}; 

numQuestions = numQuestions+1;
selections(numQuestions).Name = 'WhatNumber';
selections(numQuestions).Text = 'What is your favorite integer?';
selections(numQuestions).AnswerDefault = '-missing-'; 
selections(numQuestions).AnswerType = '1column_of_integers'; 
selections(numQuestions).AnswerTypeOptions = [1 1];
selections(numQuestions).FunctionMore = ''; 
selections(numQuestions).FunctionMoreInputs = []; 
selections(numQuestions).FunctionSubmission = 'what'; 
selections(numQuestions).FunctionSubmission = {'.'}; 

numQuestions = numQuestions+1;
selections(numQuestions).Name = 'WhatNumber';
selections(numQuestions).Text = 'Quit this homework (work will be saved)';
selections(numQuestions).AnswerDefault = '-missing-'; 
selections(numQuestions).AnswerType = ''; 
selections(numQuestions).AnswerTypeOptions = [];
selections(numQuestions).FunctionMore = ''; 
selections(numQuestions).FunctionMoreInputs = []; 
selections(numQuestions).FunctionSubmission = 'what'; 
selections(numQuestions).FunctionSubmission = {'.'}; 

numQuestions = numQuestions+1;
selections(numQuestions).Name = 'WhatNumber';
selections(numQuestions).Text = 'Submit answers for grading.';
selections(numQuestions).AnswerDefault = '-missing-'; 
selections(numQuestions).AnswerType = ''; 
selections(numQuestions).AnswerTypeOptions = [];
selections(numQuestions).FunctionMore = ''; 
selections(numQuestions).FunctionMoreInputs = []; 
selections(numQuestions).FunctionSubmission = 'what'; 
selections(numQuestions).FunctionSubmission = {'.'}; 

cellArray = fcn_INTERNAL_buildCellArray(selections);

%% Functions follow
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   ______                _   _
%  |  ____|              | | (_)
%  | |__ _   _ _ __   ___| |_ _  ___  _ __  ___
%  |  __| | | | '_ \ / __| __| |/ _ \| '_ \/ __|
%  | |  | |_| | | | | (__| |_| | (_) | | | \__ \
%  |_|   \__,_|_| |_|\___|\__|_|\___/|_| |_|___/
%
% See: https://patorjk.com/software/taag/#p=display&f=Big&t=Functions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%§

%% fcn_INTERNAL_buildCellArray
function cellArray = fcn_INTERNAL_buildCellArray(selections, answers, selected)
numRows = length(selections);

% Selection, Q#, Text, More, Answer
numCols = 5;
cellArray = cell(numRows, numCols);
for ith_row = 1:numRows
    cellArray{ith_row, 1} = fcn_INTERNAL_isSelectedString(ith_row, selected); % Selection arrow
    cellArray{ith_row, 2} = ith_row;                   % Question Number
    cellArray{ith_row, 3} = selections(ith_row).Text;  % Question Text

	if ~isempty(selections(ith_row).FunctionMore)
		cellArray{ith_row, 4} = 'More info available.'; % More Info Function
	else
		cellArray{ith_row, 4} = ''; % No More Info Function
	end

	if isempty(answers{ith_row})
		cellArray{ith_row, 5} = selections(ith_row).AnswerDefault; % Default Answer
	else
		cellArray{ith_row, 5} = answers{ith_row}; % User's Answer
	end
end

end % Ends fcn_INTERNAL_buildCellArray

%% stringIsSelected
function stringIsSelected = fcn_INTERNAL_isSelectedString(ith_row, selected)

% Draws selection arrow
if selected(ith_row)==1
	stringIsSelected = '-->'; % Indicate selection with an arrow
else
    stringIsSelected = '   '; % No selection
end

end % Ends stringIsSelected
