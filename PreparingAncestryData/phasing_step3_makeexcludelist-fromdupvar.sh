#!/bin/bash
#SBATCH --mem=40GB
cd /datacommons/noor/klk37/CV/phasing/try-together

DUPS=*.dupvar
for DUP in $DUPS
do
	#name="$(echo ${R1} | awk -F'[_' '{print $1}')"
	name="$(echo ${DUP} | grep -oP '.*(?=.dupvar)')"
	echo "working on $name"
	OUT=exclude_"$name".site	
	awk 'NR>1' $DUP | awk '{print $2}' > $OUT	
done
