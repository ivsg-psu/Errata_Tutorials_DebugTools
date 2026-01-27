% script_test_fcn_DebugTools_debugPrintStringToNCharacters.m
% This is a script to exercise the function: fcn_DebugTools_debugPrintStringToNCharacters
% This function was written on 2021_12_12 by S. Brennan
% Questions or comments? sbrennan@psu.edu


% REVISION HISTORY:
% 
% 2021_12_12 - S. Brennan
% - first write of the function
% 
% 2023_01_17 - S. Brennan
% - first write of the test script
%
% 2025_11_20 by Sean Brennan, sbrennan@psu.edu
% - Formatted revision lists to Markdown format
%
% 2025_12_17 by Sean Brennan, sbrennan@psu.edu
% - Changed figNum input to FID, to allow prints to files
% - Created many more test cases to demo new features


% TO-DO:
% 2025_11_20 by Sean Brennan, sbrennan@psu.edu
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

%% DEMO case: basic call with all columns of same fixed character width
figNum = 10001;
titleString = sprintf('DEMO case: basic call with all columns of same fixed character width');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);

% Fill in test data
Npoints = 10;
point_IDs = (1:Npoints)';
intersection_points = rand(Npoints,2);
s_coordinates_in_traversal_1 = rand(Npoints,1);
s_coordinates_in_traversal_2 = 1000*rand(Npoints,1);
table_data = [point_IDs, intersection_points, s_coordinates_in_traversal_1, s_coordinates_in_traversal_2];


header_strings = [{'Data ID'}, {'Location X'},{'Location Y'},{'s-coord 1'},{'s-coord 2'}];
formatter_strings = [{'%.0d'},{'%.12f'},{'%.12f'},{'%.12f'},{'%.12f'}];
numChars = 15; % All columns have same number of characters
fcn_DebugTools_debugPrintTableToNCharacters(table_data, header_strings, formatter_strings,numChars);


%% DEMO case: each column has different widths
figNum = 10002;
titleString = sprintf('DEMO case: each column has different widths');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);

% Fill in test data
Npoints = 10;
point_IDs = (1:Npoints)';
intersection_points = rand(Npoints,2);
s_coordinates_in_traversal_1 = rand(Npoints,1);
s_coordinates_in_traversal_2 = 1000*rand(Npoints,1);
table_data = [point_IDs, intersection_points, s_coordinates_in_traversal_1, s_coordinates_in_traversal_2];


header_strings = [{'Data ID'}, {'Location X'},{'Location Y'},{'s-coord 1'},{'s-coord 2'}]; % Headers for each column
formatter_strings = [{'%.0d'},{'%.12f'},{'%.12f'},{'%.12f'},{'%.12f'}]; % How should each column be printed?
numChars = [4, 15, 15, 5, 5]; % Specify spaces for each column
fcn_DebugTools_debugPrintTableToNCharacters(table_data, header_strings, formatter_strings,numChars);

%% DEMO case: no header will be printed, only the table
figNum = 10003;
titleString = sprintf('DEMO case: no header will be printed, only the table');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);

% Fill in test data
Npoints = 10;
point_IDs = (1:Npoints)';
intersection_points = rand(Npoints,2);
s_coordinates_in_traversal_1 = rand(Npoints,1);
s_coordinates_in_traversal_2 = 1000*rand(Npoints,1);
table_data = [point_IDs, intersection_points, s_coordinates_in_traversal_1, s_coordinates_in_traversal_2];


header_strings = []; % [{'Data ID'}, {'Location X'},{'Location Y'},{'s-coord 1'},{'s-coord 2'}]; % Headers for each column
formatter_strings = [{'%.0d'},{'%.12f'},{'%.12f'},{'%.12f'},{'%.12f'}]; % How should each column be printed?
numChars = [4, 15, 15, 5, 5]; % Specify spaces for each column
fcn_DebugTools_debugPrintTableToNCharacters(table_data, header_strings, formatter_strings,numChars);

%% DEMO case: no table will be printed, only the header
figNum = 10004;
titleString = sprintf('DEMO case: no table will be printed, only the header');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);

% Fill in test data
% Npoints = 10;
% point_IDs = (1:Npoints)';
% intersection_points = rand(Npoints,2);
% s_coordinates_in_traversal_1 = rand(Npoints,1);
% s_coordinates_in_traversal_2 = 1000*rand(Npoints,1);
table_data = []; % [point_IDs, intersection_points, s_coordinates_in_traversal_1, s_coordinates_in_traversal_2];


