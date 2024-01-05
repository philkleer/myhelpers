
load_grey_nogrid <- function(
    font = "Fira Sans",
    color = "white"
) {
  ggplot2::theme_set(
    ggplot2::theme_grey() +
      ggplot2::theme(
        text = ggplot2::element_text(
          color = color,
          family = font
        ),
        legend.background = ggplot2::element_blank(),
        panel.grid = ggplot2::element_blank()
      )
  )
}
