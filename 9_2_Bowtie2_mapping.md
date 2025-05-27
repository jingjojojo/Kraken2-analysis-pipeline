$ cat 2\_bowtie\_1\_7.sh 
#!/bin/bash
#SBATCH -p batch
#SBATCH --job-name=bowtie\_1-7
#SBATCH -o log\_bowtie\_1-7.%j.out
#SBATCH -t 72:00:00
#SBATCH --nodes=1
#SBATCH -n 32
#SBATCH --mail-user=jing.zhang10@okstate.edu
#SBATCH --mail-type=end

source /home/jing/.bashrc
conda activate nanopore

# step1
# bowtie2-build /scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/2\_genome/five\_pathogen\_isolates\_genome\_combine.fasta ref\_indexes

##### step2 mapping sample reads
##### Pathogen 1
INPUT=/scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/8\_clean\_data/1\_CLBV\_positives\_8
OUTPUT=/scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/9\_bowtie\_28\_pathogen\_unique\_taxonomy/2\_bowtie2\_result/1\_CLBV\_positives
mkdir -p "$OUTPUT"
while read sample; do
bowtie2 -q --local -x ref\_indexes -1 ${INPUT}/${sample}\_R1\_clean.fastq.gz -2 ${INPUT}/${sample}\_R2\_clean.fastq.gz -S ${OUTPUT}/${sample}.sam
done < /scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/1\_samples/1\_CLBV\_positives/sample\_list.txt

##### Pathogen 2
INPUT=/scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/8\_clean\_data/2\_CSDaV\_positives
OUTPUT=/scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/9\_bowtie\_28\_pathogen\_unique\_taxonomy/2\_bowtie2\_result/2\_CSDaV\_positives
mkdir -p "$OUTPUT"
while read sample; do
bowtie2 -q --local -x ref\_indexes -1 ${INPUT}/${sample}\_R1\_clean.fastq.gz -2 ${INPUT}/${sample}\_R2\_clean.fastq.gz -S ${OUTPUT}/${sample}.sam
done < /scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/1\_samples/2\_CSDaV\_positives/sample\_list.txt

##### Pathogen 3
INPUT=/scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/8\_clean\_data/3\_CVd\_I\_positives
OUTPUT=/scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/9\_bowtie\_28\_pathogen\_unique\_taxonomy/2\_bowtie2\_result/3\_CVd\_I\_positives
mkdir -p "$OUTPUT"
while read sample; do
bowtie2 -q --local -x ref\_indexes -1 ${INPUT}/${sample}\_R1\_clean.fastq.gz -2 ${INPUT}/${sample}\_R2\_clean.fastq.gz -S ${OUTPUT}/${sample}.sam
done < /scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/1\_samples/3\_CVd\_I\_positives/sample\_list.txt

##### Pathogen 4
INPUT=/scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/8\_clean\_data/4\_CVd\_II\_positives
OUTPUT=/scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/9\_bowtie\_28\_pathogen\_unique\_taxonomy/2\_bowtie2\_result/4\_CVd\_II\_positives
mkdir -p "$OUTPUT"
while read sample; do
bowtie2 -q --local -x ref\_indexes -1 ${INPUT}/${sample}\_R1\_clean.fastq.gz -2 ${INPUT}/${sample}\_R2\_clean.fastq.gz -S ${OUTPUT}/${sample}.sam
done < /scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/1\_samples/4\_CVd\_II\_positives/sample\_list.txt

##### Pathogen 5
INPUT=/scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/8\_clean\_data/5\_CVd\_III\_positives
OUTPUT=/scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/9\_bowtie\_28\_pathogen\_unique\_taxonomy/2\_bowtie2\_result/5\_CVd\_III\_positives
mkdir -p "$OUTPUT"
while read sample; do
bowtie2 -q --local -x ref\_indexes -1 ${INPUT}/${sample}\_R1\_clean.fastq.gz -2 ${INPUT}/${sample}\_R2\_clean.fastq.gz -S ${OUTPUT}/${sample}.sam
done < /scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/1\_samples/5\_CVd\_III\_positives/sample\_list.txt

##### Pathogen 6
INPUT=/scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/8\_clean\_data/6\_CVd\_IV\_positives
OUTPUT=/scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/9\_bowtie\_28\_pathogen\_unique\_taxonomy/2\_bowtie2\_result/6\_CVd\_IV\_positives
mkdir -p "$OUTPUT"
while read sample; do
bowtie2 -q --local -x ref\_indexes -1 ${INPUT}/${sample}\_R1\_clean.fastq.gz -2 ${INPUT}/${sample}\_R2\_clean.fastq.gz -S ${OUTPUT}/${sample}.sam
done < /scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/1\_samples/6\_CVd\_IV\_positives/sample\_list.txt

