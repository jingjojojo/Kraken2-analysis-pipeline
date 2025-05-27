```
#!/bin/bash
#SBATCH -p batch
#SBATCH --job-name=classify_report_1-7
#SBATCH -o log_classify_report_1-7.%j.out
#SBATCH -t 72:00:00
#SBATCH --nodes=1
#SBATCH -n 32
#SBATCH --mail-user=jing.zhang10@okstate.edu
#SBATCH --mail-type=end
```

```
source /home/jing/.bashrc
```
conda activate nanopore
```


### Pathogen 1

```
INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/8_clean_data/1_CLBV_positives_8/FASTA_output
```
OUTPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/6_kraken2_whole_pathogen/4_28_pathogen_database_unique_taxonomy/2_kraken_result/1_CLBV_positives
```
mkdir -p "$OUTPUT"
```

```
while read sample; do
```
kraken2 --db  citrus_data_db_28_pathogen  \
--output ${OUTPUT}/${sample}_output.txt \
--report ${OUTPUT}/${sample}_report.txt \
--unclassified-out ${OUTPUT}/${sample}_unclassified.fasta \
--classified-out ${OUTPUT}/${sample}_classified.fasta \
${INPUT}/${sample}_combined.fasta.gz
```
done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/1_CLBV_positives/sample_list.txt
```


### Pathogen 2

```
INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/8_clean_data/2_CSDaV_positives/FASTA_output
```
OUTPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/6_kraken2_whole_pathogen/4_28_pathogen_database_unique_taxonomy/2_kraken_result/2_CSDaV_positives
```
mkdir -p "$OUTPUT"
```

```
while read sample; do
```
kraken2 --db  citrus_data_db_28_pathogen   \
--output ${OUTPUT}/${sample}_output.txt \
--report ${OUTPUT}/${sample}_report.txt \
--unclassified-out ${OUTPUT}/${sample}_unclassified.fasta \
--classified-out ${OUTPUT}/${sample}_classified.fasta \
${INPUT}/${sample}_combined.fasta.gz
```
done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/2_CSDaV_positives/sample_list.txt
```


### Pathogen 3

```
INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/8_clean_data/3_CVd_I_positives/FASTA_output
```
OUTPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/6_kraken2_whole_pathogen/4_28_pathogen_database_unique_taxonomy/2_kraken_result/3_CVd_I_positives
```
mkdir -p "$OUTPUT"
```

```
while read sample; do
```
kraken2 --db  citrus_data_db_28_pathogen  \
--output ${OUTPUT}/${sample}_output.txt \
--report ${OUTPUT}/${sample}_report.txt \
--unclassified-out ${OUTPUT}/${sample}_unclassified.fasta \
--classified-out ${OUTPUT}/${sample}_classified.fasta \
${INPUT}/${sample}_combined.fasta.gz
```
done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/3_CVd_I_positives/sample_list.txt
```


### Pathogen 4

```
INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/8_clean_data/4_CVd_II_positives/FASTA_output
```
OUTPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/6_kraken2_whole_pathogen/4_28_pathogen_database_unique_taxonomy/2_kraken_result/4_CVd_II_positives
```
mkdir -p "$OUTPUT"
```
while read sample; do
```
kraken2 --db  citrus_data_db_28_pathogen  \
--output ${OUTPUT}/${sample}_output.txt \
--report ${OUTPUT}/${sample}_report.txt \
--unclassified-out ${OUTPUT}/${sample}_unclassified.fasta \
--classified-out ${OUTPUT}/${sample}_classified.fasta \
${INPUT}/${sample}_combined.fasta.gz
```
done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/4_CVd_II_positives/sample_list.txt
```


### Pathogen 5

```
INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/8_clean_data/5_CVd_III_positives/FASTA_output
```
OUTPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/6_kraken2_whole_pathogen/4_28_pathogen_database_unique_taxonomy/2_kraken_result/5_CVd_III_positives
```
mkdir -p "$OUTPUT"
```
while read sample; do
```
kraken2 --db  citrus_data_db_28_pathogen  \
--output ${OUTPUT}/${sample}_output.txt \
--report ${OUTPUT}/${sample}_report.txt \
--unclassified-out ${OUTPUT}/${sample}_unclassified.fasta \
--classified-out ${OUTPUT}/${sample}_classified.fasta \
${INPUT}/${sample}_combined.fasta.gz
```
done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/5_CVd_III_positives/sample_list.txt
```


### Pathogen 6

```
INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/8_clean_data/6_CVd_IV_positives/FASTA_output
```
OUTPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/6_kraken2_whole_pathogen/4_28_pathogen_database_unique_taxonomy/2_kraken_result/6_CVd_IV_positives
```
mkdir -p "$OUTPUT"
```
while read sample; do
```
kraken2 --db  citrus_data_db_28_pathogen  \
--output ${OUTPUT}/${sample}_output.txt \
--report ${OUTPUT}/${sample}_report.txt \
--unclassified-out ${OUTPUT}/${sample}_unclassified.fasta \
--classified-out ${OUTPUT}/${sample}_classified.fasta \
${INPUT}/${sample}_combined.fasta.gz
```
done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/6_CVd_IV_positives/sample_list.txt
```


