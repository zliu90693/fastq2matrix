#!/bin/bash

# Depends on conda environment: fastq2matrix (see .env/fastq2matrix.yml)

set -euo pipefail

########################################
# Parameters
########################################

project_name=""

while getopts "p:" opt; do
    case $opt in
        p) project_name=$OPTARG ;;
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

# check env
if ! R -e "library(hdf5r)" >/dev/null 2>&1; then
    echo "Error: R with hdf5r package not found."
    echo "Activate the fastq2matrix conda environment first."
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

for dir in "./${project_name}/cellbender-out/"*; do
    GSM=$(basename $dir)
    mkdir -p "./${project_name}/singlet-out/${GSM}"
    log "Removing doublets for ${GSM}"
    input_h5="./${project_name}/cellbender-out/${GSM}/${GSM}_filtered.h5"
    output_h5="./${project_name}/singlet-out/${GSM}/${GSM}_singlet.h5"
    Rscript --vanilla run_scDblFinder.R $input_h5 $output_h5
    log "${GSM} processing completed"
done