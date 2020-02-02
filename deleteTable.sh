#!/bin/bash

echo "Enter Table Name"
read TableName 
if [ -f  "Databases/$currDB/Data/$TableName" ] && [ -f  "Databases/$currDB/Metadata/$TableName.metadata" ]; then 
    rm -r Databases/$currDB/Data/$TableName
    rm -r Databases/$currDB/Metadata/$TableName.metadata
    echo "$TableName Table  deleted Successfully"
  else 
    echo "No such Table"
fi








