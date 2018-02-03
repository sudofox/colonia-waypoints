#!/bin/bash

ls lines/|awk -F. '{print "INSERT INTO railway_lines (line_name, line_label) values (\""$1"\", \""toupper(substr($1,1,1)) substr($1,2)" Line\");"}'
