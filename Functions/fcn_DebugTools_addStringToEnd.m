function outputString = fcn_DebugTools_addStringToEnd(inputString, valueToAdd, varargin)
%% fcn_DebugTools_addStringToEnd
% Adds information to a string. The input is the starter string.
% The value to add can be a cell array, string, or numeric. 
%
% If it is a cell array, the first index of the cell is appended. An
% optional index value can be given to specify a different cell.
%
% If it is a string or character, then it is appended
%
% If it is numeric, the numeric value is formatted to be "pretty" to read
% using fcn_AutoExam_number2string functionality
%
% FORMAT:
%
%      outputString = fcn_DebugTools_addStringToEnd(inputString,valueToAdd, (index), (figNum))
%
% INPUTS:
%
%      inputString: the string to start with
%
%      (OPTIONAL INPUTS)
%
%      figNum: a figure number to plot results. If set to -1, skips any
%      input checking or debugging, no figures will be generated, and sets
%      up code to maximize speed. 
%
% OUTPUTS:
%
%      valueToAdd: the numeric, string, or cell value to add
%
%      (OPTIONAL INPUTS)
%      index: the index of a call array, if passed as the valueToAdd, to use
%
%
% DEPENDENCIES:
%
%      fcn_DebugTools_checkInputsToFunctions
%
%
% EXAMPLES:
%
%     See the script: script_test_fcn_DebugTools_addStringToEnd
%     for a full test suite.
%
% This function was written on 2022_11_14 by S. Brennan
% Questions or comments? sbrennan@psu.edu

% REVISION HISTORY:
% 
% 2022_11_14 by Sean Brennan, sbrennan@psu.edu
% - wrote the code originally by copying out of old Exam2 code
% 
% 2023_01_17 by Sean Brennan, sbrennan@psu.edu
% - added code to the DebugTools repo
% - Add test scripts
% 
% 2025_11_12 by Sean Brennan, sbrennan@psu.edu
% - Updated debug flags
% - Added figNum input
% - Fixed variable naming for clarity:
%   % * input_string to inputString
%   % * outputString to outputString
%   % * value_to_add to valueToAdd
%
% 2025_11_20 by Sean Brennan, sbrennan@psu.edu
% - Formatted revision lists to Markdown format
% - Fixed variable naming for clarity:
%   % * fig_+num to figNum


% TO-DO:
% 2025_11_20 by Sean Brennan, sbrennan@psu.edu
% - Add input argument checking

%% Debugging and Input checks

% Check if flag_max_speed set. This occurs if the figNum variable input
% argument (varargin) is given a number of -1, which is not a valid figure
% number.
MAX_NARGIN = 4; % The largest Number of argument inputs to the function
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
        narginchk(2,MAX_NARGIN);

        % if nargin>=2
        %     % Check the variableTypeString input, make sure it is characters
        %     if ~ischar(variableTypeString)
        %         error('The variableTypeString input must be a character type, for example: ''Path'' ');
        %     end
        % end

    end
end

% Does user want to specify the index_value input?
index_value = 1; % Default is not to force installs
if 3 <= nargin
    temp = varargin{1};
    if ~isempty(temp)
        index_value = temp;
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


if iscell(valueToAdd)
    outputString = cat(2,inputString,' ',valueToAdd{index_value});
elseif isstring(valueToAdd) || ischar(valueToAdd)
    outputString = cat(2,inputString,' ',valueToAdd);    
elseif isnumeric(valueToAdd)
    outputString = cat(2,inputString,' ',fcn_DebugTools_number2string(valueToAdd));
end



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
