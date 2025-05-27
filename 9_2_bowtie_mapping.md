```bash
#!/bin/bash
#SBATCH -p batch
#SBATCH --job-name=bowtie_1-7
#SBATCH -o log_bowtie_1-7.%j.out
#SBATCH -t 72:00:00
#SBATCH --nodes=1
#SBATCH -n 32
#SBATCH --mail-user=jing.zhang10@okstate.edu
#SBATCH --mail-type=end

source /home/jing/.bashrc
conda activate nanopore

# step1
# bowtie2-build /scratch/jing/nanopore/3_temp/2_jing_citrus_data/2_genome/five_pathogen_isolates_genome_combine.fasta  ref_indexes

##### step2 mapping sample reads
##### Pathogen 1
INPUT=/scratch/jing/nanopore/... (TRUNCATED for brevity) ...

```