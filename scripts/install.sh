#!/bin/bash 
printf "###Updating the system..."
doas pacman -Syyu

#printf "###Install xorg-server and display manager"
#doas pacman -S picom xorg-server xorg-xrandr lightdm lightdm-gtk-greeter xorg-xrdb 

printf "###Install nvim"
doas pacman -S neovim 

printf"###Install Multimedia..."
#doas pacman -S pipewire pipewire-alsa pipewire-pulse 
doas pacman -S pulseaudio 
doas pacman -S pulsemixer 
doas pacman -S mpv 
doas pacman -S mpd 
doas pacman -S moc 
doas pacman -S ncmpcpp 
doas pacman -S youtube-dl 
doas pacman -S ffmpeg 

printf "###Install file manger..."
doas pacman -S nnn 
doas pacman -S dolphin 
doas pacman -S pcmanfm 

printf "###Install terminal and tools..."
doas pacman -S alacritty 
doas pacman -S fish 
doas pacman -S kitty 
doas pacman -S exa 
doas pacman -S fzf
doas pacman -S cmatrix 
doas pacman -S xdotool 

printf "###Install Diagnostic..."
doas pacman -S htop 
doas pacman -S nvtop 

printf "###Install nvidia..."
doas pacman -S nvidia 
doas pacman -S nvidia-lts 
doas pacman -S optimus-manager 

printf "###Install browsers"
doas pacman -S brave-bin 
doas pacman -S firefox 
doas pacman -S google-chrome 
doas pacman -S chromium 
doas pacman -S qutebrowser 

printf "###Install pdf viewer..."
doas pacman -S zathura 
doas pacman -S okular 

printf "###Install launcher themes and tools ..."
doas pacman -S python-pywal 
doas pacman -S qt5ct 
doas pacman -S lxappearance 
doas pacman -S kvantum 

printf "###Install firewall..."
doas pacman -S gufw 

printf "###Install aur..."
doas pacman -S git 
doas pacman -S paru 
doas pacman -S yay 

printf "###Install general tools..."
doas pacman -S sxhkd 
doas pacman -S dmenu 
doas pacman -S sxiv 
doas pacman -S clipmenu 
doas pacman -S trash-cli 
doas pacman -S kdialog 

printf "###Install zoom and tools"
doas pacman -S zoom
doas pacman -S droidcam 

