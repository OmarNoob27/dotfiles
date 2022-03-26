set -e fish_user_paths
set -U fish_user_paths $HOME/.local/bin $HOME/Applications $fish_user_paths


### EXPORT ###
set fish_greeting                                 # Supresses fish's intro message
set TERMINAL "kitty"                         # Sets the terminal type
set EDITOR "nvim"
set VISUAL "nvim"
#export EDITOR=/usr/bin/nvim

### "bat" as manpager
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

### "vim" as manpager
#set -x MANPAGER '/bin/bash -c "vim -MRn -c \"set buftype=nofile showtabline=0 ft=man ts=8 nomod nolist norelativenumber nonu noma\" -c \"normal L\" -c \"nmap q :qa<CR>\"</dev/tty <(col -b)"'

### "nvim" as manpager
#set -x MANPAGER "nvim -c 'set ft=man' -"

### SET EITHER DEFAULT EMACS MODE OR VI MODE ###
function fish_user_key_bindings
  # fish_default_key_bindings
  fish_vi_key_bindings
end
### END OF VI MODE ###

### AUTOCOMPLETE AND HIGHLIGHT COLORS ###
set fish_color_normal brcyan
set fish_color_autosuggestion '#7d7d7d'
set fish_color_command brcyan
set fish_color_error '#ff6c6b'
set fish_color_param brcyan

### SPARK ###
set -g spark_version 1.0.0

complete -xc spark -n __fish_use_subcommand -a --help -d "Show usage help"
complete -xc spark -n __fish_use_subcommand -a --version -d "$spark_version"
complete -xc spark -n __fish_use_subcommand -a --min -d "Minimum range value"
complete -xc spark -n __fish_use_subcommand -a --max -d "Maximum range value"

function spark -d "sparkline generator"
    if isatty
        switch "$argv"
            case {,-}-v{ersion,}
                echo "spark version $spark_version"
            case {,-}-h{elp,}
                echo "usage: spark [--min=<n> --max=<n>] <numbers...>  Draw sparklines"
                echo "examples:"
                echo "       spark 1 2 3 4"
                echo "       seq 100 | sort -R | spark"
                echo "       awk \\\$0=length spark.fish | spark"
            case \*
                echo $argv | spark $argv
        end
        return
    end

    command awk -v FS="[[:space:],]*" -v argv="$argv" '
        BEGIN {
            min = match(argv, /--min=[0-9]+/) ? substr(argv, RSTART + 6, RLENGTH - 6) + 0 : ""
            max = match(argv, /--max=[0-9]+/) ? substr(argv, RSTART + 6, RLENGTH - 6) + 0 : ""
        }
        {
            for (i = j = 1; i <= NF; i++) {
                if ($i ~ /^--/) continue
                if ($i !~ /^-?[0-9]/) data[count + j++] = ""
                else {
                    v = data[count + j++] = int($i)
                    if (max == "" && min == "") max = min = v
                    if (max < v) max = v
                    if (min > v ) min = v
                }
            }
            count += j - 1
        }
        END {
            n = split(min == max && max ? "▅ ▅" : "▁ ▂ ▃ ▄ ▅ ▆ ▇ █", blocks, " ")
            scale = (scale = int(256 * (max - min) / (n - 1))) ? scale : 1
            for (i = 1; i <= count; i++)
                out = out (data[i] == "" ? " " : blocks[idx = int(256 * (data[i] - min) / scale) + 1])
            print out
        }
    '
end
### END OF SPARK ###


### FUNCTIONS ###
# Spark functions
#function letters
#    cat $argv | awk -vFS='' '{for(i=1;i<=NF;i++){ if($i~/[a-zA-Z]/) { w[tolower($i)]++} } }END{for(i in w) print i,w[i]}' | sort | cut -c 3- | spark | lolcat
#    printf  '%s\n' 'abcdefghijklmnopqrstuvwxyz'  ' ' | lolcat
#end

#function commits
#    git log --author="$argv" --format=format:%ad --date=short | uniq -c | awk '{print $1}' | spark | lolcat
#end

