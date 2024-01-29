#!/bin/bash

#creating variables of interest
#backup_location=$1
#file_or_dir_to_backup=$2

backupLoc=$(cd "$1" && pwd)
fileOrDirBackup=$(cd "$(dirname "$2")" && pwd)/$(basename "$2")

#getting the file name
fileName=$(basename "$fileOrDirBackup")

#new variable with date concatenation for new file namae smth like $1.date.tar
newDate=$(date +"%Y%m%d")


#checking for input validation: if there are two input arguments
if [[ $# != 2 ]]; then
        echo "Error: Expected two input parameters."
        echo "Usage: "$0" <backupdirectory> <fileordirtobackup>"
        exit 1
fi

#checking if the directory to backup in exists
if [[ ! -d "$backupLoc" ]]; then
        echo "Error: The directory "$backupLoc" does not exist."
        exit 2
#checking if the file or directory to backup exists
        elif [[ ! -e "$fileOrDirBackup" ]]; then
        echo "Error: The file or directory does not exist."
        exit 2
#checking if both arguments are both the same directory
        elif [[ "$backupLoc" = "$fileOrDirBackup" ]]; then
        echo "Error: Both directories are the same."
#adding the exit code to comply with all these conditions
        exit 2
fi

#add the creating a tar file here
tarFile="$backupLoc/${fileName}.${newDate}.tar"

#checking if a tar file with the same name already exisrs
if [[ -e $tarFile ]]; then
        echo "Backup file "$tarFile" already exists. Overwrite? (y/n)"
        read answer
        if [[ "$answer" == "y" ]]; then
#create the new tar file
                tar -Pcf "$tarFile" "$fileOrDirBackup" 2>/dev/null
                exit 0
        else
                exit 3
        fi
else

#create the new tar file from scratch
        tar -Pvcf "$tarFile" "$fileOrDirBackup"
        exit 0
fi
