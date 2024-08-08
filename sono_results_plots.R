library(ggplot2)
library(tidyverse)
library(reshape2)

# Read SONO output for given data
# dataset_name can be any of: flare, diabetes, lymphography, tumor, thyroid
# Using "flare" as an example
dataset_name <- "flare"
output_path <- paste0("output/", dataset_name, "_sono.rds")
sono_out <- readRDS(output_path)

# Filter out observations with non-zero scores of nominal outlyingness
sono_non_zero <- sono_out[[2]]
sono_non_zero <- sono_non_zero[which(sono_non_zero[, 2] > 0), ]
sono_non_zero_depth <- sono_out$Depth[which(sono_out[[2]][, 2] > 0)]

# Nominal outlyingness scores vs. depths scatter plot
# This is for observations with non-zero scores only
ggplot() +
  geom_point(aes(x = sono_non_zero_depth,
                 y = sono_non_zero$Score),
             colour = 'springgreen4') +
  ylab('Nominal Outlyingness Score') +
  xlab('Nominal Outlyingness Depth') + 
  theme_bw()

# Correlation matrix of variable contributions
# Average total contribution
avg_tot_contribs <- matrix(NA,
                           nrow = ncol(sono_out$Contributions),
                           ncol = ncol(sono_out$Contributions))
avg_tot_contribs <- cor(sono_out$Contributions[sono_non_zero$Observation, ])

avg_tot_contribs <- as.data.frame(as.table(avg_tot_contribs))

avg_tot_contribs <- avg_tot_contribs %>% filter(Var1 != Var2)

ggplot(avg_tot_contribs, aes(Var1, Var2, fill = Freq)) +
  geom_tile() +
  scale_fill_gradient(low = "white", high = "springgreen4", na.value = NA) +
  scale_x_discrete(labels = colnames(sono_out$Contributions)) +
  scale_y_discrete(labels = colnames(sono_out$Contributions)) +
  theme_bw() +
  theme(
    axis.text.x = element_text(angle = 30, hjust = 1),
    axis.text.y = element_text(angle = 0, hjust = 1)) +
  labs(x = "", y = "", fill = "Correlation")


# EXTRA: Variable contributions for observations with non-zero scores
# Extract non-zero scores and contributions and plot
non_zero_contribs <- sono_out$Contributions[which(sono_out[[2]][, 2] > 0),]
non_zero_contribs$row <- row.names(non_zero_contribs)
non_zero_contribs_melt <- melt(non_zero_contribs)

ggplot(data=non_zero_contribs_melt,
       aes(x=variable, y=row, fill=value)) +
  geom_tile() + 
  xlab('') + 
  scale_fill_gradient(low = "white", high = "springgreen4", na.value = NA) +
  theme_bw() + 
  theme(
    axis.text.x = element_text(angle = 30, hjust = 1),
    axis.title.y=element_blank(),
    axis.text.y=element_blank(),
    axis.ticks.y=element_blank()) +
  labs(x = "", y = "", fill = "Contribution")
