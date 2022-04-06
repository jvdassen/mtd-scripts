TARGET=MONITORING_LOG_$(date +%d_%m_%Y-%H:%M).csv
INTERFACE=eth0

echo timestamp,$(vmstat  | tail -2 | cut -c2- | sed -n '1p' | sed -e 's/\s\+/,/g'),ES_SENSOR_KB_SENT,ES_SENSOR_KB_RECV > $TARGET
while true
do
  NW_USAGE=$(nethogs -d 10 -s -t -c 2 $INTERFACE 2>/dev/null | grep es_sensor | awk '{print $2,$3}' | sed -e 's/\s\+/,/g')
  echo "Gathering data on ${INTERFACE} for 10 seconds"
  echo $(date +%s),$(vmstat | tail -1 | cut -c2- | sed -e 's/\s\+/,/g'),$NW_USAGE  >> $TARGET
 done
