#!/bin/bash


function updateTable_main_menu(){
    options=("Add New Column" "Delete Column" "Update Cell Value" "Delete Record" "Return To Main Menu");
        while [[ "$option" != "Return To Main Menu" ]] 
    do
    select option in "${options[@]}"
    do
        case $option in
            "Add New Column") . ./addNewColumn.sh;break ;;
            "Delete Column") . ./deleteColumn.sh; break;;
            "Update Cell Value") . ./updateCell.sh; break;;
            "Delete Record") . ./deleteRecord.sh; break ;;
            "Return To Main Menu") ./mainMenu.sh; break ;;
            *) echo "Invalid option $REPLY";;
        esac
    done
    done
}



read -p "Enter Table Name: " tableName;

# check if table exists
if [[ -f Databases/$currDB/Data/$tableName ]]
then
    export  tableName=$tableName;
    echo "$tableName is selected.";
    updateTable_main_menu;
else
    echo "Table does not exist.";
    
fi
