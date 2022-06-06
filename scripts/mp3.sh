#!/bin/bash
neofetch 
cd ~/youtube-dl 
echo "---------------------------------------------"
echo "✘ ❯❯ $(pwd)"
echo "---------------------------------------------"
read -p '❯❯❯ Enter name of file : ' name 
echo "---------------------------------------------"
youtube-dl --extract-audio --audio-format mp3 $(xclip -o) -o $name.mp3 && notify-send "Download process is completed." && notify-send -i ~/logo/download.png "Download completei👋👋"
