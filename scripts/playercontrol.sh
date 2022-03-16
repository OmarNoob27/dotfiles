#!/bin/bash

#This is like a structure within an array

#create the array of media players found
ap=($(playerctl -l))
#status array and display array
apstatus=($(playerctl -a status))
apdisplay=()

#iterate over all elements and clean up the naming of the elements before outputting to demnu
#create a second array for display purposes, it's like a structure having the display and internal names
#position is just the positioning of the line useful for later
position=1
for i in "${ap[@]}"
	do
	:
	#get the status of the player and save it for use later
	#apstatus+=($(playerctl -p "$i" status))
	#try to search for strings that might not be so pretty and replace them with pretty strings
	if [[ $i == *"chromium"* ]]; then
		apdisplay+=("$position Chromium")
	elif [[ $i == *"vlc"* ]]; then
		apdisplay+=("$position VLC")
	else
		apdisplay+=("$position $i")
	fi
	((position++))
done
apdisplay+=("$position ")

selected=$(printf '%s\n' "${apdisplay[@]}" | dmenu -p "Selected Playback")
index=${selected%% *}
#decrement the index for the array
((index--))

#if the cancel is selected, null, or not in the array, close the script. escape key leaves the string null
if [[ ! " ${apdisplay[@]} " =~ " ${selected} " || $selected == *""* || -z $selected ]]; then
	exit 0
fi

#try to get metadata information for the selected player
metadata=$(playerctl -p ${ap[index]} metadata --format '{{ artist }} - {{ album }} - {{ title }}')
#no meta information is available so set it unavailable
if [[ $metadata == " -  - " || -z $metadata ]]; then
	metadata="Information Unavailable"
fi

if (( ${#metadata} > 60 )); then
	metadata=$(echo ${metadata:0:60}...)
fi
	selection=$(echo -e "\n懶\n\n\n" | dmenu -p "${apdisplay[index]} | ${apstatus[index]} | $metadata ")
if [[ $selection == "" ]]; then
	playerctl -p ${ap[index]} previous
elif [[ $selection == "" ]]; then
	playerctl -p ${ap[index]} next
elif [[ $selection == "懶" ]]; then
	playerctl -p ${ap[index]} play-pause
elif [[ $selection == "" ]]; then
	"$HOME/scripts/playercontrol.sh"
else
	exit 0
fi
