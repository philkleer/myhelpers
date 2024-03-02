create_bayes_combo <- function(
    modelfit,
    nottoplot = 5,
    neachplot = 4,
    folder,
    model
){
  if(!requireNamespace("brms")) install.packages("brms")
  if(!requireNamespace("cowplot")) install.packages("cowplot")
  if(!requireNamespace("bayesplot")) install.packages("bayesplot")

  postdf <- brms::as_draws_df(
    modelfit,
    add_chain = T
  )

  total <- dim(postdf)[2] - nottoplot

  i <- 1
  j <- 1

  for (i in seq(1, total, neachplot)) {
    if (i + neachplot >= total) {
      plot <- bayesplot::mcmc_combo(
        postdf,
        combo = c("dens_overlay", "trace"),
        pars = vars(i:total),
        lwd = 3,
        widths = c(2, 3),
        gg_theme = ggplot2::theme(
          strip.text.x = ggplot2::element_text(size = 14),
          legend.position = "right",
          axis.text.x = ggplot2::element_text(
            angle = 45,
            vjust = 1,
            hjust = 1,
            size = 12
          ),
          axis.text.y = ggplot2::element_text(size = 12)
        ) + bayesplot::legend_none()
      )

      cowplot::ggsave2(
        paste0(
          folder,
          model,
          "-combo-",
          j,
          ".png"
        ),
        plot = plot,
        dpi = 300
      )
    } else {
      plot <- bayesplot::mcmc_combo(
        postdf,
        combo = c("dens_overlay", "trace"),
        pars = vars(i:(i+neachplot)),
        lwd = 3,
        gg_theme = ggplot2::theme(
          strip.text.x = ggplot2::element_text(size = 14),
          legend.position = "right",
          axis.text.x = ggplot2::element_text(
            angle = 45,
            vjust = 1,
            hjust = 1,
            size = 12
          ),
          axis.text.y = ggplot2::element_text(size = 12)
        ) + bayesplot::legend_none()
      )

      cowplot::ggsave2(
        paste0(
          folder,
          model,
          "-combo-",
          j,
          ".png"
        ),
        plot = plot,
        dpi = 300,
        width = 22.4,
        height = 22.4,
        units = "cm"
      )
    }
    j <- j + 1
  }
}
