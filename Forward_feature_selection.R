# library 
library(openxlsx)
library(caret)
library(pROC)
library(MASS)
library(dplyr)
library(ggplot2)

# load data
data <- read.xlsx("/Users/jing/Documents/7-PhD_lab/5_research/4_metagenome_seq/1_first_try/5_kraken2_28_pathogen/2_pathogen_28_single_taxonomy/Detection/2_analysis_after_0528/Detection_19_CYVCV_R.xlsx")

########------------------ Logistic regression------------------------------
data$qPCR_diagnostic <- as.factor(data$qPCR_diagnostic)
str(data)
# Fitting Generalized Linear Models
diag_model<-glm(qPCR_diagnostic~ k_numreads+k_perc_reads+b_covbases
                +b_numreads+b_coverage+b_meandepth+b_meanbaseq+b_meanmapq+EDNA_pvalue+e_raw_hit_perc+
                e_mean_identity+e_n_eprobe_ide90+e_mean_coverage+e_n_eprobe_cov90+e_sum_bitscore+
                  e_min_evalue+e_n_positive_eprobes+e_perc_positive_eprobes+b_num_hits+b_total_aligned_length+
                  b_sum_bitscore+b_min_evalue+b_avg_identity+b_avg_coverage+high_confidence_hit+prop_of_target_aligned,
                data=data,
                family = "binomial")
summary.diag_model <- summary(diag_model)
summary.diag_model
names(summary.diag_model)
summary.diag_model$aic
summary.diag_model$coefficients
# confusion matrix
# 概率预测
pred_probs <- predict(diag_model, type = "response")
# 二分类预测
pred_class <- ifelse(pred_probs > 0.5, "Positive", "Negative")
# 混淆矩阵
table(Predicted = pred_class, Actual = data$qPCR_diagnostic)
# misclassification rate
misclassification_rate <- mean(pred_class != data$qPCR_diagnostic)
misclassification_rate
FPR <- sum(pred_class == "Positive" & data$qPCR_diagnostic == "Negative") / sum(data$qPCR_diagnostic == "Negative")
FPR
FNR <- sum(pred_class == "Negative" & data$qPCR_diagnostic == "Positive") / sum(data$qPCR_diagnostic == "Positive")
FNR


#----------------------- 使用 regsubsets 进行变量选择----------------------
library(leaps)
fit.f <- regsubsets(qPCR_diagnostic~ k_numreads+k_perc_reads+b_covbases
                    +b_numreads+b_coverage+b_meandepth+b_meanbaseq+b_meanmapq+EDNA_pvalue+e_raw_hit_perc+
                      e_mean_identity+e_n_eprobe_ide90+e_mean_coverage+e_n_eprobe_cov90+e_sum_bitscore+
                      e_min_evalue+e_n_positive_eprobes+e_perc_positive_eprobes+b_num_hits+b_total_aligned_length+
                      b_sum_bitscore+b_min_evalue+b_avg_identity+b_avg_coverage+high_confidence_hit+prop_of_target_aligned,
                    data = data, method = "forward")
# 查看最终模型结果
summary(fit.f)




########-------------- Model selection by forward stepwise regression--------
# 设置 null model（仅截距项）
null_model <- glm(qPCR_diagnostic ~ 1, data = data, family = "binomial")
# 设置 full model（包含所有候选变量）
full_model <- glm(qPCR_diagnostic~ k_numreads+k_perc_reads+b_covbases
                  +b_numreads+b_coverage+b_meandepth+b_meanbaseq+b_meanmapq+EDNA_pvalue+e_raw_hit_perc+
                    e_mean_identity+e_n_eprobe_ide90+e_mean_coverage+e_n_eprobe_cov90+e_sum_bitscore+
                    e_min_evalue+e_n_positive_eprobes+e_perc_positive_eprobes+b_num_hits+b_total_aligned_length+
                    b_sum_bitscore+b_min_evalue+b_avg_identity+b_avg_coverage+high_confidence_hit+prop_of_target_aligned,
                  data = data, family = "binomial")
