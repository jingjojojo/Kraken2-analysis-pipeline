# ---------- 加载必要的包 ----------
library(openxlsx)
library(glmnet)
library(MASS)
library(randomForest)
library(pROC)
library(dplyr)

# ---------- 读取数据 ----------
data <- read.xlsx("/Users/jing/Documents/7-PhD_lab/5_research/4_metagenome_seq/1_first_try/5_kraken2_28_pathogen/2_pathogen_28_single_taxonomy/Detection/2_analysis_after_0528/Detection_19_CYVCV_R.xlsx")
data$qPCR_diagnostic <- as.factor(data$qPCR_diagnostic)

# ---------- 定义特征 ----------
features <- c("k_numreads", "k_perc_reads", "b_numreads", "b_covbases", "b_coverage",
              "b_meandepth", "b_meanbaseq", "b_meanmapq", "EDNA_pvalue",
              "e_raw_hit_perc", "e_mean_identity", "e_n_eprobe_ide90", "e_mean_coverage",
              "e_n_eprobe_cov90", "e_sum_bitscore", "e_min_evalue", "e_n_positive_eprobes",
              "e_perc_positive_eprobes", "b_num_hits", "b_total_aligned_length", "b_sum_bitscore",
              "b_min_evalue", "b_avg_identity", "b_avg_coverage",
              "high_confidence_hit", "prop_of_target_aligned")

# ---------- 清洗数据 ----------
data_clean <- data %>%
  select(qPCR_diagnostic, all_of(features)) %>%
  na.omit()

X_full <- model.matrix(qPCR_diagnostic ~ . -1, data = data_clean)
y <- as.numeric(as.character(data_clean$qPCR_diagnostic))
n <- nrow(X_full)

# ---------- 初始化预测结果 ----------
yhat_lasso <- numeric(n)
yhat_ridge <- numeric(n)
yhat_lda   <- numeric(n)
yhat_qda   <- numeric(n)
yhat_rf    <- numeric(n)

# ---------- PCA 降维用于 QDA ----------
X_scaled <- scale(X_full)
pca_result <- prcomp(X_scaled, scale. = TRUE)
X_qda <- pca_result$x[, 1:5]  # 前5个主成分

# ---------- LOOCV ----------
for (i in 1:n) {
  idx <- (1:n)[-i]
  # LASSO
  cv_lasso <- cv.glmnet(X_full[idx,], y[idx], alpha = 1, family = "binomial", nfolds = n-1)
  m_lasso  <- glmnet(X_full[idx,], y[idx], alpha = 1, family = "binomial", lambda = cv_lasso$lambda.min)
  yhat_lasso[i] <- predict(m_lasso, newx = X_full[i,,drop=FALSE], type = "response")
  # Ridge
  cv_ridge <- cv.glmnet(X_full[idx,], y[idx], alpha = 0, family = "binomial", nfolds = n-1)
  m_ridge  <- glmnet(X_full[idx,], y[idx], alpha = 0, family = "binomial", lambda = cv_ridge$lambda.min)
  yhat_ridge[i] <- predict(m_ridge, newx = X_full[i,,drop=FALSE], type = "response")
  # LDA
  lda_model <- lda(X_full[idx,], grouping = as.factor(y[idx]))
  yhat_lda[i] <- predict(lda_model, newdata = X_full[i,,drop=FALSE])$posterior[,"1"]
  # QDA (on PCA data)
  qda_model <- qda(X_qda[idx,], grouping = as.factor(y[idx]))
  yhat_qda[i] <- predict(qda_model, newdata = X_qda[i,,drop=FALSE])$posterior[,"1"]
  # Random Forest
  rf_model <- randomForest(x = X_full[idx,], y = as.factor(y[idx]), ntree = 500, mtry = 3)
  yhat_rf[i] <- predict(rf_model, newdata = X_full[i,,drop=FALSE], type = "prob")[,"1"]
}
yhat_lasso
yhat_ridge
yhat_lda
yhat_qda
yhat_rf

