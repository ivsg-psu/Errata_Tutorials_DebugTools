function fcn_DebugTools_replaceStringInDirectory(directoryPath, oldString, newString, varargin)
% fcn_DebugTools_replaceStringInDirectory
% Replaces 'oldString' with 'newString' in all files within
% 'directoryPath'. An optional flag allows the search to skip commented-out
% lines.
%
% FORMAT:
%
%      fcn_DebugTools_replaceStringInDirectory(directoryPath, oldString, newString, (filenameNewString), (flagSkipCommentedLines), (figNum));
%
% INPUTS:
%
%      directoryPath: a string representing the directory to search.
%
%      oldString: the string to replace
%
%      newString: the string that will be substituted into oldString within
%      the text of the file
%
%      (OPTIONAL INPUTS)
%
%      filenameNewString: the string that will be searched for in the file
%      name to ID files to change. Default is newString.
%
%      flagSkipCommentedLines: if set other than 0, will skip commented
%      lines. Default is 0, to include commented lines.
% 
%      figNum: a figure number to plot results. If set to -1, skips any
%      input checking or debugging, no figures will be generated, and sets
%      up code to maximize speed. If set to 1, will query user to confirm
%      that any file changes are acceptable.
%
% OUTPUTS:
%
%      (none)

%
% DEPENDENCIES:
%
%      fcn_DebugTools_checkInputsToFunctions
%
% EXAMPLES:
%
%     See the script: script_test_fcn_DebugTools_replaceStringInDirectory
%     for a full test suite.
%
% This function was written on 2025_09_26 by S. Brennan
% Questions or comments? sbrennan@psu.edu

% REVISION HISTORY:
% 
% 2025_09_26 - sbrennan@psu.edu
% - wrote the code originally, using breakDataIntoLaps as starter
% 
% 2025_11_12 by Sean Brennan, sbrennan@psu.edu
% - Updated debug flags
% - Added figNum input
% - Fixed variable naming for clarity:
% - Changed _LAPS_ global vars to _DEBUGTOOLS_
% 
% 2025_11_13 by Sean Brennan, sbrennan@psu.edu
% - added filenameNewString input
%
% 2025_11_20 by Sean Brennan, sbrennan@psu.edu
% - Formatted revision lists to Markdown format
% - Fixed variable naming for clarity:
%   % * fig_+num to figNum
% - In fcn_DebugTools_replaceStringInDirectory
%   % * Added verification for changing input
%
% 2025_11_23 by Sean Brennan, sbrennan@psu.edu
% - In fcn_DebugTools_replaceStringInDirectory
%   % * Added flag option to specify skip or no-skip on lines for
%   %   % replacements


% TO-DO:
% 
% 2025_11_20 by Sean Brennan, sbrennan@psu.edu
% - fill in to-do items here.

%% Debugging and Input checks

% Check if flag_max_speed set. This occurs if the figNum variable input
% argument (varargin) is given a number of -1, which is not a valid figure
% number.
MAX_NARGIN = 6; % The largest Number of argument inputs to the function
flag_max_speed = 0; % The default. This runs code with all error checking
if (nargin==MAX_NARGIN && isequal(varargin{end},-1))
    flag_do_debug = 0; % Flag to plot the results for debugging
    flag_check_inputs = 0; % Flag to perform input checking
    flag_max_speed = 1;
else
    % Check to see if we are externally setting debug mode to be "on"
    flag_do_debug = 0; % Flag to plot the results for debugging
    flag_check_inputs = 1; % Flag to perform input checking
    MATLABFLAG_DEBUGTOOLS_FLAG_CHECK_INPUTS = getenv("MATLABFLAG_DEBUGTOOLS_FLAG_CHECK_INPUTS");
    MATLABFLAG_DEBUGTOOLS_FLAG_DO_DEBUG = getenv("MATLABFLAG_DEBUGTOOLS_FLAG_DO_DEBUG");
    if ~isempty(MATLABFLAG_DEBUGTOOLS_FLAG_CHECK_INPUTS) && ~isempty(MATLABFLAG_DEBUGTOOLS_FLAG_DO_DEBUG)
        flag_do_debug = str2double(MATLABFLAG_DEBUGTOOLS_FLAG_DO_DEBUG);
        flag_check_inputs  = str2double(MATLABFLAG_DEBUGTOOLS_FLAG_CHECK_INPUTS);
    end
