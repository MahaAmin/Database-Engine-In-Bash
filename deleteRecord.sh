#!/bin/bash

# TO-DO: Steps of deleting a record:
#   1- Read column name from user
#   2- Validate column name (column name exists in Metadata)
#   3- Read value to be deleted
#   4- Delete record(s) containing value from Data/$tableName


echo "DB:$currDB, table:$tableName" 

# read column name from user
read -p "Enter column name: " colName;


# get column names from Metadata/$tableName
colNames=($(awk -F: '{print $1}' Databases/$currDB/Metadata/$tableName.metadata))


# validate column name
colFlag=1  #false

for i in "${!colNames[@]}"
do 
    if [[ $colName == "${colNames[$i]}" ]]; then
        colFlag=0   #true
        colNum=$(($i+1));  #column-Number
    fi   
done

if [[ $colFlag == 0 ]]; then
    # valid column-name

    # read value to delete column with
    read -p "Enter value to delete record with: " value;

    # delete lines containing value in ith column
    echo "colNum = $colNum"

    # array of records to be deleted
    recordNum=($(awk -v varCol="$colNum" -v varValue="$value" -F: '{if ($varCol == varValue) {print FNR}}' "Databases/$currDB/Data/$tableName"))

    counter=0

    for i in "${!recordNum[@]}"
    do
        index=${recordNum[$i]}
        index=$(($index-$counter))
        echo "index:$index"
        sed -i "$index"d Databases/$currDB/Data/$tableName

        counter=$(($counter+1))
    done
    echo $recordNum
else
    echo "In-valid column name";
fi



