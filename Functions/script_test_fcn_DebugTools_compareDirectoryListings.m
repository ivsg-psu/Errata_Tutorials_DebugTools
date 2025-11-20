% script_test_fcn_DebugTools_compareDirectoryListings.m
% tests fcn_DebugTools_compareDirectoryListings.m

% REVISION HISTORY:
% 
% 2024_10_24 by Sean Brennan, sbrennan@psu.edu
% - wrote the code originally
%   % * using fcn_DataClean_loadRawDataFromDirectories as starter
%
% 2025_11_20 by Sean Brennan, sbrennan@psu.edu
% - Formatted revision lists to Markdown format

% TO-DO:
% 2025_11_20 by Sean Brennan, sbrennan@psu.edu
% - Need to put into standard form

%% Set up the workspace
close all

%% Test 1: Simple example, matching "same", file to file

rng(1);

sourceRootString      = fullfile(cd,'Data','Example_compareDirectoryListings','SourceDirectory');
destinationRootString = fullfile(cd,'Data','Example_compareDirectoryListings','DestinationDirectory');


% Create a directory filelist by querying the "Functions" folder for all .m
% files
file_or_folder = 0; % Returns only files
directoryListing_source = fcn_DebugTools_listDirectoryContents({sourceRootString},'TestFolder*.m',file_or_folder);

% Call the function
flag_matchingType = 1; % Same to same
typeExtension = [];
fid = [];
flags_wasMatched = fcn_DebugTools_compareDirectoryListings(...
    directoryListing_source, sourceRootString, destinationRootString, ...
    (flag_matchingType), (typeExtension), (fid));

assert(isequal(flags_wasMatched,[1 1 0]'));

%% Test 2: Simple example, matching "same", directory to directory

rng(1);

sourceRootString      = fullfile(cd,'Data','Example_compareDirectoryListings','SourceDirectory');
destinationRootString = fullfile(cd,'Data','Example_compareDirectoryListings','DestinationDirectory');


% Create a directory filelist by querying the "Functions" folder for all .m
% files
file_or_folder = 1; % Returns only folders
directoryListing_source = fcn_DebugTools_listDirectoryContents({sourceRootString},'TestFolder*',file_or_folder);

% Call the function
flag_matchingType = 1; % Same to same
typeExtension = [];
fid = [];

flags_wasMatched = fcn_DebugTools_compareDirectoryListings( ...
    directoryListing_source, sourceRootString, destinationRootString, ...
    (flag_matchingType), (typeExtension),  (fid));

assert(isequal(flags_wasMatched,[1 0 1]'));

%% Test 3: Simple example, matching "fileToFolder"

rng(1);

sourceRootString      = fullfile(cd,'Data','Example_compareDirectoryListings','SourceDirectory');
destinationRootString = fullfile(cd,'Data','Example_compareDirectoryListings','DestinationDirectory');


% Create a directory filelist by querying the "Functions" folder for all .m
% files
file_or_folder = 0; % Returns only files
directoryListing_source = fcn_DebugTools_listDirectoryContents({sourceRootString},'TestFolder*',file_or_folder);

% Call the function
flag_matchingType = 2; % fileToFolder
typeExtension = [];
fid = [];

flags_wasMatched = fcn_DebugTools_compareDirectoryListings( ...
    directoryListing_source, sourceRootString, destinationRootString, ...
    (flag_matchingType), (typeExtension),  (fid));

assert(isequal(flags_wasMatched,[1 0 1]'));

%% Test 4: Simple example, matching "folderToFile"

rng(1);

sourceRootString      = fullfile(cd,'Data','Example_compareDirectoryListings','SourceDirectory');
destinationRootString = fullfile(cd,'Data','Example_compareDirectoryListings','DestinationDirectory');


% Create a directory filelist by querying the "Functions" folder for all .m
% files
file_or_folder = 1; % Returns only folders
directoryListing_source = fcn_DebugTools_listDirectoryContents({sourceRootString},'TestFolder*',file_or_folder);

% Call the function
flag_matchingType = 3; % fileToFolder
typeExtension = [];
fid = [];

flags_wasMatched = fcn_DebugTools_compareDirectoryListings( ...
    directoryListing_source, sourceRootString, destinationRootString, ...
    (flag_matchingType), (typeExtension),  (fid));

assert(isequal(flags_wasMatched,[1 1 0]'));
%% Fail conditions
if 1==0
    %% ERROR for bad data folder
    bagName = "badData";
    rawdata = fcn_DataClean_loadMappingVanDataFromFile(bagName, bagName);
end
