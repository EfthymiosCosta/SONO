<<<<<<< HEAD
pkgname <- "SONO"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
options(pager = "console")
base::assign(".ExTimings", "SONO-Ex.timings", pos = 'CheckExEnv')
base::cat("name\tuser\tsystem\telapsed\n", file=base::get(".ExTimings", pos = 'CheckExEnv'))
base::assign(".format_ptime",
function(x) {
  if(!is.na(x[4L])) x[1L] <- x[1L] + x[4L]
  if(!is.na(x[5L])) x[2L] <- x[2L] + x[5L]
  options(OutDec = '.')
  format(x[1L:3L], digits = 7L)
},
pos = 'CheckExEnv')

### * </HEADER>
library('SONO')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("MAXLEN_est")
### * MAXLEN_est

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: MAXLEN_est
### Title: Estimate MAXLEN
### Aliases: MAXLEN_est

### ** Examples

## No test: 
dt <- as.data.frame(sample(c(1:2), 100, replace = TRUE, prob = c(0.5, 0.5)))
dt <- cbind(dt, sample(c(1:3), 100, replace = TRUE, prob = c(0.5, 0.3, 0.2)))
dt[, 1] <- as.factor(dt[, 1])
dt[, 2] <- as.factor(dt[, 2])
colnames(dt) <- c('V1', 'V2')
MAXLEN_est(data = dt, probs = list(c(0.5, 0.5), c(1/3, 1/3, 1/3)), alpha = 0.01, frequent = FALSE)
## End(No test)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("MAXLEN_est", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("avg_rank_outs")
### * avg_rank_outs

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: avg_rank_outs
### Title: Average Rank Of Outlier
### Aliases: avg_rank_outs

### ** Examples

## No test: 
dt <- as.data.frame(sample(c(1:2), 100, replace = TRUE, prob = c(0.5, 0.5)))
dt <- cbind(dt, sample(c(1:3), 100, replace = TRUE, prob = c(0.5, 0.3, 0.2)))
dt[, 1] <- as.factor(dt[, 1])
dt[, 2] <- as.factor(dt[, 2])
colnames(dt) <- c('V1', 'V2')
sono_out <- sono(data = dt, probs = list(c(0.5, 0.5), c(1/3, 1/3, 1/3)),
alpha = 0.01, r = 2, MAXLEN = 0, frequent = FALSE)
# Suppose observations 1 up to 5 are outliers
avg_rank_outs(scores = sono_out[[2]][, 2], outs = c(1:5), ties = "min")
## End(No test)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("avg_rank_outs", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("recall_at_k")
### * recall_at_k

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: recall_at_k
### Title: Recall@K
### Aliases: recall_at_k

### ** Examples

## No test: 
dt <- as.data.frame(sample(c(1:2), 100, replace = TRUE, prob = c(0.5, 0.5)))
dt <- cbind(dt, sample(c(1:3), 100, replace = TRUE, prob = c(0.5, 0.3, 0.2)))
dt[, 1] <- as.factor(dt[, 1])
dt[, 2] <- as.factor(dt[, 2])
colnames(dt) <- c('V1', 'V2')
sono_out <- sono(data = dt,
probs = list(c(0.5, 0.5), c(1/3, 1/3, 1/3)),
alpha = 0.01,
r = 2,
MAXLEN = 0,
frequent = FALSE)
# Suppose observations 1 up to 5 are outliers
recall_at_k(scores = sono_out[[2]][, 2],
outs = c(1:5),
grid = c(1, 2.5, seq(5, 50, by = 5))/100)
## End(No test)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("recall_at_k", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("roc_auc")
### * roc_auc

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: roc_auc
### Title: ROC AUC function
### Aliases: roc_auc

### ** Examples

## No test: 
dt <- as.data.frame(sample(c(1:2), 100, replace = TRUE, prob = c(0.5, 0.5)))
dt <- cbind(dt, sample(c(1:3), 100, replace = TRUE, prob = c(0.5, 0.3, 0.2)))
dt[, 1] <- as.factor(dt[, 1])
dt[, 2] <- as.factor(dt[, 2])
colnames(dt) <- c('V1', 'V2')
sono_out <- sono(data = dt,
probs = list(c(0.5, 0.5), c(1/3, 1/3, 1/3)),
alpha = 0.01,
r = 2,
MAXLEN = 0,
frequent = FALSE)
# Suppose observations 1 up to 5 are outliers
roc_auc(scores = sono_out[[2]][, 2], outs = c(1:5),
grid = c(1, 2.5, seq(5, 50, by = 5))/100)
## End(No test)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("roc_auc", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("sono")
### * sono

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: sono
### Title: SONO (Scores Of Nominal Outlyingness)
### Aliases: sono

