
import excel "C:\Users\Baha\OneDrive\Desktop\pisa.xlsx", sheet("pisa") firstrow

gen pisa = (math + read + scien) / 3
drop math read scien
save pisa.dta, replace

/* Question one */
regress pisa F
regress pisa escs
regress pisa bullied
regress pisa teachint
regress pisa quiet
regress pisa comp
regress pisa mometh
regress pisa dadeth
regress pisa lang
regress pisa books
regress pisa late
regress pisa scchange
regress pisa pisa

ssc install outreg2
outreg2 using summary_table, replace

/* Question two */
gen mom_belgium = 0
replace mom_belgium = 1 if mometh == 1
tab mom_belgium

scatter pisa pared, title("Scatterplot of PISA Against Pared") ///
    ytitle("PISA Score") xtitle("Highest Parental Education (Years of Schooling)") ///
    mcolor(mom_belgium == 0 ? red : blue) msize(tiny) ///
    legend(order(1 "Moms not born in Belgium" 2 "Moms born in Belgium"))

gen mom_belgium_pared = mom_belgium * pared

regress pisa pared mom_belgium mom_belgium_pared

/* Test if the interaction term is statistically significant */
test mom_belgium_pared

/* Question three */

oneway pisa scchange, bonferroni tabulate

/* Question four */

/* Fit a linear model */
regress pisa bullied

/* Fit a quadratic model */
gen bullied2 = bullied^2
regress pisa bullied bullied2

/* Fit a cubic model */
gen bullied3 = bullied^3
regress pisa bullied bullied2 bullied3

/* Likelihood ratio tests */
test bullied2
test bullied3

gen dad_belgium = 1

/* Fit the regression model */
regress pisa escs bullied teachint F ///
       mom_belgium dad_belgium lang quiet comp ///
       tv music books late scchange

 /* Display the estimated model */
di "Estimated Model: "
di "pisa = " _b[_cons] " + " ///
   _b[escs] "*escs + " ///
   _b[bullied] "*bullied + " ///
   _b[teachint] "*teachint + " ///
   _b[F] "*F + " ///
   _b[mom_belgium] "*mom_belgium + " ///
   _b[dad_belgium] "*dad_belgium + " ///
   _b[lang] "*lang + " ///
   _b[quiet] "*quiet + " ///
   _b[comp] "*comp + " ///
   _b[tv] "*tv + " ///
   _b[music] "*music + " ///
   _b[books] "*books + " ///
   _b[late] "*late + " ///
   _b[scchange] "*scchange"

/* Fit the regression model */
regress pisa escs bullied teachint F ///
       mom_belgium dad_belgium lang quiet comp ///
       tv music books late scchange

/* Display summary statistics including p-values */
esttab, stats(coef p) star(* 0.05)

