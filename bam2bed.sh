#!/usr/bin/env bash

# Define input variables
echo "bam: $1"
echo "out_dir: $2"
bam_file="$1"
out_dir="$2"

# Extract base file name
base_name=$(basename "$bam_file" .bam)

# Define output path
out_full="$out_dir/${base_name}.bed"
out_chr1="$out_dir/${base_name}_chr1.bed"
count_file="$out_dir/bam2bed_number_of_rows.txt"

# Make output directory
mkdir -p "$2"

# Conda environment
source $(dirname $(dirname $(which conda)))/etc/profile.d/conda.sh
conda create -y --name bam2bed bedtools
conda activate bam2bed

# Convert to bed
bedtools bamtobed -i "$bam_file" > "$out_full"

# Create filtered bed
grep -E "^Chr1\s" "$out_full" > "$out_chr1"

# Line count
wc -l "$out_chr1" > "$count_file"

# Echo name
echo "Olivier Smeets"
