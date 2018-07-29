
% File name
nam = 'Ni-Alumina_22feb13V3'

% Read profile
[x, y] = read_raw(nam);

% Declare tuning parameter lambda
nn = 10;
lambda = logspace(-2,8,nn);

% Calculate doublet distance
delta = doublet(x, 'cobalt');

% Estimation
[mu, aic, yhat, yhat2] = kastrip(x, y, 1000, delta, lambda);

% Plot estimated profile and Ka1 and Ka2 components
subplot(2, 1, 1)
plot(x, y)
title('Raw data')
subplot(2, 1, 2)
plot(x, mu)
hold on
plot(x, yhat, 'red')
plot(x, yhat2, 'green')
hold off
title('Estimated curve (blue), Ka1 (red) and Ka2 (green) component')
shg

