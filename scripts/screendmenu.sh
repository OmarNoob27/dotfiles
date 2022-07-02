#!/bin/bash
OPT=$(echo -e "A_clip\nA_save\nA_both\nW_clip\nW_save\nFull" | dmenu -p "Choose action: ")
case $OPT in
	A_clip ) maim -s | xclip -selection clipboard -t image/png && notify-send -i ~/logo/screen.png "Screenshot taken" ;;
	A_save) maim -s ~/screenshots/$(date +'%Y%m%d-%H%M%S').png  && notify-send -i ~/logo/screen.png "Screenshot taken" ;;
	A_both ) maim -s | tee ~/screenshots/$(date +'%Y%m%d-%H%M%S').png | xclip -selection clipboard -t image/png && notify-send -i ~/logo/screen.png "Screenshot taken" ;;
	W_clip ) maim -i $(xdotool getactivewindow) | xclip -selection clipboard -t image/png   && notify-send -i ~/logo/screen.png "Screenshot taken" ;;
  W_save) maim -i $(xdotool getactivewindow) ~/screenshots/$(date +'%Y%m%d-%H%M%S').png && notify-send -i ~/logo/screen.png "Screenshot taken" ;;
  Full ) maim -i root ~/screenshots/$(date +'%Y%m%d-%H%M%S').png && notify-send -i ~/logo/screen.png "Screenshot taken" ;;
	*) ;;
esac 
