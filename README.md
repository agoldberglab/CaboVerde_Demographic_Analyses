# CaboVerde_Demographic_Analyses
This repository contains scripts for analyzing population history in Cabo Verde. The following analyses were performed in the Goldberg Lab at Duke University by Katharine Korunes (contact: kkorunes@gmail.com). These analyses were conducted using genotype data originally described in Beleza et al. 2013, which included 563 Cabo Verdeans. Sampling consent forms do not allow for public release of genotype data; however, inferred local ancestry information can be found at https://doi.org/10.5281/zenodo.4021277

#### Scripts for obtaining ancestry reference panels, clustering, and estimating ancestry are contained in the subdirectory "PreparingAncestryData":
This directory contains scripts and details for:
- obtaining/formatting reference population data from the 1000 Genomes Project high-coverage resequencing data released through the International Genome Sample Resource (Clarke et al., 2017; Fairley, Lowy-Gallego, Perry, & Flicek, 2020)
- pruning based on LD using the indep-pairwise option of PLINK v1.9 with a 50-SNP sliding window incremented by 10 SNPs, and an LD threshold of r2 = 0.5 (Purcell et al., 2007)
- visualization using PLINK’s Principal component analysis (--pca) function, using the pruned dataset
- estimating admixture proportions through unsupervised clustering of the samples using ADMIXTURE (Alexander, Novembre, & Lange, 2009), averaged over ten independent ADMIXTURE runs using K = 2 run separately for the autosomal and X chromosome datasets after LD pruning
- preparing to call local ancestry. Briefly, we phased all samples using SHAPEIT2 (Delaneau, Zagury, & Marchini, 2013), and then called local ancestry with RFMix (Maples, Gravel, Kenny, & Bustamante, 2013) using a two-way admixture model using the West African and European reference genotypes. Note that phasing and local ancestry calling details as well as the local ancestry calls are publicly available via Zenodo at https://doi.org/10.5281/zenodo.4021277

#### Scripts for inference of admixture timing are contained in the subdirectory "AdmixtureTiming":
This directory includes scripts for our application of three distinct strategies for estimating the timing of the onset of admixture in Cabo Verde: 
- ALDER (Loh et al., 2013)
- MultiWaver 2.0 (Ni et al., 2019)
- Zaitlen et al., 2017 (based on local ancestry linkage disequilibrium) 

#### Scripts for IBD detection, ROH calling, tests of nonrandom mating, and sex-biased admixture are containing in the subdirectory "RelatednessAndMatingPatterns":
This directory contains all scripts used for:
- IBD detection using the haplotype-based IBD detection method Refined IBD (B. L. Browning & Browning, 2013), followed by estimation of ancestry-specific population size using IBDNe (S. R. Browning & Browning, 2015)
- ROH calling using GARLIC v.1.1.6 (Szpiech, Blant, & Pemberton, 2017), which implements the ROH calling pipeline of Pemberton et al. (2012), following the pipeline described in Szpiech et al. (2017)
- tests of nonrandom mating over the last generation using ANCESTOR (Zou, Halperin, Burchard, & Sankararaman, 2015; Zou, Park, et al., 2015) 
- plotting results of mechanistic model of sex-biased admixture (using the method of Goldberg & Rosenberg 2015).
