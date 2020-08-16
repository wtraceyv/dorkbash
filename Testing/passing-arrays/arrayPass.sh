#!/bin/bash

function printArr {
	local arr=("$@")
	for i in "${arr[@]}"
	do
		echo "$i"
	done
}

arg1=$1
arg2=$2
shift 2
test=( "$@" )
printArr "${test[@]}"
echo "param1 was $arg1"
echo "param2 was $arg2"
