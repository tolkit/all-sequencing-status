#!/usr/bin/env bash

# otherwise the file appending gets messed up
rm -r ../clades/
# collect all stats to tsvs
# bash collect_stats.bash

printf "[+]\t::pipeline.bash:: running main pipeline now.\n"

# add higher order groupings
python3 add_higher_taxa.py ../data/all_assembled_genomes.tsv > ../data/all_assembled_genomes_higher.tsv
python3 add_higher_taxa.py ../data/all_samples_by_genomic_data.tsv > ../data/all_samples_by_genomic_data_higher.tsv

# merge the data
Rscript merge_data.R

# make the README's
python3 make_READMEs.py