### ** Examples

## No test: 
dt <- as.data.frame(sample(c(1:2), 100, replace = TRUE, prob = c(0.5, 0.5)))
dt <- cbind(dt, sample(c(1:3), 100, replace = TRUE, prob = c(0.5, 0.3, 0.2)))
dt[, 1] <- as.factor(dt[, 1])
dt[, 2] <- as.factor(dt[, 2])
colnames(dt) <- c('V1', 'V2')
sono(data = dt,
probs = list(c(0.5, 0.5), c(1/3, 1/3, 1/3)),
alpha = 0.01,
r = 2,
MAXLEN = 0,
frequent = FALSE)
## End(No test)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("sono", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("vis_contribs")
### * vis_contribs

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: vis_contribs
### Title: Visualise Contribution Matrix
### Aliases: vis_contribs

### ** Examples

## No test: 
dt <- as.data.frame(sample(c(1:2), 100, replace = TRUE, prob = c(0.5, 0.5)))
dt <- cbind(dt, sample(c(1:3), 100, replace = TRUE, prob = c(0.5, 0.3, 0.2)))
dt[, 1] <- as.factor(dt[, 1])
dt[, 2] <- as.factor(dt[, 2])
colnames(dt) <- c('V1', 'V2')
sono_out <- sono(data = dt,
probs = list(c(0.5, 0.5), c(1/3, 1/3, 1/3)),
alpha = 0.01,
r = 2,
MAXLEN = 0,
frequent = FALSE)
vis_contribs(contribs_mat = sono_out[[3]], subset = c(1:50), scale = "row")
## End(No test)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("vis_contribs", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
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
=======
pkgname <- "SONO"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
options(pager = "console")
base::assign(".ExTimings", "SONO-Ex.timings", pos = 'CheckExEnv')
base::cat("name\tuser\tsystem\telapsed\n", file=base::get(".ExTimings", pos = 'CheckExEnv'))
base::assign(".format_ptime",
function(x) {
  if(!is.na(x[4L])) x[1L] <- x[1L] + x[4L]
  if(!is.na(x[5L])) x[2L] <- x[2L] + x[5L]
  options(OutDec = '.')
  format(x[1L:3L], digits = 7L)
},
pos = 'CheckExEnv')

### * </HEADER>
library('SONO')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("MAXLEN_est")
### * MAXLEN_est

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: MAXLEN_est
### Title: Estimate MAXLEN
### Aliases: MAXLEN_est

### ** Examples

## No test: 
dt <- as.data.frame(sample(c(1:2), 100, replace = TRUE, prob = c(0.5, 0.5)))
dt <- cbind(dt, sample(c(1:3), 100, replace = TRUE, prob = c(0.5, 0.3, 0.2)))
dt[, 1] <- as.factor(dt[, 1])
dt[, 2] <- as.factor(dt[, 2])
colnames(dt) <- c('V1', 'V2')
MAXLEN_est(data = dt, probs = list(c(0.5, 0.5), c(1/3, 1/3, 1/3)), alpha = 0.01, frequent = FALSE)
## End(No test)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("MAXLEN_est", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("avg_rank_outs")
### * avg_rank_outs

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: avg_rank_outs
### Title: Average Rank Of Outlier
### Aliases: avg_rank_outs

### ** Examples

