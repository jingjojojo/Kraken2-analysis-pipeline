########----------------------- penalized logistics regression 
library(openxlsx)
library(glmnet)
data <- read.xlsx("/Users/jing/Documents/7-PhD_lab/5_research/4_metagenome_seq/1_first_try/5_kraken2_28_pathogen/2_pathogen_28_single_taxonomy/Detection/2_analysis_after_0528/Detection_19_CYVCV_R.xlsx")
#data <- read.xlsx("/Users/jing/Documents/7-PhD_lab/5_research/4_metagenome_seq/1_first_try/5_kraken2_28_pathogen/2_pathogen_28_single_taxonomy/Detection/2_analysis_after_0528/Detection_4_summary.xlsx")
#data <- read.xlsx("/Users/jing/Documents/7-PhD_lab/5_research/4_metagenome_seq/1_first_try/5_kraken2_28_pathogen/2_pathogen_28_single_taxonomy/Detection/2_analysis_after_0528/Detection_20_summary.xlsx")
# -------------------------LASSO regression (will select the predictors)
X <- model.matrix(qPCR_diagnostic~ k_numreads+k_perc_reads+b_covbases
                  +b_numreads+b_coverage+b_meandepth+b_meanbaseq+b_meanmapq+EDNA_pvalue+e_raw_hit_perc+
                    e_mean_identity+e_n_eprobe_ide90+e_mean_coverage+e_n_eprobe_cov90+e_sum_bitscore+
                    e_min_evalue+e_n_positive_eprobes+e_perc_positive_eprobes+b_num_hits+b_total_aligned_length+
                    b_sum_bitscore+b_min_evalue+b_avg_identity+b_avg_coverage+high_confidence_hit+prop_of_target_aligned-1,
                  data = data)
str(X)
# Ensure the response variable is numeric (0/1)
y <- data$qPCR_diagnostic  # 确保是 numeric 0/1
# Set empty yhat to store predicted values
yhat<-rep(NULL,nrow(X))
# LOOCV to get the yhats
# CV 1 (to get estimates)
for (i in 1:nrow(X)){
  # LOOCV to get the optimal lambda
  # CV 2 (to get the optimal lambda)
  fit<-cv.glmnet(X[-i,],y[-i], nfolds = nrow(X[-i,]), alpha = 1, family = "binomial")
  lambda.hat<-fit$lambda.min
  # Fit the model with the proper lambda
  fit<-glmnet(X[-i,],y[-i], lambda = lambda.hat,alpha=1, family = "binomial")
  # Get prediction for row i with the proper model with the proper lambda
  yhat[i]<- predict(fit,lambda = lambda.hat,newx=X[i, , drop = FALSE], type = "response")
}
# Convert probabilities to class labels
yhat.class <- ifelse(yhat > 0.5, 1, 0)
# Misclassification error rate
mean(yhat.class != y)
# 计算混淆矩阵
table_result <- table(Predicted = yhat.class, Actual = y)
print(table_result)
TP <- table_result["1", "1"]
TN <- table_result["0", "0"]
FP <- table_result["1", "0"]
FN <- table_result["0", "1"]
# True Positive Rate = Recall = Sensitivity
TPR <- TP / (TP + FN)
TNR <- TN / (TN + FP)
FPR <- FP / (FP + TN)
FNR <- FN / (TP + FN)
TPR
TNR
FPR
FNR
# Accuracy
# ACC <- (TP + TN) / (TP + TN + FP + FN)
# F1-score
# F1 <- 2 * (PPV * TPR) / (PPV + TPR)







############## -----------2---------- de-EDNA features
data <- read.xlsx("/Users/jing/Documents/7-PhD_lab/5_research/4_metagenome_seq/1_first_try/5_kraken2_28_pathogen/2_pathogen_28_single_taxonomy/Detection/2_analysis_after_0528/Detection_19_CYVCV_R.xlsx")
X <- model.matrix(qPCR_diagnostic~ k_numreads+k_perc_reads+b_covbases
                  +b_numreads+b_coverage+b_meandepth+b_meanbaseq+b_meanmapq+b_num_hits+b_total_aligned_length+
                    b_sum_bitscore+b_min_evalue+b_avg_identity+b_avg_coverage+high_confidence_hit+prop_of_target_aligned-1,
                  data = data)
