#' Plots diagnostics: posterior density and trace
#'
#' Creates diagnostic of Bayesian estimation (\code{brms} object) of
#'  posterior density and trace.
#'
#' @param modelfit Object as result of fit from \code{brms}.
#' @param nottoplot Indicate if last diagnostic parameters should not be
#'  printed by putting in an integer.
#' @param neachplot Indicate how many variables are plotted in a plot.
#' @param folder Indicate folder where to save the plot (from working
#'  directory).
#' @param model Indicate a model name to easier identify the png-file later.
#'
#' @returns Saves plots for diagnostics (density and trace).
#'
#' @examples
#' # plot_bayes_acf(
#' #   modelfit,
#' #   nottoplot = 3,
#' #   neachplot = 5,
#' #   folder = './output/',
#' #   model = 'fitm1'
#' # )
#'
#' @importFrom brms as_draws_df
#' @importFrom bayesplot mcmc_combo legend_none
#' @importFrom ggplot2 theme element_text
#' @importFrom cowplot ggsave2
#' @importFrom cli cli_progress_bar cli_progress_update cli_progress_done
#'  cli_progress_step
#' @importFrom utils install.packages
#'
#' @export

plot_bayes_combo <- function(
    modelfit,
    nottoplot = 3,
    neachplot = 5,
    folder,
    model
){
  if(!requireNamespace('brms')) install.packages('brms')
  if(!requireNamespace('cowplot')) install.packages('cowplot')
  if(!requireNamespace('bayesplot')) install.packages('bayesplot')
  if(!requireNamespace('cli')) install.packages('cli')

  stopifnot(
    '`nottoplot` must be at least 3 (`.chain`, `.iteration`, `.draw` are not plotted).' = nottoplot >= 3
  )

  cli::cli_progress_step("Creating draws ...")

  postdf <- brms::as_draws_df(
    modelfit,
    add_chain = TRUE
  )

  print(
    paste0(
      c(
        'The draws of the brms object has',
        dim(postdf)[2],
        'dimensions.',
        'Last three are .chain, .iteration, and .draw (never plot)!',
        'The following variables exist: ', colnames(postdf)
      ),
      collapse = ' '
    )
  )
  total <- dim(postdf)[2] - nottoplot

  i <- 1
  j <- 1

  cli::cli_progress_bar(
    'Creating plots',
    total = length(seq(1, total, neachplot))
  )

  for (i in seq(1, total, neachplot)) {

    cli_progress_update()

    if (i + neachplot > total) {
      howmany <- (total - i + 1)
      if (howmany < 3) {
        width.cal <- 22.4 / 5 * 3
        height.cal <- 22.4 / 5 * 3
      } else {
        width.cal <-  22.4 / 5 * howmany
        height.cal  <-  22.4 / 5 * howmany
      }
      size1 <- width.cal * 0.3571429
      size2 <- width.cal * 0.4464286
      size3 <- width.cal * 0.5803571

      plot <- bayesplot::mcmc_combo(
        postdf,
        combo = c('dens_overlay', 'trace'),
        pars = vars(i:total),
        lwd = 3,
        widths = c(2, 3),
        gg_theme = ggplot2::theme(
          strip.text.x = ggplot2::element_text(size = size2),
          legend.position = 'right',
          axis.text.x = ggplot2::element_text(
            angle = 45,
            vjust = 1,
            hjust = 1,
            size = size1
          ),
          axis.text.y = ggplot2::element_text(size = size1),
          axis.title = ggplot2::element_text(size = size3)
        ) + bayesplot::legend_none()
      )

      plot

      cowplot::ggsave2(
        paste0(
          folder,
          model,
          '-combo-',
          j,
          '.png'
        ),
        plot = plot,
        dpi = 300,
        width = width.cal,
        height = height.cal,
        units = 'cm'
      )
    } else {
      if (neachplot < 3) {
        width.cal <- 22.4 / 5 * 3
        height.cal <- 22.4 / 5 * 3
      } else {
        width.cal <-  22.4 / 5 * neachplot
        height.cal  <-  22.4 / 5 * neachplot
      }
      size1 <- width.cal * 0.3571429
      size2 <- width.cal * 0.4464286
      size3 <- width.cal * 0.5803571

      plot <- bayesplot::mcmc_combo(
        postdf,
        combo = c('dens_overlay', 'trace'),
        pars = vars(i:(i + neachplot - 1)),
        lwd = 3,
        gg_theme = ggplot2::theme(
          strip.text.x = ggplot2::element_text(size = size2),
          legend.position = 'right',
          axis.text.x = ggplot2::element_text(
            angle = 45,
            vjust = 1,
            hjust = 1,
            size = size1
          ),
          axis.text.y = ggplot2::element_text(size = size1),
          axis.title = ggplot2::element_text(size = size3)
        ) + bayesplot::legend_none()
      )

      plot

      cowplot::ggsave2(
        paste0(
          folder,
          model,
          '-combo-',
          j,
          '.png'
        ),
        plot = plot,
        dpi = 300,
        width = width.cal,
        height = height.cal,
        units = 'cm'
      )
    }
    j <- j + 1
  }

  cli::cli_progress_done()

  cli::cli_progress_step("Plots are created")
}

#' @rdname plot_bayes_combo
create_bayes_combo <- plot_bayes_combo
