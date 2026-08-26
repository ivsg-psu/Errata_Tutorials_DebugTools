function outHashes = fcn_DebugTools_hashStrings(seedString, inStrings, varargin)
%% fcn_DebugTools_hashStrings
%fcn_DebugTools_hashStrings  Return MD5 hashes for multiple strings
%
% Given an input string as a md5 hash seed, and an array of strings to
% hash, returns an array of strings XOR'd with the hash seed, effectively
% scrambling the strings randomly but reversibly.
%
% SYNTAX:
%
%      outHashes = fcn_DebugTools_hashStrings(seedString, inStrings, (flagOutputs))
%
% INPUTS:
%
%      seedString: a string array or char array containing the seed to hash
%
%      inStrings: string array, char array, cellstr, or cell of char
%      vectors to XOR with the hash produced by the seedString
% 
%      (OPTIONAL INPUTS)
% 
%      flagOutputs: 
%          if set to 0 (default): the XOR results are returned in lowercase
%          HEX format
%
%          if set to 1: the XOR results are returned in ASCII characters
%          by converting each hex byte back into a character
%
% OUTPUTS:
%
%      outHashes : string array of 32-character lowercase hex values, or if
%      the flag is set to 1, a string array
%
% DEPENDENCIES:
%
%      fcn_DebugTools_checkInputsToFunctions
%
% EXAMPLES:
%
% See the script: script_test_fcn_DebugTools_hashStrings
% for a full test suite.
%
% This function was written on 2026_08_25 by S. Brennan.
% Questions or comments? sbrennan@psu.edu

% REVISION HISTORY:
% 
% 2026_08_25 by Sean Brennan, sbrennan@psu.edu
% - First write of the function using
%   % fcn_DebugTools_debug+PrintStringToNCharacters as a starter

% TO-DO:
% 2026_08_25 by Sean Brennan, sbrennan@psu.edu
% - fill in to-do items here.

%% Debugging and Input checks

% Check if flag_max_speed set. This occurs if the fid variable input
% argument (varargin) is given a number of -1, which is not a valid figure
% number.
MAX_NARGIN = 3; % The largest Number of argument inputs to the function
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

        % % Check the directoryToCheck input
        % fcn_DebugTools_checkInputsToFunctions(seedString, 'DoesDirectoryExist');
        % 
        % % Check the filePrefixString input
        % fcn_DebugTools_checkInputsToFunctions(filePrefixString, '_of_char_strings');

    end
end

% Normalize seedString to string array
if iscell(seedString)
    % allow cell of char or string
    fixedInputSeedString = string(seedString);
elseif ischar(seedString) && isrow(seedString)
    fixedInputSeedString = string({seedString});
else
    fixedInputSeedString = string(seedString);
end


% Normalize inStrings to string array
if iscell(inStrings)
    % allow cell of char or string
    fixedInputStrings = string(inStrings);
elseif ischar(inStrings) && isrow(inStrings)
    fixedInputStrings = string({inStrings});
else
    fixedInputStrings = string(inStrings);
end


% Does user want to specify flagOutputs?
flagOutputs = 0; % Default is 0
if (3 <= nargin)
    temp = varargin{1};
    if ~isempty(temp)
        flagOutputs = temp;
        % Check the flagOutputs input
        fcn_DebugTools_checkInputsToFunctions(flagOutputs, '_1column_of_integers',[1 1]);
    end
end

% Check to see if user specifies fid?
flag_do_plots = 0; % Default is to NOT show plots
% fid = 1; % Default is to print to the console
% if (0==flag_max_speed) && (MAX_NARGIN == nargin) 
%     temp = varargin{end};
%     if ~isempty(temp)
%         fid = temp; 
%         flag_do_plots = 1;
%     end
% end


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

% Hash the seed string
hashedSeedString = fcn_DebugTools_md5ForStrings(fixedInputSeedString);

% map each hex char of the seed string to uint16 in prep for XOR
% seedIntegers = fcn_INTERNAL_hexCharsToUint16(hashedSeedString);
seedIntegers = uint8(char(hashedSeedString));