end

% flag_do_debug = 1;

if flag_do_debug % If debugging is on, print on entry/exit to the function
    st = dbstack; %#ok<*UNRCH>
    fprintf(1,'STARTING function: %s, in file: %s\n',st(1).name,st(1).file);
    debug_figNum = 999978; %#ok<NASGU>
else
    debug_figNum = []; %#ok<NASGU>
end

%% check input arguments?
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
if 0==flag_max_speed
    if flag_check_inputs
        % Are there the right number of inputs?
        narginchk(3,MAX_NARGIN);

        % % Check the input_path to be sure it has 2 or 3 columns, minimum 2 rows
        % % or more
        % fcn_DebugTools_checkInputsToFunctions(input_path, '2or3column_of_numbers',[2 3]);
    end
end


% Does user want to specify filenameNewString?
filenameNewString = newString;
if 4 <= nargin
    temp = varargin{1};
    if ~isempty(temp)
        filenameNewString = temp;
    end
end

% Does user want to specify flagSkipCommentedLines?
flagSkipCommentedLines = 0;
if 5 <= nargin
    temp = varargin{2};
    if ~isempty(temp)
        flagSkipCommentedLines = temp;
    end
end

% Does user want to show the plots?
flag_do_plots = 0; % Default is to NOT show plots
if (0==flag_max_speed) && (MAX_NARGIN == nargin) 
    temp = varargin{end};
    if ~isempty(temp) % Did the user NOT give an empty figure number?
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

% Get a list of all files in the directory
fileList = dir(fullfile(directoryPath, '*.*')); % Adjust file extension as needed

% Filter out directories from the list
fileList = fileList(~[fileList.isdir]);

if flag_do_plots
    fprintf('Changing %s to %s: \n', oldString, newString);
end

for ith_file = 1:length(fileList)
    fileName = fileList(ith_file).name;
    if contains(fileName,filenameNewString)

        filePath = fullfile(directoryPath, fileName);
        numChanged = 0;
        numSkipped = 0;
        try
            % Read the entire file content
            fileContent = readlines(filePath);

            % Perform the string replacement
            modifiedContent = fileContent;
            for ith_line = 1:length(fileContent(:,1))
                thisLine = fileContent(ith_line,1);
                thisLineCharacters = char(thisLine);
                if contains(thisLine,oldString)
                    if (thisLineCharacters(1)=='%') && (0~=flagSkipCommentedLines)
                        numSkipped = numSkipped+1;
                    else
                        modifiedContent(ith_line,1) = replace(thisLine, oldString, newString);
                        numChanged = numChanged+1;
                    end
                end
            end

            % If user has set flag_do_plots, confirm change for each file
            flag_keepGoing = 1;
            if flag_do_plots && numChanged>0
                fprintf('Found %.0f instances, skipped %.0f comments in %s\n', numChanged, numSkipped, fileName);
                flag_goodReply = 0;
                flag_keepGoing = 0;
                while 0==flag_goodReply
                    acceptTimeString = input('Is this change acceptable (you MUST type "Y" or "y" to continue)? Y/N [N]:','s');
                    if isempty(acceptTimeString)
                        flag_goodReply = 1;
                    else
                        acceptTimeString = lower(acceptTimeString);
                        if isscalar(acceptTimeString) && (strcmp(acceptTimeString,'n')||strcmp(acceptTimeString,'y'))
                            flag_goodReply = 1;
                        end
                        if strcmpi(acceptTimeString,'y')
                            flag_keepGoing = 1;
                        end

                    end
                end
            end

            if flag_keepGoing==1
                % Write the modified content back to the file
                writelines(modifiedContent, filePath);
            end

            % For debugging - use the line below to put a breakpoint
            if numChanged~=0
                temp = 2; %#ok<NASGU>
            end

            fprintf('Changed %.0f instances, skipped %.0f comments in %s\n', numChanged, numSkipped, fileName);
        catch ME
            warning('Error processing file %s: %s\n', fileName, ME.message);
        end % Ends try
    end % Ends check if file contains
end % Ends for loop

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
    
   % Nothing to plot

    
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


