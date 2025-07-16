function plotFormat = fcn_DebugTools_extractPlotFormatFromString(formatString, varargin)
%fcn_DebugTools_extractPlotFormatFromString    plots XY data with user-defined formatting strings
%
% FORMAT:
%
%      plotFormat = fcn_DebugTools_extractPlotFormatFromString(formatString, (fig_num))
%
% INPUTS:
%
%      formatString: a format string, e.g. 'b-', that dictates the plot
%      style, following MATLAB's convention
%
%      (OPTIONAL INPUTS)
%
%      fig_num: a figure number to plot results. If set to -1, skips any
%      input checking or debugging, no figures will be generated, and sets
%      up code to maximize speed.
%
% OUTPUTS:
%
%      plotFormat: a structure containing the Color, LineStyle, and
%      MarkerType that matches the formatString specifications
%
% DEPENDENCIES:
%
%      (none)
%
% EXAMPLES:
%
%       See the script:
%
%       script_test_fcn_DebugTools_extractPlotFormatFromString
%
%       for a full test suite.
%
% This function was written on 2024_08_12 by Sean Brennan
% Questions or comments? sbrennan@psu.edu

% Revision history
% 2024_08_12 - Sean Brennan
% -- Created function

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
    MATLABFLAG_PLOTROAD_FLAG_CHECK_INPUTS = getenv("MATLABFLAG_PLOTROAD_FLAG_CHECK_INPUTS");
    MATLABFLAG_PLOTROAD_FLAG_DO_DEBUG = getenv("MATLABFLAG_PLOTROAD_FLAG_DO_DEBUG");
    if ~isempty(MATLABFLAG_PLOTROAD_FLAG_CHECK_INPUTS) && ~isempty(MATLABFLAG_PLOTROAD_FLAG_DO_DEBUG)
        flag_do_debug = str2double(MATLABFLAG_PLOTROAD_FLAG_DO_DEBUG);
        flag_check_inputs  = str2double(MATLABFLAG_PLOTROAD_FLAG_CHECK_INPUTS);
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

if 0==flag_max_speed
    if flag_check_inputs == 1
        % Are there the right number of inputs?
        narginchk(1,2);

        if ~ischar(formatString) 
            error('The formatString input must be a character type, for example: ''b-'' , not "b-" ');
        end

    end
end

% Does user want to specify fig_num?
flag_do_plots = 0;
if (0==flag_max_speed) &&  (2<=nargin)
    temp = varargin{end};
    if ~isempty(temp)
        % fig_num = temp;
        flag_do_plots = 1;
    end
end


%% Solve for the Maxs and Mins
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   __  __       _
%  |  \/  |     (_)
%  | \  / | __ _ _ _ __
%  | |\/| |/ _` | | '_ \
%  | |  | | (_| | | | | |
%  |_|  |_|\__,_|_|_| |_|
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Initialize the outputs
formatColor = [];
formatMarkerStyle = [];
formatLineStyle = [];
plotFormat = [];

formatStringRemainder = formatString;

% Get the lineStyle
lineTypes = {'--','-.','-',':'};
for ith_lineType = 1:length(lineTypes)
    thisType = lineTypes{ith_lineType};
    [outputString, flag_matchFound] = fcn_INTERNAL_findResults(formatStringRemainder,thisType);
    if 1==flag_matchFound
        formatStringRemainder = outputString;
        plotFormat.LineStyle = thisType;
        formatLineStyle = thisType;
    end
end


% Get the color
colorTypes = {'b','g','r','c','m','y','k','w'};
for ith_lineType = 1:length(colorTypes)
    thisType = colorTypes{ith_lineType};
    [outputString, flag_matchFound] = fcn_INTERNAL_findResults(formatStringRemainder,thisType);
    if 1==flag_matchFound
        formatStringRemainder = outputString;
        switch thisType
            case 'b'
                plotFormat.Color = [0 0 1];
            case 'g'
                plotFormat.Color = [0 1 0];
            case 'r'
                plotFormat.Color = [1 0 0];
            case 'c'
                plotFormat.Color = [0 1 1];
            case 'm'
                plotFormat.Color = [1 0 1];
            case 'y'
                plotFormat.Color = [1 1 0];
            case 'k'
                plotFormat.Color = [0 0 0];
            case 'w'
                plotFormat.Color = [1 1 1];
            otherwise
                warning('on','backtrace');
                warning('An unkown input format is detected - throwing an error.')
                error('Unknown plotFormat input detected')
        end
        formatColor = plotFormat.Color;
    end
end

% Get the markerType
markerTypes = {'.','o.','x','+','*','s','d','v','^','<','>','p','h'};
for ith_lineType = 1:length(markerTypes)
    thisType = markerTypes{ith_lineType};
    [outputString, flag_matchFound] = fcn_INTERNAL_findResults(formatStringRemainder,thisType);
    if 1==flag_matchFound
        formatStringRemainder = outputString;
        plotFormat.Marker = thisType;
        formatMarkerStyle = thisType;
    end
end

if ~isempty(outputString)
    warning('on','backtrace');
    warning('Additional formatting characters detected - throwing an error.')
    error('Unknown formatting input detected')
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

    fprintf(1,'\n\nRESULTS:\n');
    fprintf(1,'\tInput string: \t%s\n', formatString);
    if ~isempty(formatColor)
        fprintf(1,'\tColor: \t%.0f %.0f %.0f\n', formatColor(1),  formatColor(2), formatColor(3));
    end
    if ~isempty(formatMarkerStyle)
        fprintf(1,'\tMarker: \t%s\n', formatMarkerStyle);
    end
    if ~isempty(formatLineStyle)
        fprintf(1,'\tLineStyle: \t%s\n', formatLineStyle);
    end

end % Ends check if plotting

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

function [outputString, flag_matchFound] = fcn_INTERNAL_findResults(str,expression)
flag_matchFound = 0;
outputString = [];
[matchResult, remainderCells] = regexp(str,expression,'match','split','forcecelloutput');
if ~isempty(matchResult{1})
    flag_matchFound = 1;
    outputString = '';
    remainderThisCell = remainderCells{1};
    for ith_cell = 1:length(remainderThisCell)

        outputString = cat(2,outputString, remainderThisCell{ith_cell});
    end
end

end

