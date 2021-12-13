#!/usr/bin/env bash

# now going to do this locally, because
# it's easier
# fetch data from server

printf "[+]\t::update.bash:: fetching data from server.\n"

rsync -avhP f:/lustre/scratch123/tol/teams/blaxter/users/mb39/all_sequencing_status/data/all_assembled_genomes.tsv ./data/
rsync -avhP f:/lustre/scratch123/tol/teams/blaxter/users/mb39/all_sequencing_status/data/all_samples_by_genomic_data.tsv ./data/

# just for my convenience
# go to src
cd src
# run the pipeline
bash pipeline.bash
# come back
cd ..

# store date
date=$(date '+%Y-%m-%d')

# push to git
#git add .
#git commit -m "Update on $date"
#git push

