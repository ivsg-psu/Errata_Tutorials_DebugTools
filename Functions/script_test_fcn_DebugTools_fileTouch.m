% script_test_fcn_DebugTools_fileTouch.m
% This is a script to exercise the function: fcn_DebugTools_fileTouch
% This function was written on 2021_12_12 by S. Brennan
% Questions or comments? sbrennan@psu.edu


% REVISION HISTORY:
% 
% 2025_12_18 - S. Brennan
% - first write of the function using
%   % script_test_fcn_DebugTools_debug+PrintStringToNCharacters as a starter

% TO-DO:
% 2025_12_18 by Sean Brennan, sbrennan@psu.edu
% - fill in to-do items here.

%% Code demos start here
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   _____                              ____   __    _____          _
%  |  __ \                            / __ \ / _|  / ____|        | |
%  | |  | | ___ _ __ ___   ___  ___  | |  | | |_  | |     ___   __| | ___
%  | |  | |/ _ \ '_ ` _ \ / _ \/ __| | |  | |  _| | |    / _ \ / _` |/ _ \
%  | |__| |  __/ | | | | | (_) \__ \ | |__| | |   | |___| (_) | (_| |  __/
%  |_____/ \___|_| |_| |_|\___/|___/  \____/|_|    \_____\___/ \__,_|\___|
%
%
% See: https://patorjk.com/software/taag/#p=display&f=Big&t=Demos%20Of%20Code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Figures start with 1

close all;
fprintf(1,'Figure: 1XXXXXX: DEMO cases\n');

%% DEMO case: basic call with default inputs to touch non-existant file
figNum = 10001;
titleString = sprintf('DEMO case: basic call with default inputs to touch non-existant file');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);
figure(figNum); close(figNum);

% Fill in inputs
fileNameString = fullfile(pwd,'Data','testfile_fileTouch.txt');
fid = [];

% Delete the file, if it exists
if exist(fileNameString,'file')
    delete(fileNameString);
end

% Call function
[flagSuccessful,cmdout] = fcn_DebugTools_fileTouch(fileNameString, (fid));

% sgtitle(titleString, 'Interpreter','none');

% Check variable types
assert(islogical(flagSuccessful));
assert(ischar(cmdout));

% Check variable sizes
assert(size(flagSuccessful,1)==1);
assert(size(flagSuccessful,1)==1);
assert(size(cmdout,1)>=0);
assert(size(cmdout,2)>=0);

% Check variable values
assert(flagSuccessful);
assert(isempty(cmdout));
assert(exist(fileNameString,'file'))

% Make sure plot did NOT open up
figHandles = get(groot, 'Children');
assert(~any(figHandles==figNum));

% Delete the file, if it exists
if exist(fileNameString,'file')
    delete(fileNameString);
end

%% DEMO case: basic call with default inputs to touch existing file
figNum = 10002;
titleString = sprintf('DEMO case: basic call with default inputs to touch existing file');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);
figure(figNum); close(figNum);

% Fill in inputs
fileNameString = fullfile(pwd,'Data','testfile_fileTouch.txt');
fid = [];

% Create the file, if it does not exist
if ~exist(fileNameString,'file')
    fcn_DebugTools_fileTouch(fileNameString, (-1));
end
assert(exist(fileNameString,'file'))

fileInfoBefore = dir(fileNameString);
fileDateBefore = fileInfoBefore.datenum;

pause(2); % Wait 2 seconds for the date to change

% Call function
[flagSuccessful,cmdout] = fcn_DebugTools_fileTouch(fileNameString, (fid));

% sgtitle(titleString, 'Interpreter','none');

% Check variable types
assert(islogical(flagSuccessful));
assert(ischar(cmdout));

% Check variable sizes
assert(size(flagSuccessful,1)==1);
assert(size(flagSuccessful,1)==1);
assert(size(cmdout,1)>=0);
assert(size(cmdout,2)>=0);

% Check variable values
assert(flagSuccessful);
assert(exist(fileNameString,'file'))
fileInfoAfter = dir(fileNameString);
fileDateAfter = fileInfoAfter.datenum;
assert(~isequal(fileDateBefore,fileDateAfter));

% Make sure plot did NOT open up
figHandles = get(groot, 'Children');
assert(~any(figHandles==figNum));

% Delete the file, if it exists
if exist(fileNameString,'file')
    delete(fileNameString);
end

%% DEMO case: basic call being verbose
figNum = 10003;
titleString = sprintf('DEMO case: basic call being verbose');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);
figure(figNum); close(figNum);

% Fill in inputs
fileNameString = fullfile(pwd,'Data','testfile_fileTouch.txt');
fid = 1;

% Delete the file, if it exists
if exist(fileNameString,'file')
    delete(fileNameString);
