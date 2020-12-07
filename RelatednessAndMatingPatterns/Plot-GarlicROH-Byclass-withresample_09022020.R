library(ggplot2)
library(reshape2)
library(gridExtra)

# Exploring and plotting ROH distributions in Cabo Verde

#First, run the raw output from garlic: *.roh.bed through parseGarlic-byIndiv.pl, use the output of that script here.
readSantiago <- read.table("/Users/klk37/Google Drive/Project_Admixture_CapeVerde/Garlic_NewRef/testAutoWinsizeResample100_SantiagoAuto.roh.bed_byIndiv.txt", header=TRUE, stringsAsFactors = FALSE)
readFogo <- read.table("/Users/klk37/Google Drive/Project_Admixture_CapeVerde/Garlic_NewRef/testAutoWinsizeResample100_FogoAuto.roh.bed_byIndiv.txt", header=TRUE, stringsAsFactors = FALSE)
readNW <- read.table("/Users/klk37/Google Drive/Project_Admixture_CapeVerde/Garlic_NewRef/testAutoWinsizeResample100_NWclusterAuto.roh.bed_byIndiv.txt", header=TRUE, stringsAsFactors = FALSE)
readBV <- read.table("/Users/klk37/Google Drive/Project_Admixture_CapeVerde/Garlic_NewRef/testAutoWinsizeResample100_BoaVistaAuto.roh.bed_byIndiv.txt", header=TRUE, stringsAsFactors = FALSE)
readIBS <- read.table("/Users/klk37/Google Drive/Project_Admixture_CapeVerde/Garlic_NewRef/testAutoWinsizeResample100_IBSAuto.roh.bed_byIndiv.txt", header=TRUE, stringsAsFactors = FALSE)
#readYRI <- read.table("/Users/klk37/Google Drive/Project_Admixture_CapeVerde/Garlic_NewRef/YRI-IBS-CV/test-autowinsize-resample100-YRI.roh.bed_byIndiv.txt", header=TRUE, stringsAsFactors = FALSE)
readGWD <- read.table("/Users/klk37/Google Drive/Project_Admixture_CapeVerde/Garlic_NewRef/testAutoWinsizeResample100_GWDAuto.roh.bed_byIndiv.txt", header=TRUE, stringsAsFactors = FALSE)

rohSantiago <- data.frame(pop = "Santiago", readSantiago)
rohFogo <- data.frame(pop = "Fogo", readFogo)
rohNW <- data.frame(pop = "NW", readNW)
rohBV <- data.frame(pop = "BV", readBV)
rohIBS <- data.frame(pop = "IBS", readIBS)
#rohYRI <- data.frame(pop = "YRI", readYRI)
rohGWD <- data.frame(pop = "GWD", readGWD)
rohAll <- rbind(rohSantiago, rohFogo, rohNW, rohBV, rohIBS, rohGWD, stringsAsFactors=FALSE)
#rohAll <- rbind(rohSantiago, rohFogo, rohNW, rohBV, rohYRI, rohIBS, rohGWD, stringsAsFactors=FALSE)

rohAll$Amb <- as.numeric(as.character(rohAll$Alength)) / 1000000
rohAll$Bmb <- as.numeric(as.character(rohAll$Blength)) / 1000000
rohAll$Cmb <- as.numeric(as.character(rohAll$Clength)) / 1000000
rohAll$ShorterMb<- rohAll$Amb + rohAll$Bmb

rohAll$TotalLength <- rohAll$Alength + rohAll$Blength + rohAll$Clength
rohAll$TotalMb<- rohAll$Amb + rohAll$Bmb + rohAll$Cmb
rohAll$TotalNum<- rohAll$Acount + rohAll$Bcount + rohAll$Ccount

sanVfogo <- subset(rohAll, pop=="Santiago" | pop=="Fogo")
wilcox.test(sanVfogo$TotalMb ~ sanVfogo$pop)
wilcox.test(sanVfogo$ShorterMb ~ sanVfogo$pop)
wilcox.test(sanVfogo$Cmb ~ sanVfogo$pop)

sanVgwd <- subset(rohAll, pop=="Santiago" | pop=="GWD")
wilcox.test(sanVgwd$TotalMb ~ sanVgwd$pop)
wilcox.test(sanVgwd$ShorterMb ~ sanVgwd$pop)
wilcox.test(sanVgwd$Cmb ~ sanVgwd$pop)

