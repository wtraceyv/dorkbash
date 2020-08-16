#!/bin/bash

param1=300
param2=75
original=("hello" "you" "got" "it" "sonny")

./arrayPass.sh "$param1" "$param2" "${original[@]}"
