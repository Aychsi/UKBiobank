
# This file gets the gets the desired features of interest from the data dictionary

# # Load the CSV file
# csv_data <- read.csv(paste0(root, "data/app96818_20230711234353.dataset.data_dictionary.csv"))
# 
# # Filter rows where 'folder_path' contains the string "Regional grey matter volumes (FAST)"
# filtered_data <- csv_data[grepl("Regional grey matter volumes", csv_data$folder_path), ]
# 
# 
# # 3. Combine the 'entity' and 'name' columns with a '.'
# selected_fields <- paste(filtered_data$entity, filtered_data$name, sep = ".")
# 
# # 4. Split 'selected_fields' into 5 separate parts
# num_splits <- 5
# split_size <- ceiling(length(selected_fields) / num_splits)
# split_fields <- split(selected_fields, ceiling(seq_along(selected_fields) / split_size))
# 
# # 5. Write each part to a separate text file
# for (i in 1:num_splits) {
#   writeLines(split_fields[[i]], paste0("/Users/hansoochang/Drexel/UKBiobank/fields_part_", i, 
#                                        ".txt"))
# }



# BBB
split_and_write_fields(c("Body size measures", "Blood pressure", "Blood count",
                         "Blood biochemistry"), 35, "bbb")


#dx extract_dataset record-GXg0J9jJ346zgf569X3Gf9ZZ --fields "$(cat /Users/hansoochang/Drexel/UKBiobank/fields_part_1.txt | tr '\n' ',' | sed 's/,$//')" -o /Users/hansoochang/Drexel/UKBiobank/data/regional_gmv_1.csv