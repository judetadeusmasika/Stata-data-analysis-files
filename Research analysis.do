
*Load the dataset

use "C:\Users\Baha\Downloads\Compressed\data_sets_3\Datasets\States.dta", clear

describe

*descriptive statistics of the dependent and independent variables

summarize hh_income, detail

summarize hh_income  

summarize urban, detail

summarize urban

* Generate a histogram of your dependent variable (household income disparities)

histogram hh_income, title("Distribution of household Income Disparities") ///
xtitle("Income Disparities") ytitle(Frequency) ///
note("Assess whether the distribution is symmetric or skewed") ///
bin(7) normal


histogram hh_income, title("Distribution of household Income Disparities") ///
xtitle("Income Disparities") ytitle(Frequency) ///
bin(7) normal

* Generate a mean comparison table
table urban, c(mean hh_income)

* Generate a scatterplot to visualize the relationship
scatter hh_income urban, title("Scatterplot of Household Income vs. Population Density") ///
xtitle("Population Density") ytitle("Household Income") ///
note(" To assess the relationship between variables")

* Perform a multiple regression analysis
regress hh_income urban unemployment

* Create a scatterplot matrix
graph matrix hh_income urban unemployment, title("Scatterplot Matrix")

*perform a bivariate regression analysis

regress hh_income urban

*perform a multivariate regression analysis

regress hh_income urban unemployment govt_worker ba_or_more hs_or_more adv_or_more
