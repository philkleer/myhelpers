plot_posterior <- function(
    fit,
    ndraws = 150,
    type = "ecdf_overlay",
    font = "Fira Sans",
    model = NULL,
    folder = "./"
    ) {

  if(!requireNamespace("brms")) install.packages("brms")
  if(!requireNamespace("bayesplot")) install.packages("bayesplot")

  plot <- bayesplot::pp_check(
    type = type,
    fit,
    ndraws = ndraws
  ) +
    ggplot2::labs(caption = paste0(ndraws, " draws.")) +
    ggplot2::theme(
      text = ggplot2::element_text(
        family = font,
        size = 12
      ),
      legend.position = "bottom",
      legend.text = ggplot2::element_text(size = 17),
      axis.text.x = ggplot2::element_text(
        angle = 45,
        vjust = 1,
        hjust = 1,
        size = 17
      ),
      axis.text.y = ggplot2::element_text(size = 17),
      plot.caption = ggplot2::element_text(size = 14)
    )

  ggplot2::ggsave(
    plot,
    file = paste0(
      folder,
      model,
      "-",
      type,
      ".png"
    ),
    dpi = 300,
    width = 22.4,
    height = 16,
    units = "cm"
  )

  return(plot)
}
