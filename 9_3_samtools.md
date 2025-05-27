



$ cat 3_sam_working_1_7.sh

#!/bin/bash

#SBATCH -p batch

#SBATCH --job-name=sam_1_7

#SBATCH -o log_sam_1_7.%j.out

#SBATCH -t 6:00:00

#SBATCH --nodes=1

#SBATCH -n 32

#SBATCH --mail-user=jing.zhang10@okstate.edu

#SBATCH --mail-type=end



source /home/jing/.bashrc

conda activate mikado2



##### Folder 1

INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/9_bowtie_28_pathogen_unique_taxonomy/2_bowtie2_result/1_CLBV_positives

# step3 Sort .sam output

while read sample; do

samtools sort ${INPUT}/${sample}.sam > ${INPUT}/${sample}_sorted.sam

samtools coverage ${INPUT}/${sample}_sorted.sam > ${INPUT}/${sample}_coverage.tsv

samtools view -h -S -F 4 ${INPUT}/${sample}_sorted.sam > ${INPUT}/${sample}_sorted_mapped.sam

samtools view -bt ref_genome.fasta.fai -o  ${INPUT}/${sample}_mapped.bam  ${INPUT}/${sample}_sorted_mapped.sam

samtools fasta ${INPUT}/${sample}_mapped.bam > ${INPUT}/${sample}_sorted_mapped_reads.fasta

done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/1_CLBV_positives/sample_list.txt





##### Folder2

INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/9_bowtie_28_pathogen_unique_taxonomy/2_bowtie2_result/2_CSDaV_positives

# step3 Sort .sam output

while read sample; do

samtools sort ${INPUT}/${sample}.sam > ${INPUT}/${sample}_sorted.sam

samtools coverage ${INPUT}/${sample}_sorted.sam > ${INPUT}/${sample}_coverage.tsv

samtools view -h -S -F 4 ${INPUT}/${sample}_sorted.sam > ${INPUT}/${sample}_sorted_mapped.sam

samtools view -bt ref_genome.fasta.fai -o  ${INPUT}/${sample}_mapped.bam  ${INPUT}/${sample}_sorted_mapped.sam

samtools fasta ${INPUT}/${sample}_mapped.bam > ${INPUT}/${sample}_sorted_mapped_reads.fasta

done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/2_CSDaV_positives/sample_list.txt







##### Folder3

INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/9_bowtie_28_pathogen_unique_taxonomy/2_bowtie2_result/3_CVd_I_positives

# step3 Sort .sam output

while read sample; do

samtools sort ${INPUT}/${sample}.sam > ${INPUT}/${sample}_sorted.sam

samtools coverage ${INPUT}/${sample}_sorted.sam > ${INPUT}/${sample}_coverage.tsv

samtools view -h -S -F 4 ${INPUT}/${sample}_sorted.sam > ${INPUT}/${sample}_sorted_mapped.sam

samtools view -bt ref_genome.fasta.fai -o  ${INPUT}/${sample}_mapped.bam  ${INPUT}/${sample}_sorted_mapped.sam

samtools fasta ${INPUT}/${sample}_mapped.bam > ${INPUT}/${sample}_sorted_mapped_reads.fasta

done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/3_CVd_I_positives/sample_list.txt







##### Folder4

INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/9_bowtie_28_pathogen_unique_taxonomy/2_bowtie2_result/4_CVd_II_positives

# step3 Sort .sam output

while read sample; do

samtools sort ${INPUT}/${sample}.sam > ${INPUT}/${sample}_sorted.sam

samtools coverage ${INPUT}/${sample}_sorted.sam > ${INPUT}/${sample}_coverage.tsv

samtools view -h -S -F 4 ${INPUT}/${sample}_sorted.sam > ${INPUT}/${sample}_sorted_mapped.sam

samtools view -bt ref_genome.fasta.fai -o  ${INPUT}/${sample}_mapped.bam  ${INPUT}/${sample}_sorted_mapped.sam

