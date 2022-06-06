#!/bin/bash
#sxiv via dmenu is opened only if directory existing 
while true; do
    open=$(ls --group-directories-first --file-type | dmenu "$@" -nb '#191919' -nf '#fea63c' -sb '#fea63c' -sf '#191919' -fn 'NotoMonoRegular:bold:pixelsize=15' -i -l 20  -p 'choice the directory: ')
    if [[ -d "$open" ]]; then
        cd "$open"
    else
        if [[ "$open" != "" ]]; then
            cd $open
            sxiv *
        fi
        exit 0
    fi
done
