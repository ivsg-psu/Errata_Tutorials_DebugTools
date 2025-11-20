% script_test_fcn_DebugTools_parseStringIntoCells.m
% Tests fcn_DebugTools_parseStringIntoCells


% REVISION HISTORY:
% 2022_11_15 by Sean Brennan, sbrennan@psu.edu
% - wrote the code originally, 
%
% 2025_11_20 by Sean Brennan, sbrennan@psu.edu
% - Formatted revision lists to Markdown format

% TO-DO:
% 2025_11_20 by Sean Brennan, sbrennan@psu.edu
% - fill in to-do items here.

% Test cases
%% Single character in cell array
result = fcn_DebugTools_parseStringIntoCells({'D'});
assert(isequal(result,{'D'}));

%% Empty character in cell array
result = fcn_DebugTools_parseStringIntoCells({''});
assert(isempty(result));

%% Complex input
inputString = 'This,isatest,of';
result = fcn_DebugTools_parseStringIntoCells(inputString);
assert(isequal(result,[{'This'},{'isatest'},{'of'}]));

%% Complex input with white space and commas that should be ignored
inputString = 'This,   ,  ,  isatest,';
result = fcn_DebugTools_parseStringIntoCells(inputString);
assert(isequal(result,[{'This'},{'isatest'}]));

%% Check the merging of strings
inputString = 'This,   ,  ,  isatest,';
[result,result2] = fcn_DebugTools_parseStringIntoCells(inputString);
assert(isequal(result,[{'This'},{'isatest'}]));
assert(isequal(result2,'thisisatest'));
