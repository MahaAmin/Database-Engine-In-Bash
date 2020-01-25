#!/bin/bash

echo "Enter database name: "
read currDB;

# check if database exists
if [[ -d Databases/$currDB ]]
then
    echo "Database exists";
else
    echo "Database does not exist";
fi