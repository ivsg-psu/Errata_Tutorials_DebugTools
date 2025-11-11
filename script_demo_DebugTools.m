% script_demo_DebugTools.m
% This is a script to exercise the functions within the DebugTools code
% library. The repo is typically located at:
%   https://github.com/ivsg-psu/Errata_Tutorials_DebugTools
% Questions or comments? sbrennan@psu.edu


% Revision history:
% 2021_12_12: sbrennan@psu.edu
% -- first write of the code by Steve Harnett
% 2022_03_27: sbrennan@psu.edu
% -- created a demo script of core debug utilities
% 2023_01_16: sbrennan@psu.edu
% -- vastly improved README file
% 2023_01_25: sbrennan@psu.edu
% -- added install from URL
% 2024_10_14: sbrennan@psu.edu
% -- added directory utilities
% 2024_10_25 - S. Brennan
% -- Added directory comparison and query tools, cleaned up README.md
% 2025_07_10 by S. Brennan
% Inside: checkInputsToFunctions
% -- added NorMorecolumn_of_numbers type and tests
% -- added structure comparison to see if bug with structure testing
% -- commented out traversal and traversals type to deprecate Path library
%    usage of these
% -- added numeric testing
% -- updated output options listing
% 2025_07_18 by S. Brennan
% -- added positive and strictly positive variable checking to
%    checkInputsToFunctions
% 2025_09_18 - Sean Brennan
% * In fcn_DebugTools_listDirectoryContents
% -- fixed bug where string hash being checked but queries may not be long
%    enough to do hash check during a debug test
% 2025_11_04 - Sean Brennan
% * In fcn_DebugTools_breakArrayByNans
% -- added this function from the PlotRoad library
% -- added global variables for DEBUGTOOLS libary
% -- updated README.md
% -- fixed bug in this main script in fcn_DebugTools_queryNumberRange,
%    % where old output specification was used
% -- added function fcn_DebugTools_directoryStringQuery
% -- updated script_test_all_functions
% 2025_11_06 by S. Brennan
% - In script_test_fcn_DebugTools_checkInputsToFunctions
%   % * added 'column_of_mixed' example to demonstrate nan inputs on
%   %   % 2_column_of_numbers
% - In fcn_DebugTools_checkInputsToFunctions
%   % * updated header and input checking to current format
%   % * updated plotting flag name, for consistency
%   %   % -- from flag_do_plot
%   %   % -- to flag_do_plots
%   % * changed input variable name for consistency
%   %   % -- from variable_type_string
%   %   % -- to variableTypeString
% - Added script_test_fcn_DebugTools_findLatestGitHubRelease
%   % * checks for latest releases
% 2025_11_11 by S. Brennan
% - In script_test_fcn_DebugTools_findLatestGitHubRelease
%   % * Updated incorrect function calls, added fastmode testing
% - Added fcn_DebugTools_autoInstallRepos
%   % * Automatically checks if repo installs are latest
%   % * Still debugging this. Need stable release to test.

%% To-Do list
% 2025_XX_XX - Your name, email
% -- add to-do item here

%% Set up workspace
if 1==1 % && ~exist('flag_DebugTools_Was_Initialized','var')
    addpath(pwd)

    % add necessary directories for functions recursively
    if(exist([pwd, filesep,  'Functions'],'dir'))
        addpath(genpath([pwd, filesep, 'Functions']))
    else % Throw an error?
        error('No Functions directory exists to be added to the path. Please create one (see README.md) and run again.');
    end
    
    % % add necessary directories for data?
    if(exist([pwd, filesep,  'Data'],'dir'))
        addpath(genpath([pwd, filesep, 'Data']))
    else % Throw an error?
        % error('No Data directory exists to be added to the path. Please create one (see README.md) and run again.');
    end
    
    % add necessary directories for Utilities to the path?
    if(exist([pwd, filesep,  'Utilities'],'dir'))
        addpath(genpath([pwd, filesep, 'Utilities']))  % This is where GPS utilities are stored
    else % Throw an error?
        % error('No Utilities directory exists to be added to the path. Please create one (see README.md) and run again.');
    end
    
    % set a flag so we do not have to do this again
    flag_DebugTools_Was_Initialized = 1;
end

%% Set environment flags for input checking
% These are values to set if we want to check inputs or do debugging
setenv('MATLABFLAG_DEBUGTOOLS_FLAG_CHECK_INPUTS','1');
setenv('MATLABFLAG_DEBUGTOOLS_FLAG_DO_DEBUG','0');


