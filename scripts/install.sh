#!/bin/bash 

printf "###Updating the system...\n"
pacman -Syyu
printf "###Now,The system is up todate...\n"
#
printf "###Install aur helper and doas...\n"
pacman -S paru doas
#
printf "###Make config file for doas..."
touch /etc/doas.conf 
#echo "permit omar as root" > /etc/doas.conf
echo "permit :wheel" > /etc/doas.conf

printf "###Install xorg-server and display manager"
pacman -S picom xorg-server xorg-xrandr lightdm lightdm-gtk-greeter xorg-xrdb 

printf "###Install nvim...\n"
pacman -S neovim 

#printf"###Install Multimedia...\n"
#pacman -S pulseaudio pulsemixer mpv mpv-mpris mpd mpc moc ncmpcpp youtube-dl ffmpeg

printf "###Install file manger...\n"
pacman -S nnn dolphin pcmanfm 

printf "###Install terminal and tools...\n"
pacman -S alacritty fish kitty exa fzf cmatrix xdotool xclip maim

printf "###Install Diagnostic...\n"
pacman -S htop nvtop

#printf "###Install nvidia...\n"
#pacman -S nvidia nvidia-lts optimus-manager

#printf "###Install browsers\n"
#pacman -S brave-bin firefox google-chrome chromium qutebrowser

printf "###Install pdf tools...\n"
pacman -S zathura okular zathura-pdf-mupdf

printf "###Install launcher themes and tools ...\n"
pacman -S python-pywal qt5ct lxappearance kvantum

printf "###Install firewall...\n"
pacman -S gufw 

printf "###Install aur...\n"
pacman -S git paru yay

printf "###Install general tools...\n"
pacman -S sxhkd dmenu rofi sxiv clipmenu trash-cli kdialog xorg-xprop

#printf "###Install zoom and tools...\n"
#pacman -S zoom droidcam
