# 加载必要的 R 包
library(openxlsx)
library(MASS)
library(ggplot2)
library(ggrepel)
library(dplyr)
# 读取数据
#data <- read.xlsx("/Users/jing/Documents/7-PhD_lab/5_research/4_metagenome_seq/1_first_try/5_kraken2_28_pathogen/2_pathogen_28_single_taxonomy/Detection/2_analysis_after_0528/Detection_19_CYVCV_R.xlsx")
#data <- read.xlsx("/Users/jing/Documents/7-PhD_lab/5_research/4_metagenome_seq/1_first_try/5_kraken2_28_pathogen/2_pathogen_28_single_taxonomy/Detection/2_analysis_after_0528/Detection_4_summary.xlsx")
data <- read.xlsx("/Users/jing/Documents/7-PhD_lab/5_research/4_metagenome_seq/1_first_try/5_kraken2_28_pathogen/2_pathogen_28_single_taxonomy/Detection/2_analysis_after_0528/Detection_20_summary.xlsx")
# 1. 准备数据
data$qPCR_diagnostic <- as.factor(data$qPCR_diagnostic)
features <- c("k_numreads", "k_perc_reads", "b_numreads", "b_covbases",
              "b_meandepth", "b_meanbaseq", "b_meanmapq", "EDNA_pvalue",
              "e_raw_hit_perc", "e_mean_identity", "e_n_eprobe_ide90", "e_mean_coverage",
              "e_n_eprobe_cov90", "e_sum_bitscore", "e_min_evalue", "e_n_positive_eprobes",
              "e_perc_positive_eprobes", "b_num_hits", "b_total_aligned_length", "b_sum_bitscore",
              "b_min_evalue", "b_avg_identity", "b_avg_coverage",
              "high_confidence_hit", "prop_of_target_aligned")
features <- features[-c(15, 21)]
# 保证没有 NA 并提取相关列
data_clean <- data %>%
  select(qPCR_diagnostic, all_of(features)) %>%
  na.omit()
# 2. 初始化预测结果向量
n <- nrow(data_clean)
y <- data_clean$qPCR_diagnostic
X <- data_clean[, features]
yhat <- factor(rep(NA, n), levels = levels(y))
# 3. LOOCV 循环
for (i in 1:n) {
  train_X <- X[-i, ]
  train_y <- y[-i]
  test_X  <- X[i, , drop = FALSE]
  # 训练 QDA 模型
  model_lda <- lda(train_X, grouping = train_y)
  # 预测类别
  pred <- predict(model_lda, newdata = test_X)$class
  yhat[i] <- pred
}
y
yhat
# 4. 混淆矩阵与性能指标
conf_mat <- table(Predicted = yhat, Actual = y)
print(conf_mat)
# 5. 计算准确率等
accuracy <- mean(yhat == y)
misclasificarion <- 1-accuracy
misclasificarion
cat("LOOCV Accuracy:", round(accuracy, 3), "\n")
# 可选：TPR, TNR, F1
TP <- if ("1" %in% rownames(conf_mat) && "1" %in% colnames(conf_mat)) conf_mat["1", "1"] else 0
TN <- if ("0" %in% rownames(conf_mat) && "0" %in% colnames(conf_mat)) conf_mat["0", "0"] else 0
FP <- if ("1" %in% rownames(conf_mat) && "0" %in% colnames(conf_mat)) conf_mat["1", "0"] else 0
FN <- if ("0" %in% rownames(conf_mat) && "1" %in% colnames(conf_mat)) conf_mat["0", "1"] else 0
TPR <- TP / (TP + FN)
TNR <- TN / (TN + FP)
FPR <- FP / (FP + TN)
FNR <- FN / (TP + FN)
cat("TPR (Sensitivity):", round(TPR, 3), "\n")
cat("TNR (Specificity):", round(TNR, 3), "\n")
cat("FPR:", round(FPR, 3), "\n")
cat("FNR:", round(FNR, 3), "\n")
colnames(X)[c(15, 21)]
X$b_min_evalue
X$e_min_evalue





################# ---------- 2 ----------- de EDNA features
# 读取数据
data <- read.xlsx("/Users/jing/Documents/7-PhD_lab/5_research/4_metagenome_seq/1_first_try/5_kraken2_28_pathogen/2_pathogen_28_single_taxonomy/Detection/2_analysis_after_0528/Detection_19_CYVCV_R.xlsx")
#data <- read.xlsx("/Users/jing/Documents/7-PhD_lab/5_research/4_metagenome_seq/1_first_try/5_kraken2_28_pathogen/2_pathogen_28_single_taxonomy/Detection/2_analysis_after_0528/Detection_4_summary.xlsx")
#data <- read.xlsx("/Users/jing/Documents/7-PhD_lab/5_research/4_metagenome_seq/1_first_try/5_kraken2_28_pathogen/2_pathogen_28_single_taxonomy/Detection/2_analysis_after_0528/Detection_20_summary.xlsx")
# 1. 准备数据
data$qPCR_diagnostic <- as.factor(data$qPCR_diagnostic)
features <- c("k_numreads", "k_perc_reads", "b_numreads", "b_covbases",
              "b_meandepth", "b_meanbaseq", "b_meanmapq", "b_num_hits", "b_total_aligned_length", "b_sum_bitscore",
              "b_min_evalue", "b_avg_identity", "b_avg_coverage",
              "high_confidence_hit", "prop_of_target_aligned")
