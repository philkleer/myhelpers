#' Creating regression table from \code{brms}
#'
#' Creates a regression table of bayesian regression output (from \code{brms})
#'  into LaTeX with \code{mcmcReg()} from \code{bayesPostEst}.
#'
#' @param modellist An \code{list}-object with model objects (from \code{brms}).
#' @param modelnames A vector indicating naming of models.
#' @param cirange Set the range of credible intervals, \code{Default} is 0.95.
#' @param savedir Define path and filename, e.g., './output/overview.tex'.
#'  Default is \code{'./regtable.tex'}.
#'
#' @returns Saves a \code{.tex}-file with the regression table.
#'
#' @examples
#' # create_bayesreg_table(
#' #   modellist,
#' #   modelnames,
#' #   cirange = .95,
#' #   savedir = './regtable.tex'
#' # )
#'
#' @importFrom BayesPostEst mcmcReg
#' @importFrom cli cli_alert_success
#' @importFrom utils install.packages
#'
#' @export
create_bayesreg_table <- function(
  modellist,
  modelnames,
  cirange = .95,
  savedir = './regtable.tex'
){
  if(!requireNamespace('BayesPostEst')) install.packages('BayesPostEst')
  if(!requireNamespace('cli')) install.packages('cli')

  print(
    BayesPostEst::mcmcReg(
      modellist,
      format = 'latex',
      hpdi = TRUE,
      ci = cirange,
      custom.model.names = modelnames,
      doctype = FALSE
    ),
    file = savedir
  )

  cli::cli_alert_success('Table is exported.')
}
