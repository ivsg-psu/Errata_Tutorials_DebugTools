function [overallScore, actualScoresEachQuestion, possibleScoresEachQuestion]  = fcn_DebugTools_gradeAnswers(selections, answers, varargin)
% fcn_DebugTools_gradeAnswers A tool to grade student answers by comparing
% them to correct values in "selections" structure. 
%
% Specifically, it looks for the fields:
%
% For example, to check to see if an answer exists and assign no credit,
% the following format is used:
%
% selections(numQuestions).AnswerGradingCorrect = 900000000;
% selections(numQuestions).AnswerGradingPoints = 0;
% selections(numQuestions).AnswerGradingType = 'not empty';
% selections(numQuestions).AnswerGradingOptions = {[]};
% 
% Grading options include:
%
%   'not empty': full points are assigned to any answer that isn't empty
%
%   'exact match': full points are assigned if the lowercase answer
%   exactly matches the correct answer
%
%   'contains word': full points are assigned if the lowercase answer
%   contains the correct answer.
%        Options: thisGradingOptions{1},'IgnoreCase' - ignores case
%
%   'within range': full points are assigned if the answer is within the
%   range given by thisGradingOptions{1}
%
% FORMAT:
%
%      fcn_DebugTools_gradeAnswers(selections, (fid))
%
% INPUTS:
%
%      selections: a structure defining inputs and function calls to the
%      menu system
%
%      answers: a structure defining inputs and function calls to the
%      menu system
%
%      (OPTIONAL INPUTS)
%
%      fid: a FID number to print results. If set to -1, skips any
%      input checking or debugging, no prints will be generated, and sets
%      up code to maximize speed.
%
% OUTPUTS:
%
%      overallScore: the graded value for the submission
%
%      actualScoresEachQuestion, possibleScoresEachQuestion: the grades for each part
%
% DEPENDENCIES:
%
%      fcn_DebugTools_checkInputsToFunctions
%
% EXAMPLES:
%
% See the script: script_test_fcn_DebugTools_gradeAnswers
% for a full test suite.
%
% This function was written on 2026_01_12 by S. Brennan.
% Questions or comments? sbrennan@psu.edu

% REVISION HISTORY:
%
% 2026_01_12 by Sean Brennan, sbrennan@psu.edu
% - first write of the code
%
% 2026_01_18 by Sean Brennan, sbrennan@psu.edu
% - In fcn_DebugTools_gradeAnswers
%   % * Reset bad input counter if good input detected
%   % * Allow multi-line questions if wrap-around needed for long text
%   % * Fixed bug where only part of line is being highlighted bold
%
% 2026_01_19 by Sean Brennan, sbrennan@psu.edu
% - In fcn_DebugTools_gradeAnswers
%   % * Now checks for empty entries prior to submitting
%   % * Now allows cell array of eval commands instead of one string
%   % * Now saves answers thus far into a holding "answers" data file
%   % * Saves the timeLog now
%
% 2026_01_26 by Sean Brennan, sbrennan@psu.edu
% - In fcn_DebugTools_gradeAnswers
%   % * Fixed bug where deactivated questions were still printing as active
%
% 2026_01_27 by Sean Brennan, sbrennan@psu.edu
% - In fcn_DebugTools_gradeAnswers
%   % * Updated the previous answers datafile naming to avoid prior
%   %   % assignments putting data into future assignments.
% 
% 2026_02_02 by Sean Brennan, sbrennan@psu.edu
% - In fcn_DebugTools_gradeAnswers
%   % * Fixed incorrect capitalization in fcn_DebugTools_wrapLongText
% 
% 2026_09_04 by Sean Brennan, sbrennan@psu.edu
% - In fcn_DebugTools_gradeAnswers
%   % * Added 'within range' grading option
%   % * Added outputs to allow individual problem scores to be seen

% TO-DO:
% 2026_01_12 by Sean Brennan, sbrennan@psu.edu
% - (add items here)

%% Debugging and Input checks

