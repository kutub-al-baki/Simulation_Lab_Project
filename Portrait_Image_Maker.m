clc; clear all;

% Step 1: Reading the RGB image
I = imread('1.jpg');  
figure, imshow(I), title('Original Image');

% Step 2: Converting the image to grayscale
grayImage = rgb2gray(I);

% Step 3: Applying Gaussian blur to reduce noise (this step helps reduce small dots)
blurredImage = imgaussfilt(grayImage, 2);  

% Step 4: Performing Canny edge detection with custom thresholds 
edgeImage = edge(blurredImage, 'canny', [0.3 0.5]);  
figure, imshow(edgeImage), title('Canny Edge Detection');

% Step 5: Filling in the interior of the edges
filledImage = imfill(edgeImage, 'holes');  % This fills all enclosed areas



% Step 6: To clean small dots (if any) inside the object further
se = strel('disk', 25);  % Structuring element for closing operation
cleanedFilledImage = imclose(filledImage, se);  % Closing gaps and smooth edges

filledImage2 = imfill(cleanedFilledImage, 'holes');
se = strel('disk', 25);  % Structuring element for closing operation
cleanedFilledImage2 = imclose(filledImage2, se);  % Closing gaps and smooth edges

% Step 7: Displaying the final cleaned and filled image
figure, imshow(cleanedFilledImage2);
title('Final Cleaned and Filled Image');

sigma = 15; 
gaussianFiltered = imgaussfilt(I, sigma);

finalImage = I;  

% Step 8: Replacing areas based on the binary mask
% If the binary number is 1, keeping the original image pixel, otherwise using the Gaussian filtered image
for i = 1:size(I, 1)
    for j = 1:size(I, 2)
        if cleanedFilledImage2(i, j) == 0
            finalImage(i, j, :) = gaussianFiltered(i, j, :);
        end
    end
end

% Step 9: Showing the final image
figure, imshow(finalImage), title('Final Blurred Image ');