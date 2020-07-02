library(here)
library(fs)
library(rmarkdown)

dir_create(
  c(
    here("data"),
    here("data", "raw"),
    here("data", "clean"),
    here("img"),
    here("docs")
  )
)

source(here("code", "01_download-tracts.R"))

source(here("code", "02_download-acs.R"))

source(here("code", "03_clean-join-tract-data.R"))

render(
  input = here("code", "99-1_tract-maps.Rmd"),
  output_dir = here("docs")
)
