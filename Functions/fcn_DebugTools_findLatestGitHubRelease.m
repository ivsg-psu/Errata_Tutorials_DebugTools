function latestReleaseStruct = fcn_DebugTools_findLatestGitHubRelease(owner, repo, varargin) 
% FCN_DEBUGTOOLS_FINDLATESTGITHUBRELEASE Finds and displays the latest release of a GitHub repository.
%
%   fcn_DebugTools_findLatestGitHubRelease(owner, repo) takes the GitHub repository owner
%   (username or organization) and the repository name as input and
%   displays information about the latest release.
% 
% FORMAT:
% 
%    latestReleaseStruct = fcn_DebugTools_findLatestGitHubRelease(owner, repo, varargin) 
% 
% INPUTS:
% 
%     owner: a string representing the GitHub repo owner ID. 
% 
%     repo: a string representing the repo name
% 
%     (optional inputs)
%
%     figNum: any number that acts somewhat like a figure number output. 
%     If given, this forces the variable types to be displayed as output 
%     and as well makes the input check process verbose.
% 
% OUTPUTS:
% 
%     (optional outputs)
%
%     latestReleaseStruct: a structure containing the details on the latest
%     release of the repo, including: 
%
%                  url: 'https://api.github.com/repos/ivsg-psu/FieldDataCollection_VisualizingFieldData_PlotRoad/releases/260467643'
%           assets_url: 'https://api.github.com/repos/ivsg-psu/FieldDataCollection_VisualizingFieldData_PlotRoad/releases/260467643/assets'
%           upload_url: 'https://uploads.github.com/repos/ivsg-psu/FieldDataCollection_VisualizingFieldData_PlotRoad/releases/260467643/assets{?name,label}'
%             html_url: 'https://github.com/ivsg-psu/FieldDataCollection_VisualizingFieldData_PlotRoad/releases/tag/PlotRoad_v2025_11_06'
%                   id: 260467643
%               author: [1×1 struct]
%              node_id: 'RE_kwDOMjekAc4Phmu7'
%             tag_name: 'PlotRoad_v2025_11_06'
%     target_commitish: 'main'
%                 name: 'PlotRoad_v2025_11_06'
%                draft: 0
%            immutable: 0
%           prerelease: 0
%           created_at: '2025-11-07T02:44:51Z'
%           updated_at: '2025-11-07T02:47:10Z'
%         published_at: '2025-11-07T02:47:10Z'
%               assets: []
%          tarball_url: 'https://api.github.com/repos/ivsg-psu/FieldDataCollection_VisualizingFieldData_PlotRoad/tarball/PlotRoad_v2025_11_06'
%          zipball_url: 'https://api.github.com/repos/ivsg-psu/FieldDataCollection_VisualizingFieldData_PlotRoad/zipball/PlotRoad_v2025_11_06'
%                 body: (the changelog)
% 
% 
% DEPENDENCIES:
% 
%    (none)
% 
% EXAMPLES:
% 
%     owner = 'ivsg-psu';
%     repo = 'FieldDataCollection_VisualizingFieldData_PlotRoad';
%     latestRelease = fcn_DebugTools_findLatestGitHubRelease(owner, repo)
% 
% This function was written on 2021_12_12 by S. Brennan by modifying the
% similar function from the MapGen class.
%
% Questions or comments? contact sbrennan@psu.edu

% REVISION HISTORY:
%
% 2025_11_07 by Sean Brennan, sbrennan@psu.edu
% - first write of function
%
% 2025_11_20 by Sean Brennan, sbrennan@psu.edu
% - Formatted revision lists to Markdown format
% - Fixed variable naming for clarity:
%   % * fig_+num to figNum
%
% 2025_11_22 by Sean Brennan, sbrennan@psu.edu
% - In fcn_DebugTools_findLatestGitHubRelease
%   % * Made error handling more verbose
%   % * Added warn+ings with 'backtrace' option on

% TO-DO:
% 2025_11_20 by Sean Brennan, sbrennan@psu.edu
% - fill in to-do items here.

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
    debug_figNum = 999978;
else
    debug_figNum = [];
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
        figNum = temp;
        flag_do_plots = 1;
    end
end

% Setup figures if there is debugging
if flag_do_debug
    fig_debug = 159; 
else
    fig_debug = []; %#ok<*NASGU>
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
%See: http://patorjk.com/software/taag/#p=display&f=Big&t=Main
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%§


% Construct the API URL for the latest release
apiUrl = sprintf('https://api.github.com/repos/%s/%s/releases/latest', owner, repo);

% Make the web request
try
    latestReleaseStruct = webread(apiUrl);
catch ME
    warning('backtrace','on');
    warning('Unable to find API url link - throwing error')
    error('Error fetching release information for: \n\tOwner: %s\n\tRepo: %s\n\t Error message: %s\n', owner, repo, ME.message);
    return;
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
    % Extract and display release information
    disp(['Repository: ', owner, '/', repo]);
    if isfield(latestReleaseStruct, 'tag_name')
        disp(['Latest release version: ', latestReleaseStruct.tag_name]);
    else
        disp('Could not find tag_name in the release information.');
    end

    if isfield(latestReleaseStruct, 'name')
        disp(['Release Name: ', latestReleaseStruct.name]);
    end

    if isfield(latestReleaseStruct, 'published_at')
        disp(['Published At: ', latestReleaseStruct.published_at]);
    end

    if isfield(latestReleaseStruct, 'body')
        disp('Release Notes:');
        disp(latestReleaseStruct.body);
    end
end % Ends the flag_do_plot if statement

if flag_do_debug
    fprintf(1,'ENDING function: %s, in file: %s\n\n',st(1).name,st(1).file);
end


end % Ends the function

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


