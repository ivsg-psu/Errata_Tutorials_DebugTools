%% script_test_fcn_DebugTools_extractPlotFormatFromString.m
% This is a script to exercise the function: fcn_DebugTools_extractPlotFormatFromString
% This function was written on 2023_08_12 by S. Brennan, sbrennan@psu.edu


% Revision history:
% 2023_08_12
% -- first write of the code
% 2025_07_15 by Sean Brennan
% -- pulled code out of PlotRoad and into DebugTools, due to extensive use
% in other libraries

%% Basic Example
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   ____            _        ______                           _
%  |  _ \          (_)      |  ____|                         | |
%  | |_) | __ _ ___ _  ___  | |__  __  ____ _ _ __ ___  _ __ | | ___
%  |  _ < / _` / __| |/ __| |  __| \ \/ / _` | '_ ` _ \| '_ \| |/ _ \
%  | |_) | (_| \__ \ | (__  | |____ >  < (_| | | | | | | |_) | |  __/
%  |____/ \__,_|___/_|\___| |______/_/\_\__,_|_| |_| |_| .__/|_|\___|
%                                                      | |
%                                                      |_|
% See: https://patorjk.com/software/taag/#p=display&f=Big&t=Basic%20Example
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%§
% function only plots, has no outputs

%% BASIC example 1 - simple example
fig_num = 1;
figure(fig_num);
clf;

% Test the function
formatString = 'r.-';
plotFormat = fcn_DebugTools_extractPlotFormatFromString(formatString, (fig_num));

% Check results
assert(isstruct(plotFormat));
assert(strcmp(plotFormat.LineStyle,'-'));
assert(isequal(plotFormat.Color,[1 0 0]));
assert(strcmp(plotFormat.Marker,'.'));

%% BASIC example 2 - simple example
fig_num = 1;
figure(fig_num);
clf;

% Test the function
formatString = 'g';
plotFormat = fcn_DebugTools_extractPlotFormatFromString(formatString, (fig_num));

% Check results
assert(isstruct(plotFormat));
assert(isequal(plotFormat.Color,[0 1 0]));

%% testing speed of function


formatString = 'r.-';


% Speed Test Calculation
fig_num=[];
REPS=5; minTimeSlow=Inf;
tic;

% Slow mode calculation
for i=1:REPS
    tstart=tic;
    plotFormat = fcn_DebugTools_extractPlotFormatFromString(formatString, (fig_num));
    telapsed=toc(tstart);
    minTimeSlow=min(telapsed,minTimeSlow);
end
averageTimeSlow=toc/REPS;
%slow mode END

% Fast Mode Calculation
fig_num = -1;
minTimeFast = Inf;
tic;
for i=1:REPS
    tstart = tic;
    plotFormat = fcn_DebugTools_extractPlotFormatFromString(formatString, (fig_num));
    telapsed = toc(tstart);
    minTimeFast = min(telapsed,minTimeFast);
end
averageTimeFast = toc/REPS;

% Display Console Comparison
if 1==1
    fprintf(1,'\n\nComparison of fcn_DebugTools_extractPlotFormatFromString without speed setting (slow) and with speed setting (fast):\n');
    fprintf(1,'N repetitions: %.0d\n',REPS);
    fprintf(1,'Slow mode average speed per call (seconds): %.5f\n',averageTimeSlow);
    fprintf(1,'Slow mode fastest speed over all calls (seconds): %.5f\n',minTimeSlow);
    fprintf(1,'Fast mode average speed per call (seconds): %.5f\n',averageTimeFast);
    fprintf(1,'Fast mode fastest speed over all calls (seconds): %.5f\n',minTimeFast);
    fprintf(1,'Average ratio of fast mode to slow mode (unitless): %.3f\n',averageTimeSlow/averageTimeFast);
    fprintf(1,'Fastest ratio of fast mode to slow mode (unitless): %.3f\n',minTimeSlow/minTimeFast);
end
%Assertion on averageTime NOTE: Due to the variance, there is a chance that
%the assertion will fail.
assert(averageTimeFast<averageTimeSlow);