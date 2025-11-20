function [Flag_StringsMatch] = fcn_DebugTools_doStringsMatch(...
    InputAnswer,...
    CorrectAnswer, varargin)

% fcn_DebugTools_doStringsMatch
% Checks if an input string matches the "correct answer" string.
% This handles as well situations where the input, such as 'a',
% is a member of possible answers 'abd'. The function returns true if they
% match, false if not. It will also reject "spam" inputs such as 'aaa' for
% inputs 'abc'.
%
% FORMAT:
%
%     [Flag_StringsMatch] = fcn_DebugTools_doStringsMatch(...
%         InputAnswer,...
%         CorrectAnswer, (figNum))
%
% INPUTS:
%
%      InputAnswer: a string that is to be tested
%
%      CorrectAnswer: the string that contains the input answer
%
%      (OPTIONAL INPUTS)
%
%      figNum: a figure number to plot results. If set to -1, skips any
%      input checking or debugging, no figures will be generated, and sets
%      up code to maximize speed. 
%
% OUTPUTS:
%
%      flag_stringsMatch
%
% DEPENDENCIES:
%
%      fcn_DebugTools_checkInputsToFunctions
%
% EXAMPLES:
%
%     See the script: script_test_fcn_DebugTools_doStringsMatch
%     for a full test suite.
%
% This function was written on 2022_12_09 by S. Brennan
% Questions or comments? sbrennan@psu.edu

% REVISION HISTORY:
% 
% 2022_12_09:
% - wrote the code originally
% 
% 2023_01_17:
% - Moved out of the AutoExam codeset, into DebugTools
% - Add test scripts
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
% - Add input argument checking

%% Debugging and Input checks

% Check if flag_max_speed set. This occurs if the figNum variable input
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
        narginchk(2,MAX_NARGIN);

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


try
    % Cannot let the student give more answers than allowed. If this is the
    % case, then automatically wrong. If the strings are same length, then
    % check if any of them match.
    if length(InputAnswer) > length(CorrectAnswer) % Are the student answers longer than the problem allows? If so, wrong
        Flag_StringsMatch = false;
    % OLD: elseif length(InputAnswer)==1 && any(lower(CorrectAnswer) == lower(InputAnswer)) 
    elseif isscalar(InputAnswer) && any(lower(CorrectAnswer) == lower(InputAnswer)) 
        % This format is used for Multiple Choice: ('a', 'b', or 'c'). If so, the
        % student's answer will be a single character and the correct
        % answer will be a string that may be more than one character,
        % since more than one can be right. If so, check: do the strings match? If so, right!
        % NOTE: this also marks correct answers such as "y" when answer is
        % "yes", or "n" when answer is "no".
        Flag_StringsMatch = true;
    elseif strcmpi(InputAnswer,CorrectAnswer) % Are strings non-zero length, but match exactly? If so, right!
        Flag_StringsMatch = true;
    else % The strings are same length, but do not match so this is wrong
        Flag_StringsMatch = false;
    end
catch
    error('A string condition was found that threw an error!')
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

%% fcn_DebugTools_doStringsMatch




