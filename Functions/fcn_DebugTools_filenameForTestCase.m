function [fileName, flagSuccessful] = fcn_DebugTools_filenameForTestCase(directoryToCheck, filePrefixString, varargin)
%% fcn_DebugTools_filenameForTestCase
% Given a file name prefix and a target folder, finds the next unused file
% name such that no existing files are overwritten. This is useful to
% capture and save data to a file for debugging when errors are generated.
% See the test script for an example implementation.
%
% FORMAT:
%
%      [fileName, flagSuccessful] = fcn_DebugTools_filenameForTestCase(...
%         directoryToCheck, filePrefixString, ...
%         (NdigitsInCount), (fileExtensionString), (fid))
%
% INPUTS:
%
%      directoryToCheck: a string containing the name of the directory to
%      check. For example: directoryToCheck = fullfile(cd,'Data')
% 
%      filePrefixString: a string containing the first part of the filename,
%      for example: 'ExampleData_fitROSTime2GPSTime_Case9'
%
%      (OPTIONAL INPUTS)
% 
%      NdigitsInCount: the number of digits in the case countup index that
%      occur after the prefix string. The default is 4. Thus, the example
%      prefix, 'ExampleData_fitROSTime2GPSTime_Case9' with 4 digits would
%      range in filenames from: 
%           ExampleData_fitROSTime2GPSTime_Case90001 
%      to
%           ExampleData_fitROSTime2GPSTime_Case99999
%
%      fileExtensionString: a string listing the file extension, for example
%      '.mat' (this is the default).
%
%      fid: a FID number to print results. If set to -1, skips any
%      input checking or debugging, no prints will be generated, and sets
%      up code to maximize speed. Default is fid = 1, which prints to the
%      console.
%
% OUTPUTS:
%
%      fileName: a string of the filename to use that does not conflict
%      with any of the existing files in the directory, that is one integer
%      counting upward higher than the highest file found with the same
%      prefix string and extension type.
%
%      flagSuccessful: returns true if the file was successfully found,
%      false otherwise
%
% DEPENDENCIES:
%
%      fcn_DebugTools_checkInputsToFunctions
%
% EXAMPLES:
%
% See the script: script_test_fcn_DebugTools_filenameForTestCase
% for a full test suite.
%
% This function was written on 2025_12_18 by S. Brennan.
% Questions or comments? sbrennan@psu.edu

% REVISION HISTORY:
% 
% 2025_12_18 - S. Brennan
% - first write of the function using
%   % fcn_DebugTools_debug+PrintStringToNCharacters as a starter

% TO-DO:
% 2025_12_18 by Sean Brennan, sbrennan@psu.edu
% - fill in to-do items here.

%% Debugging and Input checks

% Check if flag_max_speed set. This occurs if the fid variable input
% argument (varargin) is given a number of -1, which is not a valid figure
% number.
MAX_NARGIN = 5; % The largest Number of argument inputs to the function
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
        narginchk(2,MAX_NARGIN);

        % Check the directoryToCheck input
        fcn_DebugTools_checkInputsToFunctions(directoryToCheck, 'DoesDirectoryExist');

        % Check the filePrefixString input
        fcn_DebugTools_checkInputsToFunctions(filePrefixString, '_of_char_strings');

    end
end

% Does user want to specify NdigitsInCount?
NdigitsInCount = 4; % Default is 4
if (3 <= nargin)
    temp = varargin{1};
    if ~isempty(temp)
        NdigitsInCount = temp;
        % Check the N_chars input
        fcn_DebugTools_checkInputsToFunctions(NdigitsInCount, 'strictlypositive_1column_of_integers',[1 1]);
    end
end

% Does user want to specify typeExtension?
fileExtensionString = '.mat'; % Default
if (4 <= nargin)
    temp = varargin{2};
    if ~isempty(temp)
        fileExtensionString = temp;
    end
end

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

fileIndex = 1;
flagFileFound = 1;
while 1==flagFileFound
    % Produce a formatting string. It will have a format like: %04d if for
    % 4 digits, or %07d for 7 digits
    formattingString = cat(2,'%0',sprintf('%.0d',NdigitsInCount),'d');

    % Produce a string that stores the number case. For example, for 4
    % digits, this produces a number such as 0001 up to 9999
    caseString = sprintf(formattingString,fileIndex);
    fileOnlyName = cat(2,filePrefixString,caseString,fileExtensionString);
    testName = fullfile(directoryToCheck,fileOnlyName);
    if exist(testName,'file')
        fileIndex = fileIndex+1;
    else
        fileName = testName;
        flagFileFound = 0;
        flagSuccessful = true;
    end

    % Is the count too high?
    if fileIndex>=(10^NdigitsInCount)
        flagFileFound = 0;
        flagSuccessful = false;
        fileName = [];
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
        fprintf(fid,'Success in finding new name. The next available file name found to be: %s\n', fileName);
    else
        fprintf(fid,'Unable to find a new name. Last tested file (failure) was: %s\n',testName );
    end
end % Ends the flag_do_plot if statement

if flag_do_debug
    fprintf(1,'ENDING function: %s, in file: %s\n\n',st(1).name,st(1).file); 
end

end % Ends the function

