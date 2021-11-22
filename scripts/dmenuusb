#!/usr/bin/env sh

# Dmenu to mount/unmount partitions.

ScriptName=${0##*/}
Version=1.0.0

# Set menu options:
MenuMount='1. Mount a partition.'
MenuUnmount='2. Unmount a partition.'

ChosenMenu=$(printf '%s\n%s' \
    "$MenuMount" "$MenuUnmount" \
    | dmenu -i -l 10 -p "$ScriptName:")

# Mount a partition:
if [ "$ChosenMenu" = "$MenuMount" ]; then
    Mountable=$(lsblk -lp \
        | grep "part $" \
        | awk '{print $1, "(" $4 ")"}')
    [ -z "$Mountable" ] && exit 1

    Chosen=$(printf '%s' "$Mountable" \
        | dmenu -i -l 10 -p 'Mount which drive?' \
        | awk '{print $1}')
    [ -z "$Chosen" ] && exit 1

    # Try to mount directly based on fstab:
    sudo mount "$Chosen" && exit 0
    # Otherwise ask for directory.

    ### Implement a way to exclude already mounted locations.

    Directories=$(find ~/cell -maxdepth 1 -type d 2>/dev/null)
    MountPoint=$(printf '%s' "$Directories" \
        | dmenu -i -l 10 -p 'Type in mount point:')
    [ -z "$MountPoint" ] && exit 1

    if [ ! -d "$MountPoint" ]; then
        mkdirprompt=$(printf 'No\\nYes' \
            | dmenu -i -p "$MountPoint does not exist. Create it?")
        [ "$mkdirprompt" = 'Yes' ] && sudo mkdir -p "$MountPoint"
    fi

    sudo mount "$Chosen" "$MountPoint" -o umask=000    # (-o umask=000) >> bacause FAT / FAT32 formatted drives don't support file permissions

# Unmount a partition:
elif [ "$ChosenMenu" = "$MenuUnmount" ]; then
    ExclusionRegex='\(/boot\|/home\|/\|/backup\|/backup/extra\)$'

    Drives=$(lsblk -lp \
        | grep "part /" \
        | grep -v "$ExclusionRegex" \
        | awk '{print $1, "(" $4 ")", "on", $7}')
    [ -z "$Drives" ] && exit 1

    Chosen=$(printf '%s' "$Drives" \
        | dmenu -i -l 10 -p 'Unmount which drive?' \
        | awk '{print $1}')
    [ -z "$Chosen" ] && exit 1

    sudo umount "$Chosen"
elif [ -z "$ChosenMenu" ]; then
    exit 1
else
    printf 'ERROR: invalid selection.\n'
    exit 1
fi
