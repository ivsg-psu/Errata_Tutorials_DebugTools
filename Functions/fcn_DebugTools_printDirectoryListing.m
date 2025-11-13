function fcn_DebugTools_printDirectoryListing(directory_filelist, varargin)
% fcn_DebugTools_printDirectoryListing
% Prints a listing of a directory into either a console, a file, or a
% markdown file with markdown formatting.
%
% FORMAT:
%
%      fcn_DebugTools_printDirectoryListing(directory_filelist, (titleString), (rootDirectoryString), (fid))
%
% INPUTS:
%
%      directory_filelist: a structure array that is the output of a
%      "dir" command. A typical output can be generated using:
%      directory_filelist = fcn_DebugTools_listDirectoryContents({cd});
%
%      (OPTIONAL INPUTS)
%
%      titleString: a title put at the top of the listing. The default is:
%      "CONTENTS FOUND:" 
%
%      rootDirectoryString: a string to specify the root directory of the query,
%      thus forcing a MARKDOWN print style. The default is empty, to NOT
%      print in MARKDOWN
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
%      fcn_DataClean_loadMappingVanDataFromFile
%      fcn_DataClean_plotRawData
%
% EXAMPLES:
%
%     See the script: script_test_fcn_DebugTools_printDirectoryListing
%     for a full test suite.
%
% This function was written on 2024_10_13 by S. Brennan
% Questions or comments? sbrennan@psu.edu

% Revision history
% 2024_09_13 - Sean Brennan, sbrennan@psu.edu
% -- wrote the code originally, copying out of DataClean library
% 2025_09_19 - Sean Brennan, sbrennan@psu.edu
% -- minor bug fixes for when printing to markdown format
% 2025_11_12 by Sean Brennan, sbrennan@psu.edu
% - Updated debug flags
% - Added figNum input
% - Fixed variable naming for clarity:
%   % * fig_num to figNum
% TO DO
% -- (none)

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

        % if nargin>=2
        %     % Check the variableTypeString input, make sure it is characters
        %     if ~ischar(variableTypeString)
        %         error('The variableTypeString input must be a character type, for example: ''Path'' ');
        %     end
        % end

    end
end

% Does user want to specify fileQueryString?
titleString = 'CONTENTS FOUND:';
if 2 <= nargin
    temp = varargin{1};
    if ~isempty(temp)
        titleString = temp;
    end
end

% Does user want to specify rootDirectoryString?
flag_printMarkdownReady = 0;
if 3 <= nargin
    temp = varargin{2};
    if ~isempty(temp)
        rootDirectoryString = temp;
        flag_printMarkdownReady = 1;
    end
end

% Does user want to specify fid?
fid = 1; % Default is to print to console
if (0 == flag_max_speed) && (MAX_NARGIN <= nargin)
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


%%%%
% Print the title
fprintf(fid,'\n%s\n',titleString);

% Print the fields
previousDirectory = '';
for jth_file = 1:length(directory_filelist)
    thisFolder = directory_filelist(jth_file).folder;

    % If directory is NOT the same as the previous print, print the
    % directory name. This print will have different formats depending on
    % whether it is to a README or to the console.
    if ~strcmp(thisFolder,previousDirectory)
        % Update the previous directory variable for this new directory
        previousDirectory = thisFolder;

        % Are we printing to a README?
        if 1==flag_printMarkdownReady

            % Yes - printing to a README. Need to make a "clean" header
            % string, one that converts the subdirectories into a good
            % print string.
            subFolderName = extractAfter(thisFolder,rootDirectoryString);
            directoryParts = split(subFolderName,filesep);
            if iscell(directoryParts)
                cleanString = '';
                for ith_part = 1:length(directoryParts)
                    if ~isempty(directoryParts{ith_part})
                        cleanString = cat(2,cleanString,directoryParts{ith_part},' ');
                    end
                end
            else
                cleanString = directoryParts;
            end
            if isempty(cleanString)
                cleanString = '(root)';
            end
            fprintf(fid,'\n## %s\n\n',cleanString);
        else
            fprintf(fid,'Folder: %s\n',thisFolder);
        end
    end
    if 1==flag_printMarkdownReady
        fprintf(fid,'* %s\n',directory_filelist(jth_file).name);
    else
        fprintf(fid,'\t%s\n',directory_filelist(jth_file).name);
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


