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
| `create_bayesreg_table()` | creates a standard regression table from `bayesPostEst::mcmcReg()` to LaTeX | 
| `create_dashboard()` | initializes the use of dashboard | 
| `create_project()` | initializes folder with basic directories and files (option kind indicate R (`r`) or Python (`py`)) |
| `create_report()` | template for html-report | 
| `create_script()` | template for script (option kind indicate R (`r`) or Python (`py`)) | 
| `create_slides()` | template for html-slides |
| `create_slides_pdf()` | creating pdf files from html-slides (you will need to adjust the file-argument in this function; you will need to install `decktape` and `puppeteer` (see `README-print.md` (once you created slides with the above function) |
| `hyptest_to_latex()` | transforms output of `brms::hypothesis()` to LaTeX | 
| `load_beyonce()` | loads my preferred styling of plots | 
| `load_beyonce_bayes()` | same as above with setup for bayesian plots | 
| `load_colorblind()` | loads a colorblind-friendly palette | 
| `load_grey()` | loads my preferred grey layout for plots | 
| `load_grey_nogrid()`| same as above without grid |
| `load_slide_colors()` | Changes ggplot style to specific style concerning slides color setting. |
| `my_pause()` | collects garbage and pause computer | 
| `plot_bayes_acf()` | plots autocorrelation diagnostics for `brms`-output automatically across all variables and saves single png-files |
| `plot_bayes_combo()` | plots density and and trace diagnostics for `brms`-output automatically across all variables and saves single png-files |
| `plot_corr()` | plots a standardized correlation plot from correlation matrix |
| `plot_corr_bayes()` | plots a standardized correlation plot from correlation matrix; transforms output directly from `brms` output |
| `plot_loo()` | plots LOO-diagnostics from `loo::loo()`-output | 
| `plot_posterior()` | plots PP-checks | 
| `plot_raincloud()` | plots a standardized raincloud for a single metric variable|
| `plot_raincloud_group()` | plots a standardized raincloud for a single metric variable on a categorical variable|
| `plot_raincloud_facet()` | plots a standardized raincloud sorted by third variable |
| `posterior_to_latex()` | transfers output of `bayestestR::describe_posterior()` to LaTeX | 
| `twoSD()` | standardization by 2 SD | 
