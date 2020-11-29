#!/bin/bash
#SBATCH --mem=20GB

#######################################################
# Author: Katharine Korunes
#   For the 1kG dataset, convert VCF to PLINK, extract
#   the SNPs shared with the Cabo Verdean dataset, and
#   merge the autosomes.
#######################################################

cd /work/klk37/1kG_reseq/

for c in {1..22};
do
	FILE=reseq1kG_chr${c}_107GWD_107IBS_03062020.vcf.gz
	TMP=reseq1kG_chr${c}_107GWD_107IBS_03062020-TMP
	OUT=reseq1kG_chr${c}_107GWD_107IBS
	/opt/apps/rhel7/plink-1.90/plink --vcf $FILE --biallelic-only --vcf-require-gt --vcf-min-qual 10 --set-missing-var-ids @:\# --make-bed --out $TMP
	/opt/apps/rhel7/plink-1.90/plink --bfile $TMP --extract extract_CVvariants.txt --make-bed --out $OUT
done

# Now merge the autosomes:
/opt/apps/rhel7/plink-1.90/plink --bfile reseq1kG_chr1_107GWD_107IBS --merge-list autosomesMergeList-GWD_IBS.txt --allow-no-sex --make-bed --out reseq1kG_autosomes_107GWD_107IBS
