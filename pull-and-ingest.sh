#!/usr/bin/env bash

# variables
URL="https://digital.lib.utk.edu/collections/islandora/object/"
GAMBLE_PIDS=(101 102 103 104 105 106 107 108 109 110)
# ASCOOP_PIDS are not sequential but the array will be read in order
# book, page 1, page 2, etc, etc
ASCOOP_PIDS=(1507160130 1507160136 1507160134 1507160131 1507160132 1507160135 1507160133)
OBJ="/datastream/OBJ/content"
MODS="/datastream/MODS/content"
HOCR="/datastreams/HOCR/content"
OCR="/datastreams/OCR/content"

GAMBLE_TARGET="/tmp/gamble/"
ASCOOP_TARGET="/tmp/ascoop/issue1/"

# check for temporary gamble ingest directory
if [[ ! -d "${GAMBLE_TARGET}" ]]; then
    mkdir "${GAMBLE_TARGET}"
elif [[ -d "${GAMBLE_TARGET}" ]]; then
    rm -rf "${GAMBLE_TARGET:?}"*
fi

# check for temporary ascoop ingest directory
if [[ ! -d "${ASCOOP_TARGET}" ]]; then
    mkdir -p "${ASCOOP_TARGET}"
elif [[ -d "${ASCOOP_TARGET}" ]]; then
    rm -rf "${ASCOOP_TARGET:?}"*
fi

for E in "${GAMBLE_PIDS[@]}"; do
    curl -s -X GET "${URL}""gamble:""${E}""${OBJ}" --output "${GAMBLE_TARGET}""gamble_""${E}".tif;
    curl -s -X GET "${URL}""gamble:""${E}""${MODS}" --output "${GAMBLE_TARGET}""gamble_""${E}".xml;
done

# neanderthal approach to our sample book object
# the first item in the array is our book, everything else is a sequential page
# in other words, this is *not* a generic solution for any book
# TODO try to make this generic
# get our book-level MODS
curl -s -X GET "${URL}""ascoop:""${ASCOOP_PIDS[0]}""${MODS}" --output "${ASCOOP_TARGET}"MODS.xml;

# get the rest of our other DSIDs
for I in "${!ASCOOP_PIDS[@]}"; do
    if [ "$I" = "0" ]; then
        echo "Index 0 - skipping"
    elif [ "$I" != "0" ]; then
        echo "doing stuff"
        mkdir "${ASCOOP_TARGET}""$I"
        curl -s -X GET "${URL}""ascoop:""${ASCOOP_PIDS[$I]}""${OBJ}" --output "${ASCOOP_TARGET}""$I""/OBJ.tif"
        curl -s -X GET "${URL}""ascoop:""${ASCOOP_PIDS[$I]}""${MODS}" --output "${ASCOOP_TARGET}""$I""/MODS.xml"
        curl -s -X GET "${URL}""ascoop:""${ASCOOP_PIDS[$I]}""${HOCR}" --output "${ASCOOP_TARGET}""$I""/HOCR.html"
        curl -s -X GET "${URL}""ascoop:""${ASCOOP_PIDS[$I]}""${OCR}" --output "${ASCOOP_TARGET}""$I""/OCR.txt"
    fi
done