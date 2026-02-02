% script_test_fcn_DebugTools_wrapLongText.m
% tests fcn_DebugTools_wrapLongText.m

% REVISION HISTORY:
%
% 2026_01_18 by Sean Brennan, sbrennan@psu.edu
% - wrote the code originally, using breakDataIntoLaps as starter
%
% 2026_02_01 by Sean Brennan, sbrennan@psu.edu
% - In script_test_fcn_DebugTools_wrapLongText
%   % * Fixed wrong capitalization in function name

% TO-DO:
%
% 2026_01_18 by Sean Brennan, sbrennan@psu.edu
% - (fill in items here)


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

%% DEMO case: basic test call with one wrap
figNum = 10001;
titleString = sprintf('DEMO case: basic test call with one wrap');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);
% figure(figNum); clf;

% Load some test data 
originalText = 'This is a very long string that needs to be broken into something much, much smaller so that it is more readable';
wrapLength = 40;

% Call the function
wrappedText = fcn_DebugTools_wrapLongText(originalText, wrapLength, (figNum));

% sgtitle(titleString, 'Interpreter','none');

% Check variable types
assert(ischar(wrappedText));

% Check variable sizes
assert(size(wrappedText,1)==1); 
assert(size(wrappedText,2)>=size(originalText,2)); 

% Check variable values
assert(contains(wrappedText,'\n'));

% Make sure plot opened up
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

% %% TEST case: This one returns nothing since there is no portion of the path in criteria
% figNum = 20001;
% titleString = sprintf('TEST case: This one returns nothing since there is no portion of the path in criteria');
% fprintf(1,'Figure %.0f: %s\n',figNum, titleString);
% figure(figNum); clf;
% 


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

% Load some test data 
originalText = 'This is a very long string that needs to be broken into something much, much smaller so that it is more readable';
wrapLength = 40;

% Call the function
wrappedText = fcn_DebugTools_wrapLongText(originalText, wrapLength, ([]));

% sgtitle(titleString, 'Interpreter','none');

% Check variable types
assert(ischar(wrappedText));

% Check variable sizes
assert(size(wrappedText,1)==1); 
assert(size(wrappedText,2)>=size(originalText,2)); 

% Check variable values
assert(contains(wrappedText,'\n'));

% Make sure plot did NOT open up
figHandles = get(groot, 'Children');
assert(~any(figHandles==figNum));


%% Basic fast mode - NO FIGURE, FAST MODE
figNum = 80002;
fprintf(1,'Figure: %.0f: FAST mode, figNum=-1\n',figNum);
figure(figNum); close(figNum);

% Load some test data 
originalText = 'This is a very long string that needs to be broken into something much, much smaller so that it is more readable';
wrapLength = 40;

% Call the function
wrappedText = fcn_DebugTools_wrapLongText(originalText, wrapLength, (-1));

% sgtitle(titleString, 'Interpreter','none');

% Check variable types
assert(ischar(wrappedText));

% Check variable sizes
assert(size(wrappedText,1)==1); 
assert(size(wrappedText,2)>=size(originalText,2)); 

% Check variable values
assert(contains(wrappedText,'\n'));


% Make sure plot did NOT open up
figHandles = get(groot, 'Children');
assert(~any(figHandles==figNum));


%% Compare speeds of pre-calculation versus post-calculation versus a fast variant
figNum = 80003;
fprintf(1,'Figure: %.0f: FAST mode comparisons\n',figNum);
figure(figNum);
close(figNum);

% Load some test data 
originalText = 'This is a very long string that needs to be broken into something much, much smaller so that it is more readable';
wrapLength = 40;

Niterations = 50;

% Do calculation without pre-calculation
tic;
for ith_test = 1:Niterations
    % Call the function
    wrappedText = fcn_DebugTools_wrapLongText(originalText, wrapLength, ([]));
end
slow_method = toc;

