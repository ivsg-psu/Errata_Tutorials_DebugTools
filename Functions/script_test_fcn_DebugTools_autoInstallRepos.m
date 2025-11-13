% script_test_fcn_DebugTools_autoInstallRepos.m
% Tests fcn_DebugTools_autoInstallRepos
% Written in 2025_11_10 by S.Brennan

% Revision history:
% 2025_11_10 - S. Brennan, sbrennan@psu.edu
% -- wrote the code originally using
% script_test_fcn_DebugTools_installDependencies as a starter

% TO DO
% 2025_11_12 - S. Brennan, sbrennan@psu.edu
% -- Add input argument checking
% -- Add fastmode tests

%% Set up the workspace
close all

%% Code demos start here
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   _____                              ____   __    _____          _
%  |  __ \                            / __ \ / _|  / ____|        | |
%  | |  | | ___ _ __ ___   ___  ___  | |  | | |_  | |     ___   __| | ___
%  | |  | |/ _ \ '_ ` _ \ / _ \/ __| | |  | |  _| | |    / _ \ / _` |/ _ \
%  | |__| |  __/ | | | | | (_) \__ \ | |__| | |   | |___| (_) | (_| |  __/
%  |_____/ \___|_| |_| |_|\___/|___/  \____/|_|    \_____\___/ \__,_|\___|
%
%
% See: https://patorjk.com/software/taag/#p=display&f=Big&t=Demos%20Of%20Code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Figures start with 1

close all;
fprintf(1,'Figure: 1XXXXXX: DEMO cases\n');

%% DEMO case: basic test case installing DebugTools only, no Installer
figNum = 10001;
titleString = sprintf('DEMO case: basic test case installing DebugTools only, no Installer');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);
% figure(figNum); clf;

fullPathToInstaller = fullfile(pwd,'Installer');
if exist(fullPathToInstaller,'dir')
    rmdir('Installer','s');
end

% Remove the folders from path, to avoid deletion warnings
fcn_INTERNAL_clearUtilitiesFromPathAndFolders;

% Confirm that the Utilities are NOT installed
tempPath = dir(fullfile(pwd,'Utilities','DebugTools*'));
assert(isempty(tempPath));

% Define a universal resource locator (URL) pointing to the zip file to
% install. For example, here is the zip file location to the Debugtools
% package on GitHub:
clear dependencyURLs dependencySubfolders
dependencyURLs = 'https://github.com/ivsg-psu/Errata_Tutorials_DebugTools';

% Define sub-subfolders that are in the code package that also need to be
% added to the MATLAB path after install. Leave empty ({}) to only add
% the subfolder path without any sub-subfolder path additions.
dependencySubfolders = {'Functions','Data'};

% Do we want to force the installs?
flagForceInstalls = 0;

% Call the function to do the install
fcn_DebugTools_autoInstallRepos(dependencyURLs, dependencySubfolders, (flagForceInstalls), (figNum));

% Confirm that the Utilities were installed
tempPath = dir(fullfile(pwd,'Utilities','DebugTools*'));
assert(~isempty(tempPath));

% Remove the folders from path, to avoid deletion warnings
fcn_INTERNAL_clearUtilitiesFromPathAndFolders;
tempPath = dir(fullfile(pwd,'Utilities','DebugTools*'));
assert(isempty(tempPath));

% Show that the Installer directory was created
assert(exist(fullPathToInstaller,'dir'))


% sgtitle(titleString, 'Interpreter','none');

% % Check variable types
% assert(isnumeric(visibilityMatrix));
% assert(isstruct(visibilityDetailsEachFromPoint));
% 
% % Check variable sizes
% NpolyVertices = length([polytopes.xv]);
% assert(size(visibilityMatrix,1)==NpolyVertices+2);
% assert(size(visibilityMatrix,2)==NpolyVertices+2);
% assert(size(visibilityDetailsEachFromPoint,2)==NpolyVertices+2);
% 
% % Check variable values
% % Check manually
% 
% % Make sure plot opened up
% assert(isequal(get(gcf,'Number'),figNum));

%% DEMO case: auto-installing several repos (Debug is automatic)
figNum = 10002;
titleString = sprintf('DEMO case: auto-installing several repos (Debug is automatic)');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);
% figure(figNum); clf;

% currentFolder = pwd;
% 
% mkdir('TempTestFolder');
% cd('TempTestFolder');

% Remove the folders from path, to avoid deletion warnings
fcn_INTERNAL_clearUtilitiesFromPathAndFolders;

% Confirm that the Utilities are NOT installed
tempPath = dir(fullfile(pwd,'Utilities','DebugTools*'));
assert(isempty(tempPath));

% Define a universal resource locator (URL) pointing to the repos of
% dependencies to install. Note that DebugTools is always installed
% automatically, first, even if not listed:
clear dependencyURLs dependencySubfolders
ith_repo = 0;

ith_repo = ith_repo+1;
dependencyURLs{ith_repo} = 'https://github.com/ivsg-psu/PathPlanning_MapTools_MapGenClassLibrary';
dependencySubfolders{ith_repo} = {'Functions','testFixtures','GridMapGen'};

