#' Plots \code{loo}-object after running Bayesian models.
#'
#' This function creates a diagnostic plot for the \code{loo} calculations
#'  from a \code{brms} object.
#'
#' @param loo \code{brms} object that has been calculated leave-one-out
#'  criteria with function \code{loo()}.
#' @param folder Indicating folder from working directory. Default is \code{./}.
#' @param what Indicating model under inspection. Default is \code{regmodel}.
#'
#' @returns Saves LOO-diagnostics.
#'
#' @examples
#' # plot_loo(
#' #   loo,
#' #   folder = './',
#' #   what = 'regmodel'
#' # )
#'
#' @importFrom devtools install_github
#' @importFrom cli cli_alert_success
#' @importFrom ggplot2 ggplot aes geom_point geom_hline scale_x_continuous
#'   scale_y_continuous labs theme element_text ggsave
#' @importFrom beyonce beyonce_palette
#' @importFrom utils install.packages
#'
#' @export

plot_loo <- function(
    loo,
    folder = './',
    what = 'regmodel'
    ){
  if(!requireNamespace('devtools')) install.packages('devtools')
  if(!requireNamespace('beyonce')) devtools::install_github('dill/beyonce')
  if(!requireNamespace('cli')) install.packages('cli')

  # initializing variable for use later on in functions
  .data <- NULL

  case <- seq(1, dim(loo$pointwise)[1], 1)

  df <- as.data.frame(
    cbind(
      loo$pointwise,
      case
    )
  )

  plot <- ggplot2::ggplot(
    df,
    ggplot2::aes(
      x = .data$case,
      y = .data$influence_pareto_k
    )
  ) +
    ggplot2::geom_point(
      shape = 3,
      color = beyonce::beyonce_palette(18)[2]
    ) +
    ggplot2::geom_hline(
      yintercept = -0.5,
      lty = 'dashed',
      color = beyonce::beyonce_palette(126)[6]
    ) +
    ggplot2::geom_hline(
      yintercept = 0.5,
      lty = 'dashed',
      color = beyonce::beyonce_palette(126)[6]
    ) +
    ggplot2::geom_hline(
      yintercept = -0.7,
      lty = 'dotdash',
      color = beyonce::beyonce_palette(101)[1]
    ) +
    ggplot2::geom_hline(
      yintercept = 0.7,
      lty = 'dotdash',
      color = beyonce::beyonce_palette(101)[1]
    ) +
    ggplot2::scale_x_continuous(
      breaks = seq(0, 10000, 500)
    ) +
    ggplot2::scale_y_continuous(
      limits = c(-1, 1),
      breaks = seq(-1, 1, 0.1)
    ) +
    ggplot2::labs(
      x = 'Data point',
      y = 'Pareto shape k'
    ) + ggplot2::theme(
      axis.text.x = ggplot2::element_text(
        angle = 45,
        vjust = 1,
        hjust = 1,
        size = 8
      ),
      axis.text.y = ggplot2::element_text(size = 8),
      axis.title = ggplot2::element_text(size = 12)
    )

  ggplot2::ggsave(
    plot = plot,
    filename = paste0(
      folder,
      'loo-paretok-',
      what,
      '.png'
    ),
    dpi = 300,
    width = 11.4,
    height = 9,
    units = 'cm'
  )

  return(plot)

  cli::cli_alert_success('Plot has been exported.')

}
