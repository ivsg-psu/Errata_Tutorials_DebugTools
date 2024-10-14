% script_test_fcn_DebugTools_printDirectoryListing.m
% tests fcn_DebugTools_printDirectoryListing.m

% Revision history
% 2024_10_13 - sbrennan@psu.edu
% -- wrote the code originally, using fcn_DataClean_loadRawDataFromDirectories as starter

%% Set up the workspace
close all

%% Test 1: File query and simple print

directory_filelist = fcn_DebugTools_listDirectoryContents({cd});

fcn_DebugTools_printDirectoryListing(directory_filelist);


%% Test 2: titleString set

directory_filelist = fcn_DebugTools_listDirectoryContents({fullfile(cd,'Functions')},'*.m',0);


titleString = 'This is a listing of Functions';
rootDirectoryString = [];
fid = 1;
fcn_DebugTools_printDirectoryListing(directory_filelist, (titleString), (rootDirectoryString), (fid))


%% Test 3: rootDirectoryString set

directory_filelist = fcn_DebugTools_listDirectoryContents({fullfile(cd,'Functions')},'*.m',0);


titleString = 'This is a listing of Functions';
rootDirectoryString = cd;
fid = 1;
fcn_DebugTools_printDirectoryListing(directory_filelist, (titleString), (rootDirectoryString), (fid))



%% Fail conditions
if 1==0
    %% ERROR for bad data folder
    bagName = "badData";
    rawdata = fcn_DataClean_loadMappingVanDataFromFile(bagName, bagName);
end
