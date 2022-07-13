#!/usr/bin/env sh 
#path to this file : /usr/bin/nnnopen
if [[ ! -f "$1" ]];then
	exit
fi

mime=$(file -b --mime-type "$1")
echo $mime
# m3u files report as text/plain for some reason
if [[ "${1#*.}" = "m3u" ]];then
	mpv --player-operation-mode=pseudo-gui "$1"

# text/*
#elif [[ "${mime%/*}" = "text" ]];then
#	nnnedit "$1"

# image/*
elif [[ "${mime%/*}" = "image" ]];then
	sxiv "$1"
# video/*
elif [[ "${mime%/*}" = "video" || "${mime%/*}" = "audio" ]];then
	mpv --player-operation-mode=pseudo-gui "$1"
# ebooks 
elif [[ "$mime" = "application/epub+zip" ]];then
	zathura "$1"
# pdfs 
elif [[ "$mime" = "application/pdf" ]];then
	zathura "$1"
# exe 
elif [[ "$mime" = "application/x-dosexec" ]];then
	wine "$1"
elif [[ "$mime" = "application/vnd.oasis.opendocument.text" ]];then
	libreoffice "$1"
elif [[ "$mime" = "application/vnd.openxmlformats-officedocument.wordprocessingml.document" ]];then
	libreoffice "$1"
elif [[ "$mime" = "application/vnd.openxmlformats-officedocument.presentationml.presentation" ]];then
	libreoffice "$1"
# html 
elif [[ "$mime" = "text/html" ]];then
	brave "$1"
# plain txt
elif [[ "$mime" = "text/plain" ]];then
	kitty -e nvim "$1"
# shellscript 
elif [[ "$mime" = "text/x-shellscript" ]];then
	kitty -e nvim "$1"
fi
