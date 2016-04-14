function [dictionary] = dictionary_learning(image_set, D, lambda)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% We presume the size of the images are the same (e.g. 20 x 20)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Input parameters:
% image_set: A cell of (grey) images provide for this algorithm
% D: Initial dictionary
% lamda: The regularization term for LARS computation

% Output:
% dictionary: dictionary for this image_set

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Code is following the algorithm provided by the paper - Online Dictionary 
% for Sparse Coding by Julien Mairal, Francis Bach, Jean Ponce, and Guiilermo Sapiro

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[n p] = size(image_set{1}); % image size

A_now = [];
B_now = [];
A_old = [];
B_old = [];

% convex set of matrices verifying the constraint:
% { D in R^(m x k) s.t. for all j = 1,...,k, d^T_j * _j <= 1 }
C = {};

for s = 1:1, % letter A for now; otherwise 1:26
    T = length(image_set(s,:)); % number of images to train 
    for t = 1:T,
        Y = convert_image_to_vector(image_set{t});
        X = D;
        Y = zero_mean_y(Y);
        X = Normalize(X);
        size(Y)
        size(X)
        [beta_hist] = lars(X, Y, lambda); % sparse coding; return the hist. of coefficients it generates
        a = beta_hist(size(beta_hist, 1),:)';
        
        % update A and B
        if t == 1,
            A_now = 0.5 * a * a'; 
            A_old = A_now;
            B_now = Y * a'; 
            B_old = B_now;
        else
            A_now = A_old + 0.5 * a * a'; 
            A_old = A_now;
            B_now = B_old + Y * a';
            B_old = B_now;
        end % end if
        
        % update dictionary
        D = dict_update(D, A_now, B_now);
    end % end nested for loop
end

dictionary = D;
end