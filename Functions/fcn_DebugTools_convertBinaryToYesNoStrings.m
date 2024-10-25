function cellArrrayYesNo = fcn_DebugTools_convertBinaryToYesNoStrings(flags_binary, varargin)
% Converts Nx1 of scalar 1 or 0 vectors into Nx1 cell arrays containing
% 'yes' or 'no' corresponding to the 1's or 0's respectively
%
% FORMAT:
%
%      cellArrrayYesNo = fcn_DebugTools_convertBinaryToYesNoStrings(flags_binary, (fid))
%
% INPUTS:
%
%      flags_binary: a column array, [N x 1], of 1's or 0's
%
%      (OPTIONAL INPUTS)
%
%      fid: the fileID where to print. Default is 0, to NOT print results to
%      the console. If set to -1, skips any input checking or debugging, no
%      prints will be generated, and sets up code to maximize speed.
%
% OUTPUTS:
%
%      cellArrrayYesNo: a cell array of N rows, 1 column, of 'yes' or 'no'
%      strings
%
% DEPENDENCIES:
%
%      (none)
%
% EXAMPLES:
%
%     See the script: script_test_fcn_DebugTools_convertBinaryToYesNoStrings
%     for a full test suite.
%
% This function was written on 2024_10_24 by S. Brennan
% Questions or comments? sbrennan@psu.edu

% Revision history
% 2024_10_24 - Sean Brennan, sbrennan@psu.edu
% -- wrote the code originally, copying out of DataClean library

%% Debugging and Input checks

% Check if flag_max_speed set. This occurs if the fig_num variable input
% argument (varargin) is given a number of -1, which is not a valid figure
% number.
flag_max_speed = 0;
if (nargin==2 && isequal(varargin{end},-1))
    flag_do_debug = 0; % % % % Flag to plot the results for debugging
    flag_check_inputs = 0; % Flag to perform input checking
    flag_max_speed = 1;
else
    % Check to see if we are externally setting debug mode to be "on"
    flag_do_debug = 0; % % % % Flag to plot the results for debugging
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
    debug_fig_num = 999978; %#ok<NASGU>
else
    debug_fig_num = []; %#ok<NASGU>
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

if (0 == flag_max_speed)
    if flag_check_inputs == 1
        % Are there the right number of inputs?
        narginchk(1,2);

    end
end

% Does user want to specify fid?
fid = 0; % Default is to NOT print to console
if (0 == flag_max_speed) && (2 <= nargin)
    temp = varargin{end};
    if ~isempty(temp)
        fid = temp;
    end
end

flag_do_plots = 0; %#ok<NASGU> % Nothing to plot


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

sizeFlags = size(flags_binary);
Nflags = sizeFlags(1,1);
cellArrrayYesNo = cell(Nflags,1);
for ith_cell = 1:Nflags
    if 0==flags_binary(ith_cell,1)
        cellArrrayYesNo{ith_cell,1} = 'no';
    else
        cellArrrayYesNo{ith_cell,1} = 'yes';
    end
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
if (1==fid)

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

