% Least Angle Regression

% Inputs:
% X: design matrix
% Y: response
% t: regularization term
%
% Note: We assume the X has been normalized and Y has zero mean

% Returns:
% 
% beta:
% Row 1 is the beginning, therefore has no beta being updated
% Row 2 gives the beta being updated after the first step
% Row 3 gives the betas being updated after the second step
% And so on.
%
% mu: The prediction vector


function [beta A mu_hat gamma]= lars(X, Y, t)
%feature normalization
X = Normalize(X);
Y = zero_mean_y(Y);

% size of the design matrix
[n m] = size(X);

% mu_hat: the nx1 predictor vector; starts with zero
mu_hat = zeros(n, 1); % n x 1 vector


% beta; the regression coefficients e.g.[0, 0, ... , 0]
beta = zeros(1, m);

% active set
A = [];

% complement of the actice set
A_c = 1:m;

% record how many related covariate column has been added to the active set
N_Co_added = 0;

% the prediction vector; previous step
mu_old = zeros(n, 1);

% i is the number of attempts of minimization step
i = 0; 

for k = 1:m,
    i = i + 1;
    i
    % current correlations
    c = X' * (Y - mu_hat);
    
    % greatest absolute current correlations
    C = max(abs(c));

    % update the active set with the greatest abs. current correlation
    % find returns the index of max correlation element in the correlation vector
    if i == 1, addIndex = find(C == abs(c)); end
    
    A = [A, addIndex];
    
    % update the number of corresponding covariate index being added 
    N_Co_added = N_Co_added + 1;
    
    % update the complement of the active set
    % setdiff returns data in A that's not in B
    % A: 1st parameter argument, B: 2nd parameter argument
    A_c = setdiff(1:m, A);
    
    % sign
    s = sign(c(A));
    % make a sign matrix (s_A) for the calculation of X_A
    % remerber that n is the total rows of the design matrix, which we setup at
    % the beginning
    s_A=diag(s);
     
    % the number of zeros' coefficients out of all the regression
    % coefficients so far
    num_Zero_Coeff = length(A_c);
    
    % compute X_A, A_A and u_A and the inner product vector
    X_A = X(:, A)*s_A; % X_A: the vector of covariate that have higher correlation than other covariates; multiply s_A to make all the terms positive
    G_A = X_A' * X_A; % G_A: the dot product of X_A to itself (Gram vector)
    One_A = ones(size(A,2), 1); % One_A: a vector of ones equaling |A|, the size of the active set
    s = One_A; % One_A: a vector of ones equaling |A|, the size of the active set
    invGA = pinv(G_A);
    A_A = 1 / sqrt(s' * invGA * s);
    w_A = A_A * invGA * s; % w_A: unit vector making equal angles (less then 90%)
    u_A = X_A * w_A; % u_A: equiangular vector
    
    a = X' * u_A; % inner product vector

    % First, set up gammaTest as a matrix of zeros corresponds to the
    % covariates that are not being recorded in the active set
    gamma_Test = zeros(num_Zero_Coeff, 2);
    
    % When the corresponding covariates has all been added, then the gamma
    % is not defined. So the last step gamma (provided that the L_1 beta norm it's not converge to the boundary) 
    % is going to be equal to ..
    if N_Co_added == m-1,
        gamma(i) = C/A_A; % see the derivation in the paper (2.19)
    else
        for j = 1:num_Zero_Coeff, % run from 1 to the total number of zeros' coefficients
            j_p = A_c(j); % a particular index corresponds to the covariates
            first_term = (C - c(j_p))/(A_A - a(j_p));
            second_term = (C + c(j_p))/(A_A + a(j_p));
            gamma_Test(j, :) = [ first_term, second_term ];
        end
        % update gamma's history and the row and column of the strictly
        [gamma(i) min_i min_j] = min_pos(gamma_Test);
        addIndex = A_c(min(min_i));
    end
    
    % mu_hat
    % update the prediction vector
    mu_hat = mu_old + gamma(i)*u_A;
    mu_old = mu_hat;
    
   
    % beta_tmp: 
    % 1)record the betas that is going to be generated in the current step
    % 2)use to test out the L_1 norm at the current step
    beta_tmp = zeros(m, 1);
    
    % Update beta. Since each estimate of the prdictor vector 
    % is mu_hat+ = mu_hat + gamma(i)*u_A, follow the papaer, algebraically, each corresponding ith beta is gamma(i)*w_A
    beta_tmp(A) =  beta(i, A)' + s_A *(gamma(i)*w_A);
    beta = [beta; beta_tmp'];  
    
    % if t, the regularization term, is finite, then..
    if t ~= inf,
        t_now = norm(beta(size(beta, 1), 1), 1); % the l_1 norm of the current beta coefficients in the active set
        t_now
        if t_now > t,
            break % break out of Lars loop; return the outputs
        end
    end
    
    k
end % end for loop


end % end lars funtion


function [m, I, J] = min_pos(X)

% Remove complex elements and reset to Inf
%[I,J] = find(0 ~= imag(X));
%for i = 1:length(I),
%    X(I(i),J(i)) = Inf;
%end

X(X<=0) = max(max(X));
m = min(min(X));
[I,J] = find(X==m);
if m<0
    m=0;
end
end

