#!/bin/bash

declare options=("Brave
Firefox
Google-chrome
Chromium
Qutebrowser")

#choice=$(echo -e "${options[@]}" | dmenu -l 10 -i -fn 'Roboto Mono' -p 'launch browser: ' -nb '#3b3b3b' -nf '#71988a' -sb '#000000' -sf '#71988a')
choice=$(echo -e "${options[@]}" | dmenu -i -l 20  -p 'launch browser: ' )

case "$choice" in 
    quit)
        echo "program terminated." && exit 1
    ;;
    Brave)
        choice="brave"
    ;;
    Firefox)
        choice="firefox"
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
esac
"$choice"
