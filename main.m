% set columns (k) for our dictionary
k = 50;


% current complete training sets number
% we have A to Z both capital letters
cctsn = 26; 
training_sets = training_sets(cctsn);

% We presume all the images have the same size
[n p] = size(training_sets{1}{1}); % size of our images

% Initialize dictionaries 
% Started as zeros matrix 
% Since we are examine 26 letters, we set it from 1:26
for i = 1:26,
    Dictionaries{i} = rand(n*p, k);
    Dictionaries{i} = Dictionaries{i} ./ 100; % do this, so it satisfies the constraint of convex matrix; see def.(3) in paper
end

% Regularization term for lars
lambda = 40;

% Train dictionaries
for i = 1:cctsn, 
    image_set = training_sets{i};
    Dictionaries{i} = dictionary_learning(image_set, Dictionaries{i}, lambda);
end

% !!!! set the image here (A to B for now)
img = imread('./letters/testB.jpg');
[answer sparse_approx] = readANDtell(img, Dictionaries, lambda, cctsn);
disp(answer)

imshow(Dictionaries{3})
imshow(img)
imshow(sparse_approx)