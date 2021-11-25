#!/bin/bash
# handle status checks by player
# input:	$1 [status to check]
#		$2 [array of player's stats from main]

# - - - - - - 	Functions - - - - - - - - - #

# input: current money from main
function money {
	echo "*checks monies*"
	ops/interact.sh show money
}

# input: current health from main
function health {
	echo "*does health check*"
	ops/interact.sh show health
}

# input: inventory from main (array)
function inventory {
	ops/interact.sh show
}

# input: money, health, armor array
function all {
	ops/interact.sh show
	echo "*also checks money, health, armor*"
}

# - - - - - -	Funnel input - - - - - - - - #

if [ $# -lt 2 ]
then
	all
elif [ $2 == 'money' ]
then
	money
elif [ $2 == 'health' ]
then
	health	
fi
