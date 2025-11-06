function [ ...
varargout...
] = ...
fcn_DebugTools_checkInputsToFunctions( ...
variable, ...
variableTypeString, ...
varargin...
) %#ok<*STOUT,*INUSD>
% fcn_DebugTools_checkInputsToFunctions
% Checks the variable types commonly used in the codes to ensure 
% they are correctly formed.
% 
% This is a template function which is built for each class of functions. 
% It is typically called at the top of most functions in a particular 
% class. The input is a variable and a string defining the "type" of the 
% variable. This function checks to see that they are compatible. For 
% example, say there is a 'column_vector' type of variables used in the 
% function that is always a N x 1 array; if someone had a variable called 
% "test_example", one could check that this fit the 'column_vector' type 
% by calling 
% fcn_DebugTools_checkInputsToFunctions(test_example,'column_vector'). This 
% function would then check that the array was N x 1, and if it was not, 
% it would send out an error warning.
% 
% FORMAT:
% 
%    [ ...
%    (AllowableInputs) ...
%    ] = ...
%    fcn_DebugTools_checkInputsToFunctions( ...
%    variable, ...
%    variableTypeString, ...
%    (required_length), ...
%    (fig_num) ...
%    )
% 
% INPUTS:
% 
%     variable: the variable to check
% 
%     variableTypeString: a string representing the variable type to 
%     check. Call the function with any figure number to see allowable 
%     options.
% 
%     (optional inputs)
%
%     required_length: an integer forcing the value of N, giving an error 
%     if the input variable does not have length N. Another optional input 
%     is a rwo vector [A B] where, if B is greater than A, then the vector 
%     must be A or longer. If B is less than A, then the vector must be A 
%     or shorter. If B = A, then the vector must be length A, and no 
%     shorter or greater - note: if B==A then [A B] gives the same result
%     as [A].
% 
%     fig_num: any number that acts somewhat like a figure number output. 
%     If given, this forces the variable types to be displayed as output 
%     and as well makes the input check process verbose.
% 
% 
% OUTPUTS:
% 
%     (optional outputs)
%
%     AllowableInputs: This is a structure output that lists all the 
%     allowable types, and a description of each. As well, if an output 
%     argument is specified, the same information is printed within the 
%     workspace.
% 
% 
% DEPENDENCIES:
% 
%    (none)
% 
% EXAMPLES:
% 
% See the script: script_test_fcn_DebugTools_checkInputsToFunctions
% for a full test suite and extensive list of working examples.
% 
% This function was written on 2021_12_12 by S. Brennan by modifying the
% similar function from the MapGen class.
%
% Questions or comments? contact sbrennan@psu.edu

% 
% REVISION HISTORY:
% 2021_12_12 by S. Brennan
% -- first write of function
% 2022_04_03 by S. Brennan
% -- added Path variable types
% 2023_01_16 by S. Brennan
% -- added narginchk
% -- fixed dbstack error to match error to source function
% -- added char type
% -- added string type
% -- improved documentation
% 2025_07_10 by S. Brennan
% -- added NorMorecolumn_of_numbers type and tests
% -- added structure comparison to see if bug with structure testing
% -- commented out traversal and traversals type to deprecate Path library
%    usage of these
% -- added numeric testing
% -- updated output options listing
% 2025_07_18 by S. Brennan
% -- added positive and strictly positive variable checking to
%    checkInputsToFunctions
% 2025_11_06 by S. Brennan
% -- updated header and input checking to current format
% -- updated plotting flag name, for consistency
%    % * from flag_do_plot
%    % * to flag_do_plots
% -- changed input variable name for consistency
%    % * from variable_type_string
%    % * to variableTypeString

% 
% TO DO:
% -- fill in to-do items here.

%% Debugging and Input checks

% Check if flag_max_speed set. This occurs if the fig_num variable input
% argument (varargin) is given a number of -1, which is not a valid figure
% number.
MAX_NARGIN = 4; % The largest Number of argument inputs to the function
flag_max_speed = 0;
if (nargin==MAX_NARGIN && isequal(varargin{end},-1))
    flag_do_debug = 0; % % % % Flag to plot the results for debugging
    flag_check_inputs = 0; % Flag to perform input checking
    flag_max_speed = 1;
