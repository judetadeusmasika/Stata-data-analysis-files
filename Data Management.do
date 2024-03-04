
/* Import the dataset to be used in the analysis */

import delimited "C:\Users\Baha\OneDrive\Documents\TB_POV.csv", clear 

/*describe the dataset*/

describe

/* Descriptive statistcs for each varible with outliers*/

summarize v3 v5

/* Descriptive statistcs for each variable without outliers*/

summarize outlier_2004 outlier_2005

/* Run a linear regression of poverty on TB rate and interpret the results.*/

regress v3 v5

/* Tests for the relationship between the poverty variable and the tuberclosis variable*/

/* Correlation analysis*/

correlate v3 v5

// Create a scatterplot with custom options
scatter v3 v5, ///
    title("Scatterplot of Poverty rate and Tuberclosis") ///
    xtitle("Tuberclosis") ytitle("Poverty") ///
    xlabel(0(10)100) ylabel(0(5)50) ///
    msymbol(circle_hollow) mcolor(blue) ///
    msize(small)
	

