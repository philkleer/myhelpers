#' Transfer posterior description to LaTeX
#'
#' This function transfers results from function
#'  \code{bayestestR::describe_posterior()} into latex output
#'  (with \code{xtable}).
#'
#' @param dfobject Object as result of \code{describe_posterior()} from
#'  \code{bayestestR}.
#' @param digits Set the digits that should be shown in the latex output.
#' @param minimal Shrinks output to relevant parts. Excludes ROPE definition,
#'  PS, and Rhat. Default is \code{TRUE}.
#'
#' @returns Returns LaTeX output of the posterior description by
#'  \code{bayestestR::describe_posterior()}
#'
#' @examples
#' # posterior_to_latex(
#' #   dfobject,
#' #   digits = 3,
#' #   minimal = TRUE
#' # )
#'
#' @importFrom xtable xtable
#' @importFrom stringr str_c
#' @importFrom dplyr select relocate
#' @importFrom utils install.packages

posterior_to_latex <- function(
    dfobject,
    digits = 3,
    minimal = TRUE
) {
  if(!requireNamespace("xtable")) install.packages("xtable")

  # initializing variable for use later on in functions
  ROPE_Equivalence <- NULL
  Rhat <- NULL
  Median <- NULL
  ROPE <- NULL
  ps <- NULL

  dfobject <- as.data.frame(dfobject)
  dfobject$ROPE <- NA

  dfobject <- dfobject  |>
    tibble::add_column(
      var1 = NA,
      var2 = NA
    )

  names(dfobject)[names(dfobject) == "var1"] <- stringr::str_c(
    "CI_", (dfobject$CI[1]*100)
  )
  names(dfobject)[names(dfobject) == "var2"] <- stringr::str_c(
    "CI_", (dfobject$CI[2]*100)
  )
  match1 <- stringr::str_c("CI_", (dfobject$CI[1]*100))
  match2 <- stringr::str_c("CI_", (dfobject$CI[2]*100))

  # Length of data set, for countint the two new variables
  no1 <- dim(dfobject)[2]

  # Sorting first interval
  for (i in seq(1, dim(dfobject)[1], 2)) {
    interval <- c(
      round(dfobject$CI_low[i], digits),
      round(dfobject$CI_high[i], digits)
    )

    dfobject[[no1-1]][i] <- paste0(
      "[",
      stringr::str_c(interval, collapse = ", "),
      "]"
    )
  }
  # Sorting second interval
  for (j in seq(2, dim(dfobject)[1], 2)) {
    interval <- c(
      round(dfobject$CI_low[j], digits),
      round(dfobject$CI_high[j], digits)
    )

    dfobject[[no1]][j-1] <- paste0(
      "[",
      stringr::str_c(interval, collapse = ", "),
      "]"
    )
  }
  # sorting rope
  for (k in seq(1, dim(dfobject)[1], 1)) {
    interval <- c(
      round(dfobject$ROPE_low[k], 3),
      round(dfobject$ROPE_high[k], 3)
    )

    dfobject$ROPE[k] <- paste0(
      "[",
      stringr::str_c(interval, collapse = ", "),
      "]"
    )
  }

  dfobject$CI <- NULL
  dfobject$CI_low <- NULL
  dfobject$CI_high <- NULL
  dfobject$ROPE_high <- NULL
  dfobject$ROPE_low <- NULL
  dfobject$ROPE_CI <- NULL

  dfobject <- dfobject  |>
    dplyr::relocate(
      tidyselect::any_of(c(match1, match2)),
      .after = Median
    )  |>
    dplyr::relocate(
      ROPE,
      .after = ps
    )

  keep <- seq(1, dim(dfobject)[1], 2)

  dfobject <- dfobject[keep, ]

  if (minimal == TRUE) {
    dfobject <- dfobject |>
      dplyr::select(-c(ps, ROPE, ROPE_Equivalence, Rhat))
  }

  return(
    print(
      xtable::xtable(
        dfobject,
        digits = digits
      ),
      include.rownames = FALSE
    )
  )
}
