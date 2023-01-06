*********Relationship between Inflation, money supply, excahange rate and Economic Growth in The Gambia: Using ARDL Model*******************

clear 
set more off
use "C:\Users\22031\Desktop\Final_Inflation_Data.dta"
log using "C:\Users\22031\Desktop\inflation.log"

*Declare Dataset as time series
tsset Time, yearly
* To obtain optimal lags for each variables
varsoc Inflation
varsoc lnREER
varsoc lnGDP
varsoc M2


* Test of Unit roots  using Augmented Dickey Fuller test

dfuller Inflation, lag(1)
dfuller d.Inflation, lag(1)
dfuller lnREER , lag(2)
dfuller d.lnREER , lag(2)
dfuller lnGDP , lag(1)
dfuller d.lnGDP , lag(1)
dfuller M2, lag(1)
dfuller d.M2, lag(1)

 
*ARDL since we have a mixture I(0) and I(1) series it is ideal to use the ardl model

ardl Inflation lnREER lnGDP M2, maxlag(1)
matrix list e(lags)

* Bound test of coinegration
ardl Inflation lnREER lnGDP M2, lags(1 1 1 1) ec btest

* error correction model
ardl Inflation lnREER lnGDP M2, lags(1 1 1 1) ec 


* Peform dignostics
ardl Inflation lnREER lnGDP M2, lags(1 1 1 1) regstore (ecreg)
estat dwatson
estat bgodfrey, lag(1)
estat imtest, white
predict resid, residuals
jb resid
cusum6 Inflation lnREER lnGDP M2, cs(cusum) lw(lower) uw(upper)

log close


