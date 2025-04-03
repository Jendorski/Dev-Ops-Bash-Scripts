#! /bin/bash
TIME=$(date "+%Y-%m-%d %H:%M:%S")
echo -e "Time\tMemory\t\tDisk /root\tCPU"
seconds="3600"
end=$((SECONDS+seconds))
while [ $SECONDS -lt $end ]; do
MEMORY=$(free -m | awk 'NR==2{printf "%.f%%\t\t", $3*100/$2 }')
DISK=$(df -h | awk '$NF=="/"{printf "%s\t\t", $5}')
CPU=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{printf("%.f\n", 100 - $1)}')
echo -e "$TIME\t$MEMORY$DISK$CPU"
sleep 3
done

#Improvements: echo -e "$TIME\t$MEMORY$DISK$CPU" >> /path/to/logfile.txt (Logs the output to a log file for later analysis)

#Improvements: Send alert when the CPU or DISK or MEMORY is too high or at a certain threshold



#Article: https://medium.com/devsecops-community/day-5-automating-tasks-with-bash-scripts-part-1-e84d0a49daf9