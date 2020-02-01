#!/bin/bash

echo "Enter Table Name"
read TableName 
if [ -f  "Databases/$currDB/Data/$TableName" ]; then 
    rm -r Databases/$currDB/Data/$TableName
    echo "$TableName Table data deleted Successfully"
  else 
    echo "No such Table"
fi

if [ -f  "Databases/$currDB/Metadata/$TableName.metadata" ]; then 
    rm -r Databases/$currDB/Metadata/$TableName.metadata
    echo "$TableName Table Metadata deleted Successfully"
    
  else 
    echo "No such Table"
fi