#Avg (per individual) total length of ROH (total length ROH / # individuals) by class
San <- subset(rohAll, pop == 'Santiago')
(sum(San$TotalLength)/172)/1000000
(sum(San$Alength)/172)/1000000
(sum(San$Blength)/172)/1000000
(sum(San$Clength)/172)/1000000
Fogo <- subset(rohAll, pop == 'Fogo')
(sum(Fogo$TotalLength)/129)/1000000
(sum(Fogo$Alength)/129)/1000000
(sum(Fogo$Blength)/129)/1000000
(sum(Fogo$Clength)/129)/1000000
NW <- subset(rohAll, pop == 'NW')
(sum(NW$TotalLength)/236)/1000000
(sum(NW$Alength)/236)/1000000
(sum(NW$Blength)/236)/1000000
(sum(NW$Clength)/236)/1000000
BV <- subset(rohAll, pop == 'BV')
(sum(BV$TotalLength)/26)/1000000
(sum(BV$Alength)/26)/1000000
(sum(BV$Blength)/26)/1000000
(sum(BV$Clength)/26)/1000000
GWD <- subset(rohAll, pop == 'GWD')
(sum(GWD$TotalLength)/107)/1000000
(sum(GWD$Alength)/107)/1000000
(sum(GWD$Blength)/107)/1000000
(sum(GWD$Clength)/107)/1000000
IBS <- subset(rohAll, pop == 'IBS')
(sum(IBS$TotalLength)/107)/1000000
(sum(IBS$Alength)/107)/1000000
(sum(IBS$Blength)/107)/1000000
(sum(IBS$Clength)/107)/1000000

level_order <- c('Santiago', 'Fogo', 'NW','BV','GWD','IBS')
# try taking the mean of GWD and the mean of IBS and adding point for the weighted means 
# means weighted by the admixture proportions by island
ShorterWMsan <- ((mean(rohAll$ShorterMb[rohAll$pop=='IBS'])*(0.2629**2))+(mean(rohAll$ShorterMb[rohAll$pop=='GWD'])*(0.7371**2)))
ShorterWMfogo <- ((mean(rohAll$ShorterMb[rohAll$pop=='IBS'])*(0.5016**2))+(mean(rohAll$ShorterMb[rohAll$pop=='GWD'])*(0.4984**2)))
ShorterWMnw <- ((mean(rohAll$ShorterMb[rohAll$pop=='IBS'])*(0.4481**2))+(mean(rohAll$ShorterMb[rohAll$pop=='GWD'])*(0.5519**2)))
ShorterWMbv <- ((mean(rohAll$ShorterMb[rohAll$pop=='IBS'])*(0.3759**2))+(mean(rohAll$ShorterMb[rohAll$pop=='GWD'])*(0.6241**2)))
LongWMsan <- ((mean(rohAll$Cmb[rohAll$pop=='IBS'])*(0.2629**2))+(mean(rohAll$Cmb[rohAll$pop=='GWD'])*(0.7371**2)))
LongWMfogo <- ((mean(rohAll$Cmb[rohAll$pop=='IBS'])*(0.5016**2))+(mean(rohAll$Cmb[rohAll$pop=='GWD'])*(0.4984**2)))
LongWMnw <- ((mean(rohAll$Cmb[rohAll$pop=='IBS'])*(0.4481**2))+(mean(rohAll$Cmb[rohAll$pop=='GWD'])*(0.5519**2)))
LongWMbv <- ((mean(rohAll$Cmb[rohAll$pop=='IBS'])*(0.3759**2))+(mean(rohAll$Cmb[rohAll$pop=='GWD'])*(0.6241**2)))
TotalWMsan <- ((mean(rohAll$TotalMb[rohAll$pop=='IBS'])*(0.2629**2))+(mean(rohAll$TotalMb[rohAll$pop=='GWD'])*(0.7371**2)))
TotalWMfogo <- ((mean(rohAll$TotalMb[rohAll$pop=='IBS'])*(0.5016**2))+(mean(rohAll$TotalMb[rohAll$pop=='GWD'])*(0.4984**2)))
TotalWMnw <- ((mean(rohAll$TotalMb[rohAll$pop=='IBS'])*(0.4481**2))+(mean(rohAll$TotalMb[rohAll$pop=='GWD'])*(0.5519**2)))
TotalWMbv <- ((mean(rohAll$TotalMb[rohAll$pop=='IBS'])*(0.3759**2))+(mean(rohAll$TotalMb[rohAll$pop=='GWD'])*(0.6241**2)))

#plot total length by individual:
classA <- ggplot(rohAll, aes(x=pop, y=Amb, fill=pop)) + geom_violin()+
  labs(title="Short ROH")+
  scale_y_continuous(limits = c(0, 300))+
  labs(x="", y="")+
  theme_classic()
classB <- ggplot(rohAll, aes(x=pop, y=Bmb, fill=pop)) + geom_violin()+
  labs(title="Medium ROH")+
  scale_y_continuous(limits = c(0, 300))+
  labs(x="", y="")+
  theme_classic()
classC <- ggplot(rohAll, aes(x=factor(pop, level = level_order), y=Cmb, fill=pop)) + geom_violin()+
  labs(title="Long ROH")+
  stat_summary(fun.y = "mean", geom = "point", size=2,color = "black")+
  scale_y_continuous(limits = c(0, 300))+
  labs(x="", y="")+
  theme_classic()+
  scale_fill_manual(values = c("#A6761D", "#1B9E77", "#7570B3", "#E7298A", "#66A61E", "#E6AB02", "#D95F02"))
