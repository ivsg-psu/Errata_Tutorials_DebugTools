function fcn_DebugTools_testRepoForRelease(repoShortName, varargin)
%% FCN_DEBUGTOOLS_TESTREPOFORRELEASE - repo verification tool
%
% fcn_DebugTools_testRepoForRelease automatically checks repos to determine
% if they are ready for release. This includes a number of tests including:
%
% * Makes sure there is only one .m file in main folder
% * Checks that "script_demo_(reponame).m" exists
% * Checks that "README.md" exists
% * Checks existence of key folders 
%   % {'Functions', 'Data', 'Documents', 'Installer', 'Images'}
% * Checks that main file contains required strings 
%   % {'REVISION HISTORY', 'TO-DO','FLAG_CHECK_INPUTS','FLAG_DO_DEBUG'}
% * Checks that function folder does not contain forbiddenStrings: 
%   % 'cl'+'c') and 'clear'+' all'
% * Warns if poorly named variables or comments used in funtions
%   % fig_+num
%   % %-+- type comments
% * Makes sure all functions are matched to test scripts
% * Checks that all functions contain required strings 
%   % {'REVISION HISTORY', 'TO-DO','FLAG_CHECK_INPUTS','FLAG_DO_DEBUG'}
% * Checks that all functions do not contain forbiddenStrings: 
%   % 'cl'+'c') and 'clear'+' all'
% * Loops through all the test scripts to make sure they run
% * OPTIONAL: search/replaces for key strings in all functions
% 
%
% FORMAT:
%
%      fcn_DebugTools_testRepoForRelease(repoShortName, (figNum))
%
% INPUTS:
%
%      repoShortName: a character array denoting the repos root name,
%      including the leading and trailing underscores. For example, in
%      DebugTools, the short name is '_DebugTools_'
%
%      (OPTIONAL INPUTS)
%
%      figNum: a figure number to plot results. If set to -1, skips any
%      input checking or debugging, no figures will be generated, and sets
%      up code to maximize speed. As well, if given, this forces the
%      variable types to be displayed as output and as well makes the input
%      check process verbose
%
% OUTPUTS:
%
%      (none: saves results in an output file)
%
% DEPENDENCIES:
%
%      This code will automatically get dependent files from the internet,
%      but of course this requires an internet connection. If the
%      DebugTools are being installed, it does not require any other
%      functions. But for other packages, it uses the following from the
%      DebugTools library: fcn_DebugTools_addSubdirectoriesToPath
%
% EXAMPLES:
%      See: script_test_fcn_DebugTools_testRepoForRelease
% 
% This function was written on 2026_01_22 by S. Brennan
% Questions or comments? sbrennan@psu.edu

% REVISION HISTORY:
% 
% As: script_test_all_functions
%
% 2025_11_06 by Sean Brennan, sbrennan@psu.edu
% - Started revision history 
% - Updated clc and clear all checking to avoid checking this file
% - Added subfunction (INTERNAL) to remove specific file names from
%    % checking
% - Improved error checking for missed functions and test scripts
% 
% 2025_11_12 by Sean Brennan, sbrennan@psu.edu
% - Cleaned up variable naming for clarity
% - Functionalized fcn_INTERNAL_flagFiles
% 
% 2025_11_13 by Sean Brennan, sbrennan@psu.edu
% - Minor bug fix where filepath was not defined before first usage
% 
% 2025_11_20 by Sean Brennan, sbrennan@psu.edu
% - Updated revision hist to markdown format
% - Added forbidden commands list
% - In fcn_DebugTools_replaceStringInDirectory
%   % * Checks for warning, forbidden, and required strings
%   % * Added commented out section to allow rapid serch for strings
%   %   % and replacement.
% 
% 2026_01_09 by Sean Brennan, sbrennan@psu.edu
% - Updated ignore flags to prevent processing of .p and .asv files
%
% As:fcn_DebugTools_testRepoForRelease
% 
% 2026_01_22 by Sean Brennan, sbrennan@psu.edu
% - wrote the code originally by functionalizing script_test_all_functions
% - updated the file logic for clarity and to avoid processing this script

% TO-DO:
% - 2026_01_22 by Sean Brennan, sbrennan@psu.edu
%    % * Add items here

%% Debugging and Input checks

