#!/bin/zsh

# Get current date and time
current_date=$(date "+%Y-%m-%d %H:%M:%S")
log_date=$(date "+%Y-%m-%d_%H-%M-%S")

# Log file
log_file="$HOME/Scripting/Logs/laptop_health_check_$log_date.log"

# Check CPU usage
echo "[$current_date] Checking CPU usage..." >> $log_file
top -l 1 | grep "CPU usage" >> $log_file
echo "" >> $log_file

# Check disk space
echo "[$current_date] Checking disk space..." >> $log_file
df -h >> $log_file
echo "" >> $log_file

# Check memory usage
echo "[$current_date] Checking memory usage..." >> $log_file
vm_stat >> $log_file
echo "" >> $log_file

# Check battery status
echo "[$current_date] Checking battery status..." >> $log_file
pmset -g batt >> $log_file
echo "" >> $log_file

# Check network connectivity
echo "[$current_date] Checking network connectivity..." >> $log_file
ping -c 4 8.8.8.8 >> $log_file
echo "" >> $log_file


# Check system temperatures
echo "[$current_date] Checking system temperatures..." >> $log_file
system_profiler SPPowerDataType >> $log_file
echo "" >> $log_file

# Check top memory-consuming processes
echo "[$current_date] Checking top memory-consuming processes..." >> $log_file
ps aux | head -n 10 >> $log_file
echo "" >> $log_file


# Check active network interfaces
echo "[$current_date] Checking active network interfaces..." >> $log_file
ifconfig | grep "status: active" -B 1 >> $log_file
echo "" >> $log_file

# Check available software updates
echo "[$current_date] Checking software updates..." >> $log_file
softwareupdate -l > /tmp/softwareupdate_output.log 2>&1
cat /tmp/softwareupdate_output.log >> $log_file
rm /tmp/softwareupdate_output.log
echo "" >> $log_file

# Check running services and sort by label
echo "[$current_date] Checking running services..." >> $log_file

# Capture and sort the output
temp_file=$(mktemp)
launchctl list | sort -k3 >> $temp_file

# Append sorted output to log file
cat $temp_file >> $log_file

# Clean up
rm $temp_file

echo "" >> $log_file

echo "[$current_date] Health check completed." >> $log_file


