% set columns (k) for our dictionary
k = 50;

% current complete training sets number
% we have A to Z both capital letters
num_test_sets = 26; 
training_sets = training_sets(num_test_sets);

% We presume all the images have the same size
[n p] = size(training_sets{1}{1}); % size of our images

% Initialize dictionaries 
for i = 1:num_test_sets,
    Dictionaries{i} = rand(n*p, k);
    Dictionaries{i} = Dictionaries{i} ./ 100; % do this, so it satisfies the constraint of convex matrix; see def.(3) in paper
end

% Regularization term for lars
lambda = 50;
% Train dictionaries
for i = 1:num_test_sets, 
    t = training_sets{i};
	D = Dictionaries{i};
    Dictionaries{i} = dictionary_learning(t, D, lambda);
end

% !!!! set the image here ( we have testB.jpg testC.jpg testZ.jpg)
img = imread('./letters/testC.jpg');
% error estimation using minimum square error
[answer sparse_approx dic_num] = err(img, Dictionaries, lambda, num_test_sets); 

disp(answer)
imshow(img) % show the test image


show_dic = [];
for i = 1:k, % rearrange each atom of the dictionary into images; concate them together
   dic_elem = convert_vector_to_image( Dictionaries{dic_num}(:,i), 20 );
   show_dic = [show_dic dic_elem]
end
imshow(show_dic) % show answer's dictionary (each column is converted in to images)


imshow(sparse_approx) % show the reconstruction