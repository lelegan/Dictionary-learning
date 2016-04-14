function [img] = convert_vector_to_image(vec, row_num)
img = [];
col = size(vec)/row_num;

k = 1;
for i = 1:col,
    for j = 1:row_num,
       img(j,i) = vec(k);
       k = k + 1;
    end    
end
end