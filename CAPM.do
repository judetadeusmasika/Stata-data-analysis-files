
use "C:\Users\Baha\Downloads\Essay_cleaned.dta" 

describe

/* Generate a table of descriptive statistics (excluding string variables) */
tabstat year_ret b_mkt_numeric ivol_mm_numeric R2_mm_numeric b_mkt_3F_numeric b_smb_numeric b_hml_numeric ivol_3F_numeric R2_3F_numeric, ///
    statistics(mean sd min p25 median p75 max)
	
* Calculate the median of beta
egen median_beta = median(b_mkt_numeric)

* Filter observations where beta is below the median
gen below_median = (b_mkt_numeric < median_beta)

* Calculate the average returns for securities with beta below the median
summarize year_ret if below_median, meanonly
scalar avg_return_below_median = r(mean)

* Display the result
di "Average returns for securities with beta below the median: " avg_return_below_median


/* Calculate the median of b_mkt_numeric */
quietly summarize b_mkt_numeric, detail
scalar median_b_mkt = r(p50)

/* Generate a new variable for high and low beta */
gen high_beta = (b_mkt_numeric > median_b_mkt)

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

/* Run the regression */
regress year_ret tvol_numeric

/* Run the regression*/
regress year_ret b_mkt_numeric

/* Convert b_mkt to numeric */
destring b_smb, generate(b_smb_numeric) force

/* Run the regression */
regress year_ret b_mkt_3F_numeric b_smb_numeric b_hml_numeric

/* PART TWO */
/* Run the regression and calculate the confidence interval */
regress year_ret tvol_numeric
/* Calculate and display the 95% confidence interval for the coefficient of tvol */
di "95% Confidence Interval for the Coefficient of tvol: " ///
    _b[tvol_numeric] - invttail(e(df_r), 0.025) * _se[tvol_numeric], ///
    _b[tvol_numeric] + invttail(e(df_r), 0.025) * _se[tvol_numeric]
	
	
/* Run the regression for the first case (question 4) */
regress year_ret b_mkt_numeric
/* Interpret the results and construct confidence intervals */
di "Regression Results for b_mkt_numeric:"
di "Estimated coefficient: " _b[b_mkt_numeric]
di "95% Confidence Interval for the Coefficient of b_mkt: " ///
    _b[b_mkt_numeric] - invttail(e(df_r), 0.025) * _se[b_mkt_numeric], ///
    _b[b_mkt_numeric] + invttail(e(df_r), 0.025) * _se[b_mkt_numeric]
	
	
/* Run the regression for the second case (question 5) */
regress year_ret b_mkt_3F_numeric b_smb_numeric b_hml_numeric

/* Interpret the results and construct confidence intervals */
di "Regression Results for b_mkt_3F_numeric:"
di "Estimated coefficient: " _b[b_mkt_3F_numeric]
di "95% Confidence Interval for the Coefficient of b_mkt: " ///
    _b[b_mkt_3F_numeric] - invttail(e(df_r), 0.025) * _se[b_mkt_3F_numeric], ///
    _b[b_mkt_3F_numeric] + invttail(e(df_r), 0.025) * _se[b_mkt_3F_numeric]
	
di "Regression Results for b_smb_numeric:"
di "Estimated coefficient: " _b[b_smb_numeric]
di "95% Confidence Interval for the Coefficient of b_mkt: " ///
    _b[b_smb_numeric] - invttail(e(df_r), 0.025) * _se[b_smb_numeric], ///
    _b[b_smb_numeric] + invttail(e(df_r), 0.025) * _se[b_smb_numeric]

di "Regression Results for b_hml_numeric:"
di "Estimated coefficient: " _b[b_hml_numeric]
di "95% Confidence Interval for the Coefficient of b_mkt: " ///
    _b[b_hml_numeric] - invttail(e(df_r), 0.025) * _se[b_hml_numeric], ///
    _b[b_hml_numeric] + invttail(e(df_r), 0.025) * _se[b_hml_numeric]
	