header_strings = [{'Data ID'}, {'Location X'},{'Location Y'},{'s-coord 1'},{'s-coord 2'}]; % Headers for each column
formatter_strings = [{'%.0d'},{'%.12f'},{'%.12f'},{'%.12f'},{'%.12f'}]; % How should each column be printed?
numChars = [4, 15, 15, 5, 5]; % Specify spaces for each column
fcn_DebugTools_debugPrintTableToNCharacters(table_data, header_strings, formatter_strings,numChars);

%% DEMO case: dumb case where neither table data nor header are printed
figNum = 10005;
titleString = sprintf('DEMO case: dumb case where neither table data nor header are printed');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);

% Fill in test data
% Npoints = 10;
% point_IDs = (1:Npoints)';
% intersection_points = rand(Npoints,2);
% s_coordinates_in_traversal_1 = rand(Npoints,1);
% s_coordinates_in_traversal_2 = 1000*rand(Npoints,1);
table_data = []; % [point_IDs, intersection_points, s_coordinates_in_traversal_1, s_coordinates_in_traversal_2];


header_strings = []; % [{'Data ID'}, {'Location X'},{'Location Y'},{'s-coord 1'},{'s-coord 2'}]; % Headers for each column
formatter_strings = [{'%.0d'},{'%.12f'},{'%.12f'},{'%.12f'},{'%.12f'}]; % How should each column be printed?
numChars = [4, 15, 15, 5, 5]; % Specify spaces for each column
fcn_DebugTools_debugPrintTableToNCharacters(table_data, header_strings, formatter_strings,numChars);

%% DEMO case: 2nd column is red, 3rd is bold blue
figNum = 10006;
titleString = sprintf('DEMO case: 2nd column is red, 3rd is bold blue');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);

% Fill in test data
Npoints = 10;
point_IDs = (1:Npoints)';
intersection_points = rand(Npoints,2);
s_coordinates_in_traversal_1 = rand(Npoints,1);
s_coordinates_in_traversal_2 = 1000*rand(Npoints,1);
table_data = [point_IDs, intersection_points, s_coordinates_in_traversal_1, s_coordinates_in_traversal_2];


header_strings = [{'Data ID'}, {'Location X'},{'Location Y'},{'s-coord 1'},{'s-coord 2'}]; % Headers for each column
formatter_strings = [{'%.0d'},{'red %.12f'},{'*blue %.12f'},{'%.12f'},{'%.12f'}]; % How should each column be printed?
numChars = [4, 15, 15, 5, 5]; % Specify spaces for each column
fcn_DebugTools_debugPrintTableToNCharacters(table_data, header_strings, formatter_strings,numChars);


%% DEMO case: print rows 3 and 7 in red, column 3 in blue otherwise
figNum = 10007;
titleString = sprintf('DEMO case: print rows 3 and 7 in red, column 3 in blue otherwise');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);

% Fill in test data
Npoints = 10;
point_IDs = (1:Npoints)';
intersection_points = rand(Npoints,2);
s_coordinates_in_traversal_1 = rand(Npoints,1);
s_coordinates_in_traversal_2 = 1000*rand(Npoints,1);
table_data = [point_IDs, intersection_points, s_coordinates_in_traversal_1, s_coordinates_in_traversal_2];

rowsToFormat = [3 7];
header_strings = [{'Data ID'}, {'Location X'},{'Location Y'},{'s-coord 1'},{'s-coord 2'}]; % Headers for each column

formatter_strings = [...
    {'%.0d'},{'%.12fa'},{'*blue %.12fa'},{'%.12fa'},{'%.12fa'},{[]}; 
    {'[0.8 0.8 0.8] %.0d'},{'red %.12fa'},{'red %.12fa'},{'red %.12fa'},{'red %.12fa'},{rowsToFormat}]; 


numChars = [-1, -1, -1, -1, -1]; % Specify spaces for each column

rowToPrintInRed = 1;
fcn_DebugTools_debugPrintTableToNCharacters(table_data, header_strings, formatter_strings,numChars);


%% DEMO case: print to a file (defaults to black/white, even if print spec includes colors)
figNum = 10008;
titleString = sprintf('DEMO case: print to a file (defaults to black/white, even if print spec includes colors)');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);

