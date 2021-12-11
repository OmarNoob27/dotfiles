#!/bin/bash
OPT=$(echo -e "styli\nimages" | dmenu -nb '#191919' -nf '#fea63c' -sb '#fea63c' -sf '#191919' -fn 'NotoMonoRegular:bold:pixelsize=16' -p "Choose Source: ")
case $OPT in
	styli ) cp ~/.cache/styli.sh/wallpaper.jpg  ~/wall/wall_$(date +'%Y_%m_%d_%H%M%S').jpg ;; 
	images ) cp ~/.images/wallpaper_2560x1440.jpeg ~/wall/wall_$(date +'%Y%m%d-%H%M%S').jpeg ;;	
	*) ;;
esac

