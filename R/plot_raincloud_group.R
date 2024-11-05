#' Plots a raincloud (metric variable)
#'
#' This function creates a simple raincloud of a single metric variable. It
#'  utilizes \code{ggdist} and \code{gghalves}
#'  for additional plotting.
#'
#' @param df A Data frame.
#' @param metricvar A metric variable within that data frame.
#' @param groupvar A categorical variable within that data frame.
#'
#' @returns Returns a raincloud of the metric variable dependend on the group
#'  variable.
#'
#' @examples
#' # plot_raincloud_group(
#' #   df,
#' #   metricvar,
#' #   groupvar
#' # )
#'
#' @importFrom ggplot2 ggplot aes geom_boxplot theme element_blank after_scale
#' @importFrom colorspace darken desaturate lighten
#' @importFrom ggdist stat_halfeye
#' @importFrom gghalves geom_half_point
#' @importFrom cli cli_alert_info
#' @importFrom utils install.packages
#' @importFrom scales alpha
#'
#' @export

plot_raincloud_group <- function(
  df,
  metricvar,
  groupvar
  ){
  if(!requireNamespace('ggdist')) install.packages('ggdist')
  if(!requireNamespace('gghalves')) install.packages('gghalves')
  if(!requireNamespace('colorspace')) install.packages('colorspace')
  if(!requireNamespace('cli')) install.packages('cli')


  # initializing var objects for function below
  color <- NULL

  plot <- ggplot2::ggplot(
    df,
    ggplot2::aes(
      x = {{groupvar}},
      y = {{metricvar}},
      color = {{groupvar}},
      fill = {{groupvar}}
    )
  ) +
    ggdist::stat_halfeye(
      adjust = 5,
      width = 0.5,
      .width = c(.5, .95),
      justification = -.2
    ) +
    ggplot2::geom_boxplot(
      ggplot2::aes(color = {{groupvar}},
          color = ggplot2::after_scale(
            colorspace::darken(
              color,
              .1,
              space = 'HLS'
              )
            ),
          fill = ggplot2::after_scale(
            colorspace::desaturate(
              colorspace::lighten(
                color,
                .8
                ),
              .4
              )
            )
          ),
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
      legend.position = 'none'
    )

  cli::cli_alert_info('Plot is shown in pane `Plot`.')

  plot
}

#' @rdname plot_raincloud_group
create_raincloud_group <- plot_raincloud_group
