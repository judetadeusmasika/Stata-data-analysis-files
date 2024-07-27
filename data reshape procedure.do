
* load the dataset to reshape in the program
import excel "C:\Users\Baha\Downloads\PilotDataforReshapr.xlsx", sheet("Sheet0") firstrow clear
drop TimerConsent*
drop TimerDemo_*
drop _Timer*
drop TimerPoli_*
drop TimerInstitutBanks_*
drop RecipientLastName RecipientFirstName RecipientEmail ExternalReference LocationLatitude LocationLongitude DistributionChannel UserLanguage Q_RecaptchaScore IPAddress Progress

* Consent
drop Consent
ren ED Consent
destring Consent, force replace
recode Consent .=1
labe define consent 0 "Disagree" 1 "Agree"
label values Consent consent
tabulate Consent

* Gender
labe define gender 0 "Male" 1 "Female" 2 "Other" 99 "Prefer not to answer"
label values Gender gender
label var Gender "Respondent's gender"
tabulate Gender

* Age
label var Age "Respondent's Year of birth"

* Region 
label var Region "In which state do you currently live?"
label define region 1 "Baden-Württemberg" 2 "Bavaria" 3 "Berlin" 4 "Brandenburg" 5 "Bremen" 6 "Hamburg" 7 "Hesse" 8 "Lower Saxony" 9 "Mecklenburg-Vorpommern" 10 "North Rhine-Westphalia" 11 "Rhineland-Palatinate" 12 "Saarland" 13 "Saxony" 14 "Saxony-Anhalt" 15 "Schleswig-Holstein" 16 "Thuringia" 99 "Prefer not to answer"
label values Region region
tabulate Region
 
* Education
label var Education "What is the highest educational level that you have attained?"
label define educ 1 "No high school diploma" 2 "Elementary school" 3 "Secondary school" 4 "Vocational school" 5 "Specific higher education" 6 "Vocational academy" 7 "University" 99 "Prefer not to answer"
label values Education educ
tabulate Education

* Class
label var Class "Respondent's self-reported class affiliation"
label define class1 1 "Upper class" 2 "Upper middle class" 3 "Lower middle class" 4 "Working class" 5 "Lower class" 99 "Prefer not to answer"
label values Class class1
tabulate Class

* Econ
label var Econ "Tax preferences"
label define econ 1 "1=Lower taxes" 5 "5=More social services" 99 "Prefer not to answer"
label values Econ econ
tabulate Econ

* LeftRight
label var LeftRight "Self-reported political ideology"
label define rightleft 1 "1=Left" 5 "5 = Right"  99 "Prefer not to answer"
label values LeftRight rightleft
tabulate LeftRight

* EUimage
label var EUimage "Generally speaking, what is your image of the European Union?"
label define euim 1 "Very positive" 2 "Positive" 3 "Centrist" 4 "Negative" 5 "Very negative" 99 "Prefer not to answer"
label values EUimage euim
tabulate EUimage

* EUmembership
label var EUmembership "Attitude about referendum"
label define eumem 1 "Remain" 2 "Don't know" 3 "Leave" 99 "Prefer not to answer"
label values EUmembership eumem
tabulate EUmembership

* AttCh1
destring AttCh1, replace force
recode AttCh1 .=0
label var AttCh1 "1=fail AttentionCheck1"
label define fail 1 "Failed 1" 0 "Didn't fail"
label values AttCh1 fail
tabulate AttCh1

* AttCh2
destring AttCh2, replace force
recode AttCh2 .=0
label var AttCh2 "1=fail AttentionCheck2"
label values AttCh2 fail
tabulate AttCh2

* Trust in Institutions
label var Trustinstitutions_1 "Trust in The Bundestag"
label var Trustinstitutions_2 "Trust in The Federal Constitutional Court"
label var Trustinstitutions_3 "Trust in The German Armed Forces"
label var Trustinstitutions_4 "AttCh2"
label var Trustinstitutions_5 "Trust in The trade unions"
label var Trustinstitutions_6 "Trust in The banks"
label var Trustinstitutions_7 "Trust in The media"
label var Trustinstitutions_8 "Trust in The police"
label var Trustinstitutions_9 "Trust in The federal government"
label var Trustinstitutions_10 "Trust in The EU"

*** renaming the trust institutions variables
ren Trustinstitutions_1 Bundestag
ren Trustinstitutions_2 Court
ren Trustinstitutions_3 Army
ren Trustinstitutions_4 AttentionCheck2_2
ren Trustinstitutions_5 TradeUnioun 
ren Trustinstitutions_6 Banks
ren Trustinstitutions_7 Media
ren Trustinstitutions_8 Police
ren Trustinstitutions_9 Government
ren Trustinstitutions_10 EU

* Saving
label de saving 1 "None" 2 "Small" 3 "Half" 4 "Most" 5 "All" 99 "Prefer not to answer"
label values Savings saving
tabulate Savings

