clear all
set more off
cd "D:\Duke\Personal"
use world-d.dta

gen int visited = 0
replace visited = 1 if name == "China"
replace visited = 1 if name == "United States"
replace visited = 1 if name == "Canada"
replace visited = 1 if name == "Russian Federation"
replace visited = 1 if name == "Nepal"
replace visited = 1 if name == "Germany"
replace visited = 1 if name == "Hungary"
replace visited = 1 if name == "Austria"
replace visited = 1 if name == "Sri Lanka"
replace visited = 1 if name == "Arab Rep. of Egypt"
replace visited = 1 if name == "Czech Republic"

spmap visited using "world-c.dta",  id(_ID) ///
									 title("World Map") ///
									 fcolor(BuYlRd) ///
									 mfcolor(gs10) ///
									 legend(off)
									 
									 
									 
