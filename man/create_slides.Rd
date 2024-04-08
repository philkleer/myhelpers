\name{create_slides}
\alias{create_slides}
\title{Creates personal quarto template for slides in working directory}
\description{
This function just creates a quarto file based on the saved template as draft in the package folder. It installs also the following useful quarto extensions:

- jmbuhr/quarto-qrcode

- martinomagnifico/quarto-simplemenu

- mcanouil/quarto-iconify

- quarto-ext/fontawesome

- schochastics/academicons

- quarto-social-embeds

To print PDF-slides, you need to install `decktape` and `puppeteer` first. Then you can use one of the following commands:

with fragments: `decktape ipsa.html?fragments=true ipsa.pdf --screen-shot=1280x720 --pdf-author 'Dr. Philipp Kleer' --pdf-title 'IPSA'`

without fragments: `decktape ipsa.html ipsa.pdf --screen-shot=1280x720 --pdf-author 'Dr. Philipp Kleer' --pdf-title 'IPSA'`

}
\usage{
create_slides(
filename = NULL,
draftname = "_extensions/myquarto/draft-slides.qmd",
ext_name = "myquarto"
)
}
\arguments{
  \item{filename}{the name of the created file. You don't have to add \code{.qmd}.}
  \item{draftname}{the path to the draft file. If not indicated, the package included draft file will be used.}
  \item{ext_name}{name of extension to get the files from. Default "myquarto".}
}
\examples{
## creates the quarto file and runs the installation of some useful quarto
## extensions
# create_slides("mypresentation")
}
