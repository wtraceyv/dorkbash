#!/bin/bash

# save given
given=$1

# reassign given some way, 
# use $(()) for arithmetic vals
# refer to original as $given, but reassign to just "given"
given=$(($given + 5))

# only functions return, but we can echo to return from .sh
echo $given