/* Identify non-significant variables */
di "Non-significant variables: "
foreach var in escs bullied teachint F ///
               mom_belgium dad_belgium lang quiet comp ///
               tv music books late scchange {
    local pval : di round(_b[`var'], 0.0001)
    if `pval' > 0.05 {
        di "`var' (p-value = " `pval' ")"
    }
}

/* Calculate VIF for each variable */
foreach var in escs bullied teachint F ///
               mom_belgium dad_belgium lang quiet comp ///
               tv music books late scchange {
    quietly regress `var' escs bullied teachint F ///
                    mom_belgium dad_belgium lang quiet comp ///
                    tv music books late scchange
    di "VIF for `var': " 1 / (1 - r(r2))
}

/* Fit the regression model */
regress pisa escs bullied teachint F ///
       mom_belgium dad_belgium lang quiet comp ///
       tv music books late scchange

/* Generate residuals and predicted values */
predict residuals, residuals
predict yhat, xb

/* Scatterplot of residuals against predicted values */
scatter residuals yhat, title("Residuals vs Predicted Values") ///
    ytitle("Residuals") xtitle("Predicted Values") ///
    mcolor(blue) ///
    msymbol(O) ///
    legend(off)

/* Generate residuals */

/* Histogram of residuals */
hist residuals, normal title("Histogram of Residuals") ///
    ytitle("Frequency") xtitle("Residuals") ///
    density

/* Q-Q plot of residuals */
qnorm residuals, title("Q-Q Plot of Residuals") ///
    ytitle("Theoretical Quantiles") xtitle("Sample Quantiles") ///
    graphregion(color(white)) bgcolor(white)
	
/* Create binary variables based on the number of musical instruments */
gen M0 = (music == 0)
gen M1 = (music == 1)
gen M2 = (music == 2)
gen M3 = (music >= 3)

/* Fit the modified regression model */
regress pisa escs bullied teachint F ///
       mom_belgium dad_belgium lang quiet comp ///
       tv M0 M1 M2 M3 books late scchange

/* Display the estimated model */
di "Estimated Model with New Musical Instrument Variables: "
di "pisa = " _b[_cons] " + " ///
   _b[escs] "*escs + " ///
   _b[bullied] "*bullied + " ///
   _b[teachint] "*teachint + " ///
   _b[F] "*F + " ///
   _b[mom_belgium] "*mom_belgium + " ///
   _b[dad_belgium] "*dad_belgium + " ///
   _b[lang] "*lang + " ///
   _b[quiet] "*quiet + " ///
   _b[comp] "*comp + " ///
   _b[tv] "*tv + " ///
   _b[M0] "*M0 + " ///
   _b[M1] "*M1 + " ///
   _b[M2] "*M2 + " ///
   _b[M3] "*M3 + " ///
   _b[books] "*books + " ///
   _b[late] "*late + " ///
   _b[scchange] "*scchange"

 /* Set M1 as the reference category using fvset */
fvset base 1 M1
/* Fit the regression model with M1 as the reference category */
regress pisa i.music##(i.M0 i.M2 i.M3) escs bullied ///
       teachint F mom_belgium dad_belgium lang ///
       quiet comp tv books late scchange
/* Clear the factor variable settings */
fvset clear

/* Fit the regression model */
regress pisa i.music##(i.M0 i.M2 i.M3) escs bullied ///
       teachint F mom_belgium dad_belgium lang ///
       quiet comp tv books late scchange

/* Calculate the confidence interval for the difference between 5 and 0 musical instruments */
local contrast_var 5
local reference_var 0

/* Calculate the difference in the means */
local mean_diff _b[i.M`contrast_var'] - _b[i.M`reference_var']

/* Calculate the standard error of the difference */
local se_diff sqrt(_se[i.M`contrast_var']^2 + _se[i.M`reference_var']^2)

/* Set the confidence level */
local confidence_level 0.99

/* Calculate the margin of error */
local margin_of_error invttail(e(df_r), (1 - `confidence_level') / 2) * `se_diff'

/* Calculate the confidence interval */
local lower_bound `mean_diff' - `margin_of_error'
local upper_bound `mean_diff' + `margin_of_error'

/* Display the confidence interval */
di "99% Confidence Interval for the Difference: (" `lower_bound' ", " `upper_bound' ")"

/* Specify the levels for comparison */
local level_1 1
local level_2 2

/* Test the difference between 1 and 2 musical instruments using lincom */
lincom _b[i.M`level_1'] - _b[i.M`level_2']


/* Display the results with a significance level of 0.01 */
di "p-value: " _hat
di "Is the difference significant at α = 0.01? " (_hat < 0.01)

/* Fit a logistic regression model */
logit RP late escs bullied teachint F mom_belgium dad_belgium lang ///
     quiet comp tv music books scchange, robust

/* Display the logistic regression results */
di "Logistic Regression Results:"
estimates table, eform

/* Predict the probabilities and add them to the dataset */
predict prob_repeating, pr

/* Display summary statistics of the predicted probabilities */
su prob_repeating

/* Compute the marginal effect for the variable 'late' */
margins, dydx(late)

/* Display the marginal effect */
marginsreport

/* Create a predicted probability plot for 'late' */
twoway (scatter prob_repeating late, msymbol(o)) ///
       (lowess prob_repeating late, lpattern(dash)), ///
       title("Predicted Probability Plot for Late Arrival") ///
       ytitle("Predicted Probability of Repeating a Grade") ///
       xtitle("Late Arrival") ///
       legend(off)
