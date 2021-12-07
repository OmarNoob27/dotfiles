#!/bin/bash
[ $# -eq 0 ] && echo "# `basename $0` file1 [file2 file#]"
for inpute in $@    
do 
    output=`echo $inpute | sed -e 's/\..*$//g'`
    soffice --headless --convert-to pdf "$inpute"
done 


