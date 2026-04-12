% script_test_fcn_DebugTools_printTimeStringFromSeconds.m
% Tests fcn_DebugTools_printTimeStringFromSeconds


% REVISION HISTORY:
% 2026_04_11 by Sean Brennan, sbrennan@psu.edu
% - In script_test_fcn_DebugTools_printTimeStringFromSeconds
%   % * wrote the code originally, using fcn_DebugTools_parseStringIntoCells as
%   %   % a starter

% TO-DO:
% 2026_04_11 by Sean Brennan, sbrennan@psu.edu
% - fill in to-do items here.

% Test cases
%% Seconds
result = fcn_DebugTools_printTimeStringFromSeconds(45, -1);
assert(strcmp(result,'45.0 seconds'));

%% Minutes
result = fcn_DebugTools_printTimeStringFromSeconds(90, -1);
assert(strcmp(result,'1.5 minutes'));

%% Hours
result = fcn_DebugTools_printTimeStringFromSeconds(4000, -1);
assert(strcmp(result,'1.1 hours'));

%% Days
result = fcn_DebugTools_printTimeStringFromSeconds(500000, -1);
assert(strcmp(result,'5.8 days'));