samtools fasta ${INPUT}/${sample}_mapped.bam > ${INPUT}/${sample}_sorted_mapped_reads.fasta

done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/4_CVd_II_positives/sample_list.txt







##### Folder5

INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/9_bowtie_28_pathogen_unique_taxonomy/2_bowtie2_result/5_CVd_III_positives

# step3 Sort .sam output

while read sample; do

samtools sort ${INPUT}/${sample}.sam > ${INPUT}/${sample}_sorted.sam

samtools coverage ${INPUT}/${sample}_sorted.sam > ${INPUT}/${sample}_coverage.tsv

samtools view -h -S -F 4 ${INPUT}/${sample}_sorted.sam > ${INPUT}/${sample}_sorted_mapped.sam

samtools view -bt ref_genome.fasta.fai -o  ${INPUT}/${sample}_mapped.bam  ${INPUT}/${sample}_sorted_mapped.sam

samtools fasta ${INPUT}/${sample}_mapped.bam > ${INPUT}/${sample}_sorted_mapped_reads.fasta

done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/5_CVd_III_positives/sample_list.txt





##### Folder6

INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/9_bowtie_28_pathogen_unique_taxonomy/2_bowtie2_result/6_CVd_IV_positives

# step3 Sort .sam output

while read sample; do

samtools sort ${INPUT}/${sample}.sam > ${INPUT}/${sample}_sorted.sam

samtools coverage ${INPUT}/${sample}_sorted.sam > ${INPUT}/${sample}_coverage.tsv

samtools view -h -S -F 4 ${INPUT}/${sample}_sorted.sam > ${INPUT}/${sample}_sorted_mapped.sam

samtools view -bt ref_genome.fasta.fai -o  ${INPUT}/${sample}_mapped.bam  ${INPUT}/${sample}_sorted_mapped.sam

samtools fasta ${INPUT}/${sample}_mapped.bam > ${INPUT}/${sample}_sorted_mapped_reads.fasta

done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/6_CVd_IV_positives/sample_list.txt







##### Folder7

INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/9_bowtie_28_pathogen_unique_taxonomy/2_bowtie2_result/7_CVd_V_positives

# step3 Sort .sam output

while read sample; do

samtools sort ${INPUT}/${sample}.sam > ${INPUT}/${sample}_sorted.sam

samtools coverage ${INPUT}/${sample}_sorted.sam > ${INPUT}/${sample}_coverage.tsv

samtools view -h -S -F 4 ${INPUT}/${sample}_sorted.sam > ${INPUT}/${sample}_sorted_mapped.sam

samtools view -bt ref_genome.fasta.fai -o  ${INPUT}/${sample}_mapped.bam  ${INPUT}/${sample}_sorted_mapped.sam

samtools fasta ${INPUT}/${sample}_mapped.bam > ${INPUT}/${sample}_sorted_mapped_reads.fasta

done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/7_CVd_V_positives/sample_list.txt



##### Folder 9

INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/9_bowtie_28_pathogen_unique_taxonomy/2_bowtie2_result/9_CVV_positives

# step3 Sort .sam output

while read sample; do

samtools sort ${INPUT}/${sample}.sam > ${INPUT}/${sample}_sorted.sam

samtools coverage ${INPUT}/${sample}_sorted.sam > ${INPUT}/${sample}_coverage.tsv

samtools view -h -S -F 4 ${INPUT}/${sample}_sorted.sam > ${INPUT}/${sample}_sorted_mapped.sam

samtools view -bt ref_genome.fasta.fai -o  ${INPUT}/${sample}_mapped.bam  ${INPUT}/${sample}_sorted_mapped.sam

samtools fasta ${INPUT}/${sample}_mapped.bam > ${INPUT}/${sample}_sorted_mapped_reads.fasta

done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/9_CVV_positives/sample_list.txt





##### Folder10

INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/9_bowtie_28_pathogen_unique_taxonomy/2_bowtie2_result/10_CYVaV_positives

