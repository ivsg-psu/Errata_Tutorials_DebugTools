% script_test_fcn_DebugTools_findLatestGitHubRelease
% Tests: fcn_DebugTools_findLatestGitHubRelease


% Revision history
% As: script_test_fcn_DebugTools_findLatestGitHubRelease
% 2025_11_07 - S. Brennan
% -- first write of script, using
% script_test_fcn_VGraph_addObstacle as a starter
% 2025_11_11 - S. Brennan
% -- added fastmode testing

% TO DO:
% -- set up fast mode tests

%% Set up the workspace
close all

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

%% DEMO case: show an example query (verbose)
figNum = 10001;
titleString = sprintf('DEMO case: show an example query (verbose)');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);
figure(figNum); clf;

owner = 'ivsg-psu';
repo = 'FieldDataCollection_VisualizingFieldData_PlotRoad';
latestRelease = fcn_DebugTools_findLatestGitHubRelease(owner, repo, (figNum));

sgtitle(titleString, 'Interpreter','none');

% Check variable types
assert(isstruct(latestRelease));

% Check variable sizes
assert(size(latestRelease,1)==1); 
assert(size(latestRelease,2)==1); 

% Make sure plot opened up
assert(isequal(get(gcf,'Number'),figNum));


%% DEMO case: show an example query (not verbose)
figNum = 10002;
titleString = sprintf('DEMO case: show an example query (not verbose)');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);
figure(figNum); clf;

owner = 'ivsg-psu';
repo = 'FieldDataCollection_VisualizingFieldData_PlotRoad';
latestRelease = fcn_DebugTools_findLatestGitHubRelease(owner, repo, ([]));

sgtitle(titleString, 'Interpreter','none');

% Check variable types
assert(isstruct(latestRelease));

% Check variable sizes
assert(size(latestRelease,1)==1); 
assert(size(latestRelease,2)==1); 

% Make sure plot opened up
assert(isequal(get(gcf,'Number'),figNum));

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

% %% TEST case: zero gap between polytopes
% figNum = 20001;
% titleString = sprintf('TEST case: zero gap between polytopes');
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

owner = 'ivsg-psu';
repo = 'FieldDataCollection_VisualizingFieldData_PlotRoad';
latestRelease = fcn_DebugTools_findLatestGitHubRelease(owner, repo, ([]));

% Check variable types
assert(isstruct(latestRelease));

% Check variable sizes
assert(size(latestRelease,1)==1); 
assert(size(latestRelease,2)==1); 

% Make sure plot did NOT open up
figHandles = get(groot, 'Children');
assert(~any(figHandles==figNum));


%% Basic fast mode - NO FIGURE, FAST MODE
figNum = 80002;
fprintf(1,'Figure: %.0f: FAST mode, figNum=-1\n',figNum);
figure(figNum); close(figNum);


owner = 'ivsg-psu';
repo = 'FieldDataCollection_VisualizingFieldData_PlotRoad';
latestRelease = fcn_DebugTools_findLatestGitHubRelease(owner, repo, (-1));

% Check variable types
assert(isstruct(latestRelease));

% Check variable sizes
assert(size(latestRelease,1)==1); 
assert(size(latestRelease,2)==1); 

% Make sure plot did NOT open up
figHandles = get(groot, 'Children');
assert(~any(figHandles==figNum));


%% Compare speeds of pre-calculation versus post-calculation versus a fast variant
figNum = 80003;
fprintf(1,'Figure: %.0f: FAST mode comparisons\n',figNum);
figure(figNum);
close(figNum);

owner = 'ivsg-psu';
repo = 'FieldDataCollection_VisualizingFieldData_PlotRoad';

Niterations = 10;

% Do calculation without pre-calculation
tic;
for ith_test = 1:Niterations
    latestRelease = fcn_DebugTools_findLatestGitHubRelease(owner, repo, ([]));
end
slow_method = toc;

% Do calculation with pre-calculation, FAST_MODE on
tic;
for ith_test = 1:Niterations
    latestRelease = fcn_DebugTools_findLatestGitHubRelease(owner, repo, (-1));
end
fast_method = toc;

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