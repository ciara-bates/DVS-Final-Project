*** Personal contribution ***

I tried out a few different methods of segmenting the images, using examples online to help in this process.
I created the parts of the code on the MSER regions using this tutorial, editing to get the individual letters: https://uk.mathworks.com/help/vision/ug/automatically-detect-and-recognize-text-in-natural-images.html
The parameters needed a lot of tuning to be consistent with a range of licence plates. 

I wrote the homography transform code, aided by the lecture from Freddie Page. 
We worked together to try a few different character recognition methods. The similarity method that I found from this tutorial: https://angoratutor.com/license-plate-recognition-with-matlab was the most successful as a non-AI method. 

*** Discusssion ***

We implemented many different processing methods, all of which work best on greyscale/binarized images. It could be interesting to try segmenting the license plates using information from the colour channels as well.
What I particularly like about the way we implemented the code is that its not constrained by the number of letters in the licence plate, as the MSER regions parameters doesn't define the number of regions, just the number of pixels in the regions. 