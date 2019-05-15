#!/usr/bin/env bash

GAMBLE=(101 102 103 104 105 106 107 108 109 110)


for E in "${GAMBLE[@]}";
    do curl -X GET "https://digital.lib.utk.edu/collections/islandora/object/gamble:""${E}""/datastream/OBJ/content" --output gamble_"${E}".tif;
done