ith_repo = ith_repo+1;
dependencyURLs{ith_repo} = 'https://github.com/ivsg-psu/PathPlanning_PathTools_PathClassLibrary';
dependencySubfolders{ith_repo} = {'Functions','Data'};

ith_repo = ith_repo+1;
dependencyURLs{ith_repo} = 'https://github.com/ivsg-psu/FieldDataCollection_VisualizingFieldData_PlotRoad';
dependencySubfolders{ith_repo} = {'Functions','Data'};

ith_repo = ith_repo+1;
dependencyURLs{ith_repo} = 'https://github.com/ivsg-psu/PathPlanning_GeomTools_GeomClassLibrary';
dependencySubfolders{ith_repo} = {'Functions','Data'};



% Define sub-subfolders that are in the code package that also need to be
% added to the MATLAB path after install. Leave empty ({}) to only add
% the subfolder path without any sub-subfolder path additions.

% Do we want to force the installs?
flagForceInstalls = 0;

% Call the function to do the install
fcn_DebugTools_autoInstallRepos(dependencyURLs, dependencySubfolders, (flagForceInstalls), (figNum));

% Confirm that the Utilities were installed
tempPath = dir(fullfile(pwd,'Utilities','DebugTools*'));
assert(~isempty(tempPath));

% Remove the folders from path, to avoid deletion warnings
fcn_INTERNAL_clearUtilitiesFromPathAndFolders;
tempPath = dir(fullfile(pwd,'Utilities','DebugTools*'));
assert(isempty(tempPath));

% sgtitle(titleString, 'Interpreter','none');

% % Check variable types
% assert(isnumeric(visibilityMatrix));
% assert(isstruct(visibilityDetailsEachFromPoint));
% 
% % Check variable sizes
% NpolyVertices = length([polytopes.xv]);
% assert(size(visibilityMatrix,1)==NpolyVertices+2);
% assert(size(visibilityMatrix,2)==NpolyVertices+2);
% assert(size(visibilityDetailsEachFromPoint,2)==NpolyVertices+2);
% 
% % Check variable values
% % Check manually
% 
% % Make sure plot opened up
% assert(isequal(get(gcf,'Number'),figNum));

%% DEMO case: calling using a function handle, to avoid adding to Path
figNum = 10003;
titleString = sprintf('DEMO case: calling using a function handle, to avoid adding to Path');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);
% figure(figNum); clf;

% currentFolder = pwd;
% 
% mkdir('TempTestFolder');
% cd('TempTestFolder');

% Remove the folders from path, to avoid deletion warnings
fcn_INTERNAL_clearUtilitiesFromPathAndFolders;

% Confirm that the Utilities are NOT installed
tempPath = dir(fullfile(pwd,'Utilities','DebugTools*'));
assert(isempty(tempPath));

% Define a universal resource locator (URL) pointing to the zip file to
% install. For example, here is the zip file location to the Debugtools
% package on GitHub:
clear dependencyURLs dependencySubfolders
dependencyURLs = 'https://github.com/ivsg-psu/Errata_Tutorials_DebugTools';

% Define sub-subfolders that are in the code package that also need to be
% added to the MATLAB path after install. Leave empty ({}) to only add
% the subfolder path without any sub-subfolder path additions.
dependencySubfolders = {'Functions','Data'};

% Do we want to force the installs?
flagForceInstalls = 0;

% Navigate to the Installer directory
currentFolder = pwd;
cd('Installer');
% Create a function handle
func_handle = @fcn_DebugTools_autoInstallRepos; 

% Return to the original directory
cd(currentFolder); 

% Call the function to do the install
func_handle(dependencyURLs, dependencySubfolders, (flagForceInstalls), (figNum));

% Confirm that the Utilities were installed
tempPath = dir(fullfile(pwd,'Utilities','DebugTools*'));
assert(~isempty(tempPath));

% Remove the folders from path, to avoid deletion warnings
fcn_INTERNAL_clearUtilitiesFromPathAndFolders;
tempPath = dir(fullfile(pwd,'Utilities','DebugTools*'));
assert(isempty(tempPath));

% sgtitle(titleString, 'Interpreter','none');

% % Check variable types
% assert(isnumeric(visibilityMatrix));
% assert(isstruct(visibilityDetailsEachFromPoint));
% 
% % Check variable sizes
% NpolyVertices = length([polytopes.xv]);
% assert(size(visibilityMatrix,1)==NpolyVertices+2);
% assert(size(visibilityMatrix,2)==NpolyVertices+2);
% assert(size(visibilityDetailsEachFromPoint,2)==NpolyVertices+2);
% 
% % Check variable values
% % Check manually
% 
% % Make sure plot opened up
% assert(isequal(get(gcf,'Number'),figNum));

