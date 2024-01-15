create_raincloud <- function(
  df,
  metricvar
  ){
  if(!requireNamespace("ggdist")) install.packages("ggdist")
  if(!requireNamespace("gghalves")) install.packages("gghalves")
  if(!requireNamespace("colorspace")) install.packages("colorspace")

  ggplot2::ggplot(
    df,
    ggplot2::aes(
      y = {{metricvar}}
    )
  ) +
    ggdist::stat_halfeye(
      adjust = 5,
      width = 0.5,
      .width = c(.5, .95),
      justification = -.2
    ) +
    ggplot2::geom_boxplot(
      width = .12,
      outlier.shape = NA
    )
    gghalves::geom_half_point(
      side = "l",
      range_scale = 0.25,
      size = 1.25,
      alpha = .4
    ) +
    ggplot2::theme(
      legend.position = "none",
      axis.ticks.x = ggplot2::element_blank(),
      axis.text.x = ggplot2::element_blank(),
      axis.title.x = ggplot2::element_blank(),
      panel.grid.major.x = ggplot2::element_blank()
    )
}
