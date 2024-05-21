\name{create_script}
\alias{create_script}
\title{Creates R sript template in working directory}
\description{
This function just creates a R script file based on the saved template as draft in the package folder.
}
\usage{
create_script(
filename = NULL,
draftname = "_extensions/myhelpers/template.R",
ext_name = "myhelpers"
)
}
\arguments{
  \item{filename}{the name of the created file. You don't have to add \code{.R}.}
  \item{draftname}{the path to the draft file. If not indicated, the package included draft file will be used.}
  \item{ext_name}{name of extension to get the files from. Default "myhelpers".}
}
\examples{
## creates the quarto file and runs the installation of some useful quarto
## extensions
# create_script("myscript")
}
