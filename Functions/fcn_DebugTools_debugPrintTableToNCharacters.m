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
%      printed. If an empty entry is given, no table is printed.
%
%      header_strings: a cell array, M long, containing characters to be
%      printed as headers. If an empty entry is given, no header is
%      printed.
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
%      fid: a FID number to print results. If set to -1, skips any
%      input checking or debugging, no prints will be generated, and sets
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

% REVISION HISTORY: 
% 
% 2023_01_17 by Sean Brennan, sbrennan@psu.edu
% - first write of the code
% 
% 2025_11_12 by Sean Brennan, sbrennan@psu.edu
% - Updated debug flags
% - Added figNum input
% - Fixed variable naming for clarity:
%
% 2025_11_20 by Sean Brennan, sbrennan@psu.edu
% - Formatted revision lists to Markdown format
% - Fixed variable naming for clarity:
%   % * fig_+num to figNum
%
% 2025_12_17 by Sean Brennan, sbrennan@psu.edu
% - Changed figNum input to FID, to allow prints to files
% - Fixed issue where extra line feeds were being added above table
% - Allow empty headers and table data, causing these prints to be skipped
% - Allow multi-type formatting, specified by row memberships


% TO-DO:
% 2025_11_20 by Sean Brennan, sbrennan@psu.edu
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
        narginchk(4,MAX_NARGIN);

        % Check the table_data input
        %fcn_DebugTools_checkInputsToFunctions(table_data, '_of_chars');

        % Check the header_strings input
        %fcn_DebugTools_checkInputsToFunctions(header_strings, '_of_chars');

        % Check the N_chars input
        fcn_DebugTools_checkInputsToFunctions(N_chars, '_of_integers');

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

N_header_strings = length(header_strings);
N_data_rows = size(table_data,1);
N_data_cols = size(table_data,2);
N_formats = size(formatter_strings,1);

% Fill in the formatting of numeric and color values
numericformatter_strings = cell(N_formats, N_data_cols); 
colorformatter_strings   = cell(N_formats, N_data_cols);
row_memberships   = cell(N_formats, 1);

% Fill in the formats as a cell array. Note that the last column is the
% row membership
for jth_format = 1:N_formats
    for ith_format_string = 1:N_data_cols
        thisFormatString = formatter_strings{jth_format, ith_format_string};
        if strcmp(thisFormatString(1),'%')
            numericformatter_strings{jth_format, ith_format_string} = thisFormatString;
            colorformatter_strings{jth_format, ith_format_string} = [];
        else
            % A color designation has been given
            numericformatter_strings{jth_format, ith_format_string} = cat(2,'%',extractAfter(thisFormatString,'%'));
            colorformatter_strings{jth_format, ith_format_string} = extractBefore(thisFormatString,' %');
        end
    end

    % Check to see if row membership has been specified
    if size(formatter_strings,2)==(N_data_cols+1)
        row_memberships{jth_format} = formatter_strings{jth_format,N_data_cols+1};
    end
end

% Print the header
if ~isempty(header_strings)
    for ith_header = 1:N_header_strings
        header_str = header_strings{ith_header};

        % Do each of the columns have different widths?
        if length(N_chars)==N_header_strings
            fixed_header_str = fcn_DebugTools_debugPrintStringToNCharacters(header_str,N_chars(ith_header));
        else
            fixed_header_str = fcn_DebugTools_debugPrintStringToNCharacters(header_str,N_chars);
        end
        
        fprintf(fid,'%s ', fixed_header_str);
    end
    fprintf(fid,'\n');
end

% Print the results
if ~isempty(table_data)
    for ith_row =1:N_data_rows

        % Which formatting row to use for formatting? This is specified by
        % the membership column, which is saved in the "row_memberships"
        % cell array. We search through this to see if the current row
        % matches anything listed.
        membershipToUse = 1;
        for ith_membership = 1:length(row_memberships)
            theseMembers = row_memberships{ith_membership};
            if ~isempty(theseMembers)
                if ismember(ith_row,theseMembers)
                    membershipToUse = ith_membership;
                end
            end
        end

        for jth_col = 1:N_data_cols
            data_str = sprintf(numericformatter_strings{membershipToUse, jth_col},table_data(ith_row,jth_col));

            % Do each of the columns have different widths?
            if length(N_chars)==N_data_cols
                fixed_data_str = fcn_DebugTools_debugPrintStringToNCharacters(data_str,N_chars(jth_col));
            else
                fixed_data_str = fcn_DebugTools_debugPrintStringToNCharacters(data_str,N_chars);
            end

            if 1==fid && ~isempty(colorformatter_strings{membershipToUse, jth_col})
                fcn_DebugTools_cprintf(colorformatter_strings{membershipToUse, jth_col},'%s ',fixed_data_str)
            else
                fprintf(fid,'%s ',fixed_data_str);
            end
        end % ends looping through columns
        fprintf(fid,'\n');
        
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