else
    % Check to see if we are externally setting debug mode to be "on"
    flag_do_debug = 0; % % % % Flag to plot the results for debugging
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
    debug_fig_num = 999978;
else
    debug_fig_num = [];
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

        if nargin>=2
            % Check the variableTypeString input, make sure it is characters
            if ~ischar(variableTypeString)
                error('The variableTypeString input must be a character type, for example: ''Path'' ');
            end
        end

    end
end

% Check to see if user specifies fig_num?
flag_do_plots = 0; % Default is to NOT show plots
if (0==flag_max_speed) && (MAX_NARGIN == nargin) 
    temp = varargin{end};
    if ~isempty(temp)
        fig_num = temp;
        flag_do_plots = 1;
    end
end

% Setup figures if there is debugging
if flag_do_debug
    fig_debug = 159; 
else
    fig_debug = []; %#ok<*NASGU>
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
%See: http://patorjk.com/software/taag/#p=display&f=Big&t=Main
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%§


% Check to see if output argument given
if nargout>0
    varargout{1}= INTERNAL_fcn_showPossibleFields;
    return
end

% Grab the variable name
variable_name = inputname(1);

% Set default flags all to "off" mode
flags = INTERNAL_fcn_setDefaultFlagsToOff;

% See if special inputs, for example if there are 3 inputs and user is
% using 3rd input to specify greater than, less than, equal conditions,
% etc.
if nargin == 3
    flags.third_input = varargin{1};
    flags.check_requiredRowLength = 1;     % Must check for required length
    flags.rowLengthRangeRequired = varargin{1}; % Set to [x y]. Variable must be x or greater if y>x, =x if y=x, x or less if y<x
end

% Grab flag settings for current input
flags = INTERNAL_fcn_setFlagsByType(flags,variableTypeString);

% Check that variable meets requirements
INTERNAL_confirmVariable(flags,variable,variable_name);


%

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
    % Nothing to plot here
end % Ends the flag_do_plot if statement    

if flag_do_debug
    fprintf(1,'ENDING function: %s, in file: %s\n\n',st(1).name,st(1).file);
end


end % Ends the function

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


function flags = INTERNAL_fcn_setDefaultFlagsToOff %#ok<*DEFNU>
% Set default flags all to "off" mode
flags.check_if_isnumeric = 0; % Check to see if isnumeric
flags.check_if_positive = 0; % Check to see if number is greater than or equal to zero
flags.check_if_strictly_positive = 0; % Check to see if number is greater than zero, and not zero
flags.check_required_columns  = 0; % Check the number of columns
flags.minNrequiredcolumns  = 0; % No check
flags.maxNrequiredcolumns  = 0; % No check
flags.check_if_noNaN = 0; % Check that there are no NaN 
flags.check_if_numeric = 0; % Check that the variable is numeric
flags.check_if_integer = 0; % Check that the variable is an integer
flags.check_if_char = 0; % Check that the variable is a character
flags.check_if_string = 0; % Check that the variable is a string
flags.check_if_doesFileExist = 0; % Check that the variable is an existing file
flags.check_if_doesDirectoryExist = 0; % Check that the variable is an existing directory
flags.check_requiredRowLength = 0;     % Don't check for required length
flags.rowLengthRangeRequired = [0 0]; % Set to [x y]. Variable must be x or greater if y>x, =x if y=x, x or less if y<x
flags.check_likeStructure = 0; % Check that result is like a particular structure
template_structure = ...
    struct(...
    'vertices',[],...
    'xv',[],...
    'yv',[],...
    'distances',[],...
    'mean',[],...
    'area',[],...
    'max_radius',[]);
flags.structureToBeLike = template_structure;
flags.structureToBeLikeName = 'polytopes';
flags.third_input = [];
end

%%
function flags = INTERNAL_fcn_setFlagsByType(flags, variableTypeString)

flag_pattern_was_matched = 0;

% Convert path library variable types into regular queries
if strcmp(variableTypeString,'station')
    variableTypeString = '1column_of_numbers';
