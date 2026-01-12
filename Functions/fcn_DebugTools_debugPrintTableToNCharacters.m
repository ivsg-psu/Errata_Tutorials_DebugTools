function fcn_DebugTools_debugPrintTableToNCharacters(...
    table_data, header_strings, formatter_strings, numChars,varargin)
% fcn_DebugTools_debugPrintTableToNCharacters
% Given a matrix of data, prints the data in user-specified width to the
% workspace.
%
% FORMAT:
%
%      fcn_DebugTools_debugPrintTableToNCharacters(...
%         table_data, header_strings, formatter_strings, numChars, (figNum))
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
%      specification for each column. NOTE: a special case for %X.Xf
%      formatting, putting "a" at the end, aligns the data at the decimal
%      point for this column. For example: %10.4fa as an alignment string
%      will print 4 values after the decimal place, and 5 spaces minimum in
%      front of the decimal point so that the total characters will be
%      5+1+4 = 10, since the decimal point takes one character.
%
%      numChars: an integeter saying how long the output string should be if
%      columns have constant spacing, or an array of M integers with each
%      integer corresponding to the print with of the respective column. If
%      a non-positive value is given (0 or negative), the function
%      calculates the integer for the respective column using 0 padding for
%      0, 1 space padding for -1, 2 space padding for -2, etc. Note: this
%      printing method can be slow as it needs to test print every value to
%      find the necessary width
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
%
% 2026_01_11 by Sean Brennan, sbrennan@psu.edu
% - Updated the N_chars input to be numChars for better readability
% - Allow negative values for numChars to auto-calculate spacing needed
% - Allow autoalign at decimal points for floats, e.g. '%10.2fa' format
% - Allow cell array inputs to allow printing of strings alongside numeric
% - Fixed bug where fcn_DebugTools_cprintf was missing sprintf within,
%   % causing it not to print when color specifiers given

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

        % Check the numChars input
        fcn_DebugTools_checkInputsToFunctions(numChars, '_of_integers');

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

% Check to see if any of the formatting strings are "alignment strings"
isAlignedThisFormatString = false(1,N_header_strings);
for ith_header = 1:N_header_strings
	thisFormat = formatter_strings{1,ith_header};
	if length(thisFormat)>3 && strcmp(thisFormat(end-1:end),'fa')
		isAlignedThisFormatString(ith_header) = true;
	end
end


% Check the numChars input to see if we need to autocalculate column width
% sizes. This occurs when the user gives a 0 or negative number as the
% column width, as listed in the numChars array. 
if any(numChars<1)
	% If enter into here, the user is requesting auto-calculated column
	% widths somewhere. To find what column width to use, first print a
	% test string using the format specification.


	% Find added padding for each column
	addedPadding = nan(1,N_header_strings);
	for ith_header = 1:N_header_strings
		if numChars(ith_header)>0
			addedPadding(ith_header) = 1; % Define padding for column widths - note: this is never used
		else
			addedPadding(ith_header) = -1*numChars(ith_header);
		end
	end

	% Loop through each column, checking to see width required to print with
	% each formatter_strings entry
	N_charsData = nan(1,N_header_strings);
	for jth_row = 1:N_data_rows
		
		% What is the data size of this row?
		N_charsThisData = nan(1,N_header_strings);
		for ith_header = 1:N_header_strings
			if iscell(table_data)
				thisData = table_data{jth_row, ith_header};
			else
				thisData = table_data(jth_row,ith_header);
			end
			testString = sprintf(formatter_strings{1,ith_header}, thisData);
			N_charsThisData(ith_header) = length(testString) + addedPadding(ith_header); % Store the width required for the current column
		end

		% Keep the maximum value
		N_charsData = max([N_charsData; N_charsThisData],[],1);
	end

	% Calculate the required width for each column based on the header strings
	N_charsHeaderRaw = cellfun(@(x) size(x,2), header_strings); % Initialize with minimum width
	N_charsHeader = N_charsHeaderRaw+addedPadding;

	numCharsAutocalculated = max([N_charsHeader;N_charsData],[],1);

	% Update the character counts ONLY for the requested columns
	numChars(numChars<1) = numCharsAutocalculated(numChars<1);
end


%%%%% 
% If aligning at decimal place, need to auto-update the print specification
% so that the leading terms on fprint are correct length
if any(isAlignedThisFormatString)
	formatsToCheck = find(isAlignedThisFormatString);
	for formatRows = 1:size(formatter_strings,1)
		for ith_format = 1:length(formatsToCheck)
			thisFormatIndex = formatsToCheck(ith_format);
			thisFormat = formatter_strings{formatRows, thisFormatIndex};
			prefixString = extractBefore(thisFormat,'%');
			thisWidth  = extractBetween(thisFormat,'%','.');
			remainderString = extractAfter(thisFormat,'.');
			longestEntryThisColumn = N_charsData(thisFormatIndex) - addedPadding(thisFormatIndex);
			if isempty(thisWidth{1})
				newWidth = longestEntryThisColumn;
			else
				thisWidthNumber = str2double(thisWidth{1});
				if thisWidthNumber<longestEntryThisColumn
					newWidth = longestEntryThisColumn;
				else
					newWidth = thisWidthNumber;
				end
			end
			formatter_strings{formatRows,thisFormatIndex} = sprintf('%s%%%.0f.%s', prefixString, newWidth, remainderString(1:end-1));
		end
	end
end

N_data_cols = size(table_data,2);
N_formats = size(formatter_strings,1);

% Create placeholder matrices to fill in the formatting of numeric and color values
numericformatter_strings = cell(N_formats, N_data_cols); 
colorformatter_strings   = cell(N_formats, N_data_cols);

% Create placeholder for row memberships. This allows individual rows to be
% formatted differently, given by different formatting specifiers. 
row_memberships   = cell(N_formats, 1);

% Fill in the formats as a cell array. 
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
        if length(numChars)==N_header_strings
            fixed_header_str = fcn_DebugTools_debugPrintStringToNCharacters(header_str,numChars(ith_header));
        else
            fixed_header_str = fcn_DebugTools_debugPrintStringToNCharacters(header_str,numChars);
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
			if iscell(table_data)
				thisData = table_data{ith_row, jth_col};
			else
				thisData = table_data(ith_row,jth_col);
			end
            data_str = sprintf(numericformatter_strings{membershipToUse, jth_col},thisData);

            % Do each of the columns have different widths?
            if length(numChars)==N_data_cols
                fixed_data_str = fcn_DebugTools_debugPrintStringToNCharacters(data_str,numChars(jth_col));
            else
                fixed_data_str = fcn_DebugTools_debugPrintStringToNCharacters(data_str,numChars);
            end

            if 1==fid && ~isempty(colorformatter_strings{membershipToUse, jth_col})
                fcn_DebugTools_cprintf(colorformatter_strings{membershipToUse, jth_col},sprintf('%s ',fixed_data_str));
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

