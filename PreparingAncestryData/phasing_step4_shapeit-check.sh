#!/bin/bash
#SBATCH --mem=40GB
#SBATCH -p noor
cd /datacommons/noor/klk37/CV/NewReseqData/phasing
PATH=/datacommons/noor/klk37/java/jdk1.8.0_144/bin:$PATH
export PATH

x=merged_auto

for c in {1..22};
do /datacommons/noor/klk37/CV/shapeit.v2/bin/shapeit \
-check \
--input-bed ${x}_chr${c}.bed ${x}_chr${c}.bim ${x}_chr${c}.fam \
--input-ref /datacommons/noor/klk37/CV/1000GP_Phase3/1000GP_Phase3_chr${c}.hap.gz \
/datacommons/noor/klk37/CV/1000GP_Phase3/1000GP_Phase3_chr${c}.legend.gz \
/datacommons/noor/klk37/CV/1000GP_Phase3/1000GP_Phase3.sample \
-M /datacommons/noor/klk37/CV/1000GP_Phase3/genetic_map_chr${c}_combined_b37.txt \
--output-log test_${x}_chr${c}; 
done

x=merged_xchr_withSex
/datacommons/noor/klk37/CV/shapeit.v2/bin/shapeit \
-check \
--input-bed ${x}_chrX.bed ${x}_chrX.bim ${x}_chrX.fam \
--input-ref /datacommons/noor/klk37/CV/1000GP_Phase3/1000GP_Phase3_chrX_NONPAR.hap.gz \
/datacommons/noor/klk37/CV/1000GP_Phase3/1000GP_Phase3_chrX_NONPAR.legend.gz \
/datacommons/noor/klk37/CV/1000GP_Phase3/1000GP_Phase3.sample \
-M /datacommons/noor/klk37/CV/1000GP_Phase3/genetic_map_chrX_nonPAR_combined_b37.txt \
--output-log test_${x}_chrX \
--chrX 

# add this command if you made exclude lists (ran step 3). can skip if no duplicate variants found in step 2:
# --exclude-snp exclude_${x}_chr${c}.site \
