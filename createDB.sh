#!/bin/bash

# TO-HANDLE: User enter multiple names or name with spaces

echo "Enter Database Name: ";
read newDB;
if mkdir -p Databases/$newDB 2> log.out; then
    printf "$newDB created succesfully.\n";
else
    printf "Can not create $newDB. Check log.out for more details.\n";
fi