# Functions needed for !! and !$
#function __history_previous_command
#  switch (commandline -t)
#  case "!"
#    commandline -t $history[1]; commandline -f repaint
#  case "*"
#    commandline -i !
#  end
#end

#function __history_previous_command_arguments
#  switch (commandline -t)
#  case "!"
#    commandline -t ""
#    commandline -f history-token-search-backward
#  case "*"
#    commandline -i '$'
#  end
#end
# The bindings for !! and !$
#if [ $fish_key_bindings = "fish_vi_key_bindings" ];
#  bind -Minsert ! __history_previous_command
#  bind -Minsert '$' __history_previous_command_arguments
#else
#  bind ! __history_previous_command
#  bind '$' __history_previous_command_arguments
#end

# Function for creating a backup file
# ex: backup file.txt
# result: copies file as file.txt.bak
function backup --argument filename
    cp $filename $filename.bak
end

# Function for copying files and directories, even recursively.
# ex: copy DIRNAME LOCATIONS
# result: copies the directory and all of its contents.
#function copy
#    set count (count $argv | tr -d \n)
#    if test "$count" = 2; and test -d "$argv[1]"
#	set from (echo $argv[1] | trim-right /)
#	set to (echo $argv[2])
#        command cp -r $from $to
#    else
#        command cp $argv
#    end
#end

# Function for printing a column (splits input on whitespace)
# ex: echo 1 2 3 | coln 3
# output: 3
#function coln
#    while read -l input
#        echo $input | awk '{print $'$argv[1]'}'
#    end
#end

# Function for printing a row
# ex: seq 3 | rown 3
# output: 3
#function rown --argument index
#    sed -n "$index p"
#end

# Function for ignoring the first 'n' lines
# ex: seq 10 | skip 5
# results: prints everything but the first 5 lines
#function skip --argument n
#    tail +(math 1 + $n)
#end

# Function for taking the first 'n' lines
# ex: seq 10 | take 5
# results: prints only the first 5 lines
#function take --argument number
#    head -$number
#end

# Function for org-agenda
#function org-search -d "send a search string to org-mode"
    #set -l output (/usr/bin/emacsclient -a "" -e "(message \"%s\" (mapconcat #'substring-no-properties \
        #(mapcar #'org-link-display-format \
        #(org-ql-query \
        #:select #'org-get-heading \
        #:from  (org-agenda-files) \
        #:where (org-ql--query-string-to-sexp \"$argv\"))) \
        #\"
    #\"))")
    #printf $output
#end

### END OF FUNCTIONS ###


### ALIASES ###
# \x1b[2J   <- clears tty
# \x1b[1;1H <- goes to (1, 1) (start)
alias clear='echo -en "\x1b[2J\x1b[1;1H" ; echo; echo; seq 1 (tput cols) | sort -R | spark | lolcat; echo; echo'

# root privileges
#alias doas="doas --"

# navigation
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# git
#alias addup='git add -u'
#alias addall='git add .'
#alias branch='git branch'
#alias checkout='git checkout'
#alias clone='git clone'
#alias commit='git commit -m'
#alias fetch='git fetch'
#alias pull='git pull origin'
#alias push='git push origin'
#alias tag='git tag'
#alias newtag='git tag -a'

# get error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# gpg encryption
# verify signature for isos
alias gpg-check="gpg2 --keyserver-options auto-key-retrieve --verify"
# receive the key of a developer
alias gpg-retrieve="gpg2 --keyserver-options auto-key-retrieve --receive-keys"

# youtube-dl
alias yta-aac="youtube-dl --extract-audio --audio-format aac "
alias yta-best="youtube-dl --extract-audio --audio-format best "
alias yta-flac="youtube-dl --extract-audio --audio-format flac "
alias yta-m4a="youtube-dl --extract-audio --audio-format m4a "
alias yta-mp3="youtube-dl --extract-audio --audio-format mp3 "
alias yta-opus="youtube-dl --extract-audio --audio-format opus "
alias yta-vorbis="youtube-dl --extract-audio --audio-format vorbis "
alias yta-wav="youtube-dl --extract-audio --audio-format wav "
alias ytv-best="youtube-dl -f bestvideo+bestaudio "

