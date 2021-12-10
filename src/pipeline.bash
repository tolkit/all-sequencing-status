#!/usr/bin/env bash

# otherwise the file appending gets messed up
rm -r ../clades/
# collect all stats to tsvs
bash collect_stats.bash

# add higher order groupings
python3 add_higher_taxa.py ../data/all_assembled_genomes.tsv > ../data/all_assembled_genomes_higher.tsv
python3 add_higher_taxa.py ../data/all_samples_by_genomic_data.tsv > ../data/all_samples_by_genomic_data_higher.tsv

CWD=$(pwd)
# conda activate r-environment
cd /lustre/scratch123/tol/teams/blaxter/users/mb39/miniconda3/bin
source activate root
cd $CWD

source activate /lustre/scratch123/tol/teams/blaxter/users/mb39/miniconda3/envs/r-environment
# merge the data
Rscript merge_data.R

# make the README's
python3 make_READMEs.py
