#!/bin/bash
# 
DIR="Databases"
if [ -d "$DIR" ] && [ "$(ls -A $DIR)" ]; then
  ls $DIR
else 
    echo "No Databases to show"
fi
