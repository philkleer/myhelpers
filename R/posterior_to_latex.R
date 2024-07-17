#' Transfer posterior description to LaTeX
#'
#' This function transfers results from function
#'  \code{bayestestR::describe_posterior()} into latex output
#'  (with \code{xtable}).
#'
#' @param descobject Object as result of \code{describe_posterior()} from
#'  \code{bayestestR}.
#' @param digits Set the digits that should be shown in the latex output.
#' @param minimal Shrinks output to relevant parts. Excludes ROPE definition,
#'  PS, and Rhat. Default is \code{TRUE}.
#' @param savedir savedir Define path and filename, e.g., './output/overview.tex'.
#'  Default is \code{'./posterior.tex'}.
#'
#' @returns Returns LaTeX output of the posterior description by
#'  \code{bayestestR::describe_posterior()}
#'
#' @examples
#' # posterior_to_latex(
#' #   descobject,
#' #   digits = 3,
#' #   minimal = TRUE,
#' #   savedir = './posterior.tex'
#' # )
#'
#' @importFrom xtable xtable
#' @importFrom stringr str_c
#' @importFrom dplyr select relocate
#' @importFrom utils install.packages capture.output
#' @importFrom cli cli_alert_warning
#'
#' @export

posterior_to_latex <- function(
    descobject,
    digits = 3,
    minimal = TRUE,
    savedir = './posterior.tex'
) {
  if(!requireNamespace('xtable')) install.packages('xtable')
  if(!requireNamespace('cli')) install.packages('cli')
  if(!requireNamespace('utils')) install.packages('utils')
  if(!requireNamespace('stringr')) install.packages('stringr')
  if(!requireNamespace('dplyr')) install.packages('dplyr')

  ROPE_Equivalence <- NULL
  Rhat <- NULL
  Median <- NULL
  ROPE <- NULL
  ps <- NULL

  dfobject <- as.data.frame(descobject)
  dfobject$ROPE <- NA

  if (length(unique(dfobject$CI)) > 2) {
    cli::cli_alert_warning('Function is stopped. Only two CIs possible.')
    stop()

  } else if (length(unique(dfobject$CI)) == 2) {
    newobject <- dfobject  |>
      tibble::add_column(
        var1 = NA,
        var2 = NA
      )

    names(newobject)[names(newobject) == 'var1'] <- stringr::str_c(
      'CI_', (newobject$CI[1]*100)
    )
    names(newobject)[names(newobject) == 'var2'] <- stringr::str_c(
      'CI_', (newobject$CI[2]*100)
    )
    match1 <- stringr::str_c('CI_', (newobject$CI[1]*100))
    match2 <- stringr::str_c('CI_', (newobject$CI[2]*100))
  } else if (length(unique(dfobject$CI)) == 1) {
    newobject <- dfobject  |>
      tibble::add_column(
        var1 = NA
      )

    names(newobject)[names(newobject) == 'var1'] <- stringr::str_c(
      'CI_', (newobject$CI[1]*100)
    )

    match1 <- stringr::str_c('CI_', (newobject$CI[1]*100))
  } else {
    cli::cli_alert_warning('Function is stopped. There need to be one CI.')
    stop()
  }

  # Length of data set, for countint the two new variables
  no1 <- dim(newobject)[2]

  # Sorting first interval
  for (i in seq(1, dim(newobject)[1], 2)) {
    interval <- c(
      round(newobject$CI_low[i], digits),
      round(newobject$CI_high[i], digits)
    )

    newobject[[no1-1]][i] <- paste0(
      '[',
      stringr::str_c(interval, collapse = ', '),
      ']'
    )
  }
  # Sorting second interval
  for (j in seq(2, dim(newobject)[1], 2)) {
    interval <- c(
      round(newobject$CI_low[j], digits),
      round(newobject$CI_high[j], digits)
    )

    newobject[[no1]][j-1] <- paste0(
      '[',
      stringr::str_c(interval, collapse = ', '),
      ']'
    )
  }

  # sorting rope
  for (k in seq(1, dim(dfobject)[1], 1)) {
    interval <- c(
      round(newobject$ROPE_low[k], 3),
      round(newobject$ROPE_high[k], 3)
    )

    newobject$ROPE[k] <- paste0(
      '[',
      stringr::str_c(interval, collapse = ', '),
      ']'
    )
  }

  newobject$CI <- NULL
  newobject$CI_low <- NULL
  newobject$CI_high <- NULL
  newobject$ROPE_high <- NULL
  newobject$ROPE_low <- NULL
  newobject$ROPE_CI <- NULL


  if (length(unique(dfobject$CI)) == 2) {
    newobject <- newobject  |>
      dplyr::relocate(
        tidyselect::any_of(c(match1, match2)),
        .after = Median
      )  |>
      dplyr::relocate(
        ROPE,
        .after = ps
      )

    keep <- seq(1, dim(newobject)[1], 2)

    newobject <- newobject[keep, ]
  } else {
    newobject <- newobject  |>
      dplyr::relocate(
        tidyselect::any_of(c(match1)),
        .after = Median
      )  |>
      dplyr::relocate(
        ROPE,
        .after = ps
      )

    keep <- seq(1, dim(newobject)[1], 2)

    newobject <- newobject[keep, ]
  }

  if (minimal == TRUE) {
    newobject <- newobject |>
      dplyr::select(-c(ps, ROPE, ROPE_Equivalence, Rhat))
  }

  write(
    paste(
      utils::capture.output(
        xtable::xtable(newobject)
      ),
      collapse = '\n'
    ),
    file = savedir
  )

  cli::cli_alert_success('Table is exported.')

}
