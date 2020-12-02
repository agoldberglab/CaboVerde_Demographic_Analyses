This directory contains all scripts used for IBD detection, ROH calling, and tests of nonrandom mating:
- We tested for assortative mating over the last generation using ANCESTOR (Zou, Halperin, Burchard, & Sankararaman, 2015; Zou, Park, et al., 2015). 
- Following the analysis pipeline of S. R. Browning et al. (2018), we inferred segments of IBD using the haplotype-based IBD detection method Refined IBD (B. L. Browning & Browning, 2013), and we estimated ancestry-specific population size using IBDNe (S. R. Browning & Browning, 2015). After running Refined IBD, we used its gap-filling utility to remove gaps between segments less than 0.6 cM that had at most one discordant homozygote. We then filtered out IBD segments smaller than 5 cM, as short segments below this threshold are difficult to accurately detect (Nelson et al., 2020). To visualize IBD sharing in Fig 1 and Supp Fig 2, the sum of IBD shared in each pairwise comparison of individuals was plotted by using Cytoscape 3.8 to group nodes by island, position nodes within each island according to a prefuse force-directed algorithm, and scale the color of edges based on log-transformed total IBD length (Shannon et al., 2003). 
- We called ROH using GARLIC v.1.1.6 (Szpiech, Blant, & Pemberton, 2017), which implements the ROH calling pipeline of Pemberton et al. (2012). We performed this analysis separately for the autosomes and X chromosome. Following best-practices described in Szpiech et al. (2017), we used a single constant genotyping error rate of 0.001, we allowed GARLIC to automatically choose a window size for each population (--auto-winsize), and we used the resample flag to mitigate biases in allele frequency estimates caused by differing sample sizes. This resulted in GARLIC selecting a window size of 50 SNPs in each of the Cabo Verde regions and in GWD, and a window size of 40 for IBS. Using a three-component Gaussian mixture model, GARLIC classified ROH into three length groups: small/class A, medium/class B, and long/class C ROH. Across all populations, Class A/B and class B/C size boundaries were inferred as approximately 300 kb and 1 Mb, respectively (see Supp Table 1 in the associated preprint for population-specific parameters, including LOD cutoffs and size boundaries). Using only the females, we then classified ROH for the X chromosome.