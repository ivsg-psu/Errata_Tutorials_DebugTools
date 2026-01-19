function fcn_DebugTools_printNumeredDirectoryList(directory_filelist, cellArrayHeaders, cellArrayValues, varargin)
%fcn_DebugTools_printNumeredDirectoryList
% prints a directory file list alongside lists of flags and details.
%
% FORMAT:
%
%      fcn_DebugTools_printNumeredDirectoryList(directory_filelist, cellArrayHeaders, cellArrayValues, (directoryRoot), (fid))
%
% INPUTS:
%
%      directory_filelist: a structure array that is the output of a
%      "dir" command. A typical output can be generated using:
%      directory_filelist = fcn_DebugTools_listDirectoryContents({cd});
%
%      cellArrayHeaders: a [Nx1] cell array of strings representing the
%      headers. Note: the printing width of each column is inhereted by the
%      length of each string.
%
%      cellArrayValues: a cell array of the contents to be printed
%
%      (OPTIONAL INPUTS)
%
%      directoryRoot: a string representing the root of the directory
%      listing. By default, this is empty. However, in some folder
%      printings, the listing is intended for relative and not absolute
%      folder locations. By entering a string for the "root" of the
%      directory listing, the folders are printed in "relative to root"
%      format which makes printing more simple.
%
%      fid: the fileID where to print. Default is 0, to NOT print results to
%      the console. If set to -1, skips any input checking or debugging, no
%      prints will be generated, and sets up code to maximize speed.
%
% OUTPUTS:
%
%      (printing to console)
%
% DEPENDENCIES:
%
%      (none)
%
% EXAMPLES:
%
%     See the script: script_test_fcn_DebugTools_printNumeredDirectoryList
%     for a full test suite.
%
% This function was written on 2024_10_24 by S. Brennan
% Questions or comments? sbrennan@psu.edu

% REVISION HISTORY:
% 
% 2024_10_24 by Sean Brennan, sbrennan@psu.edu
% - wrote the code originally, copying out of DataClean library
%
% 2025_11_20 by Sean Brennan, sbrennan@psu.edu
% - Formatted revision lists to Markdown format
% - Fixed variable naming for clarity:
%   % * fig_+num to figNum
%
% 2026_01_19 by Sean Brennan, sbrennan@psu.edu
% - In fcn_DebugTools_printNumeredDirectoryList
%   % * Updated cprintf formatting to be compatible with new version

% TO-DO:
% 
% 2025_11_20 by Sean Brennan, sbrennan@psu.edu
% - fill in to-do items here.

%% Debugging and Input checks

% Check if flag_max_speed set. This occurs if the figNum variable input
% argument (varargin) is given a number of -1, which is not a valid figure
% number.
flag_max_speed = 0;
if (nargin==5 && isequal(varargin{end},-1))
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

if (0 == flag_max_speed)
    if flag_check_inputs == 1
        % Are there the right number of inputs?
        narginchk(3,5);

    end
end

% Does user want to specify directoryRoot?
directoryRoot = ''; % Default is empty
if (4 <= nargin)
    temp = varargin{1};
    if ~isempty(temp)
        directoryRoot = temp;
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


% Check that the data is consistent
% First, ensure the number of column headers is equal to the number of data
% arrays
NcolumnsToPrint = length(cellArrayHeaders);
if NcolumnsToPrint~=length(cellArrayValues(1,:))
    error('Mismatch in number of headers versus number of data');
end

% Next, ensure the length of data in each data array is equal to the number
% of files we are summarizing
NfilesToSummarize = length(directory_filelist);
if NfilesToSummarize~=length(cellArrayValues(:,1))
    error('Mismatch between number of files and number of data rows');
end

% Prepare to print
% Find the number of characters in each column, using the headers
Ncharacters_eachColumn = ones(NcolumnsToPrint,1);
for ith_header = 1:NcolumnsToPrint
    headerString = cellArrayHeaders{ith_header};
    Ncharacters_eachColumn(ith_header,1) = length(headerString);
end

% Print the headers
fprintf(1,'\n\n\t\t');
for ith_header = 1:NcolumnsToPrint
    headerString = cellArrayHeaders{ith_header};
    formattedHeaderString  = fcn_DebugTools_debugPrintStringToNCharacters(headerString,Ncharacters_eachColumn(ith_header,1));
    fprintf(1,'%s\t',formattedHeaderString);
end
fprintf(1,'\n');

% Print the data
previous_folder = '';
for ith_bagFile = 1:NfilesToSummarize
    thisFolderFillName   = directory_filelist(ith_bagFile).folder;

    % How is the folder to be printed?
    if ~isempty(directoryRoot)
        thisFolder           = extractAfter(thisFolderFillName,directoryRoot);
    else
        thisFolder = thisFolderFillName;
    end

    if ~strcmp(thisFolder,previous_folder)
        fprintf(1,'Folder: %s:\n',thisFolder);
        previous_folder = thisFolder;
    end


    fprintf(1,'\t%.0d\t', ith_bagFile);
    for ith_header = 1:NcolumnsToPrint
        thisColumnData = cellArrayValues{ith_bagFile, ith_header};
        if ischar(thisColumnData) && strcmp(thisColumnData,'yes')
            printString = fcn_DebugTools_debugPrintStringToNCharacters('yes',Ncharacters_eachColumn(ith_header,1));
            fprintf(1,'%s\t',printString);
        elseif ischar(thisColumnData) && strcmp(thisColumnData,'no')
            printString = fcn_DebugTools_debugPrintStringToNCharacters('no',Ncharacters_eachColumn(ith_header,1));
            fcn_DebugTools_cprintf('*Black',sprintf('%s\t',printString));
        elseif ischar(thisColumnData)
            printString = fcn_DebugTools_debugPrintStringToNCharacters(thisColumnData,Ncharacters_eachColumn(ith_header,1));
            fprintf(1,'%s\t',printString);
        elseif isscalar(thisColumnData)
            temp = char(formattedDisplayText(thisColumnData,"LineSpacing","compact","SuppressMarkup",true));
            numberIndicies = regexp(temp,'\d');
            thisColumnString = temp(min(numberIndicies):max(numberIndicies));
            printString = fcn_DebugTools_debugPrintStringToNCharacters(thisColumnString,Ncharacters_eachColumn(ith_header,1));
            fprintf(1,'%s\t',printString);
        else
            error('Unable to print this data type!');

        end
    end
    fprintf(1,'\n');

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

