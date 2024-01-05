hyptest_to_latex <- function(
    object,
    caption = NULL
) {
  if(!requireNamespace("xtable")) install.packages("xtable")
  if(!requireNamespace("brms")) install.packages("brms")

  # defining size of matrix by object
  rows <- length(object[[1]][[1]])
  cols <- length(object[[1]])

  mathyp <- matrix(
    nrow = rows,
    ncol = cols
  )

  # transferring values from brms-hypothesis-object to new matrix
  for (i in 1:rows) {
    for (j in 1:cols){
      mathyp[i, j] <- object[[1]][[j]][i]
    }
  }

  # setting colnames on matrix
  colnames(mathyp) <- c(
    "Hypothesis",
    "Estimate",
    "Est.Error",
    "CI.Lower",
    "CI.Upper",
    "Evid.Ratio",
    "Post.Prob",
    "Star"
  )

  # rounding numerical output
  for (k in 1:rows) {
    for (l in 2:(cols-1)) {
      mathyp[k, l] <- round(
        as.numeric(mathyp[k, l]),
        3
      )
    }
  }

  # setting rownames
  m <- seq(
    1,
    rows,
    1
  )

  hypnam <-  ""

  for (m in 1:rows) {
    hypnam[m] <- paste0("H", m)
  }

  rownames(mathyp) <- hypnam

  # getting tex-output
  xtable::xtable(
    as.table(mathyp),
    caption = caption
  )

}
