posterior_to_latex <- function(
    dfobject,
    digits = 3
) {
  if(!requireNamespace("xtable")) install.packages("xtable")
  if(!requireNamespace("bayestestR")) install.packages("bayestestR")
  if(!requireNamespace("brms")) install.packages("brms")

  dfobject <- as.data.frame(dfobject)
  dfobject$ROPE <- NA

  dfobject <- dfobject  |>
    tibble::add_column(
      var1 = NA,
      var2 = NA
    )

  names(dfobject)[names(dfobject) == "var1"] <- stringr::str_c("CI_", (dfobject$CI[1]*100))
  names(dfobject)[names(dfobject) == "var2"] <- stringr::str_c("CI_", (dfobject$CI[2]*100))
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
