library(ggplot2)
library(reshape2)
library(gridExtra)
library(dplyr)
library(plyr)
library(reshape2)
library(scales)

# Plot sex-biased admixture in Cabo Verde, including generating Fig 5 and Supp Fig 9 i the associated paper

all <- read.table("/Users/klk37/Google Drive/Project_Admixture_CapeVerde/SexBias/SexBias_08312020_All.txt", header=TRUE, stringsAsFactors = FALSE)
San <- read.table("/Users/klk37/Google Drive/Project_Admixture_CapeVerde/SexBias/SexBias_08312020_Santiago.txt", header=TRUE, stringsAsFactors = FALSE)
Fogo <- read.table("/Users/klk37/Google Drive/Project_Admixture_CapeVerde/SexBias/SexBias_08312020_Fogo.txt", header=TRUE, stringsAsFactors = FALSE)
NW <- read.table("/Users/klk37/Google Drive/Project_Admixture_CapeVerde/SexBias/SexBias_08312020_NWcluster.txt", header=TRUE, stringsAsFactors = FALSE)
BV <- read.table("/Users/klk37/Google Drive/Project_Admixture_CapeVerde/SexBias/SexBias_08312020_BoaVista.txt", header=TRUE, stringsAsFactors = FALSE)

colnames(all) <- c("s1f","s1m","s2f","s2m", "hf", "hm","dist")
colnames(San) <- c("s1f","s1m","s2f","s2m", "hf", "hm","dist")
colnames(Fogo) <- c("s1f","s1m","s2f","s2m", "hf", "hm","dist")
colnames(NW) <- c("s1f","s1m","s2f","s2m", "hf", "hm","dist")
colnames(BV) <- c("s1f","s1m","s2f","s2m", "hf", "hm","dist")

all$PropAfrFemale <- all$s1f/(all$s1f + all$s1m)
all$PropEurFemale <- all$s2f/(all$s2f + all$s2m)

San$PropAfrFemale <- San$s1f/(San$s1f + San$s1m)
San$PropEurFemale <- San$s2f/(San$s2f + San$s2m)

Fogo$PropAfrFemale <- Fogo$s1f/(Fogo$s1f + Fogo$s1m)
Fogo$PropEurFemale <- Fogo$s2f/(Fogo$s2f + Fogo$s2m)

NW$PropAfrFemale <- NW$s1f/(NW$s1f + NW$s1m)
NW$PropEurFemale <- NW$s2f/(NW$s2f + NW$s2m)

BV$PropAfrFemale <- BV$s1f/(BV$s1f + BV$s1m)
BV$PropEurFemale <- BV$s2f/(BV$s2f + BV$s2m)

allProps <- select(all, 8, 9)
SanProps <- select(San, 8, 9)
FogoProps <- select(Fogo, 8, 9)
NWProps <- select(NW, 8, 9)
BVProps <- select(BV, 8, 9)

allLong <- melt(allProps)
SanLong <- melt(SanProps)
FogoLong <- melt(FogoProps)
NWLong <- melt(NWProps) 
BVLong <- melt(BVProps) 

medAll <- ddply(allLong, "variable", summarise, value.median=median(value))
medSan <- ddply(SanLong, "variable", summarise, value.median=median(value))
medFogo <- ddply(FogoLong, "variable", summarise, value.median=median(value))
medNW <- ddply(NWLong, "variable", summarise, value.median=median(value))
medBV <- ddply(BVLong, "variable", summarise, value.median=median(value))

modelAll <- ggplot(allLong, aes(x=value, fill=variable)) +
  scale_fill_manual(values = c("steelblue4","tan4"))+
  scale_color_manual(values = c("steelblue4","tan4"))+
  theme_classic()+
  geom_histogram(color="black",alpha=0.7, bins= 25, show.legend = FALSE)+
  geom_vline(data=medAll, aes(xintercept=value.median,colour=variable),linetype="dashed", size=1, show.legend = FALSE)+
  aes(y=stat(count)/sum(stat(count)))+
  labs(x="Proportion contr from females", y="Frequency")

