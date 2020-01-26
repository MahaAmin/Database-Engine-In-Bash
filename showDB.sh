#!/bin/bash

DIR="Databases"
if [ -d "$DIR" ]; then
  ls $DIR
else 
    echo "No Databases to show"
    exit
fi