end
if strcmp(variableTypeString,'stations')
    variableTypeString = '1column_of_numbers';
    flags.check_requiredRowLength = 1;     % Must check for required length
    flags.rowLengthRangeRequired = [2 3];  % Set to [x y]. Variable must be x or greater if y>x, =x if y=x, x or less if y<x
end
if strcmp(variableTypeString,'path')
    variableTypeString = '2column_of_numbers';
    flags.check_requiredRowLength = 1;     % Must check for required length
    flags.rowLengthRangeRequired = [2 3];  % Set to [x y]. Variable must be x or greater if y>x, =x if y=x, x or less if y<x
end
if strcmp(variableTypeString,'path2or3D')
    variableTypeString = '2or3column_of_numbers';
    flags.check_requiredRowLength = 1;     % Must check for required length
    flags.rowLengthRangeRequired = [2 3];  % Set to [x y]. Variable must be x or greater if y>x, =x if y=x, x or less if y<x
end
if strcmp(variableTypeString,'elevated_path')
    variableTypeString = '3column_of_numbers';
    flags.check_requiredRowLength = 1;     % Must check for required length
    flags.rowLengthRangeRequired = [2 3];  % Set to [x y]. Variable must be x or greater if y>x, =x if y=x, x or less if y<x
end
if strcmp(variableTypeString,'paths')
    variableTypeString = '2column_of_numbers';
    flags.check_requiredRowLength = 1;     % Must check for required length
    flags.rowLengthRangeRequired = [3 4];  % Set to [x y]. Variable must be x or greater if y>x, =x if y=x, x or less if y<x
end
if strcmpi(variableTypeString,'likestructure')
    flags.check_likeStructure = 1; % Check that result is like a particular structure
    template_structure = flags.third_input; % This is where the 3rd input is stored
    if ~isstruct(template_structure)
        error('A structure type is expected as an argument for the ''likestructure'' check');
    end
    flags.structureToBeLike = template_structure;
    flags.structureToBeLikeName = 'user-defined';
    flags.check_requiredRowLength = 0;     % Override the flag by 3-argument input, since it is a structure
    flag_pattern_was_matched = 1;
end
if strcmpi(variableTypeString,'traversal')
    flags.check_likeStructure = 1; % Check that result is like a particular structure
    template_structure = ...
        struct(...
        'X',[],...
        'Y',[],...
        'Z',[],...
        'Station',[]);
    flags.structureToBeLike = template_structure;
    flags.structureToBeLikeName = 'traversal';
    flag_pattern_was_matched = 1;
end
if strcmpi(variableTypeString,'traversals')
    flags.check_likeStructure = 0; % Do NOT check that this is a structure
    template_structure = ...
        struct(...
        'X',[],...
        'Y',[],...
        'Z',[],...
        'Station',[]);
    flags.structureToBeLike = template_structure;
    flags.structureToBeLikeName = 'traversals';
    flag_pattern_was_matched = 1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End of special cases - start of general cases
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check the "Ncolumn_of" pattern, where N is a digit
pattern = digitsPattern(1)+"column_of";
if contains(variableTypeString,pattern)
    match = extract(variableTypeString,pattern);
    string_result = match{1};
    ncols_max = str2double(string_result(1));

    % Check for NorMcolumn_of format
    pattern = digitsPattern(1)+"or"+digitsPattern(1)+"column_of";
    if contains(variableTypeString,pattern)
        match = extract(variableTypeString,pattern);
        string_result = match{1};
        ncols_min = str2double(string_result(1));
    else
        ncols_min = ncols_max;
    end
    
    flags.check_if_isnumeric = 1; % Must be a number
    flags.check_required_columns  = 1; % Check the number of columns
    flags.minNrequiredcolumns  = ncols_min; % Must be 1 columns
    flags.maxNrequiredcolumns  = ncols_max; % Must be 1 columns
    flags.check_if_noNaN = 1; % Check that there are no NaN
    
    flag_pattern_was_matched = 1;
end

