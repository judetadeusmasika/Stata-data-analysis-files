
*Load the dataset to be used for analysis

use "C:\Users\Baha\Downloads\roshan_978-attachments\occ-balance-sheets_dta (1)\occ-balance-sheets.dta", clear

describe

* Calculate Equity to Asset Ratio
gen equity_asset_ratio = (capital + surplus_fund + undivided_profits) / assets

* Calculate Deposit to Asset Ratio
gen deposit_asset_ratio = deposits / assets

* Calculate Wholesale Funding to Asset Ratio
gen wholesale_funding_asset_ratio = (notes_nb + notes_sb + rediscounts) / assets

* Sort data by bank_id and year
sort bank_id year
* Calculate Nominal Asset Growth
by bank_id: gen asset_growth = ((assets - assets[_n-1]) / assets[_n-1]) * 100 if _n > 1

* Calculate Undivided Profits to Equity Ratio
gen undivided_profit_equity_ratio = undivided_profits / (capital + surplus_fund)

* Summarize the ratios
sum equity_asset_ratio deposit_asset_ratio wholesale_funding_asset_ratio asset_growth undivided_profit_equity_ratio, detail
* Export summary statistics to a table
export excel using "C:\Users\Baha\OneDrive\Desktop\Stata\Do files\summary_statistics.xlsx",replace


* QUESTION 3

* Sort data by bank_id and year
sort bank_id year

* Identify the year of failure for each bank
gen failure_year = cond(is_rec == 1, year, .)

* Calculate the cumulative change in ratios for each bank over the 10-year period
gen change_equity_asset = equity_asset_ratio - equity_asset_ratio[_n-1] if _n > 1 & _n <= 11
gen change_deposit_asset = deposit_asset_ratio - deposit_asset_ratio[_n-1] if _n > 1 & _n <= 11
gen change_wholesale_funding_asset = wholesale_funding_asset_ratio - wholesale_funding_asset_ratio[_n-1] if _n > 1 & _n <= 11
gen change_asset_growth = asset_growth - asset_growth[_n-1] if _n > 1 & _n <= 11

* Calculate the mean change across all banks for each horizon
collapse (mean) change_equity_asset change_deposit_asset change_wholesale_funding_asset change_asset_growth, by(year)

* Generate the plot
twoway (line change_equity_asset year) (line change_deposit_asset year) (line change_wholesale_funding_asset year) (line change_asset_growth year), ///
    title("Mean Change in Bank Ratios Before Failure") ///
    ytitle("Mean Change") xtitle("Years Before Failure") ///
    legend(label(1 "Equity to Asset Ratio") label(2 "Deposit to Asset Ratio") label(3 "Wholesale Funding to Asset Ratio") label(4 "Asset Growth"))
	

use "C:\Users\Baha\Downloads\roshan_978-attachments\occ-balance-sheets_dta (1)\occ-balance-sheets.dta", clear
	
*QUESTION 4

* Create a variable to identify banks that do not fail over the next 10 years
gen surviving = 1 - is_rec

* Calculate the same ratios for both failing and surviving banks
gen equity_asset_ratio = (capital + surplus_fund + undivided_profits) / assets
gen deposit_asset_ratio = deposits / assets
gen wholesale_funding_asset_ratio = (notes_nb + notes_sb + rediscounts) / assets
* Sort data by bank_id and year
sort bank_id year
* Calculate Nominal Asset Growth
by bank_id: gen asset_growth = ((assets - assets[_n-1]) / assets[_n-1]) * 100 if _n > 1
gen undivided_profit_equity_ratio = undivided_profits / (capital + surplus_fund)

* Calculate the mean ratios for failing and surviving banks
collapse (mean) equity_asset_ratio deposit_asset_ratio wholesale_funding_asset_ratio asset_growth undivided_profit_equity_ratio, by(year surviving)

* Generate the plot
twoway (line equity_asset_ratio year if surviving == 0, lcolor(red)) (line equity_asset_ratio year if surviving == 1, lcolor(blue)), ///
    title("Equity-Asset Ratio between Failing & Surviving Banks") ///
    ytitle("Mean Equity to Asset Ratio") xtitle("Years") ///
    legend(label(1 "Failing Banks") label(2 "Surviving Banks"))

twoway (line deposit_asset_ratio year if surviving == 0, lcolor(red)) (line deposit_asset_ratio year if surviving == 1, lcolor(blue)), ///
    title("Deposit-Asset Ratio between Failing and Surviving Banks") ///
    ytitle("Mean Deposit to Asset Ratio") xtitle("Years") ///
    legend(label(1 "Failing Banks") label(2 "Surviving Banks"))

twoway (line wholesale_funding_asset_ratio year if surviving == 0, lcolor(red)) (line wholesale_funding_asset_ratio year if surviving == 1, lcolor(blue)), ///
    title("WholesaleFunding-Asset Ratio between Failing and Surviving Banks") ///
    ytitle("Mean Wholesale Funding to Asset Ratio") xtitle("Years") ///
    legend(label(1 "Failing Banks") label(2 "Surviving Banks"))

twoway (line asset_growth year if surviving == 0, lcolor(red)) (line asset_growth year if surviving == 1, lcolor(blue)), ///
    title("Asset Growth between Failing and Surviving Banks") ///
    ytitle("Mean Asset Growth (%)") xtitle("Years") ///
    legend(label(1 "Failing Banks") label(2 "Surviving Banks"))
	

*QUESTION 5

use "C:\Users\Baha\Downloads\roshan_978-attachments\occ-balance-sheets_dta (1)\occ-balance-sheets.dta", clear

* Calculate solvency proxy: undivided profits over equity
gen solvency_proxy = undivided_profits / (capital + surplus_fund)

* Calculate funding vulnerability proxy: wholesale funding over assets
gen funding_vulnerability_proxy = (notes_nb + notes_sb + rediscounts) / assets

* Categorize banks into groups based on solvency proxy and funding vulnerability proxy
gen solvency_group = .
replace solvency_group = 1 if solvency_proxy <= 0.05
replace solvency_group = 2 if solvency_proxy > 0.05 & solvency_proxy <= 0.50
replace solvency_group = 3 if solvency_proxy > 0.50

gen funding_group = .
replace funding_group = 1 if funding_vulnerability_proxy <= 0.05
replace funding_group = 2 if funding_vulnerability_proxy > 0.05 & funding_vulnerability_proxy <= 0.50
replace funding_group = 3 if funding_vulnerability_proxy > 0.50

gen surviving = 1 - is_rec
* Calculate the number of failures and observations for each cell
egen failure_count = total(is_rec), by(solvency_group funding_group)
egen total_count = total(surviving), by(solvency_group funding_group)

* Calculate the probability of failure for each cell
gen failure_probability = failure_count / total_count * 100 if total_count > 0

* Generate the table
table solvency_group funding_group, format(%9.2f)
