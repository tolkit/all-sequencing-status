#!/usr/bin/env bash

printf "Begin fetching plant names\n"

# Assemblies
printf "Fetching assemblies\n"

ls /lustre/scratch123/tol/projects/darwin/data/{algae,amphibians,annelids,arthropods,birds,chordates,dicots,echinoderms,fish,fungi,insects,jellyfish,mammals,molluscs,monocots,nematodes,non-vascular-plants,other-animal-phyla,platyhelminths,protists,sharks,sponges,vascular-plants}/*/assembly/release/reference 2>/dev/null | \
grep "lustre" | \
awk -F/ '{print $8,"\t",$9,"\t","released"}' > ../data/all_assembled_genomes.tsv

ls /lustre/scratch123/tol/projects/darwin/data/{algae,amphibians,annelids,arthropods,birds,chordates,dicots,echinoderms,fish,fungi,insects,jellyfish,mammals,molluscs,monocots,nematodes,non-vascular-plants,other-animal-phyla,platyhelminths,protists,sharks,sponges,vascular-plants}/*/assembly/curated/* 2>/dev/null | \
grep "lustre" | \
awk -F/ '{print $8,"\t",$9,"\t","curated"}' >> ../data/all_assembled_genomes.tsv

ls /lustre/scratch123/tol/projects/darwin/data/{algae,amphibians,annelids,arthropods,birds,chordates,dicots,echinoderms,fish,fungi,insects,jellyfish,mammals,molluscs,monocots,nematodes,non-vascular-plants,other-animal-phyla,platyhelminths,protists,sharks,sponges,vascular-plants}/*/assembly/draft/* 2>/dev/null | \
grep "lustre" | \
awk -F/ '{print $8,"\t",$9,"\t","draft"}' >> ../data/all_assembled_genomes.tsv

printf "Fetching genomic data\n"

# Genomic data
ls /lustre/scratch123/tol/projects/darwin/data/{algae,amphibians,annelids,arthropods,birds,chordates,dicots,echinoderms,fish,fungi,insects,jellyfish,mammals,molluscs,monocots,nematodes,non-vascular-plants,other-animal-phyla,platyhelminths,protists,sharks,sponges,vascular-plants}/*/genomic_data/*/*/ | \
grep "lustre" | \
awk -F/ '{print $8,"\t",$9,"\t",$10,"\t",$11,"\t",$12}' > ../data/all_samples_by_genomic_data.tsv

printf "Done\n"

