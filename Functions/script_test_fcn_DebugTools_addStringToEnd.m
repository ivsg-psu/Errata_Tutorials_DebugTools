% script_test_fcn_DebugTools_addStringToEnd.m
% This is a script to exercise the function: fcn_DebugTools_addStringToEnd.m
% This function was written on 2021_12_12 by S. Brennan
% Questions or comments? sbrennan@psu.edu


% REVISION HISTORY:
%
% 2021_12_12 by Sean Brennan, sbrennan@psu.edu
% - first write of the function
% 
% 2023_01_17 by Sean Brennan, sbrennan@psu.edu
% - first write of the script
% 
% 2025_11_20 by Sean Brennan, sbrennan@psu.edu
% - Formatted revision lists to Markdown format

% TO-DO:
% 
% 2025_11_20 by Sean Brennan, sbrennan@psu.edu
% - fill in to-do items here.


close all;



%% Basic case - numeric (adds a space)
inputString = 'test';
valueToAdd = 2;
outputString = fcn_DebugTools_addStringToEnd(inputString,valueToAdd);
assert(isequal(outputString,'test 2'));

%% Basic case - cell (adds a space)
inputString = 'test';
valueToAdd = {'2'};
outputString = fcn_DebugTools_addStringToEnd(inputString,valueToAdd);
assert(isequal(outputString,'test 2'));

%% Basic case - string (adds a space)
inputString = 'test';
valueToAdd = '2';
outputString = fcn_DebugTools_addStringToEnd(inputString,valueToAdd);
assert(isequal(outputString,'test 2'));

%% Fail conditions
if 1==0
    %% Bad input
    outputString = fcn_DebugTools_addStringToEnd(inputString,valueToAdd);
end
    