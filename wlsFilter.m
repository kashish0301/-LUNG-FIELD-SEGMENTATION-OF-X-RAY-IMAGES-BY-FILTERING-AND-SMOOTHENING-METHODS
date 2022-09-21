function OUT = wlsFilter(IN, lambda, alpha, L)
%
%   Input arguments:
%   ----------------
%     IN              Input image (2-D, double, N-by-M matrix). 
%       
%     lambda          Balances between the data term and the smoothness
%                     term. Increasing lambda will produce smoother images.
%                     Default value is 1.0
%       
%     alpha           Gives a degree of control over the affinities by non-
%                     lineary scaling the gradients. Increasing alpha will
%                     result in sharper preserved edges. Default value: 1.2
%       
%     L               Source image for the affinity matrix. Same dimensions
%                     as the input image IN. Default: log(IN)

if(~exist('L', 'var')),
    L = log(IN+eps);
end

if(~exist('alpha', 'var')),
    alpha = 1;
end

if(~exist('lambda', 'var')),
    lambda = 1;
end

smallNum = 0.001;

[r,c] = size(IN);
k = r*c;

% Compute affinities between adjacent pixels based on gradients of L
dy = diff(L, 1, 1);
dy = -lambda./(abs(dy).^alpha + smallNum);
dy = padarray(dy, [1 0], 'post');
dy = dy(:);

dx = diff(L, 1, 2); 
dx = -lambda./(abs(dx).^alpha + smallNum);
dx = padarray(dx, [0 1], 'post');
dx = dx(:);


% Construct a five-point spatially inhomogeneous Laplacian matrix
B(:,1) = dx;
B(:,2) = dy;
d = [-r,-1];
A = spdiags(B,d,k,k);

e = dx;
w = padarray(dx, r, 'pre'); w = w(1:end-r);
s = dy;
n = padarray(dy, 1, 'pre'); n = n(1:end-1);

D = 1-(e+w+s+n);
A = A + A' + spdiags(D, 0, k, k);

% Solve
OUT = A\IN(:);
OUT = reshape(OUT, r, c);