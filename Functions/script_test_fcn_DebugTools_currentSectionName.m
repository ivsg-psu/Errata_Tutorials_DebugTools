% script_test_fcn_DebugTools_currentSectionName.m
% This is a script to exercise the function: fcn_DebugTools_currentSectionName.m
% This function was written on 2026_09_17 by S. Brennan
% Questions or comments? sbrennan@psu.edu


% REVISION HISTORY:
%
% 2026_09_17 by Sean Brennan, sbrennan@psu.edu
% - In script_test_fcn_DebugTools_currentSectionName
%   % * First write of the function
%   % * Used script_test_fcn_DebugTools_addStringToEnd as starter

% TO-DO:
% 
% 2026_09_17 by Sean Brennan, sbrennan@psu.edu
% - fill in to-do items here.


close all;



%% Basic case - numeric (adds a space)

outputString = fcn_DebugTools_currentSectionName;
assert(isequal(outputString,'Basic case - numeric (adds a space)'));

%% Basic case - test 2


outputString = fcn_DebugTools_currentSectionName;
assert(isequal(outputString,'Basic case - test 2'));

%% Basic case - test 3

outputString = fcn_DebugTools_currentSectionName;
assert(isequal(outputString,'Basic case - test 3'));

%% Fail conditions
if 1==0
    %% Bad input
    outputString = fcn_DebugTools_currentSectionName;
end
    