/* Run the regression for the first case (question 4) */
regress year_ret b_mkt_numeric ivol_mm_numeric
/* Interpret the results and construct confidence intervals */
di "Regression Results for b_mkt_numeric:"
di "Estimated coefficient: " _b[b_mkt_numeric]
di "95% Confidence Interval for the Coefficient of b_mkt: " ///
    _b[b_mkt_numeric] - invttail(e(df_r), 0.025) * _se[b_mkt_numeric], ///
    _b[b_mkt_numeric] + invttail(e(df_r), 0.025) * _se[b_mkt_numeric]
di "95% Confidence Interval for the Coefficient of ivol_mm: " ///
    _b[ivol_mm_numeric] - invttail(e(df_r), 0.025) * _se[ivol_mm_numeric], ///
    _b[ivol_mm_numeric] + invttail(e(df_r), 0.025) * _se[ivol_mm_numeric]

/* Check the improvement in explanatory capacity */
regress year_ret b_mkt_numeric
di "R-squared before adding ivol: " e(r2)
regress year_ret b_mkt_numeric ivol_mm_numeric
di "R-squared after adding ivol: " e(r2)

/* Run the regression for the second case (question 5) */
regress year_ret b_mkt_3F_numeric b_smb_numeric b_hml_numeric ivol_3F_numeric
/* Interpret the results and construct confidence intervals */
di "Regression Results for b_mkt_3F_numeric:"
di "Estimated coefficient: " _b[b_mkt_3F_numeric]
di "95% Confidence Interval for the Coefficient of b_mkt: " ///
    _b[b_mkt_3F_numeric] - invttail(e(df_r), 0.025) * _se[b_mkt_3F_numeric], ///
    _b[b_mkt_3F_numeric] + invttail(e(df_r), 0.025) * _se[b_mkt_3F_numeric]
	
di "Regression Results for b_smb_numeric:"
di "Estimated coefficient: " _b[b_smb_numeric]
di "95% Confidence Interval for the Coefficient of b_mkt: " ///
    _b[b_smb_numeric] - invttail(e(df_r), 0.025) * _se[b_smb_numeric], ///
    _b[b_smb_numeric] + invttail(e(df_r), 0.025) * _se[b_smb_numeric]

di "Regression Results for b_hml_numeric:"
di "Estimated coefficient: " _b[b_hml_numeric]
di "95% Confidence Interval for the Coefficient of b_mkt: " ///
    _b[b_hml_numeric] - invttail(e(df_r), 0.025) * _se[b_hml_numeric], ///
    _b[b_hml_numeric] + invttail(e(df_r), 0.025) * _se[b_hml_numeric]
	
di "Regression Results for ivol_3F_numeric:"
di "Estimated coefficient: " _b[ivol_3F_numeric]
di "95% Confidence Interval for the Coefficient of b_mkt: " ///
    _b[ivol_3F_numeric] - invttail(e(df_r), 0.025) * _se[ivol_3F_numeric], ///
    _b[ivol_3F_numeric] + invttail(e(df_r), 0.025) * _se[ivol_3F_numeric]
	
/* Check the improvement in explanatory capacity */
regress year_ret b_mkt_numeric
di "R-squared before adding ivol: " e(r2)
regress year_ret b_mkt_3F_numeric b_smb_numeric b_hml_numeric ivol_3F_numeric
di "R-squared after adding ivol: " e(r2)

/* Winsorize the variables you are interested in */
winsor b_mkt_numeric, p(0.01 0.99)
winsor ivol_mm_numeric, p(0.01 0.99)
winsor b_mkt_3F_numeric, p(0.01 0.99)
winsor b_smb_numeric, p(0.01 0.99)
winsor year_ret, p(0.01 0.99)
winsor ivol_3F_numeric, p(0.01 0.99)


