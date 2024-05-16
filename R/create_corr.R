create_corr <- function(
    df, varlist = colnames(df), pmat = cordf$p, sizer = 5, fontsize = 8, sizevar = 12
){
  if(!requireNamespace("ggcorrplot")) install.packages("ggcorrplot")

  corrmat <- corr.test(
    df[, varlist],
    method = "pearson",
    use = "complete.obs"
  )

  ggcorrplot::ggcorrplot(
    corrmat$r,
    p.mat = corrmat$p,
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
