% script_test_fcn_DebugTools_printNumeredDirectoryList.m
% tests fcn_DebugTools_printNumeredDirectoryList.m

% Revision history
% 2024_10_24 - sbrennan@psu.edu
% -- wrote the code originally, using fcn_DataClean_loadRawDataFromDirectories as starter

%% Set up the workspace
close all

%% Test 1: Simple example

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
fid = 1;
fcn_DebugTools_printNumeredDirectoryList(directory_filelist, cellArrayHeaders, cellArrayValues, ([]), (fid))

%% Test 2: Simple example with root specified

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

cellArrayHeaders = {'m-filename                                                        ', 'bytes    ', 'big file?   ', 'Some yes or no  ', 'Some float   '};
cellArrayValues = [dirNames, celldirBytes, celldirBigFile, dirBigFileYesNo, celldirFloat];

% Call the function
fid = 1;
fcn_DebugTools_printNumeredDirectoryList( ...
    directory_filelist, cellArrayHeaders, cellArrayValues, (fullfile(cd,'Functions')), (fid))


%% Fail conditions
if 1==0
    %% ERROR for bad data folder
    bagName = "badData";
    rawdata = fcn_DataClean_loadMappingVanDataFromFile(bagName, bagName);
end
