
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ------------- Hough Transform -------------- %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Read image and find edge points
clear all; close all;
I = imread("car_images\Cars1.png");
[f,rect] = imcrop(I);
% convert to greyscale
f = rgb2gray(f);

%------------- STEP 1 --------------%
fEdge = edge(f,'Canny');
figure(1)
montage({f,fEdge})
title('Step 1: edge point image that feeds into the Hough Transform');

%------------- STEP 2 --------------%
% Perform Hough Transform and plot count as image intensity
[H, theta, rho] = hough(fEdge);
figure(2)
imshow(H,[],'XData',theta,'YData', rho, ...
            'InitialMagnification','fit');
xlabel('theta'), ylabel('rho');
title('Step 2: counts in the Hough transform parameter domain');
axis on, axis normal, hold on;


%------------- STEP 3 --------------%
% Find 5 larges peaks and superimpose markers on Hough image
figure(2)
%peaks  = houghpeaks(H,5);
peaks  = houghpeaks(H,4,'threshold',ceil(0.3*max(H(:))));
x = theta(peaks(:,2)); y = rho(peaks(:,1));
plot(x,y,'o','color','red', 'MarkerSize',10, 'LineWidth',1);
title('Step 3: find the 5 tallest peaks in H');


%------------- STEP 4 --------------%

% Plot the Hough image as a 3D plot (called SURF)
figure(3)
surf(theta, rho, H);
xlabel('theta','FontSize',16);
ylabel('rho','FontSize',16)
zlabel('Hough Transform counts','FontSize',16)
title('Step 4: Exploring the Peaks in H');


%------------- STEP 5 --------------%

% From theta and rho and plot lines
lines = houghlines(fEdge,theta,rho,peaks,'FillGap',5,'MinLength',7);
figure(4), imshow(f),
figure(4); hold on
max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
end
 title('Step 5: Fit lines into the image');