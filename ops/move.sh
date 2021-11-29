#!/bin/bash
# handle move-related actions
# input:	$1 [check or move]
#		$2 [movement word OR direction to move]
#		$3 [path to current loc file from locations folder]

# - - - - - - - Functions - - - - - - - - - - #

# check whether player is trying to move (sort of deprecated by gameloop parser)
# params: string (original command word, first player arg)
# output: bool
# keywords: go, move, walk, run
function check {
	validMoveWords=("go" "move" "walk" "run")
	for i in "${validMoveWords[@]}"
	do
		if [ $1 == $i ]
		then
			echo 'valid move in command!'
			return 0
		fi
	done
	echo 'no valid move word detected'
	return 1
}

# grab the relative (locations) path to the location info
# which the given cardinal dir points to from the current loc
function getLocForDir {
	# desired dir
	dir=$1
	# full path to the 'TO' loc 
	toPath=$( cat $( progress/access.sh loc ) | grep -A 1 "&$dir" | grep '*' | cut -c 2- )
	# failure or success
	if [ -z "$toPath" ]
	then
		# no good direction 
		echo 1
	else
		# good direction option
		echo $toPath
	fi
}

# parse given directions for move function, do the loc calculation
# return the changed loc coordinates according to parsed direction
# input: 	$1 dir word
#		$2+ loc
# return:	new loc
function parseDir {	
	targetDir=$1
	curFilePathMinimal=$2
	
	# still could be considerably smaller 
	# --> probably another direction word list, loop through just one of these 'if' structures
	if [ $targetDir == "north" ] || [ $targetDir == "n" ]
	then
		dirTest=$( getLocForDir 'n' )
		if [ ! $dirTest == '1' ]
		then
			progress/update.sh loc $dirTest
			return
		fi
	elif [ $targetDir == "east" ] || [ $targetDir == "e" ]
	then
		dirTest=$( getLocForDir 'e' )
		if [ ! $dirTest == '1' ]
		then
			progress/update.sh loc $dirTest
			return
		fi
	elif [ $targetDir == "south" ] || [ $targetDir == "s" ]
	then
		dirTest=$( getLocForDir 's' )
		if [ ! $dirTest == '1' ]
		then
			progress/update.sh loc $dirTest
			return
		fi
	elif [ $targetDir == "west" ] || [ $targetDir == "w" ]
	then
		dirTest=$( getLocForDir 'west' )
		if [ ! $dirTest == '1' ]
		then
			progress/update.sh loc $dirTest
			return
		fi
	fi
	# reached bottom, no good location in this dir
	echo "Can't see a clear way in that direction.."
}

# take in player's loc, modify accordingly
# params: string cardinal dir (n,s,e,w,etc)
# {passes minimal path within locations to parseDir}
function move {
	# includes 'world/locations/...':
	fullCurPath=$( progress/access.sh loc )
	wantDir=$1
	# path with world/locations and .txt extension removed:
	path=$( echo $fullCurPath | cut -d '/' -f 3- | cut -d '.' -f 1 )
	parseDir $wantDir $path
}

# - - - - - funnel file usage, execute appropriate functions - - - - #
fullCommand=( "$@" )

# the command is an implicit move (one arg -> desired dir)
implicitDirs=("n" "north" "e" "east" "s" "south" "w" "west")
if [ $# -eq 1 ] && [[ "${implicitDirs[@]}" =~ $1 ]]
then
	move $1
# the command is not an implicit move, does not have enough args for explicit
elif [ $# -lt 2 ]
then
	echo 'You must supply a check or move command, then appropriate args.'
# the command wants to check a move word
elif [ $1 == 'check' ]
then
	check $2
# the command want to execute an explicit move (supplies move word)
else
	wantDir=$2
	move "$wantDir"
fi
