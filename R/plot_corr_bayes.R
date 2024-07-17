#' Creates a standard \code{ggcorrplot} with Bayesian data.
#'
#' This function just utilize \code{ggcorrplot} function to create a
#'  standardized correlation plot. Furthermore you can alter some of the values.
#'
#' @param cor Output of brms correlation calculation.
#' @param varlist Vector of variable names. Default is \code{NULL}, so that all
#'   correlations are plotted.
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
#' @importFrom cli cli_alert_success cli_progress_step
#' @importFrom ggplot2 theme element_text element_blank
#' @importFrom grid unit
#' @importFrom stringr str_replace_all str_split_i
#' @importFrom dplyr syms mutate pull
#' @importFrom utils head install.packages
#'
#' @export

plot_corr_bayes <- function(
    cor, varlist = NULL, sizer = 5, fontsize = 8, sizevar = 12
){
  if(!requireNamespace('ggcorrplot')) install.packages('ggcorrplot')
  if(!requireNamespace('cli')) install.packages('cli')

  # initializing variable for use later on in functions
  .variable <- NULL
  var1 <- var2 <- NULL

  coefnames <- cor$fit@sim$fnames_oi

  coefnames <- utils::head(coefnames, -2)

  cli::cli_progress_step(
    'Manipulation names of variables in data ...',
    spinner = TRUE
  )

  cordf <- cor |>
    # gathering draws from brms object
    tidybayes::gather_draws(
      !!!dplyr::syms(coefnames)
    ) |>
    # manipulation strings
    dplyr::mutate(
      .variable = stringr::str_replace_all(
        .variable,
        'rescor__',
        ''
      )
    ) |>
    # creating overview table and split .variable to two strings
    tidybayes::median_qi() |>
    dplyr::mutate(
      var1 = stringr::str_split_i(string = .variable, pattern = '__', i = 1),
      var2 = stringr::str_split_i(string = .variable, pattern = '__', i = 2)
    ) |>
    # relocate new variables to the front for convenience
    dplyr::relocate(var1, var2, .after = .variable)

  # no specified varlist -> print all correlations
  if (is.null(varlist)) {
    varlist <- c(cordf$var1, cordf$var2)

    varlist <- unique(varlist)

    cli::cli_alert_success('`varlist` created. All combinations will be plotted.')
  }

  # setting cormat with NA's
  cormat <- matrix(
    rep(NA, length(varlist)^2),
    nrow = length(varlist),
    ncol = length(varlist),
    dimnames = list(
      varlist,
      varlist
    )
  )

  # diagonal with 1
  for (i in 1:length(varlist)) {
    cormat[i, i] <- 1
  }

  # loop to go through pairs of correlations
  for (i in 1:dim(cordf)[1]) {
    for (j in 1:dim(cormat)[1]) {
      if (cordf$var1[i] == rownames(cormat)[j]) {
        for (k in 1:dim(cormat)[2]) {
          if (cordf$var2[i] == colnames(cormat)[k]) {
            cormat[j, k] <- dplyr::pull(cordf[i, 4])
          }
        }
      }
    }
  }

  # loop to set corresponding fields
  for (i in 1:dim(cormat)[1]) {
    for (j in 1:dim(cormat)[2])
      if (is.na(cormat[j, i])) {
        cormat[j, i] <- cormat[i, j]
      }
  }

  plot <- ggcorrplot::ggcorrplot(
    cormat,
    type = 'upper',
    tl.cex = sizevar,
    insig = 'blank',
    # outline.color = 'white',
    colors = c('#543005', 'gray88', '#003C30'),
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

  plot
}

#' @rdname plot_corr_bayes
create_corr_bayes <- plot_corr_bayes
