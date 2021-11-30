#!/bin/bash

# main gameplay loop 

# Live in a while loop that checks for keywords
# then funnels commands out appropriately

exitWords=("exit" "bye" "goodbye" "done")

# play one-time intro
# world/prompts/INTRO.sh

# main gameplay loop goes here
input='a'
while true
do
	# check if trying to quit, if yes break to outer loop
	for i in "${exitWords[@]}"
	do  
		if [[ $input = *" "* ]]
		then
			break
		elif [ $input == $i ]
		then
			break 2
		fi
	done

	# display short name of current place
	echo '- - - - - - - - -'
	cat $( progress/access.sh loc ) | grep -A 1 'short' | grep '*' | cut -c 2-
	# give input prompt
	read -p '>' input
	#echo "You said: $input" 
	
	# parse input for an action
	gameloop/./parse.sh $input	
done

echo 'Goodbye!'
