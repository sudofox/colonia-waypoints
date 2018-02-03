#!/bin/bash
# Generate command list from coordinates/stations to issue in game to add dynmap markers

# Usage: ./generate_command_list.sh filename.txt

while read -r i; do

	echo $i|awk -F\| '{print "/tp "$7" "$8" "$9}'
	echo $i|awk -F\| '{print "/dmarker add id:"$2" \""$4"\" icon:pin set:waypoints"}'
done < <(sqlite3 database/colonia.sqlite "select * from railway_stations")
