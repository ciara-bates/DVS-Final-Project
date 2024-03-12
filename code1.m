i = imread("car_images\Cars0.png");
i2 = imresize(i,0.5);
montage({i,i2})
