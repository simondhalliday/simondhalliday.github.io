getwd() 
setwd("H:\\DiscretionaryEffort\\RawData")
rm(list=ls())
#####################################################################################################################################################################
library(dplyr)
library(tidyr)
#####################################################################################################################################################################
########### helper functions #############

drop_empty_cols <- function(df) {
  df[, colSums(!(is.na(df) | df == "")) > 0]
}

clean_st_prefix <- function(df) {
  names(df) <- sub("^(s[345]t)\\d+", "\\1", names(df), perl = TRUE)  # oder s[3-6]
  df
}
#####################################################################################################################################################################
########### Import Data #############

s1_t1_wide_raw  <- drop_empty_cols(read.csv("H:/DiscretionaryEffort/RawData/all_apps_wide-2025-09-04(4).csv"))
s2_t2_wide_raw  <- drop_empty_cols(read.csv("H:/DiscretionaryEffort/RawData/all_apps_wide-2025-09-04(5).csv"))
s3_t3_wide_raw  <- drop_empty_cols(read.csv("H:/DiscretionaryEffort/RawData/all_apps_wide-2025-09-04(7).csv"))
s4_t4_wide_raw  <- drop_empty_cols(read.csv("H:/DiscretionaryEffort/RawData/all_apps_wide-2025-09-04(8).csv"))
s5_t5_wide_raw  <- drop_empty_cols(read.csv("H:/DiscretionaryEffort/RawData/all_apps_wide-2025-09-04(9).csv"))
s6_t6_wide_raw  <- drop_empty_cols(read.csv("H:/DiscretionaryEffort/RawData/all_apps_wide-2025-09-04(10).csv"))
s7_t2_wide_raw  <- drop_empty_cols(read.csv("H:/DiscretionaryEffort/RawData/all_apps_wide-2025-09-04(11).csv"))
s8_t3_wide_raw  <- drop_empty_cols(read.csv("H:/DiscretionaryEffort/RawData/all_apps_wide-2025-09-04(12).csv"))
s9_t4_wide_raw  <- drop_empty_cols(read.csv("H:/DiscretionaryEffort/RawData/all_apps_wide-2025-09-04(13).csv"))
s10_t5_wide_raw <- drop_empty_cols(read.csv("H:/DiscretionaryEffort/RawData/all_apps_wide-2025-09-05(1).csv"))
s11_t5_wide_raw <- drop_empty_cols(read.csv("H:/DiscretionaryEffort/RawData/all_apps_wide-2025-09-05(2).csv"))
s12_t6_wide_raw <- drop_empty_cols(read.csv("H:/DiscretionaryEffort/RawData/all_apps_wide-2025-09-05(3).csv"))

for (nm in c("s1_t1_wide_raw","s2_t2_wide_raw","s3_t3_wide_raw","s4_t4_wide_raw", 
             "s5_t5_wide_raw","s6_t6_wide_raw","s7_t2_wide_raw","s8_t3_wide_raw",
             "s9_t4_wide_raw","s10_t5_wide_raw","s11_t5_wide_raw","s12_t6_wide_raw")) {
  assign(nm, clean_st_prefix(get(nm)))
}

btc_data_s3s4s5s6s8s10s11s12_wide_raw <- rbind(s3_t3_wide_raw, s4_t4_wide_raw, s5_t5_wide_raw, s6_t6_wide_raw, s8_t3_wide_raw, 
                                                 s10_t5_wide_raw, s11_t5_wide_raw, s12_t6_wide_raw)

vars_s1   <- names(s1_t1_wide_raw)
vars_rest <- names(btc_data_s3s4s5s6s8s10s11s12_wide_raw)
missing_in_s1 <- setdiff(vars_rest, vars_s1)
s1_t1_wide_raw[missing_in_s1] <- NA
btc_data_s1s3s4s5s6s8s10s11s12_wide_raw <- rbind(btc_data_s3s4s5s6s8s10s11s12_wide_raw,s1_t1_wide_raw) 