str(X)
table(data$qPCR_diagnostic)
# Ensure the response variable is numeric (0/1)
# y <- data$qPCR_diagnostic  # 确保是 numeric 0/1
y <- as.numeric(as.character(data$qPCR_diagnostic))
# Set empty yhat to store predicted values
yhat<-rep(NULL,nrow(X))
# LOOCV to get the yhats
# CV 1 (to get estimates)
for (i in 1:nrow(X)){
  # LOOCV to get the optimal lambda
  # CV 2 (to get the optimal lambda)
  fit<-cv.glmnet(X[-i,],y[-i], nfolds = nrow(X[-i,]), alpha = 1, family = "binomial")
  lambda.hat<-fit$lambda.min
  # Fit the model with the proper lambda
  fit<-glmnet(X[-i,],y[-i], lambda = lambda.hat,alpha=1, family = "binomial")
  # Get prediction for row i with the proper model with the proper lambda
  yhat[i]<- predict(fit,lambda = lambda.hat,newx=X[i, , drop = FALSE], type = "response")
}
print(lambda.hat)
# Convert probabilities to class labels
yhat.class <- ifelse(yhat > 0.5, 1, 0)
y
yhat
yhat.class
# Misclassification error rate
mean(yhat.class != y)
# 计算混淆矩阵
table_result <- table(Predicted = yhat.class, Actual = y)
print(table_result)
TP <- table_result["1", "1"]
TN <- table_result["0", "0"]
FP <- table_result["1", "0"]
FN <- table_result["0", "1"]
# True Positive Rate = Recall = Sensitivity
TPR <- TP / (TP + FN)
TNR <- TN / (TN + FP)
FPR <- FP / (FP + TN)
FNR <- FN / (TP + FN)
TPR
TNR
FPR
FNR
# Accuracy
# ACC <- (TP + TN) / (TP + TN + FP + FN)
# F1-score
# F1 <- 2 * (PPV * TPR) / (PPV + TPR)







############## -----------3---------- EDNA features
data <- read.xlsx("/Users/jing/Documents/7-PhD_lab/5_research/4_metagenome_seq/1_first_try/5_kraken2_28_pathogen/2_pathogen_28_single_taxonomy/Detection/2_analysis_after_0528/Detection_19_CYVCV_R.xlsx")
X <- model.matrix(qPCR_diagnostic~ EDNA_pvalue+e_raw_hit_perc+
                    e_mean_identity+e_n_eprobe_ide90+e_mean_coverage+e_n_eprobe_cov90+e_sum_bitscore+
                    e_min_evalue+e_n_positive_eprobes+e_perc_positive_eprobes-1,
                  data = data)
str(X)
# Ensure the response variable is numeric (0/1)
y <- data$qPCR_diagnostic  # 确保是 numeric 0/1
# Set empty yhat to store predicted values
yhat<-rep(NULL,nrow(X))
# LOOCV to get the yhats
# CV 1 (to get estimates)
for (i in 1:nrow(X)){
  # LOOCV to get the optimal lambda
  # CV 2 (to get the optimal lambda)
  fit<-cv.glmnet(X[-i,],y[-i], nfolds = nrow(X[-i,]), alpha = 1, family = "binomial")
  lambda.hat<-fit$lambda.min
  # Fit the model with the proper lambda
  fit<-glmnet(X[-i,],y[-i], lambda = lambda.hat,alpha=1, family = "binomial")
  # Get prediction for row i with the proper model with the proper lambda
  yhat[i]<- predict(fit,lambda = lambda.hat,newx=X[i, , drop = FALSE], type = "response")
}
# Convert probabilities to class labels
yhat.class <- ifelse(yhat > 0.5, 1, 0)
# Misclassification error rate
mean(yhat.class != y)
# 计算混淆矩阵
table_result <- table(Predicted = yhat.class, Actual = y)
print(table_result)
TP <- table_result["1", "1"]
TN <- table_result["0", "0"]
FP <- table_result["1", "0"]
FN <- table_result["0", "1"]
# True Positive Rate = Recall = Sensitivity
TPR <- TP / (TP + FN)
TNR <- TN / (TN + FP)
FPR <- FP / (FP + TN)
FNR <- FN / (TP + FN)
TPR
TNR
FPR
FNR
# Accuracy
# ACC <- (TP + TN) / (TP + TN + FP + FN)
# F1-score
# F1 <- 2 * (PPV * TPR) / (PPV + TPR)