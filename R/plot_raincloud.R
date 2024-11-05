#' Plots a raincloud (metric variable)
#'
#' This function creates a simple raincloud of a single metric variable. It
#'  utilizes \code{ggdist} and \code{gghalves} for additional plotting.
#'
#' @param df A Data frame.
#' @param metricvar A metric variable within that data frame.
#'
#' @returns Returns a raincloud of the metric variable.
#'
#' @examples
#' # plot_raincloud(
#' #   df,
#' #   metricvar
#' # )
#'
#' @importFrom ggplot2 ggplot aes geom_boxplot theme element_blank
#' @importFrom ggdist stat_halfeye
#' @importFrom gghalves geom_half_point
#' @importFrom cli cli_alert_info
#' @importFrom utils install.packages
#' @importFrom scales alpha
#'
#' @export

plot_raincloud <- function(
  df,
  metricvar
  ){
  if(!requireNamespace('ggdist')) install.packages('ggdist')
  if(!requireNamespace('gghalves')) install.packages('gghalves')
  if(!requireNamespace('cli')) install.packages('cli')

  plot <- ggplot2::ggplot(
    df,
    ggplot2::aes(
      y = {{metricvar}}
    )
  ) +
    ggdist::stat_halfeye(
      adjust = 5,
      width = 0.5,
      .width = c(.5, .95),
      justification = -.2
    ) +
    ggplot2::geom_boxplot(
      width = .12,
      outlier.shape = NA
    ) +
    gghalves::geom_half_point(
      side = 'l',
      range_scale = 0.25,
      size = 1.25,
      alpha = .4
    ) +
    ggplot2::theme(
      legend.position = 'none',
      axis.ticks.x = ggplot2::element_blank(),
      axis.text.x = ggplot2::element_blank(),
      axis.title.x = ggplot2::element_blank(),
      panel.grid.major.x = ggplot2::element_blank()
    )

  cli::cli_alert_info('Plot is shown in pane `Plot`.')

  plot
}

#' @rdname plot_raincloud
create_raincloud <- plot_raincloud
