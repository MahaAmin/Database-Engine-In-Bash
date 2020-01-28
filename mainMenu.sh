#!/bin/bash

# TO-DO: re-print menu after selection --> while

options=("Show Databases" "Create New Database" "Use Database" "Delete Database" "Quit")

# an array to store existing databases
declare -a DATABASES;

select option in "${options[@]}"
do
	case $option in
		"Show Databases") . ./showDB.sh;;
		"Create New Database") . ./createDB.sh;;
		"Use Database") . ./useDB.sh;;
		"Delete Database") . ./deleteDB.sh;;
		"Quit") break;;
		*) echo "Invalid option $REPLY";;
	esac
done