% Check if flag_max_speed set. This occurs if the figNum variable input
% argument (varargin) is given a number of -1, which is not a valid figure
% number.
MAX_NARGIN = 2; % The largest Number of argument inputs to the function
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
        narginchk(MAX_NARGIN-1,MAX_NARGIN);

        % if nargin>=2
        %     % Check the variableTypeString input, make sure it is characters
        %     if ~ischar(variableTypeString)
        %         error('The variableTypeString input must be a character type, for example: ''Path'' ');
        %     end
        % end

    end
end

% % Does user want to specify the flagForceInstalls input?
% flagForceInstalls = false; % Default is not to force installs
% if 3 <= nargin
%     temp = varargin{1};
%     if ~isempty(temp)
%         flagForceInstalls = temp;
%     end
% end

% Check to see if user specifies figNum?
flag_do_plots = 0; % Default is to NOT show plots
if (0==flag_max_speed) && (MAX_NARGIN == nargin) 
    temp = varargin{end};
    if ~isempty(temp)
        figNum = temp;
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
%See: http://patorjk.com/software/taag/#p=display&f=Big&t=Main
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%§

%% Define the repo name and output file

% outputFile = cat(2,'script_test_fcn',repoShortName,'all_stdout.txt');
% diary(fullfile(pwd,outputFile));

%% Root folder checks start here

% st = dbstack; 
% thisFile = which(st(1).file);
% [filepath,name,ext] = fileparts(thisFile);
% rootFilePath = extractBefore(filepath,'Functions');

rootFilePath = pwd;
fcn_DebugTools_cprintf('*blue',sprintf('Checking root folder:'));
fprintf(1,'\n\t');
fprintf(1,'%s:\n', rootFilePath);


%% Make sure there is only one .m file in main folder
fcn_DebugTools_cprintf('*blue','');
fcn_DebugTools_cprintf('*blue',sprintf('\tChecking that there is 1 m-file in root folder: '));

fileListRootFolder = dir(rootFilePath);
[...
    ~,...
    flags_isMfile,...
    ~,...
    ~,...
    ~,...
    ~,...
    ~,...
    ~...
    ] = fcn_INTERNAL_flagFiles(fileListRootFolder);

sumOfmFiles = sum(flags_isMfile);
if sumOfmFiles~=1
    fcn_DebugTools_cprintf('*Red',sprintf('FAILED... %.0f were found!\n', sumOfmFiles));
else
    fcn_DebugTools_cprintf('*Green',sprintf('PASSED.\n'));
end
% script_test_fcn_DebugTools_cprintf

%% Check that "script_demo_(reponame).m" exists
repoDemoNameString = cat(2,'script_demo',repoShortName(1:end-1),'.m');
fcn_DebugTools_cprintf('*blue',sprintf('\tChecking that there is a demo file, %s: ', repoDemoNameString));

if exist(repoDemoNameString,'file')
	fcn_DebugTools_cprintf('*Green',sprintf('PASSED.'));
	fprintf(1,'\n');
else
	fcn_DebugTools_cprintf('*Red',sprintf('FAILED.'));
	fprintf(1,'\n');
end

%% Check that "README.md" exists
expectedNameString = 'README.md';
fcn_DebugTools_cprintf('*blue',sprintf('\tChecking that there is a README.md file: '));

if exist(expectedNameString,'file')
    fcn_DebugTools_cprintf('*Green',sprintf('PASSED.\n'));
else
    fcn_DebugTools_cprintf('*Red',sprintf('FAILED.\n'));
end

%% Checking existence of key folders
expectedFolders = {'Functions', 'Data', 'Documents', 'Installer', 'Images'};
for ith_expectedFolder = 1:length(expectedFolders)
    thisFolder = expectedFolders{ith_expectedFolder};
    fcn_DebugTools_cprintf('*blue',sprintf('\tChecking that there is a %s subfolder: ', thisFolder));
    expectedPath = fullfile(rootFilePath,thisFolder);
    if exist(expectedPath,'dir')
        fcn_DebugTools_cprintf('*Green',sprintf('PASSED.\n'));
    else
        fcn_DebugTools_cprintf('*Red',sprintf('FAILED.\n'));
    end
end

%% Main demo file checks start here
fcn_DebugTools_cprintf('*blue',sprintf('Checking main demo file:\n\t%s:\n', repoDemoNameString));

