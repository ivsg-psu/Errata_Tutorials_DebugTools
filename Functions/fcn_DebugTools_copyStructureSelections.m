function toStructureAfterCopy = fcn_DebugTools_copyStructureSelections(...
    toStructure, fromStructure, varargin)
%% fcn_DebugTools_copyStructureSelections
% Given a from and to structure arrays, and a set of indicies in the from
% structure, appends the indicies to the to structure. Allows user to
% specify the number to pick and to randomize the selections within the
% given range.
%
% FORMAT:
%
%      toStructureAfterCopy = fcn_DebugTools_copyStructureSelections(...
%           toStructure, fromStructure, ...
%           (rangeToPickFrom), (numToPick), ... 
%           (flagRandomizeSelections), (figNum))
%
% INPUTS:
%
%      toStructure: the structure array to copy to
%
%      fromStructure: the structure array to copy from
%
%
%      (OPTIONAL INPUTS)
%
%      rangeToPickFrom: the possible indicies to use to copy from. Default
%      is 1:length(fromStructure)
%
%      numToPick: how many to pick from the given range. Default is
%      length(rangeToPickFrom)
%
%      flagRandomizeSelections: a flag (true/false) to randomize the
%      selection. Default is false.
%
%      figNum: a figure number to plot results. If set to -1, skips any
%      input checking or debugging, no figures will be generated, and sets
%      up code to maximize speed. 
%
% OUTPUTS:
%
%      toStructureAfterCopy: the structure after copying is done
%
%
% DEPENDENCIES:
%
%      fcn_DebugTools_checkInputsToFunctions
%
% EXAMPLES:
%
%     See the script: script_test_fcn_DebugTools_copyStructureSelections
%     for a full test suite.
%
% This function was written on 2026_10_19 by S. Brennan
% Questions or comments? sbrennan@psu.edu

% REVISION HISTORY:
%
% 2026_10_19 by Sean Brennan, sbrennan@psu.edu
% - In fcn_DebugTools_copyStructureSelections
%   % * First write of the script
%   % * Used fcn_DebugTools_addStringToEnd as starter

% TO-DO:
% 
% 2026_10_19 by Sean Brennan, sbrennan@psu.edu
% - fill in to-do items here.

%% Debugging and Input checks

% Check if flag_max_speed set. This occurs if the figNum variable input
% argument (varargin) is given a number of -1, which is not a valid figure
% number.
MAX_NARGIN = 6; % The largest Number of argument inputs to the function
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

        % if nargin>=2
        %     % Check the variableTypeString input, make sure it is characters
        %     if ~ischar(variableTypeString)
        %         error('The variableTypeString input must be a character type, for example: ''Path'' ');
        %     end
        % end

    end
end

% Does user want to specify the rangeToPickFrom input?
rangeToPickFrom = 1:length(fromStructure); % Default is full structure
if 3 <= nargin
    temp = varargin{1};
    if ~isempty(temp)
        rangeToPickFrom = temp;
    end
end

% Does user want to specify the numToPick input?
numToPick = length(rangeToPickFrom); % Default is to select them all
if 4 <= nargin
    temp = varargin{2};
    if ~isempty(temp)
        numToPick = temp;
    end
end

% Does user want to specify the flagRandomizeSelections input?
flagRandomizeSelections = false; % Default is to not randomize
if 5 <= nargin
    temp = varargin{3};
    if ~isempty(temp)
        flagRandomizeSelections = temp;
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

toStructureAfterCopy = toStructure;
currentNumberOfToEntries = length(toStructureAfterCopy);
numberToPickFrom = length(rangeToPickFrom);

NproblemsToUse = numToPick; % numProblems;

if flagRandomizeSelections
    selectionsToCopy = randperm(numberToPickFrom, NproblemsToUse);
else
    selectionsToCopy = (1:NproblemsToUse)';
end


fieldNamesSource = fieldnames(fromStructure);
for ith_problem = 1:NproblemsToUse
    thisSelection = selectionsToCopy(ith_problem);
    thisFromIndex = rangeToPickFrom(thisSelection);
	currentNumberOfToEntries = currentNumberOfToEntries+1;

    % Copy fields over
    for k = 1:numel(fieldNamesSource)
        toStructureAfterCopy(currentNumberOfToEntries).(fieldNamesSource{k}) = fromStructure(thisFromIndex).(fieldNamesSource{k});
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
if flag_do_plots

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
