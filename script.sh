#!/bin/bash

snakemake -s Snakefile_consensus --config output_dir="$1" haplohiv_folder="$2" --

