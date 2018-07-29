
function [aic_i, yhat_i, yhat2_i, sr_i, mu_i, phi_i, psi_i] = kastrip_int(y, B, C, D, bst, lambda)

% penalty
P = lambda .* D' * D;
beta = bst;

% Fit iteratively
for i=1:10;
    eta = B * beta;
    gam = exp(eta);
    mu = C * gam;
    M = diag(1./ mu);
    M = sparse(M);
    X = (M * C * diag(gam)) * B;
    W = diag(mu);
    W = sparse(W);
    G = X' * W * X;
    bnew = (G + P) \ (X' * (y - mu) + G * beta);
    db = max(abs(bnew - beta));
    beta = bnew;
    disp(db);
end;

%-- AIC
dev = 2 .* sum(y .* log((y + (y == 0)) ./ mu));
H = (G + P) \ G;
ed = sum(diag(H));
aic_i = dev + 2 .* ed;
sr_i = (y - mu) ./ sqrt(mu);
m = length(y);
sdr = sqrt(sum(sr_i.^2) ./ (m - ed));
mu_i = mu;

%-- L-curve
phi_i = log(sum((D*beta).^2));
psi_i = log(sum(sr_i.^2));

%-- estimated signals
yhat_i = gam([1:m]);
yhat2_i = gam([(m+1):length(gam)]);
yhat2_i = yhat2_i .* 0.5;

