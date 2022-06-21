#!/bin/bash
OPT=$(echo -e "S_clip\nS_save\nS_both\nA_clip\nA_save\nFull" | dmenu -p "Choose action: ")
case $OPT in
	S_clip ) maim -s | xclip -selection clipboard -t image/png ;;
	S_save) maim -s ~/screenshots/$(date +'%Y%m%d-%H%M%S').png  ;;
	S_both ) maim -s | tee ~/screenshots/$(date +'%Y%m%d-%H%M%S').png | xclip -selection clipboard -t image/png ;; 
	A_clip ) maim -i $(xdotool getactivewindow) | xclip -selection clipboard -t image/png   ;;
  A_save) maim -i $(xdotool getactivewindow) ~/screenshots/$(date +'%Y%m%d-%H%M%S').png ;;
  Full ) maim -i root ~/screenshots/$(date +'%Y%m%d-%H%M%S').png ;;
	*) ;;
esac 


