create_bayes_acf <- function(
    modelfit,
    nottoplot = 3,
    neachplot = 5,
    folder,
    model
){
  if(!requireNamespace('brms')) install.packages('brms')
  if(!requireNamespace('cowplot')) install.packages('cowplot')
  if(!requireNamespace('bayesplot')) install.packages('bayesplot')

  stopifnot(
    '`nottoplot` must be at least 3 (`.chain`, `.iteration`, `.draw` are not plotted).' = nottoplot < 3
  )

  postdf <- brms::as_draws_df(
    modelfit,
    add_chain = T
  )

  print(
    paste0(
      'The draws of the brms object has ',
      dim(postdf[2]),
      ' dimensions. ',
      'Last three are .chain, .iteration, and .draw (never plot)!',
      'The following variables exist: ', colnames(postdf)
    )
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

      width.cal <-  11.2 / 5 * (total - i + 1)
      height.cal  <-  7 / 5 * (total - i + 1)

      ggplot2::ggsave(
        paste0(
          folder,
          model,
          '-acf-',
          j,
          '.png'
        ),
        width = width.cal,
        height = width.cal,
        dpi = 300
      )
    } else {
      plot <- bayesplot::mcmc_acf(
        postdf,
        pars = dplyr::vars(i:neachplot),
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

      width.cal <-  11.2 / 5 * neachplot
      height.cal  <-  7 / 5 * neachplot

      ggplot2::ggsave(
        paste0(
          folder,
          model,
          '-acf-',
          j,
          '.png'
        ),
        dpi = 300,
        width = width.cal,
        height = height.cal,
        units = 'cm'
      )
    }
    j <- j + 1
  }
}
