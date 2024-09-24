
# This files initializes the root folder and packages necessary for the UKBiobank Project

root <- "/Users/hansoochang/Drexel/UKBiobank/"

renv::init()
library(dplyr)
library(caret)
library(kernlab)
library(MASS)
library(e1071)
library(keras)
library(skimr)
library(ggplot2)
library(purrr)
library(dplyr)
library(ggpubr)
library(progress)
library(doParallel)
library(parallel)
library(tensorflow)
library(kernlab)
library(caretEnsemble)
library(neuralnet)
library(tidymodels)
library(kknn)
library(gridExtra)
library(grid)
library(renv)
renv::snapshot()


head(read.csv("/Users/hansoochang/export_2.csv"))
