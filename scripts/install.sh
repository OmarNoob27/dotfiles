#!/bin/bash 
printf "###Updating the system...\n"
sudo pacman -Syyu
printf "###Now,The system is up todate...\n"

printf "###Install aur helper and doas...\n"
sudo pacman -S paru doas

#printf "###Make config file for doas..."
#touch /etc/doas.conf 
#echo "permit omar as root" > /etc/doas.conf

#printf "###Install xorg-server and display manager"
#doas pacman -S picom xorg-server xorg-xrandr lightdm lightdm-gtk-greeter xorg-xrdb 

printf "###Install nvim...\n"
doas pacman -S neovim 

printf"###Install Multimedia...\n"
#doas pacman -S pipewire pipewire-alsa pipewire-pulse 
doas pacman -S pulseaudio pulsemixer mpv mpd moc ncmpcpp youtube-dl ffmpeg

printf "###Install file manger...\n"
doas pacman -S nnn dolphin pcmanfm 

printf "###Install terminal and tools...\n"
doas pacman -S alacritty fish kitty exa fzf cmatrix xdotool 

printf "###Install Diagnostic...\n"
doas pacman -S htop nvtop

printf "###Install nvidia...\n"
doas pacman -S nvidia nvidia-lts optimus-manager

printf "###Install browsers\n"
doas pacman -S brave-bin firefox google-chrome chromium qutebrowser

printf "###Install pdf tools...\n"
doas pacman -S zathura okular

printf "###Install launcher themes and tools ...\n"
doas pacman -S python-pywal qt5ct lxappearance kvantum

printf "###Install firewall...\n"
doas pacman -S gufw 

printf "###Install aur...\n"
doas pacman -S git paru yay

printf "###Install general tools...\n"
doas pacman -S sxhkd dmenu rofi sxiv clipmenu trash-cli kdialog xorg-xprop

printf "###Install zoom and tools...\n"
doas pacman -S zoom droidcam
