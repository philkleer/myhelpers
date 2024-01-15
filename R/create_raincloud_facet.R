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
      adjust = 5,
      width = 0.5,
      .width = c(.5, .95),
      justification = -.2
    ) +
    ggplot2::geom_boxplot(
      ggplot2::aes(
        color = {{groupvar}},
        color = ggplot2::after_scale(
          colorspace::darken(
            color,
            .1,
            space = "HLS"
            )
          ),
        fill = ggplot2::after_scale(
          colorspace::desaturate(
            colorspace::lighten(
              color,
              .8
              ),
            .4
            )
          )
        ),
      width = .12,
      outlier.shape = NA
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
    ggplot2::facet_wrap({{facetvar}})
}