### Pathogen 7

```
INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/8_clean_data/7_CVd_V_positives/FASTA_output
```
OUTPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/6_kraken2_whole_pathogen/4_28_pathogen_database_unique_taxonomy/2_kraken_result/7_CVd_V_positives
```
mkdir -p "$OUTPUT"
```
while read sample; do
```
kraken2 --db  citrus_data_db_28_pathogen  \
--output ${OUTPUT}/${sample}_output.txt \
--report ${OUTPUT}/${sample}_report.txt \
--unclassified-out ${OUTPUT}/${sample}_unclassified.fasta \
--classified-out ${OUTPUT}/${sample}_classified.fasta \
${INPUT}/${sample}_combined.fasta.gz
```
done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/7_CVd_V_positives/sample_list.txt
```


### Pathogen 9

```
INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/8_clean_data/9_CVV_positives/FASTA_output
```
OUTPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/6_kraken2_whole_pathogen/4_28_pathogen_database_unique_taxonomy/2_kraken_result/9_CVV_positives
```
mkdir -p "$OUTPUT"
```

```
while read sample; do
```
kraken2 --db citrus_data_db_28_pathogen  \
--output ${OUTPUT}/${sample}_output.txt \
--report ${OUTPUT}/${sample}_report.txt \
--unclassified-out ${OUTPUT}/${sample}_unclassified.fasta \
--classified-out ${OUTPUT}/${sample}_classified.fasta \
${INPUT}/${sample}_combined.fasta.gz
```
done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/9_CVV_positives/sample_list.txt
```


### Pathogen 10

```
INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/8_clean_data/10_CYVaV_positives/FASTA_output
```
OUTPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/6_kraken2_whole_pathogen/4_28_pathogen_database_unique_taxonomy/2_kraken_result/10_CYVaV_positives
```
mkdir -p "$OUTPUT"
```

```
while read sample; do
```
kraken2 --db citrus_data_db_28_pathogen  \
--output ${OUTPUT}/${sample}_output.txt \
--report ${OUTPUT}/${sample}_report.txt \
--unclassified-out ${OUTPUT}/${sample}_unclassified.fasta \
--classified-out ${OUTPUT}/${sample}_classified.fasta \
${INPUT}/${sample}_combined.fasta.gz
```
done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/10_CYVaV_positives/sample_list.txt
```


### Pathogen 11

```
INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/8_clean_data/11_Canker_positives/FASTA_output
```
OUTPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/6_kraken2_whole_pathogen/4_28_pathogen_database_unique_taxonomy/2_kraken_result/11_Canker_positives
```
mkdir -p "$OUTPUT"
```

```
while read sample; do
```
kraken2 --db citrus_data_db_28_pathogen \
--output ${OUTPUT}/${sample}_output.txt \
--report ${OUTPUT}/${sample}_report.txt \
--unclassified-out ${OUTPUT}/${sample}_unclassified.fasta \
--classified-out ${OUTPUT}/${sample}_classified.fasta \
${INPUT}/${sample}_combined.fasta.gz
```
done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/11_Canker_positives/46_GV_CP_Pool/sample_list.txt
```


### Pathogen 12

```
INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/8_clean_data/12_Phytoplasma_Testing/FASTA_output
```
OUTPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/6_kraken2_whole_pathogen/4_28_pathogen_database_unique_taxonomy/2_kraken_result/12_Phytoplasma_Testing
```
mkdir -p "$OUTPUT"
```
while read sample; do
```
kraken2 --db citrus_data_db_28_pathogen  \
--output ${OUTPUT}/${sample}_output.txt \
--report ${OUTPUT}/${sample}_report.txt \
--unclassified-out ${OUTPUT}/${sample}_unclassified.fasta \
--classified-out ${OUTPUT}/${sample}_classified.fasta \
${INPUT}/${sample}_combined.fasta.gz
```
done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/12_Phytoplasma_Testing/sample_list.txt
```


### Pathogen 12 single-end

