function UTCdatetime = fcn_DebugTools_timeQueryNTPserver(server, varargin)
%% fcn_DebugTools_timeQueryNTPserver
% Queries NTP server and returns the datetime in UTC
%
% FORMAT:
%
%      UTCdatetime = fcn_DebugTools_timeQueryNTPserver(server, (port), (timeoutSecs), (figNum))
%
% INPUTS:
%
%      server: a char array listing which server to test, example: 'pool.ntp.org'
%
%      (OPTIONAL INPUTS)
%
%      port: an integer listing the port to use. Default is: 123
%
%      timeoutSecs: a positive number listing how long to wait to timeout,
%      in seconds. Default is: 3
%
%      figNum: a figure number to plot results. If set to -1, skips any
%      input checking or debugging, no figures will be generated, and sets
%      up code to maximize speed. 
%
% OUTPUTS:
%
%      UTCdatetime: the UTC time returned from the server, in datetime
%      format
%
% DEPENDENCIES:
%
%      fcn_DebugTools_checkInputsToFunctions
%
% EXAMPLES:
%
%     See the script: script_test_fcn_DebugTools_timeQueryNTPserver
%     for a full test suite.
%
% This function was written on 2026_01_19 by S. Brennan
% Questions or comments? sbrennan@psu.edu

% REVISION HISTORY:
% 
% 2026_01_19 by Sean Brennan, sbrennan@psu.edu
% - Wrote the code originally
%
% 2026_02_01 by Sean Brennan, sbrennan@psu.edu
% - In fcn_DebugTools_timeQueryNTPserver
%   % * Fixed wrong capitalization in function name

% TO-DO:
% 2025_11_20 by Sean Brennan, sbrennan@psu.edu
% - Add items here

%% Debugging and Input checks

% Check if flag_max_speed set. This occurs if the figNum variable input
% argument (varargin) is given a number of -1, which is not a valid figure
% number.
MAX_NARGIN = 4; % The largest Number of argument inputs to the function
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

        % Check the server to be sure it is a text style
        fcn_DebugTools_checkInputsToFunctions(server, '_of_char_strings');

    end
end

% Does user want to specify the port input?
port = 123; % Default is 123
if 2 <= nargin
    temp = varargin{1};
    if ~isempty(temp)
        port = temp;
    end
end

% Does user want to specify the timeoutSecs input?
timeoutSecs = 3; % Default is 3 seconds
if 3 <= nargin
    temp = varargin{2};
    if ~isempty(temp)
        timeoutSecs = temp;
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

% Build 48-byte NTP request: LI=0 VN=4 Mode=3 (client) -> 0x23
req = uint8(zeros(48,1));
req(1) = uint8(0x23);

% Java UDP socket (portable across platforms)
import java.net.DatagramPacket java.net.DatagramSocket java.net.InetAddress
addr = InetAddress.getByName(server);
sock = DatagramSocket();
sock.setSoTimeout(int32(ceil(timeoutSecs*1000)));

try
    % send request
    outPacket = DatagramPacket(req, numel(req), addr, int32(port));
    sock.send(outPacket);

    % receive response (48 bytes)
    buffer = javaArray('java.lang.Byte', 48); %#ok<NASGU>
    recvBuf = zeros(48,1,'int8');
    respPacket = DatagramPacket(recvBuf, int32(48));
    sock.receive(respPacket);
    data = typecast(int8(respPacket.getData()), 'uint8');  % 1x48 uint8

    % Transmit Timestamp is bytes 40..47 (1-based indexing)
    ts_sec = uint64(data(41)) * 2^24 + uint64(data(42)) * 2^16 + ...
             uint64(data(43)) * 2^8  + uint64(data(44));
    ts_frac = uint64(data(45)) * 2^24 + uint64(data(46)) * 2^16 + ...
              uint64(data(47)) * 2^8  + uint64(data(48));
    ntpSeconds = double(ts_sec) + double(ts_frac) / 2^32;

    % NTP epoch starts 1900-01-01; convert to POSIX time by subtracting offset
    % offset = seconds between 1900-01-01 and 1970-01-01 = 2208988800
    posixSeconds = ntpSeconds - 2208988800;
    UTCdatetime = datetime(posixSeconds, 'ConvertFrom', 'posixtime', 'TimeZone', 'UTC');
catch ME
    sock.close();
    rethrow(ME);
end

sock.close();

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
    disp(UTCdatetime)
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
