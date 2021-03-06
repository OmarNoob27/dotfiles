#!/bin/bash

# where to save (or look for) the script
#script_path="$HOME/.local/bin"
script_path="$HOME"

# the editor of your choice
script_editor="nvim"

# check for argument (script name)

script_file="$script_path/$1"

if [[ -z "$@" ]]; then
    echo -e "\n\nError!\nUsage: ssgen script_name\n\n"
    exit 0;
fi

# if script doesn't exist, create it

if [[ ! -f $script_file ]]; then
    echo '#!/usr/bin/env bash' > $script_file
    chmod +744 $script_file
fi

# open script with editor

eval $script_editor $script_file

exit 0
