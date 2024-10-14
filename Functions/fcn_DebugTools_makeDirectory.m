function fcn_DebugTools_makeDirectory(directoryPath, varargin)
% fcn_DebugTools_makeDirectory
% Creates a directory given a directory path, even if directory is a full
% path, directory would not exist as a direct subfolder in current folder.
% Note: the directory can only be made as a deeper folder within current
% folder.
%
% FORMAT:
%
%      fcn_DebugTools_makeDirectory(directoryPath, (fid))
%
% INPUTS:
%
%      directoryPath: a string containing the path to the directory to
%      create
%
%      (OPTIONAL INPUTS)
%
%      fid: the fileID where to print. Default is 1, to print results to
%      the console. If set to -1, skips any input checking or debugging, no
%      prints will be generated, and sets up code to maximize speed.
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
%     See the script: script_test_fcn_DebugTools_makeDirectory
%     for a full test suite.
%
% This function was written on 2024_10_13 by S. Brennan
% Questions or comments? sbrennan@psu.edu

% Revision history
% 2024_09_13 - Sean Brennan, sbrennan@psu.edu
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
    MATLABFLAG_DATACLEAN_FLAG_CHECK_INPUTS = getenv("MATLABFLAG_DATACLEAN_FLAG_CHECK_INPUTS");
    MATLABFLAG_DATACLEAN_FLAG_DO_DEBUG = getenv("MATLABFLAG_DATACLEAN_FLAG_DO_DEBUG");
    if ~isempty(MATLABFLAG_DATACLEAN_FLAG_CHECK_INPUTS) && ~isempty(MATLABFLAG_DATACLEAN_FLAG_DO_DEBUG)
        flag_do_debug = str2double(MATLABFLAG_DATACLEAN_FLAG_DO_DEBUG);
        flag_check_inputs  = str2double(MATLABFLAG_DATACLEAN_FLAG_CHECK_INPUTS);
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

        % % Check if rootdirs is a string. If so, convert it to a cell array
        % if ~iscell(rootdirs) && (isstring(rootdirs) || ischar(rootdirs))
        %     rootdirs{1} = rootdirs;
        % end
        % 
        % % Loop through all the directories and make sure they are there
        % for ith_directory = 1:length(rootdirs)
        %     folderName = rootdirs{ith_directory};
        %     try
        %         fcn_DebugTools_checkInputsToFunctions(folderName, 'DoesDirectoryExist');
        %     catch ME
        %         warning('on','backtrace');
        %         warning('A directory was specified for query that does not seem to exist!?');
        %         warning('The missing folder is: %s',folderName);
        %         rethrow(ME)
        %     end
        % end

    end
end

% Does user want to specify fid?
fid = 0; % Default is NOT to print
if (0 == flag_max_speed) && (2 <= nargin)
    temp = varargin{end};
    if ~isempty(temp)
        fid = temp;
    end
end

flag_do_plots = 0; % Nothing to plot


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


if 7~=exist(directoryPath,'dir')
    % Need to make the directory

    % Find full path
    full_path_directory_to_create = fullfile(directoryPath);

    % Find part below current directory
    relativePath = extractAfter(full_path_directory_to_create,cat(2,cd(),filesep));

    [successFlag,message] = mkdir(cd,relativePath);
    if 1~=successFlag 
        warning('on','backtrace');
        warning('Unable to create directory: %s. Message given:',fullPathDirectoryToCheck,message);
        error('Image save specified that directory be created, but cannot create directory. Unable to continue.');
    end
    
    % % Split the relativePath into parts
    % pathParts = split(relativePath,filesep);
    % previousParentPath = cd();
    % for ith_directory = 1:length(pathParts)
    %     directoryToCheck = pathParts{ith_directory};
    %     fullPathDirectoryToCheck = fullfile(previousParentPath,directoryToCheck);
    % 
    %     % Does the directory exist, or do we need to make it?
    %     if 7~=exist(fullPathDirectoryToCheck,'dir')
    %         % Need to make the directory
    %         successFlag = mkdir(previousParentPath,directoryToCheck);
    %         if 1~=successFlag
    %             warning('on','backtrace');
    %             warning('Unable to create directory: %s',fullPathDirectoryToCheck)
    %             error('Image save specified that directory be created, but cannot create directory. Unable to continue.');
    %         end
    %     end
    % 
    %     previousParentPath = fullfile(previousParentPath,directoryToCheck);
    % 
    % end

    if fid>0
        fprintf(fid,'Successfully created directory: %s\n',full_path_directory_to_create);
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
if (1==flag_do_plots)

    % Nothing to plot!

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

