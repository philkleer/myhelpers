\name{hyptest_to_latex}
\alias{hyptest_to_latex}
\title{Transfers result of \code{hypothesis()} from \code{brms} into latex output.}
\description{
This function transfers results from function \code{hypothesis()} from \code{bayestestR} into latex output (with \code{xtable}).
}
\usage{
hyptest_to_latex(
    object,
    caption = NULL
)
}
\arguments{
  \item{object}{Object as result of \code{hypothesis()} from \code{brms}.}
  \item{caption}{Set the caption for the output.}
}
\examples{
#hyptest_to_latex(
#    object,
#    caption = NULL
#)
}
