#' Plots posterior distribution
#'
#' Creates a plot with function \code{pp_check} from \code{bayesplot} and
#'  saves it directly.
#'
#' @param fit A \code{brms} fit to plot.
#' @param ndraws Set the draws for plotting. \code{default} is 150.
#' @param type Choose the type for plotting, for help check \code{??pp_check}.
#'  Example \code{bars} or \code{dens_overlay}.
#' @param font Set the font for text in the plot.
#' @param model Indicate the model for identification later. Default is
#'  \code{NULL}.
#' @param folder Indicate a different folder than working directory for saving.
#'
#' @returns Saves plots for diagnostics (autocorrelation).
#'
#' @examples
#' # plot_posterior(
#' #   fit,
#' #   ndraws = 150,
#' #   type = 'ecdf_overlay',
#' #   font = 'Fira Sans',
#' #   model = NULL,
#' #   folder = './'
#' # )
#'
#' @importFrom bayesplot pp_check
#' @importFrom ggplot2 labs theme element_text ggsave
#' @importFrom cli cli_alert_success
#' @importFrom utils install.packages

plot_posterior <- function(
    fit,
    ndraws = 150,
    type = 'ecdf_overlay',
    font = 'Fira Sans',
    model = NULL,
    folder = './'
    ) {

  if(!requireNamespace('bayesplot')) install.packages('bayesplot')
  if(!requireNamespace('cli')) install.packages('cli')

  plot <- bayesplot::pp_check(
    type = type,
    fit,
    ndraws = ndraws
  ) +
    ggplot2::labs(caption = paste0(ndraws, ' draws.')) +
    ggplot2::theme(
      text = ggplot2::element_text(
        family = font,
        size = 12
      ),
      legend.position = 'bottom',
      legend.text = ggplot2::element_text(size = 17),
      axis.text.x = ggplot2::element_text(
        angle = 45,
        vjust = 1,
        hjust = 1,
        size = 17
      ),
      axis.text.y = ggplot2::element_text(size = 17),
      plot.caption = ggplot2::element_text(size = 14)
    )

  ggplot2::ggsave(
    plot,
    file = paste0(
      folder,
      model,
      '-',
      type,
      '.png'
    ),
    dpi = 300,
    width = 22.4,
    height = 16,
    units = 'cm'
  )

  return(plot)

  cli::cli_alert_success('Plot has been exported.')

}
