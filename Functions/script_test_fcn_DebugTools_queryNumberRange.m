% script_test_fcn_DebugTools_queryNumberRange.m
% tests fcn_DebugTools_queryNumberRange.m

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
dirScripts = contains(dirNames,'script');
celldirScripts = mat2cell(dirScripts,ones(1,length(dirNames)));
dirScriptYesNo = fcn_DebugTools_convertBinaryToYesNoStrings(dirScripts);

cellArrayHeaders = {'m-filename                                                         ', 'Script flag?   ', 'Script?   '};
cellArrayValues = [dirNames, celldirScripts, dirScriptYesNo];

% Print to screen
fid = 1;
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


%% Test 2: Simple example, no directory listing

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
fid = 1;
fcn_DebugTools_printNumeredDirectoryList(directory_filelist, cellArrayHeaders, cellArrayValues, ([]), (fid))


% Set up call to function
flags_toCheck = dirScripts;
queryEndString = ' function to change to script';
flag_confirmOverwrite = 1;
fid = 1;
[flag_keepGoing, indiciesSelected] = fcn_DebugTools_queryNumberRange(flags_toCheck, (queryEndString), (flag_confirmOverwrite), ([]), (fid));

assert(flag_keepGoing==1 || flag_keepGoing==0);
if ~isempty(indiciesSelected)
    assert(min(indiciesSelected)>0 && max(indiciesSelected)<=length(flags_toCheck));
    assert(length(indiciesSelected)<=length(flags_toCheck));
end


%% Test 3: Simple example, no directory listing, no overwrite confirm

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
fid = 1;
fcn_DebugTools_printNumeredDirectoryList(directory_filelist, cellArrayHeaders, cellArrayValues, ([]), (fid))


% Set up call to function
flags_toCheck = dirScripts;
queryEndString = ' function to change to script';
flag_confirmOverwrite = 0;
fid = 1;
[flag_keepGoing, indiciesSelected] = fcn_DebugTools_queryNumberRange(flags_toCheck, (queryEndString), (flag_confirmOverwrite), ([]), (fid));

assert(flag_keepGoing==1 || flag_keepGoing==0);
if ~isempty(indiciesSelected)
    assert(min(indiciesSelected)>0 && max(indiciesSelected)<=length(flags_toCheck));
    assert(length(indiciesSelected)<=length(flags_toCheck));
end


%% Test 4: Simple example, but flags are not continuous (checks end point)

rng(1);

% Create a directory filelist by querying the "Functions" folder for all .m
% files
directory_filelist = fcn_DebugTools_listDirectoryContents({fullfile(cd,'Functions')},'*.m',0);

dirNames = {directory_filelist.name}';
dirScripts = contains(dirNames,'print');
celldirScripts = mat2cell(dirScripts,ones(1,length(dirNames)));
dirScriptYesNo = fcn_DebugTools_convertBinaryToYesNoStrings(dirScripts);

cellArrayHeaders = {'m-filename                                                         ', 'Script flag?   ', 'Script?   '};
cellArrayValues = [dirNames, celldirScripts, dirScriptYesNo];

% Print to screen
fid = 1;
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




%% Fail conditions
if 1==0
    %% ERROR for bad data folder
    bagName = "badData";
    rawdata = fcn_DataClean_loadMappingVanDataFromFile(bagName, bagName);
end
