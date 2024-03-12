my_folder ='car_images'; 
Filenames=dir(fullfile(my_folder,'*.png')); 
Filenames;
Image = {};

for n = 1:numel(Filenames)
fullname=fullfile(my_folder,filenames(n).name);
Image{end+1} = imread(fullname);
end
%% 
Filenames(1).name