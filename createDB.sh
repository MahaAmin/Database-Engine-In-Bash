#!/bin/bash

# TO-HANDLE: User enter multiple names or name with spaces
# TO-DO: when creating db create 2 sub-directories (Data, Metadata)

echo "Enter Database Name: ";
read newDB;
if mkdir Databases/$newDB 2>> log.out; then
    mkdir Databases/$newDB/Data;
    mkdir Databases/$newDB/Metadata;
    printf "$newDB created succesfully.\n";
else
    printf "Can not create $newDB. Check log.out for more details.\n";
fi
