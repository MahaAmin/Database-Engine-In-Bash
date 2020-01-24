#!/bin/bash

mainMenu() {
	zenity --list \
	--title="ITI-DB-BASH" \
	--width=500 \
	--height=300 \
	--text="Main Menu" \
	--column="Choose Option" \
	"Show Databases" \
	"Create New Database" \
	"Use Database" \
	"Delete Database"
}


main(){
	option=$(mainMenu)
	#echo "You selected $option"
	case $option in
		"Show Databases")
			echo "run showDatabases.sh";;
		"Create New Database")
			echo "run createDB.sh";;
		"Use Database")
			echo "run useDB.sh";;
		"Delete Database")
			echo "run deleteDB.sh";;
	esac
}

main

exit


