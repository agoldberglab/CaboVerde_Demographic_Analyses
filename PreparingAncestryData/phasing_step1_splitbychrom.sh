#!/bin/bash
#SBATCH --mem=10GB
#SBATCH -p noor
cd /datacommons/noor/klk37/CV/NewReseqData/phasing

for c in {1..22};
do /opt/apps/rhel7/plink-1.90/plink \
--bfile CV_reseq1kG_GWD_IBS_Hg19_autosomes \
--chr ${c} \
--geno \
--mind \
--make-bed \
--out merged_auto_chr${c};
done

/opt/apps/rhel7/plink-1.90/plink \
--bfile CV_reseq1kG_GWD_IBS_Hg19_xchr \
--chr X \
--geno \
--mind \
--make-bed \
--out merged_xchr_chrX

