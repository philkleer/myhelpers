#' Transfer hypothesis' results to TeX
#'
#' Transfers result of \code{brms::hypothesis()} into LaTeX output.
#'
#' @param object Object as result of \code{hypothesis()} from \code{brms}.
#' @param caption Set the caption for the output. Default is \code{NULL}.
#' @param savedir Define path and filename, e.g., './output/overview.tex'.
#'  Default is \code{'./hypothesis.tex'}.
#'
#' @returns Prints result of \code{brms::hypothesis()} to LaTeX in console.
#'
#' @examples
#' # hyptest_to_latex(
#' #   object,
#' #   savedir = './hypothesis.tex'
#' #   caption = NULL
#' # )
#'
#' @importFrom xtable xtable
#' @importFrom utils install.packages capture.output
#' @importFrom cli cli_alert_success
#'
#' @export

hyptest_to_latex <- function(
    object,
    savedir = './hypothesis.tex',
    caption = NULL
) {
  if(!requireNamespace('xtable')) install.packages('xtable')
  if(!requireNamespace('cli')) install.packages('cli')
  if(!requireNamespace('utils')) install.packages('utils')


  # defining size of matrix by object
  rows <- length(object[[1]][[1]])
  cols <- length(object[[1]])

  mathyp <- matrix(
    nrow = rows,
    ncol = cols
  )

  # transferring values from brms-hypothesis-object to new matrix
  for (i in 1:rows) {
    for (j in 1:cols){
      mathyp[i, j] <- object[[1]][[j]][i]
    }
  }

  # setting colnames on matrix
  colnames(mathyp) <- c(
    'Hypothesis',
    'Estimate',
    'Est.Error',
    'CI.Lower',
    'CI.Upper',
    'Evid.Ratio',
    'Post.Prob',
    'Star'
  )

  # rounding numerical output
  for (k in 1:rows) {
    for (l in 2:(cols-1)) {
      mathyp[k, l] <- round(
        as.numeric(mathyp[k, l]),
        3
      )
    }
  }

  # setting rownames
  m <- seq(
    1,
    rows,
    1
  )

  hypnam <-  ''

  for (m in 1:rows) {
    hypnam[m] <- paste0('H', m)
  }

  rownames(mathyp) <- hypnam

  write(
    paste(
      utils::capture.output(
        xtable::xtable(
          as.table(mathyp),
          caption = caption
        )
      ),
      collapse = '\n'
    ),
    file = savedir
  )

  cli::cli_alert_success('Table is exported.')

}
