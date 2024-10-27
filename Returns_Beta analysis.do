
*** Import the dataset into the program

import excel "C:\Users\Baha\OneDrive\Desktop\RETURN.xlsx", sheet("Sheet 1") firstrow

*** describe the dataset to preview the variables present

describe, detail

*** Part I :  Explaining a panel of Stock Returns 
* use Sheet RETURN

** 1a) Generate Excess Returns (EXC_RET) and Scale VIX

gen EXC_RET = RET - RF

* Calculate mean and standard deviation of VIX
sum VIX

* Generate VIX_S
gen VIX_S = (VIX - r(mean)) / r(sd)

** Estimate three different pooled regression models with 𝑬𝑿𝑪_𝑹𝑬𝑻 as dependent variable

* Model 1: Fama-French 5 Factor Model

regress EXC_RET MktRF HML SMB RMW CMA

* Model 2: Including ln(Volume)

gen lnVOLUME = ln(VOLUME)
regress EXC_RET MktRF HML SMB RMW CMA lnVOLUME

* Model 3: Including VIX_S, Unemployment, and Inflation

regress EXC_RET MktRF HML SMB RMW CMA lnVOLUME VIX_S Unemp Inflation

** Presenting the results in a table
ssc install outreg2
* Model 1: Fama French factors
regress EXC_RET MktRF HML SMB RMW CMA
eststo Model1
* Model 2: Fama French factors + lnVOLUME
regress EXC_RET MktRF HML SMB RMW CMA lnVOLUME
eststo Model2
* Model 3: Fama French factors + lnVOLUME + VIX_S, Unemp, Inflation
regress EXC_RET MktRF HML SMB RMW CMA lnVOLUME VIX_S Unemp Inflation
eststo Model3

* Create Table 1 without the F-statistic
esttab Model1 Model2 Model3 using Table1.doc, replace ///
    title("Table 1: Regression Results for Excess Returns") ///
    b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
    r2 ar2 ///
    label nonumber nodepvars


* Run models and output results to Table 1
*outreg2 using Table1.doc, replace ctitle(Model 2) tex
*regress EXC_RET MktRF HML SMB RMW CMA
*outreg2 using Table1.doc, append ctitle(Model 3)
*regress EXC_RET MktRF HML SMB RMW CMA lnVOLUME
*outreg2 using Table1.doc, append ctitle(Model 1)
*regress EXC_RET MktRF HML SMB RMW CMA lnVOLUME VIX_S Unemp Inflation

*** 1b) Use the White test to test on heteroskedasticity within Model 3
** Perform the White Test
* Estimate Model 3
regress EXC_RET MktRF HML SMB RMW CMA lnVOLUME VIX_S Unemp Inflation
* Obtain residuals from Model 3
predict residuals, residuals
* Create squared residuals
gen residuals_sq = residuals^2
*Create Squared and Interaction Terms for the Auxiliary Regression
* Generate ln(RVOL)
gen lnRVOL = ln(RVOL)
* Generate squared terms
gen MktRF_sq = MktRF^2
gen HML_sq = HML^2
gen SMB_sq = SMB^2
gen RMW_sq = RMW^2
gen CMA_sq = CMA^2
gen lnVOLUME_sq = lnVOLUME^2
gen lnRVOL_sq = lnRVOL^2
*Run the Auxiliary Regression
regress residuals_sq MktRF_sq HML_sq SMB_sq RMW_sq CMA_sq lnVOLUME lnRVOL
* Output the Auxiliary Regression Results into Table 2
* Run the auxiliary regression and output to Table 2
* Run the auxiliary regression for White test
regress residuals_sq MktRF_sq HML_sq SMB_sq RMW_sq CMA_sq lnVOLUME lnRVOL
eststo AuxReg
* Output the results to Table 2 using esttab
esttab AuxReg using Table2.doc, replace ///
    title("Table 2: Auxiliary Regression for White Test") ///
    b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
	r2 ar2 ///
    label nonumber nodepvars ///
    addnote("Theoretical model: (Residuals)^2 = Beta0 + Beta1*(MktRF)^2 + Beta2*(HML)^2 + Beta3*(SMB)^2 + Beta4*(RMW)^2 + Beta5*(CMA)^2 + Beta6*ln(Volume) + Beta7*ln(RVol) + ε")