modelSan <- ggplot(SanLong, aes(x=value, fill=variable)) +
  scale_fill_manual(values = c("steelblue4","tan4"))+
  scale_color_manual(values = c("steelblue4","tan4"))+
  theme_classic()+
  geom_histogram(color="black",alpha=0.7, bins= 25, show.legend = FALSE)+
  geom_vline(data=medSan, aes(xintercept=value.median,colour=variable),linetype="dashed", size=1, show.legend = FALSE)+
  aes(y=stat(count)/sum(stat(count)))+
  labs(x="Proportion contr from females", y="Frequency") 

modelFogo <- ggplot(FogoLong, aes(x=value, fill=variable)) +
  scale_fill_manual(values = c("steelblue4","tan4"))+
  scale_color_manual(values = c("steelblue4","tan4"))+
  theme_classic()+
  geom_histogram(color="black",alpha=0.7, bins= 25, show.legend = FALSE)+
  geom_vline(data=medFogo, aes(xintercept=value.median,colour=variable),linetype="dashed", size=1, show.legend = FALSE)+
  aes(y=stat(count)/sum(stat(count))) +
  labs(x="Proportion contr from females", y="Frequency")

modelNW <- ggplot(NWLong, aes(x=value, fill=variable)) +
    scale_fill_manual(values = c("steelblue4","tan4"))+
    scale_color_manual(values = c("steelblue4","tan4"))+
    theme_classic()+
    geom_histogram(color="black",alpha=0.7, bins= 25, show.legend = FALSE)+
    geom_vline(data=medNW, aes(xintercept=value.median,colour=variable),linetype="dashed", size=1, show.legend = FALSE)+
    aes(y=stat(count)/sum(stat(count)))+
    labs(x="Proportion contr from females", y="Frequency")

modelBV <- ggplot(BVLong, aes(x=value, fill=variable)) +
  scale_fill_manual(values = c("steelblue4","tan4"))+
  scale_color_manual(values = c("steelblue4","tan4"))+
  theme_classic()+
  geom_histogram(color="black", alpha=0.7, bins= 25, show.legend = FALSE)+
  geom_vline(data=medBV, aes(xintercept=value.median,colour=variable),linetype="dashed", size=1, show.legend = FALSE)+
  aes(y=stat(count)/sum(stat(count)))+
  labs(x="Proportion contr from females", y="Frequency")

grid.arrange(modelAll, modelSan, modelFogo, modelNW, modelBV, nrow = 5)
#export 12x3

##### Same as above, but for males:
all$PropAfrMale <- all$s1m/(all$s1f + all$s1m)
all$PropEurMale <- all$s2m/(all$s2f + all$s2m)

San$PropAfrMale <- San$s1m/(San$s1f + San$s1m)
San$PropEurMale <- San$s2m/(San$s2f + San$s2m)

Fogo$PropAfrMale <- Fogo$s1m/(Fogo$s1f + Fogo$s1m)
Fogo$PropEurMale <- Fogo$s2m/(Fogo$s2f + Fogo$s2m)

NW$PropAfrMale <- NW$s1m/(NW$s1f + NW$s1m)
NW$PropEurMale <- NW$s2m/(NW$s2f + NW$s2m)

BV$PropAfrMale <- BV$s1m/(BV$s1f + BV$s1m)
BV$PropEurMale <- BV$s2m/(BV$s2f + BV$s2m)

allPropsM <- select(all, 10, 11)
SanPropsM <- select(San, 10, 11)
FogoPropsM <- select(Fogo, 10, 11)
NWPropsM <- select(NW, 10, 11)
BVPropsM <- select(BV, 10, 11)

allLongM <- melt(allPropsM)
SanLongM <- melt(SanPropsM)
FogoLongM <- melt(FogoPropsM)
NWLongM <- melt(NWPropsM) 
BVLongM <- melt(BVPropsM) 

