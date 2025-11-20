function directory_filelist  = fcn_DebugTools_listDirectoryContents(rootdirs, varargin)
% fcn_DebugTools_listDirectoryContents
% Creates a list of specified root directories, including all
% subdirectories, of a given query. Allows specification whether to keep
% either files, directories, or both.
%
% FORMAT:
%
%      directory_filelist = fcn_DebugTools_listDirectoryContents(rootdirs, (fileQueryString), (flag_fileOrDirectory), (fid))
%
% INPUTS:
%
%      rootdirs: either a string containing the folder name(s) where to
%      query, or a cell array of names of folder locations. NOTE: the
%      folder locations should be complete paths.
%
%      (OPTIONAL INPUTS)
%
%      fileQueryString: the prefix used to perform the query to search for
%      file or directory listings. All directories within the rootdirs, and
%      any subdirectories of these, are processed. The default
%      fileQueryString, if left empty, is to query everything: '*.*'.
%
%      flag_fileOrDirectory: a flag to specify whether files or directories
%      are returned.
% 
%         set to 0 to return only files and no directories
% 
%         set to 1 to return only directories and no files
%
%         set to 2 to return both files and directories (default)
%
%      fid: the fileID where to print. Default is 1, to print results to
%      the console. If set to -1, skips any input checking or debugging, no
%      prints will be generated, and sets up code to maximize speed.
%
% OUTPUTS:
%
%      directory_filelist: a structure array of listings, one for each
%      found match
%
% DEPENDENCIES:
%
%      fcn_DebugTools_checkInputsToFunctions
%
% EXAMPLES:
%
%     See the script: script_test_fcn_DebugTools_listDirectoryContents
%     for a full test suite.
%
% This function was written on 2024_10_13 by S. Brennan
% Questions or comments? sbrennan@psu.edu

% REVISION HISTORY:
% 
% 2024_10_13 by Sean Brennan, sbrennan@psu.edu
% - wrote the code originally, copying out of DataClean library
% 
% 2025_11_12 by Sean Brennan, sbrennan@psu.edu
% - Updated debug flags
% - Added figNum input
% - Fixed variable naming for clarity:
%
% 2025_11_20 by Sean Brennan, sbrennan@psu.edu
% - Formatted revision lists to Markdown format
% - Fixed variable naming for clarity:
%   % * fig_+num to figNum

% TO-DO:
% 
% 2025_11_20 by Sean Brennan, sbrennan@psu.edu
% - fill in to-do items here.

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
        narginchk(1,MAX_NARGIN);

        % Check if rootdirs is a string. If so, convert it to a cell array
        if ~iscell(rootdirs) && (isstring(rootdirs) || ischar(rootdirs))
            rootdirs{1} = rootdirs;
        end

        % Loop through all the directories and make sure they are there
        for ith_directory = 1:length(rootdirs)
            folderName = rootdirs{ith_directory};
            try
                fcn_DebugTools_checkInputsToFunctions(folderName, 'DoesDirectoryExist');
            catch ME
                warning('on','backtrace');
                warning('A directory was specified for query that does not seem to exist!?');
                warning('The missing folder is: %s',folderName);
                rethrow(ME)
            end
        end

    end
end

% Does user want to specify fileQueryString?
fileQueryString = '*.*';
if 2 <= nargin
    temp = varargin{1};
    if ~isempty(temp)
        fileQueryString = temp;
    end
end

% Does user want to specify flag_fileOrDirectory?
flag_fileOrDirectory = 2;
if 3 <= nargin
    temp = varargin{2};
    if ~isempty(temp)
        flag_fileOrDirectory = temp;
    end
end

% Does user want to specify fid?
fid = 0;
if (0 == flag_max_speed) && (4 <= nargin)
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

%% Check if rootdirs is a string. If so, convert it to a cell array
if ~iscell(rootdirs) && (isstring(rootdirs) || ischar(rootdirs))
    rootdirs{1} = rootdirs;
end

%% Find all the directories that will be queried
directory_filelist = [];
if fid>0
    fprintf(fid,'\nSEARCHING DIRECTORIES, searching for: %s\n',fileQueryString);
end

for ith_rootDirectory = 1:length(rootdirs)
    rootdir = rootdirs{ith_rootDirectory};
    if  fid>0
        fprintf(fid,'Loading directory candidates from directory: %s\n',rootdir);
    end

    directoryQuery = fullfile(rootdir, '**',fileQueryString);
    filelist = dir(directoryQuery);  % gets list of files and folders in any subfolder that start with name 'mapping_van_'

    % For debugging
    if 1==0 && length(fileQueryString)>3 && strcmp(fileQueryString(1:4),'hash')
        rootdir = 'C:\MappingVanData\Temp';
        fileQueryString = 'hashVelodyne_2*';
        filelist = fcn_INTERNAL_queryHash(rootdir, fileQueryString);
    end

    switch flag_fileOrDirectory
        case 0  
            % Files only
            fileListToAdd = filelist([filelist.isdir]==0);
        case 1
            % Directories only
            fileListToAdd = filelist(find([filelist.isdir].*[(~strcmp({filelist.name},'..'))]==1)); %#ok<NBRAK1,FNDSB>
        case 2
            % Both
            fileListToAdd = filelist;
    end

    directory_filelist = [directory_filelist; fileListToAdd];  %#ok<AGROW> % keep only directories from list
    if fid>0
        fprintf(fid,'\tCandidates found in directory: %.0f\n',length(fileListToAdd));
    end
end

if  fid>0
    fprintf(fid,'Total candidates found: %.0f\n',length(directory_filelist));
end

if  fid>0
    % Print the directory
    titleString = [];
    rootDirectoryString = [];
    fcn_DebugTools_printDirectoryListing(directory_filelist, (titleString), (rootDirectoryString), (fid))

    % fprintf(fid,'\nCONTENTS FOUND:\n');
    % % Print the fields
    % previousDirectory = '';
    % for jth_file = 1:length(directory_filelist)
    %     thisFolder = directory_filelist(jth_file).folder;
    %     if ~strcmp(thisFolder,previousDirectory)
    %         previousDirectory = thisFolder;
    %         fprintf(fid,'Folder: %s\n',thisFolder);
    %     end
    %     if (0==flag_fileOrDirectory) || (2==flag_fileOrDirectory)
    %         fprintf(fid,'\t%s\n',directory_filelist(jth_file).name);
    %     end
    % end
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
%% fcn_INTERNAL_queryHash
function all_filelist = fcn_INTERNAL_queryHash(rootdir, fileQueryString)

% Check for folders in this rootdir that contain the fileQueryString
% For debugging
directoryQuery = fullfile(rootdir, fileQueryString);
filelist = dir(directoryQuery);
if ~isempty(filelist)
    all_filelist = filelist;
else
    all_filelist = []; % Produce an empty result
end

% Check for sub-folders ONLY for folders that are not hash tables
if ~contains(rootdir,'hash')
    thisFolderContents = dir(rootdir);
    % Keep directories only
    directoriesToSearch = thisFolderContents(find([thisFolderContents.isdir].*[(~strcmp({thisFolderContents.name},'..'))].*[(~strcmp({thisFolderContents.name},'.'))]==1)); %#ok<NBRAK1,FNDSB>
    for ith_directory = 1:length(directoriesToSearch)
        folderToSearch = fullfile(directoriesToSearch(ith_directory).folder,directoriesToSearch(ith_directory).name);
        searchResult = fcn_INTERNAL_queryHash(folderToSearch, fileQueryString);
        all_filelist = [all_filelist; searchResult]; %#ok<AGROW>
    end
end

end % Ends fcn_INTERNAL_queryHash

