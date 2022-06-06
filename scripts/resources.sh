#!/bin/bash
OPT=$(echo -e "HTOP\nGPU" | dmenu -nb '#191919' -nf '#fea63c' -sb '#fea63c' -sf '#191919' -fn 'NotoMonoRegular:bold:pixelsize=16' -p "Choose action: ")
case $OPT in
	HTOP )  kitty -e htop ;;
	GPU )     kitty -e nvtop ;; 
	*) ;;
esac

