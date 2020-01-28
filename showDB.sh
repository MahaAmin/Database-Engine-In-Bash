#!/bin/bash
DIR="$(pwd)/Databases"
if [ -d "$DIR" ] && [ "$(ls -A $DIR)" ]; then
   echo "Available Databases"
  ls $DIR
else 
    echo "No Databases to show"
fi