end

% Call function
[flagSuccessful,cmdout] = fcn_DebugTools_fileTouch(fileNameString, (fid));

% sgtitle(titleString, 'Interpreter','none');

% Check variable types
assert(islogical(flagSuccessful));
assert(ischar(cmdout));

% Check variable sizes
assert(size(flagSuccessful,1)==1);
assert(size(flagSuccessful,1)==1);
assert(size(cmdout,1)>=0);
assert(size(cmdout,2)>=0);

% Check variable values
assert(flagSuccessful);
assert(isempty(cmdout));
assert(exist(fileNameString,'file'))

% Make sure plot did NOT open up
figHandles = get(groot, 'Children');
assert(~any(figHandles==figNum));

% Delete the file, if it exists
if exist(fileNameString,'file')
    delete(fileNameString);
end

%% DEMO case: basic call being verbose, with failure
figNum = 10004;
titleString = sprintf('DEMO case: basic call being verbose, with failure');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);
figure(figNum); close(figNum);

% Fill in inputs
fileNameString = fullfile(pwd,'FolderThatDoesNotExist','testfile_fileTouch.txt');
fid = 1;

% Delete the file, if it exists
if exist(fileNameString,'file')
    error('File should not exist');
end

% Call function
[flagSuccessful,cmdout] = fcn_DebugTools_fileTouch(fileNameString, (fid));

% sgtitle(titleString, 'Interpreter','none');

% Check variable types
assert(islogical(flagSuccessful));
assert(ischar(cmdout));

% Check variable sizes
assert(size(flagSuccessful,1)==1);
assert(size(flagSuccessful,1)==1);
assert(size(cmdout,1)>=0);
assert(size(cmdout,2)>=0);

% Check variable values
assert(~flagSuccessful);
assert(~isempty(cmdout));
assert(~exist(fileNameString,'file'))

% Make sure plot did NOT open up
figHandles = get(groot, 'Children');
assert(~any(figHandles==figNum));


%% Test cases start here. These are very simple, usually trivial
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  _______ ______  _____ _______ _____
% |__   __|  ____|/ ____|__   __/ ____|
%    | |  | |__  | (___    | | | (___
%    | |  |  __|  \___ \   | |  \___ \
%    | |  | |____ ____) |  | |  ____) |
%    |_|  |______|_____/   |_| |_____/
%
%
%
% See: https://patorjk.com/software/taag/#p=display&f=Big&t=TESTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Figures start with 2

close all;
fprintf(1,'Figure: 2XXXXXX: TEST mode cases\n');

%% TEST case: This one returns nothing since there is no portion of the path in criteria
% figNum = 20001;
% titleString = sprintf('TEST case: This one returns nothing since there is no portion of the path in criteria');
% fprintf(1,'Figure %.0f: %s\n',figNum, titleString);
% figure(figNum); clf;



