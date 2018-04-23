% doit.m - Crunches STRÅNG data into kWh per solar panel year
% Copyright (C) 2018 Tomas Härdin
%
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU Affero General Public License as published
% by the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU Affero General Public License for more details.
%
% You should have received a copy of the GNU Affero General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>.

%
%year = argv(){end}
year = "2017"
%y2 = year - 2000

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

%n0 = y2 * 365 + ceil(y2 / 4)


_global = dlmread(sprintf('%s-global.ssv', year), ' ');
directn = dlmread(sprintf('%s-direct-normal.ssv', year), ' ');
directh = dlmread(sprintf('%s-direct-horizontal.ssv', year), ' ');
diffuse = dlmread(sprintf('%s-diffuse.ssv', year), ' ');

days = size(_global,1)/24
% hour angle
h = mod(0:(size(_global,1)-1),24);
axial_tilt = 23.5

years = 1:30;
eff_max = 97.5;
eff_y12 = 91.2;
eff_y30 = 80.6;
eff_slope = (91.2-80.6)/(30-12); % efficiency drop per year
panel_eff = 0.169 * min(eff_max, eff_y30 + eff_slope*(max(years)-years)) / 100;

% http://solarpaneltilt.com/
tilt_eff = 0.75;
A_panel = 1.6;       % panel area in m²
kWh_per_panel_per_year = panel_eff * tilt_eff * A_panel * 365/days * (sum(directn(:,5) + max(0,diffuse(:,5)))) / 1000
production_per_panel_30_years = sum(kWh_per_panel_per_year)

ten_panels_power_year1 = kWh_per_panel_per_year(1)*10
fourty_panels_power_year1 = kWh_per_panel_per_year(1)*40

