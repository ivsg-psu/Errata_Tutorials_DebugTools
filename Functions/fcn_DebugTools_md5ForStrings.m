function outHashes = fcn_DebugTools_md5ForStrings(inStrings, varargin)
%% fcn_DebugTools_md5ForStrings
%fcn_DebugTools_md5ForStrings  Return MD5 hashes for multiple strings
%
% Given an input string as a md5 hash seed, and an array of strings to hash,
% returns an array of strings XOR'd with the hash seed, effectively
% scrambling the strings randomly but reversibly. 
%
% SYNTAX:
%
%      outHashes = fcn_DebugTools_md5ForStrings(inStrings, (flagOutputs))
%
% INPUTS:
%
%      inStrings: string array, char array, cellstr, or cell of char
%      vectors to XOR with the hash produced by the seedString
% 
%      (OPTIONAL INPUTS)
% 
%      flagOutputs: 
%          if set to 0 (default): returns function results 
%
%          if set to -1: checks that the hash is working by
%          performing an internal test case - does NOT return results 
%
% OUTPUTS:
%
%      outHashes : string array of 32-character lowercase hex values, or if
%      the flag is set to -1, an NaN value
%
% DEPENDENCIES:
%
%      fcn_DebugTools_checkInputsToFunctions
%
% EXAMPLES:
%       h = fcn_DebugTools_md5ForStrings({"a","b","test"})
%       h = ["0cc175b9c0f1b6a831c399e269772661" "92eb5ffee6ae2fec3ad71c777531578f" "098f6bcd4621d373cade4e832627b4f6"]
%
% See the script: script_test_fcn_DebugTools_md5ForStrings
% for a full test suite.
%
% This function was written on 2026_08_25 by S. Brennan.
% Questions or comments? sbrennan@psu.edu

% REVISION HISTORY:
% 
% 2026_08_25 by Sean Brennan, sbrennan@psu.edu
% - First write of the function using
%   % fcn_DebugTools_debug+PrintStringToNCharacters as a starter

% TO-DO:
% 2026_08_25 by Sean Brennan, sbrennan@psu.edu
% - fill in to-do items here.

%% Debugging and Input checks

% Check if flag_max_speed set. This occurs if the fid variable input
% argument (varargin) is given a number of -1, which is not a valid figure
% number.
MAX_NARGIN = 2; % The largest Number of argument inputs to the function
flag_max_speed = 0;
if (nargin==MAX_NARGIN && isequal(varargin{end},-1))
    flag_do_debug = 0; %     % Flag to plot the results for debugging
    flag_check_inputs = 0; % Flag to perform input checking
    flag_max_speed = 1;
else
    % Check to see if we are externally setting debug mode to be "on"
    flag_do_debug = 0; %     % Flag to plot the results for debugging
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
    debug_figNum = 999978; %#ok<NASGU>
else
    debug_figNum = []; %#ok<NASGU>
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

if 0 == flag_max_speed
    if flag_check_inputs == 1
        % Are there the right number of inputs?
        narginchk(1,MAX_NARGIN);

        % % Check the directoryToCheck input
        % fcn_DebugTools_checkInputsToFunctions(seedString, 'DoesDirectoryExist');
        % 
        % % Check the filePrefixString input
        % fcn_DebugTools_checkInputsToFunctions(filePrefixString, '_of_char_strings');

    end
end


% Normalize inStrings to string array
if iscell(inStrings)
    % allow cell of char or string
    fixedInputStrings = string(inStrings);
elseif ischar(inStrings) && isrow(inStrings)
    fixedInputStrings = string({inStrings});
else
    fixedInputStrings = string(inStrings);
end


% Does user want to specify flagOutputs?
flagOutputs = 0; % Default is 0
if (2 <= nargin)
    temp = varargin{1};
    if ~isempty(temp)
        flagOutputs = temp;
        % Check the flagOutputs input
        fcn_DebugTools_checkInputsToFunctions(flagOutputs, '_1column_of_integers',[1 1]);
        
        % Set test value
        if flagOutputs==-1
            fixedInputStrings = "This is a test";
        end
    end
end

% Check to see if user specifies fid?
flag_do_plots = 0; % Default is to NOT show plots
% fid = 1; % Default is to print to the console
% if (0==flag_max_speed) && (MAX_NARGIN == nargin) 
%     temp = varargin{end};
%     if ~isempty(temp)
%         fid = temp; 
%         flag_do_plots = 1;
%     end
% end


%% Start of main code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   __  __       _
%  |  \/  |     (_)
%  | \  / | __ _ _ _ __
%  | |\/| |/ _` | | '_ \
%  | |  | | (_| | | | | |
%  |_|  |_|\__,_|_|_| |_|
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Preallocate
N = numel(fixedInputStrings);
outHashes = strings(size(fixedInputStrings));

% Prefer mlreportgen.utils.hash when available and supports elementwise call
if exist('mlreportgen.utils.hash','file') == 2
    try
        for k = 1:N
            outHashes(k) = string(mlreportgen.utils.hash(fixedInputStrings(k)));
        end
        outHashes = lower(outHashes);
        return
    catch
        % fallback to Java below
    end
end

% Fallback: reuse Java MessageDigest instance for efficiency
md = java.security.MessageDigest.getInstance('MD5');
for k = 1:N
    s = char(fixedInputStrings(k));        % Java needs bytes from char
    md.reset();
    md.update(uint8(s));
    digest = md.digest();             % int8 array
    hexChars = char(dec2hex(typecast(digest,'uint8'))); % N-by-2 char array
    outHashes(k) = string(lower(reshape(hexChars',1,[])));
end

% Preserve original shape
outHashes = reshape(outHashes, size(fixedInputStrings));

if flagOutputs==-1
    assert(strcmp(outHashes,"ce114e4501d2f4e2dcea3e17b546f339"));
    outHashes = nan;
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
if 1 == flag_do_plots
    % if flagSuccessful
    %     fprintf(fid,'Success in finding new name. The next available file name found to be: %s\n', fileName);
    % else
    %     fprintf(fid,'Unable to find a new name. Last tested file (failure) was: %s\n',testName );
    % end
end % Ends the flag_do_plot if statement

if flag_do_debug
    fprintf(1,'ENDING function: %s, in file: %s\n\n',st(1).name,st(1).file); 
end

end % Ends the function


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

