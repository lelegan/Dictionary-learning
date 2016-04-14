% set columns (k) for our dictionary
k = 45;

training_sets = training_sets();

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
lambda = 70;
image_set = training_sets{1};
D = Dictionaries{1};
d = dictionary_learning(image_set, D, lambda);

test_img = training_sets{1}{7};
imshow(test_img)
test_img = convert_image_to_vector(test_img);
a = lars(d,test_img, lambda);
a = a(size(a,1),:)';

omg = d*a;
omg = convert_vector_to_image(omg, 20);
imshow(omg)


haha1 = training_sets{1}{1}
haha4 = training_sets{1}{3}
haha2 = training_sets{2}{1}
haha3 = training_sets{2}{4}
haha5 = training_sets{2}{5}
imshow(haha1)
c1 = normxcorr2(omg, haha1)
c2 = normxcorr2(omg, haha2)
c3 = normxcorr2(omg, haha3)
c4 = normxcorr2(omg, haha4)
c5 = normxcorr2(omg, haha5)
imshow(haha4)
abc = c1 == 1.0000
max(c1(:))
max(c2(:))
max(c3(:))
max(c4(:))
max(c5(:))
