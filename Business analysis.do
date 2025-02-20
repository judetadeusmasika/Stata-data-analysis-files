
** Load the data and Inspect it

** GE

import excel "C:\Users\lenovo\Desktop\GE.xlsx", sheet("Sheet1") firstrow clear

describe

list in 1/5  // Preview first 5 rows

** Run OLS Regressions for Each Dependent Variable
** First, estimate separate regressions for Short-Term Debt and Long-Term Debt.
*Short term debt

 reg ST_Debt_GE Federal_Funds_Rate GDP_Growth ROA_GE Firm_Size // Firm size and intercept significant

*Long term debt

reg LT_Debt_GE Y_Treasury_Yield GDP_Growth ROA_GE Firm_Size // ROA and intercept significant

predict res1, resid // For ST Debt
predict res2, resid // For LT Debt

** test for correlation of error terms

asdoc pwcorr res1 res2, sig // the correlation is high and higly significant, so the SUR model is appropriate instead of separate OLS models

** Run SUR Model 
** SUR models account for potential correlations in the error terms of different regressions.

asdoc sureg (ST_Debt_GE Federal_Funds_Rate GDP_Growth ROA_GE Firm_Size) ///
      (LT_Debt_GE Y_Treasury_Yield GDP_Growth ROA_GE Firm_Size)

** check for overall model significance
test [ST_Debt_GE]Federal_Funds_Rate ///
     [LT_Debt_GE]Y_Treasury_Yield ///
     [ST_Debt_GE]GDP_Growth ///
     [LT_Debt_GE]GDP_Growth
	 
** Check Cross-Equation Correlation of Errors
**To assess if SUR improves efficiency, check the covariance matrix of residuals
predict res11, resid equation(ST_Debt_GE)
predict res22, resid equation(LT_Debt_GE)
asdoc pwcorr res11 res22, sig // a highly negative and significant correlation; SUR justified to be efficient

** Test for multicollinearity

reg ST_Debt_GE Federal_Funds_Rate GDP_Growth ROA_GE Firm_Size
asdoc vif  // Check VIF for short-term debt model

reg LT_Debt_GE Y_Treasury_Yield GDP_Growth ROA_GE Firm_Size
asdoc vif  // Check VIF for long-term debt model


** Test for Heteroskedasticity
** Run a Breusch-Pagan Test to check if the variance of residuals is constant.

reg ST_Debt_GE Federal_Funds_Rate GDP_Growth ROA_GE Firm_Size
estat hettest // check for heteroskedasticity of Short-term debt model

reg LT_Debt_GE Y_Treasury_Yield GDP_Growth ROA_GE Firm_Size
estat hettest  // Check heteroskedasticity for long-term debt model

** Visualize some relationships
* ROA_GE

scatter ST_Debt_GE ROA_GE || lfit ST_Debt_GE ROA_GE, ///
    title("Relationship Between Short-Term Debt and ROA (GE)") ///
    xlabel(, grid) ylabel(, grid) ///
    xtitle("Return on Assets (ROA)") ///
    ytitle("Short-Term Debt (%)") ///
    legend(order(1 "Data Points" 2 "Fitted Line"))

scatter LT_Debt_GE ROA_GE || lfit LT_Debt_GE ROA_GE, ///
    title("Relationship Between Long-Term Debt and ROA (GE)") ///
    xlabel(, grid) ylabel(, grid) ///
    xtitle("Return on Assets (ROA)") ///
    ytitle("Long-Term Debt (%)") ///
    legend(order(1 "Data Points" 2 "Fitted Line"))


** GECS

import excel "C:\Users\lenovo\Desktop\GECS.xlsx", sheet("Sheet1") firstrow clear

describe, detail

list in 1/7 // preview the first 7 observations


** First, estimate separate regressions for Short-Term Debt and Long-Term Debt.
*Short term debt

 reg ST_Debt_GECS Federal_Funds_Rate GDP_Growth ROA_GECS Firm_Size // Firm size and intercept significant

*Long term debt

reg LT_Debt_GECS Y_Treasury_Yield GDP_Growth ROA_GECS Firm_Size // ROA and intercept significant

predict res1, resid // For ST Debt
predict res2, resid // For LT Debt

** test for correlation of error terms

pwcorr res1 res2, sig // the correlation is high and higly significant, so the SUR model is appropriate instead of separate OLS models

** Run SUR Model 
** SUR models account for potential correlations in the error terms of different regressions.

asdoc sureg (ST_Debt_GECS Federal_Funds_Rate GDP_Growth ROA_GECS Firm_Size) ///
      (LT_Debt_GECS Y_Treasury_Yield GDP_Growth ROA_GECS Firm_Size)

** check for overall model significance
test [ST_Debt_GECS]Federal_Funds_Rate ///
     [LT_Debt_GECS]Y_Treasury_Yield ///
     [ST_Debt_GECS]GDP_Growth ///
     [LT_Debt_GECS]GDP_Growth
	 
** Check Cross-Equation Correlation of Errors
**To assess if SUR improves efficiency, check the covariance matrix of residuals
predict res11, resid equation(ST_Debt_GECS)
predict res22, resid equation(LT_Debt_GECS)
asdoc pwcorr res11 res22, sig // a highly negative and significant correlation; SUR justified to be efficient

** Test for multicollinearity

reg ST_Debt_GECS Federal_Funds_Rate GDP_Growth ROA_GECS Firm_Size
asdoc vif  // Check VIF for short-term debt model

reg LT_Debt_GECS Y_Treasury_Yield GDP_Growth ROA_GECS Firm_Size
asdoc vif  // Check VIF for long-term debt model

** Test for Heteroskedasticity
** Run a Breusch-Pagan Test to check if the variance of residuals is constant.

reg ST_Debt_GECS Federal_Funds_Rate GDP_Growth ROA_GECS Firm_Size
estat hettest // check for heteroskedasticity of Short-term debt model

reg LT_Debt_GECS Y_Treasury_Yield GDP_Growth ROA_GECS Firm_Size
estat hettest  // Check heteroskedasticity for long-term debt model


** Visualize some relationships
* ROA_GECS

scatter ST_Debt_GECS ROA_GECS || lfit ST_Debt_GECS ROA_GECS, ///
    title("Relationship Between Short-Term Debt and ROA (GECS)") ///
    xlabel(, grid) ylabel(, grid) ///
    xtitle("Return on Assets (ROA)") ///
    ytitle("Short-Term Debt (%)") ///
    legend(order(1 "Data Points" 2 "Fitted Line"))

scatter LT_Debt_GECS ROA_GECS || lfit LT_Debt_GECS ROA_GECS, ///
    title("Relationship Between Long-Term Debt and ROA (GECS)") ///
    xlabel(, grid) ylabel(, grid) ///
    xtitle("Return on Assets (ROA)") ///
    ytitle("Long-Term Debt (%)") ///
    legend(order(1 "Data Points" 2 "Fitted Line"))








