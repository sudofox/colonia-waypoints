-- Colonia Waypoint Database Schema

-- Railway Stations

-- station_name		text such as morden_picadilly (needs to be unique) or mount_oswalt
-- line_name		text such as northern or kensington - lowercase, underscores between words
-- station_label 	text such as "Mount Oswalt" or "Casterly Rock (Central)"
-- posX-posZ		ints, should be where you stop at the station
-- isHub		bool 
-- specialIcon		text, default null, meant to store name of custom icon for dynmap if we want to use one

CREATE TABLE railway_stations (
station_id integer PRIMARY KEY,
station_name text not null,
line_name text not null,
station_label text not null,
isHub boolean default 0 not null check (isHub in (0,1)),
specialIcon text default null,
posX int,
posY int,
posZ int,
UNIQUE (station_name) ON CONFLICT IGNORE
);

-- Railway Lines

CREATE TABLE railway_lines (
line_name text not null primary key,
line_label text not null,
UNIQUE (line_label) ON CONFLICT IGNORE
);

