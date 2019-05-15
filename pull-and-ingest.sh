#!/usr/bin/env bash

# variables
URL="https://digital.lib.utk.edu/collections/islandora/object/"
GAMBLE_PIDS=(101 102 103 104 105 106 107 108 109 110)
OBJ="/datastream/OBJ/content"
MODS="/datastream/MODS/content"
GAMBLE_TARGET="/tmp/gamble/"

if [[ ! -d "${GAMBLE_TARGET}" ]]; then
    mkdir "${GAMBLE_TARGET}"
elif [[ -d "${GAMBLE_TARGET}" ]]; then
    rm -rf "${GAMBLE_TARGET:?}"*
fi

for E in "${GAMBLE_PIDS[@]}";
    do curl -X GET "${URL}""gamble:""${E}""${OBJ}" --output "${GAMBLE_TARGET}""gamble_""${E}".tif;
    curl -X GET "${URL}""gamble:""${E}""${MODS}" --output "$GAMBLE_TARGET}""gamble_""${E}".xml;
done
