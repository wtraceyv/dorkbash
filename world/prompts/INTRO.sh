#!/bin/bash
# intro sequence only at startup

feelings=("happy" "sad" "mad")
negResponse=("no" "nope" "fuck no" "hell no" "nah" "n")

echo "Let's talk just a moments."
echo 'How do you feel?'
echo 'I best understand these feelings: '

# loop through array elements
for i in "${feelings[@]}"
do
	echo "-- $i"
done

# take in user input and save into variable
read feeling

# call functions from other files within script
world/prompts/./intro-moodreaction.sh $feeling

echo "You're sure you feel this way?"

read affirm

echo 'Interesting.. well, would you like to play a game?'

read affirm

if [[ "${negResponse[@]}" =~ "${affirm}" ]]
then
	echo "Mm .. sorry to see you go."
	echo 'Goodbye'
	exit 0
fi

echo "Wonderful!"
echo "This must be felt in the 'theater of the mind', you understand."
echo 'I will present your story, the setting. Just act accordingly, I suppose.'
echo ''
echo 'Alright then..'