# 找出真实标签为 positive (y == 1) 的样本
positive_indices <- which(y == 1)
# 取这些 positive 样本在 LASSO 模型中的预测概率
positive_probs <- yhat_lasso[positive_indices]
# 找到最小概率对应的位置（在 positive_indices 中的下标）
min_index_in_positive <- which.min(positive_probs)
max_index_in_positive <- which.max(positive_probs)
# 获取该样本的原始编号
lowest_prob_positive_sample <- positive_indices[min_index_in_positive]
highest_prob_positive_sample <- positive_indices[max_index_in_positive]
# 输出
cat("预测概率最低的正类样本编号是：", lowest_prob_positive_sample, "\n")
cat("其预测概率为：", yhat_lasso[lowest_prob_positive_sample], "\n")

cat("预测概率最高的正类样本编号是：", highest_prob_positive_sample, "\n")
cat("其预测概率为：", yhat_lasso[highest_prob_positive_sample], "\n")




############## -----------2---------- de-EDNA features
# ---------- 定义特征 ----------
features_sub1 <- c("k_numreads", "k_perc_reads", "b_numreads", "b_covbases", "b_coverage",
              "b_meandepth", "b_meanbaseq", "b_meanmapq", "b_num_hits", "b_total_aligned_length", "b_sum_bitscore",
              "b_min_evalue", "b_avg_identity", "b_avg_coverage",
              "high_confidence_hit", "prop_of_target_aligned")
# ---------- 清洗数据 ----------
data_clean_sub1 <- data %>%
  select(qPCR_diagnostic, all_of(features_sub1)) %>%
  na.omit()
X_full_sub1 <- model.matrix(qPCR_diagnostic ~ . -1, data = data_clean_sub1)
y_sub1 <- as.numeric(as.character(data_clean_sub1$qPCR_diagnostic))
n_sub1 <- nrow(X_full_sub1)
# ---------- 初始化预测结果 ----------
yhat_ridge_sub1 <- numeric(n_sub1)
yhat_lda_sub1   <- numeric(n_sub1)
yhat_rf_sub1   <- numeric(n_sub1)
# ---------- PCA 降维用于 QDA ----------
X_scaled_sub1 <- scale(X_full_sub1)
pca_result_sub1 <- prcomp(X_scaled_sub1, scale. = TRUE)
X_qda_sub1 <- pca_result_sub1$x[, 1:5]  # 前5个主成分
# ---------- LOOCV ----------
for (i in 1:n_sub1) {
  idx_sub1 <- (1:n_sub1)[-i]
  # Ridge
  cv_ridge_sub1 <- cv.glmnet(X_full_sub1[idx_sub1,], y_sub1[idx_sub1], alpha = 0, family = "binomial", nfolds = n_sub1 - 1)
  m_ridge_sub1  <- glmnet(X_full_sub1[idx_sub1,], y_sub1[idx_sub1], alpha = 0, family = "binomial", lambda = cv_ridge_sub1$lambda.min)
  yhat_ridge_sub1[i] <- predict(m_ridge_sub1, newx = X_full_sub1[i,,drop=FALSE], type = "response")
  # LDA
  lda_model_sub1 <- lda(X_full_sub1[idx_sub1,], grouping = as.factor(y_sub1[idx_sub1]))
  yhat_lda_sub1[i] <- predict(lda_model_sub1, newdata = X_full_sub1[i,,drop=FALSE])$posterior[,"1"]
  # Random Forest
  rf_model_sub1 <- randomForest(x = X_full_sub1[idx_sub1,], y = as.factor(y_sub1[idx_sub1]), ntree = 500, mtry = 3)
  yhat_rf_sub1[i] <- predict(rf_model_sub1, newdata = X_full_sub1[i,,drop=FALSE], type = "prob")[,"1"]
  }
yhat_ridge_sub1
yhat_lda_sub1
yhat_rf_sub1







############## -----------3---------- EDNA features
# ---------- 定义特征 ----------
features_sub2 <- c( "EDNA_pvalue",
                   "e_raw_hit_perc", "e_mean_identity", "e_n_eprobe_ide90", "e_mean_coverage",
                   "e_n_eprobe_cov90", "e_sum_bitscore", "e_min_evalue", "e_n_positive_eprobes",
                   "e_perc_positive_eprobes")
# ---------- 清洗数据 ----------
data_clean_sub2 <- data %>%
  select(qPCR_diagnostic, all_of(features_sub2)) %>%
  na.omit()
