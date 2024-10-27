
*Load the dataset to be used

use "C:\Users\Baha\Downloads\dataset.dta", clear

*Convert the categorical variables into a likert scale numerical variables

gen FGG_PositiveAffect_num = .
replace FGG_PositiveAffect_num = 5 if FGGpositiveaffect == "Strongly agree"
replace FGG_PositiveAffect_num = 4 if FGGpositiveaffect == "Somewhat agree"
replace FGG_PositiveAffect_num = 3 if FGGpositiveaffect == "Neither agree nor disagree"
replace FGG_PositiveAffect_num = 2 if FGGpositiveaffect == "Somewhat disagree"
replace FGG_PositiveAffect_num = 1 if FGGpositiveaffect == "Strongly disagree"

gen FGG2_PositiveAffect_num = .
replace FGG2_PositiveAffect_num = 5 if FGG2positiveaffect == "Strongly agree"
replace FGG2_PositiveAffect_num = 4 if FGG2positiveaffect == "Somewhat agree"
replace FGG2_PositiveAffect_num = 3 if FGG2positiveaffect == "Neither agree nor disagree"
replace FGG2_PositiveAffect_num = 2 if FGG2positiveaffect == "Somewhat disagree"
replace FGG2_PositiveAffect_num = 1 if FGG2positiveaffect == "Strongly disagree"
egen FGG_PositiveAffect_combined = rowmean(FGG_PositiveAffect_num FGG2_PositiveAffect_num)

gen FGG_InvestmentIntention_num = .
replace FGG_InvestmentIntention_num = 5 if FGGinvestmentintention == "Extremely likely"
replace FGG_InvestmentIntention_num = 4 if FGGinvestmentintention == "Somewhat likely"
replace FGG_InvestmentIntention_num = 3 if FGGinvestmentintention == "Neither likely nor unlikely"
replace FGG_InvestmentIntention_num = 2 if FGGinvestmentintention == "Somewhat unlikely"
replace FGG_InvestmentIntention_num = 1 if FGGinvestmentintention == "Extremely unlikely"

gen FGG2_InvestmentIntention_num = .
replace FGG2_InvestmentIntention_num = 5 if FGG2investmentintention == "Extremely likely"
replace FGG2_InvestmentIntention_num = 4 if FGG2investmentintention == "Somewhat likely"
replace FGG2_InvestmentIntention_num = 3 if FGG2investmentintention == "Neither likely nor unlikely"
replace FGG2_InvestmentIntention_num = 2 if FGG2investmentintention == "Somewhat unlikely"
replace FGG2_InvestmentIntention_num = 1 if FGG2investmentintention == "Extremely unlikely"
egen FGG_InvestmentIntention_combined = rowmean(FGG_InvestmentIntention_num FGG2_InvestmentIntention_num)

gen FGG_PerceivedRisk_num = .
replace FGG_PerceivedRisk_num = 1 if FGGperceivedrisk == "Very low risk"
replace FGG_PerceivedRisk_num = 2 if FGGperceivedrisk == "Low risk"
replace FGG_PerceivedRisk_num = 3 if FGGperceivedrisk == "Moderate risk"
replace FGG_PerceivedRisk_num = 4 if FGGperceivedrisk == "High risk"
replace FGG_PerceivedRisk_num = 5 if FGGperceivedrisk == "Very high risk"

gen FGG2_PerceivedRisk_num = .
replace FGG2_PerceivedRisk_num = 1 if FGG2perceivedrisk == "Very low risk"
replace FGG2_PerceivedRisk_num = 2 if FGG2perceivedrisk == "Low risk"
replace FGG2_PerceivedRisk_num = 3 if FGG2perceivedrisk == "Moderate risk"
replace FGG2_PerceivedRisk_num = 4 if FGG2perceivedrisk == "High risk"
replace FGG2_PerceivedRisk_num = 5 if FGG2perceivedrisk == "Very high risk"
egen FGG_PerceivedRisk_combined = rowmean(FGG_PerceivedRisk_num FGG2_PerceivedRisk_num)