% Fill in test data
Npoints = 10;
point_IDs = (1:Npoints)';
intersection_points = rand(Npoints,2);
s_coordinates_in_traversal_1 = rand(Npoints,1);
s_coordinates_in_traversal_2 = 1000*rand(Npoints,1);
table_data = [point_IDs, intersection_points, s_coordinates_in_traversal_1, s_coordinates_in_traversal_2];


header_strings = [{'Data ID'}, {'Location X'},{'Location Y'},{'s-coord 1'},{'s-coord 2'}]; % Headers for each column
formatter_strings = [{'%.0d'},{'red %.12f'},{'*blue %.12f'},{'%.12f'},{'%.12f'}]; % How should each column be printed?
numChars = [4, 15, 15, 5, 5]; % Specify spaces for each column
fid = fopen('test.txt','w');
fcn_DebugTools_debugPrintTableToNCharacters(table_data, header_strings, formatter_strings,numChars, fid);
fclose(fid);

fprintf(1,'Below are the contents of file text.txt, which will be deleted after showing this result:\n');
type('test.txt');

delete('test.txt');


%% DEMO case: autocalculate column width for every entry with data limiting width
figNum = 10009;
titleString = sprintf('DEMO case: autocalculate column width for every entry with data limiting width');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);

% Fill in test data
Npoints = 10;
point_IDs = (1:Npoints)';
intersection_points = rand(Npoints,2);
s_coordinates_in_traversal_1 = rand(Npoints,1);
s_coordinates_in_traversal_2 = 1000*rand(Npoints,1);
table_data = [point_IDs, intersection_points, s_coordinates_in_traversal_1, s_coordinates_in_traversal_2];


header_strings = [{'X'}, {'Location X'},{'Location Y'},{'s-coord 1'},{'s-coord 2'}]; % Headers for each column
formatter_strings = [{'%.0d'},{'%.12f'},{'%.12f'},{'%.12f'},{'%.12f'}]; % How should each column be printed?
numChars = [0, -1, -2, -3, -4]; % Use zero or negative numbers to specify padding as 0, 1, 2, etc spaces between columns
fcn_DebugTools_debugPrintTableToNCharacters(table_data, header_strings, formatter_strings,numChars);

%% DEMO case: autocalculate column width for every entry with headers limiting width
figNum = 10009;
titleString = sprintf('DEMO case: autocalculate column width for every entry with headers limiting width');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);

% Fill in test data
Npoints = 10;
point_IDs = (1:Npoints)';
intersection_points = rand(Npoints,2);
s_coordinates_in_traversal_1 = rand(Npoints,1);
s_coordinates_in_traversal_2 = 1000*rand(Npoints,1);
table_data = [point_IDs, intersection_points, s_coordinates_in_traversal_1, s_coordinates_in_traversal_2];


header_strings = [{'Xdata'}, {'Location X'},{'Location Y'},{'s-coord 1'},{'s-coord 2'}]; % Headers for each column
formatter_strings = [{'%.0d'},{'%.2f'},{'%.2f'},{'%.2f'},{'%.2f'}]; % How should each column be printed?
numChars = [0, -1, -2, -3, -4]; % Use zero or negative numbers to specify padding as 0, 1, 2, etc spaces between columns
fcn_DebugTools_debugPrintTableToNCharacters(table_data, header_strings, formatter_strings,numChars);


%% DEMO case: fixed column width for some columns, autocalculated for others
figNum = 10010;
titleString = sprintf('DEMO case: fixed column width for some columns, autocalculated for others');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);

% Fill in test data
Npoints = 10;
point_IDs = (1:Npoints)';
intersection_points = rand(Npoints,2);
s_coordinates_in_traversal_1 = rand(Npoints,1);
s_coordinates_in_traversal_2 = 1000*rand(Npoints,1);
table_data = [point_IDs, intersection_points, s_coordinates_in_traversal_1, s_coordinates_in_traversal_2];


header_strings = [{'Xdata'}, {'Location X'},{'Location Y'},{'s-coord 1'},{'s-coord 2'}]; % Headers for each column
formatter_strings = [{'%.0d'},{'%.12f'},{'%.12f'},{'%.12f'},{'%.12f'}]; % How should each column be printed?
numChars = [0, 5, -1, 8, -4]; % Use zero or negative numbers to specify padding as 0, 1, 2, etc spaces between columns
fcn_DebugTools_debugPrintTableToNCharacters(table_data, header_strings, formatter_strings,numChars);


