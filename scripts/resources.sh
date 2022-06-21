#!/bin/bash
OPT=$(echo -e "HTOP\nBashtop\nbpytop\nGPU" | dmenu  -fn 'NotoMonoRegular:bold:pixelsize=18' -p "Choose action: ")
case $OPT in
	HTOP )  kitty -e htop ;;
	Bashtop ) kitty -e bashtop ;;
	bpytop )  kitty -e bpytop ;; 
	GPU )     kitty -e nvtop ;; 
	*) ;;
esac