%% Does main file contain required strings?

temp = struct;
temp(1).name = repoDemoNameString;
temp(1).folder = rootFilePath;

requiredStrings = {...
    'REVISION HISTORY',...
    'TO-DO', ...
    cat(2,'MATLABFLAG',upper(repoShortName),'FLAG_CHECK_INPUTS'),...
    cat(2,'MATLABFLAG',upper(repoShortName),'FLAG_DO_DEBUG')...
    };
if ~contains(rootFilePath,'Debug')
    requiredStrings = [requiredStrings,'fcn_DebugTools_autoInstallRepos'];
end
for ith_string = 1:length(requiredStrings)
    thisString = requiredStrings{ith_string};
    fcn_DebugTools_cprintf('*blue',sprintf('\tChecking that it contains "%s": ', thisString));
    flagsStringWasFoundInFiles = fcn_DebugTools_directoryStringQuery(temp, thisString, (-1));

    if flagsStringWasFoundInFiles
        fcn_DebugTools_cprintf('*Green',sprintf('PASSED.\n'));
    else
        fcn_DebugTools_cprintf('*Red',sprintf('FAILED.\n'));
    end
end


%% Now check the Functions folder

functionsDirectoryQuery = fullfile(pwd,'Functions','*.*');
% Use the following instead, if wish to do subdirectories
% directoryQuery = fullfile(pwd,'Functions','**','*.*');

fileListFunctionsFolder = dir(functionsDirectoryQuery); %cat(2,'.',filesep,filesep,'script_test_fcn_*.m'));

% Filter out directories from the list
fileListFunctionsFolderNoDirectories = fileListFunctionsFolder(~[fileListFunctionsFolder.isdir]);

% Filter out key files from the list
flagsFilesToKeep = true(length(fileListFunctionsFolderNoDirectories),1);
flagsFilesToKeep = fcn_INTERNAL_removeFromList(flagsFilesToKeep, fileListFunctionsFolderNoDirectories,'script_test_all_functions');
flagsFilesToKeep = fcn_INTERNAL_removeFromList(flagsFilesToKeep, fileListFunctionsFolderNoDirectories,'fcn_DebugTools_testRepoForRelease');
flagsFilesToKeep = fcn_INTERNAL_removeFromList(flagsFilesToKeep, fileListFunctionsFolderNoDirectories,'script_test_fcn_DebugTools_testRepoForRelease');
flagsFilesToKeep = fcn_INTERNAL_removeFromList(flagsFilesToKeep, fileListFunctionsFolderNoDirectories,'.p');
flagsFilesToKeep = fcn_INTERNAL_removeFromList(flagsFilesToKeep, fileListFunctionsFolderNoDirectories,'.asv');

fileListFunctionsFolderCleaned = fileListFunctionsFolderNoDirectories(flagsFilesToKeep);


%% Make sure there's no forbidden strings
forbiddenStrings = {
    cat(2,'cl','c');
    cat(2,'clear',' all');
    };

for ith_forbidden = 1:length(forbiddenStrings)
    queryString = forbiddenStrings{ith_forbidden};
    flagsStringWasFoundInFiles = fcn_DebugTools_directoryStringQuery(fileListFunctionsFolderCleaned, queryString, (-1));
    if sum(flagsStringWasFoundInFiles)>0
        fcn_DebugTools_directoryStringQuery(fileListFunctionsFolderCleaned, queryString, 1);
        error('A "%s" forbidden string was found in one of the functions or scripts - see listing above. This needs to be fixed before continuing the testing.',queryString);
    end
end

%% Make sure there's no warning strings
warningStrings = {
    cat(2,'fig_','num');
    cat(2,'% -','-');
    };

for ith_forbidden = 1:length(warningStrings)
    queryString = warningStrings{ith_forbidden};
    flagsStringWasFoundInFiles = fcn_DebugTools_directoryStringQuery(fileListFunctionsFolderCleaned, queryString, (-1));
    if sum(flagsStringWasFoundInFiles)>0
        fcn_DebugTools_directoryStringQuery(fileListFunctionsFolderCleaned, queryString, 1);
        warning('A "%s" string was found in one of the functions or scripts - see listing above. This should be fixed to maintain compatibilty.',queryString);
    end
end