% Check the "NorMorecolumn_of" pattern, where N is a digit
pattern = digitsPattern(1)+"orMorecolumn_of";
if contains(variableTypeString,pattern)
    
    match = extract(variableTypeString,pattern);
    string_result = match{1};
    ncols_min = str2double(string_result(1));
    ncols_max = inf;

    flags.check_if_isnumeric = 1; % Must be a number
    flags.check_required_columns  = 1; % Check the number of columns
    flags.minNrequiredcolumns  = ncols_min; % Must be 1 columns
    flags.maxNrequiredcolumns  = ncols_max; % Must be 1 columns
    flags.check_if_noNaN = 1; % Check that there are no NaN
    
    flag_pattern_was_matched = 1;
end



% positive_XXX and strictlypositive_XXX
pattern = 'positive_';
if contains(variableTypeString,pattern)
    flags.check_if_positive = 1;
    flag_pattern_was_matched = 1;

    pattern = 'strictlypositive_';
    if contains(variableTypeString,pattern)
        flags.check_if_positive = 0; % No need to check this also
        flags.check_if_strictly_positive = 1; 
    end
end


% XXX_of_numbers
pattern = '_of_numbers';
if contains(variableTypeString,pattern)
    flags.check_if_numeric = 1; % Check that the variable is numeric
    flag_pattern_was_matched = 1;
end

% XXX_of_integers
pattern = '_of_integers';
if contains(variableTypeString,pattern)
    flags.check_if_integer = 1; % Check that the variable is an integer
    flag_pattern_was_matched = 1;
end

% XXX_of_mixed
pattern = '_of_mixed';
if contains(variableTypeString,pattern)
    flags.check_if_noNaN = 0; % Removes check that it be numeric
    flag_pattern_was_matched = 1;
end

% XXX_of_chars
pattern = '_of_chars';
if contains(variableTypeString,pattern)
    flags.check_if_char = 1; % Check that the variable is a char
    flag_pattern_was_matched = 1;
end

% XXX_of_strings
pattern = '_of_strings';
if contains(variableTypeString,pattern)
    flags.check_if_string = 1; % Check that the variable is a string
    flag_pattern_was_matched = 1;
end

% DoesFileExist
pattern = 'DoesFileExist';
if contains(variableTypeString,pattern)
    flags.check_if_doesFileExist = 1; % Check that the variable is a string
    flag_pattern_was_matched = 1;
end

% DoesDirectoryExist
pattern = 'DoesDirectoryExist';
if contains(variableTypeString,pattern)
    flags.check_if_doesDirectoryExist = 1; % Check that the variable is a string
    flag_pattern_was_matched = 1;
end

% polytopes
if strcmpi(variableTypeString,'polytopes')
    flags.check_likeStructure = 1; % Check that result is like a particular structure
    template_structure = ...
        struct(...
        'vertices',[],...
        'xv',[],...
        'yv',[],...
        'distances',[],...
        'mean',[],...
        'area',[],...
        'max_radius',[]);
    flags.structureToBeLike = template_structure;
    flags.structureToBeLikeName = 'polytopes';
    flag_pattern_was_matched = 1;
end

% mixedset
if strcmpi(variableTypeString,'mixedset')
    flags.check_likeStructure = 1; % Check that result is like a particular structure
    template_structure = ...
        struct(...
        'name',[],...
        'settings',[],...
        'AABB',[]);
    flags.structureToBeLike = template_structure;
    flags.structureToBeLikeName = 'mixedset';
    flag_pattern_was_matched = 1;
end

if 0==flag_pattern_was_matched
    error('The variable type: %s is not defined in context of error checking.',variableTypeString);
end

end % Ends INTERNAL_fcn_setFlagsByType

%% 
function INTERNAL_confirmVariable(flags,variable,variable_name)



st = dbstack(2);
errorStruct.stack = st;
errorStruct.message = 'MyComponent:incorrectType';
errorStruct.identifier = 'MyFunction:fileNotFound';

% Numeric?
if flags.check_if_isnumeric   
    if ~isnumeric(variable)
        errorStruct.message =sprintf('The %s input must be numeric.',variable_name);
        error(errorStruct);
    end
end

% Positive?
if flags.check_if_positive   
    if any(variable<0,'all')
        errorStruct.message =sprintf('The %s input must be positive, e.g. greater than or equal to zero.',variable_name);
        error(errorStruct);
    end
