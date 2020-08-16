#!/bin/bash
# handle status checks by player
# input:	$1 [status to check]
#		$2 [array of player's stats from main]

# - - - - - - 	Functions - - - - - - - - - #

# input: current money from main
function money {

}

# input: current health from main
function health {

}

# input: inventory from main (array)
function inventory {

}

# input: money, health, armor array
function all {

}

# - - - - - -	Funnel input - - - - - - - - #

if [ $# -lt 2 ]
then
	echo 'You must supply something to check status for.'
	echo '-- money'
	echo '-- health'
	echo '-- inventory'
	echo '-- all'
elif [ $2 == 'money' ]
then
	echo 'Money checked.'
elif [ $2 == 'health' ]
then
	echo 'Health checked.'
elif [ $2 == 'inventory' ]
then
	echo 'Inventory returned.'
else
	echo 'All status checks made.'
fi
