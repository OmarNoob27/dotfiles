#!/bin/bash

declare options=("Brave
Firefox
Google-chrome
Qutebrowser")

#choice=$(echo -e "${options[@]}" | dmenu -l 10 -i -fn 'Roboto Mono' -p 'launch browser: ' -nb '#3b3b3b' -nf '#71988a' -sb '#000000' -sf '#71988a')
choice=$(echo -e "${options[@]}" | dmenu -nb '#191919' -nf '#fea63c' -sb '#fea63c' -sf '#191919' -fn 'NotoMonoRegular:bold:pixelsize=15' -i -l 20  -p 'launch browser: ' )

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
    Qutebrowser)
        choice="qutebrowser"
    ;;
esac
"$choice"