end

% Strictly positive?
if flags.check_if_strictly_positive   
    if any(variable<=0,'all')
        errorStruct.message =sprintf('The %s input must be strictly positive, e.g. greater than zero and not equal to zero.',variable_name);
        error(errorStruct);
    end
end

% NaN?
if flags.check_if_noNaN   
    if any(isnan(variable),'all')        
        errorStruct.message =sprintf('The %s input must have no NaN values.',variable_name);
        error(errorStruct);
    end
end

% Numeric?
if flags.check_if_numeric
    if any(~isnumeric(variable),'all')        
        errorStruct.message =sprintf('The %s input must be numeric.',variable_name);
        error(errorStruct);
    end
end

% Integer?
if flags.check_if_integer   
    if ~all(round(variable)==variable)        
        errorStruct.message =sprintf('The %s input must be an integer.',variable_name);
        error(errorStruct);
    end
end

% Character?
if flags.check_if_char   
    if ~ischar(variable)
        errorStruct.message =sprintf('The %s input must be a character.',variable_name);
        error(errorStruct);
    end
end

% String?
if flags.check_if_string   
    if ~isstring(variable)
        errorStruct.message =sprintf('The %s input must be a string.',variable_name);
        error(errorStruct);
    end
end

% DoesFileExist?
if flags.check_if_doesFileExist
    if 0==exist(variable,'file')
        errorStruct.message =sprintf('The %s input, %s, must be an existing file.',variable_name,variable);
        error(errorStruct);
    end
end

% DoesDirectoryExist?
if flags.check_if_doesDirectoryExist
    if 0==exist(variable,'dir')
        errorStruct.message =sprintf('The %s input, %s, must be an existing directory.',variable_name,variable);
        error(errorStruct);
    end
end


% Column length?
if flags.check_required_columns    
    if flags.minNrequiredcolumns==0
        errorStruct.message =sprintf('Need to set minimum number of columns for variable type: %s.',variable_name);
        error(errorStruct);
    end
    if flags.maxNrequiredcolumns==0
        errorStruct.message =sprintf('Need to set maximum number of columns for variable type: %s.',variable_name);
        error(errorStruct);
    end
    
    % Exactly a number of columns?
    if flags.minNrequiredcolumns==flags.maxNrequiredcolumns
        if length(variable(1,:))~=flags.minNrequiredcolumns
            errorStruct.message =sprintf('The %s input must have exactly %.0d columns.',variable_name,flags.minNrequiredcolumns);
            error(errorStruct);
        end
    end
    
    % A minimum number of columns
    if length(variable(1,:))<flags.minNrequiredcolumns
        errorStruct.message =sprintf('The %s input must have at least %.0d columns.',variable_name,flags.minNrequiredcolumns);
        error(errorStruct);
    end

    % A maximum number of columns
    if length(variable(1,:))>flags.maxNrequiredcolumns
        errorStruct.message =sprintf('The %s input must have no more than %.0d columns.',variable_name,flags.maxNrequiredcolumns);
        error(errorStruct);
    end
    
end

% Row length?
if flags.check_requiredRowLength    
    required_length = flags.rowLengthRangeRequired;
    if length(required_length(1,:))==1  % Exact, given number of rows
        if length(variable(:,1))~=required_length
            errorStruct.message =sprintf('The %s input must have exactly %.0d rows',variable_name,required_length);
            error(errorStruct);
        end
    else
        if required_length(1,2)>required_length(1,1) % Must be at least given number of rows, or more
            min_length = required_length(1,1);
            if length(variable(:,1))<min_length
                errorStruct.message =sprintf('The %s input must have %.0d rows or more',variable_name,min_length);
                error(errorStruct);
            end
        elseif required_length(1,2)<required_length(1,1) % Must be no more than given number of rows
            max_length = required_length(1,1);
            if length(variable(:,1))>max_length
                errorStruct.message =sprintf('The %s input must have no more than %.0d rows',variable_name,max_length);
                error(errorStruct);
            end
        else % It has to be equal
            required_length = required_length(1,1);
            if length(variable(:,1))~=required_length
                errorStruct.message =sprintf('The %s input must have %.0d rows or more',variable_name,required_length);
                error(errorStruct);
            end
        end
    end
