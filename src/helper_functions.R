

# Define the function to rename columns based on entity_name and title from data_dictionary
# Example usage
# dataset <- rename_columns(dataset, "/Users/hansoochang/Drexel/UKBiobank/data/app96818_20230711234353.dataset.data_dictionary.csv")
rename_columns <- function(dataset, path_to_data_dictionary) {
  # Check if the data_dictionary file exists at the specified path
  if (!file.exists(path_to_data_dictionary)) {
    stop("Data dictionary not found in path: ", path_to_data_dictionary)
  }
  
  # Load the data_dictionary from the specified path
  data_dictionary <- read.csv(path_to_data_dictionary)
  
  # 1. Combine 'entity' and 'name' columns in data_dictionary to create the 'entity_name'
  data_dictionary$entity_name <- paste(data_dictionary$entity, data_dictionary$name, sep = ".")
  
  # 2. Create a named vector to map combined 'entity_name' to 'title'
  name_mapping <- setNames(data_dictionary$title, data_dictionary$entity_name)
  
  # 3. Match and rename the column names of the dataset based on the combined 'entity_name'
  new_colnames <- name_mapping[colnames(dataset)]
  
  # 4. Handle cases where there is no match, keeping original column names
  new_colnames[is.na(new_colnames)] <- colnames(dataset)[is.na(new_colnames)]
  
  # 5. Assign the updated column names to the dataset
  colnames(dataset) <- new_colnames
  
  # 6. Return the updated dataset
  return(dataset)
}



# This function gets the desired features of interest from the data dictionary and outputs a txt
# file to use in terminal.
# filter_string: the name of desired feature from the data dictionary
# num_splits: Number of separate datasets to be outputted based on size of data
# file_base_name: the base name for the outputted .txt file.
# Example of using the function
# split_and_write_fields("Regional grey matter volumes", 5, "custom_name")
split_and_write_fields <- function(filter_strings, num_splits, file_base_name) {
  # Ensure that csv_data is available in the environment
  if (!exists("csv_data")) {
    stop("csv_data is not available in the environment.")
  }
  
  # 1. Filter rows where 'folder_path' contains any of the provided strings
  # Use Reduce with logical OR to check for multiple filter strings
  filter_mask <- Reduce(`|`, lapply(filter_strings, function(x) grepl(x, csv_data$folder_path)))
  filtered_data <- csv_data[filter_mask, ]
  
  # Check if filtered data has any rows
  if (nrow(filtered_data) == 0) {
    stop("No matching rows found for the provided filter strings.")
  }
  
  # 2. Combine the 'entity' and 'name' columns with a '.'
  selected_fields <- paste(filtered_data$entity, filtered_data$name, sep = ".")
  
  # 3. Split 'selected_fields' into the specified number of parts
  split_size <- ceiling(length(selected_fields) / num_splits)
  split_fields <- split(selected_fields, ceiling(seq_along(selected_fields) / split_size))
  
  # 4. Write each part to a separate text file with the custom base name
  for (i in 1:num_splits) {
    file_name <- paste0("/Users/hansoochang/Drexel/UKBiobank/", file_base_name, "_", i, ".txt")
    writeLines(split_fields[[i]], file_name)
  }
  
  message("Fields have been split and written to text files.")
}



# The split_by_instance function takes a dataframe (df) where columns have an "Instance" identifier 
# (e.g., column_name.Instance.0, column_name.Instance.1, etc.) and splits the dataframe into multiple 
# smaller dataframes, each containing only the columns corresponding to a specific instance.
# 
# The function loops through each unique instance found in the column names.
# For each instance, it extracts the columns related to that instance and creates a new dataframe.
# All resulting dataframes are stored in a list, with each dataframe named according to its 
# corresponding instance (e.g., instance_0, instance_1).
# The function returns the list of instance-specific dataframes, allowing you to work with them separately.

split_by_instance <- function(df) {
  # Extract unique instances from the column names by using a regular expression
  instances <- unique(gsub(".*\\.Instance\\.(\\d+)", "\\1", colnames(df)))
  
  # Create an empty list to store the resulting dataframes for each instance
  instance_dfs <- list()
  
  # Loop over each unique instance and create a separate dataframe
  for (instance in instances) {
    # Use grepl to select columns that match the specific instance
    instance_cols <- grepl(paste0("\\.Instance\\.", instance, "$"), colnames(df))
    
    # Create a new dataframe with only the columns for this specific instance
    instance_df <- df[, instance_cols, drop = FALSE]
    
    # Add the dataframe to the list with a meaningful name
    instance_dfs[[paste0("instance_", instance)]] <- instance_df
  }
  
  # Return the list of dataframes, each one corresponding to an instance
  return(instance_dfs)
}


# Custom function to skim and include available rows next to n_missing
skim_with_available <- function(data) {
  # Run skim on the dataset
  skim_data <- skim(data) %>%
    # Round numeric columns for better readability
    mutate(across(where(is.numeric), ~ round(., 3))) %>%
    # Add a column for non-missing rows
    mutate(non_missing = nrow(data) - n_missing) %>%
    # Relocate the 'non_missing' column next to 'n_missing'
    relocate(non_missing, .after = n_missing)
  
  return(skim_data)
}


