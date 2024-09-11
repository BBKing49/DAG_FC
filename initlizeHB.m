function [H, B] = initlizeHB(X, m)

rand('seed',10);
d = size(X,1);
B = rand(d,m);
    
for i = 1:100
    H = pinv( B'*B)*(B'*X);
    B = (X*H')*pinv(H*H');
end