function [flagSuccessful,cmdout] = fcn_DebugTools_fileTouch(fileNameString, varargin)
%% fcn_DebugTools_fileTouch
% Given a file name, this tool "touches" the file similar such that either
% the file is created or the file, if it exists, has its date updated. The
% intent is to emulate the "touch" command in UNIX.
%
% FORMAT:
%
%      flagSuccessful = fcn_DebugTools_fileTouch(fileNameString, (fid))
%
% INPUTS:
%
%      fileNameString: a string containing the name of the file
%
%      (OPTIONAL INPUTS)
%
%      fid: a FID number to print results. If set to -1, skips any
%      input checking or debugging, no prints will be generated, and sets
%      up code to maximize speed. Default is fid = 1, which prints to the
%      console.
%
% OUTPUTS:
%
%      flagSuccessful: returns output of any errors as non-zero integer
%
%      cmdout: the system output for any system commands
%
% DEPENDENCIES:
%
%      fcn_DebugTools_checkInputsToFunctions
%
% EXAMPLES:
%
% See the script: script_test_fcn_DebugTools_fileTouch
% for a full test suite.
%
% This function was written on 2025_12_18 by S. Brennan.
% Questions or comments? sbrennan@psu.edu

% REVISION HISTORY:
%
% 2025_12_18 - S. Brennan
% - In fcn_DebugTools_fileTouch
%   % * first write of the function
%   %   % used fcn_DebugTools_debug+PrintStringToNCharacters as a starter

% TO-DO:
% 2025_12_18 by Sean Brennan, sbrennan@psu.edu
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

        % Check the fileNameString input
        fcn_DebugTools_checkInputsToFunctions(fileNameString, '_of_char_strings');

    end
end
%
% % Does user want to specify NdigitsInCount?
% NdigitsInCount = 4; % Default is 4
% if (3 <= nargin)
%     temp = varargin{1};
%     if ~isempty(temp)
%         NdigitsInCount = temp;
%         % Check the N_chars input
%         fcn_DebugTools_checkInputsToFunctions(NdigitsInCount, 'strictlypositive_1column_of_integers',[1 1]);
%     end
% end
%
% % Does user want to specify typeExtension?
% fileExtensionString = '.mat'; % Default
% if (4 <= nargin)
%     temp = varargin{2};
%     if ~isempty(temp)
%         fileExtensionString = temp;
%     end
% end

% Check to see if user specifies fid?
flag_do_plots = 0; % Default is to NOT show plots
fid = 1; % Default is to print to the console
if (0==flag_max_speed) && (MAX_NARGIN == nargin)
    temp = varargin{end};
    if ~isempty(temp)
        fid = temp;
        flag_do_plots = 1;
    end
end


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

if ~exist(fileNameString, 'file')
    % Open then close the file. This works in all system environments
    [fileID,errmsg] = fopen(fileNameString, 'w');
    if isempty(errmsg)
        flagSuccessful = true;
    else
        flagSuccessful = false;
    end
    cmdout = errmsg;
    if flagSuccessful
        status = fclose(fileID);
        if 0~=status
            flagSuccessful = false;
        end
    end

else
    % File exists. Depending on the environment, need to "touch" it
    if ispc
        sysCommand = cat(2,'copy /b ',fileNameString,'+,, ',fileNameString);
        [status,cmdout] = system(sysCommand);
    elseif isunix || ismac
        [status,cmdout] = system(cat(2,'touch ',fileNameString));
    else
        status = 1;
        cmdout = sprintf('Unknown operating system encountered. Cannot touch file: %s\n',fileNameString);
    end
    if 0==status
        flagSuccessful = true;
    else
        flagSuccessful = false;
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
if 1 == flag_do_plots
    if flagSuccessful
        fprintf(fid,'Success in touching file:\n\t%s\n', fileNameString);
    else
        fprintf(fid,'Failure in touching file:\n\t%s\n cmdout is: %s\n',fileNameString, cmdout);
    end
end % Ends the flag_do_plot if statement

if flag_do_debug
    fprintf(1,'ENDING function: %s, in file: %s\n\n',st(1).name,st(1).file);
end

end % Ends the function

