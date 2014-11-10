function Y = odgen(b, X)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

    Y = b(1).*(X.^(b(2)-1) - (1./X.^2).^(b(2)-1));


end

