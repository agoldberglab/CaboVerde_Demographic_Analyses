library(ggplot2)
library(gridExtra)

# Plot IBDne, for Fig 7 in the associated paper

# First, do Cabo Verde as a whole (all island regions)
anc1 <- read.table("/Users/klk37/Google Drive/Project_Admixture_CapeVerde/ibdne/anc1_2cM.ibdne.ne",header=T)
anc2 <- read.table("/Users/klk37/Google Drive/Project_Admixture_CapeVerde/ibdne/anc2_2cM.ibdne.ne",header=T)
anc1$Ancestry <- "African"
anc2$Ancestry <- "European"
ancBoth <- rbind(anc1,anc2)

# Santiago
anc1San <- read.table("/Users/klk37/Google Drive/Project_Admixture_CapeVerde/ibdne/anc1_IslSantiago_2cM.ibdne.ne",header=T)
anc2San <- read.table("/Users/klk37/Google Drive/Project_Admixture_CapeVerde/ibdne/anc2_IslSantiago_2cM.ibdne.ne",header=T)
anc1San$Ancestry <- "African"
anc2San$Ancestry <- "European"
ancBothSan <- rbind(anc1San,anc2San)

# Fogo
anc1Fogo <- read.table("/Users/klk37/Google Drive/Project_Admixture_CapeVerde/ibdne/anc1_IslFogo_2cM.ibdne.ne",header=T)
anc2Fogo <- read.table("/Users/klk37/Google Drive/Project_Admixture_CapeVerde/ibdne/anc2_IslFogo_2cM.ibdne.ne",header=T)
anc1Fogo$Ancestry <- "African"
anc2Fogo$Ancestry <- "European"
ancBothFogo <- rbind(anc1Fogo,anc2Fogo)

# NW Cluster
anc1NW <- read.table("/Users/klk37/Google Drive/Project_Admixture_CapeVerde/ibdne/anc1_IslNW_2cM.ibdne.ne",header=T)
anc2NW <- read.table("/Users/klk37/Google Drive/Project_Admixture_CapeVerde/ibdne/anc2_IslNW_2cM.ibdne.ne",header=T)
anc1NW$Ancestry <- "African"
anc2NW$Ancestry <- "European"
ancBothNW <- rbind(anc1NW,anc2NW)

# Generate plots for each of the above datasets
neAll <- ggplot(ancBoth, aes(x = GEN, y = NE, color = Ancestry)) +
  geom_line()+
  geom_ribbon(aes(ymin=ancBoth$LWR.95.CI, ymax=ancBoth$UPR.95.CI, fill=ancBoth$Ancestry), alpha=0.1, linetype=0, show.legend = FALSE)+
  scale_y_continuous(limits = c(100,100000000), trans='log10')+
  scale_x_continuous(limits = c(0, 125),breaks = scales::pretty_breaks(n = 12))+
  labs(x="generations before present", y="Ancestry Specific Ne")+
  labs(title="CV (all)")+
  theme_classic()

neSan <- ggplot(ancBothSan, aes(x = GEN, y = NE, color = Ancestry)) +
  geom_line()+
  geom_ribbon(aes(ymin=ancBothSan$LWR.95.CI, ymax=ancBothSan$UPR.95.CI, fill=ancBothSan$Ancestry), alpha=0.1, linetype=0, show.legend = FALSE)+
  scale_y_continuous(limits = c(100,100000000), trans='log10')+
  scale_x_continuous(limits = c(0, 125),breaks = scales::pretty_breaks(n = 12))+
  labs(x="generations before present", y="Ancestry Specific Ne")+
  labs(title="Santiago")+
  theme_classic()

neFogo <- ggplot(ancBothFogo, aes(x = GEN, y = NE, color = Ancestry)) +
  geom_line()+
  geom_ribbon(aes(ymin=ancBothFogo$LWR.95.CI, ymax=ancBothFogo$UPR.95.CI, fill=ancBothFogo$Ancestry), alpha=0.1, linetype=0, show.legend = FALSE)+
  scale_y_continuous(limits = c(100,100000000), trans='log10')+
  scale_x_continuous(limits = c(0, 125),breaks = scales::pretty_breaks(n = 12))+
  labs(x="generations before present", y="Ancestry Specific Ne")+
  labs(title="Fogo")+
  theme_classic()

neNW <- ggplot(ancBothNW, aes(x = GEN, y = NE, color = Ancestry)) +
  geom_line()+
  geom_ribbon(aes(ymin=ancBothNW$LWR.95.CI, ymax=ancBothNW$UPR.95.CI, fill=ancBothNW$Ancestry), alpha=0.1, linetype=0, show.legend = FALSE)+
  scale_y_continuous(limits = c(100,100000000), trans='log10')+
  scale_x_continuous(limits = c(0, 125),breaks = scales::pretty_breaks(n = 12))+
  labs(x="generations before present", y="Ancestry Specific Ne")+
  labs(title="NW Cluster")+
  theme_classic()

grid.arrange(neAll, neSan, neFogo, neNW, nrow = 2)
#print to pdf at 4x10
