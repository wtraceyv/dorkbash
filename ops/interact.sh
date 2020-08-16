#!/bin/bash
# handle interactions with objects 
# input		$1 [ACTION on object]
#		$2 [OBJECT to interact with]

# - - - - - - 	Functions - - - - - - - - - #

# input		item to add
function take {
	echo '-item' >> progress/inventory.txt
	echo "*$1" >> progress/inventory.txt
	# update the location with this info
	world/ops/takeLocItem.sh $1
}

# input         item to drop
function drop {
	item=$1
	inventoryFile="progress/inventory.txt"
	# temp for rebuild
	touch progress/temp.txt
	# add in all items besides that to be dropped
	for i in $( cat $inventoryFile | grep -A 1 'item' | grep '*' | cut -c 2- | grep -v $item )
	do 
		echo '-item' >> progress/temp.txt
		echo "*$i" >> progress/temp.txt
	done
	# clean up/replace original
	rm $inventoryFile
	mv progress/temp.txt $inventoryFile
	# update location with this info
	world/ops/dropLocItem.sh $item
}

# show whole inventory
function show {
	list=$( cat progress/inventory.txt | grep -A 1 'item' | grep '*' | cut -c 2- )
	if [ -z "$list" ]
	then
		echo "You haven't got anything!"
		exit 0
	fi
	echo 'Inventory: '
	for i in $( cat progress/inventory.txt | grep -A 1 'item' | grep '*' | cut -c 2- )
	do 
		echo "- $( cat items/$i.txt | grep -A 1 'desc' | grep '*' | cut -c 2- )"
	done
}

function examine {
	echo yo
}

# assuming there's one obvious purpose 
function use {
	echo yo
}

# e.g. turn on/off, put on/off
function changeState {
	echo yo
}

# - - - - - -	Funnel input - - - - - - - - #

action=$1
item=$2

if [ $action == 'take' ] || [ $action == 'grab' ] 
then
	take $item
elif [ $action == 'drop' ]
then
	drop $item
elif [ $action == 'show' ]
then
	show
elif [ $action == 'look' ]
then
	examine $item
fi
