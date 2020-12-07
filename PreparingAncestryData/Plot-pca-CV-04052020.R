library(ggplot2)
library(gridExtra)

# Plot PCA (Supp Fig 1 in the associated paper)

pcs <- read.table("/Users/klk37/Google Drive/Project_Admixture_CapeVerde/PCAs/CV_reseq1kG_GWD_IBS_autosomes_pruned_pca.eigenvec", header = FALSE)
IIDs4grp<- read.table("/Users/klk37/Google Drive/Project_Admixture_CapeVerde/Pop-IID-Key-4grps.txt", header = TRUE)

#first, get IDs from fam file, and add them to the Q estimates:
pcss4grp <- merge(x= pcs, y= IIDs4grp, by.x = 'V2',by.y = 'IID')

length(which(pcss4grp$Island=='GWD'))
length(which(pcss4grp$Island=='IBS'))
length(which(pcss4grp$Island=='Santiago'))
length(which(pcss4grp$Island=='Fogo'))
length(which(pcss4grp$Island=='NWcluster'))
length(which(pcss4grp$Island=='BoaVista'))

ggplot(data=pcss4grp, aes(x=V3, y=V4)) + geom_point(aes(color=Island), size = 6, alpha = 0.4)+
  scale_x_continuous(limits = c(-.08, 0.08))+
  scale_y_continuous(limits = c(-.08, 0.08))+
  theme_classic()+
  scale_color_brewer(palette="Dark2")+
  labs(title="Cape Verde - Autosomal Data")+
  labs(x="PC1", y="PC2")