#!/bin/bash
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

octave --persist --no-gui doit.m -- $YEAR
