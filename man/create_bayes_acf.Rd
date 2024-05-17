\name{create_bayes_acf}
\alias{create_bayes_acf}
\title{Creates diagnostic of bayesian estimation (\code{brms} object) of posterior density and trace.}
\description{
Creates diagnostic of bayesian estimation (\code{brms} object) of autocorrelation. Automatically saves png-files.
}
\usage{
create_bayes_acf(
    modelfit,
    nottoplot = 3,
    neachplot = 5,
    folder,
    model
)
}
\arguments{
  \item{modelfit}{Object as result of fit from \code{brms}.}
  \item{nottoplot}{Indicate if last diagnostic parameters should not be printed by putting in an integer.}
  \item{neachplot}{Indiate how many variables are plotted in a plot}
  \item{folder}{Indicate folder where to save the plot (from working directory)}
  \item{model}{Indicate a model name to easier identify the png-file later}
}
\examples{
#create_bayes_acf(
#    modelfit,
#    nottoplot = 3,
#    neachplot = 5,
#    "./output/",
#    "fitm1"
#)
}
