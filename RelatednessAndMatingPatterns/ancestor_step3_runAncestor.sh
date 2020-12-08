#!/bin/bash
cd /datacommons/noor/klk37/CV/NewReseqData/ancestor/test_indivChr


FILES=../step2_indivChromosomes/ancestor-parse-step2*

for F in $FILES
	do
		OUT="$(echo ${F} | sed 's/txt/dict/')"
		#NEW="$(echo ${F} | sed 's/.txt/_over0.01.txt/')"
		#awk '$4 >= 0.01' $F > $NEW

		SH="$(echo ${F} | sed 's/.txt/runANC.sh/')"
		echo "#!/bin/bash" >> $SH
		echo "#SBATCH --mem=10GB" >> $SH
		echo "#SBATCH -p scavenger" >> $SH
		echo "#SBATCH --output=${F}.out" >> $SH
		echo "cd /datacommons/noor/klk37/CV/NewReseqData/ancestor/test_indivChr" >> $SH
		echo "source ../python2/bin/activate" >> $SH
		echo "python ../ANCESTOR-master/ancestor.py ${F} ${OUT}" >> $SH
		sbatch $SH
	done
