% script_test_fcn_DebugTools_isThisComputerOnline
% Tests fcn_DebugTools_isThisComputerOnline
% Written in 2026_10_07 by S.Brennan


% REVISION HISTORY:
% 
% 2026_10_07 by Sean Brennan, sbrennan@psu.edu
% - In script_test_fcn_DebugTools_isThisComputerOnline
%   * Wrote the code originally
%   * Used script_test_fcn_DebugTools_is+OnlineFromThisComputerAndUser as starter
 

% TO-DO:
% 2026_10_07 by Sean Brennan, sbrennan@psu.edu
% - Add to-do items here

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

%% DEMO case: basic call
figNum = 10001;
titleString = sprintf('DEMO case: basic call');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);
figure(figNum); close(figNum);

% Set the input arguments
url = [];
timeout = [];

% Call the function
[isOnline] = fcn_DebugTools_isThisComputerOnline((url), (timeout), (figNum));

sgtitle(titleString, 'Interpreter','none');

% Check variable types
assert(islogical(isOnline));

% Check variable sizes
assert(size(seed,1)==1); 
assert(size(seed,2)==1); 

% Check variable values
assert(isOnline==true);  

% Make sure plot did NOT open up
figHandles = get(groot, 'Children');
assert(~any(figHandles==figNum));


%% DEMO case: specifying good URL
figNum = 10002;
titleString = sprintf('DEMO case: specifying good URL');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);
figure(figNum); close(figNum);

% Set the input arguments
url = 'cnn.com';
timeout = [];

% Call the function
[isOnline] = fcn_DebugTools_isThisComputerOnline((url), (timeout), (figNum));

sgtitle(titleString, 'Interpreter','none');

% Check variable types
assert(islogical(isOnline));

% Check variable sizes
assert(size(seed,1)==1); 
assert(size(seed,2)==1); 

% Check variable values
assert(isOnline==true);  

% Make sure plot did NOT open up
figHandles = get(groot, 'Children');
assert(~any(figHandles==figNum));


%% DEMO case: specifying bad URL
figNum = 10003;
titleString = sprintf('DEMO case: specifying bad URL');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);
figure(figNum); close(figNum);

% Set the input arguments
url = 'a;ldkjfadskljf.com';
timeout = [];

% Call the function
[isOnline] = fcn_DebugTools_isThisComputerOnline((url), (timeout), (figNum));

sgtitle(titleString, 'Interpreter','none');

% Check variable types
assert(islogical(isOnline));

% Check variable sizes
assert(size(seed,1)==1); 
assert(size(seed,2)==1); 

% Check variable values
assert(isOnline==false);  

% Make sure plot did NOT open up
figHandles = get(groot, 'Children');
assert(~any(figHandles==figNum));


%% DEMO case: specifying good URL with long timeout
figNum = 10004;
titleString = sprintf('DEMO case: specifying good URL with long timeout');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);
figure(figNum); close(figNum);

% Set the input arguments
url = 'cnn.com';
timeout = 10000;

% Call the function
[isOnline] = fcn_DebugTools_isThisComputerOnline((url), (timeout), (figNum));

sgtitle(titleString, 'Interpreter','none');

% Check variable types
assert(islogical(isOnline));

% Check variable sizes
assert(size(seed,1)==1); 
assert(size(seed,2)==1); 

% Check variable values
assert(isOnline==true);  

% Make sure plot did NOT open up
figHandles = get(groot, 'Children');
assert(~any(figHandles==figNum));



%% DEMO case: specifying bad URL with long timeout
figNum = 10004;
titleString = sprintf('DEMO case: specifying bad URL with long timeout');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);
figure(figNum); close(figNum);

% Set the input arguments
url = 'afhfhfhfhfkdkdjfkjfjkdjfkj.com';
timeout = 5000;

% Call the function
[isOnline] = fcn_DebugTools_isThisComputerOnline((url), (timeout), (figNum));

sgtitle(titleString, 'Interpreter','none');

% Check variable types
assert(islogical(isOnline));

% Check variable sizes
assert(size(seed,1)==1); 
assert(size(seed,2)==1); 

% Check variable values
assert(isOnline==false);  

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

% Set the input arguments
url = [];
timeout = [];

% Call the function
[isOnline] = fcn_DebugTools_isThisComputerOnline((url), (timeout), ([]));

sgtitle(titleString, 'Interpreter','none');

% Check variable types
assert(islogical(isOnline));

% Check variable sizes
assert(size(seed,1)==1); 
assert(size(seed,2)==1); 

% Check variable values
assert(isOnline==true);  

% Make sure plot did NOT open up
figHandles = get(groot, 'Children');
assert(~any(figHandles==figNum));


%% Basic fast mode - NO FIGURE, FAST MODE
figNum = 80002;
fprintf(1,'Figure: %.0f: FAST mode, figNum=-1\n',figNum);
figure(figNum); close(figNum);

% Set the input arguments
url = [];
timeout = [];

% Call the function
[isOnline] = fcn_DebugTools_isThisComputerOnline((url), (timeout), (-1));

sgtitle(titleString, 'Interpreter','none');

% Check variable types
assert(islogical(isOnline));

% Check variable sizes
assert(size(seed,1)==1); 
assert(size(seed,2)==1); 

% Check variable values
assert(isOnline==true);  

% Make sure plot did NOT open up
figHandles = get(groot, 'Children');
assert(~any(figHandles==figNum));


%% Compare speeds of pre-calculation versus post-calculation versus a fast variant
figNum = 80003;
fprintf(1,'Figure: %.0f: FAST mode comparisons\n',figNum);
figure(figNum);
close(figNum);

% Set the input arguments
url = [];
timeout = [];

Niterations = 10;

% Do calculation without pre-calculation
tic;
for ith_test = 1:Niterations
	% Call the function
	[isOnline] = fcn_DebugTools_isThisComputerOnline((url), (timeout), ([]));
end
slow_method = toc;

% Do calculation with pre-calculation, FAST_MODE on
tic;
for ith_test = 1:Niterations
	% Call the function
	[isOnline] = fcn_DebugTools_isThisComputerOnline((url), (timeout), (-1));
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