% Check if flag_max_speed set. This occurs if the fid variable input
% argument (varargin) is given a number of -1, which is not a valid figure
% number.
MAX_NARGIN = 3; % The largest Number of argument inputs to the function
flag_max_speed = 0;
if (nargin==MAX_NARGIN && isequal(varargin{end},-1))
	flag_do_debug = 0; %     % Flag to plot the results for debugging
	flag_check_inputs = 0; % Flag to perform input checking
	flag_max_speed = 1;
else
	% Check to see if we are externally setting debug mode to be "on"
	flag_do_debug = 0; %     % Flag to plot the results for debugging
	flag_check_inputs = 1; % Flag to perform input checking
	MATLABFLAG_DEBUGTOOLS_FLAG_CHECK_INPUTS = getenv("MATLABFLAG_DEBUGTOOLS_FLAG_CHECK_INPUTS");
	MATLABFLAG_DEBUGTOOLS_FLAG_DO_DEBUG = getenv("MATLABFLAG_DEBUGTOOLS_FLAG_DO_DEBUG");
	if ~isempty(MATLABFLAG_DEBUGTOOLS_FLAG_CHECK_INPUTS) && ~isempty(MATLABFLAG_DEBUGTOOLS_FLAG_DO_DEBUG)
		flag_do_debug = str2double(MATLABFLAG_DEBUGTOOLS_FLAG_DO_DEBUG);
		flag_check_inputs  = str2double(MATLABFLAG_DEBUGTOOLS_FLAG_CHECK_INPUTS);
	end
end

% flag_do_debug = 1;

if flag_do_debug
	st = dbstack; %#ok<*UNRCH>
	fprintf(1,'STARTING function: %s, in file: %s\n',st(1).name,st(1).file);
	debug_figNum = 999978; %#ok<NASGU>
else
	debug_figNum = []; %#ok<NASGU>
end

%% check input arguments
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   _____                   _
%  |_   _|                 | |
%    | |  _ __  _ __  _   _| |_ ___
%    | | | '_ \| '_ \| | | | __/ __|
%   _| |_| | | | |_) | |_| | |_\__ \
%  |_____|_| |_| .__/ \__,_|\__|___/
%              | |
%              |_|
% See: http://patorjk.com/software/taag/#p=display&f=Big&t=Inputs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if 0 == flag_max_speed
	if flag_check_inputs == 1
		% Are there the right number of inputs?
		narginchk(1,MAX_NARGIN);

		% Check the table_data input
		% fcn_DebugTools_checkInputsToFunctions(table_data, '_of_chars');

		% Check the header_strings input
		% fcn_DebugTools_checkInputsToFunctions(header_strings, '_of_chars');

		% Check the numChars input
		% fcn_DebugTools_checkInputsToFunctions(numChars, '_of_integers');

	end
end


% Check to see if user specifies fid?
flag_do_plots = 0; % Default is to NOT show plots
fid = 1; %#ok<NASGU> % Default is to print to the console
if (0==flag_max_speed) && (MAX_NARGIN == nargin)
	temp = varargin{end};
	if ~isempty(temp)
		fid = temp; %#ok<NASGU>
		flag_do_plots = 1;
	end
end


