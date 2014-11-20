function Y = odgen(b, X)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

    %P33 derivation from odgen. Lambda3 is normal to bicept, 
    % lambda1 is along the muscle fiber direction and lambda 2 is 
    % orthogonal.
    % This derivations assumes lambda3 = lambda, lambda2 =
    % 1/lambda, and lambda1 = 1
    mu = b(1);
    alpha = b(2);
    Y = mu*(X.^(alpha-1) - (1./X).^(alpha+2));
    
    
    % this is an old odgen model from one of our homeworks
    % Y = b(1).*(X.^(b(2)-1) - (1./X.^2).^(b(2)-1));
    
    


end

