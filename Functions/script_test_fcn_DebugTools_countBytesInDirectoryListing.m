% script_test_fcn_DebugTools_countBytesInDirectoryListing.m
% tests fcn_DebugTools_countBytesInDirectoryListing.m

% REVISION HISTORY:
% 
% 2024_10_24 - sbrennan@psu.edu
% - wrote the code originally, 
%   % * using fcn_DataClean_loadRawDataFromDirectories as starter
%
% 2025_11_20 by Sean Brennan, sbrennan@psu.edu
% - Formatted revision lists to Markdown format

% TO-DO:
% 2025_11_20 by Sean Brennan, sbrennan@psu.edu
% - Need to put into standard form

%% Set up the workspace
close all

%% Test 1: Count the total number of bytes for files in the current directory and subdirectories

directory_filelist = fcn_DebugTools_listDirectoryContents({cd});

indicies = [];
fid = 1;
[totalBytes, Nfolders, Nfiles] = fcn_DebugTools_countBytesInDirectoryListing(directory_filelist,(indicies),(fid));

assert(totalBytes>=0);
assert(Nfolders>=0);
assert(Nfiles>=0);

%% Test 2: Count the first 10 files/folders bytes for files in the current directory and subdirectories

directory_filelist = fcn_DebugTools_listDirectoryContents({cd});

indicies = 1:10;
fid = 1;
[totalBytes, Nfolders, Nfiles] = fcn_DebugTools_countBytesInDirectoryListing(directory_filelist,(indicies),(fid));

assert(totalBytes>=0);
assert(Nfolders>=0);
assert(Nfiles>=0);
assert((Nfiles+Nfolders)<=length(indicies)); % Note: some indicies may be degenerate folders such as '.' and '..' - these are not counted

% Produced the following:
% Total number of files and folders indexed: 10, containing 1,660 bytes, 6 folders, and 2 files
% Breakdown:
% 		FOLDERS:                                                              	    BYTES (in and below):
% 		D:\GitHubRepos\IVSG\Errata\Tutorials\DebugTools\.git                  	               51,667,259
% 		D:\GitHubRepos\IVSG\Errata\Tutorials\DebugTools\Data                  	                      330
% 		D:\GitHubRepos\IVSG\Errata\Tutorials\DebugTools\Documents             	                7,106,499
% 		D:\GitHubRepos\IVSG\Errata\Tutorials\DebugTools\Example Code Snippets 	                   23,296
% 		D:\GitHubRepos\IVSG\Errata\Tutorials\DebugTools\Functions             	                  284,354
% 		D:\GitHubRepos\IVSG\Errata\Tutorials\DebugTools\Images                	                1,983,583
% 
% 		FILES:                                                                	                   BYTES:
% 		D:\GitHubRepos\IVSG\Errata\Tutorials\DebugTools\.gitignore            	                      523
% 		D:\GitHubRepos\IVSG\Errata\Tutorials\DebugTools\LICENSE               	                    1,137


%% Fail conditions
if 1==0
    %% ERROR for bad data folder
    bagName = "badData";
    rawdata = fcn_DataClean_loadMappingVanDataFromFile(bagName, bagName);
end
