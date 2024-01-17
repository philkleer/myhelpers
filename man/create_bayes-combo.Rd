\name{create_bayes_combo}
\alias{create_bayes_combo}
\title{Creates diagnostic of bayesian estimation (\code{brms} object) of posterior density and trace.}
\description{
Creates diagnostic of bayesian estimation (\code{brms} object) of posterior density and trace. Automatically saves png-files.
}
\usage{
create_bayes_combo(
    postdf,
    nottoplot = 5,
    neachplot = 4,
    folder,
    model
)
}
\arguments{
  \item{postdf}{Object as result of \code{as_draws_df()} from \code{brms}.}
  \item{nottoplot}{Indicate if last diagnostic parameters should not be printed by putting in an integer.}
  \item{neachplot}{Indiate sequence in variables (plotted are \code{neachplot} + 1}
  \item{folder}{Indicate folder where to save the plot (from working directory)}
  \item{model}{Indicate a model name to easier identify the png-file later}
}
\examples{
#create_bayes_combo(
#    postdf,
#    nottoplot = 5,
#    neachplot = 4,
#    folder,
#    model,
#)
}
