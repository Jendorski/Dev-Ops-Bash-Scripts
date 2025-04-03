#!/bin/bash
#Admin email address
ADMIN="admin@example.com"

#Get the percentage of used space on /
ROOT_USAGE=$(df/ | grep | awk '{print $5}' | sed 's/%//g')
#Check if the / partition usage is 90% or more
if [ "$ROOT_USAGE" -ge 90 ]; then
    echo "Warning / partition usage is at ${ROOT_USAGE}%!" | mail -s "/ Partition Warning" $ADMIN
fi

#Check the size of the /home directory (in GB)
HOME_SIZE=$(du -sh /home | awk '{print $1}' | sed 's/G//g')
#Check if /home size exceeds 2GB
if (( $(echo "$HOME_SIZE > 2" | bc -l) )); then 
    echo "Warning: /home size is ${HOME_SIZE}GB, exceeding 2GB!" | mail -s "/home Directory Warning" $ADMIN
fi

#To make executable chmod +x disk_monitor.sh
# To schedule this script to run periodically usng cron, crontab -e
# 0 **** /path/to/disk_monitor.sh
#Article: https://medium.com/devsecops-community/day-5-automating-tasks-with-bash-scripts-part-1-e84d0a49daf9