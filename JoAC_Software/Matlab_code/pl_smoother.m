function [mu, aic, ed, dev] = pl_smoother(y, lambda, d)
m = length(y);
z = log(y + 1);
E = speye(m);
D = diff(E, d);
P = lambda * D' * D;
mu = exp(z);
for it =1:10
    W = spdiags(mu, 0, m, m);
    z = (W + P) \(y - mu + mu .* z);
    munew = exp(z);
    dmu = max(abs(munew - mu));
    mu = munew;
    %disp(dmu)
    if dmu < 0.0001
        break
    end
end
    
if nargout > 1 
    H = (W + P) \ W;
    h = full(diag(H));
    ed = sum(h);
    dev = 2 * sum(y .* log((y + 1e-10) ./ mu));
    aic = dev + 2* ed*length(y)/(length(m)-ed);
end