%% Match functions to scripts
[...
    flags_isFile,...
    flags_isMfile,...
    flags_isMfileFunction,...
    flags_isMfileRepeated,...
    flags_isMfileTestedFunction,...
    flags_isMfileTestingScript,...
    flags_isMfileTestingScriptWithMatchingFunction,...
    flags_isEitherTestScriptOrTestedFunction...
    ] = fcn_INTERNAL_flagFiles(fileListFunctionsFolderCleaned); %#ok<ASGLU>

%% Summarize results
fprintf(1,'\nSUMMARY OF FOUND FILES: \n');
indicies_filesToTest = find(1==flags_isMfileTestingScriptWithMatchingFunction);
if ~isempty(indicies_filesToTest)
    fcn_DebugTools_cprintf('*blue',sprintf('The following scripts were found that will be tested:\n'));
    fcn_DebugTools_cprintf('*blue',sprintf('\tThere are %.0f total testable functions in this repo:\n',length(indicies_filesToTest)));
    for ith_file = 1:length(indicies_filesToTest)
        currentFileIndex = indicies_filesToTest(ith_file);
        fprintf(1,'\t%s\n',fileListFunctionsFolderCleaned(currentFileIndex).name)
    end    
end

% List missed files
indicies_missedFiles_flags = flags_isFile.*(0==flags_isMfile);
indicies_missedFiles = find(indicies_missedFiles_flags);
if ~isempty(indicies_missedFiles)
    fcn_DebugTools_cprintf('*red',sprintf('The following files were found, but do not seem to be repo functions or scripts:\n'));
    for ith_file = 1:length(indicies_missedFiles)
        currentFileIndex = indicies_missedFiles(ith_file);
        fcn_DebugTools_cprintf('*red',sprintf('\t%s\n',fileListFunctionsFolderCleaned(currentFileIndex).name))
    end    
end

% List mfiles that are not testing scripts or functions
indicies_missedMfiles_flags = flags_isMfile.*(0==flags_isMfileFunction).*(0==flags_isMfileTestingScript);
indicies_missedMfiles = find(indicies_missedMfiles_flags);

if ~isempty(indicies_missedMfiles)
    fcn_DebugTools_cprintf('*red',sprintf('The following m-files were found, but do not seem to be test scripts or functions:\n'));
    for ith_file = 1:length(indicies_missedMfiles)
        currentFileIndex = indicies_missedMfiles(ith_file);
        fcn_DebugTools_cprintf('*red',sprintf('\t%s\n',fileListFunctionsFolderCleaned(currentFileIndex).name))
    end    
end

% List missed functions
indicies_missedFunctions = find(1==(flags_isMfileFunction.*(0==flags_isMfileTestedFunction)));
if ~isempty(indicies_missedFunctions)
    fcn_DebugTools_cprintf('*red',sprintf('The following functions were found, but do not have a matching test scripts:\n'));
    for ith_file = 1:length(indicies_missedFunctions)
        currentFileIndex = indicies_missedFunctions(ith_file);
        fcn_DebugTools_cprintf('*red',sprintf('\t%s\n',fileListFunctionsFolderCleaned(currentFileIndex).name))
    end    
end

% List missed scripts
indicies_missedScripts = find(1==(flags_isMfileTestingScript.*(0==flags_isMfileTestingScriptWithMatchingFunction)));
if ~isempty(indicies_missedScripts)
    fcn_DebugTools_cprintf('*red',sprintf('The following test scripts were found, but do not have a matching function:\n'));
    for ith_file = 1:length(indicies_missedScripts)
        currentFileIndex = indicies_missedScripts(ith_file);
        fcn_DebugTools_cprintf('*red',sprintf('\t%s\n',fileListFunctionsFolderCleaned(currentFileIndex).name))
    end    
end

% List repeats
indicies_repeatedFiles = find(1==flags_isMfileRepeated);
if ~isempty(indicies_repeatedFiles)
    fcn_DebugTools_cprintf('*red',sprintf('The following files seem to be repeated:\n'));
    for ith_file = 1:length(indicies_repeatedFiles)
        currentFileIndex = indicies_repeatedFiles(ith_file);
        fcn_DebugTools_cprintf('*red',sprintf('\t%s\n',fileListFunctionsFolderCleaned(currentFileIndex).name))
    end    
end

