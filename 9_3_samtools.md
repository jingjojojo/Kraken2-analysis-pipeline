```bash
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
INPUT=/scratch/jing/nanopore/... (TRUNCATED for brevity) ...

```