X_full_sub2 <- model.matrix(qPCR_diagnostic ~ . -1, data = data_clean_sub2)
y_sub2 <- as.numeric(as.character(data_clean_sub2$qPCR_diagnostic))
n_sub2 <- nrow(X_full_sub2)
# ---------- 初始化预测结果 ----------
yhat_lasso_sub2 <- numeric(n_sub2)
yhat_ridge_sub2 <- numeric(n_sub2)
yhat_lda_sub2   <- numeric(n_sub2)
yhat_qda_sub2   <- numeric(n_sub2)
yhat_rf_sub2   <- numeric(n_sub2)
# ---------- PCA 降维用于 QDA ----------
X_scaled_sub2 <- scale(X_full_sub2)
pca_result_sub2 <- prcomp(X_scaled_sub2, scale. = TRUE)
X_qda_sub2 <- pca_result_sub2$x[, 1:5]  # 前5个主成分
# ---------- LOOCV ----------
for (i in 1:n_sub2) {
  idx_sub2 <- (1:n_sub2)[-i]
  # LASSO
  cv_lasso_sub2 <- cv.glmnet(X_full_sub2[idx_sub2,], y_sub2[idx_sub2], alpha = 1, family = "binomial", nfolds = n_sub2-1)
  m_lasso_sub2  <- glmnet(X_full_sub2[idx_sub2,], y_sub2[idx_sub2], alpha = 1, family = "binomial", lambda = cv_lasso_sub2$lambda.min)
  yhat_lasso_sub2[i] <- predict(m_lasso_sub2, newx = X_full_sub2[i,,drop=FALSE], type = "response")
  # Ridge
  cv_ridge_sub2 <- cv.glmnet(X_full_sub2[idx_sub2,], y_sub2[idx_sub2], alpha = 0, family = "binomial", nfolds = n_sub2 - 1)
  m_ridge_sub2  <- glmnet(X_full_sub2[idx_sub2,], y_sub2[idx_sub2], alpha = 0, family = "binomial", lambda = cv_ridge_sub2$lambda.min)
  yhat_ridge_sub2[i] <- predict(m_ridge_sub2, newx = X_full_sub2[i,,drop=FALSE], type = "response")
  # LDA
  lda_model_sub2 <- lda(X_full_sub2[idx_sub2,], grouping = as.factor(y_sub2[idx_sub2]))
  yhat_lda_sub2[i] <- predict(lda_model_sub2, newdata = X_full_sub2[i,,drop=FALSE])$posterior[,"1"]
  # QDA (on PCA data)
  qda_model_sub2 <- qda(X_qda_sub2[idx_sub2,], grouping = as.factor(y_sub2[idx_sub2]))
  yhat_qda_sub2[i] <- predict(qda_model_sub2, newdata = X_qda_sub2[i,,drop=FALSE])$posterior[,"1"]
  # Random Forest
  rf_model_sub2 <- randomForest(x = X_full_sub2[idx_sub2,], y = as.factor(y_sub2[idx_sub2]), ntree = 500, mtry = 3)
  yhat_rf_sub2[i] <- predict(rf_model_sub2, newdata = X_full_sub2[i,,drop=FALSE], type = "prob")[,"1"]
  }
yhat_lasso_sub2
yhat_ridge_sub2
yhat_lda_sub2
yhat_qda_sub2
yhat_rf_sub2