%% Test cases start here. These are very simple, usually trivial
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  _______ ______  _____ _______ _____
% |__   __|  ____|/ ____|__   __/ ____|
%    | |  | |__  | (___    | | | (___
%    | |  |  __|  \___ \   | |  \___ \
%    | |  | |____ ____) |  | |  ____) |
%    |_|  |______|_____/   |_| |_____/
%
%
%
% See: https://patorjk.com/software/taag/#p=display&f=Big&t=TESTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Figures start with 2

close all;
fprintf(1,'Figure: 2XXXXXX: TEST mode cases\n');

%% TEST case: two Debug install requests, resulting in only one actual install
figNum = 20001;
titleString = sprintf('TEST case: two Debug install requests, resulting in only one actual install');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);
% figure(figNum); clf;

% Remove the folders from path, to avoid deletion warnings
fcn_INTERNAL_clearUtilitiesFromPathAndFolders;

% Confirm that the Utilities are NOT installed
tempPath = dir(fullfile(pwd,'Utilities','DebugTools*'));
assert(isempty(tempPath));

% Define a universal resource locator (URL) pointing to the zip file to
% install. For example, here is the zip file location to the Debugtools
% package on GitHub:
clear dependencyURLs dependencySubfolders
dependencyURLs{1,1} = 'https://github.com/ivsg-psu/Errata_Tutorials_DebugTools/archive/refs/tags/DebugTools_v2025_11_06.zip';
dependencySubfolders{1,1} = {'Functions','Data'};
dependencyURLs{2,1} = 'https://github.com/ivsg-psu/Errata_Tutorials_DebugTools/archive/refs/tags/DebugTools_v2025_09_19c.zip';
dependencySubfolders{2,1} = {'Functions','Data'};


% Do we want to force the installs?
flagForceInstalls = 0;

% Call the function to do the install
fcn_DebugTools_autoInstallRepos(dependencyURLs, dependencySubfolders, (flagForceInstalls), (figNum));

% Confirm that the Utilities were installed
tempPath = dir(fullfile(pwd,'Utilities','DebugTools*'));
assert(~isempty(tempPath));

% Remove the folders from path, to avoid deletion warnings
fcn_INTERNAL_clearUtilitiesFromPathAndFolders;
tempPath = dir(fullfile(pwd,'Utilities','DebugTools*'));
assert(isempty(tempPath));

% sgtitle(titleString, 'Interpreter','none');

% % Check variable types
% assert(isnumeric(visibilityMatrix));
% assert(isstruct(visibilityDetailsEachFromPoint));
% 
% % Check variable sizes
% NpolyVertices = length([polytopes.xv]);
% assert(size(visibilityMatrix,1)==NpolyVertices+2);
% assert(size(visibilityMatrix,2)==NpolyVertices+2);
% assert(size(visibilityDetailsEachFromPoint,2)==NpolyVertices+2);
% 
% % Check variable values
% % Check manually
% 
% % Make sure plot opened up
% assert(isequal(get(gcf,'Number'),figNum));

%% TEST case: old Debug install automatically replaced by new one
figNum = 20002;
titleString = sprintf('TEST case: two old Debug installs, resulting in only one actual new install');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);
% figure(figNum); clf;

% Remove the folders from path, to avoid deletion warnings
fcn_INTERNAL_clearUtilitiesFromPathAndFolders;

% Confirm that the Utilities are NOT installed
tempPath = dir(fullfile(pwd,'Utilities','DebugTools*'));
assert(isempty(tempPath));

% Install first OLD version of DebugTools. 
% Use installDependencies function to
% force the install to use old version.
% NOTE: this installs under the current directory!
% Define the name of subfolder to be created in "Utilities" subfolder
dependency_name = 'DebugTools_v2025_07_15';

% Define sub-subfolders that are in the code package that also need to be
% added to the MATLAB path after install. Leave empty ({}) to only add
% the subfolder path without any sub-subfolder path additions.
dependency_subfolders = {'Functions','Data'};

% Define a universal resource locator (URL) pointing to the zip file to
% install. For example, here is the zip file location to the Debugtools
% package on GitHub:
dependency_url = 'https://github.com/ivsg-psu/Errata_Tutorials_DebugTools/archive/refs/tags/DebugTools_v2025_07_15.zip';

% Call the function to do the install
fcn_DebugTools_installDependencies(dependency_name, dependency_subfolders, dependency_url)

% Make sure install worked
tempPath = dir(fullfile(pwd,'Utilities','DebugTools_v2025_07_15'));
assert(~isempty(tempPath));

% Install second OLD version of DebugTools. 
% Use installDependencies function to
% force the install to use old version.
% NOTE: this installs under the current directory!
% Define the name of subfolder to be created in "Utilities" subfolder
dependency_name = 'DebugTools_v2025_09_19';

% Define sub-subfolders that are in the code package that also need to be
% added to the MATLAB path after install. Leave empty ({}) to only add
% the subfolder path without any sub-subfolder path additions.
dependency_subfolders = {'Functions','Data'};

