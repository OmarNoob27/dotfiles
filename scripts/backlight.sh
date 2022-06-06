#!/bin/bash

# Prints the backlight percentage
# Requires the light package

get_backlight()
{
    echo "$(light | sed 's/\..*//g')%"
}

get_backlight

