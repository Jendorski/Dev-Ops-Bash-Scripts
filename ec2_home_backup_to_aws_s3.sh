S3_BUCKET=""


BACKUP_DIRECTORY="/backup"
LOG_PATH="/var/log/ec2-backup"
LOG_FILE="{$LOG_PATH}_$(date + "%Y%m%d").log"
# Create the backup diriectory if it does not exist

mkdir -p "$BACKUP_DIRECTORY"

#Use cp to copy files 
cp -r /etc "$BACKUP_DIRECTORY"
cp -r /home "$BACKUP_DIRECTORY"

BACKUP_TAR_FILE="$BACKUP_DIRECTORY/_$(hostname -i | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b").tar.gz"
tar -czvf "$BACKUP_TAR_FILE" -C "$BACKUP_DIRECTORY" .

S3_DESTINATION="s3://$S3_BUCKET/ec2-config-backup/$(date +"%Y/%m/%d")/"

#more about 2>&1: https://stackoverflow.com/q/818255/6301817
S3_COMMAND_OUTPUT=$(aws s3 cp "$BACKUP_TAR_FILE" "$S3_DESTINATION" 2>&1)
COPY_EXIT_STATUS=$?

if [ $COPY_EXIT_STATUS -eq 0 ]; then
    STATUS="Success"
else 
    STATUS="Failure"
fi

echo "Status: $STATUS" >> "$LOG_FILE"
echo "$S3_COMMAND_OUTPUT" >> "$LOG_FILE"

rm -rf "$BACKUP_DIRECTORY"

echo " Hey, Backup completed and uploaded S3"