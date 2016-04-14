function [vec] = convert_image_to_vector(img)
% img: 1 2 3   to: 1
%      4 5 6       4
%      7 8 9       7
%                  2
%                  5
%                  8
%                  3
%                  6
%                  9

vec = [];
for i = 1:size(img,2),
    for j = 1:size(img,1),
        vec = [vec ; img(j,i)];
    end
end

vec = double(vec);
end