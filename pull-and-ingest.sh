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
    mkdir "${ASCOOP_TARGET}"
elif [[ -d "${ASCOOP_TARGET}" ]]; then
    rm -rf "${ASCOOP_TARGET:?}"*
fi

for E in "${GAMBLE_PIDS[@]}"; do
    curl -s -X GET "${URL}""gamble:""${E}""${OBJ}" --output "${GAMBLE_TARGET}""gamble_""${E}".tif;
    curl -s -X GET "${URL}""gamble:""${E}""${MODS}" --output "${GAMBLE_TARGET}""gamble_""${E}".xml;
done