```
INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/8_clean_data/12_Phytoplasma_Testing/FASTA_output
```
OUTPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/6_kraken2_whole_pathogen/4_28_pathogen_database_unique_taxonomy/2_kraken_result/12_Phytoplasma_Testing
```
mkdir -p "$OUTPUT"
```
kraken2 --db  citrus_data_db_28_pathogen  \
--output ${OUTPUT}/Sample_6_S3_output.txt \
--report ${OUTPUT}/Sample_6_S3_report.txt \
--unclassified-out ${OUTPUT}/Sample_6_S3_unclassified.fasta \
--classified-out ${OUTPUT}/Sample_6_S3_classified.fasta \
${INPUT}/Sample_6_S3_R1_clean.fasta.gz
```


### Pathogen 14

```
INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/8_clean_data/14_CEVd_positives/FASTA_output
```
OUTPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/6_kraken2_whole_pathogen/4_28_pathogen_database_unique_taxonomy/2_kraken_result/14_CEVd_positives
```
mkdir -p "$OUTPUT"
```
while read sample; do
```
kraken2 --db  citrus_data_db_28_pathogen \
--output ${OUTPUT}/${sample}_output.txt \
--report ${OUTPUT}/${sample}_report.txt \
--unclassified-out ${OUTPUT}/${sample}_unclassified.fasta \
--classified-out ${OUTPUT}/${sample}_classified.fasta \
${INPUT}/${sample}_combined.fasta.gz
```
done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/14_CEVd_positives/sample_list.txt
```


### Pathogen 15

```
INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/8_clean_data/15_CPsV_positives/FASTA_output
```
OUTPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/6_kraken2_whole_pathogen/4_28_pathogen_database_unique_taxonomy/2_kraken_result/15_CPsV_positives
```
mkdir -p "$OUTPUT"
```
while read sample; do
```
kraken2 --db citrus_data_db_28_pathogen \
--output ${OUTPUT}/${sample}_output.txt \
--report ${OUTPUT}/${sample}_report.txt \
--unclassified-out ${OUTPUT}/${sample}_unclassified.fasta \
--classified-out ${OUTPUT}/${sample}_classified.fasta \
${INPUT}/${sample}_combined.fasta.gz
```
done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/15_CPsV_positives/sample_list.txt
```


### Pathogen 16

```
INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/8_clean_data/16_CTLV_positives/FASTA_output
```
OUTPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/6_kraken2_whole_pathogen/4_28_pathogen_database_unique_taxonomy/2_kraken_result/16_CTLV_positives
```
mkdir -p "$OUTPUT"
```
while read sample; do
```
kraken2 --db citrus_data_db_28_pathogen \
--output ${OUTPUT}/${sample}_output.txt \
--report ${OUTPUT}/${sample}_report.txt \
--unclassified-out ${OUTPUT}/${sample}_unclassified.fasta \
--classified-out ${OUTPUT}/${sample}_classified.fasta \
${INPUT}/${sample}_R1_clean.fasta.gz
```
done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/16_CTLV_positives/sample_list.txt
```


### Pathogen 17

```
INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/8_clean_data/17_CTV_positives/FASTA_output
```
OUTPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/6_kraken2_whole_pathogen/3_28_pathogen_database/2_kraken_result/17_CTV_positives
```
mkdir -p "$OUTPUT"
```
while read sample; do
```
kraken2 --db citrus_data_db_28_pathogen \
--output ${OUTPUT}/${sample}_output.txt \
--report ${OUTPUT}/${sample}_report.txt \
--unclassified-out ${OUTPUT}/${sample}_unclassified.fasta \
--classified-out ${OUTPUT}/${sample}_classified.fasta \
${INPUT}/${sample}_combined.fasta.gz
```
done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/17_CTV_positives/sample_list.txt
```


### Pathogen 19

```
INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/8_clean_data/19_CYVCV_positives/FASTA_output
```
OUTPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/6_kraken2_whole_pathogen/4_28_pathogen_database_unique_taxonomy/2_kraken_result/19_CYVCV_positives
```
mkdir -p "$OUTPUT"
```
while read sample; do
```
kraken2 --db citrus_data_db_28_pathogen \
--output ${OUTPUT}/${sample}_output.txt \
--report ${OUTPUT}/${sample}_report.txt \
--unclassified-out ${OUTPUT}/${sample}_unclassified.fasta \
--classified-out ${OUTPUT}/${sample}_classified.fasta \
${INPUT}/${sample}_R1_clean.fasta.gz
```
done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/19_CYVCV_positives/sample_list.txt
```


### Pathogen 19 simulated

