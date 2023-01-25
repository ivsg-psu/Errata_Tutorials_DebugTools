% script_demo_DebugTools.m
% This is a script to exercise the functions within the DebugTools code
% library. The repo is typically located at:
%   https://github.com/ivsg-psu/Errata_Tutorials_DebugTools
% Questions or comments? sbrennan@psu.edu


% Revision history:
% 2021_12_12: sbrennan@psu.edu
% -- first write of the code by Steve Harnett
% 2022_03_27: sbrennan@psu.edu
% -- created a demo script of core debug utilities
% 2023_01_16: sbrennan@psu.edu
% -- vastly improved README file
% 2023_01_25: sbrennan@psu.edu
% -- added install from URL


%% Set up workspace
if ~exist('flag_DebugTools_Was_Initialized','var')
    
    % add necessary directories for functions recursively
    if(exist([pwd, filesep,  'Functions'],'dir'))
        addpath(genpath([pwd, filesep, 'Functions']))
    else % Throw an error?
        error('No Functions directory exists to be added to the path. Please create one (see README.md) and run again.');
    end
    
    % % add necessary directories for data?
    if(exist([pwd, filesep,  'Data'],'dir'))
        addpath(genpath([pwd, filesep, 'Data']))
    else % Throw an error?
        % error('No Data directory exists to be added to the path. Please create one (see README.md) and run again.');
    end
    
    % add necessary directories for Utilities to the path?
    if(exist([pwd, filesep,  'Utilities'],'dir'))
        addpath(genpath([pwd, filesep, 'Utilities']))  % This is where GPS utilities are stored
    else % Throw an error?
        % error('No Utilities directory exists to be added to the path. Please create one (see README.md) and run again.');
    end
    
    % set a flag so we do not have to do this again
    flag_DebugTools_Was_Initialized = 1;
end

