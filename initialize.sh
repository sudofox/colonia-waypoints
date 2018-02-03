#!/bin/bash

# Run this to initialize the database.

if [ -f database/colonia.sqlite ]; then
	echo "[INFO] Database already exists, exiting.";
	exit;
fi

cat schema.sql | sqlite3 database/colonia.sqlite
