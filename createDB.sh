#!/bin/bash

createDB(){
    zenity --entry \
    --width=300 \
    --height=100 \
    --title="Create New Database" \
    --text="Enter database name:" \
    --entry-text "database name"
}

newDB=$(createDB)
if mkdir Databases/$newDB 2>> log.out; then
    zenity --notification --text "$newDB created sucessfully\n";
else 
    zenity --error --width=300 --height=150 --text "Can not create $newDB. Check log.out for more details.\n";
fi