############## -----------4---------- ROC
library(pROC)
# --------------------- 预设颜色与线型 ---------------------
color_map <- c(
  "26 Features - LASSO" = "#FFC9C9",
  "26 Features - Ridge" = "#FF6467",
  "26 Features - LDA" = "#FFA2A2",
  "26 Features - QDA (PCA)" = "#E7180B",
  "26 Features - Random Forest" = "#82181A",
  
  "16 Features - Ridge" = "#D8F999",
  "16 Features - LDA" = "#9AE630",
  "16 Features - Random Forest" = "#497D15",
  
  "10 Features - LASSO" = "#FFDF20",
  "10 Features - Ridge" = "#FFD900",
  "10 Features - LDA" = "#D1B200",
  "10 Features - QDA (PCA)" = "#A38B00",
  "10 Features - Random Forest" = "#473D00"
)
linetypes <- c("26 Features" = 1, "16 Features" = 2, "10 Features" = 3)
# --------------------- ROC数据结构 ---------------------
roc_data <- list(
  "LASSO" = list(
    "26 Features" = if (exists("yhat_lasso")) roc(y, yhat_lasso) else NULL,
    "10 Features" = if (exists("yhat_lasso_sub2")) roc(y_sub2, yhat_lasso_sub2) else NULL
  ),
  "Ridge" = list(
    "26 Features" = if (exists("yhat_ridge")) roc(y, yhat_ridge) else NULL,
    "16 Features" = if (exists("yhat_ridge_sub1")) roc(y_sub1, yhat_ridge_sub1) else NULL,
    "10 Features" = if (exists("yhat_ridge_sub2")) roc(y_sub2, yhat_ridge_sub2) else NULL
  ),
  "LDA" = list(
    "26 Features" = if (exists("yhat_lda")) roc(y, yhat_lda) else NULL,
    "16 Features" = if (exists("yhat_lda_sub1")) roc(y_sub1, yhat_lda_sub1) else NULL,
    "10 Features" = if (exists("yhat_lda_sub2")) roc(y_sub2, yhat_lda_sub2) else NULL
  ),
  "QDA (PCA)" = list(
    "26 Features" = if (exists("yhat_qda")) roc(y, yhat_qda) else NULL,
    "10 Features" = if (exists("yhat_qda_sub2")) roc(y_sub2, yhat_qda_sub2) else NULL
  ),
  "Random Forest" = list(
    "26 Features" = if (exists("yhat_rf")) roc(y, yhat_rf) else NULL,
    "16 Features" = if (exists("yhat_rf_sub1")) roc(y_sub1, yhat_rf_sub1) else NULL,
    "10 Features" = if (exists("yhat_rf_sub2")) roc(y_sub2, yhat_rf_sub2) else NULL
  )
)
# --------------------- 自动寻找第一个可用曲线并绘图 ---------------------
first_key <- NULL
for (model in names(roc_data)) {
  for (group in names(roc_data[[model]])) {
    if (!is.null(roc_data[[model]][[group]])) {
      first_key <- c(model, group)
      break
    }
  }
  if (!is.null(first_key)) break
}
# ---------- 绘图 ----------
plot(roc_data[[first_key[1]]][[first_key[2]]],
     col = color_map[paste(first_key[2], "-", first_key[1])],
     lty = linetypes[first_key[2]], lwd = 2,
     legacy.axes = TRUE,
     main = "ROC Curves for All Models and Feature Sets in CYVCV Detection",
     xlab = "False Positive Rate", ylab = "True Positive Rate",
     cex.lab = 1.2,     # 坐标轴标签文字大小**
     cex.main = 1.5,    # 主标题文字大小**
     cex.axis = 1.2     # 坐标轴刻度文字大小**
)
par(xaxt = "s")  # 恢复默认设置
# axis(1, at = seq(0, 1, 0.1))  # 自定义x轴刻度为普通数字
# --------------------- 添加所有曲线 ---------------------
legend_items <- c()
legend_colors <- c()
legend_ltys <- c()
# 遵循 26 → 16 → 10 顺序
feature_order <- c("26 Features", "16 Features", "10 Features")
for (feature in feature_order) {
  for (model in names(roc_data)) {
    if (!is.null(roc_data[[model]][[feature]])) {
      key <- paste(feature, "-", model)
      roc_obj <- roc_data[[model]][[feature]]
      lines(roc_obj, col = color_map[[key]], lty = linetypes[[feature]], lwd = 2)
      auc_val <- round(auc(roc_obj), 3)
      legend_items <- c(legend_items, paste0(model, " (", feature, ", AUC = ", auc_val, ")"))
      legend_colors <- c(legend_colors, color_map[[key]])
      legend_ltys <- c(legend_ltys, linetypes[[feature]])
    }
  }
}
abline(a = 0, b = 1, lty = 2, col = "gray")
legend("bottomright",
       legend = legend_items,
       col = legend_colors,
       lty = legend_ltys,
       lwd = 3,
       cex = 1.1)