#!/bin/bash
neofetch 
cd ~/youtube-dl
echo "---------------------------------------------"
echo "✘ ❯❯ $(pwd)"
echo "---------------------------------------------"
read -p '❯❯❯ Enter name of file : ' name
echo "---------------------------------------------"
youtube-dl -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4' $(xclip -o) -o $name.mp4 && notify-send "Download process is completed." && notify-send -i ~/logo/download.png "Download completei👋👋"


