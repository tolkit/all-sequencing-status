#!/usr/bin/python3

import os
import csv
from collections import Counter

## do assemblies first
with open("../data/all_assembled_genomes_merged.tsv") as assemblies:
    rd = csv.reader(assemblies, delimiter="\t", quotechar='"')
    next(rd, None)  # skip the headers

    # store orders in dict
    orders = []

    # first pass to get keys
    for row in rd:
        if row[4] == "":
            pass
        else:
            # to make the dirs
            orders.append(row[4])
    # get keys for dirs & dict later
    uniq_orders = Counter(orders).keys()
    # copy
    uniq_orders_c = list(uniq_orders)
    orders_dict_assemblies = {key: [] for key in uniq_orders_c}

# make directories
for dir in uniq_orders:
    os.makedirs("../clades/{0}".format(dir), exist_ok=True)

with open("../data/all_assembled_genomes_merged.tsv") as assemblies:
    rd = csv.reader(assemblies, delimiter="\t", quotechar='"')
    next(rd, None)  # skip the headers
    # second pass
    for row in rd:
        if row[4] == "":
            continue
        # the different columns
        species = row[2]
        family = row[3]
        order = row[4]
        data_type = row[12]

        orders_dict_assemblies[order].append([species, family, order, data_type])


# write the assemblies to README
for key in uniq_orders:
    with open("../clades/{0}/README.md".format(key), "w") as key_file:
        key_file.write("# " + str(key) + " assembly data" + "\n\n")
        key_file.write("| Species | Family | Order | Data type |\n")
        key_file.write("| -- | --- | --- | --- |\n")
        # now the rows of the table
        no_released = 0
        no_curated = 0
        no_draft = 0
        for row in orders_dict_assemblies[key]:
            if row[3] == "released":
                no_released += 1
            if row[3] == "curated":
                no_curated += 1
            if row[3] == "draft":
                no_draft += 1
            sp = row[0]
            # think about italics here.
            key_file.write("| *" + sp + "* | " + " | ".join(row[1:]) + " |\n")
        key_file.write(
            "\nNumber of species released: {0}\nNumber of species curated: {1}\nNumber of species with draft assemblies: {2}\n\n".format(
                no_released, no_curated, no_draft
            )
        )

#############################################

# now do the genomic data
with open("../data/all_samples_by_genomic_data_merged.tsv") as genomic_data:
    rd = csv.reader(genomic_data, delimiter="\t", quotechar='"')
    next(rd, None)  # skip the headers

    # store orders in dict
    orders = []

    # first pass to get keys
    for row in rd:
        if row[4] == "":
            pass
        else:
            # to make the dirs
            orders.append(row[4])
    # get keys for dirs & dict later
    uniq_orders_genomic = Counter(orders).keys()
    # copy
    uniq_orders_c_genomic = list(uniq_orders_genomic)
    orders_dict_genomic_data = {key: [] for key in uniq_orders_c_genomic}

# make directories, add if they weren't there in assemblies
for dir in uniq_orders_genomic:
    os.makedirs("../clades/{0}".format(dir), exist_ok=True)

with open("../data/all_samples_by_genomic_data_merged.tsv") as genomic_data:
    rd = csv.reader(genomic_data, delimiter="\t", quotechar='"')
    next(rd, None)  # skip the headers
    # second pass
    for row in rd:
        if row[4] == "":
            continue
        # the different columns
        species = row[2]
        family = row[3]
        order = row[4]
        data_type = row[13]

        orders_dict_genomic_data[order].append([species, family, order, data_type])

# write the genomic data to README
for key in uniq_orders_genomic:
    with open("../clades/{0}/README.md".format(key), "a+") as key_file:
        key_file.write("# " + str(key) + " genomic data" + "\n\n")
        key_file.write("| Species | Family | Order | Data type |\n")
        key_file.write("| -- | --- | --- | --- |\n")
        # now the rows of the table
        no_hic = 0
        no_pacbio = 0
        no_10x = 0
        for row in orders_dict_genomic_data[key]:
            if row[3] == "hic-arima2":
                no_hic += 1
            if row[3] == "pacbio":
                no_pacbio += 1
            if row[3] == "10x":
                no_10x += 1
            sp = row[0]
            # think about italics here.
            key_file.write("| *" + sp + "* | " + " | ".join(row[1:]) + " |\n")
        key_file.write(
            "\nNumber of species with Hi-C data: {0}\nNumber of species with PacBio HiFi data: {1}\nNumber of species with 10X data: {2}\n".format(
                no_hic, no_pacbio, no_10x
            )
        )

