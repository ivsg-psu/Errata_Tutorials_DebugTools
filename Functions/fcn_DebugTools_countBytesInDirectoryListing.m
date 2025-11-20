function [totalBytes, Nfolders, Nfiles] = fcn_DebugTools_countBytesInDirectoryListing(directory_listing, varargin) 
% fcn_DebugTools_countBytesInDirectoryListing
% Counts the number of bytes in a directory listing and as well the number
% of folders and files in that listing, excluding degenerate folders 
%
% FORMAT:
%
%      [totalBytes, Nfolders, Nfiles] = fcn_INTERNAL_countBytesInDirectoryListing(directory_listing, (indicies),(fid))
%
% INPUTS:
%
%      directory_listing: a structure that is the output of MATLAB's "dir"
%      command that includes filename, bytes, etc.
%
%      (OPTIONAL INPUTS)
%
%      indicies: which indicies to include in the count. Default is to use
%      all files in the directory listing.
%
%      fid: the fileID where to print. Default is 0, to NOT print results to
%      the console. If set to -1, skips any input checking or debugging, no
%      prints will be generated, and sets up code to maximize speed.
%
% OUTPUTS:
%
%      totalBytes: the total number of bytes in the directory listing or,
%      if indicies are specified, the total of just the chosen indicies in
%      the directory listing.
%
%      Nfolders: the total number of folders in the listing, excluding
%      degenerate folders ('.' and '..').
%
%      Nfiles: the total number of files in the listing
%
% DEPENDENCIES:
%
%      fcn_DebugTools_printDirectoryListing
%
% EXAMPLES:
%
%     See the script: script_test_fcn_DebugTools_countBytesInDirectoryListing
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

% TO-DO:
% 2025_11_20 by Sean Brennan, sbrennan@psu.edu
% - fill in to-do items here.

%% Debugging and Input checks

% Check if flag_max_speed set. This occurs if the figNum variable input
% argument (varargin) is given a number of -1, which is not a valid figure
% number.
flag_max_speed = 0;
if (nargin==3 && isequal(varargin{end},-1))
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
        narginchk(1,3);

    end
end

% Does user want to specify indicies?
indicies = (1:length(directory_listing))';
if 2 <= nargin
    temp1 = varargin{1};
    if ~isempty(temp1)
        indicies = temp1;
    end
end

% Does user want to specify fid?
fid = 0; % Default is to NOT print to console
if (0 == flag_max_speed) && (3 <= nargin)
    temp1 = varargin{end};
    if ~isempty(temp1)
        fid = temp1;
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

% Check the indicies to make sure they are OK
if max(indicies)>length(directory_listing)
    error('Max query index is higher than the number of files in the directory to list. Cannot continue.');
elseif min(indicies)<1
    error('Max query index is lower than 1. Cannot continue.');
end

totalBytes = 0;
for ith_file = 1:length(indicies)
    current_index = indicies(ith_file);
    totalBytes = totalBytes + directory_listing(current_index).bytes;
end

% Find number of files and folders
fileIndicies = find([directory_listing(indicies).isdir]==0);
uniqueDirectories = [directory_listing(indicies).isdir].*[(~strcmp({directory_listing(indicies).name},'..'))].*[(~strcmp({directory_listing(indicies).name},'.'))]; %#ok<NBRAK1>
uniqueDirectoryIndicies = find(uniqueDirectories);

Nfolders = length(uniqueDirectoryIndicies);
Nfiles = length(fileIndicies);

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

    fprintf(fid,'\nTotal number of files and folders indexed: %.0d, containing %s bytes, %.0d folders, and %.0d files\n',length(indicies),addComma(totalBytes), Nfolders, Nfiles);

    % Find longest folders:
    temp1 = {directory_listing(indicies).folder}';
    temp2 = {directory_listing(indicies).name}';
    Nlongest_fname = 10;
    for ith_test = 1:length(temp1)
        Nlongest_fname = max(Nlongest_fname,length(temp1{ith_test})+length(temp2{ith_test})+2);
    end


    fprintf(fid,'Breakdown:\n');
    nameString = fcn_DebugTools_debugPrintStringToNCharacters(sprintf('%s','FOLDERS:'),Nlongest_fname);
    byteString = pad(sprintf('%s','BYTES (in and below):'),25,"left");
    fprintf(fid,'\t\t%s\t%s\n',nameString,byteString);
    for ith_folder = 1:Nfolders
        currentFolderIndex = uniqueDirectoryIndicies(ith_folder);
        currentFolderName = directory_listing(currentFolderIndex).name;        
        fullpath = fullfile(directory_listing(currentFolderIndex).folder,currentFolderName);
        localDirectoryListing = fcn_DebugTools_listDirectoryContents({fullpath});
        totalLocalBytes = fcn_DebugTools_countBytesInDirectoryListing(localDirectoryListing);

        nameString = fcn_DebugTools_debugPrintStringToNCharacters(sprintf('%s',fullpath),Nlongest_fname);
        byteString = pad(sprintf('%s',addComma(totalLocalBytes)),25,"left");
        fprintf(fid,'\t\t%s\t%s\n',nameString,byteString);
    end

    fprintf(fid,'\n'); % Add a space between folders and files
    nameString = fcn_DebugTools_debugPrintStringToNCharacters(sprintf('%s','FILES:'),Nlongest_fname);
    byteString = pad(sprintf('%s','BYTES:'),25,"left");
    fprintf(fid,'\t\t%s\t%s\n',nameString,byteString);
    for ith_file = 1:Nfiles
        currentFileIndex = fileIndicies(ith_file);
        currentFileName = directory_listing(currentFileIndex).name;        
        fullpath = fullfile(directory_listing(currentFileIndex).folder,currentFileName);
        totalFileBytes = directory_listing(currentFileIndex).bytes;

        nameString = fcn_DebugTools_debugPrintStringToNCharacters(sprintf('%s',fullpath),Nlongest_fname);
        byteString = pad(sprintf('%s',addComma(totalFileBytes)),25,"left");
        fprintf(fid,'\t\t%s\t%s\n',nameString,byteString);
    end
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


function numOut = addComma(numIn)
   import java.text.*
   jf=java.text.DecimalFormat; % comma for thousands, three decimal places
   numOut= char(jf.format(numIn)); % omit "char" if you want a string out
end