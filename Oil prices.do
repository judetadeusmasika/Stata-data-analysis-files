
* Load the daaset to be used

import excel "C:\Users\Baha\OneDrive\Desktop\Oil prices.xlsx", sheet("Sheet1") firstrow

describe, detail

*descriptive statistics

summarize SP500 DJIA STOXX600 FTSE100 Hangseng Nikkei225 BSE BRENT WTI

*Preliminary tests
*Normality Test - Shapiro-Wilk Test

swilk SP500 DJIA STOXX600 FTSE100 Hangseng Nikkei225 BSE BRENT WTI

*Stationarity Test - Augmented Dickey-Fuller (ADF) Test
tsset Date

dfuller SP500, lags(4)
dfuller DJIA, lags(4)
dfuller STOXX600, lags(4)
dfuller FTSE100, lags(4)
dfuller Hangseng, lags(4)
dfuller Nikkei225, lags(4)
dfuller BSE, lags(4)
dfuller BRENT, lags(4)
dfuller WTI, lags(4)

* Phillips perron tests

pperron SP500, lags(4)
pperron DJIA, lags(4)
pperron STOXX600, lags(4)
pperron FTSE100, lags(4)
pperron Hangseng, lags(4)
pperron Nikkei225, lags(4)
pperron BSE, lags(4)
pperron BRENT, lags(4)
pperron WTI, lags(4)

tsset Date

findit kpss

kpss SP500, lags(4)
kpss DJIA, lags(4)
kpss STOXX600, lags(4)
kpss FTSE100, lags(4)
kpss Hangseng, lags(4)
kpss Nikkei225, lags(4)
kpss BSE, lags(4)
kpss BRENT, lags(4)
kpss WTI, lags(4)



*Correlation Test

pwcorr SP500 DJIA STOXX600 FTSE100 Hangseng Nikkei225 BSE BRENT WTI, sig

*Simple regression analysis

regress SP500 BRENT
regress DJIA BRENT
regress STOXX600 BRENT
regress FTSE100 BRENT
regress Hangseng BRENT
regress Nikkei225 BRENT
regress BSE BRENT

*Multiple regression model

regress SP500 BRENT WTI
regress DJIA BRENT WTI
regress STOXX600 BRENT WTI
regress FTSE100 BRENT WTI
regress Hangseng BRENT WTI
regress Nikkei225 BRENT WTI
regress BSE BRENT WTI

*Granger Causality Test

var SP500 BRENT WTI, lags(4)
vargranger

*Cointegration Test
* The dataset has gaps

*Volatility analysis
*Volatility clustering

arch SP500
arch DJIA
arch STOXX600
arch FTSE100
arch Hangseng
arch Nikkei225
arch BSE
arch BRENT
arch WTI

arch BRENT SP500 DJIA STOXX600 Hangseng FTSE100, arch(1/1)

*Spill over effect tests

mgarch SP500 BRENT WTI, model(bekk)
mgarch DJIA BRENT WTI, model(bekk)
mgarch STOXX600 BRENT WTI, model(bekk)
mgarch FTSE100 BRENT WTI, model(bekk)
mgarch Hangseng BRENT WTI, model(bekk)
mgarch Nikkei225 BRENT WTI, model(bekk)
mgarch BSE BRENT WTI, model(bekk)


*Impulse response function

var SP500 BRENT WTI, lags(4)
irf BRENT
irf graph


*Forecast error variamnce decomposition

var SP500 BRENT WTI, lags(4)
fevd



