% script_test_fcn_DebugTools_confirmTimeToProcessDirectory.m
% tests fcn_DebugTools_confirmTimeToProcessDirectory.m

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

%% Test 1: Calculate the time for processing the current directory (LONG)

directory_listing = fcn_DebugTools_listDirectoryContents({cd});
bytesPerSecond = 10;
indexRange = [];
fid = 1;
[flag_keepGoing, timeEstimateInSeconds] = fcn_DebugTools_confirmTimeToProcessDirectory(directory_listing, bytesPerSecond, (indexRange),(fid));

assert((flag_keepGoing==0) || (flag_keepGoing==1));
assert(timeEstimateInSeconds>=0);


%% Test 2: Calculate the time for processing the current directory (SHORT)

directory_listing = fcn_DebugTools_listDirectoryContents({cd});
bytesPerSecond = 10000000;
indexRange = [];
fid = 1;
[flag_keepGoing, timeEstimateInSeconds] = fcn_DebugTools_confirmTimeToProcessDirectory(directory_listing, bytesPerSecond, (indexRange),(fid));

assert((flag_keepGoing==0) || (flag_keepGoing==1));
assert(timeEstimateInSeconds>=0);


%% Fail conditions
if 1==0
    %% ERROR for bad data folder
    bagName = "badData";
    rawdata = fcn_DataClean_loadMappingVanDataFromFile(bagName, bagName);
end
