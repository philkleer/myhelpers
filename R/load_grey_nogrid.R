#' Colorblind-friendly palette (no grid).
#'
#' With this function you alter the ggplot-theme to grey with no grid.
#'  Furthermore, font is adjusted. If you haven't installed \code{Fira Sans}
#'  change value. Textcolor can be adjusted by \code{color}
#'
#' @param font Define the font you want resp. have installed.
#' @param color Define the text color.
#'
#' @returns A grey styled ggplot-theme without grid.
#'
#' @examples
#' # load_grey_nogrid(
#' #   font = 'Fira Sans',
#' #   color = 'white'
#' # )
#'
#' @importFrom ggplot2 theme_set theme_grey theme element_text element_blank
#' @importFrom cli cli_alert_success
#' @importFrom utils install.packages
#'
#' @export

load_grey_nogrid <- function(
    font = 'Fira Sans',
    color = 'white'
) {
  if(!requireNamespace('cli')) install.packages('cli')

  ggplot2::theme_set(
    ggplot2::theme_grey() +
      ggplot2::theme(
        text = ggplot2::element_text(
          color = color,
          family = font
        ),
        legend.background = ggplot2::element_blank(),
        panel.grid = ggplot2::element_blank()
      )
  )

  cli::cli_alert_success('Theme has been set.')
}

#' @rdname load_grey_nogrid
load_gray_nogrid <- load_grey_nogrid