*regress residuals_sq MktRF_sq HML_sq SMB_sq RMW_sq CMA_sq lnVOLUME lnRVOL
*outreg2 using Table2.doc, replace ctitle(Auxiliary Regression for White Test) ///
    *addnote("Theoretical model: (Residuals)^2 = Beta0 + Beta1*(MktRF)^2 + Beta2*(HML)^2 + Beta3*(SMB)^2 + Beta4*(RMW)^2 + Beta5*(CMA)^2 + Beta6*ln(Volume) + Beta7*ln(RVol) + ε")

*** 1c) Re-estimating Model 3 with Clustered Standard Errors

* RRe-estimate Model 3 with Clustered Standard Errors on Firm
regress EXC_RET MktRF HML SMB RMW CMA lnVOLUME VIX_S Unemp Inflation, vce(cluster IDCODE)

* Re-estimate Model 3 with Clustered Standard Errors on Time
regress EXC_RET MktRF HML SMB RMW CMA lnVOLUME VIX_S Unemp Inflation, vce(cluster time)

* the table 3
* Model 3 Standard
regress EXC_RET MktRF HML SMB RMW CMA lnVOLUME VIX_S Unemp Inflation
eststo Model3_Standard
* Model 3 Clustered by Firm
regress EXC_RET MktRF HML SMB RMW CMA lnVOLUME VIX_S Unemp Inflation, vce(cluster IDCODE)
eststo Model3_Clustered_Firm
* Model 3 Clustered by Time
regress EXC_RET MktRF HML SMB RMW CMA lnVOLUME VIX_S Unemp Inflation, vce(cluster time)
eststo Model3_Clustered_Time

* Output Table 3 using esttab
esttab Model3_Standard Model3_Clustered_Firm Model3_Clustered_Time using Table3.doc, replace ///
    title("Table 3: Regression Results for Excess Returns (Model 3)") ///
    b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
    r2 ar2 ///
    label nonumber nodepvars ///
    varlabels(MktRF "Market Return" HML "High-Minus-Low" SMB "Small-Minus-Big" ///
    RMW "Profitability" CMA "Investment" lnVOLUME "ln(Volume)" VIX_S "VIX_S" Unemp "Unemployment" Inflation "Inflation")

* Export Model 3 (Standard) results
*regress EXC_RET MktRF HML SMB RMW CMA lnVOLUME VIX_S Unemp Inflation
*outreg2 using Table3.doc, replace ctitle(Model 3 Standard) keep(MktRF HML SMB RMW CMA lnVOLUME VIX_S Unemp Inflation)
* Export Model 3 (Clustered by Firm)
*regress EXC_RET MktRF HML SMB RMW CMA lnVOLUME VIX_S Unemp Inflation, vce(cluster IDCODE)
*outreg2 using Table3.doc, append ctitle(Model 3 Clustered by Firm) keep(MktRF HML SMB RMW CMA lnVOLUME VIX_S Unemp Inflation)
* Export Model 3 (Clustered by Time)
*regress EXC_RET MktRF HML SMB RMW CMA lnVOLUME VIX_S Unemp Inflation, vce(cluster time)
*outreg2 using Table3.doc, append ctitle(Model 3 Clustered by Time) keep(MktRF HML SMB RMW CMA lnVOLUME VIX_S Unemp Inflation)

*** Part II Explaining Crisis periods 

** 2a) Create the Binary Indicator CRISIS
* Calculate the 90th percentile of RVOL
centile RVOL, centile(90)
* Create CRISIS indicator based on 90th percentile
gen CRISIS = (RVOL > r(c_1))

