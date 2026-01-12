function fcn_DebugTools_cprintf(style,format,varargin) %#ok<*JAPIMATHWORKS>

%% Debugging and Input checks

% Check if flag_max_speed set. This occurs if the figNum variable input
% argument (varargin) is given a number of -1, which is not a valid figure
% number.
MAX_NARGIN = 4; % The largest Number of argument inputs to the function
flag_max_speed = 0; %#ok<*NASGU>
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
    debug_figNum = 999978; 
else
    debug_figNum = []; 
end


% FCN_DEBUGTOOLS_CPRINTF displays styled formatted text in the Command
% Window. NOTE: this is a wrapper function for the classic cprintf
% function. Where appropriate, the readme below has been modified and/or
% kept to the origial comments.
%
% Syntax:
%    count = fcn_DebugTools_cprintf(style,format,...)
%
% Description:
%    FCN_DEBUGTOOLS_CPRINTF processes the specified text using the exact same FORMAT
%    arguments accepted by the built-in SPRINTF and FPRINTF functions.
%
%    FCN_DEBUGTOOLS_CPRINTF then displays the text in the Command Window using the
%    specified STYLE argument. The accepted styles are those used for
%    Matlab's syntax highlighting (see: File / Preferences / Colors / 
%    M-file Syntax Highlighting Colors), and also user-defined colors.
%
%    The possible pre-defined STYLE names are:
%
%       'Text'                 - default: black
%       'Keywords'             - default: blue
%       'Comments'             - default: green
%       'Strings'              - default: purple
%       'UnterminatedStrings'  - default: dark red
%       'SystemCommands'       - default: orange
%       'Errors'               - default: light red
%       'Hyperlinks'           - default: underlined blue
%
%       'Black','Cyan','Magenta','Blue','Green','Red','Yellow','White'
%
%    STYLE beginning with '-' or '_' will be underlined. For example:
%          '-Blue' is underlined blue, like 'Hyperlinks';
%          '_Comments' is underlined green etc.
%
%    STYLE beginning with '*' will be bold (R2011b+ only). For example:
%          '*Blue' is bold blue;
%          '*Comments' is bold green etc.
%    Note: Matlab does not currently support both bold and underline,
%          only one of them can be used in a single fcn_DebugTools_cprintf command. But of
%          course bold and underline can be mixed by using separate commands.
%
%    STYLE colors can be specified in 3 variants:
%        [0.1, 0.7, 0.3] - standard Matlab RGB color format in the range 0.0-1.0
%        [26, 178, 76]   - numeric RGB values in the range 0-255
%        '#1ab34d'       - Hexadecimal format in the range '00'-'FF' (case insensitive)
%                          3-digit HTML RGB format also accepted: 'a5f'='aa55ff'
%
%    STYLE can be underlined by prefixing - :  -[0,1,1]  or '-#0FF' is underlined cyan
%    STYLE can be made bold  by prefixing * : '*[1,0,0]' or '*#F00' is bold red
%
%    STYLE is case-insensitive and accepts unique partial strings just
%    like handle property names.
%
%    FCN_DEBUGTOOLS_CPRINTF by itself, without any input parameters, displays a demo
%
% Example:
%    fcn_DebugTools_cprintf;   % displays the demo
%    fcn_DebugTools_cprintf('text',   'regular black text');
%    fcn_DebugTools_cprintf('hyper',  'followed %s','by');
%    fcn_DebugTools_cprintf('key',    '%d colored', 4);
%    fcn_DebugTools_cprintf('-comment','& underlined');
%    fcn_DebugTools_cprintf('err',    'elements\n');
%    fcn_DebugTools_cprintf('cyan',   'cyan');
%    fcn_DebugTools_cprintf('_green', 'underlined green');
%    fcn_DebugTools_cprintf(-[1,0,1], 'underlined magenta');
%    fcn_DebugTools_cprintf([1,0.5,0],'and multi-\nline orange\n');
%    fcn_DebugTools_cprintf('*blue',  'and *bold* (R2011b+ only)\n');
%    fcn_DebugTools_cprintf('string');  % same as fprintf('string') and fcn_DebugTools_cprintf('text','string')
%
% Bugs and suggestions:
%    Please send to Yair Altman (altmany at gmail dot com)
%
% Warning:
%    This code heavily relies on undocumented and unsupported Matlab
%    functionality. It works on Matlab 7+, but use at your own risk!
%
%    A technical description of the implementation can be found at:
%    <a href="http://undocumentedmatlab.com/articles/cprintf">http://UndocumentedMatlab.com/articles/cprintf</a>
%
% Limitations:
%    1. In R2011a and earlier, a single space char is inserted at the
%       beginning of each CPRINTF text segment (this is ok in R2011b+).
%
%    2. In R2011a and earlier, consecutive differently-colored multi-line
%       CPRINTFs sometimes display incorrectly on the bottom line.
%       As far as I could tell this is due to a Matlab bug. Examples:
%         >> cprintf('-str','under\nline'); cprintf('err','red\n'); % hidden 'red', unhidden '_'
%         >> cprintf('str','regu\nlar'); cprintf('err','red\n'); % underline red (not purple) 'lar'
%
%    3. Sometimes, non newline ('\n')-terminated segments display unstyled
%       (black) when the command prompt chevron ('>>') regains focus on the
%       continuation of that line (I can't pinpoint when this happens). 
%       To fix this, simply newline-terminate all command-prompt messages.
%
%    4. In R2011b and later, the above errors appear to be fixed. However,
%       the last character of an underlined segment is not underlined for
%       some unknown reason (add an extra space character to make it look better)
%
%    5. In old Matlab versions (e.g., Matlab 7.1 R14), multi-line styles
%       only affect the first line. Single-line styles work as expected.
%       R14 also appends a single space after underlined segments.
%
%    6. Bold style is only supported on R2011b+, and cannot also be underlined.
%
% Change log:
%    2009-05-13: First version posted on <a href="http://www.mathworks.com/matlabcentral/fileexchange/authors/27420">MathWorks File Exchange</a>
%    2009-05-28: corrected nargout behavior suggested by Andreas Gäb
%    2009-09-28: Fixed edge-case problem reported by Swagat K
%    2010-06-27: Fix for R2010a/b; fixed edge case reported by Sharron; CPRINTF with no args runs the demo
%    2011-03-04: Performance improvement
%    2011-08-29: Fix by Danilo (FEX comment) for non-default text colors
%    2011-11-27: Fixes for R2011b
%    2012-08-06: Fixes for R2012b; added bold style; accept RGB string (non-numeric) style
%    2012-08-09: Graceful degradation support for deployed (compiled) and non-desktop applications; minor bug fixes
%    2015-03-20: Fix: if command window isn't defined yet (startup) use standard fprintf as suggested by John Marozas
%    2015-06-24: Fixed a few discoloration issues (some other issues still remain)
%    2020-01-20: Fix by T. Hosman for embedded hyperlinks
%    2021-04-07: Enabled specifying color as #RGB (hexa codes), [.1,.7,.3], [26,178,76]
%    2022-01-04: Fixed cases of invalid colors (especially bad on R2021b onward)
%    2022-03-26: Fixed cases of using string (not char) inputs
%
% See also:
%    sprintf, fprintf
% 
% Copyright (c) 2015, Yair Altman. License to use and modify this code is
% granted freely to all interested, as long as the original author is
% referenced and attributed as such. The original author maintains the
% right to be solely associated with this work.
%
% SPECIFICALLY:
% This is a wrapper function for the CPRINT function:
% https://www.mathworks.com/matlabcentral/fileexchange/24093-cprintf-display-formatted-colored-text-in-command-window
%
% Copyright (c) 2015, 2026 Yair Altman
% All rights reserved.
% 
% Redistribution and use in source and binary forms, with or without
% modification, are permitted provided that the following conditions are met:
% 
% * Redistributions of source code must retain the above copyright notice, this
%   list of conditions and the following disclaimer.
% 
% * Redistributions in binary form must reproduce the above copyright notice,
%   this list of conditions and the following disclaimer in the documentation
%   and/or other materials provided with the distribution
% 
% * Neither the name of Consultant nor the names of its
%   contributors may be used to endorse or promote products derived from this
%   software without specific prior written permission.
% 
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
% AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
% IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
% DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
% FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
% DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
% SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
% CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
% OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
% OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

% REVISION HISTORY:
% 
% 2025_11_23 by Sean Brennan, sbrennan@psu.edu
% - Added this revision history area
% 2026_01_11 by Sean Brennan, sbrennan@psu.edu
% - Updated to latest version

% TO-DO:
% 2025_11_20 by Sean Brennan, sbrennan@psu.edu
% - fill in to-do items here.

cprintf(style,format)