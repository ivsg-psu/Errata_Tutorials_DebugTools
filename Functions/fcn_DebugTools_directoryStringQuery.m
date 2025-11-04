function flagsStringWasFoundInFiles = ...
    fcn_DebugTools_directoryStringQuery(fileList, queryString, varargin)
% fcn_DebugTools_directoryStringQuery
% Searches the given fileList for a queryString, returning 1 if the string
% is found in the file, 0 otherwise.
%
% FORMAT:
%
%      fcn_DebugTools_directoryStringQuery(fileList, queryString,(fig_num));
%
% INPUTS:
%
%      fileList: the output of a directory command, a structure containing
%      the files to search
%
%      queryString: the string to search
%
%      (OPTIONAL INPUTS)
%
%     fig_num: a figure number to plot results. If set to -1, skips any
%     input checking or debugging, no figures will be generated, and sets
%     up code to maximize speed. As well, if given, this forces the
%     variable types to be displayed as output and as well makes the input
%     check process verbose
%
%
% OUTPUTS:
%
%     flagsStringWasFoundInFiles: for each of the N entries in fileList,
%     returns logical 1 if the query string is found, 0 if not.
%
% DEPENDENCIES:
%
%      fcn_DebugTools_checkInputsToFunctions
%
% EXAMPLES:
%
% % Get a list of all files in the directory
% fileList = dir(fileList); % Adjust file extension as needed
% 
% % Filter out directories from the list
% fileList = fileList(~[fileList.isdir]);
%
%     See the script: script_test_fcn_DebugTools_directoryStringQuery
%     for a full test suite.
%
% This function was written on 2025_11_04 by S. Brennan
% Questions or comments? sbrennan@psu.edu

% Revision history:
% 2025_11_04 - sbrennan@psu.edu
% -- wrote the code originally, using fcn_DebugTools_replaceStringInDirectory as starter

% TO-DO
% (none)

%% Debugging and Input checks

% Check if flag_max_speed set. This occurs if the fig_num variable input
% argument (varargin) is given a number of -1, which is not a valid figure
% number.
MAX_NARGIN = 3; % The largest Number of argument inputs to the function
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
    debug_fig_num = 999978; %#ok<NASGU>
else
    debug_fig_num = []; %#ok<NASGU>
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
        narginchk(2,MAX_NARGIN);

        % Check the fileList to be sure it is a directory structure
        temp = dir;
        fcn_DebugTools_checkInputsToFunctions(fileList, 'likestructure',temp);

    end
end


% Does user want to show the plots?
flag_do_plots = 0; % Default is to NOT show plots
if (0==flag_max_speed) && (MAX_NARGIN == nargin) 
    temp = varargin{end};
    if ~isempty(temp) % Did the user NOT give an empty figure number?
        fig_num = temp; %#ok<NASGU>
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

Nfiles = length(fileList);
flagsStringWasFoundInFiles = false(Nfiles,1);

for ith_file = 1:Nfiles
    fileName = fileList(ith_file).name;
    fileFolder = fileList(ith_file).folder;
    fileFullNameAndPath = fullfile(fileFolder, fileName);
    
    % Read the entire file content
    fileContent = readlines(fileFullNameAndPath);

    % Check each line
    for ith_line = 1:length(fileContent(:,1))
        thisLine = fileContent(ith_line,1);
        thisLineCharacters = char(thisLine);
        if contains(thisLine,queryString)
            flagsStringWasFoundInFiles(ith_file,1) = true;
            if thisLineCharacters(1)~='%'
                % Do nothing
            else
                % Do nothing
            end
            break; % No need to continue within line-by-line for loop
        end % Ends check if file contains
    end % Ends for loop through lines in each file
end % Ends for loop through files

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

    % Report results

    fileNames = {fileList.name}';
    cellArrayHeaders = {'m-filename                                                         ', 'string found?'};
    cellFlagFound = mat2cell(flagsStringWasFoundInFiles,ones(1,length(fileNames)));
    cellArrayValues = [fileNames, cellFlagFound];

    % Call the function
    fid = 1;
    fcn_DebugTools_printNumeredDirectoryList(fileList, cellArrayHeaders, cellArrayValues, ([]), (fid))
   
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


