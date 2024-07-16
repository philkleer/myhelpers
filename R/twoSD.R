#' Standardize variables
#'
#' Scales variables by two SD as recommended by Gelman.
#'
#' @param x Vector to scale.
#'
#' @returns Returns a scaled vector by two SD and centered.
#'
#' @examples
#' # twoSD(x)
#'
#' @importFrom stats sd

twoSD <- function(
    x
){
  (x - mean(x, na.rm = TRUE))/(2 * sd(x, na.rm = TRUE))
}
