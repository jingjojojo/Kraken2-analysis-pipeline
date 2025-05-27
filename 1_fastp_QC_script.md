```bash
#!/bin/bash
#SBATCH -p batch
#SBATCH --job-name=fastp_QC
#SBATCH -o log_fastp_QC.%j.out
#SBATCH -t 72:00:00
#SBATCH --nodes=1
#SBATCH -n 32
#SBATCH --mail-user=jing.zhang10@okstate.edu
#SBATCH --mail-type=end

source /home/jing/.bashrc
conda activate nanopore

######### Pathogen 1
INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/1_CLBV_positives
OUTPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/8_clean_data/1_CLBV_positives
mkdir -p "$OUTPUT"
while read sample; do
    fastp -i ${INPUT}/${sample}_R1_001.fastq.gz  \
          -I ${INPUT}/${sample}_R2_001.fastq.gz \
          /--qualified_quality_phred 25  --adapter_sequence AGATCGGAAGAGCACACGTCTGAACTCCAGTCA  \
          --adapter_sequence_r2 AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT --cut_tail --cut_window_size 1 --cut_mean_quality 15  --trim_tail1=1 --trim_tail2=1 \
          -o ${OUTPUT}/${sample}_R1_clean.fastq.gz  \
          -O ${OUTPUT}/${sample}_R2_clean.fastq.gz  \
          -h ${OUTPUT}/${sample}_fastp_report.html  \
          -j ${OUTPUT}/${sample}_fastp_report.json
done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/1_CLBV_positives/sample_list.txt

######### Pathogen 2
INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/2_CSDaV_positives
OUTPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/8_clean_data/2_CSDaV_positives
mkdir -p "$OUTPUT"
while read sample; do
    fastp -i ${INPUT}/${sample}_R1_001.fastq.gz  \
          -I ${INPUT}/${sample}_R2_001.fastq.gz \
          /--qualified_quality_phred 25  --adapter_sequence AGATCGGAAGAGCACACGTCTGAACTCCAGTCA  \
          --adapter_sequence_r2 AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT --cut_tail --cut_window_size 1 --cut_mean_quality 15  --trim_tail1=1 --trim_tail2=1 \
          -o ${OUTPUT}/${sample}_R1_clean.fastq.gz  \
          -O ${OUTPUT}/${sample}_R2_clean.fastq.gz  \
          -h ${OUTPUT}/${sample}_fastp_report.html  \
          -j ${OUTPUT}/${sample}_fastp_report.json
done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/2_CSDaV_positives/sample_list.txt

######### Pathogen 3
INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/3_CVd_I_positives
OUTPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/8_clean_data/3_CVd_I_positives
mkdir -p "$OUTPUT"
while read sample; do
    fastp -i ${INPUT}/${sample}_R1_001.fastq.gz  \
          -I ${INPUT}/${sample}_R2_001.fastq.gz \
          /--qualified_quality_phred 25  --adapter_sequence AGATCGGAAGAGCACACGTCTGAACTCCAGTCA  \
          --adapter_sequence_r2 AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT --cut_tail --cut_window_size 1 --cut_mean_quality 15  --trim_tail1=1 --trim_tail2=1 \
          -o ${OUTPUT}/${sample}_R1_clean.fastq.gz  \
          -O ${OUTPUT}/${sample}_R2_clean.fastq.gz  \
          -h ${OUTPUT}/${sample}_fastp_report.html  \
          -j ${OUTPUT}/${sample}_fastp_report.json
done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/3_CVd_I_positives/sample_list.txt

######### Pathogen 4
INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/4_CVd_II_positives
OUTPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/8_clean_data/4_CVd_II_positives
mkdir -p "$OUTPUT"
while read sample; do
    fastp -i ${INPUT}/${sample}_R1_001.fastq.gz  \
          -I ${INPUT}/${sample}_R2_001.fastq.gz \
          /--qualified_quality_phred 25  --adapter_sequence AGATCGGAAGAGCACACGTCTGAACTCCAGTCA  \
          --adapter_sequence_r2 AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT --cut_tail --cut_window_size 1 --cut_mean_quality 15  --trim_tail1=1 --trim_tail2=1 \
          -o ${OUTPUT}/${sample}_R1_clean.fastq.gz  \
          -O ${OUTPUT}/${sample}_R2_clean.fastq.gz  \
          -h ${OUTPUT}/${sample}_fastp_report.html  \
          -j ${OUTPUT}/${sample}_fastp_report.json
done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/4_CVd_II_positives/sample_list.txt

######### Pathogen 5
INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/5_CVd_III_positives
OUTPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/8_clean_data/5_CVd_III_positives
mkdir -p "$OUTPUT"
while read sample; do
    fastp -i ${INPUT}/${sample}_R1_001.fastq.gz  \
          -I ${INPUT}/${sample}_R2_001.fastq.gz \
          /--qualified_quality_phred 25  --adapter_sequence AGATCGGAAGAGCACACGTCTGAACTCCAGTCA  \
          --adapter_sequence_r2 AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT --cut_tail --cut_window_size 1 --cut_mean_quality 15  --trim_tail1=1 --trim_tail2=1 \
          -o ${OUTPUT}/${sample}_R1_clean.fastq.gz  \
          -O ${OUTPUT}/${sample}_R2_clean.fastq.gz  \
          -h ${OUTPUT}/${sample}_fastp_report.html  \
          -j ${OUTPUT}/${sample}_fastp_report.json
done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/5_CVd_III_positives/sample_list.txt

######### Pathogen 6
INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/6_CVd_IV_positives
OUTPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/8_clean_data/6_CVd_IV_positives
mkdir -p "$OUTPUT"
while read sample; do
    fastp -i ${INPUT}/${sample}_R1_001.fastq.gz  \
          -I ${INPUT}/${sample}_R2_001.fastq.gz \
          /--qualified_quality_phred 25  --adapter_sequence AGATCGGAAGAGCACACGTCTGAACTCCAGTCA  \
          --adapter_sequence_r2 AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT --cut_tail --cut_window_size 1 --cut_mean_quality 15  --trim_tail1=1 --trim_tail2=1 \
          -o ${OUTPUT}/${sample}_R1_clean.fastq.gz  \
          -O ${OUTPUT}/${sample}_R2_clean.fastq.gz  \
          -h ${OUTPUT}/${sample}_fastp_report.html  \
          -j ${OUTPUT}/${sample}_fastp_report.json
done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/6_CVd_IV_positives/sample_list.txt

######### Pathogen 7
INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/7_CVd_V_positives
OUTPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/8_clean_data/7_CVd_V_positives
mkdir -p "$OUTPUT"
while read sample; do
    fastp -i ${INPUT}/${sample}_R1_001.fastq.gz  \
          -I ${INPUT}/${sample}_R2_001.fastq.gz \
          /--qualified_quality_phred 25  --adapter_sequence AGATCGGAAGAGCACACGTCTGAACTCCAGTCA  \
          --adapter_sequence_r2 AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT --cut_tail --cut_window_size 1 --cut_mean_quality 15  --trim_tail1=1 --trim_tail2=1 \
          -o ${OUTPUT}/${sample}_R1_clean.fastq.gz  \
          -O ${OUTPUT}/${sample}_R2_clean.fastq.gz  \
          -h ${OUTPUT}/${sample}_fastp_report.html  \
          -j ${OUTPUT}/${sample}_fastp_report.json
done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/7_CVd_V_positives/sample_list.txt

######### Pathogen 9
INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/9_CVV_positives
OUTPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/8_clean_data/9_CVV_positives
mkdir -p "$OUTPUT"
while read sample; do
    fastp -i ${INPUT}/${sample}_R1_001.fastq.gz  \
          -I ${INPUT}/${sample}_R2_001.fastq.gz \
          /--qualified_quality_phred 25  --adapter_sequence AGATCGGAAGAGCACACGTCTGAACTCCAGTCA  \
          --adapter_sequence_r2 AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT --cut_tail --cut_window_size 1 --cut_mean_quality 15  --trim_tail1=1 --trim_tail2=1 \
          -o ${OUTPUT}/${sample}_R1_clean.fastq.gz  \
          -O ${OUTPUT}/${sample}_R2_clean.fastq.gz  \
          -h ${OUTPUT}/${sample}_fastp_report.html  \
          -j ${OUTPUT}/${sample}_fastp_report.json
done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/9_CVV_positives/sample_list.txt

######### Pathogen 10
INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/10_CYVaV_positives
OUTPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/8_clean_data/10_CYVaV_positives
mkdir -p "$OUTPUT"
while read sample; do
    fastp -i ${INPUT}/${sample}_R1_001.fastq.gz  \
          -I ${INPUT}/${sample}_R2_001.fastq.gz \
          /--qualified_quality_phred 25  --adapter_sequence AGATCGGAAGAGCACACGTCTGAACTCCAGTCA  \
          --adapter_sequence_r2 AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT --cut_tail --cut_window_size 1 --cut_mean_quality 15  --trim_tail1=1 --trim_tail2=1 \
          -o ${OUTPUT}/${sample}_R1_clean.fastq.gz  \
          -O ${OUTPUT}/${sample}_R2_clean.fastq.gz  \
          -h ${OUTPUT}/${sample}_fastp_report.html  \
          -j ${OUTPUT}/${sample}_fastp_report.json
done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/10_CYVaV_positives/sample_list.txt

######### Pathogen 11
INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/11_Canker_positives/46_GV_CP_Pool
OUTPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/8_clean_data/11_Canker_positives
mkdir -p "$OUTPUT"
while read sample; do
    fastp -i ${INPUT}/${sample}_R1_001.fastq.gz  \
          -I ${INPUT}/${sample}_R2_001.fastq.gz \
          /--qualified_quality_phred 25  --adapter_sequence AGATCGGAAGAGCACACGTCTGAACTCCAGTCA  \
          --adapter_sequence_r2 AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT --cut_tail --cut_window_size 1 --cut_mean_quality 15  --trim_tail1=1 --trim_tail2=1 \
          -o ${OUTPUT}/${sample}_R1_clean.fastq.gz  \
          -O ${OUTPUT}/${sample}_R2_clean.fastq.gz  \
          -h ${OUTPUT}/${sample}_fastp_report.html  \
          -j ${OUTPUT}/${sample}_fastp_report.json
done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/11_Canker_positives/46_GV_CP_Pool/sample_list.txt

######### Pathogen 12
INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/12_Phytoplasma_Testing
OUTPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/8_clean_data/12_Phytoplasma_Testing
mkdir -p "$OUTPUT"
while read sample; do
    fastp -i ${INPUT}/${sample}_R1_001.fastq.gz  \
          -I ${INPUT}/${sample}_R2_001.fastq.gz \
          /--qualified_quality_phred 25  --adapter_sequence AGATCGGAAGAGCACACGTCTGAACTCCAGTCA  \
          --adapter_sequence_r2 AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT --cut_tail --cut_window_size 1 --cut_mean_quality 15  --trim_tail1=1 --trim_tail2=1 \
          -o ${OUTPUT}/${sample}_R1_clean.fastq.gz  \
          -O ${OUTPUT}/${sample}_R2_clean.fastq.gz  \
          -h ${OUTPUT}/${sample}_fastp_report.html  \
          -j ${OUTPUT}/${sample}_fastp_report.json
done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/12_Phytoplasma_Testing/sample_list.txt

######### Pathogen 12 single-end sample 
INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/12_Phytoplasma_Testing
OUTPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/8_clean_data/12_Phytoplasma_Testing
mkdir -p "$OUTPUT"
    fastp -i ${INPUT}/Sample_6_S3_R1_001.fastq.gz  \
          /--qualified_quality_phred 25  --adapter_sequence AGATCGGAAGAGCACACGTCTGAACTCCAGTCA  \
          --adapter_sequence_r2 AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT --cut_tail --cut_window_size 1 --cut_mean_quality 15  --trim_tail1=1 --trim_tail2=1 \
          -o ${OUTPUT}/Sample_6_S3_R1_clean.fastq.gz  \
          -h ${OUTPUT}/Sample_6_S3_fastp_report.html  \
          -j ${OUTPUT}/Sample_6_S3_fastp_report.json

######### Pathogen 14
INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/14_CEVd_positives
OUTPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/8_clean_data/14_CEVd_positives
mkdir -p "$OUTPUT"
while read sample; do
    fastp -i ${INPUT}/${sample}_R1_001.fastq.gz  \
          -I ${INPUT}/${sample}_R2_001.fastq.gz \
          /--qualified_quality_phred 25  --adapter_sequence AGATCGGAAGAGCACACGTCTGAACTCCAGTCA  \
          --adapter_sequence_r2 AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT --cut_tail --cut_window_size 1 --cut_mean_quality 15  --trim_tail1=1 --trim_tail2=1 \
          -o ${OUTPUT}/${sample}_R1_clean.fastq.gz  \
          -O ${OUTPUT}/${sample}_R2_clean.fastq.gz  \
          -h ${OUTPUT}/${sample}_fastp_report.html  \
          -j ${OUTPUT}/${sample}_fastp_report.json
done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/14_CEVd_positives/sample_list.txt

######### Pathogen 15
INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/15_CPsV_positives
OUTPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/8_clean_data/15_CPsV_positives     
mkdir -p "$OUTPUT"
while read sample; do
    fastp -i ${INPUT}/${sample}_R1_001.fastq.gz  \
          -I ${INPUT}/${sample}_R2_001.fastq.gz \
          /--qualified_quality_phred 25  --adapter_sequence AGATCGGAAGAGCACACGTCTGAACTCCAGTCA  \
          --adapter_sequence_r2 AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT --cut_tail --cut_window_size 1 --cut_mean_quality 15  --trim_tail1=1 --trim_tail2=1 \
          -o ${OUTPUT}/${sample}_R1_clean.fastq.gz  \
          -O ${OUTPUT}/${sample}_R2_clean.fastq.gz  \
          -h ${OUTPUT}/${sample}_fastp_report.html  \
          -j ${OUTPUT}/${sample}_fastp_report.json
done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/15_CPsV_positives/sample_list.txt

######### Pathogen 16 single-end sample
INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/16_CTLV_positives
OUTPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/8_clean_data/16_CTLV_positives     
mkdir -p "$OUTPUT"
while read sample; do
    fastp -i ${INPUT}/${sample}_R1_001.fastq.gz  \
          /--qualified_quality_phred 25  --adapter_sequence AGATCGGAAGAGCACACGTCTGAACTCCAGTCA  \
          --adapter_sequence_r2 AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT --cut_tail --cut_window_size 1 --cut_mean_quality 15  --trim_tail1=1 --trim_tail2=1 \
          -o ${OUTPUT}/${sample}_R1_clean.fastq.gz  \
          -h ${OUTPUT}/${sample}_fastp_report.html  \
          -j ${OUTPUT}/${sample}_fastp_report.json
done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/16_CTLV_positives/sample_list.txt

######### Pathogen 17
INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/17_CTV_positives
OUTPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/8_clean_data/17_CTV_positives
mkdir -p "$OUTPUT"

while read sample; do
    fastp -i ${INPUT}/${sample}_R1_001.fastq.gz  \
          --qualified_quality_phred 25  \
          --adapter_sequence AGATCGGAAGAGCACACGTCTGAACTCCAGTCA  \
          --cut_tail --cut_window_size 1 --cut_mean_quality 15  \
          --trim_tail1=1 \
          -o ${OUTPUT}/${sample}_R1_clean.fastq.gz  \
          -h ${OUTPUT}/${sample}_fastp_report.html  \
          -j ${OUTPUT}/${sample}_fastp_report.json
done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/17_CTV_positives/sample_list.txt

######### Pathogen 19
INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/19_CYVCV_positives
OUTPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/8_clean_data/19_CYVCV_positives     
mkdir -p "$OUTPUT"
while read sample; do
    fastp -i ${INPUT}/${sample}_R1_001.fastq.gz  \
          /--qualified_quality_phred 25  --adapter_sequence AGATCGGAAGAGCACACGTCTGAACTCCAGTCA  \
          --adapter_sequence_r2 AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT --cut_tail --cut_window_size 1 --cut_mean_quality 15  --trim_tail1=1 --trim_tail2=1 \
          -o ${OUTPUT}/${sample}_R1_clean.fastq.gz  \
          -h ${OUTPUT}/${sample}_fastp_report.html  \
          -j ${OUTPUT}/${sample}_fastp_report.json
done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/19_CYVCV_positives/sample_list.txt

######### Pathogen 19 simulated sample
INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/19_simulated_sample/simulated_fasta
OUTPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/8_clean_data/19_CYVCV_positives_simulate  
mkdir -p "$OUTPUT"
while read sample; do
    fastp -i ${INPUT}/${sample}_R1_001.fastq.gz  \
          /--qualified_quality_phred 25  --adapter_sequence AGATCGGAAGAGCACACGTCTGAACTCCAGTCA  \
          --adapter_sequence_r2 AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT --cut_tail --cut_window_size 1 --cut_mean_quality 15  --trim_tail1=1 --trim_tail2=1 \
          -o ${OUTPUT}/${sample}_R1_clean.fastq.gz  \
          -h ${OUTPUT}/${sample}_fastp_report.html  \
          -j ${OUTPUT}/${sample}_fastp_report.json
done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/19_simulated_sample/simulated_fasta/sample_names.txt

######### Pathogen 20
INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/20_Xanthomonas_Citri
OUTPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/8_clean_data/20_Xanthomonas_Citri
mkdir -p "$OUTPUT"
while read sample; do
    fastp -i ${INPUT}/${sample}_R1_001.fastq.gz  \
          -I ${INPUT}/${sample}_R2_001.fastq.gz \
          /--qualified_quality_phred 25  --adapter_sequence AGATCGGAAGAGCACACGTCTGAACTCCAGTCA  \
          --adapter_sequence_r2 AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT --cut_tail --cut_window_size 1 --cut_mean_quality 15  --trim_tail1=1 --trim_tail2=1 \
          -o ${OUTPUT}/${sample}_R1_clean.fastq.gz  \
          -O ${OUTPUT}/${sample}_R2_clean.fastq.gz  \
          -h ${OUTPUT}/${sample}_fastp_report.html  \
          -j ${OUTPUT}/${sample}_fastp_report.json
done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/20_Xanthomonas_Citri/sample_list.txt

######### Pathogen 20 NCBI samples
INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/20_Xanthomonas_Citri/NCBI_downloads
OUTPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/8_clean_data/20_Xanthomonas_Citri/NCBI_downloads
mkdir -p "$OUTPUT"

while read sample; do
    fastp -i ${INPUT}/${sample}.fastq.gz  \
          --cut_tail \
          --cut_window_size 4 \
          --cut_mean_quality 20 \
          -o ${OUTPUT}/${sample}_clean.fastq.gz  \
          -h ${OUTPUT}/${sample}_fastp_report.html  \
          -j ${OUTPUT}/${sample}_fastp_report.json
done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/20_Xanthomonas_Citri/NCBI_downloads/sample_list.txt

######### Pathogen 21
INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/21_For_Beta_Testing
OUTPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/8_clean_data/21_For_Beta_Testing
mkdir -p "$OUTPUT"
while read sample; do
    fastp -i ${INPUT}/${sample}_R1_001.fastq.gz  \
          -I ${INPUT}/${sample}_R2_001.fastq.gz \
          /--qualified_quality_phred 25  --adapter_sequence AGATCGGAAGAGCACACGTCTGAACTCCAGTCA  \
          --adapter_sequence_r2 AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT --cut_tail --cut_window_size 1 --cut_mean_quality 15  --trim_tail1=1 --trim_tail2=1 \
          -o ${OUTPUT}/${sample}_R1_clean.fastq.gz  \
          -O ${OUTPUT}/${sample}_R2_clean.fastq.gz  \
          -h ${OUTPUT}/${sample}_fastp_report.html  \
          -j ${OUTPUT}/${sample}_fastp_report.json
done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/21_For_Beta_Testing/sample_list.txt

######### Pathogen 23
INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/23_Xylella_positives/NCBI_SRA
OUTPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/8_clean_data/23_Xylella_positives
mkdir -p "$OUTPUT"

while read sample; do
    fastp -i ${INPUT}/${sample}.fastq.gz  \
          --cut_tail \
          --cut_window_size 4 \
          --cut_mean_quality 20 \
          -o ${OUTPUT}/${sample}_clean.fastq.gz  \
          -h ${OUTPUT}/${sample}_fastp_report.html  \
          -j ${OUTPUT}/${sample}_fastp_report.json
done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/23_Xylella_positives/NCBI_SRA/sample_list.txt




######### Pathogen Negative
INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples_add/Negative_samples
OUTPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/8_clean_data/Negative_samples
mkdir -p "$OUTPUT"
while read sample; do
    fastp -i ${INPUT}/${sample}_R1_001.fastq.gz  \
          -I ${INPUT}/${sample}_R2_001.fastq.gz \
          /--qualified_quality_phred 25  --adapter_sequence AGATCGGAAGAGCACACGTCTGAACTCCAGTCA  \
          --adapter_sequence_r2 AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT --cut_tail --cut_window_size 1 --cut_mean_quality 15  --trim_tail1=1 --trim_tail2=1 \
          -o ${OUTPUT}/${sample}_R1_clean.fastq.gz  \
          -O ${OUTPUT}/${sample}_R2_clean.fastq.gz  \
          -h ${OUTPUT}/${sample}_fastp_report.html  \
          -j ${OUTPUT}/${sample}_fastp_report.json
done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples_add/Negative_samples/sample_list.txt

```