#' Colorblind-friendly palette.
#'
#' This function loads a colorblind palette into the environment
#'
#' @returns A Colorblind-friendly palette in character vector \code{cbp}.
#'
#' @examples
#' # load_colorblind()
#'
#' @importFrom cli cli_alert_success
#'
#' @export

load_colorblind <- function() {

  if(!requireNamespace('cli')) install.packages('cli')

  cbp <- c(
    '#009E73',
    '#E69F00',
    '#56B4E9',
    '#CC79A7',
    '#F0E442',
    '#117733',
    '#D55E00',
    '#0072B2',
    '#aa3377',
    '#AAAA00',
    '#999999'
  )

 return(cbp)

  cli::cli_alert_success('Object `cbp` is in environment.')


}