# 保证没有 NA 并提取相关列
data_clean <- data %>%
  select(qPCR_diagnostic, all_of(features)) %>%
  na.omit()
# 2. 初始化预测结果向量
n <- nrow(data_clean)
y <- data_clean$qPCR_diagnostic
X <- data_clean[, features]
yhat <- factor(rep(NA, n), levels = levels(y))
# 3. LOOCV 循环
for (i in 1:n) {
  train_X <- X[-i, ]
  train_y <- y[-i]
  test_X  <- X[i, , drop = FALSE]
  # 训练 QDA 模型
  model_lda <- lda(train_X, grouping = train_y)
  # 预测类别
  pred <- predict(model_lda, newdata = test_X)$class
  yhat[i] <- pred
}
y
yhat
# 4. 混淆矩阵与性能指标
conf_mat <- table(Predicted = yhat, Actual = y)
print(conf_mat)
# 5. 计算准确率等
accuracy <- mean(yhat == y)
cat("LOOCV Accuracy:", round(accuracy, 3), "\n")
# 可选：TPR, TNR, F1
TP <- if ("1" %in% rownames(conf_mat) && "1" %in% colnames(conf_mat)) conf_mat["1", "1"] else 0
TN <- if ("0" %in% rownames(conf_mat) && "0" %in% colnames(conf_mat)) conf_mat["0", "0"] else 0
FP <- if ("1" %in% rownames(conf_mat) && "0" %in% colnames(conf_mat)) conf_mat["1", "0"] else 0
FN <- if ("0" %in% rownames(conf_mat) && "1" %in% colnames(conf_mat)) conf_mat["0", "1"] else 0
TPR <- TP / (TP + FN)
TNR <- TN / (TN + FP)
FPR <- FP / (FP + TN)
FNR <- FN / (TP + FN)
cat("TPR (Sensitivity):", round(TPR, 3), "\n")
cat("TNR (Specificity):", round(TNR, 3), "\n")
cat("FPR:", round(FPR, 3), "\n")
cat("FNR:", round(FNR, 3), "\n")







################# ---------- 3 ----------- EDNA features
# 读取数据
data <- read.xlsx("/Users/jing/Documents/7-PhD_lab/5_research/4_metagenome_seq/1_first_try/5_kraken2_28_pathogen/2_pathogen_28_single_taxonomy/Detection/2_analysis_after_0528/Detection_19_CYVCV_R.xlsx")
#data <- read.xlsx("/Users/jing/Documents/7-PhD_lab/5_research/4_metagenome_seq/1_first_try/5_kraken2_28_pathogen/2_pathogen_28_single_taxonomy/Detection/2_analysis_after_0528/Detection_4_summary.xlsx")
#data <- read.xlsx("/Users/jing/Documents/7-PhD_lab/5_research/4_metagenome_seq/1_first_try/5_kraken2_28_pathogen/2_pathogen_28_single_taxonomy/Detection/2_analysis_after_0528/Detection_20_summary.xlsx")
# 1. 准备数据
data$qPCR_diagnostic <- as.factor(data$qPCR_diagnostic)
features <- c("EDNA_pvalue",
              "e_raw_hit_perc", "e_mean_identity", "e_n_eprobe_ide90", "e_mean_coverage",
              "e_n_eprobe_cov90", "e_sum_bitscore", "e_min_evalue", "e_n_positive_eprobes",
              "e_perc_positive_eprobes")
# 保证没有 NA 并提取相关列
data_clean <- data %>%
  select(qPCR_diagnostic, all_of(features)) %>%
  na.omit()
# 2. 初始化预测结果向量
n <- nrow(data_clean)
y <- data_clean$qPCR_diagnostic
X <- data_clean[, features]
yhat <- factor(rep(NA, n), levels = levels(y))
# 3. LOOCV 循环
for (i in 1:n) {
  train_X <- X[-i, ]
  train_y <- y[-i]
  test_X  <- X[i, , drop = FALSE]
  # 训练 QDA 模型
  model_lda <- lda(train_X, grouping = train_y)
  # 预测类别
  pred <- predict(model_lda, newdata = test_X)$class
  yhat[i] <- pred
}
y
yhat
# 4. 混淆矩阵与性能指标
conf_mat <- table(Predicted = yhat, Actual = y)
print(conf_mat)
# 5. 计算准确率等
accuracy <- mean(yhat == y)
cat("LOOCV Accuracy:", round(accuracy, 3), "\n")
# 可选：TPR, TNR, F1
TP <- if ("1" %in% rownames(conf_mat) && "1" %in% colnames(conf_mat)) conf_mat["1", "1"] else 0
TN <- if ("0" %in% rownames(conf_mat) && "0" %in% colnames(conf_mat)) conf_mat["0", "0"] else 0
FP <- if ("1" %in% rownames(conf_mat) && "0" %in% colnames(conf_mat)) conf_mat["1", "0"] else 0
FN <- if ("0" %in% rownames(conf_mat) && "1" %in% colnames(conf_mat)) conf_mat["0", "1"] else 0
TPR <- TP / (TP + FN)
TNR <- TN / (TN + FP)
FPR <- FP / (FP + TN)
FNR <- FN / (TP + FN)
cat("TPR (Sensitivity):", round(TPR, 3), "\n")
cat("TNR (Specificity):", round(TNR, 3), "\n")
cat("FPR:", round(FPR, 3), "\n")
cat("FNR:", round(FNR, 3), "\n")