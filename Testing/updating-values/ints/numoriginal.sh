#!/bin/bash

if [ "$#" -lt 1 ]
then
	echo 'Supply a number to increment.'
	exit 0
fi
original=$1

echo "true original value: $original"

# just use $() to evaluate function/pass to update 
updatetemp=$(./numupdate.sh "$original")
# reassign to original, or just echo new value back
original=$updatetemp

echo "original after update: $original"

