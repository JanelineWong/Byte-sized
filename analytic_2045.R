#Set up environment####
setwd("/Users/marinalevochkina_1/Documents/Datathon")
rm(list=ls())

#Reading in packages
library(readxl)
library(dplyr)
library(writexl)

#Read In
df1 <- read_excel("venous_cath_analytic.xlsx")

#peaking####
colnames(df1)
head(df1)

#Recoding the free-text####
#race
#recode race
df1$race[df1$race=="ASIAN - CHINESE"] <- "ASIAN"
df1$race[df1$race=="ASIAN - SOUTH EAST ASIAN"] <- "ASIAN"
df1$race[df1$race=="ASIAN - KOREAN"] <- "ASIAN"
df1$race[df1$race=="ASIAN - ASIAN INDIAN"] <- "ASIAN"
df1$race[df1$race=="BLACK/AFRICAN"] <- "BLACK"
df1$race[df1$race=="BLACK/AFRICAN AMERICAN"] <- "BLACK"
df1$race[df1$race=="BLACK/CAPE VERDEAN"] <- "BLACK"
df1$race[df1$race=="BLACK/CARIBBEAN ISLAND"] <- "BLACK"
df1$race[df1$race=="HISPANIC OR LATINO"] <- "HISPANIC"
df1$race[df1$race=="HISPANIC/LATINO - DOMINICAN"] <- "HISPANIC"
df1$race[df1$race=="HISPANIC/LATINO - GUATEMALAN"] <- "HISPANIC"
df1$race[df1$race=="HISPANIC/LATINO - HONDURAN"] <- "HISPANIC"
df1$race[df1$race=="HISPANIC/LATINO - PUERTO RICAN"] <- "HISPANIC"
df1$race[df1$race=="HISPANIC/LATINO - COLUMBIAN"] <- "HISPANIC"
df1$race[df1$race=="HISPANIC/LATINO - MEXICAN"] <- "HISPANIC"
df1$race[df1$race=="HISPANIC/LATINO - SALVADORAN"] <- "HISPANIC"
df1$race[df1$race=="HISPANIC/LATINO - CUBAN"] <- "HISPANIC"
df1$race[df1$race=="HISPANIC/LATINO - CENTRAL AMERICAN"] <- "HISPANIC"
df1$race[df1$race=="PORTUGUESE"] <- "OTHER"
df1$race[df1$race=="PATIENT DECLINED TO ANSWER"] <- "U"
df1$race[df1$race=="SOUTH AMERICAN"] <- "OTHER"
df1$race[df1$race=="UNABLE TO OBTAIN"] <- "U"
df1$race[df1$race=="UNKNOWN"] <- "U"
df1$race[df1$race=="WHITE - BRAZILIAN"] <- "WHITE"
df1$race[df1$race=="WHITE - EASTERN EUROPEAN"] <- "WHITE"
df1$race[df1$race=="WHITE - OTHER EUROPEAN"] <- "WHITE"
df1$race[df1$race=="WHITE - RUSSIAN"] <- "WHITE"
df1$race[df1$race=="AMERICAN INDIAN/ALASKA NATIVE"] <- "OTHER"
df1$race[df1$race=="NATIVE HAWAIIAN OR OTHER PACIFIC ISLANDER"] <- "OTHER"
df1$race[df1$race=="MULTIPLE RACE/ETHNICITY"] <- "OTHER"
df1$race[df1$race=="NA"] <- "U"

#change any na's to "U"
df1 <- df1 %>%
  mutate(race = if_else(is.na(race), "U", race))

#check table
table(df1$race)

#assign number to each race category
df1 <- df1 %>%
  mutate(
    race_coded = as.numeric(as.factor(race))
  )

#How it's coded and number in each category
table(df1$race, df1$race_coded)

#             1     2     3     4     5     6
#ASIAN      334     0     0     0     0     0
#BLACK        0  1666     0     0     0     0
#HISPANIC     0     0   434     0     0     0
#OTHER        0     0     0   424     0     0
#U            0     0     0     0 10124     0
#WHITE        0     0     0     0     0  7293

#Gender recoding
df1 <- df1 %>%
  mutate(
    gender_coded = as.numeric(as.factor(gender))
  )

#How it's coded and number in each category
table(df1$gender, df1$gender_coded)

#      1     2
#F  8235     0
#M     0 12040

write_xlsx(df1,"analytic_2045.xlsx")