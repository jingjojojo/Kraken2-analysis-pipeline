```bash
#!/bin/bash
#SBATCH -p batch
#SBATCH --job-name=4_fasta_to_gz_negative
#SBATCH -o log_4_fasta_to_gz_negative.%j.out
#SBATCH -t 10:00:00
#SBATCH --nodes=1
#SBATCH -n 32
#SBATCH --mail-user=jing.zhang10@okstate.edu
#SBATCH --mail-type=end

source /home/jing/.bashrc
conda activate nanopore

# Compress Negative samples
INPUT1=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/8_clean_data/Negative_samples/FASTA_output
gzip ${INPUT1}/*_combined.fasta &
wait

# Compress Xanthomonas Citri NCBI samples
INPUT2=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/8_clean_data/20_Xanthomonas_Citri/NCBI_downloads/FASTA_output
gzip ${INPUT2}/*_clean.fasta &
wait

# Compress specific CVd-III sample
INPUT3=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/8_clean_data/5_CVd_III_positives/FASTA_output
gzip ${INPUT3}/GV-26_16_S4_combined.fasta

```