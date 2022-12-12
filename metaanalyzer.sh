#!/bin/bash
#
#


OIFS="$IFS"
IFS=$'\n'


if [ "$1" = "" ]
then
        echo "Modo de uso"
        echo
        echo "$0 test.com" 
else
        echo "Starting search...."
        echo
        lynx --dump "https://google.com/search?&q=site:$1+ext:pdf" | grep ".pdf" | cut -d "=" -f2 | egrep  -v "site|google" | sed 's/...$//' | egrep 'http|https' > $1.txt

        echo "Getting files...."
        for X in `cat $1.txt`
        do
                wget $X 
        done

        for X in `ls *.pdf`
        do
                echo 
                echo "============== $X ================"
                exiftool "$X"
        done
fi
