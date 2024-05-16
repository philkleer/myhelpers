\name{create_corr_bayes}
\alias{create_corr_bayes}
\title{Creates a standard \code{ggcorrplot} from \code{brms} output. }
\description{
This function just utilize \code{ggcorrplot} function to create a standardized correlation plot. Furthermore you can alter some of the values.
}
\usage{
create_corr_bayes(
    cor,
    varlist,
    sizer = 5,
    fontsize = 8,
    sizevar = 12
)
}
\arguments{
  \item{cor}{Output of brms correlation calculation.}
  \item{varlist}{Vector of variable names. Be aware: \code{brms} sometimes change variable names, and therefore be sure that you formatted this vector correctly. Otherwise nothing will be shown in the plot.}
  \item{sizer}{Font size of correlation values in plot.}
  \item{fontsize}{General font size adjustion via \code{theme()}.}
  \item{sizevar}{Font size of variable name in plot.}
}
\examples{
# create_corr_bayes(
#    cor,
#    varlist,
#    sizer = 5,
#    fontsize = 8,
#    sizevar = 12
#)
}
