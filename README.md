# Shell Script to Detect changes in /etc/passwd file

This script is to detect any changes in /etc/passwd file like Addition of any new user or deletion of any existing user. 

## Part 1 :- To Detect Changes in /etc/passwd file

We took approach to take backup of the /etc/passwd file as /etc/passwd_backup and run cron job every 15 minutes to compare content. If script detect any changes then it will update logs in /var/log/passwd_changes.log with date & Time. 

## Part 2 :- Take Backup of /etc/passwd       

If /etc/passwd_backup file is not present on server then script will take backup of /etc/passwd as /etc/passwd_backup. 

## Part 3 :- Restore /etc/passwd if file got deleted mistakenly 

If /etc/passwd_backup already present on server and mistakenly someone deleted /etc/passwd file, then script will restore /etc/passwd file using /etc/passwd_backup file. 

## Part 4 :- Cron Entry 

Cron Job Entry in /etc/cron.d to Run script Every 15 Minutes, Every day and update log file.

0,15,30,45 * * * *   root /absolute-path-of-the-script >> /absolute-path-of-log-file

## Example:- 
root@e594ba0d7b1c:/etc/cron.d# pwd

/etc/cron.d

root@e594ba0d7b1c:/etc/cron.d# cat passwd_changes 

0,15,30,45 * * * *  root /home/cloud_user/final_passwd.sh >> /var/log/crond_passwd.log
