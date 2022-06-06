#!/bin/bash

pidof -s "mpv" >/dev/null && title=$(playerctl metadata --format '{{emoji(status)}} {{duration(position)}}[{{duration(mpris:length)}}] {{xesam:title}}') ; printf "$title" || exit

pidof -s "vlc" >/dev/null && title=$(playerctl metadata --format '{{emoji(status)}} {{duration(position)}}[{{duration(mpris:length)}}] {{xesam:title}}') ; printf "$title" || exit

pidof -s "spotifyd" >/dev/null && song_info=$(playerctl metadata --format '{{emoji(status)}} {{duration(position)}}[{{duration(mpris:length)}}] {{xesam:artist}} - {{xesam:title}}') ; printf "$song_info" || exit

if pidof -s "mpd" >/dev/null; then 
	play_info=$(mpc current); play_sts=$(mpc | awk '/\[/ {print $1}'); play_pos=$(mpc | awk '/\[/ {print $3}' | awk -F "/" '{print $1 "[" $2 "]"}')
	case "$play_sts" in
		"[paused]") cur_icon="⏸️" ;;
		"[playing]") cur_icon="▶️" ;;
	esac
	printf "$cur_icon $play_pos $play_info"
else exit 
fi
