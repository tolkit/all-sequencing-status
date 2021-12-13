#!/usr/bin/python3

# Take a list of files
# Query the goat API for higher taxons

import os
import sys

input_path = sys.argv[1]

# https://stackoverflow.com/questions/28261614/how-do-i-write-in-a-new-text-file-every-x-lines-python
# split so we don't overwhelm the poor goat API
def splited_lines_generator(lines, n):
    for i in range(0, len(lines), n):
        yield lines[i : i + n]


# get species names
s = []

with open(input_path, "r") as species_tsv:
    for line in species_tsv:
        species = line.split("\t")[1].replace("_", " ").strip()
        s.append(species)

for index, lines in enumerate(splited_lines_generator(s, 50)):
    with open("./out" + str(index) + ".txt", "w") as f:
        f.write("\n".join(lines))

print("[+]\t::add_higher_taxa.py:: Querying GoaT now.", file=sys.stderr)

query = """
for file in ./out*; do
    ./goat search -cf $file --ranks family
    printf "[+]\tQueried $file in GoaT.\n" >&2 
done
rm ./out*
"""
os.system(query)
