# Colonia Waypoints

by sudofox

A toolkit to generate, manage, and update waypoints, railway lines, and locations in Colonia.

## Starting off
Run initialize.sh when you start off.

## Stations

Stations are stored in lines/<lowercased railway line name>.txt

Format (one per line):

```
Example Station (Windsor, Metro) 123 50 456
-		-		 -
|		|		 |
|		|		 +---- x y z of station
|		+------- If the station is a hub, put the names of the lines it connects to in parenthesis. I strip out commas etc. This is used to mark it as a hub
+------ Station name - this includes everything up until the coordinates.
```

If the railway line is the Metro Line, you would put the stations in lines/metro.txt

## Scripts

`generate_line_sql.sh`		 		- Generates the SQL statements to add the lines to the database.
`generate_railway_station_sql.sh`		- Generates the SQL statements to add the stations to the database.
`generate_command_list_from_database.sh`	- Generates the commands to run in-game to add all the waypoints to the map. 

## Updating the waypoints in game

You'll need to be opped, and to avoid weird things that could affect the coordinates, you might consider setting yourself to spectator mode. 
I do this from a simple chat-only client I wrote using pyCraft (and might integrate that into the repository) so I can just paste the commands into my terminal.

First, delete all the markers in the `waypoints` marker list:

/dmarker deleteset id:waypoints

Next, run ./generate_command_list_from_database.sh to get your command list (because it seems there's no way to simply add the coordinates to the command, we have to teleport to each location first.)

Paste those in and you'll have your stations! I'm using the 'pin' icon for now, but might differentiate things later.


