clear

try
    
    addpath('/home/javier/flatMounts/')
    
    rootFolder='/home/javier/qurvaImages/';
    
    %% Email settings
    props = java.lang.System.getProperties;
    props.setProperty('mail.smtp.auth','true');
    props.setProperty('mail.smtp.port','10025');
    % setpref('Internet','SMTP_Server','just59.justhost.com');
    setpref('Internet','SMTP_Server','localhost');
    setpref('Internet','E_mail','qurva@biophotonics.ca');
    setpref('Internet','SMTP_Username','qurva@biophotonics.ca');
    setpref('Internet','SMTP_Password','0pt1mu5QuRVA');
    
    %% get file names
    fileNamesToProcess=getImageList([rootFolder 'imagesToProcess']);
    
    %% process if there's something
    if numel(fileNamesToProcess)>0
        processFolder([rootFolder 'imagesToProcess'])
        
        AnalysisResult = openExcelReport([rootFolder 'imagesToProcess']);
        
        for itFile=1:numel(fileNamesToProcess)
            row=find(strcmp(AnalysisResult.FileName, fileNamesToProcess{itFile}))
            
            %% Numbers for each email
            thisFlatMountArea=AnalysisResult.FlatMountArea(row);
            thisAVascularArea=AnalysisResult.AVascularArea(row);
            thisBranchingPoints=AnalysisResult.BranchingPoints(row);
            thisVasculatureLength=AnalysisResult.VasculatureLength(row);
            thisTuftArea=AnalysisResult.TuftArea(row);
            thisTuftNumber=AnalysisResult.TuftNumber(row);
            
            %% Parse fileName
            [outEmailAddress, outFileName] = parseImageName(fileNamesToProcess{itFile})
            
            %% compose text
            emailText=['Thanks for using QuRVA' 10 10 'These are the results we have obtained for ' outFileName ':' 10 ...
                'FlatMount Area = ' num2str(thisFlatMountArea) 10 ...
                'Avascular Area = ' num2str(thisAVascularArea) 10 ...
                'Number of branching points = ' num2str(thisBranchingPoints) 10 ...
                'Vasculature full length = ' num2str(thisVasculatureLength) 10 ...
                'Tufts area = ' num2str(thisTuftArea) 10 ...
                'Total number of tusft = ' num2str(thisTuftNumber) 10 10 ...
                'You can request a copy of the software to process multiple images at once locally' 10 ...
                'Please cite this paper:'];
            
            %% send email
            
            % Open tunnel in the background and keeps it open for at least 10
            % seconds for sendmail to open the port. It will close as soon as
            % the port is released.
            system('ssh -L 10025:just59.justhost.com:25 ccvmj sleep 10')
            % Allow 2 seconds to the port to be opened.
            pause(2)
            sendmail(outEmailAddress,'Analysis Ready', emailText, ...
                {fullfile(rootFolder, 'imagesToProcess/TuftImages/', fileNamesToProcess{itFile}),...
                fullfile(rootFolder, 'imagesToProcess/VasculatureImages/', fileNamesToProcess{itFile})})
            %% move file to the Already Processed folder
            movefile([rootFolder 'imagesToProcess/' fileNamesToProcess{itFile}], [rootFolder 'imagesToProcess/imagesAlreadyProcessed/' fileNamesToProcess{itFile}])
            
        end
    end
    
catch exception
    errString = ['Error in retinaLayersSegmentation. Message: ' exception.message];
    errString = [errString buildCallStack(exception)];
    disp(errString)
end


