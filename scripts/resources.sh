#!/bin/bash
OPT=$(echo -e "htop\nbashtop\nbpytop\ngotop\nGPU" | dmenu  -fn 'NotoMonoRegular:bold:pixelsize=18' -p "Choose action: ")
case $OPT in
	htop )  kitty -e htop ;;
	bashtop ) kitty -e bashtop ;;
	bpytop )  kitty -e bpytop ;; 
	gotop )  kitty -e gotop ;; 
	GPU )     kitty -e nvtop ;; 
	*) ;;
esac

