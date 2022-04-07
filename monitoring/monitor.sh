#!/bin/bash
TARGET=MONITORING_LOG_$(date +%d_%m_%Y-%H:%M)-$1.csv
INTERFACE=eth0
SERVICE=es_sensor

I=0

echo timestamp,$(vmstat  | tail -2 | cut -c2- | sed -n '1p' | sed -e 's/\s\+/,/g'),ES_SENSOR_KB_SENT,ES_SENSOR_KB_RECV > $TARGET
echo timestamp,$(vmstat  | tail -2 | cut -c2- | sed -n '1p' | sed -e 's/\s\+/,/g'),ES_SENSOR_KB_SENT,ES_SENSOR_KB_RECV
while true
do
  NW_USAGE=$(nethogs -d 10 -s -t -c 2 $INTERFACE 2>/dev/null | grep $SERVICE | awk '{print $2,$3}' | sed -e 's/\s\+/,/g')
#  echo "Gathering data on ${INTERFACE} for 10 seconds"
  echo $(date +%s),$(vmstat 2 2| tail -1 | cut -c2- | sed -e 's/\s\+/,/g'),$NW_USAGE  >> $TARGET
  echo $(date +%s),$(vmstat 2 2| tail -1 | cut -c2- | sed -e 's/\s\+/,/g'),$NW_USAGE
  I=$((I+1))
  if [[ $I -eq $2 ]]; then
    exit
  fi
 done
