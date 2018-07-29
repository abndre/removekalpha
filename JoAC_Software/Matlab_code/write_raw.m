
function [] = write_raw(oname, nname, y, comment)

%-- Read original file
fname = [oname '.raw'];

%-- Read adresses in file headers
f = fopen(fname);
block1 = fread(f, 386, 'uint8');
% read add comments slot
comm = char(fread(f, 160, 'uchar'))';
block2 = fread(f, 422, 'uint8');
% check length of supp. header
size_sup = fread(f, 1, 'uint');
block3 = fread(f, 44);
block4 = fread(f, size_sup);
fclose(f)

%-- add comments
comm(1:length(comment)) = comment

%-- Write to file
nname = [nname '.raw']
f2 = fopen(nname, 'w');
fwrite(f2, block1, 'uint8');
fwrite(f2, comm, 'uchar');
fwrite(f2, block2, 'uint8');
fwrite(f2, block3, 'uint8');
fwrite(f2, block4, 'uint8');
% write smoothed y
fwrite(f2, y, 'single');
fclose(f2)
