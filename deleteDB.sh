#!/bin/bash
cd Databases/
echo "Enter Database Name"
read name 
if [ -d  "$name" ]; then 
    rm -r $name
    echo "$name database  deleted Successfully"
  else 
    echo "No such Database"
fi


    


