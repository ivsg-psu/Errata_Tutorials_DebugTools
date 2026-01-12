function fcn_DebugTools_menuManageSelections(selections, varargin)
% fcn_DebugTools_menuManageSelections
% A powerful menu tool that allows user to define menu options that auto-execute code.
% The settings in "selections" structure define how menu operates.
%
% FORMAT:
%
%      fcn_DebugTools_menuManageSelections(selections, (fid))
%
% INPUTS:
%
%      selections: a structure defining inputs and function calls to the
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
%      (none)
%
% DEPENDENCIES:
%
%      fcn_DebugTools_checkInputsToFunctions
%
% EXAMPLES:
%
% See the script: script_test_fcn_DebugTools_menuManageSelections
% for a full test suite.
%
% This function was written on 2026_01_12 by S. Brennan.
% Questions or comments? sbrennan@psu.edu

% REVISION HISTORY: 
% 
% 2026_01_12 by Sean Brennan, sbrennan@psu.edu
% - first write of the code


% TO-DO:
% 2026_01_12 by Sean Brennan, sbrennan@psu.edu
% - fill in to-do items here.

%% Debugging and Input checks

% Check if flag_max_speed set. This occurs if the fid variable input
% argument (varargin) is given a number of -1, which is not a valid figure
% number.
MAX_NARGIN = 2; % The largest Number of argument inputs to the function
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
numQuestions = length(selections);

% Initialize answers
answers = cell(numQuestions,1);
numIntegerQuestions = (numQuestions-2);

% Initialize count of bad inputs and loop flag
numBadInputs = 0;
numBadOptionInputs = 0; %#ok<NASGU>

flag_exitMain = 0;
while 0==flag_exitMain

	%%%%%
	% What are allowable actions right now?
	[allowableOptions, associatedIndices] = fcn_INTERNAL_setAllowableMenuOptions(selections);

	%%%%%
	%  Define default menu choice

	% Find first answer index that is not answered
	answerIndex = find(cellfun(@isempty, answers), 1);
	if ~isempty(answerIndex) && (answerIndex<=numIntegerQuestions)
		defaultMenuChoice = sprintf('%.0f',answerIndex);
	else
		defaultMenuChoice = 's';
	end
	matchedIndices = strcmpi(defaultMenuChoice,allowableOptions);
	firstMatch = find(matchedIndices,1);
	selectedRow = associatedIndices(firstMatch,1);

	%%%%%
	% Show user choices
	eval(cat(2,'cl','c')); % Make cl+c command hidden so will not throw warnings
	cellArray = fcn_INTERNAL_buildCellArray(selections, answers, selectedRow);
	fcn_INTERNAL_showTable(cellArray,selectedRow);


	%%%%
	% Get user choice
	mainMenuChoice = input(sprintf('What option do you want to choose? [default = %s]:',defaultMenuChoice),'s');
	if isempty(mainMenuChoice)
		mainMenuChoice = defaultMenuChoice;
	end
	fprintf(1,'Selection chosen: -->  %s\n',mainMenuChoice);

	%%%%
	% Catch any bad inputs
	if ~any(strcmpi(mainMenuChoice,allowableOptions))
		numBadInputs = numBadInputs + 1;
		if numBadInputs>3
			fprintf(1,'Too many failed inputs: %.0f of 3 allowed. Exiting.\n',numBadInputs);
			flag_exitMain = 1;
		else
			fprintf(1,'Unrecognized or unallowed option: %s. Try again (try %.0f of 3) \n ', mainMenuChoice, numBadInputs);
		end
		fprintf(1,'Hit any key to continue.\n');
		pause;
	else
		matchedIndices = strcmpi(mainMenuChoice,allowableOptions);
		firstMatch = find(matchedIndices,1);
		actualIndex = associatedIndices(firstMatch,1);
		commandToRun = sprintf(selections(actualIndex).FunctionSubmission);
		eval(commandToRun);
	end

end % Ends while loop for menu

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
function cellArray = fcn_INTERNAL_buildCellArray(selections, answers, selectedRow)
numRows = length(selections);

% Selection, Q#, Text, More, Answer
numCols = 5;
cellArray = cell(numRows, numCols);
for ith_row = 1:numRows
	cellArray{ith_row, 1} = fcn_INTERNAL_isSelectedString(ith_row, selectedRow); % Selection arrow
	cellArray{ith_row, 2} = selections(ith_row).MenuChar;      % Question Character
	cellArray{ith_row, 3} = selections(ith_row).Text;  % Question Text

	if ~isempty(selections(ith_row).FunctionMore)
		cellArray{ith_row, 4} = 'Yes'; % More Info Function
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
function stringIsSelected = fcn_INTERNAL_isSelectedString(ith_row, selectedRow)

% Draws selection arrow
if selectedRow == ith_row
	stringIsSelected = '-->'; % Indicate selection with an arrow
else
	stringIsSelected = '   '; % No selection
end

end % Ends stringIsSelected


%% fcn_INTERNAL_showTable
function fcn_INTERNAL_showTable(cellArray, selectedRow)
table_data = cellArray;

header_strings = [{'Selection'}, {'#'},{'Question:'},{'More Help?'},{'Answer'}]; % Headers for each column

formatter_strings = [...
	{'%s'},{'%s'},{'%s'},{'Green %s'},{'Red %s'},{[]};
	{'*Black %s'},{'*Black %s'},{'*Black %s'},{'*Green %s'},{'*Red %s'},{selectedRow}];

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
			flagVerified = false;
		end
	end

catch
	flagVerified = false;
end
end % Ends fcn_INTERNAL_verifyChoice

%% fcn_INTERNAL_enterData
function [answers, numBadOptionInputs, flag_exitMain] = fcn_INTERNAL_enterData(answers, selections, selectedRow, numBadOptionInputs)
flag_exitMain = 0;

optionChoice = input(sprintf('What answer do you wish to give to this question? [default = (h) which opens help]:'),'s');
if isempty(optionChoice) || strcmpi(optionChoice,'h')

	if ~isempty(selections(selectedRow).FunctionMore)
		fprintf(1,'Launching help function for this question:\n');
		feval(selections(selectedRow).FunctionMore)
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
	flagPassed = fcn_INTERNAL_menuVerifyChoice(optionChoice, selections(selectedRow).AnswerType, selections(selectedRow).AnswerTypeOptions,[]);

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

%% fcn_INTERNAL_prepDataForSave
function answers = fcn_INTERNAL_prepDataForSave(answers)
fileName = sprintf('Week1_HW1Answers_%s.mat',answers{1});
save(fileName,'answers');
fprintf(1,['\nThe file: \n' ...
	'\t%s\n' ...
	'was just created.\n'],fileName);
fprintf(1,'You must manually copy this file into the OneDrive folder shared with you.\nThis is to force the user to check that files were created and uploaded, before exiting.\n');
fprintf(1,'Hit any key to continue.\n');
pause;
answers{end-1} = 'SUBMITTED';
end