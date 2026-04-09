#!/bin/bash

# Depends on conda environment: cellbender (see .env/cellbender.yml)

set -euo pipefail

########################################
# Parameters
########################################

project_name=""
cpu_threads=20

while getopts "p:c:" opt; do
    case $opt in
        p) project_name=$OPTARG ;;
        c) cpu_threads=$OPTARG ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            exit 1
            ;;
        :)
            echo "Error: Option -$OPTARG requires a parameter value." >&2
            exit 1
            ;;
    esac
done

# parameter valid?
if [ -z "$project_name" ]; then
    echo "Error: The project name must be specified using -p."
    exit 1
fi

if ! [[ "$cpu_threads" =~ ^[0-9]+$ ]]; then
    echo "Error: -c must be a positive integer."
    exit 1
fi

# check env
if ! command -v cellbender >/dev/null 2>&1; then
    echo "Error: cellbender command not found."
    echo "Activate the cellbender conda environment first."
    exit 1
fi

########################################
# Functions
########################################

log() {
    echo
    echo "==================== $1 ===================="
    echo
}

########################################
# Pipeline Begin
########################################

mkdir -p "./${project_name}/cellbender-out"

for dir in ./${project_name}/fastq/*; do
    GSM=$(basename "$dir")
    mkdir -p "./${project_name}/cellbender-out/${GSM}"
    log "start processing ${GSM}"
    cellbender remove-background --cpu-threads "$cpu_threads" \
        --input "./${project_name}/cellranger-count-out/${GSM}/outs/raw_feature_bc_matrix.h5" \
        --output "./${project_name}/cellbender-out/${GSM}/GSM5590453.h5"
    log "${GSM} processing completed"
done