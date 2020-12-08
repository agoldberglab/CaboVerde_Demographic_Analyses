# Relatedness and mating patterns
This directory contains scripts used for IBD detection, ROH calling, tests of nonrandom mating, and tests of sex-biased admixture in Cabo Verde.

## 1. Assortative mating
We tested for assortative mating over the last generation using ANCESTOR (Zou, Halperin, Burchard, & Sankararaman, 2015; Zou, Park, et al., 2015). 
* ancestor_step1_parseRFmix.pl
* ancestor_step2_collapseAncestryBlocks.pl
* ancestor_step3_runAncestor.sh
* ancestor_step4_parseoutput_IndivChrom.pl

## 2. IBD
Following the analysis pipeline of S. R. Browning et al. (2018), we inferred segments of IBD using the haplotype-based IBD detection method Refined IBD (B. L. Browning & Browning, 2013), and we estimated ancestry-specific population size using IBDNe (S. R. Browning & Browning, 2015). After running Refined IBD, we used its gap-filling utility to remove gaps between segments less than 0.6 cM that had at most one discordant homozygote. We then filtered out IBD segments smaller than 5 cM, as short segments below this threshold are difficult to accurately detect (Nelson et al., 2020). See associated scripts:
* refinedIBD_step1.sh
* refinedIBD_step2.sh
* refinedIBD_tallyIBD_step1.sh
* refinedIBD_tallyIBDover5cM_step2.pl
* Visualizing IBD:
  * Plot_IBDne_09012020.R and Plot_relatednessIBD_10242020.R
  * To visualize IBD sharing in Fig 1 and Supp Fig 2, the sum of IBD shared in each pairwise comparison of individuals was plotted by using Cytoscape 3.8 to group nodes by island, position nodes within each island according to a prefuse force-directed algorithm, and scale the color of edges based on log-transformed total IBD length (Shannon et al., 2003). 

## 3. ROH
We called ROH using GARLIC v.1.1.6 (Szpiech, Blant, & Pemberton, 2017), which implements the ROH calling pipeline of Pemberton et al. (2012). We performed this analysis separately for the autosomes and X chromosome. Following best-practices described in Szpiech et al. (2017), we used a single constant genotyping error rate of 0.001, we allowed GARLIC to automatically choose a window size for each population (--auto-winsize), and we used the resample flag to mitigate biases in allele frequency estimates caused by differing sample sizes. See associated scripts:
* GarlicStep1_keep-subset-per-pop.sh
* GarlicStep2_transpose.sh
* GarlicStep3_runGarlic_testwindows.sh
* GarlicStep4_parse-garlic-by-indiv.pl
* For visualization of the ROH results, see Plot-GarlicROH-Byclass-withresample_09022020.R

## 4. Sex-biased admixture
We used the following parameters to apply a mechanistic model of sex-biased admixture using the method of Goldberg & Rosenberg 2015:

| Population, sample | Males | Females | Autosomal, mean Afr ancestry | X chr, mean Afr ancestry | p (percent female) |
| ------------------ | ----- | ------- | ---------------------------- | ------------------------ | ------------------ |
| CV (all), n = 563 | 234 | 329 | 0.5996 | 0.7585 | 0.5844 |
| Santiago, n = 172 | 70 | 102 | 0.7371 | 0.8678 | 0.5930 |
| Fogo, n = 129 | 54 | 75 | 0.4984 | 0.6797 | 0.5814 |
| NWcluster, n = 236 | 96 | 140 | 0.5519 | 0.7243 | 0.5932 |
| Boa Vista, n = 26 | 14 | 12 | 0.6241 | 0.7373 | 0.4615 |

* The above admixture proportions were collected from the ADMIXTURE results (using African ancestry averaged over 10 runs)
* For visualization of sex-biased admixture parameters, see Plot_SexBias_ContinuousAdmixture_09252020.R
