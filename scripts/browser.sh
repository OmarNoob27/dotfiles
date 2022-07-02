#!/bin/bash

declare options=("Firefox
Brave
Google-chrome
Chromium
Qutebrowser
librewolf")

#choice=$(echo -e "${options[@]}" | dmenu -l 10 -i -fn 'Roboto Mono' -p 'launch browser: ' -nb '#3b3b3b' -nf '#71988a' -sb '#000000' -sf '#71988a')
choice=$(echo -e "${options[@]}" | dmenu -i -l 20 -g 2 -X 0 -Y 0 -W 680 -p 'launch browser: ' )
#choice=$(echo -e "${options[@]}" | dmenu -i -l 20 -p 'launch browser: ' )

case "$choice" in 
    quit)
        echo "program terminated." && exit 1
    ;;
    Firefox)
        choice="firefox"
    ;;
    Brave)
        choice="brave"
    ;;
    Google-chrome)
        choice="google-chrome-stable"
    ;;
    Chromium)
        choice="chromium"
    ;;
    Qutebrowser)
        choice="qutebrowser"
    ;;
    librewolf)
        choice="librewolf"
    ;;
esac
"$choice"