# switch between shells
# I do not recommend switching default SHELL from bash.
alias tobash="sudo chsh $USER -s /bin/bash && echo 'Now log out.'"
alias tozsh="sudo chsh $USER -s /bin/zsh && echo 'Now log out.'"
alias tofish="sudo chsh $USER -s /bin/fish && echo 'Now log out.'"

# bare git repo alias for dotfiles
#alias config="/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME"

# termbin
alias tb="nc termbin.com 9999"

# the terminal rickroll
alias rr='curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash'

# Unlock LBRY tips
alias tips="lbrynet txo spend --type=support --is_not_my_input --blocking"

### DTOS ###
# Copy/paste all content of /etc/dtos over to home folder. A backup of config is created. (Be careful running this!)
alias dtoscopy='[ -d ~/.config ] || mkdir ~/.config && cp -Rf ~/.config ~/.config-backup-(date +%Y.%m.%d-%H.%M.%S) && cp -rf /etc/dtos/* ~'
# Backup contents of /etc/dtos to a backup folder in $HOME.
alias dtosbackup='cp -Rf /etc/dtos ~/dtos-backup-(date +%Y.%m.%d-%H.%M.%S)'

### RANDOM COLOR SCRIPT ###
# Get this script from my GitLab: gitlab.com/dwt1/shell-color-scripts
# Or install it from the Arch User Repository: shell-color-scripts
#colorscript random

### SETTING THE STARSHIP PROMPT ###
#starship init fish | source


#my config 
#alias v='doas nvim'
alias h='cd ~'
alias p='cd ..'
alias c='doas chmod 777'
alias d='doas'
/opt/shell-color-scripts/colorscripts/colorscript.sh -r 
#eval "$(starship init bash)"
alias pmi='doas pacman -S'
alias pmu='doas pacman -Syyu'
alias pmuu='paru -Syu'
alias pmr='doas pacman -Rs'
#alias pmR='doas pacman -Rns' #to remove config file for program 
alias pmR='doas pacman -Rd --nodeps' #remove pkg without dependencies
alias pmii='paru -S'
alias pmq='pacman -Qq'
alias pmn='pacman -Q | wc -l'
alias pmc='doas pacman -Sc' #clean the cache after upgrade my system 
alias pmg='pamac-manager'

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
alias e='exit'
alias tomp3='sh ~/scripts/tomp3.sh'
alias install='makepkg -si'
alias md='mkdir'
alias config='/home/omar/github/dmscripts/scripts/dm-confedit'
alias blk='lsblk'
#list
#alias ls='ls --color=auto'
#alias la='ls -a'
#alias ll='ls -la'
#alias l='ls'
#alias l.="ls -A | egrep '^\.'"
alias vim='doas nvim'
alias g='cd ~/Documents/GitHub'
alias gd='cd /home/omar/Documents/Github/dotfiles'
#alias pmug='git pull'
#alias ex='extract'
#alias sp='sh /home/omar/scripts/fzf-ueberzogen.sh'
#alias H='history | fzf | xclip -selection clipboard'
#alias img='sxiv * &'
alias img='~/scripts/sxivall1.sh'
alias imgall='~/scripts/sxivall2.sh'
alias gc='cd ~/.config'
alias cdi='cd ~/.config/i3'
alias ram='ps axh -o cmd:15,%mem --sort=-%mem | head | string trim'
alias cpu='ps axh -o cmd:15,%cpu --sort=-%cpu | head'
alias bup='sh /home/omar/scripts/gitupload'
alias y='ytfzf -ml'
alias yy='ytfzf -t'
#alias df='df -h'
alias df='duf'
alias printer='system-config-printer'
alias printerinstall='hp-setup -u'
alias epdf='okular'
alias topdf='sh ~/scripts/topdf.sh'
alias lf='lfrun'
alias vim='nvim'
alias gn='cd ~/.config/nnn'
alias tl='trash-list' 
alias tr='trash-restore'
#alias rm='trash-put'
alias td='cd ~/.local/share/Trash/files'
alias te='trash-empty'
alias rk='pulseaudio -k; pulseaudio --start'
alias pulse='doas nvim /etc/pulse/default.pa'
alias gs='cd ~/scripts'
alias sbup='cp -r scripts/ scripts_backup/'
alias ge='cd ~/Enterprise'
alias pr='proxychains'
alias pf='proxychains firefox'
alias toand='sh ~/scripts/android.sh'
alias N='prime-run'
alias power='tlpui'
alias cam='droidcam-cli -v adb 4747'
alias m='cmatrix'
alias mm='unimatrix'
alias gx='cd /usr/share/xsessions'
alias color='rgb-tui'
alias sv='~/scripts/dmenu_service'
alias ns='nvidia-smi'
alias ft='xdg-mime query filetype'
alias fd='xdg-mime query default'
alias search='find / -iname'
#alias search='locate -i'
#alias size='du -sh'
alias rip='~/scripts/rip' #to get public ip 
alias ip='ip --color a' #to get private ip 
alias ll='exa --group-directories-first  --icons -lh'
alias la='exa --group-directories-first  --icons -lah'
alias l='exa --group-directories-first  --icons'
alias ls='exa --group-directories-first  --icons'
alias hub='~/scripts/githubscripts/dm-hub'
alias calc='gnome-calculator'
alias smus='mpd && ncmpcpp'
alias mus='ncmpcpp'
alias emus='pkill mpd'
alias rd='zaread'
alias gsh='~/scripts/gsh'
alias size='gdu'
alias gm='cd /media'
alias yts='~/scripts/yts'
#search pkg with packman and install it 
function pmsi
    pacman -Slq | fzf --multi --preview 'pacman -Si {1}' | xargs -ro doas pacman -S
