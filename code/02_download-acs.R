library(tidyverse)
library(tidycensus)
library(here)
library(dotenv) # load secrets from .env

# set Census API key loaded from ".env" file
census_api_key(Sys.getenv("CENSUS_API_KEY"))

# Download the ACS data we need for nyc tracts
acs_tracts_raw <- get_acs(
  geography = "tract",
  state = "NY",
  county = c("005", "047", "061", "081", "085"), # NYC counties/boroughs
  variables = c(
    "gross_rent_med" = "B25064_001", # median gross rent
    "hh_inc_med" = "B19013_001", # median household income
    "rent_burden_med" = "B25071_001", # median rent burden
    "pov_pct" = "C17002_001", # poverty rate
    "hh_size_avg" = "B25010_001", # average household size
    "occ_units" = "B25003_001", # total occupied units
    "occ_renter_units" = "B25003_003", # renter occupied units
    "vac_forrent_units" = "B25004_002", # vacant units for rent
    "vac_rented_units" = "B25004_003" # vacant units rented
  ),
  survey = "acs5",
  year = 2018,
  output = "wide",
  geometry = FALSE
)

write_rds(acs_tracts_raw, here("data", "raw", "acs-2018-nyc-tracts.rds"))