%% Workspace Management
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  __          __        _                                __  __                                                   _   
%  \ \        / /       | |                              |  \/  |                                                 | |  
%   \ \  /\  / /__  _ __| | _____ _ __   __ _  ___ ___   | \  / | __ _ _ __   __ _  __ _  ___ _ __ ___   ___ _ __ | |_ 
%    \ \/  \/ / _ \| '__| |/ / __| '_ \ / _` |/ __/ _ \  | |\/| |/ _` | '_ \ / _` |/ _` |/ _ \ '_ ` _ \ / _ \ '_ \| __|
%     \  /\  / (_) | |  |   <\__ \ |_) | (_| | (_|  __/  | |  | | (_| | | | | (_| | (_| |  __/ | | | | |  __/ | | | |_ 
%      \/  \/ \___/|_|  |_|\_\___/ .__/ \__,_|\___\___|  |_|  |_|\__,_|_| |_|\__,_|\__, |\___|_| |_| |_|\___|_| |_|\__|
%                                | |                                                __/ |                              
%                                |_|                                               |___/                               
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Demonstrate: Clearing package installs and path linkages to packages
if 1==1
    % Clear out the variables
    clear global flag* FLAG*

    % Clear out any path directories under Utilities
    path_dirs = regexp(path,'[;]','split');
    utilities_dir = fullfile(pwd,filesep,'Utilities');
    for ith_dir = 1:length(path_dirs)
        utility_flag = strfind(path_dirs{ith_dir},utilities_dir);
        if ~isempty(utility_flag)
            rmpath(path_dirs{ith_dir});
        end
    end

    % Delete the Utilities folder, to be extra clean!
    if  exist(utilities_dir,'dir')
        [success_flag,message,message_ID] = rmdir(utilities_dir,'s');
        if 0==success_flag
            error('Unable remove directory: %s \nReason message: %s \nand message_ID: %s\n',utilities_dir, message,message_ID);
        end
    end

end

%% Demonstrate: Package installs from GitHub URLs
% see script_test_fcn_DebugTools_installDependencies
flag_show_warnings = 0;

% NOTE: this installs under the Utilities directory
dependency_name = 'DebugTools_v2023_01_25';
dependency_subfolders = {'Functions','Data'};
dependency_url = 'https://github.com/ivsg-psu/Errata_Tutorials_DebugTools/blob/main/Releases/DebugTools_v2023_01_25.zip?raw=true';
fcn_DebugTools_installDependencies(dependency_name, dependency_subfolders, dependency_url);


disp('Library installed! Verify this now, as it will be deleted to complete the demo');
disp('Paused. Hit any key to continue...');
pause;

% Remove the folders from path, to avoid deletion warnings
temp_path = fullfile(pwd,'Utilities','DebugTools_v2023_01_25','Functions');
rmpath(temp_path);
temp_path = fullfile(pwd,'Utilities','DebugTools_v2023_01_25','Data');
rmpath(temp_path);

% Remove the example Utilities folder and all subfolders
[success_flag,error_message,message_ID] = rmdir('Utilities','s');

% Did it work?
if ~success_flag
    error('Unable to remove the example Utilities directory. Reason: %s with message ID: %s\n',error_message,message_ID);
elseif ~isempty(error_message)
    if flag_show_warnings
        warning('The Utilities directory was removed, but with a warning: %s\n and message ID: %s\n(continuing)\n',error_message, message_ID); %#ok<UNRCH> 
    end
end

%% Demonstrate how to add subdirectories to the path
if ~exist('flag_DebugTools_Folders_Initialized','var')
    fcn_DebugTools_addSubdirectoriesToPath(pwd,{'Functions','Data'});

    % set a flag so we do not have to do this again
    flag_DebugTools_Folders_Initialized = 1;
end

%% fcn_DataClean_listDirectoryContents
% Creates a list of specified root directories, including all
% subdirectories, of a given query. Allows specification whether to keep
% either files, directories, or both.
%
% FORMAT:
%
%      directory_filelist = fcn_DataClean_listDirectoryContents(rootdirs, (fileQueryString), (flag_fileOrDirectory), (fid))

% List which directory/directories need to be loaded
clear rootdirs
% rootdirs{1} = 'D:\MappingVanData\RawBags\OnRoad\PA653Normalville\2024-08-22';
rootdirs{1} = fullfile(cd,'Functions');


% Specify the fileQueryString
fileQueryString = '*.m'; % The more specific, the better to avoid accidental loading of wrong information

% Specify the flag_fileOrDirectory
flag_fileOrDirectory = 0; % 0 = a file, 1 = directory, 2 = both

% Specify the fid
fid = -1; % 1 --> print to console

% Call the function
directory_filelist = fcn_DebugTools_listDirectoryContents(rootdirs, (fileQueryString), (flag_fileOrDirectory), (fid));

% Check the results
assert(isstruct(directory_filelist));
assert(length(directory_filelist)>1);


%% fcn_DebugTools_printDirectoryListing
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
%      (prints to console)


% Create a directory filelist by querying the "Functions" folder for all .m
% files
directory_filelist = fcn_DebugTools_listDirectoryContents({fullfile(cd,'Functions')},'*.m',0);

% Print the results with a titleString
titleString = 'This is a listing of all mfiles in the Functions folder';
rootDirectoryString = [];
fid = 1;
fcn_DebugTools_printDirectoryListing(directory_filelist, (titleString), (rootDirectoryString), (fid))

%% fcn_DebugTools_countBytesInDirectoryListing
% Counts the number of bytes in a directory listing and as well the number of folders and files in that listing, excluding degenerate folders
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

% Implementation example:

directory_filelist = fcn_DebugTools_listDirectoryContents({cd});

indicies = 1:10;
fid = 1;
[totalBytes, Nfolders, Nfiles] = fcn_DebugTools_countBytesInDirectoryListing(directory_filelist,(indicies),(fid));

assert(totalBytes>=0);
assert(Nfolders>=0);
assert(Nfiles>=0);
assert((Nfiles+Nfolders)<=length(indicies)); % Note: some indicies may be degenerate folders such as '.' and '..' - these are not counted

% Produced the following:
% Total number of files and folders indexed: 10, containing 1,660 bytes, 6 folders, and 2 files
% Breakdown:
% 		FOLDERS:                                                              	    BYTES (in and below):
% 		D:\GitHubRepos\IVSG\Errata\Tutorials\DebugTools\.git                  	               51,667,259
% 		D:\GitHubRepos\IVSG\Errata\Tutorials\DebugTools\Data                  	                      330
% 		D:\GitHubRepos\IVSG\Errata\Tutorials\DebugTools\Documents             	                7,106,499
% 		D:\GitHubRepos\IVSG\Errata\Tutorials\DebugTools\Example Code Snippets 	                   23,296
% 		D:\GitHubRepos\IVSG\Errata\Tutorials\DebugTools\Functions             	                  284,354
% 		D:\GitHubRepos\IVSG\Errata\Tutorials\DebugTools\Images                	                1,983,583
% 
% 		FILES:                                                                	                   BYTES:
% 		D:\GitHubRepos\IVSG\Errata\Tutorials\DebugTools\.gitignore            	                      523
% 		D:\GitHubRepos\IVSG\Errata\Tutorials\DebugTools\LICENSE               	                    1,137

%% fcn_DebugTools_makeDirectory
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

directoryPath = fullfile(cd,'Junk','Junk','Junk');
assert(7~=exist(directoryPath,'dir'));

fid = 1;

fcn_DebugTools_makeDirectory(directoryPath,fid);

assert(7==exist(directoryPath,'dir'));
rmdir('Junk','s');


%% fcn_DebugTools_sortDirectoryListingByTime
% Given a directory listing of files that have names ending in date
% formats, for example: filename_yyyy-MM-dd-HH-mm-ss,sorts the files
% by date. Useful to sort bag files whose names contain dates, for example:
%       mapping_van_2024-08-05-14-45-26_0
%
% FORMAT:
%
%      sorted_directory_filelist = fcn_DebugTools_sortDirectoryListingByTime(directory_filelist, (fid))
%
% INPUTS:
%
%      directory_filelist: a structure array that is the output of a
%      "dir" command. A typical output can be generated using:
%      directory_filelist = fcn_DebugTools_listDirectoryContents({cd});
%
%      (OPTIONAL INPUTS)
%
%      fid: the fileID where to print. Default is 1, to print results to
%      the console. If set to -1, skips any input checking or debugging, no
%      prints will be generated, and sets up code to maximize speed.
%
% OUTPUTS:
%
%      sorted_directory_filelist: a structure array similar to the output
%      of a "dir" command, but where the listings are sorted by date

directory_filelist = fcn_DebugTools_listDirectoryContents({fullfile(cd,'Data')},'ExampleDateSorting*.txt',0);

sorted_directory_filelist = fcn_DebugTools_sortDirectoryListingByTime(directory_filelist);

fcn_DebugTools_printDirectoryListing(sorted_directory_filelist);


%% fcn_DebugTools_confirmTimeToProcessDirectory
% Calculates the time it takes to process a directory listing and confirms
% with the user that this is acceptable.
%
% FORMAT:
%
%      [flag_keepGoing, timeEstimateInSeconds] = fcn_DebugTools_confirmTimeToProcessDirectory(directory_listing, bytesPerSecond, (indexRange),(fid))
%
% INPUTS:
%
%      directory_listing: a structure that is the output of MATLAB's "dir"
%      command that includes filename, bytes, etc.
%
%      (OPTIONAL INPUTS)
%
%      indexRange: which indicies to include in the count. Default is to use
%      all files in the directory listing.
%
%      fid: the fileID where to print. Default is 0, to NOT print results to
%      the console. If set to -1, skips any input checking or debugging, no
%      prints will be generated, and sets up code to maximize speed.
%
% OUTPUTS:
%
%      flag_keepGoing: outputs a 1 if user accepts, 0 otherwise
%
%      timeEstimateInSeconds: how many seconds the processing is estimated
%      to take

directory_listing = fcn_DebugTools_listDirectoryContents({cd});
bytesPerSecond = 10000000;
indexRange = [];
fid = 1;
[flag_keepGoing, timeEstimateInSeconds] = fcn_DebugTools_confirmTimeToProcessDirectory(directory_listing, bytesPerSecond, (indexRange),(fid));

assert((flag_keepGoing==0) || (flag_keepGoing==1));
assert(timeEstimateInSeconds>=0);

%% fcn_DebugTools_compareDirectoryListings
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

% Set strings that list where the "root" potions of the source and
% destination directories are located
sourceRootString      = fullfile(cd,'Data','Example_compareDirectoryListings','SourceDirectory');
destinationRootString = fullfile(cd,'Data','Example_compareDirectoryListings','DestinationDirectory');


% Create a directory filelist by querying the "Functions" folder for all .m
% files
file_or_folder = 0; % Returns only files
directoryListing_source = fcn_DebugTools_listDirectoryContents({sourceRootString},'TestFolder*.m',file_or_folder);

% Call the function fcn_DebugTools_compareDirectoryListings
flag_matchingType = 1; % Same to same
flags_wasMatched = fcn_DebugTools_compareDirectoryListings(directoryListing_source, sourceRootString, destinationRootString, (flag_matchingType), (fid));

assert(isequal(flags_wasMatched,[1 1 0]'));

%% fcn_DebugTools_directoryStringQuery
% Searches the given fileList for a queryString, returning 1 if the string
% is found in the file, 0 otherwise.
%
% FORMAT:
%
%      fcn_DebugTools_directoryStringQuery(fileList, queryString,(fig_num));
%
% INPUTS:
%
%      fileList: the output of a directory command, a structure containing
%      the files to search
%
%      queryString: the string to search
%
%      (OPTIONAL INPUTS)
%
%     fig_num: a figure number to plot results. If set to -1, skips any
%     input checking or debugging, no figures will be generated, and sets
%     up code to maximize speed. As well, if given, this forces the
%     variable types to be displayed as output and as well makes the input
%     check process verbose
%
%
% OUTPUTS:
%
%     flagsStringWasFoundInFiles: for each of the N entries in fileList,
%     returns logical 1 if the query string is found, 0 if not.

% Basic test case looking for ''ghglglgh (only in this file)'''

fig_num = 10001; 
titleString = sprintf('DEMO case: Basic test case looking for ''ghglglgh (only in this file)''');
fprintf(1,'Figure %.0f: %s\n',fig_num, titleString);
figure(fig_num); close(fig_num);

% Get a list of all files in the directory
fileList = dir(fullfile(pwd,'Functions', '*.*')); % Adjust file extension as needed

% Filter out directories from the list
fileList = fileList(~[fileList.isdir]);

queryString = 'ghglglgh (only in this file)';

flagsStringWasFoundInFiles = fcn_DebugTools_directoryStringQuery(fileList, queryString, (fig_num));

% Check variable types
assert(islogical(flagsStringWasFoundInFiles))

% Check variable sizes
assert(size(flagsStringWasFoundInFiles,1)==length(fileList));
assert(size(flagsStringWasFoundInFiles,2)==1);

% Check variable values
% This file and the ASV file
assert(sum(flagsStringWasFoundInFiles)>=1 || (flagsStringWasFoundInFiles)<=2);

%% Input CHecking
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   _____                   _      _____ _               _    _             
%  |_   _|                 | |    / ____| |             | |  (_)            
%    | |  _ __  _ __  _   _| |_  | |    | |__   ___  ___| | ___ _ __   __ _ 
%    | | | '_ \| '_ \| | | | __| | |    | '_ \ / _ \/ __| |/ / | '_ \ / _` |
%   _| |_| | | | |_) | |_| | |_  | |____| | | |  __/ (__|   <| | | | | (_| |
%  |_____|_| |_| .__/ \__,_|\__|  \_____|_| |_|\___|\___|_|\_\_|_| |_|\__, |
%              | |                                                     __/ |
%              |_|                                                    |___/ 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Demonstrate fcn_DebugTools_checkInputsToFunctions
% Check that input has 2 columns, maximum row length is 5 or less
Twocolumn_of_integers_test = [4 1; 3 9; 2 7];
fcn_DebugTools_checkInputsToFunctions(Twocolumn_of_integers_test, '2column_of_integers',[5 4]);


%% Demonstrate fcn_DebugTools_doStringsMatch
% simple string comparisons, student answer is part of correct answer so returns true, ignoring case
student_answer = 'A';
correct_answers = 'abc';
result = fcn_DebugTools_doStringsMatch(student_answer,correct_answers);
assert(result);

% simple string comparisons, student answer is part of correct answer so true, checking to produce false result if student repeats (FALSE)
student_answer = 'aa';
correct_answers = 'abc';
result = fcn_DebugTools_doStringsMatch(student_answer,correct_answers);
assert(result==false);

%% Demonstrate fcn_DebugTools_extractNumberFromStringCell
% Extracting a numeric value embedded in a string

% Choose a hard situation: Decimal number, negative, in cell array with leading zeros and text
result = fcn_DebugTools_extractNumberFromStringCell({'My number is -0000.4'});
assert(isequal(result,{'-0.4'}));

%% Demonstrate fcn_DebugTools_parseStringIntoCells
% Parsing a comma separated string into cells

% Choose a very Complex input
inputString = 'This,isatest,of';
result = fcn_DebugTools_parseStringIntoCells(inputString);
assert(isequal(result,[{'This'},{'isatest'},{'of'}]));

%% Demonstrate fcn_DebugTools_convertVariableToCellString
% Converting a mixed input cell array into comma separated string

% Multiple mixed character, numeric in cell array ending in string with commas
result = fcn_DebugTools_convertVariableToCellString([{'D'},{2},'abc , 123']);
assert(isequal(result,{'D, 2, abc , 123'}));

%% fcn_DebugTools_queryNumberRange
%  Query user to select index range
%
% queries the user to select a number based on a flag vector, and
% optionally can confirm the selection is valid if user selects a number
% range that overlaps indicies where a flag value is equal to 1
%
% FORMAT:
%
%      [flag_keepGoing, startingIndex, endingIndex] = fcn_DebugTools_queryNumberRange(flags_toCheck, (queryEndString), (flag_confirmOverwrite), (directory_filelist), (fid))
%
% INPUTS:
%
%      flags_toCheck: a list of flags, either 1 or 0, that indicate that
%      the number is either "done" (value = 1) or "not done" (value = 0).
%      The query defaults to the first "not done" value (the first 0).
%      Then, based on the user's entry, the query defaults to
%      subsequent-to-start last "not done" or 0 value in flags_toCheck. For
%      example, if flags_toCheck = [1 1 0 0 0 1 1 0 0 1], then the default start
%      index will be 3 as this is the first index in flags_toCheck where a
%      0 appears. If the user however selects a starting index of 6, then
%      the prompt will give a default ending index of 9, as this is the
%      last 0 value to appear after the 6 index.
%
%      (OPTIONAL INPUTS)
%
%      queryEndString: a string that appears at the end of the number query
%      given at each prompt, filled in as the XXX in the form:
%      "What is the starting numberXXXXX?". For example, if some enters:
%      " of the file(s) to parse", then the prompt will be:
%      "What is the starting number of the files to parse?". Default is
%      empty.
%
%      flag_confirmOverwrite: set to 1 to force the user to confirm
%      "overwrite" if the user selects a number range such that it overlaps
%      with one of the indicies where flags_toCheck is 1. Or, set to 0 to
%      skip this checking.  Default is 1
%
%      directory_filelist: a structure array that is the output of a
%      "dir" command. This is used to show which files corresponding to
%      flags_toCheck will be overwritten. A typical output can be generated
%      using: directory_filelist =
%      fcn_DebugTools_listDirectoryContents({cd});
%
%      fid: the fileID where to print. Default is 0, to NOT print results to
%      the console. If set to -1, skips any input checking or debugging, no
%      prints will be generated, and sets up code to maximize speed.
%
% OUTPUTS:
%
%      flag_keepGoing: outputs a 1 if user accepts, 0 otherwise
%
%      startingIndex: the user-selected first index
%
%      endingIndex: the user-selected first index


rng(1);

% Create a directory filelist by querying the "Functions" folder for all .m
% files
directory_filelist = fcn_DebugTools_listDirectoryContents({fullfile(cd,'Functions')},'*.m',0);

dirNames = {directory_filelist.name}';
dirScripts = contains(dirNames,'script');
celldirScripts = mat2cell(dirScripts,ones(1,length(dirNames)));
dirScriptYesNo = fcn_DebugTools_convertBinaryToYesNoStrings(dirScripts);

cellArrayHeaders = {'m-filename                                                         ', 'Script flag?   ', 'Script?   '};
cellArrayValues = [dirNames, celldirScripts, dirScriptYesNo];

% Print to screen
fcn_DebugTools_printNumeredDirectoryList(directory_filelist, cellArrayHeaders, cellArrayValues, ([]), (fid))


% Set up call to function
flags_toCheck = dirScripts;
queryEndString = ' function to change to script';
flag_confirmOverwrite = 1;
fid = 1;
[flag_keepGoing, indiciesSelected] = fcn_DebugTools_queryNumberRange(flags_toCheck, (queryEndString), (flag_confirmOverwrite), (directory_filelist), (fid));

assert(flag_keepGoing==1 || flag_keepGoing==0);
if ~isempty(indiciesSelected)
    assert(min(indiciesSelected)>0 && max(indiciesSelected)<=length(flags_toCheck));
    assert(length(indiciesSelected)<=length(flags_toCheck));
end

%% Break column of data by NaN values using fcn_DebugTools_breakArrayByNans   
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

test_data = [2; 3; 4; nan; 6; 7];
indicies_cell_array = fcn_DebugTools_breakArrayByNans(test_data, (fig_num));

% Check variable types
assert(iscell(indicies_cell_array))

% Check variable sizes
assert(size(indicies_cell_array,1)==1);
assert(size(indicies_cell_array,2)==2);

% Check variable values
assert(isequal(indicies_cell_array{1},[1; 2; 3]));
assert(isequal(indicies_cell_array{2},[5; 6]));

%% Output formatting
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    ____        _               _     ______                         _   _   _             
%   / __ \      | |             | |   |  ____|                       | | | | (_)            
%  | |  | |_   _| |_ _ __  _   _| |_  | |__ ___  _ __ _ __ ___   __ _| |_| |_ _ _ __   __ _ 
%  | |  | | | | | __| '_ \| | | | __| |  __/ _ \| '__| '_ ` _ \ / _` | __| __| | '_ \ / _` |
%  | |__| | |_| | |_| |_) | |_| | |_  | | | (_) | |  | | | | | | (_| | |_| |_| | | | | (_| |
%   \____/ \__,_|\__| .__/ \__,_|\__| |_|  \___/|_|  |_| |_| |_|\__,_|\__|\__|_|_| |_|\__, |
%                   | |                                                                __/ |
%                   |_|                                                               |___/ 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% fcn_DebugTools_number2string.m 
% % prints a "pretty" version of a string, e.g avoiding weirdly odd numbers
% of decimal places or strangely formatted printing.

% Basic case - example
stringNumber = fcn_DebugTools_number2string(2.333333333); % Empty result
assert(isequal(stringNumber,'2.33'));

%% fcn_DebugTools_addStringToEnd.m 
% The function: fcn_DebugTools_addStringToEnd.m appends a number, cell
% string, or string to the end of a string, producing a string. 

input_string = 'test';
value_to_add = 2;
output_string = fcn_DebugTools_addStringToEnd(input_string,value_to_add);
assert(isequal(output_string,'test 2'));

%% fcn_DebugTools_convertBinaryToYesNoStrings
% Converts Nx1 of scalar 1 or 0 vectors into Nx1 cell arrays containing
% 'yes' or 'no' corresponding to the 1's or 0's respectively
%
% FORMAT:
%
%      cellArrrayYesNo = fcn_DebugTools_convertBinaryToYesNoStrings(flags_binary, (fid))
%
% INPUTS:
%
%      flags_binary: a column array, [N x 1], of 1's or 0's
%
%      (OPTIONAL INPUTS)
%
%      fid: the fileID where to print. Default is 0, to NOT print results to
%      the console. If set to -1, skips any input checking or debugging, no
%      prints will be generated, and sets up code to maximize speed.
%
% OUTPUTS:
%
%      cellArrrayYesNo: a cell array of N rows, 1 column, of 'yes' or 'no'
%      strings

flags_binary = [0; 1; 0];
cellArrrayYesNo = fcn_DebugTools_convertBinaryToYesNoStrings(flags_binary);

assert(isequal(cellArrrayYesNo,{'no';'yes';'no'}))


%% Demonstration of codes related to fcn_DebugTools_debugPrintStringToNCharacters
% The function: fcn_DebugTools_debugPrintStringToNCharacters converts
% strings into fixed-length forms, so that they print cleanly. For example, the following 2 basic examples: 

% BASIC example 1 - string is too long
test_string = 'This is a really, really, really long string but we only want the first 10 characters';
fixed_length_string = fcn_DebugTools_debugPrintStringToNCharacters(test_string,10);
fprintf(1,'The string: %s\nwas converted to: "%s"\n',test_string,fixed_length_string);

% BASIC example 2 - string is too short
test_string = 'Tiny string but should be 40 chars';
fixed_length_string = fcn_DebugTools_debugPrintStringToNCharacters(test_string,40);
fprintf(1,'The string: %s\nwas converted to: "%s"\n',test_string,fixed_length_string);

%% Demonstration of fixed-formatting table printing
% The function: fcn_DebugTools_debugPrintTableToNCharacters, given a matrix
% of data, prints the data in user-specified width to the workspace. 

% Fill in test data
Npoints = 10;
point_IDs = (1:Npoints)';
intersection_points = rand(Npoints,2);
s_coordinates_in_traversal_1 = rand(Npoints,1);
s_coordinates_in_traversal_2 = 1000*rand(Npoints,1);
table_data = [point_IDs, intersection_points, s_coordinates_in_traversal_1, s_coordinates_in_traversal_2];

% Basic test case

header_strings = [{'Data ID'}, {'Location X'},{'Location Y'},{'s-coord 1'},{'s-coord 2'}];
formatter_strings = [{'%.0d'},{'%.12f'},{'%.12f'},{'%.12f'},{'%.12f'}];
N_chars = 15; % All columns have same number of characters
fcn_DebugTools_debugPrintTableToNCharacters(table_data, header_strings, formatter_strings,N_chars);


% Advanced test case

header_strings = [{'Data ID'}, {'Location X'},{'Location Y'},{'s-coord 1'},{'s-coord 2'}]; % Headers for each column
formatter_strings = [{'%.0d'},{'%.12f'},{'%.12f'},{'%.12f'},{'%.12f'}]; % How should each column be printed?
N_chars = [4, 15, 15, 5, 5]; % Specify spaces for each column
fcn_DebugTools_debugPrintTableToNCharacters(table_data, header_strings, formatter_strings,N_chars);

%% fcn_DebugTools_printNumeredDirectoryList
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

rng(1);

% Create a directory filelist by querying the "Functions" folder for all .m
% files
directory_filelist = fcn_DebugTools_listDirectoryContents({fullfile(cd,'Functions')},'*.m',0);

dirNames = {directory_filelist.name}';
dirBytes = [directory_filelist.bytes]';
celldirBytes = mat2cell(dirBytes,ones(1,length(dirNames)));
dirBigFile = dirBytes>1000;
celldirBigFile = mat2cell(dirBigFile,ones(1,length(dirNames)));
dirBigFileYesNo = fcn_DebugTools_convertBinaryToYesNoStrings(dirBigFile);
dirFloat = rand(length(directory_filelist),1).*10.^(10*randn(length(directory_filelist),1));
celldirFloat = mat2cell(dirFloat,ones(1,length(dirNames)));

cellArrayHeaders = {'m-filename                                                         ', 'bytes    ', 'big file?   ', 'Some yes or no  ', 'Some float   '};
cellArrayValues = [dirNames, celldirBytes, celldirBigFile, dirBigFileYesNo, celldirFloat];

% Call the function
fcn_DebugTools_printNumeredDirectoryList(directory_filelist, cellArrayHeaders, cellArrayValues, ([]), (fid))


%% Demonstration of fcn_DebugTools_cprintf - color-formatted printing
% Comprehensive list
fprintf(1,'\n');
fprintf(1,'Comprehensive list of fcn_DebugTools_cprintf options:\n');
fprintf(1,'\n');
fprintf(1,'Possible pre-defined STYLE names. NOTE: the STYLE entries are not case sensitive:\n');
fcn_DebugTools_cprintf('Text',                   '\t ''Text'' - default: black \n');
fcn_DebugTools_cprintf('Keywords',               '\t ''Keywords'' - default: blue \n');
fcn_DebugTools_cprintf('Comments',               '\t ''Comments'' - default: green \n');
fcn_DebugTools_cprintf('Strings',                '\t ''Strings'' - default: purple \n');
fcn_DebugTools_cprintf('UnterminatedStrings',    '\t ''UnterminatedStrings'' - default: dark red \n');
fcn_DebugTools_cprintf('SystemCommands',         '\t ''SystemCommands'' - default: orange \n');
fcn_DebugTools_cprintf('Errors',                 '\t ''Errors'' - default: light red \n');
fcn_DebugTools_cprintf('Hyperlinks',             '\t ''Hyperlinks'' - default: underlined blue \n');
fprintf(1,'\n');
fprintf(1,'Possible pre-defined COLOR names. NOTE: the COLOR entries are not case sensitive:\n')
fcn_DebugTools_cprintf('Black',                  '\t ''Black'' - default: black \n');
fcn_DebugTools_cprintf('Cyan',                   '\t ''Cyan'' - default: cyan \n');
fcn_DebugTools_cprintf('Magenta',                '\t ''Magenta'' - default: magenta \n');
fcn_DebugTools_cprintf('Blue',                   '\t ''Blue'' - default: blue \n');
fcn_DebugTools_cprintf('Green',                  '\t ''Green'' - default: green \n');
fcn_DebugTools_cprintf('Red',                    '\t ''Red'' - default: red \n');
fcn_DebugTools_cprintf('Yellow',                 '\t ''Yellow'' - default: yellow \n');
fcn_DebugTools_cprintf('White',                  '\t ''White'''); fcn_DebugTools_cprintf('Black',' - default: white \n');
fprintf(1,'\n');
fprintf(1,'Possible UNDERLINED (-) or (_) names. NOTE: not case sensitive:\n')
fcn_DebugTools_cprintf('-Text',                   '\t ''-Text'' - default: black \n');
fcn_DebugTools_cprintf('-Keywords',               '\t ''-Keywords'' - default: blue \n');
fcn_DebugTools_cprintf('-Comments',               '\t ''-Comments'' - default: green \n');
fcn_DebugTools_cprintf('-Strings',                '\t ''-Strings'' - default: purple \n');
fcn_DebugTools_cprintf('-UnterminatedStrings',    '\t ''-UnterminatedStrings'' - default: dark red \n');
fcn_DebugTools_cprintf('-SystemCommands',         '\t ''-SystemCommands'' - default: orange \n');
fcn_DebugTools_cprintf('-Errors',                 '\t ''-Errors'' - default: light red \n');
fcn_DebugTools_cprintf('-Hyperlinks',             '\t ''-Hyperlinks'' - default: underlined blue \n');
fcn_DebugTools_cprintf('-Black',                  '\t ''-Black'' - default: black \n');
fcn_DebugTools_cprintf('-Cyan',                   '\t ''-Cyan'' - default: cyan \n');
fcn_DebugTools_cprintf('-Magenta',                '\t ''-Magenta'' - default: magenta \n');
fcn_DebugTools_cprintf('-Blue',                   '\t ''-Blue'' - default: blue \n');
fcn_DebugTools_cprintf('-Green',                  '\t ''-Green'' - default: green \n');
fcn_DebugTools_cprintf('-Red',                    '\t ''-Red'' - default: red \n');
fcn_DebugTools_cprintf('-Yellow',                 '\t ''-Yellow'' - default: yellow \n');
fcn_DebugTools_cprintf('-White',                  '\t ''-White'''); fcn_DebugTools_cprintf('Black',' - default: white \n');
fprintf(1,'\n');
fprintf(1,'Possible BOLD (*) names. NOTE: not case sensitive:\n')
fcn_DebugTools_cprintf('*Text',                   '\t ''*Text'' - default: black \n');
fcn_DebugTools_cprintf('*Keywords',               '\t ''*Keywords'' - default: blue \n');
fcn_DebugTools_cprintf('*Comments',               '\t ''*Comments'' - default: green \n');
fcn_DebugTools_cprintf('*Strings',                '\t ''*Strings'' - default: purple \n');
fcn_DebugTools_cprintf('*UnterminatedStrings',    '\t ''*UnterminatedStrings'' - default: dark red \n');
fcn_DebugTools_cprintf('*SystemCommands',         '\t ''*SystemCommands'' - default: orange \n');
fcn_DebugTools_cprintf('*Errors',                 '\t ''*Errors'' - default: light red \n');
fcn_DebugTools_cprintf('Hyperlinks',              '\t ''*Hyperlinks'' - DOES NOT WORK!\n')
fcn_DebugTools_cprintf('*Black',                  '\t ''*Black'' - default: black \n');
fcn_DebugTools_cprintf('*Cyan',                   '\t ''*Cyan'' - default: cyan \n');
fcn_DebugTools_cprintf('*Magenta',                '\t ''*Magenta'' - default: magenta \n');
fcn_DebugTools_cprintf('*Blue',                   '\t ''*Blue'' - default: blue \n');
fcn_DebugTools_cprintf('*Green',                  '\t ''*Green'' - default: green \n');
fcn_DebugTools_cprintf('*Red',                    '\t ''*Red'' - default: red \n');
fcn_DebugTools_cprintf('*Yellow',                 '\t ''*Yellow'' - default: yellow \n');
fcn_DebugTools_cprintf('*White',                  '\t ''*White'''); fcn_DebugTools_cprintf('Black',' - default: white \n');
fprintf(1,'\n');
fprintf(1,'Color range listing examples: G are rows, B are columns\n')
for ith_R = 0:0.25:1
    fcn_DebugTools_cprintf([ith_R,0,0],'RGB setting: [%.1f G B]\n',ith_R);
    for ith_G = 0:0.25:1
        for ith_B = 0:0.25:1
            fcn_DebugTools_cprintf([ith_R,ith_G,ith_B],'[%.1f %.1f]',ith_G, ith_B);
        end
        fprintf(1,'\n');
    end
    fprintf(1,'\n');
end
