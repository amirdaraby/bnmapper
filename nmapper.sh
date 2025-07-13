#!/bin/bash

DOMAINS="domains"
OUTPUT_DIR="output"
ERROR_DIR="nmap_errors"
ARGS=$@
RUN_DIR=$OUTPUT_DIR

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[36m'

if [ $# -ne 0 ]; then
    echo -e "${CYAN}global arguments: $ARGS"
fi

if ! command -v nmap >/dev/null 2>&1; then
    echo "${RED}Error: 'nmap' is not installed or not in PATH."
    exit 1
fi

if [[ ! -f "$DOMAINS" ]]; then
    echo "${RED}please make 'domains' file"
    exit 1
fi


while IFS= read -r domain || [[ -n "$domain" ]]; do
    [[ -z "$domain" ]] && continue
    
    echo -e "${CYAN}nmapping '$domain'"

    dirname=$(echo "$domain" | tr '/ ' '_' | tr -cd '[:alnum:]_.-')
    timestamp=$(date +"%Y-%m-%d_%H-%M-%S")
    rundir="$OUTPUT_DIR/$dirname/$timestamp"
    mkdir -p $rundir
    
    errorsfile="$rundir/errors"
    nmap "$domain" "$@" >"$rundir/results" 2> >(tee "$errorsfile" >&2)
    exit_status=$?

    if [ $exit_status -ne 0 ]; then
        echo -e "${YELLOW}There might be some issues with $domain, please check $errorsfile"
        echo -e "${YELLOW}$domain nmap completed!"
    else
      rm -f $errorsfile
      echo -e "${GREEN}$domain nmap completed!"  
    fi
done < "$DOMAINS"