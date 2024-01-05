\name{plot_posterior}
\alias{plot_posterior}
\title{Creates a plot with function \code{pp_check} from \code{bayesplot} and saves it directly.}
\description{
Creates a plot with function \code{pp_check} from \code{bayesplot} and saves it directly.
}
\usage{
plot_posterior(
    fit,
    ndraws = 150,
    type = "ecdf_overlay",
    font = "Fira Sans",
    model,
    folder = "./"
    )
}
\arguments{
  \item{fit}{\code{brms} fit to plot.}
  \item{ndraws}{Set the draws for plotting. \code{default} is 150.}
  \item{type}{Choose the type for plotting, for help check \code{??pp_check}.}
  \item{font}{Set the font for text in the plot.}
  \item{model}{Indicate the model for identification later.}
  \item{folder}{Indicate a different folder than working directory for saving.}
}
\examples{
#plot_posterior(
#    fit,
#    ndraws = 150,
#    type = "ecdf_overlay",
#    font = "Fira Sans"
#    )
}
