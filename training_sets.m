function [training_set] = training_sets(completedTsets)
% completedTsets: 

% Get list of all jpg files in this directory
% DIR returns as a structure array.  You will need to use () and . to get
% the file names.

% returns the training_set as [{images_of_A}, {images_of_B},.. so on]
% right now we only have images of A to B
alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
alphabet2 = 'abcdefghijklmnopqrstuvwxyz';
image_paths = [];
 p1 = './letters_set/';
 p2 = '/*.jpg';
% capital A's to Z's
for j = 'A':alphabet(completedTsets),
    image_paths = [ image_paths; strcat(p1,j,p2)];
end    

training_set = [];

for k = 1:completedTsets,
    images = {};
    imagefiles = dir(image_paths(k,:));
    nfiles = length(imagefiles);    % Number of files found
    for i=1:nfiles,
       currentfilename = imagefiles(i).name;
       dir_path = strcat(p1, alphabet(k), '/');
       path = strcat(dir_path, currentfilename);
       currentimage = imread(path);
       images{i} = currentimage;
    end
    training_set = [training_set {images}];
end

end