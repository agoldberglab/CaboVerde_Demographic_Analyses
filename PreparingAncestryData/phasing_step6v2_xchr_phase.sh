#!/bin/bash
#SBATCH --mem=10GB
#SBATCH -p noor
cd /datacommons/noor/klk37/CV/NewReseqData/phasing/

x=merged_xchr_withSex

c=X
FILE=${x}_chr${c}_runshapeit.sh
echo "#!/bin/bash" >> $FILE
echo "#SBATCH --mem=30G" >> $FILE
echo "#SBATCH -p noor" >> $FILE
echo "cd /datacommons/noor/klk37/CV/NewReseqData/phasing" >> $FILE
echo "/datacommons/noor/klk37/CV/shapeit.v2/bin/shapeit \\" >> $FILE
echo "--input-bed ${x}_chr${c}.bed ${x}_chr${c}.bim ${x}_chr${c}.fam \\" >> $FILE
echo "--input-ref /datacommons/noor/klk37/CV/1000GP_Phase3/1000GP_Phase3_chr${c}_NONPAR.hap.gz \\" >> $FILE
echo "/datacommons/noor/klk37/CV/1000GP_Phase3/1000GP_Phase3_chr${c}_NONPAR.legend.gz \\" >> $FILE
echo "/datacommons/noor/klk37/CV/1000GP_Phase3/1000GP_Phase3.sample \\" >> $FILE
echo "-M /datacommons/noor/klk37/CV/1000GP_Phase3/genetic_map_chr${c}_nonPAR_combined_b37.txt \\" >> $FILE
echo "--exclude-snp exclude_full-list_${x}_chr${c}.exclude \\" >> $FILE
echo "-O ${x}_chr${c}.phased \\" >> $FILE
echo "--output-log ${x}_chr${c}.phased.log" >> $FILE
sbatch $FILE;
