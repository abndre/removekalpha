function [mu, aic, yhat, yhat2] = kastrip(x, y, nseg, delta, lambda)

nl = length(lambda);
ml = length(y);
ss = 1:nl;

% prepare storage
aic = zeros(0, nl);
Yhat = zeros(ml,nl);
Yhat2 = zeros(ml,nl);
Mu = zeros(ml,nl);
SR = zeros(ml,nl);
phi = zeros(0, nl);
psi = zeros(0, nl);

% Prepare model matrices
xr = max(x);
xl = min(x)-1;
xd = x-delta;
B1 = bsplbase(x, [xl, xr, nseg, 3]);
B2 = bsplbase(xd, [xl, xr, nseg, 3]);
n = size(B1,2);
B = [B1;B2];
m = length(x);
Cb = speye(m);
tau = 0.5;
C = [Cb, tau * Cb];

% Prepare penalty
E = speye(n);
D = diff(E, 2);

% Initialize
bst = (B1' * B1 + 1e-4 .* E) \ (B1' * log((y + 1) / 2));

% estimate for all lambda
for i=1:nl;
    [aic_i, yhat_i, yhat2_i, sr_i, mu_i, phi_i, psi_i] = kastrip_int(y, B, C, D, bst, lambda(i));
    aic(i) = aic_i;
    Yhat(:,i) = yhat_i;
    Yhat2(:,i) = yhat2_i;
    SR(:,i) = sr_i;
    Mu(:,i) = mu_i;
    phi(i) = phi_i;
    psi(i) = psi_i;
end;

% find optimal model and report
[op_aic, ind] = min(aic);
yhat = Yhat(:,ind);
yhat2 = Yhat2(:,ind);
mu = Mu(:,ind);
oplamb = lambda(ind);
sr = SR(:,ind);




 