gen FGG_Confidence_num = .
replace FGG_Confidence_num = 5 if FGGconfidence == "Very confident"
replace FGG_Confidence_num = 4 if FGGconfidence == "Somewhat confident"
replace FGG_Confidence_num = 3 if FGGconfidence == "Neutral"
replace FGG_Confidence_num = 2 if FGGconfidence == "Somewhat not confident"
replace FGG_Confidence_num = 1 if FGGconfidence == "Not confident at all"

gen FGG2_Confidence_num = .
replace FGG2_Confidence_num = 5 if FGG2confidence == "Very confident"
replace FGG2_Confidence_num = 4 if FGG2confidence == "Somewhat confident"
replace FGG2_Confidence_num = 3 if FGG2confidence == "Neutral"
replace FGG2_Confidence_num = 2 if FGG2confidence == "Somewhat not confident"
replace FGG2_Confidence_num = 1 if FGG2confidence == "Not confident at all"
egen FGG_Confidence_combined = rowmean(FGG_Confidence_num FGG2_Confidence_num)

gen FGG_Trust_num = .
replace FGG_Trust_num = 5 if FGGtrust == "Complete trust"
replace FGG_Trust_num = 4 if FGGtrust == "Some trust"
replace FGG_Trust_num = 3 if FGGtrust == "Neutral"
replace FGG_Trust_num = 2 if FGGtrust == "Little trust"
replace FGG_Trust_num = 1 if FGGtrust == "No trust at all"

gen FGG2_Trust_num = .
replace FGG2_Trust_num = 5 if FGG2trust == "Complete trust"
replace FGG2_Trust_num = 4 if FGG2trust == "Some trust"
replace FGG2_Trust_num = 3 if FGG2trust == "Neutral"
replace FGG2_Trust_num = 2 if FGG2trust == "Little trust"
replace FGG2_Trust_num = 1 if FGG2trust == "No trust at all"
egen FGG_Trust_combined = rowmean(FGG_Trust_num FGG2_Trust_num)

gen FGG_Evaluation_num = .
replace FGG_Evaluation_num = 5 if FGGevaluation == "Excellent"
replace FGG_Evaluation_num = 4 if FGGevaluation == "Good"
replace FGG_Evaluation_num = 3 if FGGevaluation == "Neutral"
replace FGG_Evaluation_num = 2 if FGGevaluation == "Poor"
replace FGG_Evaluation_num = 1 if FGGevaluation == "Very poor"

gen FGG2_Evaluation_num = .
replace FGG2_Evaluation_num = 5 if FGG2evaluation == "Excellent"
replace FGG2_Evaluation_num = 4 if FGG2evaluation == "Good"
replace FGG2_Evaluation_num = 3 if FGG2evaluation == "Neutral"
replace FGG2_Evaluation_num = 2 if FGG2evaluation == "Poor"
replace FGG2_Evaluation_num = 1 if FGG2evaluation == "Very poor"
egen FGG_Evaluation_combined = rowmean(FGG_Evaluation_num FGG2_Evaluation_num)

* NSF - Positive Affect
gen NSF_PositiveAffect_num = .
replace NSF_PositiveAffect_num = 5 if NSFpositiveaffect == "Strongly agree"
replace NSF_PositiveAffect_num = 4 if NSFpositiveaffect == "Somewhat agree"
replace NSF_PositiveAffect_num = 3 if NSFpositiveaffect == "Neither agree nor disagree"
replace NSF_PositiveAffect_num = 2 if NSFpositiveaffect == "Somewhat disagree"
replace NSF_PositiveAffect_num = 1 if NSFpositiveaffect == "Strongly disagree"

gen NSF2_PositiveAffect_num = .
replace NSF2_PositiveAffect_num = 5 if NSF2positiveaffect == "Strongly agree"
replace NSF2_PositiveAffect_num = 4 if NSF2positiveaffect == "Somewhat agree"
replace NSF2_PositiveAffect_num = 3 if NSF2positiveaffect == "Neither agree nor disagree"
replace NSF2_PositiveAffect_num = 2 if NSF2positiveaffect == "Somewhat disagree"
replace NSF2_PositiveAffect_num = 1 if NSF2positiveaffect == "Strongly disagree"
egen NSF_PositiveAffect_combined = rowmean(NSF_PositiveAffect_num NSF2_PositiveAffect_num)

