# DVS-Final-Project

## Identifying Car Licenses
In this project, we were able to identify the numbers and letters of license plates from images of cars, using image processing tools such as segmentation and two character recognition methods.

## Running the code
To test our code, simply download the project files and run PlateDetection.mlx in MatLab. Make sure you are using the most recent version of MatLab (R2023b) as the OCR Recognition might not work otherwise. If you wish, you can change the image name in PlateDetection.mlx with another image from the car_img folder, to process another license plate. The homography transform part of the code is best demonstrated with cars4.png
Please see the 3 PDFs for evidence that the code runs correctly. 

### Example
**Original Image**
[image]
**Crop around license plate**
[image]
**Align the license plate with Hough Transform**
[image]
**Segmentation of the different letters**
[image]
**Formatting each letter image for character recognition**
[image]
**Character Recognition - Using OCR**
[image- show on 1 letter]
**Character Recognition - Using template comparison**
[image- show on 1 letter]
**Result**
[image- matlab output of the whole license plate]


## Discussion
In this project, we were able to successfully identify the position of the license plate and each letter/number, regardless of size, position, orientation and number of characters. The segmentation of the images was very successful for a range of perspectives and scales of licence plates. We were able to implement two character recognition methods in order to compare them. However, improvements could be made regarding character recognition as both methods are prone to some errors with some images. 
We implemented 2 different ways to recognise the letters, 1 being the MATLAB OCR function, and 2 being a similarity comparsion between template images. Both methods have errors sometimes, but the MATLAB OCR method is a bit more reliable, although the classification algorithm should be trained on more block letters.
Furthermore, our project works well with images of cars offering a high contrast with their license plate (i.e. dark cars), but additional work would be required to operate with light colored cars.
