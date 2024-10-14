% script_test_fcn_DebugTools_makeDirectory.m
% tests fcn_DebugTools_makeDirectory.m

% Revision history
% 2024_10_13 - sbrennan@psu.edu
% -- wrote the code originally, using fcn_DataClean_loadRawDataFromDirectories as starter

%% Set up the workspace
close all

%% Test 1: File query and simple print

directoryPath = fullfile(cd,'Junk','Junk','Junk');
assert(7~=exist(directoryPath,'dir'));

fcn_DebugTools_makeDirectory(directoryPath);

assert(7==exist(directoryPath,'dir'));
rmdir('Junk','s');


%% Test 2: fid set

directoryPath = fullfile(cd,'Junk','Junk','Junk');
assert(7~=exist(directoryPath,'dir'));

fid = 1;

fcn_DebugTools_makeDirectory(directoryPath,fid);

assert(7==exist(directoryPath,'dir'));
rmdir('Junk','s');


%% Fail conditions
if 1==0
    %% ERROR for bad data folder
    bagName = "badData";
    rawdata = fcn_DataClean_loadMappingVanDataFromFile(bagName, bagName);
end
