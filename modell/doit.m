%
year = argv(){end}
y2 = year - 2000

% leap years: 2000, 2004, 2008, ...
% for the given year we must add the extra days in the leap years before it:
%
% 2000: 0
% 2001: 1
% 2002: 1
% 2003: 1
% 2004: 1
% 2005: 2
% 2006: 2
% 2007: 2
% 2008: 2

n0 = y2 * 365 + ceil(y2 / 4)


_global = dlmread(sprintf('%s-global.ssv', year), ' ');
directn = dlmread(sprintf('%s-direct-normal.ssv', year), ' ');
directh = dlmread(sprintf('%s-direct-horizontal.ssv', year), ' ');
diffuse = dlmread(sprintf('%s-diffuse.ssv', year), ' ');

days = size(_global,1)/24
% hour angle
h = mod(0:(size(_global,1)-1),24);
axial_tilt = 23.5