end

% Structure?
if flags.check_likeStructure 
    
    % What fields are in the template?
    template_fields = fieldnames(orderfields(flags.structureToBeLike));
        
    % Make sure user's input variable is a structure
    if ~isstruct(variable)
        fprintf(1,'The %s template has fields of:\n',flags.structureToBeLikeName);
        for ith_field = 1:length(template_fields)
            fprintf(1,'\t %s\n',string(template_fields(ith_field)));
        end
        errorStruct.message =sprintf('The %s input must be a structure type. It it not. It should have the same form as the type: %s. See the listing of fields above.',variable_name,flags.structureToBeLikeName);
        error(errorStruct);
    end
    
    % Make sure all the fields are where they should be
    variable_fields = fieldnames(orderfields(variable));
    if ~isequal(template_fields,intersect(template_fields,variable_fields))
        fprintf(1,'The %s template has fields of:\n',flags.structureToBeLikeName);
        for ith_field = 1:length(template_fields)
            fprintf(1,'\t %s\n',string(template_fields(ith_field)));
        end
        fprintf(1,'The %s input has fields of:\n',variable_name);
        for ith_field = 1:length(variable_fields)
            fprintf(1,'\t %s\n',string(variable_fields(ith_field)));
        end
        errorStruct.message =sprintf('The %s input must be a structure type. All the fields must be match the reference structure.',variable_name);
        error(errorStruct);
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Check special structure cases - traversal
    if strcmpi(flags.structureToBeLikeName,'traversal')
        X_central = variable.X;
        Y_central = variable.Y;
        Z_central = variable.Z;
        Station_central = variable.Station;        
        
        % Check that all are numeric
        if  ~isnumeric(X_central) ||  ~isnumeric(Y_central) ||  ~isnumeric(Z_central) ||  ~isnumeric(Station_central)           
            errorStruct.message =sprintf('The %s input must be a traversal type, namely a structure with fields X, Y, Z, and Station, each N x 1 numeric arrays. At least one data field is non-numeric.',variable_name);
            error(errorStruct);
        end
        
        % Check that all are 1-dimensional columns
        if (length(X_central(1,:))~=1) || (length(Y_central(1,:))~=1) || (length(Z_central(1,:))~=1) ||  (length(Station_central(1,:))~=1)            
            errorStruct.message =sprintf('The %s input must be a traversal type, namely a structure with fields X, Y, Z, and Station, each N x 1 numeric arrays. At least one data field has multiple columns.',variable_name);
            error(errorStruct);
        end
        
        % Check that their lengths are all the same
        if (length(X_central(:,1))~=length(Y_central(:,1))) || ((length(X_central(:,1))~=length(Z_central(:,1))))  || ((length(X_central(:,1))~=length(Station_central(:,1))))
            warning('The %s input has variables whose lengths do not match. See the workspace for variable information.',variable_name);
            fprintf(1,'\tX length is: %.0d.\n',length(X_central(:,1)));
            fprintf(1,'\tY length is: %.0d.\n',length(Y_central(:,1)));
            fprintf(1,'\tZ length is: %.0d.\n',length(Z_central(:,1)));
            fprintf(1,'\tStation length is: %.0d.\n',length(Station_central(:,1)));
            
            errorStruct.message =sprintf('The %s input must be a traversal type, namely a structure with fields X, Y, Z, and Station, each N x 1 numeric arrays. The lengths do not match.',variable_name);
            error(errorStruct);
        end
        
        % Make sure the station field is sorted
        if ~issorted(Station_central,'strictascend')
            errorStruct.message =sprintf('The Station field on the %s input must be strictly increasing',variable_name);
            error(errorStruct);
        end
    end    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Check special structure cases - traversals
