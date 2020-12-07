library(ggplot2)
library(gridExtra)
library(viridis)
library(dplyr)

# Plot IBD sharing in Cabo Verde: 
# First, generate the input file for Cytoscape network plotting. 
# Then look at the distributions of IBD within and between the islands to generate Supp Figs 4 and 5 for the associated paper.

#Did the following once to generate IBDout_CV_filled_allChr.ibd_over5cM_byIndiv_withIsland.txt (used for cytoscape input)
ibd <- read.table("/Users/klk37/Google Drive/Project_Admixture_CapeVerde/ibdne/IBDout_CV_filled_allChr.ibd_over5cM_byIndiv.txt", header = T, check.names = F)
IIDs4grp<- read.table("/Users/klk37/Google Drive/Project_Admixture_CapeVerde/Pop-IID-Key-4grps.txt", header = TRUE)                      
ibdIsl1 <- merge(x= ibd, y= IIDs4grp, by.x = 'ID1',by.y = 'IID')
colnames(ibdIsl1) <- c("ID1","ID2","count","length", "Isl1")
ibdIsl <- merge(x= ibdIsl1, y= IIDs4grp, by.x = 'ID2',by.y = 'IID')
colnames(ibdIsl) <- c("ID2","ID1","count","length", "Isl1", "Isl2")
ibdIsl$loglength <- log(ibdIsl$length)
#write.table(ibdIsl, file = "/Users/klk37/Google Drive/Project_Admixture_CapeVerde/ibdne/IBDout_CV_filled_allChr.ibd_over5cM_byIndiv_withIsland.txt", col.names = T, row.names= F, sep = "\t", quote = FALSE)

ibd <- read.table("/Users/klk37/Google Drive/Project_Admixture_CapeVerde/ibdne/IBDout_CV_filled_allChr.ibd_over5cM_byIndiv_withIsland.txt", header = TRUE)

#quick plot of # vs total
ggplot(ibd, aes(x=length, y=count)) + geom_point()+
  theme_classic()+
  labs(x="length", y="count")

# Generate boxplots for Supp Fig 5 in the associated paper:
level_order <- c('Santiago', 'Fogo', 'NWcluster','BoaVista')
lenIBD <- ggplot(ibd, aes(x=factor(Isl1, level = level_order), y=length, fill=Isl2)) +
  geom_boxplot(outlier.size=0.2)+
  theme_classic()
countIBD <- ggplot(ibd, aes(x=factor(Isl1, level = level_order), y=count, fill=Isl2)) +
  geom_boxplot(outlier.size=0.2)+
  theme_classic()
grid.arrange(countIBD, lenIBD, nrow = 2)
#print at 10x6

#Within each island, get the mean IDB content for each individual:
bvKinAll <- subset(ibd, Isl1 == 'BoaVista' & Isl2 == 'BoaVista')
FogoKinAll <- subset(ibd, Isl1 == 'Fogo' & Isl2 == 'Fogo')
SanKinAll <- subset(ibd, Isl1 == 'Santiago' & Isl2 == 'Santiago')
NWKinAll <- subset(ibd, Isl1 == 'NWcluster' & Isl2 == 'NWcluster')

# Within each island, plot number and length (For Supp Fig 4 in the associated paper)
san <- ggplot(SanKinAll, aes(x=length, y=count)) + geom_point(alpha = 0.4)+
  scale_x_continuous(limits = c(0,1750))+
  scale_y_continuous(limits = c(0,80))+
  theme_classic()+
  labs(title="Santiago")+
  labs(x="length", y="count")
fogo <- ggplot(FogoKinAll, aes(x=length, y=count)) + geom_point(alpha = 0.4)+
  scale_x_continuous(limits = c(0,1750))+
  scale_y_continuous(limits = c(0,80))+
  theme_classic()+
  labs(title="Fogo")+
  labs(x="length", y="count")
nw <- ggplot(NWKinAll, aes(x=length, y=count)) + geom_point(alpha = 0.4)+
  scale_x_continuous(limits = c(0,1750))+
  scale_y_continuous(limits = c(0,80))+
  theme_classic()+
  labs(title="NW Cluster")+
  labs(x="length", y="count")
bv <- ggplot(bvKinAll, aes(x=length, y=count)) + geom_point(alpha = 0.4)+
  scale_x_continuous(limits = c(0,1750))+
  scale_y_continuous(limits = c(0,80))+
  theme_classic()+
  labs(title="Boa Vista")+
  labs(x="length", y="count")
grid.arrange(san, fogo, nw, bv, nrow = 2)
#print at 6x6