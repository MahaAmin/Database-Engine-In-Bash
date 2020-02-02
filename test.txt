#! /bin/bash

#------------------------ input as array -----------------------------------
read x;

IFS=' ' read -r -a input <<< "$x";

echo "${input[0]}";

# to iterate over elements

for element in "${input[@]}"
do 
	echo "$element";
done


# array length

echo "Input length is ${#input[@]}";

#############################################################################

#------------------------ validate string contains at least one letter ----------

x="1234"
y="a1234"

if [[ "$x" =~ [A-Za-z] ]]; then 
	echo "$x has at leaast one alphapet";
else
	echo "$x has no alphapet";
fi

if [[ "$y" =~ [A-Za-z] ]]; then
	echo "$y has at least one alphapet"
fi
#################################################################################

#-----------------validate string does not begin with number --------------------

x="asasa"
short="${x:0:1}"

if [[ "$short" =~ [0-9] ]]; then
	echo "$short starts with number";
fi
#################################################################################

#------------- loop from 0 to N -----------------------------------------------

N=10
for (( i=0; i<$N; i++ ))
do
	echo $i;
done

###################################################################################

#-------------- Read file into array ----------------------------------------------
IFS=$'\n' read -d '' -r -a lines < Databases/maha/Metadata/employee.metadata

echo "Line 0: ${lines[0]}"
echo "Line 1: ${lines[1]}"

#---------------- declare array -------------------------------------------------

declare -a array

array+=("hi")	#adding element to array
array+=("bye")

for element in ${array[@]}
do
	echo $element;
done
#####################################################################################
