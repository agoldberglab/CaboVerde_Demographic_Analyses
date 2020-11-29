# Note that this script was used to run GARLIC on my (Katharine's) local system, not the Duke Compute Cluster.

# Autosomes
/bin/garlic-master/src/garlic --tped CV_reseq1kG_GWD_IBS_Hg19_autosomes_fogo_1pop.tped --tfam CV_reseq1kG_GWD_IBS_Hg19_autosomes_fogo_1pop.tfam  --build hg19 --error 0.001 --auto-winsize --resample 100 --winsize 30 --out testAutoWinsizeResample100_FogoAuto

/bin/garlic-master/src/garlic --tped CV_reseq1kG_GWD_IBS_Hg19_autosomes_santiago_1pop.tped --tfam CV_reseq1kG_GWD_IBS_Hg19_autosomes_santiago_1pop.tfam  --build hg19 --error 0.001 --auto-winsize --resample 100 --winsize 30 --out testAutoWinsizeResample100_SantiagoAuto

/bin/garlic-master/src/garlic --tped CV_reseq1kG_GWD_IBS_Hg19_autosomes_NWcluster_1pop.tped --tfam CV_reseq1kG_GWD_IBS_Hg19_autosomes_NWcluster_1pop.tfam  --build hg19 --error 0.001 --auto-winsize --resample 100 --winsize 30 --out testAutoWinsizeResample100_NWclusterAuto

/bin/garlic-master/src/garlic --tped CV_reseq1kG_GWD_IBS_Hg19_autosomes_BoaVista_1pop.tped --tfam CV_reseq1kG_GWD_IBS_Hg19_autosomes_BoaVista_1pop.tfam  --build hg19 --error 0.001 --auto-winsize --resample 100 --winsize 30 --out testAutoWinsizeResample100_BoaVistaAuto

/bin/garlic-master/src/garlic --tped CV_reseq1kG_GWD_IBS_Hg19_autosomes_GWD_1pop.tped --tfam CV_reseq1kG_GWD_IBS_Hg19_autosomes_GWD_1pop.tfam  --build hg19 --error 0.001 --auto-winsize --resample 100 --winsize 30 --out testAutoWinsizeResample100_GWDAuto

/bin/garlic-master/src/garlic --tped CV_reseq1kG_GWD_IBS_Hg19_autosomes_IBS_1pop.tped --tfam CV_reseq1kG_GWD_IBS_Hg19_autosomes_IBS_1pop.tfam  --build hg19 --error 0.001 --auto-winsize --resample 100 --winsize 30 --out testAutoWinsizeResample100_IBSAuto

# X chromosome
/bin/garlic-master/src/garlic --tped CV_reseq1kG_GWD_IBS_Hg19_xchr_Females_fogo_1pop.tped --tfam CV_reseq1kG_GWD_IBS_Hg19_xchr_Females_fogo_1pop.tfam  --build hg19 --error 0.001 --resample 100 --winsize 50 --out testAutoWinsizeResample100_FogochrX

/bin/garlic-master/src/garlic --tped CV_reseq1kG_GWD_IBS_Hg19_xchr_Females_santiago_1pop.tped --tfam CV_reseq1kG_GWD_IBS_Hg19_xchr_Females_santiago_1pop.tfam  --build hg19 --error 0.001 --resample 100 --winsize 50 --out testAutoWinsizeResample100_SantiagochrX

/bin/garlic-master/src/garlic --tped CV_reseq1kG_GWD_IBS_Hg19_xchr_Females_NWcluster_1pop.tped --tfam CV_reseq1kG_GWD_IBS_Hg19_xchr_Females_NWcluster_1pop.tfam  --build hg19 --error 0.001 --resample 100 --winsize 50 --out testAutoWinsizeResample100_NWclusterchrX

/bin/garlic-master/src/garlic --tped CV_reseq1kG_GWD_IBS_Hg19_xchr_Females_GWD_1pop.tped --tfam CV_reseq1kG_GWD_IBS_Hg19_xchr_Females_GWD_1pop.tfam  --build hg19 --error 0.001 --resample 100 --winsize 50 --out testAutoWinsizeResample100_GWDchrX

/bin/garlic-master/src/garlic --tped CV_reseq1kG_GWD_IBS_Hg19_xchr_Females_IBS_1pop.tped --tfam CV_reseq1kG_GWD_IBS_Hg19_xchr_Females_IBS_1pop.tfam  --build hg19 --error 0.001 --resample 100 --winsize 40 --out testAutoWinsizeResample100_IBSchrX

# Autosomes 7
/bin/garlic-master/src/garlic --tped CV_reseq1kG_GWD_IBS_Hg19_aut7_Females_fogo_1pop.tped --tfam CV_reseq1kG_GWD_IBS_Hg19_aut7_Females_fogo_1pop.tfam  --build hg19 --error 0.001 --resample 100 --winsize 50 --out testAutoWinsizeResample100_Fogo_aut7_Females

/bin/garlic-master/src/garlic --tped CV_reseq1kG_GWD_IBS_Hg19_aut7_Females_santiago_1pop.tped --tfam CV_reseq1kG_GWD_IBS_Hg19_aut7_Females_santiago_1pop.tfam  --build hg19 --error 0.001 --resample 100 --winsize 50 --out testAutoWinsizeResample100_Santiago_aut7_Females

/bin/garlic-master/src/garlic --tped CV_reseq1kG_GWD_IBS_Hg19_aut7_Females_NWcluster_1pop.tped --tfam CV_reseq1kG_GWD_IBS_Hg19_aut7_Females_NWcluster_1pop.tfam  --build hg19 --error 0.001 --resample 100 --winsize 50 --out testAutoWinsizeResample100_NWcluster_aut7_Females

/bin/garlic-master/src/garlic --tped CV_reseq1kG_GWD_IBS_Hg19_aut7_Females_GWD_1pop.tped --tfam CV_reseq1kG_GWD_IBS_Hg19_aut7_Females_GWD_1pop.tfam  --build hg19 --error 0.001 --resample 100 --winsize 50 --out testAutoWinsizeResample100_GWD_aut7_Females

/bin/garlic-master/src/garlic --tped CV_reseq1kG_GWD_IBS_Hg19_aut7_Females_IBS_1pop.tped --tfam CV_reseq1kG_GWD_IBS_Hg19_aut7_Females_IBS_1pop.tfam  --build hg19 --error 0.001 --resample 100 --winsize 40 --out testAutoWinsizeResample100_IBS_aut7_Females