%% DEMO case: data overflow case, attempting prints of numbers bigger than formatting results in WRONG numbers
figNum = 10011;
titleString = sprintf('DEMO case: data overflow case, attempting prints of numbers bigger than formatting results in WRONG numbers');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);

% Fill in test data
Npoints = 10;
point_IDs = (1:Npoints)';
intersection_points = rand(Npoints,2);
s_coordinates_in_traversal_1 = 100000*rand(Npoints,1);
s_coordinates_in_traversal_2 = 100000*rand(Npoints,1);
table_data = [point_IDs, intersection_points, s_coordinates_in_traversal_1, s_coordinates_in_traversal_2];

header_strings = [{'X'}, {'Y'},{'Z'},{'Aa'},{'Bb'}]; % Headers for each column
formatter_strings = [{'%.0d'},{'%.2f'},{'%.2f'},{'%.2f'},{'%.2f'}]; % How should each column be printed?
numChars = [4, 4, 4, 4, 4]; % Use zero or negative numbers to specify padding as 0, 1, 2, etc spaces between columns
fcn_DebugTools_debugPrintTableToNCharacters(table_data, header_strings, formatter_strings,numChars);

%% DEMO case: autoalign at decimal place
figNum = 10012;
titleString = sprintf('DEMO case: autoalign at decimal place');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);

% Fill in test data
Npoints = 10;
point_IDs = (1:Npoints)';
intersection_points = rand(Npoints,2);
s_coordinates_in_traversal_1 = (10.^(randi([-2 6], 10, 1))).*rand(Npoints,1);
s_coordinates_in_traversal_2 = (10.^(randi([-2 6], 10, 1))).*rand(Npoints,1);
table_data = [point_IDs, intersection_points, s_coordinates_in_traversal_1, s_coordinates_in_traversal_2];

% Show UNALIGNED data
fprintf(1,'\nNOT aligned:\n')
header_strings = [{'X'}, {'Y'},{'Z'},{'Aa'},{'Bb'}]; % Headers for each column
formatter_strings = [{'%.0d'},{'%.2f'},{'%.2f'},{'%.2f'},{'%.2f'}]; % How should each column be printed?
numChars = [4, 4, 4, 4, 4]; % Use zero or negative numbers to specify padding as 0, 1, 2, etc spaces between columns
fcn_DebugTools_debugPrintTableToNCharacters(table_data, header_strings, formatter_strings,numChars);

% Show aligned data with autoalignment at decimal place
fprintf(1,'\nAligned:\n')
formatter_strings = [{'%.0d'},{'%.2fa'},{'%10.2fa'},{'%.4fa'},{'%4.2fa'}]; % How should each column be printed?
numChars = [-1, -1, -1, -1, -1]; % Use zero or negative numbers to specify padding as 0, 1, 2, etc spaces between columns
fcn_DebugTools_debugPrintTableToNCharacters(table_data, header_strings, formatter_strings,numChars);



%% DEMO case: pass in a cell array
figNum = 10013;
titleString = sprintf('DEMO case: data is a cell array');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);

% Fill in test data
Npoints = 10;
point_IDs = (1:Npoints)';
integer_points = randi([-2 6], Npoints, 1);

minL = 3; maxL = 12;
alphabet = 'abcdefghijklmnopqrstuvwxyz';
randomStrings = strings(Npoints,1);
for i=1:Npoints
    L = randi([minL maxL]);
    % randomStrings(i) = string(char(alphabet(randi(numel(alphabet),1,L))));
    randomStrings(i) = char(alphabet(randi(numel(alphabet),1,L)));
end
randomStrings(6,1) = ""; % Make one string empty

randomFloats = (10.^(randi([-2 6], 10, 1))).*rand(Npoints,1);

cellArray = cell(Npoints,4);
cellArray(:, 1) = num2cell(point_IDs);
cellArray(:, 2) = num2cell(integer_points);
cellArray(:, 3) = cellstr(randomStrings);
cellArray(:, 4) = num2cell(randomFloats);

table_data = cellArray;

% Show UNALIGNED data
fprintf(1,'\nNOT aligned:\n')
header_strings = [{'X'}, {'Y'},{'Z'},{'Aa'}]; % Headers for each column
formatter_strings = [{'%.0d'},{'%d'},{'%s'},{'%.2f'}]; % How should each column be printed?
numChars = [4, 4, 4, 4]; % Use zero or negative numbers to specify padding as 0, 1, 2, etc spaces between columns
fcn_DebugTools_debugPrintTableToNCharacters(table_data, header_strings, formatter_strings,numChars);

