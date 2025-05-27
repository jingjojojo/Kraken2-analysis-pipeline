import pandas as pd
import os

# Step 1: 定义你的 Taxonomy ID 列表
taxonomy_ids = [
    129141, 557419, 312008, 72705, 12893, 551523, 41862, 110139, 12898, 459949,
    697192, 37127, 1297894, 487832, 487827, 37692, 85620,
    12890, 457005, 457004, 164653, 164652, 73561, 33759, 12162, 1301220,
    1214459, 611301, 2484986, 2371, 1435008, 12906, 981368, 2133,
    34021
]
taxonomy_df = pd.DataFrame(taxonomy_ids, columns=["Taxonomy ID"])

# Step 2: 读取 sample list
sample_list_path = "/scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/1_CLBV_positives/sample_list.txt"

with open(sample_list_path, 'r') as f:
    sample_names = [line.strip() for line in f if line.strip()]

# Step 3: 循环处理每个样本
base_dir = "/scratch/jing/nanopore/3_temp/2_jing_citrus_data/6_kraken2_whole_pathogen/4_28_pathogen_database_unique_taxonomy/2_kraken_result/1_CLBV_positives"

for sample in sample_names:
    report_file = os.path.join(base_dir, f"{sample}_report.txt")
    output_file = os.path.join(base_dir, f"{sample}_matched_kraken2_result.csv")

    kraken_rows = []
    try:
        with open(report_file, 'r') as file:
            for line in file:
                parts = line.strip().split()
                if len(parts) < 6:
                    continue
                try:
                    read_pct = float(parts[0])
                    clade_reads = int(parts[1])
                    taxon_reads = int(parts[2])
                    rank = parts[3]
                    taxid = int(parts[4])
                    name = " ".join(parts[5:])
                    kraken_rows.append({
                        "Taxonomy ID": taxid,
                        "Read %": round(read_pct, 5),
                        "Clade Reads": clade_reads,
                        "Taxon Reads": taxon_reads,
                        "Rank": rank,
                        "Name": name
                    })
                except ValueError:
                    continue
        kraken_df = pd.DataFrame(kraken_rows)

        # 合并并输出
        merged_df = taxonomy_df.merge(kraken_df, on="Taxonomy ID", how="left").fillna("NA")
        merged_df.to_csv(output_file, index=False)
        print(f"[✓] Processed: {sample}")
    except FileNotFoundError:
        print(f"[!] Report file not found: {report_file}")