# step3 Sort .sam output

while read sample; do

samtools sort ${INPUT}/${sample}.sam > ${INPUT}/${sample}_sorted.sam

samtools coverage ${INPUT}/${sample}_sorted.sam > ${INPUT}/${sample}_coverage.tsv

samtools view -h -S -F 4 ${INPUT}/${sample}_sorted.sam > ${INPUT}/${sample}_sorted_mapped.sam

samtools view -bt ref_genome.fasta.fai -o  ${INPUT}/${sample}_mapped.bam  ${INPUT}/${sample}_sorted_mapped.sam

samtools fasta ${INPUT}/${sample}_mapped.bam > ${INPUT}/${sample}_sorted_mapped_reads.fasta

done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/10_CYVaV_positives/sample_list.txt







##### Folder11

INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/9_bowtie_28_pathogen_unique_taxonomy/2_bowtie2_result/11_Canker_positives

# step3 Sort .sam output

while read sample; do

samtools sort ${INPUT}/${sample}.sam > ${INPUT}/${sample}_sorted.sam

samtools coverage ${INPUT}/${sample}_sorted.sam > ${INPUT}/${sample}_coverage.tsv

samtools view -h -S -F 4 ${INPUT}/${sample}_sorted.sam > ${INPUT}/${sample}_sorted_mapped.sam

samtools view -bt ref_genome.fasta.fai -o  ${INPUT}/${sample}_mapped.bam  ${INPUT}/${sample}_sorted_mapped.sam

samtools fasta ${INPUT}/${sample}_mapped.bam > ${INPUT}/${sample}_sorted_mapped_reads.fasta

done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/11_Canker_positives/46_GV_CP_Pool/sample_list.txt







##### Folder12

INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/9_bowtie_28_pathogen_unique_taxonomy/2_bowtie2_result/12_Phytoplasma_Testing

# step3 Sort .sam output

while read sample; do

samtools sort ${INPUT}/${sample}.sam > ${INPUT}/${sample}_sorted.sam

samtools coverage ${INPUT}/${sample}_sorted.sam > ${INPUT}/${sample}_coverage.tsv

samtools view -h -S -F 4 ${INPUT}/${sample}_sorted.sam > ${INPUT}/${sample}_sorted_mapped.sam

samtools view -bt ref_genome.fasta.fai -o  ${INPUT}/${sample}_mapped.bam  ${INPUT}/${sample}_sorted_mapped.sam

samtools fasta ${INPUT}/${sample}_mapped.bam > ${INPUT}/${sample}_sorted_mapped_reads.fasta

done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/12_Phytoplasma_Testing/sample_list.txt







##### Folder14

INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/9_bowtie_28_pathogen_unique_taxonomy/2_bowtie2_result/14_CEVd_positives

# step3 Sort .sam output

while read sample; do

samtools sort ${INPUT}/${sample}.sam > ${INPUT}/${sample}_sorted.sam

samtools coverage ${INPUT}/${sample}_sorted.sam > ${INPUT}/${sample}_coverage.tsv

samtools view -h -S -F 4 ${INPUT}/${sample}_sorted.sam > ${INPUT}/${sample}_sorted_mapped.sam

samtools view -bt ref_genome.fasta.fai -o  ${INPUT}/${sample}_mapped.bam  ${INPUT}/${sample}_sorted_mapped.sam

samtools fasta ${INPUT}/${sample}_mapped.bam > ${INPUT}/${sample}_sorted_mapped_reads.fasta

done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/14_CEVd_positives/sample_list.txt





##### Folder15

INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/9_bowtie_28_pathogen_unique_taxonomy/2_bowtie2_result/15_CPsV_positives

# step3 Sort .sam output

while read sample; do

samtools sort ${INPUT}/${sample}.sam > ${INPUT}/${sample}_sorted.sam

samtools coverage ${INPUT}/${sample}_sorted.sam > ${INPUT}/${sample}_coverage.tsv