* Estimate Logit and Probit Models
* Logit model
logit CRISIS VIX_S lnVOLUME

* Probit model
probit CRISIS VIX_S lnVOLUME

* create table 4
* Run Logit model
logit CRISIS VIX_S lnVOLUME
eststo Logit_Model
* Run Probit model
probit CRISIS VIX_S lnVOLUME
eststo Probit_Model
* Output Table 4 using esttab
esttab Logit_Model Probit_Model using Table4.doc, replace ///
    title("Table 4: Logit and Probit Model Results for Crisis Periods") ///
    b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
    label nonumber nodepvars ///
    varlabels(VIX_S "VIX (Scaled)" lnVOLUME "ln(Volume)")
* Add Pseudo R-squared manually
di "Pseudo R-squared (Logit): " e(r2_p) 
di "Pseudo R-squared (Probit): " e(r2_p)

* Export Logit model results
*logit CRISIS VIX_S lnVOLUME
*outreg2 using Table4.doc, replace ctitle(Logit Model) keep(VIX_S lnVOLUME) addstat(Pseudo R-squared, e(r2_p))
* Export Probit model results
*probit CRISIS VIX_S lnVOLUME
*outreg2 using Table4.doc, append ctitle(Probit Model) keep(VIX_S lnVOLUME) addstat(Pseudo R-squared, e(r2_p))

** Estimate Marginal Effects for Logit and Probit Models
* Logit model
logit CRISIS VIX_S lnVOLUME
* Compute marginal effects at the mean for Logit
margins, dydx(VIX_S lnVOLUME) atmeans
* Save Logit marginal effects
eststo LogitME

* Probit model
probit CRISIS VIX_S lnVOLUME
* Compute marginal effects at the mean for Probit
margins, dydx(VIX_S lnVOLUME) atmeans
* Save Probit marginal effects
eststo ProbitME

* Create Table 5 with marginal effects
esttab LogitME ProbitME using Table5.doc, replace ///
    title(Marginal Effects at Mean for Logit and Probit Models) ///
    b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
    label varwidth(20) ///
    nonumber nodepvars

*** 2c) New logit and probit models
* Filter data for the years 1986 to 2008
gen in_sample = (StataYear >= 1986 & StataYear <= 2008)
* Estimate the Logit model
logit CRISIS VIX_S lnVOLUME if in_sample
* Predict probabilities
predict CRISIS_Pro if in_sample
* Store AUROC value
roctab CRISIS CRISIS_Pro

* Run the new Logit model
logit CRISIS VIX_S lnVOLUME Unemp if in_sample
eststo New_Logit_Model
* If results are there, you can predict probabilities
predict prob_CRISIS if in_sample
*Construct the ROC Curve for the In-Sample Period (1986 - 2008)
* Generate ROC curve for the in-sample period
* Generate the ROC curve with a title
roctab CRISIS prob_CRISIS if in_sample, graph title("ROC Curve for In-Sample Period (1986-2008)")
graph export "ROC_Curve_In_Sample.png", replace

* Apply the Model to the Remaining Years (2009 - 2022)
* Filter data for the years 2009 to 2022
gen out_sample = (StataYear > 2008)
* Predict probabilities for the out-of-sample period
predict prob_CRISIS_out if out_sample

* Construct the ROC Curve for the Out-of-Sample Period (2009 - 2022)
* Generate ROC curve for the out-of-sample period
roctab CRISIS prob_CRISIS_out if out_sample, graph title("ROC Curve for Out-Sample Period (2008-2022)")
graph export "ROC_Curve_Out_Sample.png", replace


*** Part III Modeling beta 
* import the dataset for beta
import excel "C:\Users\Baha\OneDrive\Desktop\BETA.xlsx", sheet("Sheet1") firstrow clear
* create summary statistics
summarize
* check for missing values
misstable summarize
* Delete observations with missing values
drop if missing(BETA) | missing(StataMonth) | missing(StataYear)
* Create a time variable
gen time = _n
* Verify the data and summary statistics again
summarize
* Calculate summary statistics for BETA
summarize BETA

