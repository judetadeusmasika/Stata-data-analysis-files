* import the dataset

import excel "C:\Users\Baha\OneDrive\Desktop\House prices.xlsx", sheet("Sheet1") firstrow

*Convert the imported dataset into a .dta file

save "C:\Users\Baha\OneDrive\Desktop\HousePrices.dta", replace

* I first fitted the linear regression model 

regress SalePrice LotArea OverallQual OverallCond YearBuilt YearRemodAdd ///
    BsmtFinSF1 BsmtUnfSF TotalBsmtSF GrLivArea ///
    FullBath HalfBath BedroomAbvGr TotRmsAbvGrd Fireplaces GarageCars ///
    GarageArea WoodDeckSF OpenPorchSF EnclosedPorch ///
    i.BsmtQual i.Blmngtn i.Blueste i.BrDale i.BrkSide i.ClearCr ///
    i.CollgCr i.Crawfor i.Edwards i.Gilbert i.IDOTRR i.MeadowV i.Mitchel ///
    i.Names i.NoRidge i.NPkVill i.NriddgHt i.NWAmes i.OLDTown i.SWISU ///
    i.Sawyer i.SawyerW i.Somerst i.StoneBr i.Timber i.Veenker
	
* Fit an alternative model
* I fitted a generalized linear model with a gamma ditribution

glm SalePrice LotArea OverallQual OverallCond YearBuilt YearRemodAdd ///
    BsmtFinSF1 BsmtUnfSF TotalBsmtSF GrLivArea ///
    FullBath HalfBath BedroomAbvGr TotRmsAbvGrd Fireplaces GarageCars ///
    GarageArea WoodDeckSF OpenPorchSF EnclosedPorch ///
    i.BsmtQual i.Blmngtn i.Blueste i.BrDale i.BrkSide i.ClearCr ///
    i.CollgCr i.Crawfor i.Edwards i.Gilbert i.IDOTRR i.MeadowV i.Mitchel ///
    i.Names i.NoRidge i.NPkVill i.NriddgHt i.NWAmes i.OLDTown i.SWISU ///
    i.Sawyer i.SawyerW i.Somerst i.StoneBr i.Timber i.Veenker, family(gamma)


* demonstration of my linear model relative to generalized linear model
*Assess the fit of the linear model

estat ic

* comparing the predictions
* predictions from the linear regression model

predict pred_linear, xb

* predictions from  the generalized linear model

predict pred_glm, xb

* Calculate Mean Squared Error for the linear regression model
gen mse_Linear = (SalePrice - pred_linear)^2 / _N

* Calculate Mean Squared Error for the generalized linear  model
gen mse_GLM = (SalePrice - pred_glm)^2 / _N

summarize mse_Linear
scalar mse_Linear_mean = r(mse_Linear)

summarize mse_GLM
scalar mse_glm_mean = r(mse_GLM)

*Compare the results from the linear model and the generalized linear model
* Display comparison results
di "MSE Linear Regression: " mse_Linear
di "MSE glm Model: " mse_GLM

* perform statistical tests, most preferrably t-test, to assess whether 
* the difference in the performance of the two models is statistically significant

ttest mse_Linear == mse_GLM

* analysis on the house characteristics

* calculate the residuals

gen residuals = SalePrice - pred_linear

summarize residuals

* performing a regression analysis of residuals against various house characteristics
reg residuals LotArea OverallQual OverallCond YearBuilt YearRemodAdd ///
    BsmtFinSF1 BsmtUnfSF TotalBsmtSF GrLivArea ///
    FullBath HalfBath BedroomAbvGr TotRmsAbvGrd Fireplaces GarageCars ///
    GarageArea WoodDeckSF OpenPorchSF EnclosedPorch ///
    i.BsmtQual i.Blmngtn i.Blueste i.BrDale i.BrkSide i.ClearCr ///
    i.CollgCr i.Crawfor i.Edwards i.Gilbert i.IDOTRR i.MeadowV i.Mitchel ///
    i.Names i.NoRidge i.NPkVill i.NriddgHt i.NWAmes i.OLDTown i.SWISU ///
    i.Sawyer i.SawyerW i.Somerst i.StoneBr i.Timber i.Veenker

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

* evaluate the significance levels of the house characteristics

test LotArea = 0
test OverallQual = 0
test OverallCond = 0
test YearBuilt = 0
test TotRmsAbvGrd = 0
test GarageArea = 0


*Comparing the performance of my linear model with and without specific
* house characteristics to see the impact on SalePrice.

reg residuals pred_linear

* performing the disgnostic tests of my linear model

hettest

* interpretation of the results.