grid.arrange(classA, classB, classC, nrow = 1, bottom="Population", left="Total Length (Mb)")

#total, short, long
classC <- ggplot(rohAll, aes(x=factor(pop, level = level_order), y=Cmb, fill=pop)) + geom_violin()+
  labs(title="Long ROH")+
  annotate("point", x = 'Santiago', y = LongWMsan, shape = "asterisk", size=3)+
  annotate("point", x = 'Fogo', y = LongWMfogo, shape = "asterisk", size=3)+
  annotate("point", x = 'NW', y = LongWMnw, shape = "asterisk", size=3)+
  annotate("point", x = 'BV', y = LongWMbv, shape = "asterisk", size=3)+
  stat_summary(fun.y = "mean", geom = "point", size=2,color = "black")+
  scale_y_continuous(limits = c(0, 300))+
  labs(x="", y="")+
  theme_classic()+
  scale_fill_manual(values = c("#A6761D", "#1B9E77", "#7570B3", "#E7298A", "#66A61E", "#E6AB02", "#D95F02"))
total <- ggplot(rohAll, aes(x=factor(pop, level = level_order), y=TotalMb, fill=pop)) + geom_violin()+
  labs(title="Total ROH")+
  annotate("point", x = 'Santiago', y = TotalWMsan, shape = "asterisk", size=3)+
  annotate("point", x = 'Fogo', y = TotalWMfogo, shape = "asterisk", size=3)+
  annotate("point", x = 'NW', y = TotalWMnw, shape = "asterisk", size=3)+
  annotate("point", x = 'BV', y = TotalWMbv, shape = "asterisk", size=3)+
  stat_summary(fun.y = "mean", geom = "point", size=2,color = "black")+
  #scale_y_continuous(limits = c(0, 600))+
  labs(x="", y="")+
  theme_classic()+
  scale_fill_brewer(palette="Dark2")
shorter <- ggplot(rohAll, aes(x=factor(pop, level = level_order), y=ShorterMb, fill=pop)) + geom_violin()+
  labs(title="Short/Medium ROH")+
  annotate("point", x = 'Santiago', y = ShorterWMsan, shape = "asterisk", size=3)+
  annotate("point", x = 'Fogo', y = ShorterWMfogo, shape = "asterisk", size=3)+
  annotate("point", x = 'NW', y = ShorterWMnw, shape = "asterisk", size=3)+
  annotate("point", x = 'BV', y = ShorterWMbv, shape = "asterisk", size=3)+
  stat_summary(fun.y = "mean", geom = "point", size=2,color = "black")+
  #scale_y_continuous(limits = c(0, 500))+
  labs(x="", y="")+
  theme_classic()+
  scale_fill_brewer(palette="Dark2")
grid.arrange(total, shorter, classC, nrow = 1, bottom="Population", left="Total Length (Mb)")

classAcount <- ggplot(rohAll, aes(x=pop, y=Acount,fill=pop)) + geom_violin()+
  labs(title="Class A Total Count")+
  labs(x="", y="")+
  theme_classic()
classBcount <- ggplot(rohAll, aes(x=pop, y=Bcount, fill=pop)) + geom_violin()+
  labs(title="Class B Total Count")+
  labs(x="", y="")+
  theme_classic()
classCcount <- ggplot(rohAll, aes(x=pop, y=Ccount, fill=pop)) + geom_violin()+
  labs(title="Class C Total Count")+
  labs(x="", y="")+
  theme_classic()
grid.arrange(classAcount, classBcount, classCcount, nrow = 1, bottom="Population", left="Count")

grid.arrange(classA, classB, classC, classAcount, classBcount, classCcount, nrow = 2, bottom="Population", left="")

# plot each individual's total sum of ROH vs number of ROH
ROHclassA <- ggplot(data=rohAll, aes(x=Amb, y=Acount, color=pop)) + geom_point(alpha = 0.3, size = 3)+
  #scale_x_continuous(limits = c(0, 1))+
  scale_color_brewer(palette = "Set1")+
  scale_x_continuous(limits = c(0, 300))+
  theme_classic()+
  labs(title="Class A")+
  labs(x="", y="")
ROHclassB <- ggplot(data=rohAll, aes(x=Bmb, y=Bcount, color=pop)) + geom_point(alpha = 0.3, size = 3)+
  #scale_x_continuous(limits = c(0, 1))+
  theme_classic()+
  scale_x_continuous(limits = c(0, 300))+
  scale_color_brewer(palette = "Set1")+
  labs(title="Class B")+
  labs(x="", y="")
