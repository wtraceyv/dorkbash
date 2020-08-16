#!/bin/bash

function printArr {
	local arr=("$@")
	for i in "${arr[@]}"
	do
		echo "-- $i"
	done
}

interm=( "$@" )
printArr "${interm[@]}"
