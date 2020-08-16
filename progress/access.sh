#!/bin/bash

# access the save files info 

function getStat {
	cat progress/stats.txt | grep -A 1 "$1" | grep '*' | cut -c 2-	
}

function getLoc {
	cat progress/loc.txt
}

if [ $# -lt 1 ]
then
	echo 'Supply something to access.'
	exit 0
fi
if [ "$1" == 'stat' ]
then
	if [ $# -lt 2 ]
	then
		echo 'Stat function requires stat to retrieve.'
		exit 0
	fi
	getStat $2
elif [ $1 == 'loc' ]
then
	getStat 'loc'	
fi

