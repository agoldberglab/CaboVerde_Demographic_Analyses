#!/bin/bash
#SBATCH --mem=10GB

cd /datacommons/noor/klk37/CV/NewReseqData/Garlic-data

FILES=.bed
for FILE in $FILES
do
	NAME="$(echo ${FILE} | awk -F'[.]' '{print $1}')"
	/opt/apps/rhel7/plink-1.90/plink --bfile $NAME --recode transpose --out $NAME
done