% Define a universal resource locator (URL) pointing to the zip file to
% install. For example, here is the zip file location to the Debugtools
% package on GitHub:
dependency_url = 'https://github.com/ivsg-psu/Errata_Tutorials_DebugTools/archive/refs/tags/DebugTools_v2025_09_19.zip';

% Call the function to do the install
fcn_DebugTools_installDependencies(dependency_name, dependency_subfolders, dependency_url)

% Make sure install worked
tempPath = dir(fullfile(pwd,'Utilities','DebugTools_v2025_09_19'));
assert(~isempty(tempPath));



% Now, using one of the SAME URLs as listed above, show that the install
% overwrites old versions to install the new version.

% Define a universal resource locator (URL) pointing to the zip file to
% install. For example, here is the zip file location to the Debugtools
% package on GitHub:
clear dependencyURLs dependencySubfolders
dependencyURLs = 'https://github.com/ivsg-psu/Errata_Tutorials_DebugTools/blob/main/Releases/DebugTools_v2023_01_25.zip?raw=true';
dependencySubfolders{1,1} = {'Functions','Data'};


% Do we want to force the installs?
flagForceInstalls = 0;

% Call the function to do the install
fcn_DebugTools_autoInstallRepos(dependencyURLs, dependencySubfolders, (flagForceInstalls), (figNum));

% Confirm that the Utilities were installed
tempPath = dir(fullfile(pwd,'Utilities','DebugTools*'));
assert(~isempty(tempPath));

% Confirm that this install does NOT include old version!
tempPath = dir(fullfile(pwd,'Utilities','DebugTools_v2023_01_25'));
assert(isempty(tempPath));

% Remove the folders from path, to avoid deletion warnings
fcn_INTERNAL_clearUtilitiesFromPathAndFolders;
tempPath = dir(fullfile(pwd,'Utilities','DebugTools*'));
assert(isempty(tempPath));

% sgtitle(titleString, 'Interpreter','none');

% % Check variable types
% assert(isnumeric(visibilityMatrix));
% assert(isstruct(visibilityDetailsEachFromPoint));
% 
% % Check variable sizes
% NpolyVertices = length([polytopes.xv]);
% assert(size(visibilityMatrix,1)==NpolyVertices+2);
% assert(size(visibilityMatrix,2)==NpolyVertices+2);
% assert(size(visibilityDetailsEachFromPoint,2)==NpolyVertices+2);
% 
% % Check variable values
% % Check manually
% 
% % Make sure plot opened up
% assert(isequal(get(gcf,'Number'),figNum));

%% TEST case: 2 old and 1 current Debug install. Skips install and cleans.
figNum = 20003;
titleString = sprintf('TEST case: 2 old and 1 current Debug install. Skips install and cleans.');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);
% figure(figNum); clf;

% Remove the folders from path, to avoid deletion warnings
fcn_INTERNAL_clearUtilitiesFromPathAndFolders;

% Confirm that the Utilities are NOT installed
tempPath = dir(fullfile(pwd,'Utilities','DebugTools*'));
assert(isempty(tempPath));

% Install first OLD version of DebugTools. 
% Use installDependencies function to
% force the install to use old version.
% NOTE: this installs under the current directory!
% Define the name of subfolder to be created in "Utilities" subfolder
dependency_name = 'DebugTools_v2025_07_15';

% Define sub-subfolders that are in the code package that also need to be
% added to the MATLAB path after install. Leave empty ({}) to only add
% the subfolder path without any sub-subfolder path additions.
dependency_subfolders = {'Functions','Data'};

% Define a universal resource locator (URL) pointing to the zip file to
% install. For example, here is the zip file location to the Debugtools
% package on GitHub:
dependency_url = 'https://github.com/ivsg-psu/Errata_Tutorials_DebugTools/archive/refs/tags/DebugTools_v2025_07_15.zip';

% Call the function to do the install
fcn_DebugTools_installDependencies(dependency_name, dependency_subfolders, dependency_url)

% Make sure install worked
tempPath = dir(fullfile(pwd,'Utilities','DebugTools_v2025_07_15'));
assert(~isempty(tempPath));

% Install second OLD version of DebugTools. 
% Use installDependencies function to
% force the install to use old version.
% NOTE: this installs under the current directory!
% Define the name of subfolder to be created in "Utilities" subfolder
dependency_name = 'DebugTools_v2025_09_19';

% Define sub-subfolders that are in the code package that also need to be
% added to the MATLAB path after install. Leave empty ({}) to only add
% the subfolder path without any sub-subfolder path additions.
dependency_subfolders = {'Functions','Data'};

% Define a universal resource locator (URL) pointing to the zip file to
% install. For example, here is the zip file location to the Debugtools
% package on GitHub:
dependency_url = 'https://github.com/ivsg-psu/Errata_Tutorials_DebugTools/archive/refs/tags/DebugTools_v2025_09_19.zip';

% Call the function to do the install
fcn_DebugTools_installDependencies(dependency_name, dependency_subfolders, dependency_url)

% Make sure install worked
tempPath = dir(fullfile(pwd,'Utilities','DebugTools_v2025_09_19'));
assert(~isempty(tempPath));


