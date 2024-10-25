function flags_wasMatched = fcn_DebugTools_compareDirectoryListings(directoryListing_source, sourceRootString, destinationRootString, varargin)
%fcn_DebugTools_compareDirectoryListings
% compares a source and destination directory to check if files are located
% in destination directory that match the source directory. 
%
% FORMAT:
%
%      flags_wasMatched = fcn_DebugTools_compareDirectoryListings(directoryListing_source, sourceRootString, destinationRootString, (flag_matchingType), (typeExtension), (fid))
%
% INPUTS:
%
%      directoryListing_source: a structure array that is the output of a
%      "dir" command. A typical output can be generated using:
%      directory_filelist = fcn_DebugTools_listDirectoryContents({cd});
%
%      sourceRootString: a string that lists the root of the
%      directoryListing_source, e.g. the bottom directory of the source
%      above which the content organization should be mirrored in the
%      destination directory
%
%      destinationRootString: a string that lists the root of the
%      directoryListing_source, e.g. the bottom directory of the source
%      above which the content organization should be mirrored in the
%      destination directory
%
%      (OPTIONAL INPUTS)
%
%      flag_matchingType: a flag that sets the type of matching. Values
%      include:
%          
%           1: matches same type to same type (e.g., if the listings are
%           files in the source, matches to files in the destination. If
%           the listings are folders in the source, looks for folders in
%           the destination.
%
%           2: fileToFolder - matches files in the source to folders in the
%           destination
%
%           3: folderToFile - matches folders in the source to files in the
%           destination
% 
%      typeExtension: the file type extension to add or omit, if
%      fileToFolder or folderToFile is set. Default is to use '.m'
%
%      fid: the fileID where to print. Default is 0, to NOT print results to
%      the console. If set to -1, skips any input checking or debugging, no
%      prints will be generated, and sets up code to maximize speed.
%
% OUTPUTS:
%
%      flags_wasMatched: a flag vector of Nx1 where N is the number of
%      listings in the source directory. The flag is set to 1 if the
%      listing in the source was found in the destination, and set to 0 if
%      not found.
%
% DEPENDENCIES:
%
%      (none)
%
% EXAMPLES:
%
%     See the script: script_test_fcn_DebugTools_compareDirectoryListings
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
if (nargin==6 && isequal(varargin{end},-1))
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
        narginchk(3,6);

    end
end

% Does user want to specify flag_matchingType?
flag_matchingType = 1; % Default is 1
if (4 <= nargin)
    temp = varargin{1};
    if ~isempty(temp)
        flag_matchingType = temp;
    end
end

% Does user want to specify typeExtension?
typeExtension = '.m'; % Default
if (4 <= nargin)
    temp = varargin{1};
    if ~isempty(temp)
        flag_matchingType = temp;
    end
end



% Does user want to specify fid?
fid = 0; % Default is to NOT print to console
if (0 == flag_max_speed) && (5 <= nargin)
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


NsourceFiles = length(directoryListing_source);
flags_wasMatched = zeros(NsourceFiles,1);

for ith_index = 1:NsourceFiles
    thisIndexName        = directoryListing_source(ith_index).name;
    thisFolderFillName   = directoryListing_source(ith_index).folder;
    thisFolder           = extractAfter(thisFolderFillName,sourceRootString);

    destinationFolder  = cat(2,destinationRootString,thisFolder);    
    destinationFullPath = fullfile(destinationFolder,thisIndexName);

    switch flag_matchingType
        case 1
            % Matching same to same
            if 1==directoryListing_source(ith_index).isdir
                if 7==exist(destinationFullPath,'dir')
                    flags_wasMatched(ith_index,1) = 1;
                end
            else
                if 2==exist(destinationFullPath,'file')
                    flags_wasMatched(ith_index,1) = 1;
                end
            end
        case 2
            % fileToFolder
            fixed_destinationFullPath = extractBefore(destinationFullPath,typeExtension);
            if 7==exist(fixed_destinationFullPath,'dir')
                flags_wasMatched(ith_index,1) = 1;
            end

        case 3
            % folderToFile
            fixed_destinationFullPath = cat(2,destinationFullPath,typeExtension);
            if 2==exist(fixed_destinationFullPath,'file')
                flags_wasMatched(ith_index,1) = 1;
            end
            
        otherwise
            error('Unknown matching type encountered: %.0d',flag_matchingType);
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

