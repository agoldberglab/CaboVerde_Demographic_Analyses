#!/bin/bash
#SBATCH --mem=40GB
#SBATCH -p noor
cd /datacommons/noor/klk37/CV/NewReseqData/phasing

x=merged_auto

for c in {1..22};
do /datacommons/noor/klk37/CV/shapeit.v2/bin/shapeit \
-convert \
--input-haps ${x}_chr${c}.phased \
--output-haps ${x}_chr${c}.phased.CVsubset \
--include-ind keep_CV.inds
done

for c in {1..22};
do /datacommons/noor/klk37/CV/shapeit.v2/bin/shapeit \
-convert \
--input-haps ${x}_chr${c}.phased \
--output-haps ${x}_chr${c}.phased.IBSsubset \
--include-ind keep_ref_IBS.inds
done

for c in {1..22};
do /datacommons/noor/klk37/CV/shapeit.v2/bin/shapeit \
-convert \
--input-haps ${x}_chr${c}.phased \
--output-haps ${x}_chr${c}.phased.GWDsubset \
--include-ind keep_ref_GWD.inds
done

x=merged_xchr_withSex
c=X
/datacommons/noor/klk37/CV/shapeit.v2/bin/shapeit \
-convert \
--input-haps ${x}_chr${c}.phased \
--output-haps ${x}_chr${c}.phased.CVsubset \
--include-ind keep_CV.inds

/datacommons/noor/klk37/CV/shapeit.v2/bin/shapeit \
-convert \
--input-haps ${x}_chr${c}.phased \
--output-haps ${x}_chr${c}.phased.IBSsubset \
--include-ind keep_ref_IBS.inds

/datacommons/noor/klk37/CV/shapeit.v2/bin/shapeit \
-convert \
--input-haps ${x}_chr${c}.phased \
--output-haps ${x}_chr${c}.phased.GWDsubset \
--include-ind keep_ref_GWD.inds
