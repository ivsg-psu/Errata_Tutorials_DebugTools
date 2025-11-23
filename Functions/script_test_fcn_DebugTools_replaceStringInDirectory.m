% script_test_fcn_DebugTools_replaceStringInDirectory

% REVISION HISTORY:
% 2025_11_20 by S. Brennan
% - Formatted revision lists to Markdown format

% TO-DO:
% 2025_11_20 by Sean Brennan, sbrennan@psu.edu
% - fill in to-do items here.

if 1==0

    % Define the directory path, old string, and new string
    directoryPath = fullfile(cd,'Functions');

    oldString = cat(2,'la','la');
    newString = cat(2,'ba','a');
    filenameNewString = 'script_test_fcn_DebugTools_replaceStringInDirectory';
    flagSkipCommentedLines = [];
    figNum = -1;

    % Fill a test string. THIS WILL CHANGE from la+la to ba+a
    changingString = 'lala';

    % Show that first two letters are 'la'
    assert(strcmp(changingString(1:2),'la'));

    % Call the function to perform the replacement
    fcn_DebugTools_replaceStringInDirectory(directoryPath, oldString, newString, (filenameNewString), (flagSkipCommentedLines), (figNum));

    % One must exit the file view and reenter for it to refresh!


    %%
    % Change the string back

    % Fill a test string. THIS WILL CHANGE
    changingString = 'lala';

    % Show that first two letters are 'ba'
    assert(strcmp(changingString(1:2),'ba'));

    % Call the function to perform the replacement back
    fcn_DebugTools_replaceStringInDirectory(directoryPath, newString, oldString, (filenameNewString), (flagSkipCommentedLines), (figNum));
end

%% Perform verification (commented out to allow auto-testing)
if 1==0

    % Define the directory path, old string, and new string
    directoryPath = fullfile(cd,'Functions');

    oldString = cat(2,'la','la');
    newString = cat(2,'ba','a');
    filenameNewString = 'script_test_fcn_DebugTools_replaceStringInDirectory';
    flagSkipCommentedLines = [];
    figNum = 1;

    % Fill a test string. THIS WILL CHANGE from la+la to ba+a
    changingString = 'lala';

    % Show that first two letters are 'la'
    assert(strcmp(changingString(1:2),'la'));

    % Call the function to perform the replacement
    fcn_DebugTools_replaceStringInDirectory(directoryPath, oldString, newString, (filenameNewString), (flagSkipCommentedLines), (figNum));

    % One must exit the file view and reenter for it to refresh!

    %%
    %%%%
    % Change the string back

    % Fill a test string. THIS WILL CHANGE
    changingString = 'lala';

    % Show that first two letters are 'ba'
    assert(strcmp(changingString(1:2),'ba'));

    % Call the function to perform the replacement back
    fcn_DebugTools_replaceStringInDirectory(directoryPath, newString, oldString, (filenameNewString), (flagSkipCommentedLines), (figNum));

end


%% Skips commented out lines
% lala
if 1==0

    % Define the directory path, old string, and new string
    directoryPath = fullfile(cd,'Functions');

    oldString = cat(2,'% la','la');
    newString = cat(2,'% ba','a');
    filenameNewString = 'script_test_fcn_DebugTools_replaceStringInDirectory';
    flagSkipCommentedLines = 1;
    figNum = 1;

    % Fill a test string. THIS WILL CHANGE from la+la to ba+a
    changingString = '% lala';

    % Show that first 4 letters are '% la'
    assert(strcmp(changingString(1:4),'% la'));

    % Call the function to perform the replacement
    fcn_DebugTools_replaceStringInDirectory(directoryPath, oldString, newString, (filenameNewString), (flagSkipCommentedLines), (figNum));

    % Show that first 4 letters are '% la'
    assert(strcmp(changingString(1:4),'% la'));

    % One must exit the file view and reenter for it to refresh!

    %% SET FLAG TO CAUSE REPLACMENT
    flagSkipCommentedLines = 0;

    % Call the function to perform the replacement
    fcn_DebugTools_replaceStringInDirectory(directoryPath, oldString, newString, (filenameNewString), (flagSkipCommentedLines), (figNum));

    % One must exit the file view and reenter for it to refresh!

    %%
    %%%%
    % Change the string back

    % Fill a test string. THIS WILL CHANGE
    changingString = '% lala';

    % Show that first two letters are 'ba'
    assert(strcmp(changingString(1:4),'% ba'));

    % Call the function to perform the replacement back
    fcn_DebugTools_replaceStringInDirectory(directoryPath, newString, oldString, (filenameNewString), (flagSkipCommentedLines), (figNum));

end

%% Here's how it is typically used in a folder
if 1==0
    fcn_DebugTools_replaceStringInDirectory(pwd, '_BOUNDASTAR_', '_BOUNDEDASTAR_', (''), (-1));
end