##### Pathogen 7
INPUT=/scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/8\_clean\_data/7\_CVd\_V\_positives
OUTPUT=/scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/9\_bowtie\_28\_pathogen\_unique\_taxonomy/2\_bowtie2\_result/7\_CVd\_V\_positives
mkdir -p "$OUTPUT"
while read sample; do
bowtie2 -q --local -x ref\_indexes -1 ${INPUT}/${sample}\_R1\_clean.fastq.gz -2 ${INPUT}/${sample}\_R2\_clean.fastq.gz -S ${OUTPUT}/${sample}.sam
done < /scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/1\_samples/7\_CVd\_V\_positives/sample\_list.txt

##### Pathogen 9
INPUT=/scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/8\_clean\_data/9\_CVV\_positives
OUTPUT=/scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/9\_bowtie\_28\_pathogen\_unique\_taxonomy/2\_bowtie2\_result/9\_CVV\_positives
mkdir -p "$OUTPUT"
while read sample; do
bowtie2 -q --local -x ref\_indexes -1 ${INPUT}/${sample}\_R1\_clean.fastq.gz -2 ${INPUT}/${sample}\_R2\_clean.fastq.gz -S ${OUTPUT}/${sample}.sam
done < /scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/1\_samples/9\_CVV\_positives/sample\_list.txt


##### Pathogen 10
INPUT=/scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/8\_clean\_data/10\_CYVaV\_positives
OUTPUT=/scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/9\_bowtie\_28\_pathogen\_unique\_taxonomy/2\_bowtie2\_result/10\_CYVaV\_positives
mkdir -p "$OUTPUT"
while read sample; do
bowtie2 -q --local -x ref\_indexes -1 ${INPUT}/${sample}\_R1\_clean.fastq.gz -2 ${INPUT}/${sample}\_R2\_clean.fastq.gz -S ${OUTPUT}/${sample}.sam
done < /scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/1\_samples/10\_CYVaV\_positives/sample\_list.txt


##### Pathogen 11
INPUT=/scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/8\_clean\_data/11\_Canker\_positives
OUTPUT=/scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/9\_bowtie\_28\_pathogen\_unique\_taxonomy/2\_bowtie2\_result/11\_Canker\_positives
mkdir -p "$OUTPUT"
while read sample; do
bowtie2 -q --local -x ref\_indexes -1 ${INPUT}/${sample}\_R1\_clean.fastq.gz -2 ${INPUT}/${sample}\_R2\_clean.fastq.gz -S ${OUTPUT}/${sample}.sam
done < /scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/1\_samples/11\_Canker\_positives/sample\_list.txt


##### Pathogen 12
INPUT=/scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/8\_clean\_data/12\_Phytoplasma\_Testing
OUTPUT=/scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/9\_bowtie\_28\_pathogen\_unique\_taxonomy/2\_bowtie2\_result/12\_Phytoplasma\_Testing
mkdir -p "$OUTPUT"
while read sample; do
bowtie2 -q --local -x ref\_indexes -1 ${INPUT}/${sample}\_R1\_clean.fastq.gz -2 ${INPUT}/${sample}\_R2\_clean.fastq.gz -S ${OUTPUT}/${sample}.sam
done < /scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/1\_samples/12\_Phytoplasma\_Testing/sample\_list.txt

##### Pathogen 12 single-end
INPUT=/scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/8\_clean\_data/12\_Phytoplasma\_Testing
OUTPUT=/scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/9\_bowtie\_28\_pathogen\_unique\_taxonomy/2\_bowtie2\_result/12\_Phytoplasma\_Testing
mkdir -p "$OUTPUT"
bowtie2 -q --local -x ref\_indexes -U ${INPUT}/Sample\_6\_S3\_R1\_clean.fastq.gz -S ${OUTPUT}/Sample\_6\_S3.sam

##### Pathogen 14
INPUT=/scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/8\_clean\_data/14\_CEVd\_positives
OUTPUT=/scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/9\_bowtie\_28\_pathogen/2\_bowtie2\_result/14\_CEVd\_positives
mkdir -p "$OUTPUT"
while read sample; do
bowtie2 -q --local -x ref\_indexes -1 ${INPUT}/${sample}\_R1\_clean.fastq.gz -2 ${INPUT}/${sample}\_R2\_clean.fastq.gz -S ${OUTPUT}/${sample}.sam
done < /scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/1\_samples/14\_CEVd\_positives/sample\_list.txt


