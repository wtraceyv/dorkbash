#!/bin/bash

# locFile must be full path (world/locations/AREA/place.txt)

# supply item to remove
item=$1
locFile=$( progress/access.sh loc )

echo '-item' >> $locFile
echo "*$item" >> $locFile
