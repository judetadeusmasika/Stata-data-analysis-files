
*Load the dataset 
use "C:\Users\Baha\OneDrive\Documents\Master_dataset.dta",clear
describe
*Kolmogorov Smirnov test for normality in the data

ksmirnov Corp_strat_1, by(hypo_prox)

ksmirnov Corp_strat_2, by(hypo_prox)

ksmirnov Corp_strat_3, by(hypo_prox)

ksmirnov Corp_strat_4, by(hypo_prox)

ksmirnov Corp_strat_5, by(hypo_prox)

ksmirnov Corp_strat_6, by(hypo_prox)

ksmirnov Corp_strat_7, by(hypo_prox)

ksmirnov Corp_strat_8, by(hypo_prox)


*Shapiro Wilk test for normality in the data

swilk Corp_strat_1 Corp_strat_2 Corp_strat_3 Corp_strat_4 Corp_strat_5 ///
 Corp_strat_6 Corp_strat_7 Corp_strat_8
 
 *Common Method Bias (CMB) Test
*For Harman’s single-factor test

factor Corp_strat_1 Corp_strat_2 Corp_strat_3 Corp_strat_4 Corp_strat_5 Corp_strat_6 Corp_strat_7 Corp_strat_8

* Reliability and Validity
*Consistency 
*Cronbach Alpha
alpha Corp_strat_1 Corp_strat_2 Corp_strat_3 Corp_strat_4 Corp_strat_5 Corp_strat_6 Corp_strat_7 Corp_strat_8

*Validity
*Exploratory factor analysis
factor Corp_strat_1 Corp_strat_2 Corp_strat_3 Corp_strat_4 Corp_strat_5 Corp_strat_6 Corp_strat_7 Corp_strat_8


*Two-Tailed T-tests and Interaction Plot

/* T-tests */
ttest Corp_strat_1, by(hypo_prox)

ttest Corp_strat_2, by(hypo_prox)

ttest Corp_strat_3, by(hypo_prox)

ttest Corp_strat_4, by(hypo_prox)

ttest Corp_strat_5, by(hypo_prox)

ttest Corp_strat_6, by(hypo_prox)

ttest Corp_strat_7, by(hypo_prox)

ttest Corp_strat_8, by(hypo_prox)


/* Interaction Plot */
twoway (scatter Corp_strat_1 hypo_prox) (lfit Corp_strat_1 hypo_prox), xlabel(0(1)10) ylabel(0(1)10)

twoway (scatter Corp_strat_8 hypo_prox) (lfit Corp_strat_8 hypo_prox), xlabel(0(1)10) ylabel(0(1)10)

/* Simple Regression */
regress Corp_strat_1 hypo_prox
/* Interaction in Graph */
twoway (scatter Corp_strat_1 hypo_prox) (lfit Corp_strat_1 hypo_prox), xlabel(0(1)10) ylabel(0(1)10)

*Linear Regression analyses
/* Adding Control Variables One by One */
regress Corp_strat_1 hypo_prox CC_concern
regress Corp_strat_1 hypo_prox CC_awareness
regress Corp_strat_1 hypo_prox CC_riskperception

*T-test for Proximity/Distance and its Association with 8 Strategies

ttest Corp_strat_1, by(hypo_prox)

ttest Corp_strat_2, by(hypo_prox)

ttest Corp_strat_3, by(hypo_prox)

ttest Corp_strat_4, by(hypo_prox)

ttest Corp_strat_5, by(hypo_prox)

ttest Corp_strat_6, by(hypo_prox)

ttest Corp_strat_7, by(hypo_prox)

ttest Corp_strat_8, by(hypo_prox)

* Bonferroni Test
/* For multiple comparisons */
testparm hypo_prox

*MANCOVA
/* Multivariate Analysis of Covariance */
manova Corp_strat_1 = hypo_prox 
manova Corp_strat_2 = hypo_prox 
manova Corp_strat_3 = hypo_prox 
manova Corp_strat_4 = hypo_prox 
manova Corp_strat_5 = hypo_prox 
manova Corp_strat_6 = hypo_prox 
manova Corp_strat_7 = hypo_prox 
manova Corp_strat_8 = hypo_prox 

/* Probit */
probit Corp_strat_1 hypo_prox 
probit Corp_strat_2 hypo_prox 
probit Corp_strat_3 hypo_prox 

probit Corp_strat_4 hypo_prox 

probit Corp_strat_5 hypo_prox 

probit Corp_strat_6 hypo_prox 

probit Corp_strat_7 hypo_prox 

probit Corp_strat_8 hypo_prox 

/* Logit */
logit Corp_strat_1 hypo_prox 

logit Corp_strat_2 hypo_prox 

logit Corp_strat_3 hypo_prox 

logit Corp_strat_4 hypo_prox 

logit Corp_strat_5 hypo_prox 

logit Corp_strat_6 hypo_prox 

logit Corp_strat_7 hypo_prox 

logit Corp_strat_8 hypo_prox 





