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
			./showDB.sh;;
		"Create New Database")
			./createDB.sh ;;
		"Use Database")
			./useDB.sh;;
		"Delete Database")
			./deleteDB.sh;;
	esac
}

main

exit


