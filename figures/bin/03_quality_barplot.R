#Barplot for quality report
#Valeria Flores
#13/01/2021

#Load libraries
library (ggplot2)
library(scales)
library(wesanderson)

#Load table
quality<-read.csv("../data/quality.csv")
class(quality)
dim(quality)
names(quality)

#Set the samples order and set samples as factor
quality$sample <- factor(quality$sample, levels = c('DPVR1_S179', 'DPVR2_S180', 'DPVR3_S181', 'DPVR4_S182', 'DPVR5_S183', 'DPVR6_S184', 'DPVR7_S185', 'DPVR8_S186', 'DPVR9_S187', 'DPVR10_S188', 'DPVR11_S189', 'DPVR12_S190', 'DPVR13_S191', 'DPVR14_S192', 'DPVR15_S193', 'DPVR16_S194', 'DPVR17_S195', 'DPVR18_S196'), ordered = TRUE)
quality$sample


#Set the category order and set samples as factor
quality$category <- factor(quality$category, levels = c('dropped', 'unpaired', 'paired'), ordered = TRUE)
as.factor(quality$category)
quality$category

#Plot the stacked barchart
stackedplot <- ggplot(quality, aes(fill=category, y=reads, x=sample)) + 
  labs(x="Sample",y="Number of reads")+
  geom_bar(position="dodge", stat="identity")+
  theme_classic()+
  theme(axis.text.x = element_text(face="bold", size=10, angle=90))+
  scale_fill_manual(values = wes_palette("Moonrise3", n = 3))

stackedplot


#Plot the percent stacked barchart

qualityplot <- ggplot(quality, aes(fill=category, y=reads, x=sample)) + 
  labs(x="Sample",y="Number of reads")+
  geom_bar(position="stack", stat="identity")+
  theme_classic()+
  theme(axis.text.x = element_text(face="bold", size=10, angle=90))+
  scale_fill_manual(values = wes_palette("Moonrise3", n = 3))

qualityplot

