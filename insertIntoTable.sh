#! /bin/bash

# TO-DO:
# Steps to Insert new row in table:
# 1- Read table name from user.
# 2- Validate tableName (noSpaces, table-exists)
# 3- For each row:
#   3.1- For each column:
#       3.1.1- Show column name
#       3.1.2- Read new value from user
#       3.1.3- Validate new value:
#           3.1.3.1- check value matches column's datatype
#           3.1.3.2- If column is PK --> value must be unique
#   3.2- append new row (col1:col2:..) in Databases/$currDB/Data/$tableName
# 4- Ask user if he/she wants to insert another row


function validateTableName(){
    # Function call: validateTableName "$tableName"
    valid=0     #true
    IFS=' ' read -r -a array <<< $1;
    if (( ${#array[@]} > 1 )); then 
        echo "ERROR: Table name can not contain spaces." >> log.out;
        valid=1; #false
    fi

    if (( ${#array[@]} == 0 )); then 
        echo "ERROR: Table name can not be empty." >> log.out;
        valid=1; #false
    fi

    echo $valid;
}

function tableExists(){
    tableName=$1;
    valid=0     # valid;

    if [[ -f Databases/$currDB/Data/$tableName ]]; then
        echo "Table exists." >> log.out;
    else
        echo "$tableName no such table." >> log.out;
        valid=1;    # not-found
    fi

    echo $valid;
}



# Read tableName from user
read -p "Enter table name: " tableName;

echo "DB: $currDB, Table:$tableName";

# Validate tableName
nameFlag=$(validateTableName "$tableName");
tableExistsFlag=$(tableExists "$tableName");

echo "nameFlag: $nameFlag, tableExistsFlag: $tableExistsFlag";

if [ $nameFlag == 0 ] && [ $tableExistsFlag == 0 ]; then
    echo "Valid table";
else
    echo "In-valid table name. Check log.out for more details.";
fi

