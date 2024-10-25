function [flag_keepGoing, startingIndex, endingIndex] = fcn_DebugTools_queryNumberRange(flags_toCheck, varargin)
%fcn_DebugTools_queryNumberRange
% queries the user to select a number based on a flag vector, and
% optionally can confirm the selection is valid if user selects a number
% range that overlaps indicies where a flag value is equal to 1
%
% FORMAT:
%
%      [flag_keepGoing, startingIndex, endingIndex] = fcn_DebugTools_queryNumberRange(flags_toCheck, (queryEndString), (flag_confirmOverwrite), (directory_filelist), (fid))
%
% INPUTS:
%
%      flags_toCheck: a list of flags, either 1 or 0, that indicate that
%      the number is either "done" (value = 1) or "not done" (value = 0).
%      The query defaults to the first "not done" value (the first 0).
%      Then, based on the user's entry, the query defaults to
%      subsequent-to-start last "not done" or 0 value in flags_toCheck. For
%      example, if flags_toCheck = [1 1 0 0 0 1 1 0 0 1], then the default start
%      index will be 3 as this is the first index in flags_toCheck where a
%      0 appears. If the user however selects a starting index of 6, then
%      the prompt will give a default ending index of 9, as this is the
%      last 0 value to appear after the 6 index.
%
%      (OPTIONAL INPUTS)
%
%      queryEndString: a string that appears at the end of the number query
%      given at each prompt, filled in as the XXX in the form:
%      "What is the starting numberXXXXX?". For example, if some enters:
%      " of the file(s) to parse", then the prompt will be:
%      "What is the starting number of the files to parse?". Default is
%      empty.
%
%      flag_confirmOverwrite: set to 1 to force the user to confirm
%      "overwrite" if the user selects a number range such that it overlaps
%      with one of the indicies where flags_toCheck is 1. Or, set to 0 to
%      skip this checking.  Default is 1
%
%      directory_filelist: a structure array that is the output of a
%      "dir" command. This is used to show which files corresponding to
%      flags_toCheck will be overwritten. A typical output can be generated
%      using: directory_filelist =
%      fcn_DebugTools_listDirectoryContents({cd});
%
%      fid: the fileID where to print. Default is 0, to NOT print results to
%      the console. If set to -1, skips any input checking or debugging, no
%      prints will be generated, and sets up code to maximize speed.
%
% OUTPUTS:
%
%      flag_keepGoing: outputs a 1 if user accepts, 0 otherwise
%
%      startingIndex: the user-selected first index
%
%      endingIndex: the user-selected first index
%
% DEPENDENCIES:
%
%      (none)
%
% EXAMPLES:
%
%     See the script: script_test_fcn_DebugTools_queryNumberRange
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
if (nargin==5 && isequal(varargin{end},-1))
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
        narginchk(1,5);

    end
end

% Does user want to specify queryEndString?
queryEndString = ''; % Default is empty
if (2 <= nargin)
    temp = varargin{1};
    if ~isempty(temp)
        queryEndString = temp;
    end
end

% Does user want to specify flag_confirmOverwrite?
flag_confirmOverwrite = 1; % Default is empty
if (3 <= nargin)
    temp = varargin{2};
    if ~isempty(temp)
        flag_confirmOverwrite = temp;
    end
end


% Does user want to specify flag_confirmOverwrite?
directory_filelist = []; % Default is empty
if (3 <= nargin)
    temp = varargin{3};
    if ~isempty(temp)
        directory_filelist = temp;
        if (0 == flag_max_speed)
            if flag_check_inputs == 1
                if length(directory_filelist)~=length(flags_toCheck)
                    error('Directory length should match flags_toCheck');
                end
            end
        end
    end
end


% Does user want to specify fid?
fid = 0; % Default is to NOT print to console
if (0 == flag_max_speed) && (5 <= nargin)
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

Nflags = length(flags_toCheck);

%%% What numbers of files to parse?

flag_keepGoing = 0;

defaultStartIndex = find(flags_toCheck==0,1);
if isempty(defaultStartIndex)
    defaultStartIndex = 1;
end