%% Workspace Management
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  __          __        _                                __  __                                                   _   
%  \ \        / /       | |                              |  \/  |                                                 | |  
%   \ \  /\  / /__  _ __| | _____ _ __   __ _  ___ ___   | \  / | __ _ _ __   __ _  __ _  ___ _ __ ___   ___ _ __ | |_ 
%    \ \/  \/ / _ \| '__| |/ / __| '_ \ / _` |/ __/ _ \  | |\/| |/ _` | '_ \ / _` |/ _` |/ _ \ '_ ` _ \ / _ \ '_ \| __|
%     \  /\  / (_) | |  |   <\__ \ |_) | (_| | (_|  __/  | |  | | (_| | | | | (_| | (_| |  __/ | | | | |  __/ | | | |_ 
%      \/  \/ \___/|_|  |_|\_\___/ .__/ \__,_|\___\___|  |_|  |_|\__,_|_| |_|\__,_|\__, |\___|_| |_| |_|\___|_| |_|\__|
%                                | |                                                __/ |                              
%                                |_|                                               |___/                               
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Demonstrate workspace install from URL
% see script_test_fcn_DebugTools_installDependencies
flag_show_warnings = 0;

% NOTE: this installs under the Utililities directory
dependency_name = 'DebugTools_v2023_01_25';
dependency_subfolders = {'Functions','Data'};
dependency_url = 'https://github.com/ivsg-psu/Errata_Tutorials_DebugTools/blob/main/Releases/DebugTools_v2023_01_25.zip?raw=true';
fcn_DebugTools_installDependencies(dependency_name, dependency_subfolders, dependency_url);


disp('Library installed! Verify this now, as it will be deleted to complete the demo');
disp('Paused. Hit any key to continue...');
pause;

% Remove the folders from path, to avoid deletion warnings
temp_path = fullfile(pwd,'Utilities','DebugTools_v2023_01_25','Functions');
rmpath(temp_path);
temp_path = fullfile(pwd,'Utilities','DebugTools_v2023_01_25','Data');
rmpath(temp_path);

% Remove the example Utilities folder and all subfolders
[success_flag,error_message,message_ID] = rmdir('Utilities','s');

% Did it work?
if ~success_flag
    error('Unable to remove the example Utilities directory. Reason: %s with message ID: %s\n',error_message,message_ID);
elseif ~isempty(error_message)
    if flag_show_warnings
        warning('The Utilities directory was removed, but with a warning: %s\n and message ID: %s\n(continuing)\n',error_message, message_ID); %#ok<UNRCH> 
    end
end

%% Demonstrate how to add subdirectories
if ~exist('flag_DebugTools_Folders_Initialized','var')
    fcn_DebugTools_addSubdirectoriesToPath(pwd,{'Functions','Data'});

    % set a flag so we do not have to do this again
    flag_DebugTools_Folders_Initialized = 1;
end

%% Input CHecking
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   _____                   _      _____ _               _    _             
%  |_   _|                 | |    / ____| |             | |  (_)            
%    | |  _ __  _ __  _   _| |_  | |    | |__   ___  ___| | ___ _ __   __ _ 
%    | | | '_ \| '_ \| | | | __| | |    | '_ \ / _ \/ __| |/ / | '_ \ / _` |
%   _| |_| | | | |_) | |_| | |_  | |____| | | |  __/ (__|   <| | | | | (_| |
%  |_____|_| |_| .__/ \__,_|\__|  \_____|_| |_|\___|\___|_|\_\_|_| |_|\__, |
%              | |                                                     __/ |
%              |_|                                                    |___/ 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Demonstrate fcn_DebugTools_checkInputsToFunctions
% Check that input has 2 columns, maximum row length is 5 or less
Twocolumn_of_integers_test = [4 1; 3 9; 2 7];
fcn_DebugTools_checkInputsToFunctions(Twocolumn_of_integers_test, '2column_of_integers',[5 4]);


%% Demonstrate fcn_DebugTools_doStringsMatch
% simple string comparisons, student answer is part of correct answer so returns true, ignoring case
student_answer = 'A';
correct_answers = 'abc';
result = fcn_DebugTools_doStringsMatch(student_answer,correct_answers);
assert(result);

% simple string comparisons, student answer is part of correct answer so true, checking to produce false result if student repeats (FALSE)
student_answer = 'aa';
correct_answers = 'abc';
result = fcn_DebugTools_doStringsMatch(student_answer,correct_answers);
assert(result==false);

%% Demonstrate fcn_DebugTools_extractNumberFromStringCell
% Choose a hard situation: Decimal number, negative, in cell array with leading zeros and text
result = fcn_DebugTools_extractNumberFromStringCell({'My number is -0000.4'});
assert(isequal(result,{'-0.4'}));

%% Demonstrate fcn_DebugTools_parseStringIntoCells
% Choose a very Complex input
inputString = 'This,isatest,of';
result = fcn_DebugTools_parseStringIntoCells(inputString);
assert(isequal(result,[{'This'},{'isatest'},{'of'}]));

%% Demonstrate fcn_DebugTools_convertVariableToCellString
% Multiple mixed character, numeric in cell array ending in string with commas
result = fcn_DebugTools_convertVariableToCellString([{'D'},{2},'abc , 123']);
assert(isequal(result,{'D, 2, abc , 123'}));

%% Output formatting
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    ____        _               _     ______                         _   _   _             
%   / __ \      | |             | |   |  ____|                       | | | | (_)            
%  | |  | |_   _| |_ _ __  _   _| |_  | |__ ___  _ __ _ __ ___   __ _| |_| |_ _ _ __   __ _ 
%  | |  | | | | | __| '_ \| | | | __| |  __/ _ \| '__| '_ ` _ \ / _` | __| __| | '_ \ / _` |
%  | |__| | |_| | |_| |_) | |_| | |_  | | | (_) | |  | | | | | | (_| | |_| |_| | | | | (_| |
%   \____/ \__,_|\__| .__/ \__,_|\__| |_|  \___/|_|  |_| |_| |_|\__,_|\__|\__|_|_| |_|\__, |
%                   | |                                                                __/ |
%                   |_|                                                               |___/ 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% fcn_DebugTools_addStringToEnd.m 
input_string = 'test';
value_to_add = 2;
output_string = fcn_DebugTools_addStringToEnd(input_string,value_to_add);
assert(isequal(output_string,'test 2'));

%% fcn_DebugTools_number2string.m 
% % prints a "pretty" version of a string, e.g avoiding weirdly odd numbers
% of decimal places or strangely formatted printing.

% Basic case - example
stringNumber = fcn_DebugTools_number2string(2.333333333); % Empty result
assert(isequal(stringNumber,'2.33'));

%% Demonstration of codes related to fcn_DebugTools_debugPrintStringToNCharacters
clc; % Clear the console

% BASIC example 1 - string is too long
test_string = 'This is a really, really, really long string but we only want the first 10 characters';
fixed_length_string = fcn_DebugTools_debugPrintStringToNCharacters(test_string,10);
fprintf(1,'The string: %s\nwas converted to: "%s"\n',test_string,fixed_length_string);

% BASIC example 2 - string is too short
test_string = 'Tiny string but should be 40 chars';
fixed_length_string = fcn_DebugTools_debugPrintStringToNCharacters(test_string,40);
fprintf(1,'The string: %s\nwas converted to: "%s"\n',test_string,fixed_length_string);

%% Demonstration of fixed-formatting table printing
% Fill in test data
Npoints = 10;
point_IDs = (1:Npoints)';
intersection_points = rand(Npoints,2);
s_coordinates_in_traversal_1 = rand(Npoints,1);
s_coordinates_in_traversal_2 = 1000*rand(Npoints,1);
table_data = [point_IDs, intersection_points, s_coordinates_in_traversal_1, s_coordinates_in_traversal_2];

% Basic test case

header_strings = [{'Data ID'}, {'Location X'},{'Location Y'},{'s-coord 1'},{'s-coord 2'}];
formatter_strings = [{'%.0d'},{'%.12f'},{'%.12f'},{'%.12f'},{'%.12f'}];
N_chars = 15; % All columns have same number of characters
fcn_DebugTools_debugPrintTableToNCharacters(table_data, header_strings, formatter_strings,N_chars);


% Advanced test case

header_strings = [{'Data ID'}, {'Location X'},{'Location Y'},{'s-coord 1'},{'s-coord 2'}]; % Headers for each column
formatter_strings = [{'%.0d'},{'%.12f'},{'%.12f'},{'%.12f'},{'%.12f'}]; % How should each column be printed?
N_chars = [4, 15, 15, 5, 5]; % Specify spaces for each column
fcn_DebugTools_debugPrintTableToNCharacters(table_data, header_strings, formatter_strings,N_chars);


