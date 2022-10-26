# PredictHaplo_method3

Pipeline to retrieve haplotypes with method 3 as decribed in thesis Daphne van Ginneken. This method uses sample consensus sequences, error corrected reads and certain scripts from the HaploHIV pipeline (Copyright (C) 2019  Gijs Schroeder, Terry Huisman, Kobus Bosman, Monique Nijhuis, Rob de Boer, Aridaman Pandit). With method 2, samples from the same replicate are provided with the same reference sequence for PredictHaplo[1], this reference sequence is the consensus of both sample consensus sequences.

### How to run this pipeline
Create and activate the conda environment:  
`conda env create -f environment.yaml`  
`conda activate haplotyping`  

Run the script:  
`bash script.sh [output directory] [directory HaploHIV]`  

Run this script for each patient separately:  
`bash script.sh [output directory] [output directory HaploHIV] [patient number]` 

[1] Prabhakharan S, Rey M, Zagordi O, et al. HIV Haplotype Inference Using a Propagating Dirichlet Process Mixture Model. IEEE/ACM. 2014;11(1):182-191. doi: 10.1109/TCBB.2013.145