% Convert paths to traversal structures
if strcmpi(flags.structureToBeLikeName,'traversals')
    % Check the all_traversals variables
    try
        test = variable.traversal{1}; %#ok<NASGU>
    catch
        errorStruct.message =sprintf('The variable: %s is expected to be a traversals type, and must a subfield called traversal which is a cell array (e.g. variable.traversal{2}). An array was not found.',variable_name);
        error(errorStruct);
    end
    
    for i_traversal = 1:length(variable.traversal)
        try
            fcn_DebugTools_checkInputsToFunctions(...
                variable.traversal{i_traversal},'traversal');
        catch ME            
            errorStruct.message =sprintf('The variable: %s is expected to be a traversals type, and must have a subfield called traversal which is a cell array; for eexample: variable.traversal{2}. An error in structure type was found in the %.0d index. The detail is: %s',variable_name,i_traversal,ME.message);
            error(errorStruct);
        end
    end
end


end % Ends INTERNAL_confirmVariable

function allowable_inputs = INTERNAL_fcn_showPossibleFields
num_inputs = 0;

% General cases
num_inputs = num_inputs+1;
allowable_inputs(num_inputs).name = 'Mcolumn_of...';
allowable_inputs(num_inputs).description = 'checks that the input type is K x M of ...';

num_inputs = num_inputs+1;
allowable_inputs(num_inputs).name = 'NorMcolumn...';
allowable_inputs(num_inputs).description = 'checks that the input type is of minimum K x N to maximum K x M of ...';

num_inputs = num_inputs+1;
allowable_inputs(num_inputs).name = 'NorMorecolumn...';
allowable_inputs(num_inputs).description = 'checks that the input type is of minimum K x N or maximum K x inf of ...';

num_inputs = num_inputs+1;
allowable_inputs(num_inputs).name = 'positive_...';
allowable_inputs(num_inputs).description = 'checks that the input type is positive ...';

num_inputs = num_inputs+1;
allowable_inputs(num_inputs).name = 'strictlypositive_...';
allowable_inputs(num_inputs).description = 'checks that the input type is strictlypositive ...';

num_inputs = num_inputs+1;
allowable_inputs(num_inputs).name = '_of_numbers...';
allowable_inputs(num_inputs).description = 'checks that the input type is numeric (uses isnumeric)...';

num_inputs = num_inputs+1;
allowable_inputs(num_inputs).name = '_of_integers...';
allowable_inputs(num_inputs).description = 'checks that the input type is of_integers...';

num_inputs = num_inputs+1;
allowable_inputs(num_inputs).name = '_of_mixed...';
allowable_inputs(num_inputs).description = 'checks that the input type is numeric but can include NaN..';

num_inputs = num_inputs+1;
allowable_inputs(num_inputs).name = '_of_chars...';
allowable_inputs(num_inputs).description = 'checks that the input type is a char type (uses ischar)';

num_inputs = num_inputs+1;
allowable_inputs(num_inputs).name = '_of_strings...';
allowable_inputs(num_inputs).description = 'checks that the input type is a string type (uses isstring)';

num_inputs = num_inputs+1;
allowable_inputs(num_inputs).name = 'DoesFileExist...';
allowable_inputs(num_inputs).description = 'checks that the input type is an existing file';

num_inputs = num_inputs+1;
allowable_inputs(num_inputs).name = 'DoesDirectoryExist...';
allowable_inputs(num_inputs).description = 'checks that the input type is an existing directory';

num_inputs = num_inputs+1;
allowable_inputs(num_inputs).name = 'likestructure...';
allowable_inputs(num_inputs).description = 'checks that the input structure has same fields as a template structure, even if out of order';

num_inputs = num_inputs+1;
allowable_inputs(num_inputs).name = 'polytopes...';
allowable_inputs(num_inputs).description = 'checks that the input type is a polytope type, e.g. a structure with fields: vertices, xv, yv, distances, mean, area, max_radius.';

num_inputs = num_inputs+1;
allowable_inputs(num_inputs).name = 'mixedset...';
allowable_inputs(num_inputs).description = 'checks that the input type is a structure matching a given template..';

% Specific cases follow
num_inputs = num_inputs+1;
allowable_inputs(num_inputs).name = '1column_of_numbers';
allowable_inputs(num_inputs).description = 'checks that the input type is N x 1. Optional input: an integer forcing the value of N, giving an error if the input variable does not have length N.';

