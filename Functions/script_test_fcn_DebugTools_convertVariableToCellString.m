% script_test_fcn_DebugTools_convertVariableToCellString.m
% Tests fcn_DebugTools_convertVariableToCellString
% Written in 2023_01_18 by S.Brennan


% REVISION HISTORY:
% 
% 2023_01_18 by Sean Brennan, sbrennan@psu.edu
% - wrote the code originally, 
%
% 2025_11_20 by Sean Brennan, sbrennan@psu.edu
% - Formatted revision lists to Markdown format

% TO-DO:
% 2025_11_20 by Sean Brennan, sbrennan@psu.edu
% - Need to put into standard form



% Test cases
%% Single character in cell array
result = fcn_AutoExam_convertVariableToCellString({'A'});
assert(isequal(result,{'A'}));

%% Single number in cell array - should convert to "pretty" view
result = fcn_AutoExam_convertVariableToCellString({[4]});
assert(isequal(result,{'4'}));

%% Two numbers in a cell array 
input = [{[45]},{[9]}];
result = fcn_AutoExam_convertVariableToCellString(input);
assert(isequal(result,{'45, 9'}));

%% Single character in cell array
result = fcn_DebugTools_convertVariableToCellString({'D'});
assert(isequal(result,{'D'}));

%% Empty single input
result = fcn_DebugTools_convertVariableToCellString({''});
assert(isempty(result{1}));

%% Numeric single input
result = fcn_DebugTools_convertVariableToCellString(2.34);
assert(isequal(result,{'2.34'}));

%% Multiple character in cell array
result = fcn_DebugTools_convertVariableToCellString([{'D'},{'abc'}]);
assert(isequal(result,{'D, abc'}));

%% Multiple mixed character, numeric in cell array
result = fcn_DebugTools_convertVariableToCellString([{'D'},{2}]);
assert(isequal(result,{'D, 2'}));

%% Multiple mixed character, numeric in cell array ending in space
result = fcn_DebugTools_convertVariableToCellString([{'D'},{2},'abc ']);
assert(isequal(result,{'D, 2, abc '}));

%% Multiple mixed character, numeric in cell array ending in string with commas
result = fcn_DebugTools_convertVariableToCellString([{'D'},{2},'abc , 123']);
assert(isequal(result,{'D, 2, abc , 123'}));

%% Character input
result = fcn_DebugTools_convertVariableToCellString('abc');
assert(isequal(result,{'abc'}));
