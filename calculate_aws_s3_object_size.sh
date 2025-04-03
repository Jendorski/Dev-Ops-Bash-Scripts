#Requirements
# 1. AWS-CLI on Linux
# 2. Configure AWS CLI for ready-to-use.

aws s3 ls #verify the aws-cli command works

aws s3 ls | awk '{ print $3 }' > buckets.txt
BUCKET_FILE="buckets.txt"
date=`date +%Y-%m-%d`
output_file="s3_bucket"

while read -r S3_BUCKET; do
    # List folders inside the S3 bucket
    folders=$(aws s3 ls "s3://$S3_BUCKET/" | grep PRE | awk '{print $2}' | sort -u)

    #Iterate through and print each folder name
    for folder in $folders; do

        # Replace slashes(/) with underscores (_) in bucket and folder names
        sanitized_bucket_name=$(echo "$S3_BUCKET" | tr / _)
        sanitized_folder_name=$(echo "$folder" | tr / _)

        #Create filenames with sanitized names
        bucket_filename="${sanitized_bucket_name}.txt"
        folder_filename="${sanitized_bucket_name}_${sanitized_folder_name}.txt"

        echo "s3://$S3_BUCKET/$folder"

        #Save the output to the appropriate named files 
        aws s3 ls "s3://$S3_BUCKET/$folder" --reursive --human-readable --summarize >> "$folder_filename"

    done 

done < "$BUCKET_FILE"

#Output the files
sleep 10
grep " Total Size:" * > {$output_file}_{$date}.log

#Delete the files
sleep 10
grep " Total Size:" * | awk -F":" '{print$1}' > deletion 

#To delete the log file
sed 's/^/rm -rf /' deletion > delete_file && sh delete_file

