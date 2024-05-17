create_bayes_combo <- function(
    modelfit,
    nottoplot = 3,
    neachplot = 5,
    folder,
    model
){
  if(!requireNamespace('brms')) install.packages('brms')
  if(!requireNamespace('cowplot')) install.packages('cowplot')
  if(!requireNamespace('bayesplot')) install.packages('bayesplot')
  if(!requireNamespace('progress')) install.packages('progress')

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

  pb <- progress::progress_bar$new(
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
      width.cal <-  22.4 / 5 * howmany
      height.cal  <-  22.4 / 5 * howmany
      size1 <- width.cal * 0.3571429
      size2 <- width.cal * 0.4464286
      size3 <- width.cal * 0.5803571

      plot <- bayesplot::mcmc_combo(
        postdf,
        combo = c('dens_overlay', 'trace'),
        pars = vars(i:total),
        lwd = 3,
        widths = c(2, 3),
        gg_theme = ggplot2::theme(
          strip.text.x = ggplot2::element_text(size = size2),
          legend.position = 'right',
          axis.text.x = ggplot2::element_text(
            angle = 45,
            vjust = 1,
            hjust = 1,
            size = size1
          ),
          axis.text.y = ggplot2::element_text(size = size1),
          axis.title = ggplot2::element_text(size = size3)
        ) + bayesplot::legend_none()
      )

      cowplot::ggsave2(
        paste0(
          folder,
          model,
          '-combo-',
          j,
          '.png'
        ),
        plot = plot,
        dpi = 300,
        width = width.cal,
        height = height.cal,
        units = 'cm'
      )
    } else {
      width.cal <-  22.4 / 5 * neachplot
      height.cal  <-  22.4 / 5 * neachplot
      size1 <- width.cal * 0.3571429
      size2 <- width.cal * 0.4464286
      size3 <- width.cal * 0.5803571

      plot <- bayesplot::mcmc_combo(
        postdf,
        combo = c('dens_overlay', 'trace'),
        pars = vars(i:(i + neachplot - 1)),
        lwd = 3,
        gg_theme = ggplot2::theme(
          strip.text.x = ggplot2::element_text(size = size2),
          legend.position = 'right',
          axis.text.x = ggplot2::element_text(
            angle = 45,
            vjust = 1,
            hjust = 1,
            size = size1
          ),
          axis.text.y = ggplot2::element_text(size = size1),
          axis.title = ggplot2::element_text(size = size3)
        ) + bayesplot::legend_none()
      )

      cowplot::ggsave2(
        paste0(
          folder,
          model,
          '-combo-',
          j,
          '.png'
        ),
        plot = plot,
        dpi = 300,
        width = width.cal,
        height = height.cal,
        units = 'cm'
      )
    }
    j <- j + 1
  }
}
