#!/bin/bash
# Generate fake application logs for practice

LOG_FILE="access.log"
> $LOG_FILE  # empty the file first

ENDPOINTS=("/login" "/dashboard" "/api/users" "/api/data" "/logout")
IPS=("192.168.1.1" "192.168.1.2" "10.0.0.1" "172.16.0.1" "192.168.1.100")
CODES=("200" "200" "200" "404" "500" "401" "403" "302")

for i in $(seq 1 100); do
    IP=${IPS[$RANDOM % ${#IPS[@]}]}
    ENDPOINT=${ENDPOINTS[$RANDOM % ${#ENDPOINTS[@]}]}
    CODE=${CODES[$RANDOM % ${#CODES[@]}]}
    echo "$IP - [$(date '+%d/%b/%Y:%H:%M:%S')] \"GET $ENDPOINT HTTP/1.1\" $CODE" >> $LOG_FILE
done

echo "Generated 100 log entries in $LOG_FILE"
