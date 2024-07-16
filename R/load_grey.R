#' Colorblind-friendly palette.
#'
#' With this function you alter the ggplot-theme to grey with x-major grid.
#'  Furthermore, font is adjusted. If you haven't installed \code{Fira Sans}
#'  change value. Textcolor can be adjusted by \code{color}
#'
#' @param font Define the font you want resp. have installed.
#' @param color Define the text color.
#'
#' @returns A grey styled ggplot-theme.
#'
#' @examples
#' # load_grey(
#' #   font = 'Fira Sans',
#' #   color = 'white'
#' # )
#'
#' @importFrom ggplot2 theme_set theme_grey theme element_text element_blank
#' @importFrom cli cli_alert_success
#' @importFrom utils install.packages
#'
#' @export

load_grey <- function(
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
        panel.grid.major.y = ggplot2::element_blank(),
        panel.grid.minor.y = ggplot2::element_blank(),
        panel.grid.minor.x = ggplot2::element_blank()
      )
  )

  cli::cli_alert_success('Theme has been set.')
}

#' @rdname load_grey
load_gray <- load_grey