% Make sure seedIntegers is a column
seedIntegers = reshape(seedIntegers,[],1);

if flagOutputs==1
    % Group the hex values into groups of 2
    hexStrings = (reshape(char(fixedInputStrings),2,[]))';
    inputIntegers = uint8(hex2dec(hexStrings));
else
    % convert inputs into uint16 in prep for XOR operation
    % [inputIntegers, lengths] = fcn_INTERNAL_toUint16Array(fixedInputStrings);
    inputIntegers = uint8(char(fixedInputStrings));
end

% Make sure inputIntegers is a column
inputIntegers = reshape(inputIntegers,[],1);

% Make sure that the seed integers are at least as long as the inputs
NinputIntegers = length(inputIntegers);
NseedIntegers = length(seedIntegers);
numRepeats = floor(NinputIntegers/NseedIntegers)+1;

% create a vector that is always longer than the input integers
seedIntegersRepeated = repmat(seedIntegers,numRepeats,1);

% crop the seed vector to exactly the same size as the inputs
seedIntegersMatched = seedIntegersRepeated(1:NinputIntegers,:);

% Perform the XOR operation
outIntegers = bitxor(seedIntegersMatched,inputIntegers);

% Convert to hex or string?
if flagOutputs==1
    outHashCharArray = char(outIntegers);
    outHashes = reshape(outHashCharArray.', 1, []);
else
    outHexes = dec2hex(outIntegers);
    outHashes = reshape(outHexes.', 1, []);
end

if flagOutputs==-1
    assert(strcmp(outHashes,'test'));
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
% 
% %% fcn_INTERNAL_md5ForStrings
% function outHashes = fcn_INTERNAL_md5ForStrings(inStrings)
% %fcn_INTERNAL_md5ForStrings  Return MD5 hashes for multiple strings
% %
% % Syntax
% %  outHashes = fcn_INTERNAL_md5ForStrings(inStrings)
% %
% % Inputs
% %  inStrings : string array, char array, cellstr, or cell of char vectors
% %
% % Outputs
% %  outHashes : string array of 32-character lowercase MD5 hex values
% %
% % Example
% %  h = fcn_INTERNAL_md5ForStrings({"a","b","test"})
% %  % h = ["0cc175b9c0f1b6a831c399e269772661" "92eb5ffee6ae2fec3ad71c777531578f" "098f6bcd4621d373cade4e832627b4f6"]
% %
% 
% narginchk(1,1);
% 
% % Normalize input to string array
% if iscell(inStrings)
%     % allow cell of char or string
%     inStr = string(inStrings);
% elseif ischar(inStrings) && isrow(inStrings)
%     inStr = string({inStrings});
% else
%     inStr = string(inStrings);
% end
% 
% % Preallocate
% N = numel(inStr);
% outHashes = strings(size(inStr));
% 
% % Prefer mlreportgen.utils.hash when available and supports elementwise call
% if exist('mlreportgen.utils.hash','file') == 2
%     try
%         for k = 1:N
%             outHashes(k) = string(mlreportgen.utils.hash(inStr(k)));
%         end
%         outHashes = lower(outHashes);
%         return
%     catch
%         % fallback to Java below
%     end
% end
% 
% % Fallback: reuse Java MessageDigest instance for efficiency
% md = java.security.MessageDigest.getInstance('MD5');
% for k = 1:N
%     s = char(inStr(k));        % Java needs bytes from char
%     md.reset();
%     md.update(uint8(s));
%     digest = md.digest();             % int8 array
%     hexChars = char(dec2hex(typecast(digest,'uint8'))); % N-by-2 char array
%     outHashes(k) = string(lower(reshape(hexChars',1,[])));
% end
% 
% % Preserve original shape
% outHashes = reshape(outHashes, size(inStr));
% 
% end % Ends fcn_INTERNAL_md5ForStrings
% 
% 
% %% fcn_INTERNAL_hexStringToBinary
% function [bitChars, bitVecs] = fcn_INTERNAL_hexStringToBinary(inText)
% %fcn_INTERNAL_hexStringToBinary Convert text with hex to binary bits
% %  [bitChars,bitVecs] = fcn_INTERNAL_hexStringToBinary(inText)
% %  inText : char vector, string scalar/array, or cellstr
% %  bitChars : string array of concatenated '0'/'1' characters
% %  bitVecs  : logical array: numel(inText) x (4*numHexDigitsPerElement)
% %
% narginchk(1,1);
% 
% % Normalize to cell of char
% if isstring(inText)
%     cellIn = cellstr(inText);
% elseif ischar(inText)
%     cellIn = {inText};
% elseif iscell(inText)
%     cellIn = inText;
% else
%     error('Unsupported input type.');
% end
% 
% N = numel(cellIn);
% bitChars = strings(size(cellIn));
% bitVecs = [];
% 
% for k = 1:N
%     s = cellIn{k};
%     if isempty(s)
%         bitChars(k) = "";
%         continue
%     end
%     % Remove "0x"/"0X" prefixes and non-hex characters
%     s = regexprep(s,'0[xX]','');              % drop 0x prefixes
%     hexOnly = regexp(s,'[0-9A-Fa-f]','match');% keep only hex digits
%     if isempty(hexOnly)
%         bitChars(k) = "";
%         continue
%     end
%     hexStr = [hexOnly{:}];                    % concatenated hex digits
%     % Convert each hex char to its 4-bit binary (vectorized)
%     vals = hex2dec(cellstr(char(hexStr')));   % column of nibbles
%     bins = dec2bin(vals,4);                   % n-by-4 char array
%     bins = reshape(bins',1,[]);               % 1 x (4*n) char
%     bitChars(k) = string(bins);
%     bitVecs(k,1:numel(bins)) = (bins == '1'); % build logical matrix (zero-padded)
% end
% 
% % If bitVecs is empty (no hex found), return empty logical
% if isempty(bitVecs)
%     bitVecs = false(N,0);
% end
% 
% end % Ends fcn_INTERNAL_hexStringToBinary
% 
% %% fcn_INTERNAL_hexCharsToUint16
% function out = fcn_INTERNAL_hexCharsToUint16(hexInput)
% %fcn_INTERNAL_hexCharsToUint16  Convert hex characters to uint16 array
% %
% % out = fcn_INTERNAL_hexCharsToUint16(hexInput)
% % hexInput : char vector, string scalar/array, cellstr, or cell of char
% % out      : uint16 column vector (each element = 4 hex digits -> 16 bits)
% %
% % Notes:
% % - Non-hex characters are ignored.
% % - If total nibble count is not a multiple of 4, pads on the left with '0'.
% % - For multiple input elements, concatenates all hex digits from each element
% %   and returns values in the same element order (one value per 4 hex digits).
% 
% narginchk(1,1);
% 
% % Normalize input to cell of char vectors
% if isstring(hexInput)
%     cellIn = cellstr(hexInput);
% elseif ischar(hexInput)
%     cellIn = {hexInput};
% elseif iscell(hexInput)
%     cellIn = hexInput;
% else
%     error('Unsupported input type.');
% end
% 
% out = uint16([]); % accumulate
% 
% for i = 1:numel(cellIn)
%     s = cellIn{i};
%     if isempty(s)
%         continue
%     end
%     % keep only hex digits
%     hexDigits = regexp(s, '[0-9A-Fa-f]', 'match');
%     if isempty(hexDigits)
%         continue
%     end
%     hexStr = [hexDigits{:}];            % concatenated hex digits
% 
%     % The following converts the input into 4-byte pairs. We don't want
%     % this so commented out
%     % % make length multiple of 4 by left-padding with '0'
%     % rem4 = mod(numel(hexStr),4);
%     % if rem4 ~= 0
%     %     pad = repmat('0',1,4-rem4);
%     %     hexStr = [pad hexStr];
%     % end
%     % % reshape into 4-char groups (each column -> one uint16)
%     % M = reshape(hexStr, 4, [] )';      % n-by-4 char array
%     % % convert each 4-char group to decimal then to uint16
%     % decVals = uint16(hex2dec(cellstr(M)));
% 
%     M = reshape(hexStr,1,[]);
% 
%     % convert each char to decimal then to uint16
%     decVals = uint16(M);
%     out = [out; decVals(:)];           %#ok<AGROW>
% end
% 
% end % Ends fcn_INTERNAL_hexCharsToUint16
% 
% %% fcn_INTERNAL_toUint16Array
% function [out, lengths] = fcn_INTERNAL_toUint16Array(in)
% %fcn_INTERNAL_toUint16Array  Convert text inputs to uint16 code units
% %
% % Syntax
% %  out = fcn_INTERNAL_toUint16Array(in)
% %  [out,lengths] = fcn_INTERNAL_toUint16Array(in)
% %
% % Inputs
% %  in       : string array, char array, cellstr, or cell of char vectors
% %
% % Outputs
% %  out      : uint16 matrix, N-by-M where N = numel(in) and M = max length;
% %             rows are zero-padded on the right for shorter elements
% %  lengths  : integer column vector of original lengths for each element
% %
% % Example
% %  s = ["Hi","π"];
% %  [a,len] = fcn_INTERNAL_toUint16Array(s)
% %
% 
% narginchk(1,1);
% 
% % Normalize input to cell array of char vectors
% if isstring(in)
%     cellIn = cellstr(in);
% elseif ischar(in)
%     % char array: each row is an element
%     cellIn = cellstr(in);
% elseif iscell(in)
%     % allow cellstr or cell of char vectors
%     if all(cellfun(@(x) ischar(x) || isStringScalar(x), in))
%         cellIn = cellfun(@char, in, 'UniformOutput', false);
%     else
%         error('Input cell must contain character vectors or string scalars.');
%     end
% else
%     error('Unsupported input type. Provide string/char/cellstr/cell of char.');
% end
% 
% N = numel(cellIn);
% lengths = zeros(N,1);
% for k = 1:N
%     lengths(k) = numel(cellIn{k});
% end
% 
% if N == 0
%     out = uint16.empty(0,0);
%     return
% end
% 
% M = max(lengths);
% out = uint16(zeros(N, M));
% 
% for k = 1:N
%     if lengths(k) > 0
%         % char -> Unicode code units (0..65535)
%         out(k,1:lengths(k)) = uint16(cellIn{k});
%     end
% end
% 
% end % Ends fcn_INTERNAL_toUint16Array
% 
% 
% %% fcn_INTERNAL_uint16ArrayToStrings
% function strOut = fcn_INTERNAL_uint16ArrayToStrings(uint16Array, lengths)
% %fcn_INTERNAL_uint16ArrayToStrings  Convert uint16 matrix + lengths back to strings
% %
% % strOut = fcn_INTERNAL_uint16ArrayToStrings(uint16Array, lengths)
% %
% % Inputs
% %  uint16Array : N-by-M uint16 matrix produced by fcn_DebugTools_toUint16Array
% %  lengths     : N-by-1 or N-vector of original lengths (number of characters)
% %
% % Output
% %  strOut      : string array (N-by-1) containing original strings
% %
% narginchk(2,2);
% validateattributes(uint16Array, {'numeric','uint16'}, {'2d'}, mfilename, 'uint16Array', 1);
% validateattributes(lengths, {'numeric'}, {'vector','nonnegative','integer'}, mfilename, 'lengths', 2);
% 
% % Normalize
% uint16Array = uint16(uint16Array);
% N = size(uint16Array,1);
% lengths = lengths(:);
% if numel(lengths) ~= N
%     error('Length of lengths must equal number of rows in uint16Array.');
% end
% 
% % Build strings
% strOut = strings(N,1);
% for k = 1:N
%     L = lengths(k);
%     if L == 0
%         strOut(k) = "";
%         continue
%     end
%     if L > size(uint16Array,2)
%         error('Requested length exceeds number of columns in uint16Array for row %d.', k);
%     end
%     % Extract code units, convert to char, and take only first L characters
%     codes = uint16Array(k,1:L);
%     % Treat zeros as valid NULs only if within length; converting to char handles them
%     strOut(k) = string(char(codes));
% end
% 
% end % Ends fcn_INTERNAL_uint16ArrayToStrings
