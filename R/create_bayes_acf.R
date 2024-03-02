create_bayes_acf <- function(
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

    if (i+neachplot >= total) {
      plot <- bayesplot::mcmc_acf(
        postdf,
        pars = dplyr::vars(i:total),
      ) +
        ggplot2::theme(
          strip.text.x = ggplot2::element_text(size = 4),
          strip.text.y = ggplot2::element_text(size = 4.5),
          axis.text.x = ggplot2::element_text(
            angle = 45,
            vjust = 1,
            hjust = 1,
            size = 8
          ),
          axis.text.y = ggplot2::element_text(size = 8)
        )

      ggplot2::ggsave(
        paste0(
          folder,
          model,
          "-acf-",
          j,
          ".png"
        ),
        dpi = 300
      )
    } else {
      plot <- bayesplot::mcmc_acf(
        postdf,
        pars = dplyr::vars(i:(i+neachplot)),
      ) +
        ggplot2::theme(
          strip.text.x = ggplot2::element_text(size = 4),
          strip.text.y = ggplot2::element_text(size = 4.5),
          axis.text.x = ggplot2::element_text(
            angle = 45,
            vjust = 1,
            hjust = 1,
            size = 8
          ),
          axis.text.y = ggplot2::element_text(size = 8)
        )

      ggplot2::ggsave(
        paste0(
          folder,
          model,
          "-acf-",
          j,
          ".png"
        ),
        dpi = 300,
        width = 11.2,
        height = 7,
        units = "cm"
      )
    }
    j <- j + 1
  }
}
