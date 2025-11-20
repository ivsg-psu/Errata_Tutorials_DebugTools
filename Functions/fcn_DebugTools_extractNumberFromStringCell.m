function outputNumberCell = fcn_DebugTools_extractNumberFromStringCell(inputStringCell, varargin)
%% fcn_DebugTools_extractNumberFromStringCell
% Takes an input cell that typically contains a string, and extracts the
% first number it finds. Useful to convert student entries such as {'1
% turtle'} into data, e.g. {'1'}
%
% FORMAT:
%
%      number = fcn_DebugTools_extractNumberFromStringCell(inputStringCell, (figNum))
%
% INPUTS:
%
%      inputStringCell: a cell type containing a string that may include
%      numbers and text
%
%      (OPTIONAL INPUTS)
%
%      figNum: a figure number to plot results. If set to -1, skips any
%      input checking or debugging, no figures will be generated, and sets
%      up code to maximize speed. 
%
% OUTPUTS:
%
%      numberCell: a cell type containing only the first number part of the input
%
% DEPENDENCIES:
%
%      fcn_DebugTools_checkInputsToFunctions
%
%
% EXAMPLES:
%
%     See the script: script_test_fcn_DebugTools_extractNumberFromStringCell
%     for a full test suite.
%
% This function was written on 2022_11_14 by S. Brennan
% Questions or comments? sbrennan@psu.edu

% REVISION HISTORY:
% 
% 2022_11_14 by Sean Brennan, sbrennan@psu.edu
% - wrote the code originally by copying out of old Exam2 code
% 
% 2025_11_12 by Sean Brennan, sbrennan@psu.edu
% - Updated debug flags
% - Added figNum input
% - Fixed variable naming for clarity:
%   % * input_variable to inputVariable
%
% 2025_11_20 by Sean Brennan, sbrennan@psu.edu
% - Formatted revision lists to Markdown format
% - Fixed variable naming for clarity:
%   % * fig_+num to figNum

% TO-DO:
% 2025_11_20 by Sean Brennan, sbrennan@psu.edu
% - Add test scripts
% - Add input argument checking

%% Debugging and Input checks

% Check if flag_max_speed set. This occurs if the figNum variable input
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

        % if nargin>=2
        %     % Check the variableTypeString input, make sure it is characters
        %     if ~ischar(variableTypeString)
        %         error('The variableTypeString input must be a character type, for example: ''Path'' ');
        %     end
        % end

    end
end


% Check to see if user specifies figNum?
flag_do_plots = 0; % Default is to NOT show plots
if (0==flag_max_speed) && (MAX_NARGIN == nargin) 
    temp = varargin{end};
    if ~isempty(temp)
        figNum = temp; %#ok<NASGU>
        flag_do_plots = 1;
    end
end



%% Main code starts here
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   __  __       _
%  |  \/  |     (_)
%  | \  / | __ _ _ _ __
%  | |\/| |/ _` | | '_ \
%  | |  | | (_| | | | | |
%  |_|  |_|\__,_|_|_| |_|
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Initialize output
outputNumberCell = {};

% Convert input to characters
StudentAnswer_string = char(inputStringCell);

if ~isempty(StudentAnswer_string)

    % We use regular expression, regexp, to extract the number portion of
    % the string. The challenge is that the number can be simple, such as
    % "1" or difficult such as "1,234.50".
    % The following works for any number with commas or decimals - see
    % https://www.mathworks.com/matlabcentral/answers/34548-regexp-help
    % See also: https://www.mathworks.com/matlabcentral/fileexchange/48930-interactive-regular-expression-tool
    expression = '(\d+,)*\d+(\.\d*)?'; 
    match = regexp(StudentAnswer_string,expression,'match','forceCellOutput');

    % Did we find anything?
    if ~isempty(match)
        numberCell = match{1};

        % Did we get more than one cell? If so, only keep the first hit
        if length(numberCell)>1
            numberCell = {numberCell{1}};
        end

        % Did we get an empty result? If not, check for leading decimals,
        % zeros and negative signs
        if ~isempty(numberCell)
            % Pull out just the string
            numberCell_string = numberCell{1};

            % Find the start index of the match
            startIndex = strfind(StudentAnswer_string,numberCell_string);
            startIndex = startIndex(1); % Keep only the first one

            % Do an error check
            if isempty(startIndex)
                error('An expression was returned from regexp that is not found in strfind');
            end

            % Is there a leading decimal point? If so, add this back into
            % the number.
            if startIndex~=1 && (StudentAnswer_string(startIndex-1)=='.')
                numberCell_string = cat(2,'.',numberCell_string);

                % Find the start index of the match
                startIndex = strfind(StudentAnswer_string,numberCell_string);
                startIndex = startIndex(1); % Keep only the first one
            end
            

            % Is there a leading negative sign? If so, note it as we have
            % to add it later.
            if startIndex~=1 && (StudentAnswer_string(startIndex-1)=='-')
                flag_is_negative = 1;
            else
                flag_is_negative = 0;
            end

            % After this point, the number should only be positive, and only of
            % characters 0 to 9, commas, and decimals.

            % To remove leading zeros, we search for 0 in the front of a
            % number, and start the number if the character is NOT zero.
            % However, there's one special condition where we keep a
            % leading zero, and that's when the next character is a
            % decimal, as in the following: '0.4'. We go ahead and strip
            % the zero in this special condition, but we need to add it
            % later. See steps that follow.
            starting_index = 1;
            flag_number_started = 0;
            for ith_character = 1:(length(numberCell_string)-1)
                if numberCell_string(ith_character)~='0' && (flag_number_started==0)
                    starting_index = ith_character;
                    flag_number_started = 1;
                    %                 elseif numberCell_string(ith_character)=='0' && numberCell_string(ith_character+1)=='.' &&  (flag_number_started==0)
                    %                     % This is the special case of numbers such as '0.4'
                    %                     starting_index = ith_character;
                    %                     flag_number_started = 1;
                end
            end
            if flag_number_started==0
                starting_index = length(numberCell_string);
            end
            good_numberCell_string = numberCell_string(starting_index:end);

            % Add a leading zero back in?
            if good_numberCell_string(1)=='.'
                good_numberCell_string = cat(2,'0',good_numberCell_string);
            end

            % Add a leading negative sign back in?
            if flag_is_negative
                good_numberCell_string = cat(2,'-',good_numberCell_string);
            end
            outputNumberCell = {good_numberCell_string};
        end % Ends check if Numbercell is empty
    end % Ends check if match is empty
end % Ends check if string is empty


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
if flag_do_plots

    % Nothing to do here


end

if flag_do_debug
    fprintf(1,'ENDING function: %s, in file: %s\n\n',st(1).name,st(1).file);
end

end % Ends main function




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