% Get user's inputs for starting number
flag_goodReply = 0;
warningCount = 0;
while (0==flag_goodReply)
    queryString = sprintf('What is the starting number%s? [default = %.0d]:', queryEndString, defaultStartIndex);
    startingNumberString = input(queryString,'s');
    startingIndex = str2double(startingNumberString);
    if isempty(startingNumberString)
        startingIndex = defaultStartIndex;
        flag_goodReply = 1;
        flag_keepGoing = 1;

    elseif ~isnan(startingIndex) && (startingIndex>=1) && (startingIndex<=Nflags) && (round(startingIndex)==startingIndex)
        % Starting index is not a character, in index range, and not a
        % weird float
        flag_goodReply = 1;
        flag_keepGoing = 1;

    else
        warningCount = warningCount+1;
        if warningCount>3
            warning('Too many warnings - exiting process');
            flag_goodReply = 1;
            flag_keepGoing = 0;
        else
            warning('Invalid input detected: %s (warning %.0d of 3, after 3 will exit)', startingNumberString, warningCount);
        end
    end
end

if 1==flag_keepGoing
    flag_keepGoing = 0;
    % Set all search area up to the start index to zero, forcing the next
    % search to start after that point
    tempSearchFlags = flags_toCheck;
    tempSearchFlags(1:startingIndex,1) = 0;

    firstParsedIndex = find(tempSearchFlags==1,1);
    if isempty(firstParsedIndex)
        defaultEndIndex = Nflags;
    else
        defaultEndIndex = firstParsedIndex-1;
    end

    % Get user's inputs for ending number
    flag_goodReply = 0;
    warningCount = 0;
    while (0==flag_goodReply)
        queryString = sprintf('What is the ending number%s? [default = %.0d]:', queryEndString, defaultEndIndex);
        endingNumberString = input(queryString,'s');
        endingIndex = str2double(endingNumberString);
        if isempty(endingNumberString)
            endingIndex = defaultEndIndex;
            flag_goodReply = 1;
            flag_keepGoing = 1;
        elseif ~isnan(endingIndex) && (endingIndex>=startingIndex) && (endingIndex<=Nflags) && (round(endingIndex)==endingIndex)
            % endingIndex is not a character, in index range, and not a
            % weird float
            flag_goodReply = 1;
            flag_keepGoing = 1;
        else
            warningCount = warningCount+1;
            if warningCount>3
                warning('Too many warnings - exiting process');
                flag_goodReply = 1;
                flag_keepGoing = 0;
            else
                warning('Invalid input detected: %s (warning %.0d of 3, after 3 will exit)', endingNumberString, warningCount);
            end
        end
    end
end


%%% Make sure there are no overwritten files?
if 1==flag_keepGoing && 0~=flag_confirmOverwrite

    flag_keepGoing = 0;
    indiciesToCheck = startingIndex:endingIndex;    

    if ~any(flags_toCheck(indiciesToCheck,1))
        flag_keepGoing = 1;
    else
        % Show which flags will be lost?
        overwrittenIndicies = indiciesToCheck(flags_toCheck(indiciesToCheck)==1);
        if ~isempty(directory_filelist)
            fcn_DebugTools_printDirectoryListing(directory_filelist(overwrittenIndicies), ('THE FOLLOWING PREVIOUSLY PROCESSED FILES MAY BE OVERWRITTEN:'), ([]), (1));
        else
            fprintf(1,'THE FOLLOWING MAY BE OVERWRITTEN:\n');
            for ith_overwritten = 1:length(overwrittenIndicies)
                fprintf(1,'\tIndex: %.0d\n',overwrittenIndicies(ith_overwritten));
            end
        end
        flag_goodReply = 0;
        while 0==flag_goodReply
            acceptOverwriteString = input('Is this acceptable (you MUST type "Y" or "y" to continue)? Y/N [N]:','s');
            if isempty(acceptOverwriteString)
                flag_goodReply = 1;
            else
                acceptOverwriteString = lower(acceptOverwriteString);
                if isscalar(acceptOverwriteString) && (strcmp(acceptOverwriteString,'n')||strcmp(acceptOverwriteString,'y'))
                    flag_goodReply = 1;
                end
                if strcmp(acceptOverwriteString,'y')
                    flag_keepGoing = 1;
                end

            end
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

