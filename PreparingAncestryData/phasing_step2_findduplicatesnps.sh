#!/bin/bash
#SBATCH --mem=10GB
#SBATCH -p noor
cd /datacommons/noor/klk37/CV/NewReseqData/phasing

FILES=merged*.bed
for FILE in $FILES
do
	NAME="$(echo ${FILE} | awk -F'[.]' '{print $1}')"
	/opt/apps/rhel7/plink-1.90/plink --bfile $NAME --list-duplicate-vars --out "$NAME"
done
