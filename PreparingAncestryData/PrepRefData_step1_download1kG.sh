#!/bin/bash
 
#####################################################################
# Author: Katharine Korunes
#   This script launches wget commands to download 1kG reference data.
#####################################################################

cd /work/klk37/1kG_reseq

for x in {1..22};
do
	FILE=download_${x}.sh
	echo "#!/bin/bash" >> $FILE
	echo "#SBATCH --mem=20GB" >> $FILE
	echo "#SBATCH -p scavenger" >> $FILE	
	echo "cd /work/klk37/1kG_reseq" >> $FILE
	echo "wget ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/data_collections/1000G_2504_high_coverage/working/20190425_NYGC_GATK/CCDG_13607_B01_GRM_WGS_2019-02-19_chr${x}.recalibrated_variants.vcf.gz" >> $FILE
	sbatch $FILE
done
