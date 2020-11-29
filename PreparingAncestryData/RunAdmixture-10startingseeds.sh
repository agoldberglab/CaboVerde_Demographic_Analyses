#!/bin/bash
#SBATCH --mem=10GB

#####################################################################
# Author: Katharine Korunes
#   This script sets up and launches ADMIXTURE to run 10 times 
#   with different starting seeds for the autosomes, and separately 
#   for the x chromosome. To generate ADMIXTURE estimates for 
#   Korunes et al. 2020, the input was run on the merged Cabo Verdean,
#   GWD (African reference), and IBS (European reference) dataset
#   after pruning for LD (see prune_and_pca.sh)..
#####################################################################

cd /datacommons/noor/klk37/CV/NewReseqData

for x in {1..10};
do
	#autosomes:
	AFILE=admixture_autosomes_GWD_IBS_CV_${x}run.sh
	echo "#!/bin/bash" >> $AFILE
	echo "#SBATCH --mem=20GB" >> $AFILE
	echo "#SBATCH -p scavenger" >> $AFILE	
	echo "cd /datacommons/noor/klk37/CV/NewReseqData" >> $AFILE
	echo "mkdir admixture-randomseed-${x}" >> $AFILE
	echo "cd /datacommons/noor/klk37/CV/NewReseqData/admixture-randomseed-${x}" >> $AFILE
	echo "../../admixture_linux-1.3.0/admixture -s time ../CV_reseq1kG_GWD_IBS_autosomes_pruned.bed 2" >> $AFILE
	sbatch $AFILE
	#xchr:
	XFILE=admixture_xchr_GWD_IBS_CV_${x}run.sh
	echo "#!/bin/bash" >> $XFILE
	echo "#SBATCH --mem=20GB" >> $XFILE
	echo "#SBATCH -p scavenger" >> $XFILE	
	echo "cd /datacommons/noor/klk37/CV/NewReseqData" >> $XFILE
	echo "mkdir admixture-randomseed-xchr-${x}" >> $XFILE
	echo "cd /datacommons/noor/klk37/CV/NewReseqData/admixture-randomseed-xchr-${x}" >> $XFILE
	echo "../../admixture_linux-1.3.0/admixture -s time ../CV_reseq1kG_GWD_IBS_xchr_pruned.bed 2" >> $XFILE
	sbatch $XFILE
done
