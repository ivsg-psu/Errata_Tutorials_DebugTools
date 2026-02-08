function fcn_DebugTools_imagesConvertToJPG(sourceDirectory, destinationDirectory, imageSize, varargin)
% fcn_DebugTools_imagesConvertToJPG - Convert and resize images to JPG
% Supported: any formats readable by imread (JPG, PNG, GIF, TIFF, BMP, ...).
% FORMAT:
%
%      fcn_DebugTools_imagesConvertToJPG(sourceDirectory, destinationDirectory, imageSize, (figNum))
%
% INPUTS:
%
%      sourceDirectory: path to source folder containing images
%
%      destinationDirectory: path to destination folder (created if needed)
%
%      imageSize: scalar or [rows cols] target size (pixels)
%
%      (OPTIONAL INPUTS)
%
%      figNum: a FID number to print results. If set to -1, skips any
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
%     convert_images_to_jpg('C:\images_src','C:\images_jpg',[256 256])
%
% See the script: script_test_fcn_DebugTools_imagesConvertToJPG
% for a full test suite.
%
% This function was written on 2026_01_26 by S. Brennan.
% Questions or comments? sbrennan@psu.edu

% REVISION HISTORY:
%
% 2026_01_26 by Sean Brennan, sbrennan@psu.edu
% - In fcn_DebugTools_imagesConvertToJPG
%   % * First write of the code. used Copilot as starter.

% TO-DO:
% 2026_01_12 by Sean Brennan, sbrennan@psu.edu
% - (add items here)

%% Debugging and Input checks

% Check if flag_max_speed set. This occurs if the figNum variable input
% argument (varargin) is given a number of -1, which is not a valid figure
% number.
MAX_NARGIN = 4; % The largest Number of argument inputs to the function
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
		narginchk(MAX_NARGIN-1,MAX_NARGIN);

		% Check the sourceDirectory input, that it is string/char and a
		% folder
		fcn_DebugTools_checkInputsToFunctions(sourceDirectory, '_of_char_strings')
		fcn_DebugTools_checkInputsToFunctions(sourceDirectory, 'DoesDirectoryExist');


		% Check the destinationDirectory input, that it is string/char and a
		% folder
		fcn_DebugTools_checkInputsToFunctions(destinationDirectory, '_of_char_strings')
		fcn_DebugTools_checkInputsToFunctions(destinationDirectory, 'DoesDirectoryExist');

	end
end


% Check to see if user specifies figNum?
flag_do_plots = 0; % Default is to NOT show plots
figNum = 1; % % Default is to print to the console
if (0==flag_max_speed) && (MAX_NARGIN == nargin)
	temp = varargin{end};
	if ~isempty(temp)
		figNum = temp; 
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

% Normalize imageSize
if isscalar(imageSize)
	imageSize = [imageSize, imageSize];
elseif numel(imageSize) ~= 2
	error('imageSize must be scalar or a 2-element vector [rows cols].');
end

% Check folders
if ~isfolder(sourceDirectory)
	error('Source directory does not exist: %s', sourceDirectory);
end
if ~isfolder(destinationDirectory)
	mkdir(destinationDirectory);
end

% Get list of files in source folder
files = dir(fullfile(sourceDirectory, '*'));
files = files(~[files.isdir]);  % skip directories

for k = 1:numel(files)
	srcName = files(k).name;
	srcPath = fullfile(sourceDirectory, srcName);

	% Try reading the file as an image
	try
		[I, map, alpha] = imread(srcPath);
	catch
		% Not an image or unreadable -> skip
		continue
	end

	Isource = I;

	% If indexed image (map provided), convert to RGB
	if ~isempty(map)
		I = ind2rgb(I, map);       % returns double in [0,1]
		I = im2uint8(I);
		map = []; %#ok<NASGU>
	end

	% If grayscale, convert to RGB
	if ndims(I) == 2 %#ok<ISMAT>
		I = cat(3, I, I, I);
	end

	% If alpha channel provided separate or as 4th channel, handle it
	if ~isempty(alpha)
		% alpha returned separately (logical or numeric)
		A = im2double(alpha);
		RGB = im2double(I(:,:,1:3));
		bg = ones(size(RGB)); % white background
		RGB = RGB .* A + bg .* (1 - A);
		I = im2uint8(RGB);
	elseif size(I,3) == 4
		% 4th channel included in I
		A = im2double(I(:,:,4));
		RGB = im2double(I(:,:,1:3));
		bg = ones(size(RGB));
		RGB = RGB .* A + bg .* (1 - A);
		I = im2uint8(RGB);
	end

	% Resize
	try
		J = imresize(I, imageSize);
	catch ME
		warning('Failed to resize %s: %s', srcName, ME.message);
		continue
	end

	% Write as JPEG (use original name, change extension)
	[~, name, ~] = fileparts(srcName);
	dstPath = fullfile(destinationDirectory, [name, '.jpg']);
	try
		imwrite(J, dstPath, 'Quality', 90);
	catch ME
		warning('Failed to write %s: %s', dstPath, ME.message);
		continue
	end

	if 1 == flag_do_plots

		figure(figNum);
		subplot(1,2,1);
		imshow(Isource);
		title('Image 1');

		subplot(1,2,2);
		imshow(J);
		title('Image 2');

	end % Ends the flag_do_plot if statement
	pause(0.5);
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

if flag_do_debug
	fprintf(1,'ENDING function: %s, in file: %s\n\n',st(1).name,st(1).file);
end

end % Ends the main function

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



