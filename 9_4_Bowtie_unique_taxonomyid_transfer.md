# Bowtie Unique Taxonomy ID Transfer Script

```bash
#!/bin/bash
#SBATCH -p batch
#SBATCH --job-name=bowtie_transfer
#SBATCH -o log_bowtie_transfer.%j.out
#SBATCH -t 1:00:00
#SBATCH --nodes=1
#SBATCH -n 32
#SBATCH --mail-user=jing.zhang10@okstate.edu
#SBATCH --mail-type=end

source /home/jing/.bashrc
conda activate nanopore

#!/bin/bash

sample_list="/scratch/jing/nanopore/3_temp/2_jing_citrus_data/1_samples/1_CLBV_positives/sample_list.txt"
mapping_file="Bowtie_28_pathogen_taxonomy_level.txt"

for sample in $(cat "$sample_list"); do
    echo "Processing $sample ..."
    python3 bowtie_fragment_to_taxonomyid.py "$sample" "$mapping_file"
done
```
