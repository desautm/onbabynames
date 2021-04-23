library(tidyverse)
library(devtools)

boys <- read_csv("https://data.ontario.ca/dataset/eb4c585c-6ada-4de7-8ff1-e876fb1a6b0b/resource/919b7260-aafd-4af1-a427-38a51dbc8436/download/ontario_top_baby_names_male_1917-2018_en_fr.csv")
girls <- read_csv("https://data.ontario.ca/dataset/4d339626-98f9-49fe-aede-d64f03fa914f/resource/0c4aec56-b2b8-499b-9739-68ab8a56e69a/download/ontario_top_baby_names_female_1917-2018_en_fr.csv")

names_boys <- boys %>%
  rename(name = `Name/Nom`, year = `Year/Année`, n = `Frequency/Fréquence`) %>%
  mutate(sex = "M") %>%
  mutate(
    name = str_to_title(name),
    n = as.integer(n),
    year = as.integer(year)
  )

names_girls <- girls %>%
  rename(name = `Name/Nom`, year = `Year/Année`, n = `Frequency/Fréquence`) %>%
  mutate(sex = "F") %>%
  mutate(
    name = str_to_title(name),
    n = as.integer(n),
    year = as.integer(year)
  )

onbabynames <-
  bind_rows(names_boys,names_girls) %>%
  filter( !is.na(name), !is.na(year), !is.na(n), !is.na(sex)) %>%
  select(year, sex, name, n) %>%
  # group_by(year, sex) %>%
  # mutate(prop = n/sum(n)) %>%
  arrange(year, sex, name)

use_data(onbabynames, overwrite = TRUE)
