% script_test_fcn_DebugTools_convertBinaryToYesNoStrings.m
% tests fcn_DebugTools_convertBinaryToYesNoStrings.m

% Revision history
% 2024_10_24 - sbrennan@psu.edu
% -- wrote the code originally, using fcn_DataClean_loadRawDataFromDirectories as starter

%% Set up the workspace
close all

%% Test 1: Simple example

flags_binary = [0; 1; 0];
cellArrrayYesNo = fcn_DebugTools_convertBinaryToYesNoStrings(flags_binary);

assert(isequal(cellArrrayYesNo,{'no';'yes';'no'}))

%% Fail conditions
if 1==0
    %% ERROR for bad data folder
    bagName = "badData";
    rawdata = fcn_DataClean_loadMappingVanDataFromFile(bagName, bagName);
end
