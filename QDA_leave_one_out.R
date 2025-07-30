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
# 保证没有 NA 并提取相关列
data_clean <- data %>%
  select(qPCR_diagnostic, all_of(features)) %>%
  na.omit()
############ ---------- PCA降维 ------------------############
# 标准化特征
numerical_data <- scale(data_clean %>% select(all_of(features)))
# 数值变量部分
X <- scale(numerical_data)
# PCA 降维，保留前几个主成分（如95%方差）
pca_result <- prcomp(X, scale. = TRUE)
summary(pca_result)  # 看解释方差比例
# 可视化主成分
pca_var <- pca_result$sdev^2
pca_var <- pca_var / sum(pca_var)  # 计算每个主成分的方差比例
pca_var <- pca_var[1:10]  # 只保留前10个主成分
pca_var <- pca_var * 100  # 转换为百分比
# 绘制主成分方差比例图
pca_var_df <- data.frame(PC = paste0("PC", 1:5), Variance = pca_var)
ggplot(pca_var_df, aes(x = PC, y = Variance)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  geom_text(aes(label = round(Variance, 1)), vjust = -0.5) +
  labs(title = "PCA Variance Explained", x = "Principal Component", y = "Variance (%)") +
  theme_minimal()
# 绘制主成分图
pca_data <- data.frame(pca_result$x[, 1:5])
colnames(pca_data)[1:5] <- paste0("PC", 1:5)
pca_data$qPCR_diagnostic <- data_clean$qPCR_diagnostic
ggplot(pca_data, aes(x = PC1, y = PC2, color = qPCR_diagnostic)) +
  geom_point(size = 3) +
  geom_text_repel(aes(label = pca_data$qPCR_diagnostic), size = 3) +
  labs(title = "PCA of Features", x = "PC1", y = "PC2") +
  theme_minimal() +
  scale_color_manual(values = c("red", "blue"))
# 计算主成分得分
pca_scores <- pca_result$x[, 1:5]  # 取前两个主成分
# 计算主成分得分
pca_scores <- as.data.frame(pca_scores)
pca_scores$qPCR_diagnostic <- data_clean$qPCR_diagnostic
############ -------------- QDA --------------############
# 2. 初始化预测结果向量
n <- nrow(pca_data)
y <- pca_data$qPCR_diagnostic
X <- pca_data[, 1:5]
yhat <- factor(rep(NA, n), levels = levels(y))
# 3. LOOCV 循环
for (i in 1:n) {
  train_X <- X[-i, ]
  train_y <- y[-i]
  test_X  <- X[i, , drop = FALSE]
  # 训练 QDA 模型
  model_qda <- qda(train_X, grouping = train_y)
  # 预测类别
  pred <- predict(model_qda, newdata = test_X)$class
  yhat[i] <- pred
}
y
yhat
# 4. 混淆矩阵与性能指标
conf_mat <- table(Predicted = yhat, Actual = y)
print(conf_mat)
# 5. 计算准确率等
accuracy <- mean(yhat == y)
missclassification <- 1-accuracy
missclassification
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
############ ---------- PCA降维 ------------------############
# 标准化特征
numerical_data <- scale(data_clean %>% select(all_of(features)))
# 数值变量部分
X <- scale(numerical_data)
# PCA 降维，保留前几个主成分（如95%方差）
pca_result <- prcomp(X, scale. = TRUE)
summary(pca_result)  # 看解释方差比例
# 可视化主成分
pca_var <- pca_result$sdev^2
pca_var <- pca_var / sum(pca_var)  # 计算每个主成分的方差比例
pca_var <- pca_var[1:10]  # 只保留前10个主成分
pca_var <- pca_var * 100  # 转换为百分比
# 绘制主成分方差比例图
pca_var_df <- data.frame(PC = paste0("PC", 1:5), Variance = pca_var)
ggplot(pca_var_df, aes(x = PC, y = Variance)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  geom_text(aes(label = round(Variance, 1)), vjust = -0.5) +
  labs(title = "PCA Variance Explained", x = "Principal Component", y = "Variance (%)") +
  theme_minimal()
# 绘制主成分图
pca_data <- data.frame(pca_result$x[, 1:5])
colnames(pca_data)[1:5] <- paste0("PC", 1:5)
pca_data$qPCR_diagnostic <- data_clean$qPCR_diagnostic
ggplot(pca_data, aes(x = PC1, y = PC2, color = qPCR_diagnostic)) +
  geom_point(size = 3) +
  geom_text_repel(aes(label = pca_data$qPCR_diagnostic), size = 3) +
  labs(title = "PCA of Features", x = "PC1", y = "PC2") +
  theme_minimal() +
  scale_color_manual(values = c("red", "blue"))
# 计算主成分得分
pca_scores <- pca_result$x[, 1:5]  # 取前两个主成分
# 计算主成分得分
pca_scores <- as.data.frame(pca_scores)
pca_scores$qPCR_diagnostic <- data_clean$qPCR_diagnostic
############ -------------- QDA --------------############
# 2. 初始化预测结果向量
n <- nrow(pca_data)
y <- pca_data$qPCR_diagnostic
X <- pca_data[, 1:5]
yhat <- factor(rep(NA, n), levels = levels(y))
# 3. LOOCV 循环
for (i in 1:n) {
  train_X <- X[-i, ]
  train_y <- y[-i]
  test_X  <- X[i, , drop = FALSE]
  # 训练 QDA 模型
  model_qda <- qda(train_X, grouping = train_y)
  # 预测类别
  pred <- predict(model_qda, newdata = test_X)$class
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
############ ---------- PCA降维 ------------------############
# 标准化特征
numerical_data <- scale(data_clean %>% select(all_of(features)))
# 数值变量部分
X <- scale(numerical_data)
# PCA 降维，保留前几个主成分（如95%方差）
pca_result <- prcomp(X, scale. = TRUE)
summary(pca_result)  # 看解释方差比例
# 可视化主成分
pca_var <- pca_result$sdev^2
pca_var <- pca_var / sum(pca_var)  # 计算每个主成分的方差比例
pca_var <- pca_var[1:10]  # 只保留前10个主成分
pca_var <- pca_var * 100  # 转换为百分比
# 绘制主成分方差比例图
pca_var_df <- data.frame(PC = paste0("PC", 1:5), Variance = pca_var)
ggplot(pca_var_df, aes(x = PC, y = Variance)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  geom_text(aes(label = round(Variance, 1)), vjust = -0.5) +
  labs(title = "PCA Variance Explained", x = "Principal Component", y = "Variance (%)") +
  theme_minimal()
# 绘制主成分图
pca_data <- data.frame(pca_result$x[, 1:5])
colnames(pca_data)[1:5] <- paste0("PC", 1:5)
pca_data$qPCR_diagnostic <- data_clean$qPCR_diagnostic
ggplot(pca_data, aes(x = PC1, y = PC2, color = qPCR_diagnostic)) +
  geom_point(size = 3) +
  geom_text_repel(aes(label = pca_data$qPCR_diagnostic), size = 3) +
  labs(title = "PCA of Features", x = "PC1", y = "PC2") +
  theme_minimal() +
  scale_color_manual(values = c("red", "blue"))
# 计算主成分得分
pca_scores <- pca_result$x[, 1:5]  # 取前两个主成分
# 计算主成分得分
pca_scores <- as.data.frame(pca_scores)
pca_scores$qPCR_diagnostic <- data_clean$qPCR_diagnostic
############ -------------- QDA --------------############
# 2. 初始化预测结果向量
n <- nrow(pca_data)
y <- pca_data$qPCR_diagnostic
X <- pca_data[, 1:5]
yhat <- factor(rep(NA, n), levels = levels(y))
# 3. LOOCV 循环
for (i in 1:n) {
  train_X <- X[-i, ]
  train_y <- y[-i]
  test_X  <- X[i, , drop = FALSE]
  # 训练 QDA 模型
  model_qda <- qda(train_X, grouping = train_y)
  # 预测类别
  pred <- predict(model_qda, newdata = test_X)$class
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
