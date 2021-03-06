# CaboVerde_Demographic_Analyses
This repository contains scripts for analyzing population history in Cabo Verde. The following analyses were performed in the Goldberg Lab at Duke University by Katharine Korunes (contact: kkorunes@gmail.com). 

## Citation
Our associated preprint, *"Sex-biased admixture and assortative mating shape genetic variation and influence demographic inference in admixed Cabo Verdeans,"* is available here: https://www.biorxiv.org/content/10.1101/2020.12.14.422766v1

## Datasets
- 1000 Genomes resequencing data can be accessed here: https://www.internationalgenome.org/data-portal/data-collection/30x-grch38 
- Cabo Verdean data originally described in Beleza et al. 2013 does not allow for public release of genotype data; however, inferred local ancestry information used in this study can be found at https://doi.org/10.5281/zenodo.4021277

## Software and scripts from external sources
- plink v1.9 https://www.cog-genomics.org/plink/1.9/
- ADMIXTURE v1.3.0 https://dalexander.github.io/admixture/download.html
- SHAPEIT v2 https://mathgen.stats.ox.ac.uk/genetics_software/shapeit/shapeit.html#home
- RFMix v1.5.4 https://sites.google.com/site/rfmixlocalancestryinference/
- EIGENSOFT v3 ***convertf*** https://github.com/argriffing/eigensoft/tree/master/CONVERTF
- ALDER  v1.03 http://cb.csail.mit.edu/cb/alder/
- MULTIWAVER v2.0 https://www.picb.ac.cn/PGG/resource.php
- LAD-based Zaitlen et al. method https://github.com/dpark27/ancassort
- ANCESTOR https://github.com/sriramlab/ANCESTOR/blob/master/ancestor.py
- Ancestry specific IBD Ne http://faculty.washington.edu/sguy/asibdne/
- RefinedIBD http://faculty.washington.edu/browning/refined-ibd.html
- Kinship method from Ochoa & Storey 2019 (doi: http://dx.doi.org/10.1101/653279) https://github.com/StoreyLab/human-differentiation-manuscript
- Cytoscape v3.8 https://cytoscape.org/
- GARLIC v1.1.6 https://github.com/szpiech/garlic
- R v3.6.1 https://www.r-project.org/

## The 3 directories here contain code for analyses performed in this study:
#### 1. [PreparingAncestryData](./PreparingAncestryData) contains scripts for obtaining ancestry reference panels, PCA, estimating global ancestry, and phasing.
Also includes [PreparingAncestryData/Summary.md](./PreparingAncestryData/Summary.md) with more detailed descriptions of the following steps:
* obtaining/formatting reference population data from the 1000 Genomes Project high-coverage resequencing data released through the International Genome Sample Resource (linked above)
* pruning based on LD using the indep-pairwise option of PLINK v1.9 with a 50-SNP sliding window incremented by 10 SNPs, and an LD threshold of r2 = 0.5 (Purcell et al., 2007)
* visualization using PLINK’s Principal component analysis (--pca) function, using the pruned dataset
* estimating admixture proportions through unsupervised clustering of the samples using ADMIXTURE (Alexander, Novembre, & Lange, 2009), averaged over ten independent ADMIXTURE runs using K = 2 run separately for the autosomal and X chromosome datasets after LD pruning
* phasing using SHAPEIT2 (Delaneau, Zagury, & Marchini, 2013) 
  * Note that phasing and local ancestry calling details as well as the local ancestry calls are publicly available via Zenodo at https://doi.org/10.5281/zenodo.4021277

#### 2. [AdmixtureTiming](./AdmixtureTiming) contains scripts for inference of admixture timing.
Also includes [AdmixtureTiming/Summary.md](./AdmixtureTiming/Summary.md) with more detailed descriptions of our application of three distinct strategies for estimating the timing of the onset of admixture in Cabo Verde: 
* ALDER (Loh et al., 2013)
* MultiWaver 2.0 (Ni et al., 2019)
* Zaitlen et al., 2017 (based on local ancestry linkage disequilibrium) 

#### 3. [RelatednessAndMatingPatterns](./RelatednessAndMatingPatterns) contains scripts for IBD detection, ROH calling, tests of nonrandom mating, and sex-biased admixture analyses.
Also includes [RelatednessAndMatingPatterns/Summary.md](./RelatednessAndMatingPatterns/Summary.md) with more detailed descriptions of the following analyses:
* IBD detection using the haplotype-based IBD detection method Refined IBD (B. L. Browning & Browning, 2013), followed by estimation of ancestry-specific population size using IBDNe (S. R. Browning & Browning, 2015)
* ROH calling using GARLIC v.1.1.6 (Szpiech, Blant, & Pemberton, 2017), which implements the ROH calling pipeline of Pemberton et al. (2012), following the pipeline described in Szpiech et al. (2017)
* tests of nonrandom mating over the last generation using ANCESTOR (Zou, Halperin, Burchard, & Sankararaman, 2015; Zou, Park, et al., 2015) 
* parameters and plotting script for application of a mechanistic model of sex-biased admixture (using the method of Goldberg & Rosenberg 2015).
