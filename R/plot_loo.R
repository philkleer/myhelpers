plot_loo <- function(
    loo,
    folder,
    what
    ){
  if(!requireNamespace("loo")) install.packages("loo")
  if(!requireNamespace("beyonce")) devtools::install_github("dill/beyonce")

  case <- seq(1, dim(loo$pointwise)[1], 1)

  df <- as.data.frame(
    cbind(
      loo$pointwise,
      case
    )
  )

  plot <- ggplot2::ggplot(
    df,
    ggplot2::aes(
      x = .data$case,
      y = .data$influence_pareto_k
    )
  ) +
    ggplot2::geom_point(
      shape = 3,
      color = beyonce::beyonce_palette(18)[2]
    ) +
    ggplot2::geom_hline(
      yintercept = -0.5,
      lty = "dashed",
      color = beyonce::beyonce_palette(126)[6]
    ) +
    ggplot2::geom_hline(
      yintercept = 0.5,
      lty = "dashed",
      color = beyonce::beyonce_palette(126)[6]
    ) +
    ggplot2::geom_hline(
      yintercept = -0.7,
      lty = "dotdash",
      color = beyonce::beyonce_palette(101)[1]
    ) +
    ggplot2::geom_hline(
      yintercept = 0.7,
      lty = "dotdash",
      color = beyonce::beyonce_palette(101)[1]
    ) +
    ggplot2::scale_x_continuous(
      breaks = seq(0, 10000, 500)
    ) +
    ggplot2::scale_y_continuous(
      limits = c(-1, 1),
      breaks = seq(-1, 1, 0.1)
    ) +
    ggplot2::labs(
      x = "Data point",
      y = "Pareto shape k"
    ) + ggplot2::theme(
      axis.text.x = ggplot2::element_text(
        angle = 45,
        vjust = 1,
        hjust = 1,
        size = 8
      ),
      axis.text.y = ggplot2::element_text(size = 8),
      axis.title = ggplot2::element_text(size = 12)
    )

  ggplot2::ggsave(
    plot = plot,
    filename = paste0(
      folder,
      "loo-paretok-",
      what,
      ".png"
    ),
    dpi = 300,
    width = 11.4,
    height = 9,
    units = "cm"
  )

  return(plot)
}
