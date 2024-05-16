\name{create_corr}
\alias{create_corr}
\title{Creates a standard \code{ggcorrplot}. }
\description{
This function just utilize \code{ggcorrplot} function to create a standardized correlation plot. Furthermore you can alter some of the values.
}
\usage{
create_corr(
    df,
    varlist,
    pmat,
    sizer = 5,
    fontsize = 8,
    sizevar = 12
)
}
\arguments{
  \item{df}{A data frame that is passed to \code{psych} \code{corr.test()}}
  \item{varlist}{You can restrict variables here, if you don't use all of \code{df}}
  \item{pmat}{Object of \code{corr.test} from \code{psych}. It is only the correlation values (\code{p}). Default is \code{cordf$p}, to work with Bayesian simple correlation matrizes.}
  \item{sizer}{Font size of correlation values in plot.}
  \item{fontsize}{General font size adjustion via \code{theme()}.}
  \item{sizevar}{Font size of variable name in plot.}
}
\examples{
# create_corr(
#    df,
#    varlist,
#    pmat,
#    sizer = 5,
#    fontsize = 8,
#    sizevar = 12
#)
}
