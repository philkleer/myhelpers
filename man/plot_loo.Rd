\name{plot_loo}
\alias{plot_loo}
\title{Plots \code{loo}-object after running Bayesian models.}
\description{
This function creates a diagnostic plot for the \code{loo} calculations from a \code{brms} object.
}
\usage{
plot_loo(
  loo,
  folder,
  what
)
}
\arguments{
  \item{loo}{\code{brms} object that has been calculated leave-one-out criteria with function \code{loo()}.}
  \item{folder}{Indicating folder from working directory.}
  \item{what}{indicatin model under inspection.}
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
