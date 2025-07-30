# library 
library(openxlsx)
library(caret)
library(pROC)
library(MASS)
library(dplyr)
library(ggplot2)
library(tree)
library(tidyverse)
# load data
# data <- read.xlsx("/Users/jing/Documents/7-PhD_lab/5_research/4_metagenome_seq/1_first_try/5_kraken2_28_pathogen/2_pathogen_28_single_taxonomy/Detection/2_analysis_after_0528/Detection_19_CYVCV_R.xlsx")
# data <- read.xlsx("/Users/jing/Documents/7-PhD_lab/5_research/4_metagenome_seq/1_first_try/5_kraken2_28_pathogen/2_pathogen_28_single_taxonomy/Detection/2_analysis_after_0528/Detection_4_summary.xlsx")
data <- read.xlsx("/Users/jing/Documents/7-PhD_lab/5_research/4_metagenome_seq/1_first_try/5_kraken2_28_pathogen/2_pathogen_28_single_taxonomy/Detection/2_analysis_after_0528/Detection_20_summary.xlsx")
str(data)
# 1. 长格式转换
data_long <- data %>%
  pivot_longer(
    cols = c(k_numreads,k_perc_reads,b_covbases,b_numreads,b_coverage,
             b_meandepth,b_meanbaseq,b_meanmapq,EDNA_pvalue,e_raw_hit_perc,
             e_mean_identity,e_n_eprobe_ide90,e_mean_coverage,e_n_eprobe_cov90,
             e_sum_bitscore,e_min_evalue,e_n_positive_eprobes,e_perc_positive_eprobes,b_num_hits,
             b_total_aligned_length,b_sum_bitscore,b_min_evalue,b_avg_identity,b_avg_coverage,
             high_confidence_hit,prop_of_target_aligned),
    names_to = "Variable",
    values_to = "Value"
  )
####### data Y transfer to factor
data$qPCR_diagnostic <- as.factor(data$qPCR_diagnostic)
str(data)
#--------------Random Forest-------------------
library(randomForest)
set.seed(42)
# 设置特征变量
features <- c("k_numreads", "k_perc_reads", "b_numreads", "b_covbases","b_coverage",
              "b_meandepth", "b_meanbaseq", "b_meanmapq","EDNA_pvalue",
              "e_raw_hit_perc","e_mean_identity","e_n_eprobe_ide90","e_mean_coverage",
              "e_n_eprobe_cov90","e_sum_bitscore","e_min_evalue","e_n_positive_eprobes",
              "e_perc_positive_eprobes","b_num_hits","b_total_aligned_length","b_sum_bitscore",
              "b_min_evalue","b_avg_identity","b_avg_coverage",
              "high_confidence_hit","prop_of_target_aligned")
X <- model.matrix(qPCR_diagnostic~ k_numreads+k_perc_reads+b_covbases
                  +b_numreads+b_coverage+b_meandepth+b_meanbaseq+b_meanmapq+EDNA_pvalue+e_raw_hit_perc+
                    e_mean_identity+e_n_eprobe_ide90+e_mean_coverage+e_n_eprobe_cov90+e_sum_bitscore+
                    e_min_evalue+e_n_positive_eprobes+e_perc_positive_eprobes+b_num_hits+b_total_aligned_length+
                    b_sum_bitscore+b_min_evalue+b_avg_identity+b_avg_coverage+high_confidence_hit+prop_of_target_aligned-1,
                  data = data)
y <- data$qPCR_diagnostic
# Set empty yhat to store predicted values
# yhat<-rep(NULL,nrow(X))
yhat <- factor(rep(NA, nrow(X)), levels = levels(y))  # 明确指定 levels = c("0", "1")
# LOOCV：每次留一个样本做测试
for (i in 1:nrow(X)) {
  train_X <- X[-i, ]
  train_y <- y[-i]
  test_X  <- X[i, , drop = FALSE]
  # 训练随机森林模型
  rf_model <- randomForest(x = train_X, y = train_y, 
                           ntree = 500, mtry = 3, importance = TRUE)
  # 预测类别（多数类）
  yhat[i] <- predict(rf_model, newdata = test_X)
}
y
yhat
#网格搜索手动调优
errors <- c()
mtry_values <- 1:10  # 你也可以尝试更大的范围
 for (m in mtry_values) {
  model <- randomForest(x = X, y = y, ntree = 500, mtry = m)
  errors <- c(errors, model$err.rate[500, "OOB"])  # 第500棵树的OOB错误率
  }
plot(mtry_values, errors, type = "b", xlab = "mtry", ylab = "OOB Error Rate")
# Misclassification error rate
mean(yhat != y)
# 计算混淆矩阵
table_result <- table(Predicted = yhat, Actual = y)
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





################# ---------2---------de-EDNA features
# load data
data <- read.xlsx("/Users/jing/Documents/7-PhD_lab/5_research/4_metagenome_seq/1_first_try/5_kraken2_28_pathogen/2_pathogen_28_single_taxonomy/Detection/2_analysis_after_0528/Detection_19_CYVCV_R.xlsx")
#data <- read.xlsx("/Users/jing/Documents/7-PhD_lab/5_research/4_metagenome_seq/1_first_try/5_kraken2_28_pathogen/2_pathogen_28_single_taxonomy/Detection/2_analysis_after_0528/Detection_4_summary.xlsx")
#data <- read.xlsx("/Users/jing/Documents/7-PhD_lab/5_research/4_metagenome_seq/1_first_try/5_kraken2_28_pathogen/2_pathogen_28_single_taxonomy/Detection/2_analysis_after_0528/Detection_20_summary.xlsx")
str(data)
# 1. 长格式转换
data_long <- data %>%
  pivot_longer(
    cols = c(k_numreads,k_perc_reads,b_covbases,b_numreads,b_coverage,
             b_meandepth,b_meanbaseq,b_meanmapq,b_num_hits,
             b_total_aligned_length,b_sum_bitscore,b_min_evalue,b_avg_identity,b_avg_coverage,
             high_confidence_hit,prop_of_target_aligned),
    names_to = "Variable",
    values_to = "Value"
  )
