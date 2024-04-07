#reading in data and functions
whocovid <- read.csv("https://covid19.who.int/WHO-COVID-19-global-data.csv")
fin_country_class <- read.csv("~/Documents/STA141A/fin_country_class.csv")
library(tidyverse)
library(dbplyr)
library(ggplot2)
library(gplots)
library(car)
library(readr)
library(ggeffects)

#printing out first 6 entries of data set 
head(whocovid)

#combining the observations by country
data=whocovid%>%
  group_by(Country) %>% 
  summarize(max_cases = max(Cumulative_cases, na.rm = TRUE),  #finding the cumulative cases and deaths for each country
            max_deaths = max(Cumulative_deaths))
data$death_rate_percentage=(data$max_deaths/data$max_cases)*100 #calculating death rate percentage based on number of cases and deaths in each country
filter.data=data%>%filter(is.na(death_rate_percentage)!=TRUE) #getting rid of NA values
filter.data

#create a new data set that classifies each country as developed or not developed, adds in region and population
new_data=inner_join(filter.data, fin_country_class, by=c("Country")) 
new_data

#filter out only developed countries
dat.develop=new_data%>%filter(Classification=="Developed")%>%arrange(Population..mil.)
dat.develop=head(dat.develop,n=23)
dat.develop

#filter out developing countries 
not.develop=new_data%>%filter(Classification=="Developing")%>%arrange(Population..mil.)
not.develop=head(not.develop,n=91)
not.develop

#combining the smaller pop. of developed with smaller pop. of developing 
df1=rbind(dat.develop,not.develop)
df1=df1[c("Classification","Region", "death_rate_percentage","Population..mil.","max_cases")]
df1$pos_case_rate=((df1$max_cases/1000000)/df1$Population..mil.)*100
df=df1[c("Classification","Region", "death_rate_percentage")]
df

#finding mean death rate based on classification and region
aggregate(death_rate_percentage~Classification, data=df, mean)
aggregate(death_rate_percentage~Region, data=df, mean)

#Box plot classification vs. death rate 
ggplot(data=df, mapping=aes(x=Classification, y=death_rate_percentage)) +
  geom_boxplot() +
  ggtitle("Box plot: Classification vs. Death Rate Percentage")+
  xlab("Classification") #creating a box plot of mean scores based on class type 

#Box plot classification vs. death rate 
ggplot(data=df, mapping=aes(x=Region, y=death_rate_percentage)) +
  geom_boxplot() +
  ggtitle("Box plot: Region vs. Death Rate Percentage")+
  xlab("Region") #creating a box plot of mean scores based on class type

#histograms
ggplot(df, aes(x=death_rate_percentage))+
  geom_histogram(binwidth = 1) +
  facet_grid(Classification ~.) +
  ggtitle("Histogram: Death Rate Percentage Distribution Based on Classification")\
ggplot(df, aes(x=death_rate_percentage))+
  geom_histogram(binwidth = 1) +
  facet_grid(Region ~.) +
  ggtitle("Histogram: Death Rate Percentage Distribution Based on Region")

#Main effect
plotmeans(death_rate_percentage~Region,data=df,xlab="Region",ylab="Death Rate Percentage",
          main="Main  effect, Region",cex.lab=1.5) 
plotmeans(death_rate_percentage~Classification,data=df,xlab="Classification",ylab="Death Rate Percentage",
          main="Main  effect, Classification",cex.lab=1.5)

#Test for interaction
full_model=lm(death_rate_percentage~as.factor(Classification)+as.factor(Region)+as.factor(Classification)*as.factor(Region),data=df);
reduced_model=lm(death_rate_percentage~as.factor(Classification)+as.factor(Region),data=df);
anova(reduced_model,full_model)

#F Test 
res2=lm(death_rate_percentage~as.factor(Classification)+as.factor(Region),data=df)
anova.model=Anova(res2, type = 2)
anova.model

#Confidence Intervals 
sig.level=0.05;
T.ci=TukeyHSD(aov(res2),conf.level = 1-sig.level)
par(mfrow=c(1,1))
plot(T.ci, las=1 , col="purple")
par(mfrow=c(1,1))

#mean death percentage of region given classification
idx=list();
idx[[1]]=df$Classification;idx[[2]]=df$Region;
(means.comb=tapply( df$death_rate_percentage, INDEX=idx,mean))

#creating logistic regression model 
df$Classification = as.factor(df$Classification)
mod.can.lg<-glm(Classification~death_rate_percentage,data=df,family="binomial")
summary(mod.can.lg)
plot(jitter(mod.can.lg$y)~mod.can.lg$fitted.values,pch=16,xlab="Fitted values", ylab="Is canceled (jittered)")
threshold = 0.5;
plot(ggpredict(mod.can.lg,"death_rate_percentage[all]"))

#Sensetivity Analysis Plots 
options(repr.plot.width=12, repr.plot.height=6)
par(mfrow=c(1,2))
plot(aov(res2),cex.lab=1.2,which=1:2)
par(mfrow=c(1,1))

#Levene Test 
leveneTest(death_rate_percentage~Classification*Region,data=df)