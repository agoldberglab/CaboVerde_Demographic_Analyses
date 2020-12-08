# Preparing Ancestry Data
This directory contains all scripts used for obtaining/formatting reference population data from the 1000 Genomes Project, running PCA, estimating admixture proportions, and preparing to call local ancestry.

## 1. Obtaining/formatting reference population data from the 1000 Genomes Project
To estimate admixture proportions and call local ancestry in the Cabo Verde individuals, we merged the Cabo Verde genotypes with genotypes from 107 GWD (Gambian in Western Division - Mandinka) and 107 IBS (Iberian Population in Spain) samples called from high-coverage resequencing data released through the International Genome Sample Resource (Clarke et al., 2017; Fairley, Lowy-Gallego, Perry, & Flicek, 2020). The following scripts pertain to downloading and preparing the 1000 Genomes reference data:
* PrepRefData_step1_download1kG.sh
* PrepRefData_step2_extractRelevantSamples.sh
* PrepRefData_step3_convertToPlinkAndMergeChroms.sh (uses supporting text file autosomesMergeList-GWD_IBS.txt)

## 2. PCA and ADMIXTURE
To produce estimates of admixture proportions, we first performed unsupervised clustering of the samples using ADMIXTURE (Alexander, Novembre, & Lange, 2009), and we estimated individual ancestries by averaging over ten independent ADMIXTURE runs using K = 2. ADMIXTURE was run separately for the autosomal and X chromosome datasets after pruning based on linkage disequilibrium (LD) using the indep-pairwise option of PLINK v1.9 with a 50-SNP sliding window incremented by 10 SNPs, and an LD threshold of r2 = 0.5 (Purcell et al., 2007). We also clustered the samples using PLINK’s Principal component analysis (--pca) function, using this pruned dataset. The following scripts perform pruning, PCA, and ADMIXTURE analyses:
 * Prune_and_PCA.sh
 * RunAdmixture-10startingseeds.sh

## 3. Phasing
To prepare for local ancestry calling, we phased all samples using SHAPEIT2 (Delaneau, Zagury, & Marchini, 2013):
* phasing_step1_splitbychrom.sh
* phasing_step2_findduplicatesnps.sh
* phasing_step3_makeexcludelist-fromdupvar.sh
* phasing_step4_shapeit-check.sh
* phasing_step5_combine-exclude-lists.sh
* phasing_step6_phase.sh
* phasing_step6v2_xchr_phase.sh
* phasing_step7-takesubsets.sh
* **Note that local ancestry calling details as well as the local ancestry calls from RFMix are publicly available via Zenodo at https://doi.org/10.5281/zenodo.4021277**
