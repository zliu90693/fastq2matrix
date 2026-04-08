#!/bin/bash

# Depends on conda environment: fastq2matrix (see .env/fastq2matrix.xml)

set -euo pipefail

########################################
# Parameters
########################################

project_name=""
localcores=20
transcriptome_name=""
create_bam=false

while getopts "p:l:t:c:" opt; do
    case $opt in
        p) project_name=$OPTARG ;;
        l) localcores=$OPTARG ;;
        t) transcriptome_name=$OPTARG ;;
        c) create_bam=$OPTARG ;;
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

if ! [[ "$localcores" =~ ^[0-9]+$ ]]; then
    echo "Error: -l must be a positive integer."
    exit 1
fi

if [ -z "$transcriptome_name" ]; then
    echo "Error: The transcriptome name must be specified using -t."
    exit 1
fi

if [[ "$create_bam" != "true" && "$create_bam" != "false" ]]; then
    echo "Error: -c must be true or false"
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

mkdir -p "./${project_name}/cellranger-count-out"
cd "./${project_name}/cellranger-count-out"

for dir in ../fastq/*; do
    GSM=$(basename "$dir")
    log "start processing ${GSM}"
    cellranger count --localcores "$localcores" \
        --id="$GSM" \
        --fastqs="../fastq/${GSM}" \
        --sample="$GSM" \
        --transcriptome="../ref/${transcriptome_name}" \
        --create-bam "$create_bam"
    log "${GSM} processing completed"
done
