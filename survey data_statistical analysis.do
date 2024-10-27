
** load the dataset into the program

use "C:\Users\Baha\OneDrive\Documents\Survey_data.dta", clear

** describe the data in detail

describe, detail

** descriptive statistics of the sample dataset

summarize Q1, detail


** calculate the mode of the interested variable 

tabulate Q1, sort

tabulate Q1

summarize Q1
scalar mean_Q1 = r(mean)
scalar sd_Q1 = r(sd)
gen z_scores = (Q1 - mean_Q1) / sd_Q1

** tabulate the standardised scores

tabulate z_scores


** the percentile rank of all the values in the survey dataset

egen rank_Q1 = rank(Q1)

gen percentile_rank = (rank_Q1 - 1) / (_N - 1) * 100

** tabulate the percentile rank of the values

asdoc tabulate percentile_rank, save(mytable.doc)

** the empirical rule

* Count the number of observations within 1 standard deviation
count if z_scores >= -1 & z_scores <= 1

* Count the number of observations within 2 standard deviations
count if z_scores >= -2 & z_scores <= 2

* Count the number of observations within 3 standard deviations
count if z_scores >= -3 & z_scores <= 3
