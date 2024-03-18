
// Set path where Stata dataset will be stored
global datapath "C:\Users\Baha\Downloads\Economics"

// Change to the folder where you downloaded the CSV data
cd "C:\Users\Baha\Downloads\Economics"

// import csv of wage data into Stata
import delimited "C:\Users\Baha\Downloads\Economics\CES0500000003.csv", encoding(ISO-8859-2) clear
rename ces wage
label var wage "Average Hourly Earnings of All Employees, Total Private"
// save the dataset
compress
save "$datapath/wages", replace


// import csv of hires data into Stata
clear
import delimited "C:\Users\Baha\Downloads\Economics\JTSHIR.csv", encoding(ISO-8859-2) clear
rename jtshir hires
label var hires "Hires: Total Nonfarm"
// save the dataset
compress
save "$datapath/hires", replace

// import csv of separations data into Stata
clear
import delimited "C:\Users\Baha\Downloads\Economics\JTSTSR.csv", encoding(ISO-8859-2) clear
rename jtstsr separations
label var separations "Total Separations: Total Nonfarm"
// save the dataset
compress
save "$datapath/separations", replace


// merge the FRED data together
use "$datapath/wages", clear
merge 1:1 date using "$datapath/hires", nogen keep(match)
merge 1:1 date using "$datapath/separations", nogen keep(match)
// create turnover variable
g turnover = separations + hires
// create time indicator
g monthly_date = mofd(date(date,"YMD"))
format %tm monthly_date
sort monthly_date
// declare time series data
tsset monthly_date
// keep up to December 2023
keep if monthly_date <= ym(2023,12)
compress
save "$datapath/part1_timeseries", replace

//Load the merged dataset into Stata
use "C:\Users\Baha\Downloads\Economics\part1_timeseries.dta"

* Plot the time series for wages and turnover separately
tsset monthly_date
tsline wage, title("Time Series of Wages") ylabel(,angle(horizontal)) yaxis(1) 
graph export wages_ts.png, replace

tsline turnover, title("Time Series of Labour Turnover") ylabel(,angle(horizontal)) yaxis(1) 
graph export turnover_ts.png, replace

* Combine the time series for wages and turnover into one figure with two separate y-axes
twoway (tsline wage, yaxis(1) title("Time Series of Wages")) ///
       (tsline turnover, yaxis(2) title("Time Series of Labour Turnover")), ///
       legend(order(1 "Wages" 2 "Turnover")) ytitle("Wages" "Turnover", axis(1)) ///
       ytitle("Turnover", axis(2)) xtitle("Date") 
graph export combined_ts.png, replace

* Trend test for wages
regress wage monthly_date
test monthly_date

* Plot the trend in wages
scatter trend_wage wage, title("Trend in Wages") ytitle("Wage")

* Plot the trend in turnover
scatter trend_turnover turnover, title("Trend in Turnover") ytitle("Turnover")

* Set the time variable
tsset monthly_date

* Perform the Augmented Dickey-Fuller (ADF) test for wages
dfuller wage

* Perform the Augmented Dickey-Fuller (ADF) test for turnover
dfuller turnover

* If necessary, transform the variables to achieve stationarity
gen diff_wage = D.wage

* Perform the Augmented Dickey-Fuller (ADF) test for wages
dfuller D.wage

* Build the forecasting model for wages
reg wage L.wage L.turnover

* Display regression results
di "Regression results:"
summarize wage L.wage L.turnover

* Set the time variable
tsset monthly_date

* Estimate models with different lag lengths
reg wage L(1/5).wage L(1/5).turnover

* Display model summary statistics
estat ic

ssc install outreg2

* Estimate models with different lag lengths for wages
reg wage L1.wage L1.turnover

outreg2 using regression_results1.doc, replace

reg wage L2.wage L2.turnover

outreg2 using regression_results2.doc, replace

reg wage L3.wage L3.turnover
outreg2 using regression_results3.doc, replace

reg wage L4.wage L4.turnover
outreg2 using regression_results4.doc, replace

reg wage L5.wage L5.turnover
outreg2 using regression_results5.doc, replace



* Set the time variable
tsset monthly_date

* Estimate models with different lag lengths for wages (using data for parameter estimation up to 2022)
reg wage L1.wage L1.turnover if year(dofm(monthly_date)) < 2023
reg wage L2.wage L2.turnover if year(dofm(monthly_date)) < 2023
reg wage L3.wage L3.turnover if year(dofm(monthly_date)) < 2023
reg wage L4.wage L4.turnover if year(dofm(monthly_date)) < 2023
reg wage L5.wage L5.turnover if year(dofm(monthly_date)) < 2023

* Generate one-step-ahead forecasts for 2023
predict f
generate e = wage - f if year(dofm(monthly_date)) == 2023

* Calculate RMSE
summarize e
scalar rmse = sqrt(r(sum_sq) / r(N))

di "RMSE: " scalar(rmse)

* Calculate MAE
summarize e
scalar mae = r(sum) / r(N)

* Point forecast for January 2024
predict wage_forecast


* Load the dataset
use "C:\Users\Baha\Downloads\part2_panel.dta", clear

* Calculate descriptive statistics
summarize hours wage age edu_lessthanhs edu_somecollege edu_college edu_more edu_hs married edaycare

describe

* Run regression without controls
regress hours wage
outreg2 using regression.doc, replace


* Run regression with controls
regress hours wage age edu_lessthanhs edu_somecollege edu_college edu_more edu_hs married edaycare
outreg2 using regression1.doc, replace
* Interpret the results


* Check for serial correlation in the error term
xtregar hours wage age edu_lessthanhs edu_somecollege edu_college edu_more edu_hs married edaycare, fe

* Estimate labor supply elasticities using first differences and fixed effects
xtreg D.hours D.wage age edu_lessthanhs edu_hs married edu_somecollege edu_college edu_more edaycare, fe

* Compare the estimates to POLS results

regress hours wage age edu_lessthanhs edu_somecollege edu_college edu_more edu_hs married edaycare

* Discuss differences in estimates and potential reasons
