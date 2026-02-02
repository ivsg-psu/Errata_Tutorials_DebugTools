function labels = fcn_DebugTools_imagesAddLabelsInteractive(sourceDirectory, oldLabels, varargin)
% fcn_DebugTools_imagesAddLabelsInteractive - Prompt user to describe each image in a folder
%   The function is nonrecursive and skips unreadable files.
%
% FORMAT:
%
%      labels = fcn_DebugTools_imagesAddLabelsInteractive(sourceDirectory, oldLabels, (figNum))
%
% INPUTS:
%
%      sourceDirectory: path to source folder containing images
%
%      oldLabels: previous labels, to use as starters. If none exist, just
%      leave empty.
%
%      (OPTIONAL INPUTS)
%
%      figNum: a FID number to print results. If set to -1, skips any
%      input checking or debugging, no prints will be generated, and sets
%      up code to maximize speed.
%
% OUTPUTS:
%
%      labels: N-by-4 cell array: {filename, image, description, isVehicle}
%
% DEPENDENCIES:
%
%      fcn_DebugTools_checkInputsToFunctions
%
% EXAMPLES:
%
% See the script: script_test_fcn_DebugTools_imagesAddLabelsInteractive
% for a full test suite.
%
% This function was written on 2026_01_26 by S. Brennan.
% Questions or comments? sbrennan@psu.edu

% REVISION HISTORY:
%
% 2026_01_26 by Sean Brennan, sbrennan@psu.edu
% - In fcn_DebugTools_imagesAddLabelsInteractive
% - first write of the code. used Copilot as starter.

% TO-DO:
% 2026_01_12 by Sean Brennan, sbrennan@psu.edu
% - (add items here)

%% Debugging and Input checks

% Check if flag_max_speed set. This occurs if the figNum variable input
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
		narginchk(MAX_NARGIN-1,MAX_NARGIN);

		% Check the sourceDirectory input, that it is string/char and a
		% folder
		fcn_DebugTools_checkInputsToFunctions(sourceDirectory, '_of_char_strings')
		fcn_DebugTools_checkInputsToFunctions(sourceDirectory, 'DoesDirectoryExist');

	end
end


% Check to see if user specifies figNum?
flag_do_plots = 0; %#ok<NASGU> % Default is to NOT show plots
figNum = 1; % % Default is to print to the console
if (0==flag_max_speed) && (MAX_NARGIN == nargin)
	temp = varargin{end};
	if ~isempty(temp)
		figNum = temp; 
		flag_do_plots = 1; %#ok<NASGU>
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

% Common image extensions (add more if needed)
exts = {'*.jpg','*.jpeg','*.png','*.gif','*.tif','*.tiff','*.bmp','*.pbm','*.pgm','*.ppm'};
files = [];
for i = 1:numel(exts)
	files = [files; dir(fullfile(sourceDirectory, exts{i}))]; %#ok<AGROW>
end

% Remove duplicates and sort
if isempty(files)
	labels = cell(0,4);
	return
end

[~, idx] = unique({files.name});
files = files(sort(idx));

% Prepare output
N = numel(files);
labels = cell(N,4);


hFig = figure(figNum);
set(hFig,'Name','Image Labeling','NumberTitle','off');

for k = 1:N
	fname = files(k).name;
	fpath = fullfile(sourceDirectory, fname);

	% Try read image
	try
		I = imread(fpath);
	catch
		warning('Skipping unreadable file: %s', fname);
		continue
	end
	Ioriginal = I;

	% Normalize grayscale to RGB for consistent display
	if ndims(I) == 2 %#ok<ISMAT>
		I = cat(3, I, I, I);
	elseif size(I,3) > 3
		I = I(:,:,1:3); % drop alpha if present (display on white not handled)
	end

	% Display
	clf(hFig);
	imshow(I);
	title(sprintf('File %d of %d: %s', k, N, fname), 'Interpreter', 'none');

	% Prompt for description
	default = '';
	flagDefaultExists = 0;
	if ~isempty(oldLabels)
		temp = find(strcmp(fname,oldLabels(:,1)),1,'first');
		if ~isempty(temp)
			default = sprintf(' (default is: %s)', oldLabels{temp,3});
			flagDefaultExists = 1;
		end
	end
	
	isVehicle = ~contains(fname,'NoSlip','IgnoreCase',true);

	eval(cat(2,'cl','c'));
	if isVehicle
		prefix = 'This is a vehicle.';
	else
		prefix = 'This is NOT a vehicle.';
	end
	prompt = sprintf('%s Enter description for "%s"%s: ', prefix, fname, default);
	desc = input(prompt, 's');
	if isempty(desc) && (flagDefaultExists == 1)
		desc = oldLabels{temp,3};
	end


	% labels: N-by-4 cell array: {filename, image, description, isVehicle}
	labels{k,1} = fname;
	labels{k,2} = Ioriginal;
	labels{k,3} = desc; 
	labels{k,4} = isVehicle; 
end

if ishandle(hFig)
	close(hFig);
end

% Remove any rows for skipped unreadable files (if any were skipped)
validIdx = ~cellfun(@isempty, labels(:,1));
labels = labels(validIdx, :);

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



