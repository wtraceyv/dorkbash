#!/bin/bash
	
# must supply locFile full path (world/locations/AREA/place.txt)

# supply the loc and item to remove
locFile=$( progress/access.sh loc )
item=$1

# temp for rebuild
touch temp.txt

# put parameters besides items to check..
# also be sure to save desc and other items
directions=('north' 'east' 'south' 'west')

# rebuild desc/short
cat $locFile | grep -A 1 'desc' >> temp.txt
cat $locFile | grep -A 1 'short' >> temp.txt
# rebuild any directions
for i in "${directions[@]}"
do
	# do direction test
	grep -q $i $locFile
	# if direction present, append that info
	if [ $? -eq 0 ]
	then
		cat $locFile | grep -A 1 '&' | grep -A 1 $i >> temp.txt
	fi
done
# rebuild all items not taken
for i in $( cat $locFile | grep -A 1 'item' | grep '*' | cut -c 2- | grep -v $item )
do
	echo '-item' >> temp.txt
	echo "*$i" >> temp.txt
done

# clean up/replace original 
rm $locFile
mv temp.txt $locFile
