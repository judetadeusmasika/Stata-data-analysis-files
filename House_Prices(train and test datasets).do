* import the dataset

import excel "C:\Users\Baha\Downloads\House_Price_Data-1.xlsx", sheet("Sheet1") firstrow

* splitting the dataset (30% train data and 70% test data)

set seed 12345

sort SalePrice

* Create a variable indicating the percentage of the dataset for the training set
egen train_percent = seq(), from(1) to(100)
* Keep only the observations corresponding to the desired percentage for the training set
keep if train_percent <= 30

* Save the training set
save "C:\Users\Baha\Downloads\train_dataset.dta", replace

* Use the remaining data as the test set
use "C:\Users\Baha\Downloads\House_Prices.dta", clear
egen train_percent = seq(), from(1) to(100)
drop train_percent

* Save the test set
save "C:\Users\Baha\Downloads\test_dataset.dta", replace

* Load the training dataset
use "C:\Users\Baha\Downloads\train_dataset.dta", clear
* First, the linear regression model was fitted because it shows the 
* relationship between the Saleprice and house characteristics in a more clear way
* The house characterisics have a relationship with the SalePrice of the house
* which can be determined by the linear regression  model.

regress SalePrice LotArea OverallQual OverallCond YearBuilt YearRemodAdd ///
    BsmtFinSF1 BsmtUnfSF TotalBsmtSF GrLivArea ///
    FullBath HalfBath BedroomAbvGr TotRmsAbvGrd Fireplaces GarageCars ///
    GarageArea WoodDeckSF OpenPorchSF EnclosedPorch ///
    BsmtQual Blmngtn Blueste BrDale BrkSide ClearCr ///
    CollgCr Crawfor Edwards Gilbert IDOTRR MeadowV Mitchel ///
    Names NoRidge NPkVill NriddgHt NWAmes OLDTown SWISU ///
    Sawyer SawyerW Somerst StoneBr Timber Veenker
	
* Fit an alternative model
* Ordinary Least Squares model,  a technique of estimating linear relations 
* between a dependent variable on one hand, and a set of explanatory variables 
* on the other. It also looks for the relationship among the variables and 
* how they influence each other. It is a preferrably alternative model to be used

reg SalePrice LotArea OverallQual OverallCond YearBuilt YearRemodAdd ///
    BsmtFinSF1 BsmtUnfSF TotalBsmtSF GrLivArea ///
    FullBath HalfBath BedroomAbvGr TotRmsAbvGrd Fireplaces GarageCars ///
    GarageArea WoodDeckSF OpenPorchSF EnclosedPorch ///
    BsmtQual Blmngtn Blueste BrDale BrkSide ClearCr ///
    CollgCr Crawfor Edwards Gilbert IDOTRR MeadowV Mitchel ///
    Names NoRidge NPkVill NriddgHt NWAmes OLDTown SWISU ///
    Sawyer SawyerW Somerst StoneBr Timber Veenker


* demonstration of my linear model relative to an Ordinary Least Squares model
*Assess the fit of the linear model

estat ic

* comparing the predictions
* Load the test dataset
use "C:\Users\Baha\Downloads\test_dataset.dta", clear

* Predict SalePrice using the multiple regression model
predict pred_SalePrice, xb

* Display the predicted values
list SalePrice pred_SalePrice

* Predict SalePrice using the OLS model
predict predicted_SalePrice

* Display the predicted values
list SalePrice predicted_SalePrice

* Calculate Mean Squared Error for the linear regression model
gen mse_Linear = (SalePrice - pred_SalePrice)^2 / _N

* Calculate Mean Squared Error for the OLS  model
gen mse_OLS = (SalePrice - predicted_SalePrice)^2 / _N

summarize mse_Linear
scalar mse_Linear_mean = r(mse_Linear)

summarize mse_OLS
scalar mse_OLS_mean = r(mse_OLS)

*Compare the results from the linear model and the OLS model
* Display comparison results
di "MSE Linear Regression: " mse_Linear
di "MSE OLS Model: " mse_OLS

* perform statistical tests, most preferrably t-test, to assess whether 
* the difference in the performance of the two models is statistically significant
* t-test will do best for this because we are performing a statistical test comparing
* the performance of two models. For comparison, the t-test will do.

ttest mse_Linear == mse_OLS

* the mean difference between the two models is zero, hence at 5% level of 
* significance, the null hypothesis is not rejected.


* analysis on the house characteristics

* calculate the residuals

gen residuals = SalePrice - pred_SalePrice

summarize residuals

* performing a regression analysis of residuals against 
* various house characteristics to determine which house characteristcs influences
* SalePrice of a house and which characteristics do not.

reg residuals LotArea OverallQual OverallCond YearBuilt YearRemodAdd ///
    BsmtFinSF1 BsmtUnfSF TotalBsmtSF GrLivArea ///
    FullBath HalfBath BedroomAbvGr TotRmsAbvGrd Fireplaces GarageCars ///
    GarageArea WoodDeckSF OpenPorchSF EnclosedPorch ///
    BsmtQual Blmngtn Blueste BrDale BrkSide ClearCr ///
    CollgCr Crawfor Edwards Gilbert IDOTRR MeadowV Mitchel ///
    Names NoRidge NPkVill NriddgHt NWAmes OLDTown SWISU ///
    Sawyer SawyerW Somerst StoneBr Timber Veenker

* creating scatterplots to illustrate the relationship between various house
* characteristics and the residuals

scatter residuals YearBuilt 
scatter residuals OverallQual
scatter residuals TotRmsAbvGrd
scatter residuals GarageArea
scatter residuals OverallCond
scatter residuals Fireplaces

* performing sub group analysis

bysort BsmtQual: summarize residuals
bysort OverallQual: summarize residuals

* evaluate the significance levels of the house characteristics to check for 
* those house characteristics that significantly influence house prices and
* those that do not significantly influence house prices

test LotArea = 0
test OverallQual = 0
test OverallCond = 0
test YearBuilt = 0
test TotRmsAbvGrd = 0
test GarageArea = 0

*Comparing the performance of my linear model with and without specific
* house characteristics to see the impact on SalePrice.

reg residuals pred_SalePrice

* performing the disgnostic tests of my linear model

hettest

* interpretation of the results.



