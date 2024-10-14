% script_test_fcn_DebugTools_listDirectoryContents.m
% tests fcn_DebugTools_listDirectoryContents.m

% Revision history
% 2024_10_02 - sbrennan@psu.edu
% -- wrote the code originally, using fcn_DataClean_loadRawDataFromDirectories as starter

%% Set up the workspace
close all

%% Choose data folder and bag name, read before running the script
% The parsed the data files are saved on OneDrive
% in \IVSG\GitHubMirror\MappingVanDataCollection\ParsedData. To process the
% bag file, please copy file folder to the LargeData folder.

%% Test 0: most basic usage
directory_filelist = fcn_DebugTools_listDirectoryContents({cd});

% Check the results
assert(isstruct(directory_filelist));
assert(length(directory_filelist)>1);


%% Test 1: File query
% fig_num = 1;
% figure(fig_num);
% clf;

clear rootdirs
rootdirs{1} = fullfile(cd,'Functions');

% Specify the fileQueryString
fileQueryString = '*.m'; % The more specific, the better to avoid accidental loading of wrong information

% Specify the flag_fileOrDirectory
flag_fileOrDirectory = 0; % 0 = a file, 1 = directory, 2 = both

% Specify the fid
fid = 1; % 1 --> print to console

% Call the function
directory_filelist = fcn_DebugTools_listDirectoryContents(rootdirs, (fileQueryString), (flag_fileOrDirectory), (fid));

% Check the results
assert(isstruct(directory_filelist));
assert(length(directory_filelist)>1);


%% Test 2: File query, specific string
% fig_num = 1;
% figure(fig_num);
% clf;

clear rootdirs
rootdirs{1} = fullfile(cd,'Functions');

% Specify the fileQueryString
fileQueryString = 'script_test_fcn_DebugTools*.m'; % The more specific, the better to avoid accidental loading of wrong information

% Specify the flag_fileOrDirectory
flag_fileOrDirectory = 0; % 0 = a file, 1 = directory, 2 = both

% Specify the fid
fid = 1; % 1 --> print to console

% Call the function
directory_filelist = fcn_DebugTools_listDirectoryContents(rootdirs, (fileQueryString), (flag_fileOrDirectory), (fid));

% Check the results
assert(isstruct(directory_filelist));
assert(length(directory_filelist)>1);


%% Test 3: Directory query, specific string
% fig_num = 1;
% figure(fig_num);
% clf;

clear rootdirs
rootdirs{1} = fullfile(cd);

% Specify the fileQueryString
fileQueryString = 'Functions'; % The more specific, the better to avoid accidental loading of wrong information

% Specify the flag_fileOrDirectory
flag_fileOrDirectory = 1; % A directory

% Specify the fid
fid = 1; % 1 --> print to console

% Call the function
directory_filelist = fcn_DebugTools_listDirectoryContents(rootdirs, (fileQueryString), (flag_fileOrDirectory), (fid));

% Check the results
assert(isstruct(directory_filelist));
assert(length(directory_filelist)>=1);

%% Test 3: Directory query, specific string
% fig_num = 1;
% figure(fig_num);
% clf;

% List which directory/directories need to be loaded
clear rootdirs
rootdirs{1} = fullfile(cd,'Images');
rootdirs{2} = fullfile(cd,'Documents');
rootdirs{3} = fullfile(cd,'Functions');


% Specify the fileQueryString
fileQueryString = '*.m'; % The more specific, the better to avoid accidental loading of wrong information

% Specify the flag_fileOrDirectory
flag_fileOrDirectory = 0; % 0 = a file, 1 = directory, 2 = both

% Specify the fid
fid = 1; % 1 --> print to console

% Call the function
directory_filelist = fcn_DebugTools_listDirectoryContents(rootdirs, (fileQueryString), (flag_fileOrDirectory), (fid));

% Check the results
assert(isstruct(directory_filelist));
assert(length(directory_filelist)>1);

%% Test 4: File listing, all script files in Functions directory
% fig_num = 1;
% figure(fig_num);
% clf;

% List which directory/directories need to be loaded
clear rootdirs
rootdirs{1} = fullfile(cd,'Functions');


% Specify the fileQueryString
fileQueryString = 'script*.m'; % The more specific, the better to avoid accidental loading of wrong information

% Specify the flag_fileOrDirectory
flag_fileOrDirectory = 0; % 0 = a file, 1 = directory, 2 = both

% Specify the fid
fid = 1; % 1 --> print to console

% Call the function
directory_filelist = fcn_DebugTools_listDirectoryContents(rootdirs, (fileQueryString), (flag_fileOrDirectory), (fid));

% Check the results
assert(isstruct(directory_filelist));
assert(length(directory_filelist)>1);


%% Fail conditions
if 1==0
    %% ERROR for bad data folder
    bagName = "badData";
    rawdata = fcn_DataClean_loadMappingVanDataFromFile(bagName, bagName);
end

function timeNumber = fcn_INTERNAL_findTimeFromName(fileName)

timeString = [];
if length(fileName)>4
    splitName = strsplit(fileName,{'_','.'});
    for ith_split = 1:length(splitName)
        if contains(splitName{ith_split},'-')
            timeString = splitName{ith_split};
        end
    end
end
timeNumber = datetime(timeString,'InputFormat','yyyy-MM-dd-HH-mm-ss');
end