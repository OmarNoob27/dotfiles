#!/bin/bash
[ $# -eq 0 ] && echo "# `basename $0` file1 [file2 file#]"
for inpute in $@    
do 
    output=`echo $inpute | sed -e 's/\..*$//g'`
    ffmpeg -i "$inpute" -c:v libx264 -preset slow -crf 22 -pix_fmt yuv420p -c:a aac -b:a 128k "$output.mp4"
done 
