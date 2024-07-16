#' Creates a standard \code{ggcorrplot} with Bayesian data.
#'
#' This function just utilize \code{ggcorrplot} function to create a
#'  standardized correlation plot. Furthermore you can alter some of the values.
#'
#' @param cor Output of brms correlation calculation.
#' @param varlist Vector of variable names. Be aware: \code{brms} sometimes
#'  change variable names, and therefore be sure that you formatted this
#'  vector correctly. Otherwise nothing will be shown in the plot.
#' @param sizer Font size of correlation values in plot.
#' @param fontsize General font size adjustion via \code{theme()}.
#' @param sizevar Font size of variable name in plot.
#'
#' @returns Creates correlation matrix and saves correlation plot.
#'
#' @examples
#' # plot_corr_bayes(
#' #   cor,
#' #   varlist,
#' #   sizer = 5,
#' #   fontsize = 8,
#' #   sizevar = 12
#' # )
#'
#' @importFrom ggcorrplot ggcorrplot
#' @importFrom cli cli_alert_info cli_progress_step
#' @importFrom ggplot2 theme element_text element_blank
#' @importFrom grid unit
#' @importFrom stringr str_locate str_replace_all str_replace str_sub str_length
#' @importFrom dplyr syms mutate pull
#' @importFrom utils head install.packages

plot_corr_bayes <- function(
    cor, varlist, sizer = 5, fontsize = 8, sizevar = 12
){
  if(!requireNamespace('ggcorrplot')) install.packages('ggcorrplot')
  if(!requireNamespace('cli')) install.packages('cli')

  # initializing variable for use later on in functions
  .variable <- NULL

  coefnames <- cor$fit@sim$fnames_oi

  coefnames <- utils::head(coefnames, -2)

  cli::cli_progress_step(
    'Gathering draws from brms object ...',
    spinner = TRUE
  )

  cordf <- cor |>
    tidybayes::gather_draws(
      !!!dplyr::syms(coefnames)
    ) |>
    dplyr::mutate(
      .variable = stringr::str_replace_all(
        .variable,
        'rescor__',
        ''
      )
    )  |>
    dplyr::mutate(
      .variable = stringr::str_replace_all(
        .variable,
        '__',
        ' & '
      )
    ) |>
    tidybayes::median_qi()

  # creating blank cormat
  cormat <- matrix(rep(0, dim(cor$data)[2]^2),
                   nrow = dim(cor$data)[2],
                   ncol = dim(cor$data)[2],
                   dimnames = list(
                     varlist,
                     varlist
                   )
  )

    # diagonal with 1
  for (i in 1:dim(cor$data)[2]) {
    cormat[i, i] <- 1
  }

  cormat

  cli::cli_progress_step(
    'Manipulation names of variables in correlation matrix ...',
    spinner = TRUE
  )

  # filling cells with values (adjust numbers)
  for (i in 1:dim(cordf)[1]) {
    for (j in 1:dim(cor$data)[2]) {
      begin <- stringr::str_locate(cordf[[1]][i], ' & ')[1]
      end <- stringr::str_locate(cordf[[1]][i], ' & ')[2] + 1
      if (
        stringr::str_replace(
          stringr::str_sub(cordf[[1]][i], 1, begin),
          ' ',
          ''
        ) == rownames(cormat)[j]
      ) {
        for (k in 1:dim(cor$data)[2]) {
          if (
            stringr::str_replace(
              stringr::str_sub(
                cordf[[1]][i],
                end,
                stringr::str_length(cordf[[1]][i])
              ),
              ' ',
              ''
            ) == colnames(cormat)[k]) {
            cormat[j, k] <- dplyr::pull(cordf[i, 2])
          }
        }
      }
    }
  }

  # filling down third
  for (i in 1:dim(cormat)[1]) {
    for (j in 1:dim(cormat)[2])
      cormat[j, i] <- cormat[i, j]
  }

  ggcorrplot::ggcorrplot(
    cormat,
    type = 'upper',
    tl.cex = sizevar,
    insig = 'blank',
    # outline.color = 'white',
    colors = c('#543005', 'white', '#003C30'),
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

  cli::cli_alert_info('Plot is exported.')

}

#' @rdname plot_corr_bayes
create_corr_bayes <- plot_corr_bayes
