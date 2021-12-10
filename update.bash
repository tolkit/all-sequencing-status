#!/usr/bin/env bash

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
git add .
git commit -m "Update on $date"
git push

