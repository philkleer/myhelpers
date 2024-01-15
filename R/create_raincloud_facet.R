create_raincloud_facet <- function(
  df,
  metricvar,
  groupvar,
  facetvar
  ){
  if(!requireNamespace("ggdist")) install.packages("ggdist")
  if(!requireNamespace("gghalves")) install.packages("gghalves")

  ggplot2::ggplot(
    df,
    ggplot2::aes(
      x = {{groupvar}},
      y = {{metricvar}},
      color = {{groupvar}},
      fill = {{groupvar}}
    )
  ) +
    ggdist::stat_halfeye(
      point_interval = ggdist::mean_qi,
      adjust = 5,
      width = 0.5,
      .width = c(.5, .95)
    ) +
    gghalves::geom_half_point(
      side = "l",
      range_scale = 0.25,
      size = 1.25,
      alpha = .4
    ) +
    ggplot2::theme(
      legend.position = "none"
    ) +
    ggplot2::facet_wrap(. ~ facetvar)
}