num_inputs = num_inputs+1;
allowable_inputs(num_inputs).name = 'positive_1column_of_numbers';
allowable_inputs(num_inputs).description = 'checks that the input type is N x 1 and is a strictly positive number. Optional input: an integer forcing the value of N, giving an error if the input variable does not have length N.';

num_inputs = num_inputs+1;
allowable_inputs(num_inputs).name = '2column_of_numbers';
allowable_inputs(num_inputs).description = 'checks that the input type is N x 2 and is a number. Optional input: an integer forcing the value of N, giving an error if the input variable does not have length N. Another optional input is a rwo vector [A B] where, if B is greater than A, then the vector must be A or longer. If B is less than A, then the vector must be A or shorter. If B = A, then the vector must be length A, and no shorter or greater.';

num_inputs = num_inputs+1;
allowable_inputs(num_inputs).name = '4column_of_numbers';
allowable_inputs(num_inputs).description = 'checks that the input type is N x 4 and is a number. Optional input: an integer forcing the value of N, giving an error if the input variable does not have length N. Another optional input is a rwo vector [A B] where, if B is greater than A, then the vector must be A or longer. If B is less than A, then the vector must be A or shorter. If B = A, then the vector must be length A, and no shorter or greater.';

num_inputs = num_inputs+1;
allowable_inputs(num_inputs).name = '2or3column_of_numbers';
allowable_inputs(num_inputs).description = 'checks that the input type is N x 2 or N x 3 and is a number. Optional input: an integer forcing the value of N, giving an error if the input variable does not have length N. Another optional input is a rwo vector [A B] where, if B is greater than A, then the vector must be A or longer. If B is less than A, then the vector must be A or shorter. If B = A, then the vector must be length A, and no shorter or greater.';

num_inputs = num_inputs+1;
allowable_inputs(num_inputs).name = '2column_of_integers';
allowable_inputs(num_inputs).description = 'checks that the input type is N x 2 and is an integer. Optional input: an integer forcing the value of N, giving an error if the input variable does not have length N. Another optional input is a rwo vector [A B] where, if B is greater than A, then the vector must be A or longer. If B is less than A, then the vector must be A or shorter. If B = A, then the vector must be length A, and no shorter or greater.';

% Path library types
num_inputs = num_inputs+1;
allowable_inputs(num_inputs).name = 'station';
allowable_inputs(num_inputs).description = 'Path library type: checks that the station type is N x 1 and is a number.';

num_inputs = num_inputs+1;
allowable_inputs(num_inputs).name = 'stations';
allowable_inputs(num_inputs).description = 'Path library type: checks that the station type is N x 1 and is a number, with N >= 2.';

num_inputs = num_inputs+1;
allowable_inputs(num_inputs).name = 'path';
allowable_inputs(num_inputs).description = 'Path library type: checks that the path type is N x 2 with N>=2';

num_inputs = num_inputs+1;
allowable_inputs(num_inputs).name = 'path2or3D';
allowable_inputs(num_inputs).description = 'Path library type: checks that the path type is N x 2 or N x 3, with N>=2';

num_inputs = num_inputs+1;
allowable_inputs(num_inputs).name = 'elevated_path';
allowable_inputs(num_inputs).description = 'Path library type: checks that the elevated path type is N x 3 with N>=2';

num_inputs = num_inputs+1;
allowable_inputs(num_inputs).name = 'paths';
allowable_inputs(num_inputs).description = 'Path library type: checks that the path type is N x 2 with N>=3';

num_inputs = num_inputs+1;
allowable_inputs(num_inputs).name = 'traversal (DEPRECATED)';
allowable_inputs(num_inputs).description = 'Path library type: checks if a structure with X, Y, and Station, and that each has an N x 1 vector within all of same length. Further, the Station field must be strictly increasing.';

num_inputs = num_inputs+1;
allowable_inputs(num_inputs).name = 'traversals (DEPRECATED)';
allowable_inputs(num_inputs).description = 'Path library type: checks if a structure containing a subfield that is a cell array of traveral{i}, e.g. "data.traversal{3}", with each traversal also meeting traversal requirements.';

end



