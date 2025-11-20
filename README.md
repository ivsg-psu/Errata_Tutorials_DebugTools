# DebugTools

<!--
The following template is based on:
Best-README-Template
Search for this, and you will find!
>
<!-- PROJECT LOGO -->
<br />
<p align="center">

<h2 align="center"> Errata_Tutorials_DebugTools  </h2>

<img src=".\Images\Debug_Main_Image.jpg" alt="main debug splash picture" width="960" height="540">
<br />
<font size="-2">Photo by Sigmund on Unsplash</font>

<br />
  <p align="left">

This repo provides common tools used for debugging MATLAB codes within IVSG, and includes input checking, print to workspace, parsing user inputs, and similar functions.
    <br />
    <!-- a href="https://github.com/ivsg-psu/FeatureExtraction_Association_PointToPointAssociation"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/ivsg-psu/FeatureExtraction_Association_PointToPointAssociation/tree/main/Documents">View Demo</a>
    ·
    <a href="https://github.com/ivsg-psu/FeatureExtraction_Association_PointToPointAssociation/issues">Report Bug</a>
    ·
    <a href="https://github.com/ivsg-psu/FeatureExtraction_Association_PointToPointAssociation/issues">Request Feature</a>
    -->
  </p>
</p>

<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary><h2 style="display: inline-block">Table of Contents</h2></summary>
  <ul>
    <li>
      <a href="#about-the-library">About the Library</a>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#installation">Installation</a></li>
        <li><a href="#starting-examples">Starting Examples</a></li>
      </ul>
    </li>
    <li><a href="#repo-structure">Repo Structure</a>
         <ul>
           <li><a href="#directories">Directories</li>
           <li><a href="#dependencies">Dependencies</li>
           <li><a href="#function-structure">Function Structure</li>
        </ul>
    </li>
    <li><a href="#functions-for-workspace-management">Functions for Workspace Management</a>
         <ul>
             <li><a href="#clearing-package-installs">Clearing package installs and path linkages to packages</li>
             <li><a href="#fcn_debugtools_autoinstallrepos">fcn_DebugTools_autoInstallRepos performs automatic installation of GitHub repos into a Utilities folder and updates the MATLAB path to point to selected folders within the install.</li>
             <li><a href="#package-installs-from-github-urls">Package installs from GitHub URLs</li>
             <li><a href="#adding-subdirectories-to-the-path">Adding subdirectories to the path</li>
             <li><a href="#querying-directory-and-subdirectory-content">Listing directory and subdirectory content</li>
             <li><a href="#printing-a-directory-listing">Printing a directory listing</li>
             <li><a href="#counting-the-bytes-folders-and-files-in-a-directory-listing">Counting the bytes, folders, and files in a directory listing</li>
             <li><a href="#making-a-directory">Making a directory</li>
             <li><a href="#sorting-a-directory-listing-by-filename-time">Sorting a directory listing by filename time</li>
             <li><a href="#estimating-directory-processing-time">Calculating and confirming directory processing time</li>
             <li><a href="#comparing-directory-listings">Comparing directory listings</li>
             <li><a href="#search-a-filelist-for-a-querystring">Search a fileList for a queryStrings</li>
         </ul>
    </li>
    <li><a href="#functions-for-input-checking">Functions for Input Checking</a>
         <ul>
             <li><a href="#checking-inputs-to-functions">Checking inputs to functions</li>
             <li><a href="#checking-if-strings-partially-match">Checking if strings partially match</li>
             <li><a href="#extracting-a-numeric-value-embedded-in-a-string">Extracting a numeric value embedded in a string </li>
             <li><a href="#parsing-a-comma-separated-string-into-cells">Parsing a comma separated string into cells</li>
             <li><a href="#query-user-to-select-index-range">Query user to select index range</li>
             <li><a href="#break-column-of-data-by-nan-values-using-fcn_debugtools_breakarraybynans">Break a column of data with NaN separators into a cell array</li>
     </ul>
    </li>
    <li><a href="#functions-for-output-formatting">Functions for Output Formatting</a>
     <ul>
     <li><a href="#converting-numbers-to-human-friendly-strings">Converting numbers to human friendly strings</li>
        <li><a href="#appending-arbitrary-values-to-a-string">Appending arbitrary values to a string</li>
        <li><a href="#converting-flags-into-yes-and-no-strings">Converting flags into yes and no strings </li>
        <li><a href="#printing-results-to-fixed-length-strings">Printing results to fixed length strings</li>  
        <li><a href="#printing-matrices-to-fixed-length-columns">Printing matrices to fixed length columns</li>
        <li><a href="#printing-directory-listings-alongside-flags-and-data">Printing directory listings alongside flags and data</li>
     </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
     <ul>
     <li><a href="#examples">Examples</li>
     <li><a href="#definition-of-endpoints">Definition of Endpoints</li>
     </ul>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
  </ul>
</details>

<a href="#debugtools">Back to top</a>

<!-- ABOUT THE LIBRARY -->
## About the Library

