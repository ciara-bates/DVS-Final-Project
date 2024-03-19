# DVS-Final-Project

## Identifying Car Licenses
In this project, we were able to identify the numbers and letters of license plates from images of cars, using image processing tools such as segmentation and two character recognition methods.

## Running the code
To test our code, simply download the project files and run PlateDetection.mlx in MatLab. If you wish, you can change the image name in PlateDetection.mlx with another image from the car_img folder, to process another license plate.

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
In this project, we were able to successfully identify the position of the license plate and each letter/number, regardless of size, position, orientation and number of characters. We were able to implement two character recognition methods in order to compare them. However, improvements could be made regarding character recognition as both methods are prone to some errors with some images.
Furthermore, our project works well with images of cars offering a high contrast with their license plate (i.e. dark cars), but additional work would be required to operate with light colored cars.
