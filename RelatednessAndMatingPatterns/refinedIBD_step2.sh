#!/bin/bash
#SBATCH --mem=20GB

cd /datacommons/noor/klk37/CV/NewReseqData/RefinedIBD
PATH=/datacommons/noor/klk37/java/jdk1.8.0_144/bin:$PATH
export PATH

source /datacommons/noor/klk37/CV/NewReseqData/ancestor/python2/bin/activate

# Rephase RFmix output to match original phasing
for c in {1..22}; do 
cut -c429-1554 IBS_GWD_CV_chr${c}.rfmix.allelesRephased2.txt > CV_chr${c}.rfmix.allelesRephased2.txt
cut -d ' ' -f429-1554 IBS_GWD_CV_chr${c}.rfmix.2.Viterbi.txt > CV_chr${c}.rfmix.2.Viterbi.txt
python rephasevit.py merged_auto_chr${c}.phased.CVsubset.vcf admids.txt CV_chr${c}.rfmix.allelesRephased2.txt CV_chr${c}.rfmix.2.Viterbi.txt > phasedforIBD_CV_chr${c}
done

#Filter on population and put in ancestry
nanc=2
for c in {1..22}; do 
python filter_gapfilled_ibd_ancestry.py IBDout_CV_chr${c}.ibd IBDout_CV_filled_chr${c}.ibd phasedforIBD_CV_chr${c} $nanc > allanc_chr${c}.gapfilled_ibd
for anc in 1 2; do
cat allanc_chr${c}.gapfilled_ibd | grep -i "[[:space:]]${anc}"'$' | cut -f1-8 -d' ' > anc${anc}_chr${c}.gapfilled_ibd
done
done

#combine data from different chromosomes
for anc in 1 2; do
cat anc${anc}_chr[1-9].gapfilled_ibd anc${anc}_chr[1-2][0-9].gapfilled_ibd > anc${anc}_allchrom.gapfilled_ibd
done

#calculate adjusted number of pairs of haps
for anc in 1 2; do
cat phasedforIBD_CV_chr[1-9] phasedforIBD_CV_chr[1-2][0-9] | java -jar filtercolumns.jar 1 admids.txt | python adjust_npairs.py $anc > anc${anc}_npairs
done

#run IBDNe using 2cM IBD length threshold
cm=2
for anc in 1 2; do
cat anc${anc}_allchrom.gapfilled_ibd | java -jar ibdne.23Apr20.ae9.jar map=plink.chrAll.GRCh37.map nthreads=12 mincm=$cm npairs=`cat anc${anc}_npairs` filtersamples=false out=anc${anc}_${cm}cM.ibdne
done
