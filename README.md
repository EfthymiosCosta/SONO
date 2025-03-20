<<<<<<< HEAD
# Scores Of Nominal Outlyingness (SONO)
This repository includes the implementation of the SONO framework for computing scores of nominal outlyingness for nominal data sets.

`data`: This directory includes 2 sub-directories with the raw and processed data used for simulation purposes. The `raw` subdirectory includes the original `.csv` files from the UCI Machine Learning Repository. The `processed` sub-directory includes the same data sets upon removing any non-nominal variables and removing missing data in `.rds` format for easier handling in `R`.

`output`: This directory includes the results of running `run_sono.R` with `dataset` being one of `flare`, `diabetes`, `lymphography`, `tumor` or `thyroid` data sets.

`src`: The function `helper_funs.R` includes three manually written functions that are used in `run_sono.R`. The `sono.R` file is the main function for computing scores of nominal outlyingness, variable contribution matrix and the nominal outlyingness depth. This is calling the `sono_infreq.R` function when setting argument `frequent = FALSE`, defining outlyingness in terms of infrequent itemsets. For the alternative definition of outliers as too frequent itemsets, the function `sono_freq.R` is called instead.

`dependencies`: A list of the `R` packages used in `sono_infreq.R` and `sono_results_plots.R`.

`run_sono.R`: Script used to run the simulations.

`sono_results_plots.R`: Script used for analysis of results. Includes code for plotting scors of nominal outlyingness against nominal outlyingness depth, the correlation matrix of variable contributions and the matrix of variable contributions per individual for observations with non-zero scores of outlyingness.
=======
# SONO (Scores Of Nominal Outlyingness)
The `SONO` (Scores Of Nominal Outlyingness) `R` package includes a function that can be used for detecting outliers in data sets consisting of nominal data. Some of the capabilities of the package include:

- Calculating scores of outlyingness for data sets consisting of nominal variables.
- Estimating the maximum length of nominal sequences (MAXLEN) for doing frequent pattern mining.
- Computing maximum/minimum itemset support threshold values.
- Visualising the matrix of variable contributions to the score of nominal outlyingness computed.
- Computing evaluation metrics to compare performance of outlier detection algorithms (ROC AUC, Recall@K, Average Outlier Rank).

A detailed description of the methods included in the package can be found in [Costa, E., & Papatsouma, I. (2025). A novel framework for quantifying nominal outlyingness.](https://arxiv.org/abs/2408.07463)

# Installation
The package can be installed using [devtools](https://devtools.r-lib.org/).
```R
# install.packages("devtools")
devtools::install_github('EfthymiosCosta/SONO')
```
>>>>>>> 3310a211b6032a57a042f60aafeca5ff49aea930
