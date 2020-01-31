#!/bin/bash

# TO-DO: steps of creating new table:


createColumns(){
    read -p "Enter column name: " colName;
    while [ "$colName" != "0" ]; 
    do
        # select column datatype (string, number)
        options=("string" "number");
        select option in "${options[@]}"
        do
            case $option in
                "string") colType=1;;
                "number") colType=2;;
            esac
        done
        # create dbName/metadata.txt each row descripes column
    done
}

read -p "Enter table name: " tableName;

if test -f "$currDB/$tableName"; then
    echo "table already exists!";
else
    if touch "$currDB/$tableName" 2> log.out; then
        touch "$currDB/metadata.txt";
        echo "$tableName created succesfully";
    else
        echo "Falied to create $tableName. Refer to log.out for more details."
    fi
fi


# TO-DO: create table function
# 