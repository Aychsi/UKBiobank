
# This file reads in the gmv csv files, combines them, and renames the columns with more descriptive
# column names

gmv_1 <- read.csv(paste0(root, "data/regional_gmv_1.csv"))
gmv_2 <- read.csv(paste0(root, "data/regional_gmv_2.csv"))
gmv_3 <- read.csv(paste0(root, "data/regional_gmv_3.csv"))
gmv_4 <- read.csv(paste0(root, "data/regional_gmv_4.csv"))
gmv_5 <- read.csv(paste0(root, "data/regional_gmv_5.csv"))


# Combine the five datasets column-wise using cbind
combined_gmv <- rename_columns(cbind(gmv_1, gmv_2, gmv_3, gmv_4, gmv_5))

write.csv(combined_gmv, paste0(root, "data/combined_gmv.csv"))



