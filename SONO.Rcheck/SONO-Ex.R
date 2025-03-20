pkgname <- "SONO"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
options(pager = "console")
library('SONO')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("MAXLEN_est")
### * MAXLEN_est

flush(stderr()); flush(stdout())

### Name: MAXLEN_est
### Title: Estimate MAXLEN
### Aliases: MAXLEN_est

### ** Examples




cleanEx()
nameEx("avg_rank_outs")
### * avg_rank_outs

flush(stderr()); flush(stdout())

### Name: avg_rank_outs
### Title: Average Rank Of Outlier
### Aliases: avg_rank_outs

### ** Examples




cleanEx()
nameEx("recall_at_k")
### * recall_at_k

flush(stderr()); flush(stdout())

### Name: recall_at_k
### Title: Recall@K
### Aliases: recall_at_k

### ** Examples




cleanEx()
nameEx("roc_auc")
### * roc_auc

flush(stderr()); flush(stdout())

### Name: roc_auc
### Title: ROC AUC function
### Aliases: roc_auc

### ** Examples




cleanEx()
nameEx("sono")
### * sono

flush(stderr()); flush(stdout())

### Name: sono
### Title: SONO (Scores Of Nominal Outlyingness)
### Aliases: sono

### ** Examples




cleanEx()
nameEx("vis_contribs")
### * vis_contribs

flush(stderr()); flush(stdout())

### Name: vis_contribs
### Title: Visualise Contribution Matrix
### Aliases: vis_contribs

### ** Examples




### * <FOOTER>
###
cleanEx()
options(digits = 7L)
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
