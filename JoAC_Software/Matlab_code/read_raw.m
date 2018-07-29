
function [x, y] = read_raw(fname)
% Read header
froot = fname;
fname = [froot '.raw'];
f = fopen(fname);
raw = char(fread(f, 8, 'uchar'))';
fstat = fread(f, 1, 'uint');
rng = fread(f, 1, 'uint');
date = char(fread(f, 10, 'uchar'))';
time = char(fread(f, 10, 'uchar'))';
usr = char(fread(f, 72, 'uchar'))';
site = char(fread(f, 218, 'uchar'))';
sample = char(fread(f, 60, 'uchar'))';
comm = char(fread(f, 160, 'uchar'))';
fclose(f);

% Read XRD profile properties
f = fopen(fname);
block1 = fread(f, 712, 'uint8');
headr = fread(f, 1, 'uint');
nrec = fread(f, 1, 'uint');
gonio = fread(f, 2, 'double');
start = gonio(2);
nix = fread(f, 176 - 24, 'uint8');
step = fread(f, 1, 'double');
fclose(f);

%-- Read file headers
f = fopen(fname);
block1 = fread(f, 386, 'uint8');
% read comments slot
comm = char(fread(f, 160, 'uchar'))';
block2 = fread(f, 422, 'uint8');
% check length of supp. header
size_sup = fread(f, 1, 'uint');
block3 = fread(f, 44);
block4 = fread(f, size_sup);
fclose(f)

% Read profile
f = fopen(fname);
blocks = fread(f, 712 + 304 + size_sup, 'uint8');
y = fread(f, nrec, 'single');
%x = 1:nrec;
x = (start + (1:nrec) * step) - step;
fclose(f);

% Show header
disp(usr)
disp(site)
disp(sample)
disp(comm)

