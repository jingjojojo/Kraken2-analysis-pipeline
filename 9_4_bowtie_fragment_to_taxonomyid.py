import pandas as pd
import sys

# 参数处理
sample_name = sys.argv[1]
mapping_file = sys.argv[2]

# 构建文件名
coverage_file = f"{sample_name}_coverage.tsv"
output_file = f"taxonomy_coverage_summary_{sample_name}.tsv"

# 读取数据
coverage_df = pd.read_csv(coverage_file, sep="\t")
mapping_df = pd.read_table(mapping_file, encoding='latin1')

# 清洗列名
coverage_df.columns = coverage_df.columns.str.strip()
mapping_df.columns = mapping_df.columns.str.strip()

# 合并 coverage 与 fragment-to-taxonomy 对应关系
merged_df = pd.merge(coverage_df, mapping_df, left_on="#rname", right_on="Fragment")

# 转为数值类型
for col in ['numreads', 'covbases', 'endpos', 'meandepth', 'meanbaseq', 'meanmapq']:
    merged_df[col] = pd.to_numeric(merged_df[col], errors='coerce')

# 获取所有 Taxonomy ID（即使没有 reads 也保留）
all_taxonomy_ids = mapping_df[['Taxonomy ID']].drop_duplicates()

# 只对有 mapped reads 的片段做聚合
mapped_df = merged_df[merged_df['numreads'] > 0]

# 聚合指标计算
agg_summary = mapped_df.groupby("Taxonomy ID").agg(
    total_numreads=('numreads', 'sum'),
    total_covbases=('covbases', 'sum'),
    total_endpos=('endpos', 'sum'),
    mean_meandepth=('meandepth', 'mean'),
    mean_baseq=('meanbaseq', lambda x: x.dropna().mean()),
    mean_mapq=('meanmapq', lambda x: x.dropna().mean())
).reset_index()

# 回填所有 Taxonomy ID
complete_summary = pd.merge(all_taxonomy_ids, agg_summary, on="Taxonomy ID", how="left")

# 缺失值处理
complete_summary['total_numreads'] = complete_summary['total_numreads'].fillna(0)
complete_summary['total_covbases'] = complete_summary['total_covbases'].fillna(0)
complete_summary['total_endpos'] = complete_summary['total_endpos'].fillna(0)

# coverage = covbases / endpos（避免除0错误）
complete_summary['coverage'] = complete_summary.apply(
    lambda row: row['total_covbases'] / row['total_endpos'] if row['total_endpos'] > 0 else 0, axis=1
)

# 输出
complete_summary.to_csv(output_file, sep="\t", index=False)
