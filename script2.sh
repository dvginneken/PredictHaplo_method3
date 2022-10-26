#!/bin/bash

snakemake -c8 -s Snakefile_haplotype --config output_dir="$1" haplohiv_folder="$2" patient="$3"--
