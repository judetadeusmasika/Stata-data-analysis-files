
* Load the dataset into the program

import excel "C:\Users\lenovo\Desktop\Updated EDA excel doc.xlsx", sheet("Olympic_Economic_Data__Updated_") firstrow

* Describe the dataset

describe, detail

* Set the panel structure

* Convert the country variable into a numeric panel identifier

encode Country, generate(CountryID)

xtset CountryID YearClean

* Run a fixed effects regression model

ssc install asdoc

asdoc xtreg GDPperCapitaUSD OlympicSpendingmillionUSD, fe

* Include interaction terms

* Convert IsCountryDeveloped to a Numeric Variable

encode IsCountryDeveloped, generate(DevelopedNum)

asdoc xtreg GDPperCapitaUSD OlympicSpendingmillionUSD c.OlympicSpendingmillionUSD#i.DevelopedNum, fe

* Visualizing the relationship

* scatterplot using a fitted line

scatter GDPperCapitaUSD OlympicSpendingmillionUSD || lfit GDPperCapitaUSD OlympicSpendingmillionUSD

* Time trend of GDP per Capita and Olympic spending

* Australia

twoway ///
    (line GDPperCapitaUSD YearClean if Country == "Australia", lcolor(blue) lwidth(medium) yaxis(1)) ///
    (line OlympicSpendingmillionUSD YearClean if Country == "Australia", lcolor(red) lwidth(medium) yaxis(2)), ///
    title("GDPperCapita & OlympicSpending Over Time - Australia") ///
    ylabel(0(7000)50000, axis(1) labsize(small) grid) ///
    ytitle("GDP per Capita (USD)", axis(1)) ///
    ylabel(0(600)5000, axis(2) labsize(small) grid) ///
    ytitle("Olympic Spending (Million USD)", axis(2)) ///
    xlabel(, angle(45) labsize(small)) ///
    legend(order(1 "GDP per Capita" 2 "Olympic Spending") pos(6) ring(0)) ///
    xtitle("Year")

* United Kingdom

twoway ///
    (line GDPperCapitaUSD YearClean if Country == "United Kingdom", lcolor(gray) lwidth(medium) yaxis(1)) ///
    (line OlympicSpendingmillionUSD YearClean if Country == "United Kingdom", lcolor(red) lwidth(medium) yaxis(2)), ///
    title("GDPperCapita & OlympicSpending Over Time - UK") ///
    ylabel(0(7000)50000, axis(1) labsize(small) grid) ///
    ytitle("GDP per Capita (USD)", axis(1)) ///
    ylabel(0(600)5000, axis(2) labsize(small) grid) ///
    ytitle("Olympic Spending (Million USD)", axis(2)) ///
    xlabel(, angle(45) labsize(small)) ///
    legend(order(1 "GDP per Capita" 2 "Olympic Spending") pos(6) ring(0)) ///
    xtitle("Year")

* United States

twoway ///
    (line GDPperCapitaUSD YearClean if Country == "United States", lcolor(gray) lwidth(medium) yaxis(1)) ///
    (line OlympicSpendingmillionUSD YearClean if Country == "United States", lcolor(blue) lwidth(medium) yaxis(2)), ///
    title("GDPperCapita & OlympicSpending Over Time - US") ///
    ylabel(0(7000)50000, axis(1) labsize(small) grid) ///
    ytitle("GDP per Capita (USD)", axis(1)) ///
    ylabel(0(600)5000, axis(2) labsize(small) grid) ///
    ytitle("Olympic Spending (Million USD)", axis(2)) ///
    xlabel(, angle(45) labsize(small)) ///
    legend(order(1 "GDP per Capita" 2 "Olympic Spending") pos(6) ring(0)) ///
    xtitle("Year")


* Spain

twoway ///
    (line GDPperCapitaUSD YearClean if Country == "Spain", lcolor(darkred) lwidth(medium) yaxis(1)) ///
    (line OlympicSpendingmillionUSD YearClean if Country == "Spain", lcolor(green) lwidth(medium) yaxis(2)), ///
    title("GDPperCapita & OlympicSpending Over Time - Spain") ///
    ylabel(0(7000)50000, axis(1) labsize(small) grid) ///
    ytitle("GDP per Capita (USD)", axis(1)) ///
    ylabel(0(600)5000, axis(2) labsize(small) grid) ///
    ytitle("Olympic Spending (Million USD)", axis(2)) ///
    xlabel(, angle(45) labsize(small)) ///
    legend(order(1 "GDP per Capita" 2 "Olympic Spending") pos(6) ring(0)) ///
    xtitle("Year")
	

* Japan