##### Pathogen 15
INPUT=/scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/8\_clean\_data/15\_CPsV\_positives
OUTPUT=/scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/9\_bowtie\_28\_pathogen/2\_bowtie2\_result/15\_CPsV\_positives
mkdir -p "$OUTPUT"
while read sample; do
bowtie2 -q --local -x ref\_indexes -1 ${INPUT}/${sample}\_R1\_clean.fastq.gz -2 ${INPUT}/${sample}\_R2\_clean.fastq.gz -S ${OUTPUT}/${sample}.sam
done < /scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/1\_samples/15\_CPsV\_positives/sample\_list.txt

##### Pathogen 16
INPUT=/scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/8\_clean\_data/16\_CTLV\_positives
OUTPUT=/scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/9\_bowtie\_28\_pathogen\_unique\_taxonomy/2\_bowtie2\_result/16\_CTLV\_positives
mkdir -p "$OUTPUT"
while read sample; do
 bowtie2 -q --local -x ref\_indexes \
 -U ${INPUT}/${sample}\_R1\_clean.fastq.gz \
 -S ${OUTPUT}/${sample}.sam
done < /scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/1\_samples/16\_CTLV\_positives/sample\_list.txt

##### Pathogen 17
INPUT=/scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/8\_clean\_data/17\_CTV\_positives
OUTPUT=/scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/9\_bowtie\_28\_pathogen\_unique\_taxonomy/2\_bowtie2\_result/17\_CTV\_positives
mkdir -p "$OUTPUT"
bowtie2 -q --local -x ref\_indexes -U ${INPUT}/T519\_S2\_L005\_R1\_clean.fastq.gz -S ${OUTPUT}/T519\_S2\_L005.sam

##### Pathogen 19
INPUT=/scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/8\_clean\_data/19\_CYVCV\_positives
OUTPUT=/scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/9\_bowtie\_28\_pathogen\_unique\_taxonomy/2\_bowtie2\_result/19\_CYVCV\_positives
mkdir -p "$OUTPUT"
while read sample; do
 bowtie2 -q --local -x ref\_indexes \
 -U ${INPUT}/${sample}\_R1\_clean.fastq.gz \
 -S ${OUTPUT}/${sample}.sam
done < /scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/1\_samples/19\_CYVCV\_positives/sample\_list.txt
##### Pathogen 19 simulated S2
INPUT=/scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/8\_clean\_data/19\_CYVCV\_positives\_simulate
OUTPUT=/scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/9\_bowtie\_28\_pathogen\_unique\_taxonomy/2\_bowtie2\_result/simulated\_sample
mkdir -p "$OUTPUT"
while read sample; do
bowtie2 -q --local -x ref\_indexes -U ${INPUT}/${sample}.fastq.gz -S ${OUTPUT}/${sample}.sam
done < /scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/8\_clean\_data/19\_CYVCV\_positives\_simulate/sample\_names\_CYVCV-1\_S2.txt
##### Pathogen 19 simulated S3
INPUT=/scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/8\_clean\_data/19\_CYVCV\_positives\_simulate
OUTPUT=/scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/9\_bowtie\_28\_pathogen\_unique\_taxonomy/2\_bowtie2\_result/simulated\_sample
mkdir -p "$OUTPUT"
while read sample; do
bowtie2 -q --local -x ref\_indexes -U ${INPUT}/${sample}.fastq.gz -S ${OUTPUT}/${sample}.sam
done < /scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/8\_clean\_data/19\_CYVCV\_positives\_simulate/sample\_names\_CYVCV-2\_S3.txt
##### Pathogen 19 simulated S10
INPUT=/scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/8\_clean\_data/19\_CYVCV\_positives\_simulate
OUTPUT=/scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/9\_bowtie\_28\_pathogen\_unique\_taxonomy/2\_bowtie2\_result/simulated\_sample
mkdir -p "$OUTPUT"
while read sample; do
bowtie2 -q --local -x ref\_indexes -U ${INPUT}/${sample}.fastq.gz -S ${OUTPUT}/${sample}.sam
done < /scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/8\_clean\_data/19\_CYVCV\_positives\_simulate/sample\_names\_CYVCV-11\_S10.txt


##### Pathogen 19 simulated S11
INPUT=/scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/8\_clean\_data/19\_CYVCV\_positives\_simulate
OUTPUT=/scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/9\_bowtie\_28\_pathogen\_unique\_taxonomy/2\_bowtie2\_result/simulated\_sample
mkdir -p "$OUTPUT"
while read sample; do
bowtie2 -q --local -x ref\_indexes -U ${INPUT}/${sample}.fastq.gz -S ${OUTPUT}/${sample}.sam
done < /scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/8\_clean\_data/19\_CYVCV\_positives\_simulate/sample\_names\_CYVCV-12\_S11.txt

