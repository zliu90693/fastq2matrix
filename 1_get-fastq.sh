#!/bin/bash

# Depends on conda environment: kingfisher (see .env/kingfisher.yml)

set -euo pipefail

storage_path=/data/share/data/Zhou_lab_seq_data/20260401_lzy_sc_fastq # Please modify this path according to your needs.
threads=8

project_name=""

while getopts "p:t:v:" opt; do
    case $opt in
        p)
            project_name=$OPTARG
            ;;
        t)
            threads=$OPTARG
            ;;
        v)
            verbose=true
            ;;
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

if [ -z "$project_name" ]; then
    echo "Error: The project name must be specified using -p."
    exit 1
fi

if ! [[ "$threads" =~ ^[0-9]+$ ]]; then
    echo "Error: -t must be a positive integer."
    exit 1
fi

# if ! command -v prefetch >/dev/null 2>&1; then
#     echo "Error: prefetch command not found."
#     echo "Activate the kingfisher conda environment first."
#     exit 1
# fi

if ! command -v fasterq-dump >/dev/null 2>&1; then
    echo "Error: fasterq-dump command not found."
    echo "Activate the kingfisher conda environment first."
    exit 1
fi

project_dir="./${project_name}"
metadata_dir="./${project_dir}/metadata"
srr_list="./${metadata_dir}/SRR_list"
fastq_dir="${storage_path}/${project_name}"

########################################
# Directory / file checks
########################################

# storage path
if [[ ! -d "$storage_path" ]]; then
    echo "Error: storage path does not exist:"
    echo "  $storage_path"
    exit 1
fi

# project directory
if [[ ! -d "$project_dir" ]]; then
    echo "Error: project directory not found:"
    echo "  $project_dir"
    exit 1
fi

# metadata directory
if [[ ! -d "$metadata_dir" ]]; then
    echo "Error: metadata directory not found:"
    echo "  $metadata_dir"
    exit 1
fi

# SRR list
if [[ ! -f "$srr_list" ]]; then
    echo "Error: SRR_list file not found:"
    echo "  $srr_list"
    exit 1
fi

if [[ ! -s "$srr_list" ]]; then
    echo "Error: SRR_list exists but is empty."
    exit 1
fi

########################################
# Create output directory safely
########################################

mkdir -p "$fastq_dir"

########################################
# Run Fasterq-Dump
########################################

xargs -a "$srr_list" -I {} fasterq-dump \
    --split-files \
    --include-technical \
    --threads "$threads" \
    --outdir "$fastq_dir" \
    --temp "${fastq_dir}/tmp"

