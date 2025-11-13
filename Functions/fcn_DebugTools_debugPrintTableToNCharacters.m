function fcn_DebugTools_debugPrintTableToNCharacters(...
    table_data, header_strings, formatter_strings, N_chars,varargin)
% fcn_DebugTools_debugPrintTableToNCharacters
% Given a matrix of data, prints the data in user-specified width to the
% workspace.
%
% FORMAT:
%
%      fcn_DebugTools_debugPrintTableToNCharacters(...
%         table_data, header_strings, formatter_strings, N_chars, (figNum))
%
% INPUTS:
%
%      table_data: a matrix of N rows, M columns, containing data to be
%      printed
%
%      header_strings: a cell array, M long, containing characters to be
%      printed as headers
%
%      formatter_strings: a cell array, M long, containing the print
%      specification for each column
%
%      N_chars: an integeter saying how long the output string should be if
%      columns have constant spacing, or an array of M integers with each
%      integer corresponding to the print with of the respective column.
%
%      (OPTIONAL INPUTS)
%
%      figNum: a figure number to plot results. If set to -1, skips any
%      input checking or debugging, no figures will be generated, and sets
%      up code to maximize speed. 
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
% See the script: script_test_fcn_DebugTools_debugPrintTableToNCharacters
% for a full test suite.
%
% This function was written on 2023_01_17 by S. Brennan.
% Questions or comments? sbrennan@psu.edu

% Revision history:
% 2023_01_17:
% - first write of the code
% 2025_11_12 by Sean Brennan, sbrennan@psu.edu
% - Updated debug flags
% - Added figNum input
% - Fixed variable naming for clarity:
%   % * fig_num to figNum

% TO DO
% -- (none)

%% Debugging and Input checks

% Check if flag_max_speed set. This occurs if the figNum variable input
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
        narginchk(4,MAX_NARGIN);

        % Check the table_data input
        %fcn_DebugTools_checkInputsToFunctions(table_data, '_of_chars');

        % Check the header_strings input
        %fcn_DebugTools_checkInputsToFunctions(header_strings, '_of_chars');

        % Check the N_chars input
        fcn_DebugTools_checkInputsToFunctions(N_chars, '_of_integers');

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

N_header_strings = length(header_strings);
N_data_rows = length(table_data(:,1));

% Print the header
fprintf(1,'\n\n');
for ith_header = 1:N_header_strings
    header_str = header_strings{ith_header};
    if length(N_chars)==N_header_strings
         fixed_header_str = fcn_DebugTools_debugPrintStringToNCharacters(header_str,N_chars(ith_header));
    else
        fixed_header_str = fcn_DebugTools_debugPrintStringToNCharacters(header_str,N_chars);
    end
    fprintf(1,'%s ', fixed_header_str);
end
fprintf(1,'\n');

% Print the results
if ~isempty(table_data)
    for ith_row =1:N_data_rows
        for jth_col = 1:N_header_strings
            data_str = sprintf(formatter_strings{jth_col},table_data(ith_row,jth_col));
            if length(N_chars)==N_header_strings
                fixed_data_str = fcn_DebugTools_debugPrintStringToNCharacters(data_str,N_chars(jth_col));
            else
                fixed_data_str = fcn_DebugTools_debugPrintStringToNCharacters(data_str,N_chars);
            end
            fprintf(1,'%s ',...
                fixed_data_str);
        end % ends looping through columns
        fprintf(1,'\n');
        
    end % Ends looping down the rows
end % Ends check to see if table isempty



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
    %     figure(figNum);
    %     clf;
    %     hold on;
    %     grid on;
    %
    %        
    
end % Ends the flag_do_plot if statement

if flag_do_debug
    fprintf(1,'ENDING function: %s, in file: %s\n\n',st(1).name,st(1).file); 
end

end % Ends the function

