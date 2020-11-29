#!/bin/bash
#SBATCH --mem=20GB

cd /datacommons/noor/klk37/CV/NewReseqData/RefinedIBD
PATH=/datacommons/noor/klk37/java/jdk1.8.0_144/bin:$PATH
export PATH

#First, run refined-ibs.17Jan20.102.jar using the phased Cabo Verde dataset:
for c in {1..22};
do 
java -Xss5m -Xmx60g -jar refined-ibd.17Jan20.102.jar gt=merged_auto_chr${c}.phased.CVsubset.vcf \
out=IBDout_CV_chr${c} \
map=plink.chr${c}.GRCh37.map
done

#Unzip files:
gunzip *gz

#Merge IBD segments
for c in {1..22};
do 
cat IBDout_CV_chr${c}.ibd | java -jar merge-ibd-segments.17Jan20.102.jar merged_auto_chr${c}.phased.CVsubset.vcf \
plink.chr${c}.GRCh37.map 0.6 1 > IBDout_CV_filled_chr${c}.ibd
done
