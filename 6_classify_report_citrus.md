```bash
#!/bin/bash
#SBATCH -p batch
#SBATCH --job-name=classify_report_1-7
#SBATCH -o log_classify_report_1-7.%j.out
#SBATCH -t 72:00:00
#SBATCH --nodes=1
#SBATCH -n 32
#SBATCH --mail-user=jing.zhang10@okstate.edu
#SBATCH --mail-type=end

source /home/jing/.bashrc
conda activate nanopore

###### Pathogen 1
INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/8_clean_data/1_CLBV_positives_8/FASTA_output
OUTPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/6_kraken2_whole_pathogen/4_28_pathogen_database_unique_taxonomy/2_kraken_result/1_CLBV_positives
mkdir -p "$OUTPUT"

while read sample; do
kraken2 --db  citrus_data_db_28_pathogen  \
        --output ${OUTPUT}/${sample}_output.txt \
        --report ${OUTPUT}/${sample}_report.txt \
        --unclassified-out ${OUTPUT}/${sample}_unclassified.fasta \
        --classified-out ${OUTPUT}/${sample}_classified.fasta \
        ${INPUT}/${sample}_combined.fasta.gz
done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/1_CLBV_positives/sample_list.txt

# ... (Truncated - full script would continue)
```