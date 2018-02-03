#!/bin/bash
# Generate command list from coordinates/stations to issue in game to add dynmap markers

while read -r i; do
	i=$(echo $i|tr '\t' ' ') # Replace tabs with spaces
	LINELENGTH=$(echo $i|wc -w)
	LABELWORDS=$(expr $LINELENGTH - 3)
	echo $i|awk '{print "/tp "$(NF-2)" " $(NF-1) " " $NF}'
	echo $i|cut -d ' ' -f 1-$LABELWORDS|awk '{print "/dmarker add \""$0"\" icon:pin"}'
done< "$1"