% Install NEW version of DebugTools. 
owner = 'ivsg-psu';
repoName = 'Errata_Tutorials_DebugTools';

% Check latest release
latestReleaseStruct = fcn_DebugTools_findLatestGitHubRelease(owner, repoName, (-1));
dependency_name      = latestReleaseStruct.tag_name;
dependency_subfolders = {'Functions','Data'};
dependency_url        = cat(2,'https://github.com/',...
    owner,'/',...
    repoName,'/archive/refs/tags/',...
    dependency_name,'.zip');


% Use installDependencies function to
% force the install to use old version.
% Call the function to do the install
fcn_DebugTools_installDependencies(dependency_name, dependency_subfolders, dependency_url)

% Make sure install worked
pathName = fullfile(pwd,'Utilities',dependency_name);
tempPath = dir(pathName);
assert(~isempty(tempPath));

% Remove the folder from the path
% Clear out any path directories under Utilities
% Otherwise, test that follows will call subdirectory 
path_dirs = regexp(path,'[;]','split');
for ith_dir = 1:length(path_dirs)
    utility_flag = strfind(path_dirs{ith_dir},pathName);
    if ~isempty(utility_flag)
        rmpath(path_dirs{ith_dir});
    end
end



% Now, using one of the SAME OLD URLs as listed above, show that the install
% overwrites old versions to install the new version.

% Define a universal resource locator (URL) pointing to the zip file to
% install. For example, here is the zip file location to the Debugtools
% package on GitHub:
clear dependencyURLs dependencySubfolders
dependencyURLs = 'https://github.com/ivsg-psu/Errata_Tutorials_DebugTools/blob/main/Releases/DebugTools_v2023_01_25.zip?raw=true';
dependencySubfolders{1,1} = {'Functions','Data'};


% Do we want to force the installs?
flagForceInstalls = 0;

% Call the function to do the install
fcn_DebugTools_autoInstallRepos(dependencyURLs, dependencySubfolders, (flagForceInstalls), (figNum));

% Confirm that the Utilities were installed
tempPath = dir(fullfile(pwd,'Utilities','DebugTools*'));
assert(~isempty(tempPath));

% Confirm that this install does NOT include old version!
tempPath = dir(fullfile(pwd,'Utilities','DebugTools_v2023_01_25'));
assert(isempty(tempPath));

% Remove the folders from path, to avoid deletion warnings
fcn_INTERNAL_clearUtilitiesFromPathAndFolders;
tempPath = dir(fullfile(pwd,'Utilities','DebugTools*'));
assert(isempty(tempPath));

% sgtitle(titleString, 'Interpreter','none');

% % Check variable types
% assert(isnumeric(visibilityMatrix));
% assert(isstruct(visibilityDetailsEachFromPoint));
% 
% % Check variable sizes
% NpolyVertices = length([polytopes.xv]);
% assert(size(visibilityMatrix,1)==NpolyVertices+2);
% assert(size(visibilityMatrix,2)==NpolyVertices+2);
% assert(size(visibilityDetailsEachFromPoint,2)==NpolyVertices+2);
% 
% % Check variable values
% % Check manually
% 
% % Make sure plot opened up
% assert(isequal(get(gcf,'Number'),figNum));


%% TEST case: 1 old and many current install. Skips installs and cleans.
figNum = 20004;
titleString = sprintf('DEMO case: auto-installing several repos (Debug is automatic), with one old');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);
% figure(figNum); clf;

% Remove the folders from path, to avoid deletion warnings
fcn_INTERNAL_clearUtilitiesFromPathAndFolders;

% Confirm that the Utilities are NOT installed
tempPath = dir(fullfile(pwd,'Utilities','DebugTools*'));
assert(isempty(tempPath));

%%%%%%%%%%
% Set up situation
% Install first OLD version of MapGen. 
% Use installDependencies function to
% force the install to use old version.
% NOTE: this installs under the current directory!
% Define the name of subfolder to be created in "Utilities" subfolder
dependency_name = 'MapGenClass_v2025_10_07';

% Define sub-subfolders that are in the code package that also need to be
% added to the MATLAB path after install. Leave empty ({}) to only add
% the subfolder path without any sub-subfolder path additions.
dependency_subfolders = {'Functions','testFixtures','GridMapGen'};

% Define a universal resource locator (URL) pointing to the zip file to
% install. For example, here is the zip file location to the Debugtools
% package on GitHub:
dependency_url = 'https://github.com/ivsg-psu/PathPlanning_MapTools_MapGenClassLibrary/archive/refs/tags/MapGenClass_v2025_10_07.zip';

% Call the function to do the install
fcn_DebugTools_installDependencies(dependency_name, dependency_subfolders, dependency_url)

% Make sure install worked
tempPath = dir(fullfile(pwd,'Utilities','MapGenClass_v2025_10_07'));
assert(~isempty(tempPath));


% Install NEW version of PathClass. 
owner = 'ivsg-psu';
repoName = 'PathPlanning_PathTools_PathClassLibrary';