* NSF - Investment Intention
gen NSF_InvestmentIntention_num = .
replace NSF_InvestmentIntention_num = 5 if NSFinvestmentintention == "Extremely likely"
replace NSF_InvestmentIntention_num = 4 if NSFinvestmentintention == "Somewhat likely"
replace NSF_InvestmentIntention_num = 3 if NSFinvestmentintention == "Neither likely nor unlikely"
replace NSF_InvestmentIntention_num = 2 if NSFinvestmentintention == "Somewhat unlikely"
replace NSF_InvestmentIntention_num = 1 if NSFinvestmentintention == "Extremely unlikely"

gen NSF2_InvestmentIntention_num = .
replace NSF2_InvestmentIntention_num = 5 if NSF2investmentintention == "Extremely likely"
replace NSF2_InvestmentIntention_num = 4 if NSF2investmentintention == "Somewhat likely"
replace NSF2_InvestmentIntention_num = 3 if NSF2investmentintention == "Neither likely nor unlikely"
replace NSF2_InvestmentIntention_num = 2 if NSF2investmentintention == "Somewhat unlikely"
replace NSF2_InvestmentIntention_num = 1 if NSF2investmentintention == "Extremely unlikely"
egen NSF_InvestmentIntention_combined = rowmean(NSF_InvestmentIntention_num NSF2_InvestmentIntention_num)

* NSF - Perceived Risk
gen NSF_PerceivedRisk_num = .
replace NSF_PerceivedRisk_num = 1 if NSFperceivedrisk == "Very low risk"
replace NSF_PerceivedRisk_num = 2 if NSFperceivedrisk == "Low risk"
replace NSF_PerceivedRisk_num = 3 if NSFperceivedrisk == "Moderate risk"
replace NSF_PerceivedRisk_num = 4 if NSFperceivedrisk == "High risk"
replace NSF_PerceivedRisk_num = 5 if NSFperceivedrisk == "Very high risk"

gen NSF2_PerceivedRisk_num = .
replace NSF2_PerceivedRisk_num = 1 if NSF2perceivedrisk == "Very low risk"
replace NSF2_PerceivedRisk_num = 2 if NSF2perceivedrisk == "Low risk"
replace NSF2_PerceivedRisk_num = 3 if NSF2perceivedrisk == "Moderate risk"
replace NSF2_PerceivedRisk_num = 4 if NSF2perceivedrisk == "High risk"
replace NSF2_PerceivedRisk_num = 5 if NSF2perceivedrisk == "Very high risk"
egen NSF_PerceivedRisk_combined = rowmean(NSF_PerceivedRisk_num NSF2_PerceivedRisk_num)

* NSF - Confidence
gen NSF_Confidence_num = .
replace NSF_Confidence_num = 5 if NSFconfidence == "Very confident"
replace NSF_Confidence_num = 4 if NSFconfidence == "Somewhat confident"
replace NSF_Confidence_num = 3 if NSFconfidence == "Neutral"
replace NSF_Confidence_num = 2 if NSFconfidence == "Somewhat not confident"
replace NSF_Confidence_num = 1 if NSFconfidence == "Not confident at all"

gen NSF2_Confidence_num = .
replace NSF2_Confidence_num = 5 if NSF2confidence == "Very confident"
replace NSF2_Confidence_num = 4 if NSF2confidence == "Somewhat confident"
replace NSF2_Confidence_num = 3 if NSF2confidence == "Neutral"
replace NSF2_Confidence_num = 2 if NSF2confidence == "Somewhat not confident"
replace NSF2_Confidence_num = 1 if NSF2confidence == "Not confident at all"
egen NSF_Confidence_combined = rowmean(NSF_Confidence_num NSF2_Confidence_num)

* NSF - Trust
gen NSF_Trust_num = .
replace NSF_Trust_num = 5 if NSFtrust == "Complete trust"
replace NSF_Trust_num = 4 if NSFtrust == "Some trust"
replace NSF_Trust_num = 3 if NSFtrust == "Neutral"
replace NSF_Trust_num = 2 if NSFtrust == "Little trust"
replace NSF_Trust_num = 1 if NSFtrust == "No trust at all"