% Show aligned data with autoalignment at decimal place, including
% negative values
fprintf(1,'\nAligned:\n')
header_strings = [{'X'}, {'  Y'},{'Z'},{'     Aa'}]; % Headers for each column
formatter_strings = [{'%.0d'},{'%.0fa'},{'%s'},{'%.2fa'}]; % How should each column be printed?
numChars = [-1, -1, -1, -1]; % Use zero or negative numbers to specify padding as 0, 1, 2, etc spaces between columns
fcn_DebugTools_debugPrintTableToNCharacters(table_data, header_strings, formatter_strings,numChars);


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

% %% Basic example - NO FIGURE
% figNum = 80001;
% fprintf(1,'Figure: %.0f: FAST mode, empty figNum\n',figNum);
% figure(figNum); close(figNum);
% 
% thisSourceFolderName = fullfile(pwd,'Data','processOneTimeclean','From');
% thisDestinationFolder = fullfile(pwd,'Data','processOneTimeclean','To');
% 
% if exist(thisDestinationFolder,'dir')
%     [SUCCESS,~,~] = rmdir(thisDestinationFolder,'s');
%     if ~SUCCESS
%         error('Unable to remove test directory');
%     end
% end
% 
% % Call the function
% fcn_DataPipe_processOneTimeclean(thisSourceFolderName, thisDestinationFolder, ([]));
% 
% sgtitle(titleString, 'Interpreter','none');
% 
% % Check variable types
% assert(exist(thisDestinationFolder,'dir'));
% 
% % Check variable sizes
% temp = dir(thisDestinationFolder);
% assert(length(temp)==4);
% 
% % % Check variable values
% % assert(all(~flags_folderWasPreviouslyZipped));
% 
% [SUCCESS,~,~] = rmdir(thisDestinationFolder,'s');
% if ~SUCCESS
%     error('Unable to remove test directory');
% end
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
% thisSourceFolderName = fullfile(pwd,'Data','processOneTimeclean','From');
% thisDestinationFolder = fullfile(pwd,'Data','processOneTimeclean','To');
% 
% if exist(thisDestinationFolder,'dir')
%     [SUCCESS,~,~] = rmdir(thisDestinationFolder,'s');
%     if ~SUCCESS
%         error('Unable to remove test directory');
%     end
% end
% 
% % Call the function
% fcn_DataPipe_processOneTimeclean(thisSourceFolderName, thisDestinationFolder, (-1));
% 
% sgtitle(titleString, 'Interpreter','none');
% 
% % Check variable types
% assert(exist(thisDestinationFolder,'dir'));
% 
% % Check variable sizes
% temp = dir(thisDestinationFolder);
% assert(length(temp)==4);
% 
% % % Check variable values
% % assert(all(~flags_folderWasPreviouslyZipped));
% 
% [SUCCESS,~,~] = rmdir(thisDestinationFolder,'s');
% if ~SUCCESS
%     error('Unable to remove test directory');
% end
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
% thisSourceFolderName = fullfile(pwd,'Data','processOneTimeclean','From');
% thisDestinationFolder = fullfile(pwd,'Data','processOneTimeclean','To');
% 
% if exist(thisDestinationFolder,'dir')
%     [SUCCESS,~,~] = rmdir(thisDestinationFolder,'s');
%     if ~SUCCESS
%         error('Unable to remove test directory');
%     end
% end
% 
% Niterations = 1;
% 
% % Do calculation without pre-calculation
% tic;
% for ith_test = 1:Niterations
%     % Call the function
%     fcn_DataPipe_processOneTimeclean(thisSourceFolderName, thisDestinationFolder, ([]));
% 
% end
% slow_method = toc;
% 
% % Do calculation with pre-calculation, FAST_MODE on
% tic;
% for ith_test = 1:Niterations
%     % Call the function
%     fcn_DataPipe_processOneTimeclean(thisSourceFolderName, thisDestinationFolder, (-1));
% 
% end
% fast_method = toc;
% 
% 
% [SUCCESS,~,~] = rmdir(thisDestinationFolder,'s');
% if ~SUCCESS
%     error('Unable to remove test directory');
% end
% 
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
% 

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
