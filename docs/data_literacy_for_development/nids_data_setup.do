sort hhid 
gen pcy = w1_hhincome/w1_hhsizer
lab var pcy "Per Capita Income"

gen hhincome_notrans = w1_hhincome - w1_hhgovt
lab var hhincome_notrans "HH Income without Transfers"

*For the exercise, I want to drop those who don't have data for govt. transfers
drop if w1_hhgovt == . 
save "/Users/shalliday/Google Drive/Smith/ECO211/F2015/Midterm/nids_govt_trans.dta"

gen hhy_noremit = hhincome_notrans
replace hhy_noremit = hhincome_notrans - w1_hhremitt if w1_hhremitt !=.
lab var hhy_noremit "Income net of transfers and remittances"

preserve
* I need to tag one person in each household as representative of that HH
egen hh_one=tag(hhid)
drop if hh_one == 0

keep hhid hhy_net hhincome_notrans w1_hhremitt w1_hhgovt w1_hhsizer
save "/Users/shalliday/Google Drive/Smith/ECO211/F2015/Midterm/nids_govt_trans.dta", replace
restore

rename w1_hhsizer hhsize
rename w1_hhgovt transfers
rename w1_hhremitt remittances


outsheet hhid hhsize transfers remittances hhincome_notrans hhy_net nids_hh.csv , comma 









