*ASSIGNMENT-4

clear
log using "G:\ECON803\Assignment4\Assignment4.smcl"
import excel "G:\ECON803\Assignment4\macro-2.xls", sheet("macro") firstrow
codebook Date
generate Month = mofd(Date)
format %tm Month
tsset Month, monthly

*Estimating model for CPI data series
twoway (tsline CPI)
graph export "G:\ECON803\Assignment4\CPI_LineGraph.pdf", as(pdf) replace
corrgram CPI, lags(12)
ac CPI, lags(12)
graph export "G:\ECON803\Assignment4\CPI_AC_Graph.pdf", as(pdf) replace
pac CPI, lags(12)
graph export "G:\ECON803\Assignment4\CPI_PAC_Graph.pdf", as(pdf) replace

*Estimating model for inflation data series
generate inflation=100*(CPI-L.CPI)/L.CPI
twoway(tsline inflation)
graph export "G:\ECON803\Assignment4\inflation_lineGraph.pdf", as(pdf) replace
corrgram inflation, lags(12)
ac inflation, lags(12)
graph export "G:\ECON803\Assignment4\inflation_AC_Graph.pdf", as(pdf) replace
pac inflation, lags(12)
graph export "G:\ECON803\Assignment4\inflation_PAC_Graph.pdf", as(pdf) replace
arima inflation if Month<=tm(2015m12), arima(0,0,1)
estat ic
arima inflation if Month<=tm(2015m12), arima(0,0,3)
estat ic
arima inflation if Month<=tm(2015m12), arima(1,0,1)
estat ic
arima inflation if Month<=tm(2015m12), arima(2,0,2)
estat ic
arima inflation if Month<=tm(2015m12), arima(0,0,2)
estat ic
estat aroots, dlabel
graph export "G:\ECON803\Assignment4\inflation_MA(2)_roots_Graph.pdf", as(pdf) replace

*Generating predictions for inflation rate
predict inflation_stat, xb
predict inflation_dyn, xb dynamic(tm(2016m1))
twoway (tsline inflation if Month>tm(2015m12), lcolor(black) lpattern(solid)) (tsline inflation_stat if Month>tm(2015m12), lcolor(green) lpattern(dash)) (tsline inflation_dyn if Month>tm(2015m12), lcolor(blue) lpattern(longdash))
graph export "G:\ECON803\Assignment4\predictions2_Graph.pdf", as(pdf) replace

*Estimating model for change in inflation rate
generate dinflation=inflation-L.inflation
twoway (tsline dinflation)
corrgram dinflation, lags(24)
ac dinflation, lags(24)
pac dinflation, lags(24)
arima dinflation if Month<=tm(2015m12), arima(0,0,4)
estat ic
arima dinflation if Month<=tm(2015m12), arima(0,0,2)
estat ic
arima dinflation if Month<=tm(2015m12), arima(0,0,3)
estat ic
arima dinflation if Month<=tm(2015m12), arima(1,0,1)
estat ic
arima dinflation if Month<=tm(2015m12), arima(2,0,2)
estat ic
arima dinflation if Month<=tm(2015m12), arima(3,0,2)
estat ic
arima dinflation if Month<=tm(2015m12), arima(2,0,3)
estat ic
estat aroots

log close
save "G:\ECON803\Assignment4\Assignment4.dta", replace
save "G:\ECON803\Assignment4\Assignment4_final.dta"
