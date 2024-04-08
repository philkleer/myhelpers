# Helper Functions across analyses

This packages just represents helper functions for graphics or diagnostics that I use frequently in data analyses. 

Feel free to adjust or modify, if you want to use it. 

## Installation

```r
devtools::install_github("bpkleer/myhelpers")
```

## Overview functions

| function | aim |
|-----------|---------------------------------|
|`create_bayes_acf()` | creates autocorrelation diagnostics for `brms`-output automatically across all variables and saves single png-files |
| `create_bayes_combo()` | creates density and and trace diagnostics for `brms`-output automatically across all variables and saves single png-files |
| `create_bayesreg_table()` | creates a standard regression table from `bayesPostEst::mcmcReg()` to LaTeX | 
| `create_corr()` | creates a standardized correlation plot from correlation matrix |
| `create_raincloud()` | creates a standardized raincloud for a single metric variable|
| `create_raincloud_group()` | creates a standardized raincloud for a single metric variable on a categorical variable|
| `create_raincloud_facet()` | creates a standardized raincloud sorted by third variable |
| `hyptest_to_latex()` | transforms output of `brms::hypothesis()` to LaTeX | 
| `load_beyonce()` | loads my preferred styling of plots | 
| `load_beyonce_bayes()` | same as above with setup for bayesian plots | 
| `load_colorblind()` | loads a colorblind-friendly palette | 
| `load_grey()` | loads my preferred grey layout for plots | 
| `load_grey_nogrid()`| same as above without grid |
| `plot_loo()` | plots LOO-diagnostics from `loo::loo()`-output | 
| `plot_posterior()` | plots PP-checks | 
| `posterior_to_latex()` | transfers output of `bayestestR::describe_posterior()` to LaTeX | 
| `create_report()` | template for html-report | 
| `create_slides()` | template for html-slides |
| `create_slides_pdf()` | creating pdf files from html-slides |