%% Make sure all functions have correct global variables
temp = fileListFunctionsFolderCleaned(indicies_filesToTest);
for ith_file = 1:length(temp)
    temp(ith_file).name = extractAfter(temp(ith_file).name,'script_test_');
end
queryString = upper(repoShortName);
flagsStringWasFoundInFiles = fcn_DebugTools_directoryStringQuery(temp, queryString, (-1));
if ~all(flagsStringWasFoundInFiles)
    fcn_DebugTools_directoryStringQuery(temp, queryString, 1);
    warning('backtrace','on');
    warning('The global variable: %s is expected in every file, but was not found. See above listing.',queryString);
end


%% Test the good scripts
NtestScripts = length(indicies_filesToTest);
fprintf(1,'\nSTARTING TESTS:\n');
allResults = cell(NtestScripts,1);
testing_times = nan(NtestScripts,1);
for ith_testScript = 1:NtestScripts
    currentFileIndex = indicies_filesToTest(ith_testScript);
    file_name_extended = fileListFunctionsFolderCleaned(currentFileIndex).name;
    file_name = erase(file_name_extended,'.m');
    file_name_trunc = erase(file_name,'script_');
    fcn_DebugTools_cprintf('*blue',sprintf('%s\n','   '));
    fcn_DebugTools_cprintf('*blue',sprintf('Testing script: %.0d of %.0d, %s\n\n',ith_testScript,NtestScripts,file_name_trunc));

    % Start the test
    tstart = tic;
    suite = testsuite(file_name);
    allResults{ith_testScript,1} = run(suite);
    telapsed = toc(tstart);
    testing_times(ith_testScript) = telapsed;
    % pause;
end
diary off

close all;
figure(1)
plot(testing_times);
grid on;
xlabel('Script test number');
ylabel('Elapsed time to test (sec)');


%% Check which files contain key strings?
if 1==0
    clc
    functionsDirectoryQuery = fullfile(pwd,'Functions','*.*');
    % Use the following instead, if wish to do subdirectories
    % directoryQuery = fullfile(pwd,'Functions','**','*.*');

    fileListFunctionsFolder = dir(functionsDirectoryQuery); %cat(2,'.',filesep,filesep,'script_test_fcn_*.m'));

    % Filter out directories from the list
    fileListFunctionsFolderNoDirectories = fileListFunctionsFolder(~[fileListFunctionsFolder.isdir]);

    % Set a query string to search for. Separate it into parts so that this
    % file does not show up on search list! :-)
    queryString = cat(2,'% ','--');
    flagsStringWasFoundInFilesRaw = fcn_DebugTools_directoryStringQuery(fileListFunctionsFolderNoDirectories, queryString, (-1));
    % flagsStringWasFoundInFiles = fcn_INTERNAL_removeFromList(flagsStringWasFoundInFilesRaw, fileListFunctionsFolderNoDirectories,'script_test_all_functions');
    if sum(flagsStringWasFoundInFilesRaw)>0
        fcn_DebugTools_directoryStringQuery(fileListFunctionsFolderNoDirectories, queryString, 1);
        error('A "%s" was found in one of the functions - see listing above.', queryString);
    end

    %%
    if 1==1
        %%%% WARNING - USE THIS WITH CAUTION! %%%%%%%%%%%%
        if 1==1
            functionsDirectory = fullfile(pwd,'Functions');
            fcn_DebugTools_replaceStringInDirectory(functionsDirectory, 'fig_num', 'figNum', ('fcn_Laps_'), (1));
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

if flag_do_plots
	if ~isempty(figNum)
		fprintf(1,'Done testing the repo for release!\n\n');
	end
    % % Extract and display release information
    % disp(['Repository: ', owner, '/', repo]);
    % if isfield(latestReleaseStruct, 'tag_name')
    %     disp(['Latest release version: ', latestReleaseStruct.tag_name]);
    % else
    %     disp('Could not find tag_name in the release information.');
    % end
    % 
    % if isfield(latestReleaseStruct, 'name')
    %     disp(['Release Name: ', latestReleaseStruct.name]);
    % end
    % 
    % if isfield(latestReleaseStruct, 'published_at')
    %     disp(['Published At: ', latestReleaseStruct.published_at]);
    % end
    % 
    % if isfield(latestReleaseStruct, 'body')
    %     disp('Release Notes:');
    %     disp(latestReleaseStruct.body);
    % end
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

