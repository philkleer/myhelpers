\name{create_slides_pdf}
\alias{create_slides_pdf}
\title{Creates PDF file of presentation}
\description{
This function executes the decktape command in the terminal to create the PDF file. Please be aware that decktape and puppeteer needs to be installed.

Furthermore, you need a folder `./cache/puppeteer/chrome/mac_arm-119.0.6045.105/` with the correct version of chrome to get puppeteer run (might change with updates of puppeteer). }
\usage{
create_slides_pdf(
filename = NULL,
fragments = FALSE,
author = "Dr. Philipp Kleer"
)
}
\arguments{
  \item{filename}{the name of the created file. You don't have to add \code{.html}.}
  \item{fragments}{Default is FALSE, indicates if you want to print fragments as single slides.}
  \item{author}{Add the author name for the PDF informations.}
}
\examples{
## creates the quarto file and runs the installation of some useful quarto
## extensions
# create_slides_pdf(
#   "mypresentation",
#   fragments = FALSE,
#   author = "Dr. Philipp Kleer"
# )
}