twoway ///
    (line GDPperCapitaUSD YearClean if Country == "Japan", lcolor(red) lwidth(medium) yaxis(1)) ///
    (line OlympicSpendingmillionUSD YearClean if Country == "Japan", lcolor(blue) lwidth(medium) yaxis(2)), ///
    title("GDPperCapita & OlympicSpending Over Time - Japan") ///
    ylabel(0(7000)50000, axis(1) labsize(small) grid) ///
    ytitle("GDP per Capita (USD)", axis(1)) ///
    ylabel(0(600)5000, axis(2) labsize(small) grid) ///
    ytitle("Olympic Spending (Million USD)", axis(2)) ///
    xlabel(, angle(45) labsize(small)) ///
    legend(order(1 "GDP per Capita" 2 "Olympic Spending") pos(6) ring(0)) ///
    xtitle("Year")
	
* South Korea

twoway ///
    (line GDPperCapitaUSD YearClean if Country == "South Korea", lcolor(green) lwidth(medium) yaxis(1)) ///
    (line OlympicSpendingmillionUSD YearClean if Country == "South Korea", lcolor(red) lwidth(medium) yaxis(2)), ///
    title("GDPperCapita & OlympicSpending Over Time - South Korea") ///
    ylabel(0(7000)50000, axis(1) labsize(small) grid) ///
    ytitle("GDP per Capita (USD)", axis(1)) ///
    ylabel(0(600)5000, axis(2) labsize(small) grid) ///
    ytitle("Olympic Spending (Million USD)", axis(2)) ///
    xlabel(, angle(45) labsize(small)) ///
    legend(order(1 "GDP per Capita" 2 "Olympic Spending") pos(6) ring(0)) ///
    xtitle("Year")
	

* Greece

twoway ///
    (line GDPperCapitaUSD YearClean if Country == "Greece", lcolor(red) lwidth(medium) yaxis(1)) ///
    (line OlympicSpendingmillionUSD YearClean if Country == "Greece", lcolor(black) lwidth(medium) yaxis(2)), ///
    title("GDPperCapita & OlympicSpending Over Time - Greece") ///
    ylabel(0(7000)50000, axis(1) labsize(small) grid) ///
    ytitle("GDP per Capita (USD)", axis(1)) ///
    ylabel(0(600)5000, axis(2) labsize(small) grid) ///
    ytitle("Olympic Spending (Million USD)", axis(2)) ///
    xlabel(, angle(45) labsize(small)) ///
    legend(order(1 "GDP per Capita" 2 "Olympic Spending") pos(6) ring(0)) ///
    xtitle("Year")
	

* Brazil

twoway ///
    (line GDPperCapitaUSD YearClean if Country == "Brazil", lcolor(gray) lwidth(medium) yaxis(1)) ///
    (line OlympicSpendingmillionUSD YearClean if Country == "Brazil", lcolor(red) lwidth(medium) yaxis(2)), ///
    title("GDPperCapita & OlympicSpending Over Time - Brazil") ///
    ylabel(0(7000)50000, axis(1) labsize(small) grid) ///
    ytitle("GDP per Capita (USD)", axis(1)) ///
    ylabel(0(600)5000, axis(2) labsize(small) grid) ///
    ytitle("Olympic Spending (Million USD)", axis(2)) ///
    xlabel(, angle(45) labsize(small)) ///
    legend(order(1 "GDP per Capita" 2 "Olympic Spending") pos(6) ring(0)) ///
    xtitle("Year")

* China

twoway ///
    (line GDPperCapitaUSD YearClean if Country == "China", lcolor(orange) lwidth(medium) yaxis(1)) ///
    (line OlympicSpendingmillionUSD YearClean if Country == "China", lcolor(pink) lwidth(medium) yaxis(2)), ///
    title("GDPperCapita & OlympicSpending Over Time - China") ///
    ylabel(0(7000)50000, axis(1) labsize(small) grid) ///
    ytitle("GDP per Capita (USD)", axis(1)) ///
    ylabel(0(600)5000, axis(2) labsize(small) grid) ///
    ytitle("Olympic Spending (Million USD)", axis(2)) ///
    xlabel(, angle(45) labsize(small)) ///
    legend(order(1 "GDP per Capita" 2 "Olympic Spending") pos(6) ring(0)) ///
    xtitle("Year")


twoway ///
    (line GDPperCapitaUSD YearClean if Country == "Spain", lcolor(blue) lwidth(medium) lpattern(solid) ) ///
    (line GDPperCapitaUSD YearClean if Country == "United Kingdom", lcolor(red) lwidth(medium) lpattern(dash) ), ///
    title("GDP per Capita Over Time") ///
    legend(order(1 "Spain" 2 "United Kingdom") position(6)) ///
    xlabel(, angle(45)) ///
    ylabel(, grid)

	
twoway (line GDPperCapitaUSD OlympicSpendingmillionUSD), ///
       by(Country, col(3) note("GDP per Capita vs Olympic Spending by Country")) ///
       xlabel(, angle(45)) ylabel(, angle(0)) legend(off)

