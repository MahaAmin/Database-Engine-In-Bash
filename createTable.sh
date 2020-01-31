#!/bin/bash

# TO-DO: steps of creating new table:

function validateTableName(){
    valid=0     #true
    IFS=' ' read -r -a array <<< $1;
    if (( ${#array[@]} > 1 )); then 
        printf "ERROR: Table name can not contain spaces.";
        echo "ERROR: Table name can not contain spaces." >> log.out;
        valid=1; #false
    fi

    if (( ${#array[@]} == 0 )); then 
        printf "ERROR: Table name can not be empty.";
        echo "ERROR: Table name can not be empty." >> log.out;
        valid=1; #false
    fi

    # validate table name does not start with number
    first="${array[0]:0:1}"
    if [[ $first =~ [0-9] ]]; then
        printf "ERROR: Table name can not begin with number.";
        echo "ERROR: Table name can not begin with number." >> log.out;
        valid=1; #false
    fi


    # validate table name has at least one letter
    if [[ "$1" =~ [A-Za-z] ]]; then
        echo "Valid table name" >> log.out;
    else
        printf "ERROR: Table name must contain at least one letter.";
        echo "ERROR: Table name must contain at least one letter." >> log.out;
        valid=1;    #false
    fi

    echo $valid;
}

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

nameFlag=$(validateTableName "$tableName");

if [[ $nameFlag == 0 ]]; then
    echo "$nameFlag True";
else
    echo "$nameFlag False";
fi

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

# Steps of creating new table
# 1- Validate table name (noSapces, contains at least one letter, does not start with number)
# 2- Check if table already exists
# 3- Create 2 files Data/tableName and MetaData/tableName.metadata
# 4- Read number of columns from user 
# 5- For each column :
#   5.1- Read column name from user
#   5.2- Let user choose datatype (String/Number)
#   5.3- Is it primary-key column (Y/N)

