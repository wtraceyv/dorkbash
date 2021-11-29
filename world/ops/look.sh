#!/bin/bash

# look at current location -- we shouldn't be able to look elsewhere until we're there
curLoc=$( progress/access.sh loc )

cat $curLoc | grep -A 1 'desc' | grep '*' | cut -c 2- | fold -s -w 55
echo 

# copy loc file so I can read each item in a row
grep -q 'item' $curLoc
if [ $? -eq 1 ]
then
	# there is no item to read
	exit 0
else
	for i in $( cat $curLoc | grep -A 1 'item' | grep '*' | cut -c 2- )
	do 
		echo "There is $( cat items/$i.txt | grep -A 1 'desc' | grep '*' | cut -c 2- ) here."
	done
fi
