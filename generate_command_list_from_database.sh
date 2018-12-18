#!/bin/bash
# Generate command list from coordinates/stations to issue in game to add dynmap markers

# Usage: ./generate_command_list.sh filename.txt

echo '/dmarker deleteset id:railway_stations'
echo '/dmarker addset "Railway Stations" id:railway_stations'

while read -r i; do

	echo $i|awk -F\| '{print "/tp "$7" "$8" "$9}'
	if [[ $(echo $i|awk -F\| '{print $5}') == 1 ]]; then
		echo $i|awk -F\| '{print "/dmarker add id:"$2" \""$4"\" icon:temple set:railway_stations"}'
	else
		echo $i|awk -F\| '{print "/dmarker add id:"$2" \""$4"\" icon:pin set:railway_stations"}'
	fi
done < <(sqlite3 database/colonia.sqlite "select * from railway_stations")

#one more echo so that the last command gets executed when copy-pasting into bot
echo
