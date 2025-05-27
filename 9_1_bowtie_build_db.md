```bash
#!/bin/bash
#SBATCH -p batch
#SBATCH --job-name=bowtie_1_build_28
#SBATCH -o log_bowtie_1_build_28.%j.out
#SBATCH -t 5:00:00
#SBATCH --nodes=1
#SBATCH -n 32
#SBATCH --mail-user=jing.zhang10@okstate.edu
#SBATCH --mail-type=end

source /home/jing/.bashrc
conda activate nanopore

# step1
bowtie2-build /scratch/jing/nanopore/3_temp/2_jing_citrus_data/2_genome/citrus_pathogen_whole_28_database_taconomy_level/all_28_pathogen_unique_taxonomy.fasta  ref_indexes

```