** 3b) Conducting the ADF test 
* Conduct the Augmented Dickey-Fuller test on BETA
tsset time
dfuller BETA, lags(1) trend
* Save the results for exporting
matrix results = r(table)

** 3c) Split the Data for In-Sample Period
local n = _N
local in_sample_obs = round(0.7 * `n')
* Create an in-sample dataset with the first 70% of observations
gen in_sample = _n <= `in_sample_obs'
* Estimate AR(2) model for the BETA variable
arima BETA if in_sample, ar(1/2)
* Estimate the ARMA(p,q) Model
* Check ACF and PACF for BETA to determine p and q
// Generate ACF and PACF data for BETA variable (in-sample)
ac BETA if in_sample
pac BETA if in_sample
* estimate the ARMA (3,5) model
arima BETA if in_sample, ar(1/3) ma(1/5)
// Estimate AR(2) model
arima BETA if in_sample, ar(1/2)
estimates store AR2_Model
// Estimate ARMA(3,5) model
arima BETA if in_sample, ar(1/3) ma(1/5)
estimates store ARMA_Model
// Export both models to Table 8
esttab AR2_Model ARMA_Model using Table8.doc, replace ///
    title("Table 8: Parameter Estimates for AR(2) and ARMA(3,5) Models") ///
    b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
    label nonumber nodepvars 
	
** 3d) check if model 1 is misspecified
// Fit the AR(2) model
arima BETA if in_sample, ar(1/2)
// Store residuals
predict residuals, residuals
// Perform the Ljung-Box test for autocorrelation in the residuals
wntestq residuals

** 3e) Forecasting
// Fit the AR(2) model
arima BETA if in_sample, ar(1/2)
// Fit the ARMA(3,5) model
arima BETA if in_sample, ar(1/3) ma(1/5)
// Generate one-step ahead forecasts for AR(2) model
predict forecast_AR2 if !in_sample
// Generate one-step ahead forecasts for ARMA model
predict forecast_ARMA if !in_sample
// Plot the actual BETA and the forecasts
twoway (line BETA StataYear, lcolor(black) lwidth(medium)) ///
       (line forecast_AR2 StataYear, lcolor(blue) lwidth(medium) lpattern(dash)) ///
       (line forecast_ARMA StataYear, lcolor(red) lwidth(medium) lpattern(dash)), ///
       title("One-Step Ahead Forecasts for BETA") ///
       ylabel(, angle(0)) ///
       xlabel(, valuelabel angle(45)) ///
       legend(label(1 "Actual BETA") label(2 "Forecast AR(2)") label(3 "Forecast ARMA")) ///
       ytitle("BETA") ///
       xtitle("Year") ///
       graphregion(color(white)) // Remove blue background color
	   
** 3f) tests for unbiasedness, accuracy and efficiency
// Generate forecast errors for AR(2)
gen error_AR2 = BETA - forecast_AR2
// Generate forecast errors for ARMA
gen error_ARMA = BETA - forecast_ARMA
// Calculate unbiasedness
summarize error_AR2
local mean_error_AR2 = r(mean)
summarize error_ARMA
local mean_error_ARMA = r(mean)

// Calculate MAE for both models
gen abs_error_AR2 = abs(error_AR2)
gen abs_error_ARMA = abs(error_ARMA)
summarize abs_error_AR2
local MAE_AR2 = r(mean)
summarize abs_error_ARMA
local MAE_ARMA = r(mean)

// Calculate MSE for both models
gen squared_error_AR2 = error_AR2^2
gen squared_error_ARMA = error_ARMA^2
summarize squared_error_AR2
local MSE_AR2 = r(mean)
summarize squared_error_ARMA
local MSE_ARMA = r(mean)