samtools view -h -S -F 4 ${INPUT}/${sample}_sorted.sam > ${INPUT}/${sample}_sorted_mapped.sam

samtools view -bt ref_genome.fasta.fai -o  ${INPUT}/${sample}_mapped.bam  ${INPUT}/${sample}_sorted_mapped.sam

samtools fasta ${INPUT}/${sample}_mapped.bam > ${INPUT}/${sample}_sorted_mapped_reads.fasta

done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/15_CPsV_positives/sample_list.txt







##### Folder16

INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/9_bowtie_28_pathogen_unique_taxonomy/2_bowtie2_result/16_CTLV_positives

# step3 Sort .sam output

while read sample; do

samtools sort ${INPUT}/${sample}.sam > ${INPUT}/${sample}_sorted.sam

samtools coverage ${INPUT}/${sample}_sorted.sam > ${INPUT}/${sample}_coverage.tsv

samtools view -h -S -F 4 ${INPUT}/${sample}_sorted.sam > ${INPUT}/${sample}_sorted_mapped.sam

samtools view -bt ref_genome.fasta.fai -o  ${INPUT}/${sample}_mapped.bam  ${INPUT}/${sample}_sorted_mapped.sam

samtools fasta ${INPUT}/${sample}_mapped.bam > ${INPUT}/${sample}_sorted_mapped_reads.fasta

done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/16_CTLV_positives/sample_list.txt







##### Folder17

INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/9_bowtie_28_pathogen_unique_taxonomy/2_bowtie2_result/17_CTV_positives

# step3 Sort .sam output

while read sample; do

samtools sort ${INPUT}/${sample}.sam > ${INPUT}/${sample}_sorted.sam

samtools coverage ${INPUT}/${sample}_sorted.sam > ${INPUT}/${sample}_coverage.tsv

samtools view -h -S -F 4 ${INPUT}/${sample}_sorted.sam > ${INPUT}/${sample}_sorted_mapped.sam

samtools view -bt ref_genome.fasta.fai -o  ${INPUT}/${sample}_mapped.bam  ${INPUT}/${sample}_sorted_mapped.sam

samtools fasta ${INPUT}/${sample}_mapped.bam > ${INPUT}/${sample}_sorted_mapped_reads.fasta

done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/17_CTV_positives/sample_list.txt





##### Folder19

INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/9_bowtie_28_pathogen_unique_taxonomy/2_bowtie2_result/19_CYVCV_positives

# step3 Sort .sam output

while read sample; do

samtools sort ${INPUT}/${sample}.sam > ${INPUT}/${sample}_sorted.sam

samtools coverage ${INPUT}/${sample}_sorted.sam > ${INPUT}/${sample}_coverage.tsv

samtools view -h -S -F 4 ${INPUT}/${sample}_sorted.sam > ${INPUT}/${sample}_sorted_mapped.sam

samtools view -bt ref_genome.fasta.fai -o  ${INPUT}/${sample}_mapped.bam  ${INPUT}/${sample}_sorted_mapped.sam

samtools fasta ${INPUT}/${sample}_mapped.bam > ${INPUT}/${sample}_sorted_mapped_reads.fasta

done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/19_CYVCV_positives/sample_list.txt



##### CYVCV-11_S10

INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/9_bowtie_28_pathogen_unique_taxonomy/2_bowtie2_result/simulated_sample

# step3 Sort .sam output

while read sample; do

samtools sort ${INPUT}/${sample}.sam > ${INPUT}/${sample}_sorted.sam

samtools coverage ${INPUT}/${sample}_sorted.sam > ${INPUT}/${sample}_coverage.tsv

samtools view -h -S -F 4 ${INPUT}/${sample}_sorted.sam > ${INPUT}/${sample}_sorted_mapped.sam

samtools view -bt ref_genome.fasta.fai -o  ${INPUT}/${sample}_mapped.bam  ${INPUT}/${sample}_sorted_mapped.sam

