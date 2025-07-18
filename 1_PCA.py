import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from matplotlib.patches import Ellipse
from sklearn.preprocessing import StandardScaler
from sklearn.decomposition import PCA
from adjustText import adjust_text

# 1️⃣ 读取数据
df = pd.read_excel("/Users/jing/Documents/7-PhD_lab/5_research/4_metagenome_seq/1_first_try/5_kraken2_28_pathogen/2_pathogen_28_single_taxonomy/Detection/2_analysis_after_0528/Detection_19_CYVCV_R.xlsx")

# 2️⃣ 特征定义
features_kb = [
    "k_numreads", "k_perc_reads",
    "b_numreads", "b_covbases", "b_meandepth",
    "b_meanbaseq", "b_meanmapq", "b_coverage"
]

features_edna = [
    "EDNA_pvalue", "e_raw_hit_perc", "e_mean_identity",
    "e_n_eprobe_ide90", "e_mean_coverage", "e_n_eprobe_cov90",
    "e_sum_bitscore", "e_min_evalue", "e_n_positive_eprobes", "e_perc_positive_eprobes"
]

features_assembly = [
    "b_num_hits", "b_total_aligned_length", "b_sum_bitscore",
    "b_min_evalue", "b_avg_identity", "b_avg_coverage",
    "high_confidence_hit", "prop_of_target_aligned"
]

# 3️⃣ PCA处理函数
def run_pca(features, label):
    pca_data = df[["Sample", "qPCR_diagnostic"] + features].dropna().drop_duplicates(subset=["Sample"])
    X = StandardScaler().fit_transform(pca_data[features])
    pca = PCA(n_components=2)
    principal_components = pca.fit_transform(X)
    coords = pd.DataFrame(principal_components, columns=["PC1", "PC2"])
    coords["Sample"] = pca_data["Sample"].values
    coords["qPCR_diagnostic"] = pca_data["qPCR_diagnostic"].map({1: "Positive", 0: "Negative"})
    expl_var = pca.explained_variance_ratio_
    loads = pd.DataFrame(pca.components_.T, columns=["PC1", "PC2"], index=features).reset_index()
    loads = loads.rename(columns={"index": "Variable"})
    loads["importance"] = np.sqrt(loads["PC1"]**2 + loads["PC2"]**2)
    loads_top = loads[loads["importance"] > 0.3].copy()
    return coords, loads_top, expl_var

# 4️⃣ 添加置信椭圆绘图函数
def confidence_ellipse(x, y, ax, n_std=2.0, facecolor='none', **kwargs):
    if x.size <= 1:
        return
    cov = np.cov(x, y)
    if np.linalg.det(cov) == 0:
        return
    vals, vecs = np.linalg.eigh(cov)
    order = vals.argsort()[::-1]
    vals, vecs = vals[order], vecs[:, order]
    theta = np.degrees(np.arctan2(*vecs[:, 0][::-1]))
    width, height = 2 * n_std * np.sqrt(vals)
    mean_x, mean_y = np.mean(x), np.mean(y)
    ellipse = Ellipse(xy=(mean_x, mean_y),
                      width=width, height=height,
                      angle=theta, facecolor=facecolor, **kwargs)
    ax.add_patch(ellipse)

# 5️⃣ PCA 可视化函数（含文字避让和置信椭圆）+ 图像保存
def plot_pca(pca_df, loadings_top, explained_var, title, arrow_scale=2, filename=None):
    plt.figure(figsize=(10, 8))
    ax = sns.scatterplot(
        data=pca_df, x="PC1", y="PC2", hue="qPCR_diagnostic",
        palette={"Positive": "red", "Negative": "blue"}, alpha=0.6
    )

    # 画变量箭头 + 文本避让
    texts = []
    for _, row in loadings_top.iterrows():
        ax.arrow(0, 0, row["PC1"] * arrow_scale, row["PC2"] * arrow_scale,
                 color='black', alpha=0.7, head_width=0.02, head_length=0.03)
        texts.append(ax.text(row["PC1"] * arrow_scale * 1.1,
                             row["PC2"] * arrow_scale * 1.1,
                             row["Variable"], color='darkblue',
                             ha='center', va='center', fontsize=14))
    adjust_text(texts, arrowprops=dict(arrowstyle="->", color='gray', lw=0.5))

    # 添加置信椭圆
    for label, group in pca_df.groupby("qPCR_diagnostic"):
        confidence_ellipse(group["PC1"], group["PC2"], ax,
                           edgecolor='red' if label == "Positive" else 'blue',
                           linestyle='--', linewidth=1.2)

    # 自动扩展坐标轴范围
    xlim = ax.get_xlim()
    ylim = ax.get_ylim()
    ax.set_xlim(xlim[0] - 1.5, xlim[1] + 1.5)
    ax.set_ylim(ylim[0] - 1, ylim[1] + 1)

    # 标注等
    ax.set_title(title, fontsize=20)
    ax.set_xlabel(f"PC1 ({explained_var[0]*100:.2f}%)", fontsize=20)
    ax.set_ylabel(f"PC2 ({explained_var[1]*100:.2f}%)", fontsize=20)
    ax.tick_params(labelsize=16)
    ax.legend(title="Diagnostic", fontsize=20, title_fontsize=20)
    plt.tight_layout()

    # ✅ 保存图像（如果给定文件名）
    if filename:
        plt.savefig(filename, dpi=600, bbox_inches="tight")
    plt.show()

# 6️⃣ 执行 PCA + 绘图 + 保存
plot_pca(*run_pca(features_kb, "Kraken2 + Bowtie2"),
         title="PCA of Kraken2 + Bowtie2 Features",
         filename="/Users/jing/Documents/8_VScode/2_citrus_statistics/PCA_Kraken2_Bowtie2.png")

plot_pca(*run_pca(features_edna, "EDNA"),
         title="PCA of EDNA Features",
         filename="/Users/jing/Documents/8_VScode/2_citrus_statistics/PCA_EDNA.png")

plot_pca(*run_pca(features_assembly, "Assembly"),
         title="PCA of Assembly Features",
         filename="/Users/jing/Documents/8_VScode/2_citrus_statistics/PCA_Assembly.png")