ROHclassC <- ggplot(data=rohAll, aes(x=Cmb, y=Ccount, color=pop)) + geom_point(alpha = 0.3, size = 3)+
  #scale_x_continuous(limits = c(0, 1))+
  theme_classic()+
  scale_x_continuous(limits = c(0, 300))+
  scale_color_brewer(palette = "Set1")+
  labs(title="Class C")+
  labs(x="", y="")
grid.arrange(ROHclassA, ROHclassB, ROHclassC, nrow = 1, bottom="Total length (Mb)", left="Number of ROH")

ggplot(data=rohAll, aes(x=Clength, y=Ccount, color=pop)) + geom_point(alpha = 0.3)+
  #scale_x_continuous(limits = c(0, 1))+
  theme_classic()+
  labs(title="Class C")+
  labs(x="", y="")

###examine the inbreeding coefficients (diagonal of the kinship matrix)
IIDs3grp<- read.table("/Users/klk37/Google Drive/Project_Admixture_CapeVerde/Pop-IID-Key-3grps.txt", header = TRUE)
inbreeding <- read.table("/Users/klk37/Google Drive/Project_Admixture_CapeVerde/Kinship/kinship-inbreedingcoefficients.csv", header = TRUE, sep = ",")
colnames(inbreeding) <- c("ID","kinshipValues")
kinshipROH <- merge(x= rohAll, y= inbreeding, by.x = 'INDIV',by.y = 'ID')
kinshipROHIsland <- merge(x= kinshipROH, y= IIDs3grp, by.x = 'INDIV',by.y = 'IID')
inbShorter <- ggplot(data=kinshipROHIsland, aes(x=kinshipValues, y=ShorterMb, color=Island)) + geom_point(alpha = 0.4, size = 2)+
  #scale_x_continuous(limits = c(0.45, 0.6))+
  theme_classic()+
  scale_color_manual(values = c("#E41A1C", "#4DAF4A", "#984EA3"))+
  labs(title="Short/Medium ROH")+
  labs(x="", y="")
inbTotal <- ggplot(data=kinshipROHIsland, aes(x=kinshipValues, y=TotalMb, color=Island)) + geom_point(alpha = 0.4, size = 2)+
 # scale_x_continuous(limits = c(0.45, 0.6))+
  theme_classic()+
  scale_color_manual(values = c("#E41A1C", "#4DAF4A", "#984EA3"))+
  labs(title="Total ROH")+
  labs(x="", y="")
inbC <- ggplot(data=kinshipROHIsland, aes(x=kinshipValues, y=Cmb, color=Island)) + geom_point(alpha = 0.4, size = 2)+
 # scale_x_continuous(limits = c(0.45, 0.6))+
  theme_classic()+
  scale_color_manual(values = c("#E41A1C", "#4DAF4A", "#984EA3"))+
  labs(title="Long ROH")+
  labs(x="", y="")
grid.arrange(inbTotal, inbShorter, inbC, nrow = 1, bottom="Inbreeding Coefficient", left="Total length ROH (Mb)")
SanInb <- subset(kinshipROHIsland, Island == "Santiago")
FogoInb <- subset(kinshipROHIsland, Island == "Fogo")
NWInb <- subset(kinshipROHIsland, Island == "NWcluster")
cor.test(~ kinshipValues + Clength, data = SanInb, method="pearson")
cor.test(~ kinshipValues + Clength, data = FogoInb, method="pearson")
cor.test(~ kinshipValues + Clength, data = NWInb, method="pearson")

# compare to ancestry:
#QestID has autosomal ancestry proportions from ADMIXTURE. Plot against ROH
Qest=read.table("/Users/klk37/Google Drive/Project_Admixture_CapeVerde/admixture-runs/CV_reseq1kG_autosomes_GWD_IBS_pruned_Admixture10runAvg.txt", header=T)
IIDs4grp<- read.table("/Users/klk37/Google Drive/Project_Admixture_CapeVerde/Pop-IID-Key-4grps.txt", header = TRUE)
QestIDpop4grp <- merge(x= Qest, y= IIDs4grp, by.x = 'IID',by.y = 'IID')
rohQest <- merge(x= QestIDpop4grp, y= rohAll, by.x = 'IID',by.y = 'INDIV')
ancShorter <- ggplot(data=rohQest, aes(x=GWD, y=ShorterMb, color=Island)) + geom_point(alpha = 0.4, size = 2)+
  scale_color_brewer(palette = "Dark2")+
  geom_smooth(method = "lm", fill = NA)+
  theme_classic()+
  labs(title="Short/Medium ROH")+
  labs(x="", y="")
ancTotal <- ggplot(data=rohQest, aes(x=GWD, y=TotalMb, color=Island)) + geom_point(alpha = 0.4, size = 2)+
  scale_color_brewer(palette = "Dark2")+
  geom_smooth(method = "lm", fill = NA)+
  theme_classic()+
  labs(title="Total ROH")+
  labs(x="", y="")
