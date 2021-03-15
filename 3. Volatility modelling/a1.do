*Assignment7
clear
*log using "G:\ECON803\Assignment7\a1.smcl"
import excel "G:\ECON803\Assignment7\SPX data.xlsx", sheet("Sheet2") firstrow
codebook Date
generate obsnum=_n
tsset obsnum, weekly
twoway (tsline RMRF)
*graph export "G:\ECON803\Assignment7\lineGraph.png", as(png) replace
*Test for ARCh effect-Qn.1.b
regress RMRF
estat archlm, lags(5)
*GARCH model - qn.2
arch RMRF, arch(1/1) garch(1/1)
generate livsqL=ln(L.IV*L.IV)
arch RMRF, arch(1/1) garch(1/1) archm het(livsqL)
arch RMRF, arch(1/1) garch(1/1) archm
arch RMRF, earch(1/1) egarch(1/1) archm het(livsqL)
arch RMRF, earch(1/1) egarch(1/1) archm
newey RMRF livsqL, lag(8)

