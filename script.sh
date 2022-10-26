#!/bin/bash

snakemake -c7 -s Snakefile_consensus --config output_dir="$1" haplohiv_folder="$2" --

