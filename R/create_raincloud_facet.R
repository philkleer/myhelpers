create_raincloud_facet <- function(
  df,
  groupvar,
  metricvar,
  facetvar
  ){
  if(!requireNamespace("ggdist")) install.packages("ggdist")
  if(!requireNamespace("gghalves")) install.packages("gghalves")
  if(!requireNamespace("beyonce")) devtools::install_github("dill/beyonce")

  ggplot2::ggplot(
    df,
    ggplot2::aes(
      x = groupvar,
      y = metricvar,
      color = groupvar,
      fill = groupvar
    )
  ) +
    ggdist::stat_halfeye(
      point_interval = ggdist::mean_qi,
      adjust = 1.25,
      width = 0.5,
      .width = c(.5, .95)
    ) +
    gghalves::geom_half_point(
      side = "l",
      range_scale = 0.25,
      size = 1.25,
      alpha = .4
    ) +
    ggplot2::scale_color_manual(
      values = c(
        beyonce::beyonce_palette(39)[1],
        beyonce::beyonce_palette(32)[1]
      )
    ) +
    ggplot2::scale_fill_manual(
      values =
        scales::alpha(
          c(
            beyonce::beyonce_palette(39)[1],
            beyonce::beyonce_palette(32)[1]
          ),
          0.5
        )
    ) +
    ggplot2::theme(
      legend.position = "none"
    ) +
    ggplot2::facet_wrap(. ~ facetvar)
}
