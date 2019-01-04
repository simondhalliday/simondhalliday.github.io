use "/Users/shalliday/Desktop/Panel/wave4_merged.dta", clear
drop if w4_hhsizer == . 
drop if w4_hhincome == . 
gen tag = 0
replace tag = 1 if pid == w4_a_decdpid
keep if tag == 1 
keep w4_hhid w4_hhsizer w4_hhincome w4_hhgovt w4_remt w4_a_lng w4_best_race w4_a_gen pid w4_a_decdpid
rename w4_hhid hhid
rename w4_hhsize hhsize 
rename w4_hhincome hhincome
rename w4_hhgovt transfers
rename w4_remt remittances
rename w4_a_lng homelanguage
rename w4_best_race race
replace remittances = 0 if remittances == .
replace transfers = 0 if transfers == .
gen hhynet = hhincome - (transfers + remittances)
lab var hhynet "household income net of transfers and remittances"
export excel using "nids_hhgender.xlsx", replace firstrow(varlabels)
save "/Users/shalliday/Desktop/Panel/nids_2014_excel.dta", replace



