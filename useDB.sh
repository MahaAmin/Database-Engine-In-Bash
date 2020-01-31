#!/bin/bash

useDB_main_menu(){
    options=("Show Tables" "Create New Table" "Delete Table" "Update Table" "Display Table" "Return To Main Menu");
     while [[ "$option" != "Return To Main Menu" ]] 
    do
    select option in "${options[@]}"
    do
        case $option in
            "Show Tables") . ./showTables.sh;break;;
            "Create New Table") . ./createTable.sh;break;;
            "Delete Table") . ./deleteTable.sh;break;;
            "Update Table") . ./updateTable.sh;break;;
            "Display Table") . ./displayTable.sh;break;;
            "Return To Main Menu") . ./mainMenu.sh;break;;
            *) echo "Invalid option $REPLY";;
        esac
    done
    done
}

echo "Enter database name: "
read currDB;

# check if database exists
if [[ -d Databases/$currDB ]]
then
    export  currDB=$currDB;
    echo "$currDB is selected.";
    useDB_main_menu;
else
    echo "Database does not exist.";
fi