vars_s2   <- names(s2_t2_wide_raw)
vars_rest <- names(btc_data_s1s3s4s5s6s8s10s11s12_wide_raw)
missing_in_s2 <- setdiff(vars_rest, vars_s2)
extra_in_s2 <- setdiff(vars_s2,vars_rest)
s2_t2_wide_raw[missing_in_s2] <- NA
btc_data_s1s3s4s5s6s8s10s11s12_wide_raw[extra_in_s2] <- NA
btc_data_s1s2s3s4s5s6s8s10s11s12_wide_raw <- rbind(btc_data_s1s3s4s5s6s8s10s11s12_wide_raw, s2_t2_wide_raw)

vars_s7   <- names(s7_t2_wide_raw)
vars_rest <- names(btc_data_s1s2s3s4s5s6s8s10s11s12_wide_raw)
missing_in_s7 <- setdiff(vars_rest, vars_s7)
s7_t2_wide_raw[missing_in_s7] <- NA
btc_data_s1s2s3s4s5s6s7s8s10s11s12_wide_raw <- rbind(btc_data_s1s2s3s4s5s6s8s10s11s12_wide_raw, s7_t2_wide_raw)

vars_s9   <- names(s9_t4_wide_raw)
vars_rest <- names(btc_data_s1s2s3s4s5s6s7s8s10s11s12_wide_raw)
missing_in_s9 <- setdiff(vars_rest, vars_s9)
extra_in_s9   <- setdiff(vars_s9, vars_rest)
s9_t4_wide_raw[missing_in_s9] <- NA
btc_data_s1s2s3s4s5s6s7s8s10s11s12_wide_raw[extra_in_s9] <- NA
btc_data_s1s2s3s4s5s6s7s8s9s10s11s12_wide_raw <- rbind(btc_data_s1s2s3s4s5s6s7s8s10s11s12_wide_raw, s9_t4_wide_raw)

btc_data_wide_raw <- btc_data_s1s2s3s4s5s6s7s8s9s10s11s12_wide_raw

btc_data_wide_raw <- btc_data_wide_raw %>%
  filter(
    !(
      participant._current_page_name == "" |
        participant._current_page_name %in% c(
          "AttentionCheckFailed", "InactivePlayer", "NoPartnerFound",
          "PartnerAttentionCheckFailed", "PartnerInactive", "p1pe", "p7pe"
        ) |
        participant._current_app_name == "s1t1" |
        (session.code == "qe34cngd" & participant.GROUP_ID %in% c(9, 11, 13))
    )
  )

table(btc_data_wide_raw$session.config.name)
names(btc_data_wide_raw)
btc_data_wide <- btc_data_wide_raw

# participant variable
btc_data_wide <- btc_data_wide %>%
  mutate(participant = paste(session.code, participant.code, sep = "_"))

# format data in panel
btc_data <- btc_data_wide %>%
  pivot_longer(
    cols = matches("^(s3t|s4t)\\.\\d+\\."), 
    names_to = c("stage", "round_raw", ".value"),
    names_pattern = "^(s3t|s4t)\\.(\\d+)\\.(.+)$"
  ) %>%
  mutate(
    round_raw = as.integer(round_raw),
    round = if_else(stage == "s3t", round_raw, round_raw + 10L)
  ) %>%
  select(-stage, -round_raw) %>%
  # optional cleanup
  mutate(across(where(is.character), ~ na_if(.x, ""))) %>%
  arrange(participant, round) %>%
  select(round, participant, everything())

btc_data <- btc_data %>%
  select(round, participant, everything())
View(btc_data)

sort(unique(btc_data$round))    
btc_data %>% count(participant) %>% summary()
btc_data %>% count(participant, round) %>% filter(n > 1) 

table(btc_data$session.config.name)

# save data set
saveRDS(btc_data, file = "btc_data.rds")
















