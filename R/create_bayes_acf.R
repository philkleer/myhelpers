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
    '`nottoplot` must be at least 3 (`.chain`, `.iteration`, `.draw` are not plotted).' = nottoplot >= 3
  )

  postdf <- brms::as_draws_df(
    modelfit,
    add_chain = T
  )

  print(
    paste0(
      c(
        'The draws of the brms object has',
        dim(postdf)[2],
        'dimensions.',
        'Last three are .chain, .iteration, and .draw (never plot)!',
        'The following variables exist: ', colnames(postdf)
      ),
      collapse = " "
    )
  )

  total <- dim(postdf)[2] - nottoplot

  i <- 1
  j <- 1

  pb <- progress_bar$new(
    format = "  creating plots [:bar] :percent",
    total = length(seq(1, total, neachplot)),
    clear = FALSE,
    width = 60
  )

  pb$tick(0)

  for (i in seq(1, total, neachplot)) {

    pb$tick()

    if (i + neachplot >= total) {
      howmany <- (total - i + 1)

      plot <- bayesplot::mcmc_acf(
        postdf,
        pars = dplyr::vars(i:total),
      ) +
        ggplot2::theme(
          strip.text.x = ggplot2::element_text(size = 3.5),
          strip.text.y = ggplot2::element_text(size = 3.5),
          axis.text.x = ggplot2::element_text(
            angle = 45,
            vjust = 1,
            hjust = 1,
            size = 8
          ),
          axis.text.y = ggplot2::element_text(size = 8)
        )

      width.cal <-  11.2 / 5 * howmany
      height.cal  <-  7 / 5 * howmany

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
    } else {
      plot <- bayesplot::mcmc_acf(
        postdf,
        pars = dplyr::vars(i:(i + neachplot - 1)),
      ) +
        ggplot2::theme(
          strip.text.x = ggplot2::element_text(size = 3.5),
          strip.text.y = ggplot2::element_text(size = 3.5),
          axis.text.x = ggplot2::element_text(
            angle = 45,
            vjust = 1,
            hjust = 1,
            size = 8
          ),
          axis.text.y = ggplot2::element_text(size = 8)
        )

      width.cal <-  (11.2 / 5) * neachplot
      height.cal  <-  (7 / 5) * neachplot

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
