% script_test_fcn_DebugTools_testRepoForRelease.m
% Tests fcn_DebugTools_testRepoForRelease
% Written in 2026_01_22 by S.Brennan

% REVISION HISTORY:
% 
% 2026_01_22 by Sean Brennan, sbrennan@psu.edu
% - wrote the code originally using
%   % fcn_DebugTools_autoIn+stallRepos as a starter

% TO-DO:
% 
% 2026_01_22 by Sean Brennan, sbrennan@psu.edu
% - Add items here


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

%% DEMO case: basic test case 
figNum = 10001;
titleString = sprintf('DEMO case: basic test case');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);
% figure(figNum); clf;

% Set input arguments
repoShortName = '_DebugTools_';

% Call the function
fcn_DebugTools_testRepoForRelease(repoShortName, (figNum));

% sgtitle(titleString, 'Interpreter','none');

% % Check variable types
% assert(isnumeric(visibilityMatrix));
% assert(isstruct(visibilityDetailsEachFromPoint));
% 
% % Check variable sizes
% NpolyVertices = length([polytopes.xv]);
% assert(size(visibilityMatrix,1)==NpolyVertices+2);
% assert(size(visibilityMatrix,2)==NpolyVertices+2);
% assert(size(visibilityDetailsEachFromPoint,2)==NpolyVertices+2);
% 
% % Check variable values
% % Check manually
% 
% % Make sure plot opened up
% assert(isequal(get(gcf,'Number'),figNum));


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

% %% Basic example - NO FIGURE
% figNum = 80001;
% fprintf(1,'Figure: %.0f: FAST mode, empty figNum\n',figNum);
% figure(figNum); close(figNum);
% 
% % convex polytope
% convex_polytope(1).vertices = [0 0; 1 1; -1 2; -2 1; -1 0; 0 0];
% convex_polytope(2).vertices = [1.5 1.5; 2 0.5; 3 3; 1.5 2; 1.5 1.5];
% polytopes = fcn_MapGen_polytopesFillFieldsFromVertices(convex_polytope);
% 
% % generate pointsWithData table
% startXY = [-2.5, 1];
% finishXY = [4 1];
% 
% pointsWithData = fcn_VGraph_polytopesGenerateAllPtsTable(polytopes, startXY, finishXY,-1);
% 
% % Calculate visibility graph
% isConcave = [];
% [visibilityMatrix, visibilityDetailsEachFromPoint] = ...
%     fcn_VGraph_clearAndBlockedPointsGlobal(polytopes, pointsWithData, pointsWithData, (isConcave),([]));
% 
% % Check variable types
% assert(isnumeric(visibilityMatrix));
% assert(isstruct(visibilityDetailsEachFromPoint));
% 
% % Check variable sizes
% NpolyVertices = length([polytopes.xv]);
% assert(size(visibilityMatrix,1)==NpolyVertices+2);
% assert(size(visibilityMatrix,2)==NpolyVertices+2);
% assert(size(visibilityDetailsEachFromPoint,2)==NpolyVertices+2);
% 
% % Check variable values
% % Check this manually
% 
% % Make sure plot did NOT open up
% figHandles = get(groot, 'Children');
% assert(~any(figHandles==figNum));
% 
% 
% %% Basic fast mode - NO FIGURE, FAST MODE
% figNum = 80002;
% fprintf(1,'Figure: %.0f: FAST mode, figNum=-1\n',figNum);
% figure(figNum); close(figNum);
% 
% % convex polytope
% convex_polytope(1).vertices = [0 0; 1 1; -1 2; -2 1; -1 0; 0 0];
% convex_polytope(2).vertices = [1.5 1.5; 2 0.5; 3 3; 1.5 2; 1.5 1.5];
% polytopes = fcn_MapGen_polytopesFillFieldsFromVertices(convex_polytope);
% 
% % generate pointsWithData table
% startXY = [-2.5, 1];
% finishXY = [4 1];
% 
% pointsWithData = fcn_VGraph_polytopesGenerateAllPtsTable(polytopes, startXY, finishXY,-1);
% 
% % Calculate visibility graph
% isConcave = [];
% [visibilityMatrix, visibilityDetailsEachFromPoint] = ...
%     fcn_VGraph_clearAndBlockedPointsGlobal(polytopes, pointsWithData, pointsWithData, (isConcave),(-1));
% 
% % Check variable types
% assert(isnumeric(visibilityMatrix));
% assert(isstruct(visibilityDetailsEachFromPoint));
% 
% % Check variable sizes
% NpolyVertices = length([polytopes.xv]);
% assert(size(visibilityMatrix,1)==NpolyVertices+2);
% assert(size(visibilityMatrix,2)==NpolyVertices+2);
% assert(size(visibilityDetailsEachFromPoint,2)==NpolyVertices+2);
% 
% % Check variable values
% % Check this manually
% 
% % Make sure plot did NOT open up
% figHandles = get(groot, 'Children');
% assert(~any(figHandles==figNum));
% 
% 
% %% Compare speeds of pre-calculation versus post-calculation versus a fast variant
% figNum = 80003;
% fprintf(1,'Figure: %.0f: FAST mode comparisons\n',figNum);
% figure(figNum);
% close(figNum);
% 
% % convex polytope
% convex_polytope(1).vertices = [0 0; 1 1; -1 2; -2 1; -1 0; 0 0];
% convex_polytope(2).vertices = [1.5 1.5; 2 0.5; 3 3; 1.5 2; 1.5 1.5];
% polytopes = fcn_MapGen_polytopesFillFieldsFromVertices(convex_polytope);
% 
% % generate pointsWithData table
% startXY = [-2.5, 1];
% finishXY = [4 1];
% isConcave = [];
% 
% pointsWithData = fcn_VGraph_polytopesGenerateAllPtsTable(polytopes, startXY, finishXY,-1);
% 
% Niterations = 10;
% 
% % Do calculation without pre-calculation
% tic;
% for ith_test = 1:Niterations
%     % Call the function
%     [visibilityMatrix, visibilityDetailsEachFromPoint] = ...
%         fcn_VGraph_clearAndBlockedPointsGlobal(polytopes, pointsWithData, pointsWithData, (isConcave),([]));
% end
% slow_method = toc;
% 
% % Do calculation with pre-calculation, FAST_MODE on
% tic;
% for ith_test = 1:Niterations
%     % Call the function
%     [visibilityMatrix, visibilityDetailsEachFromPoint] = ...
%         fcn_VGraph_clearAndBlockedPointsGlobal(polytopes, pointsWithData, pointsWithData, (isConcave),(-1));
% end
% fast_method = toc;
% 
% % Make sure plot did NOT open up
% figHandles = get(groot, 'Children');
% assert(~any(figHandles==figNum));
% 
% % Plot results as bar chart
% figure(373737);
% clf;
% hold on;
% 
% X = categorical({'Normal mode','Fast mode'});
% X = reordercats(X,{'Normal mode','Fast mode'}); % Forces bars to appear in this exact order, not alphabetized
% Y = [slow_method fast_method ]*1000/Niterations;
% bar(X,Y)
% ylabel('Execution time (Milliseconds)')
% 
% 
% % Make sure plot did NOT open up
% figHandles = get(groot, 'Children');
% assert(~any(figHandles==figNum));


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

