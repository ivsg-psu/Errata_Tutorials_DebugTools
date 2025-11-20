%% script_test_fcn_DebugTools_breakArrayByNans
% Tests fcn_DebugTools_breakArrayByNans

% REVISION HISTORY:
% 
% As: script_test_fcn_PlotRoad_breakArrayByNans
% 
% 2023_07_14 - S. Brennan
% - first write of the code
% 
% 2025_11_01 - Aneesh Batchu
% - Updated the script to the latest format
%
% As: script_test_fcn_DebugTools_breakArrayByNans
% 
% 2025_11_04 - S. Brennan, sbrennan@psu.edu
% - added function to DebugTools library
% - added better assertion tests
%
% 2025_11_20 by Sean Brennan, sbrennan@psu.edu
% - Formatted revision lists to Markdown format
% - cleaned up variable naming:
%   % * fig_+num to figNum

% TO-DO:
% 2025_11_20 by Sean Brennan, sbrennan@psu.edu
% - fill in to-do items here.

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
% DEMO figures start with 1

close all;
fprintf(1,'Figure: 1XXXX: DEMO cases\n');


%% DEMO case: Input array with no Nans

figNum = 10001; 
titleString = sprintf('DEMO case: Basic test case - no Nans');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);
figure(figNum); close(figNum);

test_data = rand(10,2);
indicies_cell_array = fcn_DebugTools_breakArrayByNans(test_data, (figNum));

% Check variable types
assert(iscell(indicies_cell_array))

% Check variable sizes
assert(size(indicies_cell_array,1)==1);
assert(size(indicies_cell_array,2)==1);

% Check variable values
assert(isequal(indicies_cell_array{1},(1:10)'));


%% DEMO case: Input array with all Nans

figNum = 10002; 
titleString = sprintf('DEMO case: Input array with all Nans');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);
figure(figNum); close(figNum);

test_data = nan(10,2);
indicies_cell_array = fcn_DebugTools_breakArrayByNans(test_data, (figNum));

% Check variable types
assert(iscell(indicies_cell_array))

% Check variable sizes
assert(size(indicies_cell_array,1)==1);
assert(size(indicies_cell_array,2)==1);

% Check variable values
assert(isequal(indicies_cell_array{1},[]));

%% DEMO case: Input array with all but 1 value is Nan

figNum = 10003; 
titleString = sprintf('DEMO case: Input array with all but 1 value is Nan');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);
figure(figNum); close(figNum);

test_data = [nan(10,1); 2; nan(4,1)];
indicies_cell_array = fcn_DebugTools_breakArrayByNans(test_data, (figNum));

% Check variable types
assert(iscell(indicies_cell_array))

% Check variable sizes
assert(size(indicies_cell_array,1)==1);
assert(size(indicies_cell_array,2)==1);

% Check variable values
assert(isequal(indicies_cell_array{1},11));

%% DEMO case: Input array with one nan inside

figNum = 10004; 
titleString = sprintf('DEMO case: Input array with one nan inside');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);
figure(figNum); close(figNum);

test_data = [2; 3; 4; nan; 6; 7];
indicies_cell_array = fcn_DebugTools_breakArrayByNans(test_data, (figNum));

% Check variable types
assert(iscell(indicies_cell_array))

% Check variable sizes
assert(size(indicies_cell_array,1)==1);
assert(size(indicies_cell_array,2)==2);

% Check variable values
assert(isequal(indicies_cell_array{1},[1; 2; 3]));
assert(isequal(indicies_cell_array{2},[5; 6]));

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
% TEST figures start with 2

close all;
fprintf(1,'Figure: 2XXXXXX: TEST mode cases\n');

%% Test case: Input array with one nan sequence inside

figNum = 20001;
titleString = sprintf('Test case: Input array with one nan sequence inside');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);
figure(figNum); close(figNum);

test_data = [2; 3; 4; nan; nan; nan; 6; 7];
indicies_cell_array = fcn_DebugTools_breakArrayByNans(test_data, (figNum));

% Check variable types
assert(iscell(indicies_cell_array))

% Check variable sizes
assert(size(indicies_cell_array,1)==1);
assert(size(indicies_cell_array,2)==2);

% Check variable values
assert(isequal(indicies_cell_array{1},[1; 2; 3]));
assert(isequal(indicies_cell_array{2},[7; 8]));

%% Test case: one nan sequence inside, with one nan at end

figNum = 20002;
titleString = sprintf('Test case: one nan sequence inside, with one nan at end');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);
figure(figNum); close(figNum);

test_data = [2; 3; 4; nan; nan; nan; 6; 7; nan];
indicies_cell_array = fcn_DebugTools_breakArrayByNans(test_data, (figNum));

% Check variable types
assert(iscell(indicies_cell_array))

% Check variable sizes
assert(size(indicies_cell_array,1)==1);
assert(size(indicies_cell_array,2)==2);

% Check variable values
assert(isequal(indicies_cell_array{1},[1; 2; 3]));
assert(isequal(indicies_cell_array{2},[7; 8]));

%% Test case: one nan sequence inside, with many nan at end

figNum = 20003;
titleString = sprintf('Test case: one nan sequence inside, with many nan at end');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);
figure(figNum); close(figNum);

test_data = [2; 3; 4; nan; nan; nan; 6; 7; nan(3,1)];
indicies_cell_array = fcn_DebugTools_breakArrayByNans(test_data, (figNum));

% Check variable types
assert(iscell(indicies_cell_array))

% Check variable sizes
assert(size(indicies_cell_array,1)==1);
assert(size(indicies_cell_array,2)==2);