% Do calculation with pre-calculation, FAST_MODE on
tic;
for ith_test = 1:Niterations
    % Call the function
    wrappedText = fcn_DebugTools_wrapLongText(originalText, wrapLength, (-1));
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
    %
        %% Fails because start_definition is not correct type
        start_definition = [1 2];
        [lap_traversals, input_and_exit_traversals] = fcn_DebugTools_wrapLongText(...
            single_lap.traversal{1},...
            start_definition); %#ok<*ASGLU>

        %% Fails because start_definition is not correct type
        % Radius input is negative
        start_definition = [-1 2 3 4];
        [lap_traversals, input_and_exit_traversals] = fcn_DebugTools_wrapLongText(...
            single_lap.traversal{1},...
            start_definition);

        %% Fails because start_definition is not correct type
        % Radius input is negative
        start_definition = [0 2 3 4];
        [lap_traversals, input_and_exit_traversals] = fcn_DebugTools_wrapLongText(...
            single_lap.traversal{1},...
            start_definition);

        %% Fails because start_definition is not correct type
        % Num_inputs input is not positive
        start_definition = [1 0 3 4];
        [lap_traversals, input_and_exit_traversals] = fcn_DebugTools_wrapLongText(...
            single_lap.traversal{1},...
            start_definition);

        %% Warning because start_definition is 3D not 2D
        % Start_zone definition is a 3D point [radius num_points X Y Z]
        start_definition = [1 2 3 4 5];
        [lap_traversals, input_and_exit_traversals] = fcn_DebugTools_wrapLongText(...
            single_lap.traversal{1},...
            start_definition);

        %% Warning because start_definition is 3D not 2D
        % Start_zone definition is a 3D point [X Y Z; X Y Z]
        start_definition = [1 2 3; 4 5 6];
        [lap_traversals, input_and_exit_traversals] = fcn_DebugTools_wrapLongText(...
            single_lap.traversal{1},...
            start_definition);

        %% Warning because end_definition is 3D not 2D
        % End_zone definition is a 3D point [radius num_points X Y Z]
        start_definition = [1 2 3 4];
        end_definition = [1 2 3 4 5];

        [lap_traversals, input_and_exit_traversals] = fcn_DebugTools_wrapLongText(...
            single_lap.traversal{1},...
            start_definition,...
            end_definition);

        %% Warning because excursion_definition is 3D not 2D
        % Excursion_zone definition is a 3D point [radius num_points X Y Z]
        start_definition = [1 2 3 4];
        end_definition = [1 2 3 4];
        excursion_definition = [1 2 3 4 5];

        [lap_traversals, input_and_exit_traversals] = fcn_DebugTools_wrapLongText(...
            single_lap.traversal{1},...
            start_definition,...
            end_definition,...
            excursion_definition);
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

% function INTERNAL_plot_results(tempXYdata,cell_array_of_entry_indices,cell_array_of_lap_indices,cell_array_of_exit_indices,figNum)
% figure(figNum);
% clf
% 
% % Make first subplot
% subplot(1,3,1);  
% axis square
% hold on;
% title('Laps');
% legend_text = {};
% 
% for ith_lap = 1:length(cell_array_of_lap_indices)
%     plot(tempXYdata(cell_array_of_lap_indices{ith_lap},1),tempXYdata(cell_array_of_lap_indices{ith_lap},2),'.-','Linewidth',3);
%     legend_text = [legend_text, sprintf('Lap %d',ith_lap)]; %#ok<AGROW>    
% end
% h_legend = legend(legend_text);
% set(h_legend,'AutoUpdate','off');
% temp1 = axis;
% 
% % Make second subplot
% subplot(1,3,2);  
% axis square
% hold on;
% title('Entry');
% legend_text = {};
% 
% for ith_lap = 1:length(cell_array_of_entry_indices)
%     plot(tempXYdata(cell_array_of_entry_indices{ith_lap},1),tempXYdata(cell_array_of_entry_indices{ith_lap},2),'.-','Linewidth',3);
%     legend_text = [legend_text, sprintf('Lap %d',ith_lap)]; %#ok<AGROW>    
% end
% h_legend = legend(legend_text);
% set(h_legend,'AutoUpdate','off');
% temp2 = axis;
% 
% % Make third subplot
% subplot(1,3,3);  
% axis square
% hold on;
% title('Exit');
% legend_text = {};
% 
% for ith_lap = 1:length(cell_array_of_exit_indices)
%     plot(tempXYdata(cell_array_of_exit_indices{ith_lap},1),tempXYdata(cell_array_of_exit_indices{ith_lap},2),'.-','Linewidth',3);
%     legend_text = [legend_text, sprintf('Lap %d',ith_lap)]; %#ok<AGROW>    
% end
% h_legend = legend(legend_text);
% set(h_legend,'AutoUpdate','off');
% temp3 = axis;
% 
% % Set all axes to same value, maximum range
% max_axis = max([temp1; temp2; temp3]);
% min_axis = min([temp1; temp2; temp3]);
% good_axis = [min_axis(1) max_axis(2) min_axis(3) max_axis(4)];
% subplot(1,3,1); axis(good_axis);
% subplot(1,3,2); axis(good_axis);
% subplot(1,3,3); axis(good_axis);
% 
% 
% end
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
