#!/bin/bash
OPT=$(echo -e "Download_mp3\nDownload_mp4" | dmenu  -p "Choose action: ")
case $OPT in
	Download_mp3 )  kitty -e /home/omar/scripts/mp3.sh ;;
	Download_mp4 )     kitty -e /home/omar/scripts/mp4.sh ;; 
	*) ;;
esac

