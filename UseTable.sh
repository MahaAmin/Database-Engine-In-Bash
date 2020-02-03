#!/bin/bash
Use_Table(){
options=("displayTable" "Select By PK" "Return To Main Menu");
while [[ "$option" != "Return To Main Menu" ]]
do
select option in "${options[@]}" 
do 
       case $option in 
       "displayTable") . ./displayTable.sh; break ;;
       "Select By PK") . ./SelectPK.sh; break;;
       "Return To Main Menu") . ./mainMenu.sh; exit $? ;;
        *) echo "Invalid option $REPLY";;

         esac
    done
    done
}

Use_Table;
