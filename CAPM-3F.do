
 use "C:\Users\Baha\OneDrive\Desktop\data_essay 2011.dta"

describe

/* PART 1 */

/*QUESTION ONE*/

/* Generate a table of descriptive statistics (excluding string variables) */
tabstat year_ret b_mkt ivol_mm R2_mm b_mkt_3F b_smb b_hml ivol_3F R2_3F, ///
    statistics(mean sd min p25 median p75 max)
	
	/* QUESTION TWO */
	/* a) */
	
* Calculate the median of beta
egen median_beta = median(b_mkt)

* Filter observations where beta is below the median
gen below_median = (b_mkt < median_beta)

* Calculate the average returns for securities with beta below the median
summarize year_ret if below_median, meanonly
scalar avg_return_below_median = r(mean)

* Display the result
di "Average returns for securities with beta below the median: " avg_return_below_median

 /* b) */
 
/* Calculate the median of b_mkt */
quietly summarize b_mkt, detail
scalar median_b_mkt = r(p50)

/* Generate a new variable for high and low beta */
gen high_beta = (b_mkt > median_b_mkt)

/* Verify the new variable */
tab high_beta

/* Estimate average returns for high and low beta securities */
summarize year_ret if high_beta == 1, meanonly
scalar avg_return_high_beta = r(mean)

summarize year_ret if high_beta == 0, meanonly
scalar avg_return_low_beta = r(mean)

/* Perform a t-test for the difference in average returns */
ttest year_ret, by(high_beta)

/* Display the results */
di "Average return for high beta securities: " avg_return_high_beta
di "Average return for low beta securities: " avg_return_low_beta

 /*QUESTION THREE */
 
/* Run the regression */
regress year_ret tvol

/* Run the regression*/
regress year_ret b_mkt

/* Run the regression */
regress year_ret b_mkt_3F b_smb b_hml

 /* QUESTION FOUR */
 
/* Run the regression and calculate the confidence interval */
regress year_ret tvol
/* Calculate and display the 95% confidence interval for the coefficient of tvol */
di "95% Confidence Interval for the Coefficient of tvol: " ///
    _b[tvol] - invttail(e(df_r), 0.025) * _se[tvol], ///
    _b[tvol] + invttail(e(df_r), 0.025) * _se[tvol]
	
/* QUESTION FIVE */
	
/* Run the regression for the first case (question 4) */
regress year_ret b_mkt
/* Interpret the results and construct confidence intervals */
di "Regression Results for b_mkt_numeric:"
di "Estimated coefficient: " _b[b_mkt]
di "95% Confidence Interval for the Coefficient of b_mkt: " ///
    _b[b_mkt] - invttail(e(df_r), 0.025) * _se[b_mkt], ///
    _b[b_mkt] + invttail(e(df_r), 0.025) * _se[b_mkt]
	
	
/* Run the regression for the second case (question 5) */
regress year_ret b_mkt_3F b_smb b_hml

/* Interpret the results and construct confidence intervals */
di "Regression Results for b_mkt_3F_numeric:"
di "Estimated coefficient: " _b[b_mkt_3F]
di "95% Confidence Interval for the Coefficient of b_mkt: " ///
    _b[b_mkt_3F] - invttail(e(df_r), 0.025) * _se[b_mkt_3F], ///
    _b[b_mkt_3F] + invttail(e(df_r), 0.025) * _se[b_mkt_3F]
	
di "Regression Results for b_smb_numeric:"
di "Estimated coefficient: " _b[b_smb]
di "95% Confidence Interval for the Coefficient of b_mkt: " ///
    _b[b_smb] - invttail(e(df_r), 0.025) * _se[b_smb], ///
    _b[b_smb] + invttail(e(df_r), 0.025) * _se[b_smb]

di "Regression Results for b_hml_numeric:"
di "Estimated coefficient: " _b[b_hml]
di "95% Confidence Interval for the Coefficient of b_mkt: " ///
    _b[b_hml] - invttail(e(df_r), 0.025) * _se[b_hml], ///
    _b[b_hml] + invttail(e(df_r), 0.025) * _se[b_hml]
	
/* PART TWO */

