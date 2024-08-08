source("src/disc_scores_proj_infreq.R")
source("src/helper_funs.R")

# Read processed data
library(readr)

# dataset_name can be any of: flare, diabetes, lymphography, tumor, thyroid
# Using "flare" as an example
dataset_name <- "flare"
dataset_path <- paste0("data/processed/", dataset_name, ".csv")
dataset <- read_csv(dataset_path)
dataset <- as.data.frame(dataset)
# Convert columns to factors
for (i in 1:ncol(dataset)){
  dataset[, i] <- as.factor(dataset[, i])
}

# Create probability vectors
prob_vecs <- list()
for (i in 1:ncol(dataset)){
  prob_vecs[[i]] <- as.vector(table(dataset[,i])/nrow(dataset))
}

# Setting MAXLEN = 0 yields automated MAXLEN selection
# Set MAXLEN to a positive integer to force its value
sono_out <- sono(data = dataset, 
                 probs = prob_vecs,
                 alpha = 0.05,
                 r = 2, 
                 MAXLEN = 0)

save(sono_out, file = paste0('output/', dataset_name, '_sono.RData'))