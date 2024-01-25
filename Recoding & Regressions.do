// Import the dataset into stata

use "C:\Users\Baha\Downloads\GSS2018.dta"

//Recode some variables

//Recode the variable 'sex' into a new variable
gen woman = .
replace woman = 1 if sex == 1  // 1 represents "Woman" in the original 'sex' variable
replace woman = 0 if sex == 0  // 0 represents "Man" in the original 'sex' variable

* Assign labels to the new 'woman' variable
label define gender 1 "Woman" 0 "Man"
label values woman gender

* Recode 'childs' into a new variable 'kids' with labels
gen kids = .
replace kids = 1 if childs == 1  // 1 represents "Kids" in the original 'childs' variable
replace kids = 0 if childs == 0  // 0 represents "No kids" in the original 'childs' variable

* Assign labels to the new 'kids' variable
label define kidstatus 1 "Kids" 0 "No kids"
label values kids kidstatus

* Create a new variable 'spempstatus' with labels
gen spempstatus = .

* Recode based on marital and spwrksta values
* 1 "FT or PT spouse" (marital = 1 and spwrksta = 1 or 2)
* 2 "non-employed spouse" (marital = 1 and spwrksta = 0)
* 3 "no spouse" (marital = 0)
replace spempstatus = 1 if marital == 1 & (spwrksta == 1 | spwrksta == 2)
replace spempstatus = 2 if marital == 1 & spwrksta == 0
replace spempstatus = 3 if marital == 0

* Assign labels to the new 'spempstatus' variable
label define empstatus 1 "FT or PT spouse" 2 "non-employed spouse" 3 "no spouse"
label values spempstatus empstatus

* Recode 'age' into four categories
recode age (min/29 = 1) (30/39 = 2) (40/49 = 3) (50/max = 4), generate(age_cat4)

* Label the new 'age_cat4' variable
label define agegroups 1 "<30" 2 "30-39" 3 "40-49" 4 "50+"
label values age_cat4 agegroups

*Descriptive statistics
sum hrs1 woman age_cat4 race kids spempstatus

* frequency distribution of the spempstatus variable
tabulate spempstatus

* Initialize 'analysis' variable
gen analysis = 1

* Mark 'analysis' as missing if any of the specified variables is missing
replace analysis = . if missing(hrs1) | missing(woman) | missing(age_cat4) | missing(race) | missing(kids) | missing(spempstatus)

tabulate analysis

* Use "if analysis==1" to keep N constant across models
* First Model: woman as the only independent variable
reg hrs1 i.woman if analysis == 1
eststo model1

* Second Model: Add age_cat4, race, and kids as independent variables
reg hrs1 i.woman i.age_cat4 i.race i.kids if analysis == 1
eststo model2

* Third Model: Add spempstatus as an independent variable
reg hrs1 i.woman i.age_cat4 i.race i.kids i.ib3.spempstatus if analysis == 1
eststo model3

* Display the regression results using esttab
esttab model1 model2 model3

esttab model1 model2 model3, b(2) r2 not nobase label
