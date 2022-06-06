#!/bin/bash
OPT=$(echo -e "OPEN_Player\nKILL_Player" | dmenu -nb '#191919' -nf '#fea63c' -sb '#fea63c' -sf '#191919' -fn 'NotoMonoRegular:bold:pixelsize=16' -p "Choose action: ")
case $OPT in
	OPEN_Player ) konsole -e mocp -m ~/Music && pkill -RTMIN+3 i3blocks ;;
	KILL_Player ) pkill mocp && pkill -RTMIN+3 i3blocks ;;	
	*) ;;
esac

