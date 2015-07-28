#!/bin/bash
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Script Name:	testConnect.sh
# Script Desc:	Test SSH Connections
# Script Date:	7-28-15
# Created By:	Christopher Stanley
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
startTime=$(date +%s)
date=$(date +"%m-%d-%Y")
timeNow=$(date +"%T")

user="cstanley@"
hosts=`cat server.list`

for i in $hosts
do
        echo "---------- Connecting to $i ----------"
        tmp=$(ssh -tt -q -o StrictHostKeyChecking=no -o ConnectTimeout=1 "$user""$i" "uname")

        if [[ $tmp == *"Linux"* || $tmp == *"AIX"* ]]; then
                echo "[$(date +%D_%T)] Successfully Connected to $i"
        else
                echo "[$(date +%D_%T)] Could not connect to $i - Connection failed"
        fi
done

endTime=$(date +%s)
seconds=$(echo "$endTime - $startTime" | bc)
minutes=$(echo "($endTime - $startTime) / 60" | bc)

if [ "$minutes" -le "0" ]; then
echo "Time Taken: $seconds seconds"
else
echo "Time Taken: $minutes minute(s)"
fi

echo "[$(date +%D_%T)] Job Finished."
