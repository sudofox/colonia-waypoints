#!/bin/bash

# Generates the entries for the Google Sheets document

# strip leading or trailing whitespace
trim () {
	sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//'
}

for line in $(ls lines|awk -F. '{print $1}'); do
	while read -r waypoint; do
		waypoint=$(echo $waypoint|tr '\t' ' ') # Replace tabs with spaces
		LINELENGTH=$(echo $waypoint|wc -w)
		LABELWORDS=$(expr $LINELENGTH - 3)

		# determine if station has names of other lines in parenthesis (these are hubs)

		CHECK_HUB=$(echo $waypoint| grep -Po '\(\K.+?(?=\))'|tr -dc '[:alpha:] ' |tr ' ' '\n' |sed -s 's/proposed//g' |tr '[:upper:]' '[:lower:]'|sed '/^\s*$/d')
		if [[ $(echo -n "$CHECK_HUB" |wc -w) -gt 0 ]]; then
			isHub=1
		else
			isHub=0
		fi

		if [[ $isHub == 1 ]]; then
			station_label=$(echo $waypoint|cut -d ' ' -f 1-$LABELWORDS|grep -Po ".+?(?=\()"|trim)
		else
			station_label=$(echo $waypoint|cut -d ' ' -f 1-$LABELWORDS|trim)
		fi

		station_name=$(echo $waypoint|cut -d ' ' -f 1-$LABELWORDS|tr ' ' '_' | tr '[:upper:]' '[:lower:]' |tr -cd '[:alnum:]_')

		transfers=$(echo $CHECK_HUB|sed -e "s/\b\(.\)/\u\1/g")
                #CHECK_HUB=$(echo $waypoint| grep -Po '\(\K.+?(?=\))'|tr -dc '[:alpha:] ' |tr ' ' '\n' |sed -s 's/proposed//g' |tr '[:upper:]' '[:lower:]'|sed '/^\s*$/d')

		posX=$(echo $waypoint|awk '{print $(NF-2)}')
		posY=$(echo $waypoint|awk '{print $(NF-1)}')
		posZ=$(echo $waypoint|awk '{print $(NF)}')

		echo $station_label","$station_name","$transfers","$posX","$posY","$posZ #,"INSERT INTO railway_stations (station_name, line_name, station_label, isHub, posX, posY, posZ) values (\""$station_name"\",\""$line"\", \""$station_label"\","$isHub","$posX","$posY","$posZ");"
	done< lines/$line.txt
done
