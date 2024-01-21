
// Loading the dataset 

use "C:\Users\Baha\Downloads\Final_main .dta"

// describing the dataset

describe

// check if there are missing values in the dataset

summarize lwage SexOrient exper educ tenure expersq gender

//handle missing values in the dataset

drop if missing(lwage, sexorient, exper, educ, tenure, expersq, sex)

// convert the categorical variable sex into numeric

encode sex, gen(gender)

// convert the categorical variable sexorient into numeric

encode sexorient, gen(SexOrient)

// Fitting a multiple linear regression model to the dataset

// Estimate the regression model

regress lwage SexOrient exper educ tenure expersq gender

//export the results from regression analysis into a table

estout, title("Regression Results") 


