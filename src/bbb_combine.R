
# Explanation:
# Loading Data:
#   
# The code loops through all the CSV files. For bbb_9a and bbb_9b, it handles them separately and adds them to data_list.
# For the other CSV files, it loads them into the list if they exist.
# cbind():
#   
#   After loading all the data frames into data_list, the do.call(cbind, data_list) function combines them column-wise.
# Handling Missing Files:
#   
#   If any files don't exist, they are skipped without causing errors or warnings.
# Notes:
# Same Number of Rows: Make sure that all the datasets you want to combine have the same number of rows. cbind() requires that all the data frames have the same number of rows to work correctly.
# Column Naming Conflicts: If there are duplicate column names across different CSV files, cbind() will automatically modify the column names to avoid conflicts.
# This code will create a single combined_data dataset by combining all the CSV files column-wise.


# Initialize an empty list to store the data frames
data_list <- list()

# Load 35 CSV files into separate variables
for (i in 1:35) {
  
  # Special case for bbb_9a and bbb_9b
  if (i == 9) {
    # Load bbb_9a.csv and bbb_9b.csv as separate files
    file_9a <- paste0(root, "data/bbb_9a.csv")
    file_9b <- paste0(root, "data/bbb_9b.csv")
    
    if (file.exists(file_9a)) {
      bbb_9a <- read.csv(file_9a)
      data_list[[length(data_list) + 1]] <- bbb_9a
    }
    
    if (file.exists(file_9b)) {
      bbb_9b <- read.csv(file_9b)
      data_list[[length(data_list) + 1]] <- bbb_9b
    }
    
  } else {
    # For other cases, load the file as usual
    file_name <- paste0(root, "data/bbb_", i, ".csv")
    if (file.exists(file_name)) {
      data_list[[length(data_list) + 1]] <- read.csv(file_name)
    }
  }
}

# gmv is same as bbb eid since it includes all participants
gmv_eid_1 <- read.csv(paste0(root, "data/gmv_eid_1.csv"))

# Combine all data frames column-wise
combined_bbb <- rename_columns(do.call(cbind, data_list))
combined_bbb <- cbind(gmv_eid_1, combined_bbb)


write.csv(combined_bbb, paste0(root, "data/combined_bbb.csv"), row.names = FALSE)

