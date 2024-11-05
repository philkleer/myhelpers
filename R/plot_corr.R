#' Creates a standard \code{ggcorrplot}.
#'
#' This function just utilize \code{ggcorrplot} function to create a
#'  standardized correlation plot. Furthermore you can alter some of the values.
#'
#' @param df A data frame that is passed to \code{psych} \code{corr.test()}.
#' @param varlist You can restrict variables here, if you don't use all of
#'  \code{df}.
#' @param pmat Object of \code{corr.test} from \code{psych}. It is only the
#'   correlation values (\code{p}). Default is \code{cordf$p}, to work with
#'   Bayesian simple correlation matrizes.
#' @param insig Indicator if insignificant correlations should be shown.
#'   Default is \code{pch}. To not show insignificant correlations change to
#'   \code{blank}.
#' @param sizer Font size of correlation values in plot.
#' @param fontsize General font size adjustion via \code{theme()}.
#' @param sizevar Font size of variable name in plot.
#' @param colorlist List of colors for values of -1, 0, 1
#'
#' @returns Saves correlation plot.
#'
#' @examples
#' # plot_corr(
#' #   df,
#' #   varlist,
#' #   pmat,
#' #   insig = 'pch',
#' #   sizer = 5,
#' #   fontsize = 8,
#' #   sizevar = 12,
#' #   colorlist = c('#1E88E5', '#FFC107', '#D81B60')
#' # )
#'
#' @importFrom psych corr.test
#' @importFrom ggcorrplot ggcorrplot
#' @importFrom cli cli_alert_info
#' @importFrom ggplot2 theme element_text element_blank
#' @importFrom grid unit
#' @importFrom utils install.packages
#'
#' @export

plot_corr <- function(
    df, varlist = colnames(df), pmat = NULL, insig = 'pch', sizer = 5,
    fontsize = 8, sizevar = 12, colorlist = c('#1E88E5', '#FFC107', '#D81B60')
    #c('#7D231F', '#E1F2FF', '#1F537D')
){
  if(!requireNamespace('ggcorrplot')) install.packages('ggcorrplot')
  if(!requireNamespace('cli')) install.packages('cli')

  corrmat <- psych::corr.test(
    df[, varlist],
    method = 'pearson',
    use = 'complete.obs'
  )

  plot <- ggcorrplot::ggcorrplot(
    corrmat$r,
    p.mat = pmat,
    type = 'upper',
    tl.cex = sizevar,
    insig = insig,
    # outline.color = 'white',
    colors = colorlist,
    lab = TRUE,
    lab_size = sizer,
    lab_col = 'ghostwhite',
    legend.title = expression(rho)
  ) +
    ggplot2::theme(
      text = ggplot2::element_text(
        family = 'Fira Sans',
        size = fontsize
      ),
      panel.grid.major = ggplot2::element_blank(),
      legend.position = 'bottom',
      legend.key.height = grid::unit(0.25, 'cm'),
      legend.key.width = grid::unit(1, 'cm'),
      plot.margin = grid::unit(c(0, 0, 0, 0), 'cm')
    )

   cli::cli_alert_info('Plot is shown in pane `Plots`!')

   plot
}

#' @rdname plot_corr
create_corr <- plot_corr
