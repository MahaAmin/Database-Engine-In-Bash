#!/bin/bash

echo "Enter Table Name :"
read TableName

if [ -f "Databases/$currDB/Data/$TableName" ] && [ -f  "Databases/$currDB/Metadata/$TableName.metadata" ]; then 

    awk -F: 'BEGIN { ORS=":" }; { print $1 }' Databases/$currDB/Metadata/$TableName.metadata
    printf "\n"
    cat  Databases/$currDB/Data/$TableName 
    else 
    echo "No such Table"
fi