%% Fast Mode Tests
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  ______        _     __  __           _        _______        _
% |  ____|      | |   |  \/  |         | |      |__   __|      | |
% | |__ __ _ ___| |_  | \  / | ___   __| | ___     | | ___  ___| |_ ___
% |  __/ _` / __| __| | |\/| |/ _ \ / _` |/ _ \    | |/ _ \/ __| __/ __|
% | | | (_| \__ \ |_  | |  | | (_) | (_| |  __/    | |  __/\__ \ |_\__ \
% |_|  \__,_|___/\__| |_|  |_|\___/ \__,_|\___|    |_|\___||___/\__|___/
%
%
% See: http://patorjk.com/software/taag/#p=display&f=Big&t=Fast%20Mode%20Tests
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Figures start with 8

close all;
fprintf(1,'Figure: 8XXXXXX: FAST mode cases\n');

%% Basic example - NO FIGURE
figNum = 80001;
fprintf(1,'Figure: %.0f: FAST mode, empty figNum\n',figNum);
figure(figNum); close(figNum);

% Fill in inputs
fileNameString = fullfile(pwd,'Data','testfile_fileTouch.txt');

% Delete the file, if it exists
if exist(fileNameString,'file')
    delete(fileNameString);
end

% Call function
[flagSuccessful,cmdout] = fcn_DebugTools_fileTouch(fileNameString, ([]));

% sgtitle(titleString, 'Interpreter','none');

% Check variable types
assert(islogical(flagSuccessful));
assert(ischar(cmdout));

% Check variable sizes
assert(size(flagSuccessful,1)==1);
assert(size(flagSuccessful,1)==1);
assert(size(cmdout,1)>=0);
assert(size(cmdout,2)>=0);

% Check variable values
assert(flagSuccessful);
assert(isempty(cmdout));
assert(exist(fileNameString,'file'))

% Make sure plot did NOT open up
figHandles = get(groot, 'Children');
assert(~any(figHandles==figNum));

% Delete the file, if it exists
if exist(fileNameString,'file')
    delete(fileNameString);
end


%% Basic fast mode - NO FIGURE, FAST MODE
figNum = 80002;
fprintf(1,'Figure: %.0f: FAST mode, figNum=-1\n',figNum);
figure(figNum); close(figNum);

% Fill in inputs
fileNameString = fullfile(pwd,'Data','testfile_fileTouch.txt');

% Delete the file, if it exists
if exist(fileNameString,'file')
    delete(fileNameString);
end

% Call function
[flagSuccessful,cmdout] = fcn_DebugTools_fileTouch(fileNameString, (-1));

% sgtitle(titleString, 'Interpreter','none');

% Check variable types
assert(islogical(flagSuccessful));
assert(ischar(cmdout));

% Check variable sizes
assert(size(flagSuccessful,1)==1);
assert(size(flagSuccessful,1)==1);
assert(size(cmdout,1)>=0);
assert(size(cmdout,2)>=0);

% Check variable values
assert(flagSuccessful);
assert(isempty(cmdout));
assert(exist(fileNameString,'file'))

% Make sure plot did NOT open up
figHandles = get(groot, 'Children');
assert(~any(figHandles==figNum));

% Delete the file, if it exists
if exist(fileNameString,'file')
    delete(fileNameString);
end


%% Compare speeds of pre-calculation versus post-calculation versus a fast variant
figNum = 80003;
fprintf(1,'Figure: %.0f: FAST mode comparisons\n',figNum);
figure(figNum);
close(figNum);

% Fill in inputs
fileNameString = fullfile(pwd,'Data','testfile_fileTouch.txt');
fid = [];

% Delete the file, if it exists
if exist(fileNameString,'file')
    delete(fileNameString);
end

% Create the file
[flagSuccessful,cmdout] = fcn_DebugTools_fileTouch(fileNameString, (-1));
assert(flagSuccessful);

Niterations = 10;

% Do calculation without pre-calculation
tic;
for ith_test = 1:Niterations
    % Call the function
    [flagSuccessful,cmdout] = fcn_DebugTools_fileTouch(fileNameString, ([]));

end
slow_method = toc;

% Do calculation with pre-calculation, FAST_MODE on
tic;
for ith_test = 1:Niterations
    % Call the function
    [flagSuccessful,cmdout] = fcn_DebugTools_fileTouch(fileNameString, (-1));


end
fast_method = toc;

% Delete the file, if it exists
if exist(fileNameString,'file')
    delete(fileNameString);
end


% Make sure plot did NOT open up
figHandles = get(groot, 'Children');
assert(~any(figHandles==figNum));

% Plot results as bar chart
figure(373737);
clf;
hold on;

X = categorical({'Normal mode','Fast mode'});
X = reordercats(X,{'Normal mode','Fast mode'}); % Forces bars to appear in this exact order, not alphabetized
Y = [slow_method fast_method ]*1000/Niterations;
bar(X,Y)
ylabel('Execution time (Milliseconds)')


% Make sure plot did NOT open up
figHandles = get(groot, 'Children');
assert(~any(figHandles==figNum));


%% BUG cases
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  ____  _    _  _____
% |  _ \| |  | |/ ____|
% | |_) | |  | | |  __    ___ __ _ ___  ___  ___
% |  _ <| |  | | | |_ |  / __/ _` / __|/ _ \/ __|
% | |_) | |__| | |__| | | (_| (_| \__ \  __/\__ \
% |____/ \____/ \_____|  \___\__,_|___/\___||___/
%
% See: http://patorjk.com/software/taag/#p=display&v=0&f=Big&t=BUG%20cases
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% All bug case figures start with the number 9

% close all;

%% BUG 

%% Fail conditions
if 1==0
    
end


%% Functions follow
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   ______                _   _
%  |  ____|              | | (_)
%  | |__ _   _ _ __   ___| |_ _  ___  _ __  ___
%  |  __| | | | '_ \ / __| __| |/ _ \| '_ \/ __|
%  | |  | |_| | | | | (__| |_| | (_) | | | \__ \
%  |_|   \__,_|_| |_|\___|\__|_|\___/|_| |_|___/
%
% See: https://patorjk.com/software/taag/#p=display&f=Big&t=Functions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%§

% 
% 
% %% fcn_INTERNAL_loadExampleData
% function tempXYdata = fcn_INTERNAL_loadExampleData(dataSetNumber)
% % Call the function to fill in an array of "path" type
% laps_array = fcn_Laps_fillSampleLaps(-1);
% 
% 
% % Use the last data
% tempXYdata = laps_array{dataSetNumber};
% end % Ends fcn_INTERNAL_loadExampleData
