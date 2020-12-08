# Admixture Timing
This directory includes scripts for our application of three distinct strategies for estimating the timing of the onset of admixture in Cabo Verde. 

## 1. ALDER (Loh et al., 2013) 
* We first prepped the plink-formatted data by updating all IDs to reflect island membership and relabeling the “phenotypes” (column 6 in .fam files were -9 (missing) but convertf ignores individuals with -9 codings. Changed the column to 1s per the Eigensoft FAQ) using the following script:
  * ALDER_prep-input.sh
* We converted the genotypes to EIGENSTRAT format using convertf (Patterson, Price, & Reich, 2006; Price et al., 2006):
  * convertf -p par.PED.EIGENSTRAT
* We then ran ALDER to date admixture timing on each island using default parameters with mindis = 0.005 and source populations specified (refpops:GWD;IBS) 

## 2. MultiWaver 2.0 (Ni et al., 2019) 
We ran MultiWaver using the ancestry tracts inferred by RFMix, default parameters, and 100 bootstraps. 
* MultiWaver_step1_parseRFmix.pl
* MultiWaver_step2_collapseAncestryBlocks.pl
* MultiWaver_step3_runMultiWaver.sh

## 3. LAD-based method (Zaitlen et al. 2017) 
We followed the pipeline of Zaitlen et al. (2017) and its accompanying scripts to use the RFMix local ancestry calls to measure local ancestry disequilibrium (LAD) decay in 10 Mb windows, overlapping by 1 Mb. Specifically, we started with the first SNP on each autosome, used the 10 Mb window end point to identify the SNP closest to the inside of this boundary, and then used local ancestry calls at these positions to determine LAD. We repeated this process along each chromosome to obtain LAD in 279 autosomal windows. 
* LAD_step1_ByIsland_09152020.pl
* LAD_step2_ByIsland_09152020.pl
* The above steps generate the input for Zaitlen et al. (2017) scripts (https://github.com/dpark27/ancassort). Using possible values of admixture generations ranging from 5-25, we determined the best fit using island-specific mean LAD decay over the 279 autosomal windows, assortative mating parameters estimated with ANCESTOR, a starting autosomal admixture proportion of 0.65, and either no migration or with migration (migration rate = 0.01).

**See also Plot_admixturetiming_09212020.R for visualizing the results of the above analyses**
