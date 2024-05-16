create_corr_bayes <- function(
    cor, varlist, pmat = NULL, sizer = 5, fontsize = 8, sizevar = 12
){
  if(!requireNamespace("ggcorrplot")) install.packages("ggcorrplot")

  coefnames <- cor$fit@sim$fnames_oi

  coefnames <- utils::head(coefnames, -2)

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

  # filling cells with values (adjust numbers)
  for (i in 1:dim(cordf)[1]) {
    for (j in 1:dim(cor$data)[2]) {
      begin <- stringr::str_locate(cordf[[1]][i], ' & ')[1]
      end <- stringr::str_locate(cordf[[1]][i], ' & ')[2] + 1
      if (stringr::str_replace(stringr::str_sub(cordf[[1]][i], 1, begin), ' ', '') == rownames(cormat)[j]) {
        for (k in 1:dim(cor$data)[2]) {
          if (stringr::str_replace(stringr::str_sub(cordf[[1]][i], end, stringr::str_length(cordf[[1]][i])), ' ', '') == colnames(cormat)[k]) {
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
    p.mat = pmat,
    type = "upper",
    tl.cex = sizevar,
    insig = "blank",
    # outline.color = "white",
    colors = c("#543005", "white", "#003C30"),
    lab = TRUE,
    lab_size = sizer,
    lab_col = "ghostwhite",
    legend.title = expression(rho)
  ) +
    ggplot2::theme(
      text = ggplot2::element_text(
        family = "Fira Sans",
        size = fontsize
      ),
      panel.grid.major = ggplot2::element_blank(),
      legend.position = "bottom",
      legend.key.height = grid::unit(0.25, "cm"),
      legend.key.width = grid::unit(1, "cm"),
      plot.margin = grid::unit(c(0, 0, 0, 0), "cm")
    )
}
