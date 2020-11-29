#!/bin/bash
#SBATCH --mem=10GB

cd /datacommons/noor/klk37/CV/NewReseqData/RefinedIBD
PATH=/datacommons/noor/klk37/java/jdk1.8.0_144/bin:$PATH
export PATH

#Combine the output from all autosomes:
OUT=IBDout_CV_filled_allChr.ibd
TEMP=IBDall.tmp
touch $OUT
for c in {1..22};
do 
cat $OUT IBDout_CV_filled_chr${c}.ibd > $TEMP
mv $TEMP $OUT
done

