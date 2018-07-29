
function [delta] = doublet(x, anode)

% characteristic wavelength of anode material  
switch anode
    case 'cobalt' 
        wl1 = 1.78897;
        wl2 = 1.79285;
    case {'copper'}
        wl1 = 1.54060;
        wl2 = 1.54443;
    otherwise
        warning('Unexpected anode type');
end

wr = wl2 / wl1;
d2r = pi / 180;
u = sin(d2r .* x / 2) / wl1;
delta = 2 .* asin(wr * sin(d2r .* x / 2)) / d2r - x;


