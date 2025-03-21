% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot_corr_bayes.R
\name{plot_corr_bayes}
\alias{plot_corr_bayes}
\alias{create_corr_bayes}
\title{Creates a standard \code{ggcorrplot} with Bayesian data.}
\usage{
plot_corr_bayes(
  cor,
  varlist = NULL,
  sizer = 5,
  fontsize = 8,
  sizevar = 12,
  colorlist = c("#1E88E5", "#FFC107", "#D81B60")
)

create_corr_bayes(
  cor,
  varlist = NULL,
  sizer = 5,
  fontsize = 8,
  sizevar = 12,
  colorlist = c("#1E88E5", "#FFC107", "#D81B60")
)
}
\arguments{
\item{cor}{Output of brms correlation calculation.}

\item{varlist}{Vector of variable names. Default is \code{NULL}, so that all
correlations are plotted.}

\item{sizer}{Font size of correlation values in plot.}

\item{fontsize}{General font size adjustion via \code{theme()}.}

\item{sizevar}{Font size of variable name in plot.}

\item{colorlist}{List of colors for values of -1, 0, 1}
}
\value{
Creates correlation matrix and saves correlation plot.
}
\description{
This function just utilize \code{ggcorrplot} function to create a
 standardized correlation plot. Furthermore you can alter some of the values.
}
\examples{
# plot_corr_bayes(
#   cor,
#   varlist,
#   sizer = 5,
#   fontsize = 8,
#   sizevar = 12,
#   colorlist = c('#1E88E5', '#FFC107', '#D81B60')
# )

}