end
#search pkg with yay and install it 
function pmsii 
    yay -Slq | fzf -m --preview 'cat <(yay -Si {1}) <(yay -Fl {1} | awk "{print \$2}")' | xargs -ro  yay -S
end 
#search pkg and remove it 
function pmsr
    pacman -Qq | fzf --multi --preview 'pacman -Qi {1}' | xargs -ro sudo pacman -Rns
end
#search in scripts and open it 
function sc
    du -a ~/scripts/ | awk '{print $2}' | fzf --preview='head -$LINES {}'| xargs -r $EDITOR
end 
#search in $pwd and open it 
function sf 
    fzf --preview='head -$LINES {}'| xargs -r -I % $EDITOR % 
end 
#alias to nvim 
function v
    doas nvim $argv
end

####################################
####################################
#cd any directory by alias sd 
function sd -d "Change directory"
    set -l commandline (__fzf_parse_commandline)
    set -l dir $commandline[1]
    set -l fzf_query $commandline[2]

    if not type -q argparse
        # Fallback for fish shell version < 2.7
        function argparse
            functions -e argparse # deletes itself
        end
        if contains -- --hidden $argv; or contains -- -h $argv
            set _flag_hidden "yes"
        end
    end

    # Fish shell version >= v2.7, use argparse
    set -l options  "h/hidden"
    argparse $options -- $argv

    set -l COMMAND

    set -q FZF_CD_COMMAND
    or set -l FZF_CD_COMMAND "
    command find -L \$dir -mindepth 1 \\( -path \$dir'*/\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' \\) -prune \
    -o -type d -print 2> /dev/null | sed 's@^\./@@'"

    set -q FZF_CD_WITH_HIDDEN_COMMAND
    or set -l FZF_CD_WITH_HIDDEN_COMMAND "
    command find -L \$dir \
    \\( -path '*/\\.git*' -o -fstype 'dev' -o -fstype 'proc' \\) -prune \
    -o -type d -print 2> /dev/null | sed 1d | cut -b3-"

    if set -q _flag_hidden
        set COMMAND $FZF_CD_WITH_HIDDEN_COMMAND
    else
        set COMMAND $FZF_CD_COMMAND
    end

    eval "$COMMAND | "(__fzfcmd)" +m $FZF_DEFAULT_OPTS $FZF_CD_OPTS --query \"$fzf_query\"" | read -l select

    if not test -z "$select"
        builtin cd "$select"

        # Remove last token from commandline.
        commandline -t ""
    end

    commandline -f repaint
end
####################################
####################################
# name: sashimi prompt 

