#' Beyonce palette
#'
#' Changes ggplot style to specific beyonce style.
#'
#' @param pal Name here the palette you want to utilize in the setting.
#' @param textcolor This variable defines textcolor and background.
#' @param ticksgrid This color defines ticks and grids.
#' @param legendtext This color defines legendtext.
#'
#' @returns Set ggplot-Theme to preferred color palette as indicated by the
#'  function.
#'
#' @examples
#' # load_beyonce(
#' #   pal = 126,
#' #   textcolor = 5,
#' #   ticksgrid = 4,
#' #   legendtext = 1
#' # )
#'
#' @importFrom devtools install_github
#' @importFrom ggplot2 theme_set theme_grey theme element_text element_line
#'  element_blank element_rect
#' @importFrom cli cli_alert_success
#' @importFrom beyonce beyonce_palette
#' @importFrom utils install.packages installed.packages
#'
#' @export

load_beyonce <- function(
    pal = 126,
    textcolor = 5,
    ticksgrid = 4,
    legendtext = 1
  ) {
  # check for packages that are needed
  if(!requireNamespace('devtools')) install.packages('devtools')
  if(!'beyonce' %in% installed.packages()){
    devtools::install_github('dill/beyonce')
  }
  if(!requireNamespace('cli')) install.packages('cli')

  # ggplot settings for bayesian analysis
  ggplot2::theme_set(
    ggplot2::theme_grey() +
      ggplot2::theme(
        text = ggplot2::element_text(
          color = 'white',
          family = 'Fira Sans'
        ),
        axis.text = ggplot2::element_text(
          color = beyonce::beyonce_palette(pal)[textcolor]
        ),
        axis.text.x = ggplot2::element_text(
          angle = 45,
          vjust = 1,
          hjust = 1
        ),
        axis.ticks = ggplot2::element_line(
          color = beyonce::beyonce_palette(pal)[ticksgrid]
        ),
        legend.background = ggplot2::element_blank(),
        legend.box.background = ggplot2::element_rect(
          fill = beyonce::beyonce_palette(pal)[textcolor],
          color = 'transparent'
        ),
        legend.key = ggplot2::element_rect(
          fill = beyonce::beyonce_palette(pal)[textcolor],
          color = 'transparent'
        ),
        legend.text = ggplot2::element_text(
          color = beyonce::beyonce_palette(pal)[legendtext]
        ),
        legend.title = ggplot2::element_text(
          color = beyonce::beyonce_palette(pal)[legendtext]
        ),
        panel.background = ggplot2::element_rect(
          fill = beyonce::beyonce_palette(pal)[textcolor],
          color = beyonce::beyonce_palette(pal)[textcolor]
        ),
        panel.grid.major.y = ggplot2::element_blank(),
        panel.grid.minor.y = ggplot2::element_blank(),
        panel.grid.minor.x = ggplot2::element_blank(),
        panel.grid.major.x = ggplot2::element_line(
          color = beyonce::beyonce_palette(pal)[ticksgrid]
        ),
        plot.background = ggplot2::element_rect(
          fill = beyonce::beyonce_palette(pal)[legendtext],
          color = beyonce::beyonce_palette(pal)[legendtext]
        ),
        strip.background = ggplot2::element_rect(
          fill = beyonce::beyonce_palette(pal)[ticksgrid]
        ),
        strip.text = ggplot2::element_text(
          color = beyonce::beyonce_palette(pal)[legendtext]
        )
      )
  )

  cli::cli_alert_success('Theme has been set.')

}
