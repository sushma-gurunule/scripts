#!/bin/sh
#script to detect changes in /etc/passwd file
#we need to take initial backup of /etc/passwd file into /etc/passwd_backup

#Setting up variables
file="/etc/passwd"
backup="/etc/passwd_backup"

#To check if /etc/passwd file is exist or not
if [ -f "$file" ]; then
        #To check if /etc/passwd_backup file is exists or not
        if [ -f "$backup" ]; then
		#Part 1 :- To Detect Changes in /etc/passwd file
                #Below Code Snippet To Check the differences in the files by comparing the files line by line.
                if [ "$(diff $file $backup)" != "" ]; then
                        date 
                        echo "Detected changes in /etc/passwd file....."
                        echo "Below are the changes ("'>' means Line deleted and '<' means Line added"):- "
                        echo "-----------------------------------------"
                        diff $file $backup  
                        echo "-----------------------------------------"
                        echo "Updating Backup file with new changes so we can detect future changes to /etc/passwd"
                        cp -r /etc/passwd /etc/passwd_backup
                        echo "/etc/passwd_backup is updated."
                else
                        date
                        echo "No changes Detected in /etc/passwd file."
                fi
        else
	       #Part 2 :- Take Backup of /etc/passwd 
               #Below Code Snippet will take backup of /etc/passwd if not present.
               date
               echo "/etc/passwd_backup file is not available ..."
               echo "Creating /etc/passwd_backup file...."
               cp -r /etc/passwd /etc/passwd_backup
               echo "/etc/passwd_backup file created."
        fi
else
        #Part 3 :- Restore /etc/passwd if file got deleted mistakenly 
	#Below Code snippet Restore /etc/passwd from backup file if /etc/passwd deleted mistakenly or /etc/passwd file need to restored from from OS Backup. 
        date
        echo "/etc/passwd file is not present."
        echo "Verifying if /etc/passwd_backup file is available or not..."
        if [ -f "$backup" ]; then
                echo "Restoring /etc/passwd from /etc/passwd_backup file"
                cp -r /etc/passwd_backup /etc/passwd
                echo "/etc/passwd file Restored."
        else
                echo "/etc/passwd_backup file is not available, Please get it restored from latest available OS Backup"
        fi
fi
