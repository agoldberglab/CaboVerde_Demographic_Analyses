#!/bin/bash
#SBATCH --mem=10GB

cd /datacommons/noor/klk37/CV/NewReseqData/run_Alder

# Update bed files to reflect population membership
FILES=*.bed
for FILE in $FILES
do
	NAME="$(echo ${FILE} | awk -F'[.]' '{print $1}')"
	/opt/apps/rhel7/plink-1.90/plink --bfile $NAME --update-ids updateIDs-all.txt --make-bed --out "$NAME"_pops
done

# Relabel the "phenotypes" (column 6) of the *.fam files from -9 (missing) to 1s, as per the Eigensoft FAQs
FILES3=*.fam
for FAM in $FILES3
do
	NAME="$(echo ${FAM} | awk -F'[.]' '{print $1}')"
	echo "converting $NAME"
	OUTFAM="$NAME"_relabeled.fam
	awk -v new="1" 'BEGIN{OFS=FS=" "}{$6=new}1' $FAM > $OUTFAM
done