gen NSF2_Trust_num = .
replace NSF2_Trust_num = 5 if NSF2trust == "Complete trust"
replace NSF2_Trust_num = 4 if NSF2trust == "Some trust"
replace NSF2_Trust_num = 3 if NSF2trust == "Neutral"
replace NSF2_Trust_num = 2 if NSF2trust == "Little trust"
replace NSF2_Trust_num = 1 if NSF2trust == "No trust at all"
egen NSF_Trust_combined = rowmean(NSF_Trust_num NSF2_Trust_num)

* NSF - Evaluation
gen NSF_Evaluation_num = .
replace NSF_Evaluation_num = 5 if NSFevaluation == "Excellent"
replace NSF_Evaluation_num = 4 if NSFevaluation == "Good"
replace NSF_Evaluation_num = 3 if NSFevaluation == "Neutral"
replace NSF_Evaluation_num = 2 if NSFevaluation == "Poor"
replace NSF_Evaluation_num = 1 if NSFevaluation == "Very poor"

gen NSF2_Evaluation_num = .
replace NSF2_Evaluation_num = 5 if NSF2evaluation == "Excellent"
replace NSF2_Evaluation_num = 4 if NSF2evaluation == "Good"
replace NSF2_Evaluation_num = 3 if NSF2evaluation == "Neutral"
replace NSF2_Evaluation_num = 2 if NSF2evaluation == "Poor"
replace NSF2_Evaluation_num = 1 if NSF2evaluation == "Very poor"
egen NSF_Evaluation_combined = rowmean(NSF_Evaluation_num NSF2_Evaluation_num)

* NGG - Positive Affect
gen NGG_PositiveAffect_num = .
replace NGG_PositiveAffect_num = 5 if NGGpositiveaffect == "Strongly agree"
replace NGG_PositiveAffect_num = 4 if NGGpositiveaffect == "Somewhat agree"
replace NGG_PositiveAffect_num = 3 if NGGpositiveaffect == "Neither agree nor disagree"
replace NGG_PositiveAffect_num = 2 if NGGpositiveaffect == "Somewhat disagree"
replace NGG_PositiveAffect_num = 1 if NGGpositiveaffect == "Strongly disagree"

gen NGG2_PositiveAffect_num = .
replace NGG2_PositiveAffect_num = 5 if NGG2positiveaffect == "Strongly agree"
replace NGG2_PositiveAffect_num = 4 if NGG2positiveaffect == "Somewhat agree"
replace NGG2_PositiveAffect_num = 3 if NGG2positiveaffect == "Neither agree nor disagree"
replace NGG2_PositiveAffect_num = 2 if NGG2positiveaffect == "Somewhat disagree"
replace NGG2_PositiveAffect_num = 1 if NGG2positiveaffect == "Strongly disagree"
egen NGG_PositiveAffect_combined = rowmean(NGG_PositiveAffect_num NGG2_PositiveAffect_num)

* NGG - Investment Intention
gen NGG_InvestmentIntention_num = .
replace NGG_InvestmentIntention_num = 5 if NGGinvestmentintention == "Extremely likely"
replace NGG_InvestmentIntention_num = 4 if NGGinvestmentintention == "Somewhat likely"
replace NGG_InvestmentIntention_num = 3 if NGGinvestmentintention == "Neither likely nor unlikely"
replace NGG_InvestmentIntention_num = 2 if NGGinvestmentintention == "Somewhat unlikely"
replace NGG_InvestmentIntention_num = 1 if NGGinvestmentintention == "Extremely unlikely"

gen NGG2_InvestmentIntention_num = .
replace NGG2_InvestmentIntention_num = 5 if NGG2investmentintention == "Extremely likely"
replace NGG2_InvestmentIntention_num = 4 if NGG2investmentintention == "Somewhat likely"
replace NGG2_InvestmentIntention_num = 3 if NGG2investmentintention == "Neither likely nor unlikely"
replace NGG2_InvestmentIntention_num = 2 if NGG2investmentintention == "Somewhat unlikely"
replace NGG2_InvestmentIntention_num = 1 if NGG2investmentintention == "Extremely unlikely"
egen NGG_InvestmentIntention_combined = rowmean(NGG_InvestmentIntention_num NGG2_InvestmentIntention_num)