ancC <- ggplot(data=rohQest, aes(x=GWD, y=Cmb, color=Island)) + geom_point(alpha = 0.4, size = 2)+
  scale_color_brewer(palette = "Dark2")+
  geom_smooth(method = "lm", fill = NA)+
  theme_classic()+
  labs(title="Long ROH")+
  labs(x="", y="")
grid.arrange(ancTotal,ancShorter,ancC, nrow = 1, bottom="Afr Ancestry (estimated by ADMIXTURE)", left="Total length (Mb)")
#print at 3x12

ddply(rohQest, .(Island), summarise,
      corr=(cor.test(GWD, TotalMb,
                     alternative="two.sided", method="pearson")), name=names(corr) )
ddply(rohQest, .(Island), summarise,
      corr=(cor.test(GWD, ShorterMb,
                     alternative="two.sided", method="pearson")), name=names(corr) )
ddply(rohQest, .(Island), summarise,
      corr=(cor.test(GWD, Cmb,
                     alternative="two.sided", method="pearson")), name=names(corr) )

### Compare to ancestry switches ################
switches=read.table("/Users/klk37/Google Drive/Project_Admixture_CapeVerde/ROH/AncestrySwitches_CV_fromRFmix.txt", header=F)
switches4grp <- merge(x= switches, y= IIDs4grp, by.x = 'V1',by.y = 'IID')
switchCV <- subset(switches4grp, Island == 'Santiago' | Island == 'NWcluster' | Island == 'Fogo' | Island == 'BoaVista')
rohSwitch <- merge(x= switchCV, y= rohAll, by.x = 'V1',by.y = 'INDIV')
swShort <- ggplot(data=rohSwitch, aes(x=V4, y=Amb, color=Island)) + geom_point(alpha = 0.4, size = 2)+
  scale_color_brewer(palette = "Dark2")+
  theme_classic()+
  labs(title="Short ROH")+
  labs(x="", y="")
swMedium <- ggplot(data=rohSwitch, aes(x=V4, y=Bmb, color=Island)) + geom_point(alpha = 0.4, size = 2)+
   scale_color_brewer(palette = "Dark2")+
  theme_classic()+
  labs(title="Medium ROH")+
  labs(x="", y="")
swC <- ggplot(data=rohSwitch, aes(x=V4, y=Cmb, color=Island)) + geom_point(alpha = 0.4, size = 2)+
  scale_color_brewer(palette = "Dark2")+
  theme_classic()+
  labs(title="Long ROH")+
  labs(x="", y="")
grid.arrange(swShort,swMedium,swC, nrow = 1, bottom="Ancestry Switches", left="Total length ROH (Mb)")
cor.test(~ V4 + Amb, data = rohSwitch, method="pearson")
cor.test(~ V4 + Bmb, data = rohSwitch, method="pearson")
cor.test(~ V4 + Cmb, data = rohSwitch, method="pearson")

# plot each individuals total sum of ROH vs number of ROH
ROHclassA <- ggplot(data=rohQest, aes(x=LengthA, y=Acount, color=Island)) + geom_point(alpha = 0.3)+
  #scale_x_continuous(limits = c(0, 1))+
  theme_classic()+
  labs(title="Class A")+
  labs(x="", y="")+
  theme(legend.position="none")
ROHclassB <- ggplot(data=rohQest, aes(x=LengthB, y=Bcount, color=Island)) + geom_point(alpha = 0.3)+
  #scale_x_continuous(limits = c(0, 1))+
  theme_classic()+
  labs(title="Class B")+
  labs(x="", y="")+
  theme(legend.position="none")
ROHclassC <- ggplot(data=rohQest, aes(x=LengthC, y=Ccount, color=Island)) + geom_point(alpha = 0.3)+
  #scale_x_continuous(limits = c(0, 1))+
  theme_classic()+
  labs(title="Class C")+
  labs(x="", y="")+
  theme(legend.position="none")
grid.arrange(ROHclassA, ROHclassB, ROHclassC, nrow = 1, bottom="Total length (Mb)", left="Number of ROH")

