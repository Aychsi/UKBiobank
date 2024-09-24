
source(paste0(getwd(), "/src/init.R"))
mri <- read.csv(paste0(getwd(), "/data/MRI_Samples.csv"))


head(mri)
colnames(mri)
dim(mri)

# Instance 2
mri %>%
  filter(!is.na(mri[,4])) %>%
  dim()

# Instance 3
mri %>%
  filter(!is.na(mri[,5])) %>%
  dim()


