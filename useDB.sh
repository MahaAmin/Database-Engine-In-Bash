#!/bin/bash

useDB_main_menu(){
    options=("Show Tables" "Create New Table" "Delete Table" "Update Table" "Display Table" "Return To Main Menu");

    select option in "${options[@]}"
    do
        case $option in
            "Show Tables") . ./showTables.sh;;
            "Create New Table") . ./createTable.sh;;
            "Delete Table") . ./deleteTable.sh;;
            "Update Table") . ./updateTable.sh;;
            "Display Table") . ./displayTable.sh;;
            "Return To Main Menu") break;;
            *) echo "Invalid option $REPLY";;
        esac
    done
}

echo "Enter database name: "
read currDB;

# check if database exists
if [[ -d Databases/$currDB ]]
then
    export  currDB=Databases/$currDB;
    echo "$currDB is selected.";
    useDB_main_menu;
else
    echo "Database does not exist.";
fi
