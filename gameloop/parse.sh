#!/bin/bash 

# hold words to mean various actions, 
# send to funnel.sh to be executed properly (with extra args)

if [ "$#" -lt 1 ]
then
	echo 'Supply a command to parse.'
	gameloop/main.sh
fi

# save full command as an array
fullCommand=( "$@" )

# print full command for debug 
# echo 'Full command: '
# for i in "${fullCommand[@]}"
# do 
#	echo ">$i"
#done 

# save just first command word to parse
# --> remember to send out full command @ end
targetCommand="${fullCommand[0]}"
#echo "Chunk trying to parse: $targetCommand"

# to parse, this file must given one word! if command is multiple words, 
# its details will have to be parsed again later (obj interaction, etc.)

# lists of common words - - - - - - - - - - - - #
# general game help/mechanics
exitWords=("exit" "bye" "goodbye" "done")
helpWords=("help" "h")
saveWords=("save" "write")

# peaceful actions
moveWords=("go" "move" "walk" "run" "n" "e" "s" "w")
lookWords=("look" "l")
checkWords=("show" "check" "money" "inventory" "armor" "bank")
interactWords=("take" "grab")
dropWords=("drop")

# mid-fight actions
attackWords=("hit" "attack" "destroy" "injure" "strike" "kill")
shieldWords=("block" "shield")
dodgeWords=("dodge" "avoid")

# responses to peaceful speech
negResponse=("no" "nope" "fuck" "hell" "nah")
posResponse=("yes" "y" "yeah" "yah" "yeh" "yea")
confusedResponse=("idk" "what" "huh" "excuse" "why" "how")


# send out parsed COMMANDS to the funnel - - - - - - - - - - - - #
for i in "${exitWords[@]}"
do
	if [ $targetCommand == $i ]
	then
		echo 'Exit word detected!'
		exit 0
	fi
done 


for i in "${helpWords[@]}"
do
	if [ $targetCommand == $i ]
	then
		#echo 'Help word detected!'
		cat "util/help.txt" | fold -s 
		exit 0
	fi
done 


for i in "${moveWords[@]}"
do
	if [ $targetCommand == $i ]
	then
		#echo 'Move word detected!'
		ops/move.sh "${fullCommand[@]}"
		gameloop/main.sh
	fi
done 

for i in "${lookWords[@]}"
do
	if [ $targetCommand == $i ]
	then
		# echo 'Look word detected!'
		if [ $# -gt 1 ]
		then
			ops/interact.sh "${fullCommand[@]}"
		else
			world/ops/look.sh
		fi
	exit 0
	fi
done 

for i in "${checkWords[@]}"
do
	if [ $targetCommand == $i ]
	then
		# echo 'Check word detected!'
		ops/status-check.sh "${fullCommand[@]}"	
		exit 0
	fi
done 

for i in "${interactWords[@]}"
do
	if [ $targetCommand == $i ]
	then
		# echo 'Interact word detected!'
		ops/interact.sh "${fullCommand[@]}"
		exit 0
	fi
done 

for i in "${dropWords[@]}"
do
	if [ $targetCommand == $i ]
	then
		# echo 'Drop word detected!'
		ops/interact.sh "${fullCommand[@]}"
		exit 0
	fi
done 

for i in "${attackWords[@]}"
do
	if [ $targetCommand == $i ]
	then
		echo 'Attack word detected!'
		exit 0
	fi
done 

for i in "${shieldWords[@]}"
do
	if [ $targetCommand == $i ]
	then
		echo 'Shield word detected!'
		exit 0
	fi
done 

for i in "${dodgeWords[@]}"
do
	if [ $targetCommand == $i ]
	then
		echo 'Dodge word detected!'
		exit 0
	fi
done 

for i in "${negResponse[@]}"
do
	if [ $targetCommand == $i ]
	then
		echo 'Negative Response detected!'
		exit 0
	fi
done 

for i in "${posResponse[@]}"
do
	if [ $targetCommand == $i ]
	then
		echo 'Positive Response detected!'
		exit 0
	fi
done 

for i in "${confusedResponse[@]}"
do
	if [ $targetCommand == $i ]
	then
		echo 'Confused Response detected!'
		exit 0
	fi
done 


# can't find anything to match 
echo 'Where are you trying to go with this?'
exit 0
