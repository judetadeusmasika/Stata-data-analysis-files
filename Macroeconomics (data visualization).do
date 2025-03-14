
** Load the Macroeconomics data into the program

import excel "C:\Users\lenovo\Documents\Economics_dataset1.xlsx", sheet("Economics_data") firstrow

** describe the data to confirm if loaded

describe, detail

** summary statistics of the loaded data

summarize

** Visualization 

* GDP Growth Rate Comparison among the 3 countries from 2015 to 2024

* Chart 1

twoway (line GDP_Growth_Rate TIME if Country == "Spain", lcolor(blue)) ///
       (line GDP_Growth_Rate TIME if Country == "Netherlands", lcolor(red)) ///
       (line GDP_Growth_Rate TIME if Country == "Finland", lcolor(green)), ///
       title("GDP Growth Rate Comparison (2015-2024)") ///
       xlabel(2015(1)2024, angle(45)) ///
       ylabel(, angle(0)) ///
       xtitle("Year") ytitle("GDP Growth Rate (%)") ///
       legend(order(1 "Spain" 2 "Netherlands" 3 "Finland")) ///
       note("Source: Eurostat ~ Macroeconomic Data, 2015-2024")
	   
* Inflation rate comparison (2015-2024)

* Chart 2

twoway (line Inflation_rate TIME if Country == "Spain", lcolor(blue)) ///
       (line Inflation_rate TIME if Country == "Netherlands", lcolor(red)) ///
       (line Inflation_rate TIME if Country == "Finland", lcolor(green)), ///
       title("Inflation Rate Comparison (2015-2024)") ///
       xlabel(2015(1)2024, angle(45)) ///
       ylabel(, angle(0)) ///
       xtitle("Year") ytitle("Inflation Rate (%)") ///
       legend(order(1 "Spain" 2 "Netherlands" 3 "Finland")) ///
       note("Source: Eurostat ~ Macroeconomic Data, 2015-2024")
	   
* Unemployment rate comparison (2015-2024)

* Chart 3

twoway (line Unemployment_rate TIME if Country == "Spain", lcolor(blue)) ///
       (line Unemployment_rate TIME if Country == "Netherlands", lcolor(red)) ///
       (line Unemployment_rate TIME if Country == "Finland", lcolor(green)), ///
       title("Unemployment Rate Comparison (2015-2024)") ///
       xlabel(2015(1)2024, angle(45)) ///
       ylabel(, angle(0)) ///
       xtitle("Year") ytitle("Unemployment Rate (%)") ///
       legend(order(1 "Spain" 2 "Netherlands" 3 "Finland")) ///
       note("Source: Macroeconomic Data, 2015-2024")
	   
* Summary Bar chart (Average rates over 10 years)

* Generate average values

collapse (mean) GDP_Growth_Rate Inflation_rate Unemployment_rate, by(Country)


* Bar chart for average rates
graph bar GDP_Growth_Rate Inflation_rate Unemployment_rate, ///
    over(Country, gap(30)) ///
    bar(1, color(blue)) bar(2, color(red)) bar(3, color(green)) ///
    title("Average Macroeconomic Indicators (2015-2024)") ///
    ytitle("Average Value") ///
    legend(order(1 "GDP Growth Rate" 2 "Inflation Rate" 3 "Unemployment Rate")) ///
    note("Source: Eurostat ~ Macroeconomic Data, 2015-2024")



* Scatterplot of GDP growth rate against Inflation rate

twoway scatter GDP_Growth_Rate Inflation_rate, ///
    title("Scatterplot of GDP G. Rate vs Inflation Rate (2015-2024)") ///
    xlabel(-2(1)3) ylabel(-12(2)7) ///
    xtitle("Inflation Rate (%)") ytitle("GDP Growth Rate (%)") ///
    msize(medium) mcolor(blue) ///
    legend(off)
	







