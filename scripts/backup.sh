#!/bin/bash 

# Path for this script is : ~/Backup/bachup.sh

currentdir=$(pwd)

echo "I will create save the backup file in $currentdir"

tar -cf "$currentdir/my_backup_$(date +%d-%m-%Y_%H-%M-%S).tar" $HOME 2>/dev/null
echo "Backup completed successfully...."

exit 0 

