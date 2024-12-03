#' Adjusted theme for slides
#'
#' Changes ggplot style to specific style concerning slides color setting.
#'
#' @returns Set ggplot-Theme to preferred color palette as indicated by the
#'  function.
#'
#' @examples
#' # load_slide_colors()
#'
#' @importFrom ggplot2 theme_set theme_grey theme element_text element_line
#'  element_blank element_rect
#' @importFrom cli cli_alert_success
#' @importFrom utils install.packages installed.packages
#'
#' @export

load_slide_colors <- function() {
  # check for packages that are needed
  if(!requireNamespace('cli')) install.packages('cli')

  # ggplot settings for bayesian analysis
  ggplot2::theme_set(
    ggplot2::theme_grey() +
      ggplot2::theme(
        text = ggplot2::element_text(
          color = '#F7F7F7',
          family = 'Fira Sans',
          size = 18
        ),
        axis.text = ggplot2::element_text(color = '#ebebeb'),
        axis.text.x = ggplot2::element_text(
          angle = 45,
          vjust = 1,
          hjust = 1
        ),
        axis.ticks = ggplot2::element_line(color = '#ebebeb'),
        panel.background = ggplot2::element_rect(
          fill = '#C4C4C4',
          color = '#C4C4C4'
        ),
        panel.grid.major.y = ggplot2::element_blank(),
        panel.grid.minor.y = ggplot2::element_blank(),
        panel.grid.minor.x = ggplot2::element_blank(),
        panel.grid.major.x = ggplot2::element_line(color = '#F7F7F7'),
        plot.background = ggplot2::element_rect(
          fill = '#40746A',
          color = '#40746A'
        ),
        strip.background = ggplot2::element_rect(
          fill = '#F4F4F4'
        ),
        strip.text = ggplot2::element_text(
          color = '#579D90',
          size = 16
        ),
        legend.position = 'bottom',
        legend.title = ggplot2::element_text(color = '#40746A'),
        legend.text = ggplot2::element_text(color = '#40746A'),
        legend.background = ggplot2::element_blank(),
        legend.box.background = ggplot2::element_rect(
          fill = '#F7F7F7',
          color = 'transparent'
        )
      )
  )

  cli::cli_alert_success('Theme has been set.')

}
