
*load the dataset

use "C:\Users\Baha\Downloads\earnestbc-attachments (2)\BRFSS Final Exam.dta", clear

describe, detail

*question one

* Summarize sociodemographic and health-related characteristics for the total sample
tabulate RACEETH

tabulate SEX

tabulate HLTHPLN

tabulate EDUCA

tabulate SMOKER3

tabulate MENTHLTH 

tabulate CANCERDX

tabulate AGE

* Summarize characteristics for individuals with and without cancer

tabulate RACEETH CANCERDX, chi2
tabulate HLTHPLN CANCERDX, chi2
tabulate EDUCA CANCERDX, chi2
tabulate SMOKER3 CANCERDX, chi2
tabulate SEX CANCERDX, chi2
ttest MENTHLTH, by(CANCERDX)
ttest AGE, by(CANCERDX)

*question two

* Run logistic regression adjusting for sociodemographic and health-related characteristics
logistic CANCERDX SMOKER3 RACEETH AGE SEX HLTHPLN MENTHLTH

*question 3

* Run ANOVA to test for differences in means by smoking status
anova MENTHLTH SMOKER3

*question 4

* Run linear regression adjusting for age, race/ethnicity, and health insurance status
regress MENTHLTH CANCERDX AGE RACEETH HLTHPLN

*question 5

* Create the interaction term
gen cancer_age = CANCERDX * AGE

* Run linear regression including the interaction term
regress MENTHLTH CANCERDX AGE cancer_age

*question 6

* Run Cronbach's alpha to assess reliability
alpha CDHOUSE CDASSIST CDHELP CDSOCIAL

* Calculate Cronbach's alpha with each item removed
alpha CDHOUSE CDASSIST CDHELP CDSOCIAL, if missing(cognitive_scale) listwise

* Calculate Cronbach's alpha with each item removed
alpha CDHOUSE CDASSIST CDHELP CDSOCIAL if cognitive_scale != .