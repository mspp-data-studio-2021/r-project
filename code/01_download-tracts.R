# This script downloads the PLUTO dataset from NYC City Plannings Bytes of the
# Big Apple. First we create a new folder "/data-raw" if it doesn't already
# exist, then download the zip file if we haven't already. Then we unzip it to
# get the CSV file, if we haven't already.

# The CSV file is quite large, so we'll gitignore it, but leave the zip file so
# that for others using the project that can simple extract it.

library(fs) # cross-platform, uniform file system operations
library(here) # relative paths
library(zip) # cross-platform ‘zip’ compression

dir_create("data", "raw")

file_url <- "https://data.cityofnewyork.us/api/geospatial/fxpq-c8ku?method=export&format=Original"
zip_file <- here("data", "raw", "nyc-tracts-2010.zip")
shp_file <- here("data", "raw", "nyc-tracts-2010.shp")

if (!file_exists(zip_file) & !file_exists(shp_file)) {
  download.file(file_url, zip_file, mode = "wb")
}

if (!file_exists(shp_file)) {
  unzip(zip_file, exdir = here("data", "raw", "nyc-tracts-2010"))
}

file_delete(zip_file)
