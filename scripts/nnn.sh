#!/usr/bin/env sh

export NNN_PLUG='p:mocq;i:imgview;c:fzcd;t:mp3conv;e:suedit;v:preview-tui;V:nuke;x:!doas chmod +x $nnn;k:pskill;K:!pkill mpv;s:!bash -i*' #to play this plug press ; then choose option 
export NNN_BMS="g:$HOME/Documents/Github/dotfiles;d:$HOME/Downloads/;h:~;s:~/scripts;f:~/ffmpeg;C:~/cell;w:~/wall;y:~/youtube-dl;t:~/.local/share/Trash/files;S:~/screenshots;c:~/.config;p:~/pins;m:~/Music" #to play this plug press b then choose option 
export NNN_OPENER=nnnopen #nnnopen path : ~/.bin 
export NNN_TMPFILE='/tmp/.lastd'
export NNN_COLORS='1267'
#export NNN_FCOLORS='c1e26168E66033f7c6d6abc4'
BLK="c1" CHR="e2" DIR="61" EXE="68" REG="E6" HARDLINK="60" SYMLINK="33" MISSING="f7" ORPHAN="c6" FIFO="d6" SOCK="ab" OTHER="c4"
export NNN_FCOLORS="$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$OTHER"
export NNN_FIFO=/tmp/nnn.fifo
export NNN_TRASH=1 #to use trash (needs trash-cli) instead of delete. the trash's directory : /home/omar/.local/share/Trash/files
export NNN_ARCHIVE="\\.(7z|a|ace|alz|arc|arj|bz|bz2|cab|cpio|deb|gz|jar|lha|lz|lzh|lzma|lzo|rar|rpm|rz|t7z|tar|tbz|tbz2|tgz|tlz|txz|tZ|tzo|war|xpi|xz|Z|zip)"
alacritty -e nnn -e
