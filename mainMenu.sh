#!/bin/bash

options=("Show Databases" "Create New Database" "Use Database" "Delete Database" "Quit")

select option in "${options[@]}"
do
	case $option in
		"Show Databases") echo "Show Databases";;
		"Create New Database") echo "Create New Database";;
		"Use Database") echo "Use Database";;
		"Delete Database") echo "Delete Database";;
		"Quit") break;;
		*) echo "Invalid option $REPLY";;
	esac
done
