function B = bsplbase(x, bpars)
% Fast computation of a B-spline basis,
% of degree "deg", at positions "x",
% on a uniform grid with "ndx" intervals between "x0" and "x1".
% Saver computations
x0 = bpars(1); x1 = bpars(2); ndx = bpars(3); deg = bpars(4);
x = x(:);
if (min(x) < x0) | (max(x) > x1)
    disp('Some elements of x out of bounds !!')
    return
end
dx = (x1 - x0) / ndx;
t = x0 + dx * ((-deg):(ndx-1));
T = ones(size(x)) * t;
X = x * ones(size(t));
D = (X - T) / dx;
B = diff([zeros(size(x)), D <= 1]')';
r = [2:length(t) 1];
for k = 1:deg
    B = (D .* B + (k + 1 - D) .* B(:, r)) / k;
end;



