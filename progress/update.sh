#!/bin/bash

# update loc or stat values 

stats=('pocket' 'bank' 'armor' 'health' 'constitution' 'loc')

function update {
	# you must supply a stat to modify
	if [ $# -lt 1 ]
	then
		echo 'You must supply the stat to be updated and its new value.'
		exit 0
	fi
	# must supply a new value
	if [ $# -lt 2 ]
	then
		echo 'You must supply the new value to update.'
		exit 0
	fi
	# a temp to rebuild, later rename as stats
	touch progress/temp.txt
	# making sure given stat to change makes sense
	if [[ "${stats[@]}" =~ "$1" ]]
	then
		# for every stat..
		for i in "${stats[@]}" 
		do 
			# if no stats.txt yet, just skip to adding this attribute to it
			if [ ! -f "progress/stats.txt" ]
			then
				echo 'Stats was empty'
				break
			fi
			# if this stat is not to be updated, append its current state
			if [ ! $1 == $i ]
			then
				cat progress/stats.txt | grep -A 1 $i >> progress/temp.txt
			fi
		done
		# rebuild updated stat
		echo "-$1" >> progress/temp.txt
		echo "*$2" >> progress/temp.txt		
		# replace old stats
		if [ -f "progress/stats.txt" ]
		then
			rm progress/stats.txt
		fi
		mv progress/temp.txt progress/stats.txt
	else
		echo 'Supply a valid stat to update.'
	fi
}

# update loc in loc.txt file according to new coords
# input: (array) new coords
function updateLoc {
	# catch wrong num args
	if [ $# -lt 2 ]
	then
		echo 'You must supply an array of 2 coords to which to update.'
		exit 0
	fi
	# recieve coords
	newCoords=( "$@" )
	# erase cur coords
	rm progress/loc.txt
	touch progress/loc.txt
	for i in "${newCoords[@]}"
	do
		echo $i >> progress/loc.txt
	done		
}

if [ $1 == 'loc' ]
then
	update 'loc' "world/locations/$2.txt"
	exit 0	 
else
	update $1 $2
fi