* NGG - Perceived Risk
gen NGG_PerceivedRisk_num = .
replace NGG_PerceivedRisk_num = 1 if NGGperceivedrisk == "Very low risk"
replace NGG_PerceivedRisk_num = 2 if NGGperceivedrisk == "Low risk"
replace NGG_PerceivedRisk_num = 3 if NGGperceivedrisk == "Moderate risk"
replace NGG_PerceivedRisk_num = 4 if NGGperceivedrisk == "High risk"
replace NGG_PerceivedRisk_num = 5 if NGGperceivedrisk == "Very high risk"

gen NGG2_PerceivedRisk_num = .
replace NGG2_PerceivedRisk_num = 1 if NGG2perceivedrisk == "Very low risk"
replace NGG2_PerceivedRisk_num = 2 if NGG2perceivedrisk == "Low risk"
replace NGG2_PerceivedRisk_num = 3 if NGG2perceivedrisk == "Moderate risk"
replace NGG2_PerceivedRisk_num = 4 if NGG2perceivedrisk == "High risk"
replace NGG2_PerceivedRisk_num = 5 if NGG2perceivedrisk == "Very high risk"
egen NGG_PerceivedRisk_combined = rowmean(NGG_PerceivedRisk_num NGG2_PerceivedRisk_num)

* NGG - Confidence
gen NGG_Confidence_num = .
replace NGG_Confidence_num = 5 if NGGconfidence == "Very confident"
replace NGG_Confidence_num = 4 if NGGconfidence == "Somewhat confident"
replace NGG_Confidence_num = 3 if NGGconfidence == "Neutral"
replace NGG_Confidence_num = 2 if NGGconfidence == "Somewhat not confident"
replace NGG_Confidence_num = 1 if NGGconfidence == "Not confident at all"

gen NGG2_Confidence_num = .
replace NGG2_Confidence_num = 5 if NGG2confidence == "Very confident"
replace NGG2_Confidence_num = 4 if NGG2confidence == "Somewhat confident"
replace NGG2_Confidence_num = 3 if NGG2confidence == "Neutral"
replace NGG2_Confidence_num = 2 if NGG2confidence == "Somewhat not confident"
replace NGG2_Confidence_num = 1 if NGG2confidence == "Not confident at all"
egen NGG_Confidence_combined = rowmean(NGG_Confidence_num NGG2_Confidence_num)

* NGG - Trust
gen NGG_Trust_num = .
replace NGG_Trust_num = 5 if NGGtrust == "Complete trust"
replace NGG_Trust_num = 4 if NGGtrust == "Some trust"
replace NGG_Trust_num = 3 if NGGtrust == "Neutral"
replace NGG_Trust_num = 2 if NGGtrust == "Little trust"
replace NGG_Trust_num = 1 if NGGtrust == "No trust at all"

gen NGG2_Trust_num = .
replace NGG2_Trust_num = 5 if NGG2trust == "Complete trust"
replace NGG2_Trust_num = 4 if NGG2trust == "Some trust"
replace NGG2_Trust_num = 3 if NGG2trust == "Neutral"
replace NGG2_Trust_num = 2 if NGG2trust == "Little trust"
replace NGG2_Trust_num = 1 if NGG2trust == "No trust at all"
egen NGG_Trust_combined = rowmean(NGG_Trust_num NGG2_Trust_num)

* NGG - Evaluation
gen NGG_Evaluation_num = .
replace NGG_Evaluation_num = 5 if NGGevaluation == "Excellent"
replace NGG_Evaluation_num = 4 if NGGevaluation == "Good"
replace NGG_Evaluation_num = 3 if NGGevaluation == "Neutral"
replace NGG_Evaluation_num = 2 if NGGevaluation == "Poor"
replace NGG_Evaluation_num = 1 if NGGevaluation == "Very poor"

gen NGG2_Evaluation_num = .
replace NGG2_Evaluation_num = 5 if NGG2evaluation == "Excellent"
replace NGG2_Evaluation_num = 4 if NGG2evaluation == "Good"
replace NGG2_Evaluation_num = 3 if NGG2evaluation == "Neutral"
replace NGG2_Evaluation_num = 2 if NGG2evaluation == "Poor"
replace NGG2_Evaluation_num = 1 if NGG2evaluation == "Very poor"
egen NGG_Evaluation_combined = rowmean(NGG_Evaluation_num NGG2_Evaluation_num)

