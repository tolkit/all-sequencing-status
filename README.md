# Sequencing status for all species in DToL

This repo documents the status of each species with data in the Darwin Tree of Life Project.

The `clades` folder contains the orders of Eukaryotes for which at least one species has some data attached. A maximum of two tables are then presented, one for assemblies (either draft, curated, or released, aka public) and one for genomic data (Hi-C, PacBio or 10X).

## Environment

Needs an R environment on the server, so:

```bash
conda create -n r-environment r-base r-data.table
conda activate r-environment
```
