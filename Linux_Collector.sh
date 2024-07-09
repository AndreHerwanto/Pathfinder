#!/bin/bash
###################################################################################
#
#    Script:    Linux_Collector.sh
#    Version:   1.0
#    Purpose:   Linux Cyber Security Incident Response Script (Bash)
#    Usage:     sudo ./Linux_Collector.sh
#
#    This program is free software: you can redistribute it and / or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program. If not, see <https://www.gnu.org/licenses/>.
#
###################################################################################

version='v1.0'

########## Startup ##########

echo "


Linux Cyber Security Incident Response Script (Bash)

Script: Linux_Collector.sh - Version: $version - Author: DS

"
echo -e "\e[93m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Please Note:

Hi $(whoami), script running on $(hostname), please do not touch.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\e[0m"

echo -e "\e[92m
Running script... \e[0m"

########## Admin ##########

echo "
(Task 1 / 13) Admin tasks running."

# Destination
dst=$(pwd)
# System Date/Time
ts=$(date +%Y%m%d_%H%M%S)
# Computer Name
edp=$(hostname)
# Triage
name='Linux_Collector_'$edp\_$ts
tri=$name
# Directory Structure
mkdir $tri
chmod 777 $tri
# Start Log
exec 2> $tri/Linux_Collector.log

########## Memory ##########

echo "
(Task 2 / 13) Collecting memory data."

# Directory Structure
mkdir $tri/Memory
chmod 777 $tri/Memory
# Processes
vol_format=user,pid,ppid,%cpu,%mem,vsz,rss,tty,stat,stime,time,cmd
ps axwwSo $vol_format > $tri/Memory/Processes_Active.txt
# Memory Information
cat /proc/meminfo > $tri/Memory/meminfo
# Memory Statistics
vmstat > $tri/Memory/Memory_Statistics.txt
# Loaded Modules
lsmod | head > $tri/Memory/Loaded_Modules.txt
# Open Files
lsof > $tri/Memory/Open_Files.txt

########## Accounts ##########

echo "
(Task 3 / 13) Collecting account data."

# Directory Structure
mkdir $tri/Accounts
chmod 777 $tri/Accounts
mkdir $tri/Accounts/Bash
chmod 777 $tri/Accounts/Bash
mkdir $tri/Accounts/ZSH
chmod 777 $tri/Accounts/ZSH
mkdir $tri/Accounts/Python
chmod 777 $tri/Accounts/Python
mkdir $tri/Accounts/MRU
chmod 777 $tri/Accounts/MRU
# Bash History
find / -name ".bash_history" -exec tar -rf $tri/Accounts/Bash/bash_history.tar "{}" \;
# Bash Profile
find / -name ".bash_profile" -exec tar -rf $tri/Accounts/Bash/bash_profile.tar "{}" \;
# Bash Logout
find / -name ".bash_logout" -exec tar -rf $tri/Accounts/Bash/bash_logout.tar "{}" \;
# Bash RC
find / -name ".bashrc" -exec tar -rf $tri/Accounts/Bash/bashrc.tar "{}" \;
# ZSH History
find / -name ".zsh_history" -exec tar -rf $tri/Accounts/ZSH/zsh_history.tar "{}" \;
# ZSH RC
find / -name ".zshrc" -exec tar -rf $tri/Accounts/ZSH/zshrc.tar "{}" \;
# Python History
find / -name ".python_history" -exec tar -rf $tri/Accounts/Python/python_history.tar "{}" \;
# Most Recently Used
find / -name "recently-used.xbel" -exec tar -rf $tri/Accounts/MRU/recently-used-xbel.tar "{}" \;
# User Accounts
cat /etc/passwd > $tri/Accounts/passwd
# Password Hashes
cat /etc/shadow > $tri/Accounts/shadow
# User Groups
cat /etc/group > $tri/Accounts/group
# User Permissions
cp -rfp /etc/sudoers $tri/Accounts/sudoers
sed -i 's/@includedir/#@includedir/g' $tri/Accounts/sudoers
# Active Users
who -a > $tri/Accounts/Users_Active.txt
# Users Most Recent Logon
lastlog > $tri/Accounts/Users_All_Last_Logon.txt
# UTMP Activity
utmpdump /var/run/utmp > $tri/Accounts/UTMP_Activity.txt
# WTMP Activity
utmpdump /var/log/wtmp > $tri/Accounts/WTMP_Activity.txt
find / -name "wtmp*" -exec tar -rf $tri/Accounts/WTMP_Activity.tar "{}" \;
# BTMP Activity
utmpdump /var/log/btmp > $tri/Accounts/BTMP_Activity.txt
find / -name "btmp*" -exec tar -rf $tri/Accounts/BTMP_Activity.tar "{}" \;

########## Configuration ##########

echo "
(Task 4 / 13) Collecting system data."

# Directory Structure
mkdir $tri/Configuration
chmod 777 $tri/Configuration
mkdir $tri/Configuration/Crontab
chmod 777 $tri/Configuration/Crontab
mkdir $tri/Configuration/init
chmod 777 $tri/Configuration/init
mkdir $tri/Configuration/init.d
chmod 777 $tri/Configuration/init.d
mkdir $tri/Configuration/rc.local
chmod 777 $tri/Configuration/rc.local
mkdir $tri/Configuration/rc.local.d
chmod 777 $tri/Configuration/rc.local.d
# Hostname
hostname > $tri/Configuration/hostname
# System Date/Time/Zone
timedatectl > $tri/Configuration/System_Date_Time_Zone.txt
# Uptime
uptime > $tri/Configuration/Uptime.txt
# DNS Resolver
cat /etc/resolv.conf > $tri/Configuration/resolve.conf
# Host
cat /etc/host.conf > $tri/Configuration/host.conf
# Name Service Switch
cat /etc/nsswitch.conf > $tri/Configuration/nsswitch.conf
# Kernel Information
cat /proc/version > $tri/Configuration/Kernel_Information.txt
# Operating System Information
cat /etc/*release* > $tri/Configuration/OS_Information.txt
# Disk Management
lsblk > $tri/Configuration/Disk_Drives.txt
# Disk Partition Table
fdisk -lu > $tri/Configuration/Disk_Partition_Table.txt
# Disk Usage
df -h > $tri/Configuration/Disk_Usage.txt
# File System Information
mount > $tri/Configuration/Mounted_File_Systems.txt
# USB Devices
lsusb -v > $tri/Configuration/USB_Devices.txt
# PCI Devices
lspci > $tri/Configuration/PCI_Devices.txt
# Crontab Listing
ls -al /etc/cron.* > $tri/Configuration/Crontab_Files.txt
# Crontab Files
cp -rfp /etc/cron.d $tri/Configuration/Crontab
cp -rfp /etc/cron.daily $tri/Configuration/Crontab
cp -rfp /etc/cron.hourly $tri/Configuration/Crontab
cp -rfp /etc/cron.weekly $tri/Configuration/Crontab
cp -rfp /etc/cron.monthly $tri/Configuration/Crontab
cp -rfp /var/spool/cron/crontabs $tri/Configuration/Crontab
# Service Status
systemctl list-unit-files --type=service > $tri/Configuration/Service_Status.txt
# init Files
cp -rfp /etc/init $tri/Configuration/init
# init.d Files
cp -rfp /etc/init.d $tri/Configuration/init.d
# rc.local Files
cp -rfp /etc/rc.local $tri/Configuration/rc.local
# rc.local.d Files
cp -rfp /etc/rc.local.d $tri/Configuration/rc.local.d

########## Network ##########

echo "
(Task 5 / 13) Collecting network data."

# Directory Structure
mkdir $tri/Network
chmod 777 $tri/Network
mkdir $tri/Network/SSH
chmod 777 $tri/Network/SSH
# Netstat
netstat -anp > $tri/Network/Netstat_Connections.txt
# Socket Statistics
ss > $tri/Network/Socket_Statistics.txt
# Host IP Address
hostname -I > $tri/Network/Host_IP_Address.txt
# DHCP
cat /etc/resolv.conf > $tri/Network/resolv.conf
# Hosts
cat /etc/hosts > $tri/Network/hosts
# Hosts Allow
cat /etc/hosts.allow > $tri/Network/hosts.allow
# Hosts Deny
cat /etc/hosts.deny > $tri/Network/hosts.deny
# Routing Table
netstat -rn > $tri/Network/Routing_Table.txt
# ARP Table
cat /proc/net/arp > $tri/Network/arp
# IP Configuration
ifconfig -a > $tri/Network/ipconfig.txt
# Port Status
nmap $(hostname -I) > $tri/Network/Port_Status.txt
# IP Tables Filter Rules
iptables -t filter -L -v -n > $tri/Network/iptables_Filter.txt
# IP Tables NAT Rules
iptables -t nat -L -n -v > $tri/Network/iptables_NAT.txt
# SSH Configuration
find / -name "ssh_config" -exec tar -rf $tri/Network/SSH/ssh_config.tar "{}" \;
# Users SSH Known Hosts
find / -name "known_hosts" -exec tar -rf $tri/Network/SSH/known_hosts.tar "{}" \;
# Users SSH Authorized Keys
find / -name "authorized_keys" -exec tar -rf $tri/Network/SSH/authorized_keys.tar "{}" \;

########## Logs ##########

echo "
(Task 6 / 13) Collecting log data."

# Directory Structure
mkdir $tri/Logs
chmod 777 $tri/Logs
# Log Configuration
cat /etc/logrotate.conf > $tri/Logs/logrotate.conf
# SSHD Journal Events
journalctl -u sshd >> $tri/Logs/SSHD_Journal_Events.txt
# /var/log/*
tar -zcf $tri/Logs/var_log.tar.gz /var/log
# /var/run UTMP log
tar -zcf $tri/Logs/var_run_utmp.tar.gz /var/log/utmp

########## Programs ##########

echo "
(Task 7 / 13) Collecting program data."

# Directory Structure
mkdir $tri/Programs
chmod 777 $tri/Programs
# Installed Packages
dpkg-query -W > $tri/Programs/Installed_Packages.txt
# Installed Modules
lsmod > $tri/Programs/Installed_Modules.txt
# Installed Binary Hashes
for b in '/usr/bin/*'
do
        md5sum $b >> $tri/Programs/Installed_Binary_Hashes.txt
done

########## File System ##########

echo "
(Task 8 / 13) Collecting file system data."

# Directory Structure
mkdir $tri/FileSystem
chmod 777 $tri/FileSystem
# Trash Bin File Entries
for r in '/home/*/.local/share/Trash/info/*'
do
		cat $r >> $tri/FileSystem/Trash_Bin_File_Entries.txt	
done
# Trash Bin Raw Metadata
find / -name "*.trashinfo" -exec tar -rf $tri/FileSystem/trashinfo.tar "{}" \;
# Trash Bin File Hashes
for tb in '/home/*/.local/share/Trash/files/*'
do
        md5sum $tb >> $tri/FileSystem/Trash_Bin_File_Hashes.txt
done
# Root Temporary File Hashes
find /tmp -type f -exec md5sum {} \; > $tri/FileSystem/Root_Temporary_File_Hashes.txt
# Downloads File Hashes
find /home/*/Downloads -type f -exec md5sum {} \; > $tri/FileSystem/Downloads_File_Hashes.txt
# Potential Webshell File Hashes
find / -xdev -type f \( -iname '*.jsp' -o -iname '*.php' -o -iname '*.asp' -o -iname '*.aspx' \) 2>/dev/null -print0 | xargs -0 md5sum > $tri/FileSystem/Potential_Webshell_File_Hashes.txt

########## Internet ##########

echo "
(Task 9 / 13) Collecting internet data."

# Directory Structure
mkdir $tri/Internet
chmod 777 $tri/Internet
# Firefox History
find / -name "places.sqlite" -exec tar -rf $tri/Internet/places-sqlite.tar "{}" \;
# Firefox Cookies
find / -name "cookies.sqlite" -exec tar -rf $tri/Internet/cookies-sqlite.tar "{}" \;
# Firefox Forms
find / -name "formhistory.sqlite" -exec tar -rf $tri/Internet/formhistory-sqlite.tar "{}" \;

########## tmp folder ##########

echo "
(Task 10 / 13) Collecting tmp folder."

mkdir $tri/tmp
chmod 777 $tri/tmp

tar -zcf $tri/tmp/tmp.tar.gz /tmp

########## weblogic ##########

echo "
(Task 11 / 13) Collecting weblogic logs."

mkdir $tri/weblogic
chmod 777 $tri/weblogic

find / -name "*access*.log" -exec tar -rf $tri/weblogic/access.tar "{}" \;
find / -name "*server*.log" -exec tar -rf $tri/weblogic/server.tar "{}" \;

########## dir-list ##########

echo "
(Task 12 / 13) Collecting dir-list."

mkdir $tri/dir-list
chmod 777 $tri/dir-list

find /tmp -exec stat {} \; > $tri/dir-list/dir-list-tmp.txt
dir -laR / \; > $tri/dir-list/dir-list.txt



########## Organise Collection ##########

echo "
(Task 13 / 13) Organising collection."

# Hashing
find $tri -type f -exec md5sum {} \; >> $dst/$tri/Hashes.txt

# Compress Archive
tar -zcf $tri.tar.gz $dst/$tri

# Delete Folder
rm -rf $tri

echo -e "\e[92m
Script completed!

Send the following file to Sygnia:
$dst/$tri.tar.gz \e[0m"