* FSF - Positive Affect
gen FSF_PositiveAffect_num = .
replace FSF_PositiveAffect_num = 5 if FSFpositiveaffect == "Strongly agree"
replace FSF_PositiveAffect_num = 4 if FSFpositiveaffect == "Somewhat agree"
replace FSF_PositiveAffect_num = 3 if FSFpositiveaffect == "Neither agree nor disagree"
replace FSF_PositiveAffect_num = 2 if FSFpositiveaffect == "Somewhat disagree"
replace FSF_PositiveAffect_num = 1 if FSFpositiveaffect == "Strongly disagree"

gen FSF2_PositiveAffect_num = .
replace FSF2_PositiveAffect_num = 5 if FSF2positiveaffect == "Strongly agree"
replace FSF2_PositiveAffect_num = 4 if FSF2positiveaffect == "Somewhat agree"
replace FSF2_PositiveAffect_num = 3 if FSF2positiveaffect == "Neither agree nor disagree"
replace FSF2_PositiveAffect_num = 2 if FSF2positiveaffect == "Somewhat disagree"
replace FSF2_PositiveAffect_num = 1 if FSF2positiveaffect == "Strongly disagree"
egen FSF_PositiveAffect_combined = rowmean(FSF_PositiveAffect_num FSF2_PositiveAffect_num)

* FSF - Investment Intention
gen FSF_InvestmentIntention_num = .
replace FSF_InvestmentIntention_num = 5 if FSFinvestmentintention == "Extremely likely"
replace FSF_InvestmentIntention_num = 4 if FSFinvestmentintention == "Somewhat likely"
replace FSF_InvestmentIntention_num = 3 if FSFinvestmentintention == "Neither likely nor unlikely"
replace FSF_InvestmentIntention_num = 2 if FSFinvestmentintention == "Somewhat unlikely"
replace FSF_InvestmentIntention_num = 1 if FSFinvestmentintention == "Extremely unlikely"

gen FSF2_InvestmentIntention_num = .
replace FSF2_InvestmentIntention_num = 5 if FSF2investmentintention == "Extremely likely"
replace FSF2_InvestmentIntention_num = 4 if FSF2investmentintention == "Somewhat likely"
replace FSF2_InvestmentIntention_num = 3 if FSF2investmentintention == "Neither likely nor unlikely"
replace FSF2_InvestmentIntention_num = 2 if FSF2investmentintention == "Somewhat unlikely"
replace FSF2_InvestmentIntention_num = 1 if FSF2investmentintention == "Extremely unlikely"
egen FSF_InvestmentIntention_combined = rowmean(FSF_InvestmentIntention_num FSF2_InvestmentIntention_num)

* FSF - Perceived Risk
gen FSF_PerceivedRisk_num = .
replace FSF_PerceivedRisk_num = 1 if FSFperceivedrisk == "Very low risk"
replace FSF_PerceivedRisk_num = 2 if FSFperceivedrisk == "Low risk"
replace FSF_PerceivedRisk_num = 3 if FSFperceivedrisk == "Moderate risk"
replace FSF_PerceivedRisk_num = 4 if FSFperceivedrisk == "High risk"
replace FSF_PerceivedRisk_num = 5 if FSFperceivedrisk == "Very high risk"

gen FSF2_PerceivedRisk_num = .
replace FSF2_PerceivedRisk_num = 1 if FSF2perceivedrisk == "Very low risk"
replace FSF2_PerceivedRisk_num = 2 if FSF2perceivedrisk == "Low risk"
replace FSF2_PerceivedRisk_num = 3 if FSF2perceivedrisk == "Moderate risk"
replace FSF2_PerceivedRisk_num = 4 if FSF2perceivedrisk == "High risk"
replace FSF2_PerceivedRisk_num = 5 if FSF2perceivedrisk == "Very high risk"
egen FSF_PerceivedRisk_combined = rowmean(FSF_PerceivedRisk_num FSF2_PerceivedRisk_num)

