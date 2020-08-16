#!/bin/bash

# main gameplay loop 

# Live in a while loop that checks for keywords
# then funnels commands out appropriately

exitWords=("exit" "bye" "goodbye" "done")

# play one-time intro
# world/prompts/INTRO.sh

input='a'

# main gameplay loop goes here
while ! [[ "${exitWords[@]}" =~ "${input}" ]]
do
	# display short name of current place
	echo '- - - - - - - - -'
	cat $( progress/access.sh loc ) | grep -A 1 'short' | grep '*' | cut -c 2-
	# give input prompt
	read -p '>' input
	# echo "You said: $input" # so far confirmed, this does separate okay in parser
	
	# parse input for an action
	gameloop/./parse.sh $input	
done

echo 'Goodbye!'