##### Pathogen 20
INPUT=/scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/8\_clean\_data/20\_Xanthomonas\_Citri
OUTPUT=/scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/9\_bowtie\_28\_pathogen\_unique\_taxonomy/2\_bowtie2\_result/20\_Xanthomonas\_Citri
mkdir -p "$OUTPUT"
while read sample; do
bowtie2 -q --local -x ref\_indexes -1 ${INPUT}/${sample}\_R1\_clean.fastq.gz -2 ${INPUT}/${sample}\_R2\_clean.fastq.gz -S ${OUTPUT}/${sample}.sam
done < /scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/1\_samples/20\_Xanthomonas\_Citri/sample\_list.txt

##### Pathogen 20 NCBI download
INPUT=/scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/8\_clean\_data/20\_Xanthomonas\_Citri/NCBI\_downloads
OUTPUT=/scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/9\_bowtie\_28\_pathogen\_unique\_taxonomy/2\_bowtie2\_result/20\_Xanthomonas\_Citri/NCBI\_downloads
mkdir -p "$OUTPUT"
while read sample; do
bowtie2 -q --local -x ref\_indexes -U ${INPUT}/${sample}\_clean.fastq.gz -S ${OUTPUT}/${sample}.sam
done < /scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/1\_samples/20\_Xanthomonas\_Citri/NCBI\_downloads/sample\_list.txt


##### Pathogen 21
INPUT=/scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/8\_clean\_data/21\_For\_Beta\_Testing
OUTPUT=/scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/9\_bowtie\_28\_pathogen\_unique\_taxonomy/2\_bowtie2\_result/21\_For\_Beta\_Testing
mkdir -p "$OUTPUT"
while read sample; do
bowtie2 -q --local -x ref\_indexes -1 ${INPUT}/${sample}\_R1\_clean.fastq.gz -2 ${INPUT}/${sample}\_R2\_clean.fastq.gz -S ${OUTPUT}/${sample}.sam
done < /scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/1\_samples/21\_For\_Beta\_Testing/sample\_list.txt

##### Pathogen 23
INPUT=/scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/8\_clean\_data/23\_Xylella\_positives
OUTPUT=/scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/9\_bowtie\_28\_pathogen\_unique\_taxonomy/2\_bowtie2\_result/23\_Xylella\_positives 
mkdir -p "$OUTPUT"
bowtie2 -q --local -x ref\_indexes -U ${INPUT}/SRR10246964\_clean.fastq.gz -S ${OUTPUT}/SRR10246964.sam
bowtie2 -q --local -x ref\_indexes -U ${INPUT}/SRR14119095\_clean.fastq.gz -S ${OUTPUT}/SRR14119095.sam
bowtie2 -q --local -x ref\_indexes -U ${INPUT}/SRR14119096\_clean.fastq.gz -S ${OUTPUT}/SRR14119096.sam
bowtie2 -q --local -x ref\_indexes -U ${INPUT}/SRR14119098\_clean.fastq.gz -S ${OUTPUT}/SRR14119098.sam
bowtie2 -q --local -x ref\_indexes -U ${INPUT}/SRR14119103\_clean.fastq.gz -S ${OUTPUT}/SRR14119103.sam
bowtie2 -q --local -x ref\_indexes -U ${INPUT}/SRR14119104\_clean.fastq.gz -S ${OUTPUT}/SRR14119104.sam
bowtie2 -q --local -x ref\_indexes -U ${INPUT}/SRR14119106\_clean.fastq.gz -S ${OUTPUT}/SRR14119106.sam
bowtie2 -q --local -x ref\_indexes -U ${INPUT}/SRR3134552\_clean.fastq.gz -S ${OUTPUT}/SRR3134552.sam
bowtie2 -q --local -x ref\_indexes -U ${INPUT}/SRR3134553\_clean.fastq.gz -S ${OUTPUT}/SRR3134553.sam
bowtie2 -q --local -x ref\_indexes -U ${INPUT}/SRR9434462\_clean.fastq.gz -S ${OUTPUT}/SRR9434462.sam

##### Pathogen Negative
INPUT=/scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/8\_clean\_data/Negative\_samples
OUTPUT=/scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/9\_bowtie\_28\_pathogen\_unique\_taxonomy/2\_bowtie2\_result/Negative\_samples
mkdir -p "$OUTPUT"
while read sample; do
bowtie2 -q --local -x ref\_indexes -1 ${INPUT}/${sample}\_R1\_clean.fastq.gz -2 ${INPUT}/${sample}\_R2\_clean.fastq.gz -S ${OUTPUT}/${sample}.sam
done < /scratch/jing/nanopore/3\_temp/2\_jing\_citrus\_data/1\_samples\_add/Negative\_samples/sample\_list.txt