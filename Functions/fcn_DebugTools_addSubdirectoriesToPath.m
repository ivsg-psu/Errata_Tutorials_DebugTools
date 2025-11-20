function fcn_DebugTools_addSubdirectoriesToPath(root_path, subdirectories, varargin)
% fcn_DebugTools_addSubdirectoriesToPath
% Given a path, and a cell array of subdirectories, adds the subdirectories
% to the path, if they exist under the given path. It throws an error if
% the subdirectories do not exist
%
% FORMAT:
%
%      fcn_DebugTools_addSubdirectoriesToPath(root_path,subdirectories, (figNum))
%
% INPUTS:
%
%      root_path: a string of the path location
% 
%      subdirectories: a cell array of strings containing subdirectories,
%      for example {'Functions','Data','Utilities'}
%
%      (OPTIONAL INPUTS)
%
%      figNum: a figure number to plot results. If set to -1, skips any
%      input checking or debugging, no figures will be generated, and sets
%      up code to maximize speed. 
%
% OUTPUTS:
%
%      (none)
%
% DEPENDENCIES:
%
%      (none)
%
% EXAMPLES:
%
% See the script: script_test_fcn_DebugTools_addSubdirectoriesToPath
% for a full test suite.
%
% This function was written on 2022_03_27 by S. Brennan 
% Questions or comments? sbrennan@psu.edu

% REVISION HISTORY:
% 
% 2022_03_27 by Sean Brennan, sbrennan@psu.edu
% - first write of the code
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
% - (none)

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


% add necessary directories
if isempty(subdirectories)
    if(exist(root_path,'dir'))
        addpath(root_path);
    else % Throw an error?
        error('There was an attempt to add directory: \n%s \nto the path but the subdirectory does not exist. Suggest checking the README file to ensure correct folders are included.',...
            root_path);
    end
else
    for ith_subdirectory = 1:length(subdirectories)
        subdirectory_name = subdirectories{ith_subdirectory};
        if(exist([root_path, filesep,  subdirectory_name],'dir'))
            addpath(genpath([root_path, filesep, subdirectory_name]))
        else % Throw an error?
            error('There was an attempt to add subdirectory: \n%s \nto the path: \n%s\nbut the subdirectory does not exist. Suggest checking the README file to ensure correct folders are included.',...
                subdirectory_name,root_path);
        end
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

end % Ends the function

