#!/bin/bash
[ $# -eq 0 ] && echo "# `basename $0` file1 [file2 file#]"
for inpute in $@    
do 
    output=`echo $inpute | sed -e 's/\..*$//g'`
    ffmpeg -i "$inpute"  -c:v prores -profile:v 3 -c:a pcm_s16le "$output.mov"
done 
