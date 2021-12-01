#!/bin/bash
# handle interactions with objects 
# input		$1 [ACTION on object]
#					$2 [OBJECT to interact with]

# - - - - - - 	Functions - - - - - - - - - #

# check that an item actually exists and is available in this space
# input 	string item to check
function checkExistence {
	item=$1
	# is there an item corresponding -> gen temp list of items to regex for
	rm items/item-choices
	cat items/* | grep -A1 desc | grep "*" | awk '{print $(NF)}' > items/item-choices
	if ! grep -qw $item items/item-choices 
	then
		echo "I'm not sure what item you mean.."
		return 1
	fi
	# exists, but is item of this type in the current space
	curLoc=$( progress/access.sh loc )
	if ! grep -qw $item $curLoc
	then
		echo "I don't see one of those in here.."
		return 1
	fi	
	
	# survived checks, good to proceed 
	return 0
}

# input		item to add
function take {
	echo '-item' >> progress/inventory.txt
	echo "*$1" >> progress/inventory.txt
	# update the location with this info
	world/ops/takeLocItem.sh $1
}

# input		item to drop
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

# "look" at an item, receive more specific description
# input		item to examine
function examine {
	itemFilePath=$( ls items | grep $1 )
	cat items/$itemFilePath | grep -A1 'detailed' | grep '*' | cut -d '*' -f 2 | fold -s -w 55
}

# e.g. turn on/off, put on/off
function changeState {
	echo yo
}

# assuming there's one obvious purpose 
function use {
	echo yo
}

# - - - - - -	Funnel input - - - - - - - - #
action=$1

# only interaction w/ no specific item
if [ $action == 'show' ]
then
	show
	exit 0
fi

# for actions that require an item to interact with
if [ $# -lt 2 ]
then
	echo "You must supply an item to interact with"
	exit 0
fi

item=$2

# checkExistence will output an appropriate response,
# but endgame is we're not going to execute the request
checkExistence $item
if [ $? -eq 1 ]
then
	exit 0
fi

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
elif [ $action == 'exists' ]
then
	checkExistence $item
fi
