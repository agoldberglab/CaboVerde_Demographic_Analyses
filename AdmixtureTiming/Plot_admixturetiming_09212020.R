library(ggplot2)
library(gridExtra)

# Plot inferred admixture timing compared to historical estimates, for Fig. 3 in the associated paper

readTime <- read.table("/Users/klk37/Google Drive/Project_Admixture_CapeVerde/AdmixtureTiming/aggregated_CV_admixturetiming.txt", header=TRUE, stringsAsFactors = FALSE, sep=",")
sanTime <- subset(readTime, Pop=="Santiago")
fogoTime <- subset(readTime, Pop=="Fogo")
nwTime <- subset(readTime, Pop=="NWcluster")
bvTime <- subset(readTime, Pop=="BoaVista")

san <- ggplot(sanTime, aes(color=Method)) + 
  geom_vline(xintercept = 27.55, linetype = "dashed")+
  geom_vline(xintercept = 18.37, linetype = "dashed")+
  labs(title="Inferred Admixture Timing - Santiago")+
  geom_segment(aes(x = Recent, y = Order, xend = Older, yend = Order, size=1.5))+
  scale_x_reverse(limits = c(28,0),breaks=c(0,5,10,15,20,25))+
  labs(x="", y="")+
  theme_classic()

nw <- ggplot(nwTime, aes(color=Method)) + 
  geom_vline(xintercept = 23.25, linetype = "dashed")+
  geom_vline(xintercept = 15.5, linetype = "dashed")+
    labs(title="Inferred Admixture Timing - NW Cluster")+
  geom_segment(aes(x = Recent, y = Order, xend = Older, yend = Order, size=1.5))+
  scale_x_reverse(limits = c(28,0),breaks=c(0,5,10,15,20,25))+
  labs(x="", y="")+
  theme_classic()

fogo <- ggplot(fogoTime, aes(color=Method)) + 
  geom_vline(xintercept = 26.55, linetype = "dashed")+
  geom_vline(xintercept = 17.7, linetype = "dashed")+
  labs(title="Inferred Admixture Timing - Fogo")+
  geom_segment(aes(x = Recent, y = Order, xend = Older, yend = Order, size=1.5))+
  scale_x_reverse(limits = c(28,0),breaks=c(0,5,10,15,20,25))+
  labs(x="", y="")+
  theme_classic()

bv <- ggplot(bvTime, aes(color=Method)) + 
  geom_vline(xintercept = 19.65, linetype = "dashed")+
  geom_vline(xintercept = 13.1, linetype = "dashed")+
  labs(title="Inferred Admixture Timing - Boa Vista")+
  geom_segment(aes(x = Recent, y = Order, xend = Older, yend = Order, size=1.5))+
  scale_x_reverse(limits = c(28,0),breaks=c(0,5,10,15,20,25))+
  labs(x="", y="")+
  theme_classic()

grid.arrange(san, fogo, nw, bv, nrow = 4, bottom="Generations", left="Population")
#print @6x5