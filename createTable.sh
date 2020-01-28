#!/bin/bash

#echo "In createTable.sh"

read -p "Enter table name: " tableName;

if test -f "$currDB/$tableName"; then
    echo "table already exists!";
else
    if touch "$currDB/$tableName" 2> log.out; then
        echo "$tableName created succesfully";
    else
        echo "Falied to create $tableName. Refer to log.out for more details."
    fi
fi

echo $tableName;