<!--[![Product Name Screen Shot][product-screenshot]](https://example.com)-->

Often the codes used within IVSG require very common, repeated tools to be used for debugging or general error catching. To avoid repitition of code, most of these functions are embedded here.

The general areas of functionality include:

* Workspace management
  * Path checking and creation
* Input checking:
  * Testing whether inputs meet specifications required by code, such as whether or not they are integers, positive, contain 2 or 3 rows, only have 2 columns, etc.  
* Output formatting
  * Printing results to screen with a specified width.

<a href="#debugtools">Back to top</a>

<!-- GETTING STARTED -->
## Getting Started

To get a local copy up and running follow these simple steps.

### Installation

1. Make sure to run MATLAB 2020b or higher. Why? The "digitspattern" command used in the DebugTools was released late 2020 and this is used heavily in the Debug routines. If debugging is shut off, then earlier MATLAB versions will likely work.

2. Clone the repo

     ```sh
     git clone https://github.com/ivsg-psu/Errata_Tutorials_DebugTools
     ```

3. Confirm it works! Run script_demo_DebugTools.m from the root directory root location. If the code works, the script should run without errors. This script produces numerous example cases, many of them shown in this README file.

<a href="#debugtools">Back to top</a>

### Starting Examples

1. Run the main script to set up the workspace and demonstrate main outputs, including the figures included in this README:

   ```sh
   script_demo_DebugTools
   ```

2. After running the main script to define the included directories for utility functions, one can then navigate to the Functions directory and run any of the functions or scripts there as well. All functions for this library are found in the Functions sub-folder, and each has an associated test script. Run any of the various test scripts, such as:

   ```sh
   script_test_fcn_DebugTools_extractNumberFromStringCell
   ```

For more examples, please refer to the [Documentation](https://github.com/ivsg-psu/FeatureExtraction_Association_PointToPointAssociation/tree/main/Documents)

<a href="#debugtools">Back to top</a>

<!-- REPO STRUCTURE-->

## Repo Structure

### Directories

The following are the top level directories within the repository:
<ul>
 <li>/Data folder: Contains example data used for demonstrating the debugging tools.</li>
 <li>/Documents folder: Presentations of best practices for debugging - many of which were made by prior students.</li>
     <li>/Example Code Snippets folder: Example codes demonstrating some very powerful capabilities in MATLAB including how to set up a class, how to set environmental variables, how to perform unit testing, and how to run multiple test scripts with logging.</li>
 <li>/Functions folder: The majority of the code functionalities are implemented in this directory. All functions as well as test scripts are provided.</li>
     <li>/Images folder: Location of images used in this and or other README files.</li>
 <li>/Utilities folder: (empty) Dependencies that are utilized but not implemented in this repository are placed in the Utilities directory. These can be single files but are most often folders containing other cloned repositories.</li>
</ul>

<a href="#debugtools">Back to top</a>

### Dependencies

* (none)

<!--
* [Errata_Tutorials_DebugTools](https://github.com/ivsg-psu/Errata_Tutorials_DebugTools) - The DebugTools repo is used for the initial automated folder setup, and for input checking and general debugging calls within subfunctions. The repo can be found at: https://github.com/ivsg-psu/Errata_Tutorials_DebugTools

* [PathPlanning_PathTools_PathClassLibrary](https://github.com/ivsg-psu/PathPlanning_PathTools_PathClassLibrary) - the PathClassLibrary contains tools used to find intersections of the data with particular line segments, which is used to find start/end/excursion locations in the functions. The repo can be found at: https://github.com/ivsg-psu/PathPlanning_PathTools_PathClassLibrary

    Each should be installed in a folder called "Utilities" under the root folder, namely ./Utilities/DebugTools/ , ./Utilities/PathClassLibrary/ . If you wish to put these codes in different directories, the main call stack in script_demo_Laps can be easily modified with strings specifying the different location, but the user will have to make these edits directly. 
    
    For ease of getting started, the zip files of the directories used - without the .git repo information, to keep them small - are included in this repo.
-->

<a href="#debugtools">Back to top</a>

<!-- FUNCTION STRUCTURE -->

### Function Structure

Each of the functions described as follows has a consistent structure: each has an associated test script, using the convention

```sh
script_test_fcn_fcnname
```

where fcnname is the function name as listed above.

Also, each of the functions includes a well-documented header that explains inputs and outputs. These are supported by MATLAB's help style so that one can type:

```sh
help fcn_fcnname
```

for any function to view function details.

<a href="#debugtools">Back to top</a>

<!-- FUNCTIONS FOR WORKSPACE MANAGEMENT -->
## Functions for Workspace Management

### Clearing Package Installs

Before installing code packages from GitHub links (see below for demos of this), it is strongly recommended that old packages be removed. The code below appears at the time of most code libraries and achieves this.

NOTE: this is not functionalized because, for the function to be shared, a package must be installed - which somewhat defeats the point of clearing packages.

NOTE: it is commented out via the "if 1==0" test using an "if" statement. This is to simplify and clarify if and when the code is allowed, or not. If the code were simply commented out, a user might assume the code is not ready for execution.

```Matlab
if 1==0
    % Clear out the variables
    clear global flag* FLAG*

    % Clear out any path directories under Utilities
    path_dirs = regexp(path,'[;]','split');
    utilities_dir = fullfile(pwd,filesep,'Utilities');
    for ith_dir = 1:length(path_dirs)
        utility_flag = strfind(path_dirs{ith_dir},utilities_dir);
        if ~isempty(utility_flag)
            rmpath(path_dirs{ith_dir});
        end
    end

    % Delete the Utilities folder, to be extra clean!
    if  exist(utilities_dir,'dir')
        [success_flag,message,message_ID] = rmdir(utilities_dir,'s');
        if 0==success_flag
            error('Unable remove directory: %s \nReason message: %s \nand message_ID: %s\n',utilities_dir, message,message_ID);
        end
    end

end
```

<a href="#debugtools">Back to top</a>

***

### fcn_DebugTools_autoInstallRepos

The function,
fcn_DebugTools_autoInstallRepos
performs automatic installation of GitHub repos into a Utilities folder and
updates the MATLAB path to point to selected folders within the install.

```Matlab


FCN_DEBUGTOOLS_AUTOINSTALLREPOS automatically installs GitHub repos. Each
repo is specified by a URL pointing to the GitHub site. 

For each repo, GitHub is queried to determine the latest version of that
repo. The Utilities folder, if it exists, is queried to determine if the
latest version is installed. If the folder name matches the latest
release, the installation is skipped. An optional input flag can be used
to force clearing and installation of previously installed repos, even if
these are the same version.

For all installations, by default, the DebugTools latest release is
always checked and installed if it is not the latest version. After
install, this function, fcn_DebugTools_autoInstallRepos, is copied into
the Functions folder so that this function can be called in code releases
even without DebugTools installed yet.

All installs are pulled from the latest version (as a zip file) into a
default local subfolder, "Utilities", under the root folder. The install
process also adds either the package subfoder or any specified
sub-subfolders to the MATLAB path. 

If the Utilities folder does not exist, it is created.

If the specified code package folder and all subfolders already exist,
the package is not installed. Otherwise, the folders are created as
needed, and the package is installed.

If one does not wish to put these codes in different directories, the
function can be easily modified with strings specifying the
desired install location.

For path creation, if the "DebugTools" package is being installed, the
code installs the package, then shifts temporarily into the package to
complete the path definitions for MATLAB. If the DebugTools is not
already and/or successfully installed, an error is thrown as these tools
are needed for the path creation.

Finally, the code sets a global flag to indicate that the folders are
initialized so that, in this session, if the code is called again, then
the folders will not be installed. This global flag can be overwritten by
an optional flag input.

FORMAT:

     fcn_DebugTools_autoInstallRepos(...
          dependency_name, ...
          dependencySubfolders, ...
          dependencyURLs)

INPUTS:

     dependencyURLs: a cell array of the URLs pointing to the repo
     location(s).

     dependencySubfolders: in addition to the package subfoder, a list
     of any specified sub-subfolders to the MATLAB path. Leave blank to
     add only the package subfolder to the path. See the example below.

     (OPTIONAL INPUTS)

     flagForceInstalls: if any value other than zero, forces the
     install to occur even if the global flag is set.

     figNum: a figure number to plot results. If set to -1, skips any
     input checking or debugging, no figures will be generated, and sets
     up code to maximize speed. As well, if given, this forces the
     variable types to be displayed as output and as well makes the input
     check process verbose

OUTPUTS:

     (none into workspace - installs files into Utilities subfolder)

```

Here is an example implementation:

```Matlab
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
```

<a href="#debugtools">Back to top</a>

***


### Package installs from GitHub URLs

Package installs are a key tool used in most codes. This allows large segments of code to be debugged and tested independently (packages), released carefully when major changes are ready for sharing (versioning), and then linked quickly and clearly into other codes without copy/pasting or interfering with the versioning of other codes (e.g., install as a utility).

To be clear, a "Utility" is a package or set of codes that is needed for operation of the current code, but the package itself is never edited or changed - it is simply used as-is. This distinction is important: if a bug or change is needed in a Utility, it must be changed in the SOURCE repository; otherwise, the "local" changes will not be saved or shared with others.

Often, these utilities contain subfolder features that are reused. Functions for example are usually located in a "Functions" subdirectory and/or data in a "Data" subdirectory. The installation process of packages allows one to specify which dependency subfolders, for example "Functions" and "Data", to include in the MATLAB path after the package installation.

The installation of packages from the GitHub management tool is done via the function: fcn_DebugTools_installDependencies.m

fcn_DebugTools_installDependencies: installs code packages that are specified by a URL pointing to a zip file into a default local subfolder, "Utilities", under the root folder. It also adds either the package subfoder or any specified sub-subfolders to the MATLAB path.

If the Utilities folder does not exist, it is created.

If the specified code package folder and all subfolders already exist, the package is not installed. Otherwise, the folders are created as needed, and the package is installed.

If one does not wish to put these codes in different directories, the function can be easily modified with strings specifying the desired install location.

For path creation, if the "DebugTools" package is being installed, the code installs the package, then shifts temporarily into the package to complete the path definitions for MATLAB. If the DebugTools is not already installed, an error is thrown as these tools are needed for the path creation.

Finally, the code sets a global flag to indicate that the folders are initialized so that, in this session, if the code is called again the folders will not be installed. This global flag can be overwritten by an optional flag input.

```Matlab
%% Basic test case
% NOTE: this installs under the current directory!
% Define the name of subfolder to be created in "Utilities" subfolder
dependency_name = 'DebugTools_v2023_01_18';

% Define sub-subfolders that are in the code package that also need to be
% added to the MATLAB path after install. Leave empty ({}) to only add
% the subfolder path without any sub-subfolder path additions.
dependency_subfolders = {'Functions','Data'};

% Define a universal resource locator (URL) pointing to the zip file to
% install. For example, here is the zip file location to the Debugtools
% package on GitHub:
dependency_url = 'https://github.com/ivsg-psu/Errata_Tutorials_DebugTools/blob/main/Releases/DebugTools_v2023_01_25.zip?raw=true';

% Call the function to do the install
fcn_DebugTools_installDependencies(dependency_name, dependency_subfolders, dependency_url)
```

Note, the first time code is run, the location of this function is not going to be known. So typically, the initialization codes must be hard-coded first. The first part of the demo code for the DebugTools library does this, adn the code below is from the Laps class library to demonstrate how it is done for codes that are using DebugTools as a utility, which is more typical.

```Matlab
%% Dependencies and Setup of the Code
% The code requires several other libraries to work, namely the following
%%
% 
% * DebugTools - the repo can be found at: https://github.com/ivsg-psu/Errata_Tutorials_DebugTools
% * PathClassLibrary - the repo can be found at: https://github.com/ivsg-psu/PathPlanning_PathTools_PathClassLibrary
% 
% Each should be installed in a folder called "Utilities" under the root
% folder, namely ./Utilities/DebugTools/ , ./Utilities/PathClassLibrary/ .
% If you wish to put these codes in different directories, the function
% below can be easily modified with strings specifying the different
% location.
% 
% For ease of transfer, zip files of the directories used - without the
% .git repo information, to keep them small - are included in this repo.
% 
% The following code checks to see if the folders flag has been
% initialized, and if not, it calls the DebugTools function that loads the
% path variables. It then loads the PathClassLibrary functions as well.
% Note that the PathClass Library also has sub-utilities that are included.
if ~exist('flag_Laps_Folders_Initialized','var')
    
    % add necessary directories for function creation utility 
    %(special case because folders not added yet)
    debug_utility_folder = fullfile(pwd, 'Utilities', 'DebugTools');
    debug_utility_function_folder = fullfile(pwd, 'Utilities', 'DebugTools','Functions');
    debug_utility_folder_inclusion_script = fullfile(pwd, 'Utilities', 'DebugTools','Functions','fcn_DebugTools_addSubdirectoriesToPath.m');
    if(exist(debug_utility_folder_inclusion_script,'file'))
        current_location = pwd;
        cd(debug_utility_function_folder);
        fcn_DebugTools_addSubdirectoriesToPath(debug_utility_folder,{'Functions','Data'});
        cd(current_location);
    else % Throw an error?
        error('The necessary utilities are not found. Please add them (see README.md) and run again.');
    end
    
    % Now can add the Path Class Library automatically
    utility_folder_PathClassLibrary = fullfile(pwd, 'Utilities', 'PathClassLibrary');
    fcn_DebugTools_addSubdirectoriesToPath(utility_folder_PathClassLibrary,{'Functions','Utilities'});
    
    % utility_folder_GetUserInputPath = fullfile(pwd, 'Utilities', 'GetUserInputPath');
    % fcn_DebugTools_addSubdirectoriesToPath(utility_folder_GetUserInputPath,{'Functions','Utilities'});

    % Now can add all the other utilities automatically
    folder_LapsClassLibrary = fullfile(pwd);
    fcn_DebugTools_addSubdirectoriesToPath(folder_LapsClassLibrary,{'Functions'});

    % set a flag so we do not have to do this again
    flag_Laps_Folders_Initialized = 1;
end
```

<!--img src=".\Images\fcn_Laps_plotLapsXY.png" alt="fcn_Laps_plotLapsXY picture" width="400" height="300"
</li>
	<li>
    fcn_Laps_fillSampleLaps.m : This function allows users to create dummy data to test lap functions. The test laps are in general difficult situations, including scenarios where laps loop back onto themself and/or with separate looping structures. These challenges show that the library can work on varying and complicated data sets. NOTE: within this function, commented out typically, there is code to allow users to draw their own lap test cases.
    <br>
    <img src=".\Images\fcn_Laps_fillSampleLaps.png" alt="fcn_Laps_fillSampleLaps picture" width="400" height="300">
    </li>
    <li>
    fcn_Laps_plotZoneDefinition.m : Plots any type of zone, allowing user-defined colors. For example, the figure below shows a radial zone for the start, and a line segment for the end. For the line segment, an arrow is given that indicates which direction the segment must be crossed in order for the condition to be counted. 
    <br>
    <img src=".\Images\fcn_Laps_plotZoneDefinition.png" alt="fcn_Laps_plotZoneDefinition picture" width="400" height="300">
    </li>
    <li>
    fcn_Laps_plotPointZoneDefinition.m : Plots a point zone, allowing user-defined colors. This function is mostly used to support fcn_Laps_plotZoneDefinition.m 
    </li>
    <li>
    fcn_Laps_plotSegmentZoneDefinition.m : Plots a segment zone, allowing user-defined colors. This function is mostly used to support fcn_Laps_plotZoneDefinition.m 
    </li>
  -->  

<a href="#debugtools">Back to top</a>

***

### Adding subdirectories to the path

fcn_DebugTools_addSubdirectoriesToPath.m : This function adds given subdirectories to the root path, and causes an error to be thrown if the directory is not found. It is typically used within a flag-checking if-statement, such as below

```Matlab
%% Demonstrate how to add subdirectories
if ~exist('flag_DebugTools_Folders_Initialized','var')
    fcn_DebugTools_addSubdirectoriesToPath(pwd,{'Functions','Data'});

    % set a flag so we do not have to do this again
    flag_DebugTools_Folders_Initialized = 1;
end
```

<a href="#debugtools">Back to top</a>

***

### Querying directory and subdirectory content

fcn_DataClean_listDirectoryContents - Creates a list of specified root directories, including all subdirectories, of a given query. Allows specification whether to keep either files, directories, or both.

FORMAT:

```Matlab
     directory_filelist = fcn_DataClean_listDirectoryContents(rootdirs, (fileQueryString), (flag_fileOrDirectory), (fid))
```

Here is an example usage:

```Matlab
% List which directory/directories need to be loaded
clear rootdirs
rootdirs{1} = fullfile(cd,'Functions');

% Specify the fileQueryString
fileQueryString = '*.m'; % The more specific, the better to avoid accidental loading of wrong information

% Specify the flag_fileOrDirectory
flag_fileOrDirectory = 0; % 0 = a file, 1 = directory, 2 = both

% Specify the fid
fid = -1; % 1 --> print to console

% Call the function
directory_filelist = fcn_DebugTools_listDirectoryContents(rootdirs, (fileQueryString), (flag_fileOrDirectory), (fid));

% Check the results
assert(isstruct(directory_filelist));
assert(length(directory_filelist)>1);
```

<a href="#debugtools">Back to top</a>

***

### Printing a directory listing

Prints a listing of a directory into either a console, a file, or a
markdown file with markdown formatting.

FORMAT:

```Matlab
     fcn_DebugTools_printDirectoryListing(directory_filelist, (titleString), (rootDirectoryString), (fid))

INPUTS:

     directory_filelist: a structure array that is the output of a
     "dir" command. A typical output can be generated using:
     directory_filelist = fcn_DebugTools_listDirectoryContents({cd});

     (OPTIONAL INPUTS)

     titleString: a title put at the top of the listing. The default is:
     "CONTENTS FOUND:" 

     rootDirectoryString: a string to specify the root directory of the query,
     thus forcing a MARKDOWN print style. The default is empty, to NOT
     print in MARKDOWN

     fid: the fileID where to print. Default is 1, to print results to
     the console. If set to -1, skips any input checking or debugging, no
     prints will be generated, and sets up code to maximize speed.

OUTPUTS:

     (prints to console)

Here is an example usage:

% Create a directory filelist by querying the "Functions" folder for all .m
% files
directory_filelist = fcn_DebugTools_listDirectoryContents({fullfile(cd,'Functions')},'*.m',0);

% Print the results with a titleString
titleString = 'This is a listing of all mfiles in the Functions folder';
rootDirectoryString = [];
fid = 1;
fcn_DebugTools_printDirectoryListing(directory_filelist, (titleString), (rootDirectoryString), (fid))
```

<a href="#debugtools">Back to top</a>

***

### Counting the bytes folders and files in a directory listing

The function fcn_DebugTools_countBytesInDirectoryListing counts the number of bytes in a directory listing and as well the number of folders and files in that listing, excluding degenerate folders

```Matlab

FORMAT:

     [totalBytes, Nfolders, Nfiles] = fcn_INTERNAL_countBytesInDirectoryListing(directory_listing, (indicies),(fid))

INPUTS:

     directory_listing: a structure that is the output of MATLAB's "dir"
     command that includes filename, bytes, etc.

     (OPTIONAL INPUTS)

     indicies: which indicies to include in the count. Default is to use
     all files in the directory listing.

     fid: the fileID where to print. Default is 0, to NOT print results to
     the console. If set to -1, skips any input checking or debugging, no
     prints will be generated, and sets up code to maximize speed.

OUTPUTS:

     totalBytes: the total number of bytes in the directory listing or,
     if indicies are specified, the total of just the chosen indicies in
     the directory listing.

     Nfolders: the total number of folders in the listing, excluding
     degenerate folders ('.' and '..').

     Nfiles: the total number of files in the listing
```

Here is an example usage:

```Matlab
directory_filelist = fcn_DebugTools_listDirectoryContents({cd});

indicies = 1:10;
fid = 1;
[totalBytes, Nfolders, Nfiles] = fcn_DebugTools_countBytesInDirectoryListing(directory_filelist,(indicies),(fid));

assert(totalBytes>=0);
assert(Nfolders>=0);
assert(Nfiles>=0);
assert((Nfiles+Nfolders)<=length(indicies)); % Note: some indicies may be degenerate folders such as '.' and '..' - these are not counted
```

Produces the following:

```Matlab

Total number of files and folders indexed: 10, containing 1,660 bytes, 6 folders, and 2 files
Breakdown:
  FOLDERS:                                                                   BYTES (in and below):
  D:\GitHubRepos\IVSG\Errata\Tutorials\DebugTools\.git                                  51,667,259
  D:\GitHubRepos\IVSG\Errata\Tutorials\DebugTools\Data                                         330
  D:\GitHubRepos\IVSG\Errata\Tutorials\DebugTools\Documents                              7,106,499
  D:\GitHubRepos\IVSG\Errata\Tutorials\DebugTools\Example Code Snippets                     23,296
  D:\GitHubRepos\IVSG\Errata\Tutorials\DebugTools\Functions                                284,354
  D:\GitHubRepos\IVSG\Errata\Tutorials\DebugTools\Images                                 1,983,583

  FILES:                                                                                    BYTES:
  D:\GitHubRepos\IVSG\Errata\Tutorials\DebugTools\.gitignore                                   523
  D:\GitHubRepos\IVSG\Errata\Tutorials\DebugTools\LICENSE                                    1,137
```

<a href="#debugtools">Back to top</a>

***

### Making a directory

The function  fcn_DebugTools_makeDirectory creates a directory given a directory path, even if directory is a full path, and even if the created directory would not exist as a direct subfolder in current folder.

FORMAT:

```Matlab
     fcn_DebugTools_makeDirectory(directoryPath, (fid))

INPUTS:

     directoryPath: a string containing the path to the directory to
     create

     (OPTIONAL INPUTS)

     fid: the fileID where to print. Default is 1, to print results to
     the console. If set to -1, skips any input checking or debugging, no
     prints will be generated, and sets up code to maximize speed.

```

Here is an example implementation:

```Matlab
directoryPath = fullfile(cd,'Junk','Junk','Junk');
assert(7~=exist(directoryPath,'dir'));

fid = 1;

fcn_DebugTools_makeDirectory(directoryPath,fid);

assert(7==exist(directoryPath,'dir'));
rmdir('Junk','s');
```

<a href="#debugtools">Back to top</a>

***

### Sorting a directory listing by filename time

The function, fcn_DebugTools_sortDirectoryListingByTime, sorts directory listings by the filename time, e.g. the date/time format that is embedded within the filename.

Given a directory listing of files that have names ending in date
formats, for example: filename_yyyy-MM-dd-HH-mm-ss,sorts the files
by date. Useful to sort bag files whose names contain dates, for example:
      mapping_van_2024-08-05-14-45-26_0

```Matlab
FORMAT:

     sorted_directory_filelist = fcn_DebugTools_sortDirectoryListingByTime(directory_filelist, (fid))

INPUTS:

     directory_filelist: a structure array that is the output of a
     "dir" command. A typical output can be generated using:
     directory_filelist = fcn_DebugTools_listDirectoryContents({cd});

     (OPTIONAL INPUTS)

     fid: the fileID where to print. Default is 1, to print results to
     the console. If set to -1, skips any input checking or debugging, no
     prints will be generated, and sets up code to maximize speed.

OUTPUTS:

     sorted_directory_filelist: a structure array similar to the output
     of a "dir" command, but where the listings are sorted by date     

```

Here is an example implementation:

```Matlab

directory_filelist = fcn_DebugTools_listDirectoryContents({fullfile(cd,'Data')},'ExampleDateSorting*.txt',0);

sorted_directory_filelist = fcn_DebugTools_sortDirectoryListingByTime(directory_filelist);

fcn_DebugTools_printDirectoryListing(sorted_directory_filelist);
```

<a href="#debugtools">Back to top</a>

***

### Estimating directory processing time

The function, fcn_DebugTools_confirmTimeToProcessDirectory
Calculates the time it takes to process a directory listing and confirms
with the user that this is acceptable.

```Matlab
FORMAT:

     [flag_keepGoing, timeEstimateInSeconds] = fcn_DebugTools_confirmTimeToProcessDirectory(directory_listing, bytesPerSecond, (indexRange),(fid))

INPUTS:

     directory_listing: a structure that is the output of MATLAB's "dir"
     command that includes filename, bytes, etc.

     (OPTIONAL INPUTS)

     indexRange: which indicies to include in the count. Default is to use
     all files in the directory listing.

     fid: the fileID where to print. Default is 0, to NOT print results to
     the console. If set to -1, skips any input checking or debugging, no
     prints will be generated, and sets up code to maximize speed.

OUTPUTS:

     flag_keepGoing: outputs a 1 if user accepts, 0 otherwise

     timeEstimateInSeconds: how many seconds the processing is estimated
     to take

```

Here is an example implementation:

```Matlab
directory_listing = fcn_DebugTools_listDirectoryContents({cd});
bytesPerSecond = 10000000;
indexRange = [];
fid = 1;
[flag_keepGoing, timeEstimateInSeconds] = fcn_DebugTools_confirmTimeToProcessDirectory(directory_listing, bytesPerSecond, (indexRange),(fid));

assert((flag_keepGoing==0) || (flag_keepGoing==1));
assert(timeEstimateInSeconds>=0);
```

<a href="#debugtools">Back to top</a>

***

### Comparing directory listings

The function,
fcn_DebugTools_compareDirectoryListings
compares a source and destination directory to check if files are located
in destination directory that match the source directory.

```Matlab

FORMAT:

     flags_wasMatched = fcn_DebugTools_compareDirectoryListings(directoryListing_source, sourceRootString, destinationRootString, (flag_matchingType), (typeExtension), (fid))

INPUTS:

     directoryListing_source: a structure array that is the output of a
     "dir" command. A typical output can be generated using:
     directory_filelist = fcn_DebugTools_listDirectoryContents({cd});

     sourceRootString: a string that lists the root of the
     directoryListing_source, e.g. the bottom directory of the source
     above which the content organization should be mirrored in the
     destination directory

     destinationRootString: a string that lists the root of the
     directoryListing_source, e.g. the bottom directory of the source
     above which the content organization should be mirrored in the
     destination directory

     (OPTIONAL INPUTS)

     flag_matchingType: a flag that sets the type of matching. Values
     include:

          1: matches same type to same type (e.g., if the listings are
          files in the source, matches to files in the destination. If
          the listings are folders in the source, looks for folders in
          the destination.

          2: fileToFolder - matches files in the source to folders in the
          destination

          3: folderToFile - matches folders in the source to files in the
          destination

     typeExtension: the file type extension to add or omit, if
     fileToFolder or folderToFile is set. Default is to use '.m'

     fid: the fileID where to print. Default is 0, to NOT print results to
     the console. If set to -1, skips any input checking or debugging, no
     prints will be generated, and sets up code to maximize speed.

OUTPUTS:

     flags_wasMatched: a flag vector of Nx1 where N is the number of
     listings in the source directory. The flag is set to 1 if the
     listing in the source was found in the destination, and set to 0 if
     not found.

```

Here is an example implementation:

```Matlab
% Set strings that list where the "root" potions of the source and
% destination directories are located
sourceRootString      = fullfile(cd,'Data','Example_compareDirectoryListings','SourceDirectory');
destinationRootString = fullfile(cd,'Data','Example_compareDirectoryListings','DestinationDirectory');


% Create a directory filelist by querying the "Functions" folder for all .m
% files
file_or_folder = 0; % Returns only files
directoryListing_source = fcn_DebugTools_listDirectoryContents({sourceRootString},'TestFolder*.m',file_or_folder);

% Call the function fcn_DebugTools_compareDirectoryListings
flag_matchingType = 1; % Same to same
flags_wasMatched = fcn_DebugTools_compareDirectoryListings(directoryListing_source, sourceRootString, destinationRootString, (flag_matchingType), (fid));

assert(isequal(flags_wasMatched,[1 1 0]'));
```

<a href="#debugtools">Back to top</a>

***

### Search a fileList for a queryString

fcn_DebugTools_directoryStringQuery
Searches the given fileList for a queryString, returning 1 if the string
is found in the file, 0 otherwise.

```Matlab

FORMAT:

     fcn_DebugTools_directoryStringQuery(fileList, queryString,(fig_num));

INPUTS:

     fileList: the output of a directory command, a structure containing
     the files to search

     queryString: the string to search

     (OPTIONAL INPUTS)

    fig_num: a figure number to plot results. If set to -1, skips any
    input checking or debugging, no figures will be generated, and sets
    up code to maximize speed. As well, if given, this forces the
    variable types to be displayed as output and as well makes the input
    check process verbose


OUTPUTS:

    flagsStringWasFoundInFiles: for each of the N entries in fileList,
    returns logical 1 if the query string is found, 0 if not.

```
Here is an example implementation:

```Matlab
% Basic test case looking for ''ghglglgh (only in this file)'''

fig_num = 10001; 
titleString = sprintf('DEMO case: Basic test case looking for ''ghglglgh (only in this file)''');
fprintf(1,'Figure %.0f: %s\n',fig_num, titleString);
figure(fig_num); close(fig_num);

% Get a list of all files in the directory
fileList = dir(fullfile(pwd,'Functions', '*.*')); % Adjust file extension as needed

% Filter out directories from the list
fileList = fileList(~[fileList.isdir]);

queryString = 'ghglglgh (only in this file)';

flagsStringWasFoundInFiles = fcn_DebugTools_directoryStringQuery(fileList, queryString, (fig_num));

% Check variable types
assert(islogical(flagsStringWasFoundInFiles))

% Check variable sizes
assert(size(flagsStringWasFoundInFiles,1)==length(fileList));
assert(size(flagsStringWasFoundInFiles,2)==1);

% Check variable values
% This file and the ASV file
assert(sum(flagsStringWasFoundInFiles)>=1 || (flagsStringWasFoundInFiles)<=2);
```

<a href="#debugtools">Back to top</a>

***

## Functions for Input Checking

### Checking inputs to functions

The function: fcn_DebugTools_checkInputsToFunctions checks to see if an input meets specified requirements. It is a VERY powerful tool that is commonly used at the top of most codes in the IVSG toolset. For example, the following code checks to see if the input has 2 columns, and 5 or less rows. If it does, it gives no error:

```Matlab
%% Check that an input has 2 columns, 
% Maximum length is 5 or less
Twocolumn_of_integers_test = [4 1; 3 9; 2 7];
fcn_DebugTools_checkInputsToFunctions(Twocolumn_of_integers_test, '2column_of_integers',[5 4]);
```

This function is quite flexible. To see all options, run the script file. An output option is also available that lists all possible inputs. To see these, run the following code:

```Matlab
options = fcn_DebugTools_checkInputsToFunctions;
fprintf(1,'Here are a listing of all active input checking options: \n');
for ith_option = 1:length(options)
    fprintf('\t"%s"\n',options(ith_option).name)
    fprintf('\t\t%s\n',options(ith_option).description)    
end
```

and it returns:

```Matlab
Here are a listing of all active input checking options: 
 "Mcolumn_of..."
  checks that the input type is K x M of ...
 "NorMcolumn..."
  checks that the input type is of minimum K x M or maximum K x N of ...
 "positive_..."
  checks that the input type is positive ...
 "_of_integers..."
  checks that the input type is of_integers...
 "_of_mixed..."
  checks that the input type is numeric but can include NaN..
 "_of_chars..."
  checks that the input type is a char type (uses ischar)
 "_of_strings..."
  checks that the input type is a string type (uses isstring)
 "DoesFileExist..."
  checks that the input type is an existing file
 "DoesDirectoryExist..."
  checks that the input type is an existing directory
 "polytopes..."
  checks that the input type is a polytope type, e.g. a structure with fields: vertices, xv, yv, distances, mean, area, max_radius.
 "mixedset..."
  checks that the input type is a structure matching a given template..
 "1column_of_numbers"
  checks that the input type is a structure with fields: name, settings, AABB.
 "positive_1column_of_numbers"
  checks that the input type is N x 1 and is a strictly positive number. Optional input: an integer forcing the value of N, giving an error if the input variable does not have length N.
 "2column_of_numbers"
  checks that the input type is N x 2 and is a number. Optional input: an integer forcing the value of N, giving an error if the input variable does not have length N. Another optional input is a rwo vector [A B] where, if B is greater than A, then the vector must be A or longer. If B is less than A, then the vector must be A or shorter. If B = A, then the vector must be length A, and no shorter or greater.
 "4column_of_numbers"
  checks that the input type is N x 4 and is a number. Optional input: an integer forcing the value of N, giving an error if the input variable does not have length N. Another optional input is a rwo vector [A B] where, if B is greater than A, then the vector must be A or longer. If B is less than A, then the vector must be A or shorter. If B = A, then the vector must be length A, and no shorter or greater.
 "2or3column_of_numbers"
  checks that the input type is N x 2 or N x 3 and is a number. Optional input: an integer forcing the value of N, giving an error if the input variable does not have length N. Another optional input is a rwo vector [A B] where, if B is greater than A, then the vector must be A or longer. If B is less than A, then the vector must be A or shorter. If B = A, then the vector must be length A, and no shorter or greater.
 "2column_of_integers"
  checks that the input type is N x 2 and is an integer. Optional input: an integer forcing the value of N, giving an error if the input variable does not have length N. Another optional input is a rwo vector [A B] where, if B is greater than A, then the vector must be A or longer. If B is less than A, then the vector must be A or shorter. If B = A, then the vector must be length A, and no shorter or greater.
 "polytopes"
  a 1-by-n seven field structure of polytopes within the boundaries, where n <= number of polytopes with fields:  vertices: a m+1-by-2 matrix of xy points with row1 = rowm+1, where m is the number of the individual polytope vertices  xv: a 1-by-m vector of vertice x-coordinates  yv: a 1-by-m vector of vertice y-coordinates  distances: a 1-by-m vector of perimeter distances from one point to the next point, distances(i) = distance from vertices(i) to vertices(i+1) mean: centroid xy coordinate of the polytope area: area of the polytope max_radius: the largest distance from the centroid to any vertex
 "station"
  Path library type: checks that the station type is N x 1 and is a number.
 "stations"
  Path library type: checks that the station type is N x 1 and is a number, with N >= 2.
 "path"
  Path library type: checks that the path type is N x 2 with N>=2
 "path2or3D"
  Path library type: checks that the path type is N x 2 or N x 3, with N>=2
 "elevated_path"
  Path library type: checks that the elevated path type is N x 3 with N>=2
 "paths"
  Path library type: checks that the path type is N x 2 with N>=3
 "traversal"
  Path library type: checks if a structure with X, Y, and Station, and that each has an N x 1 vector within all of same length. Further, the Station field must be strictly increasing.
 "traversals"
  Path library type: checks if a structure containing a subfield that is a cell array of traveral{i}, e.g. "data.traversal{3}", with each traversal also meeting traversal requirements.
 "likestructure"
  Takes a structure input as the 3rd argument to serve as a template. Ensures that the input has the same structure fields.
```

<a href="#debugtools">Back to top</a>

***

### Checking if strings partially match

The function: fcn_DebugTools_doStringsMatch checks to see a string entry, usually from a prompt to a human user, matches or partially matches a given set of inputs, for example if "y" matches "Yes". This function can also handle cases where the user must select from a set of choices (a through d, for example) and confirms that one and only one of those choices was selected:

```Matlab
%% simple string comparisons, student answer is part of correct answer so returns true, ignoring case
student_answer = 'A';
correct_answers = 'abc';
result = fcn_DebugTools_doStringsMatch(student_answer,correct_answers);
assert(result);

%% simple string comparisons, student answer is part of correct answer so true, checking to produce false result if student repeats (FALSE)
student_answer = 'aa';
correct_answers = 'abc';
result = fcn_DebugTools_doStringsMatch(student_answer,correct_answers);
assert(result==false);
```

<a href="#debugtools">Back to top</a>

***

### Extracting a numeric value embedded in a string

The function fcn_DebugTools_extractNumberFromStringCell takes a char type in a cell, and finds the first number within that is numeric, and then returns the string for this number. It is robust in that weird entries also work, such as '-0004.2'. This function is particularly useful to parse human-input numbers.

```Matlab
%% Decimal number, negative, in cell array with leading zeros and text
result = fcn_DebugTools_extractNumberFromStringCell({'My number is -0000.4'});
assert(isequal(result,{'-0.4'}));
```

<a href="#debugtools">Back to top</a>

***

### Parsing a comma separated string into cells

The function fcn_DebugTools_parseStringIntoCells parses a string containing comma-separated elements, parsing out the elements into cells.

```Matlab
%% Demonstrate fcn_DebugTools_parseStringIntoCells
% Choose a very Complex input
inputString = 'This,isatest,of';
result = fcn_DebugTools_parseStringIntoCells(inputString);
assert(isequal(result,[{'This'},{'isatest'},{'of'}]));
```

<a href="#debugtools">Back to top</a>

***

### Converting a mixed input cell array into comma separated string

The function fcn_DebugTools_parseStringIntoCells parses a string containing comma-separated elements, parsing out the elements into cells.

```Matlab
%% Demonstrate fcn_DebugTools_convertVariableToCellString
% Multiple mixed character, numeric in cell array ending in string with commas
result = fcn_DebugTools_convertVariableToCellString([{'D'},{2},'abc , 123']);
assert(isequal(result,{'D, 2, abc , 123'}));
```

<a href="#debugtools">Back to top</a>

***

### Query user to select index range

The function

fcn_DebugTools_queryNumberRange

queries the user to select a number based on a flag vector, and
optionally can confirm the selection is valid if user selects a number
range that overlaps indicies where a flag value is equal to 1

```Matlab
FORMAT:

     [flag_keepGoing, startingIndex, endingIndex] = fcn_DebugTools_queryNumberRange(flags_toCheck, (queryEndString), (flag_confirmOverwrite), (directory_filelist), (fid))

INPUTS:

     flags_toCheck: a list of flags, either 1 or 0, that indicate that
     the number is either "done" (value = 1) or "not done" (value = 0).
     The query defaults to the first "not done" value (the first 0).
     Then, based on the user's entry, the query defaults to
     subsequent-to-start last "not done" or 0 value in flags_toCheck. For
     example, if flags_toCheck = [1 1 0 0 0 1 1 0 0 1], then the default start
     index will be 3 as this is the first index in flags_toCheck where a
     0 appears. If the user however selects a starting index of 6, then
     the prompt will give a default ending index of 9, as this is the
     last 0 value to appear after the 6 index.

     (OPTIONAL INPUTS)

     queryEndString: a string that appears at the end of the number query
     given at each prompt, filled in as the XXX in the form:
     "What is the starting numberXXXXX?". For example, if some enters:
     " of the file(s) to parse", then the prompt will be:
     "What is the starting number of the files to parse?". Default is
     empty.

     flag_confirmOverwrite: set to 1 to force the user to confirm
     "overwrite" if the user selects a number range such that it overlaps
     with one of the indicies where flags_toCheck is 1. Or, set to 0 to
     skip this checking.  Default is 1

     directory_filelist: a structure array that is the output of a
     "dir" command. This is used to show which files corresponding to
     flags_toCheck will be overwritten. A typical output can be generated
     using: directory_filelist =
     fcn_DebugTools_listDirectoryContents({cd});

     fid: the fileID where to print. Default is 0, to NOT print results to
     the console. If set to -1, skips any input checking or debugging, no
     prints will be generated, and sets up code to maximize speed.

OUTPUTS:

     flag_keepGoing: outputs a 1 if user accepts, 0 otherwise

     startingIndex: the user-selected first index

     endingIndex: the user-selected first index
```

And here is an example usage:

```Matlab
rng(1);

% Create a directory filelist by querying the "Functions" folder for all .m
% files
directory_filelist = fcn_DebugTools_listDirectoryContents({fullfile(cd,'Functions')},'*.m',0);

dirNames = {directory_filelist.name}';
dirScripts = contains(dirNames,'script');
celldirScripts = mat2cell(dirScripts,ones(1,length(dirNames)));
dirScriptYesNo = fcn_DebugTools_convertBinaryToYesNoStrings(dirScripts);

cellArrayHeaders = {'m-filename                                                         ', 'Script flag?   ', 'Script?   '};
cellArrayValues = [dirNames, celldirScripts, dirScriptYesNo];

% Print to screen
fcn_DebugTools_printNumeredDirectoryList(directory_filelist, cellArrayHeaders, cellArrayValues, ([]), (fid))


% Set up call to function
flags_toCheck = dirScripts;
queryEndString = ' function to change to script';
flag_confirmOverwrite = 1;
fid = 1;
[flag_keepGoing, startingIndex, endingIndex] = fcn_DebugTools_queryNumberRange(flags_toCheck, (queryEndString), (flag_confirmOverwrite), (directory_filelist), (fid));

assert(flag_keepGoing==1 || flag_keepGoing==0);
assert(startingIndex>0 && startingIndex<=length(flags_toCheck));
assert(endingIndex>=startingIndex && endingIndex<=length(flags_toCheck));
```

<a href="#debugtools">Back to top</a>

***

### Break column of data by NaN values using fcn_DebugTools_breakArrayByNans

The function

fcn_DebugTools_breakArrayByNans

breaks an Nx1 column of data into cell arrays using NaN values as separators

```Matlab
fcn_DebugTools_breakArrayByNans   

breaks data separated by nan into subdata organized into cell arrays. For
example, 
   test_data = [2; 3; 4; nan; 6; 7];
   indicies_cell_array = fcn_DebugTools_breakArrayByNans(test_data);
% Returns:
   indicies_cell_array{1} = [1; 2; 3];
   indicies_cell_array{2} = [5; 6];

FORMAT:

      indicies_cell_array = fcn_DebugTools_breakArrayByNans(input_array, (fig_num))

INPUTS:

      input_array: an Nx1 matrix where some rows contain NaN values

     (OPTIONAL INPUTS)

     fig_num: a figure number to plot results. If set to -1, skips any
     input checking or debugging, no figures will be generated, and sets
     up code to maximize speed.

OUTPUTS:

      indicies_cell_array: a cell array of indicies, one array for each
      section of the matrix that is separated by NaN values

```

And here is an example usage:

```Matlab
test_data = [2; 3; 4; nan; 6; 7];
indicies_cell_array = fcn_DebugTools_breakArrayByNans(test_data, (fig_num));

% Check variable types
assert(iscell(indicies_cell_array))

% Check variable sizes
assert(size(indicies_cell_array,1)==1);
assert(size(indicies_cell_array,2)==2);

% Check variable values
assert(isequal(indicies_cell_array{1},[1; 2; 3]));
assert(isequal(indicies_cell_array{2},[5; 6]));

```

<a href="#debugtools">Back to top</a>

***

## Functions for Output Formatting

### Converting numbers to human friendly strings

The function: fcn_DebugTools_number2string.m prints a "pretty" version of a string, e.g avoiding weirdly odd numbers of decimal places or strangely formatted printing.

```Matlab
%% Basic case - example
stringNumber = fcn_DebugTools_number2string(2.333333333); % Empty result
assert(isequal(stringNumber,'2.33'));
fprintf(1,'%s\n',stringNumber);
```

Produces the following result:

```Matlab
2.33
```

<a href="#debugtools">Back to top</a>

***

### Appending arbitrary values to a string

The function: fcn_DebugTools_addStringToEnd.m appends a number, cell string, or string to the end of a string, producing a string.

```Matlab
input_string = 'test';
value_to_add = 2;
output_string = fcn_DebugTools_addStringToEnd(input_string,value_to_add);
assert(isequal(output_string,'test 2'));
```

Produces the following result:

```Matlab
test 2
```

<a href="#debugtools">Back to top</a>

***

### Converting flags into yes and no strings

The function: fcn_DebugTools_convertBinaryToYesNoStrings
Converts Nx1 of scalar 1 or 0 vectors into Nx1 cell arrays containing
'yes' or 'no' corresponding to the 1's or 0's respectively

```Matlab
FORMAT:

     cellArrrayYesNo = fcn_DebugTools_convertBinaryToYesNoStrings(flags_binary, (fid))

INPUTS:

     flags_binary: a column array, [N x 1], of 1's or 0's

     (OPTIONAL INPUTS)

     fid: the fileID where to print. Default is 0, to NOT print results to
     the console. If set to -1, skips any input checking or debugging, no
     prints will be generated, and sets up code to maximize speed.

OUTPUTS:

     cellArrrayYesNo: a cell array of N rows, 1 column, of 'yes' or 'no'
     strings
```

An example output is as follows:

```Matlab
flags_binary = [0; 1; 0];
cellArrrayYesNo = fcn_DebugTools_convertBinaryToYesNoStrings(flags_binary);

assert(isequal(cellArrrayYesNo,{'no';'yes';'no'}))
```

<a href="#debugtools">Back to top</a>

***

### Printing results to fixed length strings

The function: fcn_DebugTools_debugPrintStringToNCharacters converts strings into fixed-length forms, so that they print cleanly. For example, the following 2 basic examples:

```Matlab
% BASIC example 1 - string is too long
test_string = 'This is a really, really, really long string but we only want the first 10 characters';
fixed_length_string = fcn_DebugTools_debugPrintStringToNCharacters(test_string,10);
fprintf(1,'The string: %s\nwas converted to: "%s"\n',test_string,fixed_length_string);

% BASIC example 2 - string is too short
test_string = 'Tiny string but should be 40 chars';
fixed_length_string = fcn_DebugTools_debugPrintStringToNCharacters(test_string,40);
fprintf(1,'The string: %s\nwas converted to: "%s"\n',test_string,fixed_length_string);
```

Produces the following output:

```Matlab
The string: This is a really, really, really long string but we only want the first 10 characters
was converted to: "This is a "
The string: Tiny string but should be 40 chars
was converted to: "Tiny string but should be 40 chars      "
```

<a href="#debugtools">Back to top</a>

***

### Printing matrices to fixed length columns

The function: fcn_DebugTools_debugPrintTableToNCharacters, given a matrix of data, prints the data in user-specified width to the workspace.

```Matlab
%% Fill in test data
Npoints = 10;
point_IDs = (1:Npoints)';
intersection_points = rand(Npoints,2);
s_coordinates_in_traversal_1 = rand(Npoints,1);
s_coordinates_in_traversal_2 = 1000*rand(Npoints,1);
table_data = [point_IDs, intersection_points, s_coordinates_in_traversal_1, s_coordinates_in_traversal_2];

%% Basic test case - constant column widths
header_strings = [{'Data ID'}, {'Location X'},{'Location Y'},{'s-coord 1'},{'s-coord 2'}];
formatter_strings = [{'%.0d'},{'%.12f'},{'%.12f'},{'%.12f'},{'%.12f'}];
N_chars = 15; % All columns have same number of characters
fcn_DebugTools_debugPrintTableToNCharacters(table_data, header_strings, formatter_strings,N_chars);


%% Advanced test case - variable column widths
header_strings = [{'Data ID'}, {'Location X'},{'Location Y'},{'s-coord 1'},{'s-coord 2'}]; % Headers for each column
formatter_strings = [{'%.0d'},{'%.12f'},{'%.12f'},{'%.12f'},{'%.12f'}]; % How should each column be printed?
N_chars = [4, 15, 15, 5, 5]; % Specify spaces for each column
fcn_DebugTools_debugPrintTableToNCharacters(table_data, header_strings, formatter_strings,N_chars);
```

Produces the following output:

```Matlab
Data ID         Location X      Location Y      s-coord 1       s-coord 2       
1               0.083497561789  0.466512012381  0.872812993043  231.09536311113 
2               0.279828920000  0.498104487123  0.938002006920  527.43396277663 
3               0.447007309335  0.487430654415  0.139689278548  724.99196135723 
4               0.587571263995  0.229468774748  0.393900144851  607.41579114493 
5               0.877634138415  0.085552232409  0.980562829715  588.36644579525 
6               0.469100520229  0.067383313609  0.644794025985  433.43484003305 
7               0.437418475702  0.888390934805  0.896409779454  244.17289350702 
8               0.746184939975  0.233167685670  0.482230405437  428.96035377800 
9               0.467910465808  0.861595759984  0.014093075189  10.177455521777 
10              0.860827351058  0.711735093008  0.622880344435  608.82144904436 


Data Location X      Location Y      s-coo s-coo 
1    0.083497561789  0.466512012381  0.872 231.0 
2    0.279828920000  0.498104487123  0.938 527.4 
3    0.447007309335  0.487430654415  0.139 724.9 
4    0.587571263995  0.229468774748  0.393 607.4 
5    0.877634138415  0.085552232409  0.980 588.3 
6    0.469100520229  0.067383313609  0.644 433.4 
7    0.437418475702  0.888390934805  0.896 244.1 
8    0.746184939975  0.233167685670  0.482 428.9 
9    0.467910465808  0.861595759984  0.014 10.17 
10   0.860827351058  0.711735093008  0.622 608.8 
```

<a href="#debugtools">Back to top</a>

***

### Printing directory listings alongside flags and data

fcn_DebugTools_printNumeredDirectoryList
prints a directory file list alongside lists of flags and details.

```Matlab

FORMAT:

     fcn_DebugTools_printNumeredDirectoryList(directory_filelist, cellArrayHeaders, cellArrayValues, (directoryRoot), (fid))

INPUTS:

     directory_filelist: a structure array that is the output of a
     "dir" command. A typical output can be generated using:
     directory_filelist = fcn_DebugTools_listDirectoryContents({cd});

     cellArrayHeaders: a [Nx1] cell array of strings representing the
     headers. Note: the printing width of each column is inhereted by the
     length of each string.

     cellArrayValues: a cell array of the contents to be printed

     (OPTIONAL INPUTS)

     directoryRoot: a string representing the root of the directory
     listing. By default, this is empty. However, in some folder
     printings, the listing is intended for relative and not absolute
     folder locations. By entering a string for the "root" of the
     directory listing, the folders are printed in "relative to root"
     format which makes printing more simple.

     fid: the fileID where to print. Default is 0, to NOT print results to
     the console. If set to -1, skips any input checking or debugging, no
     prints will be generated, and sets up code to maximize speed.

OUTPUTS:

     (printing to console)

```

An example output is as follows:

```Matlab
rng(1);

% Create a directory filelist by querying the "Functions" folder for all .m
% files
directory_filelist = fcn_DebugTools_listDirectoryContents({fullfile(cd,'Functions')},'*.m',0);

dirNames = {directory_filelist.name}';
dirBytes = [directory_filelist.bytes]';
celldirBytes = mat2cell(dirBytes,ones(1,length(dirNames)));
dirBigFile = dirBytes>1000;
celldirBigFile = mat2cell(dirBigFile,ones(1,length(dirNames)));
dirBigFileYesNo = fcn_DebugTools_convertBinaryToYesNoStrings(dirBigFile);
dirFloat = rand(length(directory_filelist),1).*10.^(10*randn(length(directory_filelist),1));
celldirFloat = mat2cell(dirFloat,ones(1,length(dirNames)));

cellArrayHeaders = {'m-filename                                                         ', 'bytes    ', 'big file?   ', 'Some yes or no  ', 'Some float   '};
cellArrayValues = [dirNames, celldirBytes, celldirBigFile, dirBigFileYesNo, celldirFloat];

% Call the function
fcn_DebugTools_printNumeredDirectoryList(directory_filelist, cellArrayHeaders, cellArrayValues, ([]), (fid))
```

Produces the following output:

```Matlab

  m-filename                                                          bytes     big file?    Some yes or no   Some float    
Folder: D:\GitHubRepos\IVSG\Errata\Tutorials\DebugTools\Functions:
 1 class_DebugFlags.m                                                  7999      1            yes              4.5043e+05    
 2 fcn_DebugTools_addStringToEnd.m                                     4157      1            yes              3.1993e-06    
 3 fcn_DebugTools_addSubdirectoriesToPath.m                            4420      1            yes              3.2176e-06    
 4 fcn_DebugTools_checkInputsToFunctions.m                             33103     1            yes              3.9968e+05    
 5 fcn_DebugTools_confirmTimeToProcessDirectory.m                      7250      1            yes              5.2864e-12    
 6 fcn_DebugTools_convertBinaryToYesNoStrings.m                        5068      1            yes              3.2290e-05    
 7 fcn_DebugTools_convertVariableToCellString.m                        4804      1            yes              3.5981e-13    
 8 fcn_DebugTools_countBytesInDirectoryListing.m                       8954      1            yes              4.8157e-08    
 9 fcn_DebugTools_cprintf.m                                            30654     1            yes              7.2560e+08    
 10 fcn_DebugTools_debugPrintStringToNCharacters.m                      3916      1            yes              8.2165e-16    
 11 fcn_DebugTools_debugPrintTableToNCharacters.m                       5190      1            yes              1.1011e-06    
 12 fcn_DebugTools_doStringsMatch.m                                     5335      1            yes              0.3559        
 13 fcn_DebugTools_extractNumberFromStringCell.m                        8371      1            yes              3.5291e-16    
 14 fcn_DebugTools_installDependencies.m                                15752     1            yes              340.8413      
 15 fcn_DebugTools_listDirectoryContents.m                              8955      1            yes              1.7809e-22    
 16 fcn_DebugTools_makeDirectory.m                                      7135      1            yes              66.6470       
 17 fcn_DebugTools_number2string.m                                      4449      1            yes              7.5700e+03    
 18 fcn_DebugTools_parseStringIntoCells.m                               5510      1            yes              1.1136e-13    
 19 fcn_DebugTools_printDirectoryListing.m                              8152      1            yes              1.9731e-06    
 20 fcn_DebugTools_printNumeredDirectoryList.m                          8904      1            yes              1.7377e+05    
 21 fcn_DebugTools_sortDirectoryListingByTime.m                         6900      1            yes              0.0014        
 22 script_test_all_functions.m                                         5976      1            yes              2.5714e-19    
 23 script_test_class_DebugFlags.m                                      2855      1            yes              0.8006        
 24 script_test_fcn_DebugTools_addStringToEnd.m                         1058      1            yes              467.7462      
 25 script_test_fcn_DebugTools_addSubdirectoriesToPath.m                1278      1            yes              3.7871        
 26 script_test_fcn_DebugTools_checkInputsToFunctions.m                 47550     1            yes              1.9317e+04    
 27 script_test_fcn_DebugTools_confirmTimeToProcessDirectory.m          1340      1            yes              1.4396e+03    
 28 script_test_fcn_DebugTools_convertBinaryToYesNoStrings.m            658       0            no               3.8633e+11    
 29 script_test_fcn_DebugTools_convertVariableToCellString.m            1345      1            yes              5.3961e-12    
 30 script_test_fcn_DebugTools_countBytesInDirectoryListing.m           2545      1            yes              1.2007e-18    
 31 script_test_fcn_DebugTools_cprintf.m                                8027      1            yes              1.4230e+07    
 32 script_test_fcn_DebugTools_debugPrintStringToNCharacters.m          4388      1            yes              2.1994e-04    
 33 script_test_fcn_DebugTools_debugPrintTableToNCharacters.m           1953      1            yes              6.8495e-13    
 34 script_test_fcn_DebugTools_doStringsMatch.m                         3538      1            yes              7.0015e+10    
 35 script_test_fcn_DebugTools_extractNumberFromStringCell.m            3605      1            yes              5.8218e-06    
 36 script_test_fcn_DebugTools_installDependencies.m                    5804      1            yes              3.0643e+08    
 37 script_test_fcn_DebugTools_listDirectoryContents.m                  4969      1            yes              4.0625e+03    
 38 script_test_fcn_DebugTools_makeDirectory.m                          933       0            no               2.7887e+14    
 39 script_test_fcn_DebugTools_number2string.m                          2866      1            yes              539.0431      
 40 script_test_fcn_DebugTools_parseStringIntoCells.m                   1017      1            yes              2.1547e+06    
 41 script_test_fcn_DebugTools_printDirectoryListing.m                  1286      1            yes              5.7327e-07    
 42 script_test_fcn_DebugTools_printNumeredDirectoryList.m              2664      1            yes              8.3490e-07    
 43 script_test_fcn_DebugTools_sortDirectoryListingByTime.m             786       0            no               3.6398e+15    
```

<a href="#debugtools">Back to top</a>

***

<!-- USAGE EXAMPLES -->
## Usage
<!-- Use this space to show useful examples of how a project can be used.
Additional screenshots, code examples and demos work well in this space. You may
also link to more resources. -->

<a href="#debugtools">Back to top</a>

<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE` for more information.

<a href="#debugtools">Back to top</a>

## Major release versions

This code is still in development (alpha testing).
The 2023-01-25 release includes the following addition:

* Updated README
* Added fcn_DebugTools_installDependencies to support automated URL-referenced install of code packages

The 2023-01-18 release includes the following addition:

* Updated README
* Adding directory and file queries for input checking
* String output functions (fixed-length printing)
* Input functions (string parsing)
* Table formatted fixed-column-width output

<a href="#debugtools">Back to top</a>

<!-- CONTACT -->
## Contact

Sean Brennan - <sbrennan@psu.edu>

Project Link: [https://github.com/ivsg-psu/Errata_Tutorials_DebugTools](https://github.com/ivsg-psu/Errata_Tutorials_DebugTools)

<a href="#debugtools">Back to top</a>

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
