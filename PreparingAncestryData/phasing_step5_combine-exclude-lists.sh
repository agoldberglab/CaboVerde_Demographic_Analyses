#!/bin/bash
#SBATCH --mem=10GB
#SBATCH -p noor
cd /datacommons/noor/klk37/CV/NewReseqData/phasing/

x=merged_auto

for c in {1..22};
do cat test_${x}_chr${c}.snp.strand.exclude > exclude_full-list_${x}_chr${c}.exclude
#Version to use if there were duplicate snps
#do cat exclude_${x}_chr${c}.site test_${x}_chr${c}.snp.strand.exclude > exclude_full-list_${x}_chr${c}.exclude
done

cat test_merged_xchr_withSex_chrX.snp.strand.exclude > exclude_full-list_merged_xchr_withSex_chrX.exclude
#Version to use if there were duplicate snps
#cat exclude_merged_xchr_chr${c}.site test_merged_xchr_chr${c}.snp.strand.exclude > exclude_full-list_merged_xchr_chr${c}.exclude
