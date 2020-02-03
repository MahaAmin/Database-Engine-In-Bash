#!/bin/bash

#Enter table name 
echo "Enter Table Name :"
read TableName 
#validate table exists
if [ -f "Databases/$currDB/Data/$TableName" ] && [ -f  "Databases/$currDB/Metadata/$TableName.metadata" ]; then 
#validate column is PK
echo "Enter PK Column Name"
read ColumnPK
if grep -q $ColumnPK  "Databases/$currDB/Metadata/$TableName.metadata" 
then
Res=$(grep  $ColumnPK  "Databases/$currDB/Metadata/$TableName.metadata"  | awk -F: '{ if($3 == "yes") {print "1"} else {print "0"}}')
ColumnNumMetadata=$(grep -n $ColumnPK  "Databases/$currDB/Metadata/$TableName.metadata" | awk -F: '{print $1}' )
#if PK enter value
if [ $Res == "1" ];
then
echo "Enter PK Value"
read Rpk  
#get column where the word is found
grep  $Rpk Databases/$currDB/Data/$TableName >> aya.temp
ColumnNumData=$(awk -v rk="$Rpk" -F: '{ for (i=0; i<=NF; i++){if ($i==rk){print i}}}' $(pwd)/aya.temp)
rm -f aya.temp
#check if word is found at the same pk column
if [ $ColumnNumMetadata == $ColumnNumData ];  
then  
var1=$(grep -ow $Rpk Databases/$currDB/Data/$TableName)
grep -w $Rpk Databases/$currDB/Data/$TableName  | awk -F: '{print $0}'
else
echo "No such value in PK column" 
fi

#not PK
else 
echo "Not PK"
fi

#column not exist
else 
echo "$ColumnPK does not exist"
fi

#wrong table
else 
echo "No such Table"
fi
