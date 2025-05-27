```bash
#!/bin/bash
#SBATCH -p batch
#SBATCH --job-name=fastp_to_fasta
#SBATCH -o log_fastp_to_fasta.%j.out
#SBATCH -t 2:00:00
#SBATCH --nodes=1
#SBATCH -n 32
#SBATCH --mail-user=jing.zhang10@okstate.edu
#SBATCH --mail-type=end

source /home/jing/.bashrc
conda activate nanopore


######### Pathogen Negative
INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/8_clean_data/Negative_samples
OUTPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/8_clean_data/Negative_samples/FASTA_output

mkdir -p ${OUTPUT}

while read sample; do
 echo "Processing sample: ${sample}"

 seqtk seq -A ${INPUT}/${sample}_R1_clean.fastq.gz > ${OUTPUT}/${sample}_R1_clean.fasta &
 seqtk seq -A ${INPUT}/${sample}_R2_clean.fastq.gz > ${OUTPUT}/${sample}_R2_clean.fasta &
 wait

 cat ${OUTPUT}/${sample}_R1_clean.fasta   ${OUTPUT}/${sample}_R2_clean.fasta > ${OUTPUT}/${sample}_combined.fasta

 echo "Completed: ${sample}"

done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples_add/Negative_samples/sample_list.txt

######### Pathogen 20 NCBI samples
INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/8_clean_data/20_Xanthomonas_Citri/NCBI_downloads OUTPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/8_clean_data/20_Xanthomonas_Citri/NCBI_downloads/FASTA_output

mkdir -p ${OUTPUT}

while read sample; do
 echo "Processing sample: ${sample}"

 seqtk seq -A ${INPUT}/${sample}_clean.fastq.gz > ${OUTPUT}/${sample}_clean.fasta 

 echo "Completed: ${sample}"

done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/20_Xanthomonas_Citri/NCBI_downloads/sample_list.txt

######### Pathogen 5 sample GV-26_16_S4
INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/8_clean_data/5_CVd_III_positives OUTPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/8_clean_data/5_CVd_III_positives/FASTA_output
mkdir -p ${OUTPUT}

seqtk seq -A ${INPUT}/GV-26_16_S4_R1_clean.fastq.gz > ${OUTPUT}/GV-26_16_S4_R1_clean.fasta &
seqtk seq -A ${INPUT}/GV-26_16_S4_R2_clean.fastq.gz > ${OUTPUT}/GV-26_16_S4_R2_clean.fasta &
wait

cat ${OUTPUT}/GV-26_16_S4_R1_clean.fasta   ${OUTPUT}/GV-26_16_S4_R2_clean.fasta > ${OUTPUT}/GV-26_16_S4_combined.fasta

```