## No test: 
dt <- as.data.frame(sample(c(1:2), 100, replace = TRUE, prob = c(0.5, 0.5)))
dt <- cbind(dt, sample(c(1:3), 100, replace = TRUE, prob = c(0.5, 0.3, 0.2)))
dt[, 1] <- as.factor(dt[, 1])
dt[, 2] <- as.factor(dt[, 2])
colnames(dt) <- c('V1', 'V2')
sono_out <- sono(data = dt, probs = list(c(0.5, 0.5), c(1/3, 1/3, 1/3)),
alpha = 0.01, r = 2, MAXLEN = 0, frequent = FALSE)
# Suppose observations 1 up to 5 are outliers
avg_rank_outs(scores = sono_out[[2]][, 2], outs = c(1:5), ties = "min")
## End(No test)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("avg_rank_outs", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("recall_at_k")
### * recall_at_k

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: recall_at_k
### Title: Recall@K
### Aliases: recall_at_k

### ** Examples

## No test: 
dt <- as.data.frame(sample(c(1:2), 100, replace = TRUE, prob = c(0.5, 0.5)))
dt <- cbind(dt, sample(c(1:3), 100, replace = TRUE, prob = c(0.5, 0.3, 0.2)))
dt[, 1] <- as.factor(dt[, 1])
dt[, 2] <- as.factor(dt[, 2])
colnames(dt) <- c('V1', 'V2')
sono_out <- sono(data = dt,
probs = list(c(0.5, 0.5), c(1/3, 1/3, 1/3)),
alpha = 0.01,
r = 2,
MAXLEN = 0,
frequent = FALSE)
# Suppose observations 1 up to 5 are outliers
recall_at_k(scores = sono_out[[2]][, 2],
outs = c(1:5),
grid = c(1, 2.5, seq(5, 50, by = 5))/100)
## End(No test)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("recall_at_k", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("roc_auc")
### * roc_auc

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: roc_auc
### Title: ROC AUC function
### Aliases: roc_auc

### ** Examples

## No test: 
dt <- as.data.frame(sample(c(1:2), 100, replace = TRUE, prob = c(0.5, 0.5)))
dt <- cbind(dt, sample(c(1:3), 100, replace = TRUE, prob = c(0.5, 0.3, 0.2)))
dt[, 1] <- as.factor(dt[, 1])
dt[, 2] <- as.factor(dt[, 2])
colnames(dt) <- c('V1', 'V2')
sono_out <- sono(data = dt,
probs = list(c(0.5, 0.5), c(1/3, 1/3, 1/3)),
alpha = 0.01,
r = 2,
MAXLEN = 0,
frequent = FALSE)
# Suppose observations 1 up to 5 are outliers
roc_auc(scores = sono_out[[2]][, 2], outs = c(1:5),
grid = c(1, 2.5, seq(5, 50, by = 5))/100)
## End(No test)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("roc_auc", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("sono")
### * sono

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: sono
### Title: SONO (Scores Of Nominal Outlyingness)
### Aliases: sono

### ** Examples

## No test: 
dt <- as.data.frame(sample(c(1:2), 100, replace = TRUE, prob = c(0.5, 0.5)))
dt <- cbind(dt, sample(c(1:3), 100, replace = TRUE, prob = c(0.5, 0.3, 0.2)))
dt[, 1] <- as.factor(dt[, 1])
dt[, 2] <- as.factor(dt[, 2])
colnames(dt) <- c('V1', 'V2')
sono(data = dt,
probs = list(c(0.5, 0.5), c(1/3, 1/3, 1/3)),
alpha = 0.01,
r = 2,
MAXLEN = 0,
frequent = FALSE)
## End(No test)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("sono", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("vis_contribs")
### * vis_contribs

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: vis_contribs
### Title: Visualise Contribution Matrix
### Aliases: vis_contribs

### ** Examples

## No test: 
dt <- as.data.frame(sample(c(1:2), 100, replace = TRUE, prob = c(0.5, 0.5)))
dt <- cbind(dt, sample(c(1:3), 100, replace = TRUE, prob = c(0.5, 0.3, 0.2)))
dt[, 1] <- as.factor(dt[, 1])
dt[, 2] <- as.factor(dt[, 2])
colnames(dt) <- c('V1', 'V2')
sono_out <- sono(data = dt,
probs = list(c(0.5, 0.5), c(1/3, 1/3, 1/3)),
alpha = 0.01,
r = 2,
MAXLEN = 0,
frequent = FALSE)
vis_contribs(contribs_mat = sono_out[[3]], subset = c(1:50), scale = "row")
## End(No test)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("vis_contribs", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
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
>>>>>>> 5b1033a (First commit)