* FSF - Confidence
gen FSF_Confidence_num = .
replace FSF_Confidence_num = 5 if FSFconfidence == "Very confident"
replace FSF_Confidence_num = 4 if FSFconfidence == "Somewhat confident"
replace FSF_Confidence_num = 3 if FSFconfidence == "Neutral"
replace FSF_Confidence_num = 2 if FSFconfidence == "Somewhat not confident"
replace FSF_Confidence_num = 1 if FSFconfidence == "Not confident at all"

gen FSF2_Confidence_num = .
replace FSF2_Confidence_num = 5 if FSF2confidence == "Very confident"
replace FSF2_Confidence_num = 4 if FSF2confidence == "Somewhat confident"
replace FSF2_Confidence_num = 3 if FSF2confidence == "Neutral"
replace FSF2_Confidence_num = 2 if FSF2confidence == "Somewhat not confident"
replace FSF2_Confidence_num = 1 if FSF2confidence == "Not confident at all"
egen FSF_Confidence_combined = rowmean(FSF_Confidence_num FSF2_Confidence_num)

* FSF - Trust
gen FSF_Trust_num = .
replace FSF_Trust_num = 5 if FSFtrust == "Complete trust"
replace FSF_Trust_num = 4 if FSFtrust == "Some trust"
replace FSF_Trust_num = 3 if FSFtrust == "Neutral"
replace FSF_Trust_num = 2 if FSFtrust == "Little trust"
replace FSF_Trust_num = 1 if FSFtrust == "No trust at all"

gen FSF2_Trust_num = .
replace FSF2_Trust_num = 5 if FSF2trust == "Complete trust"
replace FSF2_Trust_num = 4 if FSF2trust == "Some trust"
replace FSF2_Trust_num = 3 if FSF2trust == "Neutral"
replace FSF2_Trust_num = 2 if FSF2trust == "Little trust"
replace FSF2_Trust_num = 1 if FSF2trust == "No trust at all"
egen FSF_Trust_combined = rowmean(FSF_Trust_num FSF2_Trust_num)

* FSF - Evaluation
gen FSF_Evaluation_num = .
replace FSF_Evaluation_num = 5 if FSFevaluation == "Excellent"
replace FSF_Evaluation_num = 4 if FSFevaluation == "Good"
replace FSF_Evaluation_num = 3 if FSFevaluation == "Neutral"
replace FSF_Evaluation_num = 2 if FSFevaluation == "Poor"
replace FSF_Evaluation_num = 1 if FSFevaluation == "Very poor"

gen FSF2_Evaluation_num = .
replace FSF2_Evaluation_num = 5 if FSF2evaluation == "Excellent"
replace FSF2_Evaluation_num = 4 if FSF2evaluation == "Good"
replace FSF2_Evaluation_num = 3 if FSF2evaluation == "Neutral"
replace FSF2_Evaluation_num = 2 if FSF2evaluation == "Poor"
replace FSF2_Evaluation_num = 1 if FSF2evaluation == "Very poor"
egen FSF_Evaluation_combined = rowmean(FSF_Evaluation_num FSF2_Evaluation_num)

* FGG - Expected Returns
egen FGG_ReturnExpectations_combined = rowmean(FGGreturnexpectations FGG2returnexpectations)
* NSF - Expected Returns
egen NSF_ReturnExpectations_combined = rowmean(NSFreturnexpectations NSF2returnexpectations)
* NGG - Expected Returns
egen NGG_ReturnExpectations_combined = rowmean(NGGreturnexpectations NGG2returnexpectations)
* FSF - Expected Returns
egen FSF_ReturnExpectations_combined = rowmean(FSFreturnexpectations FSF2returnexpectations)

* Check summary statistics for the combined variables
summarize FGG_PositiveAffect_combined NGG_PositiveAffect_combined NSF_PositiveAffect_combined FSF_PositiveAffect_combined
summarize FGG_InvestmentIntention_combined NGG_InvestmentIntention_combined NSF_InvestmentIntention_combined FSF_InvestmentIntention_combined
summarize FGG_ReturnExpectations_combined NGG_ReturnExpectations_combined NSF_ReturnExpectations_combined FSF_ReturnExpectations_combined
summarize FGG_PerceivedRisk_combined NGG_PerceivedRisk_combined NSF_PerceivedRisk_combined FSF_PerceivedRisk_combined
summarize FGG_Confidence_combined NGG_Confidence_combined NSF_Confidence_combined FSF_Confidence_combined
summarize FGG_Trust_combined NGG_Trust_combined NSF_Trust_combined FSF_Trust_combined
summarize FGG_Evaluation_combined NGG_Evaluation_combined NSF_Evaluation_combined FSF_Evaluation_combined

