#!/bin/bash
# Define the service you want to monitor
SERVICE="apache2"
ADMIN="admin@example.com"
#Check if the service is running
if ! systemctl is-active --quiet $SERVICE; then
    # If not running, start the service
    systemctl start $SERVICE
    # Send an email notification to the admin
    echo "The $SERVICE service was down and has been restarted." | mail -s "$SERVICE Service Restarted" $ADMIN
fi

#Make it executable -> chmod +x monitor_restart_service.sh
# Check the service status every minute -> ***** /path/to/monitor_restart_service.sh