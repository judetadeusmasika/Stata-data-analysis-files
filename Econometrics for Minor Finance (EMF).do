* Load the EMF data into the stata program

use "C:\Users\Baha\Downloads\EMF_Data.dta", clear

* Inspect the leaded data

describe

summarize, detail

* Filter the data for Russia and India, and ensure the sample period covers at least 5 years
gen country_filter = inlist(countryname, "Russia", "India")
* Keep only the filtered data
keep if country_filter == 1
* Ensure data spans a minimum of 5 years
bysort countryname (year): gen valid_years = year[_N] - year[1] + 1
keep if valid_years >= 5

save Russia_India_data.dta, replace

use "C:\Users\Baha\Downloads\Russia_India_data.dta", clear


** Question 1
* dependent variable - prop_female, this is in relation to the research question
* independent variables - tot_ass, ebit, net_sales, sector, gii, in_inv, dom, fgn, number_directors, employee, year and countryname

** Question 2
* Control variables - tot_ass, ebit, net_sales, tot_debt, sector, employee

** Question 3
* check for outliers, multicollinearity, and heteroskedasticity

* Summary statistics to identify extreme values
summ prop_female tot_ass ebit net_sales tot_debt employee gii in_inv dom fgn number_directors
* Detecting outliers using box plots for continuous variables
graph box prop_female tot_ass ebit net_sales tot_debt employee gii in_inv dom fgn number_directors

* Checking for Multicollinearity
* Run a correlation matrix for continuous independent variables
corr tot_ass ebit net_sales tot_debt employee gii in_inv dom fgn number_directors
* Variance Inflation Factor (VIF) to quantify multicollinearity
reg prop_female tot_ass ebit net_sales gii in_inv dom fgn number_directors employee
vif

*  Checking for Heteroskedasticity
* Run the main regression model
reg prop_female tot_ass ebit net_sales gii in_inv dom fgn number_directors employee
* Perform the Breusch-Pagan test
estat hettest
* Alternative: White's test for heteroskedasticity
estat imtest, white

** Question 4
* Transforming the variables to address the issue of heteroskedasticity
* List observations with missing values
* misstable summarize prop_female tot_ass ebit net_sales gii in_inv fgn number_directors employee year sector countryname
* Drop observations with missing values
* drop if missing(prop_female, tot_ass, ebit, net_sales, gii, in_inv, fgn, number_directors, employee, year, sector, countryname)

* scale-transforming
gen scaled_employee = employee/1000
gen scaled_totass = tot_ass/1000
gen scaled_ebit = ebit/1000
gen scaled_netsales = net_sales/1000
gen scaled_totdebt = tot_debt/1000
gen scaled_numdirectors = number_directors/1000

reg prop_female scaled_totass scaled_employee scaled_ebit scaled_netsales scaled_totdebt gii in_inv fgn scaled_numdirectors
estat hettest     
* at a significance level of 0.01, the assumption of constant variance is met

** Question 5
* The summary statistics
* use esttab for a formatted table
*estpost summarize prop_female tot_ass ebit net_sales gii in_inv fgn number_directors employee
*esttab using summary_statistics.txt, replace
summ prop_female tot_ass ebit net_sales gii in_inv fgn number_directors employee year

* The correlation matrix
* Generate a correlation matrix
pwcorr prop_female tot_ass ebit net_sales gii in_inv fgn number_directors employee

* Relevant Graphs and Figures
* Boxplot of proportion of female directors by country
graph box prop_female, over(countryname) title("Proportion of Female Directors by Country")

* Scatter Plots
* To check the relationship between the dependent variable and key independent variables
* Scatter plot: Proportion of female directors vs total assets
// scatter prop_female tot_ass, title("Proportion of Female Directors vs Total Assets") ///
//     xlabel(, angle(0)) ylabel(, angle(0)) ///
//     xtitle("Total Assets") ytitle("Proportion Female Directors")

* Scatter plot: Proportion of female directors vs Gender Inequality Index
// scatter prop_female gii, title("Proportion of Female Directors vs Total Assets") ///
//     xlabel(, angle(0)) ylabel(, angle(0)) ///
//     xtitle("Gender Inequality Index") ytitle("Proportion Female Directors")

* Trend graph
* Line graph for trends in proportion of female directors over time by country
twoway (line prop_female year if countryname=="Russia", sort lcolor(blue)) ///
       (line prop_female year if countryname=="India", sort lcolor(red)), ///
       title("Trends in Board Gender Diversity") xlabel(2008(1)2017) ylabel(0(0.1)1) legend(label(1 "Russia") label(2 "India")) ///
	   ytitle("Proportion of Female Directors") ///
	   xtitle("Year")

* Line plot of gii over time by countryname
twoway (line gii year if countryname == "Russia", lcolor(blue) lpattern(dash)) ///
       (line gii year if countryname == "India", lcolor(red) lpattern(dash)), ///
       title("Gender Inequality Index Over Time") ///
       xlabel(2008(1)2017) ylabel(0(0.1)1) ///
       legend(label(1 "Russia - GII") ///
              label(2 "India - GII")) ///
       ytitle("Gender Inequality Index") ///
       xtitle("Year")

* Question 5 a)
** Is there a relationship between board gender diversity and financial performance?
* Declare the panel data structure
xtset dscd year
* Panel regression with firm fixed effects for EBIT
xtreg ebit prop_female tot_ass gii in_inv fgn number_directors employee, fe robust

** Are there any differences between the two countries (Russia and India) for the relationships observed between  /// 
* board gender diversity and financial performance?

* Create a country dummy variable: 1 for Russia, 2 for India
gen country_dummy = .
replace country_dummy = 1 if countryname == "Russia"
replace country_dummy = 2 if countryname == "India"
* Create interaction term between country_dummy and prop_female
gen prop_female_russia = country_dummy == 1 & prop_female
gen prop_female_india = country_dummy == 2 & prop_female
* Run the regression model
xtreg ebit prop_female_india prop_female_russia prop_female tot_ass gii in_inv fgn number_directors employee, fe robust