%% Start of main code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   __  __       _
%  |  \/  |     (_)
%  | \  / | __ _ _ _ __
%  | |\/| |/ _` | | '_ \
%  | |  | | (_| | | | | |
%  |_|  |_|\__,_|_|_| |_|
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Initialize variables 
numQuestions = length(selections);

% Count the number of integer questions
numIntegerQuestions = 0;
for ith_question = 1:numQuestions
    if ~isnan(str2double(selections(ith_question).MenuChar))
        numIntegerQuestions = ith_question;
    else
        break
    end
end

actualScoresEachQuestion = zeros(numIntegerQuestions,1);
possibleScoresEachQuestion = zeros(numIntegerQuestions,1);

% Grade each problem
for ith_problem = 1:numIntegerQuestions
    thisAnswer = answers{ith_problem};
    thisCorrectAnswer  = selections(ith_problem).AnswerGradingCorrect;
    thisPossibleScore  = selections(ith_problem).AnswerGradingPoints;
    thisGradingType    = selections(ith_problem).AnswerGradingType;
    thisGradingOptions = selections(ith_problem).AnswerGradingOptions;

    % EXAMPLE:
    % selections(numQuestions).AnswerGradingCorrect = 900000000;
    % selections(numQuestions).AnswerGradingPoints = 0;
    % selections(numQuestions).AnswerGradingType = 'exist';
    % selections(numQuestions).AnswerGradingOptions = {[]};

    switch lower(thisGradingType)
        case 'not empty'
            if ~isempty(thisAnswer)
                actualScoresEachQuestion(ith_problem) = thisPossibleScore;
            end
        case 'exact match'
            if ~isempty(thisAnswer)
                actualScoresEachQuestion(ith_problem) = thisPossibleScore * strcmpi(thisAnswer, thisCorrectAnswer);
            end
        case 'contains word'
            if ~isempty(thisAnswer)
                if strcmp(thisGradingOptions{1},'IgnoreCase')
                    actualScoresEachQuestion(ith_problem) = thisPossibleScore * contains(thisAnswer, thisCorrectAnswer,'IgnoreCase',true);
                else
                    actualScoresEachQuestion(ith_problem) = thisPossibleScore * contains(thisAnswer, thisCorrectAnswer);
                end
			end 
		case 'within range'
			if ~isempty(thisAnswer)
                if ~isempty(thisGradingOptions{1})
					expectedRange = thisGradingOptions{1};
					numericThisAnswer = str2double(thisAnswer);
					actualScoresEachQuestion(ith_problem) = thisPossibleScore * (numericThisAnswer>=expectedRange(1) && numericThisAnswer<=expectedRange(2));					
                else
                    warning('Range option not given during a within-range test. Unable to grade.');
                end
			end 
        otherwise
            warning('Unable to find grading type: %s\n',thisGradingType);
    end

    % Fill in the possible points
    possibleScoresEachQuestion(ith_problem) = thisPossibleScore;
end

% Add up results
totalPointsEarned = sum(actualScoresEachQuestion);
totalPointsPossible = sum(possibleScoresEachQuestion);

overallScore = totalPointsEarned/totalPointsPossible;


%% Plot the results (for debugging)?
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   _____       _
%  |  __ \     | |
%  | |  | | ___| |__  _   _  __ _
%  | |  | |/ _ \ '_ \| | | |/ _` |
%  | |__| |  __/ |_) | |_| | (_| |
%  |_____/ \___|_.__/ \__,_|\__, |
%                            __/ |
%                           |___/
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if 1 == flag_do_plots
	%     figure(figNum);
	%     clf;
	%     hold on;
	%     grid on;
	%
	%

end % Ends the flag_do_plot if statement

if flag_do_debug
	fprintf(1,'ENDING function: %s, in file: %s\n\n',st(1).name,st(1).file);
end

end % Ends the main function

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
function [cellArray, printStyle] = fcn_INTERNAL_buildCellArray(selections, answers, selectedOptionCharacters)
% cellArray is what is being printed, a list of strings
% printStyle is which style to use:
% 1 = default
% 2 = bold

numRows = length(selections);

% Selection, Q#, Text, More, Answer
numCols = 5;
cellArray = cell(numRows, numCols);
printStyleCell = cell(numRows,1);

numActualRows = 0;
for ith_row = 1:numRows
	numActualRows = numActualRows+1;

	flagIsSelected = strcmp(selectedOptionCharacters,selections(ith_row).MenuChar);
	if flagIsSelected
		printStyleCell{numActualRows,1} = 2;
	else
		printStyleCell{numActualRows,1} = 1;
	end

	flagIsAllowable = selections(ith_row).isAllowableMenuOption;
	if ~flagIsAllowable
		printStyleCell{numActualRows,1} = 3;
	end

	cellArray{numActualRows, 1} = fcn_INTERNAL_isSelectedString(flagIsSelected); % Selection arrow
	cellArray{numActualRows, 2} = selections(ith_row).MenuChar;      % Question Character

	originalText = selections(ith_row).Text;
	wrappedText = fcn_DebugTools_wrapLongText(originalText,50);
	textCellArray= split(wrappedText,'\n');

	cellArray{numActualRows, 3} = textCellArray{1};  % Question Text


	if ~isempty(selections(ith_row).FunctionMore)
		cellArray{numActualRows, 4} = 'Yes'; % More Info Function
	else
		cellArray{numActualRows, 4} = ''; % No More Info Function
	end

	if isempty(answers{ith_row})
		cellArray{numActualRows, 5} = selections(ith_row).AnswerDefault; % Default Answer
	else
		cellArray{numActualRows, 5} = answers{ith_row}; % User's Answer
	end

	% Check for multi-line case
	if size(textCellArray,1)>1
		for ith_extraRow = 1:(size(textCellArray,1)-1)
			numActualRows = numActualRows+1;
			cellArray{numActualRows, 1} = ' ';
			cellArray{numActualRows, 2} = ' ';
			cellArray{numActualRows, 3} = cat(2,'  ',textCellArray{ith_extraRow+1});
			cellArray{numActualRows, 4} = ' ';
			cellArray{numActualRows, 5} = ' ';

			printStyleCell{numActualRows,1} = printStyleCell{numActualRows-1,1};
		end
	end

end

printStyle = cell2mat(printStyleCell);
end % Ends fcn_INTERNAL_buildCellArray


%% fcn_INTERNAL_isSelectedString
function stringIsSelected = fcn_INTERNAL_isSelectedString(flagIsSelected)

% Draws selection arrow
if flagIsSelected
	stringIsSelected = '-->'; % Indicate selection with an arrow
else
	stringIsSelected = '   '; % No selection
end

end % Ends fcn_INTERNAL_isSelectedString


%% fcn_INTERNAL_showTable
function fcn_INTERNAL_showTable(cellArray, printStyle)
table_data = cellArray;

header_strings = [{'Selection'}, {'#'},{'Question:'},{'More Help?'},{'Answer'}]; % Headers for each column

boldedRows = find(printStyle==2);
greyRows = find(printStyle==3);


formatter_strings = [...
	{'%s'},{'%s'},{'%s'},{'Green %s'},{'Red %s'},{[]};
	{'*Black %s'},{'*Black %s'},{'*Black %s'},{'*Green %s'},{'*Red %s'},{boldedRows};
	{'[0.8 0.8 0.8] %s'},{'[0.8 0.8 0.8] %s'},{'[0.8 0.8 0.8] %s'},{'[0.8 0.8 0.8] %s'},{'[0.8 0.8 0.8] %s'},{greyRows}];

% fcn_INTERNAL_showSelection(parsingChoice,allOptions{ith_option});
% if any(strcmp(thisOption,allowableOptions))
% 	fcn_DebugTools_cprintf(0.0*[1 1 1], sprintf('%s\n',promptsForOptions{ith_option}));
% else
% 	fcn_DebugTools_cprintf(0.8*[1 1 1], sprintf('%s\n',promptsForOptions{ith_option}));
% end

numChars = [-1, -1, -1, -1, -1]; % Specify spaces for each column

fcn_DebugTools_debugPrintTableToNCharacters(table_data, header_strings, formatter_strings,numChars);

end % Ends fcn_INTERNAL_showTable

%% fcn_INTERNAL_setAllowableMenuOptions
function [allowableOptions, associatedIndices] = fcn_INTERNAL_setAllowableMenuOptions(selections)

allowableOptions = cell(1,1);
associatedIndices = [];
numOptions = 0;
for ith_selection = 1:length(selections)
	if selections(ith_selection).isAllowableMenuOption
		thisOption = selections(ith_selection).MenuChar;
		numOptions = numOptions+1;
		allowableOptions{numOptions,1} = thisOption;
		associatedIndices(numOptions,1) = ith_selection; %#ok<AGROW>
	end
end

end % Ends fcn_INTERNAL_setAllowableMenuOptions


%% fcn_INTERNAL_showSelection
function fcn_INTERNAL_showSelection(parsingChoice,thisChoice)
if strcmp(parsingChoice,thisChoice)
	fprintf(1,'SELECTED--->');
else
	fprintf(1,'            ');
end
end % Ends fcn_INTERNAL_showSelection


%% fcn_INTERNAL_verifyChoice
function flagVerified = fcn_INTERNAL_menuVerifyChoice(inputToVerify, typeTest, typeTestOptions, allowableRange)
try
	if ~isempty(typeTestOptions)
		fcn_DebugTools_checkInputsToFunctions(inputToVerify, typeTest, typeTestOptions);
	else
		fcn_DebugTools_checkInputsToFunctions(inputToVerify, typeTest);
	end

	flagVerified = true;

	if ~isempty(allowableRange)
		if inputToVerify<allowableRange(1) || inputToVerify>allowableRange(2)
			if contains(typeTest,'integer')
				fprintf(1,'The answer is outside the allowable range of: %.0f to %.0f.\n',allowableRange(1), allowableRange(2));
			else
				fprintf(1,'The answer is outside the allowable range of: %.2f to %.2f.\n',allowableRange(1), allowableRange(2));
			end
			flagVerified = false;
		end
	end

catch
	flagVerified = false;
end
end % Ends fcn_INTERNAL_verifyChoice

%% fcn_INTERNAL_enterData
function [answers, numBadOptionInputs, flag_exitMain] = fcn_INTERNAL_enterData(answers, selections, selectedOptionCharacters, numBadOptionInputs)
flag_exitMain = 0;


selectedRow = [];
for ith_selection = 1:length(selections)
	if strcmp(selections(ith_selection).MenuChar,selectedOptionCharacters)
		selectedRow = ith_selection;
		break;
	end
end

if isempty(selectedRow)
	error('Unable to match selection: %s to list of selections', selectedOptionCharacters);
end

optionChoice = input(sprintf('What answer do you wish to give to this question? [default = (h) which opens help]:'),'s');
if isempty(optionChoice) || strcmpi(optionChoice,'h')

	if ~isempty(selections(selectedRow).FunctionMore)
		fprintf(1,'Launching help function for this question:\n');
		commandToEval = selections(selectedRow).FunctionMore;
		if ischar(commandToEval)
			commandToRun = sprintf(commandToEval);
			eval(commandToRun);
		elseif iscell(commandToEval)
			for ith_cell = 1:length(commandToEval)
				commandToRun = sprintf(commandToEval{ith_cell});
				eval(commandToRun);
			end
		else
			error('Unrecognized type found in selections(actualIndex).MenuChar');
		end
	else
		fprintf(1,'Unfortunately, there is no help function for this question.\n');
	end
	fprintf(1,'Hit any key to continue.\n');
	pause;
else
	% Convert data
	if ~isempty(selections(selectedRow).AnswerConversionFunction)
		optionChoice = feval(selections(selectedRow).AnswerConversionFunction, optionChoice);
	end

	% Check if good
	if isfield(selections, 'AnswerAllowableRange') && ~isempty(selections(selectedRow).AnswerAllowableRange)
		flagPassed = fcn_INTERNAL_menuVerifyChoice(optionChoice, ...
			selections(selectedRow).AnswerType, ...
			selections(selectedRow).AnswerTypeOptions, ...
			selections(selectedRow).AnswerAllowableRange);
	else
		flagPassed = fcn_INTERNAL_menuVerifyChoice(optionChoice, selections(selectedRow).AnswerType, selections(selectedRow).AnswerTypeOptions,[]);
	end

	if ~flagPassed
		numBadOptionInputs = numBadOptionInputs + 1;
		if numBadOptionInputs>3
			fprintf(1,'Too many failed inputs: %.0f of 3 allowed. Exiting.\n',numBadOptionInputs);
			flag_exitMain = 1;
		else
			fprintf(1,'Unrecognized or unallowed option: %0.f. Try again (try %.0f of 3) \n ', optionChoice, numBadOptionInputs);
		end
		fprintf(1,'Hit any key to continue.\n');
		pause;
	else
		answers{selectedRow} = sprintf(selections(selectedRow).AnswerPrintFormat,optionChoice);
	end
end


end % Ends fcn_INTERNAL_enterData

