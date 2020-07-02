
library(tidyverse)
library(sf)
library(here)

acs_tracts_raw <- read_rds(here("data", "raw", "acs-2018-nyc-tracts.rds"))

# Clean up the ACS data and add some new derived variables
acs_tracts_clean <- acs_tracts_raw %>% 
  rename(geoid = GEOID) %>% 
  mutate(
    state = str_sub(geoid, 1, 2),
    county = str_sub(geoid, 3, 5),
    tract = str_sub(geoid, 6, 11),
    renter_pctE = occ_renter_unitsE / na_if(occ_unitsE, 0),
    renter_pctM = moe_ratio(occ_renter_unitsE, na_if(occ_unitsE, 0), occ_renter_unitsM, occ_unitsM),
    rental_unitsE = occ_renter_unitsE + vac_forrent_unitsE + vac_rented_unitsE
  ) %>% 
  # moe_sum is designed to sum one column, but we can adjust the behaviour by
  # using rowwise and c_across from dplyr (this is a bit confusing, and you
  # won't come across it much)
  rowwise() %>% 
  mutate(
    rental_units_est = sum(c_across(c(occ_renter_unitsE, vac_forrent_unitsE, vac_rented_unitsE))),
    rental_units_moe = moe_sum(
      moe = c_across(c(occ_renter_unitsM, vac_forrent_unitsM, vac_rented_unitsM)),
      estimate = rental_units_est
    )
  ) %>% 
  ungroup()

# Read in census tract shapefiles
nyc_tracts <- path("data", "raw", "nyc-tracts-2010", "nyct2010.shp") %>% 
  read_sf() %>% 
  rename_all(str_to_lower)

# Join the tract geometries and acs data
nyc_tracts_acs_sf <- nyc_tracts %>% 
  mutate(
    county = recode(borocode, "1" = "061", "2" = "005", "3" = "047", "4" = "081", "5" = "085"),
    geoid = str_c("36", county, ct2010)
  ) %>% 
  left_join(acs_tracts_clean, by = "geoid")

# Export the final clean tract data with shapes using R's "rds" format
write_rds(nyc_tracts_acs_sf, here("data", "clean", "nyc_tracts_acs_sf.rds"))
