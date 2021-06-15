r-project
=========

This is an example project to illustrate some organization and reproducability concepts for the _Policy & Data Studio_ course in Summer 2021. 

## Getting Started

You will first need to download and install [R](https://cran.rstudio.com/) and [RStudio](https://rstudio.com/products/rstudio/download/). 

Then clone this project repository and open the file `r-project.Rproj` to launch the project in R Studio. 

This project uses [`renv`](https://rstudio.github.io/renv/articles/renv.html) to handle dependency managemnt. When you launch the project in RStudio this package will automatically be installed (you can do so manually using `install.packages("renv")`). Then to install all the required packages, run the following on the R console in RStudio, and when prompted, select the option `Restore the project from the lockfile.`:

```r
renv::init()
```

In this project the [`tidycensus`](https://walker-data.com/tidycensus/) package is used to access the Census Bureau's APIs, which requires a Census API key. You can sign up for a free API key at http://api.census.gov/data/key_signup.html.

To access your API key without risking it being published on GitHub this project uses the [`dotenv`](https://github.com/gaborcsardi/dotenv) package. You need to edit the file [`.env_sample`]() and add your key, then rename the file to `.env`.


## Replicating the Analysis

The entire analysis and all files can be replicated by running `source("code/00_make.R")`, which in turn will run all the the other numbered scripts and notebooks in [`/code`](/code). 

Alternatively, you can run each step individually following the numbered ordering of files:

* [`01_download-tracts.R`](code/01_download-tracts.R)
  * This downloads a shapefile for all NYC census tracts (2010) from NYC's Open Data portal, and saves the files in [`/data/raw`](/data/raw)
* [`02_download-acs.R`](code/02_download-acs.R)
  * This uses the `tidycensus` package to download ACS summary file data for NYC tracts using the Census API. 
  * See above for instructions for getting and free Census API key and setting the key for use in this script.
* [`03_clean-join-tract-data.R`](code/03_clean-join-tract-data.R)
  * This reads in the two raw data files created above, and claculates some new ACS variables and joins the ACS data with the tract geometries frothe shapefile. The final clean tract-level dataset with geometries is saved to [`/data/clean`](/data/clean)
* [`99-1_tract-maps.Rmd`](code/99-1_tract-maps.Rmd)
  * This notebook reads in the clean tract dataset and produces some maps. The map files are saved to [`/img`](/img) and the rendered notebook is saved to [`/docs`](/docs)
