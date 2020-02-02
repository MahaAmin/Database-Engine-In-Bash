#!/bin/bash

useDB_main_menu(){
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
