% script_demo_DebugTools.m
% This is a script to exercise the functions within the DebugTools code
% library. The repo is typically located at:
%   https://github.com/ivsg-psu/Errata_Tutorials_DebugTools
% Questions or comments? sbrennan@psu.edu


% Revision history:
%      2021_12_12:
%      -- first write of the code by Steve Harnett
%      2022_03_27:
%      -- created a demo script of core debug utilities


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

%% Demonstrate how to add subdirectories
if ~exist('flag_DebugTools_Folders_Initialized','var')
    fcn_DebugTools_addSubdirectoriesToPath(pwd,{'Functions','Data'});

    % set a flag so we do not have to do this again
    flag_DebugTools_Folders_Initialized = 1;
end


%% Demonstration of codes related to fcn_DebugTools_debugPrintStringToNCharacters
clc; % Clear the console

% BASIC example 1 - string is too long
test_string = 'This is a really really really long string where I only want the first 10 characters';
fixed_length_string = fcn_DebugTools_debugPrintStringToNCharacters(test_string,10);
fprintf(1,'The string: %s\nwas converted to: "%s"\n',test_string,fixed_length_string);

% BASIC example 2 - string is too short
test_string = 'Short str that should be 40 chars';
fixed_length_string = fcn_DebugTools_debugPrintStringToNCharacters(test_string,40);
fprintf(1,'The string: %s\nwas converted to: "%s"\n',test_string,fixed_length_string);

% Advanced example
% This example shows why the function was written: to show information in a
% delimited format length

N_chars = 15;


% Create dummy data
Npoints = 10;
intersection_points = rand(Npoints,2);
s_coordinates_in_traversal_1 = rand(Npoints,1);
s_coordinates_in_traversal_2 = 1000*rand(Npoints,1);

% Print the header
header_1_str = sprintf('%s','Data ID');
fixed_header_1_str = fcn_DebugTools_debugPrintStringToNCharacters(header_1_str,N_chars);
header_2_str = sprintf('%s','Location X');
fixed_header_2_str = fcn_DebugTools_debugPrintStringToNCharacters(header_2_str,N_chars);
header_3_str = sprintf('%s','Location Y');
fixed_header_3_str = fcn_DebugTools_debugPrintStringToNCharacters(header_3_str,N_chars);
header_4_str = sprintf('%s','s-coord 1');
fixed_header_4_str = fcn_DebugTools_debugPrintStringToNCharacters(header_4_str,N_chars);
header_5_str = sprintf('%s','s-coord 2');
fixed_header_5_str = fcn_DebugTools_debugPrintStringToNCharacters(header_5_str,N_chars);

fprintf(1,'\n\n%s %s %s %s %s\n',...
    fixed_header_1_str,...
    fixed_header_2_str,...
    fixed_header_3_str,...
    fixed_header_4_str,...
    fixed_header_5_str);

% Print the results only if the array is not empty
if ~isempty(intersection_points)
    
    % Loop through all the points
    for ith_intersection =1:length(intersection_points(:,1))
        
        % Convert all the data to fixed-length format
        results_1_str = sprintf('%.0d',ith_intersection);
        fixed_results_1_str = fcn_DebugTools_debugPrintStringToNCharacters(results_1_str,N_chars);
        results_2_str = sprintf('%.12f',intersection_points(ith_intersection,1));
        fixed_results_2_str = fcn_DebugTools_debugPrintStringToNCharacters(results_2_str,N_chars);
        results_3_str = sprintf('%.12f',intersection_points(ith_intersection,2));
        fixed_results_3_str = fcn_DebugTools_debugPrintStringToNCharacters(results_3_str,N_chars);
        results_4_str = sprintf('%.12f',s_coordinates_in_traversal_1(ith_intersection));
        fixed_results_4_str = fcn_DebugTools_debugPrintStringToNCharacters(results_4_str,N_chars);
        results_5_str = sprintf('%.12f',s_coordinates_in_traversal_2(ith_intersection));
        fixed_results_5_str = fcn_DebugTools_debugPrintStringToNCharacters(results_5_str,N_chars);
        
        % Print the fixed results
        fprintf(1,'%s %s %s %s %s\n',...
            fixed_results_1_str,...
            fixed_results_2_str,...
            fixed_results_3_str,...
            fixed_results_4_str,...
            fixed_results_5_str);
        
    end % Ends for loop
end % Ends check to see if isempty

%% Demonstrate the checking of inputs to functions
% Maximum length is 5 or less
Twocolumn_of_integers_test = [4 1; 3 9; 2 7];
fcn_DebugTools_checkInputsToFunctions(Twocolumn_of_integers_test, '2column_of_integers',[5 4]);

