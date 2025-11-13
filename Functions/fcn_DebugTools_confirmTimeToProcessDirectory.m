function [flag_keepGoing, timeEstimateInSeconds] = fcn_DebugTools_confirmTimeToProcessDirectory(directory_listing, bytesPerSecond, varargin)
% fcn_DebugTools_confirmTimeToProcessDirectory
% Calculates the time it takes to process a directory listing and confirms
% with the user that this is acceptable.
%
% FORMAT:
%
%      [flag_keepGoing, timeEstimateInSeconds] = fcn_DebugTools_confirmTimeToProcessDirectory(directory_listing, bytesPerSecond, (indexRange),(fid))
%
% INPUTS:
%
%      directory_listing: a structure that is the output of MATLAB's "dir"
%      command that includes filename, bytes, etc.
%
%      (OPTIONAL INPUTS)
%
%      indexRange: which indicies to include in the count. Default is to use
%      all files in the directory listing.
%
%      fid: the fileID where to print. Default is 0, to NOT print results to
%      the console. If set to -1, skips any input checking or debugging, no
%      prints will be generated, and sets up code to maximize speed.
%
% OUTPUTS:
%
%      flag_keepGoing: outputs a 1 if user accepts, 0 otherwise
%
%      timeEstimateInSeconds: how many seconds the processing is estimated
%      to take
%
% DEPENDENCIES:
%
%      fcn_DebugTools_countBytesInDirectoryListing
%
% EXAMPLES:
%
%     See the script: script_test_fcn_DebugTools_confirmTimeToProcessDirectory
%     for a full test suite.
%
% This function was written on 2024_10_24 by S. Brennan
% Questions or comments? sbrennan@psu.edu

% Revision history
% 2024_10_24 - Sean Brennan, sbrennan@psu.edu
% -- wrote the code originally, copying out of DataClean library

%% Debugging and Input checks

% Check if flag_max_speed set. This occurs if the fig_num variable input
% argument (varargin) is given a number of -1, which is not a valid figure
% number.
flag_max_speed = 0;
if (nargin==4 && isequal(varargin{end},-1))
    flag_do_debug = 0; % % % % Flag to plot the results for debugging
    flag_check_inputs = 0; % Flag to perform input checking
    flag_max_speed = 1;
else
    % Check to see if we are externally setting debug mode to be "on"
    flag_do_debug = 0; % % % % Flag to plot the results for debugging
    flag_check_inputs = 1; % Flag to perform input checking
    MATLABFLAG_DEBUGTOOLS_FLAG_CHECK_INPUTS = getenv("MATLABFLAG_DEBUGTOOLS_FLAG_CHECK_INPUTS");
    MATLABFLAG_DEBUGTOOLS_FLAG_DO_DEBUG = getenv("MATLABFLAG_DEBUGTOOLS_FLAG_DO_DEBUG");
    if ~isempty(MATLABFLAG_DEBUGTOOLS_FLAG_CHECK_INPUTS) && ~isempty(MATLABFLAG_DEBUGTOOLS_FLAG_DO_DEBUG)
        flag_do_debug = str2double(MATLABFLAG_DEBUGTOOLS_FLAG_DO_DEBUG);
        flag_check_inputs  = str2double(MATLABFLAG_DEBUGTOOLS_FLAG_CHECK_INPUTS);
    end
end

% flag_do_debug = 1;

if flag_do_debug
    st = dbstack; %#ok<*UNRCH>
    fprintf(1,'STARTING function: %s, in file: %s\n',st(1).name,st(1).file);
    debug_fig_num = 999978; %#ok<NASGU>
else
    debug_fig_num = []; %#ok<NASGU>
end


%% check input arguments
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   _____                   _
%  |_   _|                 | |
%    | |  _ __  _ __  _   _| |_ ___
%    | | | '_ \| '_ \| | | | __/ __|
%   _| |_| | | | |_) | |_| | |_\__ \
%  |_____|_| |_| .__/ \__,_|\__|___/
%              | |
%              |_|
% See: http://patorjk.com/software/taag/#p=display&f=Big&t=Inputs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if (0 == flag_max_speed)
    if flag_check_inputs == 1
        % Are there the right number of inputs?
        narginchk(2,4);

    end
end

% Does user want to specify indexRange?
indexRange = (1:length(directory_listing))';
if 3 <= nargin
    temp = varargin{1};
    if ~isempty(temp)
        indexRange = temp;
    end
end

% Does user want to specify fid?
fid = 0; % Default is to NOT print to console
if (0 == flag_max_speed) && (4 <= nargin)
    temp = varargin{end};
    if ~isempty(temp)
        fid = temp;
    end
end

flag_do_plots = 0; %#ok<NASGU> % Nothing to plot


%% Main code starts here
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   __  __       _
%  |  \/  |     (_)
%  | \  / | __ _ _ _ __
%  | |\/| |/ _` | | '_ \
%  | |  | | (_| | | | | |
%  |_|  |_|\__,_|_|_| |_|
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Add the number of bytes to parse
totalBytes = fcn_DebugTools_countBytesInDirectoryListing(directory_listing, indexRange);

% Estimate the time
timeEstimateInSeconds = totalBytes/bytesPerSecond;

if timeEstimateInSeconds<60
    fprintf(1,'\nTotal estimated time to process these %.0f files: %.2f seconds \n',                                                 length(indexRange), timeEstimateInSeconds);
elseif timeEstimateInSeconds>=60 && timeEstimateInSeconds<(60*60)
    fprintf(1,'\nTotal estimated time to process these %.0f files: %.2f seconds (e.g. %.2f minutes) \n',                             length(indexRange), timeEstimateInSeconds, timeEstimateInSeconds/60);
elseif timeEstimateInSeconds>=(60*60) && timeEstimateInSeconds<(60*60*24)
    fprintf(1,'\nTotal estimated time to process these %.0f files: %.2f seconds (e.g. %.2f minutes, or %.2f hours) \n',              length(indexRange), timeEstimateInSeconds, timeEstimateInSeconds/60, timeEstimateInSeconds/3600);
else
    fprintf(1,'\nTotal estimated time to process these %.0f files: %.2f seconds (e.g. %.2f minutes, or %.2f hours, or %.2f days) \n',length(indexRange), timeEstimateInSeconds, timeEstimateInSeconds/60, timeEstimateInSeconds/3600, timeEstimateInSeconds/(3600*24));
end

flag_goodReply = 0;
flag_keepGoing = 0;
while 0==flag_goodReply
    acceptTimeString = input('Is this time acceptable (you MUST type "Y" or "y" to continue)? Y/N [N]:','s');
    if isempty(acceptTimeString)
        flag_goodReply = 1;
    else
        acceptTimeString = lower(acceptTimeString);
        if isscalar(acceptTimeString) && (strcmp(acceptTimeString,'n')||strcmp(acceptTimeString,'y'))
            flag_goodReply = 1;
        end
        if strcmp(acceptTimeString,'y')
            flag_keepGoing = 1;
        end

    end
end

%% Plot the results (for debugging)?
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   _____       _
%  |  __ \     | |
%  | |  | | ___| |__  _   _  __ _
%  | |  | |/ _ \ '_ \| | | |/ _` |
%  | |__| |  __/ |_) | |_| | (_| |
%  |_____/ \___|_.__/ \__,_|\__, |
%                            __/ |
%                           |___/
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if (1==fid)

    % Nothing to do here

end

if flag_do_debug
    fprintf(1,'ENDING function: %s, in file: %s\n\n',st(1).name,st(1).file);
end

end % Ends main function




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

