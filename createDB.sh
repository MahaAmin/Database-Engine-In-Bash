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
mkdir Databases/$newDB