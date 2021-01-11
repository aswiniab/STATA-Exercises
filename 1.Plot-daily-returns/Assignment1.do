clear
/*Assignment1*/
/*log using "G:\ECON803\Assignment1\Redo2\Assignment1.smcl"*/
import excel "G:\ECON803\Assignment1\precious metals.xlsx", sheet("Sheet1") firstrow
tsset Date
describe
twoway (tsline Gold)
graph export "G:\ECON803\Assignment1\Redo2\Gold_LineGraph.pdf", as(pdf) replace
generate DR_Gold = 100*(Gold-L.Gold)/L.Gold
histogram DR_Gold
graph export "G:\ECON803\Assignment1\Redo2\DR_Gold_Histogram.pdf", as(pdf) replace
summarize DR_Gold, detail
/*log close
save "G:\ECON803\Assignment1\Redo2\Assignment1.dta"*/
