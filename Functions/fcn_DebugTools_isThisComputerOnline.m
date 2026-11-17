function [isOnline] = fcn_DebugTools_isThisComputerOnline(varargin)

% fcn_DebugTools_isThisComputerOnline
% returns true if this computer is online, false if not. It does 3 layers of tests:
%  * Checks using java "isreachable" command to the URL.
%  * If this does not work, checks using the "webread" command with a
%    secure "https:\\" prefix
%  * If this does not work, checks using the "webread" command with a
%    unsecure "http:\\" prefix
%  * If this does not work, checks using a system-level "ping" command to
%    '8.8.8.8', which is the Google Public DNS (Domain Name Server) 
% If all these fail, it marks the computer as being offline. If any pass,
% it markes the computer as being online.
%
% FORMAT:
%
%     [isOnline] = fcn_DebugTools_isThisComputerOnline((url), (timeout), (figNum))
%
% INPUTS:
%
%      (none)
%
%      (OPTIONAL INPUTS)
%
%      url: if given as a string, the URL to use for testing. Default is
%      'https://github.com'.
%
%      timeout: the timeout in milliseconds to use. Default is 1000 ms.
%
%      figNum: a figure number to plot results. If set to -1, skips any
%      input checking or debugging, no figures will be generated, and sets
%      up code to maximize speed. 
%
% OUTPUTS:
%
%      isOnline: a logical value that is true if the computer is online,
%      false if not 
%
% DEPENDENCIES:
%
%      fcn_DebugTools_checkInputsToFunctions
%
% EXAMPLES:
%
%     See the script: script_test_fcn_DebugTools_isThisComputerOnline
%     for a full test suite.
%
% This function was written on 2026_10_07 by S. Brennan
% Questions or comments? sbrennan@psu.edu

% REVISION HISTORY:
% 
% 2026_10_07 by Sean Brennan, sbrennan@psu.edu
% - In fcn_DebugTools_isThisComputerOnline
%   * Wrote the code originally
%   * Used fcn_DebugTools_is+OnlineFromThisComputerAndUser as starter
% 
% 2026_11_16 by Sean Brennan, sbrennan@psu.edu
% - In fcn_DebugTools_isThisComputerOnline
%   * Changed default URL to Google's DNS to avoid issues with MacOS
% 
% 2026_11_17 by Sean Brennan, sbrennan@psu.edu
% - In fcn_DebugTools_isThisComputerOnline
%   * Added a multi-tier test to work across system OS installs including
%   % - Webread with secure URL
%   % - Webread with unsecure URL
%   % - Ping to googles DNS

% TO-DO:
% 2026_10_07 by Sean Brennan, sbrennan@psu.edu
% - Add to-do items here

%% Debugging and Input checks

% Check if flag_max_speed set. This occurs if the figNum variable input
% argument (varargin) is given a number of -1, which is not a valid figure
% number.
MAX_NARGIN = 3; % The largest Number of argument inputs to the function
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
        narginchk(0,MAX_NARGIN);

        % if nargin>=2
        %     % Check the variableTypeString input, make sure it is characters
        %     if ~ischar(variableTypeString)
        %         error('The variableTypeString input must be a character type, for example: ''Path'' ');
        %     end
        % end

    end
end

% Does user want to specify url?
url = 'google.com';
% url = 'github.com';
if 1 <= nargin
    input = varargin{1};
    if ~isempty(input)
		url = input;
    end
end

% Does user want to specify timeout?
timeout = 1000;
if 2 <= nargin
    input = varargin{2};
    if ~isempty(input)
		timeout = input;
    end
end


% Check to see if user specifies figNum?
flag_do_plots = 0; % Default is to NOT show plots
if (0==flag_max_speed) && (MAX_NARGIN == nargin) 
    temp = varargin{end};
    if ~isempty(temp)
        figNum = temp; %#ok<NASGU>
        flag_do_plots = 1;
    end
end


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

% Initialize variables
isOnline = false;
isOnline_JavaIsReachable = -1; %#ok<NASGU>
isOnline_webreadSecure = -1;
isOnline_webreadUnsecure = -1;
isOnline_ping = -1;


try
	addr = java.net.InetAddress.getByName(url);
	isOnline_JavaIsReachable = addr.isReachable(timeout); % timeout ms
catch
	isOnline_JavaIsReachable = false;
end

isOnline = isOnline || isOnline_JavaIsReachable;

% Check again, using webread secure
if ~isOnline
	try

		options = weboptions('Timeout', timeout);

		%  webread('https://github.com', options);
		webread(cat(2,'https://',url), options);

		isOnline_webreadSecure = true;

	catch

		isOnline_webreadSecure = false;

	end
	
	isOnline = isOnline || isOnline_webreadSecure;

end


% Check again, using webread unsecure
if ~isOnline
	try

		options = weboptions('Timeout', timeout);

		%  webread('https://github.com', options);
		webread(cat(2,'http://',url), options);

		isOnline_webreadUnsecure = true;

	catch

		isOnline_webreadUnsecure = false;

	end

	isOnline = isOnline || isOnline_webreadUnsecure;

end


% Check again, using system-level ping - this could work if the browser is
% not available
if ~isOnline
	try
		systemCommand = sprintf('ping -n 1 -w %d %s', timeout, '8.8.8.8');
		[pingStatus, pingOutput] = system(systemCommand);
		if pingStatus==1
			isOnline_ping = false;
		else
			isOnline_ping = ~contains(pingOutput,'Request timed out');
		end
	catch
		isOnline_ping = false;
	end

	isOnline = isOnline || isOnline_ping;

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
if flag_do_plots

    % Print results
	fprintf(1,'Test results for online verification: \n');
	fprintf(1,'\t isReachable method (Java) - online?: \t%s\n', fcn_INTERNAL_printOnlineStatus(isOnline_JavaIsReachable));
	fprintf(1,'\t webread secure method - online?:     \t%s\n', fcn_INTERNAL_printOnlineStatus(isOnline_webreadSecure));
	fprintf(1,'\t webread unsecure method - online?:   \t%s\n', fcn_INTERNAL_printOnlineStatus(isOnline_webreadUnsecure));
	fprintf(1,'\t ping method - online?:               \t%s\n', fcn_INTERNAL_printOnlineStatus(isOnline_ping));
	fprintf(1,'Overall, is computer online?: \t\t\t%s\n',    fcn_INTERNAL_printOnlineStatus(isOnline));

end

if flag_do_debug
    fprintf(1,'ENDING function: %s, in file: %s\n\n',st(1).name,st(1).file);
end

end % Ends isThisComputerOnline function




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

%% fcn_INTERNAL_printOnlineStatus
function statusString = fcn_INTERNAL_printOnlineStatus(status)
if -1==status
	statusString = 'Untested';
elseif 0==status
	statusString = 'Offline';
elseif 1==status
	statusString = ' Online';
else
	error('Unknown status encountered: %.0d',status);
end
end % Ends fcn_INTERNAL_printOnlineStatus (used in isThisComputerOnline)