medAllM <- ddply(allLongM, "variable", summarise, value.median=median(value))
medSanM <- ddply(SanLongM, "variable", summarise, value.median=median(value))
medFogoM <- ddply(FogoLongM, "variable", summarise, value.median=median(value))
medNWM <- ddply(NWLongM, "variable", summarise, value.median=median(value))
medBVM <- ddply(BVLongM, "variable", summarise, value.median=median(value))

modelAllM <- ggplot(allLongM, aes(x=value, fill=variable)) +
  scale_fill_manual(values = c("steelblue4","tan4"))+
  scale_color_manual(values = c("steelblue4","tan4"))+
  theme_classic()+
  geom_histogram(color="black",alpha=0.7, bins= 25, show.legend = FALSE)+
  geom_vline(data=medAllM, aes(xintercept=value.median,colour=variable),linetype="dashed", size=1, show.legend = FALSE)+
  aes(y=stat(count)/sum(stat(count)))+
  labs(x="Proportion contr from males", y="Frequency")

modelSanM <- ggplot(SanLongM, aes(x=value, fill=variable)) +
  scale_fill_manual(values = c("steelblue4","tan4"))+
  scale_color_manual(values = c("steelblue4","tan4"))+
  theme_classic()+
  geom_histogram(color="black",alpha=0.7, bins= 25, show.legend = FALSE)+
  geom_vline(data=medSanM, aes(xintercept=value.median,colour=variable),linetype="dashed", size=1, show.legend = FALSE)+
  aes(y=stat(count)/sum(stat(count)))+
  labs(x="Proportion contr from males", y="Frequency") 

modelFogoM <- ggplot(FogoLongM, aes(x=value, fill=variable)) +
  scale_fill_manual(values = c("steelblue4","tan4"))+
  scale_color_manual(values = c("steelblue4","tan4"))+
  theme_classic()+
  geom_histogram(color="black",alpha=0.7, bins= 25, show.legend = FALSE)+
  geom_vline(data=medFogoM, aes(xintercept=value.median,colour=variable),linetype="dashed", size=1, show.legend = FALSE)+
  aes(y=stat(count)/sum(stat(count))) +
  labs(x="Proportion contr from males", y="Frequency")

modelNWM <- ggplot(NWLongM, aes(x=value, fill=variable)) +
  scale_fill_manual(values = c("steelblue4","tan4"))+
  scale_color_manual(values = c("steelblue4","tan4"))+
  theme_classic()+
  geom_histogram(color="black",alpha=0.7, bins= 25, show.legend = FALSE)+
  geom_vline(data=medNWM, aes(xintercept=value.median,colour=variable),linetype="dashed", size=1, show.legend = FALSE)+
  aes(y=stat(count)/sum(stat(count)))+
  labs(x="Proportion contr from males", y="Frequency")

modelBVM <- ggplot(BVLongM, aes(x=value, fill=variable)) +
  scale_fill_manual(values = c("steelblue4","tan4"))+
  scale_color_manual(values = c("steelblue4","tan4"))+
  theme_classic()+
  geom_histogram(color="black", alpha=0.7, bins= 25, show.legend = FALSE)+
  geom_vline(data=medBVM, aes(xintercept=value.median,colour=variable),linetype="dashed", size=1, show.legend = FALSE)+
  aes(y=stat(count)/sum(stat(count)))+
  labs(x="Proportion contr from males", y="Frequency")

grid.arrange(modelAllM, modelSanM, modelFogoM, modelNWM, modelBVM, nrow = 5)
#export 12x3

############################################## OLD #####################################################
## The following was used for exploring he best ways to visualize these results:
accept2 <- subset(accept, Parameter=="1" | Parameter=="2"| Parameter=="3" | Parameter=="4")
accept2$Parameter <- ordered(accept2$Parameter, levels=c("1", "2", "3", "4"))
accept2$Island <- ordered(accept2$Island, levels=c('All','Santiago', 'Fogo', 'NWcluster','BoaVista'))

#boxplot (version 1 of this figure)
ggplot(accept2, aes(x = factor(Parameter), y = Values, fill=Island)) + geom_boxplot(outlier.shape=NA) +
  scale_y_continuous(limits = c(0, 1))+
  theme_classic()+
  scale_fill_manual(values = c("#7570B3", "#E6AB02","#E7298A","#66A61E", "#1B9E77"))
