
* DATASET: ICU

* Load the ICU dataset into the STATA  program

* NOTE: Change my working directory to the datasets, replace with your working directory.

* This will ensure data is imported successfully and the codes run to produce the outputs!

use "C:\Users\Baha\OneDrive\Documents\MY FIVERR ACCOUNT TASKS\cmansfield27-attachments\ICU.DTA", clear

* inspect the loaded dataset to have an overview of what it entails

describe, detail

summarize

* QUESTION 1: 1.	Predict likelihood of survival (sta) from age, service at ICU admission (ser), 
*whether or not patient was admitted due to cancer (can), infection at ICU (inf), type of admission (typ), 
*patient’s level of consciousness (loc)

* Before fitting the model to the data, lets inspect the specified variables

summarize sta age ser can inf typ loc

* Pairwise correlation matrix with p-values
pwcorr sta age ser can inf typ loc, sig

* Use the logit command, to predict the likelihood of survival using the specified 
* independent variables

logit sta age ser can inf typ loc

* ROC curve

lroc

* Predict the probabilities of survival
predict p_survival

* inspect the new variable

summarize p_survival

* assessing fittness of the model

estat ic
estat gof

* QUESTION 2: 2.	Predict likelihood of survival (sta) from age, race, gender, history of chronic renal failure (crn), 
*systolic high blood pressure (sys) at time of admission, and service at ICU admission (ser).

summarize sta age race gender crn sys ser

* Pairwise correlation matrix with p-values
pwcorr sta age race gender crn sys ser, sig

* fit the logit model to the data using the new specified independent variables

logit sta age race gender crn sys ser

*ROC curve

lroc

* predict probabilities of survival using the new model
predict p_survival_new

* check the new predicted values of survival
summarize p_survival_new

* assess fitness of new logit model
estat ic
estat gof

* DATASET: LOWBWT

* Load the dataset into the program

use "C:\Users\Baha\OneDrive\Documents\MY FIVERR ACCOUNT TASKS\cmansfield27-attachments\LOWBWT.DTA", clear

* filter the data to only retain observations with women aged 30 and above
keep if age>=30

* Inspect the dataset
describe, detail

* QUESTION 3: Predict low birthweight from age, race and smoking and pre-term labor (ptl).

* descriptive statistics
summarize low age race smoke ptl

* Pairwise correlation matrix with p-values
pwcorr low age race smoke ptl, sig

* fit the logistic/logit model to the dataset

logit low age race smoke ptl

*ROC curve

lroc

* predict low birthweight
predict p_low

summarize p_low

* assess fitness of the model
estat ic
estat gof

* QUESTION 4: Predict low birthweight from mother’s weight at her last menstrual period, history of hypertension,
* presence of uterine irritability, and first trimester visits

* Inspect the variables
summarize low lwt ht ui ftv

pwcorr low lwt ht ui ftv, sig

* fit the logit model to the data using the new variables
logit low lwt ht ui ftv

*ROC curve

lroc

* predict low birthweight using the new model
predict p_low_new

summarize p_low_new

* assess model fitness

estat ic
estat gof

* DATASET: BURN1000

use "C:\Users\Baha\OneDrive\Documents\MY FIVERR ACCOUNT TASKS\cmansfield27-attachments\BURN1000.DTA", clear

* inspect the dataset

describe, detail

* QUESTION 5: Predict death from burn injury (death) from total burn surface area (tbsa) and whether inhalation injury was involved (inh_inj)

summarize death tbsa INH_INJ

* Pairwise correlation matrix with p-values
pwcorr death tbsa INH_INJ, sig

* Logistic regression model
logit death tbsa INH_INJ

*ROC curve

lroc

* predict death from burn injury
predict p_death

summarize p_death

* assess model fitness
estat ic
estat gof

* roc curve
roctab death p_death

* QUESTION 6: Predict death from burn injury from age, gender, race (racec) and flame involved in the injury (flame)

summarize age gender racec flame death

* Pairwise correlation matrix with p-values
pwcorr death age gender racec flame, sig

* logit regression model
logit death age gender racec flame

*ROC curve

lroc

* predict death from burn injury
predict p_death_new

summarize p_death_new

* assess model 
estat ic
estat gof








