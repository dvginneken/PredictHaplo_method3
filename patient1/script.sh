#!/bin/bash
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=M.I.vanGinneken@umcutrecht.nl

snakemake -j 7 -s Snakefile_haplotype