function __fzf_cd -d "Change directory"
    set -l commandline (__fzf_parse_commandline)
    set -l dir $commandline[1]
    set -l fzf_query $commandline[2]

    if not type -q argparse
        # Fallback for fish shell version < 2.7
        function argparse
            functions -e argparse # deletes itself
        end
        if contains -- --hidden $argv; or contains -- -h $argv
            set _flag_hidden "yes"
        end
    end

    # Fish shell version >= v2.7, use argparse
    set -l options  "h/hidden"
    argparse $options -- $argv

    set -l COMMAND

    set -q FZF_CD_COMMAND
    or set -l FZF_CD_COMMAND "
    command find -L \$dir -mindepth 1 \\( -path \$dir'*/\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' \\) -prune \
    -o -type d -print 2> /dev/null | sed 's@^\./@@'"

    set -q FZF_CD_WITH_HIDDEN_COMMAND
    or set -l FZF_CD_WITH_HIDDEN_COMMAND "
    command find -L \$dir \
    \\( -path '*/\\.git*' -o -fstype 'dev' -o -fstype 'proc' \\) -prune \
    -o -type d -print 2> /dev/null | sed 1d | cut -b3-"

    if set -q _flag_hidden
        set COMMAND $FZF_CD_WITH_HIDDEN_COMMAND
    else
        set COMMAND $FZF_CD_COMMAND
    end

    eval "$COMMAND | "(__fzfcmd)" +m $FZF_DEFAULT_OPTS $FZF_CD_OPTS --query \"$fzf_query\"" | read -l select

    if not test -z "$select"
        builtin cd "$select"

        # Remove last token from commandline.
        commandline -t ""
    end

    commandline -f repaint
end

#my config for nnn file manger 
#alias nnn='nnn -ed'
alias nnn='nnn -eRx'
alias nn='nnn -eRx'
alias n='nnn -Rxe'
alias sn='sudo -E nnn -eRH'
#export NNN_PLUG='p:mocq;i:imgview;c:fzcd;t:mp3conv;e:suedit;v:preview-tui;V:nuke;x:!doas chmod +x $nnn;k:pskill;K:!pkill mpv;s:!bash -i*;o:fzopen' #to play this plug press ; then choose option 
export NNN_PLUG='F:fixname;m:nmount;i:imgview;f:fzcd;t:mp3conv;e:suedit;v:preview-tui;x:!doas chmod +x $nnn;s:!bash -i*;o:fzopen;k:kdeconnect;u:upload;p:rsynccp' #to play this plug press ; then choose option 
export NNN_BMS="m:/media/;g:$HOME/Documents/Github/dotfiles;d:$HOME/Downloads/;h:~;s:~/scripts;f:~/ffmpeg;C:~/cell;w:~/wall;y:~/youtube-dl;t:~/.local/share/Trash/files;S:~/screenshots;c:~/.config;p:~/pins;P:~/Pictures;M:~/Music;e:~/Enterprise;v:~/Videos;k:/run/user/1000/59cda44b9f5d1bb4/;T:~/Templates" #to play this plug press b then choose option 
#xdg-open is the default opener for nnn 
export NNN_OPENER=nnnopen #nnnopen path : /usr/bin/nnnopen
#export NNN_OPENER=nuke 
export NNN_TMPFILE='/tmp/.lastd'
export NNN_COLORS='1267'
#BLK="c1" CHR="e2" DIR="95" EXE="68" REG="E6" HARDLINK="60" SYMLINK="33" MISSING="f7" ORPHAN="c6" FIFO="d6" SOCK="ab" OTHER="c4"
export NNN_FCOLORS='c1e29568E66033f7c6d6abc4'
export NNN_FIFO=/tmp/nnn.fifo
export NNN_TRASH=1 #to use trash (needs trash-cli) instead of delete. the trash's directory : /home/omar/.local/share/Trash/files
export NNN_ARCHIVE="\\.(7z|a|ace|alz|arc|arj|bz|bz2|cab|cpio|deb|gz|jar|lha|lz|lzh|lzma|lzo|rar|rpm|rz|t7z|tar|tbz|tbz2|tgz|tlz|txz|tZ|tzo|war|xpi|xz|Z|zip)"