### Chromosomes 7, females only (for comparison to X)
#First, run the raw output from garlic: *.roh.bed through parseGarlic-byIndiv.pl, use the output of that script here.
readSantiago7Fs <- read.table("/Users/klk37/Google Drive/Project_Admixture_CapeVerde/Garlic_NewRef/testAutoWinsizeResample100_Santiago_aut7_Females.roh.bed_byIndiv.txt", header=TRUE, stringsAsFactors = FALSE)
readFogo7Fs <- read.table("/Users/klk37/Google Drive/Project_Admixture_CapeVerde/Garlic_NewRef/testAutoWinsizeResample100_Fogo_aut7_Females.roh.bed_byIndiv.txt", header=TRUE, stringsAsFactors = FALSE)
readNW7Fs <- read.table("/Users/klk37/Google Drive/Project_Admixture_CapeVerde/Garlic_NewRef/testAutoWinsizeResample100_NWcluster_aut7_Females.roh.bed_byIndiv.txt", header=TRUE, stringsAsFactors = FALSE)
readIBS7Fs <- read.table("/Users/klk37/Google Drive/Project_Admixture_CapeVerde/Garlic_NewRef/testAutoWinsizeResample100_IBS_aut7_Females.roh.bed_byIndiv.txt", header=TRUE, stringsAsFactors = FALSE)
readGWD7Fs <- read.table("/Users/klk37/Google Drive/Project_Admixture_CapeVerde/Garlic_NewRef/testAutoWinsizeResample100_GWD_aut7_Females.roh.bed_byIndiv.txt", header=TRUE, stringsAsFactors = FALSE)

rohSantiago7Fs <- data.frame(pop = "Santiago", readSantiago7Fs)
rohFogo7Fs <- data.frame(pop = "Fogo", readFogo7Fs)
rohNW7Fs <- data.frame(pop = "NW", readNW7Fs)
rohIBS7Fs <- data.frame(pop = "IBS", readIBS7Fs)
rohGWD7Fs <- data.frame(pop = "GWD", readGWD7Fs)
roh7Fs <- rbind(rohSantiago7Fs, rohFogo7Fs,rohNW7Fs, rohIBS7Fs, rohGWD7Fs, stringsAsFactors=FALSE)

roh7Fs$Amb <- as.numeric(as.character(roh7Fs$Alength)) / 1000000
roh7Fs$Bmb <- as.numeric(as.character(roh7Fs$Blength)) / 1000000
roh7Fs$Cmb <- as.numeric(as.character(roh7Fs$Clength)) / 1000000
roh7Fs$ShorterMb<- roh7Fs$Amb + roh7Fs$Bmb

roh7Fs$TotalLength <- roh7Fs$Alength + roh7Fs$Blength + roh7Fs$Clength
roh7Fs$TotalMb<- roh7Fs$Amb + roh7Fs$Bmb + roh7Fs$Cmb
roh7Fs$TotalNum <- roh7Fs$Acount + roh7Fs$Bcount+ roh7Fs$Ccount
#Avg (per individual) total length of ROH (total length ROH / # individuals) by class
San <- subset(roh7Fs, pop == 'Santiago')
(sum(San$TotalLength)/102)/1000000
(sum(San$Alength)/102)/1000000
(sum(San$Blength)/102)/1000000
(sum(San$Clength)/102)/1000000
Fogo <- subset(roh7Fs, pop == 'Fogo')
(sum(Fogo$TotalLength)/75)/1000000
(sum(Fogo$Alength)/75)/1000000
(sum(Fogo$Blength)/75)/1000000
(sum(Fogo$Clength)/75)/1000000
NW <- subset(roh7Fs, pop == 'NW')
(sum(NW$TotalLength)/140)/1000000
(sum(NW$Alength)/140)/1000000
(sum(NW$Blength)/140)/1000000
(sum(NW$Clength)/140)/1000000
GWD <- subset(roh7Fs, pop == 'GWD')
(sum(GWD$TotalLength)/55)/1000000
(sum(GWD$Alength)/55)/1000000
(sum(GWD$Blength)/55)/1000000
(sum(GWD$Clength)/55)/1000000
IBS <- subset(roh7Fs, pop == 'IBS')
(sum(IBS$TotalLength)/53)/1000000
(sum(IBS$Alength)/53)/1000000
(sum(IBS$Blength)/53)/1000000
(sum(IBS$Clength)/53)/1000000

### x chromosome
#First, run the raw output from garlic: *.roh.bed through parseGarlic-byIndiv.pl, use the output of that script here.
XreadSantiago <- read.table("/Users/klk37/Google Drive/Project_Admixture_CapeVerde/Garlic_NewRef/testAutoWinsizeResample100_SantiagochrX.roh.bed_byIndiv.txt", header=TRUE, stringsAsFactors = FALSE)
XreadFogo <- read.table("/Users/klk37/Google Drive/Project_Admixture_CapeVerde/Garlic_NewRef/testAutoWinsizeResample100_FogochrX.roh.bed_byIndiv.txt", header=TRUE, stringsAsFactors = FALSE)
XreadNW <- read.table("/Users/klk37/Google Drive/Project_Admixture_CapeVerde/Garlic_NewRef/testAutoWinsizeResample100_NWclusterchrX.roh.bed_byIndiv.txt", header=TRUE, stringsAsFactors = FALSE)
#readBV <- read.table("/Users/klk37/Google Drive/Project_Admixture_CapeVerde/Garlic_NewRef/testAutoWinsizeResample100_BoaVistaAuto.roh.bed_byIndiv.txt", header=TRUE, stringsAsFactors = FALSE)
XreadIBS <- read.table("/Users/klk37/Google Drive/Project_Admixture_CapeVerde/Garlic_NewRef/testAutoWinsizeResample100_IBSchrX.roh.bed_byIndiv.txt", header=TRUE, stringsAsFactors = FALSE)
#readYRI <- read.table("/Users/klk37/Google Drive/Project_Admixture_CapeVerde/Garlic_NewRef/YRI-IBS-CV/test-autowinsize-resample100-YRI.roh.bed_byIndiv.txt", header=TRUE, stringsAsFactors = FALSE)
XreadGWD <- read.table("/Users/klk37/Google Drive/Project_Admixture_CapeVerde/Garlic_NewRef/testAutoWinsizeResample100_GWDchrX.roh.bed_byIndiv.txt", header=TRUE, stringsAsFactors = FALSE)

