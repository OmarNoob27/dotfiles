#!/bin/bash
OPT=$(echo -e "dmenu_note\nOpen_note" | dmenu -nb '#191919' -nf '#fea63c' -sb '#fea63c' -sf '#191919' -fn 'NotoMonoRegular:bold:pixelsize=16' -p "Choose action: ")
case $OPT in
	dmenu_note ) /home/omar/github/dmscripts/scripts/dm-note ;; #&& pkill -RTMIN+3 i3blocks ;;
	Open_note )  alacritty -e doas nvim /home/omar/.config/dmscripts/dmnote ;;	
	*) ;;
esac