# ------------执行前向逐步回归，先检测单一一个variable------------
# 候选变量列表
vars <- c("k_numreads", "k_perc_reads", "b_numreads", "b_covbases",
          "b_meandepth", "b_meanbaseq", "b_meanmapq","EDNA_pvalue",
          "e_raw_hit_perc","e_mean_identity","e_n_eprobe_ide90","e_mean_coverage",
          "e_n_eprobe_cov90","e_sum_bitscore","e_min_evalue","e_n_positive_eprobes",
          "e_perc_positive_eprobes","b_num_hits","b_total_aligned_length","b_sum_bitscore",
          "b_min_evalue","b_avg_identity","b_avg_coverage",
          "high_confidence_hit","prop_of_target_aligned")
# 初始化结果表格
results <- data.frame(Variable = character(), Estimate = numeric(),
                      StdError = numeric(), z_value = numeric(), p_value = numeric())
# 循环拟合模型并提取 summary 的系数信息
for (v in vars) {
  formula_str <- as.formula(paste("qPCR_diagnostic ~", v))
  model <- glm(formula_str, data = data, family = "binomial")
  coef_summary <- summary(model)$coefficients
  results <- rbind(results, data.frame(
    Variable = v,
    Estimate = coef_summary[2, 1],
    StdError = coef_summary[2, 2],
    z_value = coef_summary[2, 3],
    p_value = coef_summary[2, 4]
  ))
}
# 按 p 值升序排列
results <- results[order(results$p_value), ]
results
# 执行 full model + stepwise AIC/BIC 选择
step(null_model, scope = list(lower = null_model, upper = full_model),
     direction = "forward", trace = TRUE)
# 检查 VIF，用 car::vif() 查看变量间多重共线性，排除 VIF > 5 或 10 的变量。
car::vif(full_model)


#----------------------- 使用 backward 进行变量选择----------------------
summary(full_model)
# The b_covbases, which is not significant.
full_model_1 <- glm(qPCR_diagnostic ~ k_numreads+k_perc_reads + b_covbases +
                      b_numreads  + b_meandepth +
                      b_meanbaseq + b_meanmapq,
                    data = data, family = "binomial")
summary(full_model_1)
# The k_numreads has p-value = 0.9999, which is not significant.
full_model_2 <- glm(diagnostic ~ k_perc_reads + b_covbases +
                      b_numreads  + b_meandepth +
                      b_meanbaseq + b_meanmapq,
                    data = data, family = "binomial")
summary(full_model_2)
# The b_covbases has p-value = 0.9999, which is not significant.
full_model_3 <- glm(diagnostic ~ k_perc_reads +
                      b_numreads  + b_meandepth +
                      b_meanbaseq + b_meanmapq,
                    data = data, family = "binomial")
summary(full_model_3)
# The b_numreads has p-value = 0.9999, which is not significant.
full_model_4 <- glm(diagnostic ~ k_perc_reads +
                      b_meandepth +
                      b_meanbaseq + b_meanmapq,
                    data = data, family = "binomial")
summary(full_model_4)
# The b_meandepth has p-value = 0.9999, which is not significant.
full_model_5 <- glm(diagnostic ~ k_perc_reads +
                      b_meanbaseq + b_meanmapq,
                    data = data, family = "binomial")
summary(full_model_5)
# The b_meanbaseq has p-value = 0.9999, which is not significant.
full_model_6 <- glm(diagnostic ~ k_perc_reads +
                      b_meanmapq,
                    data = data, family = "binomial")
summary(full_model_6)
# The k_perc_reads has p-value = 0.693, which is not significant.
full_model_7 <- glm(diagnostic ~ b_meanmapq,
                    data = data, family = "binomial")
summary(full_model_7)











