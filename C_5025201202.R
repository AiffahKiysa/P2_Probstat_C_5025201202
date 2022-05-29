# 1. 
data <- read.csv("saturasi_oksigen.csv")
data

# a.
sd(data$ï..X-data$Y)

# b.
t.test(data$Y, data$ï..X, paired=TRUE)

# 2.
install.packages("BSDA")
library(BSDA)

zsum.test(mean.x=23500, sigma.x = 3900, n.x = 100,  
          alternative = "greater", mu = 20000,
          conf.level = 0.95)


# 3.
# b.
tsum.test(mean.x=3.64, s.x = 1.67, n.x = 19, 
          mean.y=2.79, s.y = 1.32, n.y = 27, alternative = "greater", 
          mu = 0, var.equal = TRUE,
          conf.level = 0.90)

# c.
install.packages("mosaic")
library(mosaic)
plotDist(dist='t', df=2, col="red")

# d.
qchisq(p = 0.05, df = 2, lower.tail=FALSE)


# 4.
onewayanova = read.table("onewayanova.txt",h=T)
onewayanova

# a.
# set group jadi factor
onewayanova$Group <- as.factor(onewayanova$Group)

# memberikan label
onewayanova$Group = factor(onewayanova$Group,labels = c("kucing oren", "kucing hitam", "kucing putih"))

Group1 <- subset(onewayanova, Group == "kucing oren")
Group2 <- subset(onewayanova, Group == "kucing hitam")
Group3 <- subset(onewayanova, Group == "kucing putih")

qqnorm(Group1$Length)
qqline(Group1$Length)

qqnorm(Group2$Length)
qqline(Group2$Length)

qqnorm(Group3$Length)
qqline(Group3$Length)

# b.
# Homogeneneity of variances
bartlett.test(Length ~ Group, data = onewayanova)

# c.
#One Way ANOVA
#lm = linier model
model1 = lm(Length ~ Group, data = onewayanova)
anova(model1)

# e.
#Post-hoc test TukeyHSD
TukeyHSD(aov(model1))

# f.
install.packages("ggplot2")
library("ggplot2")

ggplot(onewayanova, aes(x = Group, y = Length)) +
  geom_boxplot(color = c("#00AFBB", "#E7B800", "#FC4E07")) +
  scale_x_discrete() + xlab("Group") + ylab("Length (cm)")


# 5.
glasstemp = read.csv("GTL.csv")
glasstemp
# check structure
str(glasstemp)

# a.
qplot(x = Temp, y = Light, geom = "auto", data = glasstemp) +
  facet_grid(.~Glass, labeller = label_both)

# b.
glasstemp$Glass <- as.factor(glasstemp$Glass)
glasstemp$Temp <- as.factor(glasstemp$Temp)

anova <- aov(Light ~ Glass*Temp, data = glasstemp)
summary(anova)

# c.
install.packages("dplyr")
library(magrittr)
library(dplyr)
summary <- group_by(glasstemp, Glass, Temp) %>%
  summarise(mean=mean(Light), sd=sd(Light)) %>%
  arrange(desc(mean))
summary

# d.
tukey <- TukeyHSD(anova)
tukey

# e.
# membuat compact letter display
install.packages("multcompView")
library(multcompView)
tukey.cld <- multcompLetters4(anova, tukey)
print(tukey.cld)

# menambahkan means dan sd ke tabel compact letter display
cld <- as.data.frame.list(tukey.cld$`Glass:Temp_Factor`)
summary$Tukey <- cld$Letters
summary


