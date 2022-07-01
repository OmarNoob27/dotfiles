#!/bin/bash

opt=$(echo -e "Mount\nUmount" | dmenu -p "Choose Action: ")
case "$opt" in 
    Mount ) ~/scripts/dmenu_mount.sh -m && notify-send -i ~/logo/mount.png "Mount Done" ;;
    Umount ) ~/scripts/dmenu_mount.sh -u && notify-send -i ~/logo/mount.png "Umount Done" ;;
    *) ;; 
esac

#old script 
#if [ -d /media/* ];then 
#    ~/scripts/dmenu_mount.sh -u && notify-send -i ~/logo/mount.png "Umount Done"
#else 
#  ~/scripts/dmenu_mount.sh -m && notify-send -i ~/logo/mount.png "Mount Done"
#fi 

