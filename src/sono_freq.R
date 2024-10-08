# Nominal scores of outlyingness - frequent itemsets
sono_freq <- function(data, probs, alpha = 0.01, r = 2, MAXLEN = 0){
  ### INPUT CHECKS ###
  disc_cols <- c(1:ncol(data))
  if (!is.data.frame(data)){
    stop("Data set should be of class 'data.frame'.")
  }
  for (i in disc_cols){
    stopifnot("Discrete variables should be of class 'factor'." = (is.factor(data[, i])))
  }
  if (length(disc_cols)==1){
    data[, disc_cols] <- as.data.frame(data[, disc_cols])
  }
  stopifnot("alpha should be of class 'numeric'." = is.numeric(alpha))
  if (length(alpha) > 1){
    stop("alpha should be of unit length.")
  }
  if (alpha <= 0 | alpha > 0.20){
    stop("alpha should be positive and at most equal to 0.20.")
  }
  if (length(MAXLEN) > 1){
    stop("MAXLEN should be an integer at most equal to the number of discrete variables.")
  }
  if (MAXLEN %% 1 !=0){
    stop("MAXLEN should be an integer at most equal to the number of discrete variables.")
  }
  if (MAXLEN < 0 | MAXLEN > length(disc_cols)){
    stop("MAXLEN should be an integer at most equal to the number of discrete variables.")
  }
  ### END OF CHECKS ###
  # Get all power sets up to length MAXLEN
  # For MAXLEN we need to make sure that the threshold value s >= 2
  # In order to do that, we take combinations of variables and calculate s
  # Until we achieve s^u < 2
  # The above of course only applies as long as MAXLEN is set equal to 0
  MAXLEN_User <- FALSE
  if (MAXLEN == 0){
    MAXLEN_User <- TRUE
    if (length(disc_cols)==1){
      MAXLEN <- 1
    } else {
      # Max expected probabilities
      max_probs <- unlist(lapply(probs, max))
      ordered_max_probs <- order(max_probs, decreasing = TRUE)
      for (i in 1:length(disc_cols)){
        probs_vec <- Reduce(kronecker, probs[c(ordered_max_probs[1:i])])
        s <- max(floor(as.numeric(nrow(data) * DescTools::MultinomCI(probs_vec*nrow(data), conf.level=(1-2*alpha))[, 3])))
        if (s == nrow(data)){
          MAXLEN <- i-1
          break
        } else {
          MAXLEN <- i
        }
      }
    }
  }
  cat('MAXLEN:', MAXLEN, '\n')
  # Get power set
  powerset_test <- rje::powerSet(disc_cols, MAXLEN)
  cat('Power set object created. \n')
  
  # Empty list to store probability vectors
  probs_list <- list()
  
  # Empty list to store outlier scores data frames
  outlierdfs_list <- list()
  
  # create corresponding list of data frames with sequences for each data point
  for (i in disc_cols){
    data[,i] <- as.numeric(data[,i])
  }
  
  cat('Pre-processing done. \n')
  
  dfs <- list()
  # List with infrequent items and powersets
  freq_list <- list()
  for (i in rev(1:MAXLEN)){
    inxs <- which(sapply(X=powerset_test, FUN=length)==i)
    aux_vec <- c()
    for (j in inxs){
      nam <- "df"
      # Setting lower threshold value s
      for (k in 1:length(powerset_test[[j]])){
        nam <- paste(nam, powerset_test[[j]][k], sep="_")
      }
      probs_vec <- Reduce(kronecker, probs[powerset_test[[j]]])
      s_obj <- DescTools::MultinomCI(probs_vec*nrow(data), conf.level=(1-2*alpha))
      s <- as.numeric(nrow(data) * s_obj[, 3])
      s_probs <- s_obj[, 1]
      df <- data.frame('Sequence'=character(),
                       'Count'=integer(),
                       'Frequent'=logical(),
                       'Threshold' =numeric(),
                       stringsAsFactors = FALSE)
      rows <- c()
      if (length(freq_list)>0){
        for (k in 1:length(freq_list)){
          if (rje::is.subset(powerset_test[[j]], freq_list[[k]]$Variables)){
            loc_inx <- which(freq_list[[k]]$Variables %in% powerset_test[[j]])
            ifelse(length(powerset_test[[j]])>1, {
              rows <- c(rows,
                        which(sapply(1:nrow(data),
                                     FUN = function(i) check_vecs_equal(data[i, powerset_test[[j]]],
                                                                        vec2=as.numeric(strsplit(freq_list[[k]]$Sequence, split="_")[[1]])[loc_inx]))==length(powerset_test[[j]])))
            }, {
              rows <- c(rows,
                        which(data[, powerset_test[[j]]]==as.numeric(strsplit(freq_list[[k]]$Sequence, split = "_")[[1]])[loc_inx]))
            })
          }
        }
      }
      ifelse(length(rows)>0, dt <- data[-rows,powerset_test[[j]]], dt <- data[,powerset_test[[j]]])
      if (i==1){
        if (length(dt) == 0){
          newrow <- data.frame('Sequence' = 'X',
                               'Count' = Inf,
                               'Frequent' = TRUE,
                               'Threshold' = 0)
          df <- rbind(df, newrow)
          dfs[[nam]] <- assign(nam, df)
          next
        }
        tab <- table(dt)
        for (k in 1:length(tab)){
          df <- rbind(df, data.frame('Sequence'=names(tab)[k],
                                     'Count'=as.numeric(tab)[k],
                                     'Frequent'=as.numeric(tab)[k]>=s[as.numeric(names(tab)[k])],
                                     'Threshold'=s[as.numeric(names(tab)[k])]))
          if (as.numeric(tab)[k] >= s[as.numeric(names(tab)[k])]){
            freq_list[[length(freq_list)+1]] <- list("Variables"=powerset_test[[j]],
                                                     "Sequence"=names(tab)[k])
          }
        }
      } else {
        if (dim(dt)[1] == 0){
          newrow <- data.frame('Sequence' = 'X',
                               'Count' = Inf,
                               'Frequent' = TRUE,
                               'Threshold' = 0)
          df <- rbind(df, newrow)
          dfs[[nam]] <- assign(nam, df)
          next
        }
        for (k in 1:nrow(dt)){
          row <- dt[k,]
          rownam <- character()
          for (l in 1:length(row)){
            ifelse(l==1, rownam <- paste0(rownam, row[l]), rownam <- paste(rownam, row[l], sep="_"))
          }
          # Save sequences based on power set, with their support
          ifelse(rownam %in% df$Sequence,
                 {row_inx <- which(df$Sequence==rownam, arr.ind=TRUE)
                 df[row_inx, 2] <- df[row_inx, 2]+1},
                 {prod <- 1
                 probs_sublist <- probs[powerset_test[[j]]]
                 for (row_num in c(1:length(row))){
                   prod <- prod*probs_sublist[[row_num]][as.numeric(row[row_num])]
                 }
                 newrow <- data.frame('Sequence'=rownam,
                                      'Count'=1,
                                      'Frequent'=TRUE,
                                      'Threshold'=s[match_numeric(prod, s_probs)])
                 df <- rbind(df, newrow)})
        }
      }
      # Sort by increasing sequence name to be able to do comparison with thresholds
      df <- df[order(df$Sequence, decreasing = FALSE),]
      for (k in 1:nrow(df)){
        ifelse(df[k,2] <= df[k,4], df[k,3] <- FALSE, freq_list[[length(freq_list)+1]] <- list("Variables"=powerset_test[[j]],
                                                                                              "Sequence"=df[k,1]))
      }
      if (all(df[,4] == nrow(data)) | all(df[, 3])){
        aux_vec <- c(aux_vec, TRUE)
      } else {
        aux_vec <- c(aux_vec, FALSE)
      }
      dfs[[nam]] <- assign(nam, df)
    }
    if (all(aux_vec) & MAXLEN_User){
      MAXLEN <- i-1
      # Remove redundant dfs
      redundant_dfs <- as.numeric(which(sapply(dfs, function(df) sapply(df[1,1], count_digits))==i))
      dfs <- dfs[-redundant_dfs]
      break
    }
  }
  
  # Save outlyingness scores based on categorical variables
  outscoredf <- data.frame('Observation'=integer(),
                           'Score'=double(),
                           stringsAsFactors = FALSE)
  
  # Save cell-wise outlyingness scores
  outscoredfcells <- as.data.frame(matrix(rep(0, nrow(data)*length(disc_cols)),
                                          nrow = nrow(data)))
  colnames(outscoredfcells) <- colnames(data[, disc_cols])
  # Vector of depths
  nod_vec <- rep(0, nrow(data))
  nod_counts <- nod_vec
  for (i in 1:nrow(data)){
    cat('Observation', i, 'of', nrow(data), '\n')
    score <- 0
    count <- 1
    for (j in rev(1:MAXLEN)){
      inxs <- which(sapply(X=powerset_test, FUN=length)==j)
      for (k in inxs){
        row <- data[i,powerset_test[[k]]]
        rownam <- character()
        for (l in 1:length(row)){
          ifelse(l==1, rownam <- paste0(rownam, row[l]), rownam <- paste(rownam, row[l], sep="_"))
        }
        if (nrow(dfs[[count]]) == 1 & dfs[[count]][1,1] == "X"){
          count <- count + 1
          next
        }
        row_inx <- which(dfs[[count]]$Sequence==rownam, arr.ind=TRUE)
        if (length(row_inx)>0){
          add_score <- (dfs[[count]][row_inx, 3])*(dfs[[count]][row_inx,2])/(dfs[[count]][row_inx,4]* (MAXLEN - length(row) + 1)^r)
          nod_vec[i] <- nod_vec[i] + (dfs[[count]][row_inx, 3]) * (MAXLEN - j + 1)
          nod_counts[i] <- nod_counts[i] + 1*(dfs[[count]][row_inx, 3])
          score <- score + add_score
          if (length(disc_cols) > 1){
            for (l in powerset_test[[k]]){
              outscoredfcells[i, match_numeric(l, disc_cols)] <- outscoredfcells[i, match_numeric(l, disc_cols)] + add_score/length(powerset_test[[k]])
            }
          }
        }
        count <- count+1
        #cat('Count:', count, '\n')
      }
    }
    score_row <- data.frame('Observation'=i,
                            'Score'=score)
    outscoredf <- rbind(outscoredf, score_row)
  }
  
  if (length(disc_cols) == 1){
    outscoredfcells <- as.matrix(outscoredf[, 2], ncol = 1)
    colnames(outscoredfcells) <- colnames(data[, disc_cols])
    outscoredfcells <- as.data.frame(outscoredfcells)
  }
  # Compute average depth
  nod_vec[which(nod_vec > 0)] <- nod_vec[which(nod_vec > 0)]/nod_counts[which(nod_vec > 0)]
  
  cat('Outlyingness scores for discrete variables calculated.\n')
  return(list('MAXLEN'=MAXLEN, 'Discrete Scores'=outscoredf, 'Contributions'=outscoredfcells, 'Depth'=nod_vec))
}
