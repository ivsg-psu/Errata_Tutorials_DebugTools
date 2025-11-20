% Renames all files with one repo name to the name of another


% REVISION HISTORY:
% 
% 2025_11_20 by Sean Brennan, sbrennan@psu.edu
% - Updated revision hist to markdown format


% TO-DO:
% 
% 2025_11_20 by Sean Brennan, sbrennan@psu.edu
% - Need better testing, standard form, etc.


thisPath = fullfile(cd,'Functions');
directoryList = dir(thisPath);

stringToFind = '_DataClean_';
stringToReplaceWith = '_LoadRawDataToMATLAB_';

numChanged = 0;
for ith_file = 1:length(directoryList)
    thisName = directoryList(ith_file).name;
    if contains(thisName,stringToFind)
        newName = replace(thisName,stringToFind,stringToReplaceWith);
        fullnameSource = fullfile(cd,'Functions',thisName);
        fullnameDestination = fullfile(cd,'Functions',newName);
        [moveStatus,moveMessage,moveMessageID] = movefile(fullnameSource,fullnameDestination,'f');
        if moveStatus~=1
            fprintf(1,'moveMessage: %s\n',moveMessage);
            fprintf(1,'moveMessageID: %s\n', moveMessageID);
            error('Move was not successful?');
        end
        fprintf('Changed %s \nto %s\n\n',thisName,newName);
        numChanged = numChanged+1;
    end
end
fprintf(1,'Number of changed names: %.0f\n',numChanged)