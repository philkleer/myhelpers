\name{posterior_to_latex}
\alias{posterior_to_latex}
\title{Transfers posterior description (\code{bayestestR} object into latex output.}
\description{
This function transfers results from function \code{describe_posterior()} from \code{bayestestR} into latex output (with \code{xtable}).
}
\usage{
posterior_to_latex(
    dfobject,
    digits = 3,
    minimal = TRUE
)
}
\arguments{
  \item{dfobject}{Object as result of \code{describe_posterior()} from \code{bayestestR}.}
  \item{digits}{Set the digits that should be shown in the latex output.}
  \item{minimal}{Shrinks output to relevant parts. Excludes ROPE definition, PS, and Rhat.}
}
\examples{
#posterior_to_latex(
#    dfobject,
#    digits = 3,
#    minimal = TRUE
#)
}