% Check latest release
latestReleaseStruct = fcn_DebugTools_findLatestGitHubRelease(owner, repoName, (-1));
dependency_name      = latestReleaseStruct.tag_name;
dependency_subfolders = {'Functions','Data'};
dependency_url        = cat(2,'https://github.com/',...
    owner,'/',...
    repoName,'/archive/refs/tags/',...
    dependency_name,'.zip');


% Use installDependencies function to
% force the install to use old version.
% Call the function to do the install
fcn_DebugTools_installDependencies(dependency_name, dependency_subfolders, dependency_url)

% Make sure install worked
pathName = fullfile(pwd,'Utilities',dependency_name);
tempPath = dir(pathName);
assert(~isempty(tempPath));

% Remove the folder from the path
% Clear out any path directories under Utilities
% Otherwise, test that follows will call subdirectory 
path_dirs = regexp(path,'[;]','split');
for ith_dir = 1:length(path_dirs)
    utility_flag = strfind(path_dirs{ith_dir},pathName);
    if ~isempty(utility_flag)
        rmpath(path_dirs{ith_dir});
    end
end


%%%%%%%%%%%%
% Prep for install
% Define a universal resource locator (URL) pointing to the zip file to
% install. For example, here is the zip file location to the Debugtools
% package on GitHub:
clear dependencyURLs dependencySubfolders
ith_repo = 0;

ith_repo = ith_repo+1;
dependencyURLs{ith_repo} = 'https://github.com/ivsg-psu/PathPlanning_MapTools_MapGenClassLibrary';
dependencySubfolders{ith_repo} = {'Functions','testFixtures','GridMapGen'};

ith_repo = ith_repo+1;
dependencyURLs{ith_repo} = 'https://github.com/ivsg-psu/PathPlanning_PathTools_PathClassLibrary';
dependencySubfolders{ith_repo} = {'Functions','Data'};

ith_repo = ith_repo+1;
dependencyURLs{ith_repo} = 'https://github.com/ivsg-psu/FieldDataCollection_VisualizingFieldData_PlotRoad';
dependencySubfolders{ith_repo} = {'Functions','Data'};

ith_repo = ith_repo+1;
dependencyURLs{ith_repo} = 'https://github.com/ivsg-psu/PathPlanning_GeomTools_GeomClassLibrary';
dependencySubfolders{ith_repo} = {'Functions','Data'};



% Define sub-subfolders that are in the code package that also need to be
% added to the MATLAB path after install. Leave empty ({}) to only add
% the subfolder path without any sub-subfolder path additions.

% Do we want to force the installs?
flagForceInstalls = 0;

% Call the function to do the install
fcn_DebugTools_autoInstallRepos(dependencyURLs, dependencySubfolders, (flagForceInstalls), (figNum));

% Confirm that the Utilities were installed
tempPath = dir(fullfile(pwd,'Utilities','DebugTools*'));
assert(~isempty(tempPath));

% Remove the folders from path, to avoid deletion warnings
fcn_INTERNAL_clearUtilitiesFromPathAndFolders;
tempPath = dir(fullfile(pwd,'Utilities','DebugTools*'));
assert(isempty(tempPath));

% sgtitle(titleString, 'Interpreter','none');

