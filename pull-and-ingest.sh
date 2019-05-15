#!/usr/bin/env bash

# variables
URL="https://digital.lib.utk.edu/collections/islandora/object/"
GAMBLE_PIDS=(101 102 103 104 105 106 107 108 109 110)
OBJ="/datastream/OBJ/content"
MODS="/datastream/MODS/content"


for E in "${GAMBLE_PIDS[@]}";
    do curl -X GET "${URL}""gamble:""${E}""${OBJ}";
done