XrohSantiago <- data.frame(pop = "Santiago", XreadSantiago)
XrohFogo <- data.frame(pop = "Fogo", XreadFogo)
XrohNW <- data.frame(pop = "NW", XreadNW)
#XrohBV <- data.frame(pop = "BV", readBV)
XrohIBS <- data.frame(pop = "IBS", XreadIBS)
#XrohYRI <- data.frame(pop = "YRI", readYRI)
XrohGWD <- data.frame(pop = "GWD", XreadGWD)
XrohAll <- rbind(XrohSantiago, XrohFogo, XrohNW, XrohIBS, XrohGWD, stringsAsFactors=FALSE)
#rohAll <- rbind(rohSantiago, rohFogo, rohNW, rohBV, rohYRI, rohIBS, rohGWD, stringsAsFactors=FALSE)

XrohAll$Amb <- as.numeric(as.character(XrohAll$Alength)) / 1000000
XrohAll$Bmb <- as.numeric(as.character(XrohAll$Blength)) / 1000000
XrohAll$Cmb <- as.numeric(as.character(XrohAll$Clength)) / 1000000
XrohAll$ShorterMb<- XrohAll$Amb + XrohAll$Bmb

XrohAll$TotalLength <- XrohAll$Alength + XrohAll$Blength + XrohAll$Clength
XrohAll$TotalMb<- XrohAll$Amb + XrohAll$Bmb + XrohAll$Cmb
XrohAll$TotalNum <- XrohAll$Acount + XrohAll$Bcount+ XrohAll$Ccount
#Avg (per individual) total length of ROH (total length ROH / # individuals) by class
XSan <- subset(XrohAll, pop == 'Santiago')
(sum(XSan$TotalLength)/102)/1000000
(sum(XSan$Alength)/102)/1000000
(sum(XSan$Blength)/102)/1000000
(sum(XSan$Clength)/102)/1000000
XFogo <- subset(XrohAll, pop == 'Fogo')
(sum(XFogo$TotalLength)/75)/1000000
(sum(XFogo$Alength)/75)/1000000
(sum(XFogo$Blength)/75)/1000000
(sum(XFogo$Clength)/75)/1000000
XNW <- subset(XrohAll, pop == 'NW')
(sum(XNW$TotalLength)/140)/1000000
(sum(XNW$Alength)/140)/1000000
(sum(XNW$Blength)/140)/1000000
(sum(XNW$Clength)/140)/1000000
XGWD <- subset(XrohAll, pop == 'GWD')
(sum(XGWD$TotalLength)/55)/1000000
(sum(XGWD$Alength)/55)/1000000
(sum(XGWD$Blength)/55)/1000000
(sum(XGWD$Clength)/55)/1000000
XIBS <- subset(XrohAll, pop == 'IBS')
(sum(XIBS$TotalLength)/53)/1000000
(sum(XIBS$Alength)/53)/1000000
(sum(XIBS$Blength)/53)/1000000
(sum(XIBS$Clength)/53)/1000000

level_order <- c('Santiago', 'Fogo', 'NW','GWD','IBS')
##plot total length by individual:
XclassA <- ggplot(XrohAll, aes(x=pop, y=Amb, fill=pop)) + geom_violin()+
  labs(title="Short Xroh")+
  scale_y_continuous(limits = c(0, 300))+
  labs(x="", y="")+
  theme_classic()
XclassB <- ggplot(XrohAll, aes(x=pop, y=Bmb, fill=pop)) + geom_violin()+
  labs(title="Medium Xroh")+
  scale_y_continuous(limits = c(0, 300))+
  labs(x="", y="")+
  theme_classic()
XclassC <- ggplot(XrohAll, aes(x=factor(pop, level = level_order), y=Cmb, fill=pop)) + geom_violin()+
  labs(title="Long Xroh")+
  stat_summary(fun.y = "mean", geom = "point", size=2,color = "black")+
  scale_y_continuous(limits = c(0, 300))+
  labs(x="", y="")+
  theme_classic()
