# epipkg
An R package to generate new R packages in a standardised format

<!-- badges: start -->
[![R-CMD-check](https://github.com/ku-awdc/epipkg/workflows/R-CMD-check/badge.svg)](https://github.com/ku-awdc/epipkg/actions)
<!-- badges: end -->

## Plan

We will first develop this package so that it resembles a complete "example" package, with all the features that we collectively want including:

- local/notebooks/reports directories with README files explaining what they can be used for and a couple of basic examples

- 2 or 3 basic functions in R along with roxygen docs, plus another couple that are not exported (ignore the epipkg_create.R file that is currently there)

- pkgdown

- GitHub actions

- 2 or 4 basic tests

- An example vignette

We will then write a vignette that explains where everything goes and how to get started (see epipkg.Rmd for a basic start)

## Converting the package

As a last step, Matt will move the "example package" under inst/ and then write the template code that will be part of the epipkg itself.  Functions will be:

- epipkg_create()  to check out a repo from GitHub, check it is blank, create the basic package template and push changes back to GitHub

- epipkg_data()  to add data-raw and data directories and examples if needed

- epipkg_Rcpp()  to ann an Rcpp module etc

- Maybe other things to be added (perhaps including pkgdown if this is unnecessarily complex to add from the start)
