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
	# if asked for specific item
	if [ $# -gt 0 ]
	then
		if [ $1 == 'money' ]
		then
			echo -n "Money: "
			cat progress/stats.txt | grep -A 1 'bank' | grep '*' | cut -c 2-
			exit 0	
		elif [ $1 == 'health' ]
		then
			echo -n "Health: "
			cat progress/stats.txt | grep -A 1 'health' | grep '*' | cut -c 2-
			exit 0
		elif [ $1 == 'armor' ]
		then
			echo -n "Armor: "
			cat progress/stats.txt | grep -A 1 'armor' | grep '*' | cut -c 2-
			exit 0
		fi
	fi
	# check if we have any items
	list=$( cat progress/inventory.txt | grep -A 1 'item' | grep '*' | cut -c 2- )
	if [ -z "$list" ]
	then
		echo "You haven't got any items!"
	else
		# list available items
		echo 'Inventory: '
		for i in $( cat progress/inventory.txt | grep -A 1 'item' | grep '*' | cut -c 2- )
		do 
			echo "- $( cat items/$i.txt | grep -A 1 'desc' | grep '*' | cut -c 2- )"
		done
	fi
	# list other stuff you may have
	echo -n "Armor: "
	cat progress/stats.txt | grep -A 1 'armor' | grep '*' | cut -c 2-
	echo -n "Money: "
	cat progress/stats.txt | grep -A 1 'bank' | grep '*' | cut -c 2-
	echo -n "Health: "
	cat progress/stats.txt | grep -A 1 'health' | grep '*' | cut -c 2-
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
	show $item
elif [ $action == 'look' ]
then
	examine $item
fi
