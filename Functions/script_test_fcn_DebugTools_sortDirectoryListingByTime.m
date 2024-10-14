% script_test_fcn_DebugTools_sortDirectoryListingByTime.m
% tests fcn_DebugTools_sortDirectoryListingByTime.m

% Revision history
% 2024_10_13 - sbrennan@psu.edu
% -- wrote the code originally, using fcn_DataClean_loadRawDataFromDirectories as starter

%% Set up the workspace
close all

%% Test 1: File query and simple print

directory_filelist = fcn_DebugTools_listDirectoryContents({fullfile(cd,'Data')},'ExampleDateSorting*.txt',0);

sorted_directory_filelist = fcn_DebugTools_sortDirectoryListingByTime(directory_filelist);

fcn_DebugTools_printDirectoryListing(sorted_directory_filelist);


%% Fail conditions
if 1==0
    %% ERROR for bad data folder
    bagName = "badData";
    rawdata = fcn_DataClean_loadMappingVanDataFromFile(bagName, bagName);
end
