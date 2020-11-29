#!/bin/bash
#SBATCH --mem=10GB

##############################################################
# Author: Katharine Korunes
#   This script uses the indep-pairwise option of plink (v1.9)
#   to prune based on linkage disequilibrium with a 50-SNP 
#   sliding window incremented by 10 SNPs and an LD threshold 
#   of r2=0.5. The pruned dataset is passed to the --pca 
#   function for clustering, and a separate script uses this
#   pruned dataset to run ADMIXTURE.
##############################################################

cd /datacommons/noor/klk37/CV/NewReseqData

FILES=*GWD_IBS.bed
for FILE in $FILES
do
	NAME="$(echo ${FILE} | awk -F'[.]' '{print $1}')"
	echo="pruning $NAME"
	PRUNED="$NAME"_pruned
	/opt/apps/rhel7/plink-1.90/plink --bfile $NAME --indep-pairwise 50 10 0.5 --out $PRUNED
	IN="$PRUNED".prune.in
	/opt/apps/rhel7/plink-1.90/plink --bfile $NAME --extract $IN --make-bed --out $PRUNED
	
	#PCA
	/opt/apps/rhel7/plink-1.90/plink --bfile $PRUNED --pca --out "$PRUNED"_pca
done