#histogram (version 2 of this figure)
afr <- subset(accept2, Parameter=="1" | Parameter=="2")
afr$grp <- factor(afr$Island, levels=c("All", "Santiago","Fogo","NWcluster", "BoaVista", "GWD", "IBS"))
afrPlot <- ggplot(afr, aes(x=Values, fill=Parameter)) +
  facet_grid(. ~ grp, drop=TRUE, space="free", scales="free")+
  scale_fill_manual(values = c("steelblue4","tan4"))+
  geom_vline(xintercept = 0.5, linetype = "dashed")+
  scale_x_continuous(limits = c(0, 1))+
  theme_classic()+
  geom_density(alpha=0.7)
eur <- subset(accept2, Parameter=="3" | Parameter=="4")
eur$grp <- factor(eur$Island, levels=c("All", "Santiago","Fogo","NWcluster", "BoaVista", "GWD", "IBS"))
eurPlot <- ggplot(eur, aes(x=Values, fill=Parameter)) +
  facet_grid(. ~ grp, drop=TRUE, space="free", scales="free")+
  scale_fill_manual(values = c("steelblue4", "tan4"))+
  geom_vline(xintercept = 0.5, linetype = "dashed")+
  scale_x_continuous(limits = c(0, 1))+
  theme_classic()+
  geom_density(alpha=0.7)
female <- subset(accept2, Parameter=="1" | Parameter=="3")
female$grp <- factor(female$Island, levels=c("All", "Santiago","Fogo","NWcluster", "BoaVista","GWD", "IBS"))
ggplot(female, aes(x=Values, fill=Parameter)) +
  facet_grid(. ~ grp, drop=TRUE, space="free", scales="free")+
  scale_fill_manual(values = c("tan4", "steelblue4"))+
  geom_vline(xintercept = 0.5, linetype = "dashed")+
  scale_x_continuous(limits = c(0, 1))+
  theme_classic()+
  geom_density(alpha=0.7)

#Get the empirical ADMIXTURE proportions for plotting alongside
## x vs autosomes
x <- read.table("/Users/klk37/Google Drive/Project_Admixture_CapeVerde/admixture-runs/CV_reseq1kG_xchr_GWD_IBS_pruned_Admixture10runAvg.txt", header=TRUE, stringsAsFactors = FALSE)
a <- read.table("/Users/klk37/Google Drive/Project_Admixture_CapeVerde/admixture-runs/CV_reseq1kG_autosomes_GWD_IBS_pruned_Admixture10runAvg.txt", header=TRUE, stringsAsFactors = FALSE)
IIDs4grp<- read.table("/Users/klk37/Google Drive/Project_Admixture_CapeVerde/Pop-IID-Key-4grps.txt", header = TRUE)
x$chrom = "x"
a$chrom = "autosomes"
combine = rbind(x,a)
combineGrp <- merge(x= combine, y= IIDs4grp, by.x = 'IID',by.y = 'IID')
addAll <- subset(combineGrp, Island == "NWcluster" | Island == "Fogo" | Island == "BoaVista" | Island == "Santiago" )
addAll$Island <- "All"
withAll <- rbind(combineGrp, addAll)
withAll$grp <- factor(withAll$Island, levels=c("All", "Santiago","Fogo","NWcluster", "BoaVista", "GWD", "IBS"))
islands <- subset(withAll, Island == "All" | Island == "NWcluster" | Island == "Fogo" | Island == "BoaVista" | Island == "Santiago" )
empirical <- ggplot(islands, aes(x=GWD, fill=chrom)) +
  facet_grid(. ~ grp, drop=TRUE, space="free", scales="free")+
  scale_fill_manual(values = c("orange", "steelblue"))+
  scale_x_continuous(limits = c(0, 1))+
  theme_classic()+
  geom_density(alpha=0.7)

grid.arrange(empirical, arrangeGrob(modelAll, modelSan, modelFogo, modelNW, modelBV), nrow = 2)
