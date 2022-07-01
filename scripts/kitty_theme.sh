#!/bin/bash

theme_path=$HOME/.config/kitty/kitty-themes/themes
cd $theme_path
opt=$(echo $(ls | dmenu -i -l 30 -p 'Choose Theme: '))
if [ -z "$opt" ];then
    notify-send -i ~/logo/theme.png "Not Selected Any Theme." 
else 
    rm ~/.config/kitty/theme.conf 
    ln -s ~/.config/kitty/kitty-themes/themes/$opt ~/.config/kitty/theme.conf
    echo $opt >> ~/.config/kitty/previous_theme.txt
    notify-send -i ~/logo/theme.png "Selected $opt Theme." 
fi 

