#! /bin/bash

# TO-DO:
# Steps to Insert new row in table:
# 1- Read table name from user.
# 2- Validate tableName (noSpaces, table-exists)
# 3- For each row:
#   3.1- For each column:
#       3.1.1- Show column name
#       3.1.2- Read new value from user
#       3.1.3- Validate new value:
#           3.1.3.1- check value matches column's datatype
#           3.1.3.2- If column is PK --> value must be unique
#   3.2- append new row (col1:col2:..) in Databases/$currDB/Data/$tableName
# 4- Ask user if he/she wants to insert another row