/* Run the regression for the first case (question 4) */
regress year_ret b_mkt ivol_mm
/* Interpret the results and construct confidence intervals */
di "Regression Results for b_mkt_numeric:"
di "Estimated coefficient: " _b[b_mkt]
di "95% Confidence Interval for the Coefficient of b_mkt: " ///
    _b[b_mkt] - invttail(e(df_r), 0.025) * _se[b_mkt], ///
    _b[b_mkt] + invttail(e(df_r), 0.025) * _se[b_mkt]
di "95% Confidence Interval for the Coefficient of ivol_mm: " ///
    _b[ivol_mm] - invttail(e(df_r), 0.025) * _se[ivol_mm], ///
    _b[ivol_mm] + invttail(e(df_r), 0.025) * _se[ivol_mm]

/* Check the improvement in explanatory capacity */
regress year_ret b_mkt
di "R-squared before adding ivol: " e(r2)
regress year_ret b_mkt ivol_mm
di "R-squared after adding ivol: " e(r2)

/* Run the regression for the second case (question 5) */
regress year_ret b_mkt_3F b_smb b_hml ivol_3F
/* Interpret the results and construct confidence intervals */
di "Regression Results for b_mkt_3F_numeric:"
di "Estimated coefficient: " _b[b_mkt_3F]
di "95% Confidence Interval for the Coefficient of b_mkt: " ///
    _b[b_mkt_3F] - invttail(e(df_r), 0.025) * _se[b_mkt_3F], ///
    _b[b_mkt_3F] + invttail(e(df_r), 0.025) * _se[b_mkt_3F]
	
di "Regression Results for b_smb_numeric:"
di "Estimated coefficient: " _b[b_smb]
di "95% Confidence Interval for the Coefficient of b_mkt: " ///
    _b[b_smb] - invttail(e(df_r), 0.025) * _se[b_smb], ///
    _b[b_smb] + invttail(e(df_r), 0.025) * _se[b_smb]

di "Regression Results for b_hml_numeric:"
di "Estimated coefficient: " _b[b_hml]
di "95% Confidence Interval for the Coefficient of b_mkt: " ///
    _b[b_hml] - invttail(e(df_r), 0.025) * _se[b_hml], ///
    _b[b_hml] + invttail(e(df_r), 0.025) * _se[b_hml]
	
di "Regression Results for ivol_3F_numeric:"
di "Estimated coefficient: " _b[ivol_3F]
di "95% Confidence Interval for the Coefficient of b_mkt: " ///
    _b[ivol_3F] - invttail(e(df_r), 0.025) * _se[ivol_3F], ///
    _b[ivol_3F] + invttail(e(df_r), 0.025) * _se[ivol_3F]
	
/* Check the improvement in explanatory capacity */
regress year_ret b_mkt
di "R-squared before adding ivol: " e(r2)
regress year_ret b_mkt_3F b_smb b_hml ivol_3F
di "R-squared after adding ivol: " e(r2)

/* Sort your dataset by yyyy */
sort year_ret

/* Calculate percentiles for winsorizing */
egen p1 = pctile(b_mkt), p(1)
egen p99 = pctile(b_mkt), p(99)

/* Winsorize b_mkt variable */
gen b_mkt_winsor = b_mkt
replace b_mkt_winsor = p1 if b_mkt < p1
replace b_mkt_winsor = p99 if b_mkt > p99

/* Repeat the process for other variables */
egen p1_3F = pctile(b_mkt_3F), p(1)
egen p99_3F = pctile(b_mkt_3F), p(99)
gen b_mkt_3F_winsor = b_mkt_3F
replace b_mkt_3F_winsor = p1_3F if b_mkt_3F < p1_3F
replace b_mkt_3F_winsor = p99_3F if b_mkt_3F > p99_3F

egen p1_ivol_3F = pctile(ivol_3F), p(1)
egen p99_ivol_3F = pctile(ivol_3F), p(99)
gen ivol_3F_winsor = ivol_3F
replace ivol_3F_winsor = p1_ivol_3F if ivol_3F < p1_ivol_3F
replace ivol_3F_winsor = p99_ivol_3F if ivol_3F > p99_ivol_3F

/* Run regressions with the winsorized variables */
regress year_ret b_mkt_winsor
regress year_ret b_mkt_winsor b_mkt_3F_winsor
regress year_ret b_mkt_winsor ivol_3F_winsor
