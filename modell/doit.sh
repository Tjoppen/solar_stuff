#!/bin/bash
# doit.sh - Downloads STRÅNG data from SMHI and computes how many kWh one solar panel produces per year
# Copyright (C) 2018 Tomas Härdin
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published
# by the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

set -e

YEAR=2017
YEAR2=$(bc <<< "$YEAR + 1")
LAT=64.32834
LON=20.56327

get_smhi() {
  echo "Grabbing data from SMHI - this may take up to an hour per data set (currently fetching set $2/4)"
  curl -s "http://strang.smhi.se/extraction/getseries.php?par=$1&m1=1&d1=1&y1=${YEAR}&h1=0&m2=1&d2=1&y2=${YEAR2}&h2=23&lat=${LAT}&lon=${LON}&lev=0" | tee $3 &
  PIDS="$PIDS $!"
}

# Fatch data in parallel
PIDS=
if [ ! -f ${YEAR}-global.ssv ];            then get_smhi 117 1 ${YEAR}-global.ssv;            fi
if [ ! -f ${YEAR}-direct-normal.ssv ];     then get_smhi 118 2 ${YEAR}-direct-normal.ssv;     fi
if [ ! -f ${YEAR}-direct-horizontal.ssv ]; then get_smhi 121 3 ${YEAR}-direct-horizontal.ssv; fi
if [ ! -f ${YEAR}-diffuse.ssv ];           then get_smhi 122 4 ${YEAR}-diffuse.ssv;           fi

if [ ! -z "$PIDS" ]
then
  echo "Waiting for PIDs $PIDS"
  wait $PIDS
fi

# Does not work right currently, year hardcoded in doit.m because I got annoyed
octave --persist --no-gui doit.m -- $YEAR
