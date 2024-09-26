#!/bin/bash

# Loop through 35 text files and extract the dataset for each
for i in {1..1}
do
  # Construct the input and output file paths
  txt_file="/Users/hansoochang/Drexel/UKBiobank/bbb_${i}.txt"
  csv_file="/Users/hansoochang/Drexel/UKBiobank/data/bbb_${i}.csv"

  # Run the dx extract_dataset command for each file
  dx extract_dataset record-GXg0J9jJ346zgf569X3Gf9ZZ --fields "$(cat ${txt_file} | tr '\n' ',' | sed 's/,$//')" -o ${csv_file}

  # Print status message for each iteration
  echo "Extracted data for ${txt_file} to ${csv_file}"

  # Optional: Add a short delay if needed (e.g., 5 seconds)
  # sleep 5
done

