#!/bin/bash

# [DONE]: create table function

# Steps of creating new table
# [DONE] 1- Validate table name (noSapces, contains at least one letter, does not start with number)
# [DONE] 2- Check if table already exists
# [DONE] 3- Create 2 files Data/tableName and MetaData/tableName.metadata
# [DONE] 4- Read number of columns from user 
# [DONE] 5- For each column :
#   [DONE] 5.1- column name :
#       [DONE] 5.1.1- Read column name from user
#       [DONE] 5.1.2- validate column name (noSpaces, contains at least one letter, does not start with number)
#   [DONE] 5.2- Let user choose datatype (String/Number)
#   [DONE] 5.3- Is it primary-key column (Y/N)
#   [DONE] 5.4- create row containing column-info in table.metadata (colName:dataType:PK)


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

    # validate table name does not start with number
    first="${array[0]:0:1}"
    if [[ $first =~ [0-9] ]]; then
        echo "ERROR: Table name can not begin with number." >> log.out;
        valid=1; #false
    fi


    # validate table name has at least one letter
    if [[ "$1" =~ [A-Za-z] ]]; then
        echo "Valid table name" >> log.out;
    else
        echo "ERROR: Table name must contain at least one letter." >> log.out;
        valid=1;    #false
    fi

    echo $valid;
}


function tableExists(){
    currDB=$1;
    tableName=$2;

    valid=0     # valid;

    if [[ -f Databases/$currDB/Data/$tableName ]]; then
        echo "ERROR: Table already exists." >> log.out;
        valid=1;    # not-valid
    fi

    echo $valid;
}


function validateColumnName(){
    # Function call: validateTableName "$colName"
    valid=0     #true
    IFS=' ' read -r -a array <<< $1;
    if (( ${#array[@]} > 1 )); then 
        echo "ERROR: Column name can not contain spaces." >> log.out;
        valid=1; #false
    fi

    if (( ${#array[@]} == 0 )); then 
        echo "ERROR: Column name can not be empty." >> log.out;
        valid=1; #false
    fi

    # validate table name does not start with number
    first="${array[0]:0:1}"
    if [[ $first =~ [0-9] ]]; then
        echo "ERROR: Column name can not begin with number." >> log.out;
        valid=1; #false
    fi


    # validate table name has at least one letter
    if [[ "$1" =~ [A-Za-z] ]]; then
        echo "Valid Column name" >> log.out;
    else
        echo "ERROR: Column name must contain at least one letter." >> log.out;
        valid=1;    #false
    fi

    echo $valid;
}


function createColumns(){
    read -p "Enter number of columns: " numCols;
     
    for (( i=0; i<$numCols; i++ ))
    do
        colMetadata="";
        read -p "Enter column name: " colName;
        # validate column name
        nameFlag=$(validateColumnName "$colName");
        if [[ $nameFlag == 0 ]]; then
            colMetadata="$colName";
            # select column datatype (string, number)
            read -p "Choose column's datatype String(s) Number(n): (s/n)" colDataType;
            if [[ $colDataType == "s" || $colDataType == "S" ]]; then
                colMetadata="$colMetadata:string";
            elif [[ $colDataType == "n" || $colDataType == "N" ]]; then
                colMetadata="$colMetadata:number";
            fi
            # Is it Primary-Key (PK): (y/n):
            read -p "Is it Primary-Key (PK): (y/n)" pk;
            if [[ $pk == "y" || $pk == "Y" ]]; then
                colMetadata="$colMetadata:yes";
            elif [[ $pk == "n" || $pk == "N" ]]; then
                colMetadata="$colMetadata:no";
            fi

            # create row containing column-info in table.metadata (colName:dataType:PK)
            echo $colMetadata >> "Databases/$currDB/Metadata/$tableName.metadata";
            
        else
            echo "In-valid column name";
        fi
    done
}

read -p "Enter table name: " tableName;

nameFlag=$(validateTableName "$tableName");
tableExistsFlag=$(tableExists "$currDB" "$tableName");


if [ $nameFlag == 0 ] && [ $tableExistsFlag == 0 ]; then
    # create Data/tableName
    if touch "Databases/$currDB/Data/$tableName" 2> log.out; then
        echo "Empty table created sucessfully." >> log.out;
        # create Metadata/tableName.metadata
        if touch "Databases/$currDB/Metadata/$tableName.metadata" 2> log.out; then
            echo "Metadata file created sucessfully." >> log.out;
        else
            echo "Falied to create metadata. Check log.out for more details.";
        fi

        if createColumns; then
            echo "Table $tableName created sucessfully.";
            cat "Databases/$currDB/Metadata/$tableName.metadata";
        else
            echo "ERROR: Failed to create $tableName."
        fi
    else
        echo "Falied to create table. Check log.out for more details.";
    fi

else
    echo "Can not create table. Check log.out for more details.";
fi