% Check variable values
assert(isequal(indicies_cell_array{1},[1; 2; 3]));
assert(isequal(indicies_cell_array{2},[7; 8]));

%% Test case - many nan sequences inside, with many nan at end

figNum = 20004;
titleString = sprintf('Test case: Input array with one nan sequence inside');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);
figure(figNum); close(figNum);

test_data = [1; 2; 3; 4; nan; 6; nan; 8; 9; nan(3,1)];
indicies_cell_array = fcn_DebugTools_breakArrayByNans(test_data, (figNum));

% Check variable types
assert(iscell(indicies_cell_array))

% Check variable sizes
assert(size(indicies_cell_array,1)==1);
assert(size(indicies_cell_array,2)==3);

% Check variable values
assert(isequal(indicies_cell_array{1},[1; 2; 3; 4]));
assert(isequal(indicies_cell_array{2},6));
assert(isequal(indicies_cell_array{3},[8; 9]));

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
% FAST Mode figures start with 8

close all;
fprintf(1,'Figure: 8XXXXXX: TEST mode cases\n');

%% Basic example - NO FIGURE

figNum = 80001;
fprintf(1,'Figure: %.0f: FAST mode, empty figNum\n',figNum);
figure(figNum); close(figNum);

test_data = rand(10,2);
indicies_cell_array = fcn_DebugTools_breakArrayByNans(test_data, ([]));

% Check variable types
assert(iscell(indicies_cell_array))

% Check variable sizes
assert(size(indicies_cell_array,1)==1);
assert(size(indicies_cell_array,2)==1);

% Check variable values
assert(isequal(indicies_cell_array{1},(1:10)'));

% Make sure plot did NOT open up
figHandles = get(groot, 'Children');
assert(~any(figHandles==figNum));


%% Basic example - NO FIGURE

figNum = 80002;
fprintf(1,'Figure: %.0f: FAST mode, figNum=-1\n',figNum);
figure(figNum); close(figNum);

test_data = rand(10,2);
indicies_cell_array = fcn_DebugTools_breakArrayByNans(test_data, (-1));

% Check variable types
assert(iscell(indicies_cell_array))

% Check variable sizes
assert(size(indicies_cell_array,1)==1);
assert(size(indicies_cell_array,2)==1);

% Check variable values
assert(isequal(indicies_cell_array{1},(1:10)'));

% Make sure plot did NOT open up
figHandles = get(groot, 'Children');
assert(~any(figHandles==figNum));

%% Compare speeds of pre-calculation versus post-calculation versus a fast variant

figNum = 80003;
fprintf(1,'Figure: %.0f: FAST mode comparisons\n',figNum);
figure(figNum); close(figNum);

test_data = rand(10,2);

Niterations = 100;

% Do calculation without pre-calculation
tic;
for ith_test = 1:Niterations

   indicies_cell_array = fcn_DebugTools_breakArrayByNans(test_data, ([]));

end
slow_method = toc;

% Do calculation with pre-calculation, FAST_MODE on
tic;

for ith_test = 1:Niterations

    indicies_cell_array = fcn_DebugTools_breakArrayByNans(test_data, (-1));

end
fast_method = toc;

% Assertions
assert(isequal(indicies_cell_array{1},(1:10)'));

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
% fprintf(1,'Figure: 9XXXXXX: TEST mode cases\n');

%% BUG

%% Fail conditions
if 1==0

    %% Should throw error because plotData does not have 3 column of numbers

    figNum = 90001;
    fprintf(1,'Figure: %.0f:Bug case\n',figNum);
    figure(figNum); close(figNum);

    test_data = 2;
    indicies_cell_array = fcn_DebugTools_breakArrayByNans(test_data, figNum);

    % Make sure plot did NOT open up
    figHandles = get(groot, 'Children');
    assert(~any(figHandles==figNum));

end



% %% testing speed of function
% 
% test_data = [2; 3; 4; nan; nan; nan; 6; 7];
% 
% REPS=5; minTimeSlow=Inf;
% % Slow mode calculation - code copied from plotVehicleXYZ
% tic;
% for i=1:REPS
%     tstart=tic;
%     indicies_cell_array = fcn_DebugTools_breakArrayByNans(test_data);
%     telapsed=toc(tstart);
%     minTimeSlow=min(telapsed,minTimeSlow);
% end
% averageTimeSlow=toc/REPS;
% % Slow mode END
% 
% % Fast Mode Calculation
% minTimeFast = Inf;
% tic;
% for i=1:REPS
%     tstart = tic;
%     indicies_cell_array = fcn_DebugTools_breakArrayByNans(test_data);
%     telapsed = toc(tstart);
%     minTimeFast = min(telapsed,minTimeFast);
% end
% averageTimeFast = toc/REPS;
% 
% % Display Console Comparison
% if 1==1
%     fprintf(1,'\n\nComparison of fcn_DebugTools_breakArrayByNans without speed setting (slow) and with speed setting (fast):\n');
%     fprintf(1,'N repetitions: %.0d\n',REPS);
%     fprintf(1,'Slow mode average speed per call (seconds): %.5f\n',averageTimeSlow);
%     fprintf(1,'Slow mode fastest speed over all calls (seconds): %.5f\n',minTimeSlow);
%     fprintf(1,'Fast mode average speed per call (seconds): %.5f\n',averageTimeFast);
%     fprintf(1,'Fast mode fastest speed over all calls (seconds): %.5f\n',minTimeFast);
%     fprintf(1,'Average ratio of fast mode to slow mode (unitless): %.3f\n',averageTimeSlow/averageTimeFast);
% end
% 
% assert(averageTimeSlow*2>averageTimeFast);
