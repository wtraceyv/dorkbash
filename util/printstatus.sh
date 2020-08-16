#!/bin/bash

echo 'Essential status:'
interm=( "$@" )
echo "-- Health: ${interm[0]}"
echo "-- Armor: ${interm[1]}"
echo "-- Pocket Money: ${interm[2]}"