%% fcn_INTERNAL_removeFromList
function newFlags = fcn_INTERNAL_removeFromList(flagsToFix, fileList,fileToRemove)
% Remove this function from list
newFlags = flagsToFix;
for ith_file = 1:length(fileList)
    if contains(fileList(ith_file).name,fileToRemove)
        newFlags(ith_file) = false;
    end
end
end % Ends fcn_INTERNAL_removeFromList

%% fcn_INTERNAL_flagFiles
function [...
    flags_isFile,...
    flags_isMfile,...
    flags_isMfileFunction,...
    flags_isMfileRepeated,...
    flags_isMfileTestedFunction,...
    flags_isMfileTestingScript,...
    flags_isMfileTestingScriptWithMatchingFunction,...
    flags_isEitherTestScriptOrTestedFunction...
    ] = fcn_INTERNAL_flagFiles(fileListFunctionsFolderNoDirectories)

N_files = length(fileListFunctionsFolderNoDirectories);


flags_isFile  = zeros(N_files,1); % All files (excludes directories)

flags_isMfile = zeros(N_files,1); % File has a .m extension
flags_isMfileFunction = zeros(N_files,1); % File starts with fcn_
flags_isMfileRepeated = zeros(N_files,1); % File is repeated between folders
flags_isMfileTestedFunction = zeros(N_files,1); % File is a fcn_XXX and there's a script_test_XXX that tests it

flags_isMfileTestingScript = zeros(N_files,1); % File starts with script_test_fcn_
flags_isMfileTestingScriptWithMatchingFunction = zeros(N_files,1); % File is a script_test_XXX that matches a function

% Check all the files to see which ones should be tested
for i_script = 1:N_files
    % Is this a file?
    if ~fileListFunctionsFolderNoDirectories(i_script).isdir
        flags_isFile(i_script,1) = 1;
    end

    file_name_extended = fileListFunctionsFolderNoDirectories(i_script).name;
    file_directory = fileListFunctionsFolderNoDirectories(i_script).folder;

    % Is this an m-file?
    if (1==flags_isFile(i_script,1) ) && length(file_name_extended)>2 && strcmp(file_name_extended(end-1:end),'.m')
        flags_isMfile(i_script,1) = 1;

        % Is this a repeated m-file?
        for jth_file = 1:N_files
            nameToTest = fileListFunctionsFolderNoDirectories(jth_file).name;
            if (i_script~=jth_file) && strcmp(file_name_extended,nameToTest)
                flags_isMfileRepeated(jth_file,1) = 1;
            end
        end
    end

    % Is this an m-file function?
    if (1==flags_isMfile(i_script,1)) && length(file_name_extended)>7 && strcmp(file_name_extended(1:4),'fcn_')
        flags_isMfileFunction(i_script,1) = 1;

        % Does this m-file function have a matching test script?
        testName = cat(2,'script_test_',file_name_extended);
        testFullPathName = fullfile(file_directory,testName);
        for jth_file = 1:N_files
            listedFullName = fullfile(fileListFunctionsFolderNoDirectories(jth_file).folder,fileListFunctionsFolderNoDirectories(jth_file).name);
            if strcmp(testFullPathName,listedFullName)
                flags_isMfileTestedFunction(i_script,1) = 1;
            end
        end

    end

    % Is this an m-file testing script?
    if (1==flags_isMfile(i_script,1) ) && length(file_name_extended)>19 && strcmp(file_name_extended(1:16),'script_test_fcn_')
        flags_isMfileTestingScript(i_script,1) = 1;

        % Does this testing script match to a function?
        testMfileName = file_name_extended(13:end);
        testFullPathName = fullfile(file_directory,testMfileName);
        for jth_file = 1:N_files
            listedFullName = fullfile(fileListFunctionsFolderNoDirectories(jth_file).folder,fileListFunctionsFolderNoDirectories(jth_file).name);
            if strcmp(testFullPathName,listedFullName)
                flags_isMfileTestingScriptWithMatchingFunction(i_script,1) = 1;
            end
        end
    end

end

flags_isEitherTestScriptOrTestedFunction = flags_isMfileTestedFunction+flags_isMfileTestingScriptWithMatchingFunction;

end % Ends fcn_INTERNAL_flagFiles