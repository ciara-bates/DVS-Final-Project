%% SECTION 1
clear all;
f = imread("car_images\Cars0.png");
f = imresize(f,2);
[f,rect] = imcrop(f); %user crops the image as best they can to the licence plate area

I = imresize(f,[500 NaN]); %resize so the number of rows of pixels is 500. 
%The number of columns is automatically calculated based on aspect ratio

imshow(I)

disp('SECTION 1 success')

%% SECTION 2
I = im2gray(I); %for MSER to work
% Detect MSER regions. 
[mserRegions, mserConnComp] = detectMSERFeatures(I, ... 
    "RegionAreaRange",[10000 60000],"ThresholdDelta",5);

figure
imshow(I)
hold on
plot(mserRegions, "showPixelList", true,"showEllipses",false)
title("MSER regions")
hold off

% Use regionprops (region properties) to measure MSER properties
mserStats = regionprops(mserConnComp, "BoundingBox", "Eccentricity", ...
    "Solidity", "Extent", "Euler", "Image");

% Compute the aspect ratio using bounding box data.
bbox = vertcat(mserStats.BoundingBox);
w = bbox(:,3);
h = bbox(:,4);
aspectRatio = w./h;

% Threshold the data to determine which regions to remove. These thresholds
% may need to be tuned for other images.
filterIdx = aspectRatio' > 3; 
filterIdx = filterIdx | [mserStats.Eccentricity] > .995 ;
filterIdx = filterIdx | [mserStats.Solidity] < .3;
filterIdx = filterIdx | [mserStats.Extent] < 0.2 | [mserStats.Extent] > 0.9;
filterIdx = filterIdx | [mserStats.EulerNumber] < -4;

% Remove regions
mserStats(filterIdx) = [];
mserRegions(filterIdx) = [];

% Show remaining regions
figure
imshow(I)
hold on
plot(mserRegions, "showPixelList", true,"showEllipses",false)
title("After Removing Non-Text Regions Based On Geometric Properties")
hold off

disp('SECTION 2 success')

%% SECTION 3

% Get bounding boxes for all the regions
bboxes = vertcat(mserStats.BoundingBox);

% Convert from the [x y width height] bounding box format to the [xmin ymin
% xmax ymax] format for convenience.
xmin = bboxes(:,1);
ymin = bboxes(:,2);
xmax = xmin + bboxes(:,3) - 1;
ymax = ymin + bboxes(:,4) - 1;

% Expand the bounding boxes by a small amount.
expansionAmount = 0.02;
xmin = (1-expansionAmount) * xmin;
ymin = (1-expansionAmount) * ymin;
xmax = (1+expansionAmount) * xmax;
ymax = (1+expansionAmount) * ymax;

% Clip the bounding boxes to be within the image bounds
xmin = max(xmin, 1);
ymin = max(ymin, 1);
xmax = min(xmax, size(I,2));
ymax = min(ymax, size(I,1));

% Show the expanded bounding boxes
expandedBBoxes = [xmin ymin xmax-xmin+1 ymax-ymin+1];
IExpandedBBoxes = insertShape(I,"rectangle",expandedBBoxes,"LineWidth",3);

figure
imshow(IExpandedBBoxes)
title("Expanded Bounding Boxes Text")

disp('SECTION 3 success')

%% SECTION 4
% Compute the overlap ratio
overlapRatio = bboxOverlapRatio(expandedBBoxes, expandedBBoxes);

% Set the overlap ratio between a bounding box and itself to zero to
% simplify the graph representation.
n = size(overlapRatio,1); 
overlapRatio(1:n+1:n^2) = 0;

% Create the graph
g = graph(overlapRatio);

% Find the connected text regions within the graph
componentIndices = conncomp(g);

disp('SECTION 4 success')

%% SECTION 5

% Merge the boxes based on the minimum and maximum dimensions.
xmin = accumarray(componentIndices', xmin, [], @min);
ymin = accumarray(componentIndices', ymin, [], @min);
xmax = accumarray(componentIndices', xmax, [], @max);
ymax = accumarray(componentIndices', ymax, [], @max);

% Compose the merged bounding boxes using the [x y width height] format.
textBBoxes = [xmin ymin xmax-xmin+1 ymax-ymin+1];

disp('SECTION 5 success')

%% SECTION 6

% Remove bounding boxes that only contain one text region
numRegionsInGroup = histcounts(componentIndices);
textBBoxes(numRegionsInGroup == 1, :) = [];

% Show the final text detection result.
ITextRegion = insertShape(I, "rectangle", textBBoxes,"LineWidth",3);

figure
imshow(ITextRegion)
title("Detected Text")

disp('SECTION 6 success')



%% SECTION 7
try
    % Perform OCR
    ocrtxt = ocr(I, textBBoxes);
    
    % Check if OCR successfully recognized text
    if ~isempty(ocrtxt.Text)
        % Display the recognized text
        licence_plate = [ocrtxt.Text];
        disp(['License plate: ' licence_plate]);
    else
        disp('OCR did not recognize any text.');
    end
catch ME
    % Handle OCR errors
    disp(['OCR Error: ' ME.message]);
    disp('Try adjusting OCR parameters or preprocessing the image.');
end

% Print a success message to the command window
disp('SECTION 7 success');





