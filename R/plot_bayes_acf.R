#' Plots diagnostics: posterior autocorrelation.
#'
#' Creates diagnostic plots of bayesian estimation (\code{brms} object) of
#'  autocorrelation. Automatically saves png-files.
#'
#' @param modelfit Object as result of fit from \code{brms}.
#' @param nottoplot Indicate if last diagnostic parameters should not be
#'  printed by putting in an integer.
#' @param neachplot Indicate how many variables are plotted in a plot.
#' @param folder Indicate folder where to save the plot (from working
#'  directory).
#' @param model Indicate a model name to easier identify the png-file later.
#'
#' @returns Saves plots for diagnostics (autocorrelation).
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
#' @importFrom bayesplot mcmc_acf
#' @importFrom ggplot2 theme element_text ggsave
#' @importFrom cli cli_progress_bar cli_progress_update cli_progress_done
#'  cli_progress_step
#' @importFrom dplyr vars
#' @importFrom utils install.packages

plot_bayes_acf <- function(
    modelfit,
    nottoplot = 3,
    neachplot = 5,
    folder,
    model
){

  if(!requireNamespace('brms')) install.packages('brms')
  if(!requireNamespace('bayesplot')) install.packages('bayesplot')
  if(!requireNamespace('cli')) install.packages('cli')

  stopifnot(
    '`nottoplot` must be at least 3 (`.chain`, `.iteration`, `.draw` are not plotted).' = nottoplot >= 3
  )

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

    cli::cli_progress_update()

    if (i + neachplot > total) {
      howmany <- (total - i + 1)
      if (howmany < 3) {
        width.cal <- 22.4 / 5 * 3
        height.cal <- 14 / 5 * 3
      } else {
        width.cal <-  22.4 / 5 * howmany
        height.cal  <-  14 / 5 * howmany
      }
      size1 <- 0.7142857 * width.cal
      size2 <- 0.3125 * width.cal
      size3 <- 1.160714 * width.cal

      plot <- bayesplot::mcmc_acf(
        postdf,
        pars = dplyr::vars(i:total),
      ) +
        ggplot2::theme(
          strip.text.x = ggplot2::element_text(size = size2),
          strip.text.y = ggplot2::element_text(size = size2),
          axis.text.x = ggplot2::element_text(
            angle = 45,
            vjust = 1,
            hjust = 1,
            size = size1
          ),
          axis.text.y = ggplot2::element_text(size = size1),
          axis.title = ggplot2::element_text(size = size3)

        )

      plot

      ggplot2::ggsave(
        paste0(
          folder,
          model,
          '-acf-',
          j,
          '.png'
        ),
        dpi = 300,
        width = width.cal,
        height = height.cal,
        units = 'cm'
      )
    } else {
      if (neachplot < 3) {
        width.cal <- 22.4 / 5 * 3
        height.cal <- 14 / 5 * 3
      } else {
        width.cal <-  22.4 / 5 * neachplot
        height.cal  <-  14 / 5 * neachplot
      }
      size1 <- 0.7142857 * width.cal
      size2 <- 0.3125 * width.cal
      size3 <- 1.160714 * width.cal

      plot <- bayesplot::mcmc_acf(
        postdf,
        pars = dplyr::vars(i:(i + neachplot - 1)),
      ) +
        ggplot2::theme(
          strip.text.x = ggplot2::element_text(size = size2),
          strip.text.y = ggplot2::element_text(size = size2),
          axis.text.x = ggplot2::element_text(
            angle = 45,
            vjust = 1,
            hjust = 1,
            size = size1
          ),
          axis.text.y = ggplot2::element_text(size = size1),
          axis.title = ggplot2::element_text(size = size3)
        )

      plot

      ggplot2::ggsave(
        paste0(
          folder,
          model,
          '-acf-',
          j,
          '.png'
        ),
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

#' @rdname plot_bayes_acf
create_bayes_acf <- plot_bayes_acf
