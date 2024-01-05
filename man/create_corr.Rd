\name{create_corr}
\alias{create_corr}
\title{Creates a standard \code{ggcorrplot}. }
\description{
This function just utilize \code{ggcorrplot} function to create a standardized correlation plot. Furthermore you can alter some of the values.
}
\usage{
create_corr(
    corrmat,
    pmat,
    sizer = 5,
    fontsize = 8,
    sizevar = 12
)
}
\arguments{
  \item{corrmat}{Object of \code{corr.test} from \code{psych}. It is only the correlation values (\code{r}). For Bayesian, works also with just a correlation matrix as input.}
  \item{pmat}{Object of \code{corr.test} from \code{psych}. It is only the correlation values (\code{p}). Default is \code{NULL}, to work with Bayesian simple correlation matrizes.}
  \item{sizer}{Font size of correlation values in plot.}
  \item{fontsize}{General font size adjustion via \code{theme()}.}
  \item{sizevar}{Font size of variable name in plot.}
}
\examples{
# create_corr(
#    corrmat,
#    pmat,
#    sizer = 5,
#    fontsize = 8,
#    sizevar = 12
#)
}