grid.arrange(XclassA, XclassB, XclassC, nrow = 1, bottom="Population", left="Total Length (Mb)")

Xavg <- ggplot(XrohAll, aes(x=factor(pop, level = level_order), y=TotalLength, fill=pop)) + geom_violin()+
  labs(title=" X Length")+
  stat_summary(fun.y = "mean", geom = "point", size=2,color = "black")+
  labs(x="", y="")+
  theme_classic()
autavg <- ggplot(rohAll, aes(x=factor(pop, level = level_order), y=TotalLength, fill=pop)) + geom_violin()+
  labs(title="Length")+
  stat_summary(fun.y = "mean", geom = "point", size=2,color = "black")+
  labs(x="", y="")+
  theme_classic()
grid.arrange(Xavg, autavg, nrow = 1, bottom="Population")

XavgC <- ggplot(XrohAll, aes(x=factor(pop, level = level_order), y=Cmb/Ccount, fill=pop)) + geom_violin()+
  labs(title=" X Avg Length - Class C")+
  stat_summary(fun.y = "mean", geom = "point", size=2,color = "black")+
  scale_y_continuous(limits = c(0, 15))+
  labs(x="", y="")+
  theme_classic()
autavgC <- ggplot(roh7Fs, aes(x=factor(pop, level = level_order), y=Cmb/Ccount, fill=pop)) + geom_violin()+
  labs(title="Avg Length")+
  stat_summary(fun.y = "mean", geom = "point", size=2,color = "black")+
  scale_y_continuous(limits = c(0, 15))+
  labs(x="", y="")+
  theme_classic()
grid.arrange(XavgC, autavgC, nrow = 1, bottom="Population")

autoSave <- roh7Fs[,c("pop", "ShorterMb", "Cmb")]
autoSave$Cat = "autosomal"
autoSave$ShorterMbperMb <- autoSave$ShorterMb/159138663
autoSave$LongMbperMb <- autoSave$Cmb/159138663
xSave <- XrohAll[,c("pop", "ShorterMb", "Cmb")]
xSave$Cat = "x chromosome"
xSave$ShorterMbperMb <- xSave$ShorterMb/155270560
xSave$LongMbperMb <- xSave$Cmb/155270560
autoVx <- rbind(autoSave, xSave)
autoVx[is.na(autoVx)] <- 0
autoVx <- autoVx[!(autoVx$pop=="BV"),]
autoVx$Cat <- factor(autoVx$Cat, levels = c('autosomal','x chromosome'),ordered = TRUE)

compareShorter <- ggplot(na.omit(autoVx), aes(x = pop, y = ShorterMbperMb, fill=Cat)) + 
  geom_boxplot(position = position_dodge(preserve = "single"),outlier.shape=NA, alpha=0.7) + 
  geom_point(size=0.3, aes(colour = Cat, alpha= 0.1),position=position_jitterdodge(jitter.width = 0.2, jitter.height = 0))+
  scale_fill_brewer(palette="Set1") + 
  scale_color_brewer(palette="Set1") +
  #scale_y_continuous(expand = c(0, 0), limits = c(0, 0.5))+
  labs(title="Shorter ROH")+
  theme_classic() + labs(x="", y="Total Length of ROH Tracts / Mb")
compareLong <- ggplot(na.omit(autoVx), aes(x = pop, y = LongMbperMb, fill=Cat)) + 
  geom_boxplot(position = position_dodge(preserve = "single"),outlier.shape=NA, alpha=0.7) + 
  geom_point(size=0.3, aes(colour = Cat, alpha= 0.1),position=position_jitterdodge(jitter.width = 0.2, jitter.height = 0))+
  scale_fill_brewer(palette="Set1") + 
  scale_color_brewer(palette="Set1") +
  #scale_y_continuous(expand = c(0, 0), limits = c(0, 0.5))+
  labs(title="Long ROH")+
  theme_classic() + labs(x="", y="Total Length of ROH Tracts / Mb")
grid.arrange(compareShorter, compareLong, nrow = 1, bottom="Population")

SantAutoVx <- subset(autoVx, pop == "Santiago")
FogoAutoVx <- subset(autoVx, pop == "Fogo")
NWAutoVx <- subset(autoVx, pop == "NW")
SantAutoVx[is.na(SantAutoVx)] = 0
FogoAutoVx[is.na(FogoAutoVx)] = 0
NWAutoVx[is.na(NWAutoVx)] = 0
wilcox.test(SantAutoVx$ShorterAvgLen ~ SantAutoVx$Cat, paired=TRUE) 
wilcox.test(SantAutoVx$LongAvgLen ~ SantAutoVx$Cat, paired=TRUE) 
wilcox.test(FogoAutoVx$LongAvgLen ~ FogoAutoVx$Cat, paired=TRUE) 
wilcox.test(NWAutoVx$LongAvgLen ~  NWAutoVx$Cat, paired=TRUE) 