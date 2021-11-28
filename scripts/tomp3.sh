#!/bin/bash
[ $# -eq 0 ] && echo "# `basename $0` file1 [file2 file#]"
for inpute in $@    
do 
    output=`echo $inpute | sed -e 's/\..*$//g'`
    ffmpeg -i "$inpute" -vn -acodec libmp3lame -ac 2 -ab 192k -ar 48000 "$output.mp3"
    #ffmpeg -i "$inpute" "$output.mp3"
done 



<<comment 
mkdir -p output
for i in *.mp4 *.mkv; do
  printf "save as output/${i%%.*}.mp3"
  ffmpeg -i "$i" "output/${i%%.*}.mp3"  
done

cd ~/ffmpeg/output
for i in *.mp3; do 
  echo ------------------------
  echo "✘ ❯❯ $i"
  read -p "Enter name of source ✘ ❯❯ " name
  mv "$i" $name.mp3
done

comment 


