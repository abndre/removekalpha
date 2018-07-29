
% File names (original data and after smoothing )
oldnam = 'Ni-Alumina_22feb13V3'
newnam = 'Smoothed_data'

% Read profile
[x, y] = read_raw(oldnam);

% Smooth data
lambda = 100000;
[z, AIC, ED, DEV] = pl_smoother(y, lambda, 3);

% Plot profile and smooth
x = 1:length(y);
subplot(2, 1, 1)
plot(x, y)
xlim([-10 length(y)+10])
title('Raw data')
subplot(2, 1, 2)
plot(x, z)
xlim([-10 length(y)+10])
title('Smoothed data')
shg

% Write to RAW file including comments
cmt = 'Whitk smoothed d=3 lambda=100000';
write_raw(oldnam, newnam, z, cmt);

% Read smoothed profile to check writing procedure 
% ys = read_raw(newnam);