samtools fasta ${INPUT}/${sample}_mapped.bam > ${INPUT}/${sample}_sorted_mapped_reads.fasta

done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/8_clean_data/19_CYVCV_positives_simulate/sample_names_CYVCV-11_S10.txt









##### CYVCV-12_S11

INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/9_bowtie_28_pathogen_unique_taxonomy/2_bowtie2_result/simulated_sample

# step3 Sort .sam output

while read sample; do

samtools sort ${INPUT}/${sample}.sam > ${INPUT}/${sample}_sorted.sam

samtools coverage ${INPUT}/${sample}_sorted.sam > ${INPUT}/${sample}_coverage.tsv

samtools view -h -S -F 4 ${INPUT}/${sample}_sorted.sam > ${INPUT}/${sample}_sorted_mapped.sam

samtools view -bt ref_genome.fasta.fai -o  ${INPUT}/${sample}_mapped.bam  ${INPUT}/${sample}_sorted_mapped.sam

samtools fasta ${INPUT}/${sample}_mapped.bam > ${INPUT}/${sample}_sorted_mapped_reads.fasta

done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/8_clean_data/19_CYVCV_positives_simulate/sample_names_CYVCV-12_S11.txt





##### CYVCV-1_S2

INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/9_bowtie_28_pathogen_unique_taxonomy/2_bowtie2_result/simulated_sample

# step3 Sort .sam output

while read sample; do

samtools sort ${INPUT}/${sample}.sam > ${INPUT}/${sample}_sorted.sam

samtools coverage ${INPUT}/${sample}_sorted.sam > ${INPUT}/${sample}_coverage.tsv

samtools view -h -S -F 4 ${INPUT}/${sample}_sorted.sam > ${INPUT}/${sample}_sorted_mapped.sam

samtools view -bt ref_genome.fasta.fai -o  ${INPUT}/${sample}_mapped.bam  ${INPUT}/${sample}_sorted_mapped.sam

samtools fasta ${INPUT}/${sample}_mapped.bam > ${INPUT}/${sample}_sorted_mapped_reads.fasta

done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/8_clean_data/19_CYVCV_positives_simulate/sample_names_CYVCV-1_S2.txt





#### CYVCV-2_S3

INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/9_bowtie_28_pathogen_unique_taxonomy/2_bowtie2_result/simulated_sample

# step3 Sort .sam output

while read sample; do

samtools sort ${INPUT}/${sample}.sam > ${INPUT}/${sample}_sorted.sam

samtools coverage ${INPUT}/${sample}_sorted.sam > ${INPUT}/${sample}_coverage.tsv

samtools view -h -S -F 4 ${INPUT}/${sample}_sorted.sam > ${INPUT}/${sample}_sorted_mapped.sam

samtools view -bt ref_genome.fasta.fai -o  ${INPUT}/${sample}_mapped.bam  ${INPUT}/${sample}_sorted_mapped.sam

samtools fasta ${INPUT}/${sample}_mapped.bam > ${INPUT}/${sample}_sorted_mapped_reads.fasta

done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/8_clean_data/19_CYVCV_positives_simulate/sample_names_CYVCV-2_S3.txt



##### Folder20

INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/9_bowtie_28_pathogen_unique_taxonomy/2_bowtie2_result/20_Xanthomonas_Citri

# step3 Sort .sam output

while read sample; do

samtools sort ${INPUT}/${sample}.sam > ${INPUT}/${sample}_sorted.sam

samtools coverage ${INPUT}/${sample}_sorted.sam > ${INPUT}/${sample}_coverage.tsv

samtools view -h -S -F 4 ${INPUT}/${sample}_sorted.sam > ${INPUT}/${sample}_sorted_mapped.sam

samtools view -bt ref_genome.fasta.fai -o  ${INPUT}/${sample}_mapped.bam  ${INPUT}/${sample}_sorted_mapped.sam