```
INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/8_clean_data/19_CYVCV_positives_simulate/FASTA_output
```
OUTPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/6_kraken2_whole_pathogen/4_28_pathogen_database_unique_taxonomy/2_kraken_result/19_CYVCV_positives_simulate
```
mkdir -p "$OUTPUT"
```

```
while read sample; do
```
kraken2 --db  citrus_data_db_28_pathogen  \
--output ${OUTPUT}/${sample}_output.txt \
--report ${OUTPUT}/${sample}_report.txt \
--unclassified-out ${OUTPUT}/${sample}_unclassified.fasta \
--classified-out ${OUTPUT}/${sample}_classified.fasta \
${INPUT}/${sample}.fasta.gz
```
done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/8_clean_data/19_CYVCV_positives_simulate/sample_names.txt
```


### Pathogen 20

```
INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/8_clean_data/23_Xylella_positives/FASTA_output
```
OUTPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/6_kraken2_whole_pathogen/4_28_pathogen_database_unique_taxonomy/2_kraken_result/23_Xylella_positives
```
mkdir -p "$OUTPUT"
```
while read sample; do
```
kraken2 --db citrus_data_db_28_pathogen \
--output ${OUTPUT}/${sample}_output.txt \
--report ${OUTPUT}/${sample}_report.txt \
--unclassified-out ${OUTPUT}/${sample}_unclassified.fasta \
--classified-out ${OUTPUT}/${sample}_classified.fasta \
${INPUT}/${sample}_clean.fasta.gz
```
done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/23_Xylella_positives/sample_list.txt
```


### Pathogen 20 NCBI

```
INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/8_clean_data/20_Xanthomonas_Citri/NCBI_downloads/FASTA_output
```
OUTPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/6_kraken2_whole_pathogen/4_28_pathogen_database_unique_taxonomy/2_kraken_result/20_Xanthomonas_Citri/NCBI_downloads
```
mkdir -p "$OUTPUT"
```
while read sample; do
```
kraken2 --db citrus_data_db_28_pathogen \
--output ${OUTPUT}/${sample}_output.txt \
--report ${OUTPUT}/${sample}_report.txt \
--unclassified-out ${OUTPUT}/${sample}_unclassified.fasta \
--classified-out ${OUTPUT}/${sample}_classified.fasta \
${INPUT}/${sample}_combined.fasta.gz
```
done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/20_Xanthomonas_Citri/NCBI_downloads/sample_list.txt
```


### Pathogen 21

```
INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/8_clean_data/21_For_Beta_Testing/FASTA_output
```
OUTPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/6_kraken2_whole_pathogen/4_28_pathogen_database_unique_taxonomy/2_kraken_result/21_For_Beta_Testing
```
mkdir -p "$OUTPUT"
```
while read sample; do
```
kraken2 --db citrus_data_db_28_pathogen \
--output ${OUTPUT}/${sample}_output.txt \
--report ${OUTPUT}/${sample}_report.txt \
--unclassified-out ${OUTPUT}/${sample}_unclassified.fasta \
--classified-out ${OUTPUT}/${sample}_classified.fasta \
${INPUT}/${sample}_combined.fasta.gz
```
done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/21_For_Beta_Testing/sample_list.txt
```


### Pathogen 23

```
INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/8_clean_data/23_Xylella_positives/FASTA_output
```
OUTPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/6_kraken2_whole_pathogen/4_28_pathogen_database_unique_taxonomy/2_kraken_result/23_Xylella_positives
```
mkdir -p "$OUTPUT"
```
while read sample; do
```
kraken2 --db citrus_data_db_28_pathogen \
--output ${OUTPUT}/${sample}_output.txt \
--report ${OUTPUT}/${sample}_report.txt \
--unclassified-out ${OUTPUT}/${sample}_unclassified.fasta \
--classified-out ${OUTPUT}/${sample}_classified.fasta \
${INPUT}/${sample}_clean.fasta.gz
```
done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/23_Xylella_positives/sample_list.txt

### Pathogen Negative

```
INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/8_clean_data/Negative_samples/FASTA_output
```
OUTPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/6_kraken2_whole_pathogen/4_28_pathogen_database_unique_taxonomy/2_kraken_result/Negative_samples
```
mkdir -p "$OUTPUT"
```
while read sample; do
```
kraken2 --db citrus_data_db_28_pathogen \
--output ${OUTPUT}/${sample}_output.txt \
--report ${OUTPUT}/${sample}_report.txt \
--unclassified-out ${OUTPUT}/${sample}_unclassified.fasta \
--classified-out ${OUTPUT}/${sample}_classified.fasta \
${INPUT}/${sample}_combined.fasta.gz
```
done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/Negative_samples/sample_list.txt
```