```bash
#!/bin/bash
#SBATCH -p batch
#SBATCH --job-name=citrus_taxonomy_db
#SBATCH -o log_citrus_taxonomy_db.%j.out
#SBATCH -t 120:00:00
#SBATCH --nodes=1
#SBATCH -n 32
#SBATCH --mail-user=jing.zhang10@okstate.edu
#SBATCH --mail-type=end

source /home/jing/.bashrc
conda activate nanopore

INPUT=/scratch/jing/nanopore/3_temp/2_jing_citrus_data/2_genome/citrus_pathogen_whole_28_database_taconomy_level

kraken2-build --download-taxonomy --db citrus_data_db_28_pathogen
kraken2-build --add-to-library ${INPUT}/1_CLBV_GCA_031123385.1_ASM3112338v1_genomic.fasta   --db citrus_data_db_28_pathogen
kraken2-build --add-to-library ${INPUT}/1_CLBV_GCF_000852305.1_ViralProj14825_genomic.fasta  --db citrus_data_db_28_pathogen
kraken2-build --add-to-library ${INPUT}/2_CSDaV_GCF_000858145.1_ViralProj15170_genomic.fasta  --db citrus_data_db_28_pathogen
kraken2-build --add-to-library ${INPUT}/3_CVd-Ia_GCA_031112995.1_ASM3111299v1_genomic.fasta  --db citrus_data_db_28_pathogen
kraken2-build --add-to-library ${INPUT}/4_CVa-II_GCA_027574605.1_ASM2757460v1_genomic.fasta  --db citrus_data_db_28_pathogen
kraken2-build --add-to-library ${INPUT}/4_CVa-II_GCF_000847785.1_ViralProj14720_genomic.fasta  --db citrus_data_db_28_pathogen
kraken2-build --add-to-library ${INPUT}/5_CVd-III_GCA_031109325.1_ASM3110932v1_genomic.fasta  --db citrus_data_db_28_pathogen
kraken2-build --add-to-library ${INPUT}/5_CVd-III_GCA_031113195.1_ASM3111319v1_genomic.fasta  --db citrus_data_db_28_pathogen
kraken2-build --add-to-library ${INPUT}/5_CVd-III_GCF_000856305.1_ViralProj14974_genomic.fasta  --db citrus_data_db_28_pathogen
kraken2-build --add-to-library ${INPUT}/6_CVd-IV_GCF_000852785.1_ViralProj14757_genomic.fasta  --db citrus_data_db_28_pathogen
kraken2-build --add-to-library ${INPUT}/7_CVd-V_GCF_000878955.1_ViralProj28115_genomic.fasta  --db citrus_data_db_28_pathogen
kraken2-build --add-to-library ${INPUT}/8_CVD-VI_GCF_000884515.1_ViralProj42701_genomic.fasta  --db citrus_data_db_28_pathogen
kraken2-build --add-to-library ${INPUT}/9_CVV_GCF_000870745.1_ViralMultiSegProj19747_genomic.fasta  --db citrus_data_db_28_pathogen
kraken2-build --add-to-library ${INPUT}/10_CYVaV_GCF_003726535.1_ASM372653v1_genomic.fasta   --db citrus_data_db_28_pathogen
kraken2-build --add-to-library ${INPUT}/11_Canker_GCF_041519315.1_NCPPB972v1_ONT_genomic.fasta  --db citrus_data_db_28_pathogen
kraken2-build --add-to-library ${INPUT}/11_Xanthomonas_axonopodis_GCA_002019105.1_ASM201910v1_genomic.fasta   --db citrus_data_db_28_pathogen
kraken2-build --add-to-library ${INPUT}/12_Candidatus_Phytoplasma_GCF_000026205.1_ASM2620v1_genomic.fasta   --db citrus_data_db_28_pathogen
kraken2-build --add-to-library ${INPUT}/12_Candidatus_Phytoplasma_GCF_038505995.1_ASM3850599v1_genomic.fasta   --db citrus_data_db_28_pathogen
kraken2-build --add-to-library ${INPUT}/14_CEVd_GCA_031116445.1_ASM3111644v1_genomic.fasta    --db citrus_data_db_28_pathogen
kraken2-build --add-to-library ${INPUT}/14_CEVd_GCA_031116455.1_ASM3111645v1_genomic.fasta   --db citrus_data_db_28_pathogen
kraken2-build --add-to-library ${INPUT}/14_CEVd_GCA_031122155.1_ASM3112215v1_genomic.fasta    --db citrus_data_db_28_pathogen
kraken2-build --add-to-library ${INPUT}/14_CEVd_GCA_031122165.1_ASM3112216v1_genomic.fasta  --db citrus_data_db_28_pathogen
kraken2-build --add-to-library ${INPUT}/14_CEVd_GCF_000849865.1_ViralProj14637_genomic.fasta  --db citrus_data_db_28_pathogen
kraken2-build --add-to-library ${INPUT}/15_CPsV_GCF_000855005.1_ViralMultiSegProj15060_genomic.fasta  --db citrus_data_db_28_pathogen
kraken2-build --add-to-library ${INPUT}/16_CTLV_GCA_031106045.1_ASM3110604v1_genomic.fasta  --db citrus_data_db_28_pathogen
kraken2-build --add-to-library ${INPUT}/17_CTV_GCF_000862265.1_ViralProj15334_genomic.fasta   --db citrus_data_db_28_pathogen
kraken2-build --add-to-library ${INPUT}/18_CVEV_GCF_000910315.1_ViralProj209366_genomic.fasta  --db citrus_data_db_28_pathogen
kraken2-build --add-to-library ${INPUT}/19_CYVCV_GCF_000955035.1_ViralProj276866_genomic.fasta   --db citrus_data_db_28_pathogen
kraken2-build --add-to-library ${INPUT}/20_Xanthomonas_citri_pv_citri_GCF_000961215.1_ASM96121v1_genomic.fasta  --db citrus_data_db_28_pathogen
kraken2-build --add-to-library ${INPUT}/22_CiVA_GCF_013087035.1_ASM1308703v1_genomic.fasta  --db citrus_data_db_28_pathogen
kraken2-build --add-to-library ${INPUT}/23_Xylella_fastidiosa_GCF_028891345.1_ASM2889134v1_genomic.fasta  --db citrus_data_db_28_pathogen
kraken2-build --add-to-library ${INPUT}/24_CEPV_GCF_000916755.1_ViralProj232404_genomic.fasta  --db citrus_data_db_28_pathogen
kraken2-build --add-to-library ${INPUT}/25_CBLVd_GCF_000855385.1_ViralProj14969_genomic.fasta  --db citrus_data_db_28_pathogen
kraken2-build --add-to-library ${INPUT}/26_Huanglongbing_GCF_000590865.3_ASM59086v3_genomic.fasta  --db citrus_data_db_28_pathogen
kraken2-build --add-to-library ${INPUT}/27_Xanthomonas_euvesicatoria_pv.citrumelo_F1_GCF_000225915.1_genomic.fasta  --db citrus_data_db_28_pathogen
kraken2-build --add-to-library ${INPUT}/28_Spiroplasma_citri_GCF_001886855.1_ASM188685v1_genomic.fasta  --db citrus_data_db_28_pathogen
kraken2-build --build --db citrus_data_db_28_pathogen

```