* Credit
label de credit 1 "Very small" 2 "Small" 3 "Not small, not large" 4 "Large" 5 "Very large" 99 "Prefer not to answer"
label values Credit credit
tabulate Credit

* Protection
label var Protection "Where do you manage your personal accounts?"
label de prot 1 "Only protected" 2 "Mostly protected" 3 "Protected AND non-protected" 4 "Mostly non-protected" 5 "Only non-protected" 99 "Prefer not to answer"
label values Protection prot
tabulate Protection

* Bafin
label de baf 1 "Fully controlled" 2 "Mostly controlled" 3 "Neither controlled nor independent" 4 "Mostly independent" 5 "Fully independent"  99 "Prefer not to answer"
label values Bafin baf
tabulate Bafin

* AttentionCheck4
tabulate AttentionCheck4

* AttentionCheck5
tabulate AttentionCheck5

* ManipulationCheck
label var ManipulationCheck "Manipulation Check"
tabulate ManipulationCheck


* Outcome Vars
label define B3way 1 "Party A" ///
                       2 "Party B" ///
                       9 "None of the parties, or don't know" 
	
foreach var of varlist _B3way* {
    label values `var' B3way
}

label define B2way 1 "Party A" ///
                       2 "Party B"
	
foreach var of varlist _B2way* {
    label values `var' B2way
}

* Define attributes labels
* Define labels
label define gov_labels 1 "Large party in opposition" ///
                       2 "Large party in government" ///
                       3 "Small party in opposition" ///
                       4 "Small party in government" ///
                       5 "New Party"

label define econ_labels 1 "Rather for free market and private ownership" ///
                        2 "Rather against the free market and private ownership" ///
                        3 "Strong for the free market and private property" ///
                        4 "Strongly against the free market and private property" ///
                        5 "Centrist"

label define lc1_labels 1 "Rather conservative" ///
                       2 "Rather liberal" ///
                       3 "Very conservative" ///
                       4 "Very liberal" ///
                       5 "Centrist"

label define eu1_labels 1 "Rather anti-EU" ///
                       2 "Rather EU-friendly" ///
                       3 "Very anti-EU" ///
                       4 "Very EU-friendly" ///
                       5 "Centrist"

label define rl1_labels 1 "Rather Leftist" ///
                       2 "Rather Rightist" ///
                       3 "Very Leftist" ///
                       4 "Very Rightist" ///
                       5 "Centristic"

label define relig_labels 1 "No Position" ///
                         2 "Moderately religious" ///
                         3 "Moderately secular" ///
                         4 "Very religious" ///
                         5 "Very secular"

label define envi_labels 1 "Rather anti-climate policy" ///
                        2 "Rather climate-friendly policy" ///
                        3 "No Position" ///
                        4 "Very anti-climate policy" ///
                        5 "Very climate-friendly policy"

label define gender_labels 1 "Other" ///
                         2 "Male" ///
                         3 "Female"

label define age_labels 1 "Old" ///
                     2 "Young" ///
                     3 "Middle Age" ///
                     4 "Very Old" ///
                     5 "Very Young"

label define supervision_labels 1 "Equally by the federal authority and the EU" ///
                               2 "Only by the federal authority" ///
                               3 "Only by the EU authority" ///
                               4 "Predominantly by the federal authority" ///
                               5 "Predominantly by the EU authority"

label define gbanks_labels 1 "Divided equally between bank owners and taxpayers" ///
                          2 "Mostly paid for by bank owners" ///
                          3 "Mostly paid for by taxpayers" ///
                          4 "Paid for in full by taxpayers" ///
                          5 "Paid for in full by bank owners"

label define ybank_labels 1 "All desired loans at very advantageous terms" ///
                         2 "Most desired loans at very advantageous terms" ///
                         3 "Part of the desired loans at market standard" ///
                         4 "A small portion of the desired loans at market standard" ///
                         5 "None of the desired loans and a very disadvantageous rate"

label define gecon_labels 1 "Has fallen into a recession" ///
                          2 "Has grown slowly with no new jobs" ///
                          3 "Has grown rapidly and unemployment has decreased" ///
                          4 "Has grown very quickly with a surge in jobs" ///
                          5 "Was in crisis with many job losses"

label define yecon_labels 1 "Has increased significantly" ///
                         2 "Has increased" ///
                         3 "Has not changed" ///
                         4 "Has decreased significantly" ///
                         5 "Has slightly decreased"
						 
