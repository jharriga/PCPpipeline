#!/bin/bash

# Short little script to query a PCP Archive for metadata
# 'host' name, 'start' & 'stop' timestamps

# Parse arg1 for archive name
# Check for proper number of args
if [ "$#" -ne 1 ]; then
    echo "One argument required, PCP Archive name"
    exit 2
else
    archive_name="${1}"
fi

# Verify archive exists by checking for the 'index' file
archive_index="${archive_name}.index"
if [ ! -f "${archive_index}" ]; then
    echo "PCP Archive $archive_index not found!"; echo
    exit 2
fi

#archive_loc="$PWD/${archive_name}"
pmdumplog -a "${archive_name}" | grep -E 'from host|commencing|ending'

