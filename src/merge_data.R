#!/usr/bin/env Rscript

library(data.table)

## read in the data

# the assemblies
assembled_genomes <- unique(fread("../data/all_assembled_genomes.tsv",
    col.names = c(
        "tol_clade",
        "scientific_name_underscore",
        "data_type"
    )
))

assembled_genomes[
    ,
    scientific_name := gsub("_", " ", scientific_name_underscore)
]

assembled_genomes_higher <- unique(
    fread("../data/all_assembled_genomes_higher.tsv")
)
# the raw data
genomic_data <- unique(fread("../data/all_samples_by_genomic_data.tsv",
    col.names = c(
        "tol_clade",
        "scientific_name_underscore",
        "type",
        "tolid",
        "data_type"
    )
))

genomic_data[
    ,
    scientific_name := gsub("_", " ", scientific_name_underscore)
]

genomic_data_higher <- unique(
    fread("../data/all_samples_by_genomic_data_higher.tsv")
)

## merge the data

all_assembled_genomes <- assembled_genomes_higher[
    assembled_genomes,
    on = .(scientific_name)
]
all_genomic_data <- genomic_data_higher[
    genomic_data,
    on = .(scientific_name)
]

## write the data
# remove tolids
# as they add dups

all_genomic_data[, tolid := NULL]

fwrite(
    x =
        unique(all_assembled_genomes),
    file = "../data/all_assembled_genomes_merged.tsv",
    sep = "\t"
)
fwrite(
    x = unique(all_genomic_data),
    file = "../data/all_samples_by_genomic_data_merged.tsv",
    sep = "\t"
)