*Independent samples t-test
* t-test for Positive Affect between Factual and Narrative Formats

ttest FGG_InvestmentIntention_combined == NSF_InvestmentIntention_combined

ttest FGG_PositiveAffect_combined == NSF_PositiveAffect_combined

ttest FGG_PerceivedRisk_combined == NSF_PerceivedRisk_combined

ttest FGG_Confidence_combined == NSF_Confidence_combined

ttest FGG_Trust_combined == NSF_Trust_combined

ttest FGG_Evaluation_combined == NSF_Evaluation_combined

*Correlation analysis

pwcorr FGG_PositiveAffect_combined FGG_InvestmentIntention_combined FGG_PerceivedRisk_combined FGG_Confidence_combined FGG_Trust_combined FGG_Evaluation_combined
pwcorr NSF_PositiveAffect_combined NSF_InvestmentIntention_combined NSF_PerceivedRisk_combined NSF_Confidence_combined NSF_Trust_combined NSF_Evaluation_combined
pwcorr NGG_PositiveAffect_combined NGG_InvestmentIntention_combined NGG_PerceivedRisk_combined NGG_Confidence_combined NGG_Trust_combined NGG_Evaluation_combined
pwcorr FSF_PositiveAffect_combined FSF_InvestmentIntention_combined FSF_PerceivedRisk_combined FSF_Confidence_combined FSF_Trust_combined FSF_Evaluation_combined

*Hypothesis testing
*Hypothesis 1:Positive affect difference between narrative and factual formats
*Regression analysis
regress FGG_PositiveAffect_combined FGG_InvestmentIntention_combined FGG_PerceivedRisk_combined FGG_Confidence_combined FGG_Trust_combined FGG_Evaluation_combined ///
FGG_ReturnExpectations_combined
regress NSF_PositiveAffect_combined NSF_InvestmentIntention_combined NSF_PerceivedRisk_combined NSF_ReturnExpectations_combined
regress NGG_PositiveAffect_combined NGG_InvestmentIntention_combined NGG_PerceivedRisk_combined NGG_Confidence_combined NGG_Trust_combined NGG_Evaluation_combined ///
NGG_ReturnExpectations_combined
regress FSF_PositiveAffect_combined FSF_InvestmentIntention_combined FSF_PerceivedRisk_combined FSF_Confidence_combined FSF_Trust_combined FSF_Evaluation_combined ///
FSF_ReturnExpectations_combined

*Hypothesis 2: Investment intention difference between narrative and factual formats
regress FGG_InvestmentIntention_combined FGG_PositiveAffect_combined FGG_PerceivedRisk_combined FGG_Confidence_combined FGG_Trust_combined FGG_Evaluation_combined ///
FGG_ReturnExpectations_combined
regress NSF_InvestmentIntention_combined NSF_PositiveAffect_combined NSF_PerceivedRisk_combined NSF_ReturnExpectations_combined
regress NGG_InvestmentIntention_combined NGG_PositiveAffect_combined NGG_PerceivedRisk_combined NGG_Confidence_combined NGG_Trust_combined NGG_Evaluation_combined ///
NGG_ReturnExpectations_combined
regress FSF_InvestmentIntention_combined FSF_PositiveAffect_combined FSF_PerceivedRisk_combined FSF_Confidence_combined FSF_Trust_combined FSF_Evaluation_combined ///
FSF_ReturnExpectations_combined

* Analysis of Demographic Variables
reg FGG_InvestmentIntention_combined gender age experience clients otherclients yesdifference
reg NGG_InvestmentIntention_combined gender age experience clients otherclients yesdifference
reg FSF_InvestmentIntention_combined gender age experience clients otherclients yesdifference
reg NSF_InvestmentIntention_combined gender age experience clients otherclients yesdifference