% % Check variable types
% assert(isnumeric(visibilityMatrix));
% assert(isstruct(visibilityDetailsEachFromPoint));
% 
% % Check variable sizes
% NpolyVertices = length([polytopes.xv]);
% assert(size(visibilityMatrix,1)==NpolyVertices+2);
% assert(size(visibilityMatrix,2)==NpolyVertices+2);
% assert(size(visibilityDetailsEachFromPoint,2)==NpolyVertices+2);
% 
% % Check variable values
% % Check manually
% 
% % Make sure plot opened up
% assert(isequal(get(gcf,'Number'),figNum));
%% Fast Mode Tests
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  ______        _     __  __           _        _______        _
% |  ____|      | |   |  \/  |         | |      |__   __|      | |
% | |__ __ _ ___| |_  | \  / | ___   __| | ___     | | ___  ___| |_ ___
% |  __/ _` / __| __| | |\/| |/ _ \ / _` |/ _ \    | |/ _ \/ __| __/ __|
% | | | (_| \__ \ |_  | |  | | (_) | (_| |  __/    | |  __/\__ \ |_\__ \
% |_|  \__,_|___/\__| |_|  |_|\___/ \__,_|\___|    |_|\___||___/\__|___/
%
%
% See: http://patorjk.com/software/taag/#p=display&f=Big&t=Fast%20Mode%20Tests
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Figures start with 8

close all;
fprintf(1,'Figure: 8XXXXXX: FAST mode cases\n');

% %% Basic example - NO FIGURE
% figNum = 80001;
% fprintf(1,'Figure: %.0f: FAST mode, empty figNum\n',figNum);
% figure(figNum); close(figNum);
% 
% % convex polytope
% convex_polytope(1).vertices = [0 0; 1 1; -1 2; -2 1; -1 0; 0 0];
% convex_polytope(2).vertices = [1.5 1.5; 2 0.5; 3 3; 1.5 2; 1.5 1.5];
% polytopes = fcn_MapGen_polytopesFillFieldsFromVertices(convex_polytope);
% 
% % generate pointsWithData table
% startXY = [-2.5, 1];
% finishXY = [4 1];
% 
% pointsWithData = fcn_VGraph_polytopesGenerateAllPtsTable(polytopes, startXY, finishXY,-1);
% 
% % Calculate visibility graph
% isConcave = [];
% [visibilityMatrix, visibilityDetailsEachFromPoint] = ...
%     fcn_VGraph_clearAndBlockedPointsGlobal(polytopes, pointsWithData, pointsWithData, (isConcave),([]));
% 
% % Check variable types
% assert(isnumeric(visibilityMatrix));
% assert(isstruct(visibilityDetailsEachFromPoint));
% 
% % Check variable sizes
% NpolyVertices = length([polytopes.xv]);
% assert(size(visibilityMatrix,1)==NpolyVertices+2);
% assert(size(visibilityMatrix,2)==NpolyVertices+2);
% assert(size(visibilityDetailsEachFromPoint,2)==NpolyVertices+2);
% 
% % Check variable values
% % Check this manually
% 
% % Make sure plot did NOT open up
% figHandles = get(groot, 'Children');
% assert(~any(figHandles==figNum));
% 
% 
% %% Basic fast mode - NO FIGURE, FAST MODE
% figNum = 80002;
% fprintf(1,'Figure: %.0f: FAST mode, figNum=-1\n',figNum);
% figure(figNum); close(figNum);
% 
% % convex polytope
% convex_polytope(1).vertices = [0 0; 1 1; -1 2; -2 1; -1 0; 0 0];
% convex_polytope(2).vertices = [1.5 1.5; 2 0.5; 3 3; 1.5 2; 1.5 1.5];
% polytopes = fcn_MapGen_polytopesFillFieldsFromVertices(convex_polytope);
% 
% % generate pointsWithData table
% startXY = [-2.5, 1];
% finishXY = [4 1];
% 
% pointsWithData = fcn_VGraph_polytopesGenerateAllPtsTable(polytopes, startXY, finishXY,-1);
% 
% % Calculate visibility graph
% isConcave = [];
% [visibilityMatrix, visibilityDetailsEachFromPoint] = ...
%     fcn_VGraph_clearAndBlockedPointsGlobal(polytopes, pointsWithData, pointsWithData, (isConcave),(-1));
% 
% % Check variable types
% assert(isnumeric(visibilityMatrix));
% assert(isstruct(visibilityDetailsEachFromPoint));
% 
% % Check variable sizes
% NpolyVertices = length([polytopes.xv]);
% assert(size(visibilityMatrix,1)==NpolyVertices+2);
% assert(size(visibilityMatrix,2)==NpolyVertices+2);
% assert(size(visibilityDetailsEachFromPoint,2)==NpolyVertices+2);
% 
% % Check variable values
% % Check this manually
% 
% % Make sure plot did NOT open up
% figHandles = get(groot, 'Children');
% assert(~any(figHandles==figNum));
% 
% 
% %% Compare speeds of pre-calculation versus post-calculation versus a fast variant
% figNum = 80003;
% fprintf(1,'Figure: %.0f: FAST mode comparisons\n',figNum);
% figure(figNum);
% close(figNum);
% 
% % convex polytope
% convex_polytope(1).vertices = [0 0; 1 1; -1 2; -2 1; -1 0; 0 0];
% convex_polytope(2).vertices = [1.5 1.5; 2 0.5; 3 3; 1.5 2; 1.5 1.5];
% polytopes = fcn_MapGen_polytopesFillFieldsFromVertices(convex_polytope);
% 
% % generate pointsWithData table
% startXY = [-2.5, 1];
% finishXY = [4 1];
% isConcave = [];
% 
% pointsWithData = fcn_VGraph_polytopesGenerateAllPtsTable(polytopes, startXY, finishXY,-1);
% 
% Niterations = 10;
% 
% % Do calculation without pre-calculation
% tic;
% for ith_test = 1:Niterations
%     % Call the function
%     [visibilityMatrix, visibilityDetailsEachFromPoint] = ...
%         fcn_VGraph_clearAndBlockedPointsGlobal(polytopes, pointsWithData, pointsWithData, (isConcave),([]));
% end
% slow_method = toc;
% 
% % Do calculation with pre-calculation, FAST_MODE on
% tic;
% for ith_test = 1:Niterations
%     % Call the function
%     [visibilityMatrix, visibilityDetailsEachFromPoint] = ...
%         fcn_VGraph_clearAndBlockedPointsGlobal(polytopes, pointsWithData, pointsWithData, (isConcave),(-1));
% end
% fast_method = toc;
% 
% % Make sure plot did NOT open up
% figHandles = get(groot, 'Children');
% assert(~any(figHandles==figNum));
% 
% % Plot results as bar chart
% figure(373737);
% clf;
% hold on;
% 
% X = categorical({'Normal mode','Fast mode'});
% X = reordercats(X,{'Normal mode','Fast mode'}); % Forces bars to appear in this exact order, not alphabetized
% Y = [slow_method fast_method ]*1000/Niterations;
% bar(X,Y)
% ylabel('Execution time (Milliseconds)')
% 
% 
% % Make sure plot did NOT open up
% figHandles = get(groot, 'Children');
% assert(~any(figHandles==figNum));


%% BUG cases
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  ____  _    _  _____
% |  _ \| |  | |/ ____|
% | |_) | |  | | |  __    ___ __ _ ___  ___  ___
% |  _ <| |  | | | |_ |  / __/ _` / __|/ _ \/ __|
% | |_) | |__| | |__| | | (_| (_| \__ \  __/\__ \
% |____/ \____/ \_____|  \___\__,_|___/\___||___/
%
% See: http://patorjk.com/software/taag/#p=display&v=0&f=Big&t=BUG%20cases
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% All bug case figures start with the number 9

% close all;

%% BUG

%% Fail conditions
if 1==0


    % broken test for 0 gap size special case that is not implemented
    % generate map
    polytopes = fcn_MapGen_generatePolysFromSeedGeneratorNames('haltonset',[low_pt,high_pt]);
    % shink the polytopes so that they are no longer tiled
    gap_size = 0; % desired average maximum radius
    if gap_size ~=0
        polytopes = fcn_MapGen_polytopesShrinkFromEdges(polytopes,gap_size);
    end

    % plot the map
    if flag_do_plot
        fig = 299; % figure to plot on
        line_spec = 'b-'; % edge line plotting
        line_width = 2; % linewidth of the edge
        axes_limits = [0 1 0 1]; % x and y axes limits
        axis_style = 'square'; % plot axes style
        fcn_MapGen_plotPolytopes(polytopes,fig,line_spec,line_width,axes_limits,axis_style);
        hold on
        box on
        xlabel('x [km]')
        ylabel('y [km]')
    end

    % generate pointsWithData table
    pointsWithData = fcn_VGraph_polytopesGenerateAllPtsTable(polytopes, startXY, finishXY,-1);

    % calculate vibility graph
    tic;
    visibilityMatrix = fcn_VGraph_clearAndBlockedPointsGlobal(polytopes,pointsWithData,pointsWithData);
    toc;
    deduped_pts = fcn_convert_polytope_struct_to_deduped_points(pointsWithData);
    % plot visibility graph edges
    if flag_do_plot && gap_size ==0
        for ith_fromIndex = 1:size(visibilityMatrix,1)
            for jth_toIndex = 1:size(visibilityMatrix,1)
                if visibilityMatrix(ith_fromIndex,jth_toIndex) == 1
                    plot([deduped_pts(ith_fromIndex).x,deduped_pts(jth_toIndex).x],[deduped_pts(ith_fromIndex).y,deduped_pts(jth_toIndex).y],'--g','LineWidth',1)
                end
            end
        end
    end
    if flag_do_plot && gap_size ~=0
        for ith_fromIndex = 1:size(visibilityMatrix,1)
            for jth_toIndex = 1:size(visibilityMatrix,1)
                if visibilityMatrix(ith_fromIndex,jth_toIndex) == 1
                    plot([pointsWithData(ith_fromIndex,1),pointsWithData(jth_toIndex,1)],[pointsWithData(ith_fromIndex,2),pointsWithData(jth_toIndex,2)],'--g','LineWidth',2)
                end
            end
        end
    end

end


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

%% function fcn_INTERNAL_clearUtilitiesFromPathAndFolders
function fcn_INTERNAL_clearUtilitiesFromPathAndFolders
% Clear out the variables
clear global flag* FLAG*
clear flag*
clear path

% Clear out any path directories under Utilities
path_dirs = regexp(path,'[;]','split');
utilities_dir = fullfile(pwd,filesep,'Utilities');
for ith_dir = 1:length(path_dirs)
    utility_flag = strfind(path_dirs{ith_dir},utilities_dir);
    if ~isempty(utility_flag)
        rmpath(path_dirs{ith_dir});
    end
end

if 1==0
    % Clear out any path directories containing the word 'Users"
    path_dirs = regexp(path,'[;]','split');
    for ith_dir = 1:length(path_dirs)
        utility_flag = strfind(path_dirs{ith_dir},'Users');
        if ~isempty(utility_flag)
            rmpath(path_dirs{ith_dir});
        end
    end
end

% Delete the Utilities folder, to be extra clean!
if  exist(utilities_dir,'dir')
    [status,message,message_ID] = rmdir(utilities_dir,'s');
    if 0==status
        error('Unable remove directory: %s \nReason message: %s \nand message_ID: %s\n',utilities_dir, message,message_ID);
    end
end

end % Ends fcn_INTERNAL_clearUtilitiesFromPathAndFolders