* Encode and apply labels to variables
foreach var of varlist c1_Gov1 c1_Gov2 c1_Econ1 c1_Econ2 c1_LC1 c1_LC2 c1_EU1 c1_EU2 c1_RL1 c1_RL2 c1_Relig1 c1_Relig2 c1_Envi1 c1_Envi2 c1_Gender1 c1_Gender2 c1_Age1 c1_Age2 c2_Gov1 c2_Gov2 c2_Econ1 c2_Econ2 c2_LC1 c2_LC2 c2_EU1 c2_EU2 c2_Supervision1 c2_Supervision2 c2_GBanks1 c2_GBanks2 c2_YBank1 c2_YBank2 c2_GEcon1 c2_GEcon2 c2_YEcon1 c2_YEcon2 c3_Gov1 c3_Gov2 c3_Econ1 c3_Econ2 c3_LC1 c3_LC2 c3_EU1 c3_EU2 c3_Supervision1 c3_Supervision2 c3_GBanks1 c3_GBanks2 c3_YBank1 c3_YBank2 c3_GEcon1 c3_GEcon2 c3_YEcon1 c3_YEcon2 c4_Gov1 c4_Gov2 c4_Econ1 c4_Econ2 c4_LC1 c4_LC2 c4_EU1 c4_EU2 c4_Supervision1 c4_Supervision2 c4_GBanks1 c4_GBanks2 c4_YBank1 c4_YBank2 c4_GEcon1 c4_GEcon2 c4_YEcon1 c4_YEcon2 c5_Gov1 c5_Gov2 c5_Econ1 c5_Econ2 c5_LC1 c5_LC2 c5_EU1 c5_EU2 c5_Supervision1 c5_Supervision2 c5_GBanks1 c5_GBanks2 c5_YBank1 c5_YBank2 c5_GEcon1 c5_GEcon2 c5_YEcon1 c5_YEcon2 c6_Gov1 c6_Gov2 c6_Econ1 c6_Econ2 c6_LC1 c6_LC2 c6_EU1 c6_EU2 c6_Supervision1 c6_Supervision2 c6_GBanks1 c6_GBanks2 c6_YBank1 c6_YBank2 c6_GEcon1 c6_GEcon2 c6_YEcon1 c6_YEcon2 c7_Gov1 c7_Gov2 c7_Econ1 c7_Econ2 c7_LC1 c7_LC2 c7_EU1 c7_EU2 c7_Supervision1 c7_Supervision2 c7_GBanks1 c7_GBanks2 c7_YBank1 c7_YBank2 c7_GEcon1 c7_GEcon2 c7_YEcon1 c7_YEcon2 c8_Gov1 c8_Gov2 c8_Econ1 c8_Econ2 c8_LC1 c8_LC2 c8_EU1 c8_EU2 c8_Supervision1 c8_Supervision2 c8_GBanks1 c8_GBanks2 c8_YBank1 c8_YBank2 c8_GEcon1 c8_GEcon2 c8_YEcon1 c8_YEcon2 c9_Gov1 c9_Gov2 c9_Econ1 c9_Econ2 c9_LC1 c9_LC2 c9_EU1 c9_EU2 c9_Supervision1 c9_Supervision2 c9_GBanks1 c9_GBanks2 c9_YBank1 c9_YBank2 c9_GEcon1 c9_GEcon2 c9_YEcon1 c9_YEcon2 {
    
    encode `var', gen(num_`var')
	
    * Apply appropriate labels
    if regexm("`var'", "GEcon") {
        label values num_`var' gecon_labels
    }
    else if regexm("`var'", "YEcon") {
        label values num_`var' yecon_labels
    }
    else if regexm("`var'", "Gov") {
        label values num_`var' gov_labels
    }
    else if regexm("`var'", "Econ") {
        label values num_`var' econ_labels
    }
    else if regexm("`var'", "LC") {
        label values num_`var' lc1_labels
    }
    else if regexm("`var'", "EU") {
        label values num_`var' eu1_labels
    }
    else if regexm("`var'", "RL") {
        label values num_`var' rl1_labels
    }
    else if regexm("`var'", "Relig") {
        label values num_`var' relig_labels
    }
    else if regexm("`var'", "Envi") {
        label values num_`var' envi_labels
    }
    else if regexm("`var'", "Gender") {
        label values num_`var' gender_labels
    }
    else if regexm("`var'", "Age") {
        label values num_`var' age_labels
    }
    else if regexm("`var'", "Supervision") {
        label values num_`var' supervision_labels
    }
    else if regexm("`var'", "GBanks") {
        label values num_`var' gbanks_labels
    }
    else if regexm("`var'", "YBank") {
        label values num_`var' ybank_labels
    }

    drop `var'
    rename num_`var' `var'
    decode `var', gen(num_`var')
    drop `var'
    rename num_`var' `var'
}

***** Information on dependent variables ******

* The DVs for Task 1 are: 
tab _B3way01
tab _B2way01

* Then for Task 2 
tab _B3way02
tab _B2way02

* Task 3
tab _B3way03
tab _B2way03

* Task 4
tab _B3way04
tab _B2way04

* Task 5
tab _B3way05
tab _B2way05

* Task 6
tab _B3way06
tab _B2way06

* Task 7
tab _B3way07
tab _B2way07

* Task 8
tab _B3way08
tab _B2way08

* Task 9
tab _B3way09
tab _B2way09

* Task 10
tab _B3way10
tab _B2way10

* Task 11
tab _B3way11
tab _B2way11
