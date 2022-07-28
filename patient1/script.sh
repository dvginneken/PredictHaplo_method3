#!/bin/bash
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=M.I.vanGinneken@umcutrecht.nl

snakemake -c8 -s Snakefile_haplotype

