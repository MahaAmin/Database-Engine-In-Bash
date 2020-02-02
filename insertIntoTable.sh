#! /bin/bash

# TO-DO:
# Steps to Insert new row in table:
# [DONE]1- Read table name from user.
# [DONE]2- Validate tableName (noSpaces, table-exists)
# [DONE]3- Get column names from table.metadata
# [DONE]3- For each row:
#   [DONE]3.1- For each column:
#       [DONE]3.1.1- Show column name
#       [DONE]3.1.2- Read new value from user
#       3.1.3- Validate new value:
#           [DONE]3.1.3.1- check value matches column's datatype
#           [DONE]3.1.3.2- If column is PK --> value must be unique
#   [DONE]3.2- append new row (col1:col2:..) in Databases/$currDB/Data/$tableName

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


function insertRow(){
    # read columns info from tableName.metadata into array
    IFS=$'\n' read -d '' -r -a lines < "Databases/$currDB/Metadata/$tableName.metadata"

    # new record
    newRecord="";
    errorFlag=0; #true

    # loop over lines array to insert each column
    for i in "${!lines[@]}"
    do
        IFS=':' read -r -a column <<< "${lines[i]}";
        colName=${column[0]};
        colDataType=${column[1]};
        colPK=${column[2]};

        #test flags
        dataTypeFlag=0; #true
        pkFlag=0;   #true

        #read new column value from user
        read -p "Enter $colName: " newColValue;
        numRegex='^[0-9]+$'

        # validate dataType
        if [[ $colDataType == "number" ]]; then
            if ! [[ $newColValue =~ $numRegex ]]; then
                dataTypeFlag=1; #false
                errorFlag=1; #false
                echo "ERROR: Value must be a number.";
            fi 
        fi

        # validate if PK
        if [[ $colPK == "yes" ]]; then
            # get all column data from Data/tableName
            IFS=$'\n' read -d '' -r -a dataLines < "Databases/$currDB/Data/$tableName"  # all table
            
            #loop over column data to check pk if unique
            for j in "${!dataLines[@]}";
            do
                IFS=':' read -r -a record <<< "${dataLines[$j]}"; # record(row)
                if [[ ${record[i]} == $newColValue ]]; then
                    pkFlag=1; #false(not-unique)
                    errorFlag=1; #false
                    echo "ERROR: Primary key must be unique.";
                fi
            done
        fi


        #if value valid add it to newRecord string
        if [[ dataTypeFlag==0 && pkFlag==0 ]]; then
            if [[ $i == 0 ]]; then
                newRecord=$newColValue;
            else
                newRecord="$newRecord:$newColValue";
            fi
        else
            echo "In-valid record";
        fi
    done


    # append newRecord in Data/$tableName
    if ! [[ $newRecord == "" ]]; then
        if [[ $errorFlag == 0 ]]; then
            if echo $newRecord >> "Databases/$currDB/Data/$tableName"; then
                echo "Record stored succesfully.";
            else
                echo "ERROR: Failed to store record.";
            fi
        else
            echo "ERROR: Failed to store record.";
        fi
    else
        echo "ERROR: Record is empty.";
    fi
}

# Read tableName from user
read -p "Enter table name: " tableName;

# Validate tableName
nameFlag=$(validateTableName "$tableName");
tableExistsFlag=$(tableExists "$tableName");


if [ $nameFlag == 0 ] && [ $tableExistsFlag == 0 ]; then
    insertRow
else
    echo "In-valid table name. Check log.out for more details.";
fi