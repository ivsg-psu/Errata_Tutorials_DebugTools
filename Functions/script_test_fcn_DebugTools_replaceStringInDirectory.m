% script_test_fcn_DebugTools_replaceStringInDirectory
% Define your directory path, old string, and new string
directoryPath = fullfile(cd,'Functions');

oldString = cat(2,'la','la');
newString = cat(2,'ba','a');
filenameNewString = 'script_test_fcn_DebugTools_replaceStringInDirectory';
figNum = -1;

% Fill a test string. THIS WILL CHANGE from la+la to ba+a
changingString = 'lala';

% Show that first two letters are 'la'
assert(strcmp(changingString(1:2),'la'));

% Call the function to perform the replacement
fcn_DebugTools_replaceStringInDirectory(directoryPath, oldString, newString, (filenameNewString), (figNum));

% One must exit the file view and reenter for it to refresh!
%%
% Fill a test string. THIS WILL CHANGE 
changingString = 'lala';

% Show that first two letters are 'ba'
assert(strcmp(changingString(1:2),'ba'));

% Call the function to perform the replacement back
fcn_DebugTools_replaceStringInDirectory(directoryPath, newString, oldString, (filenameNewString), (figNum));

%% Here's how it is typically used in a folder
if 1==0
    fcn_DebugTools_replaceStringInDirectory(pwd, '_BOUNDASTAR_', '_BOUNDEDASTAR_', (''), (-1));
end
