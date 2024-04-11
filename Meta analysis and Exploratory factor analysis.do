

*Task 1

*Load the dataset to be used
use "C:\Users\Baha\Downloads\pupiliq.dta", clear
describe, detail
*declare meta-analysis model
meta set stdmdiff se, studylabel(studylbl) eslabel(Std. Mean Diff.)
* Conduct the meta-analysis
meta summarize
* Display the meta-analysis results
meta forestplot, eform
*Heterogeneity(summary measures and homegeneity tests, subgroup analysis, meta-regression and postestimation:bubble plot)
meta forestplot, subgroup(week1)
*Meta regression
meta regress weeks
*Postestimation:bubble plot
estat bubbleplot
*Small study effects
*Standard and contour-enhanced funnel plots
meta funnelplot
meta funnelplot, contours(1 5 10)
meta funnelplot, by(week1)
*Tests for funnel-plot asymmetry
meta bias, egger
meta bias week1, egger
*Trim-and-fill analysis
meta trimfill, funnel
*cumulative meta analysis
meta forestplot, cumulative(weeks)

*Task 2

*Load the dataset to be used 
use "C:\Users\Baha\Downloads\sias.dta", clear
*describe the data in detail
describe Gender College q1 q10 q15 q20 q25 q30 q35 q40 q43
* Conduct the exploratory factor analysis
factor q1-q43, pcf
* Conduct factor analysis
factor q1-q43, factors(3)
* Generate scree plot
screeplot
* Calculate Cronbach's alpha for Factor 1
alpha q1 q2 q3 q4 q5 q6 q7 q8 q9 q10 q11 q12 q13 q14  
* Calculate Cronbach's alpha for Factor 2
alpha q15 q16 q17 q18 q19 q20 q21 q22 q23 q24 q25 q26 ///
q27 q28
* Calculate Cronbach's alpha for Factor 3
alpha q29 q30 q31 q32 q33 q34 q35 q36 q37 q38 q39 q40 ///
q41 q42 q43



