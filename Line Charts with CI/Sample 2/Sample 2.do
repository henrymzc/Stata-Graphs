
clear
set obs 7
gen cmean = .
gen coef = .
gen std = .
gen round = _n - 1 
gen treat = .
gen high = .
gen low = .

forva i = 0/6{
	replace cmean = runiform(0 , 0.2) if round == `i' 
	replace coef = runiform(0 , 0.2) if round == `i'
	replace std = runiform(0 , 0.05) if round == `i'

}

replace treat = cmean + coef
replace high = treat + 1.96 * std
replace low = treat - 1.96 * std


	label define rd 0 "Prior before readjustment" ///
					1 "Prior after readjustment" ///
					2 "After Signal 1" ///
					3 "After Signal 2" ///
					4 "After Signal 3" ///
					5 "After Signal 4" ///
					6 "After Signal 5" ///	
					
	label value round rd
	
	

	
	twoway (connected cmean round , legend(label(1 "Control")) color("52 85 119") lwidth(medthick) lp(dash) msymbol(oh) msize(large)) ///
			(connected treat round , legend(label(2 "Treat") order(1 2 3)) color("164 60 96") lwidth(medthick) lp(shortdash_dot) msymbol(x) msize(large)) ///
			(rcap high low round , color("164 60 96") legend(label(3 "90% CI")) lwidth(medthin)), ///	
			ytitle("{bf:Overconfidence}" " ", size(big)) ///
			xtitle("") ///
			xlabel(0 `" "Initial"  "' ///
				   0.5 	`" " " " "  "{bf:Prior}" "' ///
				   1 `" "Adjust"  "' ///
				   2 `" "1" "' ///
				   3 `" "2" "' ///
				   4 `" "3" "' ///
				   4.01 `" " " " "  "{bf:Posterior after signal}" "' ///
				   5 `" "4" "' ///
				   6 `" "5" "', labsize(big) tstyle(major_notick)) 	///
			yscale(r(0  0.14)) ylabel(0 (0.05) 0.2 , labsize(big)) ///
			graphregion(color(white)) ///
			legend(off) ///
			text(0.165 5 "Control group", color("52 85 119") size(big)) ///
			text(0.015 5 "Treatment group", color("164 60 96") size(big)) //
			