####### data Y transfer to factor
data$qPCR_diagnostic <- as.factor(data$qPCR_diagnostic)
str(data)
#--------------Random Forest-------------------
library(randomForest)
set.seed(42)
# 设置特征变量
features <- c("k_numreads", "k_perc_reads", "b_numreads", "b_covbases",
              "b_meandepth", "b_meanbaseq", "b_meanmapq","b_num_hits","b_total_aligned_length","b_sum_bitscore",
              "b_min_evalue","b_avg_identity","b_avg_coverage",
              "high_confidence_hit","prop_of_target_aligned")
X <- model.matrix(qPCR_diagnostic~ k_numreads+k_perc_reads+b_covbases
                  +b_numreads+b_coverage+b_meandepth+b_meanbaseq+b_meanmapq+b_num_hits+b_total_aligned_length+
                    b_sum_bitscore+b_min_evalue+b_avg_identity+b_avg_coverage+high_confidence_hit+prop_of_target_aligned-1,
                  data = data)
y <- data$qPCR_diagnostic
#网格搜索手动调优
errors <- c()
mtry_values <- 1:10  # 你也可以尝试更大的范围
for (m in mtry_values) {
  model <- randomForest(x = X, y = y, ntree = 500, mtry = m)
  errors <- c(errors, model$err.rate[500, "OOB"])  # 第500棵树的OOB错误率
}
plot(mtry_values, errors, type = "b", xlab = "mtry", ylab = "OOB Error Rate")
# Set empty yhat to store predicted values
# yhat<-rep(NULL,nrow(X))
yhat <- factor(rep(NA, nrow(X)), levels = levels(y))  # 明确指定 levels = c("0", "1")
# LOOCV：每次留一个样本做测试
for (i in 1:nrow(X)) {
  train_X <- X[-i, ]
  train_y <- y[-i]
  test_X  <- X[i, , drop = FALSE]
  # 训练随机森林模型
  rf_model <- randomForest(x = train_X, y = train_y, 
                           ntree = 500, mtry = 3, importance = TRUE)
  # 预测类别（多数类）
  yhat[i] <- predict(rf_model, newdata = test_X)
}
y
yhat
# Misclassification error rate
mean(yhat != y)
# 计算混淆矩阵
table_result <- table(Predicted = yhat, Actual = y)
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








################# ---------3---------EDNA features
# load data
data <- read.xlsx("/Users/jing/Documents/7-PhD_lab/5_research/4_metagenome_seq/1_first_try/5_kraken2_28_pathogen/2_pathogen_28_single_taxonomy/Detection/2_analysis_after_0528/Detection_19_CYVCV_R.xlsx")
#data <- read.xlsx("/Users/jing/Documents/7-PhD_lab/5_research/4_metagenome_seq/1_first_try/5_kraken2_28_pathogen/2_pathogen_28_single_taxonomy/Detection/2_analysis_after_0528/Detection_4_summary.xlsx")
#data <- read.xlsx("/Users/jing/Documents/7-PhD_lab/5_research/4_metagenome_seq/1_first_try/5_kraken2_28_pathogen/2_pathogen_28_single_taxonomy/Detection/2_analysis_after_0528/Detection_20_summary.xlsx")
str(data)
# 1. 长格式转换
data_long <- data %>%
  pivot_longer(
    cols = c(EDNA_pvalue,e_raw_hit_perc,
             e_mean_identity,e_n_eprobe_ide90,e_mean_coverage,e_n_eprobe_cov90,
             e_sum_bitscore,e_min_evalue,e_n_positive_eprobes,e_perc_positive_eprobes),
    names_to = "Variable",
    values_to = "Value"
  )
####### data Y transfer to factor
data$qPCR_diagnostic <- as.factor(data$qPCR_diagnostic)
str(data)
#--------------Random Forest-------------------
library(randomForest)
set.seed(42)
# 设置特征变量
features <- c("EDNA_pvalue",
              "e_raw_hit_perc","e_mean_identity","e_n_eprobe_ide90","e_mean_coverage",
              "e_n_eprobe_cov90","e_sum_bitscore","e_min_evalue","e_n_positive_eprobes",
              "e_perc_positive_eprobes")
X <- model.matrix(qPCR_diagnostic~ EDNA_pvalue+e_raw_hit_perc+
                    e_mean_identity+e_n_eprobe_ide90+e_mean_coverage+e_n_eprobe_cov90+e_sum_bitscore+
                    e_min_evalue+e_n_positive_eprobes+e_perc_positive_eprobes-1,
                  data = data)
y <- data$qPCR_diagnostic
# Set empty yhat to store predicted values
# yhat<-rep(NULL,nrow(X))
yhat <- factor(rep(NA, nrow(X)), levels = levels(y))  # 明确指定 levels = c("0", "1")
# LOOCV：每次留一个样本做测试
for (i in 1:nrow(X)) {
  train_X <- X[-i, ]
  train_y <- y[-i]
  test_X  <- X[i, , drop = FALSE]
  # 训练随机森林模型
  rf_model <- randomForest(x = train_X, y = train_y, 
                           ntree = 500, mtry = 6, importance = TRUE)
  # 预测类别（多数类）
  yhat[i] <- predict(rf_model, newdata = test_X)
}
y
yhat
# Misclassification error rate
mean(yhat != y)
# 计算混淆矩阵
table_result <- table(Predicted = yhat, Actual = y)
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
