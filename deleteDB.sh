#!/bin/bash

echo "Enter Database Name"
read name 
if [ -d  "Databases/$name" ]; then 
    rm -r Databases/$name
    echo "$name database  deleted Successfully"
  else 
    echo "No such Database"
fi

