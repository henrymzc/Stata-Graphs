clear
set obs 4 
gen round = _n - 1 

gen true_c_p = .
replace true_c_p =  1 if round == 0
replace true_c_p =  0.6 if round == 1
replace true_c_p =  0.5 if round == 2
replace true_c_p =  0.3 if round == 3

 
gen bt_t_c_p = .
gen bt_c_c_p = .
gen std_bt_t_c_p = .
gen std_bt_c_c_p = .

replace bt_t_c_p = 0.7 if round == 1
replace bt_t_c_p=  0.6 if round == 2
replace bt_t_c_p=  0.4 if round == 3

replace std_bt_t_c_p =  0.05  if round == 1
replace std_bt_t_c_p =  0.03 if round == 2
replace std_bt_t_c_p =  0.02 if round == 3

replace bt_c_c_p =  0.5 if round == 1
replace bt_c_c_p =  0.4 if round == 2
replace bt_c_c_p =  0.2 if round == 3


gen high_bt_t_c_p = bt_t_c_p + 1.96 * std_bt_t_c_p 
gen low_bt_t_c_p = bt_t_c_p - 1.96 * std_bt_t_c_p 


twoway (connected true_c_p round, 											 ///  First Line																
		msymbol(oh) mcolor("52 85 119") msize(medium)						 ///  The size, color, pattern of dots 
		lpattern(dash) lcolor("52 85 119") lwidth(medthick)  			     ///  The size, color, pattern of line
		xsc(r(0 1)) ysc(r(0 1)) ysize(1) xsize(1) ytick(#5) ylabel(#5) xtick() xlabel(#5)  ///  Label Look
		)																     /// 																 
	    (connected bt_t_c_p round, 											 /// Second Line
		msymbol(x) mcolor("164 60 96") msize(large			) 				 ///
		lwidth(medthick) lcolor("164 60 96") lpattern(longdash_dot)          ///
		) ///
		(connected bt_c_c_p round,											 /// Third Line
		msymbol(th) mcolor(green) msize(large) lpattern(longdash_dot)        ///
		)  																	 ///
		(rcap high_bt_t_c_p low_bt_t_c_p round ,                             /// Confidence Interval
	    lwidth(medthin) lcolor("164 60 96")									 ///
		) 							   							         	  ///
		,legend(order(1 "Actual Rate"    2 "Belief of treatment group"  3 "Belief of control group")   ///
			   pos(2) ring(0) rows(4) region(lcolor(gs16) fcolor(gs16)))            			   /// How to draw beautiful legend
	    xlabel(0 "Baseline" 1 "3 months" 2 "1 year" 3 "5 years", labsize(small) noticks)  ///	
		ylabel(0 "0" 0.2 "20" 0.4 "40" 0.6 "60" 0.8 "80" 1 "100", grid labsize(small))    ///
	    xtitle("{bf:Time after Enrollment}", height(6) size(medsmall))                  ///
		ytitle("{bf:Fraction Depressed (PHQ9 {&ge} 10)}", height(6) size(medsmall))       ///
	    title("{bf:  Program A}", size(medlarge) )                 ///
	    subtitle(" ", size(small) color(white))                                         ///
		plotregion(lcolor(white)) yscale(lstyle(none)) xscale(lstyle(none))  graphregion(color(white))
		
