function indicies_cell_array = fcn_DebugTools_breakArrayByNans(input_array, varargin)
%fcn_DebugTools_breakArrayByNans   
% 
% breaks data separated by nan into subdata organized into cell arrays. For
% example, 
%    test_data = [2; 3; 4; nan; 6; 7];
%    indicies_cell_array = fcn_DebugTools_breakArrayByNans(test_data);
% % Returns:
%    indicies_cell_array{1} = [1; 2; 3];
%    indicies_cell_array{2} = [5; 6];
%
% FORMAT:
%
%       indicies_cell_array = fcn_DebugTools_breakArrayByNans(input_array, (fig_num))
%
% INPUTS:
%
%       input_array: an Nx1 matrix where some rows contain NaN values
%
%      (OPTIONAL INPUTS)
%
%      fig_num: a figure number to plot results. If set to -1, skips any
%      input checking or debugging, no figures will be generated, and sets
%      up code to maximize speed.
%
% OUTPUTS:
%
%       indicies_cell_array: a cell array of indicies, one array for each
%       section of the matrix that is separated by NaN values
%
% DEPENDENCIES:
%
%      (none)
%
% EXAMPLES:
%
%       See the script:
%       script_test_fcn_DebugTools_breakArrayByNans.m for a full
%       test suite.
%
% This function was written on 2023_07_14 by S. Brennan
% Questions or comments? sbrennan@psu.edu


% Revision history:
% As: script_test_fcn_PlotRoad_breakArrayByNans
% 2023_07_14 by S. Brennan
% -- start writing function
% 2025_11_01 - Aneesh Batchu
% -- Added MAX_NARGIN option to the function
% -- Added debug tools to check the inputs
%
% As: script_test_fcn_DebugTools_breakArrayByNans
% 2025_11_04 - S. Brennan, sbrennan@psu.edu
% -- added function to DebugTools library
% -- updated docstrings
% -- added explicit return statements in several subsections where these 
%    % were missing

%% Debugging and Input checks

% Check if flag_max_speed set. This occurs if the fig_num variable input
% argument (varargin) is given a number of -1, which is not a valid figure
% number.
MAX_NARGIN = 2; % The largest Number of argument inputs to the function
flag_max_speed = 0;
if (nargin==MAX_NARGIN && isequal(varargin{end},-1))
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
    debug_fig_num = 999978;
else
    debug_fig_num = [];
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

        if isscalar(input_array)
            error('input_array should be a vector')
        end

    end
end

% Check to see if user specifies fig_num?
flag_do_plots = 0;
if (0==flag_max_speed) && (1<= nargin)
    temp = varargin{end};
    if ~isempty(temp)
        fig_num = temp;
        flag_do_plots = 1;
    end
end

% Setup figures if there is debugging
if flag_do_debug
    fig_debug = 9999; 
else
    fig_debug = []; %#ok<*NASGU>
end

% no plotting in this
%% Write main code for plotting
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   __  __       _
%  |  \/  |     (_)
%  | \  / | __ _ _ _ __
%  | |\/| |/ _` | | '_ \
%  | |  | | (_| | | | | |
%  |_|  |_|\__,_|_|_| |_|
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

N_points = length(input_array(:,1));
good_indicies = find(~isnan(input_array(:,1)));
if isempty(good_indicies)
    % There is nothing but Nans
    indicies_cell_array = {[]};
    return
elseif isequal(length(good_indicies),1)
    % Everything but 1 value is Nan
    indicies_cell_array = {good_indicies};
    return
else
    jumps = find(diff(good_indicies)>1);
    if isempty(jumps)
        % Good indicies strictly increasing
        indicies_cell_array = {good_indicies};
        return
    else
        % Initialize the array
        indicies_cell_array{length(jumps)+1} = [];
        prior_value = 1;
        for ith_jump = 1:length(jumps)
            current_jump = jumps(ith_jump);
            current_value = good_indicies(current_jump);
            indicies_cell_array{ith_jump} = (prior_value:current_value)';
            next_good_index = find(good_indicies>good_indicies(current_jump),1);
            if ~isempty(next_good_index)
                prior_value = good_indicies(next_good_index);
            else
                % Shift it past the end
                prior_value = N_points+1;
            end
        end
        if prior_value<=good_indicies(end)
            indicies_cell_array{length(jumps)+1} = (prior_value:good_indicies(end))';
        else
            indicies_cell_array{length(jumps)+1} = [];
        end
        return

    end
end

%% Any debugging?
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
% Plot the inputs?    
if flag_do_plots

    
    % Nothing to do here!
end

if flag_do_debug
    fprintf(1,'ENDING function: %s, in file: %s\n\n',st(1).name,st(1).file);
end

end % Ends main function for  fcn_DebugTools_breakArrayByNans

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