samtools fasta ${INPUT}/${sample}_mapped.bam > ${INPUT}/${sample}_sorted_mapped_reads.fasta

done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/20_Xanthomonas_Citri/sample_list.txt







##### Folder20 NCBI Downloads

INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/9_bowtie_28_pathogen_unique_taxonomy/2_bowtie2_result/20_Xanthomonas_Citri/NCBI_downloads

# step3 Sort .sam output

while read sample; do

samtools sort ${INPUT}/${sample}.sam > ${INPUT}/${sample}_sorted.sam

samtools coverage ${INPUT}/${sample}_sorted.sam > ${INPUT}/${sample}_coverage.tsv

samtools view -h -S -F 4 ${INPUT}/${sample}_sorted.sam > ${INPUT}/${sample}_sorted_mapped.sam

samtools view -bt ref_genome.fasta.fai -o  ${INPUT}/${sample}_mapped.bam  ${INPUT}/${sample}_sorted_mapped.sam

samtools fasta ${INPUT}/${sample}_mapped.bam > ${INPUT}/${sample}_sorted_mapped_reads.fasta

done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/20_Xanthomonas_Citri/NCBI_downloads/sample_list.txt





##### Folder21

INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/9_bowtie_28_pathogen_unique_taxonomy/2_bowtie2_result/21_For_Beta_Testing

# step3 Sort .sam output

while read sample; do

samtools sort ${INPUT}/${sample}.sam > ${INPUT}/${sample}_sorted.sam

samtools coverage ${INPUT}/${sample}_sorted.sam > ${INPUT}/${sample}_coverage.tsv

samtools view -h -S -F 4 ${INPUT}/${sample}_sorted.sam > ${INPUT}/${sample}_sorted_mapped.sam

samtools view -bt ref_genome.fasta.fai -o  ${INPUT}/${sample}_mapped.bam  ${INPUT}/${sample}_sorted_mapped.sam

samtools fasta ${INPUT}/${sample}_mapped.bam > ${INPUT}/${sample}_sorted_mapped_reads.fasta

done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/21_For_Beta_Testing/sample_list.txt







##### Folder23

INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/9_bowtie_28_pathogen_unique_taxonomy/2_bowtie2_result/23_Xylella_positives

# step3 Sort .sam output

while read sample; do

samtools sort ${INPUT}/${sample}.sam > ${INPUT}/${sample}_sorted.sam

samtools coverage ${INPUT}/${sample}_sorted.sam > ${INPUT}/${sample}_coverage.tsv

samtools view -h -S -F 4 ${INPUT}/${sample}_sorted.sam > ${INPUT}/${sample}_sorted_mapped.sam

samtools view -bt ref_genome.fasta.fai -o  ${INPUT}/${sample}_mapped.bam  ${INPUT}/${sample}_sorted_mapped.sam

samtools fasta ${INPUT}/${sample}_mapped.bam > ${INPUT}/${sample}_sorted_mapped_reads.fasta

done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/23_Xylella_positives/NCBI_SRA/sample_list.txt





##### Folder Negative

INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/9_bowtie_28_pathogen_unique_taxonomy/2_bowtie2_result/Negative_samples

# step3 Sort .sam output

while read sample; do

samtools sort ${INPUT}/${sample}.sam > ${INPUT}/${sample}_sorted.sam

samtools coverage ${INPUT}/${sample}_sorted.sam > ${INPUT}/${sample}_coverage.tsv

samtools view -h -S -F 4 ${INPUT}/${sample}_sorted.sam > ${INPUT}/${sample}_sorted_mapped.sam

samtools view -bt ref_genome.fasta.fai -o  ${INPUT}/${sample}_mapped.bam  ${INPUT}/${sample}_sorted_mapped.sam

samtools fasta ${INPUT}/${sample}_mapped.bam > ${INPUT}/${sample}_sorted_mapped_reads.fasta

done < /scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples_add/Negative_samples/sample_list.txt






