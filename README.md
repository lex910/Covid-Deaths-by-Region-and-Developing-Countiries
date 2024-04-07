# Covid Deaths by Region and Developing Countries

### Abstract 
This data analysis project will aim to determine if being a developing country and being in a specific region of the world is correlated to different mean death rate percentages due to the COVID-19 Pandemic. The COVID-19 data is obtained from the World Heath Organization and an additional source was used to classify countries as developed or developing. There are two factors that are being analyzed to see whether they effect death rate percentages. Factor A is classification with 2 levels (developed and developing) and factor B is region with 6 levels (Americas, Eastern Mediterranean, Western Pacific, South-East Asia, Africa, and Europe). First we will perform descriptive analysis and data visualization to obtain our data set and understand the distribution. Next, we fit the data set to a two way ANOVA model to further understand how region and classification effect death rates due to COVID 19 in countries. A logistic regression model will also be fit for prediction. Lastly, sensitivity analysis is performed to ensure that the dataset meets the assumptions of the model.

### Background/Introduction
The first case of COVID-19 was reported in December of 2019. The virus made its first appearance in the United States in January 2020 and has since surged through the worlds population at different rates and potency. With the virus being extremely transmittable and deathly, a vaccine has since been refined and administered to try and reduce the spread and fatality rate if infected. Countries have handled the pandemic in different fashions from initiating complete lock downs, mask mandates, and/or the requirement of being vaccinated to enter public establishments. How countries have decided to tackle the concerns of the pandemic have largely influenced infection and death rates in different places around the world. Different country economic standards and levels of development have also influenced how countries are able to provide for their citizens. Statistical data analysis pertaining to the pandemic has become largely popular to try and find answers and trends to the effects of the pandemic in hopes of bringing an end to the pandemic. The World Heath Organization has compiled a data-set that will be used throughout this project that takes daily statistics of infection and number of deaths in each country. Combining this data set with a country classification data set (https://www.un.org/development/desa/dpad/wp-content/uploads/sites/45/publication/WESP2022_web.pdf) we will aim to see if there is a correlation between region in the world, death rate, and whether the country has a developed economy or a developing economy. For this project, the countries that were classified as “in transition” in the data set will be considered developing countries. Some characteristics of countries with developing economies includes a low gross domestic product per person, low living standards, and low levels of industrialization. These characteristics may lead to less access to vaccines, as the cold supply chain to store the vaccines at low temperatures may be un-affordable and resources are not present. Additionally with a lesser developed economy, medical care for those infected may become less accessible and less advanced. With all of the factors going against developing countries during the pandemic is there actually a higher death percentage of those infected than countries that are considered developed and have more access to resources? It is expected to see that the death rate percentage of developed countries will be lower than those of undeveloped countries because they have more access to vaccines and advanced medicine.

#### Descriptive Analysis/Summary Statistics
<img width="597" alt="Screenshot 2024-04-07 at 9 34 34 AM" src="https://github.com/lex910/Covid-Deaths-by-Region-and-Developing-Countiries/assets/101606445/1b49c183-479a-486d-b47d-58cfd6fad807">

The data set is now grouped by country to combine all of the days from the country into one row as the new cases variable will not be useful for the purpose of our data analysis. Now there will only be one row for each country instead of every country having a new row for a new day. The row for each country will now also show max cases, max deaths, and a new variable, death rate percentage is calculated in a new column by dividing deaths by cases so we can see the number of people who die based on the number who are infected. The variables are now country, max_cases which is the number or reported positive cases, max_deaths which is the total amount of deaths in the specific country and death_rate_percentage. This new variable will be helpful because since it is a percent, it eliminates the variability we will get due to the fact that every country has a different population number.

<img width="780" alt="Screenshot 2024-04-07 at 9 35 22 AM" src="https://github.com/lex910/Covid-Deaths-by-Region-and-Developing-Countiries/assets/101606445/c0b016f5-49a2-4955-b4aa-65fa7efab79e">
Next, we will use a data set that the “World Economic Situations and Prospects” (WESP) uses to classify countries as developed, in transition, or developing economies. We joined this data set with our previous data set by country so that now each country will be classified as a developed or developing economy. For the purpose of our data analysis, countries classified as in transition by the data set will be reclassified into the developing category. Region and population were also added as new variables.

<img width="366" alt="Screenshot 2024-04-07 at 9 36 17 AM" src="https://github.com/lex910/Covid-Deaths-by-Region-and-Developing-Countiries/assets/101606445/a2715282-44bf-4150-8371-51916ae28573">

<img width="492" alt="Screenshot 2024-04-07 at 9 36 24 AM" src="https://github.com/lex910/Covid-Deaths-by-Region-and-Developing-Countiries/assets/101606445/7aec8464-d703-4a1b-a002-f0b64dab54d7">

The table shows the mean death rate percentage based on if the country is classified as a developed or developing economy. The average death rate percentage is seen to be higher in those classified as developing. Next we can see the mean death rates for every region. It appears that the death rate is the highest in Africa and lowest in South-East Asia. 

<img width="722" alt="Screenshot 2024-04-07 at 9 36 50 AM" src="https://github.com/lex910/Covid-Deaths-by-Region-and-Developing-Countiries/assets/101606445/41f7338c-a549-4f39-b190-d2b75ecb8655">

<img width="831" alt="Screenshot 2024-04-07 at 9 36 59 AM" src="https://github.com/lex910/Covid-Deaths-by-Region-and-Developing-Countiries/assets/101606445/8c147c58-47ae-441e-8d5b-7e9cd8f22d54">

<img width="776" alt="Screenshot 2024-04-07 at 9 37 09 AM" src="https://github.com/lex910/Covid-Deaths-by-Region-and-Developing-Countiries/assets/101606445/15222466-0ef7-485e-8218-68b2bb0d4daa">

<img width="791" alt="Screenshot 2024-04-07 at 9 37 23 AM" src="https://github.com/lex910/Covid-Deaths-by-Region-and-Developing-Countiries/assets/101606445/390a82cb-8d21-44e6-a525-a3828a5b3b72">

## Inferential Analysis/Two Way ANOVA
First we will fit our data to a model to try and see the effects of classification and region on death rate. Since we have two factor levels, we will use a two way ANOVA model to determine if there is a difference in the mean based upon region and classification. We will first conduct a hypothesis test of ANOVA to see if there is an interaction effect or not.

Hypothesis Test: Ho, null hypothesis: The model with no interactions is statistically a better fit model than the model with interactions. All Gamma*Delta(ij) = 0

Ha, alternative hypothesis: The model with interactions is a statistically better fit than the model with no interactions. At least one Gamma*Delta(ij) != 0

Full model: Yijk = mu.. + gamma(i) + delta(j) + GammaDelta(ij) + epsilon(ijk) constraints: summation of gamma(i) = 0, summation of delta(j) = 0, summation for all i of GammaDelta(ij) = 0 = summation for all j of GammaDelta(ij)

Reduced model: Yijk = mu.. + gamma(i) + delta(j) + epsilon(ijk) with constraints: summation of gamma(i) = 0, summation of delta(j) = 0

<img width="845" alt="Screenshot 2024-04-07 at 9 38 15 AM" src="https://github.com/lex910/Covid-Deaths-by-Region-and-Developing-Countiries/assets/101606445/a55b41a5-6803-4ef8-8d07-e5d5033a5148">

<img width="859" alt="Screenshot 2024-04-07 at 9 38 26 AM" src="https://github.com/lex910/Covid-Deaths-by-Region-and-Developing-Countiries/assets/101606445/3dc7db33-3c3f-4fed-a576-7cf49853976a">

Here is a plot of the effect of region by itself on the dependent variable of death rate percentage. Africa has the highest average while South East Asia has the lowest. Additionally, there is a plot of the effect of classification by itself on the dependent variable of death rate percentage. We can see there are 23 developed observations and 91 developing. The mean death rate for developed is below .6 while the mean death rate for developing is below 1.

<img width="946" alt="Screenshot 2024-04-07 at 9 38 49 AM" src="https://github.com/lex910/Covid-Deaths-by-Region-and-Developing-Countiries/assets/101606445/e26f2cf6-2023-46dd-b740-4b3f2ec24aef">

The ANOVA table for testing to see if interaction terms are significant shows a p-value of 0.2523 which is larger than alpha=0.05 therefore we fail to reject the null hypothesis and conclude that the model with interaction terms between region and classification do not improve the statistical model. This means that the reduced model will be sufficient to use which does not contain interaction terms to see effects on the death rate percentage.

<img width="704" alt="Screenshot 2024-04-07 at 9 39 11 AM" src="https://github.com/lex910/Covid-Deaths-by-Region-and-Developing-Countiries/assets/101606445/5fc0ba91-253c-4719-974a-64733fc6fea6">

We will run an imbalanced ANOVA test since there are a different number of countries in each factor level. When running a type II sum of squares test for ANOVA we can see that p-values are relatively small compared to the significance level, proving that classification and region have a significant effect on the response variable, death rate percentage. Therefore, our final model will include both factor effects with no interaction terms.

Now that we know both parameters are significant, we will begin testing to determine which groups pairs of factor levels are different from one another and to see if there is a specific combination of region and classification that has the highest death rate percentage.

## Confidence Intervals 

<img width="791" alt="Screenshot 2024-04-07 at 9 39 55 AM" src="https://github.com/lex910/Covid-Deaths-by-Region-and-Developing-Countiries/assets/101606445/ad98eea1-10ea-4842-9463-f3ba53c2d9f0">
<img width="753" alt="Screenshot 2024-04-07 at 9 40 05 AM" src="https://github.com/lex910/Covid-Deaths-by-Region-and-Developing-Countiries/assets/101606445/7dd371d6-d4c3-456b-9e36-632a95c5eb8b">

When looking at the 95% family wise confidence intervals for classification, we can see that that there is a difference in the mean levels of death rate percentage between developed and developing countries since the interval does not include zero. Since it is developing minus developed, we can conclude that developing countries have a higher death rate percentage than developed. Looking at the confidence intervals for region, differences in the mean death rate exist between Western Pacific and Africa where Western Pacific has a smaller mean death rate than Africa. We can conclude this because the confidence interval does not contain zero, meaning there is no difference in the mean death rate. The other significant difference is the mean death rate between Western Pacific and Europe where the Western Pacific has a lower death rate than Europe.

## Means depending on both factors
This table illustrates the mean death rate percentage based upon both factors simultaneously. The NA entries means that there were no reported countries that fit into both factors. For example, there are no developed countries in Africa in the portion of data that we are using. Developed countries in the Western Pacific have the lowest death rate percentage while developing countries in Europe have the highest. It is also worthy to note that there are only developed countries in Europe and the Western Pacific and both numbers are relatively low compared to the death rate percentages in developing countries.

## Logistic Regression 
<img width="709" alt="Screenshot 2024-04-07 at 9 41 15 AM" src="https://github.com/lex910/Covid-Deaths-by-Region-and-Developing-Countiries/assets/101606445/d4d10b74-14cc-4039-b091-f30e59782fac">
<img width="733" alt="Screenshot 2024-04-07 at 9 41 27 AM" src="https://github.com/lex910/Covid-Deaths-by-Region-and-Developing-Countiries/assets/101606445/e3016ba0-5881-4e94-9ca5-b891b41c85f9">

<img width="795" alt="Screenshot 2024-04-07 at 9 41 38 AM" src="https://github.com/lex910/Covid-Deaths-by-Region-and-Developing-Countiries/assets/101606445/a8dacce9-3ea5-42d9-a6e1-8fe6a13bfc79">

Above, a logistic regression model is created using a log likelihood ratio for prediction. The estimated parameter shows that the estimated log odds ratio of being classified as developing with a one unit change in death rate is 0.961. The graph shows that as death rate percentage increases, the more likely the country will be classified as developing.

## Sensitivity Analysis 
We will check to see if the assumptions of two way ANOVA are met. Our assumptions for two-way ANOVA are that all subjects are randomly sampled and independent, all levels of factor A and factor B are independent, and the errors are normally distributed.

<img width="778" alt="Screenshot 2024-04-07 at 9 42 15 AM" src="https://github.com/lex910/Covid-Deaths-by-Region-and-Developing-Countiries/assets/101606445/4cc1ac86-b82b-42ad-9703-3467b1d81653">

The Normal QQ plot illustrates that the assumption of normally distributes error terms as the points are close to creating a linear relationship. The varience of the residuals versus fitted values should be randomly distributed to show equal varience. There appears to be a slight pattern so we will run a Levene test for homogeneity to check our assumption

<img width="730" alt="Screenshot 2024-04-07 at 9 42 42 AM" src="https://github.com/lex910/Covid-Deaths-by-Region-and-Developing-Countiries/assets/101606445/769f4f29-1e60-405e-addb-92fc4aa84b96">

The Levene Test shows a low p-value so we can conclude that there is no homoscedesity in the population, population variances are approximately equal by group. Our assumptions of the ANOVA model have been met.

## Conclusion/Discussion
After performing our data analysis, we can conclude that both classification and region have an effect on death rate percentage due to the COVID 19 pandemic for countries with small populations. When performing descriptive analysis it was apparent that developing countries tended to have an average mean death rate greater than developed countries. Similarly, it was illustrated that the regions of Africa and Europe also had the highest death rate percentage. By fitting a two way ANOVA model we concluded to use the reduced model because the interaction term was not significant when performing our hypothesis test. After carrying out an F test, we concluded that both factor effects were significant to include in the model. Next, we saw that there was a significant difference in developed and developing countries mean death rate by creating family confidence intervals. Additionally there was a significant difference between death rate in Western Pacific-Africa and the Western Pacific-Europe. Finding the means between each factor level showed that the lowest death rate for developed countries in the Western Pacific and the highest death rate is for developing countries in Europe with Africa close behind. When fitting the logistic regression model, we could see that as death rate increased, the higher the probability of the country being classified as developing got. Sensitivity analysis showed that the data met the assumptions of the ANOVA model.

Being a developing country led to higher death rates potentially due to the fact that lower economic stability may lead to less access to vaccines as well as less access to proper medical care. Another thing to consider is that the original World Health Organization Data Set had missing values for smaller countries which we had to eliminate from our dataset. Having a full dataset may lead to different mean values.

To improve the results of the data analysis, we could compare my results of the lower populated countries to the higher population countries and see if the results hold true for the entire population of countries. Additionally, removing outliers could change the outcome of the data. This project did not remove any outliers since there were no outliers that were skewing the data drastically. since the outliers were seen in the developing countries, removing them might decrease the mean significantly closer to that of developed countries. Similarly, the outliers were mainly seen in Europe so removing them could again bring down the mean in that specific region.

To expand the project, clustering may be a useful classification tool to determine if clustering by kmeans and k nearest neighbors results in similar patterns as if we were to classify the points into developed and developing.

## References

U.S. and World Population Clock. United States Census Bureau. (n.d.). Retrieved February 28, 2022, https://www.census.gov/popclock/world

World Health Organization. (n.d.). Who coronavirus (COVID-19) dashboard. World Health Organization. Retrieved February 28, 2022, https://covid19.who.int/

Zhenmin, L., Barcena, A., Grynspan, R., Alisjahbana, A. S., Songwe, V., Dashti, R., & Algayerova, O. (2022, January 13). World Economic Situation and Prospects 2022. Retrieved February 20, 2022, https://www.un.org/development/desa/dpad/wp-content/uploads/sites/45/publication/WESP2022_web.pdf





