function [J, grad] = cofiCostFunc(params, Y, R, num_users, num_movies, ...
                                  num_features, lambda)
%COFICOSTFUNC Collaborative filtering cost function
%   [J, grad] = COFICOSTFUNC(params, Y, R, num_users, num_movies, ...
%   num_features, lambda) returns the cost and gradient for the
%   collaborative filtering problem.
%

% Unfold the U and W matrices from params
X = reshape(params(1:num_movies*num_features), num_movies, num_features);
Theta = reshape(params(num_movies*num_features+1:end), ...
                num_users, num_features);

            
% You need to return the following values correctly
J = 0;
X_grad = zeros(size(X));
Theta_grad = zeros(size(Theta));

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost function and gradient for collaborative
%               filtering. Concretely, you should first implement the cost
%               function (without regularization) and make sure it is
%               matches our costs. After that, you should implement the 
%               gradient and use the checkCostFunction routine to check
%               that the gradient is correct. Finally, you should implement
%               regularization.
%
% Notes: X - num_movies  x num_features matrix of movie features
%        Theta - num_users  x num_features matrix of user features
%        Y - num_movies x num_users matrix of user ratings of movies
%        R - num_movies x num_users matrix, where R(i, j) = 1 if the 
%            i-th movie was rated by the j-th user
%
% You should set the following variables correctly:
%
%        X_grad - num_movies x num_features matrix, containing the 
%                 partial derivatives w.r.t. to each element of X
%        Theta_grad - num_users x num_features matrix, containing the 
%                     partial derivatives w.r.t. to each element of Theta
%
  
  %calculate the predictions
  prediction = X*(Theta)';
  
  %calcualte the error
  error = (prediction - Y);
  
  %Eliminates values of movies that were not rated
  error_factor = error.*R;
  
  %Square the values of errors
  error_factor_squared = error_factor.^2;
  
  %sum up each row
  sumRow = sum(error_factor_squared);
  
  %calculate the regularization factor for Theta
  Theta_squared = Theta.^2;
  Theta_row = sum(Theta_squared);
  factorTheta = (0.5*lambda)*sum(Theta_row);
  
  %calculate the regularization factor for Theta
  X_squared = X.^2;
  X_row = sum( X_squared); 
  factorX = (0.5*lambda)*sum(X_row);
  
  %Calculate the cost
  J = (0.5*sum(sumRow)) + factorTheta + factorX;
  
  %calculate the regularization factors for gradient
  X_lambda = X*lambda;
  Theta_lambda = Theta*lambda;
  
  X_grad = ((error_factor)*Theta) + X_lambda;

  Theta_grad = ((error_factor)'*X)+ Theta_lambda;






% =============================================================

grad = [X_grad(:); Theta_grad(:)];

end
