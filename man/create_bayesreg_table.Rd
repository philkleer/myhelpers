\name{create_bayesreg_table}
\alias{create_bayesreg_table}
\title{Creates a regression table of bayesian regression output (from \code{brms}) into LaTeX with \code{mcmcReg()} from \code{bayesPostEst}.}
\description{
Creates a regression table of bayesian regression output (from \code{brms}) into LaTeX with \code{mcmcReg()} from \code{bayesPostEst}.
}
\usage{
create_bayesreg_table(
  modellist,
  modelnames,
  cirange = .95,
  savedir
)
}
\arguments{
  \item{modellist}{An \code{list}-object with model objects (from \code{brms}).}
  \item{modelnames}{A vector indicating naming of models.}
  \item{cirange}{Set the range of credible intervals, \code{Default} is 0.95.}
  \item{savedir}{Define path and filename, e.g., "./output/overview.tex".}
}
\examples{
#create_bayesreg_table(
#  modellist,
#  modelnames,
#  cirange = .95,
#